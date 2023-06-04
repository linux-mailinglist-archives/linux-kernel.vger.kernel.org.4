Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02FF72157F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 10:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjFDIFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 04:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjFDIFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:05:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A843BC4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 01:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CDA56123D
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 08:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52848C433EF;
        Sun,  4 Jun 2023 08:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685865942;
        bh=uKgw7J9h+ZOXY6KlyCueix1g2c074MzVz1cAgtOrLlo=;
        h=Date:From:To:Cc:Subject:From;
        b=tnr4r9i/sKgyZvp2v3yfselngubTbOHi+d5Uc0wyp/ySiSiIpnmDrwPiNJRxxC071
         w4DZV1XjEuXbPwOSAKCgUqKpDULJsWvyTZ/13xFEFaxmTtYJvdmoaX4wyahkKkhuJw
         J3gPM/s3VdGKKSZhkjwu8d/g2D90qreCm+qSoBEU=
Date:   Sun, 4 Jun 2023 10:05:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.4-rc5
Message-ID: <ZHxF1BbkBOaDv56j@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.4-rc5

for you to fetch changes up to 48e156023059e57a8fc68b498439832f7600ffff:

  test_firmware: fix the memory leak of the allocated firmware buffer (2023-05-31 20:31:07 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 6.4-rc5

Here are a bunch of tiny char/misc/other driver fixes for 6.4-rc5 that
resolve a number of reported issues.  Included in here are:
  - iio driver fixes
  - fpga driver fixes
  - test_firmware bugfixes
  - fastrpc driver tiny bugfixes
  - MAINTAINERS file updates for some subsystems

All of these have been in linux-next this past week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: iio: imx8qxp-adc: add missing vref-supply

ChiaEn Wu (1):
      iio: adc: mt6370: Fix ibus and ibat scaling value of some specific vendor ID chips

Dan Carpenter (3):
      iio: adc: imx93: fix a signedness bug in imx93_adc_read_raw()
      iio: adc: palmas: fix off by one bugs
      firmware_loader: Fix a NULL vs IS_ERR() check

Ekansh Gupta (2):
      misc: fastrpc: Pass proper scm arguments for secure map request
      misc: fastrpc: Reassign memory ownership only for remote heap

Frank Li (1):
      iio: light: vcnl4035: fixed chip ID check

Geert Uytterhoeven (1):
      dt-bindings: iio: adc: renesas,rcar-gyroadc: Fix adi,ad7476 compatible value

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-6.4a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus

Hans de Goede (1):
      iio: accel: st_accel: Fix invalid mount_matrix on devices without ACPI _ONT method

Ivan Bornyakov (2):
      MAINTAINERS: update Microchip MPF FPGA reviewers
      dt-bindings: fpga: replace Ivan Bornyakov maintainership

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: fix timestamp reset

Jiakai Luo (1):
      iio: adc: mxs-lradc: fix the order of two cleanup operations

Lars-Peter Clausen (2):
      iio: tmag5273: Fix runtime PM leak on measurement error
      iio: ad4130: Make sure clock provider gets removed

Lukas Bulwahn (1):
      iio: dac: build ad5758 driver when AD5758 is selected

Marek Vasut (1):
      iio: dac: mcp4725: Fix i2c_master_send() return value handling

Masahiro Honda (1):
      iio: adc: ad_sigma_delta: Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag

Matti Vaittinen (5):
      iio: fix doc for iio_gts_find_sel_by_int_time
      iio: bu27034: Fix integration time
      iio: gts-helpers: fix integration time units
      iio: bu27034: Ensure reset is written
      iio: accel: kx022a fix irq getting

Mirsad Goran Todorovac (3):
      test_firmware: prevent race conditions by a correct implementation of locking
      test_firmware: fix a memory leak with reqs buffer
      test_firmware: fix the memory leak of the allocated firmware buffer

Paul Cercueil (1):
      iio: adc: ad7192: Change "shorted" channels to differential

Rasmus Villemoes (1):
      iio: addac: ad74413: fix resistance input processing

Richard Acayan (2):
      misc: fastrpc: return -EPIPE to invocations on device removal
      misc: fastrpc: reject new invocations during device removal

Samuel Iglesias Gonsálvez (1):
      MAINTAINERS: Vaibhav Gupta is the new ipack maintainer

Sean Nyekjaer (2):
      iio: adc: stm32-adc: skip adc-diff-channels setup if none is present
      iio: adc: stm32-adc: skip adc-channels setup if none is present

 .../bindings/fpga/lattice,sysconfig.yaml           |  2 +-
 .../bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml  |  2 +-
 .../bindings/iio/adc/nxp,imx8qxp-adc.yaml          |  7 ++
 .../bindings/iio/adc/renesas,rcar-gyroadc.yaml     |  2 +-
 MAINTAINERS                                        |  4 +-
 drivers/base/firmware_loader/main.c                |  2 +-
 drivers/iio/accel/kionix-kx022a.c                  |  2 +-
 drivers/iio/accel/st_accel_core.c                  |  4 +-
 drivers/iio/adc/ad4130.c                           | 12 +++-
 drivers/iio/adc/ad7192.c                           |  8 +--
 drivers/iio/adc/ad_sigma_delta.c                   |  4 ++
 drivers/iio/adc/imx93_adc.c                        |  7 +-
 drivers/iio/adc/mt6370-adc.c                       | 53 +++++++++++++-
 drivers/iio/adc/mxs-lradc-adc.c                    | 10 +--
 drivers/iio/adc/palmas_gpadc.c                     | 10 +--
 drivers/iio/adc/stm32-adc.c                        | 61 ++++++++--------
 drivers/iio/addac/ad74413r.c                       |  2 +-
 drivers/iio/dac/Makefile                           |  2 +-
 drivers/iio/dac/mcp4725.c                          | 16 ++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 10 +--
 drivers/iio/industrialio-gts-helper.c              | 42 ++++++++---
 drivers/iio/light/rohm-bu27034.c                   | 26 +++++--
 drivers/iio/light/vcnl4035.c                       |  3 +
 drivers/iio/magnetometer/tmag5273.c                |  5 +-
 drivers/misc/fastrpc.c                             | 31 ++++++---
 include/linux/iio/iio-gts-helper.h                 |  2 +-
 lib/test_firmware.c                                | 81 +++++++++++++++++-----
 27 files changed, 295 insertions(+), 115 deletions(-)
