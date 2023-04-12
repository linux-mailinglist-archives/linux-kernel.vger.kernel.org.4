Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F359A6E005C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjDLVEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDLVD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:03:56 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6237D9E;
        Wed, 12 Apr 2023 14:03:54 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id f7-20020a4ab647000000b0054101f316c7so5288967ooo.13;
        Wed, 12 Apr 2023 14:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333433; x=1683925433;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6vQDOyuL4ygu5OBRBw9x0Lns1GFB34OJmrSDqZyDSWY=;
        b=VUdzEMPWzfSOy31GW5GLxqaVnQ5fRX09YUfvIwhHVlPTQZNn+N9uLKsjqT5fWZglJi
         uJhV0euAOLFvA+VYT4Ka94t0zcZzQJ/ieLu7ZRF1taF+fpHLniQCTvDZ0axQnriJPDYL
         mZCqoCw/ypiIOwY93qE8SCBdmccOEK+JLIagS7f1G/IEVRFlchKUwlhrK3j+x8pj2cR4
         oWka/iXrkdzi1v1fLx7lKh40PLJSbMZLPbMPg92e2vNwAX7GJLettzXbKCzsCNblW0NC
         HDrbIGEO6sruHC2+UHuWxuYkR05N1ONsSSBJNS3wtMvEnh3z08HS7KHJ/cSFro3G70TP
         4H6Q==
X-Gm-Message-State: AAQBX9eVEPQTP+9OV0TbTnwEqgESHjxBtznznvqoKV/MmkFZt3b5txMa
        fOKj62QG+3qy2YZJn82nGw==
X-Google-Smtp-Source: AKy350aBfPKBwNkQTAKX6pidG5KWNDP9kOhzMY+0ltkEGSly040cf+gAtSbh55AqCxwHEjPwevEIEQ==
X-Received: by 2002:a4a:454b:0:b0:53e:5698:c0d2 with SMTP id y72-20020a4a454b000000b0053e5698c0d2mr1614999ooa.7.1681333433174;
        Wed, 12 Apr 2023 14:03:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 185-20020a4a01c2000000b0051aa196ac82sm7508974oor.14.2023.04.12.14.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:03:52 -0700 (PDT)
Received: (nullmailer pid 3200529 invoked by uid 1000);
        Wed, 12 Apr 2023 21:03:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, daniel@ffwll.ch,
        linux-mediatek@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-phy@lists.infradead.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        jassisinghbrar@gmail.com, dri-devel@lists.freedesktop.org,
        ck.hu@mediatek.com, linux-kernel@vger.kernel.org,
        kishon@kernel.org, chunkuang.hu@kernel.org,
        chunfeng.yun@mediatek.com, thierry.reding@gmail.com,
        linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
        xinlei.lee@mediatek.com, airlied@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com,
        jitao.shi@mediatek.com, u.kleine-koenig@pengutronix.de,
        houlong.wei@mediatek.com, matthias.bgg@gmail.com
In-Reply-To: <20230412112739.160376-4-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-4-angelogioacchino.delregno@collabora.com>
Message-Id: <168133319106.3190682.10651793127592676554.robh@kernel.org>
Subject: Re: [PATCH 03/27] dt-bindings: display: mediatek: dpi: Add
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


On Wed, 12 Apr 2023 13:27:15 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for the MediaTek Helio X10 MT6795 SoC, using
> the same parameters as MT8183.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,dpi.yaml        | 23 +++++++++++--------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412112739.160376-4-angelogioacchino.delregno@collabora.com


dpi@14014000: Additional properties are not allowed ('ports' was unexpected)
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

dpi@14014000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

dpi@14014000: 'port' is a required property
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

dpi@1401d000: Additional properties are not allowed ('power-domains' was unexpected)
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

dp-intf@1c015000: clock-names:0: 'pixel' was expected
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dtb
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dtb
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dtb
	arch/arm64/boot/dts/mediatek/mt8195-demo.dtb
	arch/arm64/boot/dts/mediatek/mt8195-evb.dtb

dp-intf@1c015000: clock-names:1: 'engine' was expected
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dtb
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dtb
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dtb
	arch/arm64/boot/dts/mediatek/mt8195-demo.dtb
	arch/arm64/boot/dts/mediatek/mt8195-evb.dtb

dp-intf@1c113000: Additional properties are not allowed ('power-domains' was unexpected)
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dtb
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dtb
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dtb
	arch/arm64/boot/dts/mediatek/mt8195-demo.dtb
	arch/arm64/boot/dts/mediatek/mt8195-evb.dtb

dp-intf@1c113000: clock-names:0: 'pixel' was expected
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dtb
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dtb
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dtb
	arch/arm64/boot/dts/mediatek/mt8195-demo.dtb
	arch/arm64/boot/dts/mediatek/mt8195-evb.dtb

dp-intf@1c113000: clock-names:1: 'engine' was expected
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dtb
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dtb
	arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dtb
	arch/arm64/boot/dts/mediatek/mt8195-demo.dtb
	arch/arm64/boot/dts/mediatek/mt8195-evb.dtb

