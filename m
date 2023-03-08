Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01FE6B02D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCHJZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCHJYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:24:51 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 384D79DE33;
        Wed,  8 Mar 2023 01:24:30 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxMI9NVAhk1c8JAA--.12949S3;
        Wed, 08 Mar 2023 17:24:29 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax+71KVAhkbDlPAA--.6030S3;
        Wed, 08 Mar 2023 17:24:28 +0800 (CST)
Subject: Re: [PATCH v13 1/2] dt-bindings: clock: add loongson-2 boot clock
 index
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, zhuyinbo@loongson.cn,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
References: <20230307115022.12846-1-zhuyinbo@loongson.cn>
 <692a62da-a9a1-fa23-6e24-723d73c3a423@linaro.org>
 <5e9b3bd5-d885-6237-5e14-2becb3c956cc@loongson.cn>
 <31e2a67a-c046-9501-80de-e754ed450195@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <ace5159b-ebbd-7805-518c-ed3d39e4793e@loongson.cn>
Date:   Wed, 8 Mar 2023 17:24:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <31e2a67a-c046-9501-80de-e754ed450195@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Ax+71KVAhkbDlPAA--.6030S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAw48ArW7CFy7WF4kGr43trb_yoW5Gry8pr
        4vgFsxKFW2yF4xKw4IqwnxKr1Y9w4xJr1UAF4Uur1UXr17Xwn5tFs7JF4fur90grWxJFyx
        ZFWq9w4Fva1DZwUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
        AKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07j5HUDUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/8 下午4:37, Krzysztof Kozlowski 写道:
> On 08/03/2023 02:35, zhuyinbo wrote:
>> 在 2023/3/7 下午8:47, Krzysztof Kozlowski 写道:
>>> On 07/03/2023 12:50, Yinbo Zhu wrote:
>>>> The Loongson-2 boot clock was used to spi and lio peripheral and
>>>> this patch was to add boot clock index number.
>>>>
>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>> ---
>>> This is v13? Where is the changelog then?
>> in fact, this is a new patch(v1),   but another clock driver patch in
>> this series had send as v13 and need depend on
>>
>> this patch so set current patch as v13.
> This should be explained in changelog.

okay I got it , and I whether need resend a v14 patch that in order to  
add this explain in changelog ?

>
>>>
>>>>    include/dt-bindings/clock/loongson,ls2k-clk.h | 25 ++++++++++---------
>>>>    1 file changed, 13 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/include/dt-bindings/clock/loongson,ls2k-clk.h b/include/dt-bindings/clock/loongson,ls2k-clk.h
>>>> index db1e27e792ff1..e86804365e506 100644
>>>> --- a/include/dt-bindings/clock/loongson,ls2k-clk.h
>>>> +++ b/include/dt-bindings/clock/loongson,ls2k-clk.h
>>>> @@ -13,17 +13,18 @@
>>>>    #define LOONGSON2_DC_PLL				3
>>>>    #define LOONGSON2_PIX0_PLL				4
>>>>    #define LOONGSON2_PIX1_PLL				5
>>>> -#define LOONGSON2_NODE_CLK				6
>>>> -#define LOONGSON2_HDA_CLK				7
>>>> -#define LOONGSON2_GPU_CLK				8
>>>> -#define LOONGSON2_DDR_CLK				9
>>>> -#define LOONGSON2_GMAC_CLK				10
>>>> -#define LOONGSON2_DC_CLK				11
>>>> -#define LOONGSON2_APB_CLK				12
>>>> -#define LOONGSON2_USB_CLK				13
>>>> -#define LOONGSON2_SATA_CLK				14
>>>> -#define LOONGSON2_PIX0_CLK				15
>>>> -#define LOONGSON2_PIX1_CLK				16
>>>> -#define LOONGSON2_CLK_END				17
>>>> +#define LOONGSON2_BOOT_CLK				6
>>> That's an ABI break and commit msg does not explain it.
>> you meaning is that need add a explanation in commit msg that why
> You need good explanation to break the ABI. I don't understand the
> commit msg, but anyway I could not find there justification for ABI
> break. If you do not have good justification, don't break the ABI,

The commit msg is the patch commit  log,  and I maybe not got it about 
break the ABI.  You said about "break the ABI"

is whether is location issue about "LOONGSON2_BOOT_CLK"?   if yes,   the 
LOONGSON2_BOOT_CLK was placed

after LOONGSON2_PIX1_PLL that is due to their clock parent is same.     
and I whether need add this explanation

in patch commit log description?

>
>
>
> Best regards,
> Krzysztof

