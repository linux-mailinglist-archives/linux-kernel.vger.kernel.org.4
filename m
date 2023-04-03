Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A176D4479
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjDCMdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjDCMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:33:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817E66E95
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:33:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so116748371edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 05:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680525183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M3OGvuUvXrUbBF160+4HtZaEXZGNPa/djYQZa+YmEk0=;
        b=GQAg4nQK5Mvc5pc1scKeKwqGxKWdcJAQIireqHmi2z897c26Z1EPM7SnikuV28WL8+
         qbOjjrBo8P+JaMjcevGe9EXGgzk/7YCe3XXnLe7Pl0qXtivK5oCSdWlgVa9Mn6uzzzK9
         I5BYa0KRd4/xG6CeC7ZVsa0ecVsOHqiSUkVLb4DAnJEwAlwqJ76AVDwvgtXtmv58y5Z2
         4otMlJu3DwoJSpUccU8g5d62du/df1hYJ4rd4+0tSBkIN5PlNkl3kfj05LVWK57GDsUe
         YY/L2eQxXXKzGlbD/UUCixtewGRYpnvSbdcuP/ps7vfonFYOeHEEzUB17QnZnmCoL1S6
         dT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680525183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3OGvuUvXrUbBF160+4HtZaEXZGNPa/djYQZa+YmEk0=;
        b=4DtU1pGM63YM4J481aMqMhe+QOIymcHnqIXCmDyj3kpkZji3twhwrb3byZmz4Ev23y
         TA0s8D3xXIdnIAilMrMjrSEEPoB2Rmwhni68FM+QyDVNEy1yrINPl25R2ycc1vf4Wpit
         0jKPM5PTxruaeVOURNFeqzLMnrkkFVcjfoJD4FrJsq/ZwECG83wDuOom/oeRXDLIOUSx
         kS89qUO2vY0O5+30aRcMhTOOfBirNyL/ISSzJ3eO/buGoGjWEZXeA+wW0gELnWAwZNs5
         8A1xl2NJBdUZVFELsTeroMwIoY5FZI5i4JQJIxj0+G8XZ+rrxUjBey6QtKaBsv4hvYWK
         pA8Q==
X-Gm-Message-State: AAQBX9evKa6rrbg38oDPH7JnqqwSJY//k0ul2MzVYTFwk8q/lNjgYBCS
        PLaEBV7CiamIUweR09dX/NG2qA==
X-Google-Smtp-Source: AKy350YWPGhRz66/fnA00kTRX8hQfJh5cfNX+Jb8eBFOij0y1td86P+SO8mYT55Cfitf32/7Z066pQ==
X-Received: by 2002:a17:907:f90:b0:8fd:2f01:86c0 with SMTP id kb16-20020a1709070f9000b008fd2f0186c0mr40959251ejc.2.1680525182925;
        Mon, 03 Apr 2023 05:33:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id h12-20020a1709063c0c00b00947eafc76fbsm3464230ejg.144.2023.04.03.05.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 05:33:02 -0700 (PDT)
Message-ID: <5dfb81df-8ae2-eb62-01a2-b26c6b8d2597@linaro.org>
Date:   Mon, 3 Apr 2023 14:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: fix pon compatible and
 registers
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230327122948.4323-1-johan+linaro@kernel.org>
 <48f71f9a-0d00-16df-fff8-5aa455918378@linaro.org>
 <ZCqwWwdhhJdOK+5Y@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZCqwWwdhhJdOK+5Y@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 12:54, Johan Hovold wrote:
> On Mon, Apr 03, 2023 at 11:18:07AM +0200, Krzysztof Kozlowski wrote:
>> On 27/03/2023 14:29, Johan Hovold wrote:
>>> The pmk8280 PMIC PON peripheral is gen3 and uses two sets of registers;
>>> hlos and pbs.
>>>
>>> This specifically fixes the following error message during boot when the
>>> pbs registers are not defined:
>>>
>>> 	PON_PBS address missing, can't read HW debounce time
>>>
>>> Note that this also enables the spurious interrupt workaround introduced
>>> by commit 0b65118e6ba3 ("Input: pm8941-pwrkey - add software key press
>>> debouncing support") (which may or may not be needed).
>>>
>>> Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>>> index c35e7f6bd657..a0ba535bb6c9 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>>> @@ -59,8 +59,9 @@ pmk8280: pmic@0 {
>>>  		#size-cells = <0>;
>>>  
>>>  		pmk8280_pon: pon@1300 {
>>> -			compatible = "qcom,pm8998-pon";
>>> -			reg = <0x1300>;
>>> +			compatible = "qcom,pmk8350-pon";
>>
>> Same comment as Dmitry's. There is no compatible "qcom,pmk8350-pon"
>> ccd3517faf18, therefore indicated backport (through AUTOSEL) will lead
>> to invalid stable kernel.
>>
>> You must drop the Fixes tag, because this cannot be backported.
> 
> That's bullshit. Do you see a stable tag? Is 5.19-stable still active?

Why do you refer to activeness of v5.19? This will go also to v6.0 and v6.1.

> 
> The problem is that the driver was updated before the binding was so the
> above mentioned probe error has been there since this file was merged.

I grepped and that commit did not have such compatible. Are you saying
that the kernel which was released with this commit already had that
compatible in driver (through different merge/tree)?

> 
> AUTOSEL is crazy and people apparently just ignore it instead of NAKing
> when it is suggesting backporting devicetree cleanups (which to be fair
> should generally not have Fixes tags in the first place).

Sorry, no clue what do you want to say here... if you are unhappy with
AUTOSEL, I am not the one to receive such feedback. Anyway, regardless
of AUTOSEL, my concern was that the release containing that commit was
not ready to work with that compatible. Isn't this the case here?

> 
> If 5.19-stable was still active and someone suggested backporting this

Whether v5.19 is active or not, it does not matter. Why would it matter?
This will go longterm v6.1 as well!

> one, they would have to change the compatible string to match the
> inconsistent 5.19 kernel. Note that that would need to happen regardless
> of whether this patch has a Fixes tag or not.

Any manual backporting of something which is not a fix for older kernel
is already risky business and whoever is doing it, he is responsible for
the outcome.

Best regards,
Krzysztof

