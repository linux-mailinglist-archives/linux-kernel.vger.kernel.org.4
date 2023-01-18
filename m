Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40AA671E43
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjARNnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjARNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:42:07 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B75611FE;
        Wed, 18 Jan 2023 05:10:58 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id g2-20020a9d6b02000000b006864bf5e658so2416838otp.1;
        Wed, 18 Jan 2023 05:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C73j249s5bhwEuVvXBUJxqTogNEcEvZ4jDs6uGdeSpI=;
        b=uEfDNwoXY2fZYfyoWhqGLHUxwCstFqXTj+cYLlPz7Bmskv/G2X61WZYzH6X2HIDLqY
         /N9mhYvpBxvwEJ5SVyGTQFaXnZPFs0zLKXR+y/sUB3F6WtVdbKRyG5CA2KW4Ov8p71P5
         N8IpCklABWYnrDb0VchxN76lMxRI+hylx1I7aWBYOckeqbEjZCH9PBLWcboQN62aQS9M
         oOHzr9aIE6LO0JIIdWNJk3ZIzu2kLbWxV5kWROD/Ll6f39VMd9QJqhhwFKC5ecDVH5Ki
         WSlidBJNt9Xl1ODhEylkCdR9sILEO2NOZPmbNhGgTTuBlOeQyOxjNee+RfLvZc6qMDnc
         Gv1Q==
X-Gm-Message-State: AFqh2kq4PtooecDE510QGQruhzMqak/Amnc75t5CvzOoSRNTJ8/iEP+a
        rqNUP+G/CNnRV3VqMT64Kg==
X-Google-Smtp-Source: AMrXdXuZ/Q1R/e+2+1EZkZ2Wjv+Jm8OHazomq5xSIF2UKkdyDtTVd2zV+xaJkBBDz4yHktrjx9hC4A==
X-Received: by 2002:a9d:4c13:0:b0:684:c595:70a6 with SMTP id l19-20020a9d4c13000000b00684c59570a6mr3544907otf.24.1674047451997;
        Wed, 18 Jan 2023 05:10:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h8-20020a056830164800b006864a6f2bfdsm2513474otr.31.2023.01.18.05.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 05:10:51 -0800 (PST)
Received: (nullmailer pid 1459892 invoked by uid 1000);
        Wed, 18 Jan 2023 13:10:47 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        devicetree@vger.kernel.org,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118063822.14521-3-okan.sahin@analog.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-3-okan.sahin@analog.com>
Message-Id: <167404705445.1390430.14924342340029865521.robh@kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: mfd: Add ADI MAX77541/MAX77540
Date:   Wed, 18 Jan 2023 07:10:47 -0600
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


On Wed, 18 Jan 2023 09:38:09 +0300, Okan Sahin wrote:
> Add ADI MAX77541/MAX77540 devicetree document.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,max77541.yaml | 87 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/adi,max77541.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/regulator/adi,max77541-regulator.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77541.example.dtb: pmic@69: regulators: False schema does not allow {'buck1': {'regulator-min-microvolt': [[500000]], 'regulator-max-microvolt': [[5200000]], 'regulator-boot-on': True, 'regulator-always-on': True}, 'buck2': {'regulator-min-microvolt': [[500000]], 'regulator-max-microvolt': [[5200000]], 'regulator-boot-on': True, 'regulator-always-on': True}}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77541.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230118063822.14521-3-okan.sahin@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

