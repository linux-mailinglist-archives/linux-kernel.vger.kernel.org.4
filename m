Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21875652217
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiLTOK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiLTOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:10:18 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A84C1B784;
        Tue, 20 Dec 2022 06:10:13 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id v82so10660963oib.4;
        Tue, 20 Dec 2022 06:10:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q75TNysuWYdbrSwdpHQtu6i6oJmeIz4E8jf1765dsqs=;
        b=eIRe6ffSKwBamttrpCrj+lfUU2rghsGzI8ON/UeTHHOFFJ3SGI/nwNyv5GkxTF0bGX
         0ZN3fbx1NUNOo6gZQsux/kibOcmDItZwvrU2IPNJV0+JuhpCfZCpmbRUdUvOYkj95CDp
         8ZfaFJ5qsw/oaZvHHp5cji6gs8T+KOhrmUmeOmM9cRyX++9Cl2JTNL3nhMH52/DPQAi1
         hy7nTwz84FW9viiAhmJXHgNKRBbZiX5ozDbIh4Hp70CdtIYgS3KYCPxUwbGL0hItXPuF
         8/4nANDr/CJHL/6+g/H6BaimtI0q9Vy5oI2bq1Y4zPNMvrgoGsBFskMBFu869nVw8uC6
         qh0w==
X-Gm-Message-State: ANoB5pmAGq2vnqvB009FnZ3nQZZZrMJc7C716PMwOCaqknXgbRoCza3r
        jC3cb7hI88kWqZeyRkBEpvlSLToAJw==
X-Google-Smtp-Source: AA0mqf7YKNW87OKBXduuqmn4LNzeBskcnSsOxdV/gztUOSashZWYlk7FGwyb/DE5yS4klj4E0qhqlA==
X-Received: by 2002:a54:4701:0:b0:35e:bb7f:81b1 with SMTP id k1-20020a544701000000b0035ebb7f81b1mr11312413oik.6.1671545413112;
        Tue, 20 Dec 2022 06:10:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be4-20020a056808218400b0035418324b78sm5556714oib.11.2022.12.20.06.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:10:12 -0800 (PST)
Received: (nullmailer pid 226277 invoked by uid 1000);
        Tue, 20 Dec 2022 14:10:10 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     airlied@gmail.com, sam@ravnborg.org, devicetree@vger.kernel.org,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        paul@crapouillou.net,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220120108.481554-3-cbranchereau@gmail.com>
References: <20221220120108.481554-1-cbranchereau@gmail.com>
 <20221220120108.481554-3-cbranchereau@gmail.com>
Message-Id: <167154529027.200950.10451078081499230843.robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: display/panel: Add AUO A030JTN01
Date:   Tue, 20 Dec 2022 08:10:10 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2022 13:01:08 +0100, Christophe Branchereau wrote:
> From: Paul Cercueil <paul@crapouillou.net>
> 
> Add binding for the AUO A030JTN01 panel, which is a 320x480 3.0" 4:3
> 24-bit TFT LCD panel with non-square pixels and a delta-RGB 8-bit
> interface.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/display/panel/auo,a030jtn01.yaml | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dts:22.11-21: Warning (reg_format): /example-0/panel@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dtb: panel@0: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221220120108.481554-3-cbranchereau@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

