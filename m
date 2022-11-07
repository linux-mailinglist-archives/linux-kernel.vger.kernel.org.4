Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA6961F2BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiKGMRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKGMRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:17:20 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBF226FD;
        Mon,  7 Nov 2022 04:17:17 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-13b23e29e36so12384107fac.8;
        Mon, 07 Nov 2022 04:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S2yieh1wiWDy5xfyur7n11zDi2HVy+kcdU1nq6yM8l4=;
        b=L2CkKcWFWmK3Rb0T2VdR7iR5fs2mLpW+Bvyq45sTa8mlWogCpbzP4Kryfc3XY4fkL1
         qgcAl8ykcnOmyxrhhOH+86PC4XP6PX0PiWHYb3jiLqgPkTs42+k7p9hnVzEiZPQ5k0OK
         n6afhfMUub/GOhXhFQTUbRfBPcnYCgY/2Y691tpWZGhwm8mMSsqNBDEHj8pdGlnCZp2b
         +halp4A4ADyupsk++YufxJWz7JDf1FCgbsX/BbeHyrTm9a662cIXX1FWVymtR7wqh3zm
         cnhIGcNOioH3I/XxdFIV4ziWgscUkP70+kpl4lA5GaBR9m9/HFhKnzi/EytNU8xTBXxE
         Ocag==
X-Gm-Message-State: ANoB5pmQ7xfPJciHS1i4hsXkarBj8iGGrCBSoNWjXmXtHymKT1Fnkagx
        0C5ioD1CFxJhDVz78qNd7A==
X-Google-Smtp-Source: AA0mqf4wGuK46O6WkOOp/T9UvHCTdkhrDVGEt21AKF+HdKr9QRlqNabKZBtWjISO+ZCFJIUplwizfA==
X-Received: by 2002:a05:6870:f725:b0:140:7c91:c1bb with SMTP id ej37-20020a056870f72500b001407c91c1bbmr9527785oab.177.1667823385983;
        Mon, 07 Nov 2022 04:16:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x34-20020a056870b42200b0013d7fffbc3csm2924018oap.58.2022.11.07.04.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:16:25 -0800 (PST)
Received: (nullmailer pid 652846 invoked by uid 1000);
        Mon, 07 Nov 2022 12:16:26 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     robh+dt@kernel.org, sboyd@kernel.org, kernel@pengutronix.de,
        linus.walleij@linaro.org, arnd@arndb.de, Mr.Bossman075@gmail.com,
        festevam@gmail.com, stefan@agner.ch,
        Krzysztof Kozlowski <krzk@kernel.org>,
        giulio.benetti@benettiengineering.com,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        leoyang.li@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, tharvey@gateworks.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, aisheng.dong@nxp.com,
        fugang.duan@nxp.com, linux-imx@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, abel.vesa@nxp.com
In-Reply-To: <20221107071511.2764628-4-Mr.Bossman075@gmail.com>
References: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
 <20221107071511.2764628-4-Mr.Bossman075@gmail.com>
Message-Id: <166782289581.604263.3296101897705323287.robh@kernel.org>
Subject: Re: [PATCH v1 3/7] dt-bindings: timer: gpt: Add i.MXRT compatible
 Documentation
Date:   Mon, 07 Nov 2022 06:16:26 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 07 Nov 2022 02:15:07 -0500, Jesse Taube wrote:
> Both the i.MXRT1170 and 1050 have the same GPT timer as "fsl,imx6dl-gpt"
> Add i.MXRT to the compatible list.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


