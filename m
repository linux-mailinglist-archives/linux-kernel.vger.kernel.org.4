Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8957D65E928
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjAEKlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjAEKkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:40:40 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9CA50E76
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:39:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so1617674pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2lIH75JPp0HO79B17hSan6J0r/4agwXblyvknowG4AU=;
        b=heY3FrxSZswFxVIeQb2FO3fzRPQ/mMrv+iPYV5wYl5iHp6Yv4ToVPrLR8g1GM9HsaO
         uXpy60Ya+K3J4OSoTDMDcichnWE/ppR6+NLfpODrr6CP9ehvpjSMsyFZdWQD0Xbs93YW
         ckODKMWxd2D/Qi03KvC6Mv4jK7ohEVDOddWpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lIH75JPp0HO79B17hSan6J0r/4agwXblyvknowG4AU=;
        b=KIjY/FeMeQtdIdIWQfFTRLkTIhne4Se+kBwFCo62/fbhPTJF0gQxb4NHpRM09ba5NP
         FF6QWXERWatczqQxAiCOlpeF2p9CUciV4/Atqw9FgdzqvXInW2YDqxMvyqrt+hvYotmp
         rzt1p/Fql4JK1XCHfJ+HXcHhelRKI2k4kftBGswfgY4wmNr2UADzkpMO4Bom5sos2MLv
         6Bq9bqEKigp/XnMfm7btTy/onkvRc61pOGz6fV8U6Gf/GhuyVmhoRe1LQLCdkiHp8Xov
         YaeL5aGdpyGZ6RNeWasprZhk1nQYJTBl1Qhh0jzB4RjJAyILzuOZKg5d5q7pzwGl31dD
         kgNg==
X-Gm-Message-State: AFqh2kpXFtCfwC/Zk6tiADWxLkWHJP4vCQ3OLWVs9hqvra9k5o6BFbCc
        4Z25+8j5CuDjdqOIyFl5yWvGyGbGnqVNYfqTe94fYg==
X-Google-Smtp-Source: AMrXdXug3Rv8MtWdCbuqoeAFsFZ4JzB428LPyU99P0UT4Pupd9+ETqirDhbIJL1dNfPKpTdH8fAcEMMGdHMTLN8LkJE=
X-Received: by 2002:a17:902:b902:b0:190:e27b:b554 with SMTP id
 bf2-20020a170902b90200b00190e27bb554mr3098677plb.148.1672915161012; Thu, 05
 Jan 2023 02:39:21 -0800 (PST)
MIME-Version: 1.0
References: <Y7aGw/irynC61O85@ls3530> <CAKMK7uEnFBo_YfU8OTvMS8+YkoGS=vmpGQPMa9PKxGOB3pd7nA@mail.gmail.com>
 <ed7a65bb-f521-e5a5-85eb-0f24b023421b@gmx.de>
In-Reply-To: <ed7a65bb-f521-e5a5-85eb-0f24b023421b@gmx.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 5 Jan 2023 11:39:09 +0100
Message-ID: <CAKMK7uFXTsCrbn3JhnjgG-WfEZcdUELuCk98=4PEGF4VS0N+gQ@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev fixes for v6.2-rc3
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2023 at 11:31, Helge Deller <deller@gmx.de> wrote:
>
> On 1/5/23 11:22, Daniel Vetter wrote:
> > On Thu, 5 Jan 2023 at 09:14, Helge Deller <deller@gmx.de> wrote:
> >>
> >> Hi Linus,
> >>
> >> please pull the fbdev driver updates for 6.2-rc3, to receive
> >> fixes for matroxfb, offb, omapfb and fbmem.
> >>
> >> Thanks,
> >> Helge
> >>
> >> ----
> >>
> >> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> >>
> >>    Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> >>
> >> are available in the Git repository at:
> >>
> >>    http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.2-rc3
> >>
> >> for you to fetch changes up to 764043cccd7232a783753a612d628fc0cb7854be:
> >>
> >>    fbdev: omapfb: avoid stack overflow warning (2023-01-04 19:09:40 +0100)
> >>
> >> ----------------------------------------------------------------
> >> fbdev updates for kernel 6.2-rc3:
> >>
> >> - Fix Matrox G200eW initialization failure
> >> - Fix build failure of offb driver when built as module
> >> - Optimize stack usage in omapfb
> >> - Prevent use-after-free in fbmem
> >>
> >> ----------------------------------------------------------------
> >> Arnd Bergmann (1):
> >>        fbdev: omapfb: avoid stack overflow warning
> >>
> >> Hang Zhang (1):
> >>        fbdev: fbmem: prevent potential use-after-free issues with console_lock()
> >
> > I looked at this, and even by fbdev locking standards this makes
> > absolutely no sense to me. I think this should be dropped before we've
> > reached some sort of conclusion on what is going on, or whether this
> > is just pure static checker conjecture without fully understanding how
> > this is supposed to work really.
> > -Daniel
>
> Sure.
>
> I'll send a new pull request where this patch is dropped.

Thanks a lot!
-Daniel

>
> Thanks!
> Helge
>
>
> >
> >> Paul Menzel (1):
> >>        fbdev: matroxfb: G200eW: Increase max memory from 1 MB to 16 MB
> >>
> >> Randy Dunlap (1):
> >>        fbdev: make offb driver tristate
> >>
> >> Xu Panda (2):
> >>        fbdev: omapfb: use strscpy() to instead of strncpy()
> >>        fbdev: atyfb: use strscpy() to instead of strncpy()
> >>
> >>   drivers/video/fbdev/Kconfig                |  4 ++--
> >>   drivers/video/fbdev/aty/atyfb_base.c       |  3 +--
> >>   drivers/video/fbdev/core/fbmem.c           |  2 ++
> >>   drivers/video/fbdev/matrox/matroxfb_base.c |  4 ++--
> >>   drivers/video/fbdev/omap/omapfb_main.c     |  5 ++---
> >>   drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 28 ++++++++++++++++++----------
> >>   6 files changed, 27 insertions(+), 19 deletions(-)
> >
> >
> >
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
