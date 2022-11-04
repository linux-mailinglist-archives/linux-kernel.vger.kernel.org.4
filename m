Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC3618E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKDC0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiKDC0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:26:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDE624BF0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:26:03 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N3PXf6V4dzpW8R;
        Fri,  4 Nov 2022 10:22:26 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 10:26:01 +0800
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 10:26:01 +0800
Message-ID: <963da72d-ce85-ea0b-2100-33d191f724ac@huawei.com>
Date:   Fri, 4 Nov 2022 10:26:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH stable 0/1] x86: aperfmperf: bug report
To:     <tglx@linutronix.de>, <bp@alien8.de>, <mingo@redhat.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20221021021740.137196-1-zouyipeng@huawei.com>
Content-Language: en-US
From:   Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <20221021021740.137196-1-zouyipeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Ping~

在 2022/10/21 10:17, Yipeng Zou 写道:
> Recently i was doing some work about calculating CPU frequency on x86 on
> stable branch linux-5.10.y, and there is a problem which i descrip in
> the commit message.
>
> I've noticed that it has been abandoned on the mainline. On the mainline
> it becomes to update [a,m]cnt in timer code with HZ frequency, and it is
> actually calculated at the time of reading the cpu freqency. This solves
> the problem above.
>
> So, Are there other reasons why the stable branch doesn't have these
> changes?, this patch is just to ask how we plan to fix it.
>
> Yipeng Zou (1):
>    x86: aperfmperf: fix overflow problem in the concurrency scenario
>
>   arch/x86/kernel/cpu/aperfmperf.c | 4 ----
>   1 file changed, 4 deletions(-)
>
-- 
Regards,
Yipeng Zou

