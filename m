Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7FC6BE620
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCQKAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCQKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:00:07 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6762C49891;
        Fri, 17 Mar 2023 03:00:04 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxYcwiOhRkt1QNAA--.19364S3;
        Fri, 17 Mar 2023 18:00:02 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHuQgOhRk04oDAA--.15428S3;
        Fri, 17 Mar 2023 18:00:00 +0800 (CST)
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add loongson spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
 <20230317082950.12738-2-zhuyinbo@loongson.cn>
 <a736c6db-466a-12e4-8e22-c8dc900978d4@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <e944732b-9a2d-b6ff-8336-7363788809b9@loongson.cn>
Date:   Fri, 17 Mar 2023 18:00:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a736c6db-466a-12e4-8e22-c8dc900978d4@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxHuQgOhRk04oDAA--.15428S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ur4ktF47Cr17GFyxCryfJFb_yoW8Xw1xpF
        1xCFs3GFWjqF17Jwsaga48GwsxZr95JFnrJF47t347CF9093WFqF43KryUZw43AF18GFW2
        vFyjgr4UKF4UAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bx8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz4
        8v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8pnQUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/17 下午5:15, Krzysztof Kozlowski 写道:
> On 17/03/2023 09:29, Yinbo Zhu wrote:
>> Add the Loongson platform spi binding with DT schema format using
>> json-schema.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   .../bindings/spi/loongson,ls-spi.yaml         | 44 +++++++++++++++++++
>>   MAINTAINERS                                   |  6 +++
>>   2 files changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>> new file mode 100644
>> index 000000000000..936b8dc82ce8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +
> Drop blank line above.
>
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/loongson,ls-spi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
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
>> +    enum:
>> +      - loongson,ls2k-spi
>> +      - loongson,ls7a-spi
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 1
> I don't understand why did you change it. I did not ask for it.
>
> Best regards,
> Krzysztof
Add clocks "minItems: 1" description is for fix yaml file compile issue.

