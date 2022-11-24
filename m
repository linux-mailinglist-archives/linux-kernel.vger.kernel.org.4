Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F027637497
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiKXI4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKXI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:56:36 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3862B8756F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:56:35 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y4so932268plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+JlTCURFbhvaQe3VOudsfUIZNYcfNLZEHpC87BXVEE=;
        b=RVuYHCbfloxktxLMqw8zNS/LMduzjvrHQ9tEgE8Hg5Y9kP1l2ycAHmS9TSrEY01ZLt
         aPztU0lmLF5/dgbK/S9yFb4VAEPRz3N/Zp+EdR8uyC0HLbqOqTeQx4JVwfKRbn5fps8P
         JtrBYa7hIXjztPMZIlw5Oj7j0XphO0gsNSczbwzZ+zAL0ESf4gzrUXcmuJTv8FMq6bHU
         /qnqswrZ2RVO1K3jiP2pEngdCF1wJY22WDcObU699AAKoqqNlp9jHetfpsmLnym0YfDb
         1Xv5lD3lwUua3GRWAzvMtf1GBDDwDZkAIOzCJTYL5QXT9PxqtNAFmI7jjJxkbc1ozQnX
         rhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+JlTCURFbhvaQe3VOudsfUIZNYcfNLZEHpC87BXVEE=;
        b=s7LLaWE6PS6+RKwQyOQba+E8zAt/G0gxTHsvqYCGq6rRAmOLM+yYGjtrPKZqB3KZyT
         IrcXosFEctqd6ff49TZ8qOyHkYsLUv7OEuG5UUkgImMImcTY0wRXLxzfKwk8EHo7nNsK
         f/BMBgh/LirK9BgtMdCPJKpIS4q8iJc5SmQUjhtWIJpyVQL1GRy/SIzeHtwo3XT3hD8u
         9N+ZZWj22+YWcrumvLhKDXeE3jgugJgUp2qvg1De8ErEzTsBhXRJLht2JA3kBtCfkFEN
         Ben1sYsnw3PtlV6CCNwMpRzH7vtff0YgXKtoAufBg1BQ24W3uVCxUT/QwEvHZknzUUUX
         LfYA==
X-Gm-Message-State: ANoB5play7nIFwfRNlb4hYC1chkGhsTEZaPaNwA4MnlUhBesZmWQ0kQ8
        UPFwG+Oj+3zOkXJmedDel4JVRA==
X-Google-Smtp-Source: AA0mqf4wDtKU6FE10Kh5h9uR3I85P0FI6tiarpFlWpI7Zh6Qf7/ihXAMpOcaD24k80GlHGKrbWnSTw==
X-Received: by 2002:a17:90a:d38a:b0:218:a7e6:60df with SMTP id q10-20020a17090ad38a00b00218a7e660dfmr21150431pju.38.1669280194819;
        Thu, 24 Nov 2022 00:56:34 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f7cc00b0018958a913a2sm657661plw.223.2022.11.24.00.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 00:56:34 -0800 (PST)
Message-ID: <df8201b0-414e-4daf-0dae-bd3ce790304c@9elements.com>
Date:   Thu, 24 Nov 2022 14:26:32 +0530
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
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <1724dbac-024a-2758-a030-c07352b536fc@roeck-us.net>
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

Hi Guenter,

On 22-11-2022 10:32 pm, Guenter Roeck wrote:
> On 11/22/22 05:50, Naresh Solanki wrote:
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> Implement IRQ support to monitor PMBUS regulator events.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> Adding a PMBus interrupt handler should be generic and also handle hwmon
> specific events. It should report any status changes as sysfs attribute
> notifications.
This handler scope is to address regulator faults.

> 
> Guenter
> 

Regards,
Naresh
