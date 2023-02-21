Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0356369E1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjBUN6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjBUN6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:58:01 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B82D72B4;
        Tue, 21 Feb 2023 05:57:54 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1720600a5f0so5468520fac.11;
        Tue, 21 Feb 2023 05:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TDAdDLFqqY12DfAfTmg/ckX+ogSVjzXryUSCwBc6rt8=;
        b=m0HdNguml38hL9/xo4LoWtQyDKO9INROJ10Fk77cxEFQaKgX+iFYm+unn7GlRQ81cn
         0i7lDfsPRsSHgNHnDM0xUvr1+M3qBhWYOzL6BPLx0I0ZH8vg3z5Q+cYr+rf0mOgZNIF2
         dfOEhHZiiqUWP+XlZRVnLNmMXQB4x7mtlT0jv0oXMbwwA4n4iUqGgdsRunsbwqdfwqMc
         QIli0GZyZjeGmag7dBUtgk/UTffMqFXqFyLG6lefvQqF7MNwdncbWA55z1UV+4s3RS1x
         pAUIXGDZeH5jhi/TPRTAzjkFGhxg8CZXoo+c9NGoMnyd2TDX+xkbizkAGSzX0+TKGn1v
         hz8g==
X-Gm-Message-State: AO0yUKXbIxYmS9VeKOiNhbLYf6LP2F8ds7AK78nIAbdILSifYn7E/7Yx
        qi/4NGu76WiHvSPWZuJhMVDWDFrNgQ==
X-Google-Smtp-Source: AK7set87S+XCNs18LvSF2lMROtM99jmQ6ppyS9TlTowiAwPfOmZKZoBhEmM6j3hI07+YsuQb38qv6w==
X-Received: by 2002:a05:6870:608e:b0:16a:2473:fa5 with SMTP id t14-20020a056870608e00b0016a24730fa5mr6499245oae.4.1676987873344;
        Tue, 21 Feb 2023 05:57:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dv25-20020a056870d89900b0016dbf59175bsm5188740oab.47.2023.02.21.05.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 05:57:52 -0800 (PST)
Received: (nullmailer pid 2360792 invoked by uid 1000);
        Tue, 21 Feb 2023 13:57:52 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philippe Schenker <philippe.schenker@toradex.com>
In-Reply-To: <20230221102605.2007396-1-linus.walleij@linaro.org>
References: <20230221102605.2007396-1-linus.walleij@linaro.org>
Message-Id: <167698731618.2349693.5906822374742470475.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: MFD: Convert STMPE to YAML schema
Date:   Tue, 21 Feb 2023 07:57:52 -0600
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


On Tue, 21 Feb 2023 11:26:05 +0100, Linus Walleij wrote:
> This converts the STMPE MFD device tree bindings to the YAML
> schema.
> 
> Reference the existing schema for the ADC, just define the
> other subnode schemas directly in the MFD schema.
> 
> Add two examples so we have examples covering both the simple
> GPIO expander and the more complex with ADC and touchscreen.
> 
> Some in-tree users do not follow the naming conventions for nodes
> so these DTS files need to be augmented to use proper node names
> like "adc", "pwm", "gpio", "keyboard-controller" etc before the
> bindings take effect on them.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Philippe Schenker <philippe.schenker@toradex.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I chose to keep the IIO ADC separate YAML file, and contain the
> rest in the MFD YAML file.
> 
> I can pull the IIO ADC it into the MFD YAML file, I can push out
> sub-YAML files per compatible, happy to do it any way you folks
> like, just tell me what to do.
> ---
>  .../bindings/input/stmpe-keypad.txt           |  41 ---
>  .../bindings/input/touchscreen/stmpe.txt      | 108 ------
>  .../devicetree/bindings/mfd/st,stmpe.yaml     | 344 ++++++++++++++++++
>  .../devicetree/bindings/mfd/stmpe.txt         |  42 ---
>  4 files changed, 344 insertions(+), 191 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/stmpe-keypad.txt
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stmpe.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/stmpe.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230221102605.2007396-1-linus.walleij@linaro.org


adc@41: $nodename:0: 'adc@41' does not match '^stmpe[0-9]+@[0-9a-f]+$'
	arch/arm/boot/dts/exynos4412-p4note-n8010.dtb

adc@41: 'interrupt-controller', 'irq-trigger', 'stmpe_adc' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/exynos4412-p4note-n8010.dtb

gpio-expander@44: $nodename:0: 'gpio-expander@44' does not match '^stmpe[0-9]+@[0-9a-f]+$'
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb

