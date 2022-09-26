Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E565EACE3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiIZQpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIZQpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:45:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D65B91D8E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:34:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id s6so11452299lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=F5npTjbMuhkZGTbiPdd9I0BH4rth5Gn8Gik7w91MPEQ=;
        b=COyNBYSScAS0o8DDp+/0tPXmTexBHDJ8u+KWYzRSdPHkoRQmBZUmJXS8LLbSozyY+q
         NCFkzGM/3t/i5zCm5VLW5RWigE0uzDey/6LVZ7DD2zOqyCpZCVzJtr5CYAD5fJvCljUV
         KZU1RDSjJ2aZmOnMJqiE6QvMP222ve4kgfy28zHelpSvWzaqO4mk33NMM5HIuyG6Z830
         yN8qmT5CuxbULXrSdjoiyPJYmtvFZq8+zQqJdYD9+vxevjD+2JWTA7aIHjKLbX4RkSIe
         RUivF14k9gDk5Ff9QrCG8zoewQg13qrlpoxYzt5tYxV4LsXHy0qwjiuAW9iGZjm91vAX
         Ni1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=F5npTjbMuhkZGTbiPdd9I0BH4rth5Gn8Gik7w91MPEQ=;
        b=LZrDtm5c2Lq5lOfYpYo0w8UJSsfMVhoEddyJ6ATR5D3qWTGOe/xeih0UQF6W7G9G9r
         et9zSHDhXLAaZXgjWGRMgkhPYlSyxZkkmPCzyyNLVnJTc5d+4VsblSu1z027YR64wSPX
         TuIXSRqeuyEro4M5uav/xcsQD0AbBQk6BSFiiSqon0vILPgDWCpBEHrSRxhTUDVnhjM5
         kPq0l5InZb5YkMA3tX4a73hrCF+BAYZCcCK+XyI47lsJt5H6OcahGxPhN4hbvNpYZT8K
         hyAqkGiEjlurWul4WoDehQ30pbQTo5IJQAKZZFa9pH4gBhLeS3B7bdUEDzJGF42vvO1K
         SrEg==
X-Gm-Message-State: ACrzQf0jsQzthvGdHF6zLZ9g9U2+mEGiPn9PuUuBsacCXGJB+uxi4Rgk
        SMPjFxErtkUBQQrRo8m/gwFNxQ==
X-Google-Smtp-Source: AMsMyM6tMFemy+xGBNnt6gYp5DB31dPiL5kIfOf1LKc4vRAi/zdjV4hXeir/ybWPBzYvF++N0Z3T9A==
X-Received: by 2002:a05:6512:3f08:b0:4a1:af5e:5643 with SMTP id y8-20020a0565123f0800b004a1af5e5643mr4484835lfa.86.1664206441267;
        Mon, 26 Sep 2022 08:34:01 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f3-20020a056512092300b0049486c66140sm2573546lft.119.2022.09.26.08.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 08:32:57 -0700 (PDT)
Message-ID: <15611981-19b3-5124-83da-7f9a699ef62f@linaro.org>
Date:   Mon, 26 Sep 2022 17:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] ARM: dts: qcom-pma8084: fix vadc channel node names
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        neil.armstrong@linaro.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925202143.123208-1-luca@z3ntu.xyz>
 <98960452-9f48-7b4d-9aa6-55c0002ad1b4@linaro.org> <2647127.mvXUDI8C0e@g550jk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2647127.mvXUDI8C0e@g550jk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 16:57, Luca Weiss wrote:
> Hi Neil,
> 
> On Montag, 26. September 2022 10:27:54 CEST Neil Armstrong wrote:
>> On 25/09/2022 22:21, Luca Weiss wrote:
>>> Node names for the channel are supposed to be adc-chan@REG.
>>>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> ---
>>>
>>>   arch/arm/boot/dts/qcom-pma8084.dtsi | 17 +++++++++++------
>>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi
>>> b/arch/arm/boot/dts/qcom-pma8084.dtsi index e77602e9f95c..7ad573c7b4ac
>>> 100644
>>> --- a/arch/arm/boot/dts/qcom-pma8084.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
>>> @@ -64,22 +64,27 @@ pma8084_vadc: adc@3100 {
>>>
>>>   			#size-cells = <0>;
>>>   			#io-channel-cells = <1>;
>>>
>>> -			die_temp {
>>> +			adc-chan@8 {
>>>
>>>   				reg = <VADC_DIE_TEMP>;
>>>   			
>>>   			};
>>>
>>> -			ref_625mv {
>>> +
>>> +			adc-chan@9 {
>>>
>>>   				reg = <VADC_REF_625MV>;
>>>   			
>>>   			};
>>>
>>> -			ref_1250v {
>>> +
>>> +			adc-chan@10 {
>>>
>>>   				reg = <VADC_REF_1250MV>;
>>>   			
>>>   			};
>>>
>>> -			ref_buf_625mv {
>>> +
>>> +			adc-chan@12 {
>>>
>>>   				reg = <VADC_SPARE1>;
>>>   			
>>>   			};
>>>
>>> -			ref_gnd {
>>> +
>>> +			adc-chan@14 {
>>>
>>>   				reg = <VADC_GND_REF>;
>>>   			
>>>   			};
>>>
>>> -			ref_vdd {
>>> +
>>> +			adc-chan@15 {
>>>
>>>   				reg = <VADC_VDD_VADC>;
>>>   			
>>>   			};
>>>   		
>>>   		};
>>
>> I don't see where this is required, bindings doesn't mandate this naming:
>>
>> patternProperties:
>>
>>     "^.*@[0-9a-f]+$":
> 
> They don't require the "adc-chan" part (although dt nodes are supposed to have 
> common names and adc-chan is used for adc for that; and dt node names are not 
> supposed to have underscores), but this validation error happens without this 
> commit:
> 
> <snip>/arch/arm/boot/dts/qcom-apq8084-ifc6540.dtb: pma8084@0: adc@3100: 
> 'oneOf' conditional failed, one must be fixed:
>         '#address-cells', '#size-cells', 'die_temp', 'ref_1250v', 'ref_625mv', 
> 'ref_buf_625mv', 'ref_gnd', 'ref_vdd' do not match any of the regexes: 
> 'pinctrl-[0-9]+'
>         'die_temp', 'ref_1250v', 'ref_625mv', 'ref_buf_625mv', 'ref_gnd', 
> 'ref_vdd' do not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'
>         'qcom,spmi-iadc' was expected
>         From schema: <snip>/Documentation/devicetree/bindings/mfd/qcom,spmi-
> pmic.yaml
> 
> So while e.g. ref-vdd@15 would also work, adc-chan@15 is more correct.

The commit msg is not precise here. What the nodes are missing is unit
address (required by VADC bindings) and replace of underscore (coding
style). I think bindings do not require the adc-chan and we could apply
here rule from DT spec that node name should reflect it's
purpose/function, so die-temp@xxxx could be fine. Other places use
already adc-chan, so consistency could be an argument. But anyway commit
msg is not really describing why you are doing this.

Best regards,
Krzysztof

