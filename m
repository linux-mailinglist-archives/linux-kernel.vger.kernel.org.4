Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F4D70D251
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjEWDWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjEWDWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:22:31 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51EE8B6;
        Mon, 22 May 2023 20:22:29 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxI_B0MWxkficLAA--.18907S3;
        Tue, 23 May 2023 11:22:28 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHuRwMWxkvdtvAA--.57042S3;
        Tue, 23 May 2023 11:22:25 +0800 (CST)
Subject: Re: [PATCH v2 2/3] dt-bindings: soc: add loongson-2 pm
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Baoqi Zhang <zhangbaoqi@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, Yun Liu <liuyun@loongson.cn>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230522093156.7108-1-zhuyinbo@loongson.cn>
 <20230522093156.7108-3-zhuyinbo@loongson.cn>
 <20230522-kooky-outbid-82662b45d305@wendy>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <d88c0965-8f72-7be1-b67f-1bcf3be60da3@loongson.cn>
Date:   Tue, 23 May 2023 11:22:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230522-kooky-outbid-82662b45d305@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHuRwMWxkvdtvAA--.57042S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr45tr1fWw1xZF17WrWkXrb_yoW5tr1fpa
        n7Ca1Ykr48ZF13uws5JFy8Aw1Y9rZakFsrXFZrJry0kr98u3WFq3y7KF98ZFW3ArykGFW2
        vFyIgw4jgF4DCFJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYnmiUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/22 下午8:47, Conor Dooley 写道:
> Hey!
> 
> On Mon, May 22, 2023 at 05:31:55PM +0800, Yinbo Zhu wrote:
>> Add the Loongson-2 SoC Power Management Controller binding with DT
>> schema format using json-schema.
> 
> Grabbing thread from lore.kernel.org/all/20230522093156.7108-3-zhuyinbo%40loongson.cn/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 3 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>    [PATCH v2 1/3] loongarch: export loongarch pm interface
>      + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>    [PATCH v2 2/3] dt-bindings: soc: add loongson-2 pm
>      + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>    ERROR: missing [3/3]!
> ---
> Total patches: 2
> ---
> WARNING: Thread incomplete!
> Applying: loongarch: export loongarch pm interface
> Applying: dt-bindings: soc: add loongson-2 pm
> 
> Looks like the user for these bindings got lost somewhere along the way?
> Please make sure to keep a series threaded.

okay, I got it.  I will use a thread to send a series patch.

> 
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   .../soc/loongson/loongson,ls2k-pmc.yaml       | 51 +++++++++++++++++++
>>   MAINTAINERS                                   |  6 +++
>>   2 files changed, 57 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
>> new file mode 100644
>> index 000000000000..ddad62889c60
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/loongson/loongson,ls2k-pmc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Loongson-2 Power Manager controller
>> +
>> +maintainers:
>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - loongson,ls2k-pmc
>> +      - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  suspend-address:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      The "suspend-address" is a deep sleep state (Suspend To RAM)
>> +      firmware entry address which was jumped from kernel and it's
>> +      value was dependent on specific platform firmware code. In
>> +      addition, the PM need according to it to indicate that current
>> +      SoC whether support Suspend To RAM.
> 
> I (still) think this property is rather odd, maybe I am just not really
> understanding the property as it seems to be described partly in terms
> of operating system behaviour rather than its actual function. "was
> jumped from kernel" I don't get.

The function Suspend-To-RAM include kernel logic and firmware logic and
if no define "suspend-address" that kernel will can't into firmware 
after suspend to ram and the Suspend-To-RAM function will not be 
finished in LoongArch.


> 
> The whole setup here seems a bit odd, but that's for the loongson arch
> folks reviewing the actual code to comment on!

okay, I got it.

Thanks
Yinbo.
> 
> Thanks,
> Conor.
> 

