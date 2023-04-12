Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E126E0050
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjDLVDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDLVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:03:51 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149435244;
        Wed, 12 Apr 2023 14:03:49 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1842eb46746so15279579fac.4;
        Wed, 12 Apr 2023 14:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333428; x=1683925428;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v+uWMvL1JjVQ02tgsbvMPzDV91ZJCdH7YAirSLH3VxE=;
        b=jDipOKkNpy/FDRZAf9NtjrwmF3yG9E9eCMQlyqDTefHof3uidhGjaYKH5WiAqRHoZR
         Tenf10K4YFI76JRTt333kqxkCeBY3WvnWZqPUFfpNeRkLuH/st92Ri/+pQ24i3Kt36SR
         QxoybvdGnf9nk6/hnzuC6mYaWqePYm2BJZGh8xY+aUqpyyrkQ4CGL09RdhZGowt54lUB
         u8J5P1xIv0nauQ0oJTScqz5Fu5AZH5bEisPIwPq9TMRz1ELYhtKJMothXsefF1X8Ud/S
         SF1v6jF6COIc2JBXPBuKXvtnu7Tm6m7LsFVyzwbtB3wZSJ9KDJ9ykiQ7UGElCYFUyfXR
         kbBw==
X-Gm-Message-State: AAQBX9esDEZiCUoS0N4B49g9z6g4nXSeTxm96WDa+HaUGIRN91lpX17x
        QPp0+zeW+BkNQtA44jH/IQ==
X-Google-Smtp-Source: AKy350ZGedVWO+UH7Kb/1/nuC17CI2iBehcLz3EF/x0xZ+eL9nRB9pTxfFGFz39F3+ADZj4wEBMRIg==
X-Received: by 2002:a05:6871:592:b0:177:c62f:b059 with SMTP id u18-20020a056871059200b00177c62fb059mr104163oan.49.1681333428270;
        Wed, 12 Apr 2023 14:03:48 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ef42-20020a0568701aaa00b0018449ae08cesm65854oab.13.2023.04.12.14.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:03:47 -0700 (PDT)
Received: (nullmailer pid 3200531 invoked by uid 1000);
        Wed, 12 Apr 2023 21:03:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-pwm@vger.kernel.org, chunkuang.hu@kernel.org,
        linux-phy@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, thierry.reding@gmail.com,
        ck.hu@mediatek.com, kishon@kernel.org, chunfeng.yun@mediatek.com,
        matthias.bgg@gmail.com, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vkoul@kernel.org,
        linux-mediatek@lists.infradead.org, houlong.wei@mediatek.com,
        ~postmarketos/upstreaming@lists.sr.ht, jitao.shi@mediatek.com,
        linux-kernel@vger.kernel.org, airlied@gmail.com,
        p.zabel@pengutronix.de, jassisinghbrar@gmail.com,
        xinlei.lee@mediatek.com, robh+dt@kernel.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, kernel@collabora.com,
        u.kleine-koenig@pengutronix.de
In-Reply-To: <20230412112739.160376-6-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-6-angelogioacchino.delregno@collabora.com>
Message-Id: <168133319295.3190915.16401727674710547355.robh@kernel.org>
Subject: Re: [PATCH 05/27] dt-bindings: display: mediatek: dsi: Add
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


On Wed, 12 Apr 2023 13:27:17 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795, using the same
> DSI block as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,dsi.yaml        | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412112739.160376-6-angelogioacchino.delregno@collabora.com


dsi@1400c000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

dsi@14014000: 'port' is a required property
	arch/arm64/boot/dts/mediatek/mt8183-evb.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dtb

dsi@14014000: Unevaluated properties are not allowed ('ports' was unexpected)
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dtb

dsi@1401b000: 'port' is a required property
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb

dsi@1401b000: Unevaluated properties are not allowed ('ports' was unexpected)
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb

