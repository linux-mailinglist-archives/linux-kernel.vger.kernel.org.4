Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0B5F15B7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiI3WF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiI3WFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:05:49 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78087A538;
        Fri, 30 Sep 2022 15:05:47 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id d74-20020a4a524d000000b004755f8aae16so3121005oob.11;
        Fri, 30 Sep 2022 15:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HJtfTBE4oBzIjRoSP4k/w5L2USOVQ9QWyL3Cv6mKKdQ=;
        b=o1FXNkmSAtPjLT8UxzJJppo0+gbJfPJVR7ISUbhMh4fA7uDr2PtIB9tjafPJtbdiWu
         RCc+U6HUXL0Db0IERCyh/wPLD23DQiyRf2m6KWEXKh8V5fcqzv2RgXKJU0tdaEkU8BGb
         JLtv+FIaZ+boOcrI87Yfex/YcCP33SwXZv7w9/04ygOOJ3fqE2yl3f2k4sV713BfLe8e
         H/UUyFN9PYukYUTeGK70I6m47j68tQ6sHn7eM/IeXgBmHRxQRLKiiEf2CUMqeYh+s6Wm
         hUNchz1hrpGDnIY7jFMl0gCp4wBNbUr54tNNmM+yqFLMg8gzwEyI4rOnU0K7iL3YY0Xb
         vnXA==
X-Gm-Message-State: ACrzQf2tJYqo2pIqcmZzaygbZ3FknnuDXcMyybvztkPy8HBZtsL945iN
        6UfvyILte1ZLQ8fA1+lARw==
X-Google-Smtp-Source: AMsMyM4fYqHKD58rudAJVQnce+h9PCWy+Xl9vpKeXf/QgZTu/9ORgjbFS/JGgNsy1fPUibEHXPPR+A==
X-Received: by 2002:a05:6820:1888:b0:476:1d00:9d8f with SMTP id bm8-20020a056820188800b004761d009d8fmr4084027oob.98.1664575546867;
        Fri, 30 Sep 2022 15:05:46 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a056870204b00b0012796e8033dsm978279oad.57.2022.09.30.15.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:05:46 -0700 (PDT)
Received: (nullmailer pid 1129758 invoked by uid 1000);
        Fri, 30 Sep 2022 22:05:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20220930200529.331223-3-krzysztof.kozlowski@linaro.org>
References: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org> <20220930200529.331223-3-krzysztof.kozlowski@linaro.org>
Message-Id: <166457528911.1113207.5679249386040323169.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: qcom,sdm845: convert to dtschema
Date:   Fri, 30 Sep 2022 17:05:43 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 22:05:29 +0200, Krzysztof Kozlowski wrote:
> Convert Qualcomm SDM845 pin controller bindings to DT schema.  Keep
> the parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 176 ------------------
>  .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml | 158 ++++++++++++++++
>  2 files changed, 158 insertions(+), 176 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pinctrl@3400000: 'ap-edp-bklten', 'ap-suspend-l-hog', 'ap_suspend_l_assert', 'ap_suspend_l_deassert', 'bios-flash-wp-r-l', 'cci0-default', 'cci0-sleep', 'cci1-default', 'cci1-sleep', 'ec-ap-int-l', 'edp-brij-en', 'edp-brij-irq', 'en-pp3300-dx-edp', 'h1-ap-int-odl', 'pen-eject-odl', 'pen-irq-l', 'pen-pdct-l', 'pen-rst-l', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qspi-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'quat_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default', 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c13-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default', 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-default', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-spi0-default', 'qup-spi1-default', 'qup-spi10-defau
 lt', 'qup-spi11-default', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-spi15-default', 'qup-spi2-default', 'qup-spi3-default', 'qup-spi4-default', 'qup-spi5-default', 'qup-spi6-default', 'qup-spi7-default', 'qup-spi8-default', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'qup-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-default', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-default', 'sd-cd-odl', 'sdc2-clk', 'sdc2-cmd', 'sdc2-data', 'ts-int-l', 'ts-reset-l' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dtb

pinctrl@3400000: 'cam0_default', 'cam3_default', 'cci0-default', 'cci0-sleep', 'cci1-default', 'cci1-sleep', 'dsi-sw-sel', 'lt9611-irq', 'pcie0-default', 'pcie0-pwren', 'pcie1-default', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qspi-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'quat_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default', 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c13-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default', 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-default', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-spi0-default', 'qup-spi1-default', 'qup-spi10-default', 'qup-spi11-default', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-spi15-default', 'qup-spi2-default', 'qup-sp
 i3-default', 'qup-spi4-default', 'qup-spi5-default', 'qup-spi6-default', 'qup-spi7-default', 'qup-spi8-default', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'qup-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-default', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-default', 'sd-card-det-n', 'sdc2-default', 'wcd_intr_default' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-db845c.dtb

pinctrl@3400000: 'cci0-default', 'cci0-sleep', 'cci1-default', 'cci1-sleep', 'i2c11-hid-active', 'i2c2-hid-active', 'i2c5-hid-active', 'lid-pin', 'mode-pin', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qspi-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'quat_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default', 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c13-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default', 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-default', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-spi0-default', 'qup-spi1-default', 'qup-spi10-default', 'qup-spi11-default', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-spi15-default', 'qup-spi2-default', 'qup-spi3-default', 'qup-spi4-defau
 lt', 'qup-spi5-default', 'qup-spi6-default', 'qup-spi7-default', 'qup-spi8-default', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'qup-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-default', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-default', 'sn65dsi86-enable', 'wcd_intr_default' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dtb

