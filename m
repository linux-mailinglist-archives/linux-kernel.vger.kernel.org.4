Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2619C6176BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKCGbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKCGbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:31:16 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F4F15A15
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 23:31:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k2so2690445ejr.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 23:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rAMAks+U8btrXEhBzyT1Fy+l3GaOO4zT4tbaFSyikrs=;
        b=hiFusdce8A2404FDzYBv6XOGQ+tWz6ZcImCrrzNATYZuxximWqEcrfAM7+QzbPOxRX
         UHFgl00PKuU2W1ONglO5VheLoDa+uqJYVKkBU2nPcxMvtoUqeJBzv8819qUwV0Hgq0UX
         qhuTLZEbgo5iMO/WcxxklzBheCkjU+HI9zl4OvyHF9PAmW30n/TSRW02LBDECpPBw1Wc
         dCrpXhOgWoly2OPZnnXT9yGcsD9O0ZAWLV2R9ITRuzHzJNbsfujVTEuITMFfz70H8Iiy
         jAi7Lp+TBBsOzUtih6Rz0d7ObMW2cDywch2sbfneRfy1mJzxT5Rf5uf1PmpchQ+s0v2q
         QADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rAMAks+U8btrXEhBzyT1Fy+l3GaOO4zT4tbaFSyikrs=;
        b=obf2MT41m4d5w8I+9hGS453SF3hEeFv1nh2PNgY3c4uJIVnKg784afqI5WsNCD7rxZ
         zSCSceAInYaxsRTMaNyjAZkGvbfOmhXGYwlcu1oxAJ6jOufeHJLSQ0TgT5EXuM02Oj1+
         mnYvijy15bSx05f2xxMsBbSD5R06fLGdh/3FhfPXT24kykvsLZ9LPGNWrLcrms30Vs3r
         sRonihZOBewaPdNHSm2m/CRmlN9Nn3HrtlpnyGtRRzuqQ2zUixdjKFlyNoB91rARaHiS
         r2wwXzTA68aT6yEh8IBBZNq3h05WOdOXFrTxMpwBVNdkMH7mmiE/in4wtPMK4NejdmaJ
         kSXg==
X-Gm-Message-State: ACrzQf1y+LdRVJFUj3x+tUAuZegZAwXviuA8Vh/+3v6KIOPES3ZP8RXR
        zfQfcGO32R8nBTQ4PaYz+fZl47h8ke67+T7TeYFRVc/B2NQ=
X-Google-Smtp-Source: AMsMyM6pIPt+pUW86kSvSCrFrBaDf1Iegc+cqVWqakg8fuKQhFiVzQlCTWL5p5m6GQtslpA5gp+i9Pu16oaArVUIY3I=
X-Received: by 2002:a17:907:60c8:b0:78d:bc8d:8457 with SMTP id
 hv8-20020a17090760c800b0078dbc8d8457mr26381034ejc.418.1667457072602; Wed, 02
 Nov 2022 23:31:12 -0700 (PDT)
MIME-Version: 1.0
From:   Amit <amitchoudhary0523@gmail.com>
Date:   Thu, 3 Nov 2022 12:01:02 +0530
Message-ID: <CAFf+5ziLvr-bvRU_bpKdzmR_RabfrpvvXFhSwSa77EwuDqLr+w@mail.gmail.com>
Subject: String functions in C language that are not present in standard C
 library - version 1.1.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

String functions in C language that are not present in standard C
library - version 1.1.

Functions implemented are:
-------------------------------------

get_input_from_stdin_and_discard_extra_characters()
str_is_null_or_empty()
str_is_whitespaces()
str_is_null_or_empty_or_whitespaces()
str_is_integer()
str_starts_with()
str_ends_with()
str_join()
substr()
str_split()
get_number_of_strings_in_strings_array()
print_strings_array()
free_strings_array()

Functions to implement are:
-------------------------------------

str_is_float()
str_is_ascii()
str_strip()
str_strip_leading()
str_strip_trailing()
str_trim()
str_trim_leading()
str_trim_trailing()
str_compare_range()
str_hash_code()
str_remove_leading_characters()
str_remove trailing_characters()
str_r_str()
str_to_lower_case()
str_to_upper_case()
strtok_new()
str_left_pad(char, count)
str_right_pad(char, count)
str_replace_str()
str_replace_chr()
str_insert_str()
str_insert_chr()
str_remove_str()
str_remove_chr()
str_repeat(int count)
str_shuffle()
str_format_in_usa_currency()
get_file_name_from_path()
get_parent_directory_of()

