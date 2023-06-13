Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1393172E122
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbjFMLUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242412AbjFMLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:19:48 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C7F19B4;
        Tue, 13 Jun 2023 04:19:17 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-33d31ab00bdso24016555ab.3;
        Tue, 13 Jun 2023 04:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686655157; x=1689247157;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l6vFff+2O0ZgrvplVlGvI7/ixX1GTP1MycGW4svvrIs=;
        b=fDXUdfwo+PeRK6TKWGKFCrrgi2lztU15o+sA+gH637I1IC4Nlx1uD/3bdzU/VOsti+
         8af2++p7KhFc+OaxQrhj1RJ6SWtZQZPMCJnOWb3jfxuhFI9QM2F3lir4lMvQ11QmmCX+
         kLuRSw30KbBAOsQIv+MV30CTAyq5VijLGrztjpxLLWGeBwh/UVHtfKe+80qYFKbJZ7jg
         IAk2+4XYR/fSNLy6IrDwIhpjiAdxsIdQzB16OQIEflxavciF/bodH+HJnaUsboobcwYh
         REgCTvPjvprDmAb1wcouTS0/PAN2bBaYY6L6lOVoqPgPI8i6SeNTpRWp8rh5bh5wSVL1
         q2Gw==
X-Gm-Message-State: AC+VfDwzStEn+gfxWQie8DAtp8waDiFt4x8wNEN8rvI0q78DDN8hCt8N
        cSH37DOSHBay9kFEg2mruBOc+YIMSQ==
X-Google-Smtp-Source: ACHHUZ59xiR9R2NKhafW3rpWqGOsp6pmynnDq12g2a9Fg1ntHa3HyOOllfKGHp6XtqXTZsDN+QGUNA==
X-Received: by 2002:a05:6e02:4c3:b0:335:8dd:cf16 with SMTP id f3-20020a056e0204c300b0033508ddcf16mr8842321ils.9.1686655156973;
        Tue, 13 Jun 2023 04:19:16 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i8-20020a056e02054800b003248469e5easm3771627ils.43.2023.06.13.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 04:19:16 -0700 (PDT)
Received: (nullmailer pid 1407254 invoked by uid 1000);
        Tue, 13 Jun 2023 11:19:14 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org, jic23@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        mazziesaccount@gmail.com, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0d6051ad217f91c7de0883c4ca1516bdacc343ce.1686651032.git.mehdi.djait.k@gmail.com>
References: <cover.1686651032.git.mehdi.djait.k@gmail.com>
 <0d6051ad217f91c7de0883c4ca1516bdacc343ce.1686651032.git.mehdi.djait.k@gmail.com>
Message-Id: <168665515466.1407218.12335518729776515932.robh@kernel.org>
Subject: Re: [PATCH v6 1/7] dt-bindings: iio: Add KX132-1211 accelerometer
Date:   Tue, 13 Jun 2023 05:19:14 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Jun 2023 12:22:34 +0200, Mehdi Djait wrote:
> Extend the kionix,kx022a.yaml file to support the kx132-1211 device
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
> v6:
> v5:
> v4:
> v3:
> - no changes
> 
> v2:
> - made the device name more specific from "kx132" to "kx132-1211"
> - removed the output data-rates mentioned and replaced them with "variable
> output data-rates"
> 
>  .../devicetree/bindings/iio/accel/kionix,kx022a.yaml | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml: $defs:qcom-pmic-mpp-state:properties:qcom,paired: [{'description': 'Indicates that the pin should be operating in paired mode.'}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/0d6051ad217f91c7de0883c4ca1516bdacc343ce.1686651032.git.mehdi.djait.k@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

