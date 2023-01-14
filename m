Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F3D66A94A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 05:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjANEow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 23:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjANEos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 23:44:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5430DA4;
        Fri, 13 Jan 2023 20:44:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q64so24308507pjq.4;
        Fri, 13 Jan 2023 20:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGwB257AdpC1fAL0nSSnjqsI/M6uThtuC4LfS4+SqZU=;
        b=RisbqdtLLw+gQGxMC8RO7OPkQ7m5mx9DD6E4LyCkzZJANlrTUHN3fd7s9+sEVb3b1B
         JrdsPT/auwrBmJvpkcbuNLviE6/QzUlML5BzzwdGVYdXMlVb8oIP7ntbFuhcCqLm+eBs
         IGLkqHvCuQx8Zq4S1jXJ3bzAMEDqKeonsceKeAYD+44hFfls+hmlCuvz7GFeD5c7Fj8i
         nnGb2key9bxIV9PjVUhIDiKEbpmmy11xenSE/Tx35edrTfVk1OMk8jDSUsoryR2SPbe5
         uW0DajHwexCQ63cRSYOpYsjuyRIqVzB+AdcqoxTNtyDLxaRIcSisLh4KRz2K73O55yLg
         q5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGwB257AdpC1fAL0nSSnjqsI/M6uThtuC4LfS4+SqZU=;
        b=wFn/TcRsJ6DT3X4GxmWyFPXzNlL0Q3dj5UxnplC+kKl/s65pOqiA5AgwO8kYG4mj6a
         GWZJ9ce9Pe9TfhKZq6OEX03uRnfy/adAqSIYc+/Og8l9XqkO5tek3fOH1taFZKm3+Gdq
         aLSTqW3uDyB7cih8DpyEY+Rs7/RmPVQq/eish+KdNMsFRBL/vRjbYpyyDLq3MlWo+M+v
         Cu0Opve7qKLvQIVpsok7QAvlUIiWw4i8lAhJt7CRpTvnKqudKvx10AJAPakhfXVzDUgY
         EtCPZkHtwZ31q7F9aUeVoK8Hvju0sHNchmq3Ag9yBjtUoZzVkyXTphT2blZ46hV4VrNy
         56rw==
X-Gm-Message-State: AFqh2koZleyrtm4gKk2kvo1EpGKPieM+op60GCN1lJKQ/N8BmARCNNGT
        JY3rBy459EDhdntWQqu9MTE=
X-Google-Smtp-Source: AMrXdXv+c5SPhcd1BE0v9XlSOn+qEIy/YA7cTo+PDXymSv9SnxRT75ubQC1lPmvaZj7fR7cmT6dmvg==
X-Received: by 2002:a05:6a20:1b04:b0:af:88d2:33f8 with SMTP id ch4-20020a056a201b0400b000af88d233f8mr13248740pzb.7.1673671485780;
        Fri, 13 Jan 2023 20:44:45 -0800 (PST)
Received: from ?IPV6:240b:12:500:6500:dd98:10ce:e5c4:a8d4? ([240b:12:500:6500:dd98:10ce:e5c4:a8d4])
        by smtp.gmail.com with ESMTPSA id m9-20020a654c89000000b004a281fb63c3sm12427667pgt.87.2023.01.13.20.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 20:44:45 -0800 (PST)
Message-ID: <8db143ce-d479-d7c8-bf85-f81d7a6e66d9@gmail.com>
Date:   Sat, 14 Jan 2023 13:44:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] memory: omap-gpmc: fix multi-device handling on the same
 CS
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        rogerq@kernel.org, tony@atomide.com
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230111141346.1516-1-musashino.open@gmail.com>
 <2a2b2412-752a-1c64-41b7-eb256ae55f42@linaro.org>
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
In-Reply-To: <2a2b2412-752a-1c64-41b7-eb256ae55f42@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

thank you for your review and sorry for my ugly patch.

On 2023/01/11 23:57, Krzysztof Kozlowski wrote:
> On 11/01/2023 15:13, INAGAKI Hiroshi wrote:
>> This patch fixes the handling of multiple devices on the same CS by
> Do not use "This commit/patch".
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
Okay, I'll improve.

