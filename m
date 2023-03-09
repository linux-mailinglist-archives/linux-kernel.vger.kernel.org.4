Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7076B190F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 03:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCICJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 21:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCICJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 21:09:09 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2489899C24;
        Wed,  8 Mar 2023 18:09:01 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Cxidm8PwlkPS4KAA--.1825S3;
        Thu, 09 Mar 2023 10:09:00 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxK763Pwlkqw5QAA--.7739S3;
        Thu, 09 Mar 2023 10:08:57 +0800 (CST)
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: add loongson spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230308025908.21491-1-zhuyinbo@loongson.cn>
 <20230308025908.21491-2-zhuyinbo@loongson.cn>
 <8d20dcfb-480b-3f1a-02b0-294a05a566f7@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <dd2e6c68-7460-caa1-0d54-53aeb5619a18@loongson.cn>
Date:   Thu, 9 Mar 2023 10:08:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8d20dcfb-480b-3f1a-02b0-294a05a566f7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxK763Pwlkqw5QAA--.7739S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxur4fGF1UZr47WF13uFW5Awb_yoW5ZrWrpF
        y7CFs7tF4jgF1xX393ta48Cws3ZryrJ3W7JFW2q342kFyq93WFvF4agr98ZF4xAF48WFZx
        ZFy7Kr4Ygr1UXrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0HqcUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/8 下午7:30, Krzysztof Kozlowski 写道:
> On 08/03/2023 03:59, Yinbo Zhu wrote:
>> Add the Loongson platform spi binding with DT schema format using
>> json-schema.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   .../bindings/spi/loongson,ls-spi.yaml         | 47 +++++++++++++++++++
>>   MAINTAINERS                                   |  6 +++
>>   2 files changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
> Filename matching the compatible.

loongson,ls-spi.yaml is for ls2k-spi and ls7a-spi, I will add following 
desription:


properties:
   compatible:
     enum:
       - loongson,ls2k-spi
       - loongson,ls7a-spi
>
>> diff --git a/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>> new file mode 100644
>> index 000000000000..8a13a96b3818
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/spi/loongson,ls-spi.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> Drop the quotes. What was the base of your code here?

okay, I will drop the quotes.    and I don't got it  about the code base 
that you said.

you meaning is advice me add a line  as follows ?

allOf:
   - $ref: /schemas/spi/spi-controller.yaml#

>
>> +
>> +title: Loongson SPI controller
>> +
>> +maintainers:
>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: loongson,ls2k-spi
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: boot
> Drop clock-names, not needed for single entry.

if drop the clock-names entry, the yaml file will compile fail.


root@user-pc:/home/user/workspace/test/code/www.kernel.org/linux# make 
DT_CHECKER_FLAGS=-m dt_binding_check 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
   LINT    Documentation/devicetree/bindings
   CHKDT   Documentation/devicetree/bindings/processed-schema.json
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   DTEX Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dts
   DTC_CHK Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dtb
/home/user/workspace/test/code/www.kernel.org/linux/Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dtb: 
spi@1fff0220: Unevaluated properties are not allowed ('clock-names' was 
unexpected)
     From schema: 
/home/user/workspace/test/code/www.kernel.org/linux/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
root@user-pc:/home/user/workspace/test/code/www.kernel.org/linux#

>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +unevaluatedProperties: false
>
> Best regards,
> Krzysztof

