Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6E9740557
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjF0Uyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjF0Uyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:54:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C41BE9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0B4161226
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 20:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2591FC433C8;
        Tue, 27 Jun 2023 20:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687899274;
        bh=5T9yNGajZohHz72pRMr120aN7AzpZSuen42By12MugM=;
        h=Date:From:To:cc:Subject:From;
        b=jmMfK55oLmH4pPY2kA3VpPjDcw405rBYiwDz2ACvggZ7FZ9+u1z/vzw2FeT7mxIQA
         xCYeSYbvLBtARjbHUitZLj9zvUIAEuNqJeFlju7UkSy3Mq8bNmB+a3s7KwYwEhMhmd
         WeqtvBKK/fZuw3AEPwcBy/DYopDyLt3rZmIAVq6L1CuX/7IY/+kW3mt11fzAH2ed7O
         lmLxkrMNCTxOV+4K0LSXZIXYyzctf8NMcVLpFd3InjDvAKTdmbbeZ9rU07pAj0+Ig4
         CEEGrFPGPWBn1QfwwSo/Xjqvjx1LXYpQ7p49vfaGD67l6fWT2+NiIXxQcpi+Y0iCse
         N6imyQxnDmjiQ==
Date:   Tue, 27 Jun 2023 22:54:30 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 6.5
Message-ID: <nycvar.YFH.7.76.2306272250390.5716@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023062701

to receive HID subsystem updates for 6.5.

=====
- more bullet-proof handling of devres-managed resources in HID core
  (Dmitry Torokhov)
- conversion of hid-wacom to use ktime_t (Jason Gerecke)
- touch selftests for hid-wacom (Joshua Dickens)
- support for nVidia Thunderstrike (SHIELD 2017) controller (Rahul 
  Rameshbabu)
- power management reset-during-suspend fix for goodix Chromebook
  devices (Fei Shao)
- assorted device ID additions, device-specific quirks and code cleanups
=====

Thanks.

----------------------------------------------------------------
Basavaraj Natikar (5):
      HID: amd_sfh: Remove unnecessary log
      HID: amd_sfh: Remove duplicate cleanup
      HID: amd_sfh: Split sensor and HID initialization
      HID: amd_sfh: Remove duplicate cleanup for SFH1.1
      HID: amd_sfh: Split sensor and HID initialization for SFH1.1

Dan Carpenter (1):
      HID: fix an error code in hid_check_device_match()

Dmitry Torokhov (2):
      HID: split apart hid_device_probe to make logic more apparent
      HID: ensure timely release of driver-allocated resources

Even Xu (1):
      HID: intel-ish-hid: ipc: Add Arrow Lake PCI device ID

Fei Shao (2):
      dt-bindings: input: goodix: Add "goodix,no-reset-during-suspend" property
      HID: i2c-hid: goodix: Add support for "goodix,no-reset-during-suspend" property

Geert Uytterhoeven (1):
      HID: uclogic: Modular KUnit tests should not depend on KUNIT=y

Jason Gerecke (1):
      HID: wacom: Use ktime_t rather than int when dealing with timestamps

Joshua Dickens (1):
      selftests: hid: Add touch tests for Wacom devices

Lasse Brun (1):
      HID: apple: Option to swap only left side mod keys

Ludvig Michaelsson (1):
      HID: hidraw: fix data race on device refcount

Luke D. Jones (3):
      HID: asus: Add support for ASUS ROG Z13 keyboard
      HID: asus: add keycodes for 0x6a, 0x4b, and 0xc7
      HID: asus: reformat the hotkey mapping block

Marco Morandini (1):
      HID: add quirk for 03f0:464a HP Elite Presenter Mouse

Mike Hommey (1):
      HID: logitech-hidpp: add HIDPP_QUIRK_DELAYED_INIT for the T651.

Rahul Rameshbabu (3):
      HID: nvidia-shield: Initial driver implementation with Thunderstrike support
      HID: nvidia-shield: Add mappings for consumer HID USAGE buttons
      HID: nvidia-shield: Support LED functionality for Thunderstrike

Siarhei Vishniakou (1):
      HID: microsoft: Add rumble support to latest xbox controllers

Uwe Kleine-König (1):
      HID: i2c-hid: Switch i2c drivers back to use .probe()

stuarthayhurst (1):
      HID: logitech-hidpp: Add USB and Bluetooth IDs for the Logitech G915 TKL Keyboard

 .../devicetree/bindings/input/goodix,gt7375p.yaml  |   9 +
 MAINTAINERS                                        |   6 +
 drivers/hid/Kconfig                                |  20 +-
 drivers/hid/Makefile                               |   1 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c           |  47 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c      |  24 +-
 drivers/hid/hid-apple.c                            |  13 +-
 drivers/hid/hid-asus.c                             |  42 +-
 drivers/hid/hid-core.c                             | 118 ++--
 drivers/hid/hid-ids.h                              |  15 +-
 drivers/hid/hid-logitech-hidpp.c                   |   6 +-
 drivers/hid/hid-microsoft.c                        |  11 +-
 drivers/hid/hid-nvidia-shield.c                    | 738 +++++++++++++++++++++
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/hid/hidraw.c                               |   9 +-
 drivers/hid/i2c-hid/i2c-hid-acpi.c                 |   2 +-
 drivers/hid/i2c-hid/i2c-hid-of-elan.c              |   2 +-
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c            |  18 +-
 drivers/hid/i2c-hid/i2c-hid-of.c                   |   2 +-
 drivers/hid/intel-ish-hid/ipc/hw-ish.h             |   1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |   1 +
 drivers/hid/wacom_wac.c                            |   6 +-
 drivers/hid/wacom_wac.h                            |   2 +-
 include/linux/hid.h                                |   1 +
 .../selftests/hid/tests/test_wacom_generic.py      |  84 ++-
 25 files changed, 1035 insertions(+), 144 deletions(-)
 create mode 100644 drivers/hid/hid-nvidia-shield.c

-- 
Jiri Kosina
SUSE Labs

