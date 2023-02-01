Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEAD68648F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjBAKlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjBAKk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:40:59 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9E126D4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:40:38 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bk15so50044234ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akVFYb7eyxwgivRRMnUHCdAP1zAt0L+6NAmMhYaMXo0=;
        b=x1kVc/0t7XOvLu8n7/fpZorROVEFqokMu1Dyq0UsEwgQ6VEA7XYueTtn8DK/7v2Cr3
         fK8KSnc3ypYeC8QSUT95EkHNQIT5nCmwAYR5/kqX/9/oolB2vI3/Oo/vFpLPgegKGwMg
         r1XIhHXdQplWd8ZR4kCj6Go5FT7Jh8DkInqrsEtpj9UcikVa5JLltts764di9pszsRjb
         OxVxqA7rOlM6U2NCzCIMbosFAga+Jw+3+MvTFbsKGfgP8QVdckswUz92mWwjpk/cJs01
         ucmhp8JiKf6/iCK/NZr4gB3BNFctf3I35M+ng9bJdEImw40R2f+SyCwsLi2RH6seF72r
         3SWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akVFYb7eyxwgivRRMnUHCdAP1zAt0L+6NAmMhYaMXo0=;
        b=3rYpJVairvxT3aibrxcwdd3Ai938WFW6Deuqsjn27zNFpoanQYZskH9HvZbygEYcxA
         nKv2zPxauBEhbiTECdvseUW229LCXXAb0JxnT5pAZqKEoKqx1y++paVj4buEEmz0p/xJ
         Zq/FZ1urmiP8RCH7Z89uQPsCfhcjuprv/aZpnMjeNpWbAv9yAgWwYdxWJKxgnbgaizUe
         SX0ft+ukKzccTEIoTLKW6EzJZmrveNk+nQGyY7HhY9UnlcX3SdM5BooLurONokrXy5tQ
         TpvIbYbz/6UOyUNQLldh6PNBX4aCkCBArrEgDUBmDDt/f3h61DhrIRmiS4wH7fyfVgGa
         zZDA==
X-Gm-Message-State: AO0yUKX6lSDcE6l6SD8p0JZz6MkEnic/P8X5Pa+2a/1prYEmLhFfT30l
        Qu90u7S9q1YCjTGQwmefLt9q9A==
X-Google-Smtp-Source: AK7set954JPkWgXwQ8nW8dvSZPB66mOuuccfEFBg4BjCBBYwQJ3B8dYoamn9U5AYum8r9leJoJ1WqA==
X-Received: by 2002:a17:907:1c95:b0:881:7f2d:7a87 with SMTP id nb21-20020a1709071c9500b008817f2d7a87mr1534595ejc.63.1675248035239;
        Wed, 01 Feb 2023 02:40:35 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906311500b0087045ae5935sm9813939ejx.1.2023.02.01.02.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 02:40:34 -0800 (PST)
Message-ID: <11859977-4e29-e4d7-acd4-94e3d3227c27@linaro.org>
Date:   Wed, 1 Feb 2023 11:40:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] arm64: Add a couple of missing part numbers
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Michal Orzel <michal.orzel@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230201000900.3150295-1-konrad.dybcio@linaro.org>
 <e1688749-bcdf-14f4-ac34-137a602286e1@arm.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e1688749-bcdf-14f4-ac34-137a602286e1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.02.2023 05:50, Anshuman Khandual wrote:
> 
> 
> On 2/1/23 05:39, Konrad Dybcio wrote:
>> Add Cortex X1C and add/clarify various recent Qualcomm Kryo cores,
>> which almost exclusively mimic ARM IDs nowadays.
> 
> Why add these cpu numbers ? Is there an errata being worked on for them ?
> Without specific implementation requirement, these might not be necessary.
Generally I was under the impression that this header
double-served as sort of a documentation. I checked
my board and they seem to even use the Arm implementer
ID (instead of their own, as they did in the past),
so I suppose they may be using actual Cortex parts
with no modifications and this patch is not very
beneficial.

Konrad
> 
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> v1 -> v2:
>>
>> - Don't change the name of QCOM_CPU_PART_KRYO_4XX_SILVER
>>
>>  arch/arm64/include/asm/cputype.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
>> index 683ca3af4084..a4260d3194fc 100644
>> --- a/arch/arm64/include/asm/cputype.h
>> +++ b/arch/arm64/include/asm/cputype.h
>> @@ -84,6 +84,7 @@
>>  #define ARM_CPU_PART_CORTEX_X2		0xD48
>>  #define ARM_CPU_PART_NEOVERSE_N2	0xD49
>>  #define ARM_CPU_PART_CORTEX_A78C	0xD4B
>> +#define ARM_CPU_PART_CORTEX_X1C		0xD4C
>>  
>>  #define APM_CPU_PART_POTENZA		0x000
>>  
>> @@ -107,9 +108,17 @@
>>  #define QCOM_CPU_PART_KRYO		0x200
>>  #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
>>  #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
>> +#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
>>  #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
>>  #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
>>  #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
>> +#define QCOM_CPU_PART_KRYO_5XX_GOLD	ARM_CPU_PART_CORTEX_A77
>> +#define QCOM_CPU_PART_KRYO_6XX_GOLD	ARM_CPU_PART_CORTEX_A78
>> +#define QCOM_CPU_PART_KRYO_6XX_GOLDPLUS	ARM_CPU_PART_CORTEX_X1
>> +#define QCOM_CPU_PART_KRYO_6XX_SILVER_V1	ARM_CPU_PART_CORTEX_A55
>> +#define QCOM_CPU_PART_KRYO_7XX_GOLD	ARM_CPU_PART_CORTEX_A710
>> +#define QCOM_CPU_PART_KRYO_7XX_GOLDPLUS	ARM_CPU_PART_CORTEX_X2
>> +#define QCOM_CPU_PART_KRYO_7XX_SILVER	ARM_CPU_PART_CORTEX_A510
>>  
>>  #define NVIDIA_CPU_PART_DENVER		0x003
>>  #define NVIDIA_CPU_PART_CARMEL		0x004
