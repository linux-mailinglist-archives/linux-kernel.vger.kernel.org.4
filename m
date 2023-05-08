Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB5E6FACCD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbjEHL2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbjEHL1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:27:46 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9EB3C1ED;
        Mon,  8 May 2023 04:27:33 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-38dfdc1daa9so2456008b6e.1;
        Mon, 08 May 2023 04:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545252; x=1686137252;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bKwEmXkLjouRbvIPiHn1eDAbzcuCzcpIkYFR5yMyldU=;
        b=S1gp6vk1svJCkNRjAOwPNIPhC5oGJs0J1pcVbgUo9l61lhkdkvdHYwKJjGVXDywHs2
         5YlU4LLBA1OZ4gGPfgGCQdXm7tEnBdb78ucxzlJSTcRcHgjJuh9SwDGla83G1tOS3s2n
         xtRSRE5HcjeMfeLkfhkltGSqz6sgHV8beP6kvQfy+/PR4OyiEmdUwvYj7PHnJ+j9W83g
         wRNnVDlgsh9PZsn5yXY+3pJyCd4F9rq2Ssqm0au9cfRku8AW668UgcyjN6qdOcirxQen
         Dg7Yjjy4M0L8tLuU2+PyP3W2/jYEwlou4cJGjStXaG6PkmA+8d19NlgRTg0CRyRmlef1
         OZHA==
X-Gm-Message-State: AC+VfDxGKSr75fCHNRV7qQfWV4eyS5k7V7XK0nnhd3beB4w7BWGBeH04
        oh1Di5Ji/7V9PVxSxcZ0GA==
X-Google-Smtp-Source: ACHHUZ4b6HS6Nj3l3V+FkuKZw06PtKKqfLgSHl9DVMrriWGJBclIpRE3DXVBZrM2HLrg7mcM2ZUlgA==
X-Received: by 2002:a05:6808:2819:b0:38e:9203:44eb with SMTP id et25-20020a056808281900b0038e920344ebmr4922218oib.28.1683545251961;
        Mon, 08 May 2023 04:27:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i18-20020a4addd2000000b00541f66fdac8sm3955409oov.17.2023.05.08.04.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:27:31 -0700 (PDT)
Received: (nullmailer pid 789284 invoked by uid 1000);
        Mon, 08 May 2023 11:27:28 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230508103255.GA18424@standask-GA-A55M-S2HP>
References: <20230508103255.GA18424@standask-GA-A55M-S2HP>
Message-Id: <168354524719.789190.15173683031952415240.robh@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: firmware: brcm,kona-smc: convert to
 YAML
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


On Mon, 08 May 2023 12:32:55 +0200, Stanislav Jakubek wrote:
> Convert Broadcom Kona family Secure Monitor bounce buffer bindings
> to DT schema.
> 
> Changes during conversion:
>   - move from misc to firmware subdirectory
>   - add used, but previously undocumented SoC-specific compatibles
>   - drop deprecated compatibles (they've been deprecated for ~10 years)
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in V3:
>   - remove unnecessary oneOf (Krzysztof)
> 
> Changes in V2:
>   - move to firmware subdirectory (Krzysztof)
>   - drop deprecated compatibles (Krzysztof)
>   - adjusted commit message to reflect the above changes
> 
>  .../bindings/firmware/brcm,kona-smc.yaml      | 39 +++++++++++++++++++
>  .../bindings/misc/brcm,kona-smc.txt           | 15 -------
>  2 files changed, 39 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508103255.GA18424@standask-GA-A55M-S2HP

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

