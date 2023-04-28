Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA126F11ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345304AbjD1GsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345251AbjD1GsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:48:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3FB3581
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 23:48:18 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-63b70f0b320so11712289b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 23:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682664498; x=1685256498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uC+tJ4GtJurVwS7BEvK2jrpzffs8Ds1Czvj8O+Xiy4I=;
        b=QHafmgIHrEx49yE494LBSgJnwcTuOlNreOBs0nBruW+Cu640UsRueGtf9jZz/3j3DN
         jD0d7xVbmZ2H4eTVtzkUN+1v3EWPY0kax9t9cQiqDIXsgPFcCwIhMLTXM2Aq7zoO96Di
         6Rcpb0Nikg+0xULgGE2ilmhoVUxknmYsCKPWNpVKmyZhglovsXa55XgMnEJr0DcoU51f
         GvUAq28Aw3aAImSKR2u+FPNWAhhbhcmPThqz7YL+q2BirWobTUzd4/WVQPA+OjTr6KqK
         V2tP7vnv/VzXTcvGX3FyHdmLn4qKXaCJKDI1ZzeaZ2Oq+axgP3Yc2Z6igffDeO9HEfYR
         UZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682664498; x=1685256498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uC+tJ4GtJurVwS7BEvK2jrpzffs8Ds1Czvj8O+Xiy4I=;
        b=FJhB54PfPM58kWGlRMZPGWPMh2GfMnfyoA9BMl6IqhwaqONBfybekqwd1/KdSyxkOq
         O1VXoo0OclXCAv8fTra3DyDiIx6mld7pRVe5PgtKF7aLOSo4hN3U4dgkhOlvoxPOXayK
         OSLTJ0nj3xN3brrrXKYWmU4VQ/Ey17mZPPCKdnaf6a1TE8h53lsPfF1rdBpFH6pfgb4a
         vFYZdVl96cBCyrhNCBOQEwLfHEB6DohJDvgWeBugrKwosFqWYLfxBATnY44lCGUQWE/Z
         qLuGHTMPinCfI9WYBaBTm2YPFFEJL3TmW1iO/Cfei9giBJhT8v/gCrS50uvOAeGt+JmE
         HI8g==
X-Gm-Message-State: AC+VfDxlJynPy8voLSCvsuncYjAZKs4a+yw3q3DWBARBaZhVGi67Heq2
        SFEiy7yXA6z+Su5OnLj5Otk=
X-Google-Smtp-Source: ACHHUZ51Qz9nSuXULfBI70vbcVZNidv0XPtJQeTyo0MdxoZJfX8E+6qtYeI6t1MB7lNTD6pb5sscfQ==
X-Received: by 2002:aa7:888f:0:b0:63d:254a:3900 with SMTP id z15-20020aa7888f000000b0063d254a3900mr5495826pfe.5.1682664497828;
        Thu, 27 Apr 2023 23:48:17 -0700 (PDT)
