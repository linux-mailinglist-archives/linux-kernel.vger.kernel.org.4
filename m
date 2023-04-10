Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2376DC2C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDJChR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDJChQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:37:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F310330F3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:37:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so2052502pji.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 19:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681094234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJAvQYUDOxzUKcGTIyZbrwZ4Tpc0SBrozV1xC/oTk4o=;
        b=pxWB8fzvDnc3amC3Tkk22AwcbpOHkozuAAgHGAYwjmeh7pmrTiBMTPBViLm7wKfpPw
         H9eZTQd2Ugy6J/M8cDHzg8cQwdpc+ufSUuuxUeQh0k8vcMC0lTTLMdZIKZRDNHlPKI70
         wuF2P03ZdW/1Oj0I/mV1SlatugFokBfgZ5nWTQ8xc1BGBIAdgLkW8LUqTqLdjH9+dX/2
         WSxMYAKLY24IWYi1XEeqoJsgqijRJnyCRAa3AIa0Z0A0yKM24XGub04KyN4ftO0G7x3m
         7qKb8kX1G7jV6ryDx9wS/xEuB6e0yB/Y5XczM+I0tPtetrES8H6zpACHk8U+swK4Of+C
         EY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681094234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJAvQYUDOxzUKcGTIyZbrwZ4Tpc0SBrozV1xC/oTk4o=;
        b=MjLNJDDEVnv2D+LfuTqnawrsKj9ofdlsQHhej+BI4wxVr3mLWR+YGYlNsY//zvC/Fb
         cR/O3spHQlbwsIiYl0U3HZCc1ISyGQKAhpjD8KA3XB385hHp03GGTx+oL8+V3XgxEE5m
         AwLfcBgNJ95WlRWOtxsw3aft+DVaMe7/ooVkexdzPFgJasYgjx3J6WbbdVcHkiTbmn7W
         cUAs4CdjslqhG/6MTwBcmNV4iBBDR3/rH9WyDfISKvSMfhdGsjJwNzJHn6161RX1boqY
         TDL0Zr2u2+/Ve/Rr69kphxB+Mq+CgtnGAfGSldWoZu1Dd2U4GHgaDpRWnNhUDktbXJxf
         05VQ==
X-Gm-Message-State: AAQBX9dcrZVA7S/qv++imuZdAIhIEZPgg7gKJ7kKr+PVtnAXGADvjoVG
        vNP65awFSNVdKrYqhm7z1ZU=
X-Google-Smtp-Source: AKy350YfAYtWo5umdFKRneFqqsLrxDAD/4Cpyd+QdhhY7iN32KeRimQobNKXGTAk/5NkGNamYUF44A==
X-Received: by 2002:a17:902:c942:b0:19e:6760:305b with SMTP id i2-20020a170902c94200b0019e6760305bmr14132268pla.47.1681094234481;
        Sun, 09 Apr 2023 19:37:14 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ea8200b001a1cf0744a2sm6509195plb.247.2023.04.09.19.37.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Apr 2023 19:37:14 -0700 (PDT)
Date:   Mon, 10 Apr 2023 10:44:15 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] erofs: initialize packed inode after root inode is
 assigned
Message-ID: <20230410104415.00006ad2.zbestahu@gmail.com>
In-Reply-To: <20230407141710.113882-3-jefflexu@linux.alibaba.com>
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
        <20230407141710.113882-3-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Apr 2023 22:17:05 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> As commit 8f7acdae2cd4 ("staging: erofs: kill all failure handling in
> fill_super()"), move the initialization of packed inode after root
> inode is assigned, so that the iput() in .put_super() is adequate as
> the failure handling.
> 
> Otherwise, iput() is also needed in .kill_sb(), in case of the mounting
> fails halfway.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/internal.h |  1 +
>  fs/erofs/super.c    | 22 +++++++++++-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 2bcff3194e4a..caea9dc1cd82 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -157,6 +157,7 @@ struct erofs_sb_info {
>  
>  	/* what we really care is nid, rather than ino.. */
>  	erofs_nid_t root_nid;
> +	erofs_nid_t packed_nid;
>  	/* used for statfs, f_files - f_favail */
>  	u64 inos;
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 58ffbf410bfb..325602820dc8 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -388,17 +388,7 @@ static int erofs_read_superblock(struct super_block *sb)
>  #endif
>  	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
>  	sbi->root_nid = le16_to_cpu(dsb->root_nid);
> -#ifdef CONFIG_EROFS_FS_ZIP
> -	sbi->packed_inode = NULL;
> -	if (erofs_sb_has_fragments(sbi) && dsb->packed_nid) {
> -		sbi->packed_inode =
> -			erofs_iget(sb, le64_to_cpu(dsb->packed_nid));
> -		if (IS_ERR(sbi->packed_inode)) {
> -			ret = PTR_ERR(sbi->packed_inode);
> -			goto out;
> -		}
> -	}
> -#endif
> +	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
>  	sbi->inos = le64_to_cpu(dsb->inos);
>  
>  	sbi->build_time = le64_to_cpu(dsb->build_time);
> @@ -820,6 +810,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	erofs_shrinker_register(sb);
>  	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
> +#ifdef CONFIG_EROFS_FS_ZIP
> +	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
> +		sbi->packed_inode = erofs_iget(sb, sbi->packed_nid);
> +		if (IS_ERR(sbi->packed_inode)) {
> +			err = PTR_ERR(sbi->packed_inode);
> +			sbi->packed_inode = NULL;
> +			return err;
> +		}
> +	}
> +#endif
>  	err = erofs_init_managed_cache(sb);
>  	if (err)
>  		return err;

