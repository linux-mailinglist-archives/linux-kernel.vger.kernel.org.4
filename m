Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3745D750064
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjGLHsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjGLHsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:48:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711131994
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:48:36 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R18ts4xp2zPkFx;
        Wed, 12 Jul 2023 15:46:13 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 15:48:33 +0800
Subject: Re: [PATCH -next v2] ubifs: Fix some kernel-doc comments
To:     Yang Li <yang.lee@linux.alibaba.com>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230712074637.129248-1-yang.lee@linux.alibaba.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <0ab0a5de-8530-7cbc-ded0-0ca9cfdfa5e9@huawei.com>
Date:   Wed, 12 Jul 2023 15:48:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230712074637.129248-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/7/12 15:46, Yang Li Ð´µÀ:
> Add description of @time and @flags in ubifs_update_time().
> 
> to silence the warnings:
> fs/ubifs/file.c:1383: warning: Function parameter or member 'time' not described in 'ubifs_update_time'
> fs/ubifs/file.c:1383: warning: Function parameter or member 'flags' not described in 'ubifs_update_time'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5848
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
> 
> --change in v2:
> According to Zhihao's suggestion, add a more accurate description to @flags.
> 
>   fs/ubifs/file.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index 436b27d7c58f..860497532555 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -1375,6 +1375,9 @@ static inline int mctime_update_needed(const struct inode *inode,
>   /**
>    * ubifs_update_time - update time of inode.
>    * @inode: inode to update
> + * @time:  timespec structure to hold the current time value
> + * @flags: time updating control flag determines updating
> + *	    which time fields of @inode
>    *
>    * This function updates time of the inode.
>    */
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
