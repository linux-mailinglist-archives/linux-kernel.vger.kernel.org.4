Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF436639B35
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 15:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiK0OEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 09:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0OEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 09:04:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9975210048
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:04:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 364F860CBA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 14:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2388CC433C1;
        Sun, 27 Nov 2022 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669557848;
        bh=XZEqzvQEXrdhfTpQFOEm3BwVsAhq0ArIWn0tCvG1gf8=;
        h=Date:From:To:Cc:Subject:From;
        b=DQvP9l5Za8qT4j33KkXYdaYodsiq8XJmis3pQ233S9wTOGG1/B5g7ZOjLdUyChUYD
         dtelRtMhskvA/lMuWgZ7NZz2yiKBl//Pdhamf/aOGh8CmPkJOL0cTP26ijNu7VwOpv
         hRhImgof1ojpeDqeeVBzJIAbm98tLU/8xJV4DnuA=
Date:   Sun, 27 Nov 2022 14:57:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.1-rc7
Message-ID: <Y4Ns3bc9AF2L1Bw7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.1-rc7

for you to fetch changes up to 8ac3b5cd3e0521d92f9755e90d140382fc292510:

  lib/vdso: use "grep -E" instead of "egrep" (2022-11-23 19:50:15 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 6.1-rc7

Here are some small driver fixes for 6.1-rc7, they include:
	- build warning fix for the vdso when using new versions of grep
	- iio driver fixes for reported issues
	- small nvmem driver fixes
	- fpga Kconfig fix
	- interconnect dt binding fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alejandro Concepción Rodríguez (1):
      iio: light: apds9960: fix wrong register for gesture gain

Billy Tsai (2):
      iio: adc: aspeed: Remove the trim valid dts property.
      dt-bindings: iio: adc: Remove the property "aspeed,trim-data-valid"

Chen Zhongjin (1):
      iio: core: Fix entry not deleted when iio_register_sw_trigger_type() fails

Dong Chenchen (1):
      iio: accel: bma400: Fix memory leak in bma400_get_steps_reg()

Greg Kroah-Hartman (4):
      Merge tag 'fpga-for-6.1-final' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into work-linus
      Merge tag 'iio-fixes-for-6.1c' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'icc-6.1-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus
      lib/vdso: use "grep -E" instead of "egrep"

Horatiu Vultur (1):
      nvmem: lan9662-otp: Change return type of lan9662_otp_wait_flag_clear()

Krzysztof Kozlowski (1):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Correct SC7280 CPU compatible

Paul Gazzillo (1):
      iio: light: rpr0521: add missing Kconfig dependencies

Russ Weight (1):
      fpga: m10bmc-sec: Fix kconfig dependencies

Wei Yongjun (3):
      iio: health: afe4403: Fix oob read in afe4403_read_raw
      iio: health: afe4404: Fix oob read in afe4404_[read|write]_raw
      nvmem: rmem: Fix return value check in rmem_read()

 .../devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml      |  7 -------
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml |  2 +-
 drivers/fpga/Kconfig                                         |  4 +++-
 drivers/iio/accel/bma400_core.c                              |  4 +++-
 drivers/iio/adc/aspeed_adc.c                                 | 11 +++++------
 drivers/iio/health/afe4403.c                                 |  5 +++--
 drivers/iio/health/afe4404.c                                 | 12 +++++++-----
 drivers/iio/industrialio-sw-trigger.c                        |  6 +++++-
 drivers/iio/light/Kconfig                                    |  2 ++
 drivers/iio/light/apds9960.c                                 | 12 ++++++------
 drivers/nvmem/lan9662-otpc.c                                 |  2 +-
 drivers/nvmem/rmem.c                                         |  4 ++--
 lib/vdso/Makefile                                            |  2 +-
 13 files changed, 39 insertions(+), 34 deletions(-)
