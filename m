Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289006997E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBPOxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBPOxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:53:10 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D514AFE0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:53:09 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id t5so1907386oiw.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pQYLZn0bQAL+yoROTgZjs5gfeNZ6HZmmMBdCUxpu0fU=;
        b=S/t6Rm+/iIWUBvAg+mq74Pn8wXnKGCZmK2vnjgnbpv5UR3w8oH5NKJZwxYFKuClEgU
         2aLXa6fpACCBr8nzhkE32hDuOTmnGdyKYHT0DBbYoGkY6TzXh1AtaEkD38AtAoxahP+d
         onFMvmSxs1aoywi/2HLYkbRxDqOGx0SURD3YqPy3Z7ki9dXnSk2I1q+PxcTKvHCmtNaK
         zYEoQyasZPenKd0XwdqGOOpYs4J7KH2KXTvaKRlR34Yov3jl8OsnScqguNxyQhRFxEzn
         DRRR+pFcdFMaysgAhaaGhvVlmQap632MfnZbE1Vbr3ax7pBlzwXjP6nql6GQFqngiwJK
         SnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQYLZn0bQAL+yoROTgZjs5gfeNZ6HZmmMBdCUxpu0fU=;
        b=Yvrc4z2jPSm041nblzVTvn/cEmE1fxGnLkrTcyI8TQN7aQpWyIog8DhTAb64jzsPUm
         JPvolODzUY4PM+kc9cI5jRdQMUe6vm+yWzJQDP6ibIeruPWrMbdMQMwVxqwwBpxVc+S4
         L+3A+fZBMmWhcf1fqqBtJzlPqd/pwK8PPtsJ7E5uQDesOeGN133rjjAlkYJJTp5qB/F5
         hEwxQkxbF41+yGlVaGUr8uLYUst4wef7CP/IP2JMeIoZDE+Bs+VOfWYmQ3aNL0VfhWGD
         DmesBxqIcj/9467ZZOOKp+Tk1cM2n4IyAXOzphsuRbIciofU8xKC9tnfQwliVHO+0GKT
         mB0A==
X-Gm-Message-State: AO0yUKUhvGB7FaEi9grXTaeAihSDB0k0F3J3oWkdy4gwmOcEBs9T8GQc
        AyxO605LS+OVcKbwH/Iy2k77LnwFjg03dhvRdWQ=
X-Google-Smtp-Source: AK7set9+635aGGSGXuMavk+jxtmZTf8z5uamIZF5wF94ONM5UsNDW03w287rSqyPCDuCfLS6m0HCo582oc5Yj18ZayA=
X-Received: by 2002:a05:6808:2007:b0:35b:d93f:cbc4 with SMTP id
 q7-20020a056808200700b0035bd93fcbc4mr209182oiw.96.1676559189108; Thu, 16 Feb
 2023 06:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20230216102856.11987-1-orlandoch.dev@gmail.com>
In-Reply-To: <20230216102856.11987-1-orlandoch.dev@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 16 Feb 2023 09:52:57 -0500
Message-ID: <CADnq5_OMA3+FXwUB5eK=Y3qcGW1xNY6RjQAtywT3_bh6HmJztA@mail.gmail.com>
Subject: Re: [PATCHv2] drm/amdgpu: register a vga_switcheroo client for
 MacBooks with apple-gmux
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Aditya Garg <gargaditya08@live.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Thu, Feb 16, 2023 at 8:45 AM Orlando Chamberlain
<orlandoch.dev@gmail.com> wrote:
>
> Commit 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and
> vga_switcheroo") made amdgpu only register a vga_switcheroo client for
> GPU's with PX, however AMD GPUs in dual gpu Apple Macbooks do need to
> register, but don't have PX. Instead of AMD's PX, they use apple-gmux.
>
> Use apple_gmux_detect() to identify these gpus, and
> pci_is_thunderbolt_attached() to ensure eGPUs connected to Dual GPU
> Macbooks don't register with vga_switcheroo.
>
> Fixes: 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and vga_switcheroo")
> Link: https://lore.kernel.org/amd-gfx/20230210044826.9834-10-orlandoch.dev@gmail.com/
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>

This needs ifdefs around the apple_gmux stuff so that it will build
without the gmux support.

Alex

> ---
> v1->v2: Use apple_gmux_detect()
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2f28a8c02f64..ef8b996f0622 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -35,6 +35,7 @@
>  #include <linux/devcoredump.h>
>  #include <generated/utsrelease.h>
>  #include <linux/pci-p2pdma.h>
> +#include <linux/apple-gmux.h>
>
>  #include <drm/drm_aperture.h>
>  #include <drm/drm_atomic_helper.h>
> @@ -3919,12 +3920,15 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>                 vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
>
> -       if (amdgpu_device_supports_px(ddev)) {
> -               px = true;
> +       px = amdgpu_device_supports_px(ddev);
> +
> +       if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
> +                               apple_gmux_detect(NULL, NULL)))
>                 vga_switcheroo_register_client(adev->pdev,
>                                                &amdgpu_switcheroo_ops, px);
> +
> +       if (px)
>                 vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
> -       }
>
>         if (adev->gmc.xgmi.pending_reset)
>                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
> @@ -4029,6 +4033,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>  void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  {
>         int idx;
> +       bool px;
>
>         amdgpu_fence_driver_sw_fini(adev);
>         amdgpu_device_ip_fini(adev);
> @@ -4048,10 +4053,16 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>
>         kfree(adev->bios);
>         adev->bios = NULL;
> -       if (amdgpu_device_supports_px(adev_to_drm(adev))) {
> +
> +       px = amdgpu_device_supports_px(adev_to_drm(adev));
> +
> +       if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
> +                               apple_gmux_detect(NULL, NULL)))
>                 vga_switcheroo_unregister_client(adev->pdev);
> +
> +       if (px)
>                 vga_switcheroo_fini_domain_pm_ops(adev->dev);
> -       }
> +
>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>                 vga_client_unregister(adev->pdev);
>
> --
> 2.39.1
>
