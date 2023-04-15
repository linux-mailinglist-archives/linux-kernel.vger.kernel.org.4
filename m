Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B0D6E2EEA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 05:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjDOD7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 23:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDOD7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 23:59:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F72E2691;
        Fri, 14 Apr 2023 20:59:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so19742072pji.1;
        Fri, 14 Apr 2023 20:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681531145; x=1684123145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R2fde2HsHmIfkiEI2UAUWoWsc/tveiCgSyXqkf/egC8=;
        b=nj1/sKjTDSZzBUVk+FrI5W4qFaU/Li/yVySX98mpsTprmZs/ziogLy5Eg8qG70GUvu
         rm8mTyP8KEdMFjbtRBr6fXsn3Po0QKH4PCD3GpSfdosbGGqDppRm1/682pKGdc6tdchD
         GdpsQULKk1cC3NYItS/iQwdPVZc6M7w5alJXiG3cblLFJ8/WDeSHBIM3yasY/79YkJOb
         d6BGNVTbRi2btSndCMNAt21pkcFpc4AYk1hynsV5+VeUy5BxAY1fHNKOG0YvC+UE8Dax
         lst416C86gmUOphR3aSskKQu5X0PKmbjYDn/GEEVOv9Cjb2jQPWWnKoNNb1mDsX1C8EM
         HqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681531145; x=1684123145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2fde2HsHmIfkiEI2UAUWoWsc/tveiCgSyXqkf/egC8=;
        b=OZh6C+TqpqIlTa1aRlKyPPNQdkomIdZdjDWJmRiAJd/NsB04/FqC8KZ99qAMv14e3f
         H7RjsAUWOEil5tBGUo22S5T98qvhp5OY+l4RmjFeeuBlXPHZefvQGrBiEP4JeOlnObX+
         PD1wmxWkm8t6c+PqohviImblW/Wq1BaUgkDZCJFz2XirufUItkCFey5DhgPGtRofXWFS
         AuZQ0r0HsSe7U6s1lFTTW1KFpXi7V7rxF4KruzhNFJztaqWUHb5VhSeb8socYv6bixpX
         ON1sH0XavimVsgIa9pFfqTgQyvm+BGufkRmYRDHaj47mrhctI8LopnHJD+NaW/HDGDfD
         gkQA==
X-Gm-Message-State: AAQBX9ebBCT0xM78j2KSk9gHAjW3MxPl3FHrXC2aDxV5LYed2WmE/UcW
        UHFluGdgPymgt5UF1KKpanM=
X-Google-Smtp-Source: AKy350YC3SrlQSPp0eJXeYtSgWuIaVFECEw+fdKKH/xU0sG+GX2awd3nVeQlP5krB+ZRQm1MmTR7VA==
X-Received: by 2002:a17:90b:4018:b0:247:1e30:5880 with SMTP id ie24-20020a17090b401800b002471e305880mr7699599pjb.38.1681531144497;
        Fri, 14 Apr 2023 20:59:04 -0700 (PDT)
Received: from [192.168.1.101] (1-160-170-76.dynamic-ip.hinet.net. [1.160.170.76])
        by smtp.gmail.com with ESMTPSA id c15-20020a17090a1d0f00b0024499d4b72esm5219544pjd.51.2023.04.14.20.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 20:59:04 -0700 (PDT)
Message-ID: <71f646cb-7114-0c78-493c-99bdb5217801@gmail.com>
Date:   Sat, 15 Apr 2023 11:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 09/12] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
To:     Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-10-ychuang570808@gmail.com>
 <4f57a7ccc946d18be5eb9a47fa69e5f8.sboyd@kernel.org>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <4f57a7ccc946d18be5eb9a47fa69e5f8.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Stephen,


