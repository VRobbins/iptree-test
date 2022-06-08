#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <errno.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <getopt.h>
#include <time.h>
#include <algorithm>
#include "msc_tree.h"

#define MAX_READLINE_SIZE 1024
#ifndef STATUS_OK
#define STATUS_OK 0
#endif
#ifndef STATUS_ERROR
#define STATUS_ERROR -1
#endif
//: ----------------------------------------------------------------------------
//:
//: ----------------------------------------------------------------------------
//: ----------------------------------------------------------------------------
//:
//: ----------------------------------------------------------------------------
//: ----------------------------------------------------------------------------
//: \details:  TODO
//: \return:   TODO
//: \param:    TODO
//: ----------------------------------------------------------------------------
void print_usage(FILE* a_stream, int a_exit_code)
{
        fprintf(a_stream, "Usage: ip_tree [OPTIONS]\n");
        fprintf(a_stream, "msc ip Tree Test.\n");
        fprintf(a_stream, "\n");
        fprintf(a_stream, "OPTIONS:\n");
        fprintf(a_stream, "  -h, --help       Display this help and exit.\n");
        fprintf(a_stream, "  -f, --file       Input file containinf ip's to load.\n");
        fprintf(a_stream, "  -s, --search     Input file\n");
        fprintf(a_stream, "  -t, --type       type of ip's in the file :ipv4 or ipv6");
        exit(a_exit_code);
}
//: ----------------------------------------------------------------------------
//:
//: ----------------------------------------------------------------------------
int main(int argc, char** argv)
{
         char *l_err_msg;
         TreeRoot *l_tree;
         int32_t l_s = STATUS_OK;
         l_s = create_radix_tree(&l_tree, &l_err_msg);
        // -----------------------------------------
        // process args
        // -----------------------------------------
         char l_opt;
         std::string l_arg;
         std::string l_file_load_str;
         std::string l_file_search_str;
         int l_option_index = 0;
         std::string l_type;
         uint32_t l_size = 0;

         struct option l_long_options[] = 
                {
                {"help",        0, 0, 'h'},
                {"file",        1, 0, 'f'},
                {"search",      1, 0, 's'},
                {"type",        1, 0,  't'},
                {0, 0, 0, 0}
                };

        while ((l_opt = getopt_long_only(argc, argv, "hf:s:t:", l_long_options, &l_option_index)) != -1)
        {
                if (optarg)
                {
                    l_arg = optarg;
                }

                switch(l_opt)
                {
                // -----------------------------------------
                // help
                // -----------------------------------------
                case 'h':
                {
                        print_usage(stdout, 0);
                        break;
                }
                // -----------------------------------------
                //  file containing ip's to load
                // -----------------------------------------
                case 'f':
                {
                        l_file_load_str = l_arg;
                        break;
                }
                // -----------------------------------------
                //  file containing ip's to search
                // -----------------------------------------
                case 's':
                {
                        l_file_search_str = l_arg;
                        break;
                }
                case 't':
                {
                        l_type = l_arg;
                        break;
                }
                default:
                {
                        fprintf(stdout, "unrecognized option");
                        print_usage(stdout, -1);
                        break;

                }
                }
        }

        if(l_file_load_str.empty())
        {
                printf("please provide input file with ip's to load");
                print_usage(stdout, -1);
        }
        // -----------------------------------------
        //  load ip's
        // ----------------------------------------- 
        FILE * l_fp;
        l_fp = fopen(l_file_load_str.c_str(),"r");
        if (NULL == l_fp)
        {
               printf("Error opening file: %s.  Reason: %s\n", l_file_load_str.c_str(), strerror(errno));
               return STATUS_ERROR;
        }
        char l_readline[MAX_READLINE_SIZE];
        if (l_type == "ipv4")
        { 

                while(fgets(l_readline, sizeof(l_readline), l_fp))
                {
                        size_t l_readline_len = strnlen(l_readline, MAX_READLINE_SIZE);
                        if(MAX_READLINE_SIZE == l_readline_len)
                        {
                                printf("Error: lines must be shorter then %d chars\n", MAX_READLINE_SIZE);
                                return STATUS_ERROR;
                        }
                        l_readline[l_readline_len - 1] = '\0';
                        TreeAddIP(l_readline, l_tree->ipv4_tree, IPV4_TREE);
                }
        }
        else
        {
                while(fgets(l_readline, sizeof(l_readline), l_fp))
                {
                        size_t l_readline_len = strnlen(l_readline, MAX_READLINE_SIZE);
                        if(MAX_READLINE_SIZE == l_readline_len)
                        {
                                printf("Error: lines must be shorter then %d chars\n", MAX_READLINE_SIZE);
                                return STATUS_ERROR;
                        }
                        l_readline[l_readline_len - 1] = '\0';
                        TreeAddIP(l_readline, l_tree->ipv6_tree, IPV6_TREE);
                }
                
        }
        printf("Loading done\n");
        // -----------------------------------------
        //  Search ip's
        // -----------------------------------------
        if(l_file_search_str.empty())
        {
                return 0;
        }
        l_fp = fopen(l_file_search_str.c_str(),"r");
        if (NULL == l_fp)
        {
               printf("Error opening file: %s.  Reason: %s\n", l_file_search_str.c_str(), strerror(errno));
               return STATUS_ERROR;
        }
        
        printf("Searching  ips\n");
        double l_total_time;
        clock_t l_start, l_end;
        char l_rline[MAX_READLINE_SIZE];
        l_start = clock();
        while(fgets(l_rline, sizeof(l_rline), l_fp))
        {
                size_t l_rline_len = strnlen(l_rline, MAX_READLINE_SIZE);
                if(!l_rline_len)
                {
                        continue;
                }
                else if(l_rline_len == MAX_READLINE_SIZE)
                {
                        if(l_tree) { delete l_tree; l_tree = NULL;}
                        return STATUS_ERROR;
                }
                // nuke endline
                l_rline[l_rline_len - 1] = '\0';
                std::string l_line(l_rline);
                l_line.erase( std::remove_if( l_line.begin(), l_line.end(), ::isspace ), l_line.end() );
                if(l_line.empty())
                {
                        continue;
                }
                l_s = tree_contains_ip(l_tree, l_line.c_str(), &l_err_msg);
        }
        l_end = clock();
        l_total_time = ((double)(l_end-l_start)) / CLOCKS_PER_SEC;
        printf("time taken to search:%f\n", l_total_time);

        if(l_tree)
        {
                delete l_tree;
                l_tree = NULL;
        }
        return 0;
}
