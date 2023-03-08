Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569326B0BEF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjCHOyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjCHOyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:54:02 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2873387A20
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:53:59 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-176b48a9a05so11510835fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678287239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+h1rij6N0lUGO/E7ZKOwHfc3o7H8cFo1VZKk3y0lxN8=;
        b=MS45slAd8KXjvjy9zmeKgZR1lvxKaZA8SpMsisKbRQV7k5MoWAyPqTwia45hGuG8AH
         31fXYtVTxf12SQJFqnUheYQLgpU2kaaVtMGcdoGnWCkkMh9+BQ/c1GOgljZM4VGCZ72O
         WjbiTRB6eR2jY04y/ZdFoz+1p+3ZrGpgGvtpp6AexBNjPERxj4EJlIyBq+zDonPqXllj
         RGdYH99+OJP7V6MFpfmMDowOlohL83FAiW2Q149BDP60iHhVmHGjp0iqnPBonX/yObrT
         iRMnLjwa1rBcMLhGjIEzQu3fWKj48Zo1gKSVq52WvvSmkmyg2ss6LnxOaeppTRCK71lp
         SZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678287239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+h1rij6N0lUGO/E7ZKOwHfc3o7H8cFo1VZKk3y0lxN8=;
        b=vU4g5609++Y7SG0zvl8zTuNXofrhntzyBKXfv2PuYVdlxDp6MjbpQ9QcVCKshn/SM8
         L2BvKbe8/OlVrLZKhrvNibChbzj8UDjE2LlN62ZW6xyf8VJRmQ17Qg1fsqnsJtuU1VnG
         LgzZX6pJxDniaRdDsxq8fuyWqNkGz79/bkKaJuQeS2ty1Le1hyNTPRPZJr+NcbN8/Rsi
         Gclp6nvy20lab5mXCFzRRZ4AfdXV5hCUqaMI/DXxy5Q52YHpVfbArL9se6IllHM/HCrg
         6a0z4w5YYFzlwYzMjtnzlVFrxCH6jFL++Bzkgvdy9f+O2D8YXAcpAqBGwFpjuga80DgA
         vfPA==
X-Gm-Message-State: AO0yUKWWMxFpQf/JwnaFXuNL3V1DPLqX9lGDa00wy13dBPo7/KvWirBB
        etMAnWdxTXddfFZdwYfI3NVRtdMJHAoANLSAmxE=
X-Google-Smtp-Source: AK7set/GAIE8dIs01hI0FVo6FB5zbktg52ZImeNPVZn8V1GMCDG0CxElCY+45T+l43/aw+F7Hr5AmsBvy26xusOvxhw=
X-Received: by 2002:a05:6870:5a97:b0:176:31db:9a49 with SMTP id
 dt23-20020a0568705a9700b0017631db9a49mr6332180oab.3.1678287239001; Wed, 08
 Mar 2023 06:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20230307202221.880489-1-helgaas@kernel.org>
In-Reply-To: <20230307202221.880489-1-helgaas@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 8 Mar 2023 09:53:47 -0500
Message-ID: <CADnq5_PffomFtJkVmOzFQnCk=Oqv9CmTZjKVm0oZoi94oq4KMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Drop redundant pci_enable_pcie_error_reporting()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan@freedesktop.org, Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Tue, Mar 7, 2023 at 3:22 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> pci_enable_pcie_error_reporting() enables the device to send ERR_*
> Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> native"), the PCI core does this for all devices during enumeration, so the
> driver doesn't need to do it itself.
>
> Remove the redundant pci_enable_pcie_error_reporting() call from the
> driver.
>
> Note that this only controls ERR_* Messages from the device.  An ERR_*
> Message may cause the Root Port to generate an interrupt, depending on the
> AER Root Error Command register managed by the AER service driver.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
>  2 files changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 164141bc8b4a..208cebb40232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -50,7 +50,6 @@
>  #include <linux/hashtable.h>
>  #include <linux/dma-fence.h>
>  #include <linux/pci.h>
> -#include <linux/aer.h>
>
>  #include <drm/ttm/ttm_bo.h>
>  #include <drm/ttm/ttm_placement.h>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c4a4e2fe6681..a5151e83a3f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3773,8 +3773,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                 }
>         }
>
> -       pci_enable_pcie_error_reporting(adev->pdev);
> -
>         /* Post card if necessary */
>         if (amdgpu_device_need_post(adev)) {
>                 if (!adev->bios) {
> --
> 2.25.1
>
