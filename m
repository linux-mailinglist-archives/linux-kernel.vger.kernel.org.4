Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57B25B4124
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiIIU7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiIIU7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:59:10 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F779106364
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:59:09 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso1838791otb.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kFpwCO+On23s16RN6YGg888A8dXgjAXd7O3o6mtZAY0=;
        b=cYkP9UO8oDCe3MN/KnrrGL0KCht5K/tJE9DYpePXowaPHMlqyifnqJxYZh769Q0PDJ
         bOkpXwXjY/PFQbSVwQr8KhksmiBqhWR8If7zp5W7RDD7ohmBSncSkEakpY8YzR90OJA0
         Veqj8LnRuQ3RNExoPv4HPo+5j19PBjKTgbXsLTwxFI57Hk66Fcxax0CICkcJBLMfwVsh
         ijLEZdx7xeQYY/JN6nqDQgmGSS4UWKbxnS4yxc8qpEayy560CNXnnml57yKnmPVbH+UU
         ir2ZwLIBmu0TwsksFOscqgME3e9SViB2Vv+67zBUehw64W0qLtp1vxmgkJ2CmohFHkqJ
         KsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kFpwCO+On23s16RN6YGg888A8dXgjAXd7O3o6mtZAY0=;
        b=dHvjKD7zi4tda4U3AIuhUlLLBJhF5nXmIibD0swhBYneekrKHSzlIqeJBf0BacwM9r
         Sfq3lYqqyavh3ZWr3fkYRoU3/zHHHRzYxS74CvVOwJ1ErgPy9pwFeCWYk1oNn7JqU+IJ
         t15XAZl9oeuUNkFkjb10DBceL/JbSVsSiozQEZ60Fgm4qB5TkW3tGRTSWopcL8lKKNyS
         zoAghGRgUCqf4lIa2jpUyCJiF577+wbYgyePp3fHRINOCmnmKwHitlh9UduR3JlCNSVM
         ZmCPN+kPO7csQVGl3Qbj3ZSGDgpFLfdi6upzCPASbo6V/2/2JLsRrXbjTiCUrsuympSV
         d2og==
X-Gm-Message-State: ACgBeo1+T4vUWAID0h5/UqgpACCtmllTRUrkKk1LYenLcQ0B6q85Ray6
        Z1Gn388aibUzu7Aa47bPjZwH4uFP+FFYm0qNPhcI0HF/
X-Google-Smtp-Source: AA6agR61J889n91RmOLJ7O6XBg1xUpgddBBhA43Rf9/H121Hpj2mrQx3L2n6t+Ve2fKV/hfgVj+4xjwvoRH1KsBRfOQ=
X-Received: by 2002:a9d:376:0:b0:655:b4bc:fd6e with SMTP id
 109-20020a9d0376000000b00655b4bcfd6emr1346569otv.233.1662757148908; Fri, 09
 Sep 2022 13:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220905083825.23429-1-jingyuwang_vip@163.com>
 <18083c05-7636-2155-610b-2d1347f8585f@amd.com> <BL1PR12MB51444461B0F15AAF3BE46F91F77E9@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51444461B0F15AAF3BE46F91F77E9@BL1PR12MB5144.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 16:58:57 -0400
Message-ID: <CADnq5_M9HQViZp9yj55+yr3K0udh4-zqFDKTgXfuo9yyYeiNcw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: cleanup coding style in amdgpu_amdkfd_gpuvm.c
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Jingyu Wang <jingyuwang_vip@163.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Sep 6, 2022 at 2:48 PM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [Public]
>
>
> Yeah, seems to be a mix.  I don't have a strong opinion as long as it has MIT.
>
> Alex
>
> ________________________________
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Tuesday, September 6, 2022 9:46 AM
> To: Jingyu Wang <jingyuwang_vip@163.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; airlied@linux.ie <airlied@linux.ie>; daniel@ffwll.ch <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] drm/amdgpu: cleanup coding style in amdgpu_amdkfd_gpuvm.c
>
>
> Am 2022-09-05 um 04:38 schrieb Jingyu Wang:
> > Fix everything checkpatch.pl complained about in amdgpu_amdkfd_gpuvm.c
> >
> > Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index cbd593f7d553..eff596c60c89 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: MIT
>
> I'm not sure if this is correct. We've used "GPL-2.0 OR MIT" in KFD. In
> amdgpu there is currently a mix of licenses. Alex, do you want to make a
> call on a consistent one to use in amdgpu?
>
> Other than that, this patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
> >   /*
> >    * Copyright 2014-2018 Advanced Micro Devices, Inc.
> >    *
> > @@ -1612,6 +1613,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
> >        uint64_t reserved_for_pt =
> >                ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> >        size_t available;
> > +
> >        spin_lock(&kfd_mem_limit.mem_limit_lock);
> >        available = adev->gmc.real_vram_size
> >                - adev->kfd.vram_used_aligned
> > @@ -2216,7 +2218,7 @@ int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
> >   {
> >        if (atomic_read(&adev->gmc.vm_fault_info_updated) == 1) {
> >                *mem = *adev->gmc.vm_fault_info;
> > -             mb();
> > +             mb(); /* make sure read happened */
> >                atomic_set(&adev->gmc.vm_fault_info_updated, 0);
> >        }
> >        return 0;
> >
> > base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
