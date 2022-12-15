Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C3A64D9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiLOK5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiLOK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:57:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C104926C5;
        Thu, 15 Dec 2022 02:57:32 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NXq0z2HcMzJqZS;
        Thu, 15 Dec 2022 18:56:35 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 15 Dec 2022 18:57:30 +0800
Message-ID: <02631c6e-d8b8-c6fe-7339-9471f8c13227@huawei.com>
Date:   Thu, 15 Dec 2022 18:57:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ata:libata-eh:Cleanup ata_scsi_cmd_error_handler
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <20221215100959.1926459-1-haowenchao@huawei.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <20221215100959.1926459-1-haowenchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml100011.china.huawei.com (7.185.36.193) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/15 18:09, Wenchao Hao wrote:
> If ap->ops->error_handler is NULL, just go out and release the
> spinlock. This patch is just a cleanup, which would not change
> the origin error handle logic.
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/ata/libata-eh.c | 96 ++++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)
> 
Sorry, I send the wrong patch file, please ignore it
