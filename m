Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540E373C2B4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjFWVYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjFWVXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:23:30 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B2D2951;
        Fri, 23 Jun 2023 14:22:33 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-34220bb6a80so4000825ab.0;
        Fri, 23 Jun 2023 14:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687555352; x=1690147352;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X0GqmW/KiAv+jGYqZqTQZIrHhvVtdIco5t4/NhQsM7A=;
        b=iWB8rAh+VRuZ//pkO8BrPvobEcv/u8u75s356nVF/AEfNSZLvNRv16WAEnIdLuqCPu
         rBgpdw8JtYEdTsMs1YBfLIhjjAtvfbzS8bns4ZhEltRc56yfJpCr2M9HbeLabAJpRLr8
         n6MUgRAQK+PeZ+4RSd8S+m/dd5G4L8ARHzMwCwypoFYdpqPLRzGpPq59ojVv6VL18A+T
         /V7gRXZP5cqMgwF/6Nf7gnHgjcw9smQsNGnTIi71Dcs4TZ7dI4Ivr9r/SyA425mowcGs
         M13hRzuHeCM/9jXyls9a67VErRHL5fvmKGXW0k/IIYMjd4q3WFyWEGNDz5KhEaWrZSmN
         pT4g==
X-Gm-Message-State: AC+VfDw6MIuCwrK8mDpmhCUzJSaVgrrYphyIMq6k4pLHl3u/L044f90P
        WuhxE7HDlAoZpHj4kD0vQw==
X-Google-Smtp-Source: ACHHUZ7to7Wz432gqoGE6X6X+bOK8zEInf2fqDeW/L3y0SuGvSi75QMTRYsjjfKDvAi+lBdV6sJfZg==
X-Received: by 2002:a05:6e02:610:b0:331:9c03:dada with SMTP id t16-20020a056e02061000b003319c03dadamr18736468ils.13.1687555352277;
        Fri, 23 Jun 2023 14:22:32 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u1-20020a056e02080100b00342a1941daesm74587ilm.81.2023.06.23.14.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 14:22:31 -0700 (PDT)
Received: (nullmailer pid 1191189 invoked by uid 1000);
        Fri, 23 Jun 2023 21:22:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20230623201519.194269-1-afd@ti.com>
References: <20230623201519.194269-1-afd@ti.com>
Message-Id: <168755534990.1191151.8134039099017913355.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: ti,j721e-system-controller: Remove
 syscon from example
Date:   Fri, 23 Jun 2023 15:22:29 -0600
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


On Fri, 23 Jun 2023 15:15:19 -0500, Andrew Davis wrote:
> The binding for ti,am654-ehrpwm-tbclk was updated to remove the syscon
> compatible hint. Remove the same from the example in this binding.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../devicetree/bindings/mfd/ti,j721e-system-controller.yaml     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.example.dtb: scm-conf@100000: clock-controller@4140:compatible: ['ti,am654-ehrpwm-tbclk'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/ti,j721e-system-controller.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.example.dtb: clock-controller@4140: compatible: ['ti,am654-ehrpwm-tbclk'] is too short
	from schema $id: http://devicetree.org/schemas/clock/ti,am654-ehrpwm-tbclk.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230623201519.194269-1-afd@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

