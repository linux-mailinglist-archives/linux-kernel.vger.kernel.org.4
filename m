Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7920460FFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbiJ0SMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbiJ0SL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:11:56 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A0634E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:11:55 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so1512376otb.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJtzOhE6/L30ry0uaWLAjIXQQZvTKtHnJVm+sCzBkQc=;
        b=g1C9zReZykwnHPreZdHmP+71ORV2Kk5V+Mlk2VuFx3UtBigXhYbVhrS7VfZv/pIJkf
         N5LqRPpKBG9KvN3fl3sMOaY4i5h+zF5JfqRDV9GW96hJ0bzMAf6bLlnUCw1Zu8s0EFIa
         Lwhxbbgs892tEBtA1qI6zsAFukgcFwpNfOURFMjSoeXNtlBJjw+gmsxRtrmqP9x9WtFq
         rZloSKRuArJaf832NVz9CmZwD+V3g3hdi7c8yY+uhq1tlx4gQGv4M9oSy4dnWqjDOy/G
         lvRW1tkd3Gykd2fXWuhtSNJun1XHoaFE6SeqGeml4HkCbqbcyLRekrq8Wz5T2nbJ7agT
         LmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJtzOhE6/L30ry0uaWLAjIXQQZvTKtHnJVm+sCzBkQc=;
        b=Hz2mmmL3BKV7dWZcHkeG6Dd7s6OEz20fga2JGWMkadJktiI9oyMbW1NA7gFUozrevF
         Ba8bNYls8PL6Z+1KWVVuMcDIP97VyAqklOVs3kF6/RS+f2wRtw6+Ii7sN7ikeTy58aJ4
         1y9aGyvnWj5losEmMSnaHg1jcQsfZkUVz4Kwnn0AhDSiiRu/SHCyJ7JMJniqjeGrTzL2
         5cunJsaTycfbGZcXrB+ABaUO3jMbXdb3Gx1pValpLQ17vutwCacz9TK0jaWyRzsA0aDF
         KZhfBesqY4csTeAYUJsl+cNCNzNUZ96Ha2UPInUt028hxqR8T0/AR8wfoTWNCnidLNlS
         NPgw==
X-Gm-Message-State: ACrzQf3rbH/VW/H/1Ig0WFYPiVxYDmtIwsnil+VrEujiQaeM8Yr0kC9N
        X5RXZSwPrbtxFkkdY4KIBaQqUXgtaGGtF1GYqwCAUiDG
X-Google-Smtp-Source: AMsMyM4jjuFrlpqBqyFRhAzTZBKokkpHZpdKZ5Rkt35nql6+sCJLV89w05XmokGXcuGbrRTBVVtbaTEIwG7XIxlogbU=
X-Received: by 2002:a9d:6645:0:b0:661:b778:41b8 with SMTP id
 q5-20020a9d6645000000b00661b77841b8mr25371917otm.233.1666894314391; Thu, 27
 Oct 2022 11:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221026161935.6491-1-afd@ti.com>
