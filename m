Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E3462F22E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbiKRKJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiKRKJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:09:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2060FCD1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:09:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B100B82266
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C0CC433C1;
        Fri, 18 Nov 2022 10:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668766170;
        bh=mfYXSBCO5vBo5jJ93zbrEc+qduhALvWRS4JwXD0aCrw=;
        h=Date:From:To:Cc:Subject:From;
        b=Yt+XmIGzI3Cp8mAdHXRKZLsjhX1iWmm0u+WqAyJ3MZ/RQZ+e7fSqB4PmMwVeVu8DE
         ULV//A/6OvJGxFl/AHRjjEgbBwH+1l3izXc7nNcP9z7aEO1KuGQJKuUL/hn22r2oON
         hzXNJw7iXd4LGSCK2nrwXpAFX7LDPhvqoLBQK2ig=
Date:   Fri, 18 Nov 2022 10:28:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.1-rc6
Message-ID: <Y3dQKg/pGJZIYc3B@kroah.com>
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

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.1-rc6

for you to fetch changes up to 65946690ed8d972fdb91a74ee75ac0f0f0d68321:

  firmware: coreboot: Register bus in module init (2022-11-10 18:47:53 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 6.1-rc6

Here are some small char/misc and other driver fixes for 6.1-rc6 to
resolve some reported problems.  Included in here are:
	- iio driver fixes
	- binder driver fix
	- nvmem driver fix
	- vme_vmci information leak fix
	- parport fix
	- slimbus configuration fix
	- coreboot firmware bugfix
	- speakup build fix and crash fix

All of these have been in linux-next for a while with no reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Potapenko (1):
      misc/vmw_vmci: fix an infoleak in vmci_host_do_receive_datagram()

Brian Norris (1):
      firmware: coreboot: Register bus in module init

Carlos Llamas (1):
      binder: validate alloc->mm in ->mmap() handler

Christian Lamparter (1):
      nvmem: u-boot-env: fix crc32_data_offset on redundant u-boot-env

Claudiu Beznea (1):
      iio: adc: at91-sama5d2_adc: get rid of 5 degrees Celsius adjustment

Dan Carpenter (1):
      iio: imu: bno055: uninitialized variable bug in bno055_trigger_handler()

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-6.1b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus

Horatiu Vultur (1):
      nvmem: lan9662-otp: Fix compatible string

Jonathan Cameron (1):
      iio: accel: bma400: Ensure VDDIO is enable defore reading the chip ID.

Krzysztof Kozlowski (1):
      slimbus: stream: correct presence rate frequencies

Maciej W. Rozycki (1):
      parport_pc: Avoid FIFO port location truncation

Matti Vaittinen (1):
      tools: iio: iio_generic_buffer: Fix read size

Mitja Spes (2):
      iio: pressure: ms5611: fixed value compensation bug
      iio: pressure: ms5611: changed hardcoded SPI speed to value limited

Mushahid Hussain (1):
      speakup: fix a segfault caused by switching consoles

Saravanan Sekar (2):
      iio: adc: mp2629: fix wrong comparison of channel
      iio: adc: mp2629: fix potential array out of bound access

Shuah Khan (1):
      docs: update mediator contact information in CoC doc

Yang Yingliang (3):
      iio: trigger: sysfs: fix possible memory leak in iio_sysfs_trig_init()
      iio: adc: at91_adc: fix possible memory leak in at91_adc_allocate_trigger()
      siox: fix possible memory leak in siox_device_add()

Zheng Bin (1):
      slimbus: qcom-ngd: Fix build error when CONFIG_SLIM_QCOM_NGD_CTRL=y && CONFIG_QCOM_RPROC_COMMON=m

Đoàn Trần Công Danh (1):
      speakup: replace utils' u_char with unsigned char

 .../process/code-of-conduct-interpretation.rst     |  2 +-
 drivers/accessibility/speakup/main.c               |  2 +-
 drivers/accessibility/speakup/utils.h              |  2 +-
 drivers/android/binder_alloc.c                     |  7 +++
 drivers/firmware/google/coreboot_table.c           | 37 ++++++++++++----
 drivers/iio/accel/bma400_core.c                    | 24 +++++-----
 drivers/iio/adc/at91-sama5d2_adc.c                 |  6 +--
 drivers/iio/adc/at91_adc.c                         |  4 +-
 drivers/iio/adc/mp2629_adc.c                       |  5 ++-
 drivers/iio/imu/bno055/bno055.c                    |  2 +-
 drivers/iio/pressure/ms5611.h                      | 12 ++---
 drivers/iio/pressure/ms5611_core.c                 | 51 ++++++++++++----------
 drivers/iio/pressure/ms5611_spi.c                  |  2 +-
 drivers/iio/trigger/iio-trig-sysfs.c               |  6 ++-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |  2 +
 drivers/nvmem/lan9662-otpc.c                       |  2 +-
 drivers/nvmem/u-boot-env.c                         |  2 +-
 drivers/parport/parport_pc.c                       |  2 +-
 drivers/siox/siox-core.c                           |  2 +
 drivers/slimbus/Kconfig                            |  2 +-
 drivers/slimbus/stream.c                           |  8 ++--
 tools/iio/iio_generic_buffer.c                     |  4 +-
 22 files changed, 111 insertions(+), 75 deletions(-)
