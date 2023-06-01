Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6F9718F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjFAAMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 20:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFAAMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:12:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14470125
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 17:12:14 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af28303127so3106251fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 17:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685578332; x=1688170332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7T1vQLhafRXv2sTtT7nV+m/Jovj7sxrilRtgeaU+FY=;
        b=ImVXrIDOKR8zrCch+QSZ6Jdduw466FAzE1+3vOJR4GPxEj8KLqobn1tKQ2jMUzEoGW
         EB708puCAnsql2Kwg8U8rPklHjGTr7cWjfmTKKdS9VaSbq1UrV0eZvPaxSL+XSR1i9En
         axPiAghZQ/x1AW+RUx6Io6Im4caKAshF/pFSjoWdWXTixjFr2XdkMtX6ZQHbq4koO1mf
         rdo/eBATkHqqYoWgBp0P2bqATkvvstpBVTCXmEl2hH6JarSvYlIKyUKCEKu/4+Mevh7h
         CeHt0dhUusYeRa9y4EYv//+/NUzleot8wtZZqD5r/shy4hzp2Yye1T35F9ewFlpLccQf
         +JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685578332; x=1688170332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7T1vQLhafRXv2sTtT7nV+m/Jovj7sxrilRtgeaU+FY=;
        b=VkeP/5kpID9VBrAmfLyrh6h3Y3XGHEYBcOPFOnaWK8knEwmACrcs4yUJFMaPZ0y+IO
         L7yH2e/yRyUVmJL6TGCylMXGYpSACSF2GUHpeT5yBRu5nCD/acBJL/o0OG5wB+vKf1B9
         ZBbn9LeHcUT0qcsy5b7DNnSb3fMQqv41xUeFCaCj6bEDnbQrY1l0kdXd0zADhqSaw6bt
         5zsiYB24DSf52GrqBM4eodB/S7/dSMcCRqV/Q2fL+1e1WUR1yAk/ooongGXdRows78Ba
         K2TVjZLYEH2fsKcuSCmsXesd9f5HVSmGKjClMGgLjNN/SAHPhHQUnRh62+WN1YAkJkM2
         kzXg==
X-Gm-Message-State: AC+VfDwQO/khgovZp/47RMttYJRXAgdV8IQljhTnr92L3EzovdzFkSmh
        6cz7wS9+6A7jRZCOpXtY35lS0w==
X-Google-Smtp-Source: ACHHUZ4qG8Zz/GUwecKRtqQDhgDCfm8yOjOJrKw62X98fssdfeGlFoUfi4LWrBhB3CJRUM46N+eWtw==
X-Received: by 2002:a2e:a305:0:b0:2af:228a:8670 with SMTP id l5-20020a2ea305000000b002af228a8670mr3529179lje.2.1685578332280;
        Wed, 31 May 2023 17:12:12 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x13-20020a05651c104d00b002add1f4a92asm3532537ljm.113.2023.05.31.17.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 17:12:11 -0700 (PDT)
Message-ID: <247f6b45-a730-4259-9576-a0b63af24d34@linaro.org>
Date:   Thu, 1 Jun 2023 03:12:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 04/12] dt-bindings: display/msm: Add SM6350 MDSS
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        David Airlie <airlied@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Sean Paul <sean@poorly.run>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-arm-kernel@lists.infradead.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v5-4-998b4d2f7dd1@linaro.org>
 <168483089214.140382.17835176497108911988.robh@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <168483089214.140382.17835176497108911988.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 11:34, Rob Herring wrote:
> 
> On Tue, 23 May 2023 09:46:15 +0200, Konrad Dybcio wrote:
>> Document the SM6350 MDSS.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   .../bindings/display/msm/qcom,sm6350-mdss.yaml     | 214 +++++++++++++++++++++
>>   1 file changed, 214 insertions(+)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.example.dtb: dsi@ae94000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['qcom,sm6350-dsi-ctrl', 'qcom,mdss-dsi-ctrl'] is too long
> 	'qcom,sm6350-dsi-ctrl' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm6115-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl']
> 	'qcom,sm6350-dsi-ctrl' is not one of ['qcom,dsi-ctrl-6g-qcm2290', 'qcom,mdss-dsi-ctrl']
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.example.dtb: dsi@ae94000: Unevaluated properties are not allowed ('compatible' was unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml

It looks as if the patches 1 & 2 were not applied when testing this 
patch. I can not reproduce this issue locally. Could you please 
doublecheck it?

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411-topic-straitlagoon_mdss-v5-4-998b4d2f7dd1@linaro.org
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

-- 
With best wishes
Dmitry

