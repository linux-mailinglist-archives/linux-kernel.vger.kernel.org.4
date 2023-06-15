Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34F673105C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244458AbjFOHRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244251AbjFOHQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:16:24 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 522952688;
        Thu, 15 Jun 2023 00:14:46 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxV+lkuopk4XcFAA--.9700S3;
        Thu, 15 Jun 2023 15:14:44 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxNeRiuopk1qcbAA--.13198S3;
        Thu, 15 Jun 2023 15:14:43 +0800 (CST)
Message-ID: <f2fae469-2a39-119b-8512-c4ad78a896f8@loongson.cn>
Date:   Thu, 15 Jun 2023 15:14:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/ingenic: Kconfig: select REGMAP and REGMAP_MMIO
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230607072253.440613-1-suijingfeng@loongson.cn>
 <845a483ed09728c712ad57b1fe9bc5c930a72d98.camel@crapouillou.net>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <845a483ed09728c712ad57b1fe9bc5c930a72d98.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxNeRiuopk1qcbAA--.13198S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJry8tFy5tr1DJF18Zr13GFX_yoW8CF15pF
        s5ta45uFWxuF4vkr42yFy7WFy5Xw15Ja4rCr1kJa4q9ryDAr1jqrZrZFWY9FyDAr4xGr4U
        X3s3GFy7ZF17XrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
        1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
        SoJUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/7 17:46, Paul Cercueil wrote:
> Hi Sui,
>
> Le mercredi 07 juin 2023 à 15:22 +0800, Sui Jingfeng a écrit :
>> Otherwise its failed to pass basic compile test on platform without
>> REGMAP_MMIO selected by defconfig
>>
>> make -j$(nproc) ARCH=mips CROSS_COMPILE=mips64el-linux-gnuabi64-
>>
>>    SYNC    include/config/auto.conf.cmd
>>    Checking missing-syscalls for N32
>>    CALL    scripts/checksyscalls.sh
>>    Checking missing-syscalls for O32
>>    CALL    scripts/checksyscalls.sh
>>    CALL    scripts/checksyscalls.sh
>>    MODPOST Module.symvers
>> ERROR: modpost: "__devm_regmap_init_mmio_clk"
>> [drivers/gpu/drm/ingenic/ingenic-drm.ko] undefined!
>> make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
>> make: *** [Makefile:1978: modpost] Error 2
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/ingenic/Kconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/ingenic/Kconfig
>> b/drivers/gpu/drm/ingenic/Kconfig
>> index a53f475d33df..7457c0b65034 100644
>> --- a/drivers/gpu/drm/ingenic/Kconfig
>> +++ b/drivers/gpu/drm/ingenic/Kconfig
>> @@ -5,6 +5,8 @@ config DRM_INGENIC
>>          depends on CMA
>>          depends on OF
>>          depends on COMMON_CLK
>> +       select REGMAP
>> +       select REGMAP_MMIO
> nit: order alphabetically (move them after the DRM_* ones).

Fixed, I already send a updated version[1].

[1] 
https://lore.kernel.org/dri-devel/20230607110650.569522-1-suijingfeng@loongson.cn/

> Cheers,
> -Paul
>
>>          select DRM_BRIDGE
>>          select DRM_PANEL_BRIDGE
>>          select DRM_KMS_HELPER

-- 
Jingfeng

