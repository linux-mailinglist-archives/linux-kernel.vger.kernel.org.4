Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129026ADA58
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCGJ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCGJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:28:43 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0388D12BED
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:28:33 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id m10so11747324vso.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678181312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8hCXi92t8UQWDIrI0h9Kq66J5huPcm593ZnPvTm7EU=;
        b=Kq6v5vyHNzwDdpJBI/Fg6NsbbSsHB4jx62ngcaxoDzhdAXMwcPHx5IVVZ7G8ttpjnW
         Jpi4j3nm/BJE1WdcQW5MqTY2odSDn42ea1e8UvkTyjXj38KHkFtYby6TmTES2GME/5YB
         JHQnmryVytPCqSib2AR4rhCLn/9K5TGl7uFkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678181312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8hCXi92t8UQWDIrI0h9Kq66J5huPcm593ZnPvTm7EU=;
        b=54ciYfrFCsNgiS/0BlGAll/drXmYMlaFw7/TZwvG61XMbqaPEhCA4gfcm6K6silLLo
         kPNkF6fIvUQwY7uZc1nY/ZPNKYW3Nnp9eaPa74hl5WLdTSODsjoRtxvSvpLj5N2SH655
         WkYvGbd69EPKz4uJ+un/UWinxfoRJDb3Rkug0QZui6qLIgg/qYDDP/m53gP/hbuhq/vQ
         EhROpwSxi71vZJLo4nOXH7exOgcseYluoZyZHykEsxNyYp3IlHD4KQb+/BlpVQWSgClf
         50O0MgB8alzykSoBhOoMjbCuXA2R5eERohYPKIAegS4IwOzbTBgef+Ko6SEs+ZLaJv5E
         71NQ==
X-Gm-Message-State: AO0yUKWZAn4950Wip6n1eD53xlQL3xiiePCSBWrl5TBnXTcn8bC2pRqO
        yCFDnSSCVJA1rWD/lsC8r3HRQbik1E7UINY7KQCqXQ==
X-Google-Smtp-Source: AK7set9eIg6NIfG9gEV676xYVLWLVEZOK8JzoWyEtpVJ/E62wiFOnpUhU/HAx7w/NOfUgWkwWQmAxz8qnu+k2EoMdEA=
X-Received: by 2002:a67:e2c7:0:b0:412:2f46:4073 with SMTP id
 i7-20020a67e2c7000000b004122f464073mr8774638vsm.3.1678181312119; Tue, 07 Mar
 2023 01:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20230228102610.707605-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228102610.707605-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 17:28:21 +0800
Message-ID: <CAGXv+5FVZWFcYNrsgMs_0s+J5E-ijxKjf9MRsLXhC7nWNj5pPA@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Panfrost: Improve and add MediaTek SoCs support
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 6:26=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v4:
>  - Refactored power-domains and power-domain-names exclusions as
>    suggested by Krzysztof
>  - Small changes in MT8192 bindings addition
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
> AngeloGioacchino Del Regno (9):
>   dt-bindings: gpu: mali-bifrost: Split out MediaTek power-domains
>     variation
>   dt-bindings: gpu: mali-bifrost: Set power-domains maxItems to 5
>   dt-bindings: gpu: mali-bifrost: Fix power-domain-names validation
>   dt-bindings: gpu: mali-bifrost: Add sub-schema for MT8192's power
>     domains
>   dt-bindings: gpu: mali-bifrost: Add new MT8183 compatible
>   dt-bindings: gpu: mali-bifrost: Add support for MediaTek MT8186
>   dt-bindings: gpu: mali-bifrost: Add compatible for MT8195 SoC
>   drm/panfrost: Add new compatible for Mali on the MT8183 SoC
>   drm/panfrost: Add support for Mali on the MT8186 SoC

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8183, MT8186, MT8192 and MT8195 Chromebooks.

But the cover letter wasn't properly threaded with the series.

BTW, Angelo, I see that Panfrost keeps the GPU regulator enabled, but
the power domains, and thus the SRAM regulator, get powered off when
the GPU is not in use. There doesn't seem to be any damaging effects,
but I worry about idle power consumption.

ChenYu

>  .../bindings/gpu/arm,mali-bifrost.yaml        | 80 ++++++++++++++++++-
>  drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c       | 37 +++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c       |  8 ++
>  4 files changed, 123 insertions(+), 4 deletions(-)
>
> --
> 2.39.2
>
