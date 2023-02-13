Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142DA694614
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjBMMmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBMMmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:42:50 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDF31724
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:42:49 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8913646wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvL71k5Jx+BlFqsoEI2lI0Qh0UvBQ8+reA91Ml9+t3k=;
        b=Hxh3Iea3+hfvlQwHqKpNQJffyWcsh6VP5y7MQr1BVtQOaMT3VMQ7l4wQHT1l3ZjNEc
         ei9QQMyDzR8PD/uXFHkPQZE/Jf0eaWiHRdry6sziiBk6CEE3Z/5ZGFjPVA2GYoiTGgMW
         WGZwql/Jg/iHk8TIw8ZHUQU61hh7+sdlkhkxjfN8YNucYrZOzSdmShvcm7X2s/H1GhcT
         F5AwFbv9hFsCfspguU42riZ0n3nQjgU5zQPcLbYDR01lF3HokO3BQwr6FYLCdVte8NJB
         zLqbVIakEq/7XRM5k5Rm0Ox64i9C29ThF/pAhakHhlQaPB5mz9jPptuFAybS+xw70nn8
         6Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pvL71k5Jx+BlFqsoEI2lI0Qh0UvBQ8+reA91Ml9+t3k=;
        b=PkD/hNJ0ujL5YyEFifviG/t7qNlGri/3L8Qbf9dCQLVKAmhFjTyxf4V021xyuJHRGP
         huAj+9Srg0F0mYSDef28oHMqf6crw4ocXCYhqkoJLPrGDrkMAvCwXLgdrCGTsaoINP1b
         XVvWGfB8uxmFy7Vrg1VTOCOLUngWwhwP0b3rmTgPDZu8c5bc8bqik72sJjJlz5iwuZES
         Y4qkQp8RY1PU7wX/o6OnOjt0PA8ucYsI/dMPy79OZ1pVQ037TCfIQsA5HfvO/NYzH78K
         f0+rIXmGn/GqAOHtiFg+CCt/KB5B6ivLpUEIbVd6inoxkUWSROLfKqnO3t6DV6WHSFmH
         3QCw==
X-Gm-Message-State: AO0yUKWUuFQltFLwrFMhwK2B32P6vw1Ya4BvlCrctIEMN+udwxihAfuf
        k1hEb96yeSbtTEbnJ4LL2L53iA==
X-Google-Smtp-Source: AK7set+FxgOCoAaPI4MoRMO7pj4tL+FE0l1eF+6O3sLrdTTB8GkUTFuJF3XfyHKfVFIPe8X7i2SGuw==
X-Received: by 2002:a05:600c:16c4:b0:3da:270b:ba6b with SMTP id l4-20020a05600c16c400b003da270bba6bmr20334892wmn.41.1676292167858;
        Mon, 13 Feb 2023 04:42:47 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g10-20020a05600c310a00b003e1e8d794e1sm5026473wmo.13.2023.02.13.04.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:42:47 -0800 (PST)
Message-ID: <b7d1d982-d717-2930-b353-19b92cbe390f@linaro.org>
Date:   Mon, 13 Feb 2023 13:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jagan Teki <jagan@edgeble.ai>, Conor Dooley <conor@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel@sholland.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jean Delvare <jdelvare@suse.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Yangtao Li <frank.li@vivo.com>, Matt Evans <mev@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers changes for v6.3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,


The following changes since commit 5b268d8abaec6cbd4bd70d062e769098d96670aa:

   time/debug: Fix memory leak with using debugfs_lookup() (2023-02-09 
20:12:27 +0100)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.3-rc1

for you to fetch changes up to 5ccb51b06c8bfcfca99d3f68e671eead7318301d:

   clocksource/drivers/timer-sun4i: Add CLOCK_EVT_FEAT_DYNIRQ 
(2023-02-13 13:10:17 +0100)

----------------------------------------------------------------
- Add rktimer for rv1126 Rockchip based board (Jagan Teki)