pinctrl@3400000: 'cci0-default', 'cci0-sleep', 'cci1-default', 'cci1-sleep', 'panel-esd', 'panel-reset', 'panel-te', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qspi-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'quat_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default', 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c13-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default', 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-default', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-spi0-default', 'qup-spi1-default', 'qup-spi10-default', 'qup-spi11-default', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-spi15-default', 'qup-spi2-default', 'qup-spi3-default', 'qup-spi4-default', 'qup-spi5-default', 'qup-spi6-defaul
 t', 'qup-spi7-default', 'qup-spi8-default', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'qup-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-default', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-default', 'tri_state_key_default', 'ts-int' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb

pinctrl@3400000: 'cci0-default', 'cci0-sleep', 'cci1-default', 'cci1-sleep', 'pen-irq-l', 'pen-pdct-l', 'pen-rst-l', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qspi-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'quat_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default', 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c13-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default', 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-default', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-spi0-default', 'qup-spi1-default', 'qup-spi10-default', 'qup-spi11-default', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-spi15-default', 'qup-spi2-default', 'qup-spi3-default', 'qup-spi4-default', 'qup-spi5-default', 'qup-spi6-defaul
 t', 'qup-spi7-default', 'qup-spi8-default', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'qup-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-default', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-default', 'wcd_intr_default' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dtb

pinctrl@3400000: 'cci0-default', 'cci0-sleep', 'cci1-default', 'cci1-sleep', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qspi-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'quat_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default', 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c13-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default', 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-default', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-spi0-default', 'qup-spi1-default', 'qup-spi10-default', 'qup-spi11-default', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-spi15-default', 'qup-spi2-default', 'qup-spi3-default', 'qup-spi4-default', 'qup-spi5-default', 'qup-spi6-default', 'qup-spi7-default', 'qup-spi8-defaul
 t', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'qup-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-default', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-default' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dtb

pinctrl@3400000: 'cci0-default', 'cci0-sleep', 'cci1-default', 'cci1-sleep', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qspi-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'quat_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default', 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c13-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default', 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-default', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-spi0-default', 'qup-spi1-default', 'qup-spi10-default', 'qup-spi11-default', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-spi15-default', 'qup-spi2-default', 'qup-spi3-default', 'qup-spi4-default', 'qup-spi5-default', 'qup-spi6-default', 'qup-spi7-default', 'qup-spi8-defaul
 t', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'qup-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-default', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-default', 'sd-card-det-n', 'sdc2-clk', 'sdc2-cmd', 'sdc2-data' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-lg-judyp.dtb
	arch/arm64/boot/dts/qcom/sdm845-mtp.dtb

pinctrl@3400000: 'cci0-default', 'cci0-sleep', 'cci1-default', 'cci1-sleep', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qspi-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'quat_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default', 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c13-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default', 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-default', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-spi0-default', 'qup-spi1-default', 'qup-spi10-default', 'qup-spi11-default', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-spi15-default', 'qup-spi2-default', 'qup-spi3-default', 'qup-spi4-default', 'qup-spi5-default', 'qup-spi6-default', 'qup-spi7-default', 'qup-spi8-defaul
 t', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'qup-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-default', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-default', 'sd-card-det-n', 'sdc2-clk', 'sdc2-cmd', 'sdc2-data', 'thinq-key-default' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dtb

pinctrl@3400000: 'cci0-default', 'cci0-sleep', 'cci1-default', 'cci1-sleep', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qspi-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'quat_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default', 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c13-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default', 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-default', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-spi0-default', 'qup-spi1-default', 'qup-spi10-default', 'qup-spi11-default', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-spi15-default', 'qup-spi2-default', 'qup-spi3-default', 'qup-spi4-default', 'qup-spi5-default', 'qup-spi6-default', 'qup-spi7-default', 'qup-spi8-defaul
 t', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'qup-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-default', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-default', 'sd-card-det-n', 'sdc2-default', 'wcd_intr_default' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dtb

pinctrl@3400000: 'cci0-default', 'cci0-sleep', 'cci1-default', 'cci1-sleep', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qspi-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'quat_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default', 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c13-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default', 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-default', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-spi0-default', 'qup-spi1-default', 'qup-spi10-default', 'qup-spi11-default', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-spi15-default', 'qup-spi2-default', 'qup-spi3-default', 'qup-spi4-default', 'qup-spi5-default', 'qup-spi6-default', 'qup-spi7-default', 'qup-spi8-defaul
 t', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'qup-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-default', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-default', 'sde-dsi-active', 'sde-dsi-suspend', 'sde-te-active', 'sde-te-suspend', 'ts-int-active', 'ts-int-suspend', 'ts-reset-active', 'ts-reset-suspend' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb

pinctrl@3400000: 'cci0-default', 'cci0-sleep', 'cci1-default', 'cci1-sleep', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qspi-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'quat_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default', 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c13-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default', 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-default', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-spi0-default', 'qup-spi1-default', 'qup-spi10-default', 'qup-spi11-default', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-spi15-default', 'qup-spi2-default', 'qup-spi3-default', 'qup-spi4-default', 'qup-spi5-default', 'qup-spi6-default', 'qup-spi7-default', 'qup-spi8-defaul
 t', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'qup-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-default', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-default', 'sde-dsi-active', 'sde-dsi-suspend', 'ts-int-default', 'ts-int-sleep', 'ts-reset-default', 'ts-reset-sleep', 'wcd-intr-default' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dtb

pinctrl@3400000: sdc2-default-state: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dtb

