Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D375F4F1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 06:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJEE5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 00:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJEE5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 00:57:46 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D470073318
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 21:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664945865; x=1696481865;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KN2lg6zzWucjSOK5rPZIymytpXrjThzSinPr5sbnfPY=;
  b=rRivYDUqtdPixDH0iO9YWq3bb7fEebd9EMEm8QQAwKB/05GvpFUXDeUm
   fsSCzbGQc0J45RqMltVnVSUuvbwrxCpYO0K+WGaT4wHVxwrElmeK9j4nJ
   LTBVxKYFAERlKqIXdikb+AF4/5qPILqzwpwqpMofYJzZ/qqQX+u6oNs3F
   2XNmLw+B71NFy0v01AvLRntczNQAGA49zPZDdpwg3TIP+KTY39EGSOypx
   aBaZh8gYRgKVd3fPNOTg3donjY5XlnmZfUHf6JK7G2XzsQGhYClTgQzG8
   +bmDnsez8x+fGe4wOC/BNiG7w4kXzGZs1IoigX0cIrRLI9ojtATrh35NT
   w==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="213418998"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 12:57:43 +0800
IronPort-SDR: suuXI4jnxy5NE0hSoSkqZ3icvagmy/Cz3VdAlt2TrBd4Yi4dFUXj4M0Y+9fDn5M/4rqrXy7lZ3
 EhoOjF1klzxBkMy4zpXxh7EZuegew2uq/z4GCyJ3kOo6Ufh/Q1YKONpgJfsp1QedUszaPuO+kt
 TsjhKs73sjB6Ft8Bt7iL9+PC+wFlgXZnmHN8dv5kGPeZIM+PgDkDR5jDS9l/tixFbmlkYnWIV/
 Wy/Ewpy0BLfvVho6RgrGy1roDaKk9GSP7rFjQGINt1mQCSmjR9s7gzzIvEbxJIz8t6ZjPRYK5w
 R3/BZK2DLXYIDIaFYGBtcerJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:11:56 -0700
IronPort-SDR: omw+w0dzwpLq7+1SXRJ4RJSvaxzLNEiF3Tzq2wMwK5FBsqcf0EFbgMHKDTnx4f6P9YlZmRIOGV
 7cFv903sKQUSa/oeilEjSmdqUPSg83e2s18P6ABGHXxwneIeYN9UzE7a36OKRY66l1QLaV6dWN
 iHESWUX/YZlNM0KYG/ftkuNeoYOZ4lAU6yd3HzDbDgiF4bLZBWVrGcAOfH0EXJyvTP/cm7JaC4
 VcEX4wmXzg/lsQh+6GXW7upp8Hj74vw3EcoFSJt5+TSoq34FbK0AmvirfJ1NdlLY2PaPO7G6Gd
 q5M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:57:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mj2Pf6bMGz1RwtC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 21:57:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664945861; x=1667537862; bh=KN2lg6zzWucjSOK5rPZIymytpXrjThzSinP
        r5sbnfPY=; b=Cb86wCHARoD5+C2rhmnkRLbbxhZ9ngOW4nA9yNvWEY4LZgfZVN1
        /mpvQcb+sK4Bd9s4C6HIg7gCqGR6dOmi+W8H/mdzEbW6q0tt3XpF9LEHNfhWdRHP
        d0PsqbW7iqSEJNBlbUWQcAmcs+YPoC+hwSWTBWwgqSZkKPubXHPaafVJM8vKIYtC
        BcJFtidTdQXeA1m9XbdMU7ju4vLDA5GEQcCnTa3XrdgHuOCuQjEakHHePkjfIHRb
        Pl7lbAQkSikjtsq+ZijcHkv9ulRsGrAFlef0R+5wyBtP8xcYoqrXJvKQRyCtRyXL
        10vyvVk8+/f3VvhNrCwVNwHf60Hb0koR3rw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z54cWO9mrI2s for <linux-kernel@vger.kernel.org>;
        Tue,  4 Oct 2022 21:57:41 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mj2Pc1vZNz1RvLy;
        Tue,  4 Oct 2022 21:57:40 -0700 (PDT)
Message-ID: <89b93617-2fb1-3757-9f80-ddc06f02683f@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 13:57:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/6] null_blk: allow write zeores on membacked
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com, yukuai3@huawei.com
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-3-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221005031701.79077-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 12:16, Chaitanya Kulkarni wrote:
> Add a helper functions to enable the REQ_OP_WRITE_ZEROES operations
> when null_blk is configured with the membacked mode.
> 
> Since write-zeroes is a non-trivial I/O operation we need this to
> add a blktest so we can test the non-trivial I/O path from the
> application to the block layer.