timer@2098000: clock-names: ['ipg', 'per', 'osc_per'] is too long
	arch/arm/boot/dts/imx6dl-alti6p.dtb
	arch/arm/boot/dts/imx6dl-apf6dev.dtb
	arch/arm/boot/dts/imx6dl-aristainetos2_4.dtb
	arch/arm/boot/dts/imx6dl-aristainetos2_7.dtb
	arch/arm/boot/dts/imx6dl-aristainetos_4.dtb
	arch/arm/boot/dts/imx6dl-aristainetos_7.dtb
	arch/arm/boot/dts/imx6dl-b105pv2.dtb
	arch/arm/boot/dts/imx6dl-b105v2.dtb
	arch/arm/boot/dts/imx6dl-b125pv2.dtb
	arch/arm/boot/dts/imx6dl-b125v2.dtb
	arch/arm/boot/dts/imx6dl-b155v2.dtb
	arch/arm/boot/dts/imx6dl-colibri-aster.dtb
	arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6dl-colibri-iris.dtb
	arch/arm/boot/dts/imx6dl-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx6dl-cubox-i.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dtb
	arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dtb
	arch/arm/boot/dts/imx6dl-dhcom-picoitx.dtb
	arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dtb
	arch/arm/boot/dts/imx6dl-emcon-avari.dtb
	arch/arm/boot/dts/imx6dl-gw51xx.dtb
	arch/arm/boot/dts/imx6dl-gw52xx.dtb
	arch/arm/boot/dts/imx6dl-gw53xx.dtb
	arch/arm/boot/dts/imx6dl-gw54xx.dtb
	arch/arm/boot/dts/imx6dl-gw551x.dtb
	arch/arm/boot/dts/imx6dl-gw552x.dtb
	arch/arm/boot/dts/imx6dl-gw553x.dtb
	arch/arm/boot/dts/imx6dl-gw560x.dtb
	arch/arm/boot/dts/imx6dl-gw5903.dtb
	arch/arm/boot/dts/imx6dl-gw5904.dtb
	arch/arm/boot/dts/imx6dl-gw5907.dtb
	arch/arm/boot/dts/imx6dl-gw5910.dtb
	arch/arm/boot/dts/imx6dl-gw5912.dtb
	arch/arm/boot/dts/imx6dl-gw5913.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dtb
	arch/arm/boot/dts/imx6dl-icore.dtb
	arch/arm/boot/dts/imx6dl-icore-mipi.dtb
	arch/arm/boot/dts/imx6dl-icore-rqs.dtb
	arch/arm/boot/dts/imx6dl-lanmcu.dtb
	arch/arm/boot/dts/imx6dl-mamoj.dtb
	arch/arm/boot/dts/imx6dl-mba6a.dtb
	arch/arm/boot/dts/imx6dl-mba6b.dtb
	arch/arm/boot/dts/imx6dl-nit6xlite.dtb
	arch/arm/boot/dts/imx6dl-nitrogen6x.dtb
	arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb
	arch/arm/boot/dts/imx6dl-pico-dwarf.dtb
	arch/arm/boot/dts/imx6dl-pico-hobbit.dtb
	arch/arm/boot/dts/imx6dl-pico-nymph.dtb
	arch/arm/boot/dts/imx6dl-pico-pi.dtb
	arch/arm/boot/dts/imx6dl-plybas.dtb
	arch/arm/boot/dts/imx6dl-plym2m.dtb
	arch/arm/boot/dts/imx6dl-prtmvt.dtb
	arch/arm/boot/dts/imx6dl-prtrvt.dtb
	arch/arm/boot/dts/imx6dl-prtvt7.dtb
	arch/arm/boot/dts/imx6dl-rex-basic.dtb
	arch/arm/boot/dts/imx6dl-riotboard.dtb
	arch/arm/boot/dts/imx6dl-sabreauto.dtb
	arch/arm/boot/dts/imx6dl-sabrelite.dtb
	arch/arm/boot/dts/imx6dl-sabresd.dtb
	arch/arm/boot/dts/imx6dl-savageboard.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt2.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt6.dtb
	arch/arm/boot/dts/imx6dl-solidsense.dtb
	arch/arm/boot/dts/imx6dl-ts4900.dtb
	arch/arm/boot/dts/imx6dl-ts7970.dtb
	arch/arm/boot/dts/imx6dl-tx6dl-comtft.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-801x.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-811x.dtb
	arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dtb
	arch/arm/boot/dts/imx6dl-udoo.dtb
	arch/arm/boot/dts/imx6dl-victgo.dtb
	arch/arm/boot/dts/imx6dl-vicut1.dtb
	arch/arm/boot/dts/imx6dl-wandboard.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6dl-yapp4-draco.dtb
	arch/arm/boot/dts/imx6dl-yapp4-hydra.dtb
	arch/arm/boot/dts/imx6dl-yapp4-orion.dtb
	arch/arm/boot/dts/imx6dl-yapp4-ursa.dtb
	arch/arm/boot/dts/imx6q-apalis-eval.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dtb
	arch/arm/boot/dts/imx6q-apf6dev.dtb
	arch/arm/boot/dts/imx6q-arm2.dtb
	arch/arm/boot/dts/imx6q-b450v3.dtb
	arch/arm/boot/dts/imx6q-b650v3.dtb
	arch/arm/boot/dts/imx6q-b850v3.dtb
	arch/arm/boot/dts/imx6q-bosch-acc.dtb
	arch/arm/boot/dts/imx6q-cm-fx6.dtb
	arch/arm/boot/dts/imx6q-cubox-i.dtb
	arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-cubox-i-som-v15.dtb
	arch/arm/boot/dts/imx6q-dfi-fs700-m60.dtb
	arch/arm/boot/dts/imx6q-dhcom-pdk2.dtb
	arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dtb
	arch/arm/boot/dts/imx6q-dmo-edmqmx6.dtb
	arch/arm/boot/dts/imx6q-dms-ba16.dtb
	arch/arm/boot/dts/imx6q-ds.dtb
	arch/arm/boot/dts/imx6q-emcon-avari.dtb
	arch/arm/boot/dts/imx6q-evi.dtb
	arch/arm/boot/dts/imx6q-gk802.dtb
	arch/arm/boot/dts/imx6q-gw51xx.dtb
	arch/arm/boot/dts/imx6q-gw52xx.dtb
	arch/arm/boot/dts/imx6q-gw53xx.dtb
	arch/arm/boot/dts/imx6q-gw5400-a.dtb
	arch/arm/boot/dts/imx6q-gw54xx.dtb
	arch/arm/boot/dts/imx6q-gw551x.dtb
	arch/arm/boot/dts/imx6q-gw552x.dtb
	arch/arm/boot/dts/imx6q-gw553x.dtb
	arch/arm/boot/dts/imx6q-gw560x.dtb
	arch/arm/boot/dts/imx6q-gw5903.dtb
	arch/arm/boot/dts/imx6q-gw5904.dtb
	arch/arm/boot/dts/imx6q-gw5907.dtb
	arch/arm/boot/dts/imx6q-gw5910.dtb
	arch/arm/boot/dts/imx6q-gw5912.dtb
	arch/arm/boot/dts/imx6q-gw5913.dtb
	arch/arm/boot/dts/imx6q-h100.dtb
	arch/arm/boot/dts/imx6q-hummingboard2.dtb
	arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard.dtb
	arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard-som-v15.dtb
	arch/arm/boot/dts/imx6q-icore.dtb
	arch/arm/boot/dts/imx6q-icore-mipi.dtb
	arch/arm/boot/dts/imx6q-icore-ofcap10.dtb
	arch/arm/boot/dts/imx6q-icore-ofcap12.dtb
	arch/arm/boot/dts/imx6q-icore-rqs.dtb
	arch/arm/boot/dts/imx6q-kp-tpc.dtb
	arch/arm/boot/dts/imx6q-logicpd.dtb
	arch/arm/boot/dts/imx6q-marsboard.dtb
	arch/arm/boot/dts/imx6q-mba6a.dtb
	arch/arm/boot/dts/imx6q-mba6b.dtb
	arch/arm/boot/dts/imx6q-mccmon6.dtb
	arch/arm/boot/dts/imx6q-nitrogen6_max.dtb
	arch/arm/boot/dts/imx6q-nitrogen6_som2.dtb
	arch/arm/boot/dts/imx6q-nitrogen6x.dtb
	arch/arm/boot/dts/imx6q-novena.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6q-phytec-pbab01.dtb
	arch/arm/boot/dts/imx6q-pico-dwarf.dtb
	arch/arm/boot/dts/imx6q-pico-hobbit.dtb
	arch/arm/boot/dts/imx6q-pico-nymph.dtb
	arch/arm/boot/dts/imx6q-pico-pi.dtb
	arch/arm/boot/dts/imx6q-pistachio.dtb
	arch/arm/boot/dts/imx6qp-mba6b.dtb
	arch/arm/boot/dts/imx6qp-nitrogen6_max.dtb
	arch/arm/boot/dts/imx6qp-nitrogen6_som2.dtb
	arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6qp-prtwd3.dtb
	arch/arm/boot/dts/imx6q-prti6q.dtb
	arch/arm/boot/dts/imx6q-prtwd2.dtb
	arch/arm/boot/dts/imx6qp-sabreauto.dtb
	arch/arm/boot/dts/imx6qp-sabresd.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8037.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8137.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dtb
	arch/arm/boot/dts/imx6qp-vicutp.dtb
	arch/arm/boot/dts/imx6qp-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dtb
	arch/arm/boot/dts/imx6qp-zii-rdu2.dtb
	arch/arm/boot/dts/imx6q-rex-pro.dtb
	arch/arm/boot/dts/imx6q-sabreauto.dtb
	arch/arm/boot/dts/imx6q-sabrelite.dtb
	arch/arm/boot/dts/imx6q-sabresd.dtb
	arch/arm/boot/dts/imx6q-savageboard.dtb
	arch/arm/boot/dts/imx6q-sbc6x.dtb
	arch/arm/boot/dts/imx6q-skov-revc-lt2.dtb
	arch/arm/boot/dts/imx6q-skov-revc-lt6.dtb
	arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dtb
	arch/arm/boot/dts/imx6q-solidsense.dtb
	arch/arm/boot/dts/imx6q-tbs2910.dtb
	arch/arm/boot/dts/imx6q-ts4900.dtb
	arch/arm/boot/dts/imx6q-ts7970.dtb
	arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dtb
	arch/arm/boot/dts/imx6q-tx6q-1010.dtb
	arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dtb
	arch/arm/boot/dts/imx6q-tx6q-1020.dtb
	arch/arm/boot/dts/imx6q-tx6q-1036.dtb
	arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dtb
	arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dtb
	arch/arm/boot/dts/imx6q-tx6q-1110.dtb
	arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dtb
	arch/arm/boot/dts/imx6q-udoo.dtb
	arch/arm/boot/dts/imx6q-utilite-pro.dtb
	arch/arm/boot/dts/imx6q-var-dt6customboard.dtb
	arch/arm/boot/dts/imx6q-vicut1.dtb
	arch/arm/boot/dts/imx6q-wandboard.dtb
	arch/arm/boot/dts/imx6q-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6q-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6q-yapp4-crux.dtb
	arch/arm/boot/dts/imx6q-zii-rdu2.dtb
	arch/arm/boot/dts/imx6s-dhcom-drc02.dtb

