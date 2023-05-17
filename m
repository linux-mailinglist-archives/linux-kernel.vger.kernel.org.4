Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E29705BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 02:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjEQAJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 20:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjEQAJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:09:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078B319B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:09:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f00d41df22so7403959e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684282160; x=1686874160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agnI71DeqMEcuH4UFBI4XPgWdUIXdzUdwTpLk6XuB60=;
        b=xDdOoYoImw2jitgueQG4b+g9UFSnySQeghPko2OyUMkayUrF4n0cYdTKI+Nj3dA/4q
         mAtzoqp5UEK1Uhc86bGzKO7iUuKfYr6vr9bvEMNPugMIrQ1rtYhlR6cRAAe14g4cXlPs
         3tAxRUJQQsAh30tNFjcCfBlGUyjP6MWnY6WGW4612Q1oM7cqsfxRlKH/x7bg8XV/0ZLV
         27juqKqGxNVUOdgBNEYhoOyQ5UM9vePYPWUp78DueO0klgqDb8nVQWzGZHHXwgQN36In
         K4hJgeJv3SUu1FdPzoMSW88Qdkzzt8/4A+PrPa9zyDGwiLGco1b3hMuKyubz1nr6gGat
         OA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684282160; x=1686874160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agnI71DeqMEcuH4UFBI4XPgWdUIXdzUdwTpLk6XuB60=;
        b=PLGdjVnJf15R3xX+FlYyHMmwQggWfwFB1jFwbzdtqjP7jd1uwfRWDPHkuwU4UWWjuy
         y1xKXPGow0bbjDFTa+tVOAGm22aVmvC/8GXjaLSqG+KaMyvcXH7PWdNaHeUIyLiIQf3h
         4onx/XjPOiKbjO2o2ENqdODwEfpakO1qUr7Ewk03LlnLNS99rsDvCEIx358wO+E2w4Zn
         RJ6nm6maIG1uNvC+96uzuWl9rXdJ4KeIxNOY1xNMiYpAuN1+uK5HNAruktielHHreJSI
         2NS2728cajdFqefCD3Wm3ASN/fWSQG1NGRj+mi88LkRkpuAMOtU3fTJ2Yb8PNQUuDPFH
         CESg==
X-Gm-Message-State: AC+VfDwSbZ2Ts6N7/CBCGr2TsKd+hyq0TFpyxaPDHxiLhpaH954NAS2Q
        WmstKr00UomixlPWGJ+0IWxkeQ==
X-Google-Smtp-Source: ACHHUZ5q46LuyMAjzi0XfU8G7oWj0poNR12qZe/fqLFOIq8cSZKm65x3MnH3Y0Y+WHkzPyVLEJ1Vdw==
X-Received: by 2002:a05:6512:21c3:b0:4ed:d5ce:7dea with SMTP id d3-20020a05651221c300b004edd5ce7deamr86140lft.27.1684282160195;
        Tue, 16 May 2023 17:09:20 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y13-20020ac2420d000000b004efedad4604sm3131749lfh.18.2023.05.16.17.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 17:09:19 -0700 (PDT)
Message-ID: <bd10673e-806d-4a4f-32e1-c709a757ba02@linaro.org>
Date:   Wed, 17 May 2023 03:09:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V6 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Content-Language: en-GB
To:     Arnd Bergmann <arnd@arndb.de>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1683628357.git.quic_schowdhu@quicinc.com>
 <35863b47c04c2edd7ae49c57d23682aba6111d4f.1683628357.git.quic_schowdhu@quicinc.com>
 <3faa9bf7-b42c-4951-8103-9ea2fe02eac1@app.fastmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <3faa9bf7-b42c-4951-8103-9ea2fe02eac1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 11:19, Arnd Bergmann wrote:
> On Tue, May 9, 2023, at 12:52, Souradeep Chowdhury wrote:
>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>> stats, like the time when the bootloader started execution and at what
>> point the bootloader handed over control to the kernel etc. in the IMEM
>> region. This information is captured in a specific format by this driver
>> by mapping a structure to the IMEM memory region and then accessing the
>> members of the structure to show the information within debugfs file.
>> This information is useful in verifying if the existing boot KPIs have
>> regressed or not. The information is shown in milliseconds, a sample
>> log from sm8450(waipio) device is as follows:-
>>
>> /sys/kernel/debug/qcom_boot_stats # cat abl_time
>> 17898 ms
>> /sys/kernel/debug/qcom_boot_stats # cat pre_abl_time
>> 2879 ms
>>
>> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
>> stage and the timestamp generated by the sleep counter is logged by
>> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
>> starts execution which is logged here as "pre_abl_time" and the second
>> when it is about to load the kernel logged as "abl_time". Documentation
>> details are also added in Documentation/ABI/testing/debugfs-driver-bootstat
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   .../ABI/testing/debugfs-driver-bootstat       |  17 +++
>>   drivers/soc/qcom/Kconfig                      |  10 ++
>>   drivers/soc/qcom/Makefile                     |   1 +
>>   drivers/soc/qcom/boot_stats.c                 | 100 ++++++++++++++++++
> 
> As mentioned in my reply to the binding, I don't think this should
> be a driver at all. On top of that, even if it was a driver, it is
> clearly not a "soc" driver since nothing in it has any relevance to
> the hardware, rather than the first-stage loader, and drivers/soc/
> drivers should never have their own user space interface either.

I suppose that we should add a proper driver for imem rather than always 
using it through syscon.

-- 
With best wishes
Dmitry

