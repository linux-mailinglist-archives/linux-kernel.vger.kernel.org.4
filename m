Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8616472E40C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbjFMNZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242639AbjFMNZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:25:11 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B301B0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:25:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vl2cNV1_1686662703;
Received: from 30.221.134.22(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vl2cNV1_1686662703)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 21:25:04 +0800
Message-ID: <25a8daec-e1c4-2164-c210-4ee6b9924c99@linux.alibaba.com>
Date:   Tue, 13 Jun 2023 21:25:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v8 4/5] erofs: unify inline/shared xattr iterators for
 listxattr/getxattr
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230613074114.120115-1-jefflexu@linux.alibaba.com>
 <20230613074114.120115-5-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230613074114.120115-5-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/13 15:41, Jingbo Xu wrote:

...

> +
> +int erofs_getxattr(struct inode *inode, int index,
> +		   const char *name,
> +		   void *buffer, size_t buffer_size)

I changed these line above into:

int erofs_getxattr(struct inode *inode, int index, const char *name,
		   void *buffer, size_t buffer_size)

> +{
> +	int ret;


...

>   ssize_t erofs_listxattr(struct dentry *dentry,
> @@ -568,8 +523,9 @@ ssize_t erofs_listxattr(struct dentry *dentry,

I also move erofs_listxattr definition into a line (since it's just
80 chars).


Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
