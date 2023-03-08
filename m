Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FA36B0C61
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCHPSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjCHPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:18:02 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616E8B7D9F;
        Wed,  8 Mar 2023 07:17:50 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id g73-20020a9d12cf000000b006943a7df072so9146802otg.11;
        Wed, 08 Mar 2023 07:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678288669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rCEf+NQ+Pc1ncYD3djIGD+iYastMQpss3chPBnkt7Ig=;
        b=AOvv9WB4IQmxykMtzq2277on7e0CPR51Ry/Rl6JUraFHKAEczYdKlV3ZDAkpMwV7pX
         kqJzDKu/EiuahfwOKicycBXDJMcZYSXAj7wh6JHiliFpDRLaqaWuVx/pFOGnMGTWIdpi
         rxkHnmI9vyyUbqmUIY3Ya+7VRZhZSoKYOCGwO1uD/BhvekSjGkMANNNneYDAODXQ8VcQ
         FCCO8oovrLlGGM49MUqzEp29tc3p2d11z6Vo1HFCcBNu6fdOFRnrDY6ScHn9RB4HJONj
         mOzhAVITUapgFfjUO/TZDv1Hb9nMNiUJB9DNr26LiMcUk+A0K3xFmzg0m40cljLJBoCt
         2nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678288669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCEf+NQ+Pc1ncYD3djIGD+iYastMQpss3chPBnkt7Ig=;
        b=fuSy4Ztl6TatpigMBjh4gDXi3Cd4fTVV+nJFMn76+0NZFZvw0hi/xHCSiA1Uyf6f8a
         iHRhDBQoS4zeSiO33ml4DxWbVdbacGXmmbdkoaJhkm/YRRLPm30EUnCpHHZgwtgXT3ph
         uvxuP36q4XVmIyAgqvC2VAZsWdlruiAuJdu1RGsdYlCrm+I17usJZoFoV2VkVCFRCInY
         e2hTQzNyMZNPOZyYm5pbbYtR0tDTKhyqG9XPN7TU4zSo3kUgkditt99gLlWW6+bHaFPj
         VBZtM5q4iZJtm7G3VRlLyr4EHJNByherjeX+jgkz56I1XpMjGAPzPZl7846aj2Iqk7p2
         dWtw==
X-Gm-Message-State: AO0yUKXRpRfcEruXqEfEQgJ8zVFQxib0/yulC9+hR25hhuw4sRRu/Olu
        JdzX/8rVnV1mAzYepLJ2Ax4=
X-Google-Smtp-Source: AK7set9aolhusX/PmFaEseHKB8tfkbfJcx/8fA5YeZ0OaHKrPcRid0K89cnxM2/CLstuGYynD1rjhA==
X-Received: by 2002:a9d:5f9d:0:b0:694:2f51:129b with SMTP id g29-20020a9d5f9d000000b006942f51129bmr7769218oti.24.1678288669514;
        Wed, 08 Mar 2023 07:17:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a16-20020a9d3e10000000b0068d752f1870sm6539288otd.5.2023.03.08.07.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 07:17:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0b467896-17d4-c355-da86-437b45f089d4@roeck-us.net>
Date:   Wed, 8 Mar 2023 07:17:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/3] drivers: watchdog: Add StarFive Watchdog driver
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20230308034036.99213-1-xingyu.wu@starfivetech.com>
 <20230308034036.99213-3-xingyu.wu@starfivetech.com>
 <CAJM55Z9LvQZjeEY92bZETBYhp9sSavTNkKT4T-gpsHPTQ2_LAA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAJM55Z9LvQZjeEY92bZETBYhp9sSavTNkKT4T-gpsHPTQ2_LAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 07:07, Emil Renner Berthing wrote:
> On Wed, 8 Mar 2023 at 04:43, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>>
>> Add watchdog driver for the StarFive JH7100 and JH7110 SoC.
>>
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> 
> Hi Xingyu,
> 
> Thanks for adding the JH7100 support. I tried it on my Starlight board
> and it seems to work fine except systemd complains about not being
> able to set a 10min timeout on reboot:
> systemd-shutdown[1]: Using hardware watchdog 'StarFive Watchdog',
> version 0, device /dev/watchdog0
> systemd-shutdown[1]: Failed to set timeout to 10min: Invalid argument
> systemd-shutdown[1]: Syncing filesystems and block devices.
> systemd-shutdown[1]: Sending SIGTERM to remaining processes...
> 
> The systemd runtime watchdog seems to work, so I guess this is just
> because 10min is too long a timeout for the StarFive watchdog.
> 

Correct, the driver would have to be implemented slightly differently
for the watchdog subsystem to accept larger timeout values.

