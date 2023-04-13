Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C975A6E0845
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjDMHxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjDMHxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:53:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AA226A5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:53:06 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PxsGh65mVzrbJW;
        Thu, 13 Apr 2023 15:51:40 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Apr
 2023 15:53:04 +0800
Message-ID: <c4eced2d-8e64-f265-577a-878ed919f4cb@huawei.com>
Date:   Thu, 13 Apr 2023 15:53:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 1/2] x86: profiling: remove lock functions hack for
 !FRAME_POINTER
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Dave Hansen <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "akpm@linux-foudation.org" <akpm@linux-foudation.org>,
        "ben-linux@fluff.org" <ben-linux@fluff.org>,
        "wuchi.zero@gmail.com" <wuchi.zero@gmail.com>
References: <20230410022226.181812-1-chenzhongjin@huawei.com>
 <20230410022226.181812-2-chenzhongjin@huawei.com>
 <d416428f-c846-b6b9-74da-f3571d92d38a@intel.com>
 <1ceb1769-f01b-c417-e912-4ee1149dd0cb@huawei.com>
 <4c601a93e55341fc8cff766af43cb5e6@AcuMS.aculab.com>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <4c601a93e55341fc8cff766af43cb5e6@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/12 18:01, David Laight wrote:
> From: Chen Zhongjin
>> Sent: 12 April 2023 08:02
> ...
>>> 4. !CONFIG_FRAME_POINTER is probably even more rare today than it was in
>>>      2006
>> No. !CONFIG_FRAME_POINTER is more common today because of UNWINDER_ORC.
>> And that is why the bug is triggered more frequently.
> CONFIG_FRAME_POINTER is pretty much required (on x86-64)
> for the user copy checks that are enabled in distro kernels.

Thanks for reminding.. I know little about distro kernels.

I though at least !CONFIG_FRAME_POINTER is more common than it was in 2006.
Not investigated but just because UNWINDER_ORC is defconfig and it 
disables CONFIG_FRAME_POINTER.

Anyway, I kept the CONFIG_FRAME_POINTER not removed so it won't be affected.

Best,
Chen
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