// regex functions
str_match_regex()
str_starts_with_regex()
str_ends_with_regex()
str_replace_regex()
str_remove_regex()
str_split_on_regex_delim()

The code is below:
-------------------------

--------------------
string_library.c
--------------------

/*
 * License: This file has been released under APACHE LICENSE, VERSION 2.0.
 * The license details can be found here:
 *                            https://www.apache.org/licenses/LICENSE-2.0
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <ctype.h>

#include "string_library.h"

/* The description of functions in this file is in the header file
 * "string_library.h".
 */

static void free_all_allocated_memory(char **strings_array, long n);
static char **transform_str_to_string_array(const char *str);

char *get_input_from_stdin_and_discard_extra_characters(char *str, long size)
{

    int c = 0;
    long i = 0;

    // If 'size' is 0 then this function will discard all input and return NULL.
    // No need to check 'str' if 'size' is 0.
    if (size == 0) {
        // discard all input
        while ((c = getchar()) && (c != '\n') && (c != EOF));
        return NULL;
    }

    if (!str)
        return str;

    if (size < 0)
        return NULL;

    for (i = 0; i < (size - 1); i = i + 1) {

        c = getchar();

        if ((c == '\n') || (c == EOF)) {
            str[i] = 0;
            return str;
        }

        str[i] = (char)(c);

    } // end of for loop

    str[i] = 0;

    // discard rest of input
    while ((c = getchar()) && (c != '\n') && (c != EOF));

    return str;

} // end of get_input_from_stdin_and_discard_extra_characters

int str_is_null_or_empty(const char *str)
{

    if ((!str) || (!*str))
        return STR_LIB_TRUE;

    return STR_LIB_FALSE;

} // end of str_is_null_or_empty

int str_is_whitespaces(const char *str)
{

    long i = 0;

    if (!str)
        return STR_LIB_ALL_STRING_ARGS_ARE_NULL;

    while (str[i]) {
        if (!isspace(str[i]))
            return STR_LIB_FALSE;
        i++;
    }

    return STR_LIB_TRUE;

} // end of str_is_whitespaces

int str_is_null_or_empty_or_whitespaces(const char *str)
{

    if ((!str) || (!*str))
        return STR_LIB_TRUE;

    return str_is_whitespaces(str);

} // end of str_is_null_or_empty_or_whitespaces

int str_is_integer(const char *str)
{

    long i = 0;

    if (!str)
        return STR_LIB_ALL_STRING_ARGS_ARE_NULL;

    if (!*str)
        return STR_LIB_FALSE;

    while (str[i]) {
        if (!isdigit(str[i]))
            return STR_LIB_FALSE;
        i++;
    }

    return STR_LIB_TRUE;

} // end of str_is_integer

int str_starts_with(const char *str, const char *prefix,
                    long num_chars_to_compare)
{

    if ((!str) && (!prefix))
        return STR_LIB_ALL_STRING_ARGS_ARE_NULL;

    if ((!str) || (!prefix))
        return STR_LIB_FALSE;

    if (num_chars_to_compare < 0)
        return STR_LIB_AT_LEAST_ONE_ARG_IS_INVALID;

    if ((long)(strlen(str)) < num_chars_to_compare)
        return STR_LIB_ARGS_NOT_CONSISTENT_WITH_EACH_OTHER;

    if ((long)(strlen(prefix)) < num_chars_to_compare)
        return STR_LIB_ARGS_NOT_CONSISTENT_WITH_EACH_OTHER;

    if (strncmp(str, prefix, (size_t)(num_chars_to_compare)) == 0)
        return STR_LIB_TRUE;

    return STR_LIB_FALSE;

} // end of str_starts_with

