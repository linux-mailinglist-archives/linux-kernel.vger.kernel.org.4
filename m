Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8780164B68B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbiLMNqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiLMNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:46:35 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D32D96;
        Tue, 13 Dec 2022 05:46:34 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id s186so14223902oia.5;
        Tue, 13 Dec 2022 05:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JAKfpQI94u4O3fzNRcS1x/zjTFY7SnBfxQhQI8l4qJw=;
        b=qclFm7U8rGYwDWRrMzEdsgkIxVXjFRUq7beHdUkMRjxDWQuF/Y66hO0IkHrta0/y3f
         PZ3NjlaaWKEpKqg+I3XDjTXcRQ5M2j+DjY5QiHoX7d0ecZ/xFMGUANrWxaIZWV7E/Kjr
         /L3JSGpQ6tQalt3hpW6oGSJYDN7KgOaLZWom3m47YOafULWaRDYYKr6qKdniMrTu5YGD
         admdmtGucfVY4sx9p2/xT1HJ0Czee2qmlZFf0jSRTv4axxcwq2mqJ7ksdZrW2ebtKejg
         8otHlqI0eV2NTC9+E38xwsuQgxAia1oo5ntlmEpD55ZhhRJuybyMzYaopPVlxwhPtsV0
         pFdA==
X-Gm-Message-State: ANoB5plfV5NdRY/hkPUVQKF8qeL5FTGIuMff1weXTfHEi2i8zluiMz6z
        vcpNiFnE+w3Odf1qsF/AiAp8hv19FA==
X-Google-Smtp-Source: AA0mqf7Z6iH0NWdTwB6HrfGWODAGx5AXNddNroS4mQTq1LVQY7eYQiEdrMCfZSGxdHcUDNJGM+v96Q==
X-Received: by 2002:aca:5e06:0:b0:35b:ab3c:cb7f with SMTP id s6-20020aca5e06000000b0035bab3ccb7fmr10108028oib.54.1670939193255;
        Tue, 13 Dec 2022 05:46:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n2-20020a0568301e8200b006708d2cd8bcsm1167616otr.65.2022.12.13.05.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 05:46:32 -0800 (PST)
Received: (nullmailer pid 914671 invoked by uid 1000);
        Tue, 13 Dec 2022 13:46:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        daniel@ffwll.ch, paul@crapouillou.net, airlied@gmail.com,
        sam@ravnborg.org
In-Reply-To: <20221213081034.14226-2-cbranchereau@gmail.com>
References: <20221213081034.14226-1-cbranchereau@gmail.com>
 <20221213081034.14226-2-cbranchereau@gmail.com>
Message-Id: <167093911506.912834.5336090745245447936.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: display/panel: Add AUO A030JTN01
Date:   Tue, 13 Dec 2022 07:46:32 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Dec 2022 09:10:34 +0100, Christophe Branchereau wrote:
> Add binding for the AUO A030JTN01 panel, which is a 320x480 3.0" 4:3
> 24-bit TFT LCD panel with non-square pixels and a delta-RGB 8-bit
> interface.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/display/panel/auo,a030jtn01.yaml | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221213081034.14226-2-cbranchereau@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

