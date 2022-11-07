Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE761F71E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiKGPFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiKGPFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:05:50 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3E14034
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:05:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 130so10874167pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 07:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6Knqsiq6vna0ldkWZeA3B+r2w8EfWBBb6+KgxrzBHA=;
        b=y5bJcBbwgeikIPF6JX/HJKGom1C/1b8vdu258KUadd30brjgTfEZANG/Kha2t38TQH
         toLYQ7eFW6o+AHXG9o1jq0WPTZgycNxFn5XQmGLECXTRgTvXz4PX7LPQR4rt2nbf+hNd
         kEiL9x4LHcnbnTLDdM7p/NhjpWNi/nyS1o3XU22bjKGKXvZLy3Hu812y9FBfIuaVgheh
         lypU6gSFXnQbLjDQ3X5xhITKamz9+TwXrkfLObezI1qp8ZH3flkT16sHLsFlJvmWMpL0
         qfXMg4Xltyu4i05vG3Ahc6sWCoy3dGRMnpiqo/g6mW8QcyuO+OAcMczFxVfeQv/ENO4M
         5tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6Knqsiq6vna0ldkWZeA3B+r2w8EfWBBb6+KgxrzBHA=;
        b=NJso3HK5Qtm+pPDLDLXBbF66nJmJzVEtTTO/PIZkcrAUa22+r64evFuWqoVGYBR2iD
         fUO1jWNZtHmjXrL7/jL2o21Vt9f+jzCC/MsH0uFV2Xk4NFS1nrXvcq3S/tKgX8MQRiWD
         hOsHVusjajc80Gqv5Qea3C2BHFFkOSgXXQCAiI6RvDgYCQftGbK3ZVurTkOtGjW4EcLt
         xxzBKXVCld3oF35UHfVz2MCAARXeFWtHYLLUE/RY8Bs4V9DWam5M9vTdMKgcpg8kL/0+
         qNz/v3ehHty4ADre4wwtSCYb87Wf0Xy5E5qqbmumlvwCh725kt54Fmw51gDqIdCO9MJg
         6Mbw==
X-Gm-Message-State: ACrzQf1JI2Pyp+qo1rT06xCrLC9uM3l5b44YSx/MJbOYZNAhgODT0Yj7
        EyAnvpeiPVctFyYigZcHja4Ixw==
X-Google-Smtp-Source: AMsMyM66R0V2WVVWJ13espn3QxPLwHi3aPrKR3wMyMlXVj+fZClycfNJHZWzhP0GEy0pB+sVPmO4Iw==
X-Received: by 2002:a63:485f:0:b0:458:764a:2224 with SMTP id x31-20020a63485f000000b00458764a2224mr42765354pgk.620.1667833549288;
        Mon, 07 Nov 2022 07:05:49 -0800 (PST)
Received: from [10.255.93.192] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b00187033cac81sm5110920pls.145.2022.11.07.07.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 07:05:48 -0800 (PST)
Message-ID: <4736d199-7e70-6bc3-30e6-0f644c81a10c@bytedance.com>
Date:   Mon, 7 Nov 2022 23:05:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH] mm: fix unexpected changes to
 {failslab|fail_page_alloc}.attr
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dvyukov@google.com, willy@infradead.org, akinobu.mita@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org
References: <CACT4Y+Zc21Aj+5KjeTEsvOysJGHRYDSKgu_+_xN1LUYfG_H0sg@mail.gmail.com>
 <20221107033109.59709-1-zhengqi.arch@bytedance.com>
 <Y2j9Q/yMmqgPPUoO@nvidia.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y2j9Q/yMmqgPPUoO@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/7 20:42, Jason Gunthorpe wrote:
> On Mon, Nov 07, 2022 at 11:31:09AM +0800, Qi Zheng wrote:
> 
>> @@ -31,9 +33,9 @@ bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>>   		return false;
>>   
>>   	if (gfpflags & __GFP_NOWARN)
>> -		failslab.attr.no_warn = true;
>> +		flags |= FAULT_NOWARN;
> 
> You should add a comment here about why this is required, to avoid
> deadlocking printk

I think this comment should be placed where __GFP_NOWARN is specified
instead of here. What do you think? :)

Thanks,
Qi

> 
> Jason

-- 
Thanks,
Qi
