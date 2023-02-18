Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471F369BBE9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBRUkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBRUku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:40:50 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D015552
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 12:40:47 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f6so1646492lfs.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 12:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9yjE3QCCJiFeu3KJrY/us9LWq5B0xDXPEFfZAbBjes=;
        b=KHJZO0rnrAUZZS6r1uhqxXpozu3AvCyL7ufaN1/xRERjundfnIwRvtcbKwZmm9nGd3
         w/kcXKCW1tlRE6l3P4+LOLyVhZSJJGWVtKqDp0G5I3zlzrzX0SKQD93nn0oMh6265vTC
         sqUafVt2ypBqWrY4wtPE30sjF4Rj0yLtHS6ryTrsDVe9otxcIlsV9PW2IS+//eAVnv54
         ITBBXA2ZZy/BiRQ1JPV50h4a8/DQ9kfynKbXQj3spsSnEOw067BIbYfGXcNzWXupCf3K
         eF5otShLJIMlI4wjTsTm6ZkFMWpgDsy29gYUZ1DHehrZgfv4WlQuTFidvNi9329BH86z
         5N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9yjE3QCCJiFeu3KJrY/us9LWq5B0xDXPEFfZAbBjes=;
        b=Z4po3yGYNUDDTfH+EtlxfdPLGUNtqr6y9NLCmEg1zqCMWJ6bKWQO/t+9wxniyj4Ixo
         sQzRlqzGYyywFy+83NugxkfZVmL+KorpCaHFzZzMXo+gf4aDiNM8QUsciRoCByrgb98y
         KiP1MHMpQaHRuuT5kn4TTll6wmWVK7btlPKgpnv3BojYfyvSuuh07I/14aSmda8xZXHK
         PDzGWY6CVIhfD3V0yE70t5wps94i2o3h/zCDcU89Vh6uhfZf0BRr0USW2QHXDYhcg6vV
         pyNxI3GDJE5xfYSf31kM8oBOD7MMOFvIs78Rk6OH4qjKfICmpi4UcK15P1adB/Fs6kHJ
         zlOQ==
X-Gm-Message-State: AO0yUKVFaoMzlIvUboUklMod8nvE3H7Tp0j97AucWsUqGcJlP54MjXJL
        2HVvquUECyFxX1eWhoocCbGbCA==
X-Google-Smtp-Source: AK7set9sgSvx1S75m5oSL7RJvWAtaTcMk+G9MF08BmwzRwqYneDqLgU3tw/H270GjDJi8A6BrbUA5A==
X-Received: by 2002:ac2:5305:0:b0:4dc:807a:d13e with SMTP id c5-20020ac25305000000b004dc807ad13emr61998lfh.55.1676752845336;
        Sat, 18 Feb 2023 12:40:45 -0800 (PST)
Received: from [192.168.1.101] (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id c25-20020ac244b9000000b004d85789cef1sm1067946lfm.49.2023.02.18.12.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 12:40:44 -0800 (PST)
Message-ID: <2a7a43f1-a13d-f094-5167-de74d5092d91@linaro.org>
Date:   Sat, 18 Feb 2023 21:40:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/4] cpufreq: qcom-nvmem: make qcom_cpufreq_get_msm_id()
 return the SoC ID
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        agross@kernel.org, andersson@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230121112947.53433-1-robimarko@gmail.com>
 <20230121112947.53433-4-robimarko@gmail.com>
 <d71e8a18-8a09-c722-d9dd-b2d48615828f@linaro.org>
 <CAA8EJppwNVtUjB7fUZSCrZ88Ssbhmc4HD6oA2nV0uEx+vHBXUw@mail.gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJppwNVtUjB7fUZSCrZ88Ssbhmc4HD6oA2nV0uEx+vHBXUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.02.2023 21:36, Dmitry Baryshkov wrote:
> On Sat, 18 Feb 2023 at 16:43, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 21.01.2023 12:29, Robert Marko wrote:
>>> Currently, qcom_cpufreq_get_msm_id() does not simply return the SoC ID
>>> after getting it via SMEM call but instead uses an enum to encode the
>>> matched SMEM ID to 2 variants of MSM8996 which are then used in
>>> qcom_cpufreq_kryo_name_version() to set the supported version.
>>>
>>> This prevents qcom_cpufreq_get_msm_id() from being universal and its doing
>>> more than its name suggests, so lets make it just return the SoC ID
>>> directly which allows matching directly on the SoC ID and removes the need
>>> for msm8996_version enum which simplifies the driver.
>>> It also allows reusing the qcom_cpufreq_get_msm_id() for new SoC-s.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 44 ++++++++--------------------
>>>  1 file changed, 12 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>> index da55d2e1925a..9deaf9521d6d 100644
>>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>> @@ -32,12 +32,6 @@
>>>
>>>  #include <dt-bindings/arm/qcom,ids.h>
>>>
>>> -enum _msm8996_version {
>>> -     MSM8996_V3,
>>> -     MSM8996_SG,
>>> -     NUM_OF_MSM8996_VERSIONS,
>>> -};
>>> -
>>>  struct qcom_cpufreq_drv;
>>>
>>>  struct qcom_cpufreq_match_data {
>>> @@ -134,30 +128,16 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
>>>       dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
>>>  }
>>>
>>> -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>>> +static int qcom_cpufreq_get_msm_id(void)
>> This should be u32 as info->id is __le32
>>
>> And please export this function from socinfo, it'll come in
>> useful for other drivers!
> 
> How? In my opinion newer drivers should use compat strings rather than
> depending on the SoC ID. If we were not bound with the compatibility
> for msm8996pro device trees already using higher bits, we could have
> dropped this part too.
Adreno speedbin-to-fuse mapping could use SoC detection..

Konrad
> 
