Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5027B6CBE28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjC1Lxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjC1Lxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:53:43 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7B546E8B;
        Tue, 28 Mar 2023 04:53:40 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxJDRD1SJkjBMTAA--.29795S3;
        Tue, 28 Mar 2023 19:53:39 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxWb0+1SJkJ18PAA--.9312S3;
        Tue, 28 Mar 2023 19:53:37 +0800 (CST)
Subject: Re: [PATCH v4 0/2] spi: loongson: add bus driver for the loongson spi
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230328112210.23089-1-zhuyinbo@loongson.cn>
 <20230328113536.ldxpvx3hibezcqtb@intel.intel>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <253f3bf2-a193-69da-79ef-c3771d677478@loongson.cn>
Date:   Tue, 28 Mar 2023 19:53:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230328113536.ldxpvx3hibezcqtb@intel.intel>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxWb0+1SJkJ18PAA--.9312S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXFWxJry5Cw1kGw1fGrWrAFb_yoW7JFWxpF
        sxC3ZxtF43JF4kArs3JryUJr1UXryrJr93JFW3t3409ryDZw1UCr1jyF1rurWUAFyag3Wx
        WF18ur4rGFy8JFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF04k20xvE74
        AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2oGQDUUUU
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2023/3/28 ÏÂÎç7:35, Andi Shyti Ð´µÀ:
> Hi Yinbo,
> 
> before submitting the patches for review... can you please run
> checkpatch.pl on them?
yes, I had used checkpatch.pl to check and no any errors and warnings.

user@user-pc:~/workspace/test/code/www.kernel.org/linux$ 
./scripts/checkpatch.pl *.patch
-----------------------
0000-cover-letter.patch
-----------------------
total: 0 errors, 0 warnings, 0 lines checked

0000-cover-letter.patch has no obvious style problems and is ready for 
submission.
-------------------------------------------
0001-dt-bindings-spi-add-loongson-spi.patch
-------------------------------------------
Traceback (most recent call last):
   File "scripts/spdxcheck.py", line 6, in <module>
     from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
total: 0 errors, 0 warnings, 55 lines checked

0001-dt-bindings-spi-add-loongson-spi.patch has no obvious style 
problems and is ready for submission.
---------------------------------------------------------------
0002-spi-loongson-add-bus-driver-for-the-loongson-spi-con.patch
---------------------------------------------------------------
Traceback (most recent call last):
   File "scripts/spdxcheck.py", line 6, in <module>
     from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
Traceback (most recent call last):
   File "scripts/spdxcheck.py", line 6, in <module>
     from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
Traceback (most recent call last):
   File "scripts/spdxcheck.py", line 6, in <module>
     from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
Traceback (most recent call last):
   File "scripts/spdxcheck.py", line 6, in <module>
     from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
total: 0 errors, 0 warnings, 556 lines checked

0002-spi-loongson-add-bus-driver-for-the-loongson-spi-con.patch has no 
obvious style problems and is ready for submission.
user@user-pc:~/workspace/test/code/www.kernel.org/linux$
> 
> Thanks,
> Andi
> 
> On Tue, Mar 28, 2023 at 07:22:08PM +0800, Yinbo Zhu wrote:
>> Loongson platform support spi hardware controller and this series patch
>> was to add spi driver and binding support.
>>
>> Change in v2:
>> 		1. This [PATCH v2 1/2] dt-bindings patch need depend on clk patch:
>> 	 	   https://
>> 		   lore.kernel.org/all/20230307115022.12846-1-zhuyinbo@loongson.cn/
>> 		2. Remove the clock-names in spi yaml file.
>> 		3. Add "loongson,ls7a-spi" compatible in spi yaml file.
>> 		4. Add an || COMPILE_TEST and drop && PCI then add some CONFIG_PCI
>> 		   macro to limit some pci code.
>> 		5. Make the spi driver top code comment block that use C++ style.
>> 		6. Drop spi->max_speed_hz.
>> 		7. Add a spin_lock for loongson_spi_setup.
>> 		8. Add a timeout and cpu_relax() in loongson_spi_write_read_8bit.
>> 		9. Add spi_transfer_one and drop transfer and rework entire spi
>> 		   driver that include some necessary changes.
>> 		10. Use module_init replace subsys_initcall.
>> 		11. About PM interface that I don't find any issue so I don't add
>> 		    any changes.
>> Change in v3:
>> 		1. This [PATCH v3 1/2] dt-bindings patch need depend on clk patch:
>> 		   https://
>> 		   lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
>> 		2. Drop the unused blank line in loongson,ls-spi.yaml file.
>> 		3. Replace clock minItems with clock maxItems in yaml file.
>> 		4. Separate spi driver into platform module, pci module and core
>> 		   module.
>> 		5. Replace DIV_ROUND_UP with DIV_ROUND_UP_ULL to fix compile error
>> 		   "undefined reference to `__aeabi_uldivmod'" and  "__udivdi3 undefined"
>> 		   that reported by test robot.
>> 		6. Remove the spin lock.
>> 		7. Clear the loongson_spi->hz and loongson_spi->mode in setup to fixup
>> 		   the issue that multiple spi device transfer that maybe cause spi was
>> 		   be misconfigured.
>> Change in v4:
>> 		1. This [PATCH v4 1/2] dt-bindings patch need depend on clk patch:
>> 		   https://
>> 		   lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
>> 		2. Add "#include <linux/io.h>" in spi-loongson-core.c for fix the compile
>> 		   issue which devm_ioremap no declaration.
>> 		3. Add "EXPORT_SYMBOL_GPL(loongson_spi_dev_pm_ops)" in
>> 		   spi-loongson-core.c for fix the compile issue which
>> 		   loongson_spi_dev_pm_ops undefined.
>>
>> Yinbo Zhu (2):
>>    dt-bindings: spi: add loongson spi
>>    spi: loongson: add bus driver for the loongson spi controller
>>
>>   .../bindings/spi/loongson,ls-spi.yaml         |  43 +++
>>   MAINTAINERS                                   |  10 +
>>   drivers/spi/Kconfig                           |  31 ++
>>   drivers/spi/Makefile                          |   3 +
>>   drivers/spi/spi-loongson-core.c               | 304 ++++++++++++++++++
>>   drivers/spi/spi-loongson-pci.c                |  89 +++++
>>   drivers/spi/spi-loongson-plat.c               |  66 ++++
>>   drivers/spi/spi-loongson.h                    |  41 +++
>>   8 files changed, 587 insertions(+)
>>
>> -- 
>> 2.20.1
>>

