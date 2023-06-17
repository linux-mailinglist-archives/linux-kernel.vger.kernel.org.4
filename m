Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B577343D4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346348AbjFQUwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFQUwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:52:35 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1184EAB
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:52:34 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-341cb9528f5so9376265ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687035153; x=1689627153;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xt5tBCuh4bk3gvKA/8WN+ze1HqhBkx/y9yaXcS2DBMw=;
        b=frMyDzvgISt4X0LwHS98A4npWdg9QVbUXE5SUgdgGRPqJy52mC0YjAOjj/q70ulAch
         xQmIki6RlXQDh6CawqlvzhuIO3Ddth2tzkVGJj5GDWoOnITRalsDVVWx8N1+iPdqgAjL
         URaIWI4GmiomumbmjMvHAf2XjMcVL053AetlZbC6BLRVsf++T9D88oIdHZTiMtrj+FTw
         CkiLjujl9qC5wByYBwrl4NskvkMOeW03trf4ZE/MmS6uXA8qRXSNe0T2axo2VVa0d3k6
         OJ5rdLT844+ROINIZ2xg1C3qy4ayk19tX0YTTU/eZ4TSYM2IAUnB2LhHUta9+NAFWs6M
         oEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687035153; x=1689627153;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xt5tBCuh4bk3gvKA/8WN+ze1HqhBkx/y9yaXcS2DBMw=;
        b=jFFGpFA5zKw0p0V+LRhLWu6m/r8pCHNhSLkz9jjNQJdtTH72hU/PAst2cg5LkuxUcH
         EmAf1OwJfx/vlfbUecIq6qKW3gfgAJJSFZW/kz3+lHJghu+mxTLRnmo1p6IZagED0xca
         0MeLzacxn9+xeP1jVbM1u3pNUanC35uGfGAbrSXDv2VcsjHq8Rz7sn6AfhfKuMdN+qq4
         erJO7DGe/gvN8pBycGA54GnsxBTiEc/eKA3vDlDc7mTvmUu6R+UosYQhDaz8ICTigBUP
         weVFBsHCJy+rUIZC651Ldj2EQay7CdKGmUCVj6c3UOuyEUStS7eTRgGIhNG6MT+sEDlQ
         2taA==
X-Gm-Message-State: AC+VfDxtnsQuc3fjcsTVUVLXbvAsjeK03yawKTd+YMmp5+lrLRVLhLsC
        dvyPSnSDF0/AfE46JBEaN8MxhC7ShwSeo/Qc
X-Google-Smtp-Source: ACHHUZ7xm1WJwIyioKRmT8IfFY0m8vymuHsWwHM2t+XlmFRjPDbPyE8eBWSVfm4SMTZTb3Etxk7BBA==
X-Received: by 2002:a92:d3d0:0:b0:340:5661:5186 with SMTP id c16-20020a92d3d0000000b0034056615186mr3321941ilh.14.1687035153073;
        Sat, 17 Jun 2023 13:52:33 -0700 (PDT)
Received: from [192.168.43.16] ([199.7.157.10])
        by smtp.gmail.com with ESMTPSA id s7-20020a92d907000000b003350c8ae201sm7577337iln.29.2023.06.17.13.52.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 13:52:32 -0700 (PDT)
Message-ID: <b133a70d-a0f6-a99f-ca73-84dba1bedcc8@gmail.com>
Date:   Sat, 17 Jun 2023 16:52:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   Aravind Ceyardass <aravind.pub@gmail.com>
Subject: reference counting gcc plugin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kernel People,

I have developed a gcc plugin for implementing reference counting. I see that the kernel has implemented many different techniques over the years, but I couldn't find any with compiler support.

I would like your ideas, inputs before I release the plugin for everyone hoping that it would benefit the Linux kernel.

Here is a sample code to give you an idea of usage and the code transformation done by the plugin.


#include "hrcmm.h"
/*
  REFTRACK_STRUCT macro defines the following declarations

  struct foo;
  void foo_addref(const struct foo *const);
  void foo_removeref(const struct foo *const);
  void foo_destroy(struct foo *const);
*/

REFTRACK_STRUCT(foo){
    int bar;
};

/*
  REFTRACK_EPILOG_WITH_DTOR macro calls foo_destroy when reference count is zero.
  This is optional, if there is no special cleanup to be done, use REFTRACK_EPILOG. 
*/
REFTRACK_EPILOG_WITH_DTOR(foo);

// This function is called when the reference count for object pointed to by p is zero
void foo_destroy(struct foo *p){
    if (p)
        printf("foo destroyed:%p\n", p);
}

typedef struct foo foo;

// statements commented out are injected by the plugin
     
void baz(foo *p){
    printf("%d\n", p->bar);
    // foo_removeref(p);
}

int main(int argc, char *argv[]){
    foo *p = rc_malloc(sizeof(foo)); // rc_malloc is a default wrapper provided
    // foo_addref(p); 
    p->bar = 123;
    
    // foo_addref(p); 
    foo *q = p;

    // foo_addref(q); 
    baz(q);

    // foo_removeref(p); 
    // foo_removeref(q); 
}


Aravind

