Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3578F6060B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJTM41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJTM4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:56:24 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B0C143A58;
        Thu, 20 Oct 2022 05:56:23 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id y72so22748065oia.3;
        Thu, 20 Oct 2022 05:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+oTd/mCAc9rHiVxX6LMM1ilKK5nolYQ0/R9nLcKiZg=;
        b=wSJANCiukQiAzjTLr2ckqf8oWbN/WeN9L3GORQLe8stkbW7ph15ExZMjaQejQdObIf
         IIBbdN/SwNWs6phJhkBC1BwkmpMVIqG+PS69h6DxCu/r4jU8hQIFnGwGWg7+TpzJjARt
         zNm36GHseKBai0RVr8UpLr1BH8S6xWU3pLbaaPyHVO5FQvCx64t9rn6blQYZgQD0TPIx
         kg8jcGVpoQHkgxuNtbCdeY064VyHp71iv853uptYXNGChkawV7odBj52wnPsTlffhvGp
         +k2m77b26CNBVo+R6RolHdXPKEKZ8rhVzrVAPIrv/7vzEA6ogGhxpZii/2KH1bNhQKlZ
         eRtA==
X-Gm-Message-State: ACrzQf2pN5ckrnWDGWzIOCiZTAF5YjJDNnpIbLJ1SC/vzRlME5wAUZxl
        2HzMd746ms4A4i49YhR1GH7TBBG/Qg==
X-Google-Smtp-Source: AMsMyM53EIlej7wyTgu+ZyVv6pofUu9es2O1fZp/sq0pnlM7atRmQSy/1MXky98/LAspLDGWIsmXLA==
X-Received: by 2002:a05:6808:141:b0:354:9436:2e53 with SMTP id h1-20020a056808014100b0035494362e53mr7168830oie.219.1666270582152;
        Thu, 20 Oct 2022 05:56:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x9-20020a9d5889000000b00661b9421daesm7936626otg.69.2022.10.20.05.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:56:21 -0700 (PDT)
Received: (nullmailer pid 1111918 invoked by uid 1000);
        Thu, 20 Oct 2022 12:56:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
In-Reply-To: <20221020090257.1717053-4-demonsingur@gmail.com>
References: <20221020090257.1717053-1-demonsingur@gmail.com> <20221020090257.1717053-4-demonsingur@gmail.com>
Message-Id: <166626973810.1095953.8246323688783292812.robh@kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: temperature: ltc2983: refine
Date:   Thu, 20 Oct 2022 07:56:23 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 12:02:55 +0300, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
>  * make sure addresses are represented as hex
>  * add note about wrong unit value for adi,mux-delay-config-us
>  * simplify descriptions
>  * add descriptions for the items of custom sensor tables
>  * add default property values where applicable
>  * use conditionals to extend minimum reg value
>    for single ended sensors
>  * remove " around phandle schema $ref
>  * remove label from example and use generic temperature
>    sensor name
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 309 +++++++++++-------
>  1 file changed, 182 insertions(+), 127 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: patternProperties:^diode@:allOf:0:if:properties:adi,single-ended:const: True is not of type 'integer', 'string'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: patternProperties:^thermocouple@:allOf:0:if:properties:adi,single-ended:const: True is not of type 'integer', 'string'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: patternProperties:^adc@:allOf:0:if:properties:adi,single-ended:const: True is not of type 'integer', 'string'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: patternProperties:^thermistor@:allOf:0:if:properties:adi,single-ended:const: True is not of type 'integer', 'string'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

