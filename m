Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A88B6AFC73
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCHBgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCHBgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:36:06 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF7FE59E73;
        Tue,  7 Mar 2023 17:36:00 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxAf9_5gdkiagJAA--.12791S3;
        Wed, 08 Mar 2023 09:35:59 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxzr535gdkMctOAA--.16378S3;
        Wed, 08 Mar 2023 09:35:58 +0800 (CST)
Subject: Re: [PATCH v13 1/2] dt-bindings: clock: add loongson-2 boot clock
 index
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230307115022.12846-1-zhuyinbo@loongson.cn>
 <692a62da-a9a1-fa23-6e24-723d73c3a423@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <5e9b3bd5-d885-6237-5e14-2becb3c956cc@loongson.cn>
Date:   Wed, 8 Mar 2023 09:35:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <692a62da-a9a1-fa23-6e24-723d73c3a423@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxzr535gdkMctOAA--.16378S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Aw47tFW5JF1kGr1UAFW5Wrg_yoW8AFyxpr
        4v9FW3KFW2yF4Igws2qwnxKr45uw47J3WUCF47ur1UZF17J3W8JrsrJF4fArn8XrZ3JFyx
        ZFWDuw4F9ayDWw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bD8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq
        07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxV
        WUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0HqcUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/7 下午8:47, Krzysztof Kozlowski 写道:
> On 07/03/2023 12:50, Yinbo Zhu wrote:
>> The Loongson-2 boot clock was used to spi and lio peripheral and
>> this patch was to add boot clock index number.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
> This is v13? Where is the changelog then?

in fact, this is a new patch(v1),   but another clock driver patch in 
this series had send as v13 and need depend on

this patch so set current patch as v13.

>
>
>>   include/dt-bindings/clock/loongson,ls2k-clk.h | 25 ++++++++++---------
>>   1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/dt-bindings/clock/loongson,ls2k-clk.h b/include/dt-bindings/clock/loongson,ls2k-clk.h
>> index db1e27e792ff1..e86804365e506 100644
>> --- a/include/dt-bindings/clock/loongson,ls2k-clk.h
>> +++ b/include/dt-bindings/clock/loongson,ls2k-clk.h
>> @@ -13,17 +13,18 @@
>>   #define LOONGSON2_DC_PLL				3
>>   #define LOONGSON2_PIX0_PLL				4
>>   #define LOONGSON2_PIX1_PLL				5
>> -#define LOONGSON2_NODE_CLK				6
>> -#define LOONGSON2_HDA_CLK				7
>> -#define LOONGSON2_GPU_CLK				8
>> -#define LOONGSON2_DDR_CLK				9
>> -#define LOONGSON2_GMAC_CLK				10
>> -#define LOONGSON2_DC_CLK				11
>> -#define LOONGSON2_APB_CLK				12
>> -#define LOONGSON2_USB_CLK				13
>> -#define LOONGSON2_SATA_CLK				14
>> -#define LOONGSON2_PIX0_CLK				15
>> -#define LOONGSON2_PIX1_CLK				16
>> -#define LOONGSON2_CLK_END				17
>> +#define LOONGSON2_BOOT_CLK				6
> That's an ABI break and commit msg does not explain it.
you meaning is that need add a explanation in commit msg that why

LOONGSON2_BOOT_CLK was added after LOONGSON2_PIX1_PLL and not add it in ending, right?

>
>> +#define LOONGSON2_NODE_CLK				7
>
>
> Best regards,
> Krzysztof