int str_ends_with(const char *str, const char *suffix,
                  long num_chars_to_compare)
{

    long len_str = 0;
    long len_suffix = 0;

    if ((!str) && (!suffix))
        return STR_LIB_ALL_STRING_ARGS_ARE_NULL;

    if ((!str) || (!suffix))
        return STR_LIB_FALSE;

    if (num_chars_to_compare < 0)
        return STR_LIB_AT_LEAST_ONE_ARG_IS_INVALID;

    len_str = (long)(strlen(str));
    len_suffix = (long)(strlen(suffix));

    if (len_str < num_chars_to_compare)
        return STR_LIB_ARGS_NOT_CONSISTENT_WITH_EACH_OTHER;

    if (len_suffix < num_chars_to_compare)
        return STR_LIB_ARGS_NOT_CONSISTENT_WITH_EACH_OTHER;

    if (strncmp(str + len_str - num_chars_to_compare,
                suffix + len_suffix - num_chars_to_compare,
                (size_t)(num_chars_to_compare)) == 0)
        return STR_LIB_TRUE;

    return STR_LIB_FALSE;

} // end of str_ends_with

char *str_join(unsigned int skip_null_and_empty_input_strings,
               const char *delim, long num_args, ...)
{

    va_list valist;
    long i = 0;
    size_t iica = 0; // iica - index into character array
    size_t len = 0;
    size_t delim_len = 0;
    size_t total_len = 0;
    long num_delim_to_concat = -1;
    char *new_char_array = NULL;
    char *temp = NULL;

    if (num_args <= 0)
        return NULL;

    if (delim) {
        delim_len = strlen(delim);
    }

    va_start(valist, num_args);
    for (i = 0; i < num_args; i++) {

        temp = va_arg(valist, char *);

        if (skip_null_and_empty_input_strings) {
            if ((!temp) || (!*temp))
                continue;
        }

        if ((!temp) || (!*temp))
            len = 0;
        else
            len = strlen(temp);

        total_len = total_len + len;
        num_delim_to_concat = num_delim_to_concat + 1;
        if (num_delim_to_concat > 0)
            total_len = total_len + delim_len;

    }
    va_end(valist);

    if (total_len == 0)
        return NULL;

    total_len = total_len + 1; // 1 extra for terminating null byte

    new_char_array = malloc(total_len);
    if (!new_char_array)
        return NULL;

    va_start(valist, num_args);
    for (i = 0; i < num_args; i++) {

        temp = va_arg(valist, char *);

        if (skip_null_and_empty_input_strings) {
            if ((!temp) || (!*temp))
                continue;
        }

        if ((!temp) || (!*temp))
            len = 0;
        else
            len = strlen(temp);

        memmove(&(new_char_array[iica]), temp, len);
        iica = iica + len;

        if (num_delim_to_concat > 0) {
            memmove(&(new_char_array[iica]), delim, delim_len);
            iica = iica + delim_len;
            num_delim_to_concat = num_delim_to_concat - 1;
        }

    }
    va_end(valist);

    new_char_array[iica] = 0;

    return new_char_array;

} // end of str_join

char *substr(const char *str, long start_index, long end_index)
{

    char *substring = NULL;
    long len = 0;
    long substr_len = 0;

    if ((!str) || (!*str))
        return NULL;

    if ((start_index < 0) || (end_index < 0) || (end_index < start_index))
        return NULL;

    len = (long)(strlen(str));

    if ((start_index > (len - 1)) || (end_index > (len - 1)))
        return NULL;

    substr_len = end_index - start_index + 1;

    substring = malloc((size_t)(substr_len + 1)); // extra 1 byte for null byte
    if (!substring)
        return NULL;

    memmove(substring, str + start_index, (size_t)(substr_len));
    substring[substr_len] = 0;

    return substring;

} // end of substr

