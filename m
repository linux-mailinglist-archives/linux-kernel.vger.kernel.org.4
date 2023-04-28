Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB916F121C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345441AbjD1HGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345420AbjD1HGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:06:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6893E42
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:06:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso11725055b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682665592; x=1685257592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xQ4i41yadNXZoMMfJR6ndq8RUGvvWSipx17IUzZw44=;
        b=iXQevaYPY8i3iz3s9iVGQV/tD++3V73SujgAUJxBWB6lgovu7UOaSflc7KM/dv74b8
         +7Pshzhao4ftWLuyLS+XNcjQ/BYqwwF6pIHYreX1FYY+a8gQbQZBD3kAJOaQj4zgyrh2
         O3P9dvz3jhvw7c8AY16YGSAsDwk1dmmGmi7ldCJf7WNCVyVlTWJvaWIlQBRzQSBBgEy/
         lSTc89mVQuP3c9aV4T0k6DUiL+c2LsDwXuyAdUy8EnrdYh6fJRFnxtpHC41JJMIzrLYa
         2CB8kmA0IzZjoOHyAPlLDCxn8ajn4IIyWvEDSI0+JmWYVAeX51qi7vp48FK8v8VfQTne
         dW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682665592; x=1685257592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9xQ4i41yadNXZoMMfJR6ndq8RUGvvWSipx17IUzZw44=;
        b=Taijr3X7UqeGfXUulZB6LSgizBk5S3fVMHorDsOeG6DYSNRwNK1915l3a2hWXpiY+L
         UhSctm4yPXCjn+gtrvSEOxYL864TUkeCMxEHQ/4JIB5/9ABLAXwsCHx8tEPyQlmVnV/t
         t6cUH1BqaCVMrsKts3sqB99tJZs+za9gS76MKzVX95UYASLBHgexSICcqV/N8cYmXD3e
         Voynjb676NcpYvXxamKbnHkK85WjLkkxVfWx+Xm24Q8vAYJ9LIgTE0EoxRp+baQ6fde6
         8K4w0NV6cz7Z8TKb6MrOgQTfM1nzSJ9QIxpCOJM3pRy5eN8JG0HxE1chrxyXFIhZGfQx
         OdQA==
X-Gm-Message-State: AC+VfDwGn5RfE+Pt8Xc0u/hUzttz211PgG4f+CroTB+VLXBo3EtOLOU5
        uooOUZS7O0gseQek3lgQtrw=
X-Google-Smtp-Source: ACHHUZ43ezaN7TXWkuh7bvquJ5ITlCH6GUi6PqnfVF/+9iHZNU0GWP8pdsKUe5xyq1GgNKPvTi41yw==
X-Received: by 2002:a05:6a00:1806:b0:641:d9b:a458 with SMTP id y6-20020a056a00180600b006410d9ba458mr7416151pfa.18.1682665592004;
        Fri, 28 Apr 2023 00:06:32 -0700 (PDT)
