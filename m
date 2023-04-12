Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E766E004B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDLVDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDLVDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:03:48 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9AE359A;
        Wed, 12 Apr 2023 14:03:47 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id q33-20020a056830442100b006a419d3fd20so1747645otv.7;
        Wed, 12 Apr 2023 14:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333426; x=1683925426;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TfFMpWgQMG0IdQ2eBeXK2Tul1Mki7+boKfuvZh6DHJo=;
        b=WWX7N2fi1kLLcSAt81TwoO/nj87h0uSceccZiangotpgL3GWN8rhaSjBikXfCtf4Gq
         zQwXY/ZxB7yvHxTZ8pJd9l/ce9USVWfD4YOxwS4PimFNIXoOucrNB5ZT0ARc69nsB04p
         3NaeYgM1qL93kUN6210i94a5Je8wifWbxGI9twwTLAt1Hc+NRsGyg5ny6/Y9LDTJ9odO
         Cg5jDDGA2Lqk1nJcMY2rdjQ2i4LjoZjQlhDZjkGWfoLcnj9Y7KdCzC8l5g4EHA3tWrm8
         1KCxnHx1tm1vuV/q2sDYMjX4XAbnct+M4FnvQ2uWfehxZFxq7zC/tLHET/ElnQSscg0B
         cBkA==
X-Gm-Message-State: AAQBX9cQ7UIQWK8pLhYr2xehgF3ynx292Og/DnOdExkwKZvJWhtIw5wx
        FAjBIJ7H9lIYWNN+WY9+Cg==
X-Google-Smtp-Source: AKy350YLhEpo7rXHjTV6gXj47sYFzm89X6rddWa9+uaqMiDd86/UG5bnCUKz49WwfP/Noj0SnCMTXg==
X-Received: by 2002:a05:6830:1d78:b0:69f:a557:fa01 with SMTP id l24-20020a0568301d7800b0069fa557fa01mr7090154oti.9.1681333426607;
        Wed, 12 Apr 2023 14:03:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l10-20020a0568301d6a00b006a14579a8besm41057oti.43.2023.04.12.14.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:03:45 -0700 (PDT)
Received: (nullmailer pid 3200526 invoked by uid 1000);
        Wed, 12 Apr 2023 21:03:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
        kernel@collabora.com, chunkuang.hu@kernel.org,
        linux-phy@lists.infradead.org, matthias.bgg@gmail.com,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        houlong.wei@mediatek.com, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, vkoul@kernel.org,
        chunfeng.yun@mediatek.com, daniel@ffwll.ch, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, xinlei.lee@mediatek.com,
        airlied@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jassisinghbrar@gmail.com
In-Reply-To: <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
Message-Id: <168133318912.3190428.16120880490622098945.robh@kernel.org>
Subject: Re: [PATCH 01/27] dt-bindings: pwm: Add compatible for MediaTek
 MT6795
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


On Wed, 12 Apr 2023 13:27:13 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's display PWM
> block: this is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412112739.160376-2-angelogioacchino.delregno@collabora.com


pwm@1100e000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
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
	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dtb

pwm@1400a000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

pwm@1401e000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

pwm@1401f000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

