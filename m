Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B8071FA53
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjFBGrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjFBGrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:47:01 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7373E128;
        Thu,  1 Jun 2023 23:46:56 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Dxc_BekHlk0YgDAA--.7625S3;
        Fri, 02 Jun 2023 14:46:54 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx87BakHlk2nmFAA--.20371S3;
        Fri, 02 Jun 2023 14:46:50 +0800 (CST)
Subject: Re: [PATCH v11 1/2] dt-bindings: spi: add loongson spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <20230522071030.5193-2-zhuyinbo@loongson.cn>
 <20230524-pouncing-variable-c520e85f8db8@wendy>
 <b1e3d199-de5a-f8d5-9159-4965e9e1f5ef@loongson.cn>
 <20230524-relative-trimmer-046fb26a7764@wendy>
 <99b362c2-640c-9150-26ee-e9add4483886@loongson.cn>
 <2196dd29-93ee-00f7-65b4-ede73aa8ba77@linaro.org>
 <1b141df2-3e31-089e-1e05-0e268b60d074@loongson.cn>
 <25c30964-6bd3-c7eb-640a-ba1f513b7675@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <32af60eb-dc9d-1d3d-3357-4ec7234bd8a2@loongson.cn>
Date:   Fri, 2 Jun 2023 14:46:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <25c30964-6bd3-c7eb-640a-ba1f513b7675@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx87BakHlk2nmFAA--.20371S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAFyxKw1Dur17JrWxCFWruFg_yoWrGF13pa
        yDCFWDKF13JF1xA34Dta48ZFWjv34ftFWDXF15J34UC390qF1Yqr4IkFs8u3ZrWr1xWFWx
        XF1IgrW7t3WUZFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bf8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
        AKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU8rnY7UUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/1 下午11:30, Krzysztof Kozlowski 写道:
> On 01/06/2023 11:51, zhuyinbo wrote:
>>>> Yes, it is make sense as it can reduce the workload of the community.
>>>> For the Loongson platform, the versions of spi peripherals are almost
>>>> the same, except for a few  or individual SoCs.  And we have also
>>>> discussed compatible internally, and we tend to define it this way.
>>>
>>> So you have chosen different path than what's clearly recommended by
>>> community, existing experience and documentation:
>>>
>>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
>>>
>>> Family names are not accepted as specific compatibles. Whenever they
>>> were accepted, it lead to problems. All the time.
>>
>>
>> Thank you for your documentation and advice and the Loongson platform
>> have loongson-2h (ls2h), loongson-2k (ls2k), loongson-2p (ls2p) or other
>> series SoC, which loongson-2 seems to be the family name you mentioned
>> and the "loongson,ls2k-spi" should be a speific compatible name.
>>
>>>
>>> https://lore.kernel.org/all/20220822181701.GA89665-robh@kernel.org/
>>> https://lore.kernel.org/all/78651e07-6b3e-4243-8e1f-fcd1dfb3ffe1@www.fastmail.com/
>>> https://lore.kernel.org/all/288f56ba9cfad46354203b7698babe91@walle.cc/
>>> https://lore.kernel.org/all/106e443a-e765-51fe-b556-e4e7e2aa771c@linaro.org/
>>> and many many more discussions.
>>>
>>> You should choose carefully, because we will keep NAK-ing adding
>>> properties to circumvent missing compatibles.
>>
>>
>> I have read the documention and patch link that you mentioned and it
>> seems to advice that We don't have wildcard names in the compatible
>> string and use wildcard names that will cause issue. and the compatible
>> "loongson,ls2k-spi" that wasn't a wildcard names, and if the loongson-2k
>> spi controller hardware upgraded or changed the I will use
>> "loongson,ls2k-spi-version" as a compatible, such as,
>> "loongson,ls2k-spi-v1.1", "loongson,ls2k-spi-v1.1a" or other.
> 
> Versions? Why? They received a lot of comments in the past, let me just
> paste to avoid repeating the same:
> 
> https://lore.kernel.org/all/20220926231238.GA3132756-robh@kernel.org/
> 
> (and many more discussions on devicetree mailing list)
> 


I didn't notice the following words earlier about compatible in
documention and I will use "loongson,ls2k1000-spi" as ls2k1000 SoC spi
compatible, which is a very specific compatible.

"For sub-blocks/components of bigger device (e.g. SoC blocks) use rather
device-based compatible (e.g. SoC-based compatible), instead of custom
versioning of that component.For example use "vendor,soc1234-i2c"
instead of "vendor,i2c-v2".

>>
>>>>
>>>>> Or am I misunderstanding and all ls2k SoCs do work with this driver and
>>>>> you were talking about other, future products?
>>>>
>>>> Actually, in 2k500 has one special type spi was only one cs and their's
>>>> register definition was different from common type spi thus this driver
>>>> doesn't support but this driver can support another common type spi in
>>>> 2k500.  for this special type spi I will add support as needed in the
>>>> future.
>>>
>>> Bindings are for hardware, not driver. What does your driver support or
>>> does not, matters less.
>>
>>
>> okay, I got it, and the loongson spi bindings was for loongson spi
>> controller hardware. if the spi controller hardware not changed in
>> different ls2k SoC and the spi compatible should be same thus loongson
>> spi compatible seems to be adhere to the bindings aggrement.
> 
> Specific compatible - yes. Unspecific - not, because you disregard the
> clear message in the guideline.

okay, I got it.

Thanks.




