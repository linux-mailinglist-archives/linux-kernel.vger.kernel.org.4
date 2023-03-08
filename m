Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AE26B042D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCHK1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCHK1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:27:39 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5852A2697
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:27:37 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r27so20655618lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678271255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pqzvhzkr/44Xe2mAkHsd6BfnXsY6v0my5G9rUWaLipM=;
        b=OJ0sHLu2NiW+5HgUqYDWsaniLsOoz3prGjF3BcnnTrgstffXbGmanm39XDoIMR5Rrh
         gbleXmZVye3Bpz3VL7e6mIUY51SL66z6jl1CAm8/jJonUbVAR9hU3QIDpcxc+uiBLfuf
         BbPMc7SUbAmCdvZWdLrb0HAy+yQZooJtJmurLgdCwFla6uUFjyZSDBXI7qxHec3qosW1
         4Koi3FXDfqFlG92+iMM/IccXGikM/56/W3o7UtECQE4dbXMOm3jNGTnwlfM3Ugak0ISJ
         dTB/x02BYRhfaWql1CYreZhA4ScNYe98o6KIKfZhfrgsV8j/u1KMUr8Qbm9UKIIKdR9q
         6QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqzvhzkr/44Xe2mAkHsd6BfnXsY6v0my5G9rUWaLipM=;
        b=f2HZstHNo5xFItBx0STshl5gehP7wzblCCFbCUJ6D9JFeJf92qxyY2WeudMY4ZkOOs
         lq+0b2jWh44biiSSpE3kFzDNOefvlQXGyewOXelFNgzD4+KhMmYxvNPEmU1Swafincrn
         icNLv1ckf47BtfOCgyY2jsWXh49V0ax0Zs/1NU+1eJLjGzmQcH8FoEKBRLnrocUxIzDx
         aSJIqOY4wzre/YlUEUTRVKa+L/f0tiiCTGeKtoAu6Xtp/+zAq/YQDhNjVQcu/lV/1N+9
         z69d7T/fm666bQhLASZQzWLl+KlmwSaojTUX1PXf4Q/3UnYuyb3y7C5Fv+wDCpEOa/BS
         Yr0Q==
X-Gm-Message-State: AO0yUKVvQ/JRLlwG1GK+diu+kn4/4LFJ2jxWahLi4uORtY/WK5iPUasP
        x/ZZiVpAhXqeuML40wHdgaxgW8T+L8Jtsi7ssqw=
X-Google-Smtp-Source: AK7set8jnuRcG3P/eMiLoTvW4l+ACk0ugQ9b6JGpPojSXJRUFXtieXCL5NzLxCgY+3amPTIZb5cOJA==
X-Received: by 2002:ac2:4a77:0:b0:4e2:cb9:e266 with SMTP id q23-20020ac24a77000000b004e20cb9e266mr4435744lfp.50.1678271255626;
        Wed, 08 Mar 2023 02:27:35 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25598000000b004cb1e2f8f4dsm2290138lfg.152.2023.03.08.02.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:27:35 -0800 (PST)
Message-ID: <3f434777-c4b6-272f-1971-f9adf3faefe4@linaro.org>
Date:   Wed, 8 Mar 2023 11:27:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 4/6] regulator: qcom_smd: Add support to define the
 bootup voltage
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>,
        Mark Brown <broonie@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_ipkumar@quicinc.com
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
 <20230217142030.16012-5-quic_devipriy@quicinc.com>
 <907628d1-b88d-5ac6-ed9d-7f63e2875738@linaro.org>
 <Y/aeu5ua7cY5cGON@sirena.org.uk>
 <39f73580-f263-de0e-6819-89c3f4c75c3a@quicinc.com>
 <8ce07abd-2d02-69d2-8dc6-fe11525aecda@linaro.org>
 <11b05b9f-b969-6648-2204-2da5f8465c96@quicinc.com>
 <751e5129-3c11-0156-719e-3fe996a149be@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <751e5129-3c11-0156-719e-3fe996a149be@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.03.2023 07:55, Devi Priya wrote:
> 
> 
> On 3/6/2023 6:39 PM, Devi Priya wrote:
>>
>>
>> On 3/3/2023 6:57 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 3.03.2023 14:21, Devi Priya wrote:
>>>>
>>>>
>>>> On 2/23/2023 4:31 AM, Mark Brown wrote:
>>>>> On Wed, Feb 22, 2023 at 11:11:42PM +0100, Konrad Dybcio wrote:
>>>>>
>>>>>> Thinking about it again, this seems like something that could be
>>>>>> generalized and introduced into regulator core.. Hardcoding this
>>>>>> will not end well.. Not to mention it'll affect all mp5496-using
>>>>>> boards that are already upstream.
>>>>>
>>>>>> WDYT about regulator-init-microvolts Mark?
>>>>>
>>>>> The overwhelming majority of devices that have variable voltages
>>>>> support readback, these Qualcomm firmware devices are pretty much
>>>>> unique in this regard.  We don't want a general property to set a
>>>>> specific voltage since normally we should be using the
>>>>> constraints and don't normally need to adjust things immediately
>>>>> since we can tell what the current voltage is.
>>>>>
>>>>> This is pretty much just going to be a device specific bodge,
>>>>> ideally something that does know what the voltage is would be
>>>>> able to tell us at runtime but if that's not possible then
>>>>> there's no good options.  If the initial voltage might vary based
>>>>> on board then a device specific DT property might be less
>>>>> terrible, if it's determined by the regulator the current code
>>>>> seems fine.  Or just leave the current behavour, if the
>>>>> constraints are accurate then hopefully a temporary dip in
>>>>> voltage is just inelegant rather than an issue.  Indeed the
>>>>> current behaviour might well save power if you've got a voltage
>>>>> range configured and nothing actually ever gets round to setting
>>>>> the voltage (which is depressingly common, people seem keen on
>>>>> setting voltage ranges even when the voltage is never varied in
>>>>> practice).
>>>>
>>>> Hi Mark, The initial bootup voltage is actually blown into the OTP register of the PMIC and it remains the same across boards for IPQ9574 SoC.
>>> But what about IPQ6018 which also uses MP5496? That's also gonna
>>> set the voltage on there, it may be too high/low..
> For IPQ6018, the bootup voltage is the same as that of IPQ9574 which is
> 875mV
Okay, but what about any other design that employs or may employ
MP5496 in the future?

>>>
>>>   Initially the SoC runs at 800MHz with a voltage of 875mV set by the bootloaders. As kernel does not know the initial voltage, during regulator registration the framework considers the current voltage to be zero and tries to bring up the regulator to minimum supported voltage of 600mV. This causes the dip which might be of concern in SS parts where the voltage might be insufficient leading to silent reboots.
>>> That's an SoC-specific thing, the same regulator can be used with
>>> many different ones. We can't just assume it'll always be like this.
>>> I see the problem, but I believe this is not the correct solution
> Okay, As we had discussions on reading back the voltage & the generic
> DT property, do you suggest any other possible solutions here?
Due to the sudden influx of various IPQ SoCs on the mailing list lately
I have no idea if it concerned this one too, but at least one of them
was said not to use RPM for controlling the clocks. If that's the case,
I see no reason at all to use it for scaling the regulators, the PMIC
could be addressed directly over I2C as a normal device. You'd probably
want to keep VDD_[CM]X scaling through rpmpd, but it's easily done by
simply not registering the CX/MX registers as children of the I2C
regulator IC.

Konrad
>>>
>>> Konrad
>>>>
>>>> Best Regards,
>>>> Devi Priya
