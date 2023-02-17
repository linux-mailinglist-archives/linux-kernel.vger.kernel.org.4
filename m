Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E93769AF6C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjBQPWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBQPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:22:41 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765AE64B1A;
        Fri, 17 Feb 2023 07:22:39 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-171894cdf02so1256182fac.11;
        Fri, 17 Feb 2023 07:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lL6hsm2eWKzX5rffaK5mdJBLi8Mcc5sKGEpXhxOwRzo=;
        b=LHKZlKB6out+acI0SOaWU8pVdJ9lW9Od6KGZZiesAfCKgDozytg1AsxtzVaYTAjQ8f
         HaUWFCYBtAPPJKjg+yfHWNRrG1VnlT2HuJ8gE+Mh97sI9ZyvjcSZ2308CTzni28uQHQ4
         hBx9U8UNsGu2NoqEQO0sfdPuRWU8+uiNana4HXV5Kl4MoTv9XTsuhuwNQAlMTbk1/gem
         YU3jk99vgt7QJ4pOfH3d8GsPzS4bRs2LThDvNMybZ8QWRyEuAkpouyUoPa/A+P8lMFiB
         K89MXuy3/oae+Q9LB3JiIEAkI5fdGKgi6+lDfw9PC49/XIndnGa08o0pev98slWQjesb
         4L+g==
X-Gm-Message-State: AO0yUKUETV9RoZ8zQ4LvvUZxrGUaX9DmQ6rLka19Q1sAAMFVEsQct7DV
        PeWpXAERlcAwvVu+dxOCEg==
X-Google-Smtp-Source: AK7set8CNcQvPg1UU7tzYE0kfVflLacrKC4W+dAU975rORuG7n5TvQ1POmv7dWmVd7tGCw6MqnaE4Q==
X-Received: by 2002:a05:6871:14a:b0:16e:8ce5:b98 with SMTP id z10-20020a056871014a00b0016e8ce50b98mr2376754oab.8.1676647357229;
        Fri, 17 Feb 2023 07:22:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k8-20020a4adfa8000000b005176714c603sm1919545ook.4.2023.02.17.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 07:22:36 -0800 (PST)
Received: (nullmailer pid 956423 invoked by uid 1000);
        Fri, 17 Feb 2023 15:22:36 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     Angelo Compagnucci <angelo@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20230217145731.3018148-3-angelo@amarulasolutions.com>
References: <20230217145731.3018148-1-angelo@amarulasolutions.com>
 <20230217145731.3018148-3-angelo@amarulasolutions.com>
Message-Id: <167664704533.950732.842407236481610710.robh@kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: leds: servo-pwm: Add new bindings
 for servo-pwm
Date:   Fri, 17 Feb 2023 09:22:36 -0600
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


On Fri, 17 Feb 2023 15:57:30 +0100, Angelo Compagnucci wrote:
> This binding describes the binding for controlling servo motors through
> pwm.
> 
> Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> ---
>  .../devicetree/bindings/misc/servo-pwm.yaml   | 59 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/servo-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/servo-pwm.yaml: patternProperties: 'properties' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/servo-pwm.yaml: patternProperties:properties: 'anyOf' conditional failed, one must be fixed:
	'pwms' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/servo-pwm.yaml: patternProperties:properties: 'anyOf' conditional failed, one must be fixed:
	'pwm-names' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/servo-pwm.yaml: patternProperties:properties: 'anyOf' conditional failed, one must be fixed:
	'degrees' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/servo-pwm.yaml: patternProperties:properties: 'anyOf' conditional failed, one must be fixed:
	'duty-min' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/servo-pwm.yaml: patternProperties:properties: 'anyOf' conditional failed, one must be fixed:
	'duty-max' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
Documentation/devicetree/bindings/misc/servo-pwm.example.dts:19.24-25.11: Warning (unit_address_vs_reg): /example-0/servo@0: node has a unit name, but no reg or ranges property
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/servo-pwm.example.dtb: servo@0: 'degrees', 'duty-max', 'duty-min', 'pwms' do not match any of the regexes: 'pinctrl-[0-9]+', 'properties'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/servo-pwm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230217145731.3018148-3-angelo@amarulasolutions.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

