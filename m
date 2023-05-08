Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC606FA33F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjEHJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjEHJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:27:19 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331388F;
        Mon,  8 May 2023 02:27:17 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1928253dd95so1776719fac.3;
        Mon, 08 May 2023 02:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683538036; x=1686130036;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T+phZhc9+/yemeqtaxpRhq+37BIQlVelYnOaxp7TxHA=;
        b=DDrapKT1klKw1NpVUu0qeuRkWCcxss9d34pfg9lJ100V5TptTVBpikP+xhLKCEQr1v
         jdlKBnXUSnjUMm9BAI+Xhn8VpOeSC+gvajob/yh1tRu3G9vPq/c2t0i7iy0bkCN1ebxQ
         LCv7jOVY2+PB4b1Lhe3tyOD2VDnqoaoq7ZLESluRsZrhFJUDFym233eOHhEoh68uoJU8
         85plXIn/h/C+F/WiI/Qy2stHsPddSJkr43yXv4iUSJfuptKNdQFk7xjBf2+zV1gKJtUU
         Yts9wJMFqA2URQs5N2fgoJSZjhVUSHBN7B1y+tVMHoDsqANnHwDiyMFSLGI1mpHscLcZ
         5WbA==
X-Gm-Message-State: AC+VfDwFAZdF9YDvPw8e67NUFuuomLRfO/IsQK5aSs5XylN1JI7jlmnw
        ur/sL30+ipfV81mf7vEd1A==
X-Google-Smtp-Source: ACHHUZ4zEz3lotUMpKgI4ZPVHP7xU9QrTR7Bpg4c27qYYicbSaDkcubir3d0oL+l+tWFQxu7lzT4GQ==
X-Received: by 2002:a05:6870:e506:b0:177:c2bd:3f6d with SMTP id y6-20020a056870e50600b00177c2bd3f6dmr4022359oag.45.1683538036369;
        Mon, 08 May 2023 02:27:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a056870a48500b0018b12e3a392sm4724440oal.42.2023.05.08.02.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:27:15 -0700 (PDT)
Received: (nullmailer pid 575488 invoked by uid 1000);
        Mon, 08 May 2023 09:27:12 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230508085727.GA7252@standask-GA-A55M-S2HP>
References: <20230508085727.GA7252@standask-GA-A55M-S2HP>
Message-Id: <168353803294.575457.2741110608666580664.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: brcm,kona-pwm: convert to YAML
Date:   Mon, 08 May 2023 04:27:12 -0500
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


On Mon, 08 May 2023 10:57:27 +0200, Stanislav Jakubek wrote:
> Convert Broadcom Kona family PWM controller bindings to DT schema.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../devicetree/bindings/pwm/brcm,kona-pwm.txt | 21 --------
>  .../bindings/pwm/brcm,kona-pwm.yaml           | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508085727.GA7252@standask-GA-A55M-S2HP

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

