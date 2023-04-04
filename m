Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457756D60E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjDDMhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbjDDMhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:37:50 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31D0359B;
        Tue,  4 Apr 2023 05:37:19 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id a30-20020a9d3e1e000000b006a13f728172so14066380otd.3;
        Tue, 04 Apr 2023 05:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680611795;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sthxn0yskywFNWI3VDHICrGnydzqyAt4ukEZpI9YRVY=;
        b=KpfoIzbqHVSVJxhVS4pwgl95fMdy9prVbjOV4wA1UWgSQbJmbFhsxcT5OpW8btIsoP
         GgibDvJK4SUYywD7xp0EJDBAaATL74C9C63lG396OwnEi+ZyX2SiG15GW5klWpAPi7o0
         NIMnhawMDj+LBxIsqBgh3ZHFRdkPqH9WV/CPaVSIKF7RXCHQPq8pxtQbhvfyF1LGZPOe
         Za8hXIEWur/98jkJ0aK7n+dF09LQzKF+XYD+8j6PVI1zeqGb+Eofg1bXFumA5UYTPna2
         dDUL60mg55zGf/vYHP+oVQnPLroyfcp1fga3rxMzmkxBZrUqBCwZBQ7GTomngH0oIZpL
         fm6w==
X-Gm-Message-State: AAQBX9fcWqN5+1NGtK9es/o9y4jRO9C4xvI17CoOelQfOLMUE0783kxA
        0ik+trtMSBtz0fH0sG1LDQ==
X-Google-Smtp-Source: AKy350a5od+yOGJ7fZfrNyJ9aNS0aN5CJ1AISlHhrlsBmEBs0Sf83Osabm/c1DsiOgDcvaitM92Wdg==
X-Received: by 2002:a05:6830:1447:b0:6a1:150e:f777 with SMTP id w7-20020a056830144700b006a1150ef777mr1476576otp.35.1680611795221;
        Tue, 04 Apr 2023 05:36:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d16-20020a056830139000b006a1394ea9f3sm5402579otq.30.2023.04.04.05.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:36:34 -0700 (PDT)
Received: (nullmailer pid 3710631 invoked by uid 1000);
        Tue, 04 Apr 2023 12:36:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andi Shyti <andi@etezian.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <20230404060011.108561-3-jaewon02.kim@samsung.com>
References: <20230404060011.108561-1-jaewon02.kim@samsung.com>
 <CGME20230404061409epcas2p36402f7a84406ba9d831dcff0ddd994e9@epcas2p3.samsung.com>
 <20230404060011.108561-3-jaewon02.kim@samsung.com>
Message-Id: <168061169110.3708482.17770599727715267512.robh@kernel.org>
Subject: Re: [PATCH 2/3] spi: dt-bindings: samsung: add samsung,spi-polling
 property
Date:   Tue, 04 Apr 2023 07:36:32 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Apr 2023 15:00:10 +0900, Jaewon Kim wrote:
> This patch adds "samsung,spi-polling" property.
> It is method to check data trans by polling when DMA is not used.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/samsung,spi.yaml: properties:samsung,spi-polling: 'oneOf' conditional failed, one must be fixed:
	Additional properties are not allowed ('default' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/samsung,spi.yaml: properties:samsung,spi-polling: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	Additional properties are not allowed ('default', 'type' were unexpected)
		hint: A vendor string property with exact values has an implicit type
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/samsung,spi.yaml: properties:samsung,spi-polling: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
./Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/spi/samsung,spi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230404060011.108561-3-jaewon02.kim@samsung.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

