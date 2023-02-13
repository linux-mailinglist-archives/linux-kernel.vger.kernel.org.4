Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2355694782
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBMN4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjBMN4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:56:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6FA59D1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:56:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bk16so12300704wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1Uy5CSnBerGct98JAqbVYGF95fZTgd+o15YjTkcuIPk=;
        b=xZJT6Spjz5YhxcyphM9ApKsAYqrAbbXecAiawIW5K2Flh9rnsQ8qDatufAylRsgoki
         ++yrs+wwnD3MuoQarcAugWmIIqSDY0AaiDd1NiQzVxNQS/sQUqFU5YrtEbaxdJQ3BS/M
         NWAxYNH73CvXqqzp5BbXuN7fHKbyy3mG9EoS3DYshvTymcoVgCNPde3dvMRuj27aLeOM
         ui6UJzcSabTiHtaRUOW/xeUoEoToFsqP5KSbTMz8hwlgyZ1nLEqOctDKSNb+Gus8KYoL
         p0SeR4LyIjc+UAmtI4TeCEfXdzdgp7f8ZrY8u2g4RHCEEqNBk6eFbYLVQIznT2pt0rVX
         RFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Uy5CSnBerGct98JAqbVYGF95fZTgd+o15YjTkcuIPk=;
        b=R/YNPQoQ8DvWO+dDDJwCKu5FjEnD3uPCZIb8EfKyg5c3bOPR+e4iOZadsNr21D5vxb
         4aHUrJ2NRdnIXmWNPzCRSaPM4y/UwbXUvyhQEsl3j5VOlCh+yGbnUbh1PxlElJj7U2hm
         79xD8yu4nVJvqVbK+t84QR1+qF8lGqqObbTMY2nn4SJCmMXzh81rp1MKQww3Y2FBOEOO
         ha0SE2gsQCF+IyB661oaGNNtt1tUsEoURXN3pdMPaiOJuA75/rZm8gYctdTqTkhGBFms
         luuBmRm9FHr6S8+UrluQArkw5tOb+2lL8d4gNfY0wkhhN8Ss7tCJqcIf3F3US2rQqdPC
         7N7w==
X-Gm-Message-State: AO0yUKVx1w4fnP4zTo6tgLVqT93BWdboEdSW5a1/noL39GhKaFCZVx6s
        ycy2rbFP0O2kEHBqox1ybzeS9A==
X-Google-Smtp-Source: AK7set+D3CHlBRertMGZvD1SZZYSxdyV0jk07kZ5xiDaPn1MIZfSnQEaX9uZIv7om6WSAzxFky7u9Q==
X-Received: by 2002:a5d:6210:0:b0:2be:c41:4758 with SMTP id y16-20020a5d6210000000b002be0c414758mr20399555wru.38.1676296567433;
        Mon, 13 Feb 2023 05:56:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:915c:811a:b081:f099? ([2a01:e0a:982:cbb0:915c:811a:b081:f099])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d6dcf000000b002c3f9404c45sm10917766wrz.7.2023.02.13.05.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 05:56:06 -0800 (PST)
Message-ID: <83603bc5-4b32-b759-5e5c-a590c2952039@linaro.org>
Date:   Mon, 13 Feb 2023 14:56:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sm8450: add dp controller
Content-Language: en-US
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
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
References: <20230206-topic-sm8450-upstream-dp-controller-v3-0-636ef9e99932@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v3-5-636ef9e99932@linaro.org>
 <347a5193-f7b1-7f8e-0c60-3d435bdf952c@linaro.org>
 <f5a26fff-2dc2-2397-a80c-2477176a5864@linaro.org>
 <880e691a-0512-6325-f27c-9be59abdd647@linaro.org>
 <b43179c4-bbf5-1d38-6ff0-8ddd0356d6d1@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <b43179c4-bbf5-1d38-6ff0-8ddd0356d6d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 13:32, neil.armstrong@linaro.org wrote:
> On 10/02/2023 16:54, Dmitry Baryshkov wrote:
>> On 10/02/2023 17:28, Neil Armstrong wrote:
>>> On 10/02/2023 16:24, Dmitry Baryshkov wrote:
>>>> On 10/02/2023 16:44, Neil Armstrong wrote:
>>>>> Add the Display Port controller subnode to the MDSS node.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 79 ++++++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 79 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> index 6caa2c8efb46..72d54beb7d7c 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> @@ -2751,6 +2751,13 @@ dpu_intf2_out: endpoint {
>>>>>                           };
>>>>>                       };
>>>>> +                    port@2 {
>>>>> +                        reg = <2>;
>>>>> +                        dpu_intf0_out: endpoint {
>>>>> +                            remote-endpoint = <&mdss_dp0_in>;
>>>>> +                        };
>>>>> +                    };
>>>>> +
>>>>>                   };
>>>>>                   mdp_opp_table: opp-table {
>>>>> @@ -2783,6 +2790,78 @@ opp-500000000 {
>>>>>                   };
>>>>>               };
>>>>> +            mdss_dp0: displayport-controller@ae90000 {
>>>>> +                compatible = "qcom,sm8350-dp";
>>>
>>> Exact, must fix.
>>>
>>>>
>>>> Missing "qcom,sm8450-dp". As I wrote in the comment to patch 1, I'd suggest having just a single entry here rather than keeping both 8350 and 8450 entries.
>>>>
>>>>> +                reg = <0 0xae90000 0 0xfc>,
>>>>> +                      <0 0xae90200 0 0xc0>,
>>>>> +                      <0 0xae90400 0 0x770>,
>>>>> +                      <0 0xae91000 0 0x98>,
>>>>> +                      <0 0xae91400 0 0x98>;
>>>>
>>>>
>>>> While this sounds correct, usually we used the even size here (0x200, 0x400, etc.). Can we please switch to it (especially since sm8350-dp uses even sizes).
>>>
>>> I don't have access to registers layout for HDK8450 but the system freezes when using even sizes, using
>>> the exact register size works fine.
>>
>> Interesting. Could you please trace, what exactly makes it fail, since specifying bigger region size should not cause such issues.
> 
> Yep I'll trace what's happening.

OK weird, I tried with the same sizes as sm8350, and it works fine.

Will resend with this fixed.

Neil

> 
> Neil
> 
>>
> 