On 2023/4/14 上午 04:27, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-04-11 22:38:21)
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1-divider.c b/drivers/clk/nuvoton/clk-ma35d1-divider.c
>> new file mode 100644
>> index 000000000000..8d573ba3dfd3
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1-divider.c
>> @@ -0,0 +1,134 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
> [...]
>> +struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev, const char *name,
>> +                                    const char *parent_name,
>> +                                    spinlock_t *lock,
>> +                                    unsigned long flags, void __iomem *reg,
>> +                                    u8 shift, u8 width, u32 mask_bit)
>> +{
>> +       struct ma35d1_adc_clk_div *div;
>> +       struct clk_init_data init;
>> +       struct clk_div_table *table;
>> +       u32 max_div, min_div;
>> +       struct clk_hw *hw;
>> +       int ret;
>> +       int i;
>> +
>> +       div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
>> +       if (!div)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       max_div = clk_div_mask(width) + 1;
>> +       min_div = 1;
>> +
>> +       table = devm_kcalloc(dev, max_div + 1, sizeof(*table), GFP_KERNEL);
>> +       if (!table)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       for (i = 0; i < max_div; i++) {
>> +               table[i].val = min_div + i;
>> +               table[i].div = 2 * table[i].val;
>> +       }
>> +       table[max_div].val = 0;
>> +       table[max_div].div = 0;
>> +
>> +       init.name = name;
>> +       init.ops = &ma35d1_adc_clkdiv_ops;
>> +       init.flags |= flags;
>> +       init.parent_names = parent_name ? &parent_name : NULL;
> Can you use parent_data instead?

Sure, I will modify it.


>
>> +       init.num_parents = parent_name ? 1 : 0;
>> +
>> +       div->reg = reg;
>> +       div->shift = shift;
>> +       div->width = width;
>> +       div->mask = mask_bit ? BIT(mask_bit) : 0;
>> +       div->lock = lock;
>> +       div->hw.init = &init;
>> +       div->table = table;
>> +
>> +       hw = &div->hw;
>> +       ret = devm_clk_hw_register(dev, hw);
>> +       if (ret)
>> +               return ERR_PTR(ret);
>> +       return hw;
>> +}
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1-pll.c b/drivers/clk/nuvoton/clk-ma35d1-pll.c
>> new file mode 100644
>> index 000000000000..6de67c964a2d
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1-pll.c
>> @@ -0,0 +1,315 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/container_of.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +
>> +#include "clk-ma35d1.h"
>> +
>> +struct ma35d1_clk_pll {
>> +       struct clk_hw hw;
>> +       u8 type;
>> +       u8 mode;
>> +       void __iomem *ctl0_base;
>> +       void __iomem *ctl1_base;
>> +       void __iomem *ctl2_base;
>> +};
>> +
> [..]
>> +struct clk_hw *ma35d1_reg_clk_pll(enum ma35d1_pll_type type,
>> +                                 struct device *dev,
>> +                                 u8 u8mode, const char *name,
>> +                                 const char *parent,
>> +                                 void __iomem *base)
>> +{
>> +       struct ma35d1_clk_pll *pll;
>> +       struct clk_hw *hw;
>> +       struct clk_init_data init = {};
>> +       int ret;
>> +
>> +       pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
>> +       if (!pll)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       pll->type = type;
>> +       pll->mode = u8mode;
>> +       pll->ctl0_base = base + REG_PLL_CTL0_OFFSET;
>> +       pll->ctl1_base = base + REG_PLL_CTL1_OFFSET;
>> +       pll->ctl2_base = base + REG_PLL_CTL2_OFFSET;
>> +
>> +       init.name = name;
>> +       init.flags = 0;
>> +       init.parent_names = &parent;
> Can you use parent_data instead?

I will fix it.


>
>> +       init.num_parents = 1;
>> +
>> +       if (type == MA35D1_CAPLL || type == MA35D1_DDRPLL)
>> +               init.ops = &ma35d1_clk_fixed_pll_ops;
>> +       else
>> +               init.ops = &ma35d1_clk_pll_ops;
>> +
>> +       pll->hw.init = &init;
>> +       hw = &pll->hw;
>> +
>> +       ret = devm_clk_hw_register(dev, hw);
>> +       if (ret)
>> +               return ERR_PTR(ret);
>> +       return hw;
>> +}
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
>> new file mode 100644
>> index 000000000000..066e1c6f2d35
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
>> @@ -0,0 +1,897 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +#include "clk-ma35d1.h"
>> +
>> +static DEFINE_SPINLOCK(ma35d1_lock);
>> +
>> +static const struct clk_parent_data ca35clk_sel_clks[] = {
>> +       { .fw_name = "hxt", .name = "hxt" },
>> +       { .fw_name = "capll", .name = "capll" },
>> +       { .fw_name = "ddrpll", .name = "ddrpll" },
>> +       { .fw_name = "dummy", .name = "dummy" }
> What is 'dummy'? Is that in the binding? Note, don't put both .fw_name
> and .name in the binding. For new drivers, prefer to use .index or .hw
> and never use .name to describe parents.


I will remove "dummy" and use .index or .hw instead.


>> +};
>> +
>> +static const char *const sysclk0_sel_clks[] = {
>> +       "epll_div2", "syspll"
> [...]
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1.h b/drivers/clk/nuvoton/clk-ma35d1.h
>> new file mode 100644
>> index 000000000000..28c60f081788
>> --- /dev/null
>> +++ b/drivers/clk/nuvoton/clk-ma35d1.h
>> @@ -0,0 +1,123 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#ifndef __DRV_CLK_NUVOTON_MA35D1_H
>> +#define __DRV_CLK_NUVOTON_MA35D1_H
> Is this header included in one C file? If so, remove the header file and
> put the contents in the C file.

Both clk-ma35d1.c and clk-ma35d1-pll.c include this header file.


Best regards,

Jacky Huang


