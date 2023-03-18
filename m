Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C35E6BFAAB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCROIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCROIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:08:44 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8C22027
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 07:08:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 20so691744lju.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679148520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HB3cmv6Sv7SdleBzkv5B5PR9GUQ7sHBXprhMZpqwa7M=;
        b=ukwSAx9A44DJyzN8axz+CRS4ixmUIY02BAL44IvhhXqNGwpBWtYmu0gn4/7z6gEFv0
         UKBu2DIv9Qq0kKCn8a6z3hsVtzKa4t86T7UbL4HgB5yKb2g8sBX0HyelCVgv4KRO52Ly
         4FRE+/Fm1qr+LP2gLoHe84WkFZDEAVm9Fp+PJgdNq9IcYSwwW8YheR394nUgbp1L7DJT
         CPFjSnOzVTKCbiJL8o1fSJ91VINdEmPDgpGZOfWW7o6s8CgazywB4aIOTylYLrmJVT0b
         lcQhu+9Pa4IIpOTM3O1bDaUchMmOP5sH3vV0mEKAForgsIWQYEu0TUicl91m349LNZpo
         kcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679148520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HB3cmv6Sv7SdleBzkv5B5PR9GUQ7sHBXprhMZpqwa7M=;
        b=rtSz/zdHMW2ZiChWRJnWYxqE++VRMlsTFeLsOxurc20OqsQ/w+rG5bLcLmCh+CPfaF
         bXLFwBK7LmpCgE5ehnI0q0/anKnlDzmTLg9/hqK6S6DYVn1d8JsiiSePkfnVJFrkYzRW
         KDNLCqxxDBa0Go5oT8EI1WAxz03rbrLQNIQfJiJluA9Z92XkAs1gIPPdL70Bz6L6mHUR
         UGwcP+1yLRb8A1AKt1FZWYxl4l7hUx2wb/11NBUaoKUg12TkfHXE/Qnp4vGVBIGenuMm
         OO5oo4msJroLQgOmOvu38QrXnsaKz0aQ+TVpDBGXe1Bw4Lonbgz3gt9rZ2+URgEfu0fK
         ALlg==
X-Gm-Message-State: AO0yUKVEALZENasKyEKEbADGfxUQYKA5t9ncI77Ss8i0PF5/V13rbCuR
        K5/eB5G7U4+me6BLxXyLykxBxQ==
X-Google-Smtp-Source: AK7set84fWddd9NO3HF0LBnwqDWLvPpSSlFEZ/L86hkrs1DNox9R/gPMzMKkcA5zkZMCaOLh/o6V9A==
X-Received: by 2002:a05:651c:508:b0:294:6cde:b9f3 with SMTP id o8-20020a05651c050800b002946cdeb9f3mr6315626ljp.37.1679148520157;
        Sat, 18 Mar 2023 07:08:40 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id u5-20020ac24c25000000b004e7a0f67490sm842607lfq.110.2023.03.18.07.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 07:08:39 -0700 (PDT)
Message-ID: <ca12735e-d6c8-997e-036f-693cd8a9870f@linaro.org>
Date:   Sat, 18 Mar 2023 15:08:37 +0100
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
 <3f434777-c4b6-272f-1971-f9adf3faefe4@linaro.org>
 <a54d4e1b-d62d-559d-1882-e460e696c056@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a54d4e1b-d62d-559d-1882-e460e696c056@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.03.2023 18:15, Devi Priya wrote:
