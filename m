Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3309B660780
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbjAFT6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjAFT6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:58:41 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C94A77AD7;
        Fri,  6 Jan 2023 11:58:39 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id c133so1950849oif.1;
        Fri, 06 Jan 2023 11:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=43NGCXT/H0n1aRVH9SXEFAWkSQcjel85u1UCejcZUzE=;
        b=Yp21phty91QCImy9nuXutKu7L91irr6aoHlIyDJ2wxxzCHnnf96taSlOAVqW+7IeU/
         DyW0aQC0VGGXXHcNtbq8SQSnt/KX8tTnaLblk/euoek1dlqcT3sLGPAw3WxeYrC8OhG2
         56ngG5GNNJ101pK8F7uVt/dJyz5HxIuYsCcB5hqGf8qiahcbNBrpLG4Tvcw1woK+PQGh
         2Up0+NmB6LoBE8GUXpQmk2iUoO9iUic7QvEn7nCFjvj/ysSCkaWuJaba+mRRsR19eWPH
         CZsS9FZK/B2yY3tHSvJmp+CfkkZSrmEzxQWAeYha9+dYBYUZ0JQX1hmCy2CpzrMByRvV
         En6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43NGCXT/H0n1aRVH9SXEFAWkSQcjel85u1UCejcZUzE=;
        b=2cfOAv3Udq20hxm+YbDD3+r/M44kIYFrowYxviD7ROMraspz+5jz71USHay24pYRUS
         xHA2IEK+CSO7y6jeA3M6Jw7rRXoVYuhsbU4HoA0vTvhZISET7lG6a/9mMmBvYoHfY4Fl
         6F6RFcNjm/iaGezgr5uUmpAv/lCZQWNfmece1pjIuo4kGKVviOKg0GmIbm/u9kJOUsRj
         rwRlOXjy1aOMvnaKGdPCYXk2ybhnWo4yk0CyVfcwxFFJxNWprIPvfsTUEYvRmz/1aQ25
         Fz/LQBxvsftL8Oxti+Km3Ovp4FbFyWmZp/dfvXROL7kMQcpBvdY4tAhMnX7+UwzqH24c
         lilw==
X-Gm-Message-State: AFqh2koWili4GGOx59UnQeQCFZXB941YZ2/TVpC+O3xUi8j2oPCyqwml
        LhE+s4C+AnBBrsAP7sGAultRLVt+q6++Z1FM+tPS6TDFpHQ=
X-Google-Smtp-Source: AMrXdXuq0dIsh/j5UlY1v0Ms2aDphfCe1kgrNQtOygjNs4fU3R3Rbwke6Jw+4TdTdX7oRbKFRFlCvZJdr787XvGeH9I=
X-Received: by 2002:a05:6808:c:b0:35d:ff69:49c0 with SMTP id
 u12-20020a056808000c00b0035dff6949c0mr3728406oic.146.1673035118628; Fri, 06
 Jan 2023 11:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20221230063528.41037-1-zh.nvgt@gmail.com> <2711de96-fcbe-5611-657a-ab29becd2ff6@gmx.de>
 <CAKMK7uEOX5n64cjzMt9GRQaS13HFPFyOeqdrkmzc035U5_T8tg@mail.gmail.com>
 <CAKMK7uE7CAXO50JPQ6ziQGGehqfDK2UanBQbfLdUH2RwrwXUvw@mail.gmail.com>
 <CAO2zrtYDcOfvxpG6wPghPnWZVks+NL6N9VaynsBVoX7nHBcxuw@mail.gmail.com> <Y7hvhtHeivfsnBtE@phenom.ffwll.local>
In-Reply-To: <Y7hvhtHeivfsnBtE@phenom.ffwll.local>
From:   Hang Zhang <zh.nvgt@gmail.com>
Date:   Fri, 6 Jan 2023 14:58:27 -0500
Message-ID: <CAO2zrtb9H=OWPbrgmqTxQnHqETt-P4K6AxiwdtN7guxUYL2NCw@mail.gmail.com>
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

