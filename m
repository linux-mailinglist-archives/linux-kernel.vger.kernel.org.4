Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2801469BF13
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 08:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBSHy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 02:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBSHyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 02:54:25 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017EC126F3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 23:54:23 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id x22so796864edd.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 23:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ARjx7c9m7vG+q/SN6iGU/UqUFITeG/nn+7TUwXaK0N0=;
        b=TOAm+GkJyV44mBB8nCF6C1lvWOtjAChasTzBztBB/BcVt1DbTWoTKKgqZ0/VURsrdL
         23PHPiDIapp4m4kK8H5+QFBEYBL7+QxdjLMtoXYhMUFPSmyxIKD6O+ZjZ/Q8vkFsTL73
         h1+rz4T65HLVITInybqxMDS1NiaAoJV31hUFqIq0G0JKRQ2sbPz7v/Bw738K8bfTv7z2
         cYiWy+LihCcDqnFYFqVOdTrK8mLfWnDt3uGOGcM0fPGaT/UrZlCzGfwNd++bE2vcMwgH
         V/v6WqVsMhltZM02dNJZ/dbM29E5jrgzEwOCNbFitTqdLPxYH/PJKNpWy9FnTiU234Xy
         RquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ARjx7c9m7vG+q/SN6iGU/UqUFITeG/nn+7TUwXaK0N0=;
        b=0c1BdnzkvLdzVx5oxcH8dBdI1447rB6jFEtHKJ321dumlumpPY9GUGosVlb/lXsIDh
         s4fv0jzTEhrOuAEASGy9Z4RT1asI6wvk5t1Qh9dUMQ+gznHnxAWqgZZuGxoY2bo11Ie0
         ta/+wRbbuqCzKys7otHB51Q1OOMjjvQfblgf9w6rmEDCX08TDGYNI0L2RJFkmvMdJOMH
         Qo4hH0raoCD7qj4xyDtkwgGlX6gjKUZVkFnMOlc+Rc1i1tafjFSx2ErEjsyb8Us/Y5JO
         bWtZ3jPJRRL0aPvDIrd8iApFwh+hBG0bq2t4SpWHRXYLFxArWOA6ntXhfjezqujRxFsg
         UKXA==
X-Gm-Message-State: AO0yUKUl1w+Tsb3oW8vQ1mdzXxZ8tXPi8OZN4ClsohQvZ5NcOKkUJTcx
        57ZHmljkBH2aBZSFwiYTs4ado5TdAQZa5HInAcmtZBLUU+yz8g==
X-Google-Smtp-Source: AK7set+RxUQGgNJCFIlV/cgv3JLwt1LiYwN8yOLGFimrjv9LPqkR6bAlV9JTVoQXinrJqGLk/os8UgeeDAC7J27rf6w=
X-Received: by 2002:a17:906:9499:b0:8b1:79ef:6923 with SMTP id
 t25-20020a170906949900b008b179ef6923mr3753219ejx.15.1676793262034; Sat, 18
 Feb 2023 23:54:22 -0800 (PST)
MIME-Version: 1.0
From:   Amit <amitchoudhary0523@gmail.com>
Date:   Sun, 19 Feb 2023 13:24:12 +0530
Message-ID: <CAFf+5zg=dsD29RfTydWJWsmOcvcw+aLszaPokV=SM8hPLtC4YA@mail.gmail.com>
Subject: Generic Unordered Set Library (similar to C++ STL unordered_set).
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

Generic Unordered Set Library (similar to C++ STL unordered_set).

The code is below:

-------------------------------------------
generic_unordered_set_library.c
-------------------------------------------

/*
 * License: This file has been released under APACHE LICENSE, VERSION 2.0.
 * The license details can be found here:
 *                            https://www.apache.org/licenses/LICENSE-2.0
 */

#include "generic_unordered_set_library.h"

#include <stdlib.h>
#include <string.h>
#include <stddef.h>

static void us_get_matching_and_prev_elements(
                             struct generic_unordered_set_container *gusc_ptr,
                             void *data, long data_size,
                             struct element **pmatch, struct element **pprev)
{

    struct element *temp = NULL;
    struct element *prev = NULL;

    *pmatch = NULL;
    if (pprev) {
        *pprev = NULL;
    }

