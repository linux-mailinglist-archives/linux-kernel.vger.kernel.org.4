Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7AD72E3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbjFMNEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242575AbjFMNDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:03:53 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 470A11BC3;
        Tue, 13 Jun 2023 06:03:50 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.22])
        by gateway (Coremail) with SMTP id _____8AxW+o1aYhkhaYEAA--.9900S3;
        Tue, 13 Jun 2023 21:03:49 +0800 (CST)
Received: from [10.180.13.22] (unknown [10.180.13.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axfco0aYhkZTEZAA--.63228S3;
        Tue, 13 Jun 2023 21:03:48 +0800 (CST)
Message-ID: <58b70e1b-d292-ec45-2309-e237a4a43d0d@loongson.cn>
Date:   Tue, 13 Jun 2023 21:03:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [ PATCH v2 3/3] ASoC: dt-bindings: Add support for Loongson audio
 card
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
References: <20230612085614.3039498-1-mengyingkun@loongson.cn>
 <20230612-booted-french-186dd95e78a9@spud>
 <bda7c25f-65cf-d45f-3ac0-f2471e3aacf8@loongson.cn>
 <20230613-zoologist-panorama-a87858bba075@wendy>
 <887f9cc4-6457-9d14-8aef-011ff4c9aeda@loongson.cn>
 <20230613-depletion-garnet-ccc2009111c3@wendy>
From:   Yingkun Meng <mengyingkun@loongson.cn>
In-Reply-To: <20230613-depletion-garnet-ccc2009111c3@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axfco0aYhkZTEZAA--.63228S3
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQABDGSIXIIBbgABsQ
X-Coremail-Antispam: 1Uk129KBj93XoW7tF1kWF1DKr4DAF47uFykZwc_yoW8uw1fpF
        W8Ja47KFn5Kw15Cr9Yvw18Jr42vFWftFZxXr4DXr17G390gry3Gr13tF1Fk3srCr18X342
        vFWFka47J3Z8JagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwCFI7km07C267AKxVW8ZVWrXwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jF4E_UUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/13 20:46, Conor Dooley wrote:
> On Tue, Jun 13, 2023 at 08:38:59PM +0800, Yingkun Meng wrote:
>> On 2023/6/13 20:28, Conor Dooley wrote:
>>> On Tue, Jun 13, 2023 at 08:23:58PM +0800, Yingkun Meng wrote:
>>>> On 2023/6/13 01:24, Conor Dooley wrote:
>>>>> On Mon, Jun 12, 2023 at 04:56:14PM +0800, YingKun Meng wrote:
>>>>>> From: Yingkun Meng <mengyingkun@loongson.cn>
>>>>>>
>>>>>> The audio card uses loongson I2S controller present in
>>>>>> 7axxx/2kxxx chips to transfer audio data.
>>>>>>
>>>>>> On loongson platform, the chip has only one I2S controller.
>>>>>> +description:
>>>>>> +  The binding describes the sound card present in loongson
>>>>>> +  7axxx/2kxxx platform. The sound card is an ASoC component
>>>>>> +  which uses Loongson I2S controller to transfer the audio data.
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    const: loongson,ls-audio-card
>>>>> Reviewing sound stuff is beyond my pay grade, so forgive me if I am off
>>>>> the rails here, but this (and the "x"s in the description) look a bit
>>>>> odd. Recently, we've noticed quite a few loongson dt-bindings attempting
>>>>> to use a single compatible for many different chips.
>>>>> Usually you have individual compatibles for the various SoCs with this
>>>>> core, which can fall back to a generic one, rather than just adding a
>>>>> generic compatible for all devices.
>>>>> As far as I know, there's several SoCs fitting 2kxxx, and the format
>>>>> being used elsewhere is "loongson,ls2k1000" etc.
>>>> Currently, Loongson has 2K0500/2K1000LA/2K1500/2K2000 chips.
>>>>
>>>> Here, its' possible to use a single compatible for different chips,
>>>>
>>>> as the audio device is a logical device, not dependent on chip model.
>>> What, may I ask, is a "logical device"?
>>
>> I means it's not a physical one, like "platform bus".
> So it is entirely a software construct? Why does it need a dt-binding
> then? Your commit message says the controller is present on the device!

It's not. The audio device consists of an i2s controller and codec.

The dt-binding is for the audio device, not for i2s controller.

> Confused,
> Conor.

