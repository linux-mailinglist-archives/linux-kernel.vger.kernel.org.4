Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C975660843
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjAFUZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjAFUZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:25:27 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100FA1A21C;
        Fri,  6 Jan 2023 12:25:26 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1441d7d40c6so2777951fac.8;
        Fri, 06 Jan 2023 12:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H+yKMp8qRXD8qniJI3EIyRBPojM5S1J8XZ0bEu2JnS4=;
        b=SNAmU0+fJ+kOE+XjlLzpjZjN3tvkY1r6CxRprGDjF/9RGDo9WnBV0VQtgB75VOqd+A
         16GlMRvQH7Zz/+AsanEr4pFsOFmN4KkqlkdQ4xWC3PWoeXk1tFxAY8CXhOmUBApH1/Ly
         GOtPlNR2Tp0PucDijoW6Xh0veWZwKOoB4VvnUvgO9sHWzsKjISNynwo9mVmbPxqBX+y+
         Ik3XUl2EGiWnN39HxIFEhJZn2djmhC9hz1SMHHWxgsdDgk08rtDzgixxeSjROhPA09FM
         oqSN9ZInJHGWoK6rRQlnXhWsd4lhu0srCZ4RUTbv4qVqIMPmBwU0cI7u8IRtD2T+9LQP
         1l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+yKMp8qRXD8qniJI3EIyRBPojM5S1J8XZ0bEu2JnS4=;
        b=Db10h+I1H2JF0E8Gfgs4ZRBX45bOQvD6Ti1x+x/6kmiJXDUkbWRkmT7qoj00PPitNx
         thDh4HTke2MbYUThfAaVUybGhw3/r1S7a1lO71zOieeZ3h1WrKOHbZLAX9XX0itBHfMW
         7ltsnrwZymk84kbaueD+QEAna3fdkTCNl+kzFZKqgbi02/MQ/ErEkhsXIhT8dS5VIzRs
         W/t78+hKb1fNdGsjIC69NFkG4hTjbNJeCoCxaTi3XBjwrGQsNRjZTdhqJqF3BblLIE7O
         PeOhwi2pq+zCdN2jdfK2rwj9sdAiTpiNg6meX758wFx1VKCFM7jETK7O3SpYCGRNmQmC
         FBWg==
X-Gm-Message-State: AFqh2krHuhzwVT/hYJ+nBlXRPGxN+fahht9wXvtcH9uNEJj7b14Kv4gX
        wCE0eZhCft25172Ahk8pJsIW/LDkMTCEtp8Gv68=
X-Google-Smtp-Source: AMrXdXuPtclyAy+egQq8lOew28En6mCt7G/BGkoi3hZ1n95v7aWrEfYh3ip+ly8YFaZrwHl0m5UAeqz0DSxo/pIr6x0=
X-Received: by 2002:a05:6870:fd92:b0:144:bf16:f436 with SMTP id
 ma18-20020a056870fd9200b00144bf16f436mr3055185oab.199.1673036725262; Fri, 06
 Jan 2023 12:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20221230063528.41037-1-zh.nvgt@gmail.com> <2711de96-fcbe-5611-657a-ab29becd2ff6@gmx.de>
 <CAKMK7uEOX5n64cjzMt9GRQaS13HFPFyOeqdrkmzc035U5_T8tg@mail.gmail.com>
 <CAKMK7uE7CAXO50JPQ6ziQGGehqfDK2UanBQbfLdUH2RwrwXUvw@mail.gmail.com>
 <CAO2zrtYDcOfvxpG6wPghPnWZVks+NL6N9VaynsBVoX7nHBcxuw@mail.gmail.com>
 <Y7hvhtHeivfsnBtE@phenom.ffwll.local> <CAO2zrtb9H=OWPbrgmqTxQnHqETt-P4K6AxiwdtN7guxUYL2NCw@mail.gmail.com>
 <Y7h++5sU/hGJ/yTS@phenom.ffwll.local>
In-Reply-To: <Y7h++5sU/hGJ/yTS@phenom.ffwll.local>
From:   Hang Zhang <zh.nvgt@gmail.com>
Date:   Fri, 6 Jan 2023 15:25:14 -0500
Message-ID: <CAO2zrtaB3GZRSzgWu2kV_jTojwuhtL_kFz0gpzPPVGe9D8kVbQ@mail.gmail.com>
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

