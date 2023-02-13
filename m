Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CA9694A64
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjBMPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBMPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:09:46 -0500
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA624232;
        Mon, 13 Feb 2023 07:09:44 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id a5so5298305ilk.6;
        Mon, 13 Feb 2023 07:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ogFsLNQEFVm7C6QvQZMbka0qqj2F6J8HwmRYO32/VOg=;
        b=nN1WVzTtidMaq8VLcja7o2Xw2hyq7nTZPj/f0fsqFl0aEdPua8dnM4Bv+msUbcr1Mn
         DQF1rR9zPusGiQ6fGa3iYss0Mn2Y91yZlvX/Bj58Wl7FUNfcFP+VzrIxgT1eS2WIDiI4
         KMAaTjO3avtjgklRfT1SFlOSoQpzcBXDUnlrlBJ6eBLS13yUMLCkgDqqw5q3CbBP1zeS
         kEEsYPqXdwl6MaxkvaC5/wjER403UrkbHfJ3Fag5YZp4xHzv8SeYqZqzLD/Hy57G4xTD
         noqSmHRRi3Ex8QX7GawtYSqHKhELhKEflwx1OFpAgfD4EzGAn2ZqADM1TvcpO6kmRUWA
         NAyg==
X-Gm-Message-State: AO0yUKWYz3YJC4TNRki46fWC9EEpXdYflB28jP/mPQG+H0N3LC630KEi
        NN2ZIAmFV2z7z7JPV53hcQ==
X-Google-Smtp-Source: AK7set9DOOH8pVq0q18oUvyYwV+s2TWpICsRn/3fLBdCPEA0O6cjKYg+qIAzs4dUab0rq9PFB6kMoQ==
X-Received: by 2002:a92:a007:0:b0:313:d914:e544 with SMTP id e7-20020a92a007000000b00313d914e544mr21549100ili.23.1676300983976;
        Mon, 13 Feb 2023 07:09:43 -0800 (PST)
Received: from robh_at_kernel.org (c-73-14-99-67.hsd1.co.comcast.net. [73.14.99.67])
        by smtp.gmail.com with ESMTPSA id g15-20020a056e021a2f00b003141eddd283sm2746676ile.22.2023.02.13.07.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:09:43 -0800 (PST)
Received: (nullmailer pid 11608 invoked by uid 1000);
        Mon, 13 Feb 2023 15:09:41 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        freedreno@lists.freedesktop.org, marijn.suijten@somainline.org,
        David Airlie <airlied@gmail.com>, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org
In-Reply-To: <20230211122656.1479141-4-konrad.dybcio@linaro.org>
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
 <20230211122656.1479141-4-konrad.dybcio@linaro.org>
Message-Id: <167630050949.6199.14243256327599171035.robh@kernel.org>
Subject: Re: [PATCH 03/10] dt-bindings: display/msm: Add SM6350 DPU & MDSS
Date:   Mon, 13 Feb 2023 09:09:41 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Feb 2023 13:26:49 +0100, Konrad Dybcio wrote:
> Document 6350 DPU and MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6350-dpu.yaml |  94 ++++++++
>  .../display/msm/qcom,sm6350-mdss.yaml         | 213 ++++++++++++++++++
>  2 files changed, 307 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6350-dpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml:55:11: [warning] wrong indentation: expected 8 but found 10 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml: patternProperties:^dsi@[0-9a-f]+$:properties:compatible: [{'const': 'qcom,sm6350-dsi-ctrl'}, {'const': 'qcom,mdss-dsi-ctrl'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml: ignoring, error in schema: patternProperties: ^dsi@[0-9a-f]+$: properties: compatible
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.example.dtb: dsi@ae94000: compatible:0: 'qcom,sm6350-dsi-ctrl' is not one of ['qcom,mdss-dsi-ctrl', 'qcom,dsi-ctrl-6g-qcm2290']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.example.dtb: dsi@ae94000: compatible: ['qcom,sm6350-dsi-ctrl', 'qcom,mdss-dsi-ctrl'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.example.dtb: phy@ae94400: 'vdds-supply' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230211122656.1479141-4-konrad.dybcio@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

