Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC1C665126
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 02:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjAKBfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 20:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjAKBe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 20:34:59 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090D3D8C;
        Tue, 10 Jan 2023 17:34:58 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id q20-20020a4a3314000000b004f2177e6b38so746752ooq.3;
        Tue, 10 Jan 2023 17:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+bGxsqXp9QRg1WP9+JgfhsxrxUMgKueBuLUDUsQvow4=;
        b=mspRrPW4f2aMXe2dMcExY4TRe4Xme6sH6uJ7PrEfjZh8WSO6KDif3hU1Igy5HYAPJF
         B234D7RRpXqC8GVw8J0nND7Z1wCbrW+kPmCLn7mFTcIirPUuuYQLxNFXPO/r2xVTPuz4
         5Xd4nr1EPjXKIFkLAFNdgjWcfqKnxA2BCX4fj71YrFJMkmEO1Be8aL5qh9xs1kFNE11O
         acRXfr0RKIEVbXUCtEoWV15JJfMQYHJCuF4/q0P8Uri+BpWZDSzNnKDu27GBQeNdNxad
         2ajIj7D7HiCJlnlkES8tMsDzkvTuqjABsCW3dMnXquBFUyP4yrsc7MSj2cjGeuM4BIKQ
         4i4g==
X-Gm-Message-State: AFqh2kqnDeTSOj/e1tKBqmdhhcw7iuR+TbYPwtnAbBYsnZB+NWwJGKU7
        cYGOBN0JwoqsFpKUVoC+5w==
X-Google-Smtp-Source: AMrXdXszeRQ9+HsqYlG00B7ojUFlF74VNi7+aTHjFGuLt7TAkHB+QXEBoWCcejCQimTSLn7z32LzxQ==
X-Received: by 2002:a4a:ac0c:0:b0:4e7:128c:f195 with SMTP id p12-20020a4aac0c000000b004e7128cf195mr19374010oon.8.1673400897206;
        Tue, 10 Jan 2023 17:34:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q187-20020a4a4bc4000000b004a3c359fdaesm6437668ooa.30.2023.01.10.17.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 17:34:56 -0800 (PST)
Received: (nullmailer pid 3441155 invoked by uid 1000);
        Wed, 11 Jan 2023 01:34:56 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hvilleneuve@dimonoff.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        lars@metafoo.de
In-Reply-To: <20230110160124.3853593-3-hugo@hugovil.com>
References: <20230110160124.3853593-1-hugo@hugovil.com>
 <20230110160124.3853593-3-hugo@hugovil.com>
Message-Id: <167340066186.3433002.1362198141589296440.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: add Texas Instruments ADS7924
Date:   Tue, 10 Jan 2023 19:34:56 -0600
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


On Tue, 10 Jan 2023 11:01:24 -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add device tree bindings document for the Texas Instruments ADS7924
> ADC.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../bindings/iio/adc/ti,ads7924.yaml          | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
Error: Documentation/devicetree/bindings/iio/adc/ti,ads7924.example.dts:29.40-41 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/iio/adc/ti,ads7924.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230110160124.3853593-3-hugo@hugovil.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

