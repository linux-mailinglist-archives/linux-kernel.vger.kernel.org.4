Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A7E71FF84
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjFBKi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbjFBKib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:38:31 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9951E72
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:37:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-64d2c865e4eso1260218b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685702273; x=1688294273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fuk2QXOCQObDKHleb4Bh3x/yhaj/YjS0EbNYNs2gjtQ=;
        b=kCsnoKNNN78OOGOqoaa9vVsX4fVMN5dnpvG9DdGufMRXh/nc6UJAc/zr414FPHVZ4u
         9twaIkOA50fGfqo0fuoOGJptRcptiGck/p8bC0B7rXbl7im6xD+zu/8E7k39VEvKtC6J
         71C1xEaLUVgJ43jq8CcPtcN9vvwKKbZjqvbtkUt3IDqjHqzJ367AA7F159syxasP8j0V
         5etsfsDHCe2XazvSEzyYs8m3LjhJG8OunhM+MSToP33l83fpIFWJBqmzOepzzy0b36Xt
         +ZV/sP5EevtcIjTUTSzBgv2LcyUepo1FYhC+p0NrORtCbwCcsc96J3lB+UxTcidSH1yK
         WMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685702273; x=1688294273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fuk2QXOCQObDKHleb4Bh3x/yhaj/YjS0EbNYNs2gjtQ=;
        b=VSNYaNz2Y7p5NdWCP2oI6rEtGwxyl4FRfqc89me5tl+M/IwGV2LDM/JjvpJmEbmfcq
         QuFNl9tVIFSSXHbdtycajnFsUKV6niER0tqpVFLGVKE617octzqJ2ydGmt9MfE8yACRS
         kebb229gQNahALqeGUmEa04rlimmPLF5S4GmZNs5jdZPCe4TiVUPvoyAqhFrtIWv3aWg
         v+il/KhIcfd/nzXpE+ODhyHKaUS4LVHwpJX460PaSK/zQ9jkwhFHoKeHBNOItgrhVWQg
         4uVq47PrD69S4SORCtXAWphTNFTwKyGH5n/5kU4wmn9pOzCQaNYoc4BKy/H2OcsHr+P1
         OIwQ==
X-Gm-Message-State: AC+VfDzTac1qeh2IvM1FFZ35lBlZaf+/Duc8TpC0zkEL7svPNySka4+L
        NqwqmxCMwOKuEwoyRAiuscE=
X-Google-Smtp-Source: ACHHUZ6eoBwZKdbe2wjLE1Hojd3Ogm4PMZd1AFzlAn/MWU4aLPv0eYu4XTm3yxgvJ+MyiCidIx4+NA==
X-Received: by 2002:a05:6a00:1826:b0:64d:3e7f:7121 with SMTP id y38-20020a056a00182600b0064d3e7f7121mr10031788pfa.22.1685702272991;
        Fri, 02 Jun 2023 03:37:52 -0700 (PDT)
Received: from [10.200.9.101] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78810000000b00646ebc77b1fsm762436pfo.75.2023.06.02.03.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:37:52 -0700 (PDT)
Message-ID: <ba09af90-2f00-f2a6-94e3-7a1c9c74c31c@gmail.com>
Date:   Fri, 2 Jun 2023 18:37:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 13/14] maple_tree: Refine mas_preallocate() node
 calculations
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <20230601021605.2823123-14-Liam.Howlett@oracle.com>
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230601021605.2823123-14-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/1 10:16, Liam R. Howlett 写道:
> Calculate the number of nodes based on the pending write action instead
> of assuming the worst case.
> 
> This addresses a performance regression introduced in platforms that
> have longer allocation timing.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   lib/maple_tree.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index adf662bc413e..5ea211c3f186 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5541,9 +5541,51 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
>    */
>   int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>   {
> +	MA_WR_STATE(wr_mas, mas, entry);
> +	unsigned char node_size;
> +	int request = 1;
If either mas_wr_append() or mas_wr_slot_store() succeeds,
or does a simple replacement, we don't need to make any allocations.
>   	int ret;
>   
> -	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
> +
> +	if (unlikely(!mas->index && mas->last == ULONG_MAX))
> +		goto ask_now;
> +
> +	mas_wr_store_setup(&wr_mas);
> +	wr_mas.content = mas_start(mas);
> +	/* Root expand */
> +	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
> +		goto ask_now;
> +
> +	if (unlikely(!mas_wr_walk(&wr_mas))) {
> +		/* Spanning store, use worst case for now */
> +		request = 1 + mas_mt_height(mas) * 3;
> +		goto ask_now;
> +	}
> +
> +	/* At this point, we are at the leaf node that needs to be altered. */
> +	/* Exact fit, no nodes needed. */
> +	if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
> +		return 0;
> +
> +	mas_wr_end_piv(&wr_mas);
> +	node_size = mas_wr_new_end(&wr_mas);
> +	if (node_size >= mt_slots[wr_mas.type]) {
> +		/* Split, worst case for now. */
> +		request = 1 + mas_mt_height(mas) * 2;
> +		goto ask_now;
> +	}
> +
> +	/* New root needs a singe node */
> +	if (unlikely(mte_is_root(mas->node)))
> +		goto ask_now;
> +
> +	/* Potential spanning rebalance collapsing a node, use worst-case */
> +	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
> +		request = mas_mt_height(mas) * 2 - 1;
> +
> +	/* node store, slot store needs one node */
> +ask_now:
> +	mas_node_count_gfp(mas, request, gfp);
>   	mas->mas_flags |= MA_STATE_PREALLOC;
>   	if (likely(!mas_is_err(mas)))
>   		return 0;
