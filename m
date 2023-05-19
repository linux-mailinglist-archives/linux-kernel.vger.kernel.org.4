Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A71709F95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjESTFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjESTFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:05:33 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02524115;
        Fri, 19 May 2023 12:05:32 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ac8ede63ccso2641543a34.2;
        Fri, 19 May 2023 12:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523132; x=1687115132;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I40vgsxqxEeuLbFdYwBEPCfpX/jxJIkwaPXV/ediegI=;
        b=N7OYhA9yXOaVr1glSocWyJamm/Ze3b/YK66xNBoHkxUoa9Fu2ufwofDU120IL3YWh0
         M9Eykeo3iDCMj/cY0O1+8gi9HRcXfZ88BLUysJweAc/wfGp6XsOmbB2R0UvHEl90tbzI
         +4lOpmCkVaMfaWaqey8jf4ayP3u1+0bqTMDDr96xoMJ4ksk5tKX8SJSYzjPt5v0kqgiR
         0LJJvqnK/j0j2wKWLndC1dtZPfzMMMSbXCBmFoj8oFDyzyEtqDi1uCuXwA+nSU4GLz8D
         iCIDBAw0NP5bP7n+yUe7Xd2Yrh0lvFgwPtTg1VnrI046kfXC8NsIJo+0VEKCWmX3dFuY
         NSqg==
X-Gm-Message-State: AC+VfDyFFXB+DPL7Ft12lPzTFoCr83UD1SOxScXZwJunUX7dlvZQA82z
        z61+/4tq3URIQbk7jKX4er47vlvXvg==
X-Google-Smtp-Source: ACHHUZ6Z7ctoE0Xg6rjUWDn3rqomNMMmXJEoVf2UiTHn5Uezqyl7vhRSGEzk/DBjyr6PSMIrc1TYBg==
X-Received: by 2002:a05:6870:36c1:b0:187:85c1:8075 with SMTP id u1-20020a05687036c100b0018785c18075mr1541235oak.15.1684523132174;
        Fri, 19 May 2023 12:05:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v1-20020a056870e28100b0018456166c7asm2259270oad.39.2023.05.19.12.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:05:31 -0700 (PDT)
Received: (nullmailer pid 3852246 invoked by uid 1000);
        Fri, 19 May 2023 19:05:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, iommu@lists.linux.dev,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v4-5-68e7e25d70e1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v4-5-68e7e25d70e1@linaro.org>
Message-Id: <168452313011.3852116.2187810600963716663.robh@kernel.org>
Subject: Re: [PATCH v4 05/12] dt-bindings: display/msm: Add SM6375 MDSS
Date:   Fri, 19 May 2023 14:05:30 -0500
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


On Fri, 19 May 2023 19:04:26 +0200, Konrad Dybcio wrote:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:0: 'bus' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:1: 'iface' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:2: 'rot' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:4: 'core' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411-topic-straitlagoon_mdss-v4-5-68e7e25d70e1@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

