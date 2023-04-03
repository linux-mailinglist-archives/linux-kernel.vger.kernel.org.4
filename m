Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B253B6D4FA0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjDCRyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjDCRyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:54:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C5F3590
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:53:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k37so39198273lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680544431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fe1puile+CIeu4Oxbg9Rq2eJRWjjHhk67hQmRmGqNb0=;
        b=uEteMWJ/CCIPT3d7X2MBjeVd4Nn5xYSdU/WTTGfJukxogCLoZiSjQVhh05fyjwHgKN
         s/hYUK7dK1os3TufOuzqA1dBb0ZrPbph/WTpIgKo7RQ8S5byapyx12TuegqJDUo2NhYm
         +YnyFtHvbAfJyQyB27x0IQ//EOCY0xZ73IhaPtOgWKDZBn2nShVZDU+C13Ti4an+gmvf
         8vXRsdGSwSGrdrXKYfpJHrfcFXBMqgaXvM9PmtNsCdgnOM1yYt/8TVPKX7h0+oWJrk9p
         N/aiHdANkoEKKe8GEWCGhE4kmZQElQiLT1+LViOZ2wkujN9+EVnWakDpbwN2TeZcKJN2
         gPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fe1puile+CIeu4Oxbg9Rq2eJRWjjHhk67hQmRmGqNb0=;
        b=1aaTe80l48j7IDwHc6N8IM0z+XYdZrWE3/8JtoxalRRHz+t15HAlnhcYHB56rRWVHA
         kNWxiHUvKt3ERc86xjjaqJ7Horz03MuKK2K0sAgdpfrfpVA6Q7QvvQbAQ0blWAwE0qXg
         yHLSaNBt/avlw1IqE3+6z4dnfQmN8L3Bv1wu6K/1KhIbnj0fhrPSQ8NvpSp3sxXXVNfx
         CHuzbiAKsk+y00Nc3iAQ3HOS8cLz/isoeDo2EnmbxV2o0GTWvif9qlIkLlmIDv8lSe5B
         qLSQGhjShboskX/qWW8U1BOj3kaPm43IpRew3TdIpLlnPL2LEnvLU1qv1dKpB4q/dow8
         PDFQ==
X-Gm-Message-State: AAQBX9eqP3p8BuwaHko+9UvqNtgj3vfjr3bc/Y+VXvoXu/E39W3fdSmD
        ojuP4cTwZ0JgztcrTip4qM6b+w==
X-Google-Smtp-Source: AKy350YF+lZZAQb/4jTlpXSTDkQZ84ZHiqGluR+QD0cxob99tywlh4Lwg6ObhfzTpFupVCaMR3Ce4g==
X-Received: by 2002:ac2:488f:0:b0:4cf:e904:bba5 with SMTP id x15-20020ac2488f000000b004cfe904bba5mr10694700lfc.29.1680544430986;
        Mon, 03 Apr 2023 10:53:50 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id h21-20020ac250d5000000b004cca1658a41sm1879087lfm.300.2023.04.03.10.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 10:53:50 -0700 (PDT)
Message-ID: <3c5a9608-ecd2-a3c0-e866-7d0070e49b89@linaro.org>
Date:   Mon, 3 Apr 2023 19:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
 <69df153d-bdc6-9008-39d6-72f66bab2e38@linaro.org>
 <5914a8db-3644-1c94-00ba-460ba2c26a5d@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <5914a8db-3644-1c94-00ba-460ba2c26a5d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.04.2023 16:07, Devi Priya wrote:
