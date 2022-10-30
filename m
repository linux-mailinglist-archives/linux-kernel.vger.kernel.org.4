Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F66612AEC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 15:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ3OKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3OKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 10:10:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EE7B4A7;
        Sun, 30 Oct 2022 07:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 285E0B80D3E;
        Sun, 30 Oct 2022 14:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4C6C433C1;
        Sun, 30 Oct 2022 14:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667138997;
        bh=K3CEKuKLIhnTzVI+eaZU/D6cwuobRADrj7tp7WzSxCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=VXLUtWD4WLFQ6PQ/l5X+DNjG+KUC+Cp86qUACDDxS+a7sQsMkDxfq/aJtAYH6IUsU
         IM7DPVzk/OcQ66mn1M2fmY8U+VmpgCgO+NmCDH80KCGEplzbKCjC5TO3CUEgLlQSBg
         1VaSZYdaIJ36eTDDw+CuQMo5MskvsNKsmEOHsHUs=
Date:   Sun, 30 Oct 2022 15:10:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.1-rc3
Message-ID: <Y16F7fZSFrXupUU6@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.1-rc3

for you to fetch changes up to 308c316d16cbad99bb834767382baa693ac42169:

  usb: dwc3: gadget: Don't set IMI for no_interrupt (2022-10-26 18:31:56 +0200)

----------------------------------------------------------------
USB fixes for 6.1-rc3

Here are a few small USB fixes for 6.1-rc3.  Include in here are:
	- MAINTAINERS update, including a big one for the USB gadget
	  subsystem.  Many thanks to Felipe for all of the years of hard
	  work he has done on this codebase, it was greatly appreciated.
	- dwc3 driver fixes for reported problems.
	- xhci driver fixes for reported problems.
	- typec driver fixes for minor issues
	- uvc gadget driver change, and then revert as it wasn't
	  relevant for 6.1-final, as it is a new feature and people are
	  still reviewing and modifying it.

All of these have been in the linux-next tree with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrey Smirnov (1):
      usb: dwc3: Don't switch OTG -> peripheral if extcon is present

Dan Vacura (2):
      usb: gadget: uvc: fix dropped frame after missed isoc
      usb: gadget: uvc: fix sg handling in error case

Greg Kroah-Hartman (2):
      MAINTAINERS: move USB gadget and phy entries under the main USB entry
      Revert "usb: gadget: uvc: limit isoc_sg to super speed gadgets"

Heikki Krogerus (2):
      usb: typec: ucsi: Check the connection on resume
      usb: typec: ucsi: acpi: Implement resume callback

Jeff Vanhoof (1):
      usb: gadget: uvc: fix sg handling during video encode

Jens Glathe (1):
      usb: xhci: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a V0.96 controller

Joel Stanley (1):
      usb: gadget: aspeed: Fix probe regression

Justin Chen (2):
      MAINTAINERS: Update maintainers for broadcom USB
      usb: bdc: change state when port disconnected

Mario Limonciello (1):
      xhci-pci: Set runtime PM as default policy on all xHC 1.2 or later devices

Mathias Nyman (2):
      xhci: Add quirk to reset host back to default state at shutdown
      xhci: Remove device endpoints from bandwidth list when freeing the device

Michael Grzeschik (1):
      usb: gadget: uvc: limit isoc_sg to super speed gadgets

Patrice Chotard (1):
      usb: dwc3: st: Rely on child's compatible instead of name

Thinh Nguyen (3):
      usb: dwc3: gadget: Don't delay End Transfer on delayed_status
      usb: dwc3: gadget: Stop processing more requests on IMI
      usb: dwc3: gadget: Don't set IMI for no_interrupt

 MAINTAINERS                              | 19 ++----------
 drivers/usb/dwc3/core.c                  | 49 ++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/drd.c                   | 50 --------------------------------
 drivers/usb/dwc3/dwc3-st.c               |  2 +-
 drivers/usb/dwc3/gadget.c                | 20 +++++++++++--
 drivers/usb/gadget/function/uvc_queue.c  |  8 +++--
 drivers/usb/gadget/function/uvc_video.c  | 25 +++++++++++-----
 drivers/usb/gadget/udc/aspeed-vhub/dev.c |  1 +
 drivers/usb/gadget/udc/bdc/bdc_udc.c     |  1 +
 drivers/usb/host/xhci-mem.c              | 20 ++++++++-----
 drivers/usb/host/xhci-pci.c              | 44 ++++++++++------------------
 drivers/usb/host/xhci.c                  | 10 +++++--
 drivers/usb/host/xhci.h                  |  1 +
 drivers/usb/typec/ucsi/ucsi.c            | 42 ++++++++++++++++++---------
 drivers/usb/typec/ucsi/ucsi_acpi.c       | 10 +++++++
 15 files changed, 169 insertions(+), 133 deletions(-)
