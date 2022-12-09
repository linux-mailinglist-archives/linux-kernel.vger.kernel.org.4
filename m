Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5F66484E8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiLIPVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLIPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:21:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F24A86F6E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:21:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m4-20020a05600c3b0400b003d1cb516ce0so54129wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvIg7h2BvXioV8AhHgWPqOCsPqInD17Pn5nCSXdP9EM=;
        b=D8EyDLBtFb08otkSEL+mEnrCHj1fetzhsYTpuNxKO9nbSrb1+w3OqIY5Py3m4AzkPx
         JeTuKU4KKocIAQoDGYF6RqA4exYQj2UQ6t7rjrV2OEsLo7rCTKT88XgNgKSPV6GuHntR
         tFfscv8+br/bFJT4tKoAwdmEWXasbAWBr7wxuxSSQnX6/bAGiubWsAXUO+aDsraeel1/
         Jo/T/c3BcVOl1V49av5ZMJCVqMMv4nGeI94infmr45vDOyKERvQT+F5EvlR1Y9+uBBy3
         95JprFNXmG3xy+X9VaTug3GOqYzZ7VZ9BNE080Wf13TjJIkHZtbQAtnY8tU3xv1Y1Kzp
         y3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rvIg7h2BvXioV8AhHgWPqOCsPqInD17Pn5nCSXdP9EM=;
        b=QAqxPBCqMi5gnDtlhyCotHv1LWDg+YLr1iuX4NW66S/ARrMIKC0u1qcRPfUnkVcfMO
         Ma0/O61wYp9B1kx1o545bMEFEFsxW9w+gHAJrpQrDquRXjzRftuDe2qPEUrz0ABq6q72
         C/7q06mSOjOBbXNVkbVfOd/Y8y2egGVBsirrVYDhGmrdl9I3o5E9fVAVr0tTzMsT4Cww
         Y1KNwmaCG/tifjG5nZqKVkQ3luenJQ+fhfZLAIkSbZzwfphA35Lu65dc02paRjlFItcQ
         q7DUxnN/klWR3lMmmeSc9pE/dwidAxRfLqOPpIfsOngRdlvnrl0Oy8AgP7zPgh14nZ9c
         VvBw==
X-Gm-Message-State: ANoB5pkzH6zk+ipT+VWC3MUHAwWejV34D+cdvkMxrqbSY4+YIJhS5YdQ
        iU5IHNeTnFDWMYZLDzpfNBYUrNd5hQSeT0yZ
X-Google-Smtp-Source: AA0mqf7K2H/0dhlg3XkLsX0/tBlV8TabcQ9qix1g1SVXgDwhcCXpqtanJ0U95p2etGuYo91wPiDB2Q==
X-Received: by 2002:a05:600c:4f05:b0:3cf:674a:aefe with SMTP id l5-20020a05600c4f0500b003cf674aaefemr5627790wmq.22.1670599273726;
        Fri, 09 Dec 2022 07:21:13 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r5-20020a05600c35c500b003a2f2bb72d5sm2214wmq.45.2022.12.09.07.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 07:21:13 -0800 (PST)
Message-ID: <3c4c3bb2-b849-0c87-0948-8a36984bdde4@linaro.org>
Date:   Fri, 9 Dec 2022 16:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Tony Lindgren <tony@atomide.com>,
        Joe Korty <joe.korty@concurrent-rt.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIt PULL] timer drivers for v6.2-rc1
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

here is the PR for v6.2-rc1.

After a long leave, I hope I did not miss some patches :/

Have a nice day

   -- Daniel

The following changes since commit ebe11732838f39bd10bddafd4dfe2f97010fde62:

   clockevents: Repair kernel-doc for clockevent_delta2ns() (2022-12-01 
13:35:41 +0100)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.2-rc1

for you to fetch changes up to 83571a4389039b1be2d77655b2ce47543d407e41:

   dt-bindings: timer: renesas,cmt: Add r8a779g0 CMT support (2022-12-02 
13:42:32 +0100)

----------------------------------------------------------------
- Add DT bindings for the Rockchip rk3128 timer (Johan Jonker)

- Change the DT bindings for the npcm7xx timer in order to specify
   multiple clocks and enable the clock for the timer1 on WPCM450
   (Jonathan Neuschäfer)

- Fix the timer duration being too long the ARM architected timer in
   order to prevent an integer overflow leading to a negative value and
   an immediate interruption (Joe Korty)

- Fix an unused pointer warning reported by lkp and some cleanups in
   the timer TI dm (Tony Lindgren)

- Fix a missing call to clk_disable_unprepare() in the error path at
   init time on the timer TI dm (Yang Yingliang)

- Use kstrtobool() instead of strtobool() in the ARM architected timer
   (Christophe JAILLET)

- Add DT bindings for r8a779g0 on Renesas platform (Wolfram Sang)

----------------------------------------------------------------
Christophe JAILLET (1):
       clocksource/drivers/arm_arch_timer: Use kstrtobool() instead of 
strtobool()

Joe Korty (1):
       clocksource/drivers/arm_arch_timer: Fix XGene-1 TVAL register 
math error

Johan Jonker (1):
       dt-bindings: timer: rockchip: Add rockchip,rk3128-timer

Jonathan Neuschäfer (2):
       dt-bindings: timer: nuvoton,npcm7xx-timer: Allow specifying all 
clocks
       clocksource/drivers/timer-npcm7xx: Enable timer 1 clock before use

Tony Lindgren (3):
       clocksource/drivers/timer-ti-dm: Fix warning for omap_timer_match
       clocksource/drivers/timer-ti-dm: Make timer_get_irq static
       clocksource/drivers/timer-ti-dm: Clear settings on probe and free

Wolfram Sang (2):
       dt-bindings: timer: renesas,tmu: Add r8a779g0 support
       dt-bindings: timer: renesas,cmt: Add r8a779g0 CMT support

Yang Yingliang (1):
       clocksource/drivers/timer-ti-dm: Fix missing 
clk_disable_unprepare in dmtimer_systimer_init_clock()

  .../bindings/timer/nuvoton,npcm7xx-timer.yaml       |  8 +++++++-
  .../devicetree/bindings/timer/renesas,cmt.yaml      |  2 ++
  .../devicetree/bindings/timer/renesas,tmu.yaml      |  1 +
  .../bindings/timer/rockchip,rk-timer.yaml           |  1 +
  drivers/clocksource/arm_arch_timer.c                | 10 +++++++---
  drivers/clocksource/timer-npcm7xx.c                 | 10 ++++++++++
  drivers/clocksource/timer-ti-dm-systimer.c          |  4 +++-
  drivers/clocksource/timer-ti-dm.c                   | 21 
+++++++++++++++++++--
  include/clocksource/timer-ti-dm.h                   |  2 --
  9 files changed, 50 insertions(+), 9 deletions(-)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
