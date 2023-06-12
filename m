Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2563472B56F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 04:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjFLCb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 22:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjFLCb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:31:26 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 996FCC5;
        Sun, 11 Jun 2023 19:31:23 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.22])
        by gateway (Coremail) with SMTP id _____8AxGup6g4ZkqWIDAA--.7455S3;
        Mon, 12 Jun 2023 10:31:22 +0800 (CST)
Received: from [10.180.13.22] (unknown [10.180.13.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx+OR4g4ZkrcMUAA--.59923S3;
        Mon, 12 Jun 2023 10:31:20 +0800 (CST)
Message-ID: <78ba489e-9391-ac05-2c25-c0210f61b7ed@loongson.cn>
Date:   Mon, 12 Jun 2023 10:30:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: Add support for Loongson audio
 card
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230605120934.2306548-1-mengyingkun@loongson.cn>
 <20230605120934.2306548-3-mengyingkun@loongson.cn>
 <118d13ef-a247-cf88-5084-afdebc6b7651@kernel.org>
From:   Yingkun Meng <mengyingkun@loongson.cn>
In-Reply-To: <118d13ef-a247-cf88-5084-afdebc6b7651@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx+OR4g4ZkrcMUAA--.59923S3
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQAADGSFuYED8wABsl
X-Coremail-Antispam: 1Uk129KBj93XoWxZw43CF4rtF48tw18uF13KFX_yoW5Zw1xpa
        s5Ca12kFW8t3W7C3yrZ3W8Aw45X39ayanxtF42qw1UGFZ093WFgw4ak3Wj9a4Yyrn5Kay7
        Za45Wa4xGa1qyagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8CksDUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your kindly work.


On 2023/6/5 22:45, Krzysztof Kozlowski wrote:
> On 05/06/2023 14:09, YingKun Meng wrote:
>> From: Yingkun Meng <mengyingkun@loongson.cn>
>>
>> The audio card uses loongson I2S controller present in 7axxx/2kxxx chips
>> to transfer audio data.
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
>
> You missed at least DT list (maybe more), so this won't be tested.
> Please resend and include all necessary entries.
>

Sorry for my mistake. Fixed in new version.

>> Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
>> ---
>>   .../sound/loongson,ls-audio-card.yaml         | 64 +++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml b/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
>> new file mode 100644
>> index 000000000000..f1d6ee346bb3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
>> @@ -0,0 +1,64 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/loongson-audio-card.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Loongson generic ASoC audio sound card.
> What is a "generic audio card"? Does it even match hardware? Bindings
> are supposed to describe hardware, which is usually very specific.
>
> Also: Drop full stop. It's a title.
>
On loongson platform, the I2S controllers connect different codecs to
form different audio devices that can be driven by the same machine driver.
The "generic audio card" refers to these audio devices.

Currently, it can match some specific hardware, such as
2k2000 + es8323: the 2k2000 is a loogson SoC with a I2S controller
7a2000 + es8288: the 7a2000 is a bridge chip with a I2S controller


>> +
>> +maintainers:
>> +  - Yingkun Meng <mengyingkun@loongson.cn>
>> +
>> +description:
>> +  Generic ASoC audio device for loongson platform.
>> +
>> +properties:
>> +  compatible:
>> +    const: loongson,ls-audio-card
>> +
>> +  model:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: User specified audio sound card name
>> +
>> +  mclk-fs:
>> +    $ref: simple-card.yaml#/definitions/mclk-fs
>> +
>> +  cpu:
>> +    description: Holds subnode which indicates cpu dai.
>> +    type: object
>> +    additionalProperties: false
>> +    properties:
>> +      sound-dai:
>> +        maxItems: 1
> In the cpu: required with sound-dai


OK.

>> +
>> +  codec:
>> +    description: Holds subnode which indicates codec dai.
>> +    type: object
>> +    additionalProperties: false
>> +    properties:
>> +      sound-dai:
>> +        maxItems: 1
> In the codec: required with sound-dai
>
> No multiple dai links? Are you sure this card is so limited?


Yes.  The audio device has only one channel.

>
> Best regards,
> Krzysztof


Thanks,

Yingkun Meng

