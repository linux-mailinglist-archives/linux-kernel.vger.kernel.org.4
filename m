Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955386C08E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCTC2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCTC2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:28:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B4F1C588
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 19:28:46 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PfzBW52QfzKs3J;
        Mon, 20 Mar 2023 10:26:27 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 10:28:42 +0800
Subject: Re: [PATCH -next] mtd: ubi: Simplify bool conversion
To:     Yang Li <yang.lee@linux.alibaba.com>, <miquel.raynal@bootlin.com>
CC:     <vigneshr@ti.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230215012117.83938-1-yang.lee@linux.alibaba.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <cce0dab6-01f4-11d4-6885-381171b7199e@huawei.com>
Date:   Mon, 20 Mar 2023 10:28:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230215012117.83938-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/2/15 9:21, Yang Li Ð´µÀ:
> ./drivers/mtd/ubi/build.c:1261:33-38: WARNING: conversion to bool not needed here
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4061
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/mtd/ubi/build.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index 0904eb40c95f..e9c153b7c471 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -1258,7 +1258,7 @@ static int __init ubi_init(void)
>   		mutex_lock(&ubi_devices_mutex);
>   		err = ubi_attach_mtd_dev(mtd, p->ubi_num,
>   					 p->vid_hdr_offs, p->max_beb_per1024,
> -					 p->enable_fm == 0 ? true : false);
> +					 p->enable_fm == 0);
>   		mutex_unlock(&ubi_devices_mutex);
>   		if (err < 0) {
>   			pr_err("UBI error: cannot attach mtd%d\n",
> 

Looks good.

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
