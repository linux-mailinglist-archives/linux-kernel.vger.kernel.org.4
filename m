Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2986B18DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCIBnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCIBnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:43:14 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 034381F4A2;
        Wed,  8 Mar 2023 17:43:09 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8CxxtisOQlkIiwKAA--.13589S3;
        Thu, 09 Mar 2023 09:43:08 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxG76pOQlkAgtQAA--.7026S3;
        Thu, 09 Mar 2023 09:43:07 +0800 (CST)
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
 <5e9b3bd5-d885-6237-5e14-2becb3c956cc@loongson.cn>
 <31e2a67a-c046-9501-80de-e754ed450195@linaro.org>
 <ace5159b-ebbd-7805-518c-ed3d39e4793e@loongson.cn>
 <b2f9cd15-b303-882a-d4e0-36d1f6d155a8@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <eca81d44-2513-8002-980d-755af32f36c4@loongson.cn>
Date:   Thu, 9 Mar 2023 09:43:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b2f9cd15-b303-882a-d4e0-36d1f6d155a8@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxG76pOQlkAgtQAA--.7026S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tw17Aw13tF1kJFy7uFyxAFb_yoW8XFy7pw
        4xt3WqgFWDJr4xZw1xt3Z5Wr95C3s7Gr15JFn5Gw4kXr1qv3WxKFs7tF4fCF98Aw4xC3ZF
        gFWUua4kCa1Y9w7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bf8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
        AKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU8rnY7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/8 下午6:38, Krzysztof Kozlowski 写道:
> On 08/03/2023 10:24, zhuyinbo wrote:
>>>>> That's an ABI break and commit msg does not explain it.
>>>> you meaning is that need add a explanation in commit msg that why
>>> You need good explanation to break the ABI. I don't understand the
>>> commit msg, but anyway I could not find there justification for ABI
>>> break. If you do not have good justification, don't break the ABI,
>> The commit msg is the patch commit  log,  and I maybe not got it about
>> break the ABI.  You said about "break the ABI"
>>
>> is whether is location issue about "LOONGSON2_BOOT_CLK"?   if yes,   the
>> LOONGSON2_BOOT_CLK was placed
>>
>> after LOONGSON2_PIX1_PLL that is due to their clock parent is same.
>> and I whether need add this explanation
>>
>> in patch commit log description?
> Unfortunately I do not understand single thing from this.
>
> Best regards,
> Krzysztof

The patch commit log description is patch desription.  as follows:


commit 592bc2b4106d787ea166ba16bfde6b3101ab1a8a
Author: Yinbo Zhu <zhuyinbo@loongson.cn>
Date:   Tue Mar 7 17:18:32 2023 +0800

     dt-bindings: clock: add loongson-2 boot clock index

     The Loongson-2 boot clock was used to spi and lio peripheral and
     this patch was to add boot clock index number.


and your advice is "That's an ABI break and commit msg does not explain it."

I got it  from your advice that was to add a explanation about 
LOONGSON2_BOOT_CLK's

location issue in patch description, right?