> 
> 
> On 3/8/2023 3:57 PM, Konrad Dybcio wrote:
>>
>>
>> On 7.03.2023 07:55, Devi Priya wrote:
>>>
>>>
>>> On 3/6/2023 6:39 PM, Devi Priya wrote:
>>>>
>>>>
>>>> On 3/3/2023 6:57 PM, Konrad Dybcio wrote:
>>>>>
>>>>>
>>>>> On 3.03.2023 14:21, Devi Priya wrote:
>>>>>>
>>>>>>
>>>>>> On 2/23/2023 4:31 AM, Mark Brown wrote:
>>>>>>> On Wed, Feb 22, 2023 at 11:11:42PM +0100, Konrad Dybcio wrote:
>>>>>>>
>>>>>>>> Thinking about it again, this seems like something that could be
>>>>>>>> generalized and introduced into regulator core.. Hardcoding this
>>>>>>>> will not end well.. Not to mention it'll affect all mp5496-using
>>>>>>>> boards that are already upstream.
>>>>>>>
>>>>>>>> WDYT about regulator-init-microvolts Mark?
>>>>>>>
>>>>>>> The overwhelming majority of devices that have variable voltages
>>>>>>> support readback, these Qualcomm firmware devices are pretty much
>>>>>>> unique in this regard.  We don't want a general property to set a
>>>>>>> specific voltage since normally we should be using the
>>>>>>> constraints and don't normally need to adjust things immediately
>>>>>>> since we can tell what the current voltage is.
>>>>>>>
>>>>>>> This is pretty much just going to be a device specific bodge,
>>>>>>> ideally something that does know what the voltage is would be
>>>>>>> able to tell us at runtime but if that's not possible then
>>>>>>> there's no good options.  If the initial voltage might vary based
>>>>>>> on board then a device specific DT property might be less
>>>>>>> terrible, if it's determined by the regulator the current code
>>>>>>> seems fine.  Or just leave the current behavour, if the
>>>>>>> constraints are accurate then hopefully a temporary dip in
>>>>>>> voltage is just inelegant rather than an issue.  Indeed the
>>>>>>> current behaviour might well save power if you've got a voltage
>>>>>>> range configured and nothing actually ever gets round to setting
>>>>>>> the voltage (which is depressingly common, people seem keen on
>>>>>>> setting voltage ranges even when the voltage is never varied in
>>>>>>> practice).
>>>>>>
>>>>>> Hi Mark, The initial bootup voltage is actually blown into the OTP register of the PMIC and it remains the same across boards for IPQ9574 SoC.
>>>>> But what about IPQ6018 which also uses MP5496? That's also gonna
>>>>> set the voltage on there, it may be too high/low..
>>> For IPQ6018, the bootup voltage is the same as that of IPQ9574 which is
>>> 875mV
>> Okay, but what about any other design that employs or may employ
>> MP5496 in the future?
>>
>>>>>
>>>>>    Initially the SoC runs at 800MHz with a voltage of 875mV set by the bootloaders. As kernel does not know the initial voltage, during regulator registration the framework considers the current voltage to be zero and tries to bring up the regulator to minimum supported voltage of 600mV. This causes the dip which might be of concern in SS parts where the voltage might be insufficient leading to silent reboots.
>>>>> That's an SoC-specific thing, the same regulator can be used with
>>>>> many different ones. We can't just assume it'll always be like this.
>>>>> I see the problem, but I believe this is not the correct solution
>>> Okay, As we had discussions on reading back the voltage & the generic
>>> DT property, do you suggest any other possible solutions here?
>> Due to the sudden influx of various IPQ SoCs on the mailing list lately
>> I have no idea if it concerned this one too, but at least one of them
>> was said not to use RPM for controlling the clocks. If that's the case,
>> I see no reason at all to use it for scaling the regulators, the PMIC
>> could be addressed directly over I2C as a normal device. You'd probably
>> want to keep VDD_[CM]X scaling through rpmpd, but it's easily done by
>> simply not registering the CX/MX registers as children of the I2C
>> regulator IC.
> 
> IPQ9574 SoC has RPM and uses it for controlling the regulators.
> Currently, the RPM firmware does not have read support implemented
> and so, we were not able to read the bootup voltage.
> As we randomly saw silent reboots when the kernel boots up,
> do you think we could proceed with this change for time being
> and revisit the same when any SoC in the future employs MP5496?
I'm still thinking about a cleaner fix because hardcoding voltages
in kernel is just dangerous. Could you check whether attaching a CPU
supply and adding an OPP table where each level has an opp-microvolt
property would resolve your issue?

Konrad
>>
>> Konrad
>>>>>
>>>>> Konrad
>>>>>>
>>>>>> Best Regards,
>>>>>> Devi Priya