    for (prev = NULL, temp = gusc_ptr->first;
         temp != NULL;
         prev = temp, temp = temp->next) {

        if (temp->data_size != data_size) {
            continue;
        }

        if (memcmp(temp->data, data, (size_t)(data_size)) == 0) { //
element matched
            *pmatch = temp;
            if (pprev) {
                *pprev = prev;
            }
            break;
        }

    } // end of for loop

    return;

} // end of us_get_matching_and_prev_elements

struct generic_unordered_set_container *us_init_generic_unordered_set_container(
                   call_function_before_deleting_data cfbdd_callback_function)
{

    struct generic_unordered_set_container *gusc_ptr = NULL;

    gusc_ptr = malloc(sizeof(*gusc_ptr));

    if (!gusc_ptr) {
        return NULL;
    }

    gusc_ptr->first = NULL;
    gusc_ptr->fi = NULL;
    gusc_ptr->total_number_of_elements = 0;
    gusc_ptr->cfbdd_callback_function = cfbdd_callback_function;

    return gusc_ptr;

} // end of us_init_generic_unordered_set_container

long us_get_total_number_of_elements(
                             struct generic_unordered_set_container *gusc_ptr)
{

    long num_elems = 0;

    num_elems = gusc_ptr->total_number_of_elements;

    return num_elems;

} // end of us_get_total_number_of_elements

int us_add_new_element(struct generic_unordered_set_container *gusc_ptr,
                       void *data, long data_size)
{

    struct element *matched_elem = NULL;
    struct element *prev_elem = NULL;
    struct element *new_elem = NULL;

    if (!data) {
        return GUSL_AT_LEAST_ONE_ARG_IS_INVALID;
    }

    if (data_size <= 0) {
        return GUSL_AT_LEAST_ONE_ARG_IS_INVALID;
    }

    us_get_matching_and_prev_elements(gusc_ptr, data, data_size, &matched_elem,
                                      &prev_elem);

    if (matched_elem) {
        return GUSL_ELEMENT_EXISTS;
    }

    new_elem = malloc(sizeof(*new_elem));
    if (!new_elem) {
        return GUSL_NO_MEMORY;
    }

    new_elem->data = malloc((size_t)(data_size));
    if (!new_elem->data) {
        free(new_elem);
        return GUSL_NO_MEMORY;
    }

    new_elem->data_size = data_size;
    memmove(new_elem->data, data, (size_t)(new_elem->data_size));

    new_elem->next = NULL;

    if (!prev_elem) { // no elements in the set
        gusc_ptr->first = new_elem;
    } else {
        prev_elem->next = new_elem;
    }

    gusc_ptr->total_number_of_elements = gusc_ptr->total_number_of_elements + 1;

    return GUSL_SUCCESS;

} // end of us_add_new_element

// The user is responsible for freeing the data pointer that is returned in
// *pdata.
int us_get_data_from_front_element_and_delete_front_element(
                             struct generic_unordered_set_container *gusc_ptr,
                             void **pdata, long *pdata_size)
{

    struct element *temp = NULL;

    if ((!pdata) || (!pdata_size)) {
        return GUSL_AT_LEAST_ONE_ARG_IS_INVALID;
    }

    *pdata = NULL;
    *pdata_size = 0;

    if (gusc_ptr->total_number_of_elements == 0) {
        return GUSL_SET_IS_EMPTY;
    }

    *pdata = gusc_ptr->first->data;
    *pdata_size = gusc_ptr->first->data_size;

    temp = gusc_ptr->first;
    gusc_ptr->first = gusc_ptr->first->next;

    temp->next = NULL;
    free(temp);

    gusc_ptr->total_number_of_elements = gusc_ptr->total_number_of_elements - 1;

    return GUSL_SUCCESS;

} // end of us_get_data_from_front_element_and_delete_front_element

int us_is_element_present(struct generic_unordered_set_container *gusc_ptr,
                          void *data, long data_size)
{

    struct element *matched_elem = NULL;

    if (!data) {
        return GUSL_AT_LEAST_ONE_ARG_IS_INVALID;
    }

    if (data_size <= 0) {
        return GUSL_AT_LEAST_ONE_ARG_IS_INVALID;
    }

    if (gusc_ptr->total_number_of_elements == 0) {
        return GUSL_FALSE;
    }

    us_get_matching_and_prev_elements(gusc_ptr, data, data_size, &matched_elem,
                                      NULL);

    if (matched_elem) {
        return GUSL_TRUE;
    }

    return GUSL_FALSE;

} // end of us_is_element_present

