Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB1D692EFE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBKHRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKHR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:17:28 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290275AB06
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 23:17:26 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PDMLS5XR0zRrvJ;
        Sat, 11 Feb 2023 15:14:56 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Feb 2023 15:17:23 +0800
Subject: Re: [PATCH] ubifs: make kobj_type structures constant
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230210-kobj_type-ubifs-v1-1-052419f90fae@weissschuh.net>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <a445d84b-2f08-69bf-9b23-5b5c79031d65@huawei.com>
Date:   Sat, 11 Feb 2023 15:17:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230210-kobj_type-ubifs-v1-1-052419f90fae@weissschuh.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/2/10 10:16, Thomas Weißschuh 写道:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   fs/ubifs/sysfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
> index 06ad8fa1fcfb..4404ca4f2ce9 100644
> --- a/fs/ubifs/sysfs.c
> +++ b/fs/ubifs/sysfs.c
> @@ -74,13 +74,13 @@ static const struct sysfs_ops ubifs_attr_ops = {
>   	.show	= ubifs_attr_show,
>   };
>   
> -static struct kobj_type ubifs_sb_ktype = {
> +static const struct kobj_type ubifs_sb_ktype = {
>   	.default_groups	= ubifs_groups,
>   	.sysfs_ops	= &ubifs_attr_ops,
>   	.release	= ubifs_sb_release,
>   };
>   
> -static struct kobj_type ubifs_ktype = {
> +static const struct kobj_type ubifs_ktype = {
>   	.sysfs_ops	= &ubifs_attr_ops,
>   };
>   
> 
> ---
> base-commit: e544a07438522ab3688416e6e2e34bf0ee6d8755
> change-id: 20230210-kobj_type-ubifs-5790a3d46e97
> 
> Best regards,
> 
