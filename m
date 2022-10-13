Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635BB5FD290
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJMB2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJMB2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:28:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F7F3C8DA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:28:44 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MnsHV54mNzlXfL;
        Thu, 13 Oct 2022 09:24:06 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 09:28:42 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 09:28:42 +0800
Subject: Re: [PATCH v2 1/2] ARM: Fix some check warnings of tool sparse
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221010095346.1957-1-thunder.leizhen@huawei.com>
 <20221010095346.1957-2-thunder.leizhen@huawei.com>
 <Y0RC213QSASPZekQ@shell.armlinux.org.uk>
 <3c8c29a8-a757-8f9d-23c6-d5790ce01611@huawei.com>
Message-ID: <60f181d5-4e1e-f45b-bc94-73ec5eebb4d0@huawei.com>
Date:   Thu, 13 Oct 2022 09:28:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3c8c29a8-a757-8f9d-23c6-d5790ce01611@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/11 10:13, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/10/11 0:05, Russell King (Oracle) wrote:
>> On Mon, Oct 10, 2022 at 05:53:45PM +0800, Zhen Lei wrote:
>>> Fix the following warnings:
>>>  warning: incorrect type in initializer (different address spaces)
>>>     expected unsigned short [noderef] __user *register __p
>>>     got unsigned short [usertype] *
>>>  warning: cast removes address space '__user' of expression
>>
>> I have a general principle that not all warnings should be fixed,
>> especially when it comes to sparse.
> 
> OK, I got it.
> 
>>
>> The aim is not to get to zero warnings - it's to get to a point where
>> the code is correct, and plastering the code with __force casts means
>> it isn't correct - you're just masking the warning.
>>
>> So no, I really don't like this. And I really don't like seeing
>> __force being used in open code in casts.
> 
> OK, I will clear only the first warning and leave the second warning.

Sorry, Maybe I misunderstood. '__force casts' mentioned here may include
not only '(__force u16 *)', but also '(u16 __user *)'.

> 
>>
> 

-- 
Regards,
  Zhen Lei
