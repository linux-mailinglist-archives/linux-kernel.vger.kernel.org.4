Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346186524D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiLTQlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiLTQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:41:03 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAED1090;
        Tue, 20 Dec 2022 08:41:01 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id i127so9831535oif.8;
        Tue, 20 Dec 2022 08:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UY+Y318S+0GC8+l3K6oMYhoO0DtBzjj8FaFxQfnBzhU=;
        b=BIiGt5W4Zmf5u+hc+IP6nIO3/Rp6gBxbKWeHLPN0DkxHtQliyVOfS9v1tn2XNxetOz
         z9uq7ErSsTKdAIfTBwD7+kQm4bT0P0WEgV/5JLhz8zC3nILmXAhmP6ADgNJjFz9anzJS
         nGct9NdJVJfmEnlA87Ut4nQ6c/rqGX6U8opK+AFbWM1w+gxiu9UyWUOSsF4GAu9VIt3W
         h9OK3+s7N9MHuCHJP2u6/GIPuOMgH50Hyjyl1XEwCt1YWkIFmOY+xB48Wt8CepejAnqY
         ruoL131a2bCzCqXGwrJ8mH+Vrp9Z9PcY3LNmra5wu8X4FOdlSrEN/3b56EgECt8+jO0l
         e3WA==
X-Gm-Message-State: AFqh2krPFOuHXX3q2iuYSQIimwIsghqQzMUYn3Trpe1q/Hi3/0NbibRY
        nlti2NAUW32Gi7i2mbZGOQ==
X-Google-Smtp-Source: AMrXdXsSdPfupRURBPcosH2gmACRMO8G7/u6yz1Jl6zoTYgYploE8g7Bl7rwKSb3o29A+AmWsqZdnA==
X-Received: by 2002:a05:6808:150b:b0:361:1a1:316 with SMTP id u11-20020a056808150b00b0036101a10316mr3680113oiw.33.1671554460478;
        Tue, 20 Dec 2022 08:41:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s8-20020acaa908000000b00354d8589a15sm5638397oie.45.2022.12.20.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:40:59 -0800 (PST)
Received: (nullmailer pid 709598 invoked by uid 1000);
        Tue, 20 Dec 2022 16:40:56 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kevin Lu <luminlong@139.com>
Cc:     robh+dt@kernel.org, alsa-devel@alsa-project.org, kevin-lu@ti.com,
        lgirdwood@gmail.com, shenghao-ding@ti.com, peeyush@ti.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, navada@ti.com, broonie@kernel.org
In-Reply-To: <20221220144114.2137-1-luminlong@139.com>
References: <20221220144114.2137-1-luminlong@139.com>
Message-Id: <167155420934.690140.217916297367066741.robh@kernel.org>
Subject: Re: [PATCH] New yaml file: tas2781
Date:   Tue, 20 Dec 2022 10:40:56 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2022 22:41:14 +0800, Kevin Lu wrote:
> Add DTS discription for tas2781 driver code
> 
> Signed-off-by: Kevin Lu <luminlong@139.com>
> ---
>  .../devicetree/bindings/sound/tas2781.yaml    | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2781.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,bottomright-channel: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	'description' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,bottomright-channel: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,bottomright-channel: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,topleft-channel: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,topleft-channel: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,topleft-channel: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,bottomleft-channel: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	'description' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,bottomleft-channel: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,bottomleft-channel: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,topright-channel: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	'description' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,topright-channel: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,topright-channel: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,global-address: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,global-address: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2781.yaml: properties:ti,global-address: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
Documentation/devicetree/bindings/sound/tas2781.example.dts:28.13-45: ERROR (duplicate_property_names): /example-0/i2c0/codec@38:ti,bottomright-channel: Duplicate property name
ERROR: Input tree has errors, aborting (use -f to force output)
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/sound/tas2781.example.dtb] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221220144114.2137-1-luminlong@139.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

