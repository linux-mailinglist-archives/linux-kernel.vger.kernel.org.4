Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2216CBFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjC1M5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjC1M5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:57:15 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E836710D7;
        Tue, 28 Mar 2023 05:57:10 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id r84so7551844oih.11;
        Tue, 28 Mar 2023 05:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680008230;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CHN38CKV1YNJ+8x4NnYyaL0Jc1CcKrEfabSV2H+a5r0=;
        b=Cgex+NzVDqThZb3KwN9eHitnmura2eCk+AFOjEjZw3+w3D8GqT/oY9OEMrG5lbXHst
         mbKyPutW+UyW42woeL7m4IcGt5MqXWxCI8N18BaaRb4xFRGjvQo6c3RtCFB3MPH1WvZf
         JVdSuLX0fdRHYI5XzpXffpGYlTn3bJdDG5GBZIV6CNvmalbMOyoCxzDL0lftZht2WXXs
         bYg3GBGLWlysz7lux63G+JSKxv/aY7WaiXhA1rb6DHxJMhGVs1dmi32GaItsaKMYHiUp
         pneGrnswCZ8/woVggE47TVqvvb7joKN9yvXZsBZxAOlVJ1X4XVVkBTeqkKl4qSMtQbsh
         NZnA==
X-Gm-Message-State: AAQBX9e1KRbVt7jnBoyzJcuv8HAQ0YS+GHr+db7QKfEtpPYNQP0t83Gf
        5tcCiPFBPEBeFKcnlocvgw==
X-Google-Smtp-Source: AKy350Yl3HPzWW3IJKVW7yG7NDuKaMgNUcCS/yR/Swit084hDdFVqxRa5KjuJvl3QP739SlCCjvYIQ==
X-Received: by 2002:a05:6808:1894:b0:389:4be5:d120 with SMTP id bi20-20020a056808189400b003894be5d120mr2474735oib.14.1680008229766;
        Tue, 28 Mar 2023 05:57:09 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p45-20020a4a95f0000000b0051fdb2cba97sm12495494ooi.7.2023.03.28.05.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:57:09 -0700 (PDT)
Received: (nullmailer pid 3017890 invoked by uid 1000);
        Tue, 28 Mar 2023 12:57:07 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-imx@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org,
        linux-gpio@vger.kernel.org, brgl@bgdev.pl, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        stefan@agner.ch, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
References: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
Message-Id: <168000764012.3003619.6871847988878152452.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: fsl-imx-gpio: update
 gpio-ranges
Date:   Tue, 28 Mar 2023 07:57:07 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Mar 2023 13:29:11 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> one is not enough for i.MX8, so enlarge it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230328052912.1957000-1-peng.fan@oss.nxp.com


gpio@10015000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

gpio@10015100: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

gpio@10015200: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

gpio@10015300: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

gpio@10015400: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

gpio@10015500: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

