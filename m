Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF51D5F4F36
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJEFD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJEFDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:03:23 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7875273923
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 22:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664946163; x=1696482163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IpdVbeiDk47yeEbUSG7Rmzu5iKtX/wEgBXWa8KZO734=;
  b=H64XXCaXkF4j0TB8qX8LWWsrFjR7WB7ZUfTnn0jcpBRXlIgcgKy2+U6h
   51u3jUY2/KEJ+UsVpYZMEPI2u9z5Gka/BQWoZ9PdSfQP28Ry8DC6V5r43
   mEjR9ph+mmEcfrD6MbvLkqjK2gweftCc29COtva34PXH/6f1fiSytf2Dz
   2pTSx10PVzll+hbRAV3fCTAzTAMluBx4y+oJWyIdUXqUcLzqGvLmb/W9E
   uYirgalOICkqEISh9n7IAJdooOoV3q3/R0SUe27SL7X7xMNNTwYRkuq33
   Pd41Q3Jdp7shBjhYDaWaBROHbffx/Rw6id/+qAZvFuG43hSCAT3bkNJwo
   A==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="213017212"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 13:02:42 +0800
IronPort-SDR: J+NlOJju+F3aQdWHxP9OCwlgCqTSs0nBAAsKihSD6DYiaCSfVIJI6UIW68auNXWASKFZXXc3eq
 YY1fjEF9Y4/UewCrVVYOGmbpzJ982kyMAH1xXSg8Q3sLDsF042Eh09z/mlMk76pnzIq6p/05aN
 DmknuCzy47ik16Zk/QIXBtvPD5VZ4+Tb114lRvlrQFtNAA5nT3IdoaH/t2yg2KiSxj1+aIq0NU
 EAwRMADILZUDWD83qkTRH33ME28IScDBBqJJ5BwM37XiaBJ7VgJD7qNYJcabXfzCO3t+oMNxeA
 EbLCdhPsEF5C1OKtBA2RGyLj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:22:30 -0700
IronPort-SDR: g1mW96Y1CS3OwXkv5xLc7BUp2PAiHGHN4zkb2sIVhaw4ax1tco1X09oji61cdI4Oy+lCJbjXwe
 wDzLHKacgL/UAmIDRHS9z6fXJMVMifaMlCiYFGQwJlFjhRm+m2/k4K5jSaPxlBnEqASuqljTQI
 PUFZv+ng+L9Rd6NREvo0Y9KrfxnjvPewdFGDhGzu5bj4zOHC52y8qCjlE4ZV/h3nVTNEbup6Az
 z5boRiOToiKSxqghtbllAeH0caRJSyWTDUY6jSFDNGIuBzdqtg3Ie30VVSxuqYddx9JJT2UCuQ
 5ok=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:02:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mj2WQ1qMTz1RwqL
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 22:02:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664946161; x=1667538162; bh=IpdVbeiDk47yeEbUSG7Rmzu5iKtX/wEgBXW
        a8KZO734=; b=o3YyezxQoIl/0zyRka4xEA7+vuRJvPpRmSkwsqlFR/NEhDtpnjk
        +hnm5yk0wsqogyL0R6HtWHJ49MllU2OOhas/pp5ZmWsEzI9RA4mldvDa4C9UtGyL
        A7NGOwVvLwr4WhqitKNI+oygnrReui01IxxHDJH7G8fDn9YwLuTRgxn5tNcW3Y1g
        u8dUSY4duvg71hXLCNn6waGfVpp7TvqcNfeLXtzOrlylJ+POxSIKA2OhoYZw55d4
        EMgXS/gf5+OetQQck7jKqmuYQauYSdvF4Ip0PS/K3B5Sun54c4MYLGyQAQKVfuzu
        g5YLHyFUhyBo3KAvP4c3nNCnHgrFofVD0ow==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7kAYIl1OHfR6 for <linux-kernel@vger.kernel.org>;
        Tue,  4 Oct 2022 22:02:41 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mj2WM51n3z1RvLy;
        Tue,  4 Oct 2022 22:02:39 -0700 (PDT)
