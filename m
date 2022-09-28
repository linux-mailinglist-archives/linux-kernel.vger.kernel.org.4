Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1691F5EDD82
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiI1NKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiI1NKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:10:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AC06B65D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:10:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n10so19680026wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=aWDc3FZSpP0pXDr7h6JpnYW4HRCA6BYwKMpjmxISDls=;
        b=Xw3UBuj1im4a+jm12QauwQdyilLTlpn49Ql9aJQ5ET0e5tRs6cJhe6AYSL7Vy/XF9r
         26jRuqTBqZ0TKCOVA/fXUWA+1K0Qcedvb1Xzm5D7F2eLEvO/AhjnMa0L3E8ahsNqhqiv
         ZQs1SUTIi+P8wKWDekXIEPA8QTDozdVLMgc8ionWobHCvB5kHGESLd1lRf94RFRrOeFP
         Ns/Sd5xHTFmzp1gjAkJVcNlTs6A9iz7+CoSpY46KImffBztplqf2s2N7Lm157+FsngWN
         l8hVnh6q2IaiwyJJuo0lsu+uci/c6VvV0sADDuIEvvm8MALNZEEt0x0Pj5tcNwiqlxVf
         DZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=aWDc3FZSpP0pXDr7h6JpnYW4HRCA6BYwKMpjmxISDls=;
        b=zmdeOT2PvMGp0kofBa0RqMTZyti7SIT1/0b+q+N+lXA6tkeEzq1zm4tLWFDI9ARxiN
         49uRmLTFgDYWLqB8RrhPbkcQ5kcl3bButimt2wHDQVQHlRFDc3teB/bBhdDMzknnsLtT
         geIEq1B1woEsEPka1GQbcH2nQxAU3/Irx03tQFJ8RG08OvzALfuZrTDTbw6muxedjREv
         gsMQoVQYXEx+Joyg9UzZonyMwTd8fgIyfWylJ+xvCquBalwiLk1uePJXe1pe+GcFDgWA
         X/vYX0KvPzEFQM7LDthRMUblQd/3unxcLhuLxPX65lR0utxuXscgjbj+DkDOxrEqWZUd
         ITuA==
X-Gm-Message-State: ACrzQf3ycyR31Cx4W1kDFCwmMI+NoBT3fQPwhhnbv9btHfcI3fJQot41
        nbJ7I3sqBidj30xNRP6B/tZ2uA==
X-Google-Smtp-Source: AMsMyM4S6sWP7ARgvtTOpxfzcT/mn8ot2oXytsCQW1hmUmo7GhrguOv2v5ZD7lil4HW03HWJzjDSgA==
X-Received: by 2002:a5d:6c6e:0:b0:22a:c36d:e411 with SMTP id r14-20020a5d6c6e000000b0022ac36de411mr20174352wrz.183.1664370645628;
        Wed, 28 Sep 2022 06:10:45 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a3-20020a05600c348300b003b3365b38f9sm1762664wmq.10.2022.09.28.06.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 06:10:41 -0700 (PDT)
Message-ID: <b28ac4b0-5745-b3a9-b7e7-cc86dcb1b023@linaro.org>
Date:   Wed, 28 Sep 2022 15:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Victor Hassan <victor@allwinnertech.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>,
        Lin Yujun <linyujun809@huawei.com>,
        Tony Lindgren <tony@atomide.com>, Peng Fan <peng.fan@nxp.com>,
        Yang Guo <guoyang2@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v6.1-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

please consider the following changes for v6.1-rc1

Thanks
   -- Daniel


The following changes since commit cceeeb6a6d02e7b9a74ddd27a3225013b34174aa:

   wait: Fix __wait_event_hrtimeout for RT/DL tasks (2022-07-28 12:35:12 
+0200)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.1-rc1

for you to fetch changes up to af246cc6d0ed11318223606128bb0b09866c4c08:

   clocksource/drivers/arm_arch_timer: Fix CNTPCT_LO and CNTVCT_LO value 
(2022-09-27 11:30:53 +0200)

----------------------------------------------------------------
- Added DT bindings for Mediatek MT8188 (Johnson Wang)

