Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F06D6EAB10
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjDUM40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjDUM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:56:23 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8304E3590;
        Fri, 21 Apr 2023 05:56:22 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6a5f852002dso1476445a34.3;
        Fri, 21 Apr 2023 05:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682081782; x=1684673782;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+A06kpmrD5z/vN43BJmKhUaZZmJWsA7CwJDf7K7zAkg=;
        b=BD+tItU+ce2MAv30+aof/i+S6avIsb5fxbtz2J02HnBDkPLDk4XZQ0D9pKv0Z4oMIK
         au0mNBUL4EmFEQqqLHE5h/rWO3L0J2Oq8f42lJBnpwGz19t7xQk7VCRX4rlLaX2DFRo4
         iOWOyt1pmUKlNjmg/tkFcXUeL+r9rVxMvgKF1/YXeIDQP0GQFoMqGUqkQ0ljFTzr8pp7
         NWgjmHTTNQbWh1kbQAQZp3lRf/5KK4lOuj2IbX+HKROsgdYnuY1dauPCaA6FkKFkMHYv
         ccfKtKZiZZ/ycpeBCTKuINPqgnE1WLAhe6bAOiFFDC3jE3CA41sc44kdIRyYNKJL5zlC
         uFFQ==
X-Gm-Message-State: AAQBX9dmbEaB8x/NCgVgEl26NEtta/MaHGV0xSMWyzMM5y1Q9UHRJS+K
        WnpFW3lfT4ZFem2clu0HuQ==
X-Google-Smtp-Source: AKy350aR7331j/a1WuGroFxPO7pFFI40xAUAXj+w2kzgIRYKHNCE27a26aL7XWes9HeOhxO4qs997w==
X-Received: by 2002:a9d:7658:0:b0:6a6:1a1a:93cc with SMTP id o24-20020a9d7658000000b006a61a1a93ccmr2408172otl.20.1682081781702;
        Fri, 21 Apr 2023 05:56:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o21-20020a9d7655000000b006a30260ccfdsm1764043otl.11.2023.04.21.05.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 05:56:21 -0700 (PDT)
Received: (nullmailer pid 936705 invoked by uid 1000);
        Fri, 21 Apr 2023 12:56:18 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        freedreno@lists.freedesktop.org,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-6-5def73f50980@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-6-5def73f50980@linaro.org>
Message-Id: <168208107915.922496.9974189012078616834.robh@kernel.org>
Subject: Re: [PATCH v2 06/13] dt-bindings: display/msm: Add SM6375 MDSS
Date:   Fri, 21 Apr 2023 07:56:18 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Apr 2023 00:31:15 +0200, Konrad Dybcio wrote:
> Document the SM6375 MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
>  1 file changed, 216 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: dsi@5e94000: compatible: 'oneOf' conditional failed, one must be fixed:
	'qcom,sm6375-dsi-ctrl' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl']
	'qcom,sm6375-dsi-ctrl' is not one of ['dsi-ctrl-6g-qcm2290']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: dsi@5e94000: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411-topic-straitlagoon_mdss-v2-6-5def73f50980@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

