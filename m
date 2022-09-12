Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2305B5EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiILRMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiILRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:12:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FA613CD8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:12:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q62-20020a17090a17c400b00202a3497516so6480234pja.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fqzzoWbSMT2VgvV42T1zNLmKmm1oMYsYPkGA/oUJULY=;
        b=Ouc7UsGuQJtuYsxymPzqHxJbwBAyRKKcmoUut4k79S2gMyCwXGY7takpQAqcRrnvW/
         qS7RP7HxGPQxEB99L3EmBQUChPZ2RO6y7/3WOO0grvhiovS7HUTV7IjETOC90ZWEhJrt
         9cZMobGoAARNGIdv9vV0IfHlXDVpIXUR63l9Rf+7/iiCUOmodc+gPJYKZ94uj+LL8LEj
         ihYvHdjg3r9FLH/5pdptbFIh2v+JDboVi03Tf0RMWUlVPQR05XxF33AZ08NH1jrO618n
         +l+SzVk93CmEZBiq4C7NvG3w8P/izZ0NvWJSVSY6n4tC5al2OGww2n56C9lhcSuqkWlG
         9Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fqzzoWbSMT2VgvV42T1zNLmKmm1oMYsYPkGA/oUJULY=;
        b=lzGA408Pzn3m93TbDIxy9NTN1ThGLhHLF79bQfYTGdOpT0GOhZL+9HivX/gOY4yp8O
         jJ0htnHgkBt8s20lwU9r0zzPTepfFhbDVtpkGKEzZwZvPWx6JIsTE5gHEYhZMHxo1A74
         lMTn92TuxrWFjz/k7Wlo1Ca4tBQyl17V0UmfKQFARthyRW1YwrEi/ThKlfjfB32AukqT
         QJ4lxBGoCsqZLjayrYr1B425IN3bQtaYebvWte54xFPIf8cZjS6epY7pHYbunDuxnA4a
         hwwySQbCwmj3RPvvgIxehpRIQXdluW1NCx1mMTCVJt/7+UBCEoE64wQizPelAN5vBOws
         G+Ng==
X-Gm-Message-State: ACgBeo04JoTMeS/qGpaHVPe6TpDJuacVcB+9mBuN05RypzvYxSuXK7jQ
        EC5ItW4WGeDyjK9WVOrJUDUgbQ==
X-Google-Smtp-Source: AA6agR4F7HDI57sNT1b6pwdarmZsx0rGVZLc8nx04fhgL8PDa0MOXXvhs9Es/azTibdolsUl4d/LMw==
X-Received: by 2002:a17:90b:4c50:b0:202:c7b1:b1f9 with SMTP id np16-20020a17090b4c5000b00202c7b1b1f9mr7899870pjb.77.1663002720601;
        Mon, 12 Sep 2022 10:12:00 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:5362:9d7f:2354:1d0a:78e3? ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id b37-20020a631b65000000b00434651f9a96sm5728367pgm.15.2022.09.12.10.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 10:12:00 -0700 (PDT)
Message-ID: <75a5789e-9100-b398-1df2-50d49823831c@linaro.org>
Date:   Mon, 12 Sep 2022 22:41:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] thermal: Introduce CONFIG_QCOM_THERMAL in Makefile
 and qcom/Kconfig
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220911184232.3198957-1-bhupesh.sharma@linaro.org>
 <CAA8EJpoM5nW=pVJB4zy4Jh9Q3gE4KOju2QVy_WtmUokKMyXtuw@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <CAA8EJpoM5nW=pVJB4zy4Jh9Q3gE4KOju2QVy_WtmUokKMyXtuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/22 1:08 AM, Dmitry Baryshkov wrote:
> On Sun, 11 Sept 2022 at 21:42, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>>
>> Introduce CONFIG_QCOM_THERMAL to allow better control
>> over selection of various Qualcomm Thermal drivers
>> available inside qcom/ directory.
>>
>> This is a preparatory change to allow new drivers to
>> be added inside qcom/ directory in a more structured
>> fashion.
>>
>> Cc: Bjorn Andersson <andersson@kernel.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Amit Kucheria <amitk@kernel.org>
>> Cc: Thara Gopinath <thara.gopinath@gmail.com>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>   drivers/thermal/Makefile     |  2 +-
>>   drivers/thermal/qcom/Kconfig | 12 ++++++++++++
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index def8e1a0399c..a12b647be0d1 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -52,7 +52,7 @@ obj-$(CONFIG_DA9062_THERMAL)  += da9062-thermal.o
>>   obj-y                          += intel/
>>   obj-$(CONFIG_TI_SOC_THERMAL)   += ti-soc-thermal/
>>   obj-y                          += st/
>> -obj-$(CONFIG_QCOM_TSENS)       += qcom/
>> +obj-$(CONFIG_QCOM_THERMAL)     += qcom/
> 
> Following other platforms around qcom, I think just `obj-y += qcom/`
> would work well enough.

I have no strong opinion on using `obj-y += qcom/` here, but I would
still like us to define a CONFIG_QCOM_THERMAL like flag in the 
qcom/Kconfig, similar to the ST platforms which use similar selection 
mechanism via 'CONFIG_ST_THERMAL'.

Thanks.

>>   obj-y                          += tegra/
>>   obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>>   obj-$(CONFIG_MTK_THERMAL)      += mtk_thermal.o
> 
