Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034B8645C50
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLGOUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiLGOT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:19:59 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7735CD2A;
        Wed,  7 Dec 2022 06:19:57 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so11344038otl.10;
        Wed, 07 Dec 2022 06:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QgVOiHXNq8Eg/RbdXIqm53C1ukjaOPMLva8zWgn7a2M=;
        b=WBaExhRs3nHA0FXvfCy0sdSdQn2ckfyQxLUzw1F1eRyMMjs/yZLMOwrnFMRZevzUA1
         8oK7A1lMo2st6Mjr7PVKcu9mlNVdbE5g59Hl0Ml6v8FNVcGElLIP2yLotiyw3n0xRJLZ
         PJRXyn3tV21sSh8VgtGc/UA17KyFS1mKFvKFAQzXb+HcESyODwbj6tJqkVKlUHP3Nlzx
         5ajUvZNIZrtfwCJsGw0I96RzYfOFG2a3cvifPKcAFzDImwOaCjgaeyfPU+Pa9LmzlQD0
         vSjDr6Y41QsLZMwhcLO8445ybWbu3ry412JSSStfh76eoGCyu1hojWSucWcB5S5c3b0E
         uwMg==
X-Gm-Message-State: ANoB5plkGnLcp2eRShZuhG6dw+5nRWAvH5h26c3rhmU+xRC0KczLi0Rd
        gFkYqK+o/GTXUu6oj9EfNQ==
X-Google-Smtp-Source: AA0mqf422GoEENzKggll1Vr+0LCwcJG1tEGJNJCcx00he4Eb012EfRCZ1zlWY/G3Oy+Ad/qk/rDIgQ==
X-Received: by 2002:a05:6830:1419:b0:670:6518:157e with SMTP id v25-20020a056830141900b006706518157emr1109531otp.269.1670422797191;
        Wed, 07 Dec 2022 06:19:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t26-20020a05683014da00b0066cb9069e0bsm10508365otq.42.2022.12.07.06.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:19:56 -0800 (PST)
Received: (nullmailer pid 2124805 invoked by uid 1000);
        Wed, 07 Dec 2022 14:19:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org
In-Reply-To: <20221207055405.30940-17-hayashi.kunihiko@socionext.com>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-17-hayashi.kunihiko@socionext.com>
Message-Id: <167042222204.2111807.2226062109962666582.robh@kernel.org>
Subject: Re: [PATCH v2 16/16] dt-bindings: soc: socionext: Add UniPhier AHCI
 glue layer
Date:   Wed, 07 Dec 2022 08:19:49 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2022 14:54:05 +0900, Kunihiko Hayashi wrote:
> Add DT binding schema for components belonging to the platform-specific
> AHCI glue layer implemented in UniPhier SoCs.
> 
> This AHCI glue layer works as a sideband logic for the host controller,
> including core reset, PHYs, and some signals to the controller.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-ahci-glue.yaml         | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.example.dtb: ahci-glue@65700000: 'reg' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221207055405.30940-17-hayashi.kunihiko@socionext.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

