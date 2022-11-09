Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06BD622C0A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiKIM77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKIM7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:59:50 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA69295;
        Wed,  9 Nov 2022 04:59:49 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso19489271fac.13;
        Wed, 09 Nov 2022 04:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IorQxebq1IkLKdmdug0pO7ZDEecFvRtQoVpI506EQvw=;
        b=AFLC6uS/eVH6N8Z3t0jR3+9c5QrIVNREkh2y8Vt1+6B3bKP5j/jKPL2K8fJeBkZQ2g
         cIH0+vQMRD8wx3aOXtdTL1MH/q4ikTZLIDhz2CkNyelRem7g6ph9zo2XmYp49Y3jsrJo
         ENv63IIqhme2AX8A+/tAkOq1UyH3frsXWlQA953uqvvPocAV/LlXWSOoVv7hi+L0357g
         f01NJTnm199IoWjhgIcBjzK8k6ORdBY6OKePyG7UuODT7nsustDLB7y1qsdPs6xm8iud
         30N3ZFF6MbX/jlnr6VFglgZ78aA0WbWL+6KsZbPgeckBcjU526UuvHPeA5onSH8KYxmR
         +1cA==
X-Gm-Message-State: ACrzQf08p+2kjVPYD6GH0FwHis9kG2jif/ebcEfeiaKnyxxneTPwecfj
        2bs9IiIdymeh+fjdQYRONQ==
X-Google-Smtp-Source: AMsMyM6v+OG1eliq8Ysr/2ZhqW/vBOs8Zq4nHM9Lpv0mKjILtoLiEyH2cl91J+qfv0ho/a8CpEYKZA==
X-Received: by 2002:a05:6870:58a4:b0:11c:9b6d:f066 with SMTP id be36-20020a05687058a400b0011c9b6df066mr35496743oab.155.1667998788293;
        Wed, 09 Nov 2022 04:59:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i25-20020a9d6519000000b0066cc88749f8sm3914504otl.68.2022.11.09.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 04:59:47 -0800 (PST)
Received: (nullmailer pid 1538569 invoked by uid 1000);
        Wed, 09 Nov 2022 12:59:47 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221109104402.45592-1-krzysztof.kozlowski@linaro.org>
References: <20221109104402.45592-1-krzysztof.kozlowski@linaro.org>
Message-Id: <166799861348.1536107.4747849372358837118.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom,msm8916: convert to dtschema
Date:   Wed, 09 Nov 2022 06:59:47 -0600
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


On Wed, 09 Nov 2022 11:44:01 +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8916 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,msm8916-pinctrl.txt | 195 ------------------
>  .../pinctrl/qcom,msm8916-pinctrl.yaml         | 166 +++++++++++++++
>  2 files changed, 166 insertions(+), 195 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pinctrl@1000000: 'accel-int-default', 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-flash-default', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ctp-pwr-en-default', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'gpio-keys-default', 'gyro-int-default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'light-int-default', 'magn-int-default', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'tp-int-default', 'wcnss-active' do not match any of the regexes: '-state$', 'pinct
 rl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb

pinctrl@1000000: 'accel-int-default', 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'fg-alert-default', 'gpio-hall-sensor-default', 'gpio-keys-default', 'gpio-led-default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'mdss', 'motor-en-default', 'muic-i2c-default', 'muic-int-default', 'nfc-default', 'nfc-i2c-default', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'tkey-default', 'tke
 y-en-default', 'tkey-i2c-default', 'ts-int-default', 'tsp-en-default', 'wcnss-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-grandmax.dtb

pinctrl@1000000: 'accel-int-default', 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'fg-alert-default', 'gpio-hall-sensor-default', 'gpio-keys-default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'mdss', 'motor-en-default', 'muic-i2c-default', 'muic-int-default', 'nfc-default', 'nfc-i2c-default', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'tkey-default', 'tkey-en-default', 'tkey
 -i2c-default', 'ts-int-default', 'tsp-en-default', 'wcnss-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-e7.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-e5.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-e7.dtb

