Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D01730CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbjFOB6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbjFOB6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:58:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1711720;
        Wed, 14 Jun 2023 18:58:48 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QhQQH3w9YzLmsd;
        Thu, 15 Jun 2023 09:56:55 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 09:58:46 +0800
Subject: Re: [PATCH v4 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
To:     Huisong Li <lihuisong@huawei.com>, <rafael@kernel.org>,
        <rafael.j.wysocki@intel.com>, <robbiek@xsightlabs.com>,
        <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230613125728.31279-1-lihuisong@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <820aa2f4-ad07-ba1d-d891-77f4b2542ea1@huawei.com>
Date:   Thu, 15 Jun 2023 09:58:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20230613125728.31279-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/13 20:57, Huisong Li wrote:
> PCC supports processing platform notification for slave subspaces and
> shared interrupt for multiple subspaces.
> 
> ---
>   -v4: add Reviewed-by.
>   -v3: update requesting shared irq code due to pcc using mbox_bind_client.
>   -v2: extract cmd complete code into a function.
>        unrelated types regard chan_in_use as dummy.
>   -v1: using subspace type to replace comm_flow_dir in patch [1/2]
>   -rfc-v3: split V2 into two patches.
>   -rfc-v2: don't use platform interrupt ack register to identify if the given
>        channel should respond interrupt.
> 
> Huisong Li (2):
>    mailbox: pcc: Add support for platform notification handling
>    mailbox: pcc: Support shared interrupt for multiple subspaces
> 
>   drivers/mailbox/pcc.c | 91 +++++++++++++++++++++++++++++++++++++------
>   1 file changed, 80 insertions(+), 11 deletions(-)
> 

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
