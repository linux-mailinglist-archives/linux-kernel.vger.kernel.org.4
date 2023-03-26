Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6016B6C948B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjCZNgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCZNgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:36:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8888F49EB;
        Sun, 26 Mar 2023 06:36:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 232E260EB9;
        Sun, 26 Mar 2023 13:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C2DC433D2;
        Sun, 26 Mar 2023 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679837807;
        bh=msP+ccOnKADnG7OkJ+CMPE7w22qn6GUO8hlPzPlKGzI=;
        h=Date:From:To:Cc:Subject:From;
        b=Whut8GCz2OMDuEwMz0x7UqaTZgKEfZxKOVD26rt8ox2B1SrVTvpNreTLzbmiaygDu
         8qau4GoUc4/+Scs6hVGf8h8R2iaRPmQmLinoHuqmm2FXwsPxG3k4mhHfc825BVqt32
         ueUn1rRNc9WqFKA0tX3P0fJwHleZyINItjM0WiTg=
Date:   Sun, 26 Mar 2023 15:36:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver fixes for 6.3-rc4
Message-ID: <ZCBKbHwjnh5iyw2D@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.3-rc4

for you to fetch changes up to 5021383242ada277a38bd052a4c12ed4707faccb:

  usb: dwc2: fix a race, don't power off/on phy for dual-role mode (2023-03-23 19:13:16 +0100)

----------------------------------------------------------------
USB/Thunderbolt driver fixes for 6.3-rc4

Here are a small set of USB and Thunderbolt driver fixes for reported
problems and a documentation update, for 6.3-rc4.

Included in here are:
  - documentation update for uvc gadget driver
  - small thunderbolt driver fixes
  - cdns3 driver fixes
  - dwc3 driver fixes
  - dwc2 driver fixes
  - chipidea driver fixes
  - typec driver fixes
  - onboard_usb_hub device id updates
  - quirk updates

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Stein (1):
      usb: misc: onboard-hub: add support for Microchip USB2517 USB 2.0 hub

Alvin Šipraga (1):
      usb: gadget: u_audio: don't let userspace block driver unbind

Andy Shevchenko (1):
      usb: gadget: Use correct endianness of the wLength field for WebUSB

Daniel Scally (1):
      docs: usb: Add documentation for the UVC Gadget

Fabrice Gasnier (2):
      usb: dwc2: fix a devres leak in hw_enable upon suspend resume
      usb: dwc2: fix a race, don't power off/on phy for dual-role mode

Gil Fine (2):
      thunderbolt: Add missing UNSET_INBOUND_SBTX for retimer access
      thunderbolt: Limit USB3 bandwidth of certain Intel USB4 host routers

Greg Kroah-Hartman (1):
      Merge tag 'thunderbolt-for-v6.3-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus

Hans de Goede (3):
      usb: ucsi: Fix NULL pointer deref in ucsi_connector_change()
      usb: ucsi: Fix ucsi->connector race
      usb: ucsi_acpi: Increase the command completion timeout

Hongren Zheng (1):
      MAINTAINERS: make me a reviewer of USB/IP

Mario Limonciello (2):
      thunderbolt: Use const qualifier for `ring_interrupt_index`
      thunderbolt: Disable interrupt auto clear for rings

Mika Westerberg (3):
      thunderbolt: Fix memory leak in margining
      thunderbolt: Call tb_check_quirks() after initializing adapters
      thunderbolt: Use scale field when allocating USB3 bandwidth

Pawel Laszczak (3):
      usb: cdnsp: Fixes issue with redundant Status Stage
      usb: cdns3: Fix issue with using incorrect PCI device function
      usb: cdnsp: changes PCI Device ID to fix conflict with CNDS3 driver

Sanjay R Mehta (1):
      thunderbolt: Add quirk to disable CLx

Tom Rix (1):
      thunderbolt: Rename shadowed variables bit to interrupt_bit and auto_clear_bit

Vincenzo Palazzo (1):
      usb: dwc3: Fix a typo in field name

Wesley Cheng (1):
      usb: dwc3: gadget: Add 1ms delay after end transfer command without IOC

Xu Yang (4):
      usb: typec: tcpm: fix create duplicate source-capabilities file
      usb: typec: tcpm: fix warning when handle discover_identity message
      usb: chipdea: core: fix return -EINVAL if request role is the same with current role
      usb: chipidea: core: fix possible concurrent when switch role

Yaroslav Furman (1):
      uas: Add US_FL_NO_REPORT_OPCODES for JMicron JMS583Gen 2

Ziyang Huang (1):
      usb: dwc2: drd: fix inconsistent mode if role-switch-default-mode="host"

 Documentation/usb/gadget_uvc.rst      | 352 ++++++++++++++++++++++++++++++++++
 Documentation/usb/index.rst           |   1 +
 MAINTAINERS                           |   1 +
 drivers/thunderbolt/debugfs.c         |  12 +-
 drivers/thunderbolt/nhi.c             |  49 +++--
 drivers/thunderbolt/nhi_regs.h        |   6 +-
 drivers/thunderbolt/quirks.c          |  44 +++++
 drivers/thunderbolt/retimer.c         |  23 ++-
 drivers/thunderbolt/sb_regs.h         |   1 +
 drivers/thunderbolt/switch.c          |   4 +-
 drivers/thunderbolt/tb.h              |  15 +-
 drivers/thunderbolt/usb4.c            |  53 ++++-
 drivers/usb/cdns3/cdns3-pci-wrap.c    |   5 +
 drivers/usb/cdns3/cdnsp-ep0.c         |  19 +-
 drivers/usb/cdns3/cdnsp-pci.c         |  27 ++-
 drivers/usb/chipidea/ci.h             |   2 +
 drivers/usb/chipidea/core.c           |  11 +-
 drivers/usb/chipidea/otg.c            |   5 +-
 drivers/usb/dwc2/drd.c                |   3 +-
 drivers/usb/dwc2/gadget.c             |   6 +-
 drivers/usb/dwc2/platform.c           |  19 +-
 drivers/usb/dwc3/core.h               |   2 +-
 drivers/usb/dwc3/gadget.c             |  14 +-
 drivers/usb/gadget/composite.c        |   7 +-
 drivers/usb/gadget/function/u_audio.c |   2 +-
 drivers/usb/misc/onboard_usb_hub.c    |   1 +
 drivers/usb/misc/onboard_usb_hub.h    |   1 +
 drivers/usb/storage/unusual_uas.h     |   7 +
 drivers/usb/typec/tcpm/tcpm.c         |  28 ++-
 drivers/usb/typec/ucsi/ucsi.c         |  33 ++--
 drivers/usb/typec/ucsi/ucsi_acpi.c    |   2 +-
 31 files changed, 625 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/usb/gadget_uvc.rst
