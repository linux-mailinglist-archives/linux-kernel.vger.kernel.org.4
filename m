Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C33666232F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbjAIK1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjAIK0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:26:36 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA410C6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:26:35 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso12348965pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa0LOobEUkWWUY8RhKywphIXv2oIbVVC/OzD6QfEsQE=;
        b=Z7pTduGlCGBHVVcxuh1G+qFZ8V8F8RDij6up/fHEYFYwjw4jsAAU8hPA3DcGW7EMTs
         PwZr27y+BmAO3nffL3xhtMzHL16VVDZ0hutyCRrHwCNnTCwdBEps5pvb539TpQGwW2sC
         8pCMuHZffO7HH1BT27aKv3spiDWKqiXyneSiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aa0LOobEUkWWUY8RhKywphIXv2oIbVVC/OzD6QfEsQE=;
        b=qBE/ied0C9re1c4urzNMOJAbnidRGAAWf6toUpcoWdt6CvCyAM3Yu/TdswO8905w/e
         ax3uPW+Y4A4rCpKJ9P6FJMgv7K08qGFkSAjY9q6EF3EjQXv8Dq/IYQS5pEmQW/A5l+K/
         ifmtzIxQq3XetnZtvMwEcJUJ/bqqD7G5BODqGSM2GnjdNguftdIGl86jibJowdN5eFYf
         BjDIzwexZMdvF6Uig3PS39mHqdF/e4aDCAsCCFKwIjmgkMS4g5u+YG8lRfHQPhs5s1em
         M4OSahqs+OCZlXUUTUSgmXRyFeIoWm4fWAssPruM56x7sDfMhkGodqNB9KAPOCNZ1YEs
         HPsQ==
X-Gm-Message-State: AFqh2kpMq4vBU0OB+Z8B+ZlKrRmbe0Vc6HETXnJYEnneGboIZzepHuqv
        SQYeBp7FUdYHNKZgmrx7yLLdbgITvQ/ykvANltdVHw==
X-Google-Smtp-Source: AMrXdXvqVha9HvD+ZV3UPEcDTnV12qpjFigiVnDNRTduYEkbP3gT+f48li1UxGcNeTw/+cJfUhEiW2+eicsfZv55/Lk=
X-Received: by 2002:a17:902:7884:b0:192:bf3c:b85e with SMTP id
 q4-20020a170902788400b00192bf3cb85emr2011150pll.68.1673259995334; Mon, 09 Jan
 2023 02:26:35 -0800 (PST)
MIME-Version: 1.0
References: <Y7aGw/irynC61O85@ls3530> <CAKMK7uEnFBo_YfU8OTvMS8+YkoGS=vmpGQPMa9PKxGOB3pd7nA@mail.gmail.com>
In-Reply-To: <CAKMK7uEnFBo_YfU8OTvMS8+YkoGS=vmpGQPMa9PKxGOB3pd7nA@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 9 Jan 2023 11:26:23 +0100
Message-ID: <CAKMK7uFijjF+px9=xDXnyfhMbkxRqinEmV_N5VX6eAuJkc1J+g@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev fixes for v6.2-rc3
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2023 at 11:22, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, 5 Jan 2023 at 09:14, Helge Deller <deller@gmx.de> wrote:
> >
> > Hi Linus,
> >
> > please pull the fbdev driver updates for 6.2-rc3, to receive
> > fixes for matroxfb, offb, omapfb and fbmem.
> >
> > Thanks,
> > Helge
> >
> > ----
> >
> > The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> >
> >   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> >
> > are available in the Git repository at:
> >
> >   http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.2-rc3
> >
> > for you to fetch changes up to 764043cccd7232a783753a612d628fc0cb7854be:
> >
> >   fbdev: omapfb: avoid stack overflow warning (2023-01-04 19:09:40 +0100)
> >
> > ----------------------------------------------------------------
> > fbdev updates for kernel 6.2-rc3:
> >
> > - Fix Matrox G200eW initialization failure
> > - Fix build failure of offb driver when built as module
> > - Optimize stack usage in omapfb
> > - Prevent use-after-free in fbmem
> >
> > ----------------------------------------------------------------
> > Arnd Bergmann (1):
> >       fbdev: omapfb: avoid stack overflow warning
> >
> > Hang Zhang (1):
> >       fbdev: fbmem: prevent potential use-after-free issues with console_lock()
>
> I looked at this, and even by fbdev locking standards this makes
> absolutely no sense to me. I think this should be dropped before we've
> reached some sort of conclusion on what is going on, or whether this
> is just pure static checker conjecture without fully understanding how
> this is supposed to work really.

Just to close this: Turned out to be some kind of static checker dud
(and unfortunately the commit message didn't even explain that it was
found through some undisclosed static checker, I asked the submitter
to rectify this going forward since they'll likely submit more stuff
like this).
-Daniel

> > Paul Menzel (1):
> >       fbdev: matroxfb: G200eW: Increase max memory from 1 MB to 16 MB
> >
> > Randy Dunlap (1):
> >       fbdev: make offb driver tristate
> >
> > Xu Panda (2):
> >       fbdev: omapfb: use strscpy() to instead of strncpy()
> >       fbdev: atyfb: use strscpy() to instead of strncpy()
> >
> >  drivers/video/fbdev/Kconfig                |  4 ++--
> >  drivers/video/fbdev/aty/atyfb_base.c       |  3 +--
> >  drivers/video/fbdev/core/fbmem.c           |  2 ++
> >  drivers/video/fbdev/matrox/matroxfb_base.c |  4 ++--
> >  drivers/video/fbdev/omap/omapfb_main.c     |  5 ++---
> >  drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 28 ++++++++++++++++++----------
> >  6 files changed, 27 insertions(+), 19 deletions(-)
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