timer@2098000: clocks: [[2, 119], [2, 120], [2, 237]] is too long
	arch/arm/boot/dts/imx6dl-alti6p.dtb
	arch/arm/boot/dts/imx6dl-apf6dev.dtb
	arch/arm/boot/dts/imx6dl-aristainetos2_4.dtb
	arch/arm/boot/dts/imx6dl-aristainetos2_7.dtb
	arch/arm/boot/dts/imx6dl-aristainetos_4.dtb
	arch/arm/boot/dts/imx6dl-aristainetos_7.dtb
	arch/arm/boot/dts/imx6dl-b105pv2.dtb
	arch/arm/boot/dts/imx6dl-b105v2.dtb
	arch/arm/boot/dts/imx6dl-b125pv2.dtb
	arch/arm/boot/dts/imx6dl-b125v2.dtb
	arch/arm/boot/dts/imx6dl-b155v2.dtb
	arch/arm/boot/dts/imx6dl-colibri-aster.dtb
	arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6dl-colibri-iris.dtb
	arch/arm/boot/dts/imx6dl-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx6dl-cubox-i.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dtb
	arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dtb
	arch/arm/boot/dts/imx6dl-dhcom-picoitx.dtb
	arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dtb
	arch/arm/boot/dts/imx6dl-emcon-avari.dtb
	arch/arm/boot/dts/imx6dl-gw51xx.dtb
	arch/arm/boot/dts/imx6dl-gw52xx.dtb
	arch/arm/boot/dts/imx6dl-gw53xx.dtb
	arch/arm/boot/dts/imx6dl-gw54xx.dtb
	arch/arm/boot/dts/imx6dl-gw551x.dtb
	arch/arm/boot/dts/imx6dl-gw552x.dtb
	arch/arm/boot/dts/imx6dl-gw553x.dtb
	arch/arm/boot/dts/imx6dl-gw560x.dtb
	arch/arm/boot/dts/imx6dl-gw5903.dtb
	arch/arm/boot/dts/imx6dl-gw5904.dtb
	arch/arm/boot/dts/imx6dl-gw5907.dtb
	arch/arm/boot/dts/imx6dl-gw5910.dtb
	arch/arm/boot/dts/imx6dl-gw5912.dtb
	arch/arm/boot/dts/imx6dl-gw5913.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dtb
	arch/arm/boot/dts/imx6dl-icore.dtb
	arch/arm/boot/dts/imx6dl-icore-mipi.dtb
	arch/arm/boot/dts/imx6dl-icore-rqs.dtb
	arch/arm/boot/dts/imx6dl-lanmcu.dtb
	arch/arm/boot/dts/imx6dl-mamoj.dtb
	arch/arm/boot/dts/imx6dl-mba6a.dtb
	arch/arm/boot/dts/imx6dl-mba6b.dtb
	arch/arm/boot/dts/imx6dl-nit6xlite.dtb
	arch/arm/boot/dts/imx6dl-nitrogen6x.dtb
	arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb
	arch/arm/boot/dts/imx6dl-pico-dwarf.dtb
	arch/arm/boot/dts/imx6dl-pico-hobbit.dtb
	arch/arm/boot/dts/imx6dl-pico-nymph.dtb
	arch/arm/boot/dts/imx6dl-pico-pi.dtb
	arch/arm/boot/dts/imx6dl-plybas.dtb
	arch/arm/boot/dts/imx6dl-plym2m.dtb
	arch/arm/boot/dts/imx6dl-prtmvt.dtb
	arch/arm/boot/dts/imx6dl-prtrvt.dtb
	arch/arm/boot/dts/imx6dl-prtvt7.dtb
	arch/arm/boot/dts/imx6dl-rex-basic.dtb
	arch/arm/boot/dts/imx6dl-riotboard.dtb
	arch/arm/boot/dts/imx6dl-sabreauto.dtb
	arch/arm/boot/dts/imx6dl-sabrelite.dtb
	arch/arm/boot/dts/imx6dl-sabresd.dtb
	arch/arm/boot/dts/imx6dl-savageboard.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt2.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt6.dtb
	arch/arm/boot/dts/imx6dl-solidsense.dtb
	arch/arm/boot/dts/imx6dl-ts4900.dtb
	arch/arm/boot/dts/imx6dl-ts7970.dtb
	arch/arm/boot/dts/imx6dl-tx6dl-comtft.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-801x.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-811x.dtb
	arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dtb
	arch/arm/boot/dts/imx6dl-udoo.dtb
	arch/arm/boot/dts/imx6dl-victgo.dtb
	arch/arm/boot/dts/imx6dl-vicut1.dtb
	arch/arm/boot/dts/imx6dl-wandboard.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6dl-yapp4-draco.dtb
	arch/arm/boot/dts/imx6dl-yapp4-hydra.dtb
	arch/arm/boot/dts/imx6dl-yapp4-orion.dtb
	arch/arm/boot/dts/imx6dl-yapp4-ursa.dtb
	arch/arm/boot/dts/imx6q-apalis-eval.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dtb
	arch/arm/boot/dts/imx6q-apf6dev.dtb
	arch/arm/boot/dts/imx6q-arm2.dtb
	arch/arm/boot/dts/imx6q-b450v3.dtb
	arch/arm/boot/dts/imx6q-b650v3.dtb
	arch/arm/boot/dts/imx6q-b850v3.dtb
	arch/arm/boot/dts/imx6q-bosch-acc.dtb
	arch/arm/boot/dts/imx6q-cm-fx6.dtb
	arch/arm/boot/dts/imx6q-cubox-i.dtb
	arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-cubox-i-som-v15.dtb
	arch/arm/boot/dts/imx6q-dfi-fs700-m60.dtb
	arch/arm/boot/dts/imx6q-dhcom-pdk2.dtb
	arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dtb
	arch/arm/boot/dts/imx6q-dmo-edmqmx6.dtb
	arch/arm/boot/dts/imx6q-dms-ba16.dtb
	arch/arm/boot/dts/imx6q-ds.dtb
	arch/arm/boot/dts/imx6q-emcon-avari.dtb
	arch/arm/boot/dts/imx6q-evi.dtb
	arch/arm/boot/dts/imx6q-gk802.dtb
	arch/arm/boot/dts/imx6q-gw51xx.dtb
	arch/arm/boot/dts/imx6q-gw52xx.dtb
	arch/arm/boot/dts/imx6q-gw53xx.dtb
	arch/arm/boot/dts/imx6q-gw5400-a.dtb
	arch/arm/boot/dts/imx6q-gw54xx.dtb
	arch/arm/boot/dts/imx6q-gw551x.dtb
	arch/arm/boot/dts/imx6q-gw552x.dtb
	arch/arm/boot/dts/imx6q-gw553x.dtb
	arch/arm/boot/dts/imx6q-gw560x.dtb
	arch/arm/boot/dts/imx6q-gw5903.dtb
	arch/arm/boot/dts/imx6q-gw5904.dtb
	arch/arm/boot/dts/imx6q-gw5907.dtb
	arch/arm/boot/dts/imx6q-gw5910.dtb
	arch/arm/boot/dts/imx6q-gw5912.dtb
	arch/arm/boot/dts/imx6q-gw5913.dtb
	arch/arm/boot/dts/imx6q-h100.dtb
	arch/arm/boot/dts/imx6q-hummingboard2.dtb
	arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard.dtb
	arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard-som-v15.dtb
	arch/arm/boot/dts/imx6q-icore.dtb
	arch/arm/boot/dts/imx6q-icore-mipi.dtb
	arch/arm/boot/dts/imx6q-icore-ofcap10.dtb
	arch/arm/boot/dts/imx6q-icore-ofcap12.dtb
	arch/arm/boot/dts/imx6q-icore-rqs.dtb
	arch/arm/boot/dts/imx6q-kp-tpc.dtb
	arch/arm/boot/dts/imx6q-logicpd.dtb
	arch/arm/boot/dts/imx6q-marsboard.dtb
	arch/arm/boot/dts/imx6q-mba6a.dtb
	arch/arm/boot/dts/imx6q-mba6b.dtb
	arch/arm/boot/dts/imx6q-mccmon6.dtb
	arch/arm/boot/dts/imx6q-nitrogen6_max.dtb
	arch/arm/boot/dts/imx6q-nitrogen6_som2.dtb
	arch/arm/boot/dts/imx6q-nitrogen6x.dtb
	arch/arm/boot/dts/imx6q-novena.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6q-phytec-pbab01.dtb
	arch/arm/boot/dts/imx6q-pico-dwarf.dtb
	arch/arm/boot/dts/imx6q-pico-hobbit.dtb
	arch/arm/boot/dts/imx6q-pico-nymph.dtb
	arch/arm/boot/dts/imx6q-pico-pi.dtb
	arch/arm/boot/dts/imx6q-pistachio.dtb
	arch/arm/boot/dts/imx6qp-mba6b.dtb
	arch/arm/boot/dts/imx6qp-nitrogen6_max.dtb
	arch/arm/boot/dts/imx6qp-nitrogen6_som2.dtb
	arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6qp-prtwd3.dtb
	arch/arm/boot/dts/imx6q-prti6q.dtb
	arch/arm/boot/dts/imx6q-prtwd2.dtb
	arch/arm/boot/dts/imx6qp-sabreauto.dtb
	arch/arm/boot/dts/imx6qp-sabresd.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8037.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8137.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dtb
	arch/arm/boot/dts/imx6qp-vicutp.dtb
	arch/arm/boot/dts/imx6qp-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dtb
	arch/arm/boot/dts/imx6qp-zii-rdu2.dtb
	arch/arm/boot/dts/imx6q-rex-pro.dtb
	arch/arm/boot/dts/imx6q-sabreauto.dtb
	arch/arm/boot/dts/imx6q-sabrelite.dtb
	arch/arm/boot/dts/imx6q-sabresd.dtb
	arch/arm/boot/dts/imx6q-savageboard.dtb
	arch/arm/boot/dts/imx6q-sbc6x.dtb
	arch/arm/boot/dts/imx6q-skov-revc-lt2.dtb
	arch/arm/boot/dts/imx6q-skov-revc-lt6.dtb
	arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dtb
	arch/arm/boot/dts/imx6q-solidsense.dtb
	arch/arm/boot/dts/imx6q-tbs2910.dtb
	arch/arm/boot/dts/imx6q-ts4900.dtb
	arch/arm/boot/dts/imx6q-ts7970.dtb
	arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dtb
	arch/arm/boot/dts/imx6q-tx6q-1010.dtb
	arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dtb
	arch/arm/boot/dts/imx6q-tx6q-1020.dtb
	arch/arm/boot/dts/imx6q-tx6q-1036.dtb
	arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dtb
	arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dtb
	arch/arm/boot/dts/imx6q-tx6q-1110.dtb
	arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dtb
	arch/arm/boot/dts/imx6q-udoo.dtb
	arch/arm/boot/dts/imx6q-utilite-pro.dtb
	arch/arm/boot/dts/imx6q-var-dt6customboard.dtb
	arch/arm/boot/dts/imx6q-vicut1.dtb
	arch/arm/boot/dts/imx6q-wandboard.dtb
	arch/arm/boot/dts/imx6q-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6q-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6q-yapp4-crux.dtb
	arch/arm/boot/dts/imx6q-zii-rdu2.dtb
	arch/arm/boot/dts/imx6s-dhcom-drc02.dtb

