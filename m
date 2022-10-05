Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9E45F4F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 06:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJEEy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 00:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJEEyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 00:54:54 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9111004B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 21:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664945692; x=1696481692;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X/wnYvLEfjWPiHP0g6qUoEkTmreuHxScsfCtdjtKDoI=;
  b=KtTMEz7Tz0rWiF6u+TyzDsUx/GG7TrbljiAc1Pt4LS0/SwxX4lFTP1IE
   fBZ77q0EZpuNj25Qykyf5KhMFJWCWZ32GIYpq9h9HLy0abFm1CQ+8Uiy9
   mtCf2k1JD1cLrkEViK9ZvxLFnbc8lmrJF+II03Z+KjAR13LLkqnXWz3tL
   0etiax4wPf8p4oMzFMAGf0DRSTNHcfZ+Gbts+vm+1lwCxsNZooX+4BKF/
   F6KAySmYxqjukT3tderzOf6OFGaUfozJJJ1gxl2cTz4PxEaXHz40E7qEH
   sVZQSnjLcM3XepiyeSY2/DNqRAC3KBzafQHrHZdYXrwVakZHjwdb6WlS0
   A==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="325117122"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 12:54:49 +0800
IronPort-SDR: whQzsPKeMPhqz/+UPcz/hRpB43keSRudPff8eg/NgsgZKaVLVVWVhxC/WeIPVvU1fECkrQvW3J
 8GCNcV1aOfL+UAmGgbZDGhxxoIxl59+v5X2owBDoX0Psjdx5y5vfxB3uhbUkEDRxPRI5RUsUUL
 n/LbRl4eaAgNmDE2boIhvbbbdC+iGIKDjAfNgGsoAQE7d6hHdeCMsysdiHM0P8AWvzFZisR3FX
 lomkvXXucjxqGx8lX0jtOvFALuTZaLwiKTC09uE6ybFEg9YZMe+xShe6sXempBdWcwxYX1T0zp
 Q37LrEAfRsDQucB+tY0vralm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:09:02 -0700
IronPort-SDR: m0TQHzvN7b2aYnuTpnaBAo/Q96wAdFinNBg0Xfla44q5GnURqF3ysJvMefP240UMZ/OHojDnu3
 5WDuYAQKD8fEMYOJsuXgbJcc8U7vJ/3x832pNJUKQP6pkEYNg9N5IUGvQsCKs7lgpBVzPYuWKP
 cpmmqs1IwsONVQ9Q4DI96N8Pvzh4p9AcM7VwDh5M6Oz6+vSPTVe1OPKKhYTEik1RbDpLJI7TOL
 R0aK7MhG8NzUpJOqLkonXDEMz7xO+kt2KK58jeHxaV8siaqUdKfCuWwc9YlVV1uua4UrO1d8le
 cIg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:54:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mj2LJ6C4Kz1Rwt8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 21:54:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664945687; x=1667537688; bh=X/wnYvLEfjWPiHP0g6qUoEkTmreuHxScsfC
        tdjtKDoI=; b=I45lrdqZJ44GFSl/+oBfP47bm9o4FQE7J+aQgmTDuydXl+k6Udw
        QJBeahxO3k77MCHH39X6yLg7HVLPCbWrstD7RqRPxXQUiFjh+auU/ShrMYSDSP9f
        VABP7UGxkocDuxGO9mJRMNLTgrLigBbDtWDYVA7T95nR5WimB1n1W5vi+d19Ki66
        ILmeuwmFJlHl9BLMfP/aRY52FD3Utl6yiZOqJXOwMUfVjMom1ELCp4ZoZnbETmVQ
        IQVBF9DRCkGR77WEH72NlSQ6Un85/5TTBnM5qaNOI6727z8FufdA3uK01ivfG6dk
        4WEtJjkcx4NK+i2kZu/kjD3QWegUdUjmRHg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Zx9T7XrGq-3h for <linux-kernel@vger.kernel.org>;
        Tue,  4 Oct 2022 21:54:47 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mj2LG1chxz1RvLy;
        Tue,  4 Oct 2022 21:54:45 -0700 (PDT)
Message-ID: <66698df8-74ca-e802-2250-04aecafa1106@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 13:54:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/6] null_blk: allow write zeores on non-membacked
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com, yukuai3@huawei.com
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-2-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221005031701.79077-2-kch@nvidia.com>
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
> Add a helper function to enable the REQ_OP_WRITE_ZEROES operations
> when null_blk is configured with the non-membacked operations.
> 
> Since write-zeroes is a non-trivial I/O operation we need this to
> add a blktest so we can test the non-trivial I/O path from the
> application to the block layer.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/null_blk/main.c     | 13 +++++++++++++
>  drivers/block/null_blk/null_blk.h |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 1f154f92f4c2..fc3e883f7b84 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -209,6 +209,10 @@ static bool g_discard;
>  module_param_named(discard, g_discard, bool, 0444);
>  MODULE_PARM_DESC(discard, "Support discard operations (requires memory-backed null_blk device). Default: false");
>  
> +static bool g_write_zeroes;
> +module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
> +MODULE_PARM_DESC(write_zeroes, "Support write-zeores operations. Default: false");

Why not make this a number of sectors representing the maximum size of a
write zero command (blk_queue_max_write_zeroes_sectors()) ? That would
allow exercising split write zeros BIOs.

> +
>  static unsigned long g_cache_size;
>  module_param_named(cache_size, g_cache_size, ulong, 0444);
>  MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (none)");
> @@ -678,6 +682,7 @@ static struct nullb_device *null_alloc_dev(void)
>  	dev->blocking = g_blocking;
>  	dev->memory_backed = g_memory_backed;
>  	dev->discard = g_discard;
> +	dev->write_zeroes = g_write_zeroes;
>  	dev->cache_size = g_cache_size;
>  	dev->mbps = g_mbps;
>  	dev->use_per_node_hctx = g_use_per_node_hctx;
> @@ -1800,6 +1805,13 @@ static void null_config_discard(struct nullb *nullb)
>  	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
>  }
>  
> +static void null_config_write_zeroes(struct nullb *nullb)
> +{
> +	if (!nullb->dev->write_zeroes)
> +		return;
> +	blk_queue_max_write_zeroes_sectors(nullb->q, UINT_MAX >> 9);
> +}
> +
>  static const struct block_device_operations null_bio_ops = {
>  	.owner		= THIS_MODULE,
>  	.submit_bio	= null_submit_bio,
> @@ -2111,6 +2123,7 @@ static int null_add_dev(struct nullb_device *dev)
>  		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
>  
>  	null_config_discard(nullb);
> +	null_config_write_zeroes(nullb);
>  
>  	if (config_item_name(&dev->item)) {
>  		/* Use configfs dir name as the device name */
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 94ff68052b1e..2c0c9c29158f 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -111,6 +111,7 @@ struct nullb_device {
>  	bool power; /* power on/off the device */
>  	bool memory_backed; /* if data is stored in memory */
>  	bool discard; /* if support discard */
> +	bool write_zeroes; /* if support write_zeroes */
>  	bool zoned; /* if device is zoned */
>  	bool virt_boundary; /* virtual boundary on/off for the device */
>  	bool no_sched; /* no IO scheduler for the device */

-- 
Damien Le Moal
Western Digital Research

