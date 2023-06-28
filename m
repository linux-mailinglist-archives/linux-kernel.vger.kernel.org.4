Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956A9740DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjF1Jx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:53:27 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:45068 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjF1JiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:38:23 -0400
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-77acb04309dso287194039f.2;
        Wed, 28 Jun 2023 02:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687945102; x=1690537102;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XOpBCKE+PIRr5MgGPC1pYSwv19OzpzqzpgmhgsMavwo=;
        b=g5VqDoPapIAaDPb68zNYxAKZzdJc/DvP+33FAJP8JTLu08WfKIb0FVSPkRCN95CWsT
         OJi3YRrEFkLZDjiJJY+SRQ4JY0MWjIYpWoqVBwDUL7D3R992EcWDs3uAQhWTWKz9IbsS
         4BYnZpyIxk7Wg2uQUQ/w48rlX6CxqI6X2a8QM6mAl4aATxLZWXAZ69IOvRxd7v1lUGrY
         SNSl0GSOq+5GMXu3O02XnvD5rpGlmGW764jD+Qsrbeux2BoHaOFXAO46YquzB6pZMaml
         nN5a6NJEZDVWZ0Ud3acs6mEBuQViTfWq3aOqTFFU43pA8xRNIHUt7A9r536+504uQL9t
         nBMA==
X-Gm-Message-State: AC+VfDw/AciQuEM72KYaPXzrshxjyZNSpFIhG8nh4anjvGuiTHyknl60
        VGJ3ZskIhrNh5pwnBp9ZGxKX6fu0vw==
X-Google-Smtp-Source: ACHHUZ7aZ+YVb425TfCrUALvFuPQDBZ6ct5yhqYMzSjPk05y5iZkOnAREaFJwZcG3G0AGJrOu2GnTA==
X-Received: by 2002:a6b:e60a:0:b0:783:71b1:50cf with SMTP id g10-20020a6be60a000000b0078371b150cfmr5833101ioh.11.1687945102273;
        Wed, 28 Jun 2023 02:38:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z3-20020a6b5c03000000b0077ac4b77d62sm3475262ioh.43.2023.06.28.02.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:38:21 -0700 (PDT)
Received: (nullmailer pid 4181073 invoked by uid 1000);
        Wed, 28 Jun 2023 09:38:17 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     cy_huang@richtek.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        conor+dt@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1687942037-14652-2-git-send-email-cy_huang@richtek.com>
References: <1687942037-14652-1-git-send-email-cy_huang@richtek.com>
 <1687942037-14652-2-git-send-email-cy_huang@richtek.com>
Message-Id: <168794509690.4180998.4132353427147392015.robh@kernel.org>
Subject: Re: [PATCH 1/2] regulator: dt-bindings: rt5739: Add compatible for
 rt5733
Date:   Wed, 28 Jun 2023 03:38:17 -0600
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Jun 2023 16:47:16 +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add compatible string for rt5733.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.example.dtb: /example-0/cpuctrl@a22000/clock@0: failed to match any schema with compatible: ['hisilicon,hix5hd2-clock']
Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.example.dtb: /example-0/system-controller@802000/clock@0: failed to match any schema with compatible: ['hisilicon,hi3620-clock']
Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.example.dtb: /example-0/peripheral-controller@8a20000/phy@850: failed to match any schema with compatible: ['hisilicon,hi3798cv200-combphy']
Documentation/devicetree/bindings/net/qca,ar71xx.example.dtb: /example-0/ethernet@1a000000/mdio/switch@10: failed to match any schema with compatible: ['qca,ar9331-switch']
Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: /example-0/usb/mdio@1/switch@0: failed to match any schema with compatible: ['marvell,mv88e6190']
Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: /example-0/parent/i2c/camera@36: failed to match any schema with compatible: ['ovti,ov5695']
Documentation/devicetree/bindings/thermal/imx-thermal.example.dtb: /example-0/anatop@20c8000: failed to match any schema with compatible: ['fsl,imx6q-anatop', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.example.dtb: /example-0/avs-monitor@7d5d2000: failed to match any schema with compatible: ['brcm,bcm2711-avs-monitor', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.example.dtb: /example-0/memory-controller@13410000/ethernet@6: failed to match any schema with compatible: ['davicom,dm9000']
Documentation/devicetree/bindings/leds/common.example.dtb: /example-2/i2c/led-controller@30: failed to match any schema with compatible: ['panasonic,an30259a']
Documentation/devicetree/bindings/clock/milbeaut-clock.example.dtb: /example-2/serial@1e700010: failed to match any schema with compatible: ['socionext,milbeaut-usio-uart']
Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.example.dtb: /example-1/syscon@20e00000: failed to match any schema with compatible: ['sprd,sc9863a-glbregs', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/sound/audio-graph-card2.example.dtb: /example-0/cpu: failed to match any schema with compatible: ['cpu-driver']
Documentation/devicetree/bindings/sound/audio-graph-card2.example.dtb: /example-0/codec: failed to match any schema with compatible: ['codec-driver']
Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.example.dtb: /example-0/iomcu@ffd7e000: failed to match any schema with compatible: ['hisilicon,hi3660-iomcu', 'syscon']
Documentation/devicetree/bindings/i2c/qcom,i2c-cci.example.dtb: /example-0/cci@ac4a000/i2c-bus@1/camera@60: failed to match any schema with compatible: ['ovti,ov7251']
Documentation/devicetree/bindings/input/mediatek,pmic-keys.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['mediatek,mt6397']
Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.example.dtb: /example-0/pmic@0: failed to match any schema with compatible: ['sprd,sc2731']
Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-dma-crossbar']
Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /example-0/dma-controller@48000000: failed to match any schema with compatible: ['ti,omap-sdma']
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['ti,twl6035-pmic', 'ti,palmas-pmic']
Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['ti,twl6035-pmic', 'ti,palmas-pmic']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1687942037-14652-2-git-send-email-cy_huang@richtek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