timer@2098000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx6sl-evk.dtb
	arch/arm/boot/dts/imx6sll-evk.dtb
	arch/arm/boot/dts/imx6sll-kobo-clarahd.dtb
	arch/arm/boot/dts/imx6sll-kobo-librah2o.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine2hd.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine3.dtb
	arch/arm/boot/dts/imx6sl-tolino-vision5.dtb
	arch/arm/boot/dts/imx6sl-warp.dtb
	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
	arch/arm/boot/dts/imx6ul-geam.dtb
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
	arch/arm/boot/dts/imx6ul-kontron-bl-43.dtb
	arch/arm/boot/dts/imx6ul-kontron-bl.dtb
	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
	arch/arm/boot/dts/imx6ull-colibri-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dtb
	arch/arm/boot/dts/imx6ul-liteboard.dtb
	arch/arm/boot/dts/imx6ull-jozacp.dtb
	arch/arm/boot/dts/imx6ull-kontron-bl.dtb
	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-tauri-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-tauri-nand.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
	arch/arm/boot/dts/imx6ul-pico-pi.dtb
	arch/arm/boot/dts/imx6ul-prti6g.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb
	arch/arm/boot/dts/imx6ulz-14x14-evk.dtb
	arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dtb

timer@20e8000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
	arch/arm/boot/dts/imx6ul-geam.dtb
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
	arch/arm/boot/dts/imx6ul-kontron-bl-43.dtb
	arch/arm/boot/dts/imx6ul-kontron-bl.dtb
	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
	arch/arm/boot/dts/imx6ull-colibri-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dtb
	arch/arm/boot/dts/imx6ul-liteboard.dtb
	arch/arm/boot/dts/imx6ull-jozacp.dtb
	arch/arm/boot/dts/imx6ull-kontron-bl.dtb
	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-tauri-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-tauri-nand.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
	arch/arm/boot/dts/imx6ul-pico-pi.dtb
	arch/arm/boot/dts/imx6ul-prti6g.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb

