Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38106641D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbjAJN3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjAJN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:29:33 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423E910B3;
        Tue, 10 Jan 2023 05:29:32 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id r2-20020a9d7cc2000000b006718a7f7fbaso6958890otn.2;
        Tue, 10 Jan 2023 05:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zKAe0OFUWm2XvE8TtB0lP81U5fBp4FRhR/a1eftM+Ek=;
        b=VigkJQ0EWzxGefJCeXaPUHMOiF3cw51+Cb+X5iE55xu099UYvTfpA0yDQRII5pYi/r
         RzMVrb6Il9j4y4QVuLFSz711nPVSfhiN01TVaNcASuBU4bOtUHU46zTcw2t8f5vMlNLI
         5PavAFoiaGSQtBDYaq0xVmoY6nDV82iqPFloJEgbSY3nAeHz7DsbgKbh1NMEdENHee0k
         +XUZh+mKl+7g58e7/W6yAmdJ5N7JS5nRYiQtpioWbjh26vUtDRd8mWeq6LvMzHbk6fGp
         zo3noD+4QlCLRW9ZcuF3jLYmkDWfhOLOqlxtGjMd3d18MVJWfZxUqi/hL+N0MIBx17h4
         w9fQ==
X-Gm-Message-State: AFqh2kr7v21c1b1Gm816OwsTj4e5bklaDrxg5X+6qV8xTGv30YkdbFgT
        8f5FT6zjJ4/R+wmhx1MnLuUH9sQUqA==
X-Google-Smtp-Source: AMrXdXsD1u2a+0P2EAP8UF4IZ31u4JKrWLup4jFFntlInWFYKtWuEjk3NnGkodmas2ONEijs/l13jg==
X-Received: by 2002:a05:6830:20c4:b0:66c:4f82:b83c with SMTP id z4-20020a05683020c400b0066c4f82b83cmr38750946otq.7.1673357371404;
        Tue, 10 Jan 2023 05:29:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y18-20020a0568302a1200b0066f7e1188f0sm6053005otu.68.2023.01.10.05.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:29:31 -0800 (PST)
Received: (nullmailer pid 1984996 invoked by uid 1000);
        Tue, 10 Jan 2023 13:29:30 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jim Liu <jim.t90615@gmail.com>
Cc:     linux-gpio@vger.kernel.org, JJLIU0@nuvoton.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, KWLIU@nuvoton.com,
        openbmc@lists.ozlabs.org, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20230110083238.19230-4-jim.t90615@gmail.com>
References: <20230110083238.19230-1-jim.t90615@gmail.com>
 <20230110083238.19230-4-jim.t90615@gmail.com>
Message-Id: <167335661623.1967925.9927691364268671668.robh@kernel.org>
Subject: Re: [PATCH v4 3/3] dt-bindings: gpio: add NPCM sgpio driver bindings
Date:   Tue, 10 Jan 2023 07:29:30 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jan 2023 16:32:38 +0800, Jim Liu wrote:
> Add dt-bindings document for the Nuvoton NPCM7xx and NPCM8xx sgpio driver
> 
> Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> ---
> Changes for v4:
>    - modify in/out property
>    - modify bus-frequency property
> Changes for v3:
>    - modify description
>    - modify in/out property name
> Changes for v2:
>    - modify description
> ---
>  .../bindings/gpio/nuvoton,sgpio.yaml          | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,input-ngpios: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,input-ngpios: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,input-ngpios: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,output-ngpios: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,output-ngpios: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,output-ngpios: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230110083238.19230-4-jim.t90615@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

