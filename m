Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561516FACD3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjEHL2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjEHL1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:27:51 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2D3D55C;
        Mon,  8 May 2023 04:27:37 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-38dfa504391so2369979b6e.3;
        Mon, 08 May 2023 04:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545256; x=1686137256;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hgY1TG/HeMuxKUbL+5g1oS6I4Kij1PvcnYZww9LHLxw=;
        b=Ocx34fuZ1afSLUvPCl5vHgu5/AA+JCYUdOsG+eqrqkYZCfprYN+C2gpdt+pox+ZbbN
         a88kEywP3+geoidRLLDsHHQPBAnxltwGfjOtGMGi0bkIGYeHp8TPR7xz4MI8rkjN2fel
         +eBaZlrrHZZSSUFN35YIC4BBGzp8oTGk72dhTg24K8nYudbhk2xHrrWdlOqMKS1/JIac
         dzcdGAu1wn/Pfal24GpfmZ4mA682X/EUtFeny9tpw9jX0sjMMvPGRfExdZ982QmJGX9T
         i3JFd45ZkgI8SIiCnPKvobsxdTEBNFdfj/u0B7NB5pWh8KmdF/OXI2JJzXXKd4gcU+gu
         Wz7Q==
X-Gm-Message-State: AC+VfDz3DPNb86644s2z933IakSR/SK8B4W8iXCvR+DaU8KM9aHhb5pU
        xMDx5SrBusdI5fnUBXLF41w16ORGtXjb
X-Google-Smtp-Source: ACHHUZ6CnaupNBoI+FoKCFTYjq8Y0Zi59PAtLLATG0Oc1ZTR6Wn71A3JmNl66+ywJlOAJS/NHTClRQ==
X-Received: by 2002:a05:6808:6243:b0:38e:7bb:5a0d with SMTP id dt3-20020a056808624300b0038e07bb5a0dmr4703743oib.27.1683545255953;
        Mon, 08 May 2023 04:27:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id es10-20020a056808278a00b0038edc69490bsm5433912oib.10.2023.05.08.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:27:35 -0700 (PDT)
Received: (nullmailer pid 789288 invoked by uid 1000);
        Mon, 08 May 2023 11:27:28 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-clk@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org
In-Reply-To: <20230508104801.445261-3-claudiu.beznea@microchip.com>
References: <20230508104801.445261-1-claudiu.beznea@microchip.com>
 <20230508104801.445261-3-claudiu.beznea@microchip.com>
Message-Id: <168354524853.789265.9741363586759296275.robh@kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc:
 convert to yaml
Date:   Mon, 08 May 2023 06:27:28 -0500
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


On Mon, 08 May 2023 13:47:58 +0300, Claudiu Beznea wrote:
> Convert Atmel PMC documentation to yaml.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/clock/at91-clock.txt  |  28 ----
>  .../bindings/clock/atmel,at91rm9200-pmc.yaml  | 154 ++++++++++++++++++
>  2 files changed, 154 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508104801.445261-3-claudiu.beznea@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

