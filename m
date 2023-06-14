Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F92572F901
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbjFNJ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjFNJ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:26:15 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 039671FC3;
        Wed, 14 Jun 2023 02:26:13 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.22])
        by gateway (Coremail) with SMTP id _____8AxnOq0h4lkwxEFAA--.10690S3;
        Wed, 14 Jun 2023 17:26:12 +0800 (CST)
Received: from [10.180.13.22] (unknown [10.180.13.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxJeSzh4lkDnEaAA--.10205S3;
        Wed, 14 Jun 2023 17:26:11 +0800 (CST)
Message-ID: <75be5e57-28a7-bf3f-8b2e-a0183e54e25c@loongson.cn>
Date:   Wed, 14 Jun 2023 17:25:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [ PATCH v2 3/3] ASoC: dt-bindings: Add support for Loongson audio
 card
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
References: <20230612090058.3039546-1-mengyingkun@loongson.cn>
 <4f1c934c-5a68-a2cd-10d1-568d61865755@linaro.org>
From:   Yingkun Meng <mengyingkun@loongson.cn>
In-Reply-To: <4f1c934c-5a68-a2cd-10d1-568d61865755@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxJeSzh4lkDnEaAA--.10205S3
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQACDGSIXIIX-wABsU
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr4xAryDCrW3WrW3AF48Zrc_yoW8CrWrpF
        s7CasrKFWxt3W7u39I9FyfJr45Z39ayanxJF42qw1UGF98K3Wru3yayF1UZanIyr1rGFW7
        ZFyF9w48GFn0yacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
        WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUU
        U==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/13 16:36, Krzysztof Kozlowski wrote:
> On 12/06/2023 11:00, YingKun Meng wrote:
>> From: Yingkun Meng <mengyingkun@loongson.cn>
>>
>> The audio card uses loongson I2S controller present in
>> 7axxx/2kxxx chips to transfer audio data.
>>
>> On loongson platform, the chip has only one I2S controller.
>>
>> Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
>> ---
>>   .../sound/loongson,ls-audio-card.yaml         | 70 +++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml b/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
>> new file mode 100644
>> index 000000000000..61e8babed402
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
>> @@ -0,0 +1,70 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/loongson,ls-audio-card.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Loongson 7axxx/2kxxx ASoC audio sound card driver
>> +
>> +maintainers:
>> +  - Yingkun Meng <mengyingkun@loongson.cn>
>> +
>> +description:
>> +  The binding describes the sound card present in loongson
>> +  7axxx/2kxxx platform. The sound card is an ASoC component
>> +  which uses Loongson I2S controller to transfer the audio data.
>> +
>> +properties:
>> +  compatible:
>> +    const: loongson,ls-audio-card
> Generic compatible does not allow you to add any quirks or differences
> if one board is a bit different.
>

Yeah, i know. It's okay to use a generic compatible.

>
> Best regards,
> Krzysztof


Thanks,

Yingkun

