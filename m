Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96136FAFF3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjEHM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjEHM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:27:42 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A81348A4;
        Mon,  8 May 2023 05:27:41 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-38ede2e0e69so2401421b6e.2;
        Mon, 08 May 2023 05:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683548860; x=1686140860;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FAWpRaRKQmsrZ8YpOrHNArx2L7SXFnSdCqBgsashUhc=;
        b=dOAP9GVmSjgglGKBgQMENdwMAysTVa4WDKJeqHOfoJQSruyMa7jeNWriEvSz7tFhUE
         m00Zfp+P7PP/RSZxtyM5k+SNKTVky8D4HiBopoViezDsb91KnvXef9uBVIdtD7QTQY5d
         tY+D6y5WQyFgqq/Rxm51MGeoI6TtUaOuvsfVkQRKzGjhTRpWJtGL11tqrlv1GgjWJA1J
         zLf8COl0y6ICWbwKD+g8mOK3QC25Tc8xoOQcIJHG1X/NAhAdwUL3+No1/EHLGaSAksnh
         P4oWEbqWtdTCmZ1BW8yCAdm9VqIZPraVdSogXM+TC4NBjRV7UxkgUvJVvhxjBDXPI64F
         XeJw==
X-Gm-Message-State: AC+VfDyjJFUAKoOEUwM169xEvi6DFBqZBQUM0IP1pX0+G0z6mSPQ3Skx
        7f15/j91zyfQMnZdFlcbJA==
X-Google-Smtp-Source: ACHHUZ5/dP6c7k6rZ1nEVeFt1izwb3s9oYfxQne+5gXrrQPrSvZpwThwF921/28ELBQbaI7SE7tYDQ==
X-Received: by 2002:a05:6808:6c4:b0:38e:47a5:e4a0 with SMTP id m4-20020a05680806c400b0038e47a5e4a0mr3898153oih.56.1683548860412;
        Mon, 08 May 2023 05:27:40 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m4-20020a056820034400b0054f86ad9e45sm760963ooe.0.2023.05.08.05.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 05:27:39 -0700 (PDT)
Received: (nullmailer pid 927517 invoked by uid 1000);
        Mon, 08 May 2023 12:27:38 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230508110231.GA19395@standask-GA-A55M-S2HP>
References: <20230508110231.GA19395@standask-GA-A55M-S2HP>
Message-Id: <168354885674.927386.15460796878696387417.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: pwm: brcm,kona-pwm: convert to YAML
Date:   Mon, 08 May 2023 07:27:38 -0500
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


On Mon, 08 May 2023 13:02:31 +0200, Stanislav Jakubek wrote:
> Convert Broadcom Kona family PWM controller bindings to DT schema.
> 
> Change during conversion:
>   - add used, but previously undocumented brcm,bcm11351-pwm compatible
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in V2:
>   - mention the new compatible in the commit message (Krzysztof)
> 
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508110231.GA19395@standask-GA-A55M-S2HP

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

