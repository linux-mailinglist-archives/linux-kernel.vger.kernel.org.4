Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA5B61F2A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiKGMND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiKGMNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:13:01 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BEBE26F3;
        Mon,  7 Nov 2022 04:12:59 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8AxHLZI9mhj0wcFAA--.4655S3;
        Mon, 07 Nov 2022 20:12:56 +0800 (CST)
Received: from [10.20.42.77] (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPuBI9mhju3AOAA--.40359S3;
        Mon, 07 Nov 2022 20:12:56 +0800 (CST)
Subject: Re: [PATCH 2/2] dt-bindings: interrupt-controller: add yaml for
 LoongArch CPU interrupt controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107023404.26730-1-liupeibao@loongson.cn>
 <20221107023404.26730-2-liupeibao@loongson.cn>
 <b45b8cf8-de9d-7132-1a35-48deeb4b79d5@linaro.org>
 <196e80d8-f4fb-7393-81a5-bca757c805f5@loongson.cn>
 <e92beaac-aa88-0336-cb30-7de438de67c9@linaro.org>
 <e5910bf9-b662-a733-57f2-5faccb038cb1@loongson.cn>
 <9bcefe53-5ac8-5265-a0ac-83cdd69798eb@linaro.org>
From:   Liu Peibao <liupeibao@loongson.cn>
Message-ID: <37f77670-f8c3-5fbf-c84f-eeaa85107c5a@loongson.cn>
Date:   Mon, 7 Nov 2022 20:12:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9bcefe53-5ac8-5265-a0ac-83cdd69798eb@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxPuBI9mhju3AOAA--.40359S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQADCmNno+QOXQAFsd
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cw47Ww4DAw48uFy5Xr1kXwb_yoW8XFy3pa
        yUZasrCF48tF1rGw1qqayrWF4jv3yxKFyaq3ZYyr1kCrnFgFy7XF4FkFWruFWrWryxJw4j
        qr40gw1xXFsrZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bakYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1l
        x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
        v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
        x2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
        yTuYvjxUcVc_UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 7:33 PM, Krzysztof Kozlowski wrote:
>>>>>> +    const: loongarch,cpu-interrupt-controller
>>>>>
>>>>> You have exactly one and only one type of CPU interrupt controller for
>>>>> all your Loongarch designs? All current and all future? All?
>>>>>
>>>>
>>>> It is sure of that "all current and recent designs". It is really hard to limit the
>>>> design in the distant future.
>>>>
>>>> And if there is updating, maybe I will add additional things like this:
>>>> "loongarch,cpu-interrupt-controller-2.0".
>>>
>>> Unless you have a clear versioning of your hardware, adding 2.0 won't be
>>> correct. Don't you have this for specific SoC?
>>>
>>
>> The "loongarch,cpu-interrupt-controller" now is compatible for all the LoongArch
>> compatible CPUs, not specific for one chip. And we may keep this CPU interrupt
>> controller for a long time.
> 
> Still specific compatibles (as fallbacks) are used for such cases, so
> why is this different? Hardware compatible with several other devices
> still gets specific compatible, right?
>

I don't really agree with that. This is a specified higher level abstract of all
our designed hardware. We could do this as we have unified this in hardware. So
this compatible could be simple.
 
> You cannot have "-2.0" suffix in the future just because "you want", so
> be sure that your choice is reasonable.
> 

It was an example and the CPUs IRQs hardware updating is not on our schedule.
If I do some thing like "-2.0" in the future, I will find a proper way and
be reasonable.

BR,
Peibao

