Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83D76B39DB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjCJJOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCJJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:13:24 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E300DBF1;
        Fri, 10 Mar 2023 01:08:41 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PY0Wb6NvdzSkN5;
        Fri, 10 Mar 2023 17:05:31 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 17:08:38 +0800
Subject: Re: [PATCH 4/6] crypto: hisilicon/qm - remove unnecessary aer.h
 include
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
References: <20230307161947.857491-1-helgaas@kernel.org>
 <20230307161947.857491-5-helgaas@kernel.org>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <98cd8461-3016-fc73-ff13-bb35e4907efa@huawei.com>
Date:   Fri, 10 Mar 2023 17:08:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230307161947.857491-5-helgaas@kernel.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/8 0:19, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> <linux/aer.h> is unused, so remove it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Weili Qian <qianweili@huawei.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/crypto/hisilicon/qm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index e4c84433a88a..8b563ab47484 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -2,7 +2,6 @@
>  /* Copyright (c) 2019 HiSilicon Limited. */
>  #include <asm/page.h>
>  #include <linux/acpi.h>
> -#include <linux/aer.h>
>  #include <linux/bitmap.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/idr.h>
> 

Acked-by: Longfang Liu <liulongfang@huawei.com>
Thanks.
