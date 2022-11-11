Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD686260C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiKKSDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbiKKSC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:02:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCCF77E4A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:02:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so3613362wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OlH0QNtWKGQs1bVflWE70OyJVa1i7TKc+YHXJpmQvE=;
        b=aEn5McTvGMq/smgffe9DlOFzMQOIABpmzOQUNz6DuKSJBIziPCx47on6ETUL0T507u
         Eh5crjdJgyJ33iuGYcW1fnFYq/HkPuootm6JPKnIqg/GrQY6EiA8mC17JvqcnLeo1LjF
         QQb8sPN5Oq857F7TCXh+pcdjKYvd7f0/OdxEDz7NpOEEh6kogjG4vXUS/14RYxUztKIn
         P4h4v1zsyPH7uQ7u5WkTOOgjxIFxEcHxBFP43d0Dtp2p8rKEFZQB+mp8XSakuYnRFaTV
         6Rth/SAOaftlI6+CXxP0mFcaDhlGGyMcqepWtAaNjMknE6n8W0BPQToVwXcgyoeulZ5+
         MJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OlH0QNtWKGQs1bVflWE70OyJVa1i7TKc+YHXJpmQvE=;
        b=oOUn93VXv/iXVCLHHrelcfVo7FeuijL+lTZmNaFYhVGSv2Jt1UVaSrUx4tskwgCE3b
         k4CwJKw2EmHvLZ8I/uxCtvqWrEEA3IlhyREAwgxDbkT0uQ+Z7l5123Nf5dJ7Si9QGHma
         Vw8NWXkSK7aDc7ifeDc/ZOSFZ5NbMklRsWvX0nKiMruIE6ugzpYrC1pLEIjvQ9aexWZe
         15sacYXAJlgPT3NGlZ+DxFoMlyd8Z+uhEwvv8NcOVa/HkgxTRYFWOxNCVZL6ddYYzl6p
         VIWGGhkCL2/50Vhx+RG3bS40ln5qLAVP8nOO47e6qn1qlnBLATxLQtgvLDW3kyehHnei
         I9Cg==
X-Gm-Message-State: ANoB5plDY5i6xsqwvSNkv30sdxK+ToL7gycV1AfauuRZCS6pylZ+QUhC
        Nz4qvrEHux8w9bCYakJLL6Zqiw==
X-Google-Smtp-Source: AA0mqf5gqJS5n7MhaHg/1SIXShxU3C0DKdNvmI4P3RLm/zSMCufpq/mhtGloXYsjWzUFfKNzsNS/cQ==
X-Received: by 2002:a05:600c:1c1a:b0:3cf:aae0:802a with SMTP id j26-20020a05600c1c1a00b003cfaae0802amr2093558wms.112.1668189774731;
        Fri, 11 Nov 2022 10:02:54 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j5-20020a05600c1c0500b003cfbbd54178sm14542001wms.2.2022.11.11.10.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 10:02:53 -0800 (PST)
Message-ID: <68533848-7deb-8f80-6218-04dc9001376e@linaro.org>
Date:   Fri, 11 Nov 2022 18:02:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvmem: u-boot-env: add Broadcom format support
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Tom Rini <trini@konsulko.com>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20221017071722.32731-1-zajec5@gmail.com>
 <fe41146d-48f9-3e9c-1e5a-48e8488f4fee@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <fe41146d-48f9-3e9c-1e5a-48e8488f4fee@gmail.com>
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



On 11/11/2022 17:57, Rafał Miłecki wrote:
> On 17.10.2022 09:17, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. They
>> decided to store U-Boot environment data inside U-Boot partition and to
>> use a custom header (with "uEnv" magic and env data length).
>>
>> Add support for Broadcom's specific binding and their custom format.
>>
>> Ref: c34f9f5499278 ("dt-bindings: nvmem: u-boot,env: add Broadcom's 
>> variant binding")
> 
> This should be actually:
> 6b0584c19d87 ("dt-bindings: nvmem: u-boot,env: add Broadcom's variant 
> binding")
> 
> Srinivas: could you fix it up while applying, please?
> 

Applied with this change

--srini
> 
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   drivers/nvmem/u-boot-env.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
>> index 8e72d1bbd649..049330660fd7 100644
>> --- a/drivers/nvmem/u-boot-env.c
>> +++ b/drivers/nvmem/u-boot-env.c
>> @@ -16,6 +16,7 @@
>>   enum u_boot_env_format {
>>       U_BOOT_FORMAT_SINGLE,
>>       U_BOOT_FORMAT_REDUNDANT,
>> +    U_BOOT_FORMAT_BROADCOM,
>>   };
>>   struct u_boot_env {
>> @@ -40,6 +41,13 @@ struct u_boot_env_image_redundant {
>>       uint8_t data[];
>>   } __packed;
>> +struct u_boot_env_image_broadcom {
>> +    __le32 magic;
>> +    __le32 len;
>> +    __le32 crc32;
>> +    uint8_t data[0];
>> +} __packed;
>> +
>>   static int u_boot_env_read(void *context, unsigned int offset, void 
>> *val,
>>                  size_t bytes)
>>   {
>> @@ -138,6 +146,11 @@ static int u_boot_env_parse(struct u_boot_env *priv)
>>           crc32_data_offset = offsetof(struct 
>> u_boot_env_image_redundant, mark);
>>           data_offset = offsetof(struct u_boot_env_image_redundant, 
>> data);
>>           break;
>> +    case U_BOOT_FORMAT_BROADCOM:
>> +        crc32_offset = offsetof(struct u_boot_env_image_broadcom, 
>> crc32);
>> +        crc32_data_offset = offsetof(struct 
>> u_boot_env_image_broadcom, data);
>> +        data_offset = offsetof(struct u_boot_env_image_broadcom, data);
>> +        break;
>>       }
>>       crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
>>       crc32_data_len = priv->mtd->size - crc32_data_offset;
>> @@ -202,6 +215,7 @@ static const struct of_device_id 
>> u_boot_env_of_match_table[] = {
>>       { .compatible = "u-boot,env", .data = (void 
>> *)U_BOOT_FORMAT_SINGLE, },
>>       { .compatible = "u-boot,env-redundant-bool", .data = (void 
>> *)U_BOOT_FORMAT_REDUNDANT, },
>>       { .compatible = "u-boot,env-redundant-count", .data = (void 
>> *)U_BOOT_FORMAT_REDUNDANT, },
>> +    { .compatible = "brcm,env", .data = (void 
>> *)U_BOOT_FORMAT_BROADCOM, },
>>       {},
>>   };
