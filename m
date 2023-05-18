Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8902707CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjERJ1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjERJ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:27:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8FCC7
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:27:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643a1656b79so1408645b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684402056; x=1686994056;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSani2RG74ENszir6YKYpOk7wlORB/U+hT2qJfC/37w=;
        b=f2WnhvlvGt/Iy6xTwm/ELn5F6JNejWqd+MVcF67lDFmUaGH1n1mwS7zxkxpakrjR/T
         oicroJpUsNYYanIje8NGNckK0qRlHNn07x4ltVY8K76TzUvPqfeXHcrjzoZegUiNCMEU
         or6pOiPgrwGek9BlzivMsWx9sgHNZWwnWeR3EytLkoDQmau5Rlelz85j9BqHKycdJO3G
         hHlQavazTqNhsQvkGPTE8o8xKBhgXoK2IYGpLAtTeo1ZCPQeNTMKtk/oLyOsBt2vhIN9
         pfmBx4tE4HoH1pTKr8BfAJ95d0ECAh0AUkRS6fAczbF/Hb0M9mwjN7F2szxCPoi5cg8c
         x0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684402056; x=1686994056;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wSani2RG74ENszir6YKYpOk7wlORB/U+hT2qJfC/37w=;
        b=kNKB34NZjtGFsU2jMMJJUA4GOZ7QHuW6+LIWveIC77o4A+1JUBch8hXTUZi3RGaa3m
         halNdwsvrX9lvOe7LXmJYdaOK6EOexQLqUHOpV6oOGXgVhub25X+O8iWu7HgfxZx3i2f
         tqlCdBZb7SeRBeGBjKpVJdw2QkO4HWNN4f0ah74iaGaXK1vb5Bhh36yZGcJ3zjPpAUnM
         vyxi3K/BUxVG34h+uZrigaER3Tq4no+6D4UFWBWatvtGHJmVgqFLHZ2Gtx8ya6FOnH0J
         eNJmuc6sMABNwxJM1OSpMStWHfUK9+siMolJpBkJ+VOO243plo1CHzEW0AwBKKe2HKJD
         vtYQ==
X-Gm-Message-State: AC+VfDx/QrutiysX1fC8f/pXf0b9Oui4F9d4eEaQDwh5Vlkywxkcdmsu
        iA+cA+A+bAWtIHeZEU5+VjjnIw==
X-Google-Smtp-Source: ACHHUZ47IVM+ryiNznhRL+Fn4N4tF6nkRP/mG3BIuklC7X/uGAzb7O6UaHght5K9D+yN1BNdr0h7WQ==
X-Received: by 2002:a05:6a00:114f:b0:63d:6744:8caf with SMTP id b15-20020a056a00114f00b0063d67448cafmr3461488pfm.26.1684402056623;
        Thu, 18 May 2023 02:27:36 -0700 (PDT)
Received: from [10.200.9.101] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78e11000000b006414289ab69sm937470pfr.52.2023.05.18.02.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 02:27:36 -0700 (PDT)
Message-ID: <13a3e7cd-b8bf-1aef-b2f0-465ee77f8638@bytedance.com>
Date:   Thu, 18 May 2023 17:27:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2 08/10] maple_tree: Rework mas_wr_slot_store() to be
 cleaner and more efficient.
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
 <20230517085809.86522-9-zhangpeng.00@bytedance.com>
 <20230517224812.knkhqmrweggsbnuk@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230517224812.knkhqmrweggsbnuk@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/18 06:48, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230517 04:59]:
>> The code of mas_wr_slot_store() is messy, make it clearer and concise,
>> and add comments. In addition, get whether the two gaps are empty to
>> avoid calling mas_update_gap() all the time.
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 59 ++++++++++++++++++++----------------------------
>>   1 file changed, 24 insertions(+), 35 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index bbe4c6f2858c..25a8b7d5d598 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -4200,49 +4200,38 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>>   static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
>>   {
>>   	struct ma_state *mas = wr_mas->mas;
>> -	unsigned long lmax; /* Logical max. */
>>   	unsigned char offset = mas->offset;
>> +	unsigned char offset_end = wr_mas->offset_end;
>> +	unsigned long lmax = wr_mas->end_piv; /* Logical max. */
>> +	bool gap = false;
>>   
>> -	if ((wr_mas->r_max > mas->last) && ((wr_mas->r_min != mas->index) ||
>> -				  (offset != wr_mas->node_end)))
>> +	if (offset_end - offset != 1)
>>   		return false;
>>   
>> -	if (offset == wr_mas->node_end - 1)
>> -		lmax = mas->max;
>> -	else
>> -		lmax = wr_mas->pivots[offset + 1];
>> -
>> -	/* going to overwrite too many slots. */
>> -	if (lmax < mas->last)
>> -		return false;
>> -
>> -	if (wr_mas->r_min == mas->index) {
>> -		/* overwriting two or more ranges with one. */
>> -		if (lmax == mas->last)
>> -			return false;
>> -
>> -		/* Overwriting all of offset and a portion of offset + 1. */
>> +	if (mas->index == wr_mas->r_min && mas->last < lmax) {
>> +		/* Overwriting the range and over a part of the next range. */
>> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
>> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
>>   		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
>>   		wr_mas->pivots[offset] = mas->last;
>> -		goto done;
>> -	}
>> -
>> -	/* Doesn't end on the next range end. */
>> -	if (lmax != mas->last)
>> +	} else if (mas->index > wr_mas->r_min && mas->last == lmax) {
>> +		/* Overwriting a part of the range and over the next range */
>> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
>> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
>> +		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
>> +		wr_mas->pivots[offset] = mas->index - 1;
>> +		mas->offset++; /* Keep mas accurate. */
>> +	} else {
>>   		return false;
> 
> Again here, I think you have already verified this will be a slot store
> by offset_end - offset == 1 and new_end == wr_mas->node_end.
> 
> The checking of the slots for the gap could be moved outside the
> statements.  WDYT?
Yes, I'll address this in v3. Thanks.
> 
>> +	}
>>   
>> -	/* Overwriting a portion of offset and all of offset + 1 */
>> -	if ((offset + 1 < mt_pivots[wr_mas->type]) &&
>> -	    (wr_mas->entry || wr_mas->pivots[offset + 1]))
>> -		wr_mas->pivots[offset + 1] = mas->last;
>> -
>> -	rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
>> -	wr_mas->pivots[offset] = mas->index - 1;
>> -	mas->offset++; /* Keep mas accurate. */
>> -
>> -done:
>>   	trace_ma_write(__func__, mas, 0, wr_mas->entry);
>> -	mas_update_gap(mas);
>> +	/*
>> +	 * Only update gap when the new entry is empty or there is an empty
>> +	 * entry in the original two ranges.
>> +	 */
>> +	if (!wr_mas->entry || gap)
>> +		mas_update_gap(mas);
>>   	return true;
>>   }
>>   
>> @@ -4396,7 +4385,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>>   	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
>>   		return;
>>   
>> -	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
>> +	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
>>   		return;
>>   	else if (mas_wr_node_store(wr_mas))
>>   		return;
>> -- 
>> 2.20.1
>>
