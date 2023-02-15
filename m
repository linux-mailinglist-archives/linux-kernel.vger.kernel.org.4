Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A1E69755F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBOEYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBOEYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:24:49 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46224200
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 20:24:48 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id p24-20020a056830131800b0068d4b30536aso5322163otq.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 20:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qvKOU4avZmIzyYVOQhc+tG6rthx234MXp5OMVmckZE4=;
        b=eqTQxYMDRwfuhuWV1ksdh9A4ydfNEzp9bKF5eyEZzsG3hUWaZwHsDP7efqyQBqkjD9
         wVdSZKokaZmPnLw1U2uc9MBuUWt8j++nL8CM1GnsfE8f0EfESfYSEY2Tjyp0D17gDTdr
         IKPiN/AomHuqD5c9FBwVO3IIk4BUdrznl1sEvjM9BwzpX8Io/b11CX7hy4Er+LaKpQma
         ZJmrg9KZUeYQwELBCju4G/OTfNNpvSUQrW7i3wTCYr7g7KqAeDwCjjU+KjgRnoY4+njX
         3CHArQQQ26+b0z1HDtdKsmwDld3mJP2eSNneaznZSB4wYv+FJe/juLuUGHxCrV350r00
         LMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvKOU4avZmIzyYVOQhc+tG6rthx234MXp5OMVmckZE4=;
        b=lanTzw0rF/UQxawRpr9KzdHD/RgDpmE1nlj7JFZP6Fc6FqxdRzNa6XIX/qa89M9wqJ
         mdpuj72+Qzm3TXILOr1T8EtNUBDwXQ1COI9K/2CjqPFgPzYkF25kLHXKouY5paaQaQ4P
         t93j3J3SX88r0Tl4u8Tcoe53EKHwV1OoDcUb/t6oDGrooyGH5h/5GGJcybV6JiTpmJCt
         aUSygAMhna1lhNWI0Tg48TQXuxGA+MRaeDGAsbVUMhxD/qM08LooD3NuTpqFmjUN/k8O
         trxR4gMC9MLEpvQm+8nc8sWeOTEGbvXU60ojJDJmmNAOIfgJfrqWjNXfFOsh8quOCP4f
         daPg==
X-Gm-Message-State: AO0yUKV3Tw8t5RGoFok5pYskoUAXJQ03i5qtfxDc6ZlTE+mzRFGEW2KJ
        jQQkoBQiGe4TBPqVSO+c7cNIzK1A0vJXIe/ujlwxEIwx
X-Google-Smtp-Source: AK7set/nmdEuYU4bOBmZL00qZ5LjEiIikomugFMgVVCc/KYC3xw9K5W7h/Co7ljZmIYYraSFevN21vtJ1EiVpWa46PM=
X-Received: by 2002:a05:6830:18e8:b0:68d:4133:fd26 with SMTP id
 d8-20020a05683018e800b0068d4133fd26mr29701otf.56.1676435088248; Tue, 14 Feb
 2023 20:24:48 -0800 (PST)
MIME-Version: 1.0
References: <Y+YVy7RaxnXokJ3l@ubun2204.myguest.virtualbox.org> <49a3244a-1416-12c4-9dfa-661cf5b5d569@amd.com>
In-Reply-To: <49a3244a-1416-12c4-9dfa-661cf5b5d569@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 14 Feb 2023 23:24:36 -0500
Message-ID: <CADnq5_M5JeSU4WwkbWM55HKPtaxsjkJ29JScdWq=OgHkBfNdEw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate/repeating expressions
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Deepak R Varma <drv@mailo.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
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

Applied.  Thanks!

Alex

On Fri, Feb 10, 2023 at 2:37 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2/10/23 05:00, Deepak R Varma wrote:
> > Remove duplicate or repeating expressions in the if condition
> > evaluation. Issue identified using doubletest.cocci Coccinelle semantic
> > patch.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c    | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> > index 4b8f5fa0f0ad..ae89760d887d 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> > @@ -2335,8 +2335,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
> >
> >                       if (mode_lib->vba.DSCEnable[k] && mode_lib->vba.ForcedOutputLinkBPP[k] != 0)
> >                               mode_lib->vba.DSCOnlyIfNecessaryWithBPP = true;
> > -                     if ((mode_lib->vba.DSCEnable[k] || mode_lib->vba.DSCEnable[k])
> > -                                     && mode_lib->vba.OutputFormat[k] == dm_n422
> > +                     if (mode_lib->vba.DSCEnable[k] && mode_lib->vba.OutputFormat[k] == dm_n422
> >                                       && !mode_lib->vba.DSC422NativeSupport)
> >                               mode_lib->vba.DSC422NativeNotSupported = true;
> >
> > @@ -3639,7 +3638,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
> >                       if (mode_lib->vba.SourcePixelFormat[k] != dm_444_64
> >                                       && mode_lib->vba.SourcePixelFormat[k] != dm_444_32
> >                                       && mode_lib->vba.SourcePixelFormat[k] != dm_444_16
> > -                                     && mode_lib->vba.SourcePixelFormat[k] != dm_444_16
> >                                       && mode_lib->vba.SourcePixelFormat[k] != dm_444_8
> >                                       && mode_lib->vba.SourcePixelFormat[k] != dm_rgbe) {
> >                               if (mode_lib->vba.ViewportWidthChroma[k] > mode_lib->vba.SurfaceWidthC[k]
>
