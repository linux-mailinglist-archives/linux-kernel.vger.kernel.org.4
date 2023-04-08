Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9266DBA8C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjDHLs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjDHLsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C2EEFBE;
        Sat,  8 Apr 2023 04:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADADC60A65;
        Sat,  8 Apr 2023 11:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBECC433D2;
        Sat,  8 Apr 2023 11:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680954496;
        bh=MLN/PCCSpkG/BMKWkQyFJn5UPwX5b12Nbnmnj5iUpuY=;
        h=Date:From:To:Cc:Subject:From;
        b=jjVxx+92c5LLdlEboHrzvEl/9AsKiJ3XoYgC5igM0WhzdAscA4tG0J5QWzuxwqeDW
         FjwjhPhEwpw3bCqitYKO9yAQ0qtkmitH3lViVpvW7u4y0OxtIIqJjXRc9EmnklB3ns
         EJ7QIObyRc/ietuyTLqFYBjHIeTg1kC/svjNj9hA=
Date:   Sat, 8 Apr 2023 13:48:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver fixes for 6.3-rc6
Message-ID: <ZDFUfXFg3s03QbsL@kroah.com>
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

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.3-rc6

for you to fetch changes up to 1edf48991a783d00a3a18dc0d27c88139e4030a2:

  usb: cdnsp: Fixes error: uninitialized symbol 'len' (2023-04-05 19:55:04 +0200)

----------------------------------------------------------------
USB bugfixes for 6.3-rc6

Here are some small USB bugfixes for 6.3-rc6 that have been in my tree,
and in linux-next, for a while.  Included in here are:
  - new usb-serial driver device ids
  - xhci bugfixes for reported problems
  - gadget driver bugfixes for reported problems
  - dwc3 new device id

All have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bjørn Mork (1):
      USB: serial: option: add Quectel RM500U-CN modem

D Scott Phillips (1):
      xhci: also avoid the XHCI_ZERO_64B_REGS quirk with a passthrough iommu

Enrico Sau (1):
      USB: serial: option: add Telit FE990 compositions

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-6.3-rc5' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Meteor Lake-S

Kees Jan Koster (1):
      USB: serial: cp210x: add Silicon Labs IFS-USB-DATACABLE IDs

Mathias Nyman (2):
      Revert "usb: xhci-pci: Set PROBE_PREFER_ASYNCHRONOUS"
      xhci: Free the command allocated for setting LPM if we return early

Pawel Laszczak (1):
      usb: cdnsp: Fixes error: uninitialized symbol 'len'

RD Babiera (1):
      usb: typec: altmodes/displayport: Fix configure initial pin assignment

Sandeep Dhavale (2):
      usb: gadget: f_fs: Fix ffs_epfile_read_iter to handle ITER_UBUF
      usb: gadgetfs: Fix ep_read_iter to handle ITER_UBUF

Wayne Chang (1):
      usb: xhci: tegra: fix sleep in atomic call

 drivers/usb/cdns3/cdnsp-ep0.c            |  3 +--
 drivers/usb/dwc3/dwc3-pci.c              |  4 ++++
 drivers/usb/gadget/function/f_fs.c       |  2 +-
 drivers/usb/gadget/legacy/inode.c        |  2 +-
 drivers/usb/host/xhci-pci.c              |  7 +++----
 drivers/usb/host/xhci-tegra.c            |  6 +++---
 drivers/usb/host/xhci.c                  |  7 ++++++-
 drivers/usb/serial/cp210x.c              |  1 +
 drivers/usb/serial/option.c              | 10 ++++++++++
 drivers/usb/typec/altmodes/displayport.c |  6 +++++-
 10 files changed, 35 insertions(+), 13 deletions(-)
