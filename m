Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6EA6A59A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjB1NBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjB1NBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:01:34 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42E83018E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:01:31 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id t11so13097521lfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677589290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmcENpXNJMP3+mRcBEtL4u5TWOcKvk1vpFTsGy9hwFM=;
        b=VrZ/pzNMVRji1QXeGg83jSBpLU91PqZRnN0EshQ8nl80gpDPBt/Ni7olYSRbt5H2zA
         ncW9bBeyB7t8Pi04F6n4YFBY6GUYnvYabHf10AQpNR1BnlUDm1Pc57khoAldzPplTTU3
         Y9o6dXtZkfOIFcElCVRyx9mzhK1qbNvKpJGyx4+mxvyPna1akGlfSbPM7PKrn8aE9pT3
         tikPks45aQwDG6CpMXEXd+qI/65kqBpO5TNTeMw3nSrQ0yk7TVq4FvbEfvX2ngRFhZM8
         4Mq4aeVf6mB0/RUivTOPMiAxApMveTnqhCsCwKkHccHVGeqUZat+AvLfZYU0v5J2WO+v
         EWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677589290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmcENpXNJMP3+mRcBEtL4u5TWOcKvk1vpFTsGy9hwFM=;
        b=Drxi7HGJ8T19ek933Fk/IFBpyGdhiSagzj//JET3SViSaerudc1m/7NjEKUdmCeTnu
         gA10dAK4HWKRcnKq0N8kohDodJCGZkg5bMjyAyU6e0ne/RqfiistJxniqjISCOYTZWvH
         opsEd83ue6fVy7gcpw8clJ8yxb4SZ2m0U2kOWYdvWSDCoiDXno5aq72GzApqJFs8pDGc
         ai9mdt6y7E6cOsLjC0VU2o8Ty5Bis5pjWBWrnyh+mACeas9fKmpcrfGUHDL2QQ4NIEYf
         MPaz+eyzbHbtbOH3XOrb01uhK2U+P8qBPqtVl2VBMnNlT77trkspnPy8jV7g2XvjwbnJ
         jCNQ==
X-Gm-Message-State: AO0yUKWc7vBfAr5fzAUTOtPmzsntj8ulSGj3XVoOqt9/u+3U0A0Ko/p9
        7pJhzWNZoSuq+a9Kk4TcrekIZA==
X-Google-Smtp-Source: AK7set+xxjCs4P3sX8/fDJiixYPr+PmoXyz7rzf6qHqL+iRZCbnxRVf0GMVJO8FuBGAkHB0PngojZQ==
X-Received: by 2002:a19:5511:0:b0:4e1:13fa:bf07 with SMTP id n17-20020a195511000000b004e113fabf07mr602899lfe.43.1677589289993;
        Tue, 28 Feb 2023 05:01:29 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j27-20020ac2551b000000b004dc4cb4f9c4sm1332478lfk.35.2023.02.28.05.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 05:01:29 -0800 (PST)
Message-ID: <e07ede3a-3412-0ec1-4f6d-ffa406465d3a@linaro.org>
Date:   Tue, 28 Feb 2023 14:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 5/6] soc: qcom: Add support for Core Power Reduction
 v3, v4 and Hardened
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
 <20230217-topic-cpr3h-v10-5-67aed8fdfa61@linaro.org>
 <153ef3e0-9978-d201-44ad-3a5e55eeef4f@linaro.org>
 <8c105a4f-f450-8fbf-ff0b-5629a47c1463@collabora.com>
 <d2784517-0f0c-43a5-63a6-57f6aa3e5912@linaro.org>
 <8a813713-c60d-4726-0c62-de032db99ede@collabora.com>
 <CAA8EJpprXe3k6Kecg6v-QHT-qP=QjimFZFpLWjPqky3M=J+x+A@mail.gmail.com>
 <5e7f9d22-b918-bdfc-931c-0e679c1e946d@collabora.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <5e7f9d22-b918-bdfc-931c-0e679c1e946d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.02.2023 09:19, AngeloGioacchino Del Regno wrote:
> Il 27/02/23 14:20, Dmitry Baryshkov ha scritto:
>> On Mon, 27 Feb 2023 at 15:06, AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> wrote:
>>>
>>> Il 27/02/23 13:01, Dmitry Baryshkov ha scritto:
>>>>
>>>> I took a glance at the 'cpufreq: qcom-hw: Implement CPRh aware OSM programming'
>>>> patch, it doesn't seem to use the header (maybe I checked the older version of the
>>>> patch). As for me, this is another signal that cpr_ext_data should come together
>>>> with the LUT programming rather than with the CPRh itself.
>>>>
>>>>> Konrad, perhaps you can send the cpufreq-hw commits in a separate series, in
>>>>> which cover letter you mention a dependency on this one?
>>>>> That would *clearly* show the full picture to reviewers.
If by "the cpufreq-hw commits" you mean the OSM enablement, that's
the plan! I just don't think sending it parallel to this series
makes a whole lot of sense logistically (even though it does
logically), as they both are quite gigantic..

For reference, here's the last revision that made it to lkml, I think:

https://lore.kernel.org/phone-devel/20210701105730.322718-7-angelogioacchino.delregno@somainline.org/

>>>>
>>>> Yes, that would be great. A small note regarding those patches. I see that you
>>>> patched the qcom-cpufreq-hw.c. This way first the driver programs the LUT, then it
>>>> reads it back to setup the OPPs. Would it be easier to split OSM-not-programmed
>>>> driver?
>>>>
>>>
>>> When I engineered that solution, I kept the cpufreq-hw reading *again* the values
>>> from OSM to keep the driver *fully* compatible with the bootloader-programmed OSM
>>> flow, which makes one thing (in my opinion) perfectly clear: that programming
>>> sequence is exactly the same as what happens "under the hood" on SDM845 (and later)
>>> but performed here-instead-of-there (linux instead of bootloader), with the actual
>>> scaling driver being 100% the same between the two flows in the end.
>>>
>>> Having two drivers as you suggested would indeed achieve the same, but wouldn't be
>>> any easier... if you do that, you'd have to *somehow* make sure that the
>>> programming driver does its job before the cpufreq driver tries to read the OSM
>>> status, adding one more link to an already long chain.
>>>
>>> Besides, I remember that this question got asked a while ago on the mailing lists
>>> and there was a short discussion about it:
>>>
>>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2555580.html
>>
>> Ack, I see. Maybe splitting LUT programming to a separate source file
>> would emphasise the fact that it is only required for some (older)
> 
> Maybe. I'm not sure it's worth adding a new helper file, but I don't really have
> any strong arguments against...
> 
> Konrad, your call.
qcom-cpufreq-hw.c is currently a driver for a small subset of the
functionality that's available from the hardware behind it. Hence I
reckon it'd only be correct to also keep all the "proper" setup there,
as it concerns the same hardware, just that previously one did not need
to utilize it fully, as the boot firmware ever so graciously performed
that exact same setup with elevated privileges and before jumping
to HLOS.

Konrad

> 
> Cheers!
> Angelo
> 
>> SoCs. Other than that, I have no additional comments for that series.
>>
