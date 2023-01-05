Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB7965E902
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjAEK3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjAEK2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:28:11 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAA05B86C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:23:38 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n4so38935680plp.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QW8mExk2Nc3xqwsCWhcXGMVs98kEZwkVDbL0tRWyTY8=;
        b=PJrJAYnb90s7w4gDAt1RZ4zaUBBcOCgFck+92/xYf73O/WsoTY1Cm0LXbCmQi5K5fk
         oH35M46D5q37UGuC9LJpSotKeUkdIk2j37oQ1BfIpGOqb6jjvoVeWHGgXy/W/F1fZIE2
         GxJHAu/llSd6RYIYwS/A0YhiSVxn59qrgsfTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QW8mExk2Nc3xqwsCWhcXGMVs98kEZwkVDbL0tRWyTY8=;
        b=mEHzFy/w0xlfC4ksOGJTFE3oQ88A1BGhhVSofyWI8Sy8drpDmYjg4LpN/v9w5gKJH9
         ZNKH0pc2jUSYySD5n6w8gHZhl89DsExEKBIX40OOVjmqhJr5NaDi+VLIGN0+UNrN5HAO
         JPoVhC1HagpNShmqp2NT/dbO053hyAJ98Cs66H6aDpUj2weCxAzEI9p+0edd6txUzDZO
         kmFVoMtKF0jW2dr3dT/rdyjev5QNzSSxNNHtvedrcOYPu3XjFj/8SCD86s76iz7tjNxN
         7s1M647N5uAXQ/QDzmB3RLfFXEG1f6+voxpSwD+BebiSDB2bJnuBEw5GDG1SSII5l2jN
         q0eQ==
X-Gm-Message-State: AFqh2kom9gXOR6oSRuqWw6pmDh2wYlMuyxWcLiP3DH/wuUZq5cevxH3D
        YpdvjCEbA259D/R2yt6/1Xj2XsyUHKzhiUQl+y96Og==
X-Google-Smtp-Source: AMrXdXt2H+AtWOYKmaNsNlvhTfXsGkSKph/Ah0bsT/z+2hIax16T17+aU+L31MdtLvGjCg8XOYiEbyN1LRTMZHVfLF8=
X-Received: by 2002:a17:902:7884:b0:192:bf3c:b85e with SMTP id
 q4-20020a170902788400b00192bf3cb85emr1050467pll.68.1672914184720; Thu, 05 Jan
 2023 02:23:04 -0800 (PST)
MIME-Version: 1.0
References: <Y7aGw/irynC61O85@ls3530>
In-Reply-To: <Y7aGw/irynC61O85@ls3530>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 5 Jan 2023 11:22:53 +0100
Message-ID: <CAKMK7uEnFBo_YfU8OTvMS8+YkoGS=vmpGQPMa9PKxGOB3pd7nA@mail.gmail.com>
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

On Thu, 5 Jan 2023 at 09:14, Helge Deller <deller@gmx.de> wrote:
>
> Hi Linus,
>
> please pull the fbdev driver updates for 6.2-rc3, to receive
> fixes for matroxfb, offb, omapfb and fbmem.
>
> Thanks,
> Helge
>
> ----
>
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
>
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
>
> are available in the Git repository at:
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.2-rc3
>
> for you to fetch changes up to 764043cccd7232a783753a612d628fc0cb7854be:
>
>   fbdev: omapfb: avoid stack overflow warning (2023-01-04 19:09:40 +0100)
>
> ----------------------------------------------------------------
> fbdev updates for kernel 6.2-rc3:
>
> - Fix Matrox G200eW initialization failure
> - Fix build failure of offb driver when built as module
> - Optimize stack usage in omapfb
> - Prevent use-after-free in fbmem
>
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       fbdev: omapfb: avoid stack overflow warning
>
> Hang Zhang (1):
>       fbdev: fbmem: prevent potential use-after-free issues with console_lock()

I looked at this, and even by fbdev locking standards this makes
absolutely no sense to me. I think this should be dropped before we've
reached some sort of conclusion on what is going on, or whether this
is just pure static checker conjecture without fully understanding how
this is supposed to work really.
-Daniel

> Paul Menzel (1):
>       fbdev: matroxfb: G200eW: Increase max memory from 1 MB to 16 MB
>
> Randy Dunlap (1):
>       fbdev: make offb driver tristate
>
> Xu Panda (2):
>       fbdev: omapfb: use strscpy() to instead of strncpy()
>       fbdev: atyfb: use strscpy() to instead of strncpy()
>
>  drivers/video/fbdev/Kconfig                |  4 ++--
>  drivers/video/fbdev/aty/atyfb_base.c       |  3 +--
>  drivers/video/fbdev/core/fbmem.c           |  2 ++
>  drivers/video/fbdev/matrox/matroxfb_base.c |  4 ++--
>  drivers/video/fbdev/omap/omapfb_main.c     |  5 ++---
>  drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 28 ++++++++++++++++++----------
>  6 files changed, 27 insertions(+), 19 deletions(-)



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
