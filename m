Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFE56524D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiLTQlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLTQk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:40:59 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6504F6436;
        Tue, 20 Dec 2022 08:40:58 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id k189so11035846oif.7;
        Tue, 20 Dec 2022 08:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=chwYKrVGBIhdy9wrtIZn6F96I3NcHCo/+rJY4lOg0AQ=;
        b=I38hg+wWRrTkLVWPEfaMTa48mMZsV7vGBK5rnCvzDQVkf6/mVXunQp9rZDlBn0O2mO
         Ip9TRDvmvQFsCBfZXXct0WiOhfINI53UE6EVgskT37LauUM29kLJpEwRk0xs6LcCAGwh
         wK/W/vvp2P8rNWuRdPffKpinLe73D/M28zxaG+7mHTCU4I1Sji5YxGruR6tyfoxryzpQ
         dAnrt2HI3lZY4A8vBUGS3TEFGqhKqRBPWejo7zJ1NuB4+Eu6305S7V4PbBmukxh1x9b0
         25FuRGwfYsYHYlqK9jxCz6KwWky5TKwomxENpxRWpflvvadTYbJKyJ3N0nWef7CLMRGf
         d56Q==
X-Gm-Message-State: ANoB5pl22Rhfbzifi6+aEZFjm7/2ANTWWeQ2Sd8NgLWoz4FT6O9RoDUU
        U0IcwPBUKiD97uJaumdgGw==
X-Google-Smtp-Source: AA0mqf7b7KYOGLj9+YtsU0829OeLadtCcX/pXvT3VNyawaN69N+NwtqV18JjGGH8M2/RA52SQgfF1A==
X-Received: by 2002:a05:6808:a04:b0:35e:885e:1c53 with SMTP id n4-20020a0568080a0400b0035e885e1c53mr15580391oij.21.1671554457642;
        Tue, 20 Dec 2022 08:40:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id es10-20020a056808278a00b00359ad661d3csm5673557oib.30.2022.12.20.08.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:40:57 -0800 (PST)
Received: (nullmailer pid 709595 invoked by uid 1000);
        Tue, 20 Dec 2022 16:40:56 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Cc:     lgirdwood@gmail.com, linux-pm@vger.kernel.org, broonie@kernel.org,
        lee@kernel.org, Nurettin.Bolucu@analog.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20221220132250.19383-3-Zeynep.Arslanbenzer@analog.com>
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
 <20221220132250.19383-3-Zeynep.Arslanbenzer@analog.com>
Message-Id: <167155420720.690036.18231060148928716465.robh@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: mfd: add MAX77659 binding
Date:   Tue, 20 Dec 2022 10:40:56 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2022 16:22:46 +0300, Zeynep Arslanbenzer wrote:
> This patch adds binding document for MAX77659 MFD driver.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,max77659.yaml | 70 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77659.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/adi,max77659.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/power/supply/adi,max77659-charger.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77659.example.dtb: pmic@40: charger: False schema does not allow {'compatible': ['adi,max77659-charger'], 'adi,fast-charge-timer': [[5]], 'adi,fast-charge-microamp': [[15000]], 'adi,topoff-timer': [[30]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77659.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77659.example.dtb: pmic@40: regulator: False schema does not allow {'compatible': ['adi,max77659-regulator'], 'regulator-boot-on': True, 'regulator-always-on': True}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77659.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77659.example.dtb: pmic@40: '#interrupt-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77659.yaml
Documentation/devicetree/bindings/mfd/adi,max77659.example.dtb:0:0: /example-0/i2c/pmic@40/regulator: failed to match any schema with compatible: ['adi,max77659-regulator']
Documentation/devicetree/bindings/mfd/adi,max77659.example.dtb:0:0: /example-0/i2c/pmic@40/charger: failed to match any schema with compatible: ['adi,max77659-charger']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221220132250.19383-3-Zeynep.Arslanbenzer@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

