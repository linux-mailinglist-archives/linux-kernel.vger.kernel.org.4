Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAADB6A0455
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjBWJB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjBWJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:01:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677ED9038
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:01:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA63861620
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DE5C433EF;
        Thu, 23 Feb 2023 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677142883;
        bh=dz6gr3H9WtWPEo0tkI8j4/8XKd4WRZTWJZAJ1Gjjs/4=;
        h=Date:From:To:Cc:Subject:From;
        b=pTsAHh9kNo2jyEcQv0qZPxXYbWtSkN0OqprO7sCay0JBTuxZ2XjSD15dfOGWmM/As
         nv1l7IbxgDd6rgYgChqOgZrs86cVTRVuVea9uv++6HW4fLqaMSO1SoB7KTFt6LTzad
         QN3r6IV6ITxverscFxeBRKmBVMt2ATroyzQTX4qZako2YCOgiYPwaehEhcQ+DhUdNt
         oQ2SIj01xscnspnMZzjIQ0nIPuS+XkASaKn645bKMwBYHIbX3IW05pBxuA99UZvvAY
         bA/ap3ETgBqDwzSRfYIaA/5F5GzEcmG661vtLdKSSjPMzwXmoZH/U8+fESTia0+H7C
         AXHIIaew22Jtw==
Date:   Thu, 23 Feb 2023 09:01:19 +0000
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v6.3
Message-ID: <Y/crX1pmBC0wBefi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.3

for you to fetch changes up to ad614f81d2e8b9704478921935c75ccd4024b854:

  backlight: ktz8866: Convert to i2c's .probe_new() (2023-02-22 10:55:28 +0000)

----------------------------------------------------------------
 - New Drivers
   - Add support for Kinetic KTZ8866 Backlight

 - Remove Drivers
   - Toshiba Sharp SL-6000 LCD and Backlight

 - Fix-ups
   - Provide some profiling optimisations with respect to pwm_get_state() and pwm_apply_state()
   - Make use of the dev_err_probe() API
   - Provide some Device Tree documentation additions / adaptions
   - Drop fall-back legacy PWM probing support
   - Convert over to new I2C probing API
   - Fix incorrect documentation
   - Make use of backlight_get_brightness() API

 - Bug Fixes
   - Fix disabling backlight on i.MX6 when inverted PWMs are used

----------------------------------------------------------------
Arnd Bergmann (1):
      backlight: Remove pxa tosa support

Jianhua Lu (2):
      dt-bindings: leds: backlight: Add Kinetic KTZ8866 backlight
      backlight: ktz8866: Add support for Kinetic KTZ8866 backlight

Luca Weiss (1):
      dt-bindings: backlight: qcom-wled: Add PMI8950 compatible

Miaoqian Lin (1):
      backlight: backlight: Fix doc for backlight_device_get_by_name

Randy Dunlap (1):
      backlight: sky81452: Fix sky81452_bl_platform_data kernel-doc

Stephen Kitt (3):
      backlight: arcxcnn: Use backlight helper
      backlight: ipaq_micro: Use backlight helper
      backlight: aat2870: Use backlight helper

Uwe Kleine-König (4):
      backlight: pwm_bl: Drop support for legacy PWM probing
      backlight: pwm_bl: Configure pwm only once per backlight toggle
      backlight: pwm_bl: Don't rely on a disabled PWM emiting inactive state
      backlight: ktz8866: Convert to i2c's .probe_new()

Yang Yingliang (1):
      backlight: ktd253: Switch to use dev_err_probe() helper

 .../bindings/leds/backlight/kinetic,ktz8866.yaml   |  76 ++++++
 .../bindings/leds/backlight/qcom-wled.yaml         |   1 +
 MAINTAINERS                                        |   6 +
 drivers/video/backlight/Kconfig                    |  22 +-
 drivers/video/backlight/Makefile                   |   3 +-
 drivers/video/backlight/aat2870_bl.c               |   7 +-
 drivers/video/backlight/arcxcnn_bl.c               |   5 +-
 drivers/video/backlight/backlight.c                |   2 +-
 drivers/video/backlight/ipaq_micro_bl.c            |   7 +-
 drivers/video/backlight/ktd253-backlight.c         |   9 +-
 drivers/video/backlight/ktz8866.c                  | 208 +++++++++++++++
 drivers/video/backlight/pwm_bl.c                   |  68 +++--
 drivers/video/backlight/sky81452-backlight.c       |   2 +-
 drivers/video/backlight/tosa_bl.c                  | 172 -------------
 drivers/video/backlight/tosa_bl.h                  |   8 -
 drivers/video/backlight/tosa_lcd.c                 | 284 ---------------------
 include/linux/pwm_backlight.h                      |   1 -
 17 files changed, 339 insertions(+), 542 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
 create mode 100644 drivers/video/backlight/ktz8866.c
 delete mode 100644 drivers/video/backlight/tosa_bl.c
 delete mode 100644 drivers/video/backlight/tosa_bl.h
 delete mode 100644 drivers/video/backlight/tosa_lcd.c

-- 
Lee Jones [李琼斯]
