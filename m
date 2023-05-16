Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5F1704B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjEPKyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjEPKyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:54:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC72101
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:53:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae3ed1b0d6so2538585ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684234426; x=1686826426;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n626oaPkQJb0yVduT/hXLekvHPq7ugOQkvnQZLORBVs=;
        b=Sc33jbHFBWIl+idyGSuvHTzkB5uy2T0qJJr6vFv9fig/cTa1qfp++Q8NraXhnN6PSa
         ZNfKkaPoJDIwVLH3Kqjy621jzqy3Zr1rar/fCN1E8NdZ3veZ1cpteBrNV4xYYDFeVuwU
         Vy/pdHsbxsQUPhNXlSJ9w6tYpLxmCWGt6BE08CwxEBdcxeDUdCrwNcQrxTZSbN3bnkUC
         VSyyVc2Xmzm6uTHufUjLvD5kueb8j/ty3ivLrOijcPa+ZEsGWIt5ivnzUlFFH4lDvye8
         d8qbeoa2KxPMyzrXTkH6bS6flCjA2XiiAJXtTrzw0vHO99txCDG8YfOMQWoCDWTwAa56
         iGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684234426; x=1686826426;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n626oaPkQJb0yVduT/hXLekvHPq7ugOQkvnQZLORBVs=;
        b=ACwXKmXZh/nKNsqCeCuf9KYNZFiup7YyVe75LPRR2Sf6/O+sqKJVqvYpxxj56Zu556
         hJ5Qa+BctQl0scOCq8pNRY25cv2GTZhi6DcALwReu3v4ZSK/TKjJ8DZGSYSv+SuVSTcW
         7Sc5pM2LA18yc+3wpiRIy7Wa3GgGSJJqFOBZ38B4nIy8TjkNEWOHdY70aisJ53u4nNlA
         FF43eXI3FHJy0txd92/5oYDUZ+KvC7dRPAS4dYnU03ptmuluuzJKZuHWu2zLBHGu1UWk
         Jj3J+y35q2eGF0FEPaQp/DDaAIE5H6Sp+OyvugfwUr+xtg/3Ypjx5YvX8kysi0CA93JD
         NY8Q==
X-Gm-Message-State: AC+VfDzfbUhL65IwjWhFVTQhojjbY5BCVeEDQFJB8XMhAHTXxxI+zgMS
        3IynEypsXTaDyPM0wpsXYVb1fA==
X-Google-Smtp-Source: ACHHUZ5AQfk++7pQRRXrAeOET+n8VfLHWJwlbGOEJClVwFhamRZRow7rehPU2kjHi+vGVg4AzEgu1g==
X-Received: by 2002:a17:903:120f:b0:1ac:6d4c:c265 with SMTP id l15-20020a170903120f00b001ac6d4cc265mr38206074plh.28.1684234426023;
        Tue, 16 May 2023 03:53:46 -0700 (PDT)
Received: from [10.200.9.178] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001a988a71617sm15185678pla.192.2023.05.16.03.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 03:53:45 -0700 (PDT)
Message-ID: <c0530aec-754b-f382-3c96-35437d5ec762@bytedance.com>
Date:   Tue, 16 May 2023 18:53:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 10/10] maple_tree: Simplify and clean up
 mas_wr_node_store()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-11-zhangpeng.00@bytedance.com>
 <20230515185810.esnbqaybs5ivttwq@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230515185810.esnbqaybs5ivttwq@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/16 02:58, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
