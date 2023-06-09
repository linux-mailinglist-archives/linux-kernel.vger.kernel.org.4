Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9110C728E75
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbjFIDR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbjFIDR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:17:29 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A236B3589;
        Thu,  8 Jun 2023 20:17:26 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8CxOurFmYJk8N0AAA--.2763S3;
        Fri, 09 Jun 2023 11:17:25 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxZuTEmYJkHZ4JAA--.29606S3;
        Fri, 09 Jun 2023 11:17:24 +0800 (CST)
Subject: Re: [PATCH v12 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-3-zhuyinbo@loongson.cn>
 <CAHp75VfrPX=VsXMry0Dg_Y4zgt59S=uY=rxCZzv8fBvr_w+i-g@mail.gmail.com>
 <88f19398-385e-440c-83e9-ce51ea60cc97@sirena.org.uk>
 <fa6d546f-ce92-1fe9-5400-0cb8bccf8ee5@loongson.cn>
 <23420735-0221-4eab-9a4e-07a6225c761a@sirena.org.uk>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <04638a1f-7e93-983c-a014-4a026309c7fa@loongson.cn>
Date:   Fri, 9 Jun 2023 11:17:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <23420735-0221-4eab-9a4e-07a6225c761a@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxZuTEmYJkHZ4JAA--.29606S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/8 下午7:53, Mark Brown 写道:
> On Thu, Jun 08, 2023 at 07:45:49PM +0800, zhuyinbo wrote:
>> 在 2023/6/8 下午6:29, Mark Brown 写道:
>>> On Thu, Jun 08, 2023 at 01:15:39PM +0300, Andy Shevchenko wrote:
>>>> On Thu, Jun 8, 2023 at 10:28 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> 
>>>>> This bus driver supports the Loongson SPI hardware controller in the
>>>>> Loongson platforms and supports to use DTS and PCI framework to
> 
>>> Please delete unneeded context from mails when replying.  Doing this
>>> makes it much easier to find your reply in the message, helping ensure
>>> it won't be missed by people scrolling through the irrelevant quoted
>>> material.
> 
>> okay, I got it.
> 
> That was more directed at Andy than you!


Okay, I will learn from Andy.

Thanks
> 

