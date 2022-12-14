Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26164C277
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiLNC56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiLNC5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:57:54 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BA3DF37;
        Tue, 13 Dec 2022 18:57:53 -0800 (PST)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NX0Pv4751zRq1R;
        Wed, 14 Dec 2022 10:56:51 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 14 Dec 2022 10:57:51 +0800
Message-ID: <ef705471-0dd3-fef1-68df-6a5761410946@huawei.com>
Date:   Wed, 14 Dec 2022 10:57:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC-V3 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
To:     <robbiek@xsightlabs.com>, <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221203095150.45422-1-lihuisong@huawei.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20221203095150.45422-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

Can you take a look? This patch series works well for type3 and type4.

/Huisong Li

在 2022/12/3 17:51, Huisong Li 写道:
> PCC supports processing platform notification for slave subspaces and
> shared interrupt for multiple subspaces.
>
> ---
>   -v3: split V2 into two patches.
>   -v2: don't use platform interrupt ack register to identify if the given
>        channel should respond interrupt.
>
> Huisong Li (2):
>    mailbox: pcc: Add processing platform notification for slave subspaces
>    mailbox: pcc: Support shared interrupt for multiple subspaces
>
>   drivers/mailbox/pcc.c | 123 ++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 114 insertions(+), 9 deletions(-)
>
