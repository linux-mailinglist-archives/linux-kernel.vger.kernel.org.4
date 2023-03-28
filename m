Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A26CB95F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjC1I2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjC1I2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:28:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BBB4EDB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:28:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k37so14807837lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679992086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JE88YHNFT3bmDtNbJzRh1vBURf+C99Dfd2CogXr/VpY=;
        b=BzlG0WSCGnhaPcYzPplxOIH7Uu6jBt27haCOcrox/uGZFeVoGgPHhd83bp/hYIbAtg
         shav90eDLWlzfuEPHtA8xfH/8r+WKR9FqvzKN5FY7Ac1+U4CzboU52S/ZcGnnox9YJ8L
         w7ks0okOK+p5b14SITzNeFrEktxZpJSQoMEN0IF40HdZoYfxj6YqnbONxwjgT4kO8ZQl
         b7kAj2L5kdaIY630ysreeq0iYEUYXdj1B4twdWy4Row4ymmleTY3TNq4xApCMVCnTlYL
         izKKn25f6x+ULJjWHH4lsFZrj6RD85Mr518OzBg2AXphqpCla64CUGqzi31DkHOKN/wk
         pwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679992086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JE88YHNFT3bmDtNbJzRh1vBURf+C99Dfd2CogXr/VpY=;
        b=DhJn0yEVoWz9Ga5tJGMFBgVZjTvIWKMS64CWTkkHKITRbUaAATPbrr2xInBC76Fzdl
         9Z36XnDpVqhQZ0v2K+jpgs/lbheBHy9z4L8wfMpFZ4UBSxcaRf7kgHSq+Fa3o+m5BW6L
         BTpYFjZuO9LRNaU0wKO1ZNMUR6Q3vC9M+lGUSVooRE3zmG+XSA2/upV1PhpQQWvezxb5
         Td390cE5+yzEaTGrR1hJImvTlPISkcXk02EtcRV8Ujx4peNtr8qt1mPlNdnJbvNROUC3
         aGj0uyWQoXM2XDDjRasa2qEGgMX4yB0AiV3HlUo2CysyxrRVhIotqk7CuZ9j4lhjmCcZ
         CZHQ==
X-Gm-Message-State: AAQBX9dk9jdDnzamAJhHW2AMB+1wVwgC47QXQgNH0mQHsJRKgC/UM36v
        XxeuBi+k41wTQ8ndL+SAs0h/evlDLs14aKQ+VD4=
X-Google-Smtp-Source: AKy350ZFugCkesDuzC6rChyO8n6ljb82ESIK/SUwg6xuGnimM7oSEmURQO0igqHzwwYpRRpNSPFcyg==
X-Received: by 2002:ac2:43bc:0:b0:4e9:bf83:2f8c with SMTP id t28-20020ac243bc000000b004e9bf832f8cmr4221374lfl.38.1679992086016;
        Tue, 28 Mar 2023 01:28:06 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id b6-20020a056512218600b004e8452972a2sm4971742lft.247.2023.03.28.01.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:28:05 -0700 (PDT)
Message-ID: <69df153d-bdc6-9008-39d6-72f66bab2e38@linaro.org>
Date:   Tue, 28 Mar 2023 10:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
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
 <ca12735e-d6c8-997e-036f-693cd8a9870f@linaro.org>
 <e19393e3-5898-bff2-cc00-d88c9194c7c2@quicinc.com>
 <6e1f6466-7f2e-7bd5-f6a2-5691a30c4e1f@linaro.org>
 <9989c92c-9949-5531-c7d2-e54882795a68@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <9989c92c-9949-5531-c7d2-e54882795a68@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.03.2023 08:12, Devi Priya wrote:
