Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2166F133B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345477AbjD1I1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345429AbjD1I1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:27:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE732137
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 01:27:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-63b46186c03so10948718b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682670469; x=1685262469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H18dMVo9qUQadEgoZKjkca+2alYtWvOTeMQpVzEQrQ4=;
        b=f4CYpi6sFKm1jS5zAmyNI4iDz5fVbfn4mfmJQzvxjumrF3azU3cQv1jQRRg7MljF4i
         ySx5EYQBraTWANIvANtB4Y17URlsvGhXCG+0fvGOqmQk6SO5ItzipDM/hXYbtptr6qju
         nn4cJmRNWGCBbLMIEfNbTGvfMPtw/G/MkFziVdTTgnAAHBn8b3ybSSvV7ii3D4KlqokK
         avIYONmmVQGC/wEVgwu0C3TakuQINUnl85uvORs8XFp0cjC5QaV/jDqbmD4syG7kvXG2
         iM35Btrz964e9gN3nBOA4MQnfZ8rie5nbWKsATLkfZ6t/wkwBiuRiyduqom4OD/m+kWk
         6RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682670469; x=1685262469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H18dMVo9qUQadEgoZKjkca+2alYtWvOTeMQpVzEQrQ4=;
        b=fqC/yIgW9MU5/XFx8Dr+hO/i5YHLGAF3Tq4MMqRjNtyWX09VqhL4tfD8ZFLCNrrFvi
         Aeh6V887FtSzCp3/qoLdiYzbplgjXTepMkbtOB5dL5bFXU5onquBhQcyxt33V8uejrYb
         SCtkcPnPKP6lnn7O+iXdS5vVV7z/M4WpWFn3WcfzDmI1nuZmpeaWbrxm+GeTZv1FzO9+
         Q07GSYHmhPaRaKPph7HyA7AeNXeJsplNJ1gbABkPOQKMlSty4xGbAeLiUJ30mfyyeazU
         fijMR5NLuhSzoKwv99rGRYVpMdhVw5dbwA3JMdAE4GAWosVfNQZF+yTvkSgJ0ezm25zd
         XhBQ==
X-Gm-Message-State: AC+VfDxYJP9MsQyuiDZ90jyHTXTV7xHu9RIfWWyqq5EcuvFlM/7JNTpz
        +LSMjWLwTeKSI+/DcxP/7+4DwceHkEVllNSa
X-Google-Smtp-Source: ACHHUZ4DF2Pg2yl4DEAX+uYMHc8dn+00yHnBGDvWbYIQnl37VNIihmznbbNzycrXkSiYiIEtw1Eazw==
X-Received: by 2002:a05:6a20:7f92:b0:f0:e3ed:469a with SMTP id d18-20020a056a207f9200b000f0e3ed469amr5297306pzj.55.1682670468641;
        Fri, 28 Apr 2023 01:27:48 -0700 (PDT)
