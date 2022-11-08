Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C28620CD1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiKHKDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbiKHKDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:03:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA1717AB8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:03:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w14so20107905wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOX9zjUZFkr9z7v9HthQbYfzbIWKCxg0bpV+kFj752Q=;
        b=RLCmOwYKvHF1KTZilJEPRrub4fLrNsrQTLfsWXZADJCzY6xp5OTw18NwtJKD+W4OF6
         Yy0ifNLkO82kg7ygIaZxBIoStesEoPAAkXUF7vCzeSnIGxdbfWSW4S1vWYtxB+jjmGVw
         Clmb68bkVHRK2Gmkn8caxbz06opiaHt/GgZMbvb0ZxH58b8KkGNsAtQmfqLNxobBEYqH
         6H8WnLTyz2p1L7/I6L++y9cEmGSLo9SDDJsHLsw4NWJ5cXXV9tBr5/YMrUuWBJDBX2u4
         823JEAuCh1qqKn0QVNCrdu20vBvdoBMDYO5fhsXzhII6im8h/TVNhZAGRQoWTLsjKLce
         zuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOX9zjUZFkr9z7v9HthQbYfzbIWKCxg0bpV+kFj752Q=;
        b=FRMcv8ck1zwOK2R/6HH0kDwnLZBoKy0OMqfzdzDFJt6YQEy85ikFGKxne5hXHszO96
         uUqaFejLe4GKnCpgt1dYRkbAsy+hltDM37Gzs0FNq5vdOUZgaVEE8/frET7kUCfdyfwI
         flT099hNe0JypyduQPNxomP81cnauf6vgWacZQFu43HdRIcppNkA0ZkvTVmr6CoU4dIz
         EB72aZGgeJ4nu6H3eRaG4KIcxAE4vx2JofDoB3BHfc9Vpue1J0axqTkfQMawondLhs8K
         J/aFXY1VlvSQxhGna26Yfcq7i30kx/WABUaxWAvoh+uuFKFyJbIyeiB0fj1eeeagGIud
         NeSA==
X-Gm-Message-State: ACrzQf1npy5AqGLyDBX4Jh57PIYFLLPxnXMsaXq6u94BBv7zHWAu25rG
        wa4OwMRBM9Olk7EF0WJllUfQNg==
X-Google-Smtp-Source: AMsMyM74duCvRHfxLbIJOIZ+HAamQmseiB+R4lDKUyA/yqs2F1ppB+86f6gdiucReM3MNJoPm7wCKQ==
X-Received: by 2002:a5d:6589:0:b0:236:52af:3b70 with SMTP id q9-20020a5d6589000000b0023652af3b70mr33270343wru.349.1667901817444;
        Tue, 08 Nov 2022 02:03:37 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o35-20020a05600c512300b003cfbbd54178sm1120625wms.2.2022.11.08.02.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 02:03:36 -0800 (PST)
Message-ID: <4789703d-0434-2e72-0001-5a7e1014f816@linaro.org>
Date:   Tue, 8 Nov 2022 10:03:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] nvmem: stm32: add OP-TEE support for STM32MP13x
To:     Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Etienne CARRIERE <etienne.carriere@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <20221028145252.2115933-1-patrick.delaunay@foss.st.com>
 <20221028165150.3.Ibc43aa73f865090affeb1751af0cc260c7f1dd07@changeid>
 <99a8d093-13f3-9ff8-6d87-d4aecaec1566@linaro.org>
 <a4ae3648-2943-55e0-243f-71a3c5f71ad8@foss.st.com>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <a4ae3648-2943-55e0-243f-71a3c5f71ad8@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2022 10:59, Patrick DELAUNAY wrote:
> Hi,
> 
> On 11/1/22 08:26, Srinivas Kandagatla wrote:
>>
>>
>> On 28/10/2022 15:52, Patrick Delaunay wrote:
>>> For boot with OP-TEE on STM32MP13, the communication with the secure
>>> world no more use STMicroelectronics SMC but communication with the
>>> BSEC TA, for data access (read/write) or lock operation:
>>> - all the request are sent to OP-TEE trusted application,
>>> - for upper OTP with ECC protection and with word programming only
>>>    each OTP are permanently locked when programmed to avoid ECC error
>>>    on the second write operation
>>>
>>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> ---
>>
>> For some reason I pushed this patch without a full review, This is now 
>> reverted from nvmem-next.
> 
> 
> Ok
> 
> 
>>
>> Why not add TEE client based new driver instead of ifdefing around 
>> this driver? Also I see there is not much common across both drivers 
>> anyway.
> 
> 
> I hesitate between the 2 solutions. I choose this update to handle the 
> STM32MP15 support with OP-TEE.

How are you to handing this?

> 
> For backward compatibility reason the same driver STM32 ROMEM associated 
> to compatible "st,stm32mp15-bsec" should be kept.
> 
> - the lower OTP can directly accessible by Linux (the IP is not secured) 
> => boot with SPL

Can we determine this at runtime?

> 
> - the upper OTP and the write operation are requested by 
> STMicroelectronics SMCs
> 
>     => boot with TF-A SPMIN and old OP-TEE (before migration to STM32 
> BSEC PTA)
> 
> 
> But in the future OP-TEE the access to OTP should be also done with 
> STM32 BSEC PTA...

