Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA9F6E2C6F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 00:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDNWV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 18:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDNWVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:21:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3602140F1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:21:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso7775452pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681510913; x=1684102913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SLqNGLosZovkrXAf3+SwfrjNlS64/xyQZTbyCVO0BxQ=;
        b=flSWtgEcFQWRDJSgY5ws8HrxttLbvh3ovwpwZnYrGWuKspM9na62YBx+L+YsSiaAf8
         MQWiBW7jm2QgpahDO83ysoM0CsGRGNbLZayUQ8XFgvjvXuboORHk1P6YBcKQxFiJhp5Z
         Z4BiwfXGdxnNtuM9CwLg+pHtWEn2tFKMfOt5fkMmjKXhaNW1ab6xuRiF9Y+3a5UYDUwL
         sOKGEwKEtVU4vP/3oEV7z12zFTEhJ60peVcCG6WAoz7uq2htk2S6z8ODYMhHcceBAxVW
         rknMhE1wbR77/R8iSpH+YMXQaXKujxoSK2Mf1ysgDv2vfxMerJTBIC2hUYhclijt4X2e
         +IeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681510913; x=1684102913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLqNGLosZovkrXAf3+SwfrjNlS64/xyQZTbyCVO0BxQ=;
        b=eiz4JN33cZ++tYrMUGFKfFVvZMptDWZiBfa46edolWRDPZfVUNnNBAGPe+C7LDi2pQ
         5tb/YTSUoebUb6EhMsmPVv2Q2X3O16jKW7Rnh1bYu/UicDqiFrEfiX5CqJ4+lc48/gZw
         paJrk/FgPN/fYwP8DzfqqAHDy/l37uqwBcvosG3sPsql/GD3WqN4S5KiHwcxn9X1fOuJ
         Xxhf/C7DQOHuWoG4R7YYlfW7WgL678+7jUPrN/us4C/BbTFmaz181FUsWD9NV8nf7CeT
         ObOFAeJtQUnrTReorm3/5JnfvMuCsoTxsYpR9qSgtqAIpgl4kHUXuwbvA3v4rjpLBO1m
         amkw==
X-Gm-Message-State: AAQBX9ctDlh27OLXS/UaC1IGXyk1EXW+/6NKhtPeJLKIs54IHOSybFFW
        h8lL31VYa6pC+6/+qTii1+o=
X-Google-Smtp-Source: AKy350awc9s1TJQHmTDe0ROiljhHv3b+u2EkXnYUi86wXlrw50nRxW1EAPbTfiOCRdqYwBLLQnZniQ==
X-Received: by 2002:a05:6a21:32a2:b0:ee:7fb0:da51 with SMTP id yt34-20020a056a2132a200b000ee7fb0da51mr2089028pzb.31.1681510913591;
        Fri, 14 Apr 2023 15:21:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k12-20020aa7820c000000b00634dde2992bsm3470658pfi.132.2023.04.14.15.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 15:21:52 -0700 (PDT)
Message-ID: <18da7eec-3898-06fb-2746-c201450389ac@gmail.com>
Date:   Fri, 14 Apr 2023 15:21:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/4] cacheinfo: Check cache properties are present in
 DT
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
 <20230413091436.230134-3-pierre.gondois@arm.com>
 <4da53918-839b-4d28-0634-66fd7f38c8bd@gmail.com>
 <20230413195032.bw3yu7a6puqziinx@bogus>
 <d44baa58-8c39-407c-db94-390bc0d12dbe@gmail.com>
 <20230414090542.rbidu45cx4halja4@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230414090542.rbidu45cx4halja4@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 02:05, Sudeep Holla wrote:
> On Thu, Apr 13, 2023 at 01:06:46PM -0700, Florian Fainelli wrote:
>> On 4/13/23 12:50, Sudeep Holla wrote:
>>> On Thu, Apr 13, 2023 at 11:16:37AM -0700, Florian Fainelli wrote:
>>>> On 4/13/23 02:14, Pierre Gondois wrote:
>>>>> If a Device Tree (DT) is used, the presence of cache properties is
>>>>> assumed. Not finding any is not considered. For arm64 platforms,
>>>>> cache information can be fetched from the clidr_el1 register.
>>>>> Checking whether cache information is available in the DT
>>>>> allows to switch to using clidr_el1.
>>>>>
>>>>> init_of_cache_level()
>>>>> \-of_count_cache_leaves()
>>>>> will assume there a 2 cache leaves (L1 data/instruction caches), which
>>>>> can be different from clidr_el1 information.
>>>>>
>>>>> cache_setup_of_node() tries to read cache properties in the DT.
>>>>> If there are none, this is considered a success. Knowing no
>>>>> information was available would allow to switch to using clidr_el1.
>>>>>
>>>>> Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count cache leaves")
>>>>> Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>>>> Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
>>>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>>>
>>>> Humm, it would appear that the cache levels and topology is still provided,
>>>> despite the lack of cache properties in the Device Tree which is intended by
>>>> this patch set however we lost the size/ways/sets information, could we not
>>>> complement the missing properties here?
>>>>
>>>
>>> I am confused. How and from where the information was fetched before this
>>> change ?
>>
>> I applied Pierre's patches to my tree and then did the following:
>>
>> - before means booting with the patches applied and the Device Tree
>> providing cache information: {d,i}-cache-{size,line-size,sets} and
>> next-level-cache
>>
>> - after means removing all of those properties still with the patches
>> applied
>>
> 
> Ah okay, I assumed something totally different and hence thought patches
> broke something.
> 
>> My expectation is that if we omit the properties in the Device Tree, we will
>> fallback to reading that information out of clidr_el1. However as can be
>> seen from the "before" and "after" outputs, there is loss of information, as
>> we no longer have the cacheline size, number of sets/ways, the rest is valid
>> though.
>>
> 
> Correct and that is expected. We dropped ccsidr_el1 support to fetch cache
> geometry with the commit a8d4636f96ad ("arm64: cacheinfo: Remove CCSIDR-based
> cache information probing") after Arm ARM added wordings not to infer the
> information. However clidr_el1 info still holds except it may not include
> transparent system level caches. Hope that clarifies.

Yes it definitively does, thanks a lot for the refresher.
-- 
Florian

