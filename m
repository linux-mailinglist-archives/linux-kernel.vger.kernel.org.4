Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746B2616152
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiKBK75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiKBK7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:59:54 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17331C12F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 03:59:53 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A29fK18004411;
        Wed, 2 Nov 2022 11:59:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=aSfGlhCcZ/1fR+G9G0wTcQE3tTWgYAJtQ9xzPRJuxiI=;
 b=wjepG41PBjuTgwTCke5djvnLYVVI2KthQh292FSbxi+DUOOzLVqrixf/frip7bNq+ttq
 bsnuxaUah3QdjB2QvPOTwwNxK0DmOlCmLckqGoJX9CXJ5mCHAt1MX6Xa4WbOsnhO9cFc
 voByotxl7euQzRvaTnyMfkVfaFtu9OQ7i1m5r8GPGgb2JQyaIJ5stw5oxlGP4Jr8FAAm
 74xojMGSkmR6sSTdriF/h678B9k4XCLFjpxrZ6qo6YASodPpHV0RbILK6Z7cgP8DnBzn
 tdz8WTB9fqnXUUuB9/FkyqWQav0icTNyZWJX9z9fbrQoKUe41PxlEBspwHy+fvjM44Hz sA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kkp4x0r4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 11:59:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E6DB310002A;
        Wed,  2 Nov 2022 11:59:32 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DEEA121A90C;
        Wed,  2 Nov 2022 11:59:32 +0100 (CET)
Received: from [10.48.0.157] (10.48.0.157) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:59:29 +0100
Message-ID: <a4ae3648-2943-55e0-243f-71a3c5f71ad8@foss.st.com>
Date:   Wed, 2 Nov 2022 11:59:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] nvmem: stm32: add OP-TEE support for STM32MP13x
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Etienne CARRIERE <etienne.carriere@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <20221028145252.2115933-1-patrick.delaunay@foss.st.com>
 <20221028165150.3.Ibc43aa73f865090affeb1751af0cc260c7f1dd07@changeid>
 <99a8d093-13f3-9ff8-6d87-d4aecaec1566@linaro.org>
Content-Language: en-US
From:   Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <99a8d093-13f3-9ff8-6d87-d4aecaec1566@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_07,2022-11-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/1/22 08:26, Srinivas Kandagatla wrote:
>
>
> On 28/10/2022 15:52, Patrick Delaunay wrote:
>> For boot with OP-TEE on STM32MP13, the communication with the secure
>> world no more use STMicroelectronics SMC but communication with the
>> BSEC TA, for data access (read/write) or lock operation:
>> - all the request are sent to OP-TEE trusted application,
>> - for upper OTP with ECC protection and with word programming only
>>    each OTP are permanently locked when programmed to avoid ECC error
>>    on the second write operation
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>
> For some reason I pushed this patch without a full review, This is now 
> reverted from nvmem-next.


Ok


>
> Why not add TEE client based new driver instead of ifdefing around 
> this driver? Also I see there is not much common across both drivers 
> anyway.


I hesitate between the 2 solutions. I choose this update to handle the 
STM32MP15 support with OP-TEE.

For backward compatibility reason the same driver STM32 ROMEM associated 
to compatible "st,stm32mp15-bsec" should be kept.

- the lower OTP can directly accessible by Linux (the IP is not secured) 
=> boot with SPL

- the upper OTP and the write operation are requested by 
STMicroelectronics SMCs

    => boot with TF-A SPMIN and old OP-TEE (before migration to STM32 
BSEC PTA)


But in the future OP-TEE the access to OTP should be also done with 
STM32 BSEC PTA...


I can manage this compatibility by detection in STM32 romem driver if 
the booth access are managed in the same driver.

This patch can be added in the serie to understood the detection mechanism.


