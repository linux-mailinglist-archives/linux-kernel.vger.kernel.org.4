Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0228268C8FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjBFVuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBFVuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:50:52 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173B42DE55;
        Mon,  6 Feb 2023 13:50:28 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 20so10210448oix.5;
        Mon, 06 Feb 2023 13:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TComHy6fZylroVxyyvSSlsSThHII6Mu4hEBfm8EqSnQ=;
        b=wzcgRGz00UQEDrm6wOLuvKXuTvB5rwVlO0eaTY1L4+SX8QIGvV0SFhKJ79vw8RCOfU
         3aIQkj2vffP9okUNAg429LO+yyrNI/1qDS1pUJG1yP4uUgy1lNHDkzj4CHu0rms9JJlC
         TfggjfNFmiLPl4yXbclfpNiS11jgvnqB1277QspPjBIewp6OsxTrpJhw/tCGElx3eMRv
         iMSyNoy2GarWtgsWjC14iWpvjfd6tUBLI878zXFOIUWGk+DW42IweKEBQYLNqaENl4OS
         GBpFeQP+oEWQbeh2r1pbxyZsf6l+jCGY6lqluCfzkiZqhZZ1GFiebkiRfk61m0L5ndsG
         kcBA==
X-Gm-Message-State: AO0yUKVf1pIZv4nlOlZJU/OrkeBigg3FVsRyPZ5k+CKyBlH1JjAuOtpW
        s/YVzYIcM9Nu7o8t055eCA==
X-Google-Smtp-Source: AK7set/hYpEoCmUec9o7ktPTMXf736j7C/JoYG/gvXF5wTwFwEmDcTGWh8hMqjewMfZtm/XdF/MBdg==
X-Received: by 2002:aca:1c03:0:b0:378:4a78:2bba with SMTP id c3-20020aca1c03000000b003784a782bbamr134479oic.18.1675720209074;
        Mon, 06 Feb 2023 13:50:09 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x4-20020a9d6284000000b006865f605ce3sm5495840otk.54.2023.02.06.13.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:50:08 -0800 (PST)
Received: (nullmailer pid 1564985 invoked by uid 1000);
        Mon, 06 Feb 2023 21:50:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        phone-devel@vger.kernel.org
In-Reply-To: <20230206-ov2685-dtschema-v1-1-9e4da3474c10@z3ntu.xyz>
References: <20230206-ov2685-dtschema-v1-1-9e4da3474c10@z3ntu.xyz>
Message-Id: <167572017056.1564123.13342855865502188090.robh@kernel.org>
Subject: Re: [PATCH] media: dt-bindings: ov2685: convert to dtschema
Date:   Mon, 06 Feb 2023 15:50:08 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Feb 2023 21:23:16 +0100, Luca Weiss wrote:
> Convert the text-based dt-bindings to yaml.
> 
> Changes from original txt:
> * Take wording for various properties from other yaml bindings, this
>   removes e.g. volt amount from schema since it isn't really relevant
>   and the datasheet is a better source.
> * Don't make reset-gpios a required property since it can be tied to
>   DOVDD instead.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../devicetree/bindings/media/i2c/ov2685.txt       |  41 ---------
>  .../devicetree/bindings/media/i2c/ovti,ov2685.yaml | 101 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  3 files changed, 102 insertions(+), 41 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: 'clocks' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: 'clock-names' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: 'dvdd-supply' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: 'avdd-supply' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: 'dovdd-supply' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230206-ov2685-dtschema-v1-1-9e4da3474c10@z3ntu.xyz

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

