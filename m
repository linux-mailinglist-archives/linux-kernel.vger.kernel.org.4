Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29D561EB37
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKGGxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiKGGxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:53:32 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A9263F6;
        Sun,  6 Nov 2022 22:53:30 -0800 (PST)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5MPt2yrczRp42;
        Mon,  7 Nov 2022 14:53:22 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 14:53:28 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 14:53:28 +0800
Subject: Re: [PATCH v2 1/4] crypto: hisilicon/qm - modify the process of regs
 dfx
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <20221105095357.21199-1-yekai13@huawei.com>
 <20221105095357.21199-2-yekai13@huawei.com>
 <Y2Y4hWc+cUJ4VZgy@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>
From:   "yekai (A)" <yekai13@huawei.com>
Message-ID: <45cf9fba-fae6-8279-bfac-f70110df42dc@huawei.com>
Date:   Mon, 7 Nov 2022 14:53:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Y2Y4hWc+cUJ4VZgy@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



On 2022/11/5 18:18, Herbert Xu wrote:
> On Sat, Nov 05, 2022 at 09:53:54AM +0000, Kai Ye wrote:
>> +static void dfx_regs_uninit(struct hisi_qm *qm,
>> +		struct dfx_diff_registers *dregs, int reg_len)
>> +{
>> +	int i;
>> +
>> +	/* Setting the pointer is NULL to prevent double free */
>> +	for (i = 0; i < reg_len; i++) {
>> +		kfree(dregs[i].regs);
>> +		dregs[i].regs = NULL;
>> +	}
>> +	kfree(dregs);
>> +	dregs = NULL;
>> +}
> The line that I complained about is still here.
>
> Cheers,

ok

thanks
kai