char **str_split(const char *str, const char *delim, long max_splits)
{

    char **output_strings_array = NULL;
    char *temp = NULL;
    char *prev_temp = NULL;
    long num_tokens = 0;
    size_t delim_len = 0;
    size_t len = 0;
    long i = 0;

    if ((!str) || (!*str))
        return NULL;

    if ((!delim) || (!*delim))
        return transform_str_to_string_array(str);

    if (max_splits == 0)
        return transform_str_to_string_array(str);

    // handle special case where delim does not occur in str
    if (strstr(str, delim) == NULL)
        return transform_str_to_string_array(str);

    delim_len = strlen(delim);

    temp = (char *)(str);
    prev_temp = (char *)(str);

    while (1) {

        temp = strstr(temp, delim);

        num_tokens = num_tokens + 1;

        if (!temp)
            break;

        temp = temp + delim_len;
        prev_temp = temp;

    } // end of while loop

    if ((max_splits > 0) && (max_splits < num_tokens))
        num_tokens = max_splits + 1;

    // allocate 1 extra character pointer to terminate output_strings_array with
    // a NULL pointer.
    output_strings_array = calloc((size_t)(num_tokens) + 1,
                                  (sizeof(*output_strings_array)));
    if (!output_strings_array)
        return NULL;

    temp = (char *)(str);
    prev_temp = (char *)(str);
    i = 0;

    while (1) {

        temp = strstr(temp, delim);

        len = (size_t)(temp - prev_temp);

        // allocate 1 extra byte for null terminator
        output_strings_array[i] = malloc(len + 1);
        if (!output_strings_array[i]) {
            free_all_allocated_memory(output_strings_array, i);
            return NULL;
        }

        memmove(output_strings_array[i], prev_temp, len);
        (output_strings_array[i])[len] = 0;
        i = i + 1;

        temp = temp + delim_len;
        prev_temp = temp;

        if ((num_tokens - i) == 1) { // last token

            len = (size_t)(str + strlen(str) - prev_temp);

            // allocate 1 extra byte for null terminator
            output_strings_array[i] = malloc(len + 1);
            if (!output_strings_array[i]) {
                free_all_allocated_memory(output_strings_array, i);
                return NULL;
            }

            memmove(output_strings_array[i], prev_temp, len);
            (output_strings_array[i])[len] = 0;
            i = i + 1;

            break;

        } // end of if ((num_tokens - i) == 1)

    } // end of while loop

    output_strings_array[i] = 0;

    return output_strings_array;

} // end of str_split

/*
 * static char **transform_str_to_string_array(const char *str):
 *
 * Function transform_str_to_string_array() basically allocates a
 * pointer to pointer to character (means a pointer to an array of
 * strings/elements). This array of strings have two elements - the first
 * element is a pointer to a copy of 'str' and the second element is a NULL
 * pointer/string/element.
 *
 * This is a static function and this function should not be called from outside
 * this file.
 */
static char **transform_str_to_string_array(const char *str)
{

    char **output_strings_array = NULL;
    size_t num_tokens = 1;
    size_t len = strlen(str);

    // allocate 1 extra character pointer to terminate output_strings_array with
    // a NULL pointer.
    output_strings_array = calloc(num_tokens + 1,
                                  (sizeof(*output_strings_array)));
    if (!output_strings_array)
        return NULL;

    // allocate 1 extra byte for null terminator
    output_strings_array[0] = malloc(len + 1);
    if (!output_strings_array[0]) {
        free(output_strings_array);
        return NULL;
    }

    memmove(output_strings_array[0], str, len);
    (output_strings_array[0])[len] = 0;

    output_strings_array[num_tokens] = 0;

    return output_strings_array;

} // end of transform_str_to_string_array

/*
 * static void free_all_allocated_memory(char **strings_array, long n):
 *
 * Function free_all_allocated_memory() frees all elements of the array of
 * strings that is passed to this function. It also frees the pointer to the
 * array of strings ('strings_array').
 *
 * This is a static function and this function should not be called from outside
 * this file.
 */
static void free_all_allocated_memory(char **strings_array, long n)
{

    long i = 0;

    if (!strings_array)
        return;

    for (i = 0; i < n; i = i + 1) {
        free(strings_array[i]);
    }

    free(strings_array);

} // end of free_all_allocated_memory

long get_number_of_strings_in_strings_array(const char **strings_array)
{

    long i = 0;

    if (!strings_array)
        return 0;

    while (strings_array[i]) {
        i = i + 1;
    }

    return i;

} // end of get_number_of_strings_in_strings_array

void print_strings_array(const char **strings_array)
{

    long i = 0;

    printf("Tokens are printed below (within single quotes):\n\n");
    printf("---- Start of Tokens ----\n");

    if (!strings_array) {
        printf("---- End of Tokens ----\n\n");
        return;
    }

    while (strings_array[i]) {
        printf("'%s'\n", strings_array[i]);
        i = i + 1;
    }

    printf("---- End of Tokens ----\n\n");

} // end of print_strings_array

void free_strings_array(char **strings_array)
{

    long i = 0;

    if (!strings_array)
        return;

    while (strings_array[i]) {
        free(strings_array[i]);
        i = i + 1;
    }

    free(strings_array);

} // end of free_strings_array

--------------------
string_library.h
--------------------

