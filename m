Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7BF7415AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjF1Pve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:51:34 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:56808 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjF1PvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:51:08 -0400
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7836272f36eso2547839f.1;
        Wed, 28 Jun 2023 08:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687967468; x=1690559468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsVwnvN8UA+vjzML9ynuWlM7XDFzQVSclkHUBpH0XLE=;
        b=W39UCYy1wW3da7oNx14FZmuIhcxGV4vOE+yYJE/gtE6Uta7mvleCtKfIsoRMb67hiQ
         ykzyQJBHbIsOAL0mwqqYMqctXQbAs+udjNmvo+0n78pSmYcI7jfj0YSO3MuIG1PMD6jO
         sSW9GMvkT89c1GDMfy2xM2YDSBgbBbpaPRpjey96oR4VodH098S5oBTmzAjbkeEnycI1
         HCWiodLLBY13a8CjmjFQOJCxzjkYIzDN1aDfrZn29KuZT1T7wRGqGfxODFerwmfeLAKG
         dcozRE5fd8JEwKJ4Z9mGyFDOxGm2bY2YhoLDq8RUjjPvcIvz/OBapVqi4GLnbfGSvoB+
         LrrQ==
X-Gm-Message-State: AC+VfDxiV4PFaA+SbgYNNTOGxA8im2dX5om5yEtiSanl+PDqT+0nyQ71
        JAtP5RZqG/nAYD89pK4HQQ==
X-Google-Smtp-Source: ACHHUZ6GpPMsZ/GOqhRVihNfwkL2OcgihdJlj1EfdmbTKu4GSeC9tBKvuCWLY1Mftcy9g/mZ41rKfA==
X-Received: by 2002:a5d:8c87:0:b0:783:5e4e:b785 with SMTP id g7-20020a5d8c87000000b007835e4eb785mr9124650ion.19.1687967467854;
        Wed, 28 Jun 2023 08:51:07 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r5-20020a056638100500b0041fb2506011sm3249151jab.172.2023.06.28.08.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:51:07 -0700 (PDT)
Received: (nullmailer pid 537668 invoked by uid 1000);
        Wed, 28 Jun 2023 15:51:05 -0000
Date:   Wed, 28 Jun 2023 09:51:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Alex Elder <elder@ieee.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH V25 1/3] dt-bindings: misc: qcom,dcc: Add the dtschema
Message-ID: <20230628155105.GA536963-robh@kernel.org>
References: <cover.1687945879.git.quic_schowdhu@quicinc.com>
 <1c657427d572cc4143e2787f473c59c293d09a71.1687945879.git.quic_schowdhu@quicinc.com>
 <168795111519.154501.14113356989078168146.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168795111519.154501.14113356989078168146.robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:18:36AM -0600, Rob Herring wrote:
> 
> On Wed, 28 Jun 2023 15:53:30 +0530, Souradeep Chowdhury wrote:
> > Add the device tree bindings for Data Capture and Compare(DCC).
> > 
> > Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../devicetree/bindings/misc/qcom,dcc.yaml    | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/qcom,dcc.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['ti,twl6035-pmic', 'ti,palmas-pmic']
> Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['ti,twl6035-pmic', 'ti,palmas-pmic']
> Documentation/devicetree/bindings/i2c/qcom,i2c-cci.example.dtb: /example-0/cci@ac4a000/i2c-bus@1/camera@60: failed to match any schema with compatible: ['ovti,ov7251']
> Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: /example-0/usb/mdio@1/switch@0: failed to match any schema with compatible: ['marvell,mv88e6190']
> Documentation/devicetree/bindings/net/qca,ar71xx.example.dtb: /example-0/ethernet@1a000000/mdio/switch@10: failed to match any schema with compatible: ['qca,ar9331-switch']
> Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.example.dtb: /example-0/memory-controller@13410000/ethernet@6: failed to match any schema with compatible: ['davicom,dm9000']
> Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.example.dtb: /example-0/iomcu@ffd7e000: failed to match any schema with compatible: ['hisilicon,hi3660-iomcu', 'syscon']
> Documentation/devicetree/bindings/leds/common.example.dtb: /example-2/i2c/led-controller@30: failed to match any schema with compatible: ['panasonic,an30259a']
> Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-dma-crossbar']
> Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /example-0/dma-controller@48000000: failed to match any schema with compatible: ['ti,omap-sdma']
> Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: /example-0/parent/i2c/camera@36: failed to match any schema with compatible: ['ovti,ov5695']
> Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.example.dtb: /example-1/syscon@20e00000: failed to match any schema with compatible: ['sprd,sc9863a-glbregs', 'syscon', 'simple-mfd']
> Documentation/devicetree/bindings/clock/milbeaut-clock.example.dtb: /example-2/serial@1e700010: failed to match any schema with compatible: ['socionext,milbeaut-usio-uart']
> Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.example.dtb: /example-0/cpuctrl@a22000/clock@0: failed to match any schema with compatible: ['hisilicon,hix5hd2-clock']
> Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.example.dtb: /example-0/peripheral-controller@8a20000/phy@850: failed to match any schema with compatible: ['hisilicon,hi3798cv200-combphy']
> Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.example.dtb: /example-0/system-controller@802000/clock@0: failed to match any schema with compatible: ['hisilicon,hi3620-clock']
> Documentation/devicetree/bindings/sound/audio-graph-card2.example.dtb: /example-0/cpu: failed to match any schema with compatible: ['cpu-driver']
> Documentation/devicetree/bindings/sound/audio-graph-card2.example.dtb: /example-0/codec: failed to match any schema with compatible: ['codec-driver']
> Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.example.dtb: /example-0/pmic@0: failed to match any schema with compatible: ['sprd,sc2731']
> Documentation/devicetree/bindings/input/mediatek,pmic-keys.example.dtb: /example-0/pmic: failed to match any schema with compatible: ['mediatek,mt6397']
> Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.example.dtb: /example-0/avs-monitor@7d5d2000: failed to match any schema with compatible: ['brcm,bcm2711-avs-monitor', 'syscon', 'simple-mfd']
> Documentation/devicetree/bindings/thermal/imx-thermal.example.dtb: /example-0/anatop@20c8000: failed to match any schema with compatible: ['fsl,imx6q-anatop', 'syscon', 'simple-mfd']

This can be ignored.

Rob
