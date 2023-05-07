Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7476F9BE6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjEGVZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjEGVZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:25:50 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EBF18C;
        Sun,  7 May 2023 14:25:49 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-38de3338abeso2008516b6e.1;
        Sun, 07 May 2023 14:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683494748; x=1686086748;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WQt/KFtGyk7LRyeTp3Pb3XBGe8U1XDkxGErGnAAzsHQ=;
        b=PSuW/YK2FvqoDO4w3VMGGlte9VbKxEgZiyDFLSItJrvPY8hVuTErzT23bZChK0mOQN
         AJ8Ig6wYYHWJaSfy7+sWX73o/aEtCNHzIyr5DteET+QIQ7XiPP+P8ZtIxnUobm42hQjs
         szh9ivH4YEbnm96lXBB7NHKgIS9lKdhi9GfLs9MUsPNa7vZPrYUtSXcjdb48F0xzkQnh
         RqghsImUOnuCtcSztSGxzrD0uyaCTg0OKDT8ZLlVZJNrFqNMHasa5hzKYKZngTrAPwry
         9D4TPfcH3sL9prio16BtQOfF3ZmEZNZHmV0nPF6+YctkH7wNi363JhQk1ZLE7HQzbwMX
         ABbQ==
X-Gm-Message-State: AC+VfDyVP/CcatkhH3OllDEfuNyLdujNOdITuq3VFewdeyOpbQzoSNOF
        CR1o0te8YAp0fw/CY/LEg+fXZaQm3OuC
X-Google-Smtp-Source: ACHHUZ7rC+lOSVcLehPC2tatKjklBzuJJsYTl8RtWlZsastEufTrvMbAPRtz9iUj4uTUII89jNErHg==
X-Received: by 2002:a05:6808:356:b0:38e:e0c3:5cce with SMTP id j22-20020a056808035600b0038ee0c35ccemr3776456oie.18.1683494748239;
        Sun, 07 May 2023 14:25:48 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id by6-20020a056808340600b0038ea7f7328bsm4976415oib.46.2023.05.07.14.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 14:25:46 -0700 (PDT)
Received: (nullmailer pid 3488552 invoked by uid 1000);
        Sun, 07 May 2023 21:25:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
In-Reply-To: <20230507201225.89694-3-matti.lehtimaki@gmail.com>
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
 <20230507201225.89694-3-matti.lehtimaki@gmail.com>
Message-Id: <168349474403.3488517.5211527034357682544.robh@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: thermal: tsens: Add compatible for
 MSM8226
Date:   Sun, 07 May 2023 16:25:44 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 07 May 2023 23:12:20 +0300, Matti Lehtimäki wrote:
> Qualcomm MSM8226 has tsens v0.1 block.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230507201225.89694-3-matti.lehtimaki@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

