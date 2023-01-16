Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C2B66C978
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjAPQt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjAPQtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:49:32 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A60E2B2A7;
        Mon, 16 Jan 2023 08:36:18 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id d188so12670889oia.3;
        Mon, 16 Jan 2023 08:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1mnVLUqXMbam/ql0ZAT00mPh8Q7RxTd9GmFpYmAkm4=;
        b=XSJqEc63ecqvcqjhv+Bt/0sAK/IU+YpWj5q70To1QqunvOyD6C7hsBt/smAIc7QtwS
         snrM5vD1ij/W4QeFLFDqmxqpk47CBL8PbXASOnLcMcMA0+uh0p9fUeggR6SJEYR6wsqP
         A5zb767LWXO5K4L7rIvPoO9LjFRoou6hS3QyhTou7tQp1FX5Y1B7Jd8zUqs8JLUZErHQ
         eSWejB1zwTNF/SbnApXWKLfCXx0aeVDRM8I9ZiaRuLxVNDU4yi4TZpTX0O1lptvzuoGq
         52AXoZD4RbkFo6vJ+QZQVo5ghj2t92p6Gpxs5CNRobqdWOEP9eF1tWDnKzJDl8SmdnVv
         1I0g==
X-Gm-Message-State: AFqh2koX6/WtvYx4PfUQNhWCuLwqir5efKVl6jl6HjgCBiI4AjG6Flag
        S5cZyDN5b1JniSPLcJDESCj/RcUWvg==
X-Google-Smtp-Source: AMrXdXs3Hr51eTOi/MRFOAQNqOWjNSAoz2ZaZH/Mx8uM+O8E+kql8IwC4IZsTNPAH9WZrLwUr6BU8g==
X-Received: by 2002:a05:6808:124c:b0:364:3de0:f92f with SMTP id o12-20020a056808124c00b003643de0f92fmr17757691oiv.19.1673886977885;
        Mon, 16 Jan 2023 08:36:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t11-20020a9d590b000000b00677714a440fsm14931184oth.81.2023.01.16.08.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:36:17 -0800 (PST)
Received: (nullmailer pid 606184 invoked by uid 1000);
        Mon, 16 Jan 2023 16:36:12 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, andersson@kernel.org,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230116093845.72621-3-konrad.dybcio@linaro.org>
References: <20230116093845.72621-1-konrad.dybcio@linaro.org>
 <20230116093845.72621-3-konrad.dybcio@linaro.org>
Message-Id: <167388663828.594146.5142968901472742042.robh@kernel.org>
Subject: Re: [PATCH v9 2/6] dt-bindings: soc: qcom: cpr3: Add bindings for CPR3 driver
Date:   Mon, 16 Jan 2023 10:36:12 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Jan 2023 10:38:41 +0100, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Add the bindings for the CPR3 driver to the documentation.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Konrad: Make binding check pass; update AGdR's email]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,cpr3.yaml          | 314 ++++++++++++++++++
>  1 file changed, 314 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dtb: opp-table-cprh: opp-1: 'qcom,opp-cloop-vadj', 'qcom,opp-oloop-vadj' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dtb: opp-table-cprh: opp-2: 'qcom,opp-cloop-vadj', 'qcom,opp-oloop-vadj' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dtb: opp-table-cprh: opp-3: 'qcom,opp-cloop-vadj', 'qcom,opp-oloop-vadj' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.example.dtb: opp-table-cprh: opp-3:qcom,opp-fuse-level:0: [2, 3] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230116093845.72621-3-konrad.dybcio@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