gpio@209c000: gpio-ranges: [[17, 0, 131, 2], [17, 2, 137, 8], [17, 10, 189, 2], [17, 12, 194, 1], [17, 13, 193, 1], [17, 14, 192, 1], [17, 15, 191, 1], [17, 16, 185, 2], [17, 18, 184, 1], [17, 19, 187, 1], [17, 20, 183, 1], [17, 21, 188, 1], [17, 22, 123, 3], [17, 25, 121, 1], [17, 26, 127, 1], [17, 27, 126, 1], [17, 28, 128, 1], [17, 29, 130, 1], [17, 30, 129, 1], [17, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-mamoj.dtb

gpio@209c000: gpio-ranges: [[19, 0, 131, 2], [19, 2, 137, 8], [19, 10, 189, 2], [19, 12, 194, 1], [19, 13, 193, 1], [19, 14, 192, 1], [19, 15, 191, 1], [19, 16, 185, 2], [19, 18, 184, 1], [19, 19, 187, 1], [19, 20, 183, 1], [19, 21, 188, 1], [19, 22, 123, 3], [19, 25, 121, 1], [19, 26, 127, 1], [19, 27, 126, 1], [19, 28, 128, 1], [19, 29, 130, 1], [19, 30, 129, 1], [19, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dtb
	arch/arm/boot/dts/imx6dl-gw5903.dtb
	arch/arm/boot/dts/imx6dl-lanmcu.dtb
	arch/arm/boot/dts/imx6dl-wandboard.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revd1.dtb

gpio@209c000: gpio-ranges: [[20, 0, 131, 2], [20, 2, 137, 8], [20, 10, 189, 2], [20, 12, 194, 1], [20, 13, 193, 1], [20, 14, 192, 1], [20, 15, 191, 1], [20, 16, 185, 2], [20, 18, 184, 1], [20, 19, 187, 1], [20, 20, 183, 1], [20, 21, 188, 1], [20, 22, 123, 3], [20, 25, 121, 1], [20, 26, 127, 1], [20, 27, 126, 1], [20, 28, 128, 1], [20, 29, 130, 1], [20, 30, 129, 1], [20, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-cubox-i.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dtb
	arch/arm/boot/dts/imx6dl-savageboard.dtb

gpio@209c000: gpio-ranges: [[21, 0, 131, 2], [21, 2, 137, 8], [21, 10, 189, 2], [21, 12, 194, 1], [21, 13, 193, 1], [21, 14, 192, 1], [21, 15, 191, 1], [21, 16, 185, 2], [21, 18, 184, 1], [21, 19, 187, 1], [21, 20, 183, 1], [21, 21, 188, 1], [21, 22, 123, 3], [21, 25, 121, 1], [21, 26, 127, 1], [21, 27, 126, 1], [21, 28, 128, 1], [21, 29, 130, 1], [21, 30, 129, 1], [21, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-aristainetos_7.dtb
	arch/arm/boot/dts/imx6dl-b105pv2.dtb
	arch/arm/boot/dts/imx6dl-b105v2.dtb
	arch/arm/boot/dts/imx6dl-b125pv2.dtb
	arch/arm/boot/dts/imx6dl-b125v2.dtb
	arch/arm/boot/dts/imx6dl-b155v2.dtb
	arch/arm/boot/dts/imx6dl-icore.dtb
	arch/arm/boot/dts/imx6dl-icore-rqs.dtb
	arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb

gpio@209c000: gpio-ranges: [[22, 0, 131, 2], [22, 2, 137, 8], [22, 10, 189, 2], [22, 12, 194, 1], [22, 13, 193, 1], [22, 14, 192, 1], [22, 15, 191, 1], [22, 16, 185, 2], [22, 18, 184, 1], [22, 19, 187, 1], [22, 20, 183, 1], [22, 21, 188, 1], [22, 22, 123, 3], [22, 25, 121, 1], [22, 26, 127, 1], [22, 27, 126, 1], [22, 28, 128, 1], [22, 29, 130, 1], [22, 30, 129, 1], [22, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-aristainetos_4.dtb
	arch/arm/boot/dts/imx6dl-gw552x.dtb
	arch/arm/boot/dts/imx6dl-icore-mipi.dtb
	arch/arm/boot/dts/imx6dl-rex-basic.dtb
	arch/arm/boot/dts/imx6dl-riotboard.dtb

gpio@209c000: gpio-ranges: [[23, 0, 131, 2], [23, 2, 137, 8], [23, 10, 189, 2], [23, 12, 194, 1], [23, 13, 193, 1], [23, 14, 192, 1], [23, 15, 191, 1], [23, 16, 185, 2], [23, 18, 184, 1], [23, 19, 187, 1], [23, 20, 183, 1], [23, 21, 188, 1], [23, 22, 123, 3], [23, 25, 121, 1], [23, 26, 127, 1], [23, 27, 126, 1], [23, 28, 128, 1], [23, 29, 130, 1], [23, 30, 129, 1], [23, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-alti6p.dtb
	arch/arm/boot/dts/imx6dl-gw551x.dtb
	arch/arm/boot/dts/imx6dl-gw5904.dtb
	arch/arm/boot/dts/imx6dl-gw5913.dtb
	arch/arm/boot/dts/imx6dl-plybas.dtb
	arch/arm/boot/dts/imx6dl-prtmvt.dtb
	arch/arm/boot/dts/imx6dl-prtvt7.dtb
	arch/arm/boot/dts/imx6dl-ts4900.dtb
	arch/arm/boot/dts/imx6dl-udoo.dtb
	arch/arm/boot/dts/imx6dl-yapp4-draco.dtb
	arch/arm/boot/dts/imx6dl-yapp4-hydra.dtb
	arch/arm/boot/dts/imx6dl-yapp4-orion.dtb
	arch/arm/boot/dts/imx6dl-yapp4-ursa.dtb

gpio@209c000: gpio-ranges: [[24, 0, 131, 2], [24, 2, 137, 8], [24, 10, 189, 2], [24, 12, 194, 1], [24, 13, 193, 1], [24, 14, 192, 1], [24, 15, 191, 1], [24, 16, 185, 2], [24, 18, 184, 1], [24, 19, 187, 1], [24, 20, 183, 1], [24, 21, 188, 1], [24, 22, 123, 3], [24, 25, 121, 1], [24, 26, 127, 1], [24, 27, 126, 1], [24, 28, 128, 1], [24, 29, 130, 1], [24, 30, 129, 1], [24, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-gw51xx.dtb
	arch/arm/boot/dts/imx6dl-gw553x.dtb
	arch/arm/boot/dts/imx6dl-gw5907.dtb
	arch/arm/boot/dts/imx6dl-gw5910.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dtb
	arch/arm/boot/dts/imx6dl-nit6xlite.dtb
	arch/arm/boot/dts/imx6dl-plym2m.dtb
	arch/arm/boot/dts/imx6dl-solidsense.dtb

gpio@209c000: gpio-ranges: [[25, 0, 131, 2], [25, 2, 137, 8], [25, 10, 189, 2], [25, 12, 194, 1], [25, 13, 193, 1], [25, 14, 192, 1], [25, 15, 191, 1], [25, 16, 185, 2], [25, 18, 184, 1], [25, 19, 187, 1], [25, 20, 183, 1], [25, 21, 188, 1], [25, 22, 123, 3], [25, 25, 121, 1], [25, 26, 127, 1], [25, 27, 126, 1], [25, 28, 128, 1], [25, 29, 130, 1], [25, 30, 129, 1], [25, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dtb
	arch/arm/boot/dts/imx6dl-emcon-avari.dtb
	arch/arm/boot/dts/imx6dl-prtrvt.dtb

gpio@209c000: gpio-ranges: [[26, 0, 131, 2], [26, 2, 137, 8], [26, 10, 189, 2], [26, 12, 194, 1], [26, 13, 193, 1], [26, 14, 192, 1], [26, 15, 191, 1], [26, 16, 185, 2], [26, 18, 184, 1], [26, 19, 187, 1], [26, 20, 183, 1], [26, 21, 188, 1], [26, 22, 123, 3], [26, 25, 121, 1], [26, 26, 127, 1], [26, 27, 126, 1], [26, 28, 128, 1], [26, 29, 130, 1], [26, 30, 129, 1], [26, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-apf6dev.dtb
	arch/arm/boot/dts/imx6dl-mba6a.dtb
	arch/arm/boot/dts/imx6dl-mba6b.dtb
	arch/arm/boot/dts/imx6dl-nitrogen6x.dtb
	arch/arm/boot/dts/imx6dl-sabrelite.dtb
	arch/arm/boot/dts/imx6dl-sabresd.dtb
	arch/arm/boot/dts/imx6dl-ts7970.dtb
	arch/arm/boot/dts/imx6dl-vicut1.dtb

gpio@209c000: gpio-ranges: [[27, 0, 131, 2], [27, 2, 137, 8], [27, 10, 189, 2], [27, 12, 194, 1], [27, 13, 193, 1], [27, 14, 192, 1], [27, 15, 191, 1], [27, 16, 185, 2], [27, 18, 184, 1], [27, 19, 187, 1], [27, 20, 183, 1], [27, 21, 188, 1], [27, 22, 123, 3], [27, 25, 121, 1], [27, 26, 127, 1], [27, 27, 126, 1], [27, 28, 128, 1], [27, 29, 130, 1], [27, 30, 129, 1], [27, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-dhcom-picoitx.dtb
	arch/arm/boot/dts/imx6dl-gw560x.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035.dtb
	arch/arm/boot/dts/imx6dl-tx6u-801x.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033.dtb

gpio@209c000: gpio-ranges: [[28, 0, 131, 2], [28, 2, 137, 8], [28, 10, 189, 2], [28, 12, 194, 1], [28, 13, 193, 1], [28, 14, 192, 1], [28, 15, 191, 1], [28, 16, 185, 2], [28, 18, 184, 1], [28, 19, 187, 1], [28, 20, 183, 1], [28, 21, 188, 1], [28, 22, 123, 3], [28, 25, 121, 1], [28, 26, 127, 1], [28, 27, 126, 1], [28, 28, 128, 1], [28, 29, 130, 1], [28, 30, 129, 1], [28, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-colibri-iris.dtb
	arch/arm/boot/dts/imx6dl-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx6dl-gw53xx.dtb
	arch/arm/boot/dts/imx6dl-gw5912.dtb
	arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6dl-pico-dwarf.dtb
	arch/arm/boot/dts/imx6dl-pico-hobbit.dtb
	arch/arm/boot/dts/imx6dl-pico-nymph.dtb
	arch/arm/boot/dts/imx6dl-pico-pi.dtb
	arch/arm/boot/dts/imx6dl-tx6dl-comtft.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dtb

gpio@209c000: gpio-ranges: [[29, 0, 131, 2], [29, 2, 137, 8], [29, 10, 189, 2], [29, 12, 194, 1], [29, 13, 193, 1], [29, 14, 192, 1], [29, 15, 191, 1], [29, 16, 185, 2], [29, 18, 184, 1], [29, 19, 187, 1], [29, 20, 183, 1], [29, 21, 188, 1], [29, 22, 123, 3], [29, 25, 121, 1], [29, 26, 127, 1], [29, 27, 126, 1], [29, 28, 128, 1], [29, 29, 130, 1], [29, 30, 129, 1], [29, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-aristainetos2_4.dtb
	arch/arm/boot/dts/imx6dl-aristainetos2_7.dtb
	arch/arm/boot/dts/imx6dl-colibri-aster.dtb
	arch/arm/boot/dts/imx6dl-sabreauto.dtb
	arch/arm/boot/dts/imx6dl-tx6u-811x.dtb
	arch/arm/boot/dts/imx6dl-victgo.dtb

gpio@209c000: gpio-ranges: [[30, 0, 131, 2], [30, 2, 137, 8], [30, 10, 189, 2], [30, 12, 194, 1], [30, 13, 193, 1], [30, 14, 192, 1], [30, 15, 191, 1], [30, 16, 185, 2], [30, 18, 184, 1], [30, 19, 187, 1], [30, 20, 183, 1], [30, 21, 188, 1], [30, 22, 123, 3], [30, 25, 121, 1], [30, 26, 127, 1], [30, 27, 126, 1], [30, 28, 128, 1], [30, 29, 130, 1], [30, 30, 129, 1], [30, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6dl-gw52xx.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt2.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt6.dtb
	arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dtb
	arch/arm/boot/dts/imx6s-dhcom-drc02.dtb

gpio@209c000: gpio-ranges: [[32, 0, 131, 2], [32, 2, 137, 8], [32, 10, 189, 2], [32, 12, 194, 1], [32, 13, 193, 1], [32, 14, 192, 1], [32, 15, 191, 1], [32, 16, 185, 2], [32, 18, 184, 1], [32, 19, 187, 1], [32, 20, 183, 1], [32, 21, 188, 1], [32, 22, 123, 3], [32, 25, 121, 1], [32, 26, 127, 1], [32, 27, 126, 1], [32, 28, 128, 1], [32, 29, 130, 1], [32, 30, 129, 1], [32, 31, 122, 1]] is too long
	arch/arm/boot/dts/imx6dl-gw54xx.dtb

gpio@20a8000: gpio-ranges: [[10, 0, 17, 8], [10, 8, 107, 8], [10, 16, 151, 1], [10, 17, 149, 1], [10, 18, 146, 1], [10, 19, 144, 1], [10, 20, 142, 1], [10, 21, 143, 1], [10, 22, 150, 1], [10, 23, 148, 1], [10, 24, 147, 1], [10, 25, 145, 1], [10, 26, 152, 1], [10, 27, 125, 1], [10, 28, 131, 1], [10, 29, 134, 1], [10, 30, 129, 1], [10, 31, 133, 1]] is too long
	arch/arm/boot/dts/imx6sll-kobo-librah2o.dtb

gpio@20a8000: gpio-ranges: [[11, 0, 17, 8], [11, 8, 107, 8], [11, 16, 151, 1], [11, 17, 149, 1], [11, 18, 146, 1], [11, 19, 144, 1], [11, 20, 142, 1], [11, 21, 143, 1], [11, 22, 150, 1], [11, 23, 148, 1], [11, 24, 147, 1], [11, 25, 145, 1], [11, 26, 152, 1], [11, 27, 125, 1], [11, 28, 131, 1], [11, 29, 134, 1], [11, 30, 129, 1], [11, 31, 133, 1]] is too long
	arch/arm/boot/dts/imx6sll-evk.dtb
	arch/arm/boot/dts/imx6sll-kobo-clarahd.dtb

gpio@20a8000: gpio-ranges: [[11, 0, 95, 1], [11, 1, 103, 1], [11, 2, 96, 1], [11, 3, 104, 1], [11, 4, 97, 1], [11, 5, 105, 1], [11, 6, 98, 1], [11, 7, 106, 1], [11, 8, 28, 1], [11, 9, 27, 1], [11, 10, 26, 1], [11, 11, 29, 1], [11, 12, 32, 1], [11, 13, 31, 1], [11, 14, 30, 1], [11, 15, 33, 1], [11, 16, 84, 1], [11, 17, 79, 2], [11, 19, 78, 1], [11, 20, 76, 1], [11, 21, 81, 2], [11, 23, 75, 1], [11, 24, 83, 1], [11, 25, 74, 1], [11, 26, 77, 1], [11, 27, 159, 1], [11, 28, 154, 1], [11, 29, 157, 1], [11, 30, 152, 1], [11, 31, 156, 1]] is too long
	arch/arm/boot/dts/imx6sl-tolino-vision5.dtb

gpio@20a8000: gpio-ranges: [[12, 0, 95, 1], [12, 1, 103, 1], [12, 2, 96, 1], [12, 3, 104, 1], [12, 4, 97, 1], [12, 5, 105, 1], [12, 6, 98, 1], [12, 7, 106, 1], [12, 8, 28, 1], [12, 9, 27, 1], [12, 10, 26, 1], [12, 11, 29, 1], [12, 12, 32, 1], [12, 13, 31, 1], [12, 14, 30, 1], [12, 15, 33, 1], [12, 16, 84, 1], [12, 17, 79, 2], [12, 19, 78, 1], [12, 20, 76, 1], [12, 21, 81, 2], [12, 23, 75, 1], [12, 24, 83, 1], [12, 25, 74, 1], [12, 26, 77, 1], [12, 27, 159, 1], [12, 28, 154, 1], [12, 29, 157, 1], [12, 30, 152, 1], [12, 31, 156, 1]] is too long
	arch/arm/boot/dts/imx6sl-kobo-aura2.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine2hd.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine3.dtb

gpio@20a8000: gpio-ranges: [[13, 0, 95, 1], [13, 1, 103, 1], [13, 2, 96, 1], [13, 3, 104, 1], [13, 4, 97, 1], [13, 5, 105, 1], [13, 6, 98, 1], [13, 7, 106, 1], [13, 8, 28, 1], [13, 9, 27, 1], [13, 10, 26, 1], [13, 11, 29, 1], [13, 12, 32, 1], [13, 13, 31, 1], [13, 14, 30, 1], [13, 15, 33, 1], [13, 16, 84, 1], [13, 17, 79, 2], [13, 19, 78, 1], [13, 20, 76, 1], [13, 21, 81, 2], [13, 23, 75, 1], [13, 24, 83, 1], [13, 25, 74, 1], [13, 26, 77, 1], [13, 27, 159, 1], [13, 28, 154, 1], [13, 29, 157, 1], [13, 30, 152, 1], [13, 31, 156, 1]] is too long
	arch/arm/boot/dts/imx6sl-warp.dtb

gpio@20a8000: gpio-ranges: [[14, 0, 95, 1], [14, 1, 103, 1], [14, 2, 96, 1], [14, 3, 104, 1], [14, 4, 97, 1], [14, 5, 105, 1], [14, 6, 98, 1], [14, 7, 106, 1], [14, 8, 28, 1], [14, 9, 27, 1], [14, 10, 26, 1], [14, 11, 29, 1], [14, 12, 32, 1], [14, 13, 31, 1], [14, 14, 30, 1], [14, 15, 33, 1], [14, 16, 84, 1], [14, 17, 79, 2], [14, 19, 78, 1], [14, 20, 76, 1], [14, 21, 81, 2], [14, 23, 75, 1], [14, 24, 83, 1], [14, 25, 74, 1], [14, 26, 77, 1], [14, 27, 159, 1], [14, 28, 154, 1], [14, 29, 157, 1], [14, 30, 152, 1], [14, 31, 156, 1]] is too long
	arch/arm/boot/dts/imx6sl-evk.dtb

gpio@20ac000: gpio-ranges: [[10, 0, 135, 1], [10, 1, 128, 1], [10, 2, 132, 1], [10, 3, 130, 1], [10, 4, 127, 1], [10, 5, 126, 1], [10, 6, 120, 1], [10, 7, 123, 1], [10, 8, 118, 1], [10, 9, 122, 1], [10, 10, 124, 1], [10, 11, 117, 1], [10, 12, 121, 1], [10, 13, 119, 1], [10, 14, 116, 1], [10, 15, 115, 1], [10, 16, 140, 2], [10, 18, 136, 1], [10, 19, 138, 1], [10, 20, 139, 1], [10, 21, 137, 1]] is too long
	arch/arm/boot/dts/imx6sll-kobo-librah2o.dtb

gpio@20ac000: gpio-ranges: [[11, 0, 135, 1], [11, 1, 128, 1], [11, 2, 132, 1], [11, 3, 130, 1], [11, 4, 127, 1], [11, 5, 126, 1], [11, 6, 120, 1], [11, 7, 123, 1], [11, 8, 118, 1], [11, 9, 122, 1], [11, 10, 124, 1], [11, 11, 117, 1], [11, 12, 121, 1], [11, 13, 119, 1], [11, 14, 116, 1], [11, 15, 115, 1], [11, 16, 140, 2], [11, 18, 136, 1], [11, 19, 138, 1], [11, 20, 139, 1], [11, 21, 137, 1]] is too long
	arch/arm/boot/dts/imx6sll-evk.dtb
	arch/arm/boot/dts/imx6sll-kobo-clarahd.dtb

gpio@20ac000: gpio-ranges: [[11, 0, 158, 1], [11, 1, 151, 1], [11, 2, 155, 1], [11, 3, 153, 1], [11, 4, 150, 1], [11, 5, 149, 1], [11, 6, 144, 1], [11, 7, 147, 1], [11, 8, 142, 1], [11, 9, 146, 1], [11, 10, 148, 1], [11, 11, 141, 1], [11, 12, 145, 1], [11, 13, 143, 1], [11, 14, 140, 1], [11, 15, 139, 1], [11, 16, 164, 2], [11, 18, 160, 1], [11, 19, 162, 1], [11, 20, 163, 1], [11, 21, 161, 1]] is too long
	arch/arm/boot/dts/imx6sl-tolino-vision5.dtb

gpio@20ac000: gpio-ranges: [[12, 0, 158, 1], [12, 1, 151, 1], [12, 2, 155, 1], [12, 3, 153, 1], [12, 4, 150, 1], [12, 5, 149, 1], [12, 6, 144, 1], [12, 7, 147, 1], [12, 8, 142, 1], [12, 9, 146, 1], [12, 10, 148, 1], [12, 11, 141, 1], [12, 12, 145, 1], [12, 13, 143, 1], [12, 14, 140, 1], [12, 15, 139, 1], [12, 16, 164, 2], [12, 18, 160, 1], [12, 19, 162, 1], [12, 20, 163, 1], [12, 21, 161, 1]] is too long
	arch/arm/boot/dts/imx6sl-kobo-aura2.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine2hd.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine3.dtb

gpio@20ac000: gpio-ranges: [[13, 0, 158, 1], [13, 1, 151, 1], [13, 2, 155, 1], [13, 3, 153, 1], [13, 4, 150, 1], [13, 5, 149, 1], [13, 6, 144, 1], [13, 7, 147, 1], [13, 8, 142, 1], [13, 9, 146, 1], [13, 10, 148, 1], [13, 11, 141, 1], [13, 12, 145, 1], [13, 13, 143, 1], [13, 14, 140, 1], [13, 15, 139, 1], [13, 16, 164, 2], [13, 18, 160, 1], [13, 19, 162, 1], [13, 20, 163, 1], [13, 21, 161, 1]] is too long
	arch/arm/boot/dts/imx6sl-warp.dtb

gpio@20ac000: gpio-ranges: [[14, 0, 158, 1], [14, 1, 151, 1], [14, 2, 155, 1], [14, 3, 153, 1], [14, 4, 150, 1], [14, 5, 149, 1], [14, 6, 144, 1], [14, 7, 147, 1], [14, 8, 142, 1], [14, 9, 146, 1], [14, 10, 148, 1], [14, 11, 141, 1], [14, 12, 145, 1], [14, 13, 143, 1], [14, 14, 140, 1], [14, 15, 139, 1], [14, 16, 164, 2], [14, 18, 160, 1], [14, 19, 162, 1], [14, 20, 163, 1], [14, 21, 161, 1]] is too long
	arch/arm/boot/dts/imx6sl-evk.dtb

gpio@20b0000: gpio-ranges: [[17, 0, 23, 6], [17, 6, 75, 1], [17, 7, 156, 1], [17, 8, 155, 1], [17, 9, 170, 1], [17, 10, 169, 1], [17, 11, 157, 1], [17, 14, 158, 3], [17, 17, 204, 1], [17, 18, 203, 1], [17, 19, 182, 1], [17, 20, 177, 4], [17, 24, 175, 1], [17, 25, 171, 1], [17, 26, 181, 1], [17, 27, 172, 3], [17, 30, 176, 1], [17, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-mamoj.dtb

gpio@20b0000: gpio-ranges: [[19, 0, 23, 6], [19, 6, 75, 1], [19, 7, 156, 1], [19, 8, 155, 1], [19, 9, 170, 1], [19, 10, 169, 1], [19, 11, 157, 1], [19, 14, 158, 3], [19, 17, 204, 1], [19, 18, 203, 1], [19, 19, 182, 1], [19, 20, 177, 4], [19, 24, 175, 1], [19, 25, 171, 1], [19, 26, 181, 1], [19, 27, 172, 3], [19, 30, 176, 1], [19, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dtb
	arch/arm/boot/dts/imx6dl-gw5903.dtb
	arch/arm/boot/dts/imx6dl-lanmcu.dtb
	arch/arm/boot/dts/imx6dl-wandboard.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revd1.dtb

gpio@20b0000: gpio-ranges: [[20, 0, 23, 6], [20, 6, 75, 1], [20, 7, 156, 1], [20, 8, 155, 1], [20, 9, 170, 1], [20, 10, 169, 1], [20, 11, 157, 1], [20, 14, 158, 3], [20, 17, 204, 1], [20, 18, 203, 1], [20, 19, 182, 1], [20, 20, 177, 4], [20, 24, 175, 1], [20, 25, 171, 1], [20, 26, 181, 1], [20, 27, 172, 3], [20, 30, 176, 1], [20, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-cubox-i.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dtb
	arch/arm/boot/dts/imx6dl-savageboard.dtb

gpio@20b0000: gpio-ranges: [[21, 0, 23, 6], [21, 6, 75, 1], [21, 7, 156, 1], [21, 8, 155, 1], [21, 9, 170, 1], [21, 10, 169, 1], [21, 11, 157, 1], [21, 14, 158, 3], [21, 17, 204, 1], [21, 18, 203, 1], [21, 19, 182, 1], [21, 20, 177, 4], [21, 24, 175, 1], [21, 25, 171, 1], [21, 26, 181, 1], [21, 27, 172, 3], [21, 30, 176, 1], [21, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-aristainetos_7.dtb
	arch/arm/boot/dts/imx6dl-b105pv2.dtb
	arch/arm/boot/dts/imx6dl-b105v2.dtb
	arch/arm/boot/dts/imx6dl-b125pv2.dtb
	arch/arm/boot/dts/imx6dl-b125v2.dtb
	arch/arm/boot/dts/imx6dl-b155v2.dtb
	arch/arm/boot/dts/imx6dl-icore.dtb
	arch/arm/boot/dts/imx6dl-icore-rqs.dtb
	arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb

gpio@20b0000: gpio-ranges: [[22, 0, 23, 6], [22, 6, 75, 1], [22, 7, 156, 1], [22, 8, 155, 1], [22, 9, 170, 1], [22, 10, 169, 1], [22, 11, 157, 1], [22, 14, 158, 3], [22, 17, 204, 1], [22, 18, 203, 1], [22, 19, 182, 1], [22, 20, 177, 4], [22, 24, 175, 1], [22, 25, 171, 1], [22, 26, 181, 1], [22, 27, 172, 3], [22, 30, 176, 1], [22, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-aristainetos_4.dtb
	arch/arm/boot/dts/imx6dl-gw552x.dtb
	arch/arm/boot/dts/imx6dl-icore-mipi.dtb
	arch/arm/boot/dts/imx6dl-rex-basic.dtb
	arch/arm/boot/dts/imx6dl-riotboard.dtb

gpio@20b0000: gpio-ranges: [[23, 0, 23, 6], [23, 6, 75, 1], [23, 7, 156, 1], [23, 8, 155, 1], [23, 9, 170, 1], [23, 10, 169, 1], [23, 11, 157, 1], [23, 14, 158, 3], [23, 17, 204, 1], [23, 18, 203, 1], [23, 19, 182, 1], [23, 20, 177, 4], [23, 24, 175, 1], [23, 25, 171, 1], [23, 26, 181, 1], [23, 27, 172, 3], [23, 30, 176, 1], [23, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-alti6p.dtb
	arch/arm/boot/dts/imx6dl-gw551x.dtb
	arch/arm/boot/dts/imx6dl-gw5904.dtb
	arch/arm/boot/dts/imx6dl-gw5913.dtb
	arch/arm/boot/dts/imx6dl-plybas.dtb
	arch/arm/boot/dts/imx6dl-prtmvt.dtb
	arch/arm/boot/dts/imx6dl-prtvt7.dtb
	arch/arm/boot/dts/imx6dl-ts4900.dtb
	arch/arm/boot/dts/imx6dl-udoo.dtb
	arch/arm/boot/dts/imx6dl-yapp4-draco.dtb
	arch/arm/boot/dts/imx6dl-yapp4-hydra.dtb
	arch/arm/boot/dts/imx6dl-yapp4-orion.dtb
	arch/arm/boot/dts/imx6dl-yapp4-ursa.dtb

gpio@20b0000: gpio-ranges: [[24, 0, 23, 6], [24, 6, 75, 1], [24, 7, 156, 1], [24, 8, 155, 1], [24, 9, 170, 1], [24, 10, 169, 1], [24, 11, 157, 1], [24, 14, 158, 3], [24, 17, 204, 1], [24, 18, 203, 1], [24, 19, 182, 1], [24, 20, 177, 4], [24, 24, 175, 1], [24, 25, 171, 1], [24, 26, 181, 1], [24, 27, 172, 3], [24, 30, 176, 1], [24, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-gw51xx.dtb
	arch/arm/boot/dts/imx6dl-gw553x.dtb
	arch/arm/boot/dts/imx6dl-gw5907.dtb
	arch/arm/boot/dts/imx6dl-gw5910.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dtb
	arch/arm/boot/dts/imx6dl-nit6xlite.dtb
	arch/arm/boot/dts/imx6dl-plym2m.dtb
	arch/arm/boot/dts/imx6dl-solidsense.dtb

gpio@20b0000: gpio-ranges: [[25, 0, 23, 6], [25, 6, 75, 1], [25, 7, 156, 1], [25, 8, 155, 1], [25, 9, 170, 1], [25, 10, 169, 1], [25, 11, 157, 1], [25, 14, 158, 3], [25, 17, 204, 1], [25, 18, 203, 1], [25, 19, 182, 1], [25, 20, 177, 4], [25, 24, 175, 1], [25, 25, 171, 1], [25, 26, 181, 1], [25, 27, 172, 3], [25, 30, 176, 1], [25, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dtb
	arch/arm/boot/dts/imx6dl-emcon-avari.dtb
	arch/arm/boot/dts/imx6dl-prtrvt.dtb

gpio@20b0000: gpio-ranges: [[26, 0, 23, 6], [26, 6, 75, 1], [26, 7, 156, 1], [26, 8, 155, 1], [26, 9, 170, 1], [26, 10, 169, 1], [26, 11, 157, 1], [26, 14, 158, 3], [26, 17, 204, 1], [26, 18, 203, 1], [26, 19, 182, 1], [26, 20, 177, 4], [26, 24, 175, 1], [26, 25, 171, 1], [26, 26, 181, 1], [26, 27, 172, 3], [26, 30, 176, 1], [26, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-apf6dev.dtb
	arch/arm/boot/dts/imx6dl-mba6a.dtb
	arch/arm/boot/dts/imx6dl-mba6b.dtb
	arch/arm/boot/dts/imx6dl-nitrogen6x.dtb
	arch/arm/boot/dts/imx6dl-sabrelite.dtb
	arch/arm/boot/dts/imx6dl-sabresd.dtb
	arch/arm/boot/dts/imx6dl-ts7970.dtb
	arch/arm/boot/dts/imx6dl-vicut1.dtb

gpio@20b0000: gpio-ranges: [[27, 0, 23, 6], [27, 6, 75, 1], [27, 7, 156, 1], [27, 8, 155, 1], [27, 9, 170, 1], [27, 10, 169, 1], [27, 11, 157, 1], [27, 14, 158, 3], [27, 17, 204, 1], [27, 18, 203, 1], [27, 19, 182, 1], [27, 20, 177, 4], [27, 24, 175, 1], [27, 25, 171, 1], [27, 26, 181, 1], [27, 27, 172, 3], [27, 30, 176, 1], [27, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-dhcom-picoitx.dtb
	arch/arm/boot/dts/imx6dl-gw560x.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035.dtb
	arch/arm/boot/dts/imx6dl-tx6u-801x.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033.dtb

gpio@20b0000: gpio-ranges: [[28, 0, 23, 6], [28, 6, 75, 1], [28, 7, 156, 1], [28, 8, 155, 1], [28, 9, 170, 1], [28, 10, 169, 1], [28, 11, 157, 1], [28, 14, 158, 3], [28, 17, 204, 1], [28, 18, 203, 1], [28, 19, 182, 1], [28, 20, 177, 4], [28, 24, 175, 1], [28, 25, 171, 1], [28, 26, 181, 1], [28, 27, 172, 3], [28, 30, 176, 1], [28, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-colibri-iris.dtb
	arch/arm/boot/dts/imx6dl-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx6dl-gw53xx.dtb
	arch/arm/boot/dts/imx6dl-gw5912.dtb
	arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6dl-pico-dwarf.dtb
	arch/arm/boot/dts/imx6dl-pico-hobbit.dtb
	arch/arm/boot/dts/imx6dl-pico-nymph.dtb
	arch/arm/boot/dts/imx6dl-pico-pi.dtb
	arch/arm/boot/dts/imx6dl-tx6dl-comtft.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dtb

gpio@20b0000: gpio-ranges: [[29, 0, 23, 6], [29, 6, 75, 1], [29, 7, 156, 1], [29, 8, 155, 1], [29, 9, 170, 1], [29, 10, 169, 1], [29, 11, 157, 1], [29, 14, 158, 3], [29, 17, 204, 1], [29, 18, 203, 1], [29, 19, 182, 1], [29, 20, 177, 4], [29, 24, 175, 1], [29, 25, 171, 1], [29, 26, 181, 1], [29, 27, 172, 3], [29, 30, 176, 1], [29, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-aristainetos2_4.dtb
	arch/arm/boot/dts/imx6dl-aristainetos2_7.dtb
	arch/arm/boot/dts/imx6dl-colibri-aster.dtb
	arch/arm/boot/dts/imx6dl-sabreauto.dtb
	arch/arm/boot/dts/imx6dl-tx6u-811x.dtb
	arch/arm/boot/dts/imx6dl-victgo.dtb

gpio@20b0000: gpio-ranges: [[30, 0, 23, 6], [30, 6, 75, 1], [30, 7, 156, 1], [30, 8, 155, 1], [30, 9, 170, 1], [30, 10, 169, 1], [30, 11, 157, 1], [30, 14, 158, 3], [30, 17, 204, 1], [30, 18, 203, 1], [30, 19, 182, 1], [30, 20, 177, 4], [30, 24, 175, 1], [30, 25, 171, 1], [30, 26, 181, 1], [30, 27, 172, 3], [30, 30, 176, 1], [30, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6dl-gw52xx.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt2.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt6.dtb
	arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dtb
	arch/arm/boot/dts/imx6s-dhcom-drc02.dtb

gpio@20b0000: gpio-ranges: [[32, 0, 23, 6], [32, 6, 75, 1], [32, 7, 156, 1], [32, 8, 155, 1], [32, 9, 170, 1], [32, 10, 169, 1], [32, 11, 157, 1], [32, 14, 158, 3], [32, 17, 204, 1], [32, 18, 203, 1], [32, 19, 182, 1], [32, 20, 177, 4], [32, 24, 175, 1], [32, 25, 171, 1], [32, 26, 181, 1], [32, 27, 172, 3], [32, 30, 176, 1], [32, 31, 78, 1]] is too long
	arch/arm/boot/dts/imx6dl-gw54xx.dtb

gpio@30200000: pmic-5v-hog: 'lane-mapping' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb

gpio@53f9c000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb

gpio@53fa4000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb

gpio@53fcc000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb

gpio@53fd0000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb

gpio@5d080000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
	arch/arm64/boot/dts/freescale/imx8qm-mek.dtb

gpio@5d090000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
	arch/arm64/boot/dts/freescale/imx8qm-mek.dtb

gpio@5d0a0000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
	arch/arm64/boot/dts/freescale/imx8qm-mek.dtb

gpio@5d0b0000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
	arch/arm64/boot/dts/freescale/imx8qm-mek.dtb

gpio@5d0c0000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
	arch/arm64/boot/dts/freescale/imx8qm-mek.dtb

gpio@5d0d0000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
	arch/arm64/boot/dts/freescale/imx8qm-mek.dtb

gpio@5d0e0000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
	arch/arm64/boot/dts/freescale/imx8qm-mek.dtb

gpio@5d0f0000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
	arch/arm64/boot/dts/freescale/imx8qm-mek.dtb