>
>
>>
>>   drivers/nvmem/stm32-romem.c | 450 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 446 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
>> index 6de565639d5f..dfdedbcca9b9 100644
>> --- a/drivers/nvmem/stm32-romem.c
>> +++ b/drivers/nvmem/stm32-romem.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/module.h>
>>   #include <linux/nvmem-provider.h>
>>   #include <linux/of_device.h>
>> +#include <linux/tee_drv.h>
>>     /* BSEC secure service access from non-secure */
>>   #define STM32_SMC_BSEC            0x82001003
>> @@ -25,14 +26,22 @@
>>   struct stm32_romem_cfg {
>>       int size;
>>       u8 lower;
>> +    bool ta;
>>   };
>>     struct stm32_romem_priv {
>>       void __iomem *base;
>>       struct nvmem_config cfg;
>>       u8 lower;
>> +    struct device *ta;
>>   };
>>   +struct device *stm32_bsec_pta_find(struct device *dev);
>> +static int stm32_bsec_pta_read(void *context, unsigned int offset, 
>> void *buf,
>> +                   size_t bytes);
>> +static int stm32_bsec_pta_write(void *context, unsigned int offset, 
>> void *buf,
>> +                size_t bytes);
>> +
>>   static int stm32_romem_read(void *context, unsigned int offset, 
>> void *buf,
>>                   size_t bytes)
>>   {
>> @@ -173,15 +182,25 @@ static int stm32_romem_probe(struct 
>> platform_device *pdev)
>>       } else {
>>           priv->cfg.size = cfg->size;
>>           priv->lower = cfg->lower;
>> -        priv->cfg.reg_read = stm32_bsec_read;
>> -        priv->cfg.reg_write = stm32_bsec_write;
>> +        if (cfg->ta) {
>> +            priv->ta = stm32_bsec_pta_find(dev);
>> +            /* wait for OP-TEE client driver to be up and ready */
>> +            if (!priv->ta)
>> +                return -EPROBE_DEFER;
>> +
>> +            priv->cfg.reg_read = stm32_bsec_pta_read;
>> +            priv->cfg.reg_write = stm32_bsec_pta_write;
>> +        } else {
>> +            priv->cfg.reg_read = stm32_bsec_read;
>> +            priv->cfg.reg_write = stm32_bsec_write;
>> +        }
>>       }
>>         return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &priv->cfg));
>>   }
>>     /*
>> - * STM32MP15 BSEC OTP regions: 4096 OTP bits (with 3072 effective bits)
>> + * STM32MP15/13 BSEC OTP regions: 4096 OTP bits (with 3072 effective 
>> bits)
>>    * => 96 x 32-bits data words
>>    * - Lower: 1K bits, 2:1 redundancy, incremental bit programming
>>    *   => 32 (x 32-bits) lower shadow registers = words 0 to 31
>> @@ -191,6 +210,13 @@ static int stm32_romem_probe(struct 
>> platform_device *pdev)
>>   static const struct stm32_romem_cfg stm32mp15_bsec_cfg = {
>>       .size = 384,
>>       .lower = 32,
>> +    .ta = false,
>> +};
>> +
>> +static const struct stm32_romem_cfg stm32mp13_bsec_cfg = {
>> +    .size = 384,
>> +    .lower = 32,
>> +    .ta = true,
>>   };
>>     static const struct of_device_id stm32_romem_of_match[] = {
>> @@ -198,6 +224,8 @@ static const struct of_device_id 
>> stm32_romem_of_match[] = {
>>           .compatible = "st,stm32mp15-bsec",
>>           .data = (void *)&stm32mp15_bsec_cfg,
>>       }, {
>> +        .compatible = "st,stm32mp13-bsec",
>> +        .data = (void *)&stm32mp13_bsec_cfg,
>
> missing sentinel, which caused a regression in next.


Ok, sorry for my error in the rebase conflict.


Patrick


>
>
> --srini
>>       },
>>   };
>>   MODULE_DEVICE_TABLE(of, stm32_romem_of_match);
>> @@ -209,7 +237,421 @@ static struct platform_driver 
>> stm32_romem_driver = {
>>           .of_match_table = of_match_ptr(stm32_romem_of_match),
>>       },
>>   };
>> -module_platform_driver(stm32_romem_driver);
>> +
>> +#if IS_ENABLED(CONFIG_OPTEE)
>>
....


>> +
>> +module_init(stm32_romem_init);
>> +module_exit(stm32_romem_exit);
>>     MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
>>   MODULE_DESCRIPTION("STMicroelectronics STM32 RO-MEM");
