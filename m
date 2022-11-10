Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F0A624219
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiKJMRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiKJMRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:17:12 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CA36C72F;
        Thu, 10 Nov 2022 04:17:11 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7LRb4C8LzHvkt;
        Thu, 10 Nov 2022 20:16:43 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 20:17:09 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 20:17:08 +0800
Message-ID: <4f167ee7-ad50-d66c-8bd7-811fa0e83cfd@huawei.com>
Date:   Thu, 10 Nov 2022 20:17:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] mailbox: pcc: rename platform interrupt bit macro
 name
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>
References: <20221110015034.7943-1-lihuisong@huawei.com>
 <20221110015034.7943-2-lihuisong@huawei.com>
 <20221110102528.6kuznowxtqkouvlb@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20221110102528.6kuznowxtqkouvlb@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


在 2022/11/10 18:25, Sudeep Holla 写道:
> On Thu, Nov 10, 2022 at 09:50:32AM +0800, Huisong Li wrote:
>> Currently, the name of platform interrupt bit macro, ACPI_PCCT_DOORBELL,
>> is not very appropriate. The doorbell is generally considered as an action
>> when send mailbox data. Actually, the macro value comes from Platform
>> Interrupt in Platform Communications Channel Global Flags. If the bit is
>> '1', it means that the platform is capable of generating an interrupt to
>> indicate completion of a command.
>>
> This is touching ACPICA header file, so it must be submitted to ACPICA
> separately following the guidelines in the github and imported into the
> kernel.
Got it, thanks.
>
> However, I don't see any point in this change. Yes the language "doorbell"
> is not used in this particular context in the spec, but it is implicit from
> other parts. I am not opposing the change though if Rafael is OK and ACPICA
> project accepts it.
@Rafael, what do you think?
>
