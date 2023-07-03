Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AC57459CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGCKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjGCKMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7576E4E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DD9760E98
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24C5C433C7;
        Mon,  3 Jul 2023 10:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688379123;
        bh=jaYt5qwu3mQMuo2IUBFzGxNvaZbcHubfDoaRB2I4BZ4=;
        h=Date:From:To:Cc:Subject:From;
        b=t8nFlu2pd+blUjGBdoN+7NqwfRWZ9k62btl58Qur8BHIeWO3OF6GBbJRf50n+kqr0
         cHvhimwXKRa+TIS/j9uwFfB2d0YA5WO5Nn6j/1YQiJCtI9qcUdJ/8byXmFlkVbkwLj
         oRjkIZ3aRgvP84/lN4jcNb8vipkw+Xx+Lm2GhIgGBkb0MV2b4caVRjgyxu3COeIc2G
         g01RHyw6YtKMgXiKJ0nPSaiQZxW7C5MpF1KGFQ8LUIeX1WGHiNMQLPgBrqGkYFiKnJ
         x3BnXkBagGfP4IJMx9UCBc73tSJTBMTbRzFFbRYDLY8xMzHGC3wSKUjb9tghoBjM87
         urzJIph6PvE/g==
Date:   Mon, 3 Jul 2023 11:11:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] Backlight for v6.5
Message-ID: <20230703101159.GC10359@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.5

for you to fetch changes up to a33677b9211b6c328ad359b072043af94f7c9592:

  backlight: led_bl: Take led_access lock when required (2023-06-26 16:29:42 +0100)

----------------------------------------------------------------
 - New Functionality
   - Add lots of Device Tree bindings / support
   - Turn off LED strings when display is blank
   - Switch I2C drivers from .probe_new() to .probe()
   - Remove superfluous NULL checks
   - Only obtain PWM information once and do it in .probe()

 - Fix-ups
   - Ensure locks are obtained and held when required

----------------------------------------------------------------
Artur Weber (2):
      dt-bindings: backlight: lp855x: Convert to YAML and modernize
      video: backlight: lp855x: Get PWM for PWM mode during probe

Geert Uytterhoeven (2):
      backlight: pwm_bl: Remove unneeded checks for valid GPIOs
      dt-bindings: backlight: pwm: Make power-supply not required

Jianhua Lu (1):
      dt-bindings: leds: backlight: ktz8866: Add reg property and update example

Mans Rullgard (1):
      backlight: led_bl: Take led_access lock when required

Maximilian Weigand (1):
      backlight: lm3630a: Turn off both led strings when display is blank

Uwe Kleine-König (1):
      backlight: Switch i2c drivers back to use .probe()

 .../bindings/leds/backlight/kinetic,ktz8866.yaml   |  29 ++--
 .../bindings/leds/backlight/lp855x-backlight.yaml  | 149 +++++++++++++++++++++
 .../devicetree/bindings/leds/backlight/lp855x.txt  |  72 ----------
 .../bindings/leds/backlight/pwm-backlight.yaml     |   1 -
 drivers/video/backlight/adp8860_bl.c               |   4 +-
 drivers/video/backlight/adp8870_bl.c               |   4 +-
 drivers/video/backlight/arcxcnn_bl.c               |   2 +-
 drivers/video/backlight/bd6107.c                   |   2 +-
 drivers/video/backlight/ktz8866.c                  |   2 +-
 drivers/video/backlight/led_bl.c                   |   5 +-
 drivers/video/backlight/lm3630a_bl.c               |  10 +-
 drivers/video/backlight/lm3639_bl.c                |   2 +-
 drivers/video/backlight/lp855x_bl.c                |  50 +++----
 drivers/video/backlight/lv5207lp.c                 |   2 +-
 drivers/video/backlight/pwm_bl.c                   |   9 +-
 15 files changed, 218 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x.txt

-- 
Lee Jones [李琼斯]
