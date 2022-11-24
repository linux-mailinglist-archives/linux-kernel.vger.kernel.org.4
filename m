Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90961637E62
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKXRj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKXRj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:39:28 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479A1369DD;
        Thu, 24 Nov 2022 09:39:27 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id x16so1039703ilm.5;
        Thu, 24 Nov 2022 09:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GUtAsbJjtVstvd/b0ZGms/6XAruxEAzhFNxybJwuAKI=;
        b=rAuhIQia1tqB4UtNqREwH5oeDzJfxgTT9xW0luyAxfNlV4/2lXREVJl8ut+HaKQiBd
         Vv8QHIcbPpSaNXQnJH7YnftVbZiHijzHCX2Pc9u4cU0BRCqRPuW54YFUOZt5pEQzUbnI
         8mKhf/0qTARMWLH01HSylNPegA3C21CyMEROTYgPPbOAMvThN6aYmko4y/wmI2FnIoto
         Oq5zPb6XLcXFRY4Yd9u587wnl0JKOoYysifVhwUaShRJOMVPkvBF19c2Vd7WOi/xNkqZ
         QAqJJb73RdRX+pC/13hZUdQlM9Ys8JzeJbK+ByzIhi2e0/R9T6HJhguSbj4+E2UqnYma
         Usow==
X-Gm-Message-State: ANoB5pkILVD94HWkPYm+Ik6MzZY9GQ84KeTsiv7Gw+gonqEUAiH06rIX
        4j7AE5KccBjDw/mHp41BJw==
X-Google-Smtp-Source: AA0mqf5LnzuB0Q7FUVU6kDolp5fz6a9D/ptnXBsEj4VJRjUHp9cPfRVI5EbQBTT+LdQ+G2TVumuDcw==
X-Received: by 2002:a05:6e02:1d17:b0:302:9392:5a01 with SMTP id i23-20020a056e021d1700b0030293925a01mr6314525ila.268.1669311566801;
        Thu, 24 Nov 2022 09:39:26 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s193-20020a0251ca000000b00375b5370314sm617539jaa.62.2022.11.24.09.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:39:26 -0800 (PST)
Received: (nullmailer pid 4182339 invoked by uid 1000);
        Thu, 24 Nov 2022 17:39:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     dianders@chromium.org, dmitry.baryshkov@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, david@ixit.cz, daniel@ffwll.ch,
        devicetree@vger.kernel.org, sean@poorly.run, agross@kernel.org,
        airlied@gmail.com, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, robdclark@gmail.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, andersson@kernel.org,
        quic_abhinavk@quicinc.com, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org
In-Reply-To: <20221124004801.361232-5-bryan.odonoghue@linaro.org>
References: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
 <20221124004801.361232-5-bryan.odonoghue@linaro.org>
Message-Id: <166930149919.3946571.17568259975526028936.robh@kernel.org>
Subject: Re: [PATCH v3 04/18] dt-bindings: msm: dsi-controller-main: Add
 compatible strings for every current SoC
Date:   Thu, 24 Nov 2022 11:39:27 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2022 00:47:47 +0000, Bryan O'Donoghue wrote:
> Currently we do not differentiate between the various users of the
> qcom,mdss-dsi-ctrl. The driver is flexible enough to operate from one
> compatible string but, the hardware does have some significant differences
> in the number of clocks.
> 
> To facilitate documenting the clocks add the following compatible strings
> 
> - qcom,apq8064-dsi-ctrl
> - qcom,msm8916-dsi-ctrl
> - qcom,msm8974-dsi-ctrl
> - qcom,msm8996-dsi-ctrl
> - qcom,sc7180-dsi-ctrl
> - qcom,sc7280-dsi-ctrl
> - qcom,sdm630-dsi-ctrl
> - qcom,sdm660-dsi-ctrl
> - qcom,sdm845-dsi-ctrl
> - qcom,sm8250-dsi-ctrl
> 
> Each SoC dtsi should declare "qcom,socname-dsi-ctrl", "qcom,mdss-dsi-ctrl";
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../display/msm/dsi-controller-main.yaml        | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.example.dtb: dsi@ae94000: compatible:0: 'qcom,mdss-dsi-ctrl' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm630-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm8250-dsi-ctrl']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.example.dtb: dsi@ae94000: compatible: ['qcom,mdss-dsi-ctrl'] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221124004801.361232-5-bryan.odonoghue@linaro.org

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

