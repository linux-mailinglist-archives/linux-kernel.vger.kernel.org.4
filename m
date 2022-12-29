Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA3658F27
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiL2Qmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiL2Qms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:42:48 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DD2A199
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:42:47 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso11737828oto.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XIvm70LkQ0CoIBJttPmIJN6T0aTQeFPqoab/sv2/Y/Q=;
        b=RpbCVwWkg6y2HFXbLkdAMBEjzk1nGRpiL3JNiid7F86P98QOUxAExYfy5Nt3XXW8Qj
         QhxSYdgLBA6u3ddxnLXHT3Npm+mw6TDGiL8FVK5WU07CTtpGLIsYzY8UuX3E/thZBoxT
         XmbhBwROvAj3ti7Y56c+9CnVye/Zc0iWb91udaRj0dtV18cXzKNsW9c0ULtyPTF3QCgN
         6kX84x+AzKfM51A5t9UPjOmmJCBDLQdwfFzuMZCuLickpcd5RB1hCdgXN3bWUZIWQi3K
         hRN7dlTa4bNW3ZSGKL6LyEia7+coFika2MDDUj5KaNrjrPfIMioZ+57XIkwEgg/z7FY6
         g80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIvm70LkQ0CoIBJttPmIJN6T0aTQeFPqoab/sv2/Y/Q=;
        b=MANzfb1OXZ0+/8L+Br0ZnBOZLvz1GH79emt8VpaYHbDLdwiQsBh/MJz8gRgyzEwwTv
         4SkqIQT7vVLvJWDk76mda55gpp2IA6tYvs32qwJzHaNcNnAd6M+8kOjVb+Gy3Id35bRA
         K3jDLqW6Qb7RU7jeYGzaUa4RC97hHcUooIJGcmxoxSagSf62LNqcMoR0ari5ZvfgkgGC
         mk2qp1qD57fOUgFt/FzDahj9Ru2BjJXlD6J0GOz0GvLHnW71wAa/jZD633psnFCi2y9N
         wSHlFy++a0jbqA4hHAIUgysHfrHQGxzgsXBin4c6coJms/V/gRnaDxrubHIdoCux9p3h
         uXyQ==
X-Gm-Message-State: AFqh2kpxbDfeAqIkNZFo2u+C2RqH02k+QwermTsifyyvFPVm4Qenyg/3
        fewe4wUGnWji3ZIHfRJHQ7OuExZmsjoNRGnb7dZy9itg
X-Google-Smtp-Source: AMrXdXtBCmcxjk+Vd0518fLYPGkHLDRkfku4pPSrg7+B3ww44bFQhxGhRTH25O0a6nz9t5OpFouimGJA/o8GyL1o848=
X-Received: by 2002:a9d:6ac6:0:b0:671:cacb:681f with SMTP id
 m6-20020a9d6ac6000000b00671cacb681fmr1850314otq.233.1672332167193; Thu, 29
 Dec 2022 08:42:47 -0800 (PST)
MIME-Version: 1.0
References: <3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com> <20221228192740.1ec44a3d@localhost>
In-Reply-To: <20221228192740.1ec44a3d@localhost>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 29 Dec 2022 11:42:35 -0500
Message-ID: <CADnq5_OXLuhSJwN-bKg47YjurUze6wj0kZhzsqszfV93uzok_w@mail.gmail.com>
Subject: Re: [BUG] AMD Radeon Pro 5600M with 8GB of HBM2 memory shows blank
 screen on Linux
To:     Orlando Chamberlain <redecorating@protonmail.com>
Cc:     Aditya Garg <gargaditya08@live.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
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

On Wed, Dec 28, 2022 at 5:47 PM Orlando Chamberlain
<redecorating@protonmail.com> wrote:
>
> On Mon, 26 Dec 2022 21:44:06 +1100
> "Aditya Garg" <gargaditya08@live.com> wrote:
>
> > The AMD Radeon Pro 5600M with 8GB of HBM2 memory GPU is found in
> > MacBook Pro 16 inch, 2019 (MacBookPro16,4).
> >
> > The GPU fails to work on Linux, thus a blank black screen gets
> > displayed on boot.
> >
> > If nomodeset is added as a kernel parameter, we are able to access
> > Linux easily.
> >
> > The link below contains the journalctl of the failed boot :-
> > https://gist.github.com/AdityaGarg8/dfe1a1c23bf2b92b640dad89f55b73c7
> >
> > Thanks
> > Aditya
>
> I'm not sure if it was an unrelated issue, but on older versions
> including 5.17.1, psp_v11_0_bootloader_load_sysdrv would timeout and
> return -ETIME. I'm not sure when it started having Mode Validation
> Warnings instead, but these errors are what it previously had:
>
> [    5.136077] [drm:psp_hw_start [amdgpu]] *ERROR* PSP load sys drv failed!
> [    5.136233] [drm:psp_hw_init [amdgpu]] *ERROR* PSP firmware loading failed
> [    5.136351] [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* hw_init of IP block <psp> failed -22
> [    5.136458] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_init failed
> [    5.136477] amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
> [    5.136540] amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing device.
> [    5.137815] amdgpu: probe of 0000:03:00.0 failed with error -22


It's not likely that the two are related.

>
> The patch used to test this and the kernel log I received from someone
> using that patch are on this page:
> https://gist.github.com/Redecorating/645a62eec4fb06e03f384396f483fa37

What was this patch for?

Alex
