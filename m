Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED36E15A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDMUGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 16:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDMUGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:06:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8B78A4F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:06:50 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b5c48ea09so133230b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681416409; x=1684008409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0ZpJ0Es0TVuLF4Q9N+1tR+E1FVE4LdQR/1O1wdVns4=;
        b=d8exFRdZmVKU3BxoQ8FhGgcQ8Lsv7O2x0fo3zi9dybG9GgNk1DDYH+yUWk6inQBoMp
         FguMzp1FheJ2whYDnyTZDo0Z2nFBQTOo6cLoYTvU+11H7rqJPo6DMVd0ct95h23C4Wxx
         bjyj2kwL+t2A9eUsNdR4IQ2ppWLYBuJizeTJGThh2fvx/XjqPRQQ3Qh/mizaBYa5mgn1
         3RjRvIWGRZvIcq752qnAdDX9JAFwYLCh10KsPK7wb/3cFVvqRASa11zCfJ4aiMBPkPKL
         ulq8kQ50v6gE/LQ3b89fB+K+umIKwRXaeGCmPzDq2/o0ucU3qzTyf6UdERr6tJEBC/VL
         ActA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681416409; x=1684008409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0ZpJ0Es0TVuLF4Q9N+1tR+E1FVE4LdQR/1O1wdVns4=;
        b=FPMK2nNuNwAVPnbFJBExmxFKp8HA3yRG0+eYIaieKw+aC4WqV6d1UjJO0JG4v4BGNd
         q2BFSc/IQGB21zd87Y/PMUKDEOBuYS4tCL6GOrnHpblqjp2CiyB6Yld2g+j6eFtHvuJi
         d0tVieEMSYailqjlVToavOI6WDE2OS6ksJ913GVpCQsUY8iGKSR3rv7O/gqA00Koptsw
         lA9GlLbXoVnfliBpJGrkUS56IvrWmeiURs0dahJoMcxQWslkXly08neIR77rpE/w/q7D
         /z9IT7aJDMcQxLIFD8YWTt5WbsFJZJmDdrxUEtIREED/FjP0HatD6yWQ1ajmZuJFMbYv
         Vuhw==
X-Gm-Message-State: AAQBX9doiqpMKEYkP/da8sx/8KB8gcTqpB28s1gIT0zIcR1ho14qsCmT
        Cndc5JS7VXUMZcSZAnzifUI=
X-Google-Smtp-Source: AKy350ayWm2vWn7nJGOGtLJfuY3ycEOjgbFvTT5d3GFRSsWV2mSudInGqQfgiOyfc0SH8JgkeifdNw==
X-Received: by 2002:a05:6a00:1514:b0:63a:8533:d6a7 with SMTP id q20-20020a056a00151400b0063a8533d6a7mr5588346pfu.9.1681416409251;
        Thu, 13 Apr 2023 13:06:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i3-20020aa78b43000000b00627f054a3cdsm1758139pfd.31.2023.04.13.13.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 13:06:48 -0700 (PDT)
Message-ID: <d44baa58-8c39-407c-db94-390bc0d12dbe@gmail.com>
Date:   Thu, 13 Apr 2023 13:06:46 -0700
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230413195032.bw3yu7a6puqziinx@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 12:50, Sudeep Holla wrote:
> On Thu, Apr 13, 2023 at 11:16:37AM -0700, Florian Fainelli wrote:
>> On 4/13/23 02:14, Pierre Gondois wrote:
>>> If a Device Tree (DT) is used, the presence of cache properties is
>>> assumed. Not finding any is not considered. For arm64 platforms,
>>> cache information can be fetched from the clidr_el1 register.
>>> Checking whether cache information is available in the DT
>>> allows to switch to using clidr_el1.
>>>
>>> init_of_cache_level()
>>> \-of_count_cache_leaves()
>>> will assume there a 2 cache leaves (L1 data/instruction caches), which
>>> can be different from clidr_el1 information.
>>>
>>> cache_setup_of_node() tries to read cache properties in the DT.
>>> If there are none, this is considered a success. Knowing no
>>> information was available would allow to switch to using clidr_el1.
>>>
>>> Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count cache leaves")
>>> Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>
>> Humm, it would appear that the cache levels and topology is still provided,
>> despite the lack of cache properties in the Device Tree which is intended by
>> this patch set however we lost the size/ways/sets information, could we not
>> complement the missing properties here?
>>
> 
> I am confused. How and from where the information was fetched before this
> change ?

I applied Pierre's patches to my tree and then did the following:

- before means booting with the patches applied and the Device Tree 
providing cache information: {d,i}-cache-{size,line-size,sets} and 
next-level-cache

- after means removing all of those properties still with the patches 
applied

My expectation is that if we omit the properties in the Device Tree, we 
will fallback to reading that information out of clidr_el1. However as 
can be seen from the "before" and "after" outputs, there is loss of 
information, as we no longer have the cacheline size, number of 
sets/ways, the rest is valid though.

So my question is whether this is expected and in scope of what is being 
done here, or not.

> 
>> If this is out of the scope of what you are doing:
>>
>> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
>>
> 
> Just looking at the lscpu output before and after, it looks something is
> broken. What am I missing here ?
> 

What is broken in the "before" output? It contains the entire set of 
possible information we know about the caches. As for the "after", well 
yes there is information missing, the whole point of my email actually...
-- 
Florian

