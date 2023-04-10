Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED476DC24E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 03:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDJB1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 21:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjDJB1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 21:27:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C457635A7;
        Sun,  9 Apr 2023 18:26:57 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pvrq943X9zKxj2;
        Mon, 10 Apr 2023 09:24:21 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 09:26:53 +0800
Message-ID: <7ef4eec4-2cfb-6f66-a9b9-9c130a1b71d8@huawei.com>
Date:   Mon, 10 Apr 2023 09:26:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
From:   "lihuisong (C)" <lihuisong@huawei.com>
To:     Sudeep Holla <sudeep.holla@arm.com>, <robbiek@xsightlabs.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230314111135.16520-1-lihuisong@huawei.com>
 <20230327113326.dgrb5ainl6mv7wr5@bogus>
 <570a6f6d-87cb-48ca-3bbc-cd1221bfa88c@huawei.com>
In-Reply-To: <570a6f6d-87cb-48ca-3bbc-cd1221bfa88c@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/27 20:31, lihuisong (C) 写道:
>
> 在 2023/3/27 19:33, Sudeep Holla 写道:
>> On Tue, Mar 14, 2023 at 07:11:33PM +0800, Huisong Li wrote:
>>> PCC supports processing platform notification for slave subspaces and
>>> shared interrupt for multiple subspaces.
>>>
>> Other than a super minor nit in the patch 1/2, this looks good to me.
>> It would be good if we can get tested-by from
>> Robbie King <robbiek@xsightlabs.com>
>>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Thanks for your review.😁
>
> @Robbie King, can you give us some feedback?
> Looking forward to you reply.
>
>
@Robbie King, kindly ping.
