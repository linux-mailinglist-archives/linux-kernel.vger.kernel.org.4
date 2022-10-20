Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE92605775
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJTGkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJTGkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:40:00 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC563840
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:39:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id u21so28436118edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5SkWu9TMlvfPH4xDr96EOyPcWTtFvPT5HwtFkody3dY=;
        b=ZrrCMMR+Oymq2SCRxzY/PVp2TZxWpi7cVQoTPBoWMGJXgpo4R+b0Ig7AWtU6VGjT9r
         WEMMQb4OThNdhUlWQzoyjZNsyqYFjskiPELT+lSQtfhNZ5KVpZTLpzxq74nY4ydsTPHx
         5l/ejpMF2tQcsL0fZ/XlIQrkZwc3xnRw5ZChHIACbrcCxEyh9xZsWsh/bazMae3jq6Fr
         h+PeeF5juYERGV/zaUHvanzrWlFdv9zhFIMSnFANcBiLZaW0cngBXm5gM8QSIWyYNY5M
         VmoWkgZgPf9WuLEok/tPEgINS3HjN34XUj9BlHko7aC3aN8G0nhOgx6ElsmsLrMxKfDw
         WDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5SkWu9TMlvfPH4xDr96EOyPcWTtFvPT5HwtFkody3dY=;
        b=5DiEDDKEbUpFOvtaZlUdrFZ0nn716WEWrte1TVkG7Q+k3YEreLqgpeJf8DeKXX/DcM
         v6LzNv1JGP1dyJP7IdDnfHNI+TKWK2Ov47XLxYJb5VVAxTJKrAcG15H2eGofpUkVIIC5
         abaRoD7vvmi5RyPWNz8Pzzt8zmTg/TjRn1B8QBcN2qF/Mrmyj8kbNLBUGYYyG1UZDdRG
         V4QvtICJJkLrOoDdCDNoXoOq3o7+IqRk4cZyhlNvLZ5RkK8wbLVJiTWiOvlsH7ziiPCb
         4WBibupktnJXdWWegQTU1tfY5cpyfvjJeeakzLHo3CipYOp0oNqA3iO4N1zSxeo7UXuz
         HzzA==
X-Gm-Message-State: ACrzQf3z0xdCTL8N3NMf8R/7D9oxb3Fscw8hp0elmQUGD9t2w8MzdIhW
        9dnOka0U9eh/Dyw9LBeV6PzyJFjU1OB7iwfz7YKQ/NJDC8E=
X-Google-Smtp-Source: AMsMyM7pcm8fkxfMUXo7heZjwrtYw5hW+0NRDeXfIeARBUzjp+lDet5+E3wKtYQw1zEhPOo06Q2so9nap2Yvj62XANQ=
X-Received: by 2002:a05:6402:4446:b0:457:eebd:fe52 with SMTP id
 o6-20020a056402444600b00457eebdfe52mr10685917edb.234.1666247997437; Wed, 19
 Oct 2022 23:39:57 -0700 (PDT)
MIME-Version: 1.0
From:   Amit <amitchoudhary0523@gmail.com>
Date:   Thu, 20 Oct 2022 12:09:47 +0530
Message-ID: <CAFf+5zhr96ORRJO_AMn3ZVc-REdkYAjxegq-3p=LSnGybgpG6g@mail.gmail.com>
Subject: Generic Linked List Library (like C++ STL list) - version 1.0
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

Generic Linked List Library (like C++ STL list) - version 1.0

The code is below:

-------------------------------------
generic_linked_list_library.c
-------------------------------------

/*
 * License: This file has been released under APACHE LICENSE, VERSION 2.0.
 * The license details can be found here:
https://www.apache.org/licenses/LICENSE-2.0
 */

#include <stdlib.h>
#include <string.h>

#include "generic_linked_list_library.h"

struct generic_linked_list_container
*init_generic_linked_list_container(before_deleting_data_callback_function
func)
{

    struct generic_linked_list_container *gllc_ptr = malloc(sizeof(*gllc_ptr));

    if (!gllc_ptr)
        return NULL;

    gllc_ptr->first = NULL;
    gllc_ptr->last = NULL;
    gllc_ptr->bdd_callback_func = func;
    gllc_ptr->total_number_of_nodes = 0;

    return gllc_ptr;

} // end of init_generic_linked_list_container