Received: from [10.200.10.82] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id b200-20020a621bd1000000b0063b1bb2e0a7sm14242055pfb.203.2023.04.28.00.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 00:06:31 -0700 (PDT)
Message-ID: <e4bea3e8-1ee2-2259-27ed-e8d643299f72@gmail.com>
Date:   Fri, 28 Apr 2023 15:06:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 28/34] maple_tree: Revise limit checks in
 mas_empty_area{_rev}()
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-29-Liam.Howlett@oracle.com>
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230425140955.3834476-29-Liam.Howlett@oracle.com>
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
> Since the maple tree is inclusive in range, ensure that a range of 1
> (min = max) works for searching for a gap in either direction, and make
> sure the size is at least 1 but not larger than the delta between min
> and max.
> 
> This commit also updates the testing.  Unfortunately there isn't a way
> to safely update the tests and code without a test failure.
> 
> Suggested-by: Peng Zhang <zhangpeng.00@bytedance.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
Except test code.
> ---
>   lib/maple_tree.c      | 20 +++++++++++++-------
>   lib/test_maple_tree.c | 27 ++++++++++++++++++++-------
>   2 files changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index fe6c9da6f2bd5..7370d7c12fe3b 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5248,7 +5248,10 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
>   	unsigned long *pivots;
>   	enum maple_type mt;
>   
> -	if (min >= max)
> +	if (min > max)
> +		return -EINVAL;
> +
> +	if (size == 0 || max - min < size - 1)
>   		return -EINVAL;
>   
>   	if (mas_is_start(mas))
> @@ -5303,7 +5306,10 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>   {
>   	struct maple_enode *last = mas->node;
>   
> -	if (min >= max)
> +	if (min > max)
> +		return -EINVAL;
> +
> +	if (size == 0 || max - min < size - 1)
>   		return -EINVAL;
>   
>   	if (mas_is_start(mas)) {
> @@ -5339,7 +5345,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>   		return -EBUSY;
>   
>   	/* Trim the upper limit to the max. */
> -	if (max <= mas->last)
> +	if (max < mas->last)
>   		mas->last = max;
>   
>   	mas->index = mas->last - size + 1;
> @@ -6375,7 +6381,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
>   {
>   	int ret = 0;
>   
> -	MA_STATE(mas, mt, min, max - size);
> +	MA_STATE(mas, mt, min, min);
>   	if (!mt_is_alloc(mt))
>   		return -EINVAL;
>   
> @@ -6395,7 +6401,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
>   retry:
>   	mas.offset = 0;
>   	mas.index = min;
> -	mas.last = max - size;
> +	mas.last = max - size + 1;
>   	ret = mas_alloc(&mas, entry, size, startp);
>   	if (mas_nomem(&mas, gfp))
>   		goto retry;
> @@ -6411,14 +6417,14 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
>   {
>   	int ret = 0;
>   
> -	MA_STATE(mas, mt, min, max - size);
> +	MA_STATE(mas, mt, min, max - size + 1);
>   	if (!mt_is_alloc(mt))
>   		return -EINVAL;
>   
>   	if (WARN_ON_ONCE(mt_is_reserved(entry)))
>   		return -EINVAL;
>   
> -	if (min >= max)
> +	if (min > max)
>   		return -EINVAL;
>   
>   	if (max < size - 1)
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index 345eef526d8b0..7b2d19ad5934d 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -105,7 +105,7 @@ static noinline void __init check_mtree_alloc_rrange(struct maple_tree *mt,
>   	unsigned long result = expected + 1;
>   	int ret;
>   
> -	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end - 1,
> +	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end,
>   			GFP_KERNEL);
>   	MT_BUG_ON(mt, ret != eret);
>   	if (ret)
> @@ -683,7 +683,7 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
>   		0,              /* Return value success. */
>   
>   		0x0,            /* Min */
> -		0x565234AF1 << 12,    /* Max */
> +		0x565234AF0 << 12,    /* Max */
>   		0x3000,         /* Size */
>   		0x565234AEE << 12,  /* max - 3. */
>   		0,              /* Return value success. */
> @@ -695,14 +695,14 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
>   		0,              /* Return value success. */
>   
>   		0x0,            /* Min */
> -		0x7F36D510A << 12,    /* Max */
> +		0x7F36D5109 << 12,    /* Max */
>   		0x4000,         /* Size */
>   		0x7F36D5106 << 12,    /* First rev hole of size 0x4000 */
>   		0,              /* Return value success. */
>   
>   		/* Ascend test. */
>   		0x0,
> -		34148798629 << 12,
> +		34148798628 << 12,
>   		19 << 12,
>   		34148797418 << 12,
>   		0x0,
> @@ -714,6 +714,12 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
>   		0x0,
>   		-EBUSY,
>   
> +		/* Single space test. */
> +		34148798725 << 12,
> +		34148798725 << 12,
> +		1 << 12,
> +		34148798725 << 12,
> +		0,
>   	};
>   
>   	int i, range_count = ARRAY_SIZE(range);
> @@ -762,9 +768,9 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
>   	mas_unlock(&mas);
>   	for (i = 0; i < req_range_count; i += 5) {
>   #if DEBUG_REV_RANGE
> -		pr_debug("\tReverse request between %lu-%lu size %lu, should get %lu\n",
> -				req_range[i] >> 12,
> -				(req_range[i + 1] >> 12) - 1,
> +		pr_debug("\tReverse request %d between %lu-%lu size %lu, should get %lu\n",
> +				i, req_range[i] >> 12,
> +				(req_range[i + 1] >> 12),
>   				req_range[i+2] >> 12,
>   				req_range[i+3] >> 12);
>   #endif
> @@ -883,6 +889,13 @@ static noinline void __init check_alloc_range(struct maple_tree *mt)
>   		4503599618982063UL << 12,  /* Size */
>   		34359052178 << 12,  /* Expected location */
>   		-EBUSY,             /* Return failure. */
> +
> +		/* Test a single entry */
> +		34148798648 << 12,		/* Min */
> +		34148798648 << 12,		/* Max */
> +		4096,			/* Size of 1 */
> +		34148798648 << 12,	/* Location is the same as min/max */
> +		0,			/* Success */
>   	};
>   	int i, range_count = ARRAY_SIZE(range);
>   	int req_range_count = ARRAY_SIZE(req_range);
