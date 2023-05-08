Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A58A6F9E30
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjEHD0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHD0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:26:31 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C09ECD;
        Sun,  7 May 2023 20:26:30 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-38dfdc1daa9so2279827b6e.1;
        Sun, 07 May 2023 20:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683516389; x=1686108389;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qZLHJ8wW6At9vFqnZUP+MvedymItkBNKJfu1zZbGYGE=;
        b=QKdD6nt7vQrfddMEUAoHgZ922hZvlUfiUvDe4PoLRm5t5ADg0PFhwczAoIGVN76uAh
         LhidpPKFzLn6E1/FPuYDPpMO/Nhmg8cPFlha/96Mp3VTCVqgnC+dh8bEle2OJ5GLfaww
         80qRyh6Yabgh1lywZBkC7DMYD8MSgVE6BRsaP7moARW1x0NMlhUGLbhjiZQRmrwtUhf5
         bGrhMpHu2EizLeanlLuqFURBHazMQNMkg1WjlWxyGD1FL/SBc+eLk3AMGiFBaOR3qDxv
         u5k9b5bBFvwY0ULCgaJWyA7/vDErS63IurJyPmoiyNcI75+kQV6P5LWz2Q8D5kwbN6rW
         9l7g==
X-Gm-Message-State: AC+VfDwf7lyqPH+PkFLR+4LxhW5diHvG7+ftLkN2ZusiD0edakfR+8b9
        7HYQTg/W/FyHSh9PzH+ehLIhiLcYIbdU
X-Google-Smtp-Source: ACHHUZ6TB83+t1QGbQO7ToWj5cMexn7tJT+864DxLG8gEdzQs9IJGzMyl2DTDuXY/W4j1DN76J+Lhg==
X-Received: by 2002:aca:1014:0:b0:386:ca93:7ada with SMTP id 20-20020aca1014000000b00386ca937adamr4016049oiq.57.1683516389472;
        Sun, 07 May 2023 20:26:29 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w14-20020a4ac18e000000b00541854ce607sm3685092oop.28.2023.05.07.20.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 20:26:28 -0700 (PDT)
Received: (nullmailer pid 4154761 invoked by uid 1000);
        Mon, 08 May 2023 03:26:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     lee@kernel.org, mjchen@nuvoton.com, will@kernel.org,
        mturquette@baylibre.com, Jacky Huang <ychuang3@nuvoton.com>,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jirislaby@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        schung@nuvoton.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-serial@vger.kernel.org, tmaimon77@gmail.com
In-Reply-To: <20230508025936.36776-4-ychuang570808@gmail.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-4-ychuang570808@gmail.com>
Message-Id: <168351638542.4154651.973240291606333991.robh@kernel.org>
Subject: Re: [PATCH v10 03/10] dt-bindings: clock: nuvoton: add binding for
 ma35d1 clock controller
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


On Mon, 08 May 2023 02:59:29 +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
> between the clock controller and clock references in the dts.
> Add documentation to describe nuvoton ma35d1 clock driver.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/clock/nuvoton,ma35d1-clk.yaml    |  63 +++++
>  .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 253 ++++++++++++++++++
>  2 files changed, 316 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>  create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
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

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508025936.36776-4-ychuang570808@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