timer@302d0000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx7d-cl-som-imx7.dtb
	arch/arm/boot/dts/imx7d-colibri-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-iris.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dtb
	arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-iris.dtb
	arch/arm/boot/dts/imx7d-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
	arch/arm/boot/dts/imx7d-mba7.dtb
	arch/arm/boot/dts/imx7d-meerkat96.dtb
	arch/arm/boot/dts/imx7d-nitrogen7.dtb
	arch/arm/boot/dts/imx7d-pico-dwarf.dtb
	arch/arm/boot/dts/imx7d-pico-hobbit.dtb
	arch/arm/boot/dts/imx7d-pico-nymph.dtb
	arch/arm/boot/dts/imx7d-pico-pi.dtb
	arch/arm/boot/dts/imx7d-remarkable2.dtb
	arch/arm/boot/dts/imx7d-sbc-imx7.dtb
	arch/arm/boot/dts/imx7d-sdb.dtb
	arch/arm/boot/dts/imx7d-sdb-reva.dtb
	arch/arm/boot/dts/imx7d-sdb-sht11.dtb
	arch/arm/boot/dts/imx7d-smegw01.dtb
	arch/arm/boot/dts/imx7d-zii-rmu2.dtb
	arch/arm/boot/dts/imx7d-zii-rpu2.dtb
	arch/arm/boot/dts/imx7s-colibri-aster.dtb
	arch/arm/boot/dts/imx7s-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7s-colibri-iris.dtb
	arch/arm/boot/dts/imx7s-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx7s-mba7.dtb
	arch/arm/boot/dts/imx7s-warp.dtb

