Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C80638007
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiKXUC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXUC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:02:56 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D74140A7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 12:02:55 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c21so470087pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 12:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yriV1kcTjmeFSwCRxV7ARCgTj+gAgWe/fIgRxZlL04w=;
        b=cY1/wpjaxZXfnPLVRiGSJlm7QWtX1QnocGOiyy3eX6+1GqoIbnKC4lO+j8ipR1BNe0
         M0+SlJ2MQZzUGWRv4UDLp/Ro8TRYqYXiJOUqQIMCpFR56QxKw9tF/TIFfU3nBDAQr05C
         hCD2MS6FAfUxUN9HKn12mW3YtuqPg4Zru2h1T3xOsVyYb+OBIbyqjkKtl/aOTr5eUIz4
         I4Wky4ztJU12PCDstPMHIei32iliHLdN39gExVI/nDGy/YyeFpzTDs23odBkNVPz/9cg
         V60TqXkU4bAlgLj7KKu7MN1KH/16Aku3K+XuNRTN0Enpea7MmTnZ0jUxFI8wqpZhzWJ+
         jGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yriV1kcTjmeFSwCRxV7ARCgTj+gAgWe/fIgRxZlL04w=;
        b=pQ0V36LeH26l05a+NdE3954w2pVpDUwpoDasbK7B+VArn/5Uf9ejtdDfjFYv4D08pJ
         Kd7Cn6WFgmUsk3wlWRTEJCO2cqMFPiwtrECWWzCVnnwxSEjT+B/tx06+xpNVFmz1lUnO
         W6HKTkwuvfqX3mBoD5ZssWzKzTG6ubaWZzbiBJcfoGv8Rqm/LTXbMSrUwnVDPKiDJyqY
         UfwJnYy5Er4rJ2YxCuXt7qRQVBngfyJeEUH9IEA5BcURwIxfMtGZovQaiYJdUnN+Ozjf
         OrSmAWhlF0jdJ3eEoLqGfIRFwLHbfaXLe30/cOj++p7rVeoeRA95R5EyPuBqtQuLusu6
         13WA==
X-Gm-Message-State: ANoB5pl6ESHQR9nhkfKHiU/x++5uyfmpjBGPKKYxRBXw8bUS8PjRSAWJ
        rq46xDTpatvqpyO9j2in2e2PSxi79CnSGIFB
X-Google-Smtp-Source: AA0mqf7CLpl2VcseuxmVIMGJYgIM04KtYDaR1vy42JGbv4harJwakksTSKcDsA0eMs87fVxdFfYyIQ==
X-Received: by 2002:a63:ec47:0:b0:46f:c465:5848 with SMTP id r7-20020a63ec47000000b0046fc4655848mr14284641pgj.148.1669320174699;
        Thu, 24 Nov 2022 12:02:54 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id v10-20020aa799ca000000b0053e62b6fd22sm1473182pfi.126.2022.11.24.12.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 12:02:54 -0800 (PST)
Message-ID: <03dfb055-bca7-5ba8-0590-f32671af1498@9elements.com>
Date:   Fri, 25 Nov 2022 01:32:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/3] hwmon: (pmbus/core): Implement IRQ support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     broonie@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221122135014.3504094-1-Naresh.Solanki@9elements.com>
 <20221122135014.3504094-3-Naresh.Solanki@9elements.com>
 <1724dbac-024a-2758-a030-c07352b536fc@roeck-us.net>
 <df8201b0-414e-4daf-0dae-bd3ce790304c@9elements.com>
 <7ce64ea0-f595-a5b6-a810-2bc9133b5386@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <7ce64ea0-f595-a5b6-a810-2bc9133b5386@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter

On 24-11-2022 07:37 pm, Guenter Roeck wrote:
> On 11/24/22 00:56, Naresh Solanki wrote:
>> Hi Guenter,
>>
>> On 22-11-2022 10:32 pm, Guenter Roeck wrote:
>>> On 11/22/22 05:50, Naresh Solanki wrote:
>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>
>>>> Implement IRQ support to monitor PMBUS regulator events.
>>>>
>>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>
>>> Adding a PMBus interrupt handler should be generic and also handle hwmon
>>> specific events. It should report any status changes as sysfs attribute
>>> notifications.
>> This handler scope is to address regulator faults.
>>
> 
> Maybe that is the use case from your perspective, but this is primarily
> a hardware monitoring driver and needs to primarily serve its hardware
> monitoring functionality.
Yeah. What you said makes more sense. I'll do necessary changes & test & 
get back. Thanks :)
> 
> Guenter
> 
> 

Regards,
Naresh
