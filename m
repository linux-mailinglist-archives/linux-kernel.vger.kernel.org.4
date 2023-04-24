Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE96ECE12
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjDXN25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjDXN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:28:44 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1490F659A;
        Mon, 24 Apr 2023 06:28:30 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-18785f07525so1508396fac.3;
        Mon, 24 Apr 2023 06:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682342896; x=1684934896;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BUbITa7M0mz2iZpaowuhtMLwPUGEDWVdrXFE3/RAlpI=;
        b=PXDy66cH57ZaX/aYpA5kF3FMEXjhIiUJqIIKQoLj1/YAOmrBO2nRORt+EdI4RKCKO5
         Lm3xIipcfJiCfZ9ViGlBy1Ep0kS4dfZTTOZPzXrWU+XFNwBzGR4DTfo1Ru9oIcoOmW3d
         oRJEQc0aFrfvpay1+3dGLoSuWpColMfLlipOJlfLh5Vb5gFE+HGx5lO2FjGuyy2nS6QU
         5Bj11Fq7fqGmIpSQvxER8/kLLs9f6egsuILTJBa8UnxlSkRBJLxRkWu+DE3s3yWVr4Q2
         RrLNEKUaxpJ868qiPn0pskIxrn/CdoeRPTdmol447JAGKanQtrSuS60GKQK+4A7lGUDT
         Z1bw==
X-Gm-Message-State: AAQBX9ehnFNkZ9DPCm4ovteHBTAy+qUgr/5bHDpisCbp1i1WYZJ9RmTB
        s5NLgceHZmCfIXIDJ2OHrw==
X-Google-Smtp-Source: AKy350ZNRKoPdi8PRsXdyeVXpHGjJIWBlX1BLCc1hqcgXnHJQReVhG2v85dieRZAzC9x+ey504B+vQ==
X-Received: by 2002:a05:6870:5249:b0:184:579c:4f07 with SMTP id o9-20020a056870524900b00184579c4f07mr8688765oai.48.1682342896471;
        Mon, 24 Apr 2023 06:28:16 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80e7:4387:ec9f:155:c2d2:6e82])
        by smtp.gmail.com with ESMTPSA id h9-20020a056830164900b006a61bef7968sm4551935otr.53.2023.04.24.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:28:15 -0700 (PDT)
Received: (nullmailer pid 2494970 invoked by uid 1000);
        Mon, 24 Apr 2023 13:28:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230424123522.18302-4-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-4-nikita.shubin@maquefel.me>
Message-Id: <168234254711.2487840.819622568941840833.robh@kernel.org>
Subject: Re: [PATCH 03/43] dt-bindings: pinctrl: Add DT bindings ep93xx
 pinctrl
Date:   Mon, 24 Apr 2023 08:28:08 -0500
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


On Mon, 24 Apr 2023 15:34:19 +0300, Nikita Shubin wrote:
> Add YAML bindings ep93xx SoC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> 
> Notes:
>     rfc->v0:
>     - dropped separate bindings description, left only one with all groups,
>       functions and etc...
>     - added Alexander Sverdlin to maintainers
>     - added Linus Reviwed-by tags, through i shoudn't =) too many changes
>     - fixed warning and added seq_file header
> 
>  .../pinctrl/cirrus,ep93xx-pinctrl.yaml        | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,ep93xx-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pinctrl/cirrus,ep93xx-pinctrl.example.dtb: /example-0/syscon@80930000: failed to match any schema with compatible: ['cirrus,ep9301-syscon', 'syscon', 'simple-mfd']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230424123522.18302-4-nikita.shubin@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

