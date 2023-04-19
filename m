Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8817B6E7F42
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjDSQM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjDSQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:12:23 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AC0A5CD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:12:08 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x34so21403131ljq.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681920727; x=1684512727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVgwraJWt3EyktAkt1C2LoJC0avBDiNujtBEgja7u2E=;
        b=qt2GMvO0NpsFA0UuXiSxHZrGuavUrfBYK4d9A/Rmgq4f9T1W0Ued8smZHOtXtia6yA
         9DLbCZQH9iRlrmt4sbUIZSY1lrpFj10vS/xT76iMgVBrkQrBQ+mTgZ5wpD95/L3BNLxc
         3RaZZGfhm+kV5ZtzpuucKTLQKq+ajHPGvzqvpu8711+IY65E4ImvcBw9KXk81f8kfNtp
         PbVmZwZSfbdLQ76vVayJF8DwFX2NQHWnrxMcv1vyjJsmnGnnBatj0TanIkOagDtQdf74
         fjoXvDe2fLc4mflinyB+cPVFknaz7tkcPM/7adVZqg/lbBhxKUztAO6S5H5EGkIGn/Wh
         1tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920727; x=1684512727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVgwraJWt3EyktAkt1C2LoJC0avBDiNujtBEgja7u2E=;
        b=evooeSf9ZrKmfHaCs9k1++peHmxFHAKC69pLqVcLCmuL8HsuC+ykgVjhqz08UvbH1m
         gwJniKU8zsbMAOwPMIYnk1AYMeYP5IbAbkDBORvutrb2dxEV8lZi4Rv07Aj9X+qwTQ6F
         FnWE0kYHSRdkqfiF/gnbRIMk303Uptbcdat8r+PEmUu6PXYQUzbbwIPIk13iQSQ8uXLM
         1HEjzgOOq2JJpRmAW1iMg6RqnuFmWNeIR9ZfjtuS5icBu55e8om26lXAIcfM47Ef/kWq
         +nDBs1+nDntxDDevInm0d6p3osZP6yYHrLg2f+ZE5HIXnPJiLxQmPKtiZL+vfJhdNjy9
         UO2w==
X-Gm-Message-State: AAQBX9eTi3jbynf5Y4pA3ZLa/L9BrxOiCKjBRavbKP5ILUhSsBTpTGwz
        bmq5F3+zFX3Eos34Fkq8mlI3/w==
X-Google-Smtp-Source: AKy350bfZaIQsy/AVLooAEBYssL+3BU8q2EDUDmK13Nfb5ORewH0+4KL+wa/jRN3REqQuFmy9zKNwA==
X-Received: by 2002:a2e:3602:0:b0:2a7:970b:b046 with SMTP id d2-20020a2e3602000000b002a7970bb046mr1931761lja.46.1681920726761;
        Wed, 19 Apr 2023 09:12:06 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id m24-20020a2e8718000000b002a8c8fa34bfsm1136966lji.50.2023.04.19.09.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 09:12:06 -0700 (PDT)
Message-ID: <383f6aa0-6150-22b5-425a-f9cf13bdbc50@linaro.org>
Date:   Wed, 19 Apr 2023 18:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: correct qfprom node reg
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>
References: <20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3ntu.xyz>
 <568ebb75-5cb2-af97-bfae-c1e1e6174a45@linaro.org>
 <2401830.jE0xQCEvom@z3ntu.xyz> <5664419.DvuYhMxLoT@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <5664419.DvuYhMxLoT@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.2023 18:00, Luca Weiss wrote:
