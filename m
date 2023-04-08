Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130C36DBAA7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjDHLuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjDHLuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B885FF2B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 04:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1478F60E07
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 11:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FEDC433EF;
        Sat,  8 Apr 2023 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680954598;
        bh=IBQG+8dg4afwdGQ+6tWzzbepfyfrQnecV2o+6V5mv7I=;
        h=Date:From:To:Cc:Subject:From;
        b=v6ZUVq0To67B3suEzLaV6VIR0xssPCh2qrYRLaGz2iytQhjuhnH0is0xxvWJTgG44
         xC1uZ0oUhfuwO7DKJW5gJHt+1ZmcnAPngkHe6ocEIKqSQ3kU3wwHFyry3f5w3u2I7L
         jHc9cIdHp83r3bUB7rZs2ua3kOpkiroT9co10rmw=
Date:   Sat, 8 Apr 2023 13:49:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver updates for 6.3-rc6
Message-ID: <ZDFU437akoy8b8cX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.3-rc6

for you to fetch changes up to 4bffd2c7a3fc165fc70bc69211b8e6436f41a5c3:

  Merge tag 'iio-fixes-for-6.3a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2023-03-28 13:30:55 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.3-rc6

Here are a small set of various small driver changes for 6.3-rc6.
Included in here are:
  - iio driver fixes for reported problems.
  - coresight hwtracing bugfix for reported problem
  - small counter driver bugfixes

All have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      iio: adc: qcom-spmi-adc5: Fix the channel name

Arnd Bergmann (1):
      iio: adis16480: select CONFIG_CRC32

Greg Kroah-Hartman (3):
      Merge tag 'counter-fixes-6.3a' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-linus
      Merge tag 'coresight-fixes-v6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-linus
      Merge tag 'iio-fixes-for-6.3a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus

Ian Ray (1):
      drivers: iio: adc: ltc2497: fix LSB shift

Kai-Heng Feng (1):
      iio: light: cm32181: Unregister second I2C client if present

Lars-Peter Clausen (1):
      iio: adc: ti-ads7950: Set `can_sleep` flag for GPIO chip

Mehdi Djait (1):
      iio: accel: kionix-kx022a: Get the timestamp from the driver's private data in the trigger_handler

Mårten Lindahl (1):
      iio: light: vcnl4000: Fix WARN_ON on uninitialized lock

Nuno Sá (4):
      iio: buffer: correctly return bytes written in output buffers
      iio: buffer: make sure O_NONBLOCK is respected
      iio: adc: ad7791: fix IRQ flags
      iio: adc: max11410: fix read_poll_timeout() usage

Patrik Dahlström (1):
      iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Steve Clevenger (1):
      coresight-etm4: Fix for() loop drvdata->nr_addr_cmp range bug

Suzuki K Poulose (1):
      coresight: etm4x: Do not access TRCIDR1 for identification

William Breathitt Gray (3):
      iio: dac: cio-dac: Fix max DAC write value check for 12-bit
      counter: 104-quad-8: Fix race condition between FLAG and CNTR reads
      counter: 104-quad-8: Fix Synapse action reported for Index signals

 drivers/counter/104-quad-8.c                       | 31 +++++++---------------
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 24 +++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.h      | 20 +++++---------
 drivers/iio/accel/kionix-kx022a.c                  |  2 +-
 drivers/iio/adc/ad7791.c                           |  2 +-
 drivers/iio/adc/ltc2497.c                          |  6 ++---
 drivers/iio/adc/max11410.c                         | 22 ++++++++++-----
 drivers/iio/adc/palmas_gpadc.c                     |  2 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   | 10 ++++++-
 drivers/iio/adc/ti-ads7950.c                       |  1 +
 drivers/iio/dac/cio-dac.c                          |  4 +--
 drivers/iio/imu/Kconfig                            |  1 +
 drivers/iio/industrialio-buffer.c                  | 21 ++++++++-------
 drivers/iio/light/cm32181.c                        | 12 +++++++++
 drivers/iio/light/vcnl4000.c                       |  3 ++-
 15 files changed, 84 insertions(+), 77 deletions(-)
