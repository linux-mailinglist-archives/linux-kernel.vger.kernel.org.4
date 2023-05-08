Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57E86F9E3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjEHD0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjEHD0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:26:37 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7911160E;
        Sun,  7 May 2023 20:26:36 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-19288cce249so3152593fac.0;
        Sun, 07 May 2023 20:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683516396; x=1686108396;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EemJBrn6GOEq4h6DJze4+bYrzkEtbrLt+WCQrEjb4Pc=;
        b=PH0Tkiwa7k0XtbLyYzsBbqLWHK3YJpza++qTr6mI1ihgJaMd/gcYB8Xxy2hWjFz5kM
         iPoST/z7QSBl3OwMhaEumeHfnbl7uQs/uYwyPIHE7f3XtLJULg9HE/2wXZmQ6WuHTy0i
         dHvONn1jLFNmQjcWroA+tegVZ77ZMXfgMBGYiU/sKaMIXCpcd+0Ss/k8LitnrlIEWQOq
         xljpCakkleGa8TCzFeqs1HOhvp3vQqlJ+umisO5fXPUtVv1d2CCD2UxjzLyKQoDBxSUa
         pI8IxPq8JPpPsDFtZGDb7zv/G4q3+IzPzS7JMqGVWteiwNjPUqNEFQx+XhQ5JT4AAiXt
         KuUg==
X-Gm-Message-State: AC+VfDyjjURAiFtFG7ZtLab57f+E7dajMelfZ9NiR2aI13Qc8fpApeg9
        IjOkTWlKqBtu94DMF7z3HA==
X-Google-Smtp-Source: ACHHUZ4sFYPAnhsVkA9ohV167odbTn46TWVmbiKJKmnMf222CHUJQoLuQVSjmrXdQdTHP1VDvfBxYA==
X-Received: by 2002:a05:6870:1842:b0:180:1531:32c with SMTP id u2-20020a056870184200b001801531032cmr3504065oaf.55.1683516395922;
        Sun, 07 May 2023 20:26:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i18-20020a4addd2000000b00541f66fdac8sm3692661oov.17.2023.05.07.20.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 20:26:35 -0700 (PDT)
Received: (nullmailer pid 4154766 invoked by uid 1000);
        Mon, 08 May 2023 03:26:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     schung@nuvoton.com, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, p.zabel@pengutronix.de,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        gregkh@linuxfoundation.org, sboyd@kernel.org, tmaimon77@gmail.com,
        mturquette@baylibre.com, catalin.marinas@arm.com, will@kernel.org,
        jirislaby@kernel.org, lee@kernel.org,
        linux-arm-kernel@lists.infradead.org, mjchen@nuvoton.com,
        robh+dt@kernel.org, Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <20230508025936.36776-6-ychuang570808@gmail.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-6-ychuang570808@gmail.com>
Message-Id: <168351638675.4154701.13382196910923386751.robh@kernel.org>
Subject: Re: [PATCH v10 05/10] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Date:   Sun, 07 May 2023 22:26:27 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 08 May 2023 02:59:31 +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Modify Nuvoton NPCM and MA35 platform board bindings
>   - Move 'nuvoton,npcm-gcr.yaml' from 'bindings/arm/npcm' to
>     'bindings/soc/nuvoton'.
>   - Rename the 'bindings/arm/npcm' directory to 'bindings/arm/nuvoton'.
>   - Add bindings for ARMv8-based Nuvoton SoCs and platform boards, and
>     include the initial bindings for ma35d1 series development boards.
> 
> Modify MAINTAINERS
>   - Remove the line for 'bindings/arm/npcm/' under ARM/NUVOTON NPCM, as it
>     has been renamed.
>   - Add ARM/NUVOTON MA35 for Nuvoton MA35 series SoCs maintainer and files.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>  .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>  .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
>  MAINTAINERS                                   | 13 +++++++-
>  4 files changed, 44 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
>  rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
>  rename Documentation/devicetree/bindings/{arm/npcm/nuvoton,gcr.yaml => soc/nuvoton/nuvoton,npcm-gcr.yaml} (93%)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508025936.36776-6-ychuang570808@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

