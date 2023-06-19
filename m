Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9493A735E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjFSUkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFSUkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:40:33 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E86128;
        Mon, 19 Jun 2023 13:40:32 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-39ca48cd4c6so2542809b6e.0;
        Mon, 19 Jun 2023 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687207231; x=1689799231;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8OmJOKb9s+fcDbS/sj7n7U1iFY0sQLOmiWn97pgiWB4=;
        b=XX9i3xNupKSfMvXZr3bus/3QFqcu+CfiRB/vkNy35rDAqBGixc+VfP4OQDeqFZmjs6
         NaI8bF/EpSwM2oPlAAADHxHEUPTLcDfN6S8LupWJAxkzt6Slvf4vXL+FOd9h8tyAYIYn
         XuW9o+xxvCnsihoB0dp16XJOyaYOYpc2vDF38XuW5qY3uUVtELlnWr9DqAuAc5xHS9R+
         tjwJsOYRaaYFpugBjIZddYM0rIbHcoVneKQOAc1f5NpDVaq9PhjjKCf/wJWoV8k5sJBd
         /1HUEDR80VH4u80bDDAkvjU+KMhNCmYNoZNuiO/aJxPCif90FwPhGz1MpRsAiS6sxmv3
         zdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687207231; x=1689799231;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OmJOKb9s+fcDbS/sj7n7U1iFY0sQLOmiWn97pgiWB4=;
        b=N1G0/fElNAM/iNhkfeqNhYiaxM+Ghx8IgRv2w68NzoysI7Xa2aZM049FdQVAcsR6pM
         jJJ2ApCCRmSZbGRvK7RTb4DrhyVToHn1BAhKbK7KuYqvY9N+wFd9ktK6S4O+RpEtTjVA
         hpM5PWc7uPGGDTqxTf9uXS0aBF+/TbUIQi6KW9tlTtfFCGgSOKEppHGlyIrkVlfOFm5j
         xhEceE5Hik7ISzsoq/F9SNR0DcnR4TalHP2Fwigq2Z7WZT96u79Ifz77Ev9mU/jM5mUA
         kYm1Sajy4asuEmrWgtHbDhP1m78fHcA9QTdbYY9QTGDO2IEwUALbTcUIpBrIeNqTrkCa
         FhGQ==
X-Gm-Message-State: AC+VfDxmLOl4/AIszi0va+3za8Zv4TqVi+oYX/sUAsl3IsCd6SWpfrGw
        QIYioJ2Lyw8uFg0qixivHAg=
X-Google-Smtp-Source: ACHHUZ76U4DT4t3XKpnjTBevB1UxNB/cJqZAjlHDZO9zvx4PQBh7MWCBXZJ3TBwvnKdE1gkr3y3b3w==
X-Received: by 2002:aca:2b14:0:b0:39a:bbd4:bab with SMTP id i20-20020aca2b14000000b0039abbd40babmr8063403oik.31.1687207231356;
        Mon, 19 Jun 2023 13:40:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ji21-20020a170903325500b001b034d2e71csm255136plb.34.2023.06.19.13.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 13:40:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <88525fc7-ee7b-969a-cb14-02ca8736f229@roeck-us.net>
Date:   Mon, 19 Jun 2023 13:40:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] hwmon: (k10temp) Enable AMD3255 Proc to show negative
 temperature
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Baskaran Kannan <Baski.Kannan@amd.com>, babu.moger@amd.com,
        clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619165413.806450-1-Baski.Kannan@amd.com>
 <4585ec62-b7bb-9f2a-eee0-07032648e55a@roeck-us.net>
 <012ea369-52ec-4a7a-ec66-812690d430ad@amd.com>
 <598247ee-3ff8-8413-274a-7d313c2af324@roeck-us.net>
 <a8107f7d-3163-4f03-9f17-82e1a93d8e91@amd.com>
 <99f95783-176a-c227-6a75-1c6e05a8020e@roeck-us.net>
 <65eb7961-755a-a11b-906b-aae237216d5f@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <65eb7961-755a-a11b-906b-aae237216d5f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/23 12:58, Limonciello, Mario wrote:
> 
> On 6/19/2023 2:48 PM, Guenter Roeck wrote:
>> On 6/19/23 11:53, Limonciello, Mario wrote:
>> [ ,,, ]
>>
>>> So Pinnacle Ridge and Summit Ridge (Zen/Zen+) have model_id_str values of 'B1' and 'B2'.
>>> I think we should be able to detect those and only avoid showing the negative values when:
>>>
>>> * Family 17h
>>> * Model > 0x00
>>> * Model <= 0x0f
>>> * Model ID str B1 or B2
>>>
>>
>> Threadripper 1950X model string is "AMD Ryzen Threadripper 1950X 16-Core Processor".
>> Not sure where B1 or B2 is seen, but it is not in the model string.
>>
>> Guenter
>>
> Sorry; I thought you were talking about desktop parts and didn't realize it was a Threadripper
> part that prompted all of this.
> 
> I looked at the old commit aef17ca127, and it seems that this is tied to the usage of some
> overclocking knobs offered by some BIOS vendors.
> 

Correct.

> As an idea to avoid the initial issue and all these hacks; what about changing the logic to
> compare the calculated temperature against the max temperature?  If it's greater than the max
> THEN set it to zero.
> 

No, that won't work anymore. In the old code, negative temperatures were displayed as large
positive temperatures. This was changed later, and temperatures are now reported as
negative temperatures.

Is there a way to detect if those overclocking knobs are set ? Alternatively, we could\
possibly just check if the CPU is a Threadripper and limit the hack to Threadripper CPUs.

Thanks,
Guenter

