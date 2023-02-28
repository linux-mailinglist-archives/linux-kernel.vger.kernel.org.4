Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47E86A5CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjB1QKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjB1QKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:10:15 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84E331E20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:09:55 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id g18so8690553ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677600594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BYDcuGy5OWjwIJ636Q05VJ9FInAylVAhdb47A3o3FVo=;
        b=pmyvY+uN5lA4Mgk0e/qRlFnmceiZ/jbzEAcJdiA/3qei+D5HHo9FHpwJpth5lL76Fu
         FPVLaTqZF1yHeiSxMAbj0EOA4dyqzvMGOkVxGi2UmHAL4EBoHyatC6/5Yo5EI7F+jNSe
         4NrfcMDlIBIa8t/AG+5VMUa2yyJpXOso9vGv1LEy7ES7/tZBmiNv7vvf+ZDNc7hHDj6e
         QyMOiMS0OLguwgxDRfugfDdQlTOTlm3CmZ2jgZE8RkdO0s8pyDvG+wgVZy6njH45Psh+
         75qhP+zO7fHJOFEwSBYQDAOwgZ72f6hnlyLVKhiGftnIBAxjZhJsljbfruYj3wZZ7lCw
         8HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677600594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYDcuGy5OWjwIJ636Q05VJ9FInAylVAhdb47A3o3FVo=;
        b=SuzQuWXrNRbgC1U+TsWRZFlP2XhisDEK/IIne37ylpm+hXtc6cUsGzBFm6QM47rurG
         wj+ynIskkp+us1mz+iUveD9U1irkvo+ZVxWSMQD3Rf9HjbYUK934dNk62u5XMW5H4/iX
         FvRaWatUj/B+hg1pwiKkEgCJpxpKWYSJ5kBTHkRPEftGorQ4VFSFTBoFznWuALWI23n5
         hLTSl/91/gKDt5VPmRvBnogzKAbUfrKXibix0BkjlKktjzlRybZJp2agLwawokZKcmKT
         OtZIGGotAbRxoOsAu2YeysXPtpl6vml9aCuzdCj1CoG/YdnBSSxt4HI+2hfK3t6yISMp
         HV2w==
X-Gm-Message-State: AO0yUKVw/HVGDdYKkoawqZ4SXHhrrzohJ7CpAhqgV7An1oivL+9Uu6XP
        ytqza6+N1NNbfc6C8Kg31hanYA==
X-Google-Smtp-Source: AK7set/XIAul1u+pQL6u9dmpXuW22sZXWBMl/V6EkKAxVq+JGAz2Qf6Tw2xFAZK2rc/xDoHa4oF5dw==
X-Received: by 2002:a2e:99cb:0:b0:28e:b061:7a9b with SMTP id l11-20020a2e99cb000000b0028eb0617a9bmr873249ljj.42.1677600593956;
        Tue, 28 Feb 2023 08:09:53 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id b20-20020a2eb914000000b00290b375a068sm1260431ljb.39.2023.02.28.08.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 08:09:53 -0800 (PST)
Message-ID: <3c54f2f6-225c-600e-8679-097fbc78f4df@linaro.org>
Date:   Tue, 28 Feb 2023 17:09:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 18/18] media: venus: hfi_venus: Restrict writing
 SCIACMDARG3 to Venus V1/V2
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
 <20230228-topic-venus-v1-18-58c2c88384e9@linaro.org>
 <0d319988-e4fe-3c67-fca6-fee3ff94f673@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <0d319988-e4fe-3c67-fca6-fee3ff94f673@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.02.2023 16:57, Bryan O'Donoghue wrote:
> On 28/02/2023 15:24, Konrad Dybcio wrote:
>> This write was last present on msm-3.10, which means before HFI3XX
>> platforms were introduced. Guard it with an appropriate if condition.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_venus.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index c2d134e04c30..deeceb86414d 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -463,7 +463,8 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>>       }
>>         writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
>> -    writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
>> +    if (IS_V1(hdev->core))
>> +        writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
>>         writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
>>       while (!ctrl_status && count < max_tries) {
>>
> 
> Looks good.
> 
> Which platforms have you tested this change on ?
8250

Can you include that detail in the commit log ?
Sure!

Konrad
> 
> ---
> bod
