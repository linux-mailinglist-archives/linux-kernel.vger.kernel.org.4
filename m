Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363325EF050
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbiI2IX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiI2IX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:23:57 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3ED213D856;
        Thu, 29 Sep 2022 01:23:53 -0700 (PDT)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxFeISVjVjBLAjAA--.3503S2;
        Thu, 29 Sep 2022 16:23:46 +0800 (CST)
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
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <a205592c-9e5b-0cf2-88d7-aabe0bdcc2ae@loongson.cn>
Date:   Thu, 29 Sep 2022 16:23:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f54a40ea-99bf-e341-3bbd-851b250cc9cd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxFeISVjVjBLAjAA--.3503S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW7KF4DAF17Jw1xWryfWFg_yoW8AFykpF
        Z3G3WqyF4UCF429w4vyay8tw4vvw1ktFW3XFW3KrnrKw4DX3y3try3Kr9ruFZ09w40gFWI
        yry5KrWaka4qv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/29 下午3:45, Krzysztof Kozlowski 写道:
> On 29/09/2022 09:07, Yinbo Zhu wrote:
>>>>>>
>>>>>> ... and please test your patches before sending :(
>>>> You said is refer that "reg: [[0, 534779136], [0, 48]] is too long" ?
>>>> Need fix that warning, right?
>>>
>>> Yes. You said you tested it but then sent with an error... so it's not
>>> really a testing.
>> sorry, I did do some testing. but I think It is okay that can generate a
>> dtb  without reporting an error when compile yaml file, in fact, I
>> ignore the warning,  I will fix it in v6.
> 
> 
> Do you also send the code with warnings reported by GCC? Judging by
> number of kernel test robot reports, it could be. So just to be very,
> very clear: do not send any code which generates any warning. For GCC
> this means W=1 builds.
I don't find about the warning about GCC when compile yaml file.
and I dont't know the meaning about W=1, you said about "W=1" is to execute
following command to compile the yaml, right?

root@m-pc:/home/m/workspace/test/code/upstream# make DT_CHECKER_FLAGS=-m
dt_binding_check W=1 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml 


I compile it use v6 patch that compile result as follows:
root@m-pc:/home/m/workspace/test/code/upstream# make DT_CHECKER_FLAGS=-m 
dt_binding_check W=1 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml 

   DTC 
Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.example.dtb
   CHECK 
Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.example.dtb


In addtion, if you said was about loongson2_thermal.c, this code has no 
warning that I had check.

BRs,
Yinbo Zhu.

> 
> Best regards,
> Krzysztof
> 

