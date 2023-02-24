Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488F26A18F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBXJnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBXJnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:43:17 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D131D924
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:43:16 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id a3so7597551vsi.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kbnXOoIvCwre/+4QX5AN/9RjsRsacNnY7HA3dADS82M=;
        b=SSI0N/ZzzZtFN3NC9K9DXhTBJeR3c8kHwLA5fTMTff0SyrOe86wwffe3Djlo0gYd0f
         6g64G/BHBOijusArADG/hxf6rlwCGwFkRKhecjiHfm1e9LFUFnB/sJTf5NUQq15Ht5UV
         Gc1zD7tqJ1k8N8zfsQK6IWmeY1a5VmYBokIxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbnXOoIvCwre/+4QX5AN/9RjsRsacNnY7HA3dADS82M=;
        b=21jLpuSFslOobuhnqsFnpyUhCWlOIXr6e0Vqv/i4UhxF5qMPWLQ+sWf8cbwRMbRL9l
         b2EJPIWofj7QtdDo95cLXHrJu4snyVkcrQyP5Wylsi+aGDwM5612ev6H7tVUFgt+zfs6
         9ctApMHRy/6K/o/Q4JdcbJDTyN5s98HiNiNAwtYmtOrVEH/LSqStPZFU3ZYG9SWRpkaL
         /NnFwwmM8evNlA17KEXCZfCvkZ8vJFGjqxEClkE7n7YQ8G2NMz3JjKtdhv0U+TiDR5h5
         gmzFKXa/xKNr3A1ANQz+vL/zQJaU7EwLVQ91UutwLna9j6jyyOLsbef32idQ6M1B7ch/
         Y6Ug==
X-Gm-Message-State: AO0yUKXRJa9j6yqjl9Hvn3+h629e55MqjfWkYR+SxZEDFsEjZy5sFfCp
        dzN5zGGK7V1XkGPtBWBzNCUDN/g1j+8nYE8s90ys4g==
X-Google-Smtp-Source: AK7set/KpmOufYOT89amku4MuWdzdnK+6D2wu9CS/8jhVNSAh5wdSQfoQxCA2kg+qARRnk13Skua4AsQwc/ET0fx5nE=
X-Received: by 2002:a67:fbd2:0:b0:411:fff6:3cc4 with SMTP id
 o18-20020a67fbd2000000b00411fff63cc4mr2067609vsr.3.1677231795727; Fri, 24 Feb
 2023 01:43:15 -0800 (PST)
MIME-Version: 1.0
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:43:04 +0800
Message-ID: <CAGXv+5Gcnx4cw891hDTsSzMQsw+NAR7Le7FkUejEJCL-MMsktg@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Panfrost: Improve and add MediaTek SoCs support
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:34 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v3:
>  - Changed MT8186 bindings to declare only two power domains
>  - Added a commit introducing MT8186 specific platform data to
>    panfrost_drv
>
> Changes in v2:
>  - Add power-domain-names commit from Chen-Yu to the series
>  - Kept sram-supply in base schema, overridden for non-MediaTek
>  - Added Reviewed-by tags from Steven Price to the driver commits
>    (as released in reply to v1's cover letter - thanks!)
>
> This series adds support for new MediaTek SoCs (MT8186/MT8192/MT8195)
> and improves MT8183 support: since the mtk-regulator-coupler driver
> was picked, it is now useless for Panfrost to look for, and manage,
> two regulators (GPU Vcore and GPU SRAM) on MediaTek;
>
> The aforementioned driver will take care of keeping the voltage
> relation (/constraints) of the two regulators on its own when a
> voltage change request is sent to the Vcore, solving the old time
> issue with not working DVFS on Panfrost+MediaTek (due to devfreq
> supporting only single regulator).
>
> In the specific case of MT8183, in order to not break the ABI, it
> was necessary to add a new compatible for enabling DVFS.
>
> Alyssa Rosenzweig (3):
>   drm/panfrost: Increase MAX_PM_DOMAINS to 5
>   drm/panfrost: Add the MT8192 GPU ID
>   drm/panfrost: Add mediatek,mt8192-mali compatible
>
> AngeloGioacchino Del Regno (7):
>   dt-bindings: gpu: mali-bifrost: Split out MediaTek power-domains
>     variation
>   dt-bindings: gpu: mali-bifrost: Allow up to 5 power domains for MT8192
>   dt-bindings: gpu: mali-bifrost: Add compatible for MT8195 SoC
>   dt-bindings: gpu: mali-bifrost: Add new MT8183 compatible
>   dt-bindings: gpu: mali-bifrost: Add support for MediaTek MT8186
>   drm/panfrost: Add new compatible for Mali on the MT8183 SoC
>   drm/panfrost: Add support for Mali on the MT8186 SoC
>
> Chen-Yu Tsai (1):
>   dt-bindings: gpu: mali-bifrost: Add power-domain-names to base schema

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8183 Juniper, MT8192 Hayato, MT8195 Tomato, MT8186 not-yet-upstreamed
device.
