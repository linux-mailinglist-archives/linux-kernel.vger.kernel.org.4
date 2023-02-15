Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9017069889C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBOXLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBOXLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:11:47 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6E338676
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:11:27 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id c29so144354pgm.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676502687;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=um8HNgC9PwbXstjy6UxoGSCnKuinXLIsMiLvss4UAkA=;
        b=LLM4ZIfxC5K/PN1xPUa3Z/Ds6aGzszd/rcm4tz4Txk9OzhUSsaR44jkByLyChETSdN
         TTvRuujVczFfb1cBBGDED5Mnp/JUxz3iMWU1siU/G9sNTgVY5/OhnNvwoItozqV/RrGb
         dUpNI1KcoX3CS8DyeqShjZED67YPpUgtcGlt0BbucYdNpd92QfShMTgCORVvcEN1n/1n
         dSkzQwlyRsea/DvC1xxE0tsbmCaVqObpjSgKCYR+9xjVR5Egy/tGlDEk/eet+kqYs4oH
         j7Kk71T28JucQjP5FbxxBaGMTiUDQSJL0dveR6005eZs6hIUN/h6y4nKXkVorVs+SNoW
         qn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676502687;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=um8HNgC9PwbXstjy6UxoGSCnKuinXLIsMiLvss4UAkA=;
        b=uYCz2Syxv6pQCgBOko+lQJooEyJFBNH/0VrnfmTAeqsVlI0RGecE/Y8m8sH3Xi/42z
         KL7Q0aNI+2OyRikGSwcMoE1K5+gycqJJEC6kcuJh6ivtEXpIkXLASe3xNTq7mr69PFvh
         qvM/PxkLKvrYBuysoxpBa9dyeWQ34705Y/Qty6xirgDF2aAXf5eQOc0kA5LFr02Gz5ZH
         +nLOAEDHqDX+u5ke6SUnPfr9NWetGnGSvCuK35BoRuFTFew0lvJ4PGflBOyBr/XgLWV8
         N4ZpH1r8S958c8v/hrV749w6GjXz5g4xlZkM5KpufABS+8HKIehDoRdeAZWuW1c/m1Lf
         59/g==
X-Gm-Message-State: AO0yUKV46d0gXrGvjYcQni/sjNrVC/7WgRtfZhOasvjyX4iXZAUXdBei
        BsPglY6cGLpNV0ERVhu7QbCSDw==
X-Google-Smtp-Source: AK7set8/ZL3ifVyFvFg2ml0d9J29P4JCWmwHzhaCB9FRX8xLcQyZmGy4F2PmrpN5o9G3FYEqwxICQg==
X-Received: by 2002:a62:d104:0:b0:5a8:bbd7:d7aa with SMTP id z4-20020a62d104000000b005a8bbd7d7aamr3083220pfg.1.1676502687107;
        Wed, 15 Feb 2023 15:11:27 -0800 (PST)
Received: from [10.200.11.190] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id g2-20020a62e302000000b005a7f8a326a3sm7128156pfh.50.2023.02.15.15.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 15:11:26 -0800 (PST)
Message-ID: <3426457c-99bf-9f7c-f663-c29474d9fa73@bytedance.com>
Date:   Thu, 16 Feb 2023 07:11:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH 0/2] handle memoryless nodes more appropriately
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rppt@kernel.org, willy@infradead.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
References: <20230215152412.13368-1-zhengqi.arch@bytedance.com>
 <Y+0KKnN8BU6ky6oP@dhcp22.suse.cz>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y+0KKnN8BU6ky6oP@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/16 00:36, Michal Hocko wrote:
> On Wed 15-02-23 23:24:10, Qi Zheng wrote:
>> Hi all,
>>
>> Currently, in the process of initialization or offline memory, memoryless
>> nodes will still be built into the fallback list of itself or other nodes.
>>
>> This is not what we expected, so this patch series removes memoryless
>> nodes from the fallback list entirely.
>>
>> Comments and suggestions are welcome.

Hi Michal,

> 
> This is a tricky area full of surprises and it is really easy to

Would you mind giving an example of a "new problem"?

> introduce new problems. What kind of problem/issue are you trying to
> solve/handle by these changes?

IIUC, I think there are two reasons:

Firstly, as mentioned in commit message, the memoryless node has no
memory to allocate (If it can be allocated, it may also cause the panic
I mentioned in [1]), so we should not continue to traverse it when
allocating memory at runtime, which will have a certain overhead.

Secondly, from the perspective of semantic correctness, why do we remove
the memoryless node from the fallback list of other normal nodes
(N_MEMORY), but not from its own fallback list (PATCH[1/2])? Why should
an upcoming memoryless node continue exist in the fallback list of
itself and other normal nodes (PATCH[2/2])?

Please let me know if I missed something.


[1] 
https://lore.kernel.org/lkml/20230212110305.93670-1-zhengqi.arch@bytedance.com/

Thanks,
Qi

> 

