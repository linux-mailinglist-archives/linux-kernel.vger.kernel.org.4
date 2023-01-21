Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318BF676720
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 16:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjAUP26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 10:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjAUP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 10:28:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A222BF39;
        Sat, 21 Jan 2023 07:28:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 164B9B80690;
        Sat, 21 Jan 2023 15:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49813C433EF;
        Sat, 21 Jan 2023 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674314930;
        bh=b75SWTE66lLJn5s7fn/5v2YvyP6oVfWzwpQ2R5S26LY=;
        h=Date:From:To:Cc:Subject:From;
        b=Q35CfV2sxXDyV3PHM5Wo0VAjTYdQezHnpkZNeKaHNNixTPUr4F/3TxFqBR4nyt6u1
         EbUU3XlMBYDjZda0HHa86a3O89bUl3/vRS3luBEazD/pmMW6zEetkfSLizRdKZsian
         mb91qqrSsOXWzP/NeRtiVjYX9KDtlqvjMXbjQ/c8=
Date:   Sat, 21 Jan 2023 16:28:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.2-rc5
Message-ID: <Y8wEsNOa9JR4cdPK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc5

for you to fetch changes up to 14ff7460bb58662d86aa50298943cc7d25532e28:

  USB: misc: iowarrior: fix up header size for USB_DEVICE_ID_CODEMERCS_IOW100 (2023-01-20 15:06:23 +0100)

----------------------------------------------------------------
USB / Thunderbolt fixes for 6.2-rc5

Here are a number of small USB and Thunderbolt driver fixes and new
device id changes for 6.2-rc5.  Included in here are:
  - thunderbolt bugfixes for reported problems
  - new usb-serial driver ids added
  - onboard_hub usb driver fixes for much-reported problems
  - xhci bugfixes
  - typec bugfixes
  - ehci-fsl driver module alias fix
  - iowarrior header size fix
  - usb gadget driver fixes

All of these, except for the iowarrior fix, have been in linux-next with
no reported issues.  The iowarrior fix passed the 0-day testing and is a
one digit change based on a reported problem in the driver (which was
written to a spec, not the real device that is now available.)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: gadgetfs: Fix race between mounting and unmounting

Alexander Stein (1):
      usb: host: ehci-fsl: Fix module alias

Ali Mirghasemi (1):
      USB: serial: option: add Quectel EC200U modem

Arnd Bergmann (1):
      usb: dwc3: fix extcon dependency

Chanh Nguyen (1):
      USB: gadget: Add ID numbers to configfs-gadget driver names

ChiYuan Huang (1):
      usb: typec: tcpm: Fix altmode re-registration causes sysfs create fail

Daniel Scally (1):
      usb: gadget: g_webcam: Send color matching descriptor per frame

Duke Xin(辛安文) (5):
      USB: serial: option: add Quectel EM05-G (CS) modem
      USB: serial: option: add Quectel EM05-G (GR) modem
      USB: serial: option: add Quectel EM05-G (RS) modem
      USB: serial: option: add Quectel EM05CN (SG) modem
      USB: serial: option: add Quectel EM05CN modem

Flavio Suligoi (1):
      usb: core: hub: disable autosuspend for TI TUSB8041

Greg Kroah-Hartman (3):
      Merge tag 'thunderbolt-for-v6.2-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus
      Merge tag 'usb-serial-6.2-rc5' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus
      USB: misc: iowarrior: fix up header size for USB_DEVICE_ID_CODEMERCS_IOW100

Jack Pham (1):
      usb: ucsi: Ensure connector delayed work items are flushed

Jimmy Hu (1):
      usb: xhci: Check endpoint is valid before dereferencing it

Johan Hovold (1):
      USB: fix misleading usb_set_intfdata() kernel doc

Juhyung Park (1):
      usb-storage: apply IGNORE_UAS only for HIKSEMI MD202 on RTL9210

Maciej Żenczykowski (1):
      usb: gadget: f_ncm: fix potential NULL ptr deref in ncm_bitrate()