On Fri, Jan 6, 2023 at 1:59 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, Jan 05, 2023 at 01:38:54PM -0500, Hang Zhang wrote:
> > On Thu, Jan 5, 2023 at 5:25 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Thu, 5 Jan 2023 at 11:21, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > >
> > > > Hi Helge
> > > >
> > > > On Mon, 2 Jan 2023 at 16:28, Helge Deller <deller@gmx.de> wrote:
> > > > >
> > > > > On 12/30/22 07:35, Hang Zhang wrote:
> > > > > > In do_fb_ioctl(), user specified "fb_info" can be freed in the callee
> > > > > > fbcon_get_con2fb_map_ioctl() -> set_con2fb_map() ->
> > > > > > con2fb_release_oldinfo(), this free operation is protected by
> > > > > > console_lock() in fbcon_set_con2fb_map_ioctl(), it also results in
> > > > > > the change of certain states such as "minfo->dead" in matroxfb_remove(),
> > > > > > so that it can be checked to avoid use-after-free before the use sites
> > > > > > (e.g., the check at the beginning of matroxfb_ioctl()). However,
> > > > > > the problem is that the use site is not protected by the same locks
> > > > > > as for the free operation, e.g., "default" case in do_fb_ioctl()
> > > > > > can lead to "matroxfb_ioctl()" but it's not protected by console_lock(),
> > > > > > which can invalidate the aforementioned state set and check in a
> > > > > > concurrent setting.
> > > > > >
> > > > > > Prevent the potential use-after-free issues by protecting the "default"
> > > > > > case in do_fb_ioctl() with console_lock(), similarly as for many other
> > > > > > cases like "case FBIOBLANK" and "case FBIOPAN_DISPLAY".
> > > > > >
> > > > > > Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> > > > >
> > > > > applied to fbdev git tree.
> > > >
> > > > The patch above makes no sense at all to me:
> > > >
> > > > - fb_info is protected by lock_fb_info and
> > > > - the lifetime of fb_info is protected by the get/put functions
> > > > - yes there's the interaction with con2fb, which is protected by
> > > > console_lock, but the lifetime guarantees are ensured by the device
> > > > removal
> > > > - which means any stuff happening in matroxfb_remove is also not a
> > > > concern here (unless matroxfb completely gets all the device lifetime
> > > > stuff wrong, but it doesn't look like it's any worse than any of the
> > > > other fbdev drivers that we haven't recently fixed up due to the
> > > > takeover issues with firmware drivers
> > >
> > > I have also a really hard timing finding the con2fb map use in the
> > > matroxfb ioctl code, but that just might be that I didn't look
> > > carefully enough. Maybe that would shed some light on this.
> > > -Daniel
> > >
> > >
> > > >
> > > > On the very clear downside this now means we take console_lock for the
> > > > vblank ioctl (which is a device driver extension for reasons, despite
> > > > that it's a standard fbdev ioctl), which is no good at all given how
> > > > console_lock() is a really expensive lock.
> > > >
> > > > Unless I'm massively missing something, can you pls push the revert
> > > > before this lands in Linus' tree?
> > > >
> > > > Thanks, Daniel
> >
> > Hi, Daniel. Thank you for your feedback. We're not developers of the
> > video subsystem and thus may be short in domain knowledge (e.g., the
> > performance of console_lock() and the complex lifetime management).
> > This patch initially intended to bring up the potential use-after-free
> > issues here to the community - we have performed a best-effort code
> > review and cannot exclude the possibility based on our understanding.
> >
> > What we have observed is that the call chain leading to the free site
> > (do_fb_ioctl()->fbcon_set_con2fb_map_ioctl()->set_con2fb_map()->
> > con2fb_release_oldinfo()-> ... ->matroxfb_remove()) is only protected
> > by console_lock() but not lock_fb_info(), while the potential use
> > site (call chain starts from the default case in do_fb_ioctl()) is
> > only protected by lock_fb_info() but not console_lock().
> > We thus propose to add this extra console_lock() to the default case,
> > which is inspired by the lock protection of many other existing
> > switch-case terms in the same function.
> >
> > Since we do not have deep domain knowledge of this subsystem, we will
> > rely on the developers to make a decision regarding the patch. Thank
> > you again for your review and help!
>
> Can you please elaborate where you've found this use-after-free and how?
> I'm still not understanding how you even got here - this is orthogonal to
> whether the patch is the right fix or not.
> -Daniel

Hi, Daniel. Sure. This issue was initially flagged by our experimental static
code analyzer aiming to find use-after-free issues in the kernel - that's why
we don't have PoC or execution traces here. We deeply understand that
static analyzer can generate false alarms, so we have tried our best and
spent a good amount of time carefully reviewing the related code. We
eventually found that we could not exclude this potential issue based on our
study, so we decided to report this to the community with this tentative fix. As
mentioned, we may be short in domain knowledge, so your input is
highly appreciated. We respect the developer's decision about whether
this is really a problem and whether/how to fix it. However, if you think the
use-after-free is actually not possible, it will be very helpful if you can
elaborate on the reasoning since it will greatly help us improve our
analyzer. Thank you very much for your help!

BTW, if this is worthed a fix and the performance of console_lock() is a
major concern, then I think there may be alternative solutions like adding
a lock_fb_info() to the free call chain - if that's better in performance,
or maybe selectively protect the matroxfb ioctl but not vblank ioctl as you
mentioned.

Thanks,
Hang

>
> >
> > Best,
> > Hang
> >
> > > >
> > > > > Thanks,
> > > > > Helge
> > > > >
> > > > > > ---
> > > > > >   drivers/video/fbdev/core/fbmem.c | 2 ++
> > > > > >   1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > > > > > index 1e70d8c67653..8b1a1527d18a 100644
> > > > > > --- a/drivers/video/fbdev/core/fbmem.c
> > > > > > +++ b/drivers/video/fbdev/core/fbmem.c
> > > > > > @@ -1182,6 +1182,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> > > > > >               console_unlock();
> > > > > >               break;
> > > > > >       default:
> > > > > > +             console_lock();
> > > > > >               lock_fb_info(info);
> > > > > >               fb = info->fbops;
> > > > > >               if (fb->fb_ioctl)
> > > > > > @@ -1189,6 +1190,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> > > > > >               else
> > > > > >                       ret = -ENOTTY;
> > > > > >               unlock_fb_info(info);
> > > > > > +             console_unlock();
> > > > > >       }
> > > > > >       return ret;
> > > > > >   }
> > > > >
> > > >
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
