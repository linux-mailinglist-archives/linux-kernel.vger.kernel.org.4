Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B1465B3E4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbjABPKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjABPKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:10:04 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D595AA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:10:03 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id s22so29254054ljp.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F51K2k1UqyDsMK9Y8htUZq3ZisZ/a1NgKWMO6hVgpG4=;
        b=D0Pb3yiEiAm96gLXnuPr8iBw0kUz7Oxz429nZBJ660QLCv279EabwyTWwKKc9ZfvtK
         TdwoAMn0oeW5jwSBhpyGV/6LqnQcgPhYVqYlgiHP6B3C+mK7ZJtx+Mm906zQ4JWo5Aes
         ohvbIUMnqw+zLzRm5NSBVGgQ5b0w3yad42GYrtk8k/iDzaykxWUclTWvSanyj8tc36uD
         /LA4lhBwp/r+KrKqx/SXpy9FxhUmEqpMi7PEgeFsFRFQCuYyMpG3wdkQqzsPSMBhVvJy
         IweujxddqAaftDETIvl5p7br9iJT66w/dB1gYk6VyAICFy1OymW4xVSMD2CTXM9Ab151
         DTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F51K2k1UqyDsMK9Y8htUZq3ZisZ/a1NgKWMO6hVgpG4=;
        b=lPdugU0hbPBIsLLwU2j5iQOvXr1cRlQ6KUPqFhBtw+YhAAIG1syYBR9CzfHvG0rGKp
         O43l6OqWutHmY0kVLXu9w/1n4eBYBVCOA3BZsNlFbH7nd12JKNmbhaWKMtPABFfV8oLs
         kadi1HNrN1naOEcf1th61s5DtSqF1aPTMNbc27k7Qg7JQbEXfRHs3IlxBSV3UorCew0V
         RhsUK16aVhxyDWEZdHJ/yEVaDJO0iNKIcZPARaETiwyIF9/Oz/on7xOFTl/e1HipBBAT
         GwUWQxmCrvC5pPF7PnCR4vutECW1vX3ZSW2nEyyYj1wMCcZ5afP3O5M+QT0JVF6QjZ9N
         3mXg==
X-Gm-Message-State: AFqh2kp8Tb5f0D32dLkf/paVtz6ppxNHwqje0/DB1Fy7Wm7vMWndc3Xr
        us/Uj1q/juPuxuk3vmwbWgMNQQ==
X-Google-Smtp-Source: AMrXdXusj4s5bqU1bs/9C17CH0pow47iKrbQsKBGBcYyBzOSj/b8dymnUIz/0LTx/VbKu6EQRcDhVg==
X-Received: by 2002:a05:651c:c90:b0:27f:f740:8260 with SMTP id bz16-20020a05651c0c9000b0027ff7408260mr499772ljb.45.1672672201461;
        Mon, 02 Jan 2023 07:10:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z2-20020a2eb522000000b0027fdee02c66sm904604ljm.95.2023.01.02.07.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 07:10:00 -0800 (PST)
Message-ID: <e57164f6-7dcf-5139-1b4f-6b63f9fd7786@linaro.org>
Date:   Mon, 2 Jan 2023 16:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sm8450-hdk: fix wcd938x codec node
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-7-johan+linaro@kernel.org>
 <c2a32bd3-90cf-6d1b-1ca7-76071232c81b@linaro.org>
 <791c0e37-f825-c324-7a99-163b0566c758@linaro.org>
 <Y7Ly1wlft4Y6VfIG@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7Ly1wlft4Y6VfIG@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 16:05, Johan Hovold wrote:
> On Mon, Jan 02, 2023 at 01:24:34PM +0100, Krzysztof Kozlowski wrote:
>> On 02/01/2023 13:23, Krzysztof Kozlowski wrote:
>>> On 02/01/2023 11:50, Johan Hovold wrote:
>>>> The wcd938x codec is not a memory-mapped device and does not belong
>>>> under the soc node.
>>>>
>>>> Move the node to the root node to avoid DT validation failures.
>>>>
>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 52 ++++++++++++-------------
>>>>  1 file changed, 25 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>>>> index 4de3e1f1c39c..217b2c654745 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>>>> @@ -17,6 +17,31 @@ aliases {
>>>>  		serial0 = &uart7;
>>>>  	};
>>>>  
>>>> +	wcd938x: codec {
>>>
>>> Let's call it audio-codec and put it somewhere ordered alphabetically.
>>> This avoids useless reshuffles immediately. Moving things back and forth
>>> does not make sense.
>>
>> Eh, on the other hand SM8250-MTP uses name codec so maybe the rename in
>> SC8280xp should be dropped.
> 
> Nah, let's go with audio-codec. Your MTP change hasn't been merged yet
> so we can still drop or respin that one.

It was, ~5 days ago, so please rebase.

Best regards,
Krzysztof

