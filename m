Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AF36A414F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjB0MBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjB0MBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:01:20 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBF01633D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 04:01:18 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z5so6153433ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 04:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfHHQXugEcdy+Rrfa7ItXE3CF7B0+eNK7PBHqmJuXxU=;
        b=Dsy7zWx53ZriKinglkKi+9u6oZ3iqsWLAjRbLrGEesW8fvW+Mj7MjtyYGMKvMjvcgM
         8aXWLJ472UQDgdG+KLr2jU4bLdutLwUSMUZk8Rs7OH5Bro1nLhYagdW67JzVJEJP0lsm
         93+7kXFVHIaM4FvLKol0TMHXxXXIMy61DQCk+53esRfB5HfkUxBJG87ozSUGzgcGS0kh
         hpsUsbJ0RScu+UEpNzatLURDivBmc/zrmucDLyVAK1WW7NH5JqBuc/YMa9csnwuz7tyn
         on42/zAbf/Iuy6nwzebfzLvwK6sNDSLwDJc09KQQ7EYPANPWOEy5kRwfTy5cxZh27zgz
         /EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfHHQXugEcdy+Rrfa7ItXE3CF7B0+eNK7PBHqmJuXxU=;
        b=TIX8YzHBjo/9UDV+8vK9LTC0gn4+lvk1oSGSeLLaAE5Nr7R+SfC+G5sHwyOCs7WQ12
         QShlSJc4icUy+TZTTjs4JH0cy7L/HjIZC+q6eE9yv3eW7TXf6ywtCBlYsNHrEAD4UoxV
         qoeMfdq0RdrV0WAFdg5NmAQRfVk4KipOcgBlsUxZ2emazlJzmdwlD3hvbi9JklZlzQwr
         svxm3saoEKJBMzeWRYHfUg3lstX9SQsTZYyk0za8l2GB0erGd/vUhPMBDFuofzxpMvrz
         O3mGLqeYWrzeJSHpOvHm4NNzFxnFp9XbTd9B1NmD1pcq2k/r2hXtAEJXuh2+TwLJkX2c
         9itA==
X-Gm-Message-State: AO0yUKWNPx8OUDDqDboDYSOnoDZL7Wy/p6UK7c3Ct99MqG0BqLYaENG/
        OOq1rdIe5Qx1SsGDuSo/5XljKA==
X-Google-Smtp-Source: AK7set/UawgvhDtrmJxn8Yh7RHXxAMOQGOJYeX5ptFfyG6L5uy29bHmB3YyRjy8Ot9felMvpJ7o6dg==
X-Received: by 2002:a05:651c:509:b0:293:2b55:3608 with SMTP id o9-20020a05651c050900b002932b553608mr11697674ljp.15.1677499277008;
        Mon, 27 Feb 2023 04:01:17 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v3-20020a056512048300b004d869c1861esm880119lfq.192.2023.02.27.04.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 04:01:16 -0800 (PST)
Message-ID: <d2784517-0f0c-43a5-63a6-57f6aa3e5912@linaro.org>
Date:   Mon, 27 Feb 2023 14:01:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v10 5/6] soc: qcom: Add support for Core Power Reduction
 v3, v4 and Hardened
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
 <20230217-topic-cpr3h-v10-5-67aed8fdfa61@linaro.org>
 <153ef3e0-9978-d201-44ad-3a5e55eeef4f@linaro.org>
 <8c105a4f-f450-8fbf-ff0b-5629a47c1463@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <8c105a4f-f450-8fbf-ff0b-5629a47c1463@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 11:13, AngeloGioacchino Del Regno wrote:
