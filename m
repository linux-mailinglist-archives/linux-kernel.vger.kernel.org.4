Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673896CF9AB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjC3Dqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC3Dqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:46:42 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3C2F4C27;
        Wed, 29 Mar 2023 20:46:38 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxEk4dBiVkhDMUAA--.19613S3;
        Thu, 30 Mar 2023 11:46:37 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxur0aBiVkJ_UQAA--.13166S3;
        Thu, 30 Mar 2023 11:46:34 +0800 (CST)
Subject: Re: [PATCH v4 0/2] spi: loongson: add bus driver for the loongson spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230328112210.23089-1-zhuyinbo@loongson.cn>
 <20230328113536.ldxpvx3hibezcqtb@intel.intel>
 <253f3bf2-a193-69da-79ef-c3771d677478@loongson.cn>
 <e9b1b899-9f19-0abd-8e20-fc486bf28b17@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <c881aa81-10c1-06f5-de9c-8948e9f6ebe8@loongson.cn>
Date:   Thu, 30 Mar 2023 11:46:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e9b1b899-9f19-0abd-8e20-fc486bf28b17@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxur0aBiVkJ_UQAA--.13166S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zw13WFyrtF1DCFWkKw1xKrg_yoW8KrW5pF
        nxJ3ZxJay3JF4DArs7twn8Jr1UW3yxJr4rJFW7JF18KF1qkF1UAry5Ar1rG34UXry5Ga47
        WF4UZryxGr18WFDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0HqcUUUUU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/29 下午4:07, Krzysztof Kozlowski 写道:
> On 28/03/2023 13:53, zhuyinbo wrote:
>>
>>
>> 在 2023/3/28 下午7:35, Andi Shyti 写道:
>>> Hi Yinbo,
>>>
>>> before submitting the patches for review... can you please run
>>> checkpatch.pl on them?
>> yes, I had used checkpatch.pl to check and no any errors and warnings.
>>
>> user@user-pc:~/workspace/test/code/www.kernel.org/linux$
>> ./scripts/checkpatch.pl *.patch
>> -----------------------
>> 0000-cover-letter.patch
>> -----------------------
>> total: 0 errors, 0 warnings, 0 lines checked
>>
>> 0000-cover-letter.patch has no obvious style problems and is ready for
>> submission.
>> -------------------------------------------
>> 0001-dt-bindings-spi-add-loongson-spi.patch
>> -------------------------------------------
>> Traceback (most recent call last):
>>     File "scripts/spdxcheck.py", line 6, in <module>
>>       from ply import lex, yacc
>> ModuleNotFoundError: No module named 'ply'
>> total: 0 errors, 0 warnings, 55 lines checked
>>
>> 0001-dt-bindings-spi-add-loongson-spi.patch has no obvious style
>> problems and is ready for submission.
>> ---------------------------------------------------------------
>> 0002-spi-loongson-add-bus-driver-for-the-loongson-spi-con.patch
>> ---------------------------------------------------------------
>> Traceback (most recent call last):
>>     File "scripts/spdxcheck.py", line 6, in <module>
>>       from ply import lex, yacc
>> ModuleNotFoundError: No module named 'ply'
>> Traceback (most recent call last):
>>     File "scripts/spdxcheck.py", line 6, in <module>
>>       from ply import lex, yacc
>> ModuleNotFoundError: No module named 'ply'
>> Traceback (most recent call last):
>>     File "scripts/spdxcheck.py", line 6, in <module>
>>       from ply import lex, yacc
>> ModuleNotFoundError: No module named 'ply'
>> Traceback (most recent call last):
>>     File "scripts/spdxcheck.py", line 6, in <module>
>>       from ply import lex, yacc
>> ModuleNotFoundError: No module named 'ply'
> 
> You have errors here... Fix your setup for spdx check.
I installed ply and gitpython package locally, and then there was no 
spdxcheck and other error when use checkpatch.pl to check this series patch.

Thanks.
> 
> Best regards,
> Krzysztof
> 

