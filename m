Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA16F6EDA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjEDPYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjEDPYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:24:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1002F49CB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:24:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5083bd8e226so923208a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683213868; x=1685805868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpvVYRaSZSo/qHq4l0Ax63FC86wa0lwjbGgjNwrdoNY=;
        b=PPlAan2314hetKUG7RtPJNXrKa0PbsOZ339lsVS0hQXVOEcWk2YEu2357kxSoKUsc3
         6Xqbyjqvv0MonXmmR9Ypq1Rb1MYW8vyiEDkiD5l1QgFhOSDsSStltezXLWrQxCtKI+Cz
         Kl8kRV6vGbwdXKdq9xAmyijEYHtsg2XID1ZnEqCsXf7UEeLULAr8ek0hA/RcVx4I2Lt8
         eRuTdcvu6YetKtycGT/XfuZJkyPNSNP3Tz5sYjml9rcLNP2cLs/qTqhZpavmFuSjC7t2
         GS+jQd8odsE6H4jQ72zZlpXNybI/koZGf6QiyAytuvzw6py0+DPi10UqV4iFsap4cUEA
         77Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683213868; x=1685805868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpvVYRaSZSo/qHq4l0Ax63FC86wa0lwjbGgjNwrdoNY=;
        b=FA0NeP0Y7P1tWGFLePbG7qpc9uQc/0u1oyGAjkq47zm2jwtMBspvos+yVRX4U7xejh
         Ek+SPC1avwWfuY1y0FMEZ6m7dAk4eDm4ByvCioQYrzFJ4d+Xcb3Gxji1K60u9r27bPcK
         GO/9q9JrbJStKYNj/e+Nayhu51dzyhmYTb6R01GTLw+UUDPQzzn1Mz4phjW7SPVgtbtk
         WJws5Dik6PRDaCfBM1O1Syu9jUNQBtrFuGx9OtnOiEV+iAQS/wcINZjBK5J4LqJbMRD8
         txSWs4moemYA0cQvMD0Mb+6BLl3QboawOQWxMcmA4ogBJJPoz85CRNFNz+NhlM05B2SE
         wjbA==
X-Gm-Message-State: AC+VfDzB37rnGu8dhLS9rYhQWtCwgD766nxSDZXthdeGvgpzDmKy0VPX
        FoFg3MFYpklaNL20BGONXX8+dA==
X-Google-Smtp-Source: ACHHUZ7gh7wB1JRUTh/FK6dClK2y7GMFZoT+TpZPzjkz+MVSYYieOMcTNt1MkABNcqdtMhm7bA/izA==
X-Received: by 2002:a05:6402:746:b0:50b:c971:c14b with SMTP id p6-20020a056402074600b0050bc971c14bmr2159293edy.11.1683213868504;
        Thu, 04 May 2023 08:24:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id d18-20020a50fe92000000b0050470aa444fsm1951945edt.51.2023.05.04.08.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:24:28 -0700 (PDT)
Message-ID: <12131791-c775-cfc3-824a-e59c4e0ea338@linaro.org>
Date:   Thu, 4 May 2023 17:24:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 07/18] arm64: defconfig: Enable Qualcomm minidump
 driver
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-8-git-send-email-quic_mojha@quicinc.com>
 <ad9915b2-56ff-3f95-7c92-fae597d6ed43@linaro.org>
 <4325c2e7-8ca1-7e45-db14-5ba8bc83f5d7@quicinc.com>
 <a4118697-d575-6499-ed8e-656e51ca0da3@linaro.org>
 <2fb1658a-3a38-7eb4-0e6e-d8c61981bdab@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2fb1658a-3a38-7eb4-0e6e-d8c61981bdab@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 16:43, Mukesh Ojha wrote:
> 
> 
> On 5/4/2023 6:02 PM, Krzysztof Kozlowski wrote:
>> On 04/05/2023 13:45, Mukesh Ojha wrote:
>>>
>>>
>>> On 5/4/2023 4:53 PM, Krzysztof Kozlowski wrote:
>>>> On 03/05/2023 19:02, Mukesh Ojha wrote:
>>>>> Previous patches add the Qualcomm minidump driver support, so
>>>>> lets enable minidump config so that it can be used by kernel
>>>>> clients.
>>>>>
>>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>>
>>>> This patchset is split too much. Defconfig change is one change. Not two
>>>> or three.
>>>>
>>>>> ---
>>>>>    arch/arm64/configs/defconfig | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>>> index a24609e..831c942 100644
>>>>> --- a/arch/arm64/configs/defconfig
>>>>> +++ b/arch/arm64/configs/defconfig
>>>>> @@ -1250,6 +1250,7 @@ CONFIG_QCOM_STATS=m
>>>>>    CONFIG_QCOM_WCNSS_CTRL=m
>>>>>    CONFIG_QCOM_APR=m
>>>>>    CONFIG_QCOM_ICC_BWMON=m
>>>>> +CONFIG_QCOM_MINIDUMP=y
>>>>
>>>> This must be a module.
>>>
>>> Why do you think this should be a module ?
>>>
>>> Is it because, it is lying here among others '=m' ?
>>
>> Because we want and insist on everything being a module. That's the
>> generic rule. There are exceptions, so if this justifies being an
>> exception, please bring appropriate arguments.
>>
>>>
>>> Or you have some other reasoning ? like it is for qcom specific
>>> soc and can not be used outside ? but that is not true for
>>> all configs mentioned here.
>>>
>>> The reason behind making it as '=y' was, to collect information from
>>> core kernel data structure as well as the information like percpu data,
>>> run queue, irq stat kind of information on kernel crash on a target
>>> running some perf configuration(android phone).
>>
>> I don't understand why =m stops you from all that.
> 
> How do i get kernel symbol address from a modules
> can we use kallsyms_lookup_name from modules ?

You allow it to be a module in patch #4, so I think you solved it,
right? Otherwise it could not be a module?

Anyway, where do you use kallsyms_lookup_name()? I cannot find it in
your patch.

Best regards,
Krzysztof