timer@302e0000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx7d-cl-som-imx7.dtb
	arch/arm/boot/dts/imx7d-colibri-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-iris.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dtb
	arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-iris.dtb
	arch/arm/boot/dts/imx7d-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
	arch/arm/boot/dts/imx7d-mba7.dtb
	arch/arm/boot/dts/imx7d-meerkat96.dtb
	arch/arm/boot/dts/imx7d-nitrogen7.dtb
	arch/arm/boot/dts/imx7d-pico-dwarf.dtb
	arch/arm/boot/dts/imx7d-pico-hobbit.dtb
	arch/arm/boot/dts/imx7d-pico-nymph.dtb
	arch/arm/boot/dts/imx7d-pico-pi.dtb
	arch/arm/boot/dts/imx7d-remarkable2.dtb
	arch/arm/boot/dts/imx7d-sbc-imx7.dtb
	arch/arm/boot/dts/imx7d-sdb.dtb
	arch/arm/boot/dts/imx7d-sdb-reva.dtb
	arch/arm/boot/dts/imx7d-sdb-sht11.dtb
	arch/arm/boot/dts/imx7d-smegw01.dtb
	arch/arm/boot/dts/imx7d-zii-rmu2.dtb
	arch/arm/boot/dts/imx7d-zii-rpu2.dtb
	arch/arm/boot/dts/imx7s-colibri-aster.dtb
	arch/arm/boot/dts/imx7s-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7s-colibri-iris.dtb
	arch/arm/boot/dts/imx7s-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx7s-mba7.dtb
	arch/arm/boot/dts/imx7s-warp.dtb

