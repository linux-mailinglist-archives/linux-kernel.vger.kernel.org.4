Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEC46E497D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjDQNLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjDQNLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:11:32 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E73B47A;
        Mon, 17 Apr 2023 06:10:55 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id j12so16656448oij.3;
        Mon, 17 Apr 2023 06:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681737031; x=1684329031;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Jry06HvGlIuf9DQAjGhESKm49kYLIDW7RCcP+zw4oE=;
        b=fWxMLEAdxj09ClNjrNoPsH5Z7d1chi6g7AYDSHLfKsPmb0TzhUpv7aq3AAXzmoJr/5
         tzrlxu3dYJbwiZsHDj7VTcDHvFazxp4rLyeR37fSKAvVVOjDzsc2kmcsiySsGx7XE2vt
         2hWEWYcEElwQYAwbZO4iGj8wI1HwWuu8BhSHwKNR7ape48YuZPViOgZlpIunuqXMJAig
         N4DQoVKPh84Kt6bebD5Wv3zCUVf6EOG4QOi+IbtsiSw9HsGZx6RaPiodAIhAiJ6zE3vq
         N46sEnMFvAgRg+/i01xYKsF3CfN51uRkFh3kG8hVY6mE83dKObtukpRtNmneGLK/PAIg
         vnwA==
X-Gm-Message-State: AAQBX9cZJevjiWfL6hZEBU3b9cFgPU5cBczH2MFf5aRyitRLBjr61aHf
        Mc1jPmVB8FZmrSbXHgyB3A==
X-Google-Smtp-Source: AKy350Y4aH0hdYr3q3wYIq9II+cnWAjuXLdja9vFbsPQQeVrQsaCDGYVa1LXyUE9McMgjRKYL+2gFg==
X-Received: by 2002:aca:c44:0:b0:38e:bfa:241e with SMTP id i4-20020aca0c44000000b0038e0bfa241emr1084719oiy.42.1681737031117;
        Mon, 17 Apr 2023 06:10:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s188-20020acac2c5000000b00383eaea5e88sm4564595oif.38.2023.04.17.06.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:10:30 -0700 (PDT)
Received: (nullmailer pid 2588779 invoked by uid 1000);
        Mon, 17 Apr 2023 13:10:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jiri Valek - 2N <jiriv@axis.com>
Cc:     devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, linux-input@vger.kernel.org,
        robh+dt@kernel.org
In-Reply-To: <20230414233815.4004526-2-jiriv@axis.com>
References: <20230414233815.4004526-1-jiriv@axis.com>
 <20230414233815.4004526-2-jiriv@axis.com>
Message-Id: <168173527578.2535543.13078048336293156269.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: microchip,cap11xx: add
 advanced sensitivity settings
Date:   Mon, 17 Apr 2023 08:10:27 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Apr 2023 01:38:14 +0200, Jiri Valek - 2N wrote:
> Add support for advanced sensitivity settings and signal guard feature.
> 
> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
> ---
>  .../bindings/input/microchip,cap11xx.yaml     | 64 ++++++++++++++++++-
>  1 file changed, 61 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,signal-guard: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,signal-guard: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,input-treshold: 'minimum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,input-treshold: 'maximum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,input-treshold: 'minimum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,input-treshold: 'maximum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,calib-sensitivity: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,calib-sensitivity: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,signal-guard: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'enum', 'maxItems', 'minItems' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'maxItems', 'minItems' were unexpected)
		hint: A vendor string property with exact values has an implicit type
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,signal-guard: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	0 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	1 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,input-treshold: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'maxItems', 'maximum', 'minItems', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,input-treshold: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,input-treshold: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,calib-sensitivity: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'enum', 'maxItems', 'minItems' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'maxItems', 'minItems' were unexpected)
		hint: A vendor string property with exact values has an implicit type
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml: properties:microchip,calib-sensitivity: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	1 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	2 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	4 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.example.dtb: touch@28: microchip,signal-guard: [[0, 0, 0, 0, 0, 0]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.example.dtb: touch@28: microchip,signal-guard:0: [0, 0, 0, 0, 0, 0] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.example.dtb: touch@28: microchip,input-treshold: [[21, 18, 46, 46, 46, 21]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.example.dtb: touch@28: microchip,input-treshold:0: [21, 18, 46, 46, 46, 21] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.example.dtb: touch@28: 'microchip,calib-sensitivityj' does not match any of the regexes: '^led@[0-7]$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230414233815.4004526-2-jiriv@axis.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

