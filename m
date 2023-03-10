Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0868C6B507D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCJTDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjCJTDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:03:31 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81680112A65
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:03:27 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id d10so3616802pgt.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678475007;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HJMs6+Kdc1OEc2fFSFYRB2EioEoEFo0VUZVVyRVLQY=;
        b=U6L5ZFKKloSDynq8esV4PSUbWTgzgRvxnP9nV4e1tfJLsQa9ewl70xQx0CA6gYcZzR
         QtYgDLLPflhsRVjJ3w9F02eqNwuxCfijFzyjDbtbK5TgU8xzMFN3k+tMjTCbEalDymxn
         GbBbtoJHObm41datISzyn7VUsLE36L0MUCUl1E+jfxkw8BxYy5x8aZtpNnMcUkToniI7
         fRrU7RAuuFf+ao9csKsVUH06uc/eZzGOL+5PAqAvgf8WdNsLN6VMpW5RFdK3c+7K7sld
         GpoTYZygD7q3LNhrBIryQjy6hddzyGcU3lTbj86lJOeeI5hWARm91moWGxozb6aR2vcj
         Cl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678475007;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7HJMs6+Kdc1OEc2fFSFYRB2EioEoEFo0VUZVVyRVLQY=;
        b=gVXUsDTJMzniSgYISbcqe7WlsKi7SJCfeBOxj5bJReI9HL0+sfl7U9fg6ZI/B9LZkF
         JNZWZlXHdCYaGo2gFpd7smEKdpaduRfz0H7O3F3wx21PTx+LLtfnwCM09fKIoVPaG93h
         Bz/GY3CBFotAOXXzBvfj8XWSZjSe/mzwLH5WbwuZLH+zq9hDDwe5RgzqyIPCF79vpeoL
         UaYIEI/QSzj7VjbhmQbf5hPGUOW12YVZgxEzo/ec8ARDmBpGRjAwVVmmefJfzW5TblYd
         5ViA3mFSkcKePrSlEbsZvYyKUyWhb+1MgNoGXC3exZWM6MYlm6jS6tI6JfVvHrVxYhN5
         8M2g==
X-Gm-Message-State: AO0yUKXwBcIciCxSfR4keyviDlngX/JPAzX3AogXIejaClS5aPB23NOS
        j3ZeqvF66D8OAhleyETMSFPOPA==
X-Google-Smtp-Source: AK7set/+9lIiHNMBOxf2F7At84dLq8xFZwQ5+D+t77gwK3TUYermJ3ZdrO2BV0Sz2asidHFTKHbAYQ==
X-Received: by 2002:a62:4d05:0:b0:5eb:25b2:5f6e with SMTP id a5-20020a624d05000000b005eb25b25f6emr24253725pfb.8.1678475006929;
        Fri, 10 Mar 2023 11:03:26 -0800 (PST)
Received: from [10.200.11.19] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id j21-20020aa79295000000b005dc70330d9bsm171911pfa.26.2023.03.10.11.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 11:03:26 -0800 (PST)
Message-ID: <1670bc9f-e601-c445-6db1-7c769bb21547@bytedance.com>
Date:   Sat, 11 Mar 2023 03:03:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 3/4] maple_tree: Fix a potential concurrency bug in RCU
 mode
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
 <20230310140848.94485-4-zhangpeng.00@bytedance.com>
 <20230310182717.csx4qgmvfvtc262c@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230310182717.csx4qgmvfvtc262c@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/11 02:27, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230310 09:09]:
>> There is a concurrency bug that may cause the wrong value to be loaded
>> when a CPU is modifying the maple tree.
>>
>> CPU1:
>> mtree_insert_range()
>>    mas_insert()
>>      mas_store_root()
>>        ...
>>        mas_root_expand()
>>          ...
>>          rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
>>          ma_set_meta(node, maple_leaf_64, 0, slot);    <---IP
>>
>> CPU2:
>> mtree_load()
>>    mtree_lookup_walk()
>>      ma_data_end();
>>
>> When CPU1 is about to execute the instruction pointed to by IP,
>> the ma_data_end() executed by CPU2 may return the wrong end position,
>> which will cause the value loaded by mtree_load() to be wrong.
>>
>> An example of triggering the bug:
>>
>> Add mdelay(100) between rcu_assign_pointer() and ma_set_meta() in
>> mas_root_expand().
>>
>> static DEFINE_MTREE(tree);
>> int work(void *p) {
>> 	unsigned long val;
>> 	for (int i = 0 ; i< 30; ++i) {
>> 		val = (unsigned long)mtree_load(&tree, 8);
>> 		mdelay(5);
>> 		pr_info("%lu",val);
>> 	}
>> 	return 0;
>> }
>>
>> mt_init_flags(&tree, MT_FLAGS_USE_RCU);
>> mtree_insert(&tree, 0, (void*)12345, GFP_KERNEL);
>> run_thread(work)
>> mtree_insert(&tree, 1, (void*)56789, GFP_KERNEL);
>>
>> In RCU mode, mtree_load() should always return the value before or after
>> the data structure is modified, and in this example mtree_load(&tree, 8)
>> may return 56789 which is not expected, it should always return NULL.
>> Fix it by put ma_set_meta() before rcu_assign_pointer().
> Are you able to write a test case for this issue?  I understand it's a
> race so it may be difficult to catch.
Yes it's hard to catch. I'll try to think of a test case next week.
It is difficult because of the need to expand the competitive area.
>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
>> ---
>>   lib/maple_tree.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 4d15202a0692..de43ff19da72 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -3635,10 +3635,9 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
>>   		slot++;
>>   	mas->depth = 1;
>>   	mas_set_height(mas);
>> -
>> +	ma_set_meta(node, maple_leaf_64, 0, slot);
>>   	/* swap the new root into the tree */
>>   	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
>> -	ma_set_meta(node, maple_leaf_64, 0, slot);
>>   	return slot;
>>   }
>>   
>> -- 
>> 2.20.1
>>
