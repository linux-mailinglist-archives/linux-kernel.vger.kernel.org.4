Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E51622664
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiKIJMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiKIJLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:11:05 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D14F20F51;
        Wed,  9 Nov 2022 01:10:52 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8BxGdiabmtjyoMFAA--.16083S3;
        Wed, 09 Nov 2022 17:10:50 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJleXbmtjVHgPAA--.24650S2;
        Wed, 09 Nov 2022 17:10:48 +0800 (CST)
Subject: Re: [PATCH v9 1/3] dt-bindings: clock: add loongson-2 clock include
 file
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221103050032.29236-1-zhuyinbo@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <129c908a-8c6d-6b2b-ef61-e774cf6368b7@loongson.cn>
Date:   Wed, 9 Nov 2022 17:10:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221103050032.29236-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxJleXbmtjVHgPAA--.24650S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJFW3uFWfCrW7Zr4kKFyUWrg_yoW5CFW7pr
        4kCFZ3Gry2yF4IkanYgF13Krn8uw48J3WUCF429w1UAFnxtw18JrnrKF1fA39xXrZ7AFW7
        Z3Wv9w409FW7u3DanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jetC7UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainer,

please help me merge it to upstream.

thanks,
Yinbo.

ÔÚ 2022/11/3 ÏÂÎç1:00, Yinbo Zhu Ð´µÀ:
> This file defines all Loongson-2 SoC clock indexes, it should be
> included in the device tree in which there's device using the
> clocks.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Change in v9:
> 		1. Add all history changelog infomation.
> Change in v8:
> 		1. No change but this series patch has a change.
> Change in v7:
> 		1. No change but this series patch has a change.
> Change in v6:
> 		1. Replace string LOONGSON2 with LOONGSON-2 in MAINTAINERS.
> Change in v5:
> 		1. Replace loongson2/Loongson2 with loongson-2/Loongson-2.
> 		2. Replace soc with SoC.
> Change in v4:
> 		1. No change but this series patch has a change.
> Change in v3:
> 		1. Add the review information.
> Change in v2:
> 		1. Make filename matching the compatible.
> 		2. Drop weird indentation after define.
> 		3. Add dual license.
> 		4. Use subject prefixes matching the subsystem.
> 
>   MAINTAINERS                                   |  6 ++++
>   include/dt-bindings/clock/loongson,ls2k-clk.h | 29 +++++++++++++++++++
>   2 files changed, 35 insertions(+)
>   create mode 100644 include/dt-bindings/clock/loongson,ls2k-clk.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3aff8b8723b1..d5d1f2b9fcfd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12018,6 +12018,12 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
>   F:	drivers/thermal/loongson2_thermal.c
>   
> +LOONGSON-2 SOC SERIES CLOCK DRIVER
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:	linux-clk@vger.kernel.org
> +S:	Maintained
> +F:	include/dt-bindings/clock/loongson,ls2k-clk.h
> +
>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>   M:	Sathya Prakash <sathya.prakash@broadcom.com>
>   M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> diff --git a/include/dt-bindings/clock/loongson,ls2k-clk.h b/include/dt-bindings/clock/loongson,ls2k-clk.h
> new file mode 100644
> index 000000000000..db1e27e792ff
> --- /dev/null
> +++ b/include/dt-bindings/clock/loongson,ls2k-clk.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_LOONGSON2_H
> +#define __DT_BINDINGS_CLOCK_LOONGSON2_H
> +
> +#define LOONGSON2_REF_100M				0
> +#define LOONGSON2_NODE_PLL				1
> +#define LOONGSON2_DDR_PLL				2
> +#define LOONGSON2_DC_PLL				3
> +#define LOONGSON2_PIX0_PLL				4
> +#define LOONGSON2_PIX1_PLL				5
> +#define LOONGSON2_NODE_CLK				6
> +#define LOONGSON2_HDA_CLK				7
> +#define LOONGSON2_GPU_CLK				8
> +#define LOONGSON2_DDR_CLK				9
> +#define LOONGSON2_GMAC_CLK				10
> +#define LOONGSON2_DC_CLK				11
> +#define LOONGSON2_APB_CLK				12
> +#define LOONGSON2_USB_CLK				13
> +#define LOONGSON2_SATA_CLK				14
> +#define LOONGSON2_PIX0_CLK				15
> +#define LOONGSON2_PIX1_CLK				16
> +#define LOONGSON2_CLK_END				17
> +
> +#endif
> 

