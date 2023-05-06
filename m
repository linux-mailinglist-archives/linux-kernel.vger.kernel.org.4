Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9226F9105
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 11:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjEFJtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 05:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 05:49:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0480883ED;
        Sat,  6 May 2023 02:49:02 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QD2hD4bQqzTjxm;
        Sat,  6 May 2023 17:44:28 +0800 (CST)
Received: from [10.67.101.126] (10.67.101.126) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 6 May 2023 17:49:00 +0800
Message-ID: <0b4dee69-347f-4a53-d41d-5a0de96d9b2f@huawei.com>
Date:   Sat, 6 May 2023 17:49:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Content-Language: en-CA
To:     Jason Yan <yanaijie@huawei.com>,
        John Garry <john.g.garry@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20230505025712.19438-1-yangxingui@huawei.com>
 <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
 <b13c9445-39c5-f207-d5d0-d6c86eee54ae@oracle.com>
 <1b703656-e966-63f8-19dd-33e4e9914676@huawei.com>
 <4364409d-e63c-f87f-0484-f170e92d44c5@huawei.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <4364409d-e63c-f87f-0484-f170e92d44c5@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.126]
X-ClientProxiedBy: dggpemm100015.china.huawei.com (7.185.36.61) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/6 10:11, Jason Yan wrote:
> On 2023/5/5 17:14, yangxingui wrote:
>>
>>
>> On 2023/5/5 16:25, John Garry wrote:
>>> On 05/05/2023 09:17, Damien Le Moal wrote:
>>>>> --- a/drivers/ata/libata-scsi.c
>>>>> +++ b/drivers/ata/libata-scsi.c
>>>>> @@ -26,6 +26,7 @@
>>>>>   #include <scsi/scsi_device.h>
>>>>>   #include <scsi/scsi_tcq.h>
>>>>>   #include <scsi/scsi_transport.h>
>>>>> +#include <scsi/libsas.h>
>>>
>>> hmmm... is it really acceptable that libata is referencing libsas? I 
>>> didn't think that it would be. libsas uses libata, not the other way 
>>> around.
>> Yeah, I didn't expect that either. Is there any other way? If so, is 
>> patch v1 OK?
> 
> Hi Xingui,
> 
> Libsas should follow the standard way of libata to manage the ata 
> structures. Not the opposite way. So what you should do is to find a way 
> for libsas to behave as a normal ata driver. It's not good to make 
> libata aware of libsas or referencing libsas.
> 
> If you have detailed questions you can ask me internally(which will be 
> faster) or publicly through the maillist(which may have some delay).
> 
ok

Thanks,
Xingui
.
> Thanks,
> Jason
> .
