Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F234F694A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBMPKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjBMPJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:09:53 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C885A1CF4B;
        Mon, 13 Feb 2023 07:09:49 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id u8so5280850ilq.13;
        Mon, 13 Feb 2023 07:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=izcvmEfYGF1qHX8/hJIplnh01MRs+KJ7qGdimHU+1VM=;
        b=R87qvgecQxIsujLJPGiAEGXOR1B8xww3joOKiv1pYscZBKs2izLbYZv3HF13IZS2dV
         FtmVY8Q/IKIqAm400Tmrac4XoC1B/odJAf1B9UtTiPjA2ObxHNe+02NqvCYYn1eRQE82
         6BNLwRMAeDxS81E/O0JL2bhEZ43smDmeD0qT8gtydU8Oa9bbDDpcSzD8GMRld7HEnHFb
         JU+FBwaJAYou+k8yq/E+Mebsvd5ugSrxYuNdHNNeLVALOIJEAWqOVjqOsHrg0ZyiK4Sy
         dGX5qDkMrJTU6HRbBSZjjEMa78rSCwCVZIpP0jzJNnelSPjUweALcgG+QNv9GI3Now7+
         53XA==
X-Gm-Message-State: AO0yUKX1t/AuhXJ/ySNM8cgBK0aBuxYgdRl5Y7eOj11/EbdWbNplmqAd
        7/oNH2OHhTib7C0ELgL0mg==
X-Google-Smtp-Source: AK7set/PauQ/4h5+1OHFxdgFVp3PLCj5fX29L44DbapxgCZR3zDCwMZWu/ZKbFWwXtvHlLVLC8DXEg==
X-Received: by 2002:a92:c263:0:b0:315:3948:1c5a with SMTP id h3-20020a92c263000000b0031539481c5amr5310369ild.15.1676300989045;
        Mon, 13 Feb 2023 07:09:49 -0800 (PST)
Received: from robh_at_kernel.org (c-73-14-99-67.hsd1.co.comcast.net. [73.14.99.67])
        by smtp.gmail.com with ESMTPSA id g3-20020a056e020d0300b003153787b444sm1493791ilj.21.2023.02.13.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:09:48 -0800 (PST)
Received: (nullmailer pid 11611 invoked by uid 1000);
        Mon, 13 Feb 2023 15:09:41 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     andersson@kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        krzysztof.kozlowski@linaro.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@gmail.com>, Sean Paul <sean@poorly.run>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org
In-Reply-To: <20230211122656.1479141-5-konrad.dybcio@linaro.org>
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
 <20230211122656.1479141-5-konrad.dybcio@linaro.org>
Message-Id: <167630051091.6244.17725263778561654199.robh@kernel.org>
Subject: Re: [PATCH 04/10] dt-bindings: display/msm: Add SM6375 DPU & MDSS
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


On Sat, 11 Feb 2023 13:26:50 +0100, Konrad Dybcio wrote:
> Document SM6375 DPU and MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6375-dpu.yaml | 106 +++++++++
>  .../display/msm/qcom,sm6375-mdss.yaml         | 216 ++++++++++++++++++
>  2 files changed, 322 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6375-dpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: dsi@5e94000: compatible:0: 'qcom,sm6375-dsi-ctrl' is not one of ['qcom,mdss-dsi-ctrl', 'qcom,dsi-ctrl-6g-qcm2290']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: dsi@5e94000: compatible: ['qcom,sm6375-dsi-ctrl', 'qcom,mdss-dsi-ctrl'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230211122656.1479141-5-konrad.dybcio@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

