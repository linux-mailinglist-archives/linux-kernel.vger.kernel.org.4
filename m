Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EFC6F9C83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 00:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjEGW0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjEGW0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 18:26:02 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5601C100DF;
        Sun,  7 May 2023 15:26:01 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1929818d7faso28413668fac.0;
        Sun, 07 May 2023 15:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683498360; x=1686090360;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hZTsJHTnq+3a+hCnLjGr0R5FRnfLRT1vEoTP8UaO6Sg=;
        b=NqZyV9ZtSo7pHSdBju8GLWVh3zmT3Jtia+u6mJxfnHFFecnlwoyVVKIZE3ILWnTtC3
         0r82VwTXg8TLmCJY4YpEfuXVMW9GFGBBhxAZ3OkdcBJDPKu1dTcfYbgF33Cm2DDfPEIq
         5qQc7Sw1l1pBlWQjZUA3K1otACCpKb9Xi+PK0/VHfyqEDvFZuXeZY2VmO/Af+zU8/pNv
         YcHYJw/h9AK/1bMuCmnInB10e7qlP+0v44xgJPqW+lMiuiJPpQxk9EcWFA0V9NE4zyY+
         7AIytd0GZWrFBpw85zxDD+Smk3QSOvMQK7pgcTUcHmeEvu2O1kp+CHxxBrGRDnRJ2euZ
         x0Iw==
X-Gm-Message-State: AC+VfDwExPTKfJqVduyqjPgYyXX8U+LtTjPRkX3vbA3AGaOd+iqFRP5G
        gK6VtSAlQesyg8fCGana6w==
X-Google-Smtp-Source: ACHHUZ5B38IBdFaOItperX8ILwbZiwkiV5aNivf+0j4HhXgM+8G8oIEkdX/ELJgRFCj83rPlNSeAuw==
X-Received: by 2002:a05:6870:772d:b0:18b:1374:7ca8 with SMTP id dw45-20020a056870772d00b0018b13747ca8mr3919091oab.17.1683498360468;
        Sun, 07 May 2023 15:26:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ee10-20020a056870c80a00b001726cfeea97sm4326602oab.29.2023.05.07.15.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 15:25:59 -0700 (PDT)
Received: (nullmailer pid 3623291 invoked by uid 1000);
        Sun, 07 May 2023 22:25:56 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Stefan Agner <stefan@agner.ch>,
        linux-arm-kernel@lists.infradead.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-input@vger.kernel.org, Marek Vasut <marex@denx.de>
In-Reply-To: <20230426-stmpe-dt-bindings-v3-2-eac1d736e488@linaro.org>
References: <20230426-stmpe-dt-bindings-v3-0-eac1d736e488@linaro.org>
 <20230426-stmpe-dt-bindings-v3-2-eac1d736e488@linaro.org>
Message-Id: <168349835671.3623272.12285551237666172256.robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: MFD: Convert STMPE to YAML schema
Date:   Sun, 07 May 2023 17:25:56 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 07 May 2023 23:19:20 +0200, Linus Walleij wrote:
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
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Drop the required pwm properties already required by the
>   template pwm schema.
> - Add the number of PWM cells as const.
> ChangeLog v1->v2:
> - Split off the GPIO bindings to their own schema, as the old
>   bindings didn't even have any GPIO bindings. Put the GPIO
>   schema before this schema so we can use GPIO in the examples.
> - Drop nodename and pattern as STMPE is not a generic name.
> - Add maxItems to the resets.
> - Make wakeup-source just :true, as it is a generic property.
> - Move unevaluatedProperties for subnodes right before properties
>   as requested.
> - Name devices "port-expander" in the examples.
> - Use lowercase hex in line init.
> ---
>  .../devicetree/bindings/input/stmpe-keypad.txt     |  41 ---
>  .../bindings/input/touchscreen/stmpe.txt           | 108 --------
>  .../devicetree/bindings/mfd/st,stmpe.yaml          | 297 +++++++++++++++++++++
>  Documentation/devicetree/bindings/mfd/stmpe.txt    |  42 ---
>  4 files changed, 297 insertions(+), 191 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/st,stmpe.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/gpio/st,stmpe-gpio.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/st,stmpe.example.dtb: port-expander@43: gpio: False schema does not allow {'compatible': ['st,stmpe-gpio'], 'gpio-controller': True, '#gpio-cells': [[2]], 'interrupt-controller': True, '#interrupt-cells': [[2]], 'st,norequest-mask': [[15790082]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
Documentation/devicetree/bindings/mfd/st,stmpe.example.dtb: /example-0/i2c/port-expander@43/gpio: failed to match any schema with compatible: ['st,stmpe-gpio']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/st,stmpe.example.dtb: port-expander@41: gpio: False schema does not allow {'compatible': ['st,stmpe-gpio'], 'gpio-controller': True, '#gpio-cells': [[2]], 'interrupt-controller': True, '#interrupt-cells': [[2]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
Documentation/devicetree/bindings/mfd/st,stmpe.example.dtb: /example-0/i2c/port-expander@41/gpio: failed to match any schema with compatible: ['st,stmpe-gpio']

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230426-stmpe-dt-bindings-v3-2-eac1d736e488@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

