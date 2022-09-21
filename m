Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17FD5BFC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIUKos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIUKon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:44:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F0C1A39A;
        Wed, 21 Sep 2022 03:44:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc7so12809971ejb.0;
        Wed, 21 Sep 2022 03:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=w7PGwburogAz+tHaI9/Ru4EmAnC85TTzky0ZESiUE0w=;
        b=Lpcq+E1YhVeP1MqV3JpUJZERvU+wWHpYRa2MbIkg5jy9N4Om2K5Hewc68RgeFX+7Ma
         oBl2s0W4pfKYN/ipe1vafUPn+NEVKwwnGk1Gu5PYLNEFyerEt44A2pqlcQQpMNGbunQ7
         t8zBcei/9Y7gDKC560vbAkC2fBW2fVhDb859Y2LbcQloGkLv8e6jKCfjy28Z7rYu4oj/
         1bM6ZTDcQKwcOviZn3PqgpJAGvVfRJvwRWnldYTgWcbe9+osWe0k8fQNe04P/XJfacbz
         AlCEfOnXjkc7xRaxtmoYUetgJzGUQ5EZgA1vgUn9mvGRwYssZ9QO4qGwY8OWsOVCwDjA
         4qBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=w7PGwburogAz+tHaI9/Ru4EmAnC85TTzky0ZESiUE0w=;
        b=GQdVyjMuX+qXn00Vn+LvMV8BXmqIjk+FE7gKh7WqX6e6Y56CPc/8ad7us/LoWG+ff/
         3Ba3OduOmjM7pTvSZqm145LIF/KChkzzu8mZqrf6FcrzFSV6J52wzjtrvTRaJ93bQDne
         uVDx5OX9fGD0XxgsHGLyooALBBLvEWmBIz7o9JySpG7JI0nYEEwCtvO4HELjkRc+QEK6
         O4dfTh8FmuhiSfqVCtxMH5e/FS6uWd6CZCu1MV/w3vIG2jsUscTjddF3iQuPeZalphxW
         RK17QGMXF82qJA+35vLFuhL5yi6C9ennVg1NTjH7mGC8TaXFMjN28kuY9+yLwl3mDw5x
         mz9Q==
X-Gm-Message-State: ACrzQf1e9XnAL4EIaEPEZGnuYMrkEm08IQhM8PIopLgKm56w84n8XRsC
        1D09l4oxvGfLSKe4sJjHVTM=
X-Google-Smtp-Source: AMsMyM5CVTm4fuPMNeJiR110kEjHNzaklBpIGZlULXsVe9PwIEcKWLn2gtZ8j2hJcVcrPw3G0VotWw==
X-Received: by 2002:a17:907:7f02:b0:73d:dffa:57b3 with SMTP id qf2-20020a1709077f0200b0073ddffa57b3mr21316561ejc.19.1663757078052;
        Wed, 21 Sep 2022 03:44:38 -0700 (PDT)
Received: from gmail.com (1F2EF035.nat.pool.telekom.hu. [31.46.240.53])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906309000b0073d70df6e56sm1106402ejv.138.2022.09.21.03.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 03:44:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 21 Sep 2022 12:44:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>, x86@kernel.org
Subject: Re: [tip: perf/core] perf/core: Convert snprintf() to scnprintf()
Message-ID: <YyrrE8vpFSR+kdHQ@gmail.com>
References: <166374773592.401.16831946846027095231.tip-bot2@tip-bot2>
 <YyrMmyUPk+4t6OLm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyrMmyUPk+4t6OLm@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 21, 2022 at 08:08:55AM -0000, tip-bot2 for Jules Irenge wrote:
> > The following commit has been merged into the perf/core branch of tip:
> > 
> > Commit-ID:     678739d622ae7b75b62d550858b6bf104c43e2df
> > Gitweb:        https://git.kernel.org/tip/678739d622ae7b75b62d550858b6bf104c43e2df
> > Author:        Jules Irenge <jbi.octave@gmail.com>
> > AuthorDate:    Sun, 18 Sep 2022 00:41:08 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Wed, 21 Sep 2022 10:01:20 +02:00
> > 
> > perf/core: Convert snprintf() to scnprintf()
> > 
> > Coccinelle reports a warning:
> > 
> >     WARNING: use scnprintf or sprintf
> > 
> > Adding to that, there has also been some slow migration from snprintf to scnprintf.
> > 
> > This LWN article explains the rationale for this change:
> > 
> >     https: //lwn.net/Articles/69419/
> > 
> > No change in behavior.
> > 
> > [ mingo: Improved the changelog. ]
> 
> And yet, at this point I still have no clue what's wrong with
> snprintf(). So not much improvement :/

I've added this to the changelog:

    perf/core: Convert snprintf() to scnprintf()
    
    Coccinelle reports a warning:
    
        WARNING: use scnprintf or sprintf
    
    This LWN article explains the rationale for this change:
    
        https: //lwn.net/Articles/69419/
    
    Ie. snprintf() returns what *would* be the resulting length,
    while scnprintf() returns the actual length.
    
    Adding to that, there has also been some slow migration from snprintf to scnprintf,
    here's the shift in usage in the past 3.5 years, in all fs/ files:
    
                             v5.0    v6.0-rc6
       --------------------------------------
       snprintf() uses:        63         213
       scnprintf() uses:      374         186
    
    No intended change in behavior.

I also reviewed the usage sites - this patch could in fact be a bugfix as 
we are passing back these lengths to the VFS, which lengths are arguably 
bogus in the snprintf() case, should we ever get close to the buffer limits 
to trigger output truncation - which with PAGE_SIZE-1 is very unlikely.

[ Anyway, the shift in interface usage for FS code makes it pretty clear 
  that when in doubt we should use scnprintf() for FS code. snprintf() is 
  arguably actively dangerous whenever it works differently from sprintf() 
  ... ]

Thanks,

	Ingo