> Il 27/02/23 03:55, Dmitry Baryshkov ha scritto:
>> On 17/02/2023 13:08, Konrad Dybcio wrote:
>>> From: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@somainline.org>
>>>
>>> This commit introduces a new driver, based on the one for cpr v1,
>>> to enable support for the newer Qualcomm Core Power Reduction
>>> hardware, known downstream as CPR3, CPR4 and CPRh, and support
>>> for MSM8998 and SDM630 CPU power reduction.
>>>
>>> In these new versions of the hardware, support for various new
>>> features was introduced, including voltage reduction for the GPU,
>>> security hardening and a new way of controlling CPU DVFS,
>>> consisting in internal communication between microcontrollers,
>>> specifically the CPR-Hardened and the Operating State Manager.
>>>
>>> The CPR v3, v4 and CPRh are present in a broad range of SoCs,
>>> from the mid-range to the high end ones including, but not limited
>>> to, MSM8953/8996/8998, SDM630/636/660/845.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@somainline.org>
>>> [Konrad: rebase, apply review comments]
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   drivers/soc/qcom/Kconfig      |   22 +
>>>   drivers/soc/qcom/Makefile     |    4 +-
>>>   drivers/soc/qcom/cpr-common.h |    2 +
>>>   drivers/soc/qcom/cpr3.c       | 2923 
>>> +++++++++++++++++++++++++++++++++++++++++
>>>   include/soc/qcom/cpr.h        |   17 +
>>>   5 files changed, 2967 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/soc/qcom/cpr.h b/include/soc/qcom/cpr.h
>>> new file mode 100644
>>> index 000000000000..2ba4324d18f6
>>> --- /dev/null
>>> +++ b/include/soc/qcom/cpr.h
>>> @@ -0,0 +1,17 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (c) 2013-2020, The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2019 Linaro Limited
>>> + * Copyright (c) 2021, AngeloGioacchino Del Regno
>>> + *                     <angelogioacchino.delregno@somainline.org>
>>> + */
>>> +
>>> +#ifndef __CPR_H__
>>> +#define __CPR_H__
>>> +
>>> +struct cpr_ext_data {
>>> +    int mem_acc_threshold_uV;
>>> +    int apm_threshold_uV;
>>> +};
>>
>> Who is going to use this? Is it the cpufreq driver or some other driver?
>> We are adding an API without a clean user, can we drop it for now?
>>
> 
> This is mandatory: qcom-cpufreq-hw is supposed to program the OSM before
> starting.

Thanks for the explanation!

> 
>  From SDM845 onwards, the OSM is programmed by the bootloader before 
> booting
> Linux;
> In MSM8996/98, SDM630/636/660, others, the bootloader does not program 
> the OSM
> uC, so this has to be done in Linux - specifically, in the CPUFREQ driver
> (qcom-cpufreq-hw), otherwise this driver is completely pointless to have.
> 
> CPU DVFS requires three uC to be correctly programmed in order to work:
>   - SAW (for sleep states)

I believe this is handled by the PCSI for all mentioned platforms.

>   - CPR-Hardened (voltage control, mandatory for stability)

This driver (nit: 8996 has cpr3)

>   - OSM (for cpufreq-hw frequency steps [1..N])

I think this is valid only for the CPRh targets. And for OSM programming 
the driver populates OPP tables with voltage levels (which should then 
be handled by the cpufreq-hw).

I'd toss another coin into the list: for 8996 we also have to program 
APM and cluster (kryo) regulators _manually_.

> 
> Failing to *correctly* program either of the three will render CPU DVFS 
> unusable.
> 
> 
> That clarified, my opinion is:
> No, you can't drop this. It's an essential piece for functionality.
> 
> I agree in that this commit introduces a header that has only an 
> internal (as in
> cpr3.c) user and no external ones, but I think that Konrad didn't want 
> to include
> the qcom-cpufreq-hw.c commits in this series because it's already huge 
> and pretty
> difficult to review; adding the cpufreq-hw commits would make the 
> situation worse.

Perhaps we misunderstand each other here. I suggest dropping the header 
from _this_ patchset only and submit/merge corresponding code together 
with the cpufreq-hw changes. This might sound like a complication, but 
in reality it allows one to assess corresponding code separately.

(Moreover, please correct me if I'm wrong, I think this header will be 
used only with the CPRh, and so this has no use for CPR3/4. Is this 
correct?)

I took a glance at the 'cpufreq: qcom-hw: Implement CPRh aware OSM 
programming' patch, it doesn't seem to use the header (maybe I checked 
the older version of the patch). As for me, this is another signal that 
cpr_ext_data should come together with the LUT programming rather than 
with the CPRh itself.

> Konrad, perhaps you can send the cpufreq-hw commits in a separate 
> series, in
> which cover letter you mention a dependency on this one?
> That would *clearly* show the full picture to reviewers.

Yes, that would be great. A small note regarding those patches. I see 
that you patched the qcom-cpufreq-hw.c. This way first the driver 
programs the LUT, then it reads it back to setup the OPPs. Would it be 
easier to split OSM-not-programmed driver?

> 
> I remember that when I sent the cpufreq-hw series along with this one 
> (~2 years
> ago, I think?) that code had positive reviews from Bjorn, so it should 
> be OK.
> It wasn't picked just-only-because of the cpr3 dependency.
> 
> Regards,
> Angelo
> 
>>> +
>>> +#endif /* __CPR_H__ */
>>>
>>
> 
> 
> 

-- 
With best wishes
Dmitry