Message-ID: <b96c6d74-3436-c4c4-4c25-23960a1b3cc8@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 14:02:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/6] null_blk: code cleaup
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com, yukuai3@huawei.com
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-4-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221005031701.79077-4-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 12:16, Chaitanya Kulkarni wrote:
> Introduce and use two new macros for calculating the page index from
> given sector and index (offset) of the sector in the page.
> The newly added macros makes code easy to read with meaningful name and
> explanation comments attached to it.
> 
> While at it adjust the code in the null_free_sector() to return early
> to get rid of the extra identation.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/null_blk/main.c | 37 ++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 2d592b4eb815..b82c2ffeb086 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -14,6 +14,11 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt)	"null_blk: " fmt
>  
> +/* Gives page index for which this sector belongs to. */

That is clear from the macro name. Not convinced this comment is useful.

> +#define PAGE_IDX_FROM_SECT(sect)	(sect >> PAGE_SECTORS_SHIFT)
> +/* Gives index (offset) of the sector within page. */
> +#define SECT_IDX_IN_PAGE(sect)		((sect & SECTOR_MASK) << SECTOR_SHIFT)

SECT_OFFSET_IN_PAGE() ? A "page" not being an array of sectors, using
index for a sector is a little strange I think. And you use this macro for
things like:

	offset = SECT_IDX_IN_PAGE(sect);

So offset in the name makes more sense.

> +
>  #define FREE_BATCH		16
>  
>  #define TICKS_PER_SEC		50ULL
> @@ -860,20 +865,20 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
>  	struct radix_tree_root *root;
>  
>  	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
> -	idx = sector >> PAGE_SECTORS_SHIFT;
> +	idx = PAGE_IDX_FROM_SECT(sector);
>  	sector_bit = (sector & SECTOR_MASK);
>  
>  	t_page = radix_tree_lookup(root, idx);
> -	if (t_page) {
> -		__clear_bit(sector_bit, t_page->bitmap);
> -
> -		if (null_page_empty(t_page)) {
> -			ret = radix_tree_delete_item(root, idx, t_page);
> -			WARN_ON(ret != t_page);
> -			null_free_page(ret);
> -			if (is_cache)
> -				nullb->dev->curr_cache -= PAGE_SIZE;
> -		}
> +	if (!t_page)
> +		return;
> +	__clear_bit(sector_bit, t_page->bitmap);
> +
> +	if (null_page_empty(t_page)) {
> +		ret = radix_tree_delete_item(root, idx, t_page);
> +		WARN_ON(ret != t_page);
> +		null_free_page(ret);
> +		if (is_cache)
> +			nullb->dev->curr_cache -= PAGE_SIZE;
>  	}
>  }
>  
> @@ -885,11 +890,11 @@ static void null_zero_sector(struct nullb_device *d, sector_t sect,
>  	unsigned int offset;
>  	void *dest;
>  
> -	t_page = radix_tree_lookup(root, sect >> PAGE_SECTORS_SHIFT);
> +	t_page = radix_tree_lookup(root, PAGE_IDX_FROM_SECT(sect));
>  	if (!t_page)
>  		return;
>  
> -	offset = (sect & SECTOR_MASK) << SECTOR_SHIFT;
> +	offset = SECT_IDX_IN_PAGE(sect);
>  	dest = kmap_atomic(t_page->page);
>  	memset(dest + offset, 0, SECTOR_SIZE * nr_sects);
>  	kunmap_atomic(dest);
> @@ -949,7 +954,7 @@ static struct nullb_page *__null_lookup_page(struct nullb *nullb,
>  	struct nullb_page *t_page;
>  	struct radix_tree_root *root;
>  
> -	idx = sector >> PAGE_SECTORS_SHIFT;
> +	idx = PAGE_IDX_FROM_SECT(sector);
>  	sector_bit = (sector & SECTOR_MASK);
>  
>  	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
> @@ -1125,7 +1130,7 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
>  		if (null_cache_active(nullb) && !is_fua)
>  			null_make_cache_space(nullb, PAGE_SIZE);
>  
> -		offset = (sector & SECTOR_MASK) << SECTOR_SHIFT;
> +		offset = SECT_IDX_IN_PAGE(sector);
>  		t_page = null_insert_page(nullb, sector,
>  			!null_cache_active(nullb) || is_fua);
>  		if (!t_page)
> @@ -1159,7 +1164,7 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
>  	while (count < n) {
>  		temp = min_t(size_t, nullb->dev->blocksize, n - count);
>  
> -		offset = (sector & SECTOR_MASK) << SECTOR_SHIFT;
> +		offset = SECT_IDX_IN_PAGE(sector);
>  		t_page = null_lookup_page(nullb, sector, false,
>  			!null_cache_active(nullb));
>  

-- 
Damien Le Moal
Western Digital Research

