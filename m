Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E151674EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjATIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjATIET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:04:19 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7096E59E6E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:04:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h12so86475wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6LXkIx8BANILDQmoLHswehPH28NdMe4BBg+GYgmQJc=;
        b=gd4l01rhpsa8H54xUMgiQ+zJGbH0SoJyTrI51hbsZysaJi8L40ZQIGPyyul0z7Ocg4
         zpTey7QZIqkSZ7gD5mfJdzGH+L4xP/Jxx56pspJ6DDz/Nuu1VfZEFelRQ4fi1j2kbkDG
         w6trpgj2whXf8arw9tAjTnPhr22VOyiu53zB5CjdInNNnTHdHsFAf3a3zOM2pa3gRF1e
         JnyE9UIa+CjL/Wu7vll6UEQG/D9fdAAnH4sEvkUbrmMjEHAcpAzpaIhiQwydr0b83pxt
         4aCsRknCcqzwyo8rJRE4R7ChWA6EjnQh9pcWq482df90gL/dh5ZcxXYq5aygoTOLg8md
         5CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6LXkIx8BANILDQmoLHswehPH28NdMe4BBg+GYgmQJc=;
        b=l5axY2Z5VOMeNLEocoJ4u2aPfyeO1UwG9gNSbLE04UApyD23e3GDkD86KHOO65Binz
         zusnuZRZUo9D1h2qo7Ru7rKz+JXYa+xzBKaTcQelJ9tfoVBRebbu5PWqQJG+oLU64NiO
         L4T/6ni/dYYiwtF6Cb0vD0GAEg6dNueKyd5xx+voQYYaqTtSz7QBbmhrtPqdsEsDnkuu
         tPrdH/Qx39C0QTILiUjiFs9LtNC5QrY5/XuWll6QQBFxs4cpJQzFXrhEWw0iiUR0vIHO
         DqtEvDM4JP19Ygqd0HAXZGFry0ZRj5u4PxGeDs+bhINEUg3S/r1kulnSAyzeWYaCyQgM
         8BlQ==
X-Gm-Message-State: AFqh2kol5ZHF7aYSavjR0zVxGFx/UYV4agLvbR3tedPncj0+WYMGJCSG
        U2ZEtBCLqLU2f7A8Zk2E6PgoYA==
X-Google-Smtp-Source: AMrXdXsMXAoaC0AHQ2YBbTngF/qLL6GGMIQ5qXh9iHZwnWh7GupAm7r9lc0MoGv9BvDY3wk+bH3dTg==
X-Received: by 2002:adf:8b1c:0:b0:2bf:9478:a91d with SMTP id n28-20020adf8b1c000000b002bf9478a91dmr1393wra.39.1674201855853;
        Fri, 20 Jan 2023 00:04:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d6d0b000000b002bdda9856b5sm1822404wrq.50.2023.01.20.00.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:04:15 -0800 (PST)
Message-ID: <4be5a020-c9a3-cab9-921a-c4cdfe6ce979@linaro.org>
Date:   Fri, 20 Jan 2023 09:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 4/7] arm64: dts: qcom: sc7280: Update VA/RX/TX macro
 clock nodes
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org
References: <1674131227-26456-1-git-send-email-quic_srivasam@quicinc.com>
 <1674131227-26456-5-git-send-email-quic_srivasam@quicinc.com>
 <17b895c0-3985-a012-9b02-94d5ebb11ff9@linaro.org>
 <9ae3b1b0-e9d6-6370-667b-88af5d0efa2e@quicinc.com>
 <7d874a5d-5a26-1ae1-58bc-dd819774190d@linaro.org>
 <3299b57b-7260-0189-ba6f-824db391d81c@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3299b57b-7260-0189-ba6f-824db391d81c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 07:35, Srinivasa Rao Mandadapu wrote:
> 
> On 1/20/2023 11:54 AM, Krzysztof Kozlowski wrote:
> Thanks for your valuable suggestion Krzysztof!!!
>> On 20/01/2023 05:47, Srinivasa Rao Mandadapu wrote:
>>> On 1/19/2023 7:01 PM, Krzysztof Kozlowski wrote:
>>> Thanks for your time Krzysztof!!!
>>>> On 19/01/2023 13:27, Srinivasa Rao Mandadapu wrote:
>>>>> Update VA, RX and TX macro and lpass_tlmm clock properties and
>>>>> enable them.
>>>> Everything is an update and this does not explain what exactly you are
>>>> updating in the nodes and why.
>>>>
>>>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>>>> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>>>>> ---
>>>>>    .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 59 ++++++++++++++++++++++
>>>>>    1 file changed, 59 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>>>>> index 81e0f3a..674b01a 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>>>>> @@ -8,8 +8,67 @@
>>>>>    
>>>>>    #include <dt-bindings/sound/qcom,q6afe.h>
>>>>>    
>>>>> +/delete-node/ &lpass_rx_macro;
>>>> Why?
>>> Actually in SoC dtsi (sc7280.dtsi) power domains property used.
>>>
>>> Which is not required for ADSP based solution. As there is no way to delete
>>>
>>> individual property, deleting node and recreating it here.
>>>
>> You can delete property - delete-property. However why in AudioReach
>> device comes without power domains? What does it mean "power domains
>> property is not required"? DTS describes the hardware and the rx macro
>> is powered, isn't it?
> 
> Actually in case ADSP bypass solution power domains are handled in HLOS 
> clock driver.
> 
> Whereas in ADSP based solution they are handled in ADSP firmware, and 
> from HLOS
> 
> voted as clocks.
> 
> Below is the reference commit.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9e3d83c52844f955aa2975f78cee48bf9f72f5e1

I am sorry, but this is one big mess. Hardware is one. I understand that
Linux drivers can be entirely different but here - and in the past with
few clocks - the hardware description keeps changing depending on the
wishes of developers. That's not how bindings and DTS work. This suggest
that DTS is being pushed to satisfy driver needs, not to properly
describe the hardware. I am sorry, but hardware does not change.

Best regards,
Krzysztof

