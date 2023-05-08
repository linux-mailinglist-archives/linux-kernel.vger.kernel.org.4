Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184756F9FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjEHG1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjEHG1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:27:00 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF06A30E8;
        Sun,  7 May 2023 23:26:58 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-195ee1be41aso1168524fac.1;
        Sun, 07 May 2023 23:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683527218; x=1686119218;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zA2dOrgpR+LAShw4lI3fM62PxuKc8EjiFypsxPezBTE=;
        b=lf0FFkvBpGxl4IS3wCnkrJa8CMwaC5ViIFPSlh3k0FdRl0m2s7fvPV7gG17TZVn9XL
         rzu1rpHGNYPvZdrIBFVz5xRpwnl14SzVjEYZhrkyckU588P8HoGBl6iPCSkt+Ly0VADN
         D2GgVpMxbEGyGCJrlvjtXsMAjl0fy8wsNQ8+n/HlpZFfQLfyqxj4UcLvinE1aksCbEOt
         37smaY4HPgDZFZGVscv3IgyOEWFKtit+1Yj8TwE/yvjTqQWEniInvupvqL3pO1U5u3Cm
         30TX/S4kQuvlgRCzt7U5Gj9Xrkg3CEcyFeWRICdM8mXE8jBNgwFk6DrphllCvQ0D/hrr
         buZQ==
X-Gm-Message-State: AC+VfDy5yKkWz0UpcjC9tea7z3Zab6WonuFHvGoElO8L815vPU74VgBP
        ToowMo0l3gSKd0rhc14GAQ==
X-Google-Smtp-Source: ACHHUZ79sO6V/lar1ARUIsYqRQiGqHQtNQzJC5YOgirC6ArGbU6WU1wCuu4pynsdBPC15daXAVoiyw==
X-Received: by 2002:a05:6870:2201:b0:192:b536:259 with SMTP id i1-20020a056870220100b00192b5360259mr4424969oaf.19.1683527218009;
        Sun, 07 May 2023 23:26:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a19-20020a056870e35300b0018456166c7asm4635438oae.39.2023.05.07.23.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 23:26:57 -0700 (PDT)
Received: (nullmailer pid 213417 invoked by uid 1000);
        Mon, 08 May 2023 06:26:53 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        festevam@gmail.com, airlied@gmail.com, robh+dt@kernel.org,
        stefan@agner.ch, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, krzysztof.kozlowski@linaro.org,
        LW@karo-electronics.de, alexander.stein@ew.tq-group.com,
        daniel@ffwll.ch, s.hauer@pengutronix.de
In-Reply-To: <20230508055740.635256-2-victor.liu@nxp.com>
References: <20230508055740.635256-1-victor.liu@nxp.com>
 <20230508055740.635256-2-victor.liu@nxp.com>
Message-Id: <168352721348.213381.2072764987425735233.robh@kernel.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: lcdif: Add i.MX93 LCDIF support
Date:   Mon, 08 May 2023 01:26:53 -0500
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


On Mon, 08 May 2023 13:57:35 +0800, Liu Ying wrote:
> There is one LCDIF embedded in i.MX93 SoC to connect with
> MIPI DSI controller through LCDIF cross line pattern(controlled
> by mediamix blk-ctrl) or connect with LVDS display bridge(LDB)
> directly or connect with a parallel display through parallel
> display format(also controlled by mediamix blk-ctrl).  i.MX93
> LCDIF IP is essentially the same to i.MX8MP LCDIF IP.  Add device
> tree binding for i.MX93 LCDIF.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v4->v5:
> * No change.
> 
> v3->v4:
> * Add Alexander's R-b tag.
> 
> v2->v3:
> * No change.
> 
> v1->v2:
> * Add Krzysztof's A-b and Marek's R-b tags.
> 
>  Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508055740.635256-2-victor.liu@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