int add_new_node_to_end(struct generic_linked_list_container
*gllc_ptr, void *data, long data_len)
{

    struct linked_list_node *lln = NULL;
    struct node_data *nddt = NULL;

    if (!data)
        return ARG_DATA_IS_NULL;

    if (data_len <= 0)
        return DATA_LEN_IS_INVALID;

    lln = malloc(sizeof(*lln));
    if (!lln) {
        return NO_MEMORY;
    }

    nddt = malloc(sizeof(*nddt));
    if (!nddt) {
        free(lln);
        return NO_MEMORY;
    }

    nddt->data = malloc((size_t)(data_len));
    if (!nddt->data) {
        free(nddt);
        free(lln);
        return NO_MEMORY;
    }

    nddt->data_len = data_len;
    memmove(nddt->data, data, (size_t)(nddt->data_len));

    lln->nd_ptr = nddt;
    lln->next = NULL;

    if (gllc_ptr->total_number_of_nodes == 0) {
        gllc_ptr->first = lln;
        gllc_ptr->last = lln;
    } else {
        gllc_ptr->last->next = lln;
    }

    gllc_ptr->total_number_of_nodes = gllc_ptr->total_number_of_nodes + 1;

    return GLLL_SUCCESS;

} // end of add_new_node_to_end

struct node_data *remove_front_node_and_get_data(struct
generic_linked_list_container *gllc_ptr)
{

    struct linked_list_node *lln_ptr = NULL;
    struct node_data *nddt = NULL;

    lln_ptr = remove_front_node(gllc_ptr);
    if (!lln_ptr)
        return NULL;

    nddt = lln_ptr->nd_ptr;

    free(lln_ptr);

    return nddt;

} // end of remove_front_node_and_get_data

struct linked_list_node *remove_front_node(struct
generic_linked_list_container *gllc_ptr)
{

    struct linked_list_node *lln_ptr = NULL;

    if (gllc_ptr->total_number_of_nodes == 0)
        return NULL;

    lln_ptr = gllc_ptr->first;

    if (gllc_ptr->total_number_of_nodes == 1) {
        gllc_ptr->first = NULL;
        gllc_ptr->last = NULL;
    } else {
        gllc_ptr->first = gllc_ptr->first->next;
    }

    gllc_ptr->total_number_of_nodes = gllc_ptr->total_number_of_nodes - 1;

    lln_ptr->next = NULL;

    return lln_ptr;

} // end of remove_front_node

void delete_front_node(struct generic_linked_list_container *gllc_ptr)
{

    struct linked_list_node *lln_ptr = NULL;
    struct node_data *nddt = NULL;

    lln_ptr = remove_front_node(gllc_ptr);
    if (!lln_ptr)
        return;

    nddt = lln_ptr->nd_ptr;

    if (gllc_ptr->bdd_callback_func)
        gllc_ptr->bdd_callback_func(nddt);

    free(nddt);
    free(lln_ptr);

    return;

} // end of delete_front_node

-------------------------------------
generic_linked_list_library.h
-------------------------------------

/*
 * License: This file has been released under APACHE LICENSE, VERSION 2.0.
 * The license details can be found here:
https://www.apache.org/licenses/LICENSE-2.0
 */

#ifndef _GENERIC_LINKED_LIST_LIBRARY_H_
#define _GENERIC_LINKED_LIST_LIBRARY_H_

#define GLLL_SUCCESS 0 // everything happened successfully
#define ARG_DATA_IS_NULL -1 // 'data' argument is NULL
#define DATA_LEN_IS_INVALID -2 // 'data_len' argument is <= 0
#define NO_MEMORY -3 // no memory available

struct node_data
{
    void *data;
    long data_len;
};

struct linked_list_node
{
    struct node_data *nd_ptr;
    struct linked_list_node *next;
};

typedef void (*before_deleting_data_callback_function)(struct node_data *);

struct generic_linked_list_container
{
    struct linked_list_node *first;
    struct linked_list_node *last;
    before_deleting_data_callback_function bdd_callback_func;
    long total_number_of_nodes;
};

struct generic_linked_list_container
*init_generic_linked_list_container(before_deleting_data_callback_function
func);
int add_new_node_to_end(struct generic_linked_list_container
*gllc_ptr, void *data, long data_len);
struct node_data *remove_front_node_and_get_data(struct
generic_linked_list_container *gllc_ptr);
struct linked_list_node *remove_front_node(struct
generic_linked_list_container *gllc_ptr);
void delete_front_node(struct generic_linked_list_container *gllc_ptr);

#endif

---- End of code ----
