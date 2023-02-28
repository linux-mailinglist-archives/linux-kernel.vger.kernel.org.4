Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080E76A5CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjB1P7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjB1P7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:59:12 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150C41E5F3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:59:09 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a4so7479759ljr.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677599947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNWPzJa8avM6TYHOopiEbIWeBbxOSlZbdp2M+5N4n6w=;
        b=g33hCLsPO13fVZ7stjnki4X6No0f6y0UaXrelFrfQN3MIasef8dIWXsbyWtebXnNyo
         D6ZL82tjYczzEDolfiL5GbpiNj9T5X6F8FlMrI1qg7Q1ElPJLvIiuHfYIApx95+JLahY
         orVec/hiHTGAnwDoviZF5UM4k0yMwhK1lsdi9Db3zk7O/aLuQXdkbt7lsStfxaKy7RIY
         yxu4tJIIXGVCYv9xp93cVyqi03amHAMYQGUl6ictFU6dGO9rmSxgaT4CGNztk0SfwfPu
         Rus6bKInFl4JNC1Ork0k/plYwUhm7+9dkJGgLbXS7qD8Q5q5zLXeTF6v2L9eRKke7/47
         RHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677599947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNWPzJa8avM6TYHOopiEbIWeBbxOSlZbdp2M+5N4n6w=;
        b=XfCeDD41HHi+0EMsS21GB6QDy9TfEFd3Jm0O1KQGX4BmsG2cWb72jZnh4nht/1qcV1
         swxyiEPEqAATFlVBBTDaPONjDqGNX+Pd+zpe1GcdA5SE1wocjto+8YgszVH+OpnrYX8Q
         oYWDrGLU9JHkSj4U/tPkT9mjnZvrj5uDV96z3A6P84AS3xvhzHv19s6gkBTiZdTv6ago
         /9aiWxyxudeRF+FvSl9oWD2eNDeK1AQc6AA6YKQ8MQDzFTwA17T7d8JeeaTk31WEqwvl
         iDtqdKApHPHAUIMdIV9xN47aDN/fNf3iISPgWG/qTjhl2qEgc8IKUBqdI6Qg2j8/wRPI
         RhAQ==
X-Gm-Message-State: AO0yUKVYaAFOYY7uELV3FeHnjxGFozlvp/SU3kYtHf4jMjZL2FM/xtVH
        PyZNXzTKPZnaD/C2P6eTvxIJ/A==
X-Google-Smtp-Source: AK7set+nh6nKO4W/CLbkUT6vmVUv59u8gKvxHE6bm0irg3U7R5DefwdE3UA1PG+/jYrnzAi+piQfKQ==
X-Received: by 2002:a2e:9b9a:0:b0:295:a5da:a0e with SMTP id z26-20020a2e9b9a000000b00295a5da0a0emr901337lji.28.1677599947301;
        Tue, 28 Feb 2023 07:59:07 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id u19-20020a2eb813000000b00295a8d0722asm1269598ljo.93.2023.02.28.07.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:59:06 -0800 (PST)
Message-ID: <71fd2070-d986-6359-eeca-6105f0835a1b@linaro.org>
Date:   Tue, 28 Feb 2023 16:59:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/18] media: venus: hfi_venus: Write to VIDC_CTRL_INIT
 after unmasking interrupts
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-6-58c2c88384e9@linaro.org>
 <54bd7d0b-b47b-dfae-f62e-9393162d79a7@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <54bd7d0b-b47b-dfae-f62e-9393162d79a7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.02.2023 16:33, Bryan O'Donoghue wrote:
> On 28/02/2023 15:24, Konrad Dybcio wrote:
>> The downstream driver signals the hardware to be enabled only after the
>> interrupts are unmasked, which... makes sense. Follow suit.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index 772e5e9cf127..4d785e53aa0b 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -454,7 +454,6 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>>       void __iomem *wrapper_base = hdev->core->wrapper_base;
>>       int ret = 0;
>>   -    writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
>>       if (IS_IRIS1(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
>>           mask_val = readl(wrapper_base + WRAPPER_INTR_MASK);
>>           mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BASK_V6 |
>> @@ -466,6 +465,7 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>>       writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
>>       writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
>>   +    writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
>>       while (!ctrl_status && count < max_tries) {
>>           ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
>>           if ((ctrl_status & CPU_CS_SCIACMDARG0_ERROR_STATUS_MASK) == 4) {
>>
> 
> This should go before you add your new macros in-place of IS_V6() and it should have a fixes.
Ack

Konrad
> 
> ---
> bod