- Added DT bindings for Renesas r8a779f0 (Wolfram Sang)

- Added support for RZ/V2L SoC (Lad Prabhakar)

- Rename TIMER_IRQ_EN to TIMER_IRQ_CLEAR to prevent confusion on sun4i
   (Victor Hassan)

- Added support for Exynos ARTPEC-8 MCT, including DT bindings
   (Vincent Whitchurch)

- Fixed handling of ARM erratum 858921 on the ARM Arch timer (Kunkun
   Jiang)

- Added missing call platform_device_put() in the error path on ther
   GXP timer (Lin Yujun)

- Cleaned the timer TI DM driver by self-encapsulating the code,
   dropping dead code and simplifying some functions (Tony Lindgren)

- Added a DT property to tell the driver the clock is no longer
   divided on recent NXP hardware (Peng Fan)

- Fixed the CNTPCT_LO and CNTVCT_LO values in the ARM arch timer (Yang
   Guo)

----------------------------------------------------------------
Johnson Wang (1):
       dt-bindings: timer: Add compatible for MediaTek MT8188

Kunkun Jiang (1):
       clocksource/drivers/arm_arch_timer: Fix handling of ARM erratum 
858921

Lad Prabhakar (1):
       clocksource/drivers/renesas-ostm: Add support for RZ/V2L SoC

Lin Yujun (1):
       clocksource/drivers/timer-gxp: Add missing error handling in 
gxp_timer_probe

Peng Fan (2):
       dt-bindings: timer: nxp,sysctr-timer: add nxp,no-divider property
       clocksource/drivers/imx-sysctr: handle nxp,no-divider property

Tony Lindgren (9):
       clocksource/drivers/timer-ti-dm: Drop unused functions
       clocksource/drivers/timer-ti-dm: Simplify register reads with 
dmtimer_read()
       clocksource/drivers/timer-ti-dm: Simplify register writes with 
dmtimer_write()
       clocksource/drivers/timer-ti-dm: Simplify register access further
       clocksource/drivers/timer-ti-dm: Move private defines to the driver
       clocksource/drivers/timer-ti-dm: Use runtime PM directly and 
check errors
       clocksource/drivers/timer-ti-dm: Move struct omap_dm_timer fields 
to driver
       clocksource/drivers/timer-ti-dm: Add flag to detect omap1
       clocksource/drivers/timer-ti-dm: Get clock in probe with 
devm_clk_get()

Victor Hassan (1):
       clocksource/drivers/sun4i: Add definition of clear interrupt

Vincent Whitchurch (4):
       dt-bindings: timer: exynos4210-mct: Add ARTPEC-8 MCT support
       clocksource/drivers/exynos_mct: Support frc-shared property
       clocksource/drivers/exynos_mct: Support local-timers property
       clocksource/drivers/exynos_mct: Enable building on ARTPEC

Wolfram Sang (1):
       dt-bindings: timer: renesas,tmu: Add r8a779f0 support

Yang Guo (1):
       clocksource/drivers/arm_arch_timer: Fix CNTPCT_LO and CNTVCT_LO value

  .../bindings/timer/mediatek,mtk-timer.txt          |   1 +
  .../bindings/timer/nxp,sysctr-timer.yaml           |   4 +
  .../devicetree/bindings/timer/renesas,tmu.yaml     |   1 +
  .../bindings/timer/samsung,exynos4210-mct.yaml     |  26 +
  drivers/clocksource/Kconfig                        |   2 +-
  drivers/clocksource/arm_arch_timer.c               |   6 +-
  drivers/clocksource/exynos_mct.c                   |  83 ++-
  drivers/clocksource/renesas-ostm.c                 |   2 +-
  drivers/clocksource/timer-gxp.c                    |   7 +-
  drivers/clocksource/timer-imx-sysctr.c             |   6 +-
  drivers/clocksource/timer-sun4i.c                  |   3 +-
  drivers/clocksource/timer-ti-dm.c                  | 681 
+++++++++++++--------
  include/clocksource/timer-ti-dm.h                  | 112 ----
  13 files changed, 553 insertions(+), 381 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
