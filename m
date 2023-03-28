Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04B76CB94B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjC1IYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC1IYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:24:10 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB0E4EC1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:24:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VesNAiw_1679991838;
Received: from 30.221.134.40(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VesNAiw_1679991838)
          by smtp.aliyun-inc.com;
          Tue, 28 Mar 2023 16:23:59 +0800
Message-ID: <ae65829a-b2a6-281d-8d46-2c93d32f506a@linux.alibaba.com>
Date:   Tue, 28 Mar 2023 16:23:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 2/8] erofs: rename init_inode_xattrs with erofs_ prefix
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230323000949.57608-1-jefflexu@linux.alibaba.com>
 <20230323000949.57608-3-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230323000949.57608-3-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/23 08:09, Jingbo Xu wrote:
> Rename init_inode_xattrs() to erofs_init_inode_xattrs() without logic
> change.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/xattr.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 760ec864a39c..ab4517e5ec84 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -29,7 +29,7 @@ struct xattr_iter {
>   	unsigned int ofs;
>   };
>   
> -static int init_inode_xattrs(struct inode *inode)
> +static int erofs_init_inode_xattrs(struct inode *inode)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
>   	struct xattr_iter it;
> @@ -404,7 +404,7 @@ static int erofs_getxattr(struct inode *inode, int index, const char *name,
>   	if (!name)
>   		return -EINVAL;
>   
> -	ret = init_inode_xattrs(inode);
> +	ret = erofs_init_inode_xattrs(inode);
>   	if (ret)
>   		return ret;
>   
> @@ -619,7 +619,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>   	int ret;
>   	struct listxattr_iter it;
>   
> -	ret = init_inode_xattrs(d_inode(dentry));
> +	ret = erofs_init_inode_xattrs(d_inode(dentry));
>   	if (ret == -ENOATTR)
>   		return 0;
>   	if (ret)
