Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0F1630C19
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 06:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiKSFVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 00:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSFVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 00:21:06 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E3B91529
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 21:21:05 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NDhjP0vpxzqSMw;
        Sat, 19 Nov 2022 13:17:13 +0800 (CST)
Received: from [10.67.109.51] (10.67.109.51) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 13:21:03 +0800
Message-ID: <23feff35-6f2d-5cd7-57f9-ff2591a3c74e@huawei.com>
Date:   Sat, 19 Nov 2022 13:21:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] ubifs: Fix build errors as symbol undefined
To:     <richard@nod.at>, <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <weiyongjun1@huawei.com>, <yusongping@huawei.com>
References: <20221115083335.21211-1-hucool.lihua@huawei.com>
From:   "Lihua (lihua, ran)" <hucool.lihua@huawei.com>
In-Reply-To: <20221115083335.21211-1-hucool.lihua@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.51]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

在 2022/11/15 16:33, Li Hua 写道:
> When CONFIG_UBIFS_FS is enable but CONFIG_UBIFS_FS_AUTHENTICATION is not set:
>      ERROR: modpost: "ubifs_bad_hash" [fs/ubifs/ubifs.ko] undefined!
> 
> Fixes: 16a26b20d2af ("ubifs: authentication: Add hashes to index nodes")
> Signed-off-by: Li Hua <hucool.lihua@huawei.com>
> ---
>   fs/ubifs/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
> index 45d3d207fb99..93bda1057fdc 100644
> --- a/fs/ubifs/Kconfig
> +++ b/fs/ubifs/Kconfig
> @@ -13,6 +13,7 @@ config UBIFS_FS
>   	select CRYPTO_HASH_INFO
>   	select UBIFS_FS_XATTR if FS_ENCRYPTION
>   	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
> +	select UBIFS_FS_AUTHENTICATION
>   	depends on MTD_UBI
>   	help
>   	  UBIFS is a file system for flash devices which works on top of UBI.
> @@ -91,6 +92,7 @@ config UBIFS_FS_AUTHENTICATION
>   	select KEYS
>   	select CRYPTO_HMAC
>   	select SYSTEM_DATA_VERIFICATION
> +	select SYSTEM_TRUSTED_KEYRING
>   	help
>   	  Enable authentication support for UBIFS. This feature offers protection
>   	  against offline changes for both data and metadata of the filesystem.
> 