In-Reply-To: <20221026161935.6491-1-afd@ti.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 Oct 2022 14:11:43 -0400
Message-ID: <CADnq5_OLHbGrq-hTFpyUfawHMwMRAkT84-coAfCweKbPeSZBrA@mail.gmail.com>
Subject: Re: [PATCH v3] drm: Move radeon and amdgpu Kconfig options into their directories
To:     Andrew Davis <afd@ti.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Oct 26, 2022 at 12:31 PM Andrew Davis <afd@ti.com> wrote:
>
> Most Kconfig options to enable a driver are in the Kconfig file
> inside the relevant directory, move these two to the same.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>
> Changes from v2:
>  - Rebased on latest
>
> Changes from v1:
>  - Fix whitespace issue pointed out by Randy
>
>  drivers/gpu/drm/Kconfig            | 57 ------------------------------
>  drivers/gpu/drm/amd/amdgpu/Kconfig | 29 +++++++++++++++
>  drivers/gpu/drm/radeon/Kconfig     | 30 ++++++++++++++++
>  3 files changed, 59 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index fa986075e8fb..9c2d9495cb3c 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -233,65 +233,8 @@ source "drivers/gpu/drm/i2c/Kconfig"
>
>  source "drivers/gpu/drm/arm/Kconfig"
>
> -config DRM_RADEON
> -       tristate "ATI Radeon"
> -       depends on DRM && PCI && MMU
> -       depends on AGP || !AGP
> -       select FW_LOADER
> -       select DRM_DISPLAY_DP_HELPER
> -       select DRM_DISPLAY_HELPER
> -        select DRM_KMS_HELPER
> -        select DRM_TTM
> -       select DRM_TTM_HELPER
> -       select SND_HDA_COMPONENT if SND_HDA_CORE
> -       select POWER_SUPPLY
> -       select HWMON
> -       select BACKLIGHT_CLASS_DEVICE
> -       select INTERVAL_TREE
> -       # radeon depends on ACPI_VIDEO when ACPI is enabled, for select t=
o work
> -       # ACPI_VIDEO's dependencies must also be selected.
> -       select INPUT if ACPI
> -       select ACPI_VIDEO if ACPI
> -       # On x86 ACPI_VIDEO also needs ACPI_WMI
> -       select X86_PLATFORM_DEVICES if ACPI && X86
> -       select ACPI_WMI if ACPI && X86
> -       help
> -         Choose this option if you have an ATI Radeon graphics card.  Th=
ere
> -         are both PCI and AGP versions.  You don't need to choose this t=
o
> -         run the Radeon in plain VGA mode.
> -
> -         If M is selected, the module will be called radeon.
> -
>  source "drivers/gpu/drm/radeon/Kconfig"
>
> -config DRM_AMDGPU
> -       tristate "AMD GPU"
> -       depends on DRM && PCI && MMU
> -       select FW_LOADER
> -       select DRM_DISPLAY_DP_HELPER
> -       select DRM_DISPLAY_HDMI_HELPER
> -       select DRM_DISPLAY_HELPER
> -       select DRM_KMS_HELPER
> -       select DRM_SCHED
> -       select DRM_TTM
> -       select DRM_TTM_HELPER
> -       select POWER_SUPPLY
> -       select HWMON
> -       select BACKLIGHT_CLASS_DEVICE
> -       select INTERVAL_TREE
> -       select DRM_BUDDY
> -       # amdgpu depends on ACPI_VIDEO when ACPI is enabled, for select t=
o work
> -       # ACPI_VIDEO's dependencies must also be selected.
> -       select INPUT if ACPI
> -       select ACPI_VIDEO if ACPI
> -       # On x86 ACPI_VIDEO also needs ACPI_WMI
> -       select X86_PLATFORM_DEVICES if ACPI && X86
> -       select ACPI_WMI if ACPI && X86
> -       help
> -         Choose this option if you have a recent AMD Radeon graphics car=
d.
> -
> -         If M is selected, the module will be called amdgpu.
> -
>  source "drivers/gpu/drm/amd/amdgpu/Kconfig"
>
>  source "drivers/gpu/drm/nouveau/Kconfig"
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amd=
gpu/Kconfig
> index 7777d55275de..5fcd510f1abb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -1,4 +1,33 @@
>  # SPDX-License-Identifier: MIT
> +
> +config DRM_AMDGPU
> +       tristate "AMD GPU"
> +       depends on DRM && PCI && MMU
> +       select FW_LOADER
> +       select DRM_DISPLAY_DP_HELPER
> +       select DRM_DISPLAY_HDMI_HELPER
> +       select DRM_DISPLAY_HELPER
> +       select DRM_KMS_HELPER
> +       select DRM_SCHED
> +       select DRM_TTM
> +       select DRM_TTM_HELPER
> +       select POWER_SUPPLY
> +       select HWMON
> +       select BACKLIGHT_CLASS_DEVICE
> +       select INTERVAL_TREE
> +       select DRM_BUDDY
> +       # amdgpu depends on ACPI_VIDEO when ACPI is enabled, for select t=
o work
> +       # ACPI_VIDEO's dependencies must also be selected.
> +       select INPUT if ACPI
> +       select ACPI_VIDEO if ACPI
> +       # On x86 ACPI_VIDEO also needs ACPI_WMI
> +       select X86_PLATFORM_DEVICES if ACPI && X86
> +       select ACPI_WMI if ACPI && X86
> +       help
> +         Choose this option if you have a recent AMD Radeon graphics car=
d.
> +
> +         If M is selected, the module will be called amdgpu.
> +
>  config DRM_AMDGPU_SI
>         bool "Enable amdgpu support for SI parts"
>         depends on DRM_AMDGPU
> diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kcon=
fig
> index 52819e7f1fca..2267c501f724 100644
> --- a/drivers/gpu/drm/radeon/Kconfig
> +++ b/drivers/gpu/drm/radeon/Kconfig
> @@ -1,4 +1,34 @@
>  # SPDX-License-Identifier: MIT
> +
> +config DRM_RADEON
> +       tristate "ATI Radeon"
> +       depends on DRM && PCI && MMU
> +       depends on AGP || !AGP
> +       select FW_LOADER
> +       select DRM_DISPLAY_DP_HELPER
> +       select DRM_DISPLAY_HELPER
> +       select DRM_KMS_HELPER
> +       select DRM_TTM
> +       select DRM_TTM_HELPER
> +       select SND_HDA_COMPONENT if SND_HDA_CORE
> +       select POWER_SUPPLY
> +       select HWMON
> +       select BACKLIGHT_CLASS_DEVICE
> +       select INTERVAL_TREE
> +       # radeon depends on ACPI_VIDEO when ACPI is enabled, for select t=
o work
> +       # ACPI_VIDEO's dependencies must also be selected.
> +       select INPUT if ACPI
> +       select ACPI_VIDEO if ACPI
> +       # On x86 ACPI_VIDEO also needs ACPI_WMI
> +       select X86_PLATFORM_DEVICES if ACPI && X86
> +       select ACPI_WMI if ACPI && X86
> +       help
> +         Choose this option if you have an ATI Radeon graphics card.  Th=
ere
> +         are both PCI and AGP versions.  You don't need to choose this t=
o
> +         run the Radeon in plain VGA mode.
> +
> +         If M is selected, the module will be called radeon.
> +
>  config DRM_RADEON_USERPTR
>         bool "Always enable userptr support"
>         depends on DRM_RADEON
> --
> 2.37.3
>