Received: from [10.200.10.82] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id q10-20020a63d60a000000b0051eff0a70d7sm12310713pgg.94.2023.04.28.01.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 01:27:48 -0700 (PDT)
Message-ID: <e91f609b-bee7-bc6a-cc01-e2d69fdd68c3@gmail.com>
Date:   Fri, 28 Apr 2023 16:27:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 29/34] maple_tree: Introduce mas_prev_slot() interface
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-30-Liam.Howlett@oracle.com>
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230425140955.3834476-30-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/25 22:09, Liam R. Howlett 写道:
> Sometimes the user needs to revert to the previous slot, regardless of
> if it is empty or not.  Add an interface to go to the previous slot.
> 
> Since there can't be two consecutive NULLs in the tree, the mas_prev()
> function can be implemented by calling mas_prev_slot() a maximum of 2
> times.  Change the underlying interface to use mas_prev_slot() to align
> the code.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   lib/maple_tree.c | 217 ++++++++++++++++++++---------------------------
>   1 file changed, 90 insertions(+), 127 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 7370d7c12fe3b..297d936321347 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4498,6 +4498,25 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
>   
>   }
>   
> +static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
> +{
> +retry:
> +	mas_set(mas, index);
> +	mas_state_walk(mas);
> +	if (mas_is_start(mas))
> +		goto retry;
> +}
> +
> +static inline bool mas_rewalk_if_dead(struct ma_state *mas,
> +		struct maple_node *node, const unsigned long index)
> +{
> +	if (unlikely(ma_dead_node(node))) {
> +		mas_rewalk(mas, index);
> +		return true;
> +	}
> +	return false;
> +}
> +
>   /*
>    * mas_prev_node() - Find the prev non-null entry at the same level in the
>    * tree.  The prev value will be mas->node[mas->offset] or MAS_NONE.
> @@ -4515,13 +4534,15 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
>   	struct maple_node *node;
>   	struct maple_enode *enode;
>   	unsigned long *pivots;
> +	unsigned long max;
>   
> -	if (mas_is_none(mas))
> -		return 0;
> +	node = mas_mn(mas);
> +	max = mas->min - 1;
May underflow.
> +	if (max < min)
> +		goto no_entry;
>   
>   	level = 0;
>   	do {
> -		node = mas_mn(mas);
>   		if (ma_is_root(node))
>   			goto no_entry;
>   
> @@ -4530,11 +4551,11 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
>   			return 1;
>   		offset = mas->offset;
>   		level++;
> +		node = mas_mn(mas);
>   	} while (!offset);
>   
>   	offset--;
>   	mt = mte_node_type(mas->node);
> -	node = mas_mn(mas);
>   	slots = ma_slots(node, mt);
>   	pivots = ma_pivots(node, mt);
>   	if (unlikely(ma_dead_node(node)))
> @@ -4543,12 +4564,10 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
>   	mas->max = pivots[offset];
>   	if (offset)
>   		mas->min = pivots[offset - 1] + 1;
> +
>   	if (unlikely(ma_dead_node(node)))
>   		return 1;
>   
> -	if (mas->max < min)
> -		goto no_entry_min;
> -
>   	while (level > 1) {
>   		level--;
>   		enode = mas_slot(mas, slots, offset);
> @@ -4569,9 +4588,6 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
>   
>   		if (offset < mt_pivots[mt])
>   			mas->max = pivots[offset];
> -
> -		if (mas->max < min)
> -			goto no_entry;
>   	}
>   
>   	mas->node = mas_slot(mas, slots, offset);
> @@ -4584,10 +4600,6 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
>   
>   	return 0;
>   
> -no_entry_min:
> -	mas->offset = offset;
> -	if (offset)
> -		mas->min = pivots[offset - 1] + 1;
>   no_entry:
>   	if (unlikely(ma_dead_node(node)))
>   		return 1;
> @@ -4596,6 +4608,62 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
>   	return 0;
>   }
>   
> +/*
> + * mas_prev_slot() - Get the entry in the previous slot
> + *
> + * @mas: The maple state
> + * @max: The minimum starting range
> + *
> + * Return: The entry in the previous slot which is possibly NULL
> + */
> +void *mas_prev_slot(struct ma_state *mas, unsigned long min)
> +{
> +	void *entry;
> +	void __rcu **slots;
> +	unsigned long pivot;
> +	enum maple_type type;
> +	unsigned long *pivots;
> +	struct maple_node *node;
> +	unsigned long save_point = mas->index;
> +
> +retry:
> +	node = mas_mn(mas);
> +	type = mte_node_type(mas->node);
> +	pivots = ma_pivots(node, type);
> +	pivot = mas_safe_min(mas, pivots, mas->offset);
> +	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
> +		goto retry;
> +
> +	if (pivot <= min)
> +		return NULL;
> +
> +	if (likely(mas->offset)) {
> +		mas->offset--;
> +		mas->last = mas->index - 1;
> +	} else  {
> +		if (mas_prev_node(mas, min)) {
> +			mas_rewalk(mas, save_point);
> +			goto retry;
> +		}
> +
> +		if (mas_is_none(mas))
> +			return NULL;
> +
> +		mas->last = mas->max;
> +		node = mas_mn(mas);
> +		type = mte_node_type(mas->node);
> +		pivots = ma_pivots(node, type);
> +	}
> +
> +	mas->index = mas_safe_min(mas, pivots, mas->offset);
> +	slots = ma_slots(node, type);
> +	entry = mas_slot(mas, slots, mas->offset);
> +	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
> +		goto retry;
> +
> +	return entry;
> +}
> +
>   /*
>    * mas_next_node() - Get the next node at the same level in the tree.
>    * @mas: The maple state
> @@ -4680,25 +4748,6 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
>   	return 0;
>   }
>   
> -static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
> -{
> -retry:
> -	mas_set(mas, index);
> -	mas_state_walk(mas);
> -	if (mas_is_start(mas))
> -		goto retry;
> -}
> -
> -static inline bool mas_rewalk_if_dead(struct ma_state *mas,
> -		struct maple_node *node, const unsigned long index)
> -{
> -	if (unlikely(ma_dead_node(node))) {
> -		mas_rewalk(mas, index);
> -		return true;
> -	}
> -	return false;
> -}
> -
>   /*
>    * mas_next_slot() - Get the entry in the next slot
>    *
> @@ -4777,117 +4826,31 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
>   	if (mas->last >= limit)
>   		return NULL;
>   
> -	entry = mas_next_slot_limit(mas, limit);
> +	entry = mas_next_slot(mas, limit);
>   	if (entry)
>   		return entry;
>   
>   	if (mas_is_none(mas))
>   		return NULL;
>   
> -	return mas_next_slot_limit(mas, limit);
> -}
> -
> -/*
> - * mas_prev_nentry() - Get the previous node entry.
> - * @mas: The maple state.
> - * @limit: The lower limit to check for a value.
> - *
> - * Return: the entry, %NULL otherwise.
> - */
> -static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
> -				    unsigned long index)
> -{
> -	unsigned long pivot, min;
> -	unsigned char offset, count;
> -	struct maple_node *mn;
> -	enum maple_type mt;
> -	unsigned long *pivots;
> -	void __rcu **slots;
> -	void *entry;
> -
> -retry:
> -	if (!mas->offset)
> -		return NULL;
> -
> -	mn = mas_mn(mas);
> -	mt = mte_node_type(mas->node);
> -	offset = mas->offset - 1;
> -	slots = ma_slots(mn, mt);
> -	pivots = ma_pivots(mn, mt);
> -	count = ma_data_end(mn, mt, pivots, mas->max);
> -	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
> -		goto retry;
> -
> -	offset = mas->offset - 1;
> -	if (offset >= mt_slots[mt])
> -		offset = mt_slots[mt] - 1;
> -
> -	if (offset >= count) {
> -		pivot = mas->max;
> -		offset = count;
> -	} else {
> -		pivot = pivots[offset];
> -	}
> -
> -	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
> -		goto retry;
> -
> -	while (offset && !mas_slot(mas, slots, offset)) {
> -		pivot = pivots[--offset];
> -		if (pivot >= limit)
> -			break;
> -	}
> -
> -	/*
> -	 * If the slot was null but we've shifted outside the limits, then set
> -	 * the range to the last NULL.
> -	 */
> -	if (unlikely((pivot < limit) && (offset < mas->offset)))
> -		pivot = pivots[++offset];
> -
> -	min = mas_safe_min(mas, pivots, offset);
> -	entry = mas_slot(mas, slots, offset);
> -	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
> -		goto retry;
> -
> -	mas->offset = offset;
> -	mas->last = pivot;
> -	mas->index = min;
> -	return entry;
> +	return mas_next_slot(mas, limit);
>   }
>   
>   static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
>   {
>   	void *entry;
> -	struct maple_enode *prev_enode;
> -	unsigned char prev_offset;
>   
>   	if (mas->index < min)
>   		return NULL;
>   
> -retry:
> -	prev_enode = mas->node;
> -	prev_offset = mas->offset;
> -	while (likely(!mas_is_none(mas))) {
> -		entry = mas_prev_nentry(mas, min, mas->index);
> -
> -		if (likely(entry))
> -			return entry;
> -
> -		if (unlikely(mas->index <= min))
> -			return NULL;
> -
> -		if (unlikely(mas_prev_node(mas, min))) {
> -			mas_rewalk(mas, mas->index);
> -			goto retry;
> -		}
> +	entry = mas_prev_slot(mas, min);
> +	if (entry)
> +		return entry;
>   
> -		mas->offset++;
> -	}
> +	if (mas_is_none(mas))
> +		return NULL;
>   
> -	mas->node = prev_enode;
> -	mas->offset = prev_offset;
> -	return NULL;
> +	return mas_prev_slot(mas, min);
>   }
>   
>   /*
