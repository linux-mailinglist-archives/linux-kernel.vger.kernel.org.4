Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BCD62F047
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbiKRI6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241301AbiKRI6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:58:50 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704E471F0F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:58:48 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ND9ft2npvzHw25;
        Fri, 18 Nov 2022 16:58:14 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:58:46 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:58:45 +0800
Subject: Re: [PATCH 0/6] ubifs: Fix wrong space calculation while doing budget
To:     Richard Weinberger <richard@nod.at>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yi zhang <yi.zhang@huawei.com>
References: <20221011034732.45605-1-chengzhihao1@huawei.com>
 <8207d8f9-8b30-cfbb-9a5f-56294cb35601@huawei.com>
 <16338722.252938.1668761788563.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <96ecfd93-f74f-5a43-2124-85168a08b00c@huawei.com>
Date:   Fri, 18 Nov 2022 16:58:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <16338722.252938.1668761788563.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

在 2022/11/18 16:56, Richard Weinberger 写道:
>> 在 2022/10/11 11:47, Zhihao Cheng 写道:
>>
>> Hi. Richard
>> Just a reminding. Could you please look through following series(Some of
>> them is sent several months ago), I wish these can be merged in 6.1,
>> thanks a lot:
>>
>> ubi infinite loop:
>> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=304485
>> ubi uaf in sysfs:
>> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=311956
>> ubi fastmap:
>> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=313063
>> ubifs assertion failed about writepage:
>> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=302776
>> ubifs space budget:
>> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=322220
> Sure. Let me check what happened to them.
OK. Thanks again.
> Thanks,
> //richard
> .


