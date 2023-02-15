Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2B269755A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBOEXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBOEXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:23:35 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC746BA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 20:23:34 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id bj22so14817574oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 20:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=28pkhs7BNsOxA9fRLX3gZsoQIzciaQoaB4lJUO4D5nY=;
        b=Fa8w4E5izzvn9yFXqCRURcAGEdKWPXgAVpTypsZf43R4pZtoQ3BKjRGad+ww+Mq3kV
         tCkj2izkJmSLl9QQRPMSGqBvoEdBj3NSacSh/eyFiuPFFXhOTV8zBeog09F3LE4uUsmT
         /RCT8MO52WkmNgJZoS6jbFa5kX2SvxQ3/1mdfWkZYSTKkZpWL4RpewpFG31E4Zuv8NMj
         jM2ljuVp/QwD6mAx9B24TZbeWpPABgh0pG5YEnE6gYHfvQGBwKBir832LIAQqD+j+KLW
         LyCoLhyxUsd8FjY660egh2HFIQoChtfsBaYpw1RGvLENovmjMWicbopSs2yGEAa7M0LR
         3ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28pkhs7BNsOxA9fRLX3gZsoQIzciaQoaB4lJUO4D5nY=;
        b=PG0GSvbeKupPB6sZgroJPtjlW9NJQeBkcn5mfiV/pDibEVgapbIPvmReyS/MzFexYt
         hUCnGDsHew6WUqNV27ImjRsF9g9L+wJqGHGUFiiPSW8tEb89/hKLMH3owaUQBPRAY6mG
         LrTXxZ2js6+6XFtQXpjybXbSXk04Nu9YHy3PfTcY0dXbSRf8mEuCiCt5yiT2Y7+u9Rz8
         80FsUcjhce3gGv7B8YwuX3HqyTd/Rc3OITwgNonweItmJkljq3uVlE5iUkA+QKKZ6ZpK
         u1i+ep7zfeeGDG+OzZMJttK0DmIPkP8HQvjjaxXpJDL1nXoPtG3qL0gyNMntpS2MSgna
         0yJA==
X-Gm-Message-State: AO0yUKVnvYDPa3fQY5lnOoqD9ySGntxeZD6C43s4q6WokXX+ki/llXCk
        NucrfucxhJBpFtFJkb6ltWNgDqzhv4YiilaHSeLkwLS5
X-Google-Smtp-Source: AK7set/r++RbOmGbzjb+Yp69hd6JJ+g/KPtzvE2ZN65RIpZijc9zcasmQbwcBLPttyQOlCwlijCKJ5KJ3pabQ1tBe1M=
X-Received: by 2002:aca:ded7:0:b0:35b:d93f:cbc4 with SMTP id
 v206-20020acaded7000000b0035bd93fcbc4mr96257oig.96.1676435013946; Tue, 14 Feb
 2023 20:23:33 -0800 (PST)
MIME-Version: 1.0
References: <Y+YYZ4SbMQBcpTZP@ubun2204.myguest.virtualbox.org> <c64bb7b8-ab50-78c3-bb56-820ce96a1e14@amd.com>
In-Reply-To: <c64bb7b8-ab50-78c3-bb56-820ce96a1e14@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 14 Feb 2023 23:23:22 -0500
Message-ID: <CADnq5_NektE+iS4VUXjha=WOOo4WRKCM3dXnYfP7RBtGztCZVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate/repeating expression
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

On Fri, Feb 10, 2023 at 10:22 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2/10/23 05:11, Deepak R Varma wrote:
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
> >  .../gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
> > index 61ee9ba063a7..6576b897a512 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
> > @@ -51,7 +51,7 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
> >               *BytePerPixelDETC = 0;
> >               *BytePerPixelY = 4;
> >               *BytePerPixelC = 0;
> > -     } else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16) {
> > +     } else if (SourcePixelFormat == dm_444_16) {
> >               *BytePerPixelDETY = 2;
> >               *BytePerPixelDETC = 0;
> >               *BytePerPixelY = 2;
>
