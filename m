Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB526362DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbiKWPHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238622AbiKWPHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:07:31 -0500
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA9AFF3;
        Wed, 23 Nov 2022 07:07:26 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id r81so13340124iod.2;
        Wed, 23 Nov 2022 07:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hLETIKJccRyPQMJ8KCnoTh6vcUSTK9D/bxKP76WIm5E=;
        b=mgxoMt7tGh7Aj1MQQa30mJyCbUxwFoH40SvD0vHDGqWcE5A1b/UHaQtZI2Mw+DDgeN
         zShVAT1g/G3duhCO6NaikbOXfSr3FJMOhVx/VGS2e31quT34KEt7kKtxVB7WKmKiJFGh
         PWqd+wwyuTIAwQ59LzMyxnkmrC1C8BwDDCJBsZF6F8WKNW+Cw8U811yXIESw9h6tfpYp
         HQzFp+4KBZrpKR+a57c6ilfVJz7DBzpoiNoslS10a5fQH6FLqHMVtB0ifeH1z1cgpeab
         pkgc/X1HHJgr/1bMps1oawLyvW1jeTcluKTtpAiQoxCMiARonEc5JaNJKorOHFHE2eek
         x+TQ==
X-Gm-Message-State: ANoB5plJ3ZgGnybWkCZ9D4Ve2WY+K4aePz+2yVRqAuAlzEyto0Nwp8Cy
        nalo4qaKRyBA9KpBTRPVZg==
X-Google-Smtp-Source: AA0mqf4SUiWT+J/qqCxyaqKJMFnZAZA1PuepXjokI4v31dpgrcg6c4htmrUB1sb3P085pAcWl8zOCg==
X-Received: by 2002:a5e:840f:0:b0:6dd:2127:50b9 with SMTP id h15-20020a5e840f000000b006dd212750b9mr5818301ioj.120.1669216046145;
        Wed, 23 Nov 2022 07:07:26 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z7-20020a05663822a700b003752e5b3c23sm6353811jas.20.2022.11.23.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:07:25 -0800 (PST)
Received: (nullmailer pid 2005411 invoked by uid 1000);
        Wed, 23 Nov 2022 15:07:21 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     robh+dt@kernel.org, lee@kernel.org, jdelvare@suse.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        corbet@lwn.net, linux-pwm@vger.kernel.org, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org, thierry.reding@gmail.com,
        linux@roeck-us.net, linux-doc@vger.kernel.org, andrew@aj.id.au,
        p.zabel@pengutronix.de
In-Reply-To: <20221123061635.32025-3-billy_tsai@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-3-billy_tsai@aspeedtech.com>
Message-Id: <166921592652.2001911.517272119608827476.robh@kernel.org>
Subject: Re: [v4 2/5] dt-bindings: pwm: Add bindings for aspeed pwm controller
Date:   Wed, 23 Nov 2022 09:07:21 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2022 14:16:32 +0800, Billy Tsai wrote:
> Add the aspeed pwm device bindings which should be the child-node of
> pwm-tach mfd.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: patternProperties:^pwm@[a-z0-9]+$:properties:aspeed,wdt-reload-duty-point: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maximum', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: patternProperties:^pwm@[a-z0-9]+$:properties:aspeed,wdt-reload-duty-point: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: patternProperties:^pwm@[a-z0-9]+$:properties:aspeed,wdt-reload-duty-point: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221123061635.32025-3-billy_tsai@aspeedtech.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

