Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955636C3271
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjCUNR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjCUNRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:17:52 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8B43B3D3;
        Tue, 21 Mar 2023 06:17:49 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id bk5so1773275oib.6;
        Tue, 21 Mar 2023 06:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404669;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j+nNG4CRmvp57djbTm+wpvC5ckLMSjxKHNGUYKAJVhM=;
        b=YZCr8Yhm04akhb5xZg53KolEZsVX6trLY3amJqSfgPhUUjAuBu5MYvuF9UAHYMyLhw
         E0Uj8ESPo4kgOWD4PE+xBDxvBPb7t3k8jmZXnVC6he+n2PSaNaaejOL1FRaNgpI0e/SS
         h4SVEsoPUwCSBVeCyOup3Pq8deGrUnvW/e18Lbo2iBo6VKIWk0m86o9aevB8avhKxN5l
         loCxuc3may/rNC2mdQ6txwka3D7y/ynQUQ/fMpiEQwzOFtoiURw80FGaWZdpKVFKeelq
         WtcO/jG/vBycX2uREvCv+hN3hiTovNBx04wEE0PcclelmA/lzDVFwqI+37bm4BXqQspi
         J2ZQ==
X-Gm-Message-State: AO0yUKUM9wQDuq8PelnhuuPFCCarq8t1gcDMKZYEPleM4ar2JF+4fMjy
        JR2OJAB/Khe4SzUwbkZoCg==
X-Google-Smtp-Source: AK7set82FcKW/p5W4iGNn5MuODuFnAoFOZ5uexG3vj4tkSfjSNgfps8JYyPhOdVceB21qsXggYRnpQ==
X-Received: by 2002:aca:2316:0:b0:386:c5ad:16ab with SMTP id e22-20020aca2316000000b00386c5ad16abmr1011331oie.10.1679404668834;
        Tue, 21 Mar 2023 06:17:48 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v41-20020a4a8c6c000000b0052532296449sm4843750ooj.20.2023.03.21.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 06:17:48 -0700 (PDT)
Received: (nullmailer pid 582077 invoked by uid 1000);
        Tue, 21 Mar 2023 13:17:45 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
In-Reply-To: <20230320135710.1989-4-johan+linaro@kernel.org>
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-4-johan+linaro@kernel.org>
Message-Id: <167940239018.531701.12929244936825953214.robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: mfd: qcom,spmi-pmic: add nvram
 function
Date:   Tue, 21 Mar 2023 08:17:45 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Mar 2023 14:57:10 +0100, Johan Hovold wrote:
> Add an 'nvram' pattern property and a reference to the corresponding
> SDAM DT schema.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230320135710.1989-4-johan+linaro@kernel.org


pm8941@0: gpio@c000: 'otg' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb

pm8941@0: 'pwrkey@800' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'pinctrl-[0-9]+', 'pon@[0-9a-f]+$'
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dtb
	arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dtb

pma8084@0: 'pwrkey@800' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'pinctrl-[0-9]+', 'pon@[0-9a-f]+$'
	arch/arm/boot/dts/qcom-apq8084-ifc6540.dtb
	arch/arm/boot/dts/qcom-apq8084-mtp.dtb
	arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dtb

pmic@0: 'extcon@1300' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'pinctrl-[0-9]+', 'pon@[0-9a-f]+$'
	arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
	arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dtb
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
	arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dtb
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
	arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-e7.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
	arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dtb
	arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dtb
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
	arch/arm/boot/dts/qcom-apq8016-sbc.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-e5.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-e7.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-grandmax.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb

pmic@2: adc@3100:adc-chan@8:qcom,pre-scaling: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb

pmic@2: adc@3100: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb

pmic@2: adc@4500:compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
	arch/arm64/boot/dts/qcom/sdm845-db845c.dtb
	arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dtb
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dtb

pmic@2: adc@4500: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
	arch/arm64/boot/dts/qcom/sdm845-db845c.dtb
	arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dtb
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dtb

pmic@2: gpio@c000:button-backlight-state: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb

pmic@3: leds@d800:interrupt-names:0: 'ovp' was expected
	arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dtb
	arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dtb
	arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dtb
	arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dtb

pmic@3: leds@d800:interrupt-names: ['ovp'] is too short
	arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
	arch/arm64/boot/dts/qcom/sdm670-google-sargo.dtb

pmic@3: leds@d800:interrupt-names: ['short'] is too short
	arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dtb
	arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dtb
	arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dtb
	arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dtb

pmic@3: leds@d800:interrupts: [[3, 216, 1, 1]] is too short
	arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
	arch/arm64/boot/dts/qcom/sdm670-google-sargo.dtb

pmic@3: leds@d800:interrupts: [[3, 216, 2, 1]] is too short
	arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dtb
	arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dtb
	arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dtb
	arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dtb

pmic@3: leds@d800: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dtb
	arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dtb

pmic@3: regulators: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 's2@1700' were unexpected)
	arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb

pmic@3: regulators: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

pmic@3: wled@d800:interrupt-names:0: 'ovp' was expected
	arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
	arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

pmic@3: wled@d800:interrupt-names: ['short'] is too short
	arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
	arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

pmic@3: wled@d800:interrupts: [[3, 216, 2, 1]] is too short
	arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
	arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
	arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

pmic@3: wled@d800: 'label' is a required property
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

pmic@3: wled@d800: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

pmic@5: 'led-controller@d300' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'pinctrl-[0-9]+', 'pon@[0-9a-f]+$'
	arch/arm64/boot/dts/qcom/sc7180-idp.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb
	arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb

pmic@5: leds@d800:interrupt-names: ['ovp'] is too short
	arch/arm64/boot/dts/qcom/sc7180-idp.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb
	arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb

pmic@5: leds@d800:interrupts: [[5, 216, 1, 1]] is too short
	arch/arm64/boot/dts/qcom/sc7180-idp.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb
	arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb

pmic@7: compatible:0: 'qcom,pm8450' is not one of ['qcom,pm6125', 'qcom,pm6150', 'qcom,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm8009', 'qcom,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,pm8150', 'qcom,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', 'qcom,pm8350', 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8550', 'qcom,pm8550b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom,pm8909', 'qcom,pm8916', 'qcom,pm8941', 'qcom,pm8950', 'qcom,pm8953', 'qcom,pm8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmd9635', 'qcom,pmi8950', 'qcom,pmi8962', 'qcom,pmi8994', 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', 'qcom,pmk8550', 'qcom,pmm8155au', 'qcom,pmp8074', 'qcom,pmr735a', 'qcom,pmr735b', 'qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'qcom,pmx65', 'qcom,smb2351']
	arch/arm64/boot/dts/qcom/sm8450-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8450-qrd.dtb
	arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dtb
	arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dtb

