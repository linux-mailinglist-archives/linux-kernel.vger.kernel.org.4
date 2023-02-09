Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA02568FFF9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBIFop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBIFon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:44:43 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C421731
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 21:44:41 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbEiVu9_1675921476;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbEiVu9_1675921476)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 13:44:38 +0800
Message-ID: <1222a277-b55c-f0e1-7845-6dbd6887894b@linux.alibaba.com>
Date:   Thu, 9 Feb 2023 13:44:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] Documentation/ABI: sysfs-fs-erofs: update supported
 features
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
References: <20230209051128.10571-1-zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230209051128.10571-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/9 13:11, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Add missing feaures for sysfs-fs-erofs feature doc.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   Documentation/ABI/testing/sysfs-fs-erofs | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index bb4681a01811..284224d1b56f 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -4,7 +4,8 @@ Contact:	"Huang Jianan" <huangjianan@oppo.com>
>   Description:	Shows all enabled kernel features.
>   		Supported features:
>   		zero_padding, compr_cfgs, big_pcluster, chunked_file,
> -		device_table, compr_head2, sb_chksum.
> +		device_table, compr_head2, sb_chksum, ztailpacking,
> +		dedupe, fragments.
>   
>   What:		/sys/fs/erofs/<disk>/sync_decompress
>   Date:		November 2021
