Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B4A617390
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiKCBHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCBHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:07:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C64265B;
        Wed,  2 Nov 2022 18:07:40 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N2lq414gkzRny0;
        Thu,  3 Nov 2022 09:02:40 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 09:07:38 +0800
Subject: Re: [PATCH next v3 1/2] gpio: hisi: Add initial device tree support
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <f.fangjian@huawei.com>, <linus.walleij@linaro.org>,
        <yangyicong@hisilicon.com>, <xuwei5@huawei.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20221101082442.263448-1-chenweilong@huawei.com>
 <CAMRc=Mdi2ASr1Wq66YTQKTvW+ysU4bw=eN4=9tYUxcJWLPGNaQ@mail.gmail.com>
From:   chenweilong <chenweilong@huawei.com>
Message-ID: <a65d1bc5-16e3-7041-dfd1-665ee1dfa00a@huawei.com>
Date:   Thu, 3 Nov 2022 09:07:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mdi2ASr1Wq66YTQKTvW+ysU4bw=eN4=9tYUxcJWLPGNaQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.179.106]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/2 20:49, Bartosz Golaszewski wrote:
> On Tue, Nov 1, 2022 at 9:17 AM Weilong Chen <chenweilong@huawei.com> wrote:
>> Add support for HiSilicon GPIO controller in embedded platform, which
>> boot from devicetree.
>>
>> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
>> ---
> This is v3 - just like the previous version. Are there any changes?

Hi, v3 is the same with v2, but v2 had a lot change to v1.

Link for v2: https://lore.kernel.org/lkml/20221028022453.163186-2-chenweilong@huawei.com/

There's a change log in commit message to describe the changes.


I send v3 patch to fix problem of the other patch in the series:

Link is: https://lore.kernel.org/lkml/791619d1-a227-477a-99c6-7ba15b4a28df@huawei.com/

>
> Also: you don't need that -next in your patch tag.

Thanks for the advice, I will adjust it in subsequent  work.

Thanks.

>
> Bart
>
> .