> 
> 
> On 3/28/2023 1:58 PM, Konrad Dybcio wrote:
>>
>>
>> On 28.03.2023 08:12, Devi Priya wrote:
>>>
>>>
>>> On 3/27/2023 2:56 PM, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 27.03.2023 10:40, Devi Priya wrote:
>>>>>
>>>>>
>>>>> On 3/18/2023 7:38 PM, Konrad Dybcio wrote:
>>>>>>
>>>>>>
>>>>>> On 14.03.2023 18:15, Devi Priya wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 3/8/2023 3:57 PM, Konrad Dybcio wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 7.03.2023 07:55, Devi Priya wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 3/6/2023 6:39 PM, Devi Priya wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 3/3/2023 6:57 PM, Konrad Dybcio wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 3.03.2023 14:21, Devi Priya wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 2/23/2023 4:31 AM, Mark Brown wrote:
>>>>>>>>>>>>> On Wed, Feb 22, 2023 at 11:11:42PM +0100, Konrad Dybcio wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thinking about it again, this seems like something that could be
>>>>>>>>>>>>>> generalized and introduced into regulator core.. Hardcoding this
>>>>>>>>>>>>>> will not end well.. Not to mention it'll affect all mp5496-using
>>>>>>>>>>>>>> boards that are already upstream.
>>>>>>>>>>>>>
>>>>>>>>>>>>>> WDYT about regulator-init-microvolts Mark?
>>>>>>>>>>>>>
>>>>>>>>>>>>> The overwhelming majority of devices that have variable voltages
>>>>>>>>>>>>> support readback, these Qualcomm firmware devices are pretty much
>>>>>>>>>>>>> unique in this regard.  We don't want a general property to set a
>>>>>>>>>>>>> specific voltage since normally we should be using the
>>>>>>>>>>>>> constraints and don't normally need to adjust things immediately
>>>>>>>>>>>>> since we can tell what the current voltage is.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This is pretty much just going to be a device specific bodge,
>>>>>>>>>>>>> ideally something that does know what the voltage is would be
>>>>>>>>>>>>> able to tell us at runtime but if that's not possible then
>>>>>>>>>>>>> there's no good options.  If the initial voltage might vary based
>>>>>>>>>>>>> on board then a device specific DT property might be less
>>>>>>>>>>>>> terrible, if it's determined by the regulator the current code
>>>>>>>>>>>>> seems fine.  Or just leave the current behavour, if the
>>>>>>>>>>>>> constraints are accurate then hopefully a temporary dip in
>>>>>>>>>>>>> voltage is just inelegant rather than an issue.  Indeed the
>>>>>>>>>>>>> current behaviour might well save power if you've got a voltage
>>>>>>>>>>>>> range configured and nothing actually ever gets round to setting
>>>>>>>>>>>>> the voltage (which is depressingly common, people seem keen on
>>>>>>>>>>>>> setting voltage ranges even when the voltage is never varied in
>>>>>>>>>>>>> practice).
>>>>>>>>>>>>
>>>>>>>>>>>> Hi Mark, The initial bootup voltage is actually blown into the OTP register of the PMIC and it remains the same across boards for IPQ9574 SoC.
>>>>>>>>>>> But what about IPQ6018 which also uses MP5496? That's also gonna
>>>>>>>>>>> set the voltage on there, it may be too high/low..
>>>>>>>>> For IPQ6018, the bootup voltage is the same as that of IPQ9574 which is
>>>>>>>>> 875mV
>>>>>>>> Okay, but what about any other design that employs or may employ
>>>>>>>> MP5496 in the future?
>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>       Initially the SoC runs at 800MHz with a voltage of 875mV set by the bootloaders. As kernel does not know the initial voltage, during regulator registration the framework considers the current voltage to be zero and tries to bring up the regulator to minimum supported voltage of 600mV. This causes the dip which might be of concern in SS parts where the voltage might be insufficient leading to silent reboots.
>>>>>>>>>>> That's an SoC-specific thing, the same regulator can be used with
>>>>>>>>>>> many different ones. We can't just assume it'll always be like this.
>>>>>>>>>>> I see the problem, but I believe this is not the correct solution
>>>>>>>>> Okay, As we had discussions on reading back the voltage & the generic
>>>>>>>>> DT property, do you suggest any other possible solutions here?
>>>>>>>> Due to the sudden influx of various IPQ SoCs on the mailing list lately
>>>>>>>> I have no idea if it concerned this one too, but at least one of them
>>>>>>>> was said not to use RPM for controlling the clocks. If that's the case,
>>>>>>>> I see no reason at all to use it for scaling the regulators, the PMIC
>>>>>>>> could be addressed directly over I2C as a normal device. You'd probably
>>>>>>>> want to keep VDD_[CM]X scaling through rpmpd, but it's easily done by
>>>>>>>> simply not registering the CX/MX registers as children of the I2C
>>>>>>>> regulator IC.
>>>>>>>
>>>>>>> IPQ9574 SoC has RPM and uses it for controlling the regulators.
>>>>>>> Currently, the RPM firmware does not have read support implemented
>>>>>>> and so, we were not able to read the bootup voltage.
>>>>>>> As we randomly saw silent reboots when the kernel boots up,
>>>>>>> do you think we could proceed with this change for time being
>>>>>>> and revisit the same when any SoC in the future employs MP5496?
>>>>>> I'm still thinking about a cleaner fix because hardcoding voltages
>>>>>> in kernel is just dangerous. Could you check whether attaching a CPU
>>>>>> supply and adding an OPP table where each level has an opp-microvolt
>>>>>> property would resolve your issue?
>>>>>>
>>>>>> Konrad
>>>>> Yes, Understood! We already have the CPU supply and OPP table where
>>>>> each level has an opp-microvolt property changes in place and it did
>>>>> not help in our case.
>>>> Ouch. That totally sounds like a bug.. Would you be willing to dig
>>>> a bit further into why this happens?
>>> As the regulator registration happens before the cpu freq scaling comes
>>> into picture, having an OPP table did not help to set the bootup voltage
>> I see, but the order should not affect it. If your regulator driver
>> returns -EPROBE_DEFER, so should the cpufreq one.
>>
>> Konrad
> Sorry konrad, don't exactly get your point here.
> The cpufreq driver depends on the regulator driver to be probed as
> the regulator serves as the cpu-supply.
> But, when the regulator driver comes up, it tries to bring up the
> regulators to the minimum supported voltage provided with the
> regulator-min-microvolt property in the DT.
Right, that exists.. 

Mark, do you think it should be updated such that the requests are
aggregated before assuming min_uV is "just fine"?

> 
> The regulator being the CPU only supply, updating the
> regulator-min-microvolt with SVS voltage (725000uV) would ideally help
> us with the issue. That way, we could update the DT and drop this patch.
> 
> This approach seems quite ideal to us. Shall we proceed with it if we don't foresee any issues?
Yes, please do so as a temporary measure and leave a comment about
it in the device tree so that it's not forgotten about. Ideally
both scaling up and down should be supported..

Konrad
> 
> Thanks,
> Devi Priya
> 
>>>>
>>>> Konrad
>>>>> We have now planned to update the regulator-min-microvolt property
>>>>> with the SVS voltage (725000uV) in the board DT such that the regulators
>>>>> are brought up with the nominal voltage which would be sufficient
>>>>> for all the corner parts operating at 800MHz.
>>>>>
>>>>> That way, we would update the DT and drop this patch in the next spin.
>>>>>
>>>>> Thanks,
>>>>> Devi Priya
>>>>>>>>
>>>>>>>> Konrad
>>>>>>>>>>>
>>>>>>>>>>> Konrad
>>>>>>>>>>>>
>>>>>>>>>>>> Best Regards,
>>>>>>>>>>>> Devi Priya
