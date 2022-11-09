Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE662356E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiKIVJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiKIVJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:09:13 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC9B12D38;
        Wed,  9 Nov 2022 13:09:12 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-13b103a3e5dso193834fac.2;
        Wed, 09 Nov 2022 13:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=69ynaJZ0vfSiU5Z7REHN/yVn0+I4DGU0vC88AAV66eU=;
        b=rh09yB7TkjRXGV19Bw67j20XW4exVjrcKHX0RZVnQxkeXyoAFC4zu/8JX0eEXdGPXJ
         igW9PmJ+5fLHckPfivjJECJ7CJfXUkaJ5U55EUOLuCoiTNMlaJnIzHFdQ41BLx812L8V
         rmzIqX/cl7O7ZpyQ/Ra0OtmT6GBCLcpQxBOQ7Agu38PDXAk4ZAneV03zg9l7veriWgdp
         oiKLF90XBVsDk4SAnL18UeY2gt3ovNhDuQMAeuclVHXBVQiR9s+tg8hii1qQd74ulEh8
         TJpShTTgiHwKIWMccHbC5KQeMqxe0ma8/UbMYzZQ6ab2NvmeeAA6OsomuW2g++yldJHK
         00ZQ==
X-Gm-Message-State: ANoB5pkcZmZ3zc0662T1bLIcuiErfY1GCDiQcP4YZVedmzEEIX39h7J1
        OSvPRPioRPESQ2lkZ4EBag==
X-Google-Smtp-Source: AA0mqf7uijbXxM1V5E4YDTZSWH4fX4tkDBL3BOD5z9wGdyYsxPQIhx2cbf5ym35wl8Y+779wpe7d8g==
X-Received: by 2002:a05:6870:888c:b0:12c:55d6:968 with SMTP id m12-20020a056870888c00b0012c55d60968mr11226996oam.244.1668028151442;
        Wed, 09 Nov 2022 13:09:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r198-20020a4a37cf000000b0049be423151asm4572127oor.34.2022.11.09.13.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:09:10 -0800 (PST)
Received: (nullmailer pid 2868046 invoked by uid 1000);
        Wed, 09 Nov 2022 21:09:10 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     lee@kernel.org, patches@opensource.cirrus.com, maz@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        broonie@kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20221109165331.29332-2-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-2-rf@opensource.cirrus.com>
Message-Id: <166802788268.2833081.8250615552136903141.robh@kernel.org>
Subject: Re: [PATCH 01/12] dt-bindings: mfd: Add Cirrus Logic CS48L32 audio codec
Date:   Wed, 09 Nov 2022 15:09:10 -0600
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


On Wed, 09 Nov 2022 16:53:20 +0000, Richard Fitzgerald wrote:
> The CS48L32 has multiple digital and analog audio I/O, a
> high-performance low-power programmable audio DSP, and a variety of
> power-efficient fixed-function audio processors, with digital
> mixing and routing.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../bindings/mfd/cirrus,cs48l32.yaml          | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml:107:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
./Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml:108:7: [warning] wrong indentation: expected 8 but found 6 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml: properties:clocks: 'oneOf' conditional failed, one must be fixed:
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml: properties:clocks: 'anyOf' conditional failed, one must be fixed:
		'minItems' is not one of ['maxItems', 'description', 'deprecated']
			hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
		'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
		'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
		1 is less than the minimum of 2
			hint: Arrays must be described with a combination of minItems/maxItems/items
		hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
		from schema $id: http://devicetree.org/meta-schemas/clocks.yaml#
	'minItems' is not one of ['type', 'description', 'dependencies', 'dependentRequired', 'dependentSchemas', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'allOf', 'anyOf', 'oneOf', '$ref']
	'maxItems' is not one of ['type', 'description', 'dependencies', 'dependentRequired', 'dependentSchemas', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'allOf', 'anyOf', 'oneOf', '$ref']
	'type' is a required property
		hint: DT nodes ("object" type in schemas) can only use a subset of json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/clocks.yaml#
./Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/pinctrl/cirrus,cs48l32.yaml
Documentation/devicetree/bindings/mfd/cirrus,cs48l32.example.dts:21:18: fatal error: dt-bindings/sound/cs48l32.h: No such file or directory
   21 |         #include <dt-bindings/sound/cs48l32.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/mfd/cirrus,cs48l32.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

