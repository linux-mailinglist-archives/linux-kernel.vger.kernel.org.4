Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C926F9E35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjEHD0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjEHD0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:26:33 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D9CA5E9;
        Sun,  7 May 2023 20:26:32 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-54cbb666aa5so2163309eaf.1;
        Sun, 07 May 2023 20:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683516391; x=1686108391;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GUP740VSIFLDV8rZCQ5oBsU29cPyJ7u+vd58HVBat4Y=;
        b=WNg9LdmW9hKC+3u6qdtyh03vW/t+SFJlh0j+umH8H3Avh7EUoTS/plV7eL2OM81sSc
         0Uzp9qtkax88v1YerIAH69Zz0Ekdh09zY7/vr9P2/f70iWMX2+samMypIVGXmYI+eWSU
         xe394LkK6rK5LqC2gUC6xx0036/1ru9TttzsGbcg7TSAhgS/WoUROAE4KoVvwbrGA2+9
         QsoDyB8yBCQkeQcNj0B8oEDOHU4Htkw4N985DL55wOWDARWvX8m+AvW6033gz/1WCSt2
         Tax5sg0HfW0rCsDxCCZRRzMmLBx+NCLAA63bAiVYALm6GnXAo9nT/8XNcJEcbojHZAGU
         Tvrg==
X-Gm-Message-State: AC+VfDyDp4JQqDDOvSoDHCQbb1Tfr+MKDDOJcH50KN1Vr1kRo8zMncjq
        0p3WvaW9VVOplNVIFJvVdf9ZSsiUDnqB
X-Google-Smtp-Source: ACHHUZ59A+v/ZumD/ssBM+TZ58XgiyDzEywM9UukDF60uWTxIK5s4tu0gz+Y+rdJF7rmlB0m0eKp1A==
X-Received: by 2002:a05:6808:251:b0:38e:8e30:677d with SMTP id m17-20020a056808025100b0038e8e30677dmr4240684oie.3.1683516391495;
        Sun, 07 May 2023 20:26:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fe9-20020a0568082b0900b0038bb2f60064sm5199849oib.30.2023.05.07.20.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 20:26:30 -0700 (PDT)
Received: (nullmailer pid 4154764 invoked by uid 1000);
        Mon, 08 May 2023 03:26:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     tmaimon77@gmail.com, mjchen@nuvoton.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, will@kernel.org, schung@nuvoton.com,
        robh+dt@kernel.org, jirislaby@kernel.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Jacky Huang <ychuang3@nuvoton.com>, lee@kernel.org
In-Reply-To: <20230508025936.36776-5-ychuang570808@gmail.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-5-ychuang570808@gmail.com>
Message-Id: <168351638608.4154679.2636482702680796849.robh@kernel.org>
Subject: Re: [PATCH v10 04/10] dt-bindings: reset: nuvoton: Document ma35d1
 reset control
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


On Mon, 08 May 2023 02:59:30 +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
> between the reset controller and reset references in the dts.
> Add documentation to describe nuvoton ma35d1 reset driver.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/reset/nuvoton,ma35d1-reset.yaml  |  45 ++++++++
>  .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 ++++++++++++++++++
>  2 files changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>  create mode 100644 include/dt-bindings/reset/nuvoton,ma35d1-reset.h
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508025936.36776-5-ychuang570808@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