> 
> 
> On 3/27/2023 2:56 PM, Konrad Dybcio wrote:
>>
>>
>> On 27.03.2023 10:40, Devi Priya wrote:
>>>
>>>
>>> On 3/18/2023 7:38 PM, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 14.03.2023 18:15, Devi Priya wrote:
>>>>>
>>>>>
>>>>> On 3/8/2023 3:57 PM, Konrad Dybcio wrote:
>>>>>>
>>>>>>
>>>>>> On 7.03.2023 07:55, Devi Priya wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 3/6/2023 6:39 PM, Devi Priya wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 3/3/2023 6:57 PM, Konrad Dybcio wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 3.03.2023 14:21, Devi Priya wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2/23/2023 4:31 AM, Mark Brown wrote:
>>>>>>>>>>> On Wed, Feb 22, 2023 at 11:11:42PM +0100, Konrad Dybcio wrote:
>>>>>>>>>>>
>>>>>>>>>>>> Thinking about it again, this seems like something that could be
>>>>>>>>>>>> generalized and introduced into regulator core.. Hardcoding this
>>>>>>>>>>>> will not end well.. Not to mention it'll affect all mp5496-using
>>>>>>>>>>>> boards that are already upstream.
>>>>>>>>>>>
>>>>>>>>>>>> WDYT about regulator-init-microvolts Mark?
>>>>>>>>>>>
>>>>>>>>>>> The overwhelming majority of devices that have variable voltages
>>>>>>>>>>> support readback, these Qualcomm firmware devices are pretty much
>>>>>>>>>>> unique in this regard.  We don't want a general property to set a
>>>>>>>>>>> specific voltage since normally we should be using the
>>>>>>>>>>> constraints and don't normally need to adjust things immediately
>>>>>>>>>>> since we can tell what the current voltage is.
>>>>>>>>>>>
>>>>>>>>>>> This is pretty much just going to be a device specific bodge,
>>>>>>>>>>> ideally something that does know what the voltage is would be
>>>>>>>>>>> able to tell us at runtime but if that's not possible then
>>>>>>>>>>> there's no good options.  If the initial voltage might vary based
>>>>>>>>>>> on board then a device specific DT property might be less
>>>>>>>>>>> terrible, if it's determined by the regulator the current code
>>>>>>>>>>> seems fine.  Or just leave the current behavour, if the
>>>>>>>>>>> constraints are accurate then hopefully a temporary dip in
>>>>>>>>>>> voltage is just inelegant rather than an issue.  Indeed the
>>>>>>>>>>> current behaviour might well save power if you've got a voltage
>>>>>>>>>>> range configured and nothing actually ever gets round to setting
>>>>>>>>>>> the voltage (which is depressingly common, people seem keen on
>>>>>>>>>>> setting voltage ranges even when the voltage is never varied in
>>>>>>>>>>> practice).
>>>>>>>>>>
>>>>>>>>>> Hi Mark, The initial bootup voltage is actually blown into the OTP register of the PMIC and it remains the same across boards for IPQ9574 SoC.
>>>>>>>>> But what about IPQ6018 which also uses MP5496? That's also gonna
>>>>>>>>> set the voltage on there, it may be too high/low..
>>>>>>> For IPQ6018, the bootup voltage is the same as that of IPQ9574 which is
>>>>>>> 875mV
>>>>>> Okay, but what about any other design that employs or may employ
>>>>>> MP5496 in the future?
>>>>>>
>>>>>>>>>
>>>>>>>>>      Initially the SoC runs at 800MHz with a voltage of 875mV set by the bootloaders. As kernel does not know the initial voltage, during regulator registration the framework considers the current voltage to be zero and tries to bring up the regulator to minimum supported voltage of 600mV. This causes the dip which might be of concern in SS parts where the voltage might be insufficient leading to silent reboots.
>>>>>>>>> That's an SoC-specific thing, the same regulator can be used with
>>>>>>>>> many different ones. We can't just assume it'll always be like this.
>>>>>>>>> I see the problem, but I believe this is not the correct solution
>>>>>>> Okay, As we had discussions on reading back the voltage & the generic
>>>>>>> DT property, do you suggest any other possible solutions here?
>>>>>> Due to the sudden influx of various IPQ SoCs on the mailing list lately
>>>>>> I have no idea if it concerned this one too, but at least one of them
>>>>>> was said not to use RPM for controlling the clocks. If that's the case,
>>>>>> I see no reason at all to use it for scaling the regulators, the PMIC
>>>>>> could be addressed directly over I2C as a normal device. You'd probably
>>>>>> want to keep VDD_[CM]X scaling through rpmpd, but it's easily done by
>>>>>> simply not registering the CX/MX registers as children of the I2C
>>>>>> regulator IC.
>>>>>
>>>>> IPQ9574 SoC has RPM and uses it for controlling the regulators.
>>>>> Currently, the RPM firmware does not have read support implemented
>>>>> and so, we were not able to read the bootup voltage.
>>>>> As we randomly saw silent reboots when the kernel boots up,
>>>>> do you think we could proceed with this change for time being
>>>>> and revisit the same when any SoC in the future employs MP5496?
>>>> I'm still thinking about a cleaner fix because hardcoding voltages
>>>> in kernel is just dangerous. Could you check whether attaching a CPU
>>>> supply and adding an OPP table where each level has an opp-microvolt
>>>> property would resolve your issue?
>>>>
>>>> Konrad
>>> Yes, Understood! We already have the CPU supply and OPP table where
>>> each level has an opp-microvolt property changes in place and it did
>>> not help in our case.
>> Ouch. That totally sounds like a bug.. Would you be willing to dig
>> a bit further into why this happens?
> As the regulator registration happens before the cpu freq scaling comes
> into picture, having an OPP table did not help to set the bootup voltage
I see, but the order should not affect it. If your regulator driver
returns -EPROBE_DEFER, so should the cpufreq one.

Konrad
>>
>> Konrad
>>> We have now planned to update the regulator-min-microvolt property
>>> with the SVS voltage (725000uV) in the board DT such that the regulators
>>> are brought up with the nominal voltage which would be sufficient
>>> for all the corner parts operating at 800MHz.
>>>
>>> That way, we would update the DT and drop this patch in the next spin.
>>>
>>> Thanks,
>>> Devi Priya
>>>>>>
>>>>>> Konrad
>>>>>>>>>
>>>>>>>>> Konrad
>>>>>>>>>>
>>>>>>>>>> Best Regards,
>>>>>>>>>> Devi Priya
