Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0175369EFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBVHz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBVHz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:55:57 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17522BEF2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:55:55 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id l15so9000920pls.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBgzLfkXpKOGfd/1eNx8Vyt8q2pJnQcGFP33kaJSZLo=;
        b=bKcnv4mE5FYO28aQVhL4l7jvPYfuxRvwJx4aDOMpVX7i7lTxPjZ2zeB/msNGjCoAUS
         9BWfwGlpf4nOVynX5qpqDIcuFnNCx1ZYDUxfE0cP0TsmymLnw467Im4PI/aPWvfGTOTq
         fYnOFo4Nyhdr7Pzf7P3ljnJxv/HDvkXFr7eog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBgzLfkXpKOGfd/1eNx8Vyt8q2pJnQcGFP33kaJSZLo=;
        b=We3KkIhLijzkfBMZFOrVhf3T7VefX+hsv/wNAiKLak1zr1Ue9AvY+Zod16fkTlYDaZ
         S0dbVEcs+lm521AARHZstKOn3b2hXTvkeH25iBhEv+84wEg+cBpZGZHfL9TInF3d5rgE
         nQiVUpRAcQfnwcz20A6ahpyLcNJoRF1yNSJYtyLXeD+hrm+ddL87u6BwVF65XvPNNATq
         /PdOqMcoMim/2CVBnuk4oj1dKpKbMexgJooX1kY5RD4jfcu8p3xjzEtCIcXbJzplJSt/
         t3vdx4zyQhuSyXWKPm2kqjMzT77oRkbBwZhOW6zV1HVBUmApBfABtyMi9/2e4FFy4SE+
         2eMA==
X-Gm-Message-State: AO0yUKWTETLSheSQBlHSphqxDAcCRxZrXK3PZX7jSIX3Wg/g6EvbgP3o
        u4R5Ixo3U2h046v7ySEv5ab/TA==
X-Google-Smtp-Source: AK7set+DvRSC/UTE3/Bo65NIi9ejlfvJh5OTnIy8q82XRhMInMhg/LrhSdfTTPAcfKctZav/mMZuWQ==
X-Received: by 2002:a17:903:110e:b0:19c:ac96:223b with SMTP id n14-20020a170903110e00b0019cac96223bmr509904plh.40.1677052555089;
        Tue, 21 Feb 2023 23:55:55 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:ddae:8a07:7ed9:423d])
        by smtp.gmail.com with ESMTPSA id x24-20020a170902821800b001947222676csm5009278pln.249.2023.02.21.23.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 23:55:54 -0800 (PST)
Date:   Wed, 22 Feb 2023 15:55:50 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 00/10] Panfrost: Improve and add MediaTek SoCs support
Message-ID: <Y/XKhg+wultVbEWW@google.com>
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 04:37:30PM +0100, AngeloGioacchino Del Regno wrote:
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
> AngeloGioacchino Del Regno (6):
>   dt-bindings: gpu: mali-bifrost: Split out MediaTek power-domains
>     variation
>   dt-bindings: gpu: mali-bifrost: Allow up to 5 power domains for MT8192
>   dt-bindings: gpu: mali-bifrost: Add compatible for MT8195 SoC
>   dt-bindings: gpu: mali-bifrost: Add new MT8183 compatible
>   dt-bindings: gpu: mali-bifrost: Add a compatible for MediaTek MT8186
>   drm/panfrost: Add new compatible for Mali on the MT8183 SoC
> 
> Chen-Yu Tsai (1):
>   dt-bindings: gpu: mali-bifrost: Add power-domain-names to base schema
> 
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 67 ++++++++++++++++++-
>  drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c       | 28 ++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c       |  8 +++
>  4 files changed, 101 insertions(+), 4 deletions(-)

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8183, MT8186, MT8192, MT8195 with glmark2.
