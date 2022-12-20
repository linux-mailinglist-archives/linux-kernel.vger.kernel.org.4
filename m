Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3440652216
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiLTOKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiLTOKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:10:17 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C221B7A2;
        Tue, 20 Dec 2022 06:10:12 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id s187so10622351oie.10;
        Tue, 20 Dec 2022 06:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SjBHXkyHGiWve/uXORSeTIM3nsUbZRLtIdh/xsIJaqY=;
        b=3vCWeUFmZqqKAmbz1pbBx31HxJdX73A4uyQxK9JfPsFO8MPc8XXMlQarVGisPAx4U5
         vgiLei66bnWr5stcJ8gS97tt3pNgppxTC2DT3eDhmSMfOYZQNdWkk77TpAjSSzrsBAY4
         ZIIT2T+YH6S4fEm1wW1bFnCs5L+loxITGa6itbgGZd0vUpWdjZiHE9qksE2puEuCALHR
         e2Sk2sfcbY2ZHiERyybRVJAmVgIT6CeFbjwa2WXMTUhQF2yYA68Bmk1zd+IkWiCaysE5
         IMog1vBKNZNBsUeCt5hjyYW/Ni+x54UYwTkKIbh9gkHoU++2/n98dcFHxPf9TKjdrSFV
         U45Q==
X-Gm-Message-State: AFqh2krFkHlS1yPLO5LFmQRzQt7fGRJyJgCxmijalsbTSdEW0NiLewPj
        bjiEX+pPsmFtHM4qC6qKWQ==
X-Google-Smtp-Source: AMrXdXspHadroOLYY8Z4ogPudHrY6urHxn+kioyUvSh0MS4YyW567+BPsFy8G7Mi/VU2mH5AF4CEDg==
X-Received: by 2002:a05:6808:2182:b0:361:8ea:a3b5 with SMTP id be2-20020a056808218200b0036108eaa3b5mr3111612oib.54.1671545411626;
        Tue, 20 Dec 2022 06:10:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p26-20020a9d745a000000b006391adb6034sm5642896otk.72.2022.12.20.06.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:10:11 -0800 (PST)
Received: (nullmailer pid 226274 invoked by uid 1000);
        Tue, 20 Dec 2022 14:10:10 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jim Liu <jim.t90615@gmail.com>
Cc:     linux-gpio@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, openbmc@lists.ozlabs.org, JJLIU0@nuvoton.com,
        linux-kernel@vger.kernel.org, KWLIU@nuvoton.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org
In-Reply-To: <20221220080139.1803-4-JJLIU0@nuvoton.com>
References: <20221220080139.1803-1-JJLIU0@nuvoton.com>
 <20221220080139.1803-4-JJLIU0@nuvoton.com>
Message-Id: <167154528944.200721.11678821541440830244.robh@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: gpio: add npcm7xx sgpio driver bindings
Date:   Tue, 20 Dec 2022 08:10:10 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2022 16:01:39 +0800, Jim Liu wrote:
> Add dt-bindings document for the NPCM7xx sgpio driver
> 
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
> Changes for v3:
>    - modify description
>    - modify in/out property name
> Changes for v2:
>    - modify description
> ---
>  .../bindings/gpio/nuvoton,sgpio.yaml          | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,input-ngpios: True is not of type 'object'
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,input-ngpios: More than one condition true in oneOf schema:
	{'description': 'Vendor specific properties must have a type and '
	                'description unless they have a defined, common '
	                'suffix.',
	 'oneOf': [{'additionalProperties': False,
	            'description': 'A vendor boolean property can use "type: '
	                           'boolean"',
	            'properties': {'deprecated': True,
	                           'description': True,
	                           'type': {'const': 'boolean'}},
	            'required': ['type', 'description']},
	           {'additionalProperties': False,
	            'description': 'A vendor string property with exact values '
	                           'has an implicit type',
	            'oneOf': [{'required': ['enum']}, {'required': ['const']}],
	            'properties': {'const': {'type': 'string'},
	                           'deprecated': True,
	                           'description': True,
	                           'enum': {'items': {'type': 'string'}}},
	            'required': ['description']},
	           {'description': 'A vendor property needs a $ref to '
	                           'types.yaml',
	            'oneOf': [{'required': ['$ref']}, {'required': ['allOf']}],
	            'properties': {'$ref': {'pattern': 'types.yaml#/definitions/'},
	                           'allOf': {'items': [{'properties': {'$ref': {'pattern': 'types.yaml#/definitions/'}},
	                                                'required': ['$ref']}]}},
	            'required': ['description']},
	           {'description': 'A vendor property can have a $ref to a a '
	                           '$defs schema',
	            'properties': {'$ref': {'pattern': '^#/(definitions|\\$defs)/'}},
	            'required': ['$ref']}],
	 'type': 'object'}
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,output-ngpios: True is not of type 'object'
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,output-ngpios: More than one condition true in oneOf schema:
	{'description': 'Vendor specific properties must have a type and '
	                'description unless they have a defined, common '
	                'suffix.',
	 'oneOf': [{'additionalProperties': False,
	            'description': 'A vendor boolean property can use "type: '
	                           'boolean"',
	            'properties': {'deprecated': True,
	                           'description': True,
	                           'type': {'const': 'boolean'}},
	            'required': ['type', 'description']},
	           {'additionalProperties': False,
	            'description': 'A vendor string property with exact values '
	                           'has an implicit type',
	            'oneOf': [{'required': ['enum']}, {'required': ['const']}],
	            'properties': {'const': {'type': 'string'},
	                           'deprecated': True,
	                           'description': True,
	                           'enum': {'items': {'type': 'string'}}},
	            'required': ['description']},
	           {'description': 'A vendor property needs a $ref to '
	                           'types.yaml',
	            'oneOf': [{'required': ['$ref']}, {'required': ['allOf']}],
	            'properties': {'$ref': {'pattern': 'types.yaml#/definitions/'},
	                           'allOf': {'items': [{'properties': {'$ref': {'pattern': 'types.yaml#/definitions/'}},
	                                                'required': ['$ref']}]}},
	            'required': ['description']},
	           {'description': 'A vendor property can have a $ref to a a '
	                           '$defs schema',
	            'properties': {'$ref': {'pattern': '^#/(definitions|\\$defs)/'}},
	            'required': ['$ref']}],
	 'type': 'object'}
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221220080139.1803-4-JJLIU0@nuvoton.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

