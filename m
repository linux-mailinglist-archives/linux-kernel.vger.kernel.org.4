Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7F36DC700
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 15:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjDJNCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 09:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDJNCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 09:02:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE61330C0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 06:02:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso7271291pjm.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681131729;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5w185Me5M7zSn4d9QrTVpJhTLjbMKcakFOrEP4Qx0w=;
        b=S8wYV9umEhgUZNjfILciRNDGBn7cJijaO7FXTAKY4FSEyNceJ5QHXyHR9jq/USG+Bd
         pusNPwx61zaBzazu/5Mb9CLrs223026k2XjjFwXmJtLoOa8FoCpuwHL7GPwE6yHczywS
         KbXdQ65vKRtY8rYYzp6E4UmP1t6pgFrQhGlXRb2EpxBycbBKYbEWfmA5m0iAEzCTIC1a
         30QW/mYSGaV6KSqgtpoygzqzjHC8c6ug1kMBzieVtDGsfcXBEQXZNFy8lU+R153IqLJG
         y2l2nbV0Q7rlFr8L3r6AgXkrrHXeuexg0rOz42hyuacA/1wOv1DJWTuZwuoTSYrJyQ7w
         jr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681131729;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u5w185Me5M7zSn4d9QrTVpJhTLjbMKcakFOrEP4Qx0w=;
        b=s75DZ7NUMwl7gxAVeBh98XC5ZyJGXfVdygz4fLP/PodpYzS49o1gUwxYUjjVFw/LOt
         IC2u7TbZUMIvUsKIacY4/muouR11GNCMtGOjgkvWwHbuPokxmbsXcBYIFp0NUcVk+ARa
         O6XKvWCauILNN1fI4uP9/nUAoWnLllqywTDix+m2zwSEvtWK9jCNdURMQ6FgiY7cZCCh
         W+rH/BIPTaATnDwcrBb5HpyyYxPM4JGfDB5Yy65E/4c3zqQdUMZxaECx1VCL+OFr0Cdh
         frbnB2Ol8N9pOCOy5ba876p/9Qtcx0vjkDlfWIMk9gLKwTzlZvPMhHnFNNcD4XRDVbjp
         SFbA==
X-Gm-Message-State: AAQBX9eGWt9KTDJS8t9hSStJdgFWVwqgwuLeLr06gAEPowrhHCLyqaWi
        TjxIx9dDedGX+giSTqkk3KM=
X-Google-Smtp-Source: AKy350aLe9TwzIVhf7jL14WwgNiiUj5REUzvaSnIBPqjDytnJ8YZd0SiIsDGsQ3zlvToLv4fSu8dsg==
X-Received: by 2002:a17:902:d503:b0:19c:a9b8:58eb with SMTP id b3-20020a170902d50300b0019ca9b858ebmr16999131plg.12.1681131728814;
        Mon, 10 Apr 2023 06:02:08 -0700 (PDT)
Received: from [10.200.10.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902b70300b0019a8530c063sm7741083pls.102.2023.04.10.06.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 06:02:08 -0700 (PDT)
Message-ID: <d4b49df5-0f17-15f1-a077-3a30beb64386@gmail.com>
Date:   Mon, 10 Apr 2023 21:02:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] maple_tree: Add a test case to check maple_alloc
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230407040718.99064-1-zhangpeng.00@bytedance.com>
 <20230410124144.ouhhnmfoipkqtveu@revolver>
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230410124144.ouhhnmfoipkqtveu@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/10 20:41, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230407 00:09]:
>> Add a test case to check whether the number of maple_alloc structures is
>> actually equal to mas->alloc->total.
> Thanks for the test case.  Can you please send the code to fix the issue
> first in the future?  This way the verification code can be used to
> bisect any issues.
Ok, I will exchange the order of the two patches in the next version.
>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   tools/testing/radix-tree/maple.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
>> index 958ee9bdb316..26389e0dcfff 100644
>> --- a/tools/testing/radix-tree/maple.c
>> +++ b/tools/testing/radix-tree/maple.c
>> @@ -55,6 +55,28 @@ struct rcu_reader_struct {
>>   	struct rcu_test_struct2 *test;
>>   };
>>   
>> +static int get_alloc_node_count(struct ma_state *mas)
>> +{
>> +	int count = 1;
>> +	struct maple_alloc *node = mas->alloc;
>> +
>> +	if (!node || ((unsigned long)node & 0x1))
>> +		return 0;
>> +	while (node->node_count) {
>> +		count += node->node_count;
>> +		node = node->slot[0];
>> +	}
>> +	return count;
>> +}
>> +
>> +static void check_mas_alloc_node_count(struct ma_state *mas)
>> +{
>> +	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 1, GFP_KERNEL);
>> +	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 3, GFP_KERNEL);
>> +	MT_BUG_ON(mas->tree, get_alloc_node_count(mas) != mas->alloc->total);
>> +	mas_destroy(mas);
>> +}
>> +
>>   /*
>>    * check_new_node() - Check the creation of new nodes and error path
>>    * verification.
>> @@ -69,6 +91,8 @@ static noinline void check_new_node(struct maple_tree *mt)
>>   
>>   	MA_STATE(mas, mt, 0, 0);
>>   
>> +	check_mas_alloc_node_count(&mas);
>> +
>>   	/* Try allocating 3 nodes */
>>   	mtree_lock(mt);
>>   	mt_set_non_kernel(0);
>> -- 
>> 2.20.1
>>
