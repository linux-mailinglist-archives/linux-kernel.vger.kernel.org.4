Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862D9612AED
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 15:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ3OKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3OKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 10:10:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4A7B4A7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 07:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6414AB80D3E
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00B7C433D6;
        Sun, 30 Oct 2022 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667139049;
        bh=LjP7hZQaK3z2TLA+ghezmzjZYSn/DOpKnGqgDaaQaW4=;
        h=Date:From:To:Cc:Subject:From;
        b=wZi3bLYaiQ5YIs+lBUbybaJjAhPasAwe6N/jGVQ/7s4GOxzh6B7I0Cgh3o87TsJnL
         RVOrvvfrFYT932/cLH7XIsH1yUNU1DanTqptr2r7QahO6mkoz6ZjumJGfCYNV61K8J
         PH/59Bn63MH1t3cAHxybtKr0qSyLXOVoVFK7ZKIE=
Date:   Sun, 30 Oct 2022 15:11:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.1-rc3
Message-ID: <Y16GIJg2y/3M9Xbt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.1-rc3

for you to fetch changes up to 677047383296ea25fdfc001be3cdcdf5cc874be2:

  misc: sgi-gru: use explicitly signed char (2022-10-25 19:12:10 +0200)

----------------------------------------------------------------
Char/Misc fixes for 6.1-rc3

Here are some small driver fixes for 6.1-rc3.  They include:
	- iio driver bugfixes
	- counter driver bugfixes
	- coresight bugfixes, including a revert and then a second
	  fix to get it right.

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Cosmin Tanislav (1):
      iio: temperature: ltc2983: allocate iio channels once

Dan Carpenter (2):
      iio: adc: mcp3911: fix sizeof() vs ARRAY_SIZE() bug
      counter: ti-ecap-capture: fix IS_ERR() vs NULL check

Greg Kroah-Hartman (4):
      Merge tag 'coresight-fixes-v6.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      Merge tag 'iio-fixes-for-6.1a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus
      Revert "coresight: cti: Fix hang in cti_disable_hw()"
      Merge tag 'counter-fixes-for-6.1a' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-linus

James Clark (2):
      coresight: cti: Fix hang in cti_disable_hw()
      coresight: cti: Fix hang in cti_disable_hw()

Jason A. Donenfeld (1):
      misc: sgi-gru: use explicitly signed char

Marcus Folkesson (3):
      iio: adc: mcp3911: return proper error code on failure to allocate trigger
      iio: adc: mcp3911: use correct id bits
      iio: adc: mcp3911: mask out device ID in debug prints

Matti Vaittinen (5):
      tools: iio: iio_utils: fix digit calculation
      iio: at91-sama5d2_adc: Fix unsafe buffer attributes
      iio: adxl372: Fix unsafe buffer attributes
      iio: adxl367: Fix unsafe buffer attributes
      iio: bmc150-accel-core: Fix unsafe buffer attributes

Olivier Moysan (1):
      iio: adc: stm32-adc: fix channel sampling time init

Shreeya Patel (1):
      iio: light: tsl2583: Fix module unloading

Sudeep Holla (1):
      coresight: Fix possible deadlock with lock dependency

William Breathitt Gray (3):
      counter: Reduce DEFINE_COUNTER_ARRAY_POLARITY() to defining counter_array
      counter: microchip-tcb-capture: Handle Signal1 read and Synapse
      counter: 104-quad-8: Fix race getting function mode and direction

 drivers/counter/104-quad-8.c                     | 64 ++++++++++++++++--------
 drivers/counter/microchip-tcb-capture.c          | 18 +++++--
 drivers/counter/ti-ecap-capture.c                |  7 +--
 drivers/hwtracing/coresight/coresight-core.c     |  7 +--
 drivers/hwtracing/coresight/coresight-cti-core.c | 10 ++--
 drivers/iio/accel/adxl367.c                      | 23 +++++++--
 drivers/iio/accel/adxl372.c                      | 23 +++++++--
 drivers/iio/accel/bmc150-accel-core.c            | 23 +++++++--
 drivers/iio/adc/at91-sama5d2_adc.c               | 23 +++++++--
 drivers/iio/adc/mcp3911.c                        | 13 ++---
 drivers/iio/adc/stm32-adc.c                      | 11 ++--
 drivers/iio/light/tsl2583.c                      |  2 +-
 drivers/iio/temperature/ltc2983.c                | 13 +++--
 drivers/misc/sgi-gru/grumain.c                   |  6 +--
 drivers/misc/sgi-gru/grutables.h                 | 14 +++---
 include/linux/counter.h                          |  5 +-
 tools/iio/iio_utils.c                            |  4 ++
 17 files changed, 175 insertions(+), 91 deletions(-)
