Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5BE6C9F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjC0JMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjC0JMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:12:06 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39D88E9;
        Mon, 27 Mar 2023 02:11:59 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxedndXSFko0sSAA--.27776S3;
        Mon, 27 Mar 2023 17:11:57 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxbb7YXSFkrRIOAA--.33921S3;
        Mon, 27 Mar 2023 17:11:54 +0800 (CST)
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: add loongson spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, loongson-kernel@lists.loongnix.cn,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, zhuyinbo@loongson.cn
References: <20230324063317.14664-1-zhuyinbo@loongson.cn>
 <20230324063317.14664-2-zhuyinbo@loongson.cn>
 <167966252219.1675112.1668738117284963309.robh@kernel.org>
 <31026abc-bdb3-9d30-276f-82ff93e43d48@loongson.cn>
 <87045dd7-7af1-7af2-83f3-aa15bf74e965@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <be027670-f60d-1fce-5dcd-b406824f26e0@loongson.cn>
Date:   Mon, 27 Mar 2023 17:11:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87045dd7-7af1-7af2-83f3-aa15bf74e965@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxbb7YXSFkrRIOAA--.33921S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kry8Kry5uw1Utr13Ar4UXFb_yoW8Cr45pw
        48Can0yFWjyr13Kw4ft34Igw1YqrykJr1YqrnxKry7tF90va4Fvr4akryUuFsruF13Gryx
        ZF1UK343K34jvw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82
        IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMxCI
        bckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
        0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8SksDUUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/27 下午4:52, Krzysztof Kozlowski 写道:
> On 27/03/2023 10:39, zhuyinbo wrote:
>>
>>
>> 在 2023/3/24 下午9:07, Rob Herring 写道:
>>>
>>> On Fri, 24 Mar 2023 14:33:16 +0800, Yinbo Zhu wrote:
>>>> Add the Loongson platform spi binding with DT schema format using
>>>> json-schema.
>>>>
>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>> ---
>>>>    .../bindings/spi/loongson,ls-spi.yaml         | 43 +++++++++++++++++++
>>>>    MAINTAINERS                                   |  6 +++
>>>>    2 files changed, 49 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>>
>>>
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
>> Hi Rob Herring,
>>
>> This error was still appears on 22 line, this line was
>> LOONGSON2_BOOT_CLK not refer, it need depend on
>> https://lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
>> then compile will be successful. and I had added this depend on
>> description in v2, v3 patch changelog, I was also send a email to remind
>> your bot for the test my patch need dpend on other clock patch.
> 
> ... and did you read Rob's advice?yes
For some reason you responded to
> automated bot's email, but not to actual email from Rob.
okay, I got it.
> 
> Best regards,
> Krzysztof
> 

