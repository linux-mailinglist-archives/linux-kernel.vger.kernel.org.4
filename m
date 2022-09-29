Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29685EF06E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiI2I2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiI2I2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:28:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466461162EC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:28:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s14so1013820wro.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=tKKWFXZii5QgbaLTyEujRe6CHc4wQgmQFi6wf2giT+8=;
        b=KnYUG4kPRTFFu8OzI6Hrw91OKgj5cyB9qkOZakZjah6ri3UWJEBuqAQLjSD9RqcXLW
         Sf1tkeA6beXxqhpDcY6NC4IhOTfegDjNBgCH3icDbgpezwJnmpY550mTVbDccSsrsVfy
         Vjd2bYl2ieTHop5yZgl2qAeCdWYeLtv+cS9dzrUVUbq6nIABAXZavG13GdtoealwXpln
         lTSNvaRLk3HIfWlThKbNfrYjhJLy0hDZL82pLBoTMsBetmC7YZjhESiWxzQw8It3MpNN
         xoSxL5H7FBIA62CaH/upGlJ3bsHGrF1staTzeDBmh/Y7pj7Ub9quWENwO6iJtK92SKMn
         bYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tKKWFXZii5QgbaLTyEujRe6CHc4wQgmQFi6wf2giT+8=;
        b=X3CSEOosYDNgfYRsVfmn223clbNp0svCeWu1MKul/YT8iMeDq2yOv1jPOF7Upk28RU
         Mn+CJCfjLiI9MrhzFSBYhwYgQDrJXCt88hTFZa3e4omqEeFzstmpZNiiIg6V54ronDws
         jU3QU6n/1PLA7ZH1aBvaVrNQs5XpjSNtM+9PyXEldSfNCjXKVXs8qyCpIpxeMvNzDlPQ
         c762lOtD8ZQHjpZUtAzMrNBvm8Fy7Df/PK3MmCx50TTwD56csNvoo/2WK7iebXrQd52d
         y4WOhYYhfKKFmrzxiOntOrTYzK51RCksNl9X4xfumJKAEv9Pv/XKov7e5ehaAbbYF4xh
         EedA==
X-Gm-Message-State: ACrzQf0FHYSXIebLZvHdu51B/p+6gvVeClNmFd5vsI0xIesPkzq33pRu
        /wMe1cdroRm5ZxghXJ5OGioVbunIHw==
X-Google-Smtp-Source: AMsMyM5yfPah1NB92S3pXTAH3L+8p8kIn26K+zETGFHadoeLv1KHzAVZHQbo9lkwWYrs2ZuaXwGvdg==
X-Received: by 2002:adf:cd86:0:b0:22c:c7ce:1e5e with SMTP id q6-20020adfcd86000000b0022cc7ce1e5emr1248352wrj.462.1664440086632;
        Thu, 29 Sep 2022 01:28:06 -0700 (PDT)
Received: from octinomon ([2a00:23c8:2f02:3b01:3ea1:40:8650:189])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05600c524a00b003b435c41103sm5544486wmb.0.2022.09.29.01.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 01:28:06 -0700 (PDT)
Date:   Thu, 29 Sep 2022 09:28:04 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     peterz@infradead.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: perf/core] perf/core: Convert snprintf() to scnprintf()
Message-ID: <YzVXFOFeGkl33Yjv@octinomon>
References: <166374773592.401.16831946846027095231.tip-bot2@tip-bot2>
 <YyrMmyUPk+4t6OLm@hirez.programming.kicks-ass.net>
 <YyrrE8vpFSR+kdHQ@gmail.com>
 <20220921125535.GF32411@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921125535.GF32411@twin.jikos.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 02:55:35PM +0200, David Sterba wrote:
> On Wed, Sep 21, 2022 at 12:44:35PM +0200, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Wed, Sep 21, 2022 at 08:08:55AM -0000, tip-bot2 for Jules Irenge wrote:
> > > > The following commit has been merged into the perf/core branch of tip:
> > > > 
> > > > Commit-ID:     678739d622ae7b75b62d550858b6bf104c43e2df
> > > > Gitweb:        https://git.kernel.org/tip/678739d622ae7b75b62d550858b6bf104c43e2df
> > > > Author:        Jules Irenge <jbi.octave@gmail.com>
> > > > AuthorDate:    Sun, 18 Sep 2022 00:41:08 +01:00
> > > > Committer:     Ingo Molnar <mingo@kernel.org>
> > > > CommitterDate: Wed, 21 Sep 2022 10:01:20 +02:00
> > > > 
> > > > perf/core: Convert snprintf() to scnprintf()
> > > > 
> > > > Coccinelle reports a warning:
> > > > 
> > > >     WARNING: use scnprintf or sprintf
> > > > 
> > > > Adding to that, there has also been some slow migration from snprintf to scnprintf.
> > > > 
> > > > This LWN article explains the rationale for this change:
> > > > 
> > > >     https: //lwn.net/Articles/69419/
> > > > 
> > > > No change in behavior.
> > > > 
> > > > [ mingo: Improved the changelog. ]
> > > 
> > > And yet, at this point I still have no clue what's wrong with
> > > snprintf(). So not much improvement :/
> > 
> > I've added this to the changelog:
> > 
> >     perf/core: Convert snprintf() to scnprintf()
> 
> I'm not sure if it would apply in this case as it's for a device
> attribute, but there's another helper sysfs_emit that does the safe
> print to string and one does not have to care which flavor of s*printf
> it is. We had patches in btrfs converting from snprintf to scnprintf and
> the latest one is sysfs_emit which is convenient to use but assumes the
> PAGE_SIZE of the buffer.

Yes, you are right. I can resend the patch with sysfs_emit() if

possible as the latest documentation on sysfs states that 

show() device function should only use sysfs_emit() or sysfs_emit_at() 
when formatting the value to be returned to user space.

* https://www.kernel.org/doc/html/latest/filesystems/sysfs.html

I don't know whether it may apply to this subsystem.  I have to read
more about it and test

thanks
jules
