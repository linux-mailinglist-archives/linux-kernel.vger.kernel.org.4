Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EC68FE27
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjBID63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjBID60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:58:26 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D612E810
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:58:25 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d2so914078pjd.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 19:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxAQGzrgLbEKwQLTtSgWWT/soA7h5zx9Of2z6uUxhpo=;
        b=alC9C1/54qBtm60InbmYrT1IuXDDtew6Mqg8QMXjlYPN0F+oQji1Aw762ZssCSPatD
         swp3F/VVLKdU2fJvSlnPndW1kYvkFiFQNGJQXQSPkxVrpU7kvTc6Om+1eLpf45QrJ3BR
         0FVLr+DC0Am0upSuHJ7z242L1WlDnEkN5gBUe6r1fIRX3S0JIkCzCVUdbgQXDJ6bMFWj
         3znlvBNm9Zwp/T43esqBr2/asXe3bKCRdaPH57xm/gri0AbT8Ib3Uit0eazui+/H8WDU
         OtwlPuURbiVmgNq/KNT7vts9NQqFPH9GhlYu/nloO7K/tEMAELeRgmfdal6KfYYh42em
         OQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxAQGzrgLbEKwQLTtSgWWT/soA7h5zx9Of2z6uUxhpo=;
        b=kXgzbREv03GKkSaeTn1i0nbKZ1ENwRoA+lKs/m/wpZK9S+2DJiNxRTohSXfnxoj4Xe
         mQCc5N3nQ3Qxgo5PWP12v0H8SY0sg9eSNT0S96TmaxUPneglPPlzi33zTmTVqGaJ56SA
         AQW47A8x/kbcAGbOWO6J/x+TJx9r65U8yvvStkYuNH6u8UgLjewOISQK0m0YH6ZaNDxO
         0rx2Fitn6DWPBpZN4FyMfouZu7Lh5cAmIe+9Pl3yQyvpYipcmZF4KPiQpWYhEoe04vVd
         I0d+P09Utvkfh3nuvF9dYgW5IMAkoLG74BjzkvWNpO+71JQux4Mp/5IjNoks/CSS+5+V
         5XXQ==
X-Gm-Message-State: AO0yUKXQsQDQNU5MqDCnbI312fgtRuix81AIpd58EZHV7gcVeuuwBulp
        FqR3dnKEWnrC9AzGwcTg2wU=
X-Google-Smtp-Source: AK7set+VRpB1T34o6oZU9KXK251nTXoKwlJ+1XmNMO0jf14olBYGzwci8pt33LwAUSSRf7+/5JavxA==
X-Received: by 2002:a17:90b:3903:b0:22c:7ed4:6bf9 with SMTP id ob3-20020a17090b390300b0022c7ed46bf9mr11099836pjb.28.1675915104781;
        Wed, 08 Feb 2023 19:58:24 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090ad3cf00b00229962d07bcsm300105pjw.6.2023.02.08.19.58.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Feb 2023 19:58:24 -0800 (PST)
Date:   Thu, 9 Feb 2023 12:04:09 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH v3 2/2] erofs: remove unused EROFS_GET_BLOCKS_RAW flag
Message-ID: <20230209120409.000030a0.zbestahu@gmail.com>
In-Reply-To: <20230209024825.17335-2-jefflexu@linux.alibaba.com>
References: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
        <20230209024825.17335-2-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Feb 2023 10:48:25 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> For erofs_map_blocks() and erofs_map_blocks_flatmode(), the flags