Mathias Nyman (5):
      xhci: Fix null pointer dereference when host dies
      xhci: Add update_hub_device override for PCI xHCI hosts
      xhci: Add a flag to disable USB3 lpm on a xhci root port level.
      usb: acpi: add helper to check port lpm capability using acpi _DSM
      xhci: Detect lpm incapable xHC USB3 roothub ports from ACPI tables

Matthias Kaehlcke (2):
      usb: misc: onboard_hub: Invert driver registration order
      usb: misc: onboard_hub: Move 'attach' work to the driver

Michael Adler (1):
      USB: serial: cp210x: add SCALANCE LPE-9000 device id

Mika Westerberg (3):
      thunderbolt: Do not call PM runtime functions in tb_retimer_scan()
      thunderbolt: Use correct function to calculate maximum USB3 link rate
      thunderbolt: Disable XDomain lane 1 only in software connection manager

Pawel Laszczak (1):
      usb: cdns3: remove fetched trb from cache before dequeuing

Prashant Malani (3):
      usb: typec: altmodes/displayport: Add pin assignment helper
      usb: typec: altmodes/displayport: Fix pin assignment calculation
      usb: typec: altmodes/displayport: Use proper macro for pin assignment check

Ricardo Ribalda (1):
      xhci-pci: set the dma max_seg_size

Udipto Goswami (2):
      usb: gadget: f_fs: Prevent race during ffs_ep0_queue_wait
      usb: gadget: f_fs: Ensure ep0req is dequeued before free_request

Utkarsh Patel (1):
      thunderbolt: Do not report errors if on-board retimers are found

Xu Yang (1):
      usb: chipidea: core: fix possible constant 0 if use IS_ERR(ci->role_switch)

Yang Yingliang (1):
      usb: musb: fix error return code in omap2430_probe()

 drivers/thunderbolt/retimer.c            | 20 ++--------
 drivers/thunderbolt/tb.c                 | 20 +++++++---
 drivers/thunderbolt/tunnel.c             |  2 +-
 drivers/thunderbolt/xdomain.c            | 17 ++++++---
 drivers/usb/cdns3/cdns3-gadget.c         | 12 ++++++
 drivers/usb/chipidea/core.c              |  4 +-
 drivers/usb/core/hub.c                   | 13 +++++++
 drivers/usb/core/usb-acpi.c              | 65 ++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/Kconfig                 |  2 +-
 drivers/usb/gadget/configfs.c            | 12 +++++-
 drivers/usb/gadget/function/f_fs.c       |  7 ++++
 drivers/usb/gadget/function/f_ncm.c      |  4 +-
 drivers/usb/gadget/legacy/inode.c        | 28 ++++++++++----
 drivers/usb/gadget/legacy/webcam.c       |  3 ++
 drivers/usb/host/ehci-fsl.c              |  2 +-
 drivers/usb/host/xhci-pci.c              | 45 ++++++++++++++++++++++
 drivers/usb/host/xhci-ring.c             |  5 ++-
 drivers/usb/host/xhci.c                  | 18 ++++++++-
 drivers/usb/host/xhci.h                  |  5 +++
 drivers/usb/misc/iowarrior.c             |  2 +-
 drivers/usb/misc/onboard_usb_hub.c       | 18 ++++-----
 drivers/usb/musb/omap2430.c              |  4 +-
 drivers/usb/serial/cp210x.c              |  1 +
 drivers/usb/serial/option.c              | 17 +++++++++
 drivers/usb/storage/uas-detect.h         | 13 +++++++
 drivers/usb/storage/unusual_uas.h        |  7 ----
 drivers/usb/typec/altmodes/displayport.c | 22 +++++++----
 drivers/usb/typec/tcpm/tcpm.c            |  7 ++--
 drivers/usb/typec/ucsi/ucsi.c            | 24 ++++++++++--
 drivers/usb/typec/ucsi/ucsi.h            |  1 +
 include/linux/usb.h                      | 18 +++++----
 31 files changed, 334 insertions(+), 84 deletions(-)
