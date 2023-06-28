Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826B5740DED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjF1Jva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:51:30 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:53586 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjF1Ji0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:38:26 -0400
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-78362f57500so112625139f.3;
        Wed, 28 Jun 2023 02:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687945105; x=1690537105;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1UpWa5+A+kmLbkjpGcGVFWBo61zYo79kFlUi3Wf7gqc=;
        b=OTtz6bW5qQFcZPfEpQGpH5oncW8ZlyuEK68OAoOxuD7mfC5GmkOIkzIsoKUeCfAPxZ
         2jCFVIxG7DLG6GpbNmK66AvZUH9AVx8I4SoRcZJMp+DLkS6m9iqSH9xszW2aYSsssw9X
         BFe8nXiZmiJpQie3XrIv931DB4Qh/ElegXLAct8dIaGF1CVq8CIL2GfhmpJgR6wyFKVV
         sRJlHMVNnCsNGcFnvybOYNjlBp4ea08KfF1UoP+FfqXLXErxU254HEg9ExmsQChA6SBQ
         LswcIjy1xjWa0g34r9jDpJRB/AYAv+M4FAGTnr88ZXYznI0qyfLeGJFztRPv9Q0UqjNd
         eqlw==
X-Gm-Message-State: AC+VfDxfozfB5sMuxLSVqhgDSS24uzY7qZt2Lj9QPFi9eCCfqx6YdHN3
        lb363lb8U+Nzw+0sdB0rPA==
X-Google-Smtp-Source: ACHHUZ6lzMkMoU6ElEm6Lq68Puq+JoTK6rfxkhnG8wu2dkqCZ1OUrEnRlAD/dzB4zIXhiW1LtRubIg==
X-Received: by 2002:a5e:8a0d:0:b0:780:d8ef:8b06 with SMTP id d13-20020a5e8a0d000000b00780d8ef8b06mr18890628iok.17.1687945105034;
        Wed, 28 Jun 2023 02:38:25 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q7-20020a02cf07000000b0042acdb441a2sm1727097jar.137.2023.06.28.02.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:38:24 -0700 (PDT)
Received: (nullmailer pid 4181075 invoked by uid 1000);
        Wed, 28 Jun 2023 09:38:17 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Seven Lee <wtli@nuvoton.com>
Cc:     robh+dt@kernel.org, alsa-devel@alsa-project.org,
        scott6986@gmail.com, supercraig0719@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, WTLI@nuvoton.com,
        devicetree@vger.kernel.org, CTLIN0@nuvoton.com, KCHSU0@nuvoton.com,
        dardar923@gmail.com, YHCHuang@nuvoton.com, SJLIN0@nuvoton.com,
        lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
In-Reply-To: <20230628085009.1130318-1-wtli@nuvoton.com>
References: <20230628085009.1130318-1-wtli@nuvoton.com>
Message-Id: <168794509789.4181033.630544988903150718.robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: nau8821: Convert to dtschema
Date:   Wed, 28 Jun 2023 03:38:17 -0600
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Jun 2023 16:50:09 +0800, Seven Lee wrote:
> Convert the NAU8821 audio CODEC bindings to DT schema.
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../devicetree/bindings/sound/nau8821.txt     |  55 --------
>  .../bindings/sound/nuvoton,nau8821.yaml       | 125 ++++++++++++++++++
>  2 files changed, 125 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/nau8821.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/milbeaut-clock.example.dtb: /example-2/serial@1e700010: failed to match any schema with compatible: ['socionext,milbeaut-usio-uart']
Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.example.dtb: /example-1/syscon@20e00000: failed to match any schema with compatible: ['sprd,sc9863a-glbregs', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/leds/common.example.dtb: /example-2/i2c/led-controller@30: failed to match any schema with compatible: ['panasonic,an30259a']
Documentation/devicetree/bindings/sound/audio-graph-card2.example.dtb: /example-0/cpu: failed to match any schema with compatible: ['cpu-driver']
Documentation/devicetree/bindings/sound/audio-graph-card2.example.dtb: /example-0/codec: failed to match any schema with compatible: ['codec-driver']
Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.example.dtb: /example-0/avs-monitor@7d5d2000: failed to match any schema with compatible: ['brcm,bcm2711-avs-monitor', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/thermal/imx-thermal.example.dtb: /example-0/anatop@20c8000: failed to match any schema with compatible: ['fsl,imx6q-anatop', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/i2c/qcom,i2c-cci.example.dtb: /example-0/cci@ac4a000/i2c-bus@1/camera@60: failed to match any schema with compatible: ['ovti,ov7251']
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['ti,twl6035-pmic', 'ti,palmas-pmic']
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['ti,twl6035-pmic', 'ti,palmas-pmic']
Documentation/devicetree/bindings/input/mediatek,pmic-keys.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['mediatek,mt6397']
Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.example.dtb: /example-0/pmic@0: failed to match any schema with compatible: ['sprd,sc2731']
Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /example-0/dma-controller@48000000: failed to match any schema with compatible: ['ti,omap-sdma']
Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-dma-crossbar']
Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.example.dtb: /example-0/memory-controller@13410000/ethernet@6: failed to match any schema with compatible: ['davicom,dm9000']
Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.example.dtb: /example-0/peripheral-controller@8a20000/phy@850: failed to match any schema with compatible: ['hisilicon,hi3798cv200-combphy']
Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.example.dtb: /example-0/system-controller@802000/clock@0: failed to match any schema with compatible: ['hisilicon,hi3620-clock']
Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.example.dtb: /example-0/cpuctrl@a22000/clock@0: failed to match any schema with compatible: ['hisilicon,hix5hd2-clock']
Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: /example-0/parent/i2c/camera@36: failed to match any schema with compatible: ['ovti,ov5695']
Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: /example-0/usb/mdio@1/switch@0: failed to match any schema with compatible: ['marvell,mv88e6190']
Documentation/devicetree/bindings/net/qca,ar71xx.example.dtb: /example-0/ethernet@1a000000/mdio/switch@10: failed to match any schema with compatible: ['qca,ar9331-switch']
Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.example.dtb: /example-0/iomcu@ffd7e000: failed to match any schema with compatible: ['hisilicon,hi3660-iomcu', 'syscon']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230628085009.1130318-1-wtli@nuvoton.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