> argument is always EROFS_GET_BLOCKS_RAW.  Thus remove the unused flags
> parameter for these two functions.
> 
> Besides EROFS_GET_BLOCKS_RAW is originally introduced for reading
> compressed (raw) data for compressed files.  However it's never used
> actually and let's remove it now.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/data.c              | 14 ++++++--------
>  fs/erofs/fscache.c           |  2 +-
>  fs/erofs/internal.h          | 10 ++++------
>  include/trace/events/erofs.h |  1 -
>  4 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 2713257ee718..032e12dccb84 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -74,8 +74,7 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>  }
>  
>  static int erofs_map_blocks_flatmode(struct inode *inode,
> -				     struct erofs_map_blocks *map,
> -				     int flags)
> +				     struct erofs_map_blocks *map)
>  {
>  	erofs_blk_t nblocks, lastblk;
>  	u64 offset = map->m_la;
> @@ -114,8 +113,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  	return 0;
>  }
>  
> -int erofs_map_blocks(struct inode *inode,
> -		     struct erofs_map_blocks *map, int flags)
> +int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	struct erofs_inode *vi = EROFS_I(inode);
> @@ -127,7 +125,7 @@ int erofs_map_blocks(struct inode *inode,
>  	void *kaddr;
>  	int err = 0;
>  
> -	trace_erofs_map_blocks_enter(inode, map, flags);
> +	trace_erofs_map_blocks_enter(inode, map, 0);
>  	map->m_deviceid = 0;
>  	if (map->m_la >= inode->i_size) {
>  		/* leave out-of-bound access unmapped */
> @@ -137,7 +135,7 @@ int erofs_map_blocks(struct inode *inode,
>  	}
>  
>  	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
> -		err = erofs_map_blocks_flatmode(inode, map, flags);
> +		err = erofs_map_blocks_flatmode(inode, map);
>  		goto out;
>  	}
>  
> @@ -189,7 +187,7 @@ int erofs_map_blocks(struct inode *inode,
>  out:
>  	if (!err)
>  		map->m_llen = map->m_plen;
> -	trace_erofs_map_blocks_exit(inode, map, flags, 0);
> +	trace_erofs_map_blocks_exit(inode, map, 0, err);
>  	return err;
>  }
>  
> @@ -252,7 +250,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	map.m_la = offset;
>  	map.m_llen = length;
>  
> -	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	ret = erofs_map_blocks(inode, &map);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 03de4dc99302..9658cf8689d9 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -197,7 +197,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
>  	int ret;
>  
>  	map.m_la = pos;
> -	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	ret = erofs_map_blocks(inode, &map);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 48a2f33de15a..8a6ae820cd6d 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -401,16 +401,15 @@ struct erofs_map_blocks {
>  	unsigned int m_flags;
>  };
>  
> -#define EROFS_GET_BLOCKS_RAW    0x0001
>  /*
>   * Used to get the exact decompressed length, e.g. fiemap (consider lookback
>   * approach instead if possible since it's more metadata lightweight.)
>   */
> -#define EROFS_GET_BLOCKS_FIEMAP	0x0002
> +#define EROFS_GET_BLOCKS_FIEMAP		0x0001
>  /* Used to map the whole extent if non-negligible data is requested for LZMA */
> -#define EROFS_GET_BLOCKS_READMORE	0x0004
> +#define EROFS_GET_BLOCKS_READMORE	0x0002
>  /* Used to map tail extent for tailpacking inline or fragment pcluster */
> -#define EROFS_GET_BLOCKS_FINDTAIL	0x0008
> +#define EROFS_GET_BLOCKS_FINDTAIL	0x0004
>  
>  enum {
>  	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
> @@ -458,8 +457,7 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>  int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
>  int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		 u64 start, u64 len);
> -int erofs_map_blocks(struct inode *inode,
> -		     struct erofs_map_blocks *map, int flags);
> +int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
>  struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
>  int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  		  struct kstat *stat, u32 request_mask,
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index f0e43e40a4a1..cf4a0d28b178 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -19,7 +19,6 @@ struct erofs_map_blocks;
>  		{ 1,		"DIR" })
>  
>  #define show_map_flags(flags) __print_flags(flags, "|",	\
> -	{ EROFS_GET_BLOCKS_RAW,		"RAW" },	\
>  	{ EROFS_GET_BLOCKS_FIEMAP,	"FIEMAP" },	\
>  	{ EROFS_GET_BLOCKS_READMORE,	"READMORE" },	\
>  	{ EROFS_GET_BLOCKS_FINDTAIL,	"FINDTAIL" })

