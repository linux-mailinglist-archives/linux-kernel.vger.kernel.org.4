Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF31645C45
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiLGOTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLGOTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:19:53 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC4555C81;
        Wed,  7 Dec 2022 06:19:51 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1445ca00781so14841550fac.1;
        Wed, 07 Dec 2022 06:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pi2o5fQQUNnXltuus7EPRUPgm6i8PxvXv763Tq5/HAM=;
        b=qcgZANJtSl5kHUfdJezRBdoLmkO2QWLGaRJIJyRokGrTc/DNMbXA7BugUQtaFp3qSN
         XyKiFI2SI+ZFYu6cUPWhRtrGlsM9bsi+Up9/5qf/AQKBGK+xxmX1YyKjApnEGx0RbBkV
         RLHihQMbQZBoQ3RzhSo3kMsDcewzGaDjTE+Tv4fKVSQZRBql5R7B6pR2eaBZpYjyFVXB
         A5TCKzoScO0frBnvv395Obpb6f1T7xoZkyDsPpav2Dao09eeqN48dIiL6NViK+k05sNN
         Jd1P21hBeJ0CYOvJKLv+KfSa+igbbKFwlzYqLyxa2vmUoZYt3unNblAX94JkFQb1IsS7
         8InQ==
X-Gm-Message-State: ANoB5pnwetmxm/DrovN2L3VQHLw0I795w1YXaqFMn+IPt3HEQ7vQUFev
        5DcPrbUoUPwVqyaVaMiL7A==
X-Google-Smtp-Source: AA0mqf5VSOef30zOp0qgUOwJNVFltclH7wjWy25TlqQr4xsb/OjxWJmLXhaaOSqiPhBVUECq3YL4wQ==
X-Received: by 2002:a05:6871:b21:b0:143:cc3d:58f with SMTP id fq33-20020a0568710b2100b00143cc3d058fmr23003973oab.210.1670422791094;
        Wed, 07 Dec 2022 06:19:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bt3-20020a05683039c300b0066e93d2b858sm6614711otb.55.2022.12.07.06.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:19:50 -0800 (PST)
Received: (nullmailer pid 2124798 invoked by uid 1000);
        Wed, 07 Dec 2022 14:19:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221207055405.30940-9-hayashi.kunihiko@socionext.com>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-9-hayashi.kunihiko@socionext.com>
Message-Id: <167042221991.2111700.14995917692321113955.robh@kernel.org>
Subject: Re: [PATCH v2 08/16] dt-bindings: soc: socionext: Add UniPhier system
 controller
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


On Wed, 07 Dec 2022 14:53:57 +0900, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the system controller implemented on
> Socionext Uniphier SoCs.
> 
> This system controller has multiple functions such as clock control,
> reset control, internal watchdog timer, thermal management, and so on.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext/socionext,uniphier-sysctrl.yaml | 105 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.example.dtb: sysctrl@61840000: 'thermal' does not match any of the regexes: '^clock-controller(@[0-9a-f]+)?$', '^reset-controller(@[0-9a-f]+)?$', '^thermal-sensor(@[0-9a-f]+)?$', '^watchdog(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221207055405.30940-9-hayashi.kunihiko@socionext.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

