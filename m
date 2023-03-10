Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D76B4B31
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjCJPd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbjCJPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:33:19 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345141CBE7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:21:19 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id be16so4535028oib.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678461678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e9lMn6VV65uWfzjqWmmufolCWaaGVCVGPcfnBRvktiU=;
        b=pO23LVjRTOe/Pqi17BvQZxLyFh8oj6DcEb5OIH5ttExR/GXThc7CquNptfxFHVXWgZ
         ul8jRVwlPw9zx7yIkmmRypTjIqcuLU3Ty0MN4dlNNFmZSxqiybOcJlbFaBwBrCnO0YLv
         k151bi31IvRsJLooodKgjDmT2eY9eKy0OTYMhmw1ILIYhHEYyg4a1Zksfc4MK/ZLi+en
         jwKJhyJR55GKaAO0oak3RxlaVDsGUgPT163ZBmlmDluD7uMStDArT1tepifoyB4VT4Ce
         uV9JJrq/uJKMzvUqSDOJ6taUTeKOXIyx0ZQeLkgHosP9JMTByhisC9fz26YxrZ/VqN0N
         alVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678461678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9lMn6VV65uWfzjqWmmufolCWaaGVCVGPcfnBRvktiU=;
        b=fh65ls5a+sbOfkJ849mPDU1SE85xRqCTjAEH6C+m31ToGbRUXREOrlyeLwRlVSUlA5
         auB/lo8B0Afq1GwEoRn+myxYLVKK/296eY0fYFcn+DG8vSaJdIoi8SjTrpCkNpUQZZOi
         tBFD+4q2l3n74VIw5LlYYUcwWCIHrHk+yvpeXASW2TAQv5ylFZa5+XYgiq1Wy052uqnw
         cW6DuH0IAr+1T8oqO5zj2sCwpF5CT5k7RYQmZVzOt00URHepN2r5FHv/I2mJzKAeetpd
         xTucptz4mi3fBY3qqkE+t64sHqi2xDr+LTslobTLBECI2lra2Ouhe8q6qo84TnG/jd0F
         qk3A==
X-Gm-Message-State: AO0yUKW0llOyranJSc/NZvav7DBmETXjvgwjXQufbQUdI3xNmg38JMMr
        ifN44PR3saydez1qzE5tn9uWpPGXVefe1c0rl6w=
X-Google-Smtp-Source: AK7set/QNvrTKVBToHtiE+X4AER7ddGa4mlsjh2V+qz09csY1T7Jh2Eldr8lMW4bE6jaNMbgI25b1ciWyLOY4CxXG7A=
X-Received: by 2002:aca:230d:0:b0:383:d3ae:2ef4 with SMTP id
 e13-20020aca230d000000b00383d3ae2ef4mr7916358oie.8.1678461678504; Fri, 10 Mar
 2023 07:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20230310074000.2078124-1-lizhenneng@kylinos.cn> <DM5PR12MB2469FEB1E81CA99C51E7DAF0F1BA9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469FEB1E81CA99C51E7DAF0F1BA9@DM5PR12MB2469.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 10 Mar 2023 10:21:06 -0500
Message-ID: <CADnq5_OzDzi_LKeNdk4LNa2SwWg8Jpieci8omJye_ASDyjW3sA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: resove reboot exception for si oland
To:     "Chen, Guchun" <Guchun.Chen@amd.com>
Cc:     Zhenneng Li <lizhenneng@kylinos.cn>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
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

On Fri, Mar 10, 2023 at 3:18 AM Chen, Guchun <Guchun.Chen@amd.com> wrote:
>
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Zhenneng Li
> > Sent: Friday, March 10, 2023 3:40 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: David Airlie <airlied@linux.ie>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> > linux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; Zhenneng Li
> > <lizhenneng@kylinos.cn>; amd-gfx@lists.freedesktop.org; Daniel Vetter
> > <daniel@ffwll.ch>; Koenig, Christian <Christian.Koenig@amd.com>
> > Subject: [PATCH] drm/amdgpu: resove reboot exception for si oland
> >
> > During reboot test on arm64 platform, it may failure on boot.
> >
> > The error message are as follows:
> > [    6.996395][ 7] [  T295] [drm:amdgpu_device_ip_late_init [amdgpu]]
> > *ERROR*
> >                           late_init of IP block <si_dpm> failed -22
> > [    7.006919][ 7] [  T295] amdgpu 0000:04:00.0: amdgpu_device_ip_late_init
> > failed
> > [    7.014224][ 7] [  T295] amdgpu 0000:04:00.0: Fatal error during GPU init
> > ---
> >  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > index d6d9e3b1b2c0..dee51c757ac0 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > @@ -7632,9 +7632,6 @@ static int si_dpm_late_init(void *handle)
> >       if (!adev->pm.dpm_enabled)
> >               return 0;
> >
> > -     ret = si_set_temperature_range(adev);
> > -     if (ret)
> > -             return ret;
>
> si_set_temperature_range should be platform agnostic. Can you please elaborate more?
>

Yes.  Not setting this means we won't get thermal interrupts.  We
shouldn't skip this.

Alex


> Regards,
> Guchun
>
> >  #if 0 //TODO ?
> >       si_dpm_powergate_uvd(adev, true);
> >  #endif
> > --
> > 2.25.1
>
