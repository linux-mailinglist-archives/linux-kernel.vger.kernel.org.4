Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E274864ADF3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiLMCyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiLMCya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:54:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF82913CEB;
        Mon, 12 Dec 2022 18:54:29 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NWNNV4PCyzmWTX;
        Tue, 13 Dec 2022 10:53:30 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 10:54:27 +0800
Message-ID: <61ac361e-a958-b112-6e40-73d7bcd390dc@huawei.com>
Date:   Tue, 13 Dec 2022 10:54:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: linux-next: build failure after merge of the mm-hotfixes tree
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221213093054.5211da74@canb.auug.org.au>
 <e8dfaf60-ff35-66d3-7bc1-f11eaaef642a@huawei.com>
 <20221212182304.fc148bf08bc17e58ec4b6674@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221212182304.fc148bf08bc17e58ec4b6674@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/13 10:23, Andrew Morton wrote:
> On Tue, 13 Dec 2022 09:34:24 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> Hi, this patch relays on Tony Luck's Patch series "Copy-on-write poison
>> recovery".[1]
>> and tested ppc64_defconfig based on next-20221208, it's no build failure
...
>> I think it is not very hotfix, also will send v3 to address some comments
>> we could adjust the patch order in mm tree, thanks.
> This patch is still in mm-unstable so updates won't be a problem.
> Soon, please.
Done, thanks.
>