>> Simplify and clean up mas_wr_node_store(), remove unnecessary code.
> 
> This change fails the userspace testing for me.
> 
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 75 +++++++++++++-----------------------------------
>>   1 file changed, 20 insertions(+), 55 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index d558e7bcb6da8..ff4aa01cf88b6 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -4066,46 +4066,21 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>>    *
>>    * Return: True if stored, false otherwise
>>    */
>> -static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>> +static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
>> +				     unsigned char new_end)
>>   {
>>   	struct ma_state *mas = wr_mas->mas;
>>   	void __rcu **dst_slots;
>>   	unsigned long *dst_pivots;
>>   	unsigned char dst_offset;
>> -	unsigned char new_end = wr_mas->node_end;
>> -	unsigned char offset;
>> -	unsigned char node_slots = mt_slots[wr_mas->type];
>>   	struct maple_node reuse, *newnode;
>> -	unsigned char copy_size, max_piv = mt_pivots[wr_mas->type];
>> +	unsigned char copy_size, node_pivots = mt_pivots[wr_mas->type];
>>   	bool in_rcu = mt_in_rcu(mas->tree);
>>   
>> -	offset = mas->offset;
>> -	if (mas->last == wr_mas->r_max) {
>> -		/* runs right to the end of the node */
>> -		if (mas->last == mas->max)
>> -			new_end = offset;
>> -		/* don't copy this offset */
>> +	if (mas->last == wr_mas->end_piv)
>>   		wr_mas->offset_end++;
I guess there is a problem here? If we modify wr_mas->offset_end,
but this function fails to try the fast path, it will enter the
slow path with the modified offset_end. But it also has this
problem in the previous version.

I applied this patch to linux-next/master but it passed the
userspace tests. I need more information to confirm what the
problem is.

Thanks.

>> -	} else if (mas->last < wr_mas->r_max) {
>> -		/* new range ends in this range */
>> -		if (unlikely(wr_mas->r_max == ULONG_MAX))
>> -			mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
>> -
>> -		new_end++;
>> -	} else {
>> -		if (wr_mas->end_piv == mas->last)
>> -			wr_mas->offset_end++;
>> -
>> -		new_end -= wr_mas->offset_end - offset - 1;
>> -	}
>> -
>> -	/* new range starts within a range */
>> -	if (wr_mas->r_min < mas->index)
>> -		new_end++;
>> -
>> -	/* Not enough room */
>> -	if (new_end >= node_slots)
>> -		return false;
>> +	else if (unlikely(wr_mas->r_max == ULONG_MAX))
>> +		mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
>>   
>>   	/* Not enough data. */
>>   	if (!mte_is_root(mas->node) && (new_end <= mt_min_slots[wr_mas->type]) &&
>> @@ -4128,47 +4103,36 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>>   	dst_pivots = ma_pivots(newnode, wr_mas->type);
>>   	dst_slots = ma_slots(newnode, wr_mas->type);
>>   	/* Copy from start to insert point */
>> -	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * (offset + 1));
>> -	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * (offset + 1));
>> -	dst_offset = offset;
>> +	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * mas->offset);
>> +	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * mas->offset);
>>   
>>   	/* Handle insert of new range starting after old range */
>>   	if (wr_mas->r_min < mas->index) {
>> -		mas->offset++;
>> -		rcu_assign_pointer(dst_slots[dst_offset], wr_mas->content);
>> -		dst_pivots[dst_offset++] = mas->index - 1;
>> +		rcu_assign_pointer(dst_slots[mas->offset], wr_mas->content);
>> +		dst_pivots[mas->offset++] = mas->index - 1;
>>   	}
>>   
>>   	/* Store the new entry and range end. */
>> -	if (dst_offset < max_piv)
>> -		dst_pivots[dst_offset] = mas->last;
>> -	mas->offset = dst_offset;
>> -	rcu_assign_pointer(dst_slots[dst_offset], wr_mas->entry);
>> +	if (mas->offset < node_pivots)
>> +		dst_pivots[mas->offset] = mas->last;
>> +	rcu_assign_pointer(dst_slots[mas->offset], wr_mas->entry);
>>   
>>   	/*
>>   	 * this range wrote to the end of the node or it overwrote the rest of
>>   	 * the data
>>   	 */
>> -	if (wr_mas->offset_end > wr_mas->node_end || mas->last >= mas->max) {
>> -		new_end = dst_offset;
>> +	if (wr_mas->offset_end > wr_mas->node_end)
>>   		goto done;
>> -	}
>>   
>> -	dst_offset++;
>> +	dst_offset = mas->offset + 1;
>>   	/* Copy to the end of node if necessary. */
>>   	copy_size = wr_mas->node_end - wr_mas->offset_end + 1;
>>   	memcpy(dst_slots + dst_offset, wr_mas->slots + wr_mas->offset_end,
>>   	       sizeof(void *) * copy_size);
>> -	if (dst_offset < max_piv) {
>> -		if (copy_size > max_piv - dst_offset)
>> -			copy_size = max_piv - dst_offset;
>> +	memcpy(dst_pivots + dst_offset, wr_mas->pivots + wr_mas->offset_end,
>> +	       sizeof(unsigned long) * (copy_size - 1));
>>   
>> -		memcpy(dst_pivots + dst_offset,
>> -		       wr_mas->pivots + wr_mas->offset_end,
>> -		       sizeof(unsigned long) * copy_size);
>> -	}
>> -
>> -	if ((wr_mas->node_end == node_slots - 1) && (new_end < node_slots - 1))
>> +	if (new_end < node_pivots)
>>   		dst_pivots[new_end] = mas->max;
>>   
>>   done:
>> @@ -4429,7 +4393,8 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>>   
>>   	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
>>   		return;
>> -	else if (mas_wr_node_store(wr_mas))
>> +
>> +	if (mas_wr_node_store(wr_mas, new_end))
>>   		return;
>>   
>>   	if (mas_is_err(mas))
>> -- 
>> 2.20.1
>>
