Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7B617403
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKCCJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKCCJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:09:09 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB3F5FB0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:09:08 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l127so623577oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 19:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3kav229FcT5RedMgRM0xVlY6MwQlOtEuSw3Vkef24s=;
        b=i7tJTcqPQiVG7CjFubgr+q0cSlwolDBd/uusG/bli2fmChQcyMaGs/LWbT4SKjUVvP
         r7L2PyK5IWY5mv9qP6Iryb3SHmxrPXvLLXUN5hecCIq+ZgMB3rP/aTZETCsD2/CU9DiI
         Jr+gOHq4GsdeQI3kiFFN0ZUYO5Xa4ba3zxP3uqf23RtLHEUpIEOmt+ny1ffdyGxogk/b
         pYHZKdQI/QddMywEAJjaZ+Iu4uVhx15qZ9ENDdTVo34fUOWtsSeowZ0j1ZLzwAixTM5W
         zMbePGbpyapOcvRgwbzQGKdFkkA4oJXffuhaKtAO9yD3Z/IsipNBaB1b3+HyPWCcJ7+L
         wpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3kav229FcT5RedMgRM0xVlY6MwQlOtEuSw3Vkef24s=;
        b=WkMvGpUYFRVR8CQZrj8WRvR5E3TjC091ejwxl8+bZ+Dpput4kNtH+6EBqDCSTg20Z1
         ix/cd2ALX/YEyWoSRNMUzLH3d4St7eJuHCgEj7IX6XodsRTaPqyQ02w32BSG4CQhkw7O
         Vrnjm6HK1PhPyEoNDI3E/7ihH+5TrTCgL3PiXvzuOc/2JEiI6Y7zH/IOX+1v7fU7lWng
         Up1OwGSwq59gzs58fEIRotsb5VuE4MZEJyC5qZIBomTOQq9QHG8SYhkxhXFJIhMA8P9t
         ijUz9CTagekLPf6DNXQFuIvyEewcmtxL9j5l+xTnWrudCEr+wjHIFDAf7thMQr8esEul
         rWMQ==
X-Gm-Message-State: ACrzQf06XFD7Z6PNXcfcTrL8njn5Nv41KXR7MdABN3ASpr/xHiGZFE2p
        udKoKXqbI5qbnl9pxDTRA1ZM8IJOfeA=
X-Google-Smtp-Source: AMsMyM6846gxhFUay6O2hAHELEIReuFZUAuTe+61N3WUm4IQQEdUea3FDWvB9TTRwLsKAZmmrkTMKg==
X-Received: by 2002:a05:6808:ecc:b0:353:2f37:5527 with SMTP id q12-20020a0568080ecc00b003532f375527mr15177180oiv.259.1667441347743;
        Wed, 02 Nov 2022 19:09:07 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id o37-20020a05687096a500b00131c3d4d38fsm6849327oaq.39.2022.11.02.19.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 19:09:07 -0700 (PDT)
Date:   Wed, 2 Nov 2022 19:09:06 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 0/6] bitmap: remove _reg_op()
Message-ID: <Y2MiwgtCbT3f4onw@yury-laptop>
References: <20221028014834.572819-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028014834.572819-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments guys?

On Thu, Oct 27, 2022 at 06:48:28PM -0700, Yury Norov wrote:
> _reg_op() duplicates functionality of other bitmap functions.
> This series removes it.
> 
> On top of this:
> https://lore.kernel.org/lkml/20221027043810.350460-1-yury.norov@gmail.com/
> 
> Yury Norov (6):
>   bitmap: add bitmap_empty_from()
>   bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
>   bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
>   bitmap: replace _reg_op(REG_OP_ISFREE) with bitmap_empty_from()
>   bitmap: fix opencoded bitmap_allocate_region()
>   bitmap: drop _reg_op()
> 
>  include/linux/bitmap.h | 11 ++++++
>  lib/bitmap.c           | 89 +++---------------------------------------
>  2 files changed, 17 insertions(+), 83 deletions(-)
> 
> -- 
> 2.34.1
