Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF0E5EEE72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbiI2HHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiI2HHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:07:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CB993846C;
        Thu, 29 Sep 2022 00:07:21 -0700 (PDT)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxYOIaRDVjm6kjAA--.2760S2;
        Thu, 29 Sep 2022 15:07:06 +0800 (CST)
Subject: Re: [PATCH v5 2/3] dt-bindings: thermal: add loongson2k thermal
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
References: <20220928083702.17309-1-zhuyinbo@loongson.cn>
 <20220928083702.17309-2-zhuyinbo@loongson.cn>
 <066b55cf-4a28-89a2-56ab-572590c97c30@linaro.org>
 <9b2f2d43-981d-3ffb-7526-dc3e58a9f367@linaro.org>
 <f0946817-cc2c-449b-d93b-0dd94a0f51f1@loongson.cn>
 <ed762d71-7104-b1ad-009d-51c1a4407472@loongson.cn>
 <9b62594f-7473-9974-8ab3-4c93aae5fa64@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <abaf9b69-487c-0f1e-7a94-201155f5e3d2@loongson.cn>
Date:   Thu, 29 Sep 2022 15:07:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9b62594f-7473-9974-8ab3-4c93aae5fa64@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxYOIaRDVjm6kjAA--.2760S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1kGry5XrWDtFWDXF43ZFb_yoW8Xry7pF
        y8Ja1qkFWDJrW3Kw48Kw1xtF1Yvws7tr45Xr1rGr4UArWqqw15tF1DZr1jkryDWrWfXFW7
        trW5K3srJr4UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/29 下午3:00, Krzysztof Kozlowski 写道:
> On 29/09/2022 05:57, Yinbo Zhu wrote:
>>
>>
>> 在 2022/9/29 上午11:42, Yinbo Zhu 写道:
>>>
>>>
>>> 在 2022/9/28 下午10:18, Krzysztof Kozlowski 写道:
>>>> On 28/09/2022 10:37, Krzysztof Kozlowski wrote:
>>>>> On 28/09/2022 10:37, Yinbo Zhu wrote:
>>>>>> Add the loongson2k thermal binding with DT schema format using
>>>>>> json-schema.
>>>>>>
>>>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>>
>>>>> Please add Acked-by/Reviewed-by tags when posting new versions. However,
>>>>> there's no need to repost patches *only* to add the tags. The upstream
>>>>> maintainer will do that for acks received on the version they apply.
>>>>>
>>>>> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>>>>>
>>>>>
>>>>> If a tag was not added on purpose, please state why and what changed.
>>>>>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> ... and please test your patches before sending :(
>> You said is refer that "reg: [[0, 534779136], [0, 48]] is too long" ?
>> Need fix that warning, right?
> 
> Yes. You said you tested it but then sent with an error... so it's not
> really a testing.
sorry, I did do some testing. but I think It is okay that can generate a 
dtb  without reporting an error when compile yaml file, in fact, I 
ignore the warning,  I will fix it in v6.
> 
> Best regards,
> Krzysztof
> 

