Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAAC6E0070
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjDLVEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDLVEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:04:21 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203C4729F;
        Wed, 12 Apr 2023 14:04:20 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id u24-20020a9d7218000000b006a413c893c8so2422985otj.10;
        Wed, 12 Apr 2023 14:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333438; x=1683925438;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xhMw93yysyOYrwKp1hI3dRgsA4+S2zDf16pTeQ0jQhE=;
        b=QKsxqnYMxAuUvtO1qHS9bWSWE0Z0d3gsFYhGzxIzne7t/MRIRbpKffRXZRwY+tGYxz
         2KQ/LRuUMKRGv4sn3aJNWxfSpn2HjvZKIVpLsLO0//MVao9TPphSzISUCC/ifS5e4Vk9
         G5HctMEPlzaXH0D58F8Xd2ZS6kuwRX3mz92GLZ9w5ahgL/grz5vbECO67KPSO/WpxQ4v
         egXgcy5Pk+cU4A/hYMwV+KEGyJSH6KHZTGmlfzdQl3rBt6IoYCewDcfygQpy78ErgVS4
         frP2egEThgctaxxioxUmGOT41Z6Ashr8PQVxmrXx939zhO0HY6DQt2+LGLaTOyHxkOQu
         Yzog==
X-Gm-Message-State: AAQBX9c0f0WTayzkekXCkamQdt63QBKavhcMrq+w5GKOxbMBrLSebXN0
        l/xbHN3flfSVzOx7rLRT+g==
X-Google-Smtp-Source: AKy350bDX+UH3xmkYuUvscW0CL6cCSZRAiDFFLGLOqiUOEqq1NjVCfl2xG/WT5gMBlmEZh0qKgWGKg==
X-Received: by 2002:a05:6830:146:b0:6a1:3101:8e29 with SMTP id j6-20020a056830014600b006a131018e29mr9619627otp.18.1681333437931;
        Wed, 12 Apr 2023 14:03:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e26-20020a0568301e5a00b0069fa776d3c2sm54079otj.18.2023.04.12.14.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:03:57 -0700 (PDT)
Received: (nullmailer pid 3200535 invoked by uid 1000);
        Wed, 12 Apr 2023 21:03:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, chunfeng.yun@mediatek.com,
        kishon@kernel.org, chunkuang.hu@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-mediatek@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht, matthias.bgg@gmail.com,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        kernel@collabora.com, u.kleine-koenig@pengutronix.de,
        daniel@ffwll.ch, jitao.shi@mediatek.com, linux-pwm@vger.kernel.org,
        robh+dt@kernel.org, jassisinghbrar@gmail.com,
        phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, ck.hu@mediatek.com, vkoul@kernel.org,
        houlong.wei@mediatek.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, p.zabel@pengutronix.de,
        xinlei.lee@mediatek.com
In-Reply-To: <20230412112739.160376-8-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-8-angelogioacchino.delregno@collabora.com>
Message-Id: <168133319439.3191194.3289065027670891182.robh@kernel.org>
Subject: Re: [PATCH 07/27] dt-bindings: display: mediatek: rdma: Add
 compatible for MediaTek MT6795
Date:   Wed, 12 Apr 2023 16:03:44 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Apr 2023 13:27:19 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's RDMA block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,rdma.yaml   | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412112739.160376-8-angelogioacchino.delregno@collabora.com


rdma@14008000: 'power-domains' is a required property
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

rdma@14012000: 'power-domains' is a required property
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