pinctrl@1000000: 'accel-int-default', 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'fg-alert-default', 'gpio-hall-sensor-default', 'gpio-keys-default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'mdss', 'muic-i2c-default', 'muic-int-default', 'nfc-default', 'nfc-i2c-default', 'panel-vdd3-default', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'tkey-default', 'tkey-en-default', 'tk
 ey-i2c-default', 'tkey-led-en-default', 'ts-int-default', 'tsp-en-default', 'wcnss-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb

pinctrl@1000000: 'accel-int-default', 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'fg-alert-default', 'gpio-hall-sensor-default', 'gpio-keys-default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'mdss', 'muic-i2c-default', 'muic-int-default', 'nfc-default', 'nfc-i2c-default', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'tkey-default', 'tkey-en-default', 'tkey-i2c-default', 'ts-i
 nt-default', 'tsp-en-default', 'wcnss-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb

pinctrl@1000000: 'accel-int-default', 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'gpio-keys-default', 'gyro-int-default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'mag-reset-default', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'proximity-int-default', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'ts-int-reset-default', 'usb-id-default', 'wcnss-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb

pinctrl@1000000: 'accel-irq-default', 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'gpio-keys-default', 'gpio-leds-default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'mag-reset-default', 'nfc-default', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'prox-irq-default', 'reg-lcd-en-default', 'sdhc2-cd-default', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'ts-irq-default', 'usb-id-default', 'wcnss-active' do not match any of 
 the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb

pinctrl@1000000: 'adv533-int-active', 'adv7533-int-suspend', 'adv7533-switch-active', 'adv7533-switch-suspend', 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'msm-key-volp-n-default', 'msmgpio-leds', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'usb-id-default', 'wcnss-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
	arch/arm/boot/dts/qcom-apq8016-sbc.dtb

pinctrl@1000000: 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'button-backlight-default', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'gpio-keys-default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'mag-reset-default', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'usb-id-default', 'wcnss-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb

pinctrl@1000000: 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'fg-alert-default', 'gpio-hall-sensor-default', 'gpio-keys-default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'imu-irq-default', 'muic-i2c-default', 'muic-irq-default', 'nfc-default', 'nfc-i2c-default', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'tkey-default', 'tkey-en-default', 'tkey-i2c-default', 'tkey-led-en-de
 fault', 'tsp-en-default', 'tsp-irq-default', 'wcnss-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb

pinctrl@1000000: 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'gpio-keys-default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'imu-default', 'mag-reset-default', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'sd-vmmc-en-default', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'touchscreen-default', 'usb-id-default', 'wcnss-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb

pinctrl@1000000: 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'gpio-keys-default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'imu-default', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'touchscreen-default', 'usb-id-default', 'wcnss-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb

pinctrl@1000000: 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'gpio-keys-default', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'wcnss-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb

pinctrl@1000000: 'blsp1-uart1-default', 'blsp1-uart1-sleep', 'blsp1-uart2-default', 'blsp1-uart2-sleep', 'camera-front-default', 'camera-rear-default', 'cci0-default', 'cdc-dmic-lines', 'cdc-pdm-lines', 'ext-mclk-tlmm-lines', 'ext-pri-tlmm-lines', 'ext-pri-ws-line', 'ext-sec-tlmm-lines', 'i2c1-default', 'i2c1-sleep', 'i2c2-default', 'i2c2-sleep', 'i2c3-default', 'i2c3-sleep', 'i2c4-default', 'i2c4-sleep', 'i2c5-default', 'i2c5-sleep', 'i2c6-default', 'i2c6-sleep', 'pmx-sdc1-clk', 'pmx-sdc1-cmd', 'pmx-sdc1-data', 'pmx-sdc2-cd-pin', 'pmx-sdc2-clk', 'pmx-sdc2-cmd', 'pmx-sdc2-data', 'spi1-default', 'spi1-sleep', 'spi2-default', 'spi2-sleep', 'spi3-default', 'spi3-sleep', 'spi4-default', 'spi4-sleep', 'spi5-default', 'spi5-sleep', 'spi6-default', 'spi6-sleep', 'wcnss-active' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8916-mtp.dtb

