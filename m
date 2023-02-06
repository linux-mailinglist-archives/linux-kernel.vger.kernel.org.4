Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A253468BEFD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjBFN5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjBFN5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:57:12 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C0279A5;
        Mon,  6 Feb 2023 05:56:18 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 123-20020a4a0681000000b004faa9c6f6b9so1105166ooj.11;
        Mon, 06 Feb 2023 05:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=M/ScyK/OROP9tthD5it+CFMOeANaS2TfYZEW0alU7+w=;
        b=jfpeSuNtRk8ZozjxQKKYLnoCz0wSDUzbwrEXZS3SESQ7qoEFs9HlAFqlpWB+5HTyTC
         GJ+2jU2K5/gX0EVZAr1NgmN/Im9vSzLaYrLmOQivC0h77AyO8JIdgUZoPv+9DKy0ktWF
         r6QUxGELY5Mx8D5PdIH2kaqkVgXuEvQekJvibyhoefTK4a74Xx86aUtuUQrAFpsqh2BN
         D38uC3FIx4QC5rWtu8dKxCxl1JgTX7Ifr14e4Yv8KLxb/mCy7+aYunf/ZaxUbsHqS3IE
         FCE6mGnmNmHpPcpZOaSlNvUR607ZKQtMid7vGhqal8YGj5SjTakV807cFKki84QkKkVR
         c5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/ScyK/OROP9tthD5it+CFMOeANaS2TfYZEW0alU7+w=;
        b=xRxHVOzQC5Z4dH2f44JnYD/NC9LWFjX2mJ19LOJyXIL9rbGCcACGJHW1KjBgAK+eNz
         3Zp+ECVtZUo9I2UNCZ1/jtfAt6QGp1YOhn/vO9/jIQR7M2oklVUpwijosytwyA4tQ/dH
         nMmQlM9T3wstUqcmE9s7pqDfJgIpH6fy8Aeb8M68tbcVxNc4J3k5JOUe2Revk+9G7kbt
         5dVAAiwxA86GLyDCkH/hvP7RFL2dSyZ7rniyY+3E0GFPQ+xOcOw8DrqUB47hNwtjIuAY
         NDcNoxzL2EO3QxI1SBn7Bf708uLpPTsZ2VyL06MGxIbHufcy2BV2leP38fhg0ByaZPDv
         lquQ==
X-Gm-Message-State: AO0yUKXBQICJSLhTrgWB7QMONmhVs6IrC3KCVjHgQHC23J9EdASWcIa+
        zSW+EA67L5S95hYB7K9GEjg=
X-Google-Smtp-Source: AK7set8XCGE2V8OJ/1Fo5vsdndP5+FcblwVGf8Ip72WurbGHEgkZfXaF5KT1pttcuNKlN9mxzhAoTg==
X-Received: by 2002:a4a:4f42:0:b0:517:b904:b4ec with SMTP id c63-20020a4a4f42000000b00517b904b4ecmr9624885oob.2.1675691743411;
        Mon, 06 Feb 2023 05:55:43 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v8-20020a4aa408000000b005178a98b6d2sm4567423ool.30.2023.02.06.05.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 05:55:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b7da8789-6c55-cf41-b95a-e87f9341c438@roeck-us.net>
Date:   Mon, 6 Feb 2023 05:55:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/5] diag288 watchdog fixes and improvements
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
 <Y+DPnGN9l7Ix+TX7@osiris>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Y+DPnGN9l7Ix+TX7@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/23 01:59, Heiko Carstens wrote:
> On Fri, Feb 03, 2023 at 08:39:53AM +0100, Alexander Egorenkov wrote:
>> Minor code refactoring to improve readability of the driver,
>> reduce code duplication and remove dead code.
>>
>> Alexander Egorenkov (5):
>>    watchdog: diag288_wdt: get rid of register asm
>>    watchdog: diag288_wdt: remove power management
>>    watchdog: diag288_wdt: unify command buffer handling for diag288 zvm
>>    watchdog: diag288_wdt: de-duplicate diag_stat_inc() calls
>>    watchdog: diag288_wdt: unify lpar and zvm diag288 helpers
>>
>>   drivers/watchdog/diag288_wdt.c | 162 ++++++++-------------------------
>>   1 file changed, 37 insertions(+), 125 deletions(-)
> 
> Guenter, Wim, how should this go upstream?
> 
> I can easily pick this up via the s390 tree for the next merge window.
> Please let me know.
> 

I have it currently in my watchdog-next tree, but that is not in linux-next.
Fine with me to go through the s390 tree.

Guenter