/*
 * License: This file has been released under APACHE LICENSE, VERSION 2.0.
 * The license details can be found here:
 *                            https://www.apache.org/licenses/LICENSE-2.0
 */

#ifndef _STRING_LIBRARY_H_
#define _STRING_LIBRARY_H_

#define STR_LIB_TRUE 1
#define STR_LIB_FALSE 0
#define STR_LIB_ALL_STRING_ARGS_ARE_NULL -1
#define STR_LIB_AT_LEAST_ONE_ARG_IS_INVALID -2
#define STR_LIB_ARGS_NOT_CONSISTENT_WITH_EACH_OTHER -3

/*
 * get_input_from_stdin_and_discard_extra_characters(char *str, long size):
 *
 * Function get_input_from_stdin_and_discard_extra_characters() reads at most
 * 'size - 1' characters into 'str' from stdin and then appends the null
 * character ('\0'). If 'size' is 0 then this function will discard all input
 * and return NULL. So, to discard all input, this function can be called with
 * 'str' having value NULL and 'size' having value 0.
 *
 * In all cases, reading input stops after encountering a newline ('\n') or EOF
 * even if 'size - 1' characters have not been read. If a newline ('\n') or EOF
 * is read then it is replaced by null character ('\0'). If there are extra
 * characters in input, they are read and discarded.
 * In all cases, 'str' or NULL is returned.
 */
char *get_input_from_stdin_and_discard_extra_characters(char *str, long size);

/*
 * char **str_split(const char *str, const char *delim, long max_splits):
 *
 * Function str_split() splits a string ('str') into tokens. It uses the 'delim'
 * string to split 'str' into tokens. If a 'delim' is found at position "i",
 * then the token ends at position "i - 1".
 *
 * If there are "n" 'delim' in 'str' then "n + 1" tokens are generated/returned.
 * However, some or all of these tokens may be empty strings. For example, if
 * 'str' contains only a single 'delim' then two empty tokens are generated.
 *
 * The reason that empty tokens are returned is that some users may want empty
 * tokens. One use case is that, if they are splitting records from a file to
 * insert in a database, then when an empty token is found, then they can insert
 * NULL value or 0 or empty string, etc. in that column.
 *
 * Users who don't want empty tokens can skip them by testing which token is
 * empty and which is not.
 *
 * The return value of this function is a pointer to pointer to character (means
 * a pointer to an array of strings/elements). This array of strings is
 * terminated by a NULL pointer/string/element which means that the last element
 * in this strings of array is a NULL pointer/string. So, you can loop through
 * this array of strings until you get a NULL pointer/string.
 *
 * The code of looping through this array of strings is:
 *
 *          long i = 0;
 *          while (strings_array[i]) {
 *              ..do stuff here..
 *              i = i + 1;
 *          }
 *
 * The above can be achieved using a for loop also:
 *
 *          long i = 0;
 *          for (i = 0; strings_array[i]; i = i + 1) {
 *              ..do stuff here..
 *          }
 *
 * If you want to skip the empty tokens then the following would be the code for
 * looping through this array of strings:
 *
 *          long i = 0;
 *          while (strings_array[i]) {
 *              if (!*(strings_array[i])) {
 *                  i = i + 1;
 *                  continue;
 *              }
 *              ..do stuff here..
 *              i = i + 1;
 *          }
 *
 * The above can be achieved using a for loop also:
 *
 *          long i = 0;
 *          for (i = 0; strings_array[i]; i = i + 1) {
 *              if (!*(strings_array[i]))
 *                  continue;
 *              ..do stuff here..
 *          }
 *
 *
 * If 'str' is NULL or empty then NULL is returned. NULL is also returned if
 * memory was not available. To find out what exactly happened, the user can
 * check whether 'str' is NULL or empty. In case, 'str' is neither NULL nor
 * empty then it means that memory was not available.
 *
 * 'max_splits' argument is used to control hwo many times 'str' should be
 * split. If 'max_splits' is less than the number of tokens that would be
 * ideally generated then the number of tokens is reduced to "max_splits + 1".
 * If max_splits is negative then it means that all tokens should be returned.
 *
 * If 'max_splits' is 0 or 'delim' is NULL or empty string or 'delim' is not
 * found in 'str' then an array of strings is returned which will have two
 * elements - the first element will be a pointer to a copy of 'str' and the
 * second element will be a NULL pointer/string/element.
 *
 * The return value of this function is a pointer to pointer to character (means
 * a pointer to an array of strings/elements) and it had been allocated using
 * malloc, so it is user's responsibility to free this memory. The user can
 * use the function free_strings_array() to free the strings_array returned by
 * this function.
 */
