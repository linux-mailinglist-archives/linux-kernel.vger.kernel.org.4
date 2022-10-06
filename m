Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D7F5F60D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJFFyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJFFyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:54:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA2D8992C;
        Wed,  5 Oct 2022 22:54:16 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MjgWS2SCKzVhlr;
        Thu,  6 Oct 2022 13:49:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 13:54:13 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 13:54:13 +0800
Subject: Re: [PATCH -next v3] pinctrl: ocelot: add missing destroy_workqueue()
 in error path in ocelot_pinctrl_probe()
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <horatiu.vultur@microchip.com>,
        <andy.shevchenko@gmail.com>, <yangyingliang@huawei.com>
References: <20220925021258.1492905-1-yangyingliang@huawei.com>
 <CACRpkdZijkQAT84mfP06SgxBjHmrqSbWwctBBA0pvb_1xYzGvA@mail.gmail.com>
 <CACRpkda6kCL-FbEdfu9msXH6xnLn9fLC-q6hcm=e_H_AT_uVEQ@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <ddd58293-0b5b-3c34-c396-0a635444410d@huawei.com>
Date:   Thu, 6 Oct 2022 13:54:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda6kCL-FbEdfu9msXH6xnLn9fLC-q6hcm=e_H_AT_uVEQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/10/5 3:57, Linus Walleij wrote:
> On Tue, Oct 4, 2022 at 1:46 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sun, Sep 25, 2022 at 4:06 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>>
>>> Using devm_add_action_or_reset() to make workqueue device-managed, so it can be
>>> destroy whenever the driver is unbound.
>>>
>>> Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> ---
>>> v3:
>>>    Using devm_add_action_or_reset().
>> Patch applied, after deleting the hunks removing .remove because
>> that was already gone upstream.
> Ah, the patch introducing that is in the MFD tree is it not?
>
> Either ask Lee to apply it or wait until -rc1 it's no big deal
> anyway. Remind me in two weeks.
It's OK.

Thanks,
Yang
>
> Yours,
> Linus Walleij
> .
