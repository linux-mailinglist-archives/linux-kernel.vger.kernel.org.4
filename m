Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BEB6C2B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCUHeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCUHef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:34:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8135EC4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:34:06 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PgjwL6MvWzKq3Z;
        Tue, 21 Mar 2023 15:31:46 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 15:34:02 +0800
Subject: Re: [PATCH] ubifs: remove return in compr_exit()
To:     Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230321071136.68872-1-frank.li@vivo.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <61bd9c01-5e5d-76b0-103a-323a5bf0fa33@huawei.com>
Date:   Tue, 21 Mar 2023 15:34:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230321071136.68872-1-frank.li@vivo.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

> It's redundant, let's remove it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/ubifs/compress.c | 1 -
>   1 file changed, 1 deletion(-)
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/ubifs/compress.c b/fs/ubifs/compress.c
> index 3a92e6af69b2..75461777c466 100644
> --- a/fs/ubifs/compress.c
> +++ b/fs/ubifs/compress.c
> @@ -217,7 +217,6 @@ static void compr_exit(struct ubifs_compressor *compr)
>   {
>   	if (compr->capi_name)
>   		crypto_free_comp(compr->cc);
> -	return;
>   }
>   
>   /**
> 

