Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0062D6C6B58
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjCWOoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjCWOo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:44:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE5E23A78
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:44:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so1356813wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679582665;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ek4wZhl4Mg0GrDMidRpjCLxiT+Jj8TNIew80B1+dS8=;
        b=t3Vp7RyFM8QV+VOhJkauXK9ZBmgTbo+zXmbbdNc5YTzFZhULmKx7ULUx2hi9UKIvj4
         yIAo+gNJ6mUmL6zRsgWruEYkTL1nqJr4XVGp9j53f1R59pcJo9BvjgV6ZGPCOWExngg3
         9lwyhlQ7PfizNhOXlnvJ2BjCjfCnW+3z+rA2W9HGw5O1aPBlgxrSE/lr6RkeFNqBSoPK
         gJ3bS3SEKIW41PNmlixE4c62EWhsHJcY3ftPuqZ/F3JOmp8dUDVFskJH15Bv/IRWLTtI
         VmGC96o6jb8k6ouaD0vV0GREdN870JpBDWppohe72sFOYfxOkxkoAarzmhvWz0vtwhhG
         l4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679582665;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ek4wZhl4Mg0GrDMidRpjCLxiT+Jj8TNIew80B1+dS8=;
        b=US8klX2t6a2XEL5HbxYFrXbzlrbdH00tJQJC5xHn6HOaEy1HoKkdF68V92uby2gSuJ
         /ZeV1GssuBs9KX0z4wo/Z5G84g8sCJGOu0N+UkuI8YuLOIRJq/0NIK9CBDiNbqm995Nc
         a8JB9L705iSvh3VtEaJy2oVzf2hiWgzLcBpo8i8XdBi0je5mLDQ6n9d9bKhoeEkaXtEo
         qUerBvl5+bUVLbwtJQcE6P4qokA9APCA9+Ad/UFClEHBcXEGDxq6MIfi2FhzZ68HgbKD
         8Zfr++W8HzLbbPFY4kItklkpl8DHm6ThfzqFRFLhsyWsHGtbQsnUaGrlTP3PWSTlifcu
         s6FA==
X-Gm-Message-State: AO0yUKWHWg5kXmJ94aPa1S3NC0M4lefg4WowEuCd7is71wO1KKF/4zNP
        ZamXrUgIqjk3NZAXSaeTPsvZOg==
X-Google-Smtp-Source: AK7set/LnBgJwUokuNj+rBAbXxBzVAIv6jLo1Im7boQzr5ZnmQ5GFZnXrwDgWbSR8lrMohjRlVuXtQ==
X-Received: by 2002:a05:600c:2c48:b0:3eb:39e0:3530 with SMTP id r8-20020a05600c2c4800b003eb39e03530mr2306311wmg.41.1679582664667;
        Thu, 23 Mar 2023 07:44:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e25a:65de:379a:3899? ([2a01:e0a:982:cbb0:e25a:65de:379a:3899])
        by smtp.gmail.com with ESMTPSA id c18-20020a7bc852000000b003ed2c0a0f37sm2045208wml.35.2023.03.23.07.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 07:44:23 -0700 (PDT)
Message-ID: <381cad84-da61-5a55-73eb-869294aa1d1c@linaro.org>
Date:   Thu, 23 Mar 2023 15:44:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/8] dt-bindings: display: msm: sm8450-mdss: Fix DSI
 compatible
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Avri Altman <avri.altman@wdc.com>, Sean Paul <sean@poorly.run>,
        freedreno@lists.freedesktop.org,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-scsi@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-0-3ead1e418fe4@linaro.org>
 <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-1-3ead1e418fe4@linaro.org>
 <167957963042.3095255.5445133387110199668.robh@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <167957963042.3095255.5445133387110199668.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 14:58, Rob Herring wrote:
> 
> On Thu, 23 Mar 2023 11:25:16 +0100, Neil Armstrong wrote:
>> The DSI compatible changed between patchset revisions, but that wasn't
>> reflected in the bindings. Fix it.
>>
>> 0eda3c6cb1c5 ("dt-bindings: display/msm: add support for the display on SM8450")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: display-subsystem@ae00000: phy@ae94400:compatible:0: 'qcom,sm8450-dsi-phy-5nm' was expected
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: display-subsystem@ae00000: phy@ae96400:compatible:0: 'qcom,sm8450-dsi-phy-5nm' was expected
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
> Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: /example-0/display-subsystem@ae00000/phy@ae94400: failed to match any schema with compatible: ['qcom,dsi-phy-5nm-8450']
> Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: /example-0/display-subsystem@ae00000/phy@ae96400: failed to match any schema with compatible: ['qcom,dsi-phy-5nm-8450']


Indeed I forgot to fix the bindings example....

Thx,
Neil

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-1-3ead1e418fe4@linaro.org
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

