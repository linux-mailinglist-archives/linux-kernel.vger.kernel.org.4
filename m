Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D647D710E05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbjEYOIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbjEYOIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:08:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7FC1A6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:07:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae4e49727eso14437505ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1685023664; x=1687615664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c33tBT8cy9JPPgdRV9qNDNmoB5Xhj3TMTGSWoBJRi6Y=;
        b=FYZ4Qv3lhHI2M6JlMLNPzk+I50IUxOLOyogHAdzY/9dAsG8hcofW6kRBUtQtqme6eF
         El9ACrF9m6b/U1v8bIU9e6ogQnPYpCAlIPROFX03fQH6TtFmc+NpjRypzzUfvLQcCPgA
         IMmLH6zkb8bityx6mv4Sc2Ngs1jHgYVESI6kU386dGSu1gtYkoe5zYsIezw/Lbapda2D
         nzPd62vGlE4aAG9wK8L5blxg5ilcUkQLkzhsgEsNhgv0XLZ251TEbnLh/AN6hpKUPdj/
         oCrWYI+n54m3SyBU4d/ncPb8TQUouvgBEbP8YkzUCmoCXR0LG38N128QLQtSZRlCobg6
         IAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023664; x=1687615664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c33tBT8cy9JPPgdRV9qNDNmoB5Xhj3TMTGSWoBJRi6Y=;
        b=FOE+4D5dtTvx3tD9LgCo/psW0TL6FrN4yLOk8GRoK1bzZxwVEA16pgeFuqnOEFsL9O
         go06k0juE9AMuNRZsz9Jo7rHZTr2ig+JDcyw5LKoHYnP1eEiN7KGSwi1n8bCWYUijpvl
         hoVXHFjwnI+2pTf33NGQbO8HYkgM0axiK8LMsbZyFO/bgB0duGG+rHKn4X4gMbfOUf4i
         eSbUylxaUEWnALZGV89nR/vOooPDUMqSTVcaF0S833Syg41EuH7VxUmiiG90zzzR8PII
         +50I+a1pH1PNulUln6+GoWt8wuzIgHBNeBKv7lGl9jVFkSrklybkEDkgciMDZgVP//sH
         FyQA==
X-Gm-Message-State: AC+VfDybCliUvOf9feILDbujsblLm1TDgj9hc1AQQM3mKo71gNDmzE1j
        ZsS/hKdylNWUf89MbYY4JenJ8w==
X-Google-Smtp-Source: ACHHUZ45yFuJ/9A4MCbSl44XKJvuN/lObdaSmxg20qFmfGTxUn37ZhJoyCioHCu8T2L7XphJ/xFaww==
X-Received: by 2002:a17:902:e88b:b0:1b0:f8:9b2d with SMTP id w11-20020a170902e88b00b001b000f89b2dmr856962plg.29.1685023664547;
        Thu, 25 May 2023 07:07:44 -0700 (PDT)
Received: from [10.12.184.48] ([143.92.127.226])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709029a0b00b001ac5b0a959bsm1478099plp.24.2023.05.25.07.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 07:07:44 -0700 (PDT)
Message-ID: <5453d94d-c231-6d50-02bd-a510109bb306@shopee.com>
Date:   Thu, 25 May 2023 22:07:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] mm/mm_init.c: remove comments in
 zone_spanned_pages_in_node() and zone_absent_pages_in_node()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230525040150.1588-1-haifeng.xu@shopee.com>
 <20230525082444.GT4967@kernel.org>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20230525082444.GT4967@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/25 16:24, Mike Rapoport wrote:
> On Thu, May 25, 2023 at 04:01:48AM +0000, Haifeng Xu wrote:
>> Since commit 03e85f9d5f1f ("mm/page_alloc: Introduce free_area_init_core_hotplug"),
>> free_area_init_node() doesn't get called in hotplug path anymore, so
>> remove the comments related to it.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  mm/mm_init.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 7f7f9c677854..cf55bba04b23 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -1174,7 +1174,6 @@ static unsigned long __init zone_absent_pages_in_node(int nid,
>>  	unsigned long zone_start_pfn, zone_end_pfn;
>>  	unsigned long nr_absent;
>>  
>> -	/* When hotadd a new node from cpu_up(), the node should be empty */
>>  	if (!node_start_pfn && !node_end_pfn)
>>  		return 0;
> 
> I think it's better to call calculate_node_totalpages only if node actually has 
> memory and for node with no memory we just need to make sure all the node
> and zone page counts are indeed set to 0.

Yes, it's good advice.

> 
> Then the condition here and in zone_spanned_pages_in_node() can be removed
> along with the comment and patch 2 won't be required at all.

Regarding to patch 2, if the node has mmeory but contains zone with no memory,
it can avoid the calculation of absent pages.

I thik we can add a check that whether zone_end_pfn is equal to zone_start_pfn
in patch 3. If it's true, return 0 directly. So patch 2 can be dropped.

Thanks!

>   
>> @@ -1227,7 +1226,7 @@ static unsigned long __init zone_spanned_pages_in_node(int nid,
>>  {
>>  	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
>>  	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
>> -	/* When hotadd a new node from cpu_up(), the node should be empty */
>> +
>>  	if (!node_start_pfn && !node_end_pfn)
>>  		return 0;
>>  
>> -- 
>> 2.25.1
>>
>>
> 
