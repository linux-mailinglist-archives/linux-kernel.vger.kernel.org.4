Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246696F6FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjEDQT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEDQTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:19:23 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5F3AA7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:19:21 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac836f4447so988311fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683217160; x=1685809160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vo5rW4D2buAZqQwwd6Aqk9WkGhPA3mqzeuCzA9HHXHw=;
        b=bUS8e2wntjbH4LIDt48dgSCo0uqIWnegtQFEJEgwSD+CzwL21vgpK5JkWWVj3T+tla
         sqUyyzUosaupjxiWJbAPlBW4UUGCbCf4q6sqkDbjIH4muva3RDC4O50rzSHBQE2DNBDZ
         ikn/K2HRBqPqKWbg/eTC83hl6CQ4EV0bp5bubAjtDAHgqM4vB4WZBXQ7V7sZfkxNAHoa
         uy6yCVsWnURMRQEqsTybCcqhifPVDKNybbFdg36mCjF6sFDoYbpI5eVFagzkFcJbfH1R
         boWNBH6H7/ohyRj5ppNy4W0PVwi2Nm/mWuzXN65Odc14yHxcwscxpaWRQ0Ej37iJCmCr
         FqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683217160; x=1685809160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo5rW4D2buAZqQwwd6Aqk9WkGhPA3mqzeuCzA9HHXHw=;
        b=YAmTCPNXgIB/aL2OR9+mnisGS1YdEfwz4sjxSHHxCWuNZQV0RHKdYKyMnJJQ7aA0Rp
         DERxTIhGJg7FJVxwr/dDk5fdp2M4z9aqBXJiqBPXW3LUyoEZ+ej9ECimWMMDa15SjOOH
         ZRqGiLgnyHDT9OyZuLrp1Ilem3st1OaEn1LcINxKgN5rAP4wcR+mvrb20wZActoJMuwh
         Ye67zrsH5OEl+a9Gl5HtfnBcDUVm3KaeLpy1VYztPgOXU3CZMmCGOVyrl+4bdgNqSTyN
         +rMZ+iLcmuoupnL/338jdI5uLZPddv8c0ODG5wPsaNVX/hvWXk7EjqJf4hmSMBnsmlqb
         30xA==
X-Gm-Message-State: AC+VfDzjC16PcCmUPk0YZxjEHDyYSGGEHjhQzgfOP2cRJsFj8OBKf4s7
        /PTPajY+MMdlYZECqSjDTk3sFg==
X-Google-Smtp-Source: ACHHUZ7FQe9V76G9mpp4s9UGUHEHt3Z6SAErVNGGT9aBvjJDagHMe8oKF+6DaUEkU1YasdRhd6V0JA==
X-Received: by 2002:a2e:8356:0:b0:2a8:e6fd:5e57 with SMTP id l22-20020a2e8356000000b002a8e6fd5e57mr1180897ljh.11.1683217159769;
        Thu, 04 May 2023 09:19:19 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id j25-20020a2e8519000000b002a76c16ad65sm6634378lji.87.2023.05.04.09.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 09:19:19 -0700 (PDT)
Message-ID: <35ac64ab-512d-1425-7a1b-6e8d3806c8a8@linaro.org>
Date:   Thu, 4 May 2023 19:19:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Content-Language: en-GB
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681742910.git.quic_schowdhu@quicinc.com>
 <C1eDJi-H9uWRAtbInRclmCgPb4EcgaeS3sk5FKO9cw8KscgMCH8dxRSvdPGUMwDFKpte7cBVeaqPhlLog-CRrg==@protonmail.internalid>
 <2ef76ce292c059c144e559123a9a54201ae2d0cf.1681742910.git.quic_schowdhu@quicinc.com>
 <575ee047-c6ce-95c3-8781-8c9a78534bb1@linaro.org>
 <f42637c8-400b-e39f-412d-60328e176585@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <f42637c8-400b-e39f-412d-60328e176585@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 09:35, Souradeep Chowdhury wrote:
> 
> 
> On 5/4/2023 4:23 AM, Caleb Connolly wrote:
>>
>>
>> On 17/04/2023 16:08, Souradeep Chowdhury wrote:
>>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>>> stats, like the time when the bootloader started execution and at what
>>> point the bootloader handed over control to the kernel etc. in the IMEM
>>> region. This information is captured in a specific format by this driver
>>> by mapping a structure to the IMEM memory region and then accessing the
>>> members of the structure to show the information within debugfs file.
>>> This information is useful in verifying if the existing boot KPIs have
>>> regressed or not. The information is shown in milliseconds, a sample
>>> log from sm8450(waipio) device is as follows:-
>>>
>>> /sys/kernel/debug/146aa6b0.boot_stats # cat abl_time
>>> 17898 ms
>>> /sys/kernel/debug/146aa6b0.boot_stats # cat pre_abl_time
>>> 2879 ms
>>>
>>> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
>>> stage and the timestamp generated by the sleep counter is logged by
>>> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
>>> starts execution which is logged here as "pre_abl_time" and the second
>>> when it is about to load the kernel logged as "abl_time". Documentation
>>> details are also added in 
>>> Documentation/ABI/testing/debugfs-driver-bootstat
>>>
>>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>>
>> Hi,
>>
>> [...]
>>> +
>>> +static int boot_stats_probe(struct platform_device *pdev)
>>> +{
>>> +    struct device *bootstat_dev = &pdev->dev;
>>> +    struct bs_data *drvdata;
>>> +
>>> +    drvdata = devm_kzalloc(bootstat_dev, sizeof(*drvdata), GFP_KERNEL);
>>> +    platform_set_drvdata(pdev, drvdata);
>>> +
>>> +    drvdata->dbg_dir = debugfs_create_dir(dev_name(bootstat_dev), 
>>> NULL);
>>
>> This might be better as just "qcom_boot_stats", rather than including
>> the address.
> 
> We usually use the dev_name to represent the one to one correspondence 

Who is "we"?

> of the debugfs file with the device. Will create the root dir as
> "qcom_boot_stats" and push the dev_name dir inside it.

No, this doesn't sound logical. Please use just the "qcom_boot_stats" as 
Caleb suggested.

> 
>>
>> [...]
>>> +
>>> +static const struct of_device_id boot_stats_dt_match[] = {
>>> +    { .compatible = "qcom,sm8450-bootstats" },
>>
>> This driver doesn't only support sm8450, I've tested this on sdm845 and
>> it works just fine. Can we use a generic compatible here instead?
> 
> We can add soc specific compatibles here to extend support for other 
> socs. This also captures the SoCs for which the driver is supported 
> which won't be the case if we use a generic compatible.

No. If there is no difference between SoCs, please don't add 
soc-specific compatibles. They pollute the kernel and provide no 
additional benefits. Please use generic compatible and add 
platform-specific ones only if you have something to override.

> 
> 
>>> +    { }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
>>> +
>>> +static struct platform_driver boot_stat_driver = {
>>> +    .probe  = boot_stats_probe,
>>> +    .remove_new = boot_stats_remove,
>>> +    .driver = {
>>> +        .name = "qcom-boot-stats",
>>> +        .of_match_table = boot_stats_dt_match,
>>> +    },
>>> +};
>>> +module_platform_driver(boot_stat_driver);
>>> +
>>> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
>>> +MODULE_LICENSE("GPL");
>>> -- 
>>> 2.7.4
>>>
>>

-- 
With best wishes
Dmitry

