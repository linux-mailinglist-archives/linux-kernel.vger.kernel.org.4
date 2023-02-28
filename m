Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142316A63BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjB1XPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1XPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:15:31 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD98A126D1;
        Tue, 28 Feb 2023 15:15:26 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id x19-20020a4a3953000000b00525191358b6so1820120oog.12;
        Tue, 28 Feb 2023 15:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=42CWs713idbO/CYhPX4NZ4H9bYxxL/CCH/Vaue+iG8M=;
        b=vViWgrISr7bmNk3NqUQpiYPLxjYDDFBLPvMHB8ZehuXeDcC8h5Ymk3k0lfHWqitmNU
         CIZc/Q6Z5yRx1JYM2pyWfwAo/E5u4ikgUt4fTNkIGh74Eebmzud2FSnIQ/q8W8vJi8cS
         y75Q4u2e6lszP4ax5dI0bxBSg0lbeUaulSlbMM6QvTSfS70VyNVQrGPsVj7SiSHgWX2c
         +FBv5L16L3Z8RpestTaUaxqM899UhORmjF6139ShaE1OWH/ZtNm+Jx9BoJnLMyqRakXk
         eE4ltvChsDuC5gaTHiuf161BAHZBFhSt2AKIqYw2+WfBtWo6/va/fJ6WsqKHnAN9HXAC
         5PJw==
X-Gm-Message-State: AO0yUKX6qSfTAlGu6kHH3JRfxydpeK25Nh+FvUs6ihEIEvumcRAg9kH3
        HyqFxBuCS8aHPZWkoiWYKA==
X-Google-Smtp-Source: AK7set+tMwLfJlHBAPoLVZOB1EWEZgi5T+91nmZvuIQvmyX6QUc9G0z1Jj82uaTGupYNDZi7yr4zXg==
X-Received: by 2002:a4a:e511:0:b0:525:5a74:a7fe with SMTP id r17-20020a4ae511000000b005255a74a7femr2032879oot.4.1677626125963;
        Tue, 28 Feb 2023 15:15:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a4aae09000000b0049fd5c02d25sm4211690oom.12.2023.02.28.15.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:15:25 -0800 (PST)
Received: (nullmailer pid 4157989 invoked by uid 1000);
        Tue, 28 Feb 2023 23:15:24 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>
In-Reply-To: <a698f524106e0eb7db5cbd7e73e77ecd5ac8ad7f.1677620677.git.jahau@rocketmail.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
 <a698f524106e0eb7db5cbd7e73e77ecd5ac8ad7f.1677620677.git.jahau@rocketmail.com>
Message-Id: <167762589365.4152972.16760715269546832503.robh@kernel.org>
Subject: Re: [PATCH 10/10] dt-bindings: Add documentation for rt5033 mfd,
 regulator and charger
Date:   Tue, 28 Feb 2023 17:15:24 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Feb 2023 23:32:27 +0100, Jakob Hauser wrote:
> Add device tree binding documentation for rt5033 multifunction device, voltage
> regulator and battery charger.
> 
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  .../bindings/mfd/richtek,rt5033.yaml          | 102 ++++++++++++++++++
>  .../power/supply/richtek,rt5033-charger.yaml  |  76 +++++++++++++
>  .../regulator/richtek,rt5033-regulator.yaml   |  45 ++++++++
>  3 files changed, 223 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/power/supply/richtek,rt5033-charger.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,pre-threshold-uvolt: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,pre-threshold-uvolt: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,pre-threshold-uvolt: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,const-uvolt: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,const-uvolt: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,const-uvolt: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,eoc-uamp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,eoc-uamp: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,eoc-uamp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,fast-uamp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,fast-uamp: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,fast-uamp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,pre-uamp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,pre-uamp: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml: properties:richtek,pre-uamp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
Documentation/devicetree/bindings/mfd/richtek,rt5033.example.dts:23.15-66.11: Warning (unit_address_vs_reg): /example-0/i2c@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/mfd/richtek,rt5033.example.dts:68.15-78.11: Warning (unit_address_vs_reg): /example-0/i2c@1: node has a unit name, but no reg or ranges property

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/a698f524106e0eb7db5cbd7e73e77ecd5ac8ad7f.1677620677.git.jahau@rocketmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

