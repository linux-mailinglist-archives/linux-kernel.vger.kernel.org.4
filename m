Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB05B5B6C59
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiIMLZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiIMLZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:25:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0298C13E2C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:25:17 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MRgzt47YrznVCx;
        Tue, 13 Sep 2022 19:22:34 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 19:25:14 +0800
Subject: Re: [PATCH] drivers/misc/sgi-xp: remove unused declarations in xp.h
To:     Steve Wahl <steve.wahl@hpe.com>
CC:     <robinmholt@gmail.com>, <mike.travis@hpe.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <hch@lst.de>,
        <linux-kernel@vger.kernel.org>
References: <20220911093212.3220496-1-cuigaosheng1@huawei.com>
 <Yx9PAHL/6ptF5MDF@swahl-home.5wahls.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <076c0021-0d2e-8e59-1832-beea561ad053@huawei.com>
Date:   Tue, 13 Sep 2022 19:25:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <Yx9PAHL/6ptF5MDF@swahl-home.5wahls.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Shouldn't xp_nofault_PIOR be removed also, for the exact same reasons?
>
> On Sun, Sep 11, 2022 at 05:32:12PM +0800, Gaosheng Cui wrote:
>> xp_nofault_PIOR_target and xp_error_PIOR have been removed since
>> commit 9726bfcdb977 ("misc/sgi-xp: remove SGI SN2 support"),
>> so remove them.
>>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   drivers/misc/sgi-xp/xp.h | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/misc/sgi-xp/xp.h b/drivers/misc/sgi-xp/xp.h
>> index 9f9af77f8d2e..cf073304b714 100644
>> --- a/drivers/misc/sgi-xp/xp.h
>> +++ b/drivers/misc/sgi-xp/xp.h
>> @@ -334,9 +334,7 @@ extern int (*xp_cpu_to_nasid) (int);
>>   extern enum xp_retval (*xp_expand_memprotect) (unsigned long, unsigned long);
>>   extern enum xp_retval (*xp_restrict_memprotect) (unsigned long, unsigned long);
>>   
>> -extern u64 xp_nofault_PIOR_target;
>>   extern int xp_nofault_PIOR(void *);
>> -extern int xp_error_PIOR(void);
>>   
>>   extern struct device *xp;
>>   extern enum xp_retval xp_init_uv(void);
>> -- 
>> 2.25.1
>>
Yes, Thanks for taking the time to review this patch, I have made a patch V2 and submitted it.
link: https://lore.kernel.org/lkml/20220913110356.764711-1-cuigaosheng1@huawei.com/T/#u

