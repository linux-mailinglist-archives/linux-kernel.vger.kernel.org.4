Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A575612F93
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJaFAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaFAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:00:11 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCA32DEA
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:00:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id fz10so1151435qtb.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8eqTjguB2oGWax96LvgoPSRaOwaKV0lZXOHpXf5yIg=;
        b=Z6EhDUqtSdLCakfj7nxJOpCMa+1G5l/MyNyE0qyPeeiowPd9u630XyOtzdq8chD9ET
         kwmeUmMnSPk3CDcLZQw2FPiRv/kKDGrTHfdcb3VWFCj0ryYhQtQLYGR12sLAbIR2Mz8l
         VFpbYOQjuDpIvpo26V2On1F9aBsWArWM9FVKlULWhJyJ3NV37u8aB+YN5xYULxLeoob5
         iHD/4IUbrAB+6ktwshX00ubfpuXBzNEXM5wEYCttkTnIGE37CO/AdI0eiJex8AzuZzVp
         c7yNWgMnRSa3qLxJZR2OSXwBWcv7T7TeYrTNbnK/z+iyuzPm8/psIoMJgsVEq3fxMJHw
         vtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8eqTjguB2oGWax96LvgoPSRaOwaKV0lZXOHpXf5yIg=;
        b=FnN9bQxHyaTrltSkkhONjDHLGWuYY8pDB2JlWqxpgLNHdpyR8ADoKRRn1P8H67bsUI
         t0oB93yf0m7+FoUwFQJ64qPfPXBoffcAfx1dEUB0njn0WIDGtotZcsVIoXLd4ht3oUsY
         EUjMia3sZHCa096/dZsM4vfhcLJQRvWMRPmSCHPgg58Sl9zVCjuqv7s25+DefiQVlMDb
         BpWsJ3a3LAJmDVEDHGffdNNtL8Lh7A6hSNrxNHLhkgnwSQ4+r75xYabPdUQHpCO0zmFr
         4oxPFp+lHAOlhgFH0q6krXb2odttpQeHZJy6YUqQuhaPw2fJWPI11+3wOvhgGgIVmAPs
         bmqg==
X-Gm-Message-State: ACrzQf0hLtxDqJiYHHquEoCkcj5ynJmZVZ7T+Kd6fJI2tW36jkAVT6cI
        WqiI29yF8DER/wjtmsrO2xqXSVUkVRY=
X-Google-Smtp-Source: AMsMyM6Oa/2+1fSB4rp+Qz0DQWpeITC7sckuY6ko39FxNxORU6ssA6V4udQB9PwW1K3vG1W87T/gtg==
X-Received: by 2002:ac8:5f54:0:b0:39c:ce86:65dd with SMTP id y20-20020ac85f54000000b0039cce8665ddmr8873496qta.285.1667192409390;
        Sun, 30 Oct 2022 22:00:09 -0700 (PDT)
Received: from sophie ([185.156.46.162])
        by smtp.gmail.com with ESMTPSA id e5-20020ac84905000000b003a5092ed8cdsm3196150qtq.9.2022.10.30.22.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 22:00:09 -0700 (PDT)
Date:   Mon, 31 Oct 2022 00:00:06 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/5] memblock tests: add tests for
 memblock_alloc_exact_nid_raw
Message-ID: <20221031050006.GA15612@sophie>
References: <cover.1666203642.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666203642.git.remckee0@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

I noticed that the memblock tree has been updated since I sent this
patch set. Do you want me to send an updated patch set applied on top of
the current tree?

On Wed, Oct 19, 2022 at 01:34:07PM -0500, Rebecca Mckeever wrote:
> These patches add tests for memblock_alloc_exact_nid_raw(). There are two
> sets of tests: range tests and NUMA tests. The range tests use a normal
> (i.e., UMA) simulated physical memory and set the nid to NUMA_NO_NODE. The
> NUMA tests use a simulated physical memory that is set up with multiple
> NUMA nodes. Additionally, most of the NUMA tests set nid != NUMA_NO_NODE.
> 
> For the range tests, the TEST_F_EXACT flag is used to run the same set of
> range tests used for memblock_alloc_try_nid_raw(). The NUMA tests have the
> same setup as the corresponding test for memblock_alloc_try_nid_raw(), but
> several of the memblock_alloc_exact_nid_raw() tests fail to allocate
> memory in setups where the memblock_alloc_try_nid_raw() test would
> allocate memory. Also, some memblock_alloc_exact_nid_raw() tests drop the
> lower limit of the requested range in order to allocate within the
> requested node, but the same setup in a memblock_alloc_try_nid_raw() test
> allocates within the requested range.
> 
> ---
> Changelog
> 
> v1 -> v2
> PATCH 0:
> - Add missing memblock_alloc_exact_nid_raw to subject line
> 
> v2 -> v3
> Based on feedback from David Hildenbrand:
> PATCH 1:
> - alloc_nid_api.c, alloc_nid_api.h, common.h:
>     + Add TEST_F_EXACT flag so that tests in alloc_nid_api.c can be run
>       with that flag to test memblock_alloc_exact_nid_raw()
> - alloc_exact_nid_api.c:
>     + Update to run range tests in alloc_nid_api.c with TEST_F_EXACT flag
>       instead of using a separate set of tests
> - alloc_nid_api.c:
>     + Rename tests and other functions by removing "_try" so that the
>       function names are general enough to refer to any of the
>       memblock_alloc_*nid*() functions of the memblock API
> ---
> 
> Rebecca Mckeever (5):
>   memblock tests: introduce range tests for memblock_alloc_exact_nid_raw
>   memblock tests: add top-down NUMA tests for
>     memblock_alloc_exact_nid_raw
>   memblock tests: add bottom-up NUMA tests for
>     memblock_alloc_exact_nid_raw
>   memblock tests: add generic NUMA tests for
>     memblock_alloc_exact_nid_raw
>   memblock tests: remove completed TODO item
> 
>  tools/testing/memblock/Makefile               |    2 +-
>  tools/testing/memblock/TODO                   |    7 +-
>  tools/testing/memblock/main.c                 |    2 +
>  .../memblock/tests/alloc_exact_nid_api.c      | 1113 +++++++++++++++++
>  .../memblock/tests/alloc_exact_nid_api.h      |   25 +
>  tools/testing/memblock/tests/alloc_nid_api.c  |  542 ++++----
>  tools/testing/memblock/tests/alloc_nid_api.h  |    1 +
>  tools/testing/memblock/tests/common.h         |    2 +
>  8 files changed, 1425 insertions(+), 269 deletions(-)
>  create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.c
>  create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.h
> 
> -- 
> 2.25.1
> 
Thanks,
Rebecca