Received: from [10.200.10.82] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id y189-20020a62cec6000000b00640defda6d2sm7682777pfg.207.2023.04.27.23.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 23:48:17 -0700 (PDT)
Message-ID: <cfa05198-9ab0-3529-bc1f-08d8035a435c@gmail.com>
Date:   Fri, 28 Apr 2023 14:48:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 27/34] maple_tree: Introduce mas_next_slot() interface
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-28-Liam.Howlett@oracle.com>
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230425140955.3834476-28-Liam.Howlett@oracle.com>
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
> Sometimes, during a tree walk, the user needs the next slot regardless
> of if it is empty or not.  Add an interface to get the next slot.
> 
> Since there are no consecutive NULLs allowed in the tree, the mas_next()
> function can only advance two slots at most.  So use the new
> mas_next_slot() interface to align both implementations.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   lib/maple_tree.c | 178 +++++++++++++++++++----------------------------
>   1 file changed, 71 insertions(+), 107 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 31cbfd7b44728..fe6c9da6f2bd5 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4619,15 +4619,16 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
>   	if (mas->max >= max)
>   		goto no_entry;
>   
> +	min = mas->max + 1;
> +	if (min > max)
> +		goto no_entry;
Unnecessary check due to mas->max < max.
> +
>   	level = 0;
>   	do {
>   		if (ma_is_root(node))
>   			goto no_entry;
>   
> -		min = mas->max + 1;
> -		if (min > max)
> -			goto no_entry;
> -
> +		/* Walk up. */
>   		if (unlikely(mas_ascend(mas)))
>   			return 1;
>   
> @@ -4645,13 +4646,12 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
>   	slots = ma_slots(node, mt);
>   	pivot = mas_safe_pivot(mas, pivots, ++offset, mt);
>   	while (unlikely(level > 1)) {
> -		/* Descend, if necessary */
> +		level--;
>   		enode = mas_slot(mas, slots, offset);
>   		if (unlikely(ma_dead_node(node)))
>   			return 1;
>   
>   		mas->node = enode;
> -		level--;
>   		node = mas_mn(mas);
>   		mt = mte_node_type(mas->node);
>   		slots = ma_slots(node, mt);
> @@ -4680,85 +4680,84 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
>   	return 0;
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
> - * mas_next_nentry() - Get the next node entry
> - * @mas: The maple state
> - * @max: The maximum value to check
> - * @*range_start: Pointer to store the start of the range.
> + * mas_next_slot() - Get the entry in the next slot
>    *
> - * Sets @mas->offset to the offset of the next node entry, @mas->last to the
> - * pivot of the entry.
> + * @mas: The maple state
> + * @max: The maximum starting range
>    *
> - * Return: The next entry, %NULL otherwise
> + * Return: The entry in the next slot which is possibly NULL
>    */
> -static inline void *mas_next_nentry(struct ma_state *mas,
> -	    struct maple_node *node, unsigned long max, enum maple_type type)
> +void *mas_next_slot(struct ma_state *mas, unsigned long max)
>   {
> -	unsigned char count;
> -	unsigned long pivot;
> -	unsigned long *pivots;
>   	void __rcu **slots;
> +	unsigned long *pivots;
> +	unsigned long pivot;
> +	enum maple_type type;
> +	struct maple_node *node;
> +	unsigned char data_end;
> +	unsigned long save_point = mas->last;
>   	void *entry;
>   
> -	if (mas->last == mas->max) {
> -		mas->index = mas->max;
> -		return NULL;
> -	}
> -
> -	slots = ma_slots(node, type);
> +retry:
> +	node = mas_mn(mas);
> +	type = mte_node_type(mas->node);
>   	pivots = ma_pivots(node, type);
> -	count = ma_data_end(node, type, pivots, mas->max);
> -	if (unlikely(ma_dead_node(node)))
> -		return NULL;
> -
> -	mas->index = mas_safe_min(mas, pivots, mas->offset);
> -	if (unlikely(ma_dead_node(node)))
> -		return NULL;
> -
> -	if (mas->index > max)
> -		return NULL;
> +	data_end = ma_data_end(node, type, pivots, mas->max);
> +	pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
> +	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
> +		goto retry;
>   
> -	if (mas->offset > count)
> +	if (pivot >= max)
>   		return NULL;
>   
> -	while (mas->offset < count) {
> -		pivot = pivots[mas->offset];
> -		entry = mas_slot(mas, slots, mas->offset);
> -		if (ma_dead_node(node))
> -			return NULL;
> -
> -		mas->last = pivot;
> -		if (entry)
> -			return entry;
> -
> -		if (pivot >= max)
> -			return NULL;
> +	if (likely(data_end > mas->offset)) {
> +		mas->offset++;
> +		mas->index = mas->last + 1;
> +	} else  {
> +		if (mas_next_node(mas, node, max)) {
> +			mas_rewalk(mas, save_point);
> +			goto retry;
> +		}
>   
> -		if (pivot >= mas->max)
> +		if (mas_is_none(mas))
>   			return NULL;
>   
> -		mas->index = pivot + 1;
> -		mas->offset++;
> +		mas->offset = 0;
> +		mas->index = mas->min;
> +		node = mas_mn(mas);
> +		type = mte_node_type(mas->node);
> +		pivots = ma_pivots(node, type);
>   	}
>   
> -	pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
> +	slots = ma_slots(node, type);
> +	mas->last = mas_logical_pivot(mas, pivots, mas->offset, type);
>   	entry = mas_slot(mas, slots, mas->offset);
> -	if (ma_dead_node(node))
> -		return NULL;
> +	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
> +		goto retry;
>   
> -	mas->last = pivot;
>   	return entry;
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
>   /*
>    * mas_next_entry() - Internal function to get the next entry.
>    * @mas: The maple state
> @@ -4774,47 +4773,18 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
>   static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
>   {
>   	void *entry = NULL;
> -	struct maple_node *node;
> -	unsigned long last;
> -	enum maple_type mt;
>   
>   	if (mas->last >= limit)
>   		return NULL;
>   
> -	last = mas->last;
> -retry:
> -	node = mas_mn(mas);
> -	mt = mte_node_type(mas->node);
> -	mas->offset++;
> -	if (unlikely(mas->offset >= mt_slots[mt])) {
> -		mas->offset = mt_slots[mt] - 1;
> -		goto next_node;
> -	}
> -
> -	while (!mas_is_none(mas)) {
> -		entry = mas_next_nentry(mas, node, limit, mt);
> -		if (unlikely(ma_dead_node(node))) {
> -			mas_rewalk(mas, last);
> -			goto retry;
> -		}
> -
> -		if (likely(entry))
> -			return entry;
> -
> -		if (unlikely((mas->last >= limit)))
> -			return NULL;
> +	entry = mas_next_slot_limit(mas, limit);
> +	if (entry)
> +		return entry;
>   
> -next_node:
> -		if (unlikely(mas_next_node(mas, node, limit))) {
> -			mas_rewalk(mas, last);
> -			goto retry;
> -		}
> -		mas->offset = 0;
> -		node = mas_mn(mas);
> -		mt = mte_node_type(mas->node);
> -	}
> +	if (mas_is_none(mas))
> +		return NULL;
>   
> -	return NULL;
> +	return mas_next_slot_limit(mas, limit);
>   }
>   
>   /*
> @@ -4845,10 +4815,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
>   	slots = ma_slots(mn, mt);
>   	pivots = ma_pivots(mn, mt);
>   	count = ma_data_end(mn, mt, pivots, mas->max);
> -	if (unlikely(ma_dead_node(mn))) {
> -		mas_rewalk(mas, index);
> +	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
>   		goto retry;
> -	}
>   
>   	offset = mas->offset - 1;
>   	if (offset >= mt_slots[mt])
> @@ -4861,10 +4829,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
>   		pivot = pivots[offset];
>   	}
>   
> -	if (unlikely(ma_dead_node(mn))) {
> -		mas_rewalk(mas, index);
> +	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
>   		goto retry;
> -	}
>   
>   	while (offset && !mas_slot(mas, slots, offset)) {
>   		pivot = pivots[--offset];
> @@ -4881,10 +4847,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
>   
>   	min = mas_safe_min(mas, pivots, offset);
>   	entry = mas_slot(mas, slots, offset);
> -	if (unlikely(ma_dead_node(mn))) {
> -		mas_rewalk(mas, index);
> +	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
>   		goto retry;
> -	}
>   
>   	mas->offset = offset;
>   	mas->last = pivot;
