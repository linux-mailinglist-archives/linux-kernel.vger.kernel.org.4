Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E802645C52
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiLGOUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiLGOUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:20:01 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A1A56D6F;
        Wed,  7 Dec 2022 06:19:58 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id r11so15137268oie.13;
        Wed, 07 Dec 2022 06:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YPXQ5aeP/xmgm2md3W0N1j14oZE9IYfxmA6XKi7xf9E=;
        b=dH0bZA0EpkjyDY1b7m0WVsL+GvaTNmN9gQFN7Gw8AHZ0zyKy6+Zim1WFEem2xbhBBF
         7trZQmcm1qLheUhqAgKr9GQzrR1JavKNwhi3kVq2YEcOcxUHToymTkoLAXbK9P9aJFu9
         HFGEEsNJZMEfoiAD7pkhB5Qk1TxbKfHcTBRG9TpCzE815uoIXHg7s9ntmhRjddCiQhjT
         ExgVRzkw1l56R4sTyc66F5M+2IC4YBmVptPSBTMk0/Dcs1WOrjBFv77auSpiMkZ40AWY
         SOXsGye3iuAkqZe8MfVidFejK7piWAnVfU6/XzmLh2WcnnC/7f8uTLnl+aFaWy7p8rQ3
         PvCA==
X-Gm-Message-State: ANoB5pl3r28L+v/8HfUah3SB8LnBiHeYrozzPK9Qc3j9yYEKlxpWXhYx
        cpe8drzSlzjeKQDwfjpbzQ7nXNTD1A==
X-Google-Smtp-Source: AA0mqf6hj6axM7QKNbYaGaiZ9NTuFdqxrD39C8T2gNl9I1o+Oaz8MEX3/kbEWOOr/wkNCCLtF9qUkw==
X-Received: by 2002:a05:6808:180a:b0:35a:58c7:7f5f with SMTP id bh10-20020a056808180a00b0035a58c77f5fmr33962772oib.252.1670422798388;
        Wed, 07 Dec 2022 06:19:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x16-20020a056870b41000b0014474019e50sm6946926oap.24.2022.12.07.06.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:19:57 -0800 (PST)
Received: (nullmailer pid 2124803 invoked by uid 1000);
        Wed, 07 Dec 2022 14:19:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20221207055405.30940-16-hayashi.kunihiko@socionext.com>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-16-hayashi.kunihiko@socionext.com>
Message-Id: <167042222133.2111770.10863782441264197850.robh@kernel.org>
Subject: Re: [PATCH v2 15/16] dt-bindings: soc: socionext: Add UniPhier DWC3
 USB glue layer
Date:   Wed, 07 Dec 2022 08:19:49 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2022 14:54:04 +0900, Kunihiko Hayashi wrote:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.example.dtb: usb-glue@65b00000: 'reg' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.example.dtb: usb-glue@65b00000: 'hs-phy@200' does not match any of the regexes: '^phy@[0-9a-f]+$', '^regulator@[0-9a-f]+$', '^reset-controller@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.example.dtb: usb-glue@65b00000: 'reg' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.example.dtb: usb-glue@65b00000: 'ss-phy@300' does not match any of the regexes: '^phy@[0-9a-f]+$', '^regulator@[0-9a-f]+$', '^reset-controller@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221207055405.30940-16-hayashi.kunihiko@socionext.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

