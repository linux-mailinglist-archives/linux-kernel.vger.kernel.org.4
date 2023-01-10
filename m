Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5311A663F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbjAJL5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbjAJL5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:57:39 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B65193E4;
        Tue, 10 Jan 2023 03:57:28 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nrq1g3dLTzqV4X;
        Tue, 10 Jan 2023 19:52:39 +0800 (CST)
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 19:57:25 +0800
Subject: Re: [PATCH v10 3/3] crypto: hisilicon/qm - define the device
 isolation strategy
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <20221119074817.12063-1-yekai13@huawei.com>
 <20221119074817.12063-4-yekai13@huawei.com>
 <Y5V1zaurC8TuuA6l@gondor.apana.org.au>
CC:     <gregkh@linuxfoundation.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <liulongfang@huawei.com>
From:   "yekai (A)" <yekai13@huawei.com>
Message-ID: <03da282d-7654-4469-ca33-54eaa81b23d9@huawei.com>
Date:   Tue, 10 Jan 2023 19:57:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Y5V1zaurC8TuuA6l@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/11 14:16, Herbert Xu wrote:
> On Sat, Nov 19, 2022 at 07:48:17AM +0000, Kai Ye wrote:
>> Define the device isolation strategy by the device driver. The
>> user configures a hardware error threshold value by uacce interface.
>> If the number of hardware errors exceeds the value of setting error
>> threshold in one hour. The device will not be available in user space.
>> The VF device use the PF device isolation strategy. All the hardware
>> errors are processed by PF driver.
>>
>> Signed-off-by: Kai Ye <yekai13@huawei.com>
>> ---
>>  drivers/crypto/hisilicon/qm.c | 169 +++++++++++++++++++++++++++++++---
>>  include/linux/hisi_acc_qm.h   |  15 +++
>>  2 files changed, 169 insertions(+), 15 deletions(-)
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Hi Greg KH

Could you help me to apply this patchset v10?

thanks
Kai