gpio-expander@44: '#interrupt-cells', 'interrupt-controller' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb

gpio-expander@44: touchscreen: Unevaluated properties are not allowed ('st,adc-freq', 'st,mod-12b', 'st,ref-sel', 'st,sample-time' were unexpected)
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb

stmpe1600@42: 'interrupt-controller', 'stmpe_gpio' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/stm32429i-eval.dtb

stmpe1601@40: 'interrupt-controller', 'stmpe_keypad' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/ste-hrefprev60-stuib.dtb
	arch/arm/boot/dts/ste-hrefv60plus-stuib.dtb

stmpe1601@40: 'stmpe_gpio' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6q-dmo-edmqmx6.dtb

stmpe1601@44: 'stmpe_gpio' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6q-dmo-edmqmx6.dtb

stmpe2401@43: 'interrupt-controller', 'stmpe_gpio', 'stmpe_keypad', 'stmpe_pwm' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/ste-nomadik-nhk15.dtb

stmpe2401@44: 'interrupt-controller', 'stmpe_gpio' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/ste-nomadik-nhk15.dtb

stmpe@41: $nodename:0: 'stmpe@41' does not match '^stmpe[0-9]+@[0-9a-f]+$'
	arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb
	arch/arm/boot/dts/imx6q-phytec-pbab01.dtb

stmpe@41: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb
	arch/arm/boot/dts/imx6q-phytec-pbab01.dtb

stmpe801@41: '#address-cells', '#size-cells', 'irq-trigger', 'stmpe_gpio' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/spear1340-evb.dtb

stmpe811@41: '#address-cells', '#size-cells', 'blocks', 'id', 'irq-gpios', 'irq-trigger', 'stmpe-gpio', 'stmpe610-ts' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/spear320-hmi.dtb

stmpe811@41: '#address-cells', '#size-cells', 'blocks', 'id', 'irq-gpio', 'stmpe_touchscreen' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dtb

stmpe811@41: 'blocks', 'id', 'interrupt-controller', 'irq-trigger', 'stmpe_adc', 'stmpe_gpio', 'stmpe_pwm', 'stmpe_touchscreen' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am5729-beagleboneai.dtb

stmpe811@41: 'blocks', 'id', 'interrupt-controller', 'irq-trigger', 'stmpe_adc', 'stmpe_touchscreen' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6dl-colibri-aster.dtb
	arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6dl-colibri-iris.dtb
	arch/arm/boot/dts/imx6dl-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx6q-apalis-eval.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dtb

stmpe811@41: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dtb
	arch/arm/boot/dts/spear320-hmi.dtb

stmpe811@41: 'stmpe_adc', 'stmpe_touchscreen' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/stm32f429-disco.dtb

stmpe811@44: 'blocks', 'id', 'irq-gpio', 'irq-trigger', 'stmpe_touchscreen' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6q-novena.dtb

stmpe811@44: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx6q-novena.dtb

stmpe811@44: 'stmpe_touchscreen' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
	arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dtb

touchctrl@44: $nodename:0: 'touchctrl@44' does not match '^stmpe[0-9]+@[0-9a-f]+$'
	arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb

touchctrl@44: 'stmpe_touchscreen' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb

touchscreen@41: $nodename:0: 'touchscreen@41' does not match '^stmpe[0-9]+@[0-9a-f]+$'
	arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dtb
	arch/arm/boot/dts/tegra30-apalis-eval.dtb
	arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dtb
	arch/arm/boot/dts/tegra30-colibri-eval-v3.dtb

touchscreen@41: 'blocks', 'id', 'interrupt-controller', 'irq-gpio', 'irq-trigger', 'stmpe_adc', 'stmpe_touchscreen' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/tegra30-apalis-eval.dtb
	arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dtb
	arch/arm/boot/dts/tegra30-colibri-eval-v3.dtb

touchscreen@41: 'interrupt-controller', 'stmpe_touchscreen' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dtb

touchscreen@41: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/tegra30-apalis-eval.dtb
	arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dtb
	arch/arm/boot/dts/tegra30-colibri-eval-v3.dtb

touchscreen@44: $nodename:0: 'touchscreen@44' does not match '^stmpe[0-9]+@[0-9a-f]+$'
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/rk3288-phycore-rdk.dtb

touchscreen@44: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/rk3288-phycore-rdk.dtb

touchscreen@44: 'stmpe_touchscreen' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb

