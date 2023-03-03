Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A3C6A9468
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCCJsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCCJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:48:21 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73B2D31F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:48:17 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so3065231wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23Z3X1K5N5UuRVaVfx5jG4l/8tOn32i2PmVWKuVL6kA=;
        b=q9hoRd/t3CA5Sz9OiT2YSI95/ifslPF/GIjYiJAzTXnCh5sD2HlUvUDhDHgj6aVeRj
         e1RXGNwW0czS96IHKmuj/0I7lCngC4FUTU+mYdAp2hClefE1hYQB61mEV5GWeM5YAJ6I
         +x/WMXoqPeLq/bwyayA3JJjoZ0H4zU3QjAYZQU1vgMEGadeD01O2WE+5igm8AhNId82g
         nYvkykUw1OdMifF7BKTnfT4ldtZYsTp2l95238pr96pu+7VInggrCT73O0fB5g53yzo9
         LJjdOZ9/aHZOQ8g+pLD+nXdcrpK9ZuHO/IfuqhCVRthaT0sQ8mPayCqyRgqpCcnZllb7
         7BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23Z3X1K5N5UuRVaVfx5jG4l/8tOn32i2PmVWKuVL6kA=;
        b=ZmQTPn1jyt9Mn89BYol8BV+wi4DHVDohPE1h2MiAAy7I3FQEl3P2YkZu5j6+MTQF/h
         E+HFMCfLCsQishksk4DYsfxopMMix+CpuQzekuJ/jJjm0TSV5aOwURNtMQ16kYTw7Kln
         WrwJn3T2l/bdFj1xrkASbCWQQ9cE4xHMjOt9dMDnEct2C2d0Y7oLi9mqd9QAMD8nNZ4l
         qHITGSsUYqONhMfTlC1d+sJG9iPeAaWg2yZ+REB+LlaqGngmzFLdd7un0GOZis68XpZT
         NrsQxXqM49lpoMBzwbnrbIf+4QHTW3kweKqgwKCWMhPCkOs0NW4pkiUwGWvmHRAzdHoD
         oflw==
X-Gm-Message-State: AO0yUKWTcfSyDTaqwc4S0VIb6OmVh6F6J5e+AI1v96oUuwsTfgfXLMpt
        pABaQyXTGwSub4HtEtAv0xJV1w==
X-Google-Smtp-Source: AK7set/ZEFLM78ntYTmWl8llRTFGkS4U3M9sRqLEHjCHjzcyKzX9DNaUQQm5tv7/4dKbRmfGZ/4Sww==
X-Received: by 2002:a05:600c:4e8f:b0:3eb:2da4:f32d with SMTP id f15-20020a05600c4e8f00b003eb2da4f32dmr1002977wmq.26.1677836896081;
        Fri, 03 Mar 2023 01:48:16 -0800 (PST)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c091d00b003dc521f336esm1902294wmp.14.2023.03.03.01.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 01:48:15 -0800 (PST)
Message-ID: <dbf4b01d-e3c7-28fc-890d-9bb51c919f59@baylibre.com>
Date:   Fri, 3 Mar 2023 10:48:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mfd: tps65219: Add support for soft shutdown via sys-off
 API
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, tony@atomide.com,
        lee@kernel.org
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, nm@ti.com, afd@ti.com, msp@baylibre.com
References: <20230203140150.13071-1-jneanne@baylibre.com>
 <4b9fc988-5313-757a-b3bc-ec90dba4f4b2@ti.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <4b9fc988-5313-757a-b3bc-ec90dba4f4b2@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/03/2023 06:36, Vignesh Raghavendra wrote:
> 
> 
> On 03/02/23 19:31, Jerome Neanne wrote:
>> Use new API for power-off mode support:
>> Link: https://lwn.net/Articles/894511/
>> Link: https://lore.kernel.org/all/7hfseqa7l0.fsf@baylibre.com/
>>
>> sys-off API allows support of shutdown handler and restart handler.
>>
>> Shutdown was not supported before that enhancement.
>> This is required for platform that are not using PSCI.
>>
>> Test:
>> - restart:
>>    # reboot
>>    Default is cold reset:
>>    # cat /sys/kernel/reboot/mode
>>    Switch boot mode to warm reset:
>>    # echo warm > /sys/kernel/reboot/mode
>> - power-off:
>>    # halt
>>
>> Tested on AM62-SP-SK board.
>>
> 
> There is no -SP-SK that I am aware of.. Do you mean -LP-SK?
You are right, this is a typo. It's LP-SK
> [...]
> 
