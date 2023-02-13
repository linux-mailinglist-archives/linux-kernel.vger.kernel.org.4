Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B536945D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjBMMdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjBMMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:32:59 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CD330F9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:32:57 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y1so12045456wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YSNp7daxwzg9PeQCPBa7S3ruVaUwF/8x5X2sPmkYUbU=;
        b=UJ+/6SZI81VVEoKozzQ8GO9TuQJj64Lx/5i1dgvMZq4FHlNxsaXl7v2SDKZTuTap/a
         iaoA/L7ADyxppRF4ZvN5wuc9coUMPnf/w/SIfR2WqMwJbi/+uOmgWOVzUNNq41lHAprJ
         e9KWQ5LLMYAlwi/f/UdrUMsYLYLHVVdME/U6700osLFKwFk+9u+Y0Jtli20NehbMhq2m
         D2u2T8l/w30CR7IwlA4lF9TuU58WkXYuvqC/WcW9D3CwaJSg06KbpS5JhJr/1hMCJKFX
         6pFqwsTnwO6e5t2IvExKEQzpN2Jsb+Tz/yRapICQzwU6hRPeM7wGZEcfvDcvJyCAcM+P
         SXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSNp7daxwzg9PeQCPBa7S3ruVaUwF/8x5X2sPmkYUbU=;
        b=dJJgkNawzX70GiXOsb/XUqvM0VAXZVGo6S2ILOPqO4yZomwhBmdJITr/3/cV/J0vsx
         pg9zD8+QSzsYhEERpyz8otMuv/eHHtDMOwmzjYIzmEj4I9kTr3YBUl/1PVSMsqD+ohrq
         G7BBw/R4mr+krFeW1449/Pv4KUbn5YpQ16wNd11De0Y+eUAkZd+K8HfaZN2KzqRGmXmj
         UlKanfjVmjerR0IF+ou30NS2cf1Mu6QvMZna4/TrYagSlE8eh0K8Nv+3a8tb0lFg+F9p
         je0tuUQvuNayVSw8G1BxfFM9OwY9zAAHPSmgzHy1MhwQ1IVRYxOo3RIU7EmJEYSFTlAA
         36Dg==
X-Gm-Message-State: AO0yUKXR6JpgQgWOJLYdJgzGcoBfN/9AU83X39WqnF5olmealE+o7dVm
        Ye5gfxIA6NL1Zb+6iXaahuB7rQ==
X-Google-Smtp-Source: AK7set98VgOl5yQKfPXnOp7+BQ9mmm+DHvJB09+5pQ0i8QwnCQ1+3pJs7gj3hbgfxxu+zV4TJyspBA==
X-Received: by 2002:a5d:6e8d:0:b0:2c5:4c5e:412b with SMTP id k13-20020a5d6e8d000000b002c54c5e412bmr7191875wrz.23.1676291575920;
        Mon, 13 Feb 2023 04:32:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:6e1e:131f:8bc1:aad8? ([2a01:e0a:982:cbb0:6e1e:131f:8bc1:aad8])
        by smtp.gmail.com with ESMTPSA id j4-20020adff544000000b002c54fb024b2sm5497068wrp.61.2023.02.13.04.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:32:55 -0800 (PST)
Message-ID: <b43179c4-bbf5-1d38-6ff0-8ddd0356d6d1@linaro.org>
Date:   Mon, 13 Feb 2023 13:32:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sm8450: add dp controller
Content-Language: en-US
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
Organization: Linaro Developer Services
In-Reply-To: <880e691a-0512-6325-f27c-9be59abdd647@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 16:54, Dmitry Baryshkov wrote:
> On 10/02/2023 17:28, Neil Armstrong wrote:
>> On 10/02/2023 16:24, Dmitry Baryshkov wrote:
>>> On 10/02/2023 16:44, Neil Armstrong wrote:
>>>> Add the Display Port controller subnode to the MDSS node.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 79 ++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 79 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> index 6caa2c8efb46..72d54beb7d7c 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> @@ -2751,6 +2751,13 @@ dpu_intf2_out: endpoint {
>>>>                           };
>>>>                       };
>>>> +                    port@2 {
>>>> +                        reg = <2>;
>>>> +                        dpu_intf0_out: endpoint {
>>>> +                            remote-endpoint = <&mdss_dp0_in>;
>>>> +                        };
>>>> +                    };
>>>> +
>>>>                   };
>>>>                   mdp_opp_table: opp-table {
>>>> @@ -2783,6 +2790,78 @@ opp-500000000 {
>>>>                   };
>>>>               };
>>>> +            mdss_dp0: displayport-controller@ae90000 {
>>>> +                compatible = "qcom,sm8350-dp";
>>
>> Exact, must fix.
>>
>>>
>>> Missing "qcom,sm8450-dp". As I wrote in the comment to patch 1, I'd suggest having just a single entry here rather than keeping both 8350 and 8450 entries.
>>>
>>>> +                reg = <0 0xae90000 0 0xfc>,
>>>> +                      <0 0xae90200 0 0xc0>,
>>>> +                      <0 0xae90400 0 0x770>,
>>>> +                      <0 0xae91000 0 0x98>,
>>>> +                      <0 0xae91400 0 0x98>;
>>>
>>>
>>> While this sounds correct, usually we used the even size here (0x200, 0x400, etc.). Can we please switch to it (especially since sm8350-dp uses even sizes).
>>
>> I don't have access to registers layout for HDK8450 but the system freezes when using even sizes, using
>> the exact register size works fine.
> 
> Interesting. Could you please trace, what exactly makes it fail, since specifying bigger region size should not cause such issues.

Yep I'll trace what's happening.

Neil

> 

