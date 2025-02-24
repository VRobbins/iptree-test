//: ----------------------------------------------------------------------------
//: Copyright (C) 2017 Verizon.  All Rights Reserved.
//: All Rights Reserved
//:
//: \file:    nms.h
//: \details: TODO
//: \author:  Reed P Morrison
//: \date:    08/09/2018
//:
//:   Licensed under the Apache License, Version 2.0 (the "License");
//:   you may not use this file except in compliance with the License.
//:   You may obtain a copy of the License at
//:
//:       http://www.apache.org/licenses/LICENSE-2.0
//:
//:   Unless required by applicable law or agreed to in writing, software
//:   distributed under the License is distributed on an "AS IS" BASIS,
//:   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//:   See the License for the specific language governing permissions and
//:   limitations under the License.
//:
//: ----------------------------------------------------------------------------
#ifndef _NMS_H_
//: ----------------------------------------------------------------------------
//: includes
//: ----------------------------------------------------------------------------
#include <iostream>
#include <set>
#include <utility>
#include <unordered_set>
#include <list>
#include <netinet/in.h>
#include <string.h>
#include <string>
namespace ns_waflz
{
//: ----------------------------------------------------------------------------
//: netmask set
//: ----------------------------------------------------------------------------
class nms
{
public:
        // -------------------------------------------------
        // public enums
        // -------------------------------------------------
        typedef enum {
                ADDR_IPV4 = 0,
                ADDR_IPV6,
                ADDR_NONE
        } addr_t;
        // -------------------------------------------------
        // public methods
        // -------------------------------------------------
        nms();
        ~nms();
        int32_t add(const char *a_buf, uint32_t a_buf_len);
        int32_t contains(bool &ao_match, const char *a_buf, uint32_t a_buf_len);
private:
        // -------------------------------------------------
        // private types
        // -------------------------------------------------
        struct cmp_in6_addr
        {
                bool operator()(const in6_addr& a,
                                const in6_addr& b) const
                {
                        return (0 > memcmp(&a.s6_addr,
                                           &b.s6_addr,
                                           sizeof(a.s6_addr)));
                }
        };
        struct Hash {
                size_t operator() (const std::pair<char, uint32_t> pair) const {
                        return pair.second;
                }
        };
        struct KeyEq {
                bool operator() (const std::pair<char, uint32_t> pair1, const std::pair<char, uint32_t> pair2) const {
                        return pair1.first == pair2.first && pair1.second==pair2.second;
                }
        };
        typedef std::unordered_set<std::pair<char,uint32_t>, Hash, KeyEq> ipv4_set_t;
        typedef std::set<in6_addr, cmp_in6_addr> ipv6_set_t;
        // -------------------------------------------------
        // nested data structure:
        // outer map indexed by subnet mask bits, and inner
        // maps indexed by ipv4/ipv6 addresses.
        // To determine whether an ip address is contained
        // iterate over all known netmasks, starting from
        // largest (i.e., 32 for ipv4 or 128 for ipv6)
        // looking for the ip address.
        // -------------------------------------------------
        // -------------------------------------------------
        // private methods
        // -------------------------------------------------
        addr_t detect_addr(const char *a_buf, uint32_t a_buf_len);
        int32_t add_ipv4(const char *a_buf, uint32_t a_buf_len);
        int32_t add_ipv4_plain(const char *a_buf, uint32_t a_buf_len);
        int32_t add_ipv4_cidr(const char *a_buf, uint32_t a_buf_len);
        int32_t add_ipv6(const char *a_buf, uint32_t a_buf_len);
        int32_t add_ipv6_plain(const char *a_buf, uint32_t a_buf_len);
        int32_t add_ipv6_cidr(const char *a_buf, uint32_t a_buf_len);
        int32_t contains_ipv4(bool &ao_match, const char *a_buf, uint32_t a_buf_len);
        int32_t contains_ipv6(bool &ao_match, const char *a_buf, uint32_t a_buf_len);
        // -------------------------------------------------
        // private members
        // -------------------------------------------------
        ipv4_set_t ipv4_arr;
        ipv6_set_t* ipv6_arr;
};
//: ----------------------------------------------------------------------------
//: types
//: ----------------------------------------------------------------------------
typedef std::list <const std::string *> ip_str_list_t;
//: ----------------------------------------------------------------------------
//: ****************************************************************************
//:                            U T I L I T I E S
//: ****************************************************************************
//: ----------------------------------------------------------------------------
int32_t create_nms_from_str(nms **ao_nms, const std::string &a_str);
int32_t create_nms_from_file(nms **ao_nms, const std::string &a_file);
int32_t create_nms_from_ip_str_list(nms **ao_nms, const ip_str_list_t &a_ip_str_list);
}
#endif