Given that we have only one compatible for these two type of 
combinations how are you planning to deal with both the cases and still 
be backward compatible?

--srini
> 
> 
> I can manage this compatibility by detection in STM32 romem driver if 
> the booth access are managed in the same driver.



> 
> This patch can be added in the serie to understood the detection mechanism.
> 
> 
>>
>>
>>>
>>>   drivers/nvmem/stm32-romem.c | 450 +++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 446 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
>>> index 6de565639d5f..dfdedbcca9b9 100644
>>> --- a/drivers/nvmem/stm32-romem.c
>>> +++ b/drivers/nvmem/stm32-romem.c
>>> @@ -11,6 +11,7 @@
>>>   #include <linux/module.h>
>>>   #include <linux/nvmem-provider.h>
>>>   #include <linux/of_device.h>
>>> +#include <linux/tee_drv.h>
>>>     /* BSEC secure service access from non-secure */
>>>   #define STM32_SMC_BSEC            0x82001003
>>> @@ -25,14 +26,22 @@
>>>   struct stm32_romem_cfg {
>>>       int size;
>>>       u8 lower;
>>> +    bool ta;
>>>   };
>>>     struct stm32_romem_priv {
>>>       void __iomem *base;
>>>       struct nvmem_config cfg;
>>>       u8 lower;
>>> +    struct device *ta;
>>>   };
>>>   +struct device *stm32_bsec_pta_find(struct device *dev);
>>> +static int stm32_bsec_pta_read(void *context, unsigned int offset, 
>>> void *buf,
>>> +                   size_t bytes);
>>> +static int stm32_bsec_pta_write(void *context, unsigned int offset, 
>>> void *buf,
>>> +                size_t bytes);
>>> +
>>>   static int stm32_romem_read(void *context, unsigned int offset, 
>>> void *buf,
>>>                   size_t bytes)
>>>   {
>>> @@ -173,15 +182,25 @@ static int stm32_romem_probe(struct 
>>> platform_device *pdev)
>>>       } else {
>>>           priv->cfg.size = cfg->size;
>>>           priv->lower = cfg->lower;
>>> -        priv->cfg.reg_read = stm32_bsec_read;
>>> -        priv->cfg.reg_write = stm32_bsec_write;
>>> +        if (cfg->ta) {
>>> +            priv->ta = stm32_bsec_pta_find(dev);
>>> +            /* wait for OP-TEE client driver to be up and ready */
>>> +            if (!priv->ta)
>>> +                return -EPROBE_DEFER;
>>> +
>>> +            priv->cfg.reg_read = stm32_bsec_pta_read;
>>> +            priv->cfg.reg_write = stm32_bsec_pta_write;
>>> +        } else {
>>> +            priv->cfg.reg_read = stm32_bsec_read;
>>> +            priv->cfg.reg_write = stm32_bsec_write;
>>> +        }
>>>       }
>>>         return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &priv->cfg));
>>>   }
>>>     /*
>>> - * STM32MP15 BSEC OTP regions: 4096 OTP bits (with 3072 effective bits)
>>> + * STM32MP15/13 BSEC OTP regions: 4096 OTP bits (with 3072 effective 
>>> bits)
>>>    * => 96 x 32-bits data words
>>>    * - Lower: 1K bits, 2:1 redundancy, incremental bit programming
>>>    *   => 32 (x 32-bits) lower shadow registers = words 0 to 31
>>> @@ -191,6 +210,13 @@ static int stm32_romem_probe(struct 
>>> platform_device *pdev)
>>>   static const struct stm32_romem_cfg stm32mp15_bsec_cfg = {
>>>       .size = 384,
>>>       .lower = 32,
>>> +    .ta = false,
>>> +};
>>> +
>>> +static const struct stm32_romem_cfg stm32mp13_bsec_cfg = {
>>> +    .size = 384,
>>> +    .lower = 32,
>>> +    .ta = true,
>>>   };
>>>     static const struct of_device_id stm32_romem_of_match[] = {
>>> @@ -198,6 +224,8 @@ static const struct of_device_id 
>>> stm32_romem_of_match[] = {
>>>           .compatible = "st,stm32mp15-bsec",
>>>           .data = (void *)&stm32mp15_bsec_cfg,
>>>       }, {
>>> +        .compatible = "st,stm32mp13-bsec",
>>> +        .data = (void *)&stm32mp13_bsec_cfg,
>>
>> missing sentinel, which caused a regression in next.
> 
> 
> Ok, sorry for my error in the rebase conflict.
> 
> 
> Patrick
> 
> 
>>
>>
>> --srini
>>>       },
>>>   };
>>>   MODULE_DEVICE_TABLE(of, stm32_romem_of_match);
>>> @@ -209,7 +237,421 @@ static struct platform_driver 
>>> stm32_romem_driver = {
>>>           .of_match_table = of_match_ptr(stm32_romem_of_match),
>>>       },
>>>   };
>>> -module_platform_driver(stm32_romem_driver);
>>> +
>>> +#if IS_ENABLED(CONFIG_OPTEE)
>>>
> ....
> 
> 
>>> +
>>> +module_init(stm32_romem_init);
>>> +module_exit(stm32_romem_exit);
>>>     MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
>>>   MODULE_DESCRIPTION("STMicroelectronics STM32 RO-MEM");