> Hi Konrad,
> 
> On Montag, 30. Jänner 2023 21:37:29 CEST Luca Weiss wrote:
>> On Montag, 30. Jänner 2023 19:42:51 CET Konrad Dybcio wrote:
>>> On 30.01.2023 19:36, Luca Weiss wrote:
>>>> On Montag, 30. Jänner 2023 19:30:04 CET Konrad Dybcio wrote:
>>>>> On 30.01.2023 19:20, luca@z3ntu.xyz wrote:
>>>>>> From: Craig Tatlor <ctatlor97@gmail.com>
>>>>>>
>>>>>> The qfprom actually starts at 0xfc4b8000 instead of 0xfc4bc000 as
>>>>>> defined previously. Adjust the tsens offsets accordingly.
>>>>>>
>>>>>> [luca@z3ntu.xyz: extract to standalone patch]
>>>>>>
>>>>>> Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and
>>>>>> qfprom nodes") Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
>>>>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>>>>> ---
>>>>>
>>>>> Isn't this a raw vs ecc-corrected values problem?
>>>>
>>>> Not quite sure what you mean.
>>>
>>> The QFPROM is split into two parts: one where raw values
>>> are stored, and the other one where ECC-corrected copies
>>> of them reside. Usually it's at offset of 0x4000. We should
>>> generally be using the ECC-corrected ones, because.. well..
>>> they are ECC-corrected.. You may want to check if the
>>> fuse you're adding reads the same value at +0x4000.
>>
>> Yeah that actually seems to work...
>>
>> But downstream's using this +0x4000 only for tsens it seems
>>
>>    <0xfc4bc000 0x1000> as "tsens_eeprom_physical"
>>
>> qcom,clock-krait-8974 is using this:
>>
>>     <0xfc4b80b0 0x08> as "efuse"
>>
>> Also seems HDMI driver is using a mix for HDCP stuff
>>
>>   drivers/video/msm/mdss/mdss_hdmi_util.h:
>>
>>     /* QFPROM Registers for HDMI/HDCP */
>>     #define QFPROM_RAW_FEAT_CONFIG_ROW0_LSB  (0x000000F8)
>>     #define QFPROM_RAW_FEAT_CONFIG_ROW0_MSB  (0x000000FC)
>>     #define HDCP_KSV_LSB                     (0x000060D8)
>>     #define HDCP_KSV_MSB                     (0x000060DC)
>>
>> Any clue why Qualcomm used it this way in downstream? I'd rather not deviate
>> too much if not for a good reason...
> 
> Any comments on the above?
This thread got burried to deep in the mailbox!

I see two reasons why they could be using the uncorrected region:
- their generators are messed up in general

- they may have had an early chip revision once where there were
  problems with this and their generators were messed up to
  accommodate for it and everybody forgot to fix that

No other good explanations as far as I'm aware!

Konrad

> 
> Regards
> Luca
> 
>>
>> Regards
>> Luca
>>
>>> Konrad
>>>
>>>> The original intention behind this patch is to allow to use the pvs fuse
>>>> at
>>>> (now) 0xb0 which was inaccessible with the former definition.
>>>>
>>>>     pvs: pvs@b0 {
>>>>     
>>>>         reg = <0xb0 0x8>;
>>>>     
>>>>     };
>>>>
>>>> Regards
>>>> Luca
>>>>
>>>>> Konrad
>>>>>
>>>>>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 12 ++++++------
>>>>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
>>>>>> b/arch/arm/boot/dts/qcom-msm8974.dtsi index 8d216a3c0851..922d235c6065
>>>>>> 100644
>>>>>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>>>>>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>>>>>> @@ -1132,16 +1132,16 @@ restart@fc4ab000 {
>>>>>>
>>>>>>  			reg = <0xfc4ab000 0x4>;
>>>>>>  		
>>>>>>  		};
>>>>>>
>>>>>> -		qfprom: qfprom@fc4bc000 {
>>>>>> +		qfprom: qfprom@fc4b8000 {
>>>>>>
>>>>>>  			compatible = "qcom,msm8974-qfprom",
>>>>
>>>> "qcom,qfprom";
>>>>
>>>>>> -			reg = <0xfc4bc000 0x1000>;
>>>>>> +			reg = <0xfc4b8000 0x7000>;
>>>>>>
>>>>>>  			#address-cells = <1>;
>>>>>>  			#size-cells = <1>;
>>>>>>
>>>>>> -			tsens_calib: calib@d0 {
>>>>>> -				reg = <0xd0 0x18>;
>>>>>> +			tsens_calib: calib@40d0 {
>>>>>> +				reg = <0x40d0 0x18>;
>>>>>>
>>>>>>  			};
>>>>>>
>>>>>> -			tsens_backup: backup@440 {
>>>>>> -				reg = <0x440 0x10>;
>>>>>> +			tsens_backup: backup@4440 {
>>>>>> +				reg = <0x4440 0x10>;
>>>>>>
>>>>>>  			};
>>>>>>  		
>>>>>>  		};
>>>>>>
>>>>>> ---
>>>>>> base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
>>>>>> change-id: 20230130-msm8974-qfprom-619c0e8f26eb
>>>>>>
>>>>>> Best regards,
> 
> 
> 
> 