On Fri, Jan 6, 2023 at 3:05 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Jan 06, 2023 at 02:58:27PM -0500, Hang Zhang wrote:
> > On Fri, Jan 6, 2023 at 1:59 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Thu, Jan 05, 2023 at 01:38:54PM -0500, Hang Zhang wrote:
> > > > On Thu, Jan 5, 2023 at 5:25 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > >
> > > > > On Thu, 5 Jan 2023 at 11:21, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > >
> > > > > > Hi Helge
> > > > > >
> > > > > > On Mon, 2 Jan 2023 at 16:28, Helge Deller <deller@gmx.de> wrote:
> > > > > > >
> > > > > > > On 12/30/22 07:35, Hang Zhang wrote:
> > > > > > > > In do_fb_ioctl(), user specified "fb_info" can be freed in the callee
> > > > > > > > fbcon_get_con2fb_map_ioctl() -> set_con2fb_map() ->
> > > > > > > > con2fb_release_oldinfo(), this free operation is protected by
> > > > > > > > console_lock() in fbcon_set_con2fb_map_ioctl(), it also results in
> > > > > > > > the change of certain states such as "minfo->dead" in matroxfb_remove(),
> > > > > > > > so that it can be checked to avoid use-after-free before the use sites
> > > > > > > > (e.g., the check at the beginning of matroxfb_ioctl()). However,
> > > > > > > > the problem is that the use site is not protected by the same locks
> > > > > > > > as for the free operation, e.g., "default" case in do_fb_ioctl()
> > > > > > > > can lead to "matroxfb_ioctl()" but it's not protected by console_lock(),
> > > > > > > > which can invalidate the aforementioned state set and check in a
> > > > > > > > concurrent setting.
> > > > > > > >
> > > > > > > > Prevent the potential use-after-free issues by protecting the "default"
> > > > > > > > case in do_fb_ioctl() with console_lock(), similarly as for many other
> > > > > > > > cases like "case FBIOBLANK" and "case FBIOPAN_DISPLAY".
> > > > > > > >
> > > > > > > > Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> > > > > > >
> > > > > > > applied to fbdev git tree.
> > > > > >
> > > > > > The patch above makes no sense at all to me:
> > > > > >
> > > > > > - fb_info is protected by lock_fb_info and
> > > > > > - the lifetime of fb_info is protected by the get/put functions
> > > > > > - yes there's the interaction with con2fb, which is protected by
> > > > > > console_lock, but the lifetime guarantees are ensured by the device
> > > > > > removal
> > > > > > - which means any stuff happening in matroxfb_remove is also not a
> > > > > > concern here (unless matroxfb completely gets all the device lifetime
> > > > > > stuff wrong, but it doesn't look like it's any worse than any of the
> > > > > > other fbdev drivers that we haven't recently fixed up due to the
> > > > > > takeover issues with firmware drivers
> > > > >
> > > > > I have also a really hard timing finding the con2fb map use in the
> > > > > matroxfb ioctl code, but that just might be that I didn't look
> > > > > carefully enough. Maybe that would shed some light on this.
> > > > > -Daniel
> > > > >
> > > > >
> > > > > >
> > > > > > On the very clear downside this now means we take console_lock for the
> > > > > > vblank ioctl (which is a device driver extension for reasons, despite
> > > > > > that it's a standard fbdev ioctl), which is no good at all given how
> > > > > > console_lock() is a really expensive lock.
> > > > > >
> > > > > > Unless I'm massively missing something, can you pls push the revert
> > > > > > before this lands in Linus' tree?
> > > > > >
> > > > > > Thanks, Daniel
> > > >
> > > > Hi, Daniel. Thank you for your feedback. We're not developers of the
> > > > video subsystem and thus may be short in domain knowledge (e.g., the
> > > > performance of console_lock() and the complex lifetime management).
> > > > This patch initially intended to bring up the potential use-after-free
> > > > issues here to the community - we have performed a best-effort code
> > > > review and cannot exclude the possibility based on our understanding.
> > > >
> > > > What we have observed is that the call chain leading to the free site
> > > > (do_fb_ioctl()->fbcon_set_con2fb_map_ioctl()->set_con2fb_map()->
> > > > con2fb_release_oldinfo()-> ... ->matroxfb_remove()) is only protected
> > > > by console_lock() but not lock_fb_info(), while the potential use
> > > > site (call chain starts from the default case in do_fb_ioctl()) is
> > > > only protected by lock_fb_info() but not console_lock().
> > > > We thus propose to add this extra console_lock() to the default case,
> > > > which is inspired by the lock protection of many other existing
> > > > switch-case terms in the same function.
> > > >
> > > > Since we do not have deep domain knowledge of this subsystem, we will
> > > > rely on the developers to make a decision regarding the patch. Thank
> > > > you again for your review and help!
> > >
> > > Can you please elaborate where you've found this use-after-free and how?
> > > I'm still not understanding how you even got here - this is orthogonal to
> > > whether the patch is the right fix or not.
> > > -Daniel
> >
> > Hi, Daniel. Sure. This issue was initially flagged by our experimental static
> > code analyzer aiming to find use-after-free issues in the kernel - that's why
> > we don't have PoC or execution traces here. We deeply understand that
> > static analyzer can generate false alarms, so we have tried our best and
> > spent a good amount of time carefully reviewing the related code. We
> > eventually found that we could not exclude this potential issue based on our
> > study, so we decided to report this to the community with this tentative fix. As
> > mentioned, we may be short in domain knowledge, so your input is
> > highly appreciated. We respect the developer's decision about whether
> > this is really a problem and whether/how to fix it. However, if you think the
> > use-after-free is actually not possible, it will be very helpful if you can
> > elaborate on the reasoning since it will greatly help us improve our
> > analyzer. Thank you very much for your help!
>
> Please start out these patches with the fact that this is from an
> experimental checker.
>
> Also do include _why_ your checker things something is going wrong. If you
> cannot follow why the checker complains about something, then don't report
> it as an issue until you do. Also, if you do not understand the code,
> please make it absolutely clear that you just guessed a possible fix, but
> not that it's been tested in any way or form.
>
> If you don't do this, then we end up wasting a ton of time of people who
> don't have surplus time, because in this case the patch got review,
> applied, pull request made, I realized it looks funny, patch dropped, pull
> request remade, and then a fairly big thread here.
>
> All for a bug that's likely in your checker and not in the kernel. This is
> not great.
>
> > BTW, if this is worthed a fix and the performance of console_lock() is a
> > major concern, then I think there may be alternative solutions like adding
> > a lock_fb_info() to the free call chain - if that's better in performance,
> > or maybe selectively protect the matroxfb ioctl but not vblank ioctl as you
> > mentioned.
>
> Please start out with explaining what kind of bug your checker is seeing,
> and why. Not how you're trying to fix it. Because I'm pretty sure there
> isn't a bug, but since I've already spent a pile of time looking at this,
> I want to make sure.
>
> Cheers, Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

We are sorry for the inconvenience caused, we'll follow these practices and
guidelines in the future. Thank you!
