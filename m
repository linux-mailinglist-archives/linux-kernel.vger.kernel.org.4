Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08BE6F9E3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjEHD0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjEHD0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:26:35 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2A79ECD;
        Sun,  7 May 2023 20:26:34 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-38de3338abeso2097306b6e.1;
        Sun, 07 May 2023 20:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683516394; x=1686108394;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qOB4cMVMck53fRMNOsixuHMoaFEzDyEqYLNlrgAaE6E=;
        b=ecGvUzGanM1X3TXxTfk7HdgtfyEXig6iNdhwDn/89C/OCRsqPQ5Y+dEafzUWL1LGFn
         3dRE3dPYiT8bDXFocgCPpLgyMyEUtY1XdY/9CxxDqrrrWJ0aTB5UtRAbJEIPmfOpuauB
         FkjDNIi9lClkgOGPwfNaG7LP/7OQ5x5i3wtiZwwqZNxH2tC/gzgjM73whj9SWw1/JflT
         2zYjLIRfxyK68XLF5Mx2A2ripcaWV5jXC4fFqharfprIC1fh6rWpTSW57Vd0ed9vLWA5
         Ul4RAPosaUBkLUjtRdd3Ujif96K9qFP+jUclT5fjcZu1wdELx++TR7s+uiyWuAdIBCok
         EThg==
X-Gm-Message-State: AC+VfDw39GPOdAzP4h8TdLrK7GHLUMuPbi54wmzP61LDxFhnv4CxNhBK
        1qDuBv1xOBjDk/tptVDoJQ==
X-Google-Smtp-Source: ACHHUZ5sEqhXlV8uwwweYHNv2XwKFWmslbtTAH8WEWZjeUkCj9PxKq14Z05hVAe+wocpSM4YCZ2saw==
X-Received: by 2002:aca:2b06:0:b0:38c:11b3:a397 with SMTP id i6-20020aca2b06000000b0038c11b3a397mr3874384oik.14.1683516393616;
        Sun, 07 May 2023 20:26:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y15-20020a4ae70f000000b0054c7a08d4casm1002976oou.38.2023.05.07.20.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 20:26:32 -0700 (PDT)
Received: (nullmailer pid 4154768 invoked by uid 1000);
        Mon, 08 May 2023 03:26:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     p.zabel@pengutronix.de, arnd@arndb.de, jirislaby@kernel.org,
        schung@nuvoton.com, tmaimon77@gmail.com,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org,
        linux-serial@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        will@kernel.org, Jacky Huang <ychuang3@nuvoton.com>,
        lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, mjchen@nuvoton.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230508025936.36776-7-ychuang570808@gmail.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-7-ychuang570808@gmail.com>
Message-Id: <168351638748.4154745.16515916544783600377.robh@kernel.org>
Subject: Re: [PATCH v10 06/10] dt-bindings: serial: Document ma35d1 uart
 controller
Date:   Sun, 07 May 2023 22:26:27 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 08 May 2023 02:59:32 +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add documentation that describes the nuvoton ma35d1 UART driver bindings.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../serial/nuvoton,ma35d1-serial.yaml         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.example.dts:25:18: fatal error: dt-bindings/clock/nuvoton,ma35d1-clk.h: No such file or directory
   25 |         #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508025936.36776-7-ychuang570808@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

