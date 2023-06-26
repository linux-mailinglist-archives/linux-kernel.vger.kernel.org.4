Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E2A73DAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjFZJFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjFZJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:04:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC34172B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:00:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa7512e599so38574185e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687770039; x=1690362039;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWuRpgBJ6l/Pv7FEU0LOn4g2AJlmwxkqUVtV4vBWbo0=;
        b=dCouLOJEMAHZhupYzWJn4YCs1cfYGA6w/i1YDJ9hurs7r4T8/Wuwu1PtGIUPFxKzM1
         hBTpiBsTwJXCzHnAjtAUJnOVzbh2Yw4kq5J972WPrdmxokV6c4EIwgdC7rBZEWfu/MNL
         2BXlcxZvTpFvKE0ZG4yPqrCZ6EWF3UcqQgtxykRc1AZMaNHM/YbRZK61wT6ztTsEbZYf
         /S+xYwrMKPGSm3+RjBF5fV5GwKO5gugJkcGZ0NLgdbJS5nxOF99Wq45vjLKNmGm3KF8Y
         8g2Lql5bv7Sa14oo8l4jIL40U+4FSmVoQ3SZyjrRjZehcm1J93MqxFOMdCVwS1US6/tI
         pxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687770039; x=1690362039;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lWuRpgBJ6l/Pv7FEU0LOn4g2AJlmwxkqUVtV4vBWbo0=;
        b=AirvJn7ug/WbYpYr5aTRfLGlooxkzLhiWJCdILi96Ee3TEBKEJP2TbE2kOXjDkHSbJ
         FyAI4R4mzuH2ampF0kvoXP/wGUhlNg9zFrZD4yetsMzmqATrDjZz/liai1tWhbH3Knz8
         tRKyaoby0Z4roNEMZwFRICQQxEjlLGk/FnMmsB+zPWkLhMKQ194BAC6fD5/yzKWwqTrU
         bjnHz8AB7Z3YKHoI7C4hoc0Uj8JfuIEjMs7vhCOG/LLmJ9gnnjhnoN+pv8rtmSftzr/Z
         dG9ulHjcmxGqqO8of7ZWRLlhasZzgJySTfsWh1PNrnoMuDYbBPSVdCt2BHgF7aWDbEEm
         W5nA==
X-Gm-Message-State: AC+VfDx6EEkCy9KSTKFeUzkjOmShmI0hnPKLLGLwbxPu/6oDIhvYkuVG
        3qqORgQBHyxVKPa2mlc1rDB2+w==
X-Google-Smtp-Source: ACHHUZ5U/GAew0W09eAQvVrbahBMRJNntgHXBQfHSojJ5cVjw3dCL3DIOzCNiDRhe9j7MBz7E77LaA==
X-Received: by 2002:a7b:c392:0:b0:3fa:8fb1:50fe with SMTP id s18-20020a7bc392000000b003fa8fb150femr2344346wmj.15.1687770039100;
        Mon, 26 Jun 2023 02:00:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k1-20020a05600c0b4100b003fa82210e7asm7100396wmr.14.2023.06.26.02.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 02:00:38 -0700 (PDT)
Message-ID: <c0d4cc77-149e-9a59-4093-b5ba9b2361ae@linaro.org>
Date:   Mon, 26 Jun 2023 11:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Mingxi <m202271825@hust.edu.cn>,
        Paul Cercueil <paul@crapouillou.net>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v6.5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

sorry for not sending the pull request earlier, I've been overwhelmed by 
a lot of stuff.

Please consider the following changes since commit 
2951580ba6adb082bb6b7154a5ecb24e7c1f7569:

   tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode(). 
(2023-06-19 09:09:14 +0200)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.5-rc1

for you to fetch changes up to 8b5bf64c89c7100c921bd807ba39b2eb003061ab:

   clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe 
(2023-06-23 09:33:44 +0200)

----------------------------------------------------------------
- Fix memory leak on Cadence TTC at probe time (Feng Mingxi)

- Use the pm_sleep_ptr macro for the Ingenic driver (Paul Cercueil)

- Relocate the PMW timer Loongson from the mips arch directory to the
   drivers/clocksource (Keguang Zhang)

- Use the same function names instead of using aliases and move data
   defined in the header to the driver directly as this one is the only
   user of the header file and remove this one on i.MX GPT (Uwe
   Kleine-König)

- Convert Broadcom Kona family timer bindings to DT schema (Michael
    Kelley)

- Add DT bindings for Ralink SoCs timer (Sergio Paracuellos)

----------------------------------------------------------------
Feng Mingxi (1):
       clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe

Keguang Zhang (3):
       MIPS: Loongson32: Remove deprecated PWM timer clocksource
       dt-bindings: timer: Add Loongson-1 clocksource
       clocksource/drivers/loongson1: Move PWM timer to clocksource 
framework

Michael Kelley (1):
       clocksource/drivers/hyper-v: Rework clocksource and sched clock setup

Paul Cercueil (1):
       clocksource/drivers/ingenic-timer: Use pm_sleep_ptr() macro

Sergio Paracuellos (1):
       dt-bindings: timers: Add Ralink SoCs timer

Stanislav Jakubek (1):
       dt-bindings: timer: brcm,kona-timer: convert to YAML

Uwe Kleine-König (3):
       clocksource/drivers/imx-gpt: Use only a single name for functions
       clk: imx: Drop inclusion of unused header <soc/imx/timer.h>
       clocksource/drivers/imx-gpt: Fold <soc/imx/timer.h> into its only 
user

  .../devicetree/bindings/timer/brcm,kona-timer.txt  |  25 ---
  .../devicetree/bindings/timer/brcm,kona-timer.yaml |  52 +++++
  .../bindings/timer/loongson,ls1x-pwmtimer.yaml     |  48 +++++
  .../bindings/timer/ralink,rt2880-timer.yaml        |  44 ++++
  arch/mips/include/asm/mach-loongson32/loongson1.h  |   1 -
  arch/mips/include/asm/mach-loongson32/regs-pwm.h   |  25 ---
  arch/mips/loongson32/Kconfig                       |  37 ----
  arch/mips/loongson32/common/time.c                 | 210 
------------------
  drivers/clk/imx/clk-imx1.c                         |   1 -
  drivers/clk/imx/clk-imx27.c                        |   1 -
  drivers/clk/imx/clk-imx31.c                        |   1 -
  drivers/clk/imx/clk-imx35.c                        |   1 -
  drivers/clocksource/Kconfig                        |   9 +
  drivers/clocksource/Makefile                       |   1 +
  drivers/clocksource/hyperv_timer.c                 |  54 ++---
  drivers/clocksource/ingenic-timer.c                |  10 +-
  drivers/clocksource/timer-cadence-ttc.c            |  19 +-
  drivers/clocksource/timer-imx-gpt.c                |  25 ++-
  drivers/clocksource/timer-loongson1-pwm.c          | 236 
+++++++++++++++++++++
  include/soc/imx/timer.h                            |  16 --
  20 files changed, 442 insertions(+), 374 deletions(-)
  delete mode 100644 
Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
  create mode 100644 
Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml
  create mode 100644 
Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
  create mode 100644 
Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
  delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-pwm.h
  create mode 100644 drivers/clocksource/timer-loongson1-pwm.c
  delete mode 100644 include/soc/imx/timer.h

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
