Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED961625932
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiKKLSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiKKLR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:17:57 -0500
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Nov 2022 03:17:55 PST
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82AA06711D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:17:55 -0800 (PST)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 07F16205158B;
        Fri, 11 Nov 2022 20:08:11 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 2ABB85k6029676
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 20:08:06 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 2ABB85vK102819
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 20:08:05 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Submit) id 2ABB85vd102818;
        Fri, 11 Nov 2022 20:08:05 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Bo Liu <liubo03@inspur.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fat (exportfs): Fix some kernel-doc warnings
In-Reply-To: <20221111075648.4005-1-liubo03@inspur.com> (Bo Liu's message of
        "Fri, 11 Nov 2022 02:56:48 -0500")
References: <20221111075648.4005-1-liubo03@inspur.com>
Date:   Fri, 11 Nov 2022 20:08:05 +0900
Message-ID: <87wn8121gq.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bo Liu <liubo03@inspur.com> writes:

> Fixes the following W=1 kernel build warning(s):
>   fs/fat/nfs.c:21: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   fs/fat/nfs.c:139: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Looks good.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/nfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
> index af191371c352..3626eb585a98 100644
> --- a/fs/fat/nfs.c
> +++ b/fs/fat/nfs.c
> @@ -17,7 +17,7 @@ struct fat_fid {
>  #define FAT_FID_SIZE_WITHOUT_PARENT 3
>  #define FAT_FID_SIZE_WITH_PARENT (sizeof(struct fat_fid)/sizeof(u32))
>  
> -/**
> +/*
>   * Look up a directory inode given its starting cluster.
>   */
>  static struct inode *fat_dget(struct super_block *sb, int i_logstart)
> @@ -135,7 +135,7 @@ fat_encode_fh_nostale(struct inode *inode, __u32 *fh, int *lenp,
>  	return type;
>  }
>  
> -/**
> +/*
>   * Map a NFS file handle to a corresponding dentry.
>   * The dentry may or may not be connected to the filesystem root.
>   */

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