int us_replace_data_and_size_in_matching_element(
                             struct generic_unordered_set_container *gusc_ptr,
                             void *old_data, long old_data_size,
                             void *new_data, long new_data_size)
{

    struct element *matched_elem = NULL;
    void *data = NULL;

    if ((!old_data) || (!new_data)) {
        return GUSL_AT_LEAST_ONE_ARG_IS_INVALID;
    }

    if ((old_data_size <= 0) || (new_data_size <= 0)) {
        return GUSL_AT_LEAST_ONE_ARG_IS_INVALID;
    }

    if (gusc_ptr->total_number_of_elements == 0) {
        return GUSL_SET_IS_EMPTY;
    }

    us_get_matching_and_prev_elements(gusc_ptr, old_data, old_data_size,
                                      &matched_elem, NULL);

    if (!matched_elem) {
        return GUSL_ELEMENT_NOT_FOUND;
    }

    // We will allocate memory for contents of new_data and copy contents of
    // new_data into this newly allocated memory. Then we will free old_data
    // and populate the data member of the matched_elem with the address of the
    // newly allocated memory. We will also populate the data_size member of
    // the matched_elem with the value in new_data_size.
    data = malloc((size_t)(new_data_size));
    if (!data) {
        return GUSL_NO_MEMORY;
    }

    memmove(data, new_data, (size_t)(new_data_size));

    if (gusc_ptr->cfbdd_callback_function) {
        gusc_ptr->cfbdd_callback_function(gusc_ptr, matched_elem->data);
    }

    free(matched_elem->data);

    matched_elem->data = data;
    matched_elem->data_size = new_data_size;

    return GUSL_SUCCESS;

} // end of us_replace_data_and_size_in_matching_element

int us_delete_matching_element(
                             struct generic_unordered_set_container *gusc_ptr,
                             void *data, long data_size)
{

    struct element *matched_elem = NULL;
    struct element *prev_elem = NULL;

    if (!data) {
        return GUSL_AT_LEAST_ONE_ARG_IS_INVALID;
    }

    if (data_size <= 0) {
        return GUSL_AT_LEAST_ONE_ARG_IS_INVALID;
    }

    if (gusc_ptr->total_number_of_elements == 0) {
        return GUSL_SET_IS_EMPTY;
    }

    us_get_matching_and_prev_elements(gusc_ptr, data, data_size, &matched_elem,
                                      &prev_elem);

    if (!matched_elem) {
        return GUSL_ELEMENT_NOT_FOUND;
    }

    if (!prev_elem) { // first element matched
        gusc_ptr->first = gusc_ptr->first->next;
    } else {
        prev_elem->next = matched_elem->next;
    }

    matched_elem->next = NULL;

    if (gusc_ptr->cfbdd_callback_function) {
        gusc_ptr->cfbdd_callback_function(gusc_ptr, matched_elem->data);
    }

    gusc_ptr->total_number_of_elements = gusc_ptr->total_number_of_elements - 1;

    free(matched_elem->data);
    free(matched_elem);

    return GUSL_SUCCESS;

} // end of us_delete_matching_element

void us_init_fi(struct generic_unordered_set_container *gusc_ptr)
{

    gusc_ptr->fi = gusc_ptr->first;

    return;

} // end of us_init_fi

int us_fi_has_next_element(struct generic_unordered_set_container *gusc_ptr)
{

    int has_next = GUSL_FALSE;

    if (gusc_ptr->fi) {
        has_next = GUSL_TRUE;
    }

    return has_next;

} // end of us_fi_has_next_element

// The user should not free the data pointer that is returned in *pdata because
// the element that contains the data is still part of the set. However, the
// user can modify the data and then modify data_size if the size of data has
// changed.
int us_fi_get_data_from_next_element(
                             struct generic_unordered_set_container *gusc_ptr,
                             void **pdata, long **ppdata_size)
{

    if ((!pdata) || (!ppdata_size)) {
        return GUSL_AT_LEAST_ONE_ARG_IS_INVALID;
    }

    *pdata = NULL;
    *ppdata_size = 0;

    *pdata = gusc_ptr->fi->data;
    *ppdata_size = &(gusc_ptr->fi->data_size);

    gusc_ptr->fi = gusc_ptr->fi->next;

    return GUSL_SUCCESS;

} // end of us_fi_get_data_from_next_element

