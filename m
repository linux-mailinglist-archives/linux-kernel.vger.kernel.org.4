Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2AC6F62AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 03:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjEDBbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 21:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDBbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 21:31:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1C110E6;
        Wed,  3 May 2023 18:31:03 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QBbnl13YRzsR6S;
        Thu,  4 May 2023 09:29:15 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 09:31:00 +0800
Message-ID: <65434e32-d1e5-54ef-2e91-b4aa8d79dfc8@huawei.com>
Date:   Thu, 4 May 2023 09:30:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
To:     <robbiek@xsightlabs.com>, <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230423110335.2679-1-lihuisong@huawei.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230423110335.2679-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

Can you add Reviewed-by again?
I forgot to do it when send v3.
There is no the 'Reviewed-by' tag on patchwork now.
I'm not sure if this affects patch merging.

/Huisong

在 2023/4/23 19:03, Huisong Li 写道:
> PCC supports processing platform notification for slave subspaces and
> shared interrupt for multiple subspaces.
>
> ---
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
