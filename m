Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2783A6973A8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjBOBbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjBOBbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:31:20 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE4534334
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:31:17 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id sa10so44493980ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aI/i5jy/3RaQrerUAILzjzBlGYFwOaVfy4rEAxzIvBw=;
        b=S49ZflQkLg9ERIdpEIQNGiz/7fet4Zb9lqjgchR4MB/5/G5iaYwX7MEfUs05Hso+Hk
         qEsZlhe8+ZoE2mcsSeYTAcr+5gBVJF2cU3HPRniC5lVTHOa4v1nRJACalNys5UYw1N8j
         BKVSWT/UPiY2a9KFD19JvE9xrlQNM63fYvCABmZHJiuoINiMvqekmXVmDRNftEFmoD5E
         gJpufNyxEJsiRFucmXCT3YLFayLWnIebdhnQrRq6Umckijv0aJf4Fykd/vbyNQYw14oQ
         6pyipPM8dPZlpwKuJ1cir0uJCVZ3bL8QCl86GbVFvDoYfGHDj0Ek7RZ2esigTdsYbX27
         QXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aI/i5jy/3RaQrerUAILzjzBlGYFwOaVfy4rEAxzIvBw=;
        b=5v5ZHYNQm8lA6wxQUlJdOeX5eeaIhXBC6tXeDtCis0ef9y6LfIFwAg72xuI1I85BI+
         181z8jEDJUYr+OozGqY3MCEcfn8YEd7w9xBQ/bPyJ/HZO35ZBEeLl1dwFsfRPLJJV763
         gQN29xAW57gGWSh+xRaFgpCePXpqOI2eE9TuwXoZvhejOQlhPdssK1oTQkgvR9tq1sjQ
         m/v2Cf6TodKn+niYoL0ICNrJURdDy/f2SjasweARZgaYx5AGKE8QA57KLrNMkQ1WdmAi
         TYBK9bjzx3+l6rhK/6pwBl6iN661v0ulZjfvGHe96qjSagmNFf63LXXuYP2D/+cMgKvq
         auww==
X-Gm-Message-State: AO0yUKV71hn6ovLVGgu17nglScZEea3okF6JQLzDyVpdfiuFpX/KhQkH
        baMtihf1cPrc90hNP4Q3YGCA/Q==
X-Google-Smtp-Source: AK7set8pRGei2+FRstywE9fQuZ72lLtkEmAf+QHtzKXmanwLQzCyeF5Y+c4I5Yv5fzFKWfUqffXo4Q==
X-Received: by 2002:a17:906:5a90:b0:8b1:3f5b:af5f with SMTP id l16-20020a1709065a9000b008b13f5baf5fmr392899ejq.73.1676424676077;
        Tue, 14 Feb 2023 17:31:16 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id l6-20020a170907914600b008b138528a53sm880912ejs.224.2023.02.14.17.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 17:31:15 -0800 (PST)
Message-ID: <585c6e42-bc59-5a6a-b3e8-0a4e1841c5b0@linaro.org>
Date:   Wed, 15 Feb 2023 02:31:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4 12/12] interconnect: qcom: icc-rpm: Allow negative QoS
 offset
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
 <20230214143720.2416762-13-konrad.dybcio@linaro.org>
 <24167f9e-328c-0201-7eea-de201bed4b6a@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <24167f9e-328c-0201-7eea-de201bed4b6a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.02.2023 02:16, Dmitry Baryshkov wrote:
> On 14/02/2023 16:37, Konrad Dybcio wrote:
>> In some very very very very unfortunate cases, the correct offset of
>> the QoS registers will be.. negative. One such case is MSM8998, where
>> The DDR BWMON occupies what-would-be-the-BIMC-base which we usually
>> take into account with the register calculation, making the actual
>> BIMC node start at what-would-be-the-BIMC-base+0x300.
>>
>> In order to keep the calculation code sane, the simplest - however
>> ugly it may be - solution is to allow the offset to be negative.
> 
> I'm not sure how does this work, as e.g. qcom_icc_set_qnoc_qos() will try to access an address before the first register. Most probably this patch should go together with the rest of msm8998 patches.
In our case BIMC is the offender and its defines all base on
M_BKE_REG_BASE(n) (0x300 + (0x4000 * n)), so removing 0x300
is perfectly ok.

> 
> A slightly better solution to making qos_offset negative might be to make bwmon a child node of the icc.
That sounds like a lot of complex changes and accounting for old
/ different DTs who don't have the bwmon as a child of icc :/

Konrad
> 
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>> index 77e263b93c27..5e4215f25c2e 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.h
>> +++ b/drivers/interconnect/qcom/icc-rpm.h
>> @@ -39,7 +39,7 @@ struct qcom_icc_provider {
>>       int num_intf_clks;
>>       enum qcom_icc_type type;
>>       struct regmap *regmap;
>> -    unsigned int qos_offset;
>> +    int qos_offset;
>>       u64 bus_clk_rate[2];
>>       bool keep_alive;
>>       struct clk_bulk_data bus_clks[2];
>> @@ -105,7 +105,7 @@ struct qcom_icc_desc {
>>       bool keep_alive;
>>       enum qcom_icc_type type;
>>       const struct regmap_config *regmap_cfg;
>> -    unsigned int qos_offset;
>> +    int qos_offset;
>>   };
>>     /* Valid for all bus types */
> 
