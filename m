Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F3E734177
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjFQNqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjFQNqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:46:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98323212C;
        Sat, 17 Jun 2023 06:45:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12F2160A05;
        Sat, 17 Jun 2023 13:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3CBC433C0;
        Sat, 17 Jun 2023 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687009556;
        bh=bDc57OYF9YNscuK7fDx2p8ot3sLPBCuXkMdnSQ/dYUM=;
        h=Date:From:To:Cc:Subject:From;
        b=NxVacafFBvAyCOj24xxq6yurlbRAk/1LKYCuWOL82OF0GPrAVwymUlKSj8lMLRx2A
         wrHQwuYx9eDybLJ+xlvTxHXoEEQmVErKvRC6GEFSkmD9MHPdj7aK2u90zt2NjJY87d
         TknMxE1K3hCHyAsOMTPzQxHsEvlxcAkwKR2JrXMU=
Date:   Sat, 17 Jun 2023 15:45:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.4-rc7
Message-ID: <ZI25EoACbZnSfnYF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.4-rc7

for you to fetch changes up to 286d9975a838d0a54da049765fa1d1fb96b89682:

  usb: gadget: udc: core: Prevent soft_connect_store() race (2023-06-13 12:16:34 +0200)

----------------------------------------------------------------
USB/Thunderbolt Fixes for 6.4-rc7

Here are some small USB and Thunderbolt driver fixes and new device ids
for 6.4-rc7 to resolve some reported problems.  Included in here are:
  - new USB serial device ids
  - USB gadget core fixes for long-dissussed problems
  - dwc3 bugfixes for reported issues.
  - typec driver fixes
  - thunderbolt driver fixes

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Badhri Jagan Sridharan (2):
      usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
      usb: gadget: udc: core: Prevent soft_connect_store() race

Biju Das (1):
      usb: gadget: udc: renesas_usb3: Fix RZ/V2M {modprobe,bind} error

Elson Roy Serrao (1):
      usb: dwc3: gadget: Reset num TRBs before giving back the request

Greg Kroah-Hartman (2):
      Merge tag 'thunderbolt-for-v6.4-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus
      Merge tag 'usb-serial-6.4-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Heikki Krogerus (1):
      usb: typec: ucsi: Fix command cancellation

Jerry Meng (1):
      USB: serial: option: add Quectel EM061KGL series

Johan Hovold (2):
      USB: dwc3: qcom: fix NULL-deref on suspend
      USB: dwc3: fix use-after-free on core driver unbind

Mika Westerberg (4):
      thunderbolt: dma_test: Use correct value for absent rings when creating paths
      thunderbolt: Increase DisplayPort Connection Manager handshake timeout
      thunderbolt: Do not touch CL state configuration during discovery
      thunderbolt: Mask ring interrupt on Intel hardware as well

Pavan Holla (1):
      usb: typec: Fix fast_role_swap_current show function

 drivers/thunderbolt/dma_test.c        |   8 +-
 drivers/thunderbolt/nhi.c             |  11 ++-
 drivers/thunderbolt/tb.c              |  17 +++-
 drivers/thunderbolt/tunnel.c          |   2 +-
 drivers/usb/dwc3/core.c               |   5 +
 drivers/usb/dwc3/dwc3-qcom.c          |  11 ++-
 drivers/usb/dwc3/gadget.c             |   1 +
 drivers/usb/gadget/udc/core.c         | 180 +++++++++++++++++++++++++---------
 drivers/usb/gadget/udc/renesas_usb3.c |   4 +-
 drivers/usb/serial/option.c           |  16 +++
 drivers/usb/typec/pd.c                |   2 +-
 drivers/usb/typec/ucsi/ucsi.c         |  11 ++-
 12 files changed, 198 insertions(+), 70 deletions(-)
