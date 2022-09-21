Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E02B5BF8E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiIUIUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiIUITn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:19:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9D1895ED;
        Wed, 21 Sep 2022 01:19:25 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXWTT6X3SzpTtm;
        Wed, 21 Sep 2022 16:16:29 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 16:19:18 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 16:19:18 +0800
Message-ID: <3dd984c1-d17f-0a6a-c52e-87e161f867fc@huawei.com>
Date:   Wed, 21 Sep 2022 16:19:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH 0/6] crypto: benchmark - add the crypto benchmark
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <gregkh@linuxfoundation.org>
References: <20220919120537.39258-1-shenyang39@huawei.com>
 <Yyl5yKQCAgPBbFd7@gondor.apana.org.au>
From:   Yang Shen <shenyang39@huawei.com>
In-Reply-To: <Yyl5yKQCAgPBbFd7@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/20 16:28, Herbert Xu 写道:
> On Mon, Sep 19, 2022 at 08:05:31PM +0800, Yang Shen wrote:
>> Add crypto benchmark - A tool to help the users quickly get the
>> performance of a algorithm registered in crypto.
> Please explain how this relates to the existing speed testing
> functionality in tcrypt.
>
> Thanks,

In fact, the purpose for I is to get a crypto benchmark tool which is 
customizable
and easy to called. For example, I test the hardware performance every 
rc1 to check
whether the modification of the common module affects it. For me, I need 
to test
the mutil threads, mutil numas, mutil requests of one tfm and so on. 
These test
cases are used to simulate some service scenarios. And in these cases, I 
can find
if any common module apply a patch that has an impact on us.

I know the tcrypt.ko has the speed test cases. But the tcrypt.ko test 
case is fixed.
If I understand correctly, the design model of tcrypt.ko is test the 
algorithms with
determined case conditions. It can provide some standardized testing to 
ensure
that the implementation of the algorithm meets the requirements. This is a
reasonable developer test tool, but it is not flexible enough for 
testers and users.

There are two main reasons for this:
1> For testers, the performance is not only related to algorithms and 
algorithm
configurations. Many configurations may have obvious effect on 
performance which
are not provided on tcrypt.ko. Of course, this problem can fix by add 
these as module
parameters.
2> For users, a friendly tool is that they can use the tool directly 
rather to need to
watch the source code to know how to use it. In tcrypt.ko, users need to 
get the 'mode'
number of case they want to test if exist.

So this tool's original intention is to allow users test more complex 
scenarios and get the
parameters usage directly.

If I have any misunderstanding about tcrypt.ko, please correct me. And 
I'll try to use the
tcrytp.ko to meet my request.

Thanks,

Yang
