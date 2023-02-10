Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DB46920B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjBJOUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjBJOUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:20:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6390305E5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:20:00 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ml19so16406952ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1yeTUYV9DwvmvumapxveCYKLkr4TLgt1HykRgiLQgSg=;
        b=PZD18EyHYR2HZg93WKDj6/g1Sl72V5Gg9ccQiT7XyhsvH7ZH6xBrflo9dWbWVzLNQM
         WFlCaJ61SA+fCHm9frVrgTVH9mBzLVKpy7hr8XMS81emZOkp8PBdgiKRJBYTHJv5X2RH
         yeyxQiMz0ZfBw/3YatSc1Yvrff4iDRpMhEx4VIu85HITwU0Wu+zILpGQOrBWTcwPceLB
         qjYTq/P5CEssy6TTTR0qHjeeWQfdMiK/eR+f3OYL+7HMMrXB644BEq69ikyJ0881bLM/
         ffgT2CQdWVi5HbSzIa10b5X+MXcFW/FBnXRLaKWGSx11OGtzPIhmNp2678bqHS3u2X/u
         gtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yeTUYV9DwvmvumapxveCYKLkr4TLgt1HykRgiLQgSg=;
        b=RnMfclFVZd0zleG6kbnctLg7MlG9diK9xXjSdM1B7Em55Jxm0jscsnwMvH7imPaiYA
         mpYAaghT4jC3dSKq7hjuZEPwIa8bzOTBxVGe4Q1ZsmvaHYnZi06mvhwtvgfDBKCZ2lxj
         cMzHENr1/LVru8pcqpDOCH3OoUWL5bb5Fo2MEJ46zboVcwFkfkFgYwTsdMO7S0jFO7Pd
         MzQhSCGNpIQNCiYP7n3TivjL7WJVqxz0xWDWd7OW0+YGNCV01dOIzIxIG9FV34HJf5sg
         qQM+KNv6intSlCeX+wI/IXDpo+WSIBiWdqDzvBwAaWhoQqwkiEplWouGduWvI3GdA5tO
         9fog==
X-Gm-Message-State: AO0yUKWBcP64N2hMFC36Ba6b4/rWiNgL0cxj8vAo4/wflb9R9uTss/uc
        KYQOSfu7ubwUo15sOEEP+jzqfA==
X-Google-Smtp-Source: AK7set+NpQMZbv5ZXwmnSHxh8Yc3tiwUG09wLMeLAvVpFA5+yXPGm2Glt6S1EsUDBk30Kyow7w+/3A==
X-Received: by 2002:a17:906:6a20:b0:8af:33f8:dcb3 with SMTP id qw32-20020a1709066a2000b008af33f8dcb3mr8466028ejc.57.1676038799317;
        Fri, 10 Feb 2023 06:19:59 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c18-20020a17090618b200b0088452ca0666sm2410748ejf.196.2023.02.10.06.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 06:19:58 -0800 (PST)
Message-ID: <97d75a6d-0b75-f0c2-1327-ceece0e4a17a@linaro.org>
Date:   Fri, 10 Feb 2023 16:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: sm8350: add dp controller
Content-Language: en-GB
To:     neil.armstrong@linaro.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v2-0-529da2203659@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v2-3-529da2203659@linaro.org>
 <df068428-c086-4f6a-3cda-9ef6ce665f13@linaro.org>
 <37d23af4-7920-055f-76b0-87ad907896e2@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <37d23af4-7920-055f-76b0-87ad907896e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 16:18, Neil Armstrong wrote:
> On 10/02/2023 12:08, Dmitry Baryshkov wrote:
>> On 10/02/2023 12:34, Neil Armstrong wrote:
>>> Add the Display Port controller subnode to the MDSS node.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 82 
>>> +++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 80 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi 
>>> b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> index d490ce84a022..eb636b7dffa7 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> @@ -2862,13 +2862,20 @@ ports {
>>>                       port@0 {
>>>                           reg = <0>;
>>> -                        dpu_intf1_out: endpoint {
>>> -                            remote-endpoint = <&mdss_dsi0_in>;
>>> +                        dpu_intf0_out: endpoint {
>>> +                            remote-endpoint = <&mdss_dp_in>;
>>
>> No need to reorder these ports. Please add DP to the end.
> 
> Right, but I'll keep the dpu_intf0_out label for this port,
> but having dpu_intf1_out, dpu_intf2_out then dpu_intf0_out isn't very 
> clean...

I don't have a strong opinion here. I think we can ignore it.

-- 
With best wishes
Dmitry