void us_delete_all_elements(struct generic_unordered_set_container *gusc_ptr)
{

    struct element *temp = NULL;

    while ((temp = gusc_ptr->first)) {

        gusc_ptr->first = gusc_ptr->first->next;
        temp->next = NULL;

        if (gusc_ptr->cfbdd_callback_function) {
            gusc_ptr->cfbdd_callback_function(gusc_ptr, temp->data);
        }

        free(temp->data);
        free(temp);

        gusc_ptr->total_number_of_elements =
                                       gusc_ptr->total_number_of_elements - 1;
    }

    // crash the program if total_number_of_elements is not zero
    if (gusc_ptr->total_number_of_elements != 0) {
        *((unsigned long *)(-1)) = 123;
    }

    return;

} // end of us_delete_all_elements

void us_delete_container(struct generic_unordered_set_container *gusc_ptr)
{

    us_delete_all_elements(gusc_ptr);

    free(gusc_ptr);

    return;

} // end of us_delete_container

-------------------------------------------
generic_unordered_set_library.h
-------------------------------------------

/*
 * License: This file has been released under APACHE LICENSE, VERSION 2.0.
 * The license details can be found here:
 *                            https://www.apache.org/licenses/LICENSE-2.0
 */

#ifndef _GENERIC_UNORDERED_SET_LIBRARY_H_
#define _GENERIC_UNORDERED_SET_LIBRARY_H_

#define GUSL_SUCCESS 2 // everything happened successfully
#define GUSL_TRUE 1 // true
#define GUSL_FALSE 0 // false
#define GUSL_AT_LEAST_ONE_ARG_IS_INVALID -1 // at least one argument is invalid
#define GUSL_NO_MEMORY -2 // no memory available
#define GUSL_ELEMENT_EXISTS -3 // element already exists in the set
#define GUSL_SET_IS_EMPTY -4 // there are no elements in the set
#define GUSL_ELEMENT_NOT_FOUND -5 // element not found in the set

struct generic_unordered_set_container;

struct element
{
    void *data;
    long data_size;
    struct element *next;
};

// gusc_ptr needs to be sent because in case the user has created more than
// one container and the user stores different 'data' in each container, then
// the user will be able to identify that the 'data' belongs to which container.
// Otherwise, the user won't be able to identify that the 'data' belongs to
// which container and then things won't happen correctly.
typedef void (*call_function_before_deleting_data)(
                             struct generic_unordered_set_container *gusc_ptr,
                             void *data);

struct generic_unordered_set_container
{
    struct element *first;
    struct element *fi; // fi stands for forward iterator
    long total_number_of_elements;
    // callback function
    call_function_before_deleting_data cfbdd_callback_function;
};

/*
 * Names of functions start with the prefix us_. us_ stands for unordered set.
 *
 * In this software, delete and free mean the same thing.
 */

struct generic_unordered_set_container *us_init_generic_unordered_set_container(
                   call_function_before_deleting_data cfbdd_callback_function);

long us_get_total_number_of_elements(
                             struct generic_unordered_set_container *gusc_ptr);

int us_add_new_element(struct generic_unordered_set_container *gusc_ptr,
                       void *data, long data_size);

int us_get_data_from_front_element_and_delete_front_element(
                             struct generic_unordered_set_container *gusc_ptr,
                             void **pdata, long *pdata_size);

int us_is_element_present(struct generic_unordered_set_container *gusc_ptr,
                          void *data, long data_size);

int us_replace_data_and_size_in_matching_element(
                             struct generic_unordered_set_container *gusc_ptr,
                             void *old_data, long old_data_size,
                             void *new_data, long new_data_size);

int us_delete_matching_element(
                             struct generic_unordered_set_container *gusc_ptr,
                             void *data, long data_size);

void us_init_fi(struct generic_unordered_set_container *gusc_ptr);

int us_fi_has_next_element(struct generic_unordered_set_container *gusc_ptr);

int us_fi_get_data_from_next_element(
                             struct generic_unordered_set_container *gusc_ptr,
                             void **pdata, long **ppdata_size);

void us_delete_all_elements(struct generic_unordered_set_container *gusc_ptr);

void us_delete_container(struct generic_unordered_set_container *gusc_ptr);

#endif
