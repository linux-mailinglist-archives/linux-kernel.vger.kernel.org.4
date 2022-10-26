Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA00360DC05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiJZHWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJZHWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:22:18 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEE0E57BD1;
        Wed, 26 Oct 2022 00:22:14 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8AxDdkl4FhjTo0CAA--.9934S3;
        Wed, 26 Oct 2022 15:22:13 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxLeAh4FhjNzEFAA--.19404S2;
        Wed, 26 Oct 2022 15:22:09 +0800 (CST)
Subject: Re: [PATCH v2 2/2] dt-bindings: soc: add loongson2 guts
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        zhuyinbo@loongson.cn, Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221025035128.21068-1-zhuyinbo@loongson.cn>
 <20221025035128.21068-2-zhuyinbo@loongson.cn>
 <7c67c721-685a-fa0e-ab4b-41b7de3ea0a0@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <52de60bd-8aa5-a461-9bca-ce8e6f82ead8@loongson.cn>
Date:   Wed, 26 Oct 2022 15:22:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7c67c721-685a-fa0e-ab4b-41b7de3ea0a0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxLeAh4FhjNzEFAA--.19404S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFy7ZF43WF4UuFyUJF1rCrg_yoW5Kr13p3
        WxCFW5KFWvqF129wsIq3WxAF13urZ7C3WDWr9rJ3429FyDCasaqwsxKas8Za1xJr97WFW2
        9FW0g3yF9F4DAFJanT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUciL0UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/26 上午3:40, Krzysztof Kozlowski 写道:
> On 24/10/2022 23:51, Yinbo Zhu wrote:
>> Add the loongson2 soc guts driver binding with DT schema format
>> using json-schema.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   .../soc/loongson/loongson,ls2k-guts.yaml      | 37 +++++++++++++++++++
> 
> Looks like wrong location, although difficult to judge because you did
> not describe the hardware at all. If this is chipinfo-like device, then
> Documentation/devicetree/bindings/hwinfo/.
My guts driver is refer fsl platform. It was was to manage and access
global utilities register block for SoC and it was only used in SoC
platform. when driver need use Soc ops to do some function the this 
driver was needed.  the dcfg (device config) was a function in guts 
(global utilities) block.
For these type of driver, other platforms were initially placed on
Documentation/devicetree/bindings/arm/   if it is arm/arm64
architecture. Later, move it to the soc directory.

Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml

So, do you still think it is inappropriate to place it in the soc dir?
> 
> 
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 38 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
>> new file mode 100644
>> index 000000000000..2502f8aeb74d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/loongson/loongson,ls2k-guts.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Loongson2 GUTS driver.
> 
> Drop "driver." unless you refer to some hardware (like motor driver?).
this need refer hardware soc datasheet to gain soc register (global 
utilities register block ).
so keep "driver" string that whether was more appropriate?
> 
>> +
>> +maintainers:
>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>> +
>> +description: |
>> +  GUTS driver was to manage and access global utilities block. Initially
> 
> Drop "driver" and describe instead what is GUTS, including its acronym,
> 
>> +  only reading SVR and registering soc device are supported.
> 
> Entire sentence describe Linux driver - drop it. Instead describe the
> device, the hardware.
> 
>> +
>> +properties:
>> +  compatible:
>> +    const: loongson,ls2k-guts
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  little-endian: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    guts: guts@1fe00000 {
> 
> Node names should be generic.
dcfg/scfg (device cfg/ soc cfg)was the key function of guts (global 
utilities) block. and guts name I was refer fsl soc driver. 
"drivers/soc/fsl/guts.c"
this binding file was follows of fsl guts.
Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml

or, I was use scfg as node name, Do you think it's appropriate?


> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
> Best regards,
> Krzysztof
> 

