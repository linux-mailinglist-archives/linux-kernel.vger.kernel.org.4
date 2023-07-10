Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FBE74D122
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGJJM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGJJMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:12:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34969A8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:11:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8ad356fe4so21029125ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688980316; x=1691572316;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cktsf3e/9yrSZkfRHzFPts0N9sSQ7eFco0OYncndQDY=;
        b=YR387A5tUMzUm+Mxwyf5r6vu7cQFgPPUwlT6mz9aHYmDBxyfn44CoLCyKZWBLhAmxL
         kdhZguk3KvwosZL30Ucg40KWVhJK06BnoL+sDRpFaH8cZLKJ9pcrm9SPEYOk/Ns2NyWu
         vuYatnpz9VFy/rAwXOD65aUIAONbfT/dYALCUo6c1LDbRo6F1Qhd4weHvY58np6E5/EX
         HfXNGD2Eq0KnVUrDZEs11Ppk5jRBseLdoOGI2RyAH3g3nzDmOpB8Rd27rnAvUdJ/R8Oh
         pesUmKyYVxnmlYtOmxpRz+vUgQiJQFoy+RLxK4qQ6jD7qZP3JbUkNpG27tKvNoBmD1+2
         TwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688980316; x=1691572316;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cktsf3e/9yrSZkfRHzFPts0N9sSQ7eFco0OYncndQDY=;
        b=bz5JW+8n6/SdyJyVF9g4ZpGAuqXoIp3Olhofwf9yQwpTz35+7llD8MDKY9/7MgVL1e
         oVWxXOcFUlWnvaupAXxgCpA4rDIc6Rs2ZGbc44VZwTBXeKcwLBVNcG7N1mH/fPyRtGBq
         GdFOB3TDZ3HRdU7zKmWGkqjEJrXQGhBqp5p5mVrocrHdd3uLbVzI/BNcOA+COkgPplFC
         umQRDH3ISMhVpmaSxtcw2UPp3sA5XSO9+Q8gszq0iPd2URSvJOzrrJJWHrcYVOM/Zl7j
         WWOwVJUP9c7icG0YehHHb11C0KVwczvYlyV1aFSP2QygWtRXmhvbTXnwNmOtlBeEETD6
         bd0g==
X-Gm-Message-State: ABy/qLYTsNlTCnkiHmoptN5EoBwZWGgYft9ASaBQpQSOCJOFiGPHGjVG
        3QJJ1jVrx2cfjfbuF4GHWc8yKQ==
X-Google-Smtp-Source: APBJJlE5gPvetUd9sDdLRZi5Rr3hp14Pbn5crLRM0qEo1N9NogPXfMmgJXzFkUcEJMmk9VmwIduJVA==
X-Received: by 2002:a17:902:ef95:b0:1b1:9218:6bf3 with SMTP id iz21-20020a170902ef9500b001b192186bf3mr9521475plb.37.1688980316660;
        Mon, 10 Jul 2023 02:11:56 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:1c2a:1cd4:8b91:108f:bf15? ([2408:8000:b001:1:1f:58ff:f102:103])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b001b80760fd04sm7733208pla.112.2023.07.10.02.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:11:56 -0700 (PDT)
Message-ID: <42945254-beb8-8a04-8689-1419595b0b85@bytedance.com>
Date:   Mon, 10 Jul 2023 17:11:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH 5/8] maple_tree: make mas_validate_limits() check
 root node and node limit
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
 <20230707101057.29326-6-zhangpeng.00@bytedance.com>
 <20230707145848.yninylf4uccfsnaa@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
In-Reply-To: <20230707145848.yninylf4uccfsnaa@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/7 22:58, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
>> Update mas_validate_limits() to check root node, check node limit pivot
>> if there is enough room for it to exist and check data_end. Remove the
>> check for child existence as it is done in mas_validate_child_slot().
>>
> 
> The comments for this function say:
>   * Validate all pivots are within mas->min and mas->max.
> 
> This needs adjusting since we are doing a whole lot more now..
Thanks, I will update it in v2.
> 
> Validate limits is now checking metadata ends where the maximum ends,
> checks the pivots are within the limits of the node, and ensures
> there is no slots or pivots set outside of the end of the data.
> 
> Did I miss anything?
You're right, that's exactly all the checks it does.
> 
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 26 +++++++++++---------------
>>   1 file changed, 11 insertions(+), 15 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 88d6373f37b0..e84a042b6d84 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -7148,26 +7148,15 @@ static void mas_validate_limits(struct ma_state *mas)
>>   	void __rcu **slots = ma_slots(mte_to_node(mas->node), type);
>>   	unsigned long *pivots = ma_pivots(mas_mn(mas), type);
>>   
>> -	/* all limits are fine here. */
>> -	if (mte_is_root(mas->node))
>> -		return;
>> -
>>   	for (i = 0; i < mt_slots[type]; i++) {
>>   		unsigned long piv;
>>   
>>   		piv = mas_safe_pivot(mas, pivots, i, type);
>>   
>> -		if (!piv && (i != 0))
>> -			break;
>> -
>> -		if (!mte_is_leaf(mas->node)) {
>> -			void *entry = mas_slot(mas, slots, i);
>> -
>> -			if (!entry)
>> -				pr_err("%p[%u] cannot be null\n",
>> -				       mas_mn(mas), i);
>> -
>> -			MT_BUG_ON(mas->tree, !entry);
>> +		if (!piv && (i != 0)) {
>> +			pr_err("Missing node limit pivot at %p[%u]",
>> +			       mas_mn(mas), i);
>> +			MAS_WARN_ON(mas, 1);
>>   		}
>>   
>>   		if (prev_piv > piv) {
>> @@ -7190,6 +7179,13 @@ static void mas_validate_limits(struct ma_state *mas)
>>   		if (piv == mas->max)
>>   			break;
>>   	}
>> +
>> +	if (mas_data_end(mas) != i) {
>> +		pr_err("node%p: data_end %u != the last slot offset %u\n",
>> +		       mas_mn(mas), mas_data_end(mas), i);
>> +		MT_BUG_ON(mas->tree, 1);
>> +	}
>> +
>>   	for (i += 1; i < mt_slots[type]; i++) {
>>   		void *entry = mas_slot(mas, slots, i);
>>   
>> -- 
>> 2.20.1
>>
>>
>> -- 
>> maple-tree mailing list
>> maple-tree@lists.infradead.org
>> https://lists.infradead.org/mailman/listinfo/maple-tree
