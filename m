Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2AC7027AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjEOI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEOI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:57:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C019A0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:57:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aad6f2be8eso115196455ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684141034; x=1686733034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rG1m6/ZUbXcFAUMvzzP6os9D3LqFPw+qOiQ1spcSC0s=;
        b=qfOwVI1bjES6z8OWoa6aCTHzIcYwMil7bcYQiVp4/zTotErBmf2f5YyD+R0G+HKL9z
         pjK98sD/k1xhZ2rTLHsmfwsjjpYhe/E8jqBfzMVyzBe4zedvKPn/ypCuZufwupFTdSWH
         UFJgIiZCfvvcMHZ3zS9X4WdSPXfzDPT2KEj6FJGxNbYolYnFkFzmhlD7ZZSatm+PeKb2
         97xUWwrNbi8c3HwwzwKHkJaVMRL0V2ecTlOmbfi/C0XjARstt6ISJPlrIxlOHJv+QLol
         iC5jYUO+hKOXBRbEr68f/tNC/+H94uRutP0vbK0sK+qpDjgAOPiyJilea7HD+nr/STpc
         kkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684141034; x=1686733034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rG1m6/ZUbXcFAUMvzzP6os9D3LqFPw+qOiQ1spcSC0s=;
        b=PtqAa2659WW5Wzk1biAznmYgKRBcFcU/JfVdQE54m6J7gBOPpFMtPg12L9nqSpJ93k
         wAlO5rV5o08NKnj1jRbUxRjseQn1Iz4dYjrM5kpm1pQS+xOnguUp3BjiL1wzu5N37pi6
         7nAC2MtKHWH+4Xb4QXhDWF7kzFRcEFERINDJylo+xK8SJ0r3u8zzhRpbGRdZs+vNmjWz
         kBrFyR49vbbpDBQ4fX3YsHJW0L3/Q2uvsHL2nsYFLJYm1rVl2DZCez6JGJ5tVIpWOsht
         KXFaVcB1czO3dox5SOcSsgjGdL3bcDfMVjscD3Ct+BYyYFlemC1icU/Hjxp+krawECl5
         U25Q==
X-Gm-Message-State: AC+VfDzQcWdWWt3YobPE4t+SOcwRektWsVmAL+vC2Z5d07wgp2aglMZV
        CUJILztODbg8MA8SwAw2xMjB/q450PQ=
X-Google-Smtp-Source: ACHHUZ7aImgc01WTtJLddcsEZ6YyRvJXxo8TUI4GeVtryV71WHIgEN3syasvE2FR2iNA1o1UY/5JAQ==
X-Received: by 2002:a17:903:2292:b0:1a1:bff4:49e9 with SMTP id b18-20020a170903229200b001a1bff449e9mr45885771plh.23.1684141033765;
        Mon, 15 May 2023 01:57:13 -0700 (PDT)
Received: from [10.150.3.61] ([132.226.22.23])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b001ac84f87b1dsm12994846plg.155.2023.05.15.01.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 01:57:13 -0700 (PDT)
Message-ID: <9460b08a-7740-42bd-8784-d27ea038e87b@gmail.com>
Date:   Mon, 15 May 2023 17:57:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] mm/mmap: Regression fix for unmapped_area{_topdown}
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        Tad <support@spotco.us>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rick.p.edgecombe@intel.com
References: <e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us>
 <90777046-a420-b19f-1847-d353b9938131@vigovproductions.net>
 <20230502140828.hilf3myxj6kpiunz@revolver>
 <20230502140907.o7fznev4jthtgp4i@revolver>
Content-Language: en-US
From:   Juhyung Park <qkrwngud825@gmail.com>
In-Reply-To: <20230502140907.o7fznev4jthtgp4i@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

It's a bit hard to follow this particular issue on v6.1 as there are 
many email threads related to this.

I just wanted to ask if whether this is fixed on mainline and v6.1 
stable yet.

If there's a new thread tackling this issue, I'd appreciate it if you 
can link it here.

Thanks,
regards

On 5/2/23 23:09, Liam R. Howlett wrote:
> ...Adding Rick to the Cc this time.
> 
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [230502 10:08]:
>> * Michael Keyes <mgkeyes@vigovproductions.net> [230430 18:41]:
>>> On 29.04.23 15:32, Tad wrote:
>>>> This reintroduces the issue described in
>>>> https://lore.kernel.org/linux-mm/cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a@sony.com/
>>> Yes, I also ran into this (even though I'd somehow missed it the
>>> previous time).
>>
>> Rick Edgecombe reported something similar [1].
>>
>> This is probably to do with my stack guard checks I recently added.
>>
>>>
>>> Apparently the issue arises at mm/mmap.c:1582, where low_limit is set to
>>> vm_end_gap(tmp). Occasionally, this returns a 64-bit address (e.g.
>>> 0x7fedea581000), which is obviously greater than high_limit for a 32-bit
>>> mmap, and causes the next call to mas_empty_area() to fail.
>>>
>>> I'm not sure why vm_end_gap(tmp) occasionally returns a 64-bit address,
>>> or if the best solution is to just check for this and skip the retry if
>>> it occurs…
>>>
>>
>> Thanks for the debugging.  I will look into it.
>>
>> I am currently trying to revise how the iterators, prev/next deal with
>> shifting outside the requested limits.  I suspect it's something to do
>> with hitting the limit and what someone would assume the next operation
>> means.
>>
>> [1] https://lore.kernel.org/linux-mm/32f156ba80010fd97dbaf0a0cdfc84366608624d.camel@intel.com/
> 
> 
