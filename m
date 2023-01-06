Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D323066095B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjAFWNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjAFWNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:13:11 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DF93C722;
        Fri,  6 Jan 2023 14:13:09 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x25-20020a056830115900b00670932eff32so1723735otq.3;
        Fri, 06 Jan 2023 14:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zt25DSSJ5LZB5esFjPUfExa1MxSxTJOriaCIxpyCcss=;
        b=ivUXcWRR/PjWwyAkjJ1xff06xQgIzuhs0MLcP4F7xXzSVLN164QhI8tNDZNBtignf0
         LhanZgoSya8c+vWxN6s9Cmmn4yP6/yT+4Ji1htpM75YjAHy7QGhW//WWJzMcrtZKwnS9
         ukJeBfFzdxqdgAmNCEcCItzWTz5ZEgBfTVTJDlI7d1cmsgMSg/IFNVKXVOFYUEkWyy6X
         0EVJ42Tn3M2DlWEwArjWyupbibDjwdW7hxdvcN7YOWPrpe33NbW46KWd+uTSZExQHzxW
         rQJXBXJsI10w+dbEypZcjOEInmOQbTEbxNM1ccZ7g88wKTrp1h0JVJnOOZepPK+l7mmd
         pSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zt25DSSJ5LZB5esFjPUfExa1MxSxTJOriaCIxpyCcss=;
        b=hAJ6iwIlpVblH7jXXMgSGTg4u9Q23UalE0XoG0nMDGfLcnEDrh5p0Sj5xYOaNZVju0
         snD9wC23vC4iK6+YVEjAkkPL8TfUZmDv5O/0+ScNFu62dtMGyPT4q8DRYBEqfAoSaPIP
         zxZEO935ZkObNmK8TmzRLXdcJUoX3CFQN3Suaus5NRsqmBvF5RBD6Km2XJGa69eanreM
         RkuPtg+eBFfiFft9nJWIt3bTBKBtb7F1NcaQL2KdCrP1VWtRLiw44sz178GLO25bt/iD
         qANiVoKUc6TsubXAX9DZOT5I1S6KROC6awOOrB1EfUE41Cia2d0GfA+i7QgTPMHdFc1N
         kg2w==
X-Gm-Message-State: AFqh2koLnKZOV/bm5iLWtrNO3Upz0kPKALQY/Hagg3ARQOHrpJa/RGZO
        QG3muoboo/XVE36B8EX7d7B6eTAhrPxivrzCCcWnoKnR
X-Google-Smtp-Source: AMrXdXtJ2AS9Dt4EonoV0/kPCOIcFVGE0SnlNI3venILO5f7F1b/zgKCqn/6nMpVivFGwZb71yu07FVEOUiTNX2gnmM=
X-Received: by 2002:a05:6830:4128:b0:670:88af:2a01 with SMTP id
 w40-20020a056830412800b0067088af2a01mr3768757ott.116.1673043188927; Fri, 06
 Jan 2023 14:13:08 -0800 (PST)
MIME-Version: 1.0
References: <20221230063528.41037-1-zh.nvgt@gmail.com> <2711de96-fcbe-5611-657a-ab29becd2ff6@gmx.de>
 <CAKMK7uEOX5n64cjzMt9GRQaS13HFPFyOeqdrkmzc035U5_T8tg@mail.gmail.com>
 <CAKMK7uE7CAXO50JPQ6ziQGGehqfDK2UanBQbfLdUH2RwrwXUvw@mail.gmail.com>
 <CAO2zrtYDcOfvxpG6wPghPnWZVks+NL6N9VaynsBVoX7nHBcxuw@mail.gmail.com>
 <Y7hvhtHeivfsnBtE@phenom.ffwll.local> <CAO2zrtb9H=OWPbrgmqTxQnHqETt-P4K6AxiwdtN7guxUYL2NCw@mail.gmail.com>
 <Y7h++5sU/hGJ/yTS@phenom.ffwll.local> <CAO2zrtaB3GZRSzgWu2kV_jTojwuhtL_kFz0gpzPPVGe9D8kVbQ@mail.gmail.com>
 <Y7iQckF/6EMYVpQt@phenom.ffwll.local>
In-Reply-To: <Y7iQckF/6EMYVpQt@phenom.ffwll.local>
From:   Hang Zhang <zh.nvgt@gmail.com>
Date:   Fri, 6 Jan 2023 17:12:57 -0500
Message-ID: <CAO2zrtY+mMBTLimW6aZhOGFqqw53EVdP0CT8ieW6iVUXevZ7ag@mail.gmail.com>
Subject: Re: [PATCH] fbmem: prevent potential use-after-free issues with console_lock()
To:     Hang Zhang <zh.nvgt@gmail.com>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 4:19 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Jan 06, 2023 at 03:25:14PM -0500, Hang Zhang wrote:
> > On Fri, Jan 6, 2023 at 3:05 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Fri, Jan 06, 2023 at 02:58:27PM -0500, Hang Zhang wrote:
> > > > On Fri, Jan 6, 2023 at 1:59 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > BTW, if this is worthed a fix and the performance of console_lock() is a
> > > > major concern, then I think there may be alternative solutions like adding
> > > > a lock_fb_info() to the free call chain - if that's better in performance,
> > > > or maybe selectively protect the matroxfb ioctl but not vblank ioctl as you
> > > > mentioned.
> > >
> > > Please start out with explaining what kind of bug your checker is seeing,
> > > and why. Not how you're trying to fix it. Because I'm pretty sure there
> > > isn't a bug, but since I've already spent a pile of time looking at this,
> > > I want to make sure.
> >
> > We are sorry for the inconvenience caused, we'll follow these practices and
> > guidelines in the future. Thank you!
>
> Once more: Please explain what you're static checker is seeing. I want to
> understanding this, and I'm hoping at least someone involved in this
> static checker can explain what it thinks is going on.
>
> Thanks, Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

Thank you for your interest, Daniel. The checker tries first to find
the free and
use sites of a certain object (in this case "fb_info"), then reason
about whether
the use can actually happen after the free (e.g., taking into account
factors like
state set/check, locks, etc.), if so, it will flag a potential
use-after-free. As a static
checker, is doesn't execute a program or generate a PoC. We then manually
review each flagged issue by inspecting all related code. In this
case, the checker
(and us) are unaware of the lifetime management logic, which may cause
problems.

Best,
Hang
