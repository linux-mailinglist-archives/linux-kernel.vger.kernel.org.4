Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C538360656D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiJTQIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiJTQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:08:43 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3722E1011AB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:08:41 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 8so220635qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TtEMRpsimdvD8kh9027kcik8M+Z+knHwtPDnnGUJLQ=;
        b=YBfXYAQoqJLRmfHEsw9oyaJxInNF1RbJgUhGCqH5Ex2nDsDZF5708kiqPnJrA6B+wk
         c0lzVMc/JHFiLc6CpPCzvH/ll1lwjrB5oT9/DTNT9EWfi0wo3XruTkQrVfWdVsG6H+Rj
         NPrJujaKswGSzalA6nMBARxLwAL2TunQXQt+eSF7PSq7uYbVlESTuac9KMjhofJeJ45W
         y6uNhGM2vf3vyREsHoY0GJv5wyX5hykFxv7E0Obf3r//Vmp5/MU29jgkfgyEzQ7GOUc8
         b1whIY6YeiTIwuB0zCDJ/MwIr47Vak3DbI/zxFuwI4wSHK7WVFwBALKvPB7j5jo9kPSl
         ImQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TtEMRpsimdvD8kh9027kcik8M+Z+knHwtPDnnGUJLQ=;
        b=57GAEvzQLgdWUkukbLh0w5jiayktlMp4o8dJ3q0WMNisOk4ubVfL9+05BJNCKLPtRS
         JZY0IJ4tE7iO4xMr8Nhy1fud8i7hz1aX6snUPI+iG4iEEz3WdGkzmJfMETDj7MguGdgJ
         ADQHlpEd9QY/i0j1Ts8V4GWBcyv/SYT1ToPkZtmBrLLI26pwHukwXF67aWHjDlbl6/8t
         loRlZhIdj/2I1OpVV1rxtLfUtX6leYtmrBl6GkLmV2XHV7EvOn38pl7Pi41zdz/c/zRl
         SFuJJVpgLOYEANMDhdu5luTCI01SQrDQkpXhpqidgUPMk6yqJJWuoS6Gp11w9MWD9EnB
         /78Q==
X-Gm-Message-State: ACrzQf1XiX/u76RaEP6zHrH+uC3H1BVmDOth4ZTT5+P9Y3MlPthzrLmJ
        6khevTtcCeuCIDpevj8oK8ZRYr7O7NGL8w==
X-Google-Smtp-Source: AMsMyM4VXP5zpdCUBgwtAJBoMUAdpAydK8PX90MqEuxs1/Z+Ya8Fy12UemSkGfB7i2UCdB24KkTnVA==
X-Received: by 2002:a05:620a:318d:b0:6ce:d8de:bab2 with SMTP id bi13-20020a05620a318d00b006ced8debab2mr9925801qkb.456.1666282119782;
        Thu, 20 Oct 2022 09:08:39 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id f11-20020ac87f0b000000b003999d25e772sm6496923qtk.71.2022.10.20.09.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 09:08:38 -0700 (PDT)
Message-ID: <9fbe1bf5-a84d-c56b-1c0e-6848ee3d30fe@linaro.org>
Date:   Thu, 20 Oct 2022 12:08:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y1FTJgloEi5ag2/j@gerhold.net>
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

On 20/10/2022 09:54, Stephan Gerhold wrote:
> On Thu, Oct 20, 2022 at 08:41:15AM -0400, Krzysztof Kozlowski wrote:
>> On 19/10/2022 16:21, Melody Olvera wrote:
>>> On 10/15/2022 6:28 AM, Krzysztof Kozlowski wrote:
>>>> On 14/10/2022 18:11, Melody Olvera wrote:
>>>> [...]
>>>>> +	clocks {
>>>>> +		xo_board: xo-board {
>>>>> +			compatible = "fixed-clock";
>>>>> +			clock-frequency = <19200000>;
>>>> Both clocks are not a property of a SoC. They are provided by the board,
>>>> so they should either be defined by board DTS or at least their
>>>> frequency must be provided by the board.
>>> That doesn't seem in keeping with precedent.... the sm8* series all have the clocks in
>>> the dtsi. These are common to the boards anyways.
>>
>> Because people do not pay attention what is part of SoC, what is part of
>> board. DTSI is for the SoC and these are inputs to the SoC.
>>
> 
> (Just chiming in because I had this thought already a few times when you
>  suggested moving the XO "clock-frequency" to the board DTS:)
> 
> I understand your reasoning for moving components of the board to the
> board DTS, but IMHO adding just the clock-frequency to the board DTS is
> even more misleading: It suggests that there are functional board
> designs where you would use a XO clock with a different clock-frequency.
> Is that really realistic though?

Keeping it in DTSI also suggests you could have some different frequency.

> 
> There are assumptions about the XO clock frequency in a lot of places:
> You would need to fully rewrite the gcc-<SoC>.c driver because it has
> fixed multipliers/dividers for one specific XO frequency. All firmware
> binaries would likely need changes. And does the hardware even support a
> different XO clock frequency? The APQ8016E datasheet for example
> strictly documents a XO clock input of 19.2 MHz and a sleep clock of
> 32.768 kHz.

I know, the same with most of other platforms. Qualcomm is not special
here. Maybe the difference is that some other platforms have few
external clocks and not all of them are required.

> IMHO the only realistic variation of the XO clock setup would be to have
> a physical "fixed-clock" with a higher frequency, followed by a
> "fixed-factor-clock" that brings it back to the expected frequency. To
> model that properly it is not enough to have just the "clock-frequency"
> in the board DTS. In this case you need two clock nodes, and the
> xo_board would be the "fixed-factor-clock".

It's not about whether you can change it or not. It's about describing
hardware - SoC DTSI describes SoC. DTS describes the board (assuming
there is no SoM or other DTSI files). This clock is not in DTSI.

> Therefore it should be all or nothing IMO: Either we move the full
> xo-board node to the board DTS (which allows alternatively defining the
> "fixed-factor-clock" or whatever).

You can move entire clock to boards.

> Or we assume that there will be
> always an input clock signal with the fixed frequency and keep it fully
> in the SoC .dtsi.
> 
> Having just the "clock-frequency" in the board DTS puts the attention on
> the wrong detail, IMO. :)

No, it puts attention to the board designer that he needs to provide the
clock in his design.

We had such talks about other platforms, although I do not have any
recent bookmarks. Something older:

https://lore.kernel.org/all/3382034.5ADO0F7naY@wuerfel/

https://lore.kernel.org/linux-samsung-soc/53DAB0A6.9030700@gmail.com/

Best regards,
Krzysztof