- Initialize hrtimer based broadcast clock event device on RISC-V
   before C3STOP can be used (Conor Dooley)

- Add DT binding for RISC-V timer and add the C3STOP flag if the DT
   tells the timer can not wake up the CPU (Anup Patel)

- Increase the RISC-V timer rating as it is more efficient than mmio
   timers (Samuel Holland)

- Drop obsolete dependency on COMPILE_TEST on microchip-pit64b as the
   OF is already depending on it (Jean Delvare)

- Mark sh_cmt, sh_tmu, em_sti drivers as non-removable (Uwe
   Kleine-König)

- Add binding description for mediatek,mt8365-systimer (Bernhard
   Rosenkränzer)

- Add compatibles for T-Head's C9xx (Icenowy Zheng)

- Restrict the microchip-pit64b compilation to the ARM architecture
   and add the delay timer (Claudiu Beznea)

- Set the static key to select the SBI or Sstc timer sooner to prevent
   the first call to use the SBI while Sstc must be used (Matt Evans)

- Add the CLOCK_EVT_FEAT_DYNIRQ flag to optimize the timer wake up on
   the sun4i platform (Yangtao Li)

----------------------------------------------------------------
Anup Patel (2):
       dt-bindings: timer: Add bindings for the RISC-V timer device
       clocksource/drivers/timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based 
on DT

Bernhard Rosenkränzer (1):
       dt-bindings: timer: mediatek,mtk-timer: add MT8365

Claudiu Beznea (2):
       clocksource/drivers/timer-microchip-pit64b: Select driver only on ARM
       clocksource/drivers/timer-microchip-pit64b: Add delay timer

Conor Dooley (1):
       RISC-V: time: initialize hrtimer based broadcast clock event device

Icenowy Zheng (1):
       dt-bindings: timer: sifive,clint: add comaptibles for T-Head's C9xx

Jagan Teki (1):
       dt-bindings: timer: rk-timer: Add rktimer for rv1126

Jean Delvare (1):
       clocksource/drivers/timer-microchip-pit64b: Drop obsolete 
dependency on COMPILE_TEST

Lad Prabhakar (1):
       clocksource/drivers/riscv: Get rid of clocksource_arch_init() 
callback

Matt Evans (1):
       clocksource/drivers/riscv: Patch riscv_clock_next_event() jump 
before first use

Samuel Holland (1):
       clocksource/drivers/riscv: Increase the clock source rating

Uwe Kleine-König (3):
       clocksource/drivers/sh_cmt: Mark driver as non-removable
       clocksource/drivers/sh_tmu: Mark driver as non-removable
       clocksource/drivers/em_sti: Mark driver as non-removable

Yangtao Li (1):
       clocksource/drivers/timer-sun4i: Add CLOCK_EVT_FEAT_DYNIRQ

  .../bindings/timer/mediatek,mtk-timer.txt          |  1 +
  .../devicetree/bindings/timer/riscv,timer.yaml     | 52 
++++++++++++++++++++++
  .../bindings/timer/rockchip,rk-timer.yaml          |  1 +
  .../devicetree/bindings/timer/sifive,clint.yaml    |  8 ++++
  arch/riscv/Kconfig                                 |  1 -
  arch/riscv/kernel/time.c                           | 10 +----
  drivers/clocksource/Kconfig                        |  2 +-
  drivers/clocksource/em_sti.c                       |  7 +--
  drivers/clocksource/sh_cmt.c                       |  7 +--
  drivers/clocksource/sh_tmu.c                       |  7 +--
  drivers/clocksource/timer-microchip-pit64b.c       | 12 +++++
  drivers/clocksource/timer-riscv.c                  | 27 ++++++++---
  drivers/clocksource/timer-sun4i.c                  |  3 +-
  13 files changed, 103 insertions(+), 35 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/timer/riscv,timer.yaml


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
