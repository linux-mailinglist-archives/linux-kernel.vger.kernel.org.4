Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9764569574B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjBNDPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjBNDPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:15:21 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0FA1C5AB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:14:30 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t17so9326042pfj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676344466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcO98EaaP2Vt6Bx7DAhKU0bvqdQdkVskAmGJ59c7fLw=;
        b=JC5B2GN3HgDkaeXf31ttwVTosjyR/HxUuh6yQ669J1TUmCICIxT0I2q03+Ng2i7wSj
         Wy+TQnLT6msP2IGkAWu4n4oUQd5KyssSW3O2Dwe2IZBfF0mCjwvsi6qKFo2HSOPVW9Cx
         SDb2a1xO8ml9RgFRKIhOwLMayIJMEG9swZkhIs0wje8eTOAtowuNgTSindnK+U5r4zCG
         sXi4rtRLRjjNBLrQLb07GyKvLKVTscC7MZMPFeAtH0rIFX1UhRqutms7MuJaFPI6bW7o
         9q0tLr3VM10M83fgz0zo38GtLOMxFrheEnsJnJjy/VIrcoVKCvBza5XnXCGVKHplhiah
         6L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676344466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcO98EaaP2Vt6Bx7DAhKU0bvqdQdkVskAmGJ59c7fLw=;
        b=Ek+9i6TQfbhjJYEvKRAFiRbHBQsesdf7YytDp+8itTWyZX0HafXiEx3UmUPM7NbrQd
         C9/JNE8dxw0CVQ2TG9hRgGUwIGG8CgDlaLeZTCzCQEW+9tnwdI4GblDoTGYhuORHMp3F
         h/O5RLz5938JtgBdm2FmnHv4VfM/cB11DMl870izPGD6ecRvbI8eUyaBNfAbOtDUTAL2
         wUDUd7cpUqVfNYJl2hT2ciHNR6RZFRMO/RN+A/Wgmq/11afD2EJWGVSUyBfb7iRC8gWt
         akr/+G8+sRASA6nNmr2+hnb3nxNkFpB/c33XXYZIlwU8peFgfJp+ij5/cEFjM1fkmCLG
         kziw==
X-Gm-Message-State: AO0yUKWw+cYvKFAgXiS3NpBN8IbBJLwkgV2n0vKcFkEM1TIXZjr08EoP
        qNWL3gwq2wI9q+IQeS13bbOzblMyIa08+3S+
X-Google-Smtp-Source: AK7set9Viz27eQMVUiiJE4l1hll8LjkSCr+aTtoaIhq/LKztRqhwOzomiTGrSM0LxLL46zAtl2Mf/A==
X-Received: by 2002:a62:ce4c:0:b0:5a8:bbd7:d7aa with SMTP id y73-20020a62ce4c000000b005a8bbd7d7aamr648131pfg.1.1676344465750;
        Mon, 13 Feb 2023 19:14:25 -0800 (PST)
Received: from [10.200.11.190] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id i25-20020aa787d9000000b005a8ae0c52cfsm2363248pfo.16.2023.02.13.19.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 19:14:25 -0800 (PST)
Message-ID: <89da1ae8-3062-1fd9-a389-de4791c117e3@bytedance.com>
Date:   Tue, 14 Feb 2023 11:14:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] mm: page_alloc: call panic() when memoryless node
 allocation fails
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230212111027.95520-1-zhengqi.arch@bytedance.com>
 <20230213105318.e2a83d60c12e734d45dccf1a@linux-foundation.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230213105318.e2a83d60c12e734d45dccf1a@linux-foundation.org>
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



On 2023/2/14 02:53, Andrew Morton wrote:
> On Sun, 12 Feb 2023 19:10:27 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> In free_area_init(), we will continue to run after pgdat of memoryless
>> node allocation fails. However, in the subsequent process (such as when
>> initializing zonelist), the case that NODE_DATA(nid) is NULL is not
>> handled, which will cause panic. Instead of this, it's better to call
>> panic() directly when the memory allocation fails during system boot.
>>
>> ...
>>
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8360,11 +8360,9 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>>   
>>   			/* Allocator not initialized yet */
>>   			pgdat = arch_alloc_nodedata(nid);
>> -			if (!pgdat) {
>> -				pr_err("Cannot allocate %zuB for node %d.\n",
>> -						sizeof(*pgdat), nid);
>> -				continue;
>> -			}
>> +			if (!pgdat)
>> +				panic("Cannot allocate %zuB for node %d.\n",
>> +				       sizeof(*pgdat), nid);
>>   			arch_refresh_nodedata(nid, pgdat);
>>   			free_area_init_memoryless_node(nid);
> 
> Have you actually hit this at runtime?  If so, is there something we

No, I just quickly tested the following code and found that it will
immediately crash in the subsequent position (many paths do not handle
this case):

@@ -8368,6 +8368,7 @@ void __init free_area_init(unsigned long 
*max_zone_pfn)
                                                 sizeof(*pgdat), nid);
                                 continue;
                         }
+                       continue;
                         arch_refresh_nodedata(nid, pgdat);
                         free_area_init_memoryless_node(nid);

> can do to handle this failure more gracefully?

My consideration is that if the memory of the size of the pgdat
structure (so small) cannot be allocated at the boot time, there
is no need to continue running. So I choose to call the panic()
directly.

Thanks,
Qi

> 

