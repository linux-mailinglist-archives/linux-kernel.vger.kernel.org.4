Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E6D6D44C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjDCMqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjDCMqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:46:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28CE1286C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:46:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so116860646ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680526002;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=neR03f3r/PRhjAxKrg/Uky+bO4+qgi4bjtbZrSyz90E=;
        b=EVf6w8kopeQc5qosEWtBUokCa1r/js/Uos9oLbIUHBl7ks4jjsstI7+flc/COTL7Ha
         Gkcu5ZQ/QuLXaEE/GKyxNh5PxaUrgnehTafoxe1prUQuiFAL7CgADqWdszPIfPNBF1RH
         3DN1PUtvGoR8M6bBnPGKTmGXoWLHbGA82jX2dlDjrNuMYLWZDM4TZfd/O2odptXBdZcZ
         cGtzemu26UNrQ7jGPQjMT/Pz582Bleiq/v3nfWI/767OQinZoMj/yjnba9LncQ1o827p
         JhoTNa6VbwXiIjw4blmxx01Yo0KG4qFFfNq6fwRdNV9mxFhgI5uBuV2YyE0FM8GELMaO
         t/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680526002;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neR03f3r/PRhjAxKrg/Uky+bO4+qgi4bjtbZrSyz90E=;
        b=lNMbfurqVrXx4sOlB4GsTJOGp5IApTerByNijxjhcWm72DBdVf72ifF91gnTXiIyk/
         SOfWh87BacDgnpH3zIuOCi05IonMI/97ot5FuYM5bFFGD6pqSFI2eO10Yg0goWa4BWcf
         Fhu4TRxd+gDq88qSmXwO2dlRbSoh/zUqZEPQGHMlvVWQGbcrxOfrpeSKZZ/kR15qgH5N
         LZL9C97lqeJPlyl6W2WxIvqRzWqTZjg9CYt2T5rcYaCwGo+vyi/pcFcMZBclYg+ysATL
         Xbd6J7qOpzz5AExO23FZzUWuSZyPTYs6cJ2Y5PUiAj7TIctVBy2WJntrsD5ZkYRSsCUv
         XxNQ==
X-Gm-Message-State: AAQBX9d65hPZm9bhlsitFAVUsxOJ7UQA1sbqhhxF2JLdLoo0/gdrEbWO
        /3q5X0Nn4mLwL/Pc9PmVeQqsnA==
X-Google-Smtp-Source: AKy350aM+WlVOHnlCeNVQ6/mZEeUvJbST8Uv9+hSJYqmAjs6DsIwLFoDwV9YdRcHTJhsJ1wP9roCtA==
X-Received: by 2002:a17:906:4d0f:b0:8b2:8876:6a3c with SMTP id r15-20020a1709064d0f00b008b288766a3cmr34083927eju.29.1680526002502;
        Mon, 03 Apr 2023 05:46:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090608d200b0092973e209f2sm4535108eje.109.2023.04.03.05.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 05:46:42 -0700 (PDT)
Message-ID: <a04ca2bd-72f9-c89a-3fcb-36dd710b107f@linaro.org>
Date:   Mon, 3 Apr 2023 14:46:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: fix pon compatible and
 registers
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <5dfb81df-8ae2-eb62-01a2-b26c6b8d2597@linaro.org>
In-Reply-To: <5dfb81df-8ae2-eb62-01a2-b26c6b8d2597@linaro.org>
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

On 03/04/2023 14:33, Krzysztof Kozlowski wrote:
> On 03/04/2023 12:54, Johan Hovold wrote:
>> On Mon, Apr 03, 2023 at 11:18:07AM +0200, Krzysztof Kozlowski wrote:
>>> On 27/03/2023 14:29, Johan Hovold wrote:
>>>> The pmk8280 PMIC PON peripheral is gen3 and uses two sets of registers;
>>>> hlos and pbs.
>>>>
>>>> This specifically fixes the following error message during boot when the
>>>> pbs registers are not defined:
>>>>
>>>> 	PON_PBS address missing, can't read HW debounce time
>>>>
>>>> Note that this also enables the spurious interrupt workaround introduced
>>>> by commit 0b65118e6ba3 ("Input: pm8941-pwrkey - add software key press
>>>> debouncing support") (which may or may not be needed).
>>>>
>>>> Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>>>> index c35e7f6bd657..a0ba535bb6c9 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>>>> @@ -59,8 +59,9 @@ pmk8280: pmic@0 {
>>>>  		#size-cells = <0>;
>>>>  
>>>>  		pmk8280_pon: pon@1300 {
>>>> -			compatible = "qcom,pm8998-pon";
>>>> -			reg = <0x1300>;
>>>> +			compatible = "qcom,pmk8350-pon";
>>>
>>> Same comment as Dmitry's. There is no compatible "qcom,pmk8350-pon"
>>> ccd3517faf18, therefore indicated backport (through AUTOSEL) will lead
>>> to invalid stable kernel.
>>>
>>> You must drop the Fixes tag, because this cannot be backported.
>>
>> That's bullshit. Do you see a stable tag? Is 5.19-stable still active?
> 
> Why do you refer to activeness of v5.19? This will go also to v6.0 and v6.1.
> 
>>
>> The problem is that the driver was updated before the binding was so the
>> above mentioned probe error has been there since this file was merged.
> 
> I grepped and that commit did not have such compatible. Are you saying
> that the kernel which was released with this commit already had that
> compatible in driver (through different merge/tree)?

So I double checked, the commit ccd3517faf18 (which is being "fixed")
was introduced in v6.0-rc1. v6.0-rc1 did not have "qcom,pmk8350-pon"
compatible, thus it could not be fixed that way. Therefore this cannot
be logically fix for that commit from that release.

"Fixes" means that commit has a bug and this is how it should be fixed.
So v6.0 kernel should be fixed to use "qcom,pmk8350-pon" compatible,
which is obviously wrong. v6.0 does not support it and the "fix" would
actually break it (which might be worse or better than original problem,
but that's independent thing).


Best regards,
Krzysztof