timer@302f0000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx7d-cl-som-imx7.dtb
	arch/arm/boot/dts/imx7d-colibri-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-iris.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dtb
	arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-iris.dtb
	arch/arm/boot/dts/imx7d-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
	arch/arm/boot/dts/imx7d-mba7.dtb
	arch/arm/boot/dts/imx7d-meerkat96.dtb
	arch/arm/boot/dts/imx7d-nitrogen7.dtb
	arch/arm/boot/dts/imx7d-pico-dwarf.dtb
	arch/arm/boot/dts/imx7d-pico-hobbit.dtb
	arch/arm/boot/dts/imx7d-pico-nymph.dtb
	arch/arm/boot/dts/imx7d-pico-pi.dtb
	arch/arm/boot/dts/imx7d-remarkable2.dtb
	arch/arm/boot/dts/imx7d-sbc-imx7.dtb
	arch/arm/boot/dts/imx7d-sdb.dtb
	arch/arm/boot/dts/imx7d-sdb-reva.dtb
	arch/arm/boot/dts/imx7d-sdb-sht11.dtb
	arch/arm/boot/dts/imx7d-smegw01.dtb
	arch/arm/boot/dts/imx7d-zii-rmu2.dtb
	arch/arm/boot/dts/imx7d-zii-rpu2.dtb
	arch/arm/boot/dts/imx7s-colibri-aster.dtb
	arch/arm/boot/dts/imx7s-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7s-colibri-iris.dtb
	arch/arm/boot/dts/imx7s-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx7s-mba7.dtb
	arch/arm/boot/dts/imx7s-warp.dtb

