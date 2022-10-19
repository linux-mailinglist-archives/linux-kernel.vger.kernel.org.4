Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D863C603A98
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJSHZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJSHZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:25:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023963ECD2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:25:16 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mshw52NV0zVhvr;
        Wed, 19 Oct 2022 15:20:37 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 15:24:46 +0800
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 15:24:46 +0800
Message-ID: <a584e92d-61cb-6b9c-456b-6cbe40db6518@huawei.com>
Date:   Wed, 19 Oct 2022 15:24:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH -next] drivers: soc: ti: mark knav_acc_firmwares as static
To:     Nishanth Menon <nm@ti.com>
CC:     <ssantosh@kernel.org>, <m-karicheri2@ti.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220927061951.103450-1-chenjiahao16@huawei.com>
 <20221017221909.ds24hrbivwap5cek@countable>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <20221017221909.ds24hrbivwap5cek@countable>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/18 6:19, Nishanth Menon 写道:
> On 14:19-20220927, Chen Jiahao wrote:
>> There is a sparse warning shown below:
>>
>> drivers/soc/ti/knav_qmss_queue.c:70:12: warning: symbol
>> 'knav_acc_firmwares' was not declared. Should it be static?
>>
>> Since 'knav_acc_firmwares' is only called within knav_qmss_queue.c,
>> mark it as static to fix the warning.
>>
>> Fixes: 96ee19becc3b ("soc: ti: add firmware file name as part of the driver")
>> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
>> ---
>>   drivers/soc/ti/knav_qmss_queue.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
>> index 92af7d1b6f5b..c466b98a0293 100644
>> --- a/drivers/soc/ti/knav_qmss_queue.c
>> +++ b/drivers/soc/ti/knav_qmss_queue.c
>> @@ -67,7 +67,7 @@ static DEFINE_MUTEX(knav_dev_lock);
>>    * Newest followed by older ones. Search is done from start of the array
>>    * until a firmware file is found.
>>    */
>> -const char *knav_acc_firmwares[] = {"ks2_qmss_pdsp_acc48.bin"};
>> +static const char *knav_acc_firmwares[] = {"ks2_qmss_pdsp_acc48.bin"};
> next-20221017 checkpatch suggests:
>
> static const char * array should probably be static const char * const
>
> Could you check to ensure we are clear here?

Sure, it is safe to mark 'knav_acc_firmwares' as static const char * const.

Thanks for your reminder

>>   
>>   static bool device_ready;
>>   bool knav_qmss_device_ready(void)
>> -- 
>> 2.31.1
>>
