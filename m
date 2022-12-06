Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD5B644D4A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLFUa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLFUax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:30:53 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E240474;
        Tue,  6 Dec 2022 12:30:27 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-12c8312131fso18879275fac.4;
        Tue, 06 Dec 2022 12:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=70BHd3Bha/3SVQ9Fqr3IAXA2KJogPif1rbxfcGanlLI=;
        b=l6qMrOMc1gVbYuhlAszHRHks1h0MPjaq7mTYN4fRdwTET6syx9uRLKz2nOhZth5ccC
         179CPtZ+JPBMvoGJ5p/ir3tq6lLPajNnfuGK5nuv7ZoVzv+iZNgaXLhaYNwRWgWtI6CQ
         Xb9QH9uVVLoznqXYEnZ4MkC5Wkx1B+D9+42TN1CPtlYKnooXzMig+smn9LZ7lMFP/kJO
         Xi+OT4oMFALrp7UpAlxb1mBJ9JvcxwzNEHw/RZcHz49GF2dIClvRbSqLN+c5cvxXtxoE
         oC/YA9UXvqmOwBQdQBrDoUw30C8HrvS+XHFF/QqfEWbE6WU+p7hve8ePHqb7jR3+jstr
         AhEg==
X-Gm-Message-State: ANoB5pnYXvPy3lQOawa2nmCiumfGJi2QdipMvzBzOy1jvwU8Vcis0tY3
        9lkE2lAcrJUIcCsImRNVOg==
X-Google-Smtp-Source: AA0mqf5/7tA6GtNa+ooZZfrQ3D2c18qvAkkUxKQVVV1LX5FQdtjOnvkYmlxagHeWWB71G/nuMbts8g==
X-Received: by 2002:a05:6870:c0d1:b0:144:a87e:727d with SMTP id e17-20020a056870c0d100b00144a87e727dmr4999479oad.153.1670358626695;
        Tue, 06 Dec 2022 12:30:26 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id u33-20020a05687100a100b0013ae39d0575sm11279086oaa.15.2022.12.06.12.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 12:30:26 -0800 (PST)
Received: (nullmailer pid 8554 invoked by uid 1000);
        Tue, 06 Dec 2022 20:30:25 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20221206124456.4159-1-edmund.berenson@emlix.com>
References: <20221206124456.4159-1-edmund.berenson@emlix.com>
Message-Id: <167035855162.6750.5481578237893135512.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: max7317: add gpio driver bindings
Date:   Tue, 06 Dec 2022 14:30:25 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 06 Dec 2022 13:44:55 +0100, Edmund Berenson wrote:
> Add driver bindings for the maxim max7317 spi
> gpio expander.
> 
> Co-developed-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> ---
>  .../bindings/gpio/gpio-max7317.yaml           | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-max7317.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/gpio-max7317.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/gpio-max7317.example.dtb: gpio5@0: 'spi-max-frequency' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/gpio-max7317.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221206124456.4159-1-edmund.berenson@emlix.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