timer@30300000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx7d-cl-som-imx7.dtb
	arch/arm/boot/dts/imx7d-colibri-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-iris.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-iris-v2.dtb
	arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-iris.dtb
	arch/arm/boot/dts/imx7d-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
	arch/arm/boot/dts/imx7d-mba7.dtb
	arch/arm/boot/dts/imx7d-meerkat96.dtb
	arch/arm/boot/dts/imx7d-nitrogen7.dtb
	arch/arm/boot/dts/imx7d-pico-dwarf.dtb
	arch/arm/boot/dts/imx7d-pico-hobbit.dtb
	arch/arm/boot/dts/imx7d-pico-nymph.dtb
	arch/arm/boot/dts/imx7d-pico-pi.dtb
	arch/arm/boot/dts/imx7d-remarkable2.dtb
	arch/arm/boot/dts/imx7d-sbc-imx7.dtb
	arch/arm/boot/dts/imx7d-sdb.dtb
	arch/arm/boot/dts/imx7d-sdb-reva.dtb
	arch/arm/boot/dts/imx7d-sdb-sht11.dtb
	arch/arm/boot/dts/imx7d-smegw01.dtb
	arch/arm/boot/dts/imx7d-zii-rmu2.dtb
	arch/arm/boot/dts/imx7d-zii-rpu2.dtb
	arch/arm/boot/dts/imx7s-colibri-aster.dtb
	arch/arm/boot/dts/imx7s-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7s-colibri-iris.dtb
	arch/arm/boot/dts/imx7s-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx7s-mba7.dtb
	arch/arm/boot/dts/imx7s-warp.dtb

timer@401ec000: clock-names:0: 'ipg' was expected
	arch/arm/boot/dts/imxrt1050-evk.dtb

timer@401ec000: clock-names: ['per'] is too short
	arch/arm/boot/dts/imxrt1050-evk.dtb

timer@401ec000: clocks: [[7]] is too short
	arch/arm/boot/dts/imxrt1050-evk.dtb

timer@401ec000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imxrt1050-evk.dtb

timer@53f90000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb
	arch/arm/boot/dts/imx35-pdk.dtb

