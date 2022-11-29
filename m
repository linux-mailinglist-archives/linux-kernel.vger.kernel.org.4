Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FFF63C11D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiK2NdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiK2Ncw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:32:52 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9D712611;
        Tue, 29 Nov 2022 05:32:50 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id v13so371660oie.3;
        Tue, 29 Nov 2022 05:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6f3T3Ai5aB9vAVS44RpF5q4LfJhgCY2QNzgEab8+RG4=;
        b=Joo8tRiQ+2/q8xA5fbCdPZjzdUDl2X/F4+CnTJRQi1XtK5TpZjQCygrKH8RMQIGCJl
         20NnXr28dWV87qoDbetcvKyGqX50CSIx4oqnDwAI9CUgEAS4mSZzgCtrv8RtLzucbhu7
         dz5A1Nt+gE48GKLfl/8oAQwscEMhM0E1VyCw7uEW5uLuaP7MJIPXPEq7Vd8yjgsmMtj/
         iLSlmyBrLR8lpp86tLQh1kyW9R6VaPs79OOABrL/52Y5dJkXwOhBlIegndhHrxt2YZNu
         URmsXZHOxfDx+ORXLbblXN1lwCDfwyj2JPBRMGTYwfzUx47TU9G718LBFgfmDq5v1JWJ
         Rndg==
X-Gm-Message-State: ANoB5pk0C++nMftOny6hv0dR0lRKqda/WkJ/bP/te8sspF++my5py085
        qVDj2vuViNjGdw5su3fOsw==
X-Google-Smtp-Source: AA0mqf6+QgSMbVEB7h2nMYc5UPXSSDhr5Tp+204wlBNNwIvooy8zoF7wDV2oG6Bg4MIhXf87VcitQA==
X-Received: by 2002:a05:6808:352:b0:34d:918c:3c50 with SMTP id j18-20020a056808035200b0034d918c3c50mr27090558oie.24.1669728769592;
        Tue, 29 Nov 2022 05:32:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r33-20020a056808212100b0035b99bbe30bsm4257188oiw.54.2022.11.29.05.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:32:49 -0800 (PST)
Received: (nullmailer pid 3502172 invoked by uid 1000);
        Tue, 29 Nov 2022 13:32:43 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org
In-Reply-To: <20221129103509.9958-4-hayashi.kunihiko@socionext.com>
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-4-hayashi.kunihiko@socionext.com>
Message-Id: <166972831681.3491672.1137945923513424770.robh@kernel.org>
Subject: Re: [PATCH 3/8] dt-bindings: soc: socionext: Add UniPhier peripheral block
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


On Tue, 29 Nov 2022 19:35:04 +0900, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the peripheral block implemented on
> Socionext Uniphier SoCs.
> 
> Peripheral block implemented on Socionext UniPhier SoCs is an integrated
> component of the peripherals including UART, I2C/FI2C, and SCSSI.
> 
> Peripheral block has some function logics to control the component.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-perictrl.yaml          | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.example.dtb: perictrl@59820000: 'reset' does not match any of the regexes: '^clock-controller(@[0-9a-f]+)?$', '^reset-controller(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.example.dtb: perictrl@59820000: 'clock' does not match any of the regexes: '^clock-controller(@[0-9a-f]+)?$', '^reset-controller(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221129103509.9958-4-hayashi.kunihiko@socionext.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

