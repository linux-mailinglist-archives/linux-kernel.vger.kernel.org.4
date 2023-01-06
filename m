Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6E765FF46
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjAFLA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjAFLAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:00:49 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11A56E406
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673002843; x=1704538843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dzMGYcC76vsGLcqnozoVnvpsbbrZPxZlS6l3+6NEWPY=;
  b=naec50Kp6sLLWCYDqj1rKADbuTlIuhoAft0to+UFS80b9HlOQqM3SGQO
   bBsmtBs5Hjzse+TjvxpceMd8VW6CAFnu/5W0LJd/Be8RgXi6I2/O6hfIs
   ew8dojAEZ2uaje9qHuvLH7koOLGKQZdbCZP+wLMin7wu0MAm167/bDboW
   HhBAEQOVWmuWNE9b1ZjEZmc7gb06Koa0gXTNfIKcFcBQ0yMVcJHil6Pw+
   ojntvPbXyjmnDxswKxn5E6cP2YP31HG3pcmfpVpCz1yfm+lQWC2/y6T76
   U9bJU7yl0KvgOev8I89uA/334c2YqUxSktbtLjzfFnTi4I7w0YbHpNeud
   A==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665417600"; 
   d="scan'208";a="225224631"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 19:00:43 +0800
IronPort-SDR: dtGPcXsf3O9EmbO8RkV4KGkoI6k8u7e/ke9yS1gMTQynaBnJRdyJKLNMjXFTgZVSLzJNTMLhlJ
 SVXl3iY5D3jrr5fmk8D2n3rci3yOUAwZR9VZzDm7xhcAHvb4eR5gXXTfnoECh37YRQNQ7JmN5h
 ax53ZfVOxnezD+gDtiJzIxH4SzfGJlcgKryO8t1UXCIfhg64HYiUMqtP5W2kYvw/hTt+8Pk0Tr
 iFbjrri51KlRUC23k8DF+dW5oIYKNQvGFX4tIZroRCfE7ZZOMUFuf5LAugV0IAR0USqMb02PNl
 r04=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 02:12:53 -0800
IronPort-SDR: LbYF3NBVCZjtTQKL3syAGJtT2rYWE2Wzbt3e00v40XjCmYNnJPb09UEQCR+FTP058ZnHIVmxWI
 pxddpK2bsQci7lGx7QLyWWi1XUi7euR0db/bmblg40QhZacFajYn7G+Guf+eAPJLX57MomoVpr
 aHAyml7bYJ8cRfewGOFOiaoAu7xf8/Qdk65jAaNmnTAE+EV/aryruFC07afTan8tXDdBqv5MZW
 k1bkif22v06Bs5Up+0JtmaEZEa5WY5UdkmgX9NuhWYnDrTK44ZFpPSNi9H0Sq8BJl5jc0AMxep
 Ti8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 03:00:44 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpL3Z6BZDz1RwqL
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:00:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673002841; x=1675594842; bh=dzMGYcC76vsGLcqnozoVnvpsbbrZPxZlS6l
        3+6NEWPY=; b=bI2spnR+FSiaJZD4rCqOcAS5ZC4aFxAg5nxQYH9ZyzdPB6qzPqK
        qJl9DAxhBKDWf75kvgRz6sFKhkvGo50dpTfOtfOw5I8MQXCgPtZvgnoa/XgMBmkC
        wJHygiz9VZ/Az5WOlI3Sdx7uHm/Ao6zAZDxNQktjEiG78uC3st3QbwZQLWOukKxZ
        DUDsw4M1M3dbDDQNyDNtaAOQjAiUl5Sw1+bS5x7hERVnVcEQQFO1JwIP8BGbgppB
        FOg+lp5YUtPl5ESQQVtmFQMXdwq9uWaQHrrW3FyDCmkFvGTM0kyzMmxZI6O0eUPi
        Qtj2WFVnjNkfsy2c8K9rcPVMSkjP2XxaCmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2l0hAJt0314b for <linux-kernel@vger.kernel.org>;
        Fri,  6 Jan 2023 03:00:41 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpL3X00tLz1RvLy;
        Fri,  6 Jan 2023 03:00:39 -0800 (PST)
Message-ID: <32aaa034-dc39-75dd-f4ec-e0e5ef9dd29c@opensource.wdc.com>
Date:   Fri, 6 Jan 2023 20:00:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/7] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f@eucas1p1.samsung.com>
 <20230106083317.93938-3-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230106083317.93938-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/23 17:33, Pankaj Raghav wrote:
> Instead of open coding to check for zone start, add a helper to improve
> readability and store the logic in one place.
> 
> bdev_offset_from_zone_start() will be used later in the series.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-core.c       |  2 +-
>  block/blk-zoned.c      |  4 ++--
>  include/linux/blkdev.h | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9321767470dc..0405b3144e7a 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -573,7 +573,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  		return BLK_STS_NOTSUPP;
>  
>  	/* The bio sector must point to the start of a sequential zone */
> -	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
> +	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
>  	    !bio_zone_is_seq(bio))
>  		return BLK_STS_IOERR;
>  
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index db829401d8d0..614b575be899 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -277,10 +277,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
>  		return -EINVAL;
>  
>  	/* Check alignment (handle eventual smaller last zone) */
> -	if (sector & (zone_sectors - 1))
> +	if (!bdev_is_zone_start(bdev, sector))
>  		return -EINVAL;
>  
> -	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
> +	if (!bdev_is_zone_start(bdev, nr_sectors) && end_sector != capacity)
>  		return -EINVAL;
>  
>  	/*
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 0e40b014c40b..04b7cbfd7a2a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -715,6 +715,7 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>  {
>  	return 0;
>  }
> +

whiteline change

>  static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>  {
>  	return 0;
> @@ -1304,6 +1305,23 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
>  	return q->limits.chunk_sectors;
>  }
>  
> +static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
> +						   sector_t sec)
> +{
> +	if (!bdev_is_zoned(bdev))

this helper should never be called outside of code supporting zones. So
why this check ?

> +		return 0;
> +
> +	return sec & (bdev_zone_sectors(bdev) - 1);
> +}
> +
> +static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
> +{
> +	if (!bdev_is_zoned(bdev))
> +		return false;

Same here.

> +
> +	return bdev_offset_from_zone_start(bdev, sec) == 0;
> +}
> +
>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->limits.dma_alignment : 511;

-- 
Damien Le Moal
Western Digital Research

