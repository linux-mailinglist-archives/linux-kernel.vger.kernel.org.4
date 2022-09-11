Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB75B4B63
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 04:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiIKCwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 22:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIKCwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 22:52:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F62332D80
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 19:52:29 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MQDgj3nKfzlVjm;
        Sun, 11 Sep 2022 10:48:33 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 11 Sep 2022 10:52:27 +0800
Subject: Re: [PATCH -next 1/2] um: virt-pci: add __init/__exit annotations to
 module init/exit funcs
From:   xiujianfeng <xiujianfeng@huawei.com>
To:     <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
        <johannes@sipsolutions.net>, <mst@redhat.com>,
        <vincent.whitchurch@axis.com>
CC:     <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220911024350.17444-1-xiujianfeng@huawei.com>
Message-ID: <652e3501-3a7c-7806-0bd0-cb2a81db0c1c@huawei.com>
Date:   Sun, 11 Sep 2022 10:52:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20220911024350.17444-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, bad patch format, drop it.

ÔÚ 2022/9/11 10:43, Xiu Jianfeng Ð´µÀ:
> Add missing __init/__exit annotations to module init/exit funcs.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   arch/um/drivers/virt-pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> index 027847023184..acb55b302b14 100644
> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -857,7 +857,7 @@ void *pci_root_bus_fwnode(struct pci_bus *bus)
>   	return um_pci_fwnode;
>   }
>   
> -static int um_pci_init(void)
> +static int __init um_pci_init(void)
>   {
>   	int err, i;
>   
> @@ -940,7 +940,7 @@ static int um_pci_init(void)
>   }
>   module_init(um_pci_init);
>   
> -static void um_pci_exit(void)
> +static void __exit um_pci_exit(void)
>   {
>   	unregister_virtio_driver(&um_pci_virtio_driver);
>   	irq_domain_remove(um_pci_msi_domain);
> 
