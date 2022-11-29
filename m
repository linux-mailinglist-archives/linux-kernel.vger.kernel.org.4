Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C984163C11E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiK2NdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiK2Ncw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:32:52 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565BC20359;
        Tue, 29 Nov 2022 05:32:51 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-142faa7a207so16937782fac.13;
        Tue, 29 Nov 2022 05:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7AbH7r8zfrgUHOwLlSE1ng5DOpa+fGJPYFN/KQ+C+bA=;
        b=HfSKKRVo9BZSUhDGZbShYMqC3mcFCOK0Aqyg4VqKWpiQ19LWQrZDIrkQbRdL9pBOFl
         DTBQCv43P89YmCdnBVdPRvlOoPm76z4cesdFikbwkleZDSUltXqgMECIvroM6zrUYe0t
         xfQohTcfp9/mhF1IQ+W3XG7Q8UAQpKrdXCsUdItPdvE93BRr+QRBJnu650mdc4sXnCDw
         30i4MMzIhFFV5OiRhNAcUxhtwd4fgf8lK50uO8V78EbZZWlyvD2GznSMSN+RFoCBMJvM
         XGWX6EUMG/fiKcooLhV8cWAkOoLHpk6Ki1ef3Aers2LeIi5YeZmomtcY/UP+iu8uTt9a
         n5qA==
X-Gm-Message-State: ANoB5pmu8+3t59xz2ahkdfeq7kVvc3rPweJ/AYmnNXJ71y6NTRJJrRTf
        DwrujosvXvTsihO16TylL3xo8PsMXA==
X-Google-Smtp-Source: AA0mqf50rRVlgY7UKj7g8vZjals77aYIDgUuFDGu6hoTWJb9G0uFW+Ya1ByFd4pbXZIQ2fvIo93PPg==
X-Received: by 2002:a05:6871:408b:b0:13c:4c85:f3f0 with SMTP id kz11-20020a056871408b00b0013c4c85f3f0mr20697586oab.32.1669728770927;
        Tue, 29 Nov 2022 05:32:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r11-20020a9d750b000000b006621427ecc7sm5867883otk.60.2022.11.29.05.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:32:50 -0800 (PST)
Received: (nullmailer pid 3502178 invoked by uid 1000);
        Tue, 29 Nov 2022 13:32:43 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <mhiramat@kernel.org>
In-Reply-To: <20221129103509.9958-8-hayashi.kunihiko@socionext.com>
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-8-hayashi.kunihiko@socionext.com>
Message-Id: <166972831904.3491773.307319467313805748.robh@kernel.org>
Subject: Re: [PATCH 7/8] dt-bindings: soc: socionext: Add UniPhier DWC3 USB glue layer
Date:   Tue, 29 Nov 2022 07:32:43 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Nov 2022 19:35:08 +0900, Kunihiko Hayashi wrote:
> Add DT binding schema for components belonging to the platform-specific
> DWC3 USB glue layer implemented in UniPhier SoCs.
> 
> This USB glue layer works as a sideband logic for the host controller,
> including core reset, vbus control, PHYs, and some signals to the
> controller.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-dwc3-glue.yaml         | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.example.dtb: usb-glue@65b00000: 'reg' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.example.dtb: usb-glue@65b00000: 'ss-phy@300' does not match any of the regexes: '^phy@[0-9a-f]+$', '^regulator@[0-9a-f]+$', '^reset-controller@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.example.dtb: usb-glue@65b00000: 'reg' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.example.dtb: usb-glue@65b00000: 'hs-phy@200' does not match any of the regexes: '^phy@[0-9a-f]+$', '^regulator@[0-9a-f]+$', '^reset-controller@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221129103509.9958-8-hayashi.kunihiko@socionext.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

