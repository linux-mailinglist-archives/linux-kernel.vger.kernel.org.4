Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B419C5B4109
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIIUvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIIUvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:51:53 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C674147391
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:51:50 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id q6-20020a4aa886000000b0044b06d0c453so456945oom.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DUHWHeA08mIahhsciiaTsaPGg+HQzx7SFaoh+t8qFxs=;
        b=SORX/TdUyX7GAibTMD7q0Au1yjFpBBE5BmsKfX9LSqaXhYbo010nYD6yFBM+y/b2T0
         ai3Wt12CE8e9aX4WHsOcWSuflUukQ0Ba7xeLMwyzJEDwBXesFuDioQHfWEGESVczJs/R
         3Ra8UtfgIs8/o6WN/uHjVDOo3T3z/DxzZ4EnmejFMM07CxwMsdYbCPJxHWENFw0e5G47
         bxXHTz/i0SoI98cV+PWtg707lMeW6kpPH4KF7j+YagM2NHhdGbzwQMcVNsDJC6fFFaNi
         cnf4fYyodIXygO6ww9F5uZdwfYgwwofZFVlPOQWA6fUSWiDTJGWvS9F0XH1kHMi35H4n
         8AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DUHWHeA08mIahhsciiaTsaPGg+HQzx7SFaoh+t8qFxs=;
        b=SG8lDfFtl1xdbf5v5Z5C5moSuWOrjKz8i/Byf5zD/9WfeKizxwKxy11GZM1Lb1MVJd
         2jlG0QOOtjoICSVpuvDfKcAfifq7Cob5ir4ap600xv/hBRgNuZLyrM2Ww10VHlA7nc4H
         MENxgwQTzuPvhqeWCutC4OgmEbSNX2022AZHhNPfw3onHQ+cdiUirP4p2/A3pJhy0pYu
         s+xuMstL2qlC4DGfKMmVa9CORXiZ7F/VBv5DP+R+fldH95JYLV3Ef58g4esxfHwAfuK/
         mhlufq5T1JZpuJ6jY4bm4UDs98RO9ScmvJl+3NerI1qX//kwCty9XL2Y+jMcVOkQshg6
         Q92g==
X-Gm-Message-State: ACgBeo32qTqgNcQ3AG4Kh78tlfMLow1cAUCCmrcl0TNiKAtZO6whxcn4
        jZWWwMkT8/2FRRv2nLVQtmwKeA45acoYPK1JfNk=
X-Google-Smtp-Source: AA6agR4lQQ5B0kKRbq0IyYE2sfBAPPacxCJVm/a7if8rUqF0go9tIzZ8wYR2S1rCYNl65J7Xv/DN3zOr2n58YTQSrGM=
X-Received: by 2002:a4a:a78a:0:b0:472:a078:98d6 with SMTP id
 l10-20020a4aa78a000000b00472a07898d6mr2325126oom.97.1662756709748; Fri, 09
 Sep 2022 13:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220905011431.19818-1-jingyuwang_vip@163.com>
In-Reply-To: <20220905011431.19818-1-jingyuwang_vip@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 16:51:38 -0400
Message-ID: <CADnq5_O+pduHeGra3R0XHZP=aOUmy4SETzOP+e-x-5rhYHVi2g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: cleanup coding style in amdgpu_acpi.c
To:     Jingyu Wang <jingyuwang_vip@163.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        mario.limonciello@amd.com, hdegoede@redhat.com,
        rafael.j.wysocki@intel.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Mon, Sep 5, 2022 at 2:29 AM Jingyu Wang <jingyuwang_vip@163.com> wrote:
>
> Fix everything checkpatch.pl complained about in amdgpu_acpi.c
>
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 55402d238919..3da27436922c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>  /*
>   * Copyright 2012 Advanced Micro Devices, Inc.
>   *
> @@ -849,6 +850,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>                 if (amdgpu_device_has_dc_support(adev)) {
>  #if defined(CONFIG_DRM_AMD_DC)
>                         struct amdgpu_display_manager *dm = &adev->dm;
> +
>                         if (dm->backlight_dev[0])
>                                 atif->bd = dm->backlight_dev[0];
>  #endif
> @@ -863,6 +865,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>                                 if ((enc->devices & (ATOM_DEVICE_LCD_SUPPORT)) &&
>                                     enc->enc_priv) {
>                                         struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
> +
>                                         if (dig->bl_dev) {
>                                                 atif->bd = dig->bl_dev;
>                                                 break;
> @@ -919,9 +922,9 @@ static bool amdgpu_atif_pci_probe_handle(struct pci_dev *pdev)
>                 return false;
>
>         status = acpi_get_handle(dhandle, "ATIF", &atif_handle);
> -       if (ACPI_FAILURE(status)) {
> +       if (ACPI_FAILURE(status))
>                 return false;
> -       }
> +
>         amdgpu_acpi_priv.atif.handle = atif_handle;
>         acpi_get_name(amdgpu_acpi_priv.atif.handle, ACPI_FULL_PATHNAME, &buffer);
>         DRM_DEBUG_DRIVER("Found ATIF handle %s\n", acpi_method_name);
> @@ -954,9 +957,9 @@ static bool amdgpu_atcs_pci_probe_handle(struct pci_dev *pdev)
>                 return false;
>
>         status = acpi_get_handle(dhandle, "ATCS", &atcs_handle);
> -       if (ACPI_FAILURE(status)) {
> +       if (ACPI_FAILURE(status))
>                 return false;
> -       }
> +
>         amdgpu_acpi_priv.atcs.handle = atcs_handle;
>         acpi_get_name(amdgpu_acpi_priv.atcs.handle, ACPI_FULL_PATHNAME, &buffer);
>         DRM_DEBUG_DRIVER("Found ATCS handle %s\n", acpi_method_name);
>
> base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
> --
> 2.34.1
>
