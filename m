Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37F4604069
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiJSJyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbiJSJyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:54:05 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0351F2A260;
        Wed, 19 Oct 2022 02:29:44 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8CxKdjwuk9jm7AAAA--.1747S3;
        Wed, 19 Oct 2022 16:53:04 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxn+Dtuk9jWjcBAA--.5047S2;
        Wed, 19 Oct 2022 16:53:03 +0800 (CST)
Subject: Re: [PATCH v7 2/2] dt-bindings: thermal: add loongson2k thermal
 binding
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        zhuyinbo@loongson.cn
References: <20220930021054.22387-1-zhuyinbo@loongson.cn>
 <20220930021054.22387-2-zhuyinbo@loongson.cn>
 <21717466-63f9-09b0-e666-61b98ab808f4@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <48b246c7-2af0-9d0d-3252-274b369af703@loongson.cn>
Date:   Wed, 19 Oct 2022 16:53:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <21717466-63f9-09b0-e666-61b98ab808f4@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxn+Dtuk9jWjcBAA--.5047S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZrW7Kr4xKFWUZrWDCF4Durg_yoW5CrW3pF
        4xCFyDAFyvkF1fAw4akFyUCFZ0yr18tasrAr4xW3W5tr9xJa4aqr4jgr1q9395Wr48WFW7
        Zr17ur4Uur1DJrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7
        AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280
        aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjjgxUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/14 上午11:47, Yinbo Zhu 写道:
> Hi thermal maintainer
> 
> Are there any other suggestions about this patch? If not, please help
> merge this patch to upstream.
> 
> RRs
> Yinbo

Any updates?

> 在 2022/9/30 上午10:10, Yinbo Zhu 写道:
>> Add the loongson2k thermal binding with DT schema format using
>> json-schema.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>> Change in v7:
>>         1. Split the modification of patch 3 and merge it into this 
>> patch.
>>
>>   .../thermal/loongson,ls2k-thermal.yaml        | 43 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 44 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml 
>> b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
>> new file mode 100644
>> index 000000000000..12f54076bdd1
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
>> @@ -0,0 +1,43 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/loongson,ls2k-thermal.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Thermal sensors on loongson2k SoCs
>> +
>> +maintainers:
>> +  - zhanghongchen <zhanghongchen@loongson.cn>
>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>> +
>> +properties:
>> +  compatible:
>> +    const: loongson,ls2k-thermal
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  '#thermal-sensor-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - '#thermal-sensor-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    thermal: thermal-sensor@1fe01500 {
>> +        compatible = "loongson,ls2k-thermal";
>> +        reg = <0x1fe01500 0x30>;
>> +        interrupt-parent = <&liointc0>;
>> +        interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
>> +        #thermal-sensor-cells = <1>;
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2efbd5b158b9..0be0f520c032 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11904,6 +11904,7 @@ M:    zhanghongchen <zhanghongchen@loongson.cn>
>>   M:    Yinbo Zhu <zhuyinbo@loongson.cn>
>>   L:    linux-pm@vger.kernel.org
>>   S:    Maintained
>> +F:    
>> Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
>>   F:    drivers/thermal/loongson2_thermal.c
>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SP
> 
>>

