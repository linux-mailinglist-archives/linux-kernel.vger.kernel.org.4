Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CD16B3ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCJJhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCJJgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:36:44 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01A3814E88;
        Fri, 10 Mar 2023 01:34:04 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxJPxj+Qpk5u0KAA--.14919S3;
        Fri, 10 Mar 2023 17:33:23 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxSL1e+QpkTcxRAA--.10888S3;
        Fri, 10 Mar 2023 17:33:22 +0800 (CST)
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: add loongson spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liu Peibao <liupeibao@loongson.cn>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, Mark Brown <broonie@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>, wanghongliang@loongson.cn,
        zhuyinbo@loongson.cn
References: <20230308025908.21491-1-zhuyinbo@loongson.cn>
 <20230308025908.21491-2-zhuyinbo@loongson.cn>
 <167828359942.2612999.3798783623764270312.robh@kernel.org>
 <1f14658a-5dc3-fc48-5291-28e14f88abaa@loongson.cn>
 <c254b2f1-2086-498f-35c6-c87d838bcb2d@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <3370cbee-1b17-3473-4462-c574398fb83d@loongson.cn>
Date:   Fri, 10 Mar 2023 17:33:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c254b2f1-2086-498f-35c6-c87d838bcb2d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxSL1e+QpkTcxRAA--.10888S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ar45uw4UCr1fuF4UGF48Zwb_yoW8WF4Upw
        48Can8tF4Utr13Kw4Sq345Kw1YqrWrGryYqF9xKr17GFyqg3WFvr4akr1UuFsruF17GFyx
        ZF15Kw15KryUZr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bx8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
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
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/10 下午5:08, Krzysztof Kozlowski 写道:
> On 10/03/2023 03:31, zhuyinbo wrote:
>> 在 2023/3/8 下午10:06, Rob Herring 写道:
>>> On Wed, 08 Mar 2023 10:59:07 +0800, Yinbo Zhu wrote:
>>>> Add the Loongson platform spi binding with DT schema format using
>>>> json-schema.
>>>>
>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>> ---
>>>>    .../bindings/spi/loongson,ls-spi.yaml         | 47 +++++++++++++++++++
>>>>    MAINTAINERS                                   |  6 +++
>>>>    2 files changed, 53 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> Error: Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dts:22.28-29 syntax error
>>> FATAL ERROR: Unable to parse input tree
>>> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dtb] Error 1
>>> make[1]: *** Waiting for unfinished jobs....
>>> make: *** [Makefile:1512: dt_binding_check] Error 2
>>>
>>> doc reference errors (make refcheckdocs):
>> This yaml patch need depend on
>>
>> https://lore.kernel.org/all/20230307115022.12846-1-zhuyinbo@loongson.cn/
>>
>> , then yaml  compile will be successfull.
> Nothing in the patch changelog (where it is preferred), not even cover
> letter, mention dependencies.

okay, I will add it in changelog  in next version.

>
> Best regards,
> Krzysztof

