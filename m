Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4295462B416
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiKPHjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKPHjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:39:13 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBC58C745;
        Tue, 15 Nov 2022 23:39:11 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8BxLLaek3RjXa8HAA--.10868S3;
        Wed, 16 Nov 2022 15:39:10 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axf+Cdk3Rjx5UUAA--.54799S2;
        Wed, 16 Nov 2022 15:39:10 +0800 (CST)
Subject: Re: [PATCH v10 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver
 support
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20221114024942.8111-1-zhuyinbo@loongson.cn>
 <20221115133840.GA861387-robh@kernel.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <b6b09a89-0284-69ee-a858-84c2198f4177@loongson.cn>
Date:   Wed, 16 Nov 2022 15:39:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221115133840.GA861387-robh@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axf+Cdk3Rjx5UUAA--.54799S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7CrWrZr1ftFykAFy3XF1xGrg_yoW8Wr48pF
        4fGa9YkFs8GF18Ga9xKryfZr95ZFZxJFnxtwsav342gryDAasa93yUKF1UCrykCFsxJF1x
        ua45Gw1Uuay5CFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x
        8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8c_-PUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2022/11/15 ÏÂÎç9:38, Rob Herring Ð´µÀ:
> On Mon, Nov 14, 2022 at 10:49:41AM +0800, Yinbo Zhu wrote:
>> From: zhanghongchen <zhanghongchen@loongson.cn>
>>
>> The Loongson-2 SoC has a few pins that can be used as GPIOs or take
>> multiple other functions. Add a driver for the pinmuxing.
>>
>> There is currently no support for GPIO pin pull-up and pull-down.
>>
>> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
>> Co-developed-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>> Change in v10:
>> 		1. Remove lio/uart2/uart1/carmera/dvo1/dvo0 pins resue configuration.
>> 		2. Remove the castings about readl/writel/definition addr.
>> Change in v9:
>> 		1. Add zhanghongchen as patch author and add Co-developed-by tag
>> 		   for myself.
>> 		2. Keep entry in order in Kconfig and Makefile.
>> 		3. Keep it as a separate group after generic linux/* ones.
>> 		4. Use linux/io.h replace asm-generic/io.h.
>> 		5. Use PINCTRL_PINGROUP() and associated data structure.
>> 		6. Remove Redundant blank line after loongson2_pmx_groups.
>> 		7. Adjust gpio_groups.
>> 		8. Remove message printk after devm_platform_ioremap_resource.
>> 		9. Remove comma for the terminator line.
>> 		10. Add MODULE_LICENSE("GPL") in driver ending.
>> Change in v8:
>> 		1. Add #include <linux/pinctrl/pinctrl.h>.
>> 		2. Add #include <linux/seq_file.h>.
>> Change in v7:
>> 		1. Add all history change log information.
> 
> Linus applied v7 already. Additional changes need to be incremental
> patches on top of it.
> 
> Rob
okay, I got it.
> 

