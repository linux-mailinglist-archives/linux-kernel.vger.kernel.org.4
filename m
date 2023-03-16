Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A917C6BD17E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCPNxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCPNxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:53:42 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13A0166D0;
        Thu, 16 Mar 2023 06:53:39 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id t129so796685iof.12;
        Thu, 16 Mar 2023 06:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974819;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mUdpbi5TGJoaUXHkv97gIa7NonUCQAJZsK/HjadTtxE=;
        b=44LZq5r8ideSKcJ3Hns8mVcwNb279O0bY/u82qd83ZSk4PlL1Rvyn8o4V/075x66DS
         4AtyK07RukpMcCTtN0xlCJZ8DTv78IBEjis+tvGRooqY1WSfimCQytvxlCpMOqsYyf7t
         xZHGZ3q0YaW/FyKEDGypFTKVM1K48SFhHZXsITWr3m9edb4cWLNyHtpScAigtYsDTfg8
         Gt2D0p5E+cQy87wGFcZ0BfTcM8pkZqQsg+SALr+CmgVBvD8FENUDMDt772sI6x0QvmZA
         61bTww4DMePyEzd0xsOWch0LLK/1CComU2rb1WMxWy1FxksG3w8GZ8qVqJ1/dEwQG9/N
         maDw==
X-Gm-Message-State: AO0yUKWuw9+DF2GQAZ8lZcBj85RwG55UWsHb9KRik1+Ej+W3u10TfXmX
        pYAKfqhcBaYW7iHOewmaLOq3cSeIEg==
X-Google-Smtp-Source: AK7set8W8UPFeVE0DXWj4IT3uiG6YG5+JfpqujbxicCe7RzbD9be9VSYYcqSzrSQFSB/MR4qFE0y2w==
X-Received: by 2002:a5d:9544:0:b0:74c:7db1:47cf with SMTP id a4-20020a5d9544000000b0074c7db147cfmr16981351ios.14.1678974818768;
        Thu, 16 Mar 2023 06:53:38 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id r23-20020a02c857000000b004061d6abcd2sm1151352jao.146.2023.03.16.06.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:53:38 -0700 (PDT)
Received: (nullmailer pid 2744948 invoked by uid 1000);
        Thu, 16 Mar 2023 13:53:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     devicetree@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        freedreno@lists.freedesktop.org
In-Reply-To: <20230307-topic-dsi_qcm-v5-1-9d4235b77f4f@linaro.org>
References: <20230307-topic-dsi_qcm-v5-0-9d4235b77f4f@linaro.org>
 <20230307-topic-dsi_qcm-v5-1-9d4235b77f4f@linaro.org>
Message-Id: <167897435368.2729763.13155358018368815833.robh@kernel.org>
Subject: Re: [PATCH v5 01/10] dt-bindings: display/msm:
 dsi-controller-main: Fix deprecated QCM2290 compatible
Date:   Thu, 16 Mar 2023 08:53:34 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Mar 2023 09:51:07 +0100, Konrad Dybcio wrote:
> The qcom, prefix was missed previously. Fix it.
> 
> Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.example.dtb: dsi@5e94000: compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,dsi-ctrl-6g-qcm2290'] is too short
	'qcom,dsi-ctrl-6g-qcm2290' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.example.dtb: dsi@5e94000: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.example.dtb: dsi@5e94000: compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,dsi-ctrl-6g-qcm2290'] is too short
	'qcom,dsi-ctrl-6g-qcm2290' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.example.dtb: dsi@5e94000: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230307-topic-dsi_qcm-v5-1-9d4235b77f4f@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