char **str_split(const char *str, const char *delim, long max_splits);

/*
 * void print_strings_array(const char **strings_array):
 *
 * Function print_strings_array() prints all the string elements of
 * 'strings_array'.
 */
void print_strings_array(const char **strings_array);

/*
 * void free_strings_array(char **strings_array):
 *
 * Function free_strings_array() frees all the string elements of
 * 'strings_array'. It also frees 'strings_array'.
 */
void free_strings_array(char **strings_array);

/*
 * long get_number_of_strings_in_strings_array(const char **strings_array):
 *
 * Function get_number_of_strings_in_strings_array() returns the count of number
 * of elements in 'strings_array'. It is assumed that this array of strings is
 * terminated by a NULL pointer/string/element.
 *
 */
long get_number_of_strings_in_strings_array(const char **strings_array);

/*
 * char *str_join(unsigned int skip_null_and_empty_input_strings,
 *                const char *delim, long num_args, ...):
 *
 * Parameters:
 *
 *      num_args: number of variable arguments that are passed to this function
 *                excluding the 'delim' string.
 *      ...: Variable number of "char *" pointers.
 *
 * Description:
 *
 *      Function str_join() concatenates all the strings/character arrays passed
 *      to it. If 'delim' is not NULL or not empty then between every two
 *      strings, the 'delim' string is concatenated.
 *
 *      If skip_null_and_empty_input_strings is zero then this means that
 *      NULL/empty strings should be considered valid strings for the purpose of
 *      concatenating 'delim' string - this means that if there is a
 *      NON-NULL/non-empty string in the variable arguments list which is then
 *      followed or preceded by a NULL/empty string then one 'delim' string will
 *      be concatenated between NON-NULL/non-empty string and NULL/empty string.
 *      This can be useful in case columns of a database are concatenated to
 *      form a record which will then be written in a file - so here, a column
 *      containing NULL/empty value will be represented as empty by having two
 *      consecutive 'delim' strings.
 *
 *      If skip_null_and_empty_input_strings is non-zero then this means that
 *      NULL/empty strings should be skipped and no 'delim' string should be
 *      concatenated for them.
 *
 *      Function str_join() allocates a new character array whose size is equal
 *      to the sum of the lengths of all strings passed to it plus 1 (extra 1
 *      for terminating null byte). It then concatenates all the strings passed
 *      to it (these strings are separated by 'delim' string but please see
 *      above for NULL/empty strings) into the newly allocated character array
 *      and then returns the pointer to the newly allocated character array.
 *      If memory allocation fails then NULL is returned.
 *
 *      It is the responsibility of the caller to free the allocated memory
 *      (that is, to free the returned pointer from this function).
 */
char *str_join(unsigned int skip_null_and_empty_input_strings,
               const char *delim, long num_args, ...);

/*
 * char *substr(const char *str, long start_index, long end_index):
 *
 * Function substr() allocates memory and returns a pointer to a
 * string / character array which is a substring of 'str' starting from index
 * 'start_index' till 'end_index' (inclusive). This substring is terminated by
 * null byte at the end.
 *
 * If 'str' is NULL or 'str' is empty or 'start_index' is less than 0 or
 * 'end_index' is less than 0 or 'end_index' is less than 'start_index' or
 * 'start_index' is greater than length of 'str' - 1 or 'end_index' is greater
 * than length of 'str' - 1 then NULL is returned.
 *
 * The returned pointer points to a memory region containing the substring and
 * this memory region was allocated using malloc. So, it is the user's
 * responsibility to free the allocated memory.
 *
 */
char *substr(const char *str, long start_index, long end_index);

int str_is_null_or_empty(const char *str);
int str_is_whitespaces(const char *str);
int str_is_null_or_empty_or_whitespaces(const char *str);
int str_is_integer(const char *str);
int str_starts_with(const char *str, const char *prefix,
                    long num_chars_to_compare);
int str_ends_with(const char *str, const char *suffix,
                  long num_chars_to_compare);

#endif

---- End of code ----
