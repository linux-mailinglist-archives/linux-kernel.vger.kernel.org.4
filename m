Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B6C5FAA83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJKCOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJKCOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:14:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FED48E83
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:14:27 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmfNl09xHzHtqQ;
        Tue, 11 Oct 2022 10:09:27 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 10:14:03 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 10:14:02 +0800
Subject: Re: [PATCH v2 1/2] ARM: Fix some check warnings of tool sparse
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221010095346.1957-1-thunder.leizhen@huawei.com>
 <20221010095346.1957-2-thunder.leizhen@huawei.com>
 <Y0RC213QSASPZekQ@shell.armlinux.org.uk>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <3c8c29a8-a757-8f9d-23c6-d5790ce01611@huawei.com>
Date:   Tue, 11 Oct 2022 10:13:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y0RC213QSASPZekQ@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/11 0:05, Russell King (Oracle) wrote:
> On Mon, Oct 10, 2022 at 05:53:45PM +0800, Zhen Lei wrote:
>> Fix the following warnings:
>>  warning: incorrect type in initializer (different address spaces)
>>     expected unsigned short [noderef] __user *register __p
>>     got unsigned short [usertype] *
>>  warning: cast removes address space '__user' of expression
> 
> I have a general principle that not all warnings should be fixed,
> especially when it comes to sparse.

OK, I got it.

> 
> The aim is not to get to zero warnings - it's to get to a point where
> the code is correct, and plastering the code with __force casts means
> it isn't correct - you're just masking the warning.
> 
> So no, I really don't like this. And I really don't like seeing
> __force being used in open code in casts.

OK, I will clear only the first warning and leave the second warning.

> 

-- 
Regards,
  Zhen Lei