Why a separate patch for this ? Introducing the module argument and
configfs equivalent separately in 2 different patches is strange and does
not facilitate review.

This patch should be merged with patch 1.

> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/null_blk/main.c | 46 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index fc3e883f7b84..2d592b4eb815 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -420,6 +420,7 @@ NULLB_DEVICE_ATTR(blocking, bool, NULL);
>  NULLB_DEVICE_ATTR(use_per_node_hctx, bool, NULL);
>  NULLB_DEVICE_ATTR(memory_backed, bool, NULL);
>  NULLB_DEVICE_ATTR(discard, bool, NULL);
> +NULLB_DEVICE_ATTR(write_zeroes, bool, NULL);
>  NULLB_DEVICE_ATTR(mbps, uint, NULL);
>  NULLB_DEVICE_ATTR(cache_size, ulong, NULL);
>  NULLB_DEVICE_ATTR(zoned, bool, NULL);
> @@ -544,6 +545,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
>  	&nullb_device_attr_power,
>  	&nullb_device_attr_memory_backed,
>  	&nullb_device_attr_discard,
> +	&nullb_device_attr_write_zeroes,
>  	&nullb_device_attr_mbps,
>  	&nullb_device_attr_cache_size,
>  	&nullb_device_attr_badblocks,
> @@ -618,7 +620,7 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
>  			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
>  			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
>  			"zone_capacity,zone_max_active,zone_max_open,"
> -			"zone_nr_conv,zone_size\n");
> +			"zone_nr_conv,zone_size,write_zeroes\n");
>  }
>  
>  CONFIGFS_ATTR_RO(memb_group_, features);
> @@ -875,6 +877,24 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
>  	}
>  }
>  
> +static void null_zero_sector(struct nullb_device *d, sector_t sect,
> +			     sector_t nr_sects, bool cache)
> +{
> +	struct radix_tree_root *root = cache ? &d->cache : &d->data;
> +	struct nullb_page *t_page;
> +	unsigned int offset;
> +	void *dest;
> +
> +	t_page = radix_tree_lookup(root, sect >> PAGE_SECTORS_SHIFT);
> +	if (!t_page)
> +		return;
> +
> +	offset = (sect & SECTOR_MASK) << SECTOR_SHIFT;
> +	dest = kmap_atomic(t_page->page);
> +	memset(dest + offset, 0, SECTOR_SIZE * nr_sects);
> +	kunmap_atomic(dest);
> +}
> +
>  static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
>  	struct nullb_page *t_page, bool is_cache)
>  {
> @@ -1191,6 +1211,27 @@ blk_status_t null_handle_discard(struct nullb_device *dev,
>  	return BLK_STS_OK;
>  }
>  
> +static blk_status_t null_handle_write_zeroes(struct nullb_device *dev,
> +					     sector_t sector, sector_t nr_sectors)
> +{
> +	unsigned int bytes_left = nr_sectors << 9;
> +	struct nullb *nullb = dev->nullb;
> +	size_t curr_bytes;
> +
> +	spin_lock_irq(&nullb->lock);
> +	while (bytes_left > 0) {
> +		curr_bytes = min_t(size_t, bytes_left, nullb->dev->blocksize);
> +		nr_sectors = curr_bytes >> SECTOR_SHIFT;
> +		null_zero_sector(nullb->dev, sector, nr_sectors, false);
> +		if (null_cache_active(nullb))
> +			null_zero_sector(nullb->dev, sector, nr_sectors, true);
> +		sector += nr_sectors;
> +		bytes_left -= curr_bytes;
> +	}
> +	spin_unlock_irq(&nullb->lock);
> +	return BLK_STS_OK;
> +}
> +
>  static int null_handle_flush(struct nullb *nullb)
>  {
>  	int err;
> @@ -1357,6 +1398,9 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
>  	if (op == REQ_OP_DISCARD)
>  		return null_handle_discard(dev, sector, nr_sectors);
>  
> +	if (op == REQ_OP_WRITE_ZEROES)
> +		return null_handle_write_zeroes(dev, sector, nr_sectors);
> +
>  	if (dev->queue_mode == NULL_Q_BIO)
>  		err = null_handle_bio(cmd);
>  	else

-- 
Damien Le Moal
Western Digital Research

