Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B09660352
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbjAFPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbjAFPbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:31:21 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5368873E1B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:30:58 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-150debe2b7cso1935081fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 07:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oiJt6s7+hbogz7Pnp3dT+g0/bOfE/wSE2iJelIqj6/U=;
        b=ZDLN8+H8kR4lAfnL9dFpNhPkExxpPDiNyX+c9Z8+BS9D0gRtkyROettmrozcJcr83S
         JSxz9LjVvHiTvqCTPMtYEJkLVxHbyvp46uEh9NjgS+IG2z/l1hRSxveKyIGrVkUq01wT
         GfxP/atYg9WZwQDaKnSnzG47Bt8Gb236gDLny5KIobdVQWzlQe+8VV8/t8g5t2lwQVFP
         jfzIEnxIcxB6CScqePq/tz3JevZLHNlgCvO5h9QwEHCMwTGG71ZKFyMDLvWy9J9wgPYt
         tCtnGSFaXoEX/cdzcKJcM4RQyDb4X0Cj/B15oiSupk262JZqZ8llZHICpArKJAtZRUo+
         uV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiJt6s7+hbogz7Pnp3dT+g0/bOfE/wSE2iJelIqj6/U=;
        b=CaS3MO7D0y1i+7MeaZkkg1DULIoBviVkVTX+SK+BD2IDe+9LbAQR+rzUhq3nFcVmcH
         1w8u/JZwd0zWamvI52fJhPXEW5udLA2BCdngm6BIU01gAswL3ygL9jmZpRPpfm6bwYfz
         pHOT/Etg/Z7ovmu54ejs3mdWQcEo+x7pgOfZGUO40Dpywj5QLXIa1wCfqQOMRJXTeU4F
         f2TFOT2SJTZDAz3lq4ooWn3zisQRDtPTJSeTAsPweYNjyB4iJG2Q+ByPWFrDKexaspRv
         xolmj4Mu2sdx4/PMVi7+ZWZ484CS1h37TovfCwTeuyLkjMI/vg/wjfmnN0CjqskrWQQI
         Q+0Q==
X-Gm-Message-State: AFqh2korQpzDY5LWwD7hRAeZ2VE1NrNf4dtcaTuaiIFcWnnuwofuLjw3
        bmQXPVldZCHO/1hLVSJ2k0jmJHFAbCZ5Gzcc2pbbHklY
X-Google-Smtp-Source: AMrXdXsVu9tZH9aEpFTPrGxj623SET9TazA0U7VuGephptWzQv20D90ml/cZSokwL8XmyIJ3Wj/wgSNT3aUNvKZMMg8=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr4679795oaq.46.1673019058265; Fri, 06
 Jan 2023 07:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20230106013232.25947-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230106013232.25947-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 6 Jan 2023 10:30:46 -0500
Message-ID: <CADnq5_MTfRLcH2EvxYL61pjTEs_VsQnh1Ya_ahSCDZksyFqv5Q@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: clean up some inconsistent indentings
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
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

On Thu, Jan 5, 2023 at 8:37 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:65 amdgpu_gem_fault() warn: inconsistent indenting
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3639
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 00edc7002ee8..ed1164a87fce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -62,10 +62,10 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>                         goto unlock;
>                 }
>
> -                ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
> -                                               TTM_BO_VM_NUM_PREFAULT);
> +               ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
> +                                              TTM_BO_VM_NUM_PREFAULT);
>
> -                drm_dev_exit(idx);
> +               drm_dev_exit(idx);
>         } else {
>                 ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
>         }
> --
> 2.20.1.7.g153144c
>