>
>> replacing CS name to "name" of node instead of "full_name".
>>
>> In c2ade654dbf7d02f09ad491f5621fc321d4af96b
>> ("memory: omap-gpmc: Use of_node_name_eq for node name comparisons"),
> Use syntax: commit short SHA (".....") as pointed by checkpatch.
I see, I'll replace.

>
>> the name for setting to CS was replaced but it doesn't fit for the
>> comparison by of_node_name_eq.
>> In of_node_name_eq, the length for strncmp will be obtained from the
>> node that trying to register and it doesn't contain the length of
>> "@<cs>,<offset>".
> Skip explanation what is inside of_node_name_eq() but focus on what the
> driver is doing.
Okay, I'll improve it.

>
>> But the base name for comparison passed from
>> registered CS name contains the prefix,
> What is "the prefix"?
Ahh, it's not a prefix, but suffix...my mistake.

>
>>   then, that two lengths won't
>> match and false will be returned, and registration on the same CS
>> will be failed.
> Unfortunately, based on this, I don't get what is compare with what. I
> bet the issue is simple, but based on the description it does not look
> like that.
Indeed... I wrote it because I felt like I had to explain it in detail, 
but I made it unnecessarily complicated.
I'll improve and make it concise.

>
>> example (Century Systems MA-E350/N, AM3352):
>>
>> - Device Tree
>>
>>    /* memory mapped gpio controllers on GPMC */
>>    gpio@2,2 {
>>        reg = <2 0x2 0x1>; /* CS2, offset 0x2, IO size 0x1 */
>>        ...
>>    };
>>
>>    gpio@2,10 {
>>        reg = <2 0x10 0x1>; /* CS2, offset 0x10, IO size 0x1 */
>>        ...
>>    };
>>
>>    gpio@2,12 {
>>        reg = <2 0x12 0x1>; /* CS2, offset 0x12, IO size 0x1 */
>>        ...
>>    };
>>
>>    gpio@2,14 {
>>        reg = <2 0x14 0x1>; /* CS2, offset 0x14, IO size 0x1 */
>>        ...
>>    };
> Trim it, two entries might be enough to illustrate it.
Okay, I'll reduce.

>
>> - dmesg
>>
>>    [    1.596402] omap-gpmc 50000000.gpmc: cannot request GPMC CS 2
>>    [    1.596434] omap-gpmc 50000000.gpmc: failed to probe DT child 'gpio': -16
>>    [    1.596489] omap-gpmc 50000000.gpmc: cannot request GPMC CS 2
>>    [    1.596511] omap-gpmc 50000000.gpmc: failed to probe DT child 'gpio': -16
>>    [    1.596564] omap-gpmc 50000000.gpmc: cannot request GPMC CS 2
>>    [    1.596586] omap-gpmc 50000000.gpmc: failed to probe DT child 'gpio': -16
>>
>>    ("gpio@2,2" is ok, "gpio@2,10", "gpio@2,12", "gpio@2.14" are fail)
>>
>> Fixes: c2ade654dbf7d02f09ad491f5621fc321d4af96b
>> ("memory: omap-gpmc: Use of_node_name_eq for node name comparisons")
> Also not correct tag. Run checkpatch.
>
> No blank lines.
I'll fix.

>
>> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
>
>> ---
>>   drivers/memory/omap-gpmc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
>> index d78f73db37c8..3e3e84e34795 100644
>> --- a/drivers/memory/omap-gpmc.c
>> +++ b/drivers/memory/omap-gpmc.c
>> @@ -2202,7 +2202,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>   		dev_err(&pdev->dev, "cannot request GPMC CS %d\n", cs);
>>   		return ret;
>>   	}
>> -	gpmc_cs_set_name(cs, child->full_name);
>> +	gpmc_cs_set_name(cs, child->name);
>>   
>>   	gpmc_read_settings_dt(child, &gpmc_s);
>>   	gpmc_read_timings_dt(child, &gpmc_t);
>>
>> base-commit: 13f35b3c72f4075e13a974f439b20b9e26f8f243
> Best regards,
> Krzysztof
>

I've completely forgot to run checkpatch.pl before sending...
Before sending the next patch, I will fix the points pointed out this 
time, read the guidelines carefully again and run checkpatch.

Regards,
Hiroshi