> More comments below.
> 
>> ---
>>   MAINTAINERS                     |   7 +
>>   drivers/watchdog/Kconfig        |   9 +
>>   drivers/watchdog/Makefile       |   2 +
>>   drivers/watchdog/starfive-wdt.c | 675 ++++++++++++++++++++++++++++++++
>>   4 files changed, 693 insertions(+)
>>   create mode 100644 drivers/watchdog/starfive-wdt.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8d5bc223f305..721d0e4e8a0d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19962,6 +19962,13 @@ S:     Supported
>>   F:     Documentation/devicetree/bindings/rng/starfive*
>>   F:     drivers/char/hw_random/jh7110-trng.c
>>
>> +STARFIVE WATCHDOG DRIVER
>> +M:     Xingyu Wu <xingyu.wu@starfivetech.com>
>> +M:     Samin Guo <samin.guo@starfivetech.com>
>> +S:     Supported
>> +F:     Documentation/devicetree/bindings/watchdog/starfive*
>> +F:     drivers/watchdog/starfive-wdt.c
>> +
>>   STATIC BRANCH/CALL
>>   M:     Peter Zijlstra <peterz@infradead.org>
>>   M:     Josh Poimboeuf <jpoimboe@kernel.org>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index f0872970daf9..9d825ffaf292 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -2090,6 +2090,15 @@ config UML_WATCHDOG
>>          tristate "UML watchdog"
>>          depends on UML || COMPILE_TEST
>>
>> +config STARFIVE_WATCHDOG
>> +       tristate "StarFive Watchdog support"
>> +       depends on ARCH_STARFIVE || COMPILE_TEST
>> +       select WATCHDOG_CORE
>> +       default ARCH_STARFIVE
>> +       help
>> +         Say Y here to support the watchdog of StarFive JH7100 and JH7110
>> +         SoC. This driver can also be built as a module if choose M.
> 
> This file seems to be sorted by architecture, so you probably want to
> add something like this at the appropriate place
> 
> # RISC-V Architecture
> 
> config STARFIVE_WATCHDOG
> ...
> 
> 
>>   #
>>   # ISA-based Watchdog Cards
>>   #
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 9cbf6580f16c..4c0bd377e92a 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -211,6 +211,8 @@ obj-$(CONFIG_WATCHDOG_SUN4V)                += sun4v_wdt.o
>>   # Xen
>>   obj-$(CONFIG_XEN_WDT) += xen_wdt.o
>>
>> +obj-$(CONFIG_STARFIVE_WATCHDOG) += starfive-wdt.o
> 
> Again please follow the layout of the file. Eg. something like this at
> the appropriate place
> 
> # RISC-V Architecture
> obj-$(CONFIG_STARFIVE_WATCHDOG) += starfive-wdt.o
> 
>>   # Architecture Independent
>>   obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
>>   obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
>> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
>> new file mode 100644
>> index 000000000000..8ce9f985f068
>> --- /dev/null
>> +++ b/drivers/watchdog/starfive-wdt.c
>> @@ -0,0 +1,675 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Starfive Watchdog driver
>> + *
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/reset.h>
>> +#include <linux/watchdog.h>
>> +
>> +/* JH7100 Watchdog register define */
>> +#define STARFIVE_WDT_JH7100_INTSTAUS   0x000   /* RO: [4]: Watchdog Interrupt status */
>> +#define STARFIVE_WDT_JH7100_CONTROL    0x104   /* RW: reset enable */
>> +#define STARFIVE_WDT_JH7100_LOAD       0x108   /* RW: Watchdog Load register */
>> +#define STARFIVE_WDT_JH7100_EN         0x110   /* RW: Watchdog Enable Register */
>> +#define STARFIVE_WDT_JH7100_RELOAD     0x114   /* RW: Write 0 or 1 to reload preset value */
>> +#define STARFIVE_WDT_JH7100_VALUE      0x118   /* RO: The current value for watchdog counter */
>> +#define STARFIVE_WDT_JH7100_INTCLR     0x120   /*
>> +                                                * RW: Watchdog Clear Interrupt Register
>> +                                                * [0]: Write 1 to clear interrupt
>> +                                                * [1]: 1 mean clearing and 0 mean complete
>> +                                                */
>> +#define STARFIVE_WDT_JH7100_LOCK       0x13c   /* RW: Lock Register, write 0x378f0765 to unlock */
>> +
>> +/* JH7110 Watchdog register define */
>> +#define STARFIVE_WDT_JH7110_LOAD       0x000   /* RW: Watchdog Load register */
>> +#define STARFIVE_WDT_JH7110_VALUE      0x004   /* RO: The current value for watchdog counter */
>> +#define STARFIVE_WDT_JH7110_CONTROL    0x008   /*
>> +                                                * RW:
>> +                                                * [0]: reset enable;
>> +                                                * [1]: int enable/wdt enable/reload counter;
>> +                                                * [31:2]: reserved.
>> +                                                */
>> +#define STARFIVE_WDT_JH7110_INTCLR     0x00c   /* WO: clear intterupt && reload the counter */
>> +#define STARFIVE_WDT_JH7110_IMS                0x014   /* RO: Enabled interrupt status from the counter */
>> +#define STARFIVE_WDT_JH7110_LOCK       0xc00   /* RW: Lock Register, write 0x1ACCE551 to unlock */
> 
> Since these register offsets are only used to fill in the
> starfive_wdt_variant structures, consider just adding them directly
> there with the comments.
> 

As maintainer, I prefer defines, even if only used oonce.

Guenter

