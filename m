Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E1D637B66
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiKXO0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKXO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:26:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4390E9170
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:26:06 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so5923276pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAlmDlf3J91/9mijeaog5st0f/5MkIiZF834ldeIBx0=;
        b=Lk+Axj7fdQi0yyxjccdwBH5rucopDiUHwkMJPcAFD7s4QwYPhq5ajHq09DdObQ2Uog
         wvdaypvnpIdGzvnl6AsKAxzZmxCeUbtC7znyGNbYEg7RN9iV4EwXh+GZf8DL+r6JQppl
         0+RXV3gkAXLlDxn/fNq6t7tixQd2bpUcJi2Ylyv3d52VAUk/OwKMDjpNV+LVUuioP10j
         sHDbN3vrfGaj2NkLLJ9I/PYietus+u8+w/+awCtXgEMK0AXEQT4XtdXgL22zcbuXIykW
         7fBCiTHNDknLsSPFRhsyiqhQ6LbQ1dEABMZHZ/VvRWXQTm/LwZnZBOB9rY33q5Je01kz
         UuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAlmDlf3J91/9mijeaog5st0f/5MkIiZF834ldeIBx0=;
        b=RCzK6xdZ0q1RkMFxYOjgv+XYaDTUg6gFjUTX0On7ZyyeiXuXZa5O8xu7ruxiZj4xPr
         2KtuMzCrg6mWLKikU/Jbvs17MMFIjXH6KG+649NP+JZpZLQj4jFsZU2iVgotUEK2czCK
         PIEXbXhzz8W+edyNFsDt4FXV6GCVevm+26aqOKt0DtGcdXdUA05zdjBcmfYeBsKuKHIK
         zOHSZAa03CVECfeBSOBySFpUqIHoBwBZcI9lyvk5vBNIuIk0luBWyncTz+6WmAR4uZS3
         HnMQz59pLCoPjTcKBOqkDCWu+m/zo0HOZEhntylQXbwrAMqyHTKOtcZGkzEB1CyUkgeS
         NV9A==
X-Gm-Message-State: ANoB5pnkyFIHyFrh0ktw/nVIWN3yl7Z+4GMOq1bRbQUn5zZ04dg822RT
        dVGBgiMzoC2GTqasvK6mSb0=
X-Google-Smtp-Source: AA0mqf5GMN96W6w9aQMjgL4hm3VPATsFalHprJKWDdJ0RfZ4rKCtYx8AcAblrrg7VOpxiQKs3Ex0HA==
X-Received: by 2002:a17:902:e807:b0:186:fb90:5774 with SMTP id u7-20020a170902e80700b00186fb905774mr14542983plg.137.1669299966305;
        Thu, 24 Nov 2022 06:26:06 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id b26-20020aa78eda000000b0056da63c8515sm1319439pfr.91.2022.11.24.06.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 06:26:05 -0800 (PST)
Date:   Thu, 24 Nov 2022 23:25:54 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] mm, slub: don't create kmalloc-rcl caches with
 CONFIG_SLUB_TINY
Message-ID: <Y39+8mO5oT3K41si@hyeyoo>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-7-vbabka@suse.cz>
 <d77498f8-b15f-9dae-1803-2d2bbb99da50@suse.cz>
 <Y39wYPl5y3apKbD2@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y39wYPl5y3apKbD2@hyeyoo>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 10:23:51PM +0900, Hyeonggon Yoo wrote:
> > @@ -859,7 +865,7 @@ void __init setup_kmalloc_cache_index_table(void)
> >  static void __init
> >  new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
> >  {
> > -	if (type == KMALLOC_RECLAIM) {
> > +	if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {
> 
> for consistency this can be:
> 	if (IS_ENABLED(CONFIG_SLUB_TINY) && (type == KMALLOC_RECLAIM)) {
>

My finger slipped :)
I mean:
	if (!IS_ENABLED(CONFIG_SLUB_TINY) && (type == KMALLOC_RECLAIM)) {

-- 
Thanks,
Hyeonggon
