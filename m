Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D36F665127
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 02:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjAKBfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 20:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjAKBfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 20:35:00 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BF2643F;
        Tue, 10 Jan 2023 17:34:59 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-15085b8a2f7so14109479fac.2;
        Tue, 10 Jan 2023 17:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AZ8qZH8g2P/GvUCukVOBByRWsKJyz8oeDnn8zouTKWQ=;
        b=HN0zENtLb78Y0NRXrOHHlC8R1rCeG669Y7PT6WR59/BeIndBRkz4DvqewhkRF1OhtK
         xvVRsDPa5WGdfzgXtzgCsSRKlInQrY6i5uNmbaTNcm2+hRpQBuvlO1c7v0fTqlovrXWR
         Ms4ksUpRlT5EFuuqFKfDhqECLFoXh8Qr6hTA7ZImTV/k2kaV5/Z4K7EfHA+sHeNTo6m4
         0jXA+/ubeYWmo4sJuOQ39HlPKUYAfHoILxq5Am2LwJ1bXI9oXM+/eRVKDOiARydqH3y6
         K2IIButylP69I6uq8CQnhTALh4nBo0fq6rNXgoQIdLWPs5gVcvPBNLSLKsrrpwzzCQXt
         t4Yw==
X-Gm-Message-State: AFqh2kr2kvz7AR7aWrC0tr59O8zhS3XEqW7G2cm1RsG0FpqSrz543N8/
        oh9ivpIuir7SQiPIaIyzpHizxFWuDA==
X-Google-Smtp-Source: AMrXdXvqILYWghRppCgFmNY+vFQzDVnby7uXqaQy6S+JG3SPnNRgPdF7gs4P6cAl6PiURbO+smZLgQ==
X-Received: by 2002:a05:6870:b304:b0:15b:95f2:6d34 with SMTP id a4-20020a056870b30400b0015b95f26d34mr2411613oao.28.1673400898475;
        Tue, 10 Jan 2023 17:34:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id em33-20020a0568705ba100b0014fd7e7c3fesm6581572oab.27.2023.01.10.17.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 17:34:58 -0800 (PST)
Received: (nullmailer pid 3441158 invoked by uid 1000);
        Wed, 11 Jan 2023 01:34:56 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     marijn.suijten@somainline.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        krzysztof.kozlowski@linaro.org,
        angelogioacchino.delregno@collabora.com, agross@kernel.org,
        andersson@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230110175605.1240188-2-konrad.dybcio@linaro.org>
References: <20230110175605.1240188-1-konrad.dybcio@linaro.org>
 <20230110175605.1240188-2-konrad.dybcio@linaro.org>
Message-Id: <167340066308.3433046.8913949739772474512.robh@kernel.org>
Subject: Re: [PATCH v8 1/5] dt-bindings: soc: qcom: cpr3: Add bindings for CPR3 driver
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


On Tue, 10 Jan 2023 18:56:01 +0100, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Add the bindings for the CPR3 driver to the documentation.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Konrad: Add type reference to acc-syscon; update AGdR's email]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,cpr3.yaml          | 242 ++++++++++++++++++
>  1 file changed, 242 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dtb: opp-table-cprh: opp3:qcom,opp-fuse-level:0: [2, 3] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230110175605.1240188-2-konrad.dybcio@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

