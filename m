Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E015ED7AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiI1I0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiI1I0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:26:45 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A74B671BFF;
        Wed, 28 Sep 2022 01:26:43 -0700 (PDT)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxYOI9BTRjKzIjAA--.1292S2;
        Wed, 28 Sep 2022 16:26:37 +0800 (CST)
Subject: Re: [PATCH v4 2/3] dt-bindings: thermal: add loongson2k thermal
 binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, zhuyinbo@loongson.cn
References: <20220928031628.6463-1-zhuyinbo@loongson.cn>
 <20220928031628.6463-2-zhuyinbo@loongson.cn>
 <1b2d1e4f-6b95-cf20-8c2d-f87a91ae599c@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <c6b15f31-06e1-81e8-9e4f-5a2b8a704096@loongson.cn>
Date:   Wed, 28 Sep 2022 16:26:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1b2d1e4f-6b95-cf20-8c2d-f87a91ae599c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxYOI9BTRjKzIjAA--.1292S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4kAry8ZrWrAF18Xw45trb_yoWkCrb_AF
        129wn7Zwn7ArsIgwn3Zr1fK3s3Kay8Xw15JFWkt34xZ34FvayUuF10yr1SqayfJw4kCF43
        CryrWw1Ykw4UWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb-AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/28 下午4:01, Krzysztof Kozlowski 写道:
> On 28/09/2022 05:16, Yinbo Zhu wrote:
>> Add the loongson2k thermal binding with DT schema format using
>> json-schema.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +$id: http://devicetree.org/schemas/thermal/loongson,ls2k-thermal.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Thermal sensors on loongson2k SoCs
>> +
>> +maintainers:
>> +  - zhanghongchen <zhanghongchen@loongson.cn>
>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>> +
>> +properties:
>> +  compatible:
>> +    const: loongson,ls2k-thermal
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  "#thermal-sensor-cells":
> 
> Use same quotes in all places - either ' or "
Thanks for reminding me, I will fix it.
> 
>> +    const: 1> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - '#thermal-sensor-cells'
> 
> With quotes fixed:
I will use "'" uniformly.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

