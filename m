Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62784645C54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiLGOUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiLGOUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:20:03 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316445D684;
        Wed,  7 Dec 2022 06:20:00 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-144b21f5e5fso9473250fac.12;
        Wed, 07 Dec 2022 06:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6REGDwsxUyupn+rXuHn0ky3P3vhdc4pwFOOga2lMtws=;
        b=x90tUDf9gm80Zd1BX/j8Y3tAtdzxlIzLv3PYgpUV1CGDkJTqG7sPqOj+622JIw9ybm
         m+49lokdJzpd3Vy6A0J+0Og7zp9jrsPyY0S+uRQBaIh1YfdyQhdbjucFI4jo1/03QxLg
         1GLHSW9BggBDgPUTSfRZL350Qk3JTjdg/voLqVHzYZjq8qwTXfqsdsy6wIDEKJN7v4Nr
         tjd5CbG34hVQhv4YJSYkk8V3OJ9AV7Tr1srKTYO9HqR3OeXScIv4Ln0z/ohvaOnQF6Jf
         uz/0Zzs/Vt1JdBTUFPKV5jTYgYzKUeNVZb65q2DG8ChQ+RV+LL54QX0p8fbJ9jJqdhfC
         +woA==
X-Gm-Message-State: ANoB5pmbWD9f5Z8xMbF2BkSVyJs3qsXSUnoHXiv/PGTrlDDZBu17aiYO
        JIUc6Cqx4Ehf72NylwNciIru4yXlew==
X-Google-Smtp-Source: AA0mqf63rXZN63JQcpj3P1nEVS0QcOEf+qubo/c4ZeY90gJ2hofp6U8B7yWmwvjWjEBIfSd4QjQKpA==
X-Received: by 2002:a05:6871:792:b0:141:c075:9346 with SMTP id o18-20020a056871079200b00141c0759346mr40349936oap.30.1670422799416;
        Wed, 07 Dec 2022 06:19:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p184-20020acabfc1000000b00354efb5be11sm9321200oif.15.2022.12.07.06.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:19:59 -0800 (PST)
Received: (nullmailer pid 2124801 invoked by uid 1000);
        Wed, 07 Dec 2022 14:19:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20221207055405.30940-15-hayashi.kunihiko@socionext.com>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-15-hayashi.kunihiko@socionext.com>
Message-Id: <167042222062.2111748.7794629247981493591.robh@kernel.org>
Subject: Re: [PATCH v2 14/16] dt-bindings: soc: socionext: Add UniPhier ADAMV block
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


On Wed, 07 Dec 2022 14:54:03 +0900, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the ADAMV block implemented on Socionext
> Uniphier SoCs.
> 
> The ADAMV block is analog signal amplifier that is a part of the external
> video and audio I/O system. This block is implemented on LD11 and LD20,
> and this is defined for controlling audio I/O reset only.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext/socionext,uniphier-adamv.yaml   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-adamv.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.example.dtb: adamv@57920000: 'reset' does not match any of the regexes: '^reset-controller(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-adamv.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221207055405.30940-15-hayashi.kunihiko@socionext.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

