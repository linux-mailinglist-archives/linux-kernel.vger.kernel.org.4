Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F975715C59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjE3K54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjE3K5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:57:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F800125
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:57:29 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QVq3z2rwYz18LpZ;
        Tue, 30 May 2023 18:52:47 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 18:57:24 +0800
Message-ID: <c2d2ad06-a6c0-342f-402e-ac5d42d8dda8@huawei.com>
Date:   Tue, 30 May 2023 18:57:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] soc: hisilicon: Support HCCS driver on Kunpeng SoC
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <andersson@kernel.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <shawnguo@kernel.org>,
        <arnd@arndb.de>, <krzk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <wanghuiqiang@huawei.com>,
        <tanxiaofei@huawei.com>, <liuyonglong@huawei.com>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230522072211.8894-1-lihuisong@huawei.com>
 <20230522072211.8894-2-lihuisong@huawei.com>
 <20230523093922.f2y4wrz3vkzi7kmw@bogus>
 <b29eab0c-4084-0e91-3e31-7f7c264ad629@huawei.com>
 <20230525073539.waaa7wpudohullcg@bogus>
 <5e0d81c8-5f52-82e5-5509-785e87a9a17e@huawei.com>
 <7852a2b4-b601-f4e8-bc5f-7b1bc9d9dc69@huawei.com>
 <20230530084324.m47xvpqrga6tegpd@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230530084324.m47xvpqrga6tegpd@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/30 16:43, Sudeep Holla 写道:
> On Tue, May 30, 2023 at 10:53:38AM +0800, lihuisong (C) wrote:
>> Hi Sudeep,
>>
>>
>> 在 2023/5/25 16:12, lihuisong (C) 写道:
>>> 在 2023/5/25 15:35, Sudeep Holla 写道:
>>>> On Thu, May 25, 2023 at 10:41:51AM +0800, lihuisong (C) wrote:
>>>>> Hi Sudeep,
>>>>>
>>>>> Here, the interface is used to determine whether a port is in use or
>>>>> enabled.
>>>>> If we just use 'status', it cannot inidicates its own meaning by name.
>>>>> What do you think?
>>>>>
>>>> How about "port_status" or "port-status" ?
>>> The meaning of this status is a little board.
>>> How about 'enable'? just a read-only entry.
>>>
>>>
>> "using_status" --> "enable" ? What do you think?
>> Its original purpose was to determine whether a port is in use or enabled.
>>
> That's fine. The main point I was trying to make is plain "status" or
ok, create it as "enable".
> "using_status" is prone to conflict as you have ports, lanes, ...etc.
> Adding "port_" to the name whatever you choose is better.
Yes, adding "port_" is better if not all sysfs entries are related to 
the port.
Actually, all sysfs entries belong to the hccsX port under the hccsX 
directory.
>
