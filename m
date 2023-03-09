Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59AD6B2103
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjCIKOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCIKNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:13:38 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7053239BA9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:13:07 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h31so710066pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678356785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvVQF1Z+uVtTvM4KpAiC4+sb41Sbj2azQpu+xaEd4HY=;
        b=ZxyKPdddxHeQ+erNNU4xvHftE9Ube3pH3+CenHP0xnsuI39OjpOuSzcC8iRkTS89Jg
         hvefqQhQp0tk/GzBJH3pBlDYrGxCCdZsUZKKcpjRlItJsbGZvSiI276J+nvgN2XL+4J3
         N2LFtYo6Wy33dEJpyV0CNuUGpDSvoWoTQ9mrSgt/OeMCMH9+QKTghAeKN8tUYXndny+/
         5tdaqFRU/HsPIRoYX0MQiIqo7cZDkb2cRxqFj55eD7bcg9wqNXV1TEVFZb6/STpmqISm
         eGY/J3o8y+waSkkkVcBz2n4KxW7bXAaQXkTJ/+2jJx68IyIkQXNWImilGP6SD3madEek
         e17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678356785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvVQF1Z+uVtTvM4KpAiC4+sb41Sbj2azQpu+xaEd4HY=;
        b=rqIL5o1dCbx4j6dek0Is7Hby6MfbevH4X2vNYJxOmLyY3ocKC3DMZ3Z+0aTj6FHgJk
         BfKerwJOq9pqNgnhjEfImwnX/h9+8LD8DWnfvf7p8WGf2gJVlUYx+gK43Ge5GHh0Phcq
         /6deKxh/rMKB5x7jpwFg/GJ5MxQ2jpzicoSPrhHdobE2DbIUboKIQcN+OiaRq1MUSvL2
         EKaZewMzIoh6M3a8tON5QYBNOecg3iHfgFLfsaLzGNkbr8pc5ujyXM73w9/qtv/RtRT0
         78K+K/C5ybapHCDFl3jjq4D65a//K8uGE3mg5ERiQLkp8RSWaRTeZKDN1boN+gBh3COL
         tEGg==
X-Gm-Message-State: AO0yUKVk2aNweSS2bWqO/EkpWCN2xtly+Hk5zi2o5F+w3O/rM3n9jNod
        dEyzdZ5OLp5Surj4a0Vn14XyIQ==
X-Google-Smtp-Source: AK7set9amO8fPlUgqGXCXAHuQ92SoXnTMxG3kffk6t+8GYoTyKmIzARwg//5k+9psmIIFI3C9fRfPQ==
X-Received: by 2002:a05:6a00:992:b0:5de:a362:ecf1 with SMTP id u18-20020a056a00099200b005dea362ecf1mr2362997pfg.0.1678356784831;
        Thu, 09 Mar 2023 02:13:04 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id 11-20020aa7910b000000b005ad9e050512sm10797487pfh.121.2023.03.09.02.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:13:04 -0800 (PST)
Message-ID: <f3a93538-1167-ad49-38f7-64d47964962d@bytedance.com>
Date:   Thu, 9 Mar 2023 18:12:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 4/8] mm: vmscan: add shrinker_srcu_generation
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-5-zhengqi.arch@bytedance.com>
 <b3a200b7-e9c5-4627-409c-e198ac1dc30a@suse.cz>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <b3a200b7-e9c5-4627-409c-e198ac1dc30a@suse.cz>
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



On 2023/3/9 17:23, Vlastimil Babka wrote:
> On 3/7/23 07:56, Qi Zheng wrote:
>> From: Kirill Tkhai <tkhai@ya.ru>
>>
>> After we make slab shrink lockless with SRCU, the longest
>> sleep unregister_shrinker() will be a sleep waiting for
>> all do_shrink_slab() calls.
>>
>> To aviod long unbreakable action in the unregister_shrinker(),
> 
>       ^ avoid

will change.

> 
>> add shrinker_srcu_generation to restore a check similar to the
>> rwsem_is_contendent() check that we had before.
>>
>> And for memcg slab shrink, we unlock SRCU and continue
>> iterations from the next shrinker id.
>>
>> Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.

> 
> 

-- 
Thanks,
Qi
