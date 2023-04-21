Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E0D6EAAB4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjDUMoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjDUMno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E61AD322
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF6F865048
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D717CC4339B;
        Fri, 21 Apr 2023 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682080992;
        bh=wZUJL0ot3BY3ul97b9ZJj5/rYeOtV1g665q0bfb+5mE=;
        h=Date:From:To:Cc:Subject:From;
        b=toUi93YUwN1w14v8+tYN0ka9D8n0WVeUQx+WAtq8gdPdMgYpgzJUS4UJ9iL44a90f
         x+kRUQhop5JyMnfRYUmbYStfp3xTuNts0Xi4LiMNl0Li5TnXNMm+yMt3tVh6w9FkIG
         lNJXs2vXrcSOiHza5l3T0S4HaFCTVA1iryANRYJs=
Date:   Fri, 21 Apr 2023 14:43:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.3-final
Message-ID: <ZEKE3cyac7wCBgvH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.3-final

for you to fetch changes up to a042d7feae7eff98a9ad5a9de5004e60883a96d3:

  Merge tag 'fpga-for-6.3-final' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next (2023-04-11 09:41:40 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.3-final

Here are some last-minute tiny driver fixes for 6.3-final.  They
include fixes for some fpga and iio drivers:
  - fpga bridge driver fix
  - fpga dfl error reporting fix
  - fpga m10bmc driver fix
  - fpga xilinx driver fix
  - iio light driver fix
  - iio dac fwhandle leak fix
  - iio adc driver fix

All of these have been in linux-next for a few weeks with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexis Lothoré (1):
      fpga: bridge: properly initialize bridge device before populating children

Bjorn Helgaas (1):
      fpga: dfl-pci: Drop redundant pci_enable_pcie_error_reporting()

Brian Masney (1):
      iio: light: tsl2772: fix reading proximity-diodes from device tree

Dan Carpenter (1):
      iio: adc: at91-sama5d2_adc: fix an error code in at91_adc_allocate_trigger()

Greg Kroah-Hartman (2):
      Merge tag 'iio-fixes-for-6.3b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus
      Merge tag 'fpga-for-6.3-final' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next

Ilpo Järvinen (1):
      fpga: m10bmc-sec: Fix rsu_send_data() to return FW_UPLOAD_ERR_HW_ERROR

Liang He (1):
      iio: dac: ad5755: Add missing fwnode_handle_put()

Michal Simek (1):
      fpga: xilinx-pr-decoupler: Use readl wrapper instead of pure readl

 drivers/fpga/dfl-pci.c                  | 20 ++++++--------------
 drivers/fpga/fpga-bridge.c              |  3 ++-
 drivers/fpga/intel-m10-bmc-sec-update.c |  2 +-
 drivers/fpga/xilinx-pr-decoupler.c      |  2 +-
 drivers/iio/adc/at91-sama5d2_adc.c      |  2 +-
 drivers/iio/dac/ad5755.c                |  1 +
 drivers/iio/light/tsl2772.c             |  1 +
 7 files changed, 13 insertions(+), 18 deletions(-)
