Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC5B740E88
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjF1KUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:20:39 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:44532 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjF1KSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:18:33 -0400
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-345c487807bso3814385ab.1;
        Wed, 28 Jun 2023 03:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687947512; x=1690539512;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jkZY5XWnI6WOwfagmaCwCAQfGioFt+uVaBoTTNmJFWA=;
        b=i0Yug6i/hnUkJLaytp8u2FDJgOYkaSXTPo1o5ZZTFCONNo204GWdO0NQHNz7gkBR4z
         XK+/8bDLgSn6j65B7xKgeOWrkIhXB4Yp66oZ3ijT/gNs7q3WI/mJKtymbzqc0GGC8akN
         Yrz5zfdTj16W9ncWQvZrWw2Ssd9eeYwiCbKD0aDi40SHsKZqWjQVy7Ii7hdGuX4Oh5B+
         ZbacGohjatdfka6suJzBVoUrTG+zflFf5E0bA0saZLDLMZtrJz5ljRnOoskU3lP2ophH
         WEbdc9DgKvKpiSx61hGGO2Z0IehThIP7Nl2x/4DB6945ojDOlhOtUWMwDXhfzUcJtGeN
         3NQA==
X-Gm-Message-State: AC+VfDzVTO/dzgD5n6NvBbC2S949aB5nhbqiAkhsfV0NtvYDB1xEY3S6
        wdzOskjVZvy9+Qalh93xndKVXmwF1w==
X-Google-Smtp-Source: ACHHUZ4F1SZzbggWtZ3M7Dd8uYudBHLwcuRpSuiAOEntbx7YA5l4kCgwSe8zR4CL2ou+ywBadXOIEQ==
X-Received: by 2002:a92:cac8:0:b0:345:bfdb:3548 with SMTP id m8-20020a92cac8000000b00345bfdb3548mr4273966ilq.2.1687947512250;
        Wed, 28 Jun 2023 03:18:32 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q9-20020a92c009000000b0034267d3fcc5sm3324584ild.55.2023.06.28.03.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 03:18:31 -0700 (PDT)
Received: (nullmailer pid 47051 invoked by uid 1000);
        Wed, 28 Jun 2023 10:18:26 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Imran Shaik <quic_imrashai@quicinc.com>
Cc:     Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20230628092837.3090801-2-quic_imrashai@quicinc.com>
References: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
 <20230628092837.3090801-2-quic_imrashai@quicinc.com>
Message-Id: <168794750675.47016.17958709493582414189.robh@kernel.org>
Subject: Re: [PATCH V2 1/5] dt-bindings: clock: Update GCC clocks for
 QDU1000 and QRU1000 SoCs
Date:   Wed, 28 Jun 2023 04:18:26 -0600
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Jun 2023 14:58:33 +0530, Imran Shaik wrote:
> Update the qcom GCC clock bindings for QDU1000 and QRU1000 SoCs.
> 
> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
> Chanes since v1:
>  - Removed the v2 variant compatible string changes
>  - Updated the maintainers list
> 
>  Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml | 3 ++-
>  include/dt-bindings/clock/qcom,qdu1000-gcc.h                  | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230628092837.3090801-2-quic_imrashai@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

