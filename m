Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB9B5EF2E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiI2KAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiI2KAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:00:45 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C61AEC54B;
        Thu, 29 Sep 2022 03:00:41 -0700 (PDT)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOLDbDVjMrsjAA--.1941S2;
        Thu, 29 Sep 2022 18:00:36 +0800 (CST)
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
 <abaf9b69-487c-0f1e-7a94-201155f5e3d2@loongson.cn>
 <f54a40ea-99bf-e341-3bbd-851b250cc9cd@linaro.org>
 <a205592c-9e5b-0cf2-88d7-aabe0bdcc2ae@loongson.cn>
 <06fa0bd2-c447-d705-01be-791207a4be8a@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <550a852b-0ee4-8179-48a2-6cb11a3dd800@loongson.cn>
Date:   Thu, 29 Sep 2022 18:00:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <06fa0bd2-c447-d705-01be-791207a4be8a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxBOLDbDVjMrsjAA--.1941S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF43AryxKF1Uuw4DuFW3Wrg_yoW8tF1xpF
        yDK3WDKF45ZFn29w10ya1SqF1jywn3t3y5XryfWr17K3yqvasxXFy7tr4UurZ0ga1IqFW0
        q345trWxuF4qv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
        4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/29 下午5:04, Krzysztof Kozlowski 写道:
> On 29/09/2022 10:23, Yinbo Zhu wrote:
>>
>>
>> 在 2022/9/29 下午3:45, Krzysztof Kozlowski 写道:
>>> On 29/09/2022 09:07, Yinbo Zhu wrote:
>>>>>>>>
>>>>>>>> ... and please test your patches before sending :(
>>>>>> You said is refer that "reg: [[0, 534779136], [0, 48]] is too long" ?
>>>>>> Need fix that warning, right?
>>>>>
>>>>> Yes. You said you tested it but then sent with an error... so it's not
>>>>> really a testing.
>>>> sorry, I did do some testing. but I think It is okay that can generate a
>>>> dtb  without reporting an error when compile yaml file, in fact, I
>>>> ignore the warning,  I will fix it in v6.
>>>
>>>
>>> Do you also send the code with warnings reported by GCC? Judging by
>>> number of kernel test robot reports, it could be. So just to be very,
>>> very clear: do not send any code which generates any warning. For GCC
>>> this means W=1 builds.
>> I don't find about the warning about GCC when compile yaml file.
>> and I dont't know the meaning about W=1, you said about "W=1" is to execute
>> following command to compile the yaml, right?
> 
> GCC is about your C code. You were sending patches knowing that they
> have warnings. It's not good. All warnings must be fixed.
what you said about C code warning whether is follows ? If is it, and I 
had add a static for loongson2_thermal_remove in v3 version code, I
think it shoud be fixed  about the warning.
 >> drivers/thermal/loongson2_thermal.c:183:5: warning: no previous 
prototype for function 'loongson2_thermal_remove' [-Wmissing-prototypes]
    int loongson2_thermal_remove(struct platform_device *pdev)
        ^
    drivers/thermal/loongson2_thermal.c:183:1: note: declare 'static' if 
the function is not intended to be used outside of this translation unit
    int loongson2_thermal_remove(struct platform_device *pdev)
    ^
    static
    1 warning generated.

If you said about C code warning isn't about about 
"loongson2_thermal_remove" and I may be loss a mail about that C code 
warning, Could you foward a mail about that C code warning. because I 
don't find any C code warning when compile C code.

About the C code warning, it was base on v6 code?

TKs,
Yinbo Zhu.
> 
> Best regards,
> Krzysztof
> 

