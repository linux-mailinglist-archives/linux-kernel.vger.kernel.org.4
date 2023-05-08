Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE03F6FA33C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjEHJ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjEHJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:27:17 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664A710C1;
        Mon,  8 May 2023 02:27:15 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-38e0a003abdso2327923b6e.3;
        Mon, 08 May 2023 02:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683538034; x=1686130034;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XS1/SkKzzzTOx8YnL5cLsek2MFAHz25u6xsUsoIUsnw=;
        b=AcQW2comtp5k+SH48ebUdK/YaDOYW7SpvD48xIw6ZS4j4kI5L4vBr5KsGxVR8UosMp
         YicC/L1UQ1okXstvJFFxGJrH2FfqdWsCDMWpmNfHaKz0YukdzC5GbOhEgWvLEYjAFMSj
         w+LSyL/30k3Fthc8pVnlhh59s2VQ64LMfrMnHDC2z7827BG6EYTL1pl2M3u7AoWypKh8
         0h0EEAeeewU6E9rVvn0s9RQC9B21tGkFZdCmDmNiteGskE1zwZotljAhMBv4Ss+J+DpH
         JbZHGGP0fYLSxX65PfgCJlYjvl81+iV2pD9LvDKUiKjVDAPy1W6+HaBwcB4AcB4dDHwX
         7dvg==
X-Gm-Message-State: AC+VfDwZpOzl9K2ZM7ORxGK8Oh+wSlt20Ui8L6lEjgve6TwTDuVMzl4P
        ez/g1m4BVBqjmeKNOgS5FA==
X-Google-Smtp-Source: ACHHUZ6hSDIXIY7DFFpTl/7nj1A8bNgXCBKPq6Xk+v+P9vhS+pqDLJ9Doa7YGTR5Eo4Ux6q0CkBqMQ==
X-Received: by 2002:aca:1801:0:b0:38e:a824:27d3 with SMTP id h1-20020aca1801000000b0038ea82427d3mr4216707oih.27.1683538034543;
        Mon, 08 May 2023 02:27:14 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j9-20020aca6549000000b0039232a8a1a3sm5349037oiw.13.2023.05.08.02.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:27:13 -0700 (PDT)
Received: (nullmailer pid 575483 invoked by uid 1000);
        Mon, 08 May 2023 09:27:12 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
In-Reply-To: <20230508081053.GA4675@standask-GA-A55M-S2HP>
References: <20230508081053.GA4675@standask-GA-A55M-S2HP>
Message-Id: <168353803157.575392.5110569040806330542.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: firmware: brcm,kona-smc: convert to
 YAML
Date:   Mon, 08 May 2023 04:27:12 -0500
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


On Mon, 08 May 2023 10:10:53 +0200, Stanislav Jakubek wrote:
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
> 
> Changes in V2:
>   - move to firmware subdirectory (Krzysztof)
>   - drop deprecated compatibles (Krzysztof)
>   - adjusted commit message to reflect the above changes
> 
>  .../bindings/firmware/brcm,kona-smc.yaml      | 40 +++++++++++++++++++
>  .../bindings/misc/brcm,kona-smc.txt           | 15 -------
>  2 files changed, 40 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508081053.GA4675@standask-GA-A55M-S2HP

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

