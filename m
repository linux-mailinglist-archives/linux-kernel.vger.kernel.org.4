Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A103731BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344370AbjFOO4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344970AbjFOO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:56:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8A6295E;
        Thu, 15 Jun 2023 07:56:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b3ce6607cbso38262715ad.2;
        Thu, 15 Jun 2023 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686840981; x=1689432981;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZDxzGx+G580mVpzt8oru30YD1LI8dedL/dXnT63ZTM=;
        b=Dis3/aJs4NwHXZvhsDEIsKUnAKbpjHAkmQgpd4cy2WH3NTPIqurq8SH3R5tYlpikC5
         Led3AMYDd1XcKlbh3yTh3SDCAf2C2BuvQEQ1d3PqamQdaotL8r8TPWoMGQpg6KTUwjU8
         FbQJffUPxkehUF5/feN2Vnjup6S5cBr+v/L9X6GriAzsfScdFghJJyq6iiWvf9M6dEy1
         zn6k3XGIZvhEjKKho5VZ0DjlbLT3RJZk/U95VYHEDtrFw5VekKvjJiIp+Ew+QfTNbSFY
         SnLur1xOL3on6I2njwjimwaSllKJ03DizvcOCkizOuol64NzUEumTxjsJdBJAAXDgSPW
         qQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686840981; x=1689432981;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZDxzGx+G580mVpzt8oru30YD1LI8dedL/dXnT63ZTM=;
        b=hs3eNQDLHiNvMo0rCY37th1l3XY2XgBvT1bzZF8nRy8IAIQiooOfOam9qiHOoe2Oay
         bAuNfL3hTOWboYuleTxsqhr8stH7ICd2/Av8J4LGcxPUMG2pkRx/TyAHbU5SzMmNDWS0
         jZxv8qXuKUYmQ3u7KnHwqeYXkeESE43plKW8eXP8JNd/CyAbX3Kdzy0Q+S1AVo5WX2P2
         kgJr2H9yFGuM5ItJzTQKCyxukD0gJSe2JAsVc/WmsYcRz4JuZ/uwxEkvjXzOr+Z3K3Y7
         J4R8TArUsPhmwjmrOixrM9BVH8L/g+1EHkkhAiyksnhEgbDoBIqLHTJF2sduQdH8PRsL
         VgUg==
X-Gm-Message-State: AC+VfDxfoqpVP7JMaa0i4HRkilaVZTvmW4clwVtwAgE+jQYo8J3+BxD+
        6ALmHTZ5VjmA2f9bDHhwhazem8RjulQ=
X-Google-Smtp-Source: ACHHUZ7qXwcS5H6hN2QaTkV7k/UpiEXfSWvKM2CdglAb0m7vKZAARS7KxziUvCYAZsjMECb8gSg2Eg==
X-Received: by 2002:a17:903:124d:b0:1ac:aba5:7885 with SMTP id u13-20020a170903124d00b001acaba57885mr18000926plh.47.1686840981530;
        Thu, 15 Jun 2023 07:56:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b20-20020a170902d31400b001b414fae374sm3862361plc.291.2023.06.15.07.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 07:56:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <54ca1f3c-4d24-96f9-271e-30f97f5b75f4@roeck-us.net>
Date:   Thu, 15 Jun 2023 07:56:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
References: <DB4PR10MB6261D79FE16EC2BBD5316B91925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
 <6d1209e9-0d40-c2ba-b94c-6590e98070d7@roeck-us.net>
 <DB4PR10MB626134E4213F378A430E5EED925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
 <45c8771d-47c1-c007-1cd5-97eebedef147@roeck-us.net>
 <DB4PR10MB6261C86DEE5F4008B20C5033925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] hwmon: (sht3x)remove sht3x_platform_data
In-Reply-To: <DB4PR10MB6261C86DEE5F4008B20C5033925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 16:54, JuenKit Yip wrote:
> 
> 在 2023/6/15 3:15, Guenter Roeck 写道:
>> On 6/14/23 08:02, JuenKit Yip wrote:
>>>
>>> 在 2023/6/14 20:57, Guenter Roeck 写道:
>>>> On 6/13/23 23:24, JuenKit Yip wrote:
>>>>> Since no in-tree driver supports it, the sht3x_platform_data was
>>>>> removed.
>>>>>
>>>>> - "blocking_io" property and its related code have been removed, and
>>>>> Single-Shot mode should be blocking in default.
>>>>>
>>>>> - "high-precision" property has been replaced to "repeatability" for
>>>>> matching datasheet.
>>>>>
>>>>
>>>> That needs to be three patches.
>>>
>>> Patch 1: remove sht3x_platform_data and its header file
>>>
>>> Patch 2: move "blocking_io" to struct sht3x_data
>>>
>> Essentially merge it with update_interval==0 since (if I understand
>> correctly) blocking mode and update_interval==0 will be equivalent.
>> With that in mind, a separate "blocking_io" variable should no
>> longer be needed.
>>
> I reviewed the datasheet again, update_interval == 0 means Single-Shot
> 
> mode which owns blocking(clock strench) and non-blocking(non-clock strench)
> 
> options. If master supports clock-strench( I don't know how to detect it),
> 
> the property may be reserved.
> 

I see.

In practice, blocking mode was never really used, at least not in the
upstream kernel, since platform data was not set from any in-kernel
code. Given that it is pretty much untested, I would suggest to always
use non-blocking mode. This is only relevant if the chip is in
single-shot mode, so worst case the user would have to wait a bit longer
for results in that mode. I find that acceptable over the risk involved
when trying to use/support blocking mode.

Guenter

