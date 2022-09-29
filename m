Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34685EEC9C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiI2D52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiI2D50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:57:26 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06735F161D;
        Wed, 28 Sep 2022 20:57:23 -0700 (PDT)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72ueFzVjZ6AjAA--.64342S2;
        Thu, 29 Sep 2022 11:57:18 +0800 (CST)
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
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <ed762d71-7104-b1ad-009d-51c1a4407472@loongson.cn>
Date:   Thu, 29 Sep 2022 11:57:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f0946817-cc2c-449b-d93b-0dd94a0f51f1@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx72ueFzVjZ6AjAA--.64342S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar45Xr17ZF13XF1UJw17Awb_yoW8GFWrpF
        yxA3ZrKFWDArya93yxK3WxAFnY9rsxtrWUXr15Kr4UAFWqqwnxtFnY9ryq9rykW3yrWFWI
        qFW5W39rJrWDZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/29 上午11:42, Yinbo Zhu 写道:
> 
> 
> 在 2022/9/28 下午10:18, Krzysztof Kozlowski 写道:
>> On 28/09/2022 10:37, Krzysztof Kozlowski wrote:
>>> On 28/09/2022 10:37, Yinbo Zhu wrote:
>>>> Add the loongson2k thermal binding with DT schema format using
>>>> json-schema.
>>>>
>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>
>>> Please add Acked-by/Reviewed-by tags when posting new versions. However,
>>> there's no need to repost patches *only* to add the tags. The upstream
>>> maintainer will do that for acks received on the version they apply.
>>>
>>> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540 
>>>
>>>
>>> If a tag was not added on purpose, please state why and what changed.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ... and please test your patches before sending :(
You said is refer that "reg: [[0, 534779136], [0, 48]] is too long" ?
Need fix that warning, right?
>>
>> Best regards,
>> Krzysztof
> Hi Krzysztof,
> 
> I have a function test for these three patch, that it's okay.
> for binding patch I have a compile test, as follow, it is okay.
> root@m-pc:/home/m/workspace/test/code/upstream# make DT_CHECKER_FLAGS=-m 
> dt_binding_check 
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/ls2k-thermal.yaml
> 
> BRs,
> Yinbo Zhu.
>>

