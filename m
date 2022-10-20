Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591506065C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJTQ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJTQ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:27:01 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B911A9130
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:26:51 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l28so14032708qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6dycCpajngbg2v0BxydQNe62PN7WGYYePMNofzYYVc=;
        b=wfsRQlkpytgr4C7fZSjIUAV4biD/c9lsIrlikHQqE00AJ2/GOyHnnt3jxGWi294hGP
         QCasoxV4e9jXqpbgbz31nNhvaFeADTamkq7h6sYVQF9mmlUYJ+sBia7pC/OsFXYi1um2
         VImRxEcqOSlz9Nk+isbbctIsQUCMMdA7pBncg7CbtoR1hdzlAiZcYxadW4nbEnaESRok
         PDbUyqeZ6XNiRSkuU+librfsphReuWoIFrib9SeleKjrKJHRFCnlYcBl9Co6vLMv5KS7
         ohwXrDFxgwtMBDXIGsTpL9+CqwKrL8GCIsZRVI6bdsJykU7Kyypa+oCUM/OZ9+mm5hN5
         hXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6dycCpajngbg2v0BxydQNe62PN7WGYYePMNofzYYVc=;
        b=xmFAWBRewbqPtM4gbeVsXDy+AKuD1f88CZ/AEC5Xynv1WHLxJo0Js3h6upEM0ZmSz9
         uPGIlf8IH7Tni7Cd1Yr8G7E2Xy/yljeNNYVCSAr6krB595p8W2G31BVOwR31z6mWBZVC
         9pWUAZ54FDn+umY6m+lJgHofWnBqpcfq0/qCvKGFJ6xAaOMUykAALisLidYO+fjE/yVj
         GiJDhO1SFEL0vvENhoijy01GbEQEfvxF9kSj7HnD3FUfizZgJNNmG8+Xwxw390O7tyfr
         Ph52Ew/tGOakxAG2zHcUY8iMRf1B54b2pIwhBSvyqaKTdRiIc4+MiksXmVX8LGptDfzA
         qFwQ==
X-Gm-Message-State: ACrzQf1m1SnmhqhTcoq4cNxeOkvQHAhh/U7DrI3ud8E7KBLHYqYa+N/5
        m9W5WNhBb1Bw1gmRSrPqqajTog==
X-Google-Smtp-Source: AMsMyM6sQzBZV+ybT3krnybJ7F1Gg+NUMIA1BVdPlr14i0N9nM/yHMvtqFpBbCgFGENuju805QWTFA==
X-Received: by 2002:ac8:5acf:0:b0:39c:d4d8:3f75 with SMTP id d15-20020ac85acf000000b0039cd4d83f75mr11661745qtd.579.1666283210197;
        Thu, 20 Oct 2022 09:26:50 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id do20-20020a05620a2b1400b006ec9f5e3396sm7912806qkb.72.2022.10.20.09.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 09:26:49 -0700 (PDT)
Message-ID: <d5e176b3-75e2-67bc-3fc6-b54fe685c9a0@linaro.org>
Date:   Thu, 20 Oct 2022 12:26:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
 <20221014221138.7552-3-quic_molvera@quicinc.com>
 <56af2a04-1b21-000d-e3f9-86b6ac74aaf2@linaro.org>
 <a0032338-482f-0de7-5952-c3c8b8423df6@quicinc.com>
 <50372a15-56ce-6ad6-f622-00624b909db8@linaro.org>
 <Y1FTJgloEi5ag2/j@gerhold.net>
 <9fbe1bf5-a84d-c56b-1c0e-6848ee3d30fe@linaro.org>
In-Reply-To: <9fbe1bf5-a84d-c56b-1c0e-6848ee3d30fe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 12:08, Krzysztof Kozlowski wrote:
> On 20/10/2022 09:54, Stephan Gerhold wrote:
>> On Thu, Oct 20, 2022 at 08:41:15AM -0400, Krzysztof Kozlowski wrote:
>>> On 19/10/2022 16:21, Melody Olvera wrote:
>>>> On 10/15/2022 6:28 AM, Krzysztof Kozlowski wrote:
>>>>> On 14/10/2022 18:11, Melody Olvera wrote:
>>>>> [...]
>>>>>> +	clocks {
>>>>>> +		xo_board: xo-board {
>>>>>> +			compatible = "fixed-clock";
>>>>>> +			clock-frequency = <19200000>;
>>>>> Both clocks are not a property of a SoC. They are provided by the board,
>>>>> so they should either be defined by board DTS or at least their
>>>>> frequency must be provided by the board.
>>>> That doesn't seem in keeping with precedent.... the sm8* series all have the clocks in
>>>> the dtsi. These are common to the boards anyways.
>>>
>>> Because people do not pay attention what is part of SoC, what is part of
>>> board. DTSI is for the SoC and these are inputs to the SoC.
>>>
>>
>> (Just chiming in because I had this thought already a few times when you
>>  suggested moving the XO "clock-frequency" to the board DTS:)
>>
>> I understand your reasoning for moving components of the board to the
>> board DTS, but IMHO adding just the clock-frequency to the board DTS is
>> even more misleading: It suggests that there are functional board
>> designs where you would use a XO clock with a different clock-frequency.
>> Is that really realistic though?
> 
> Keeping it in DTSI also suggests you could have some different frequency.
> 
>>
>> There are assumptions about the XO clock frequency in a lot of places:
>> You would need to fully rewrite the gcc-<SoC>.c driver because it has
>> fixed multipliers/dividers for one specific XO frequency. All firmware
>> binaries would likely need changes. And does the hardware even support a
>> different XO clock frequency? The APQ8016E datasheet for example
>> strictly documents a XO clock input of 19.2 MHz and a sleep clock of
>> 32.768 kHz.
> 
> I know, the same with most of other platforms. Qualcomm is not special
> here. Maybe the difference is that some other platforms have few
> external clocks and not all of them are required.
> 
>> IMHO the only realistic variation of the XO clock setup would be to have
>> a physical "fixed-clock" with a higher frequency, followed by a
>> "fixed-factor-clock" that brings it back to the expected frequency. To
>> model that properly it is not enough to have just the "clock-frequency"
>> in the board DTS. In this case you need two clock nodes, and the
>> xo_board would be the "fixed-factor-clock".
> 
> It's not about whether you can change it or not. It's about describing
> hardware - SoC DTSI describes SoC. DTS describes the board (assuming
> there is no SoM or other DTSI files). This clock is not in DTSI.
> 
>> Therefore it should be all or nothing IMO: Either we move the full
>> xo-board node to the board DTS (which allows alternatively defining the
>> "fixed-factor-clock" or whatever).
> 
> You can move entire clock to boards.
> 
>> Or we assume that there will be
>> always an input clock signal with the fixed frequency and keep it fully
>> in the SoC .dtsi.
>>
>> Having just the "clock-frequency" in the board DTS puts the attention on
>> the wrong detail, IMO. :)
> 
> No, it puts attention to the board designer that he needs to provide the
> clock in his design.
> 

Another solution which would satisfy me, would be to put these clocks to
a dedicated, re-usable DTSI and include that DTSI in each board DTS.

Best regards,
Krzysztof

