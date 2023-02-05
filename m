Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B887868AFCA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 13:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBEMzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 07:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEMzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 07:55:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA8A1F90B;
        Sun,  5 Feb 2023 04:55:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCCA5B80AEC;
        Sun,  5 Feb 2023 12:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E30FC433D2;
        Sun,  5 Feb 2023 12:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675601702;
        bh=x/qDsEHlWJK+SjGX4aEIfZBQAJmIhwYl+Yiwf3fMysE=;
        h=Date:From:To:Cc:Subject:From;
        b=lssMWPTq9vAlmqT9VnicpcZ1B+4eMc89IfIk29psRrPkA9nJUCLVg/OW3K4/cQR0C
         F2Op+E8ujw8auzImX2EXIplqzh+5c1qjGrZGavhYUuRVWPbZMoyG+AHa0+rUEnEtEN
         HFONKGt4l7oOIs9q7LOsDDaSVQKC8etZ/ErBICZk=
Date:   Sun, 5 Feb 2023 13:54:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.2-rc7
Message-ID: <Y9+nI9o/v/RjiWne@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc7

for you to fetch changes up to f82060da749c611ed427523b6d1605d87338aac1:

  usb: typec: ucsi: Don't attempt to resume the ports before they exist (2023-02-02 11:27:28 +0100)

----------------------------------------------------------------
USB fixes for 6.2-rc7

Here are some small USB fixes for 6.2-rc7 that resolve some reported
problems.  These include:
  - gadget driver fixes
  - dwc3 driver fix
  - typec driver fix
  - MAINTAINERS file update.

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaro Koskinen (1):
      usb: gadget: udc: do not clear gadget driver.bus

Daniel Scally (1):
      MAINTAINERS: Add myself as UVC Gadget Maintainer

Heikki Krogerus (1):
      usb: typec: ucsi: Don't attempt to resume the ports before they exist

Neil Armstrong (1):
      usb: dwc3: qcom: enable vbus override when in OTG dr-mode

Pratham Pratap (1):
      usb: gadget: f_uac2: Fix incorrect increment of bNumEndpoints

Udipto Goswami (1):
      usb: gadget: f_fs: Fix unbalanced spinlock in __ffs_ep0_queue_wait

 MAINTAINERS                            | 1 +
 drivers/usb/dwc3/dwc3-qcom.c           | 2 +-
 drivers/usb/fotg210/fotg210-udc.c      | 1 -
 drivers/usb/gadget/function/f_fs.c     | 4 +++-
 drivers/usb/gadget/function/f_uac2.c   | 1 +
 drivers/usb/gadget/udc/bcm63xx_udc.c   | 1 -
 drivers/usb/gadget/udc/fsl_qe_udc.c    | 1 -
 drivers/usb/gadget/udc/fsl_udc_core.c  | 1 -
 drivers/usb/gadget/udc/fusb300_udc.c   | 1 -
 drivers/usb/gadget/udc/goku_udc.c      | 1 -
 drivers/usb/gadget/udc/gr_udc.c        | 1 -
 drivers/usb/gadget/udc/m66592-udc.c    | 1 -
 drivers/usb/gadget/udc/max3420_udc.c   | 1 -
 drivers/usb/gadget/udc/mv_u3d_core.c   | 1 -
 drivers/usb/gadget/udc/mv_udc_core.c   | 1 -
 drivers/usb/gadget/udc/net2272.c       | 1 -
 drivers/usb/gadget/udc/net2280.c       | 1 -
 drivers/usb/gadget/udc/omap_udc.c      | 1 -
 drivers/usb/gadget/udc/pch_udc.c       | 1 -
 drivers/usb/gadget/udc/snps_udc_core.c | 1 -
 drivers/usb/typec/ucsi/ucsi.c          | 9 ++++++++-
 21 files changed, 14 insertions(+), 19 deletions(-)
