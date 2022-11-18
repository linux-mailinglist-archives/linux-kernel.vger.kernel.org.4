Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D186062FC35
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242312AbiKRSLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiKRSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:11:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E31CC5D;
        Fri, 18 Nov 2022 10:10:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45F38B824ED;
        Fri, 18 Nov 2022 18:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94085C433D6;
        Fri, 18 Nov 2022 18:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668795056;
        bh=v1LpnWuqqL/42ipq0d18sYX3BkbXM25l/UJTnIgBjLo=;
        h=Date:From:To:Cc:Subject:From;
        b=x219XtpZSnkTaYo6hGhYNpOb+isvlAshkhQ4Y8qptbywEz3ASOp9YA9CW0H2WV9oe
         F0y5aexepvj6GYxHa5SRdvzsqAlS4iSMmhBRI+24aymbgKLx6NVXwKOXHMrf8cJB5u
         ytQEbrkn/OheK10VQqKHH6/m/C40y1sari1QALig=
Date:   Fri, 18 Nov 2022 19:10:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.1-rc6
Message-ID: <Y3fKrfyixnq55Poc@kroah.com>
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

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.1-rc6

for you to fetch changes up to 59a51183be1a6aaaf6f8483aec82e2fbf2c74ab9:

  Merge tag 'usb-serial-6.1-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2022-11-17 22:06:28 +0100)

----------------------------------------------------------------
USB driver fixes for 6.1-rc6

Here are a number of USB driver fixes and new device ids for 6.1-rc6.
Included in here are:
	- new usb-serial device ids
	- dwc3 driver fixes for reported problems
	- cdns3 driver fixes
	- new USB device quirks
	- typec driver fixes
	- extcon USB typec driver fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Benoît Monin (1):
      USB: serial: option: add Sierra Wireless EM9191

Davide Tronchin (3):
      USB: serial: option: remove old LARA-R6 PID
      USB: serial: option: add u-blox LARA-R6 00B modem
      USB: serial: option: add u-blox LARA-L6 modem

Duoming Zhou (1):
      usb: chipidea: fix deadlock in ci_otg_del_timer

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-6.1-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Janne Grunau (1):
      usb: dwc3: Do not get extcon device when usb-role-switch is used

Johan Hovold (1):
      Revert "usb: dwc3: disable USB core PHY management"

Li Jun (1):
      usb: cdns3: host: fix endless superspeed hub port reset

Linus Walleij (1):
      USB: bcma: Make GPIO explicitly optional

Nicolas Dumazet (1):
      usb: add NO_LPM quirk for Realforce 87U Keyboard

Rajat Khandelwal (1):
      usb: typec: mux: Enter safe mode only when pins need to be reconfigured

Reinhard Speyerer (1):
      USB: serial: option: add Fibocom FM160 0x0111 composition

Sven Peter (1):
      usb: typec: tipd: Prevent uninitialized event{1,2} in IRQ handler

Thinh Nguyen (1):
      usb: dwc3: gadget: Return -ESHUTDOWN on ep disable

Yassine Oudjana (1):
      extcon: usbc-tusb320: Call the Type-C IRQ handler only if a port is registered

 drivers/extcon/extcon-usbc-tusb320.c  |  8 ++++-
 drivers/usb/cdns3/host.c              | 56 +++++++++++++++++------------------
 drivers/usb/chipidea/otg_fsm.c        |  2 ++
 drivers/usb/core/quirks.c             |  3 ++
 drivers/usb/dwc3/core.c               | 10 +++++++
 drivers/usb/dwc3/gadget.c             |  2 +-
 drivers/usb/dwc3/host.c               | 10 -------
 drivers/usb/host/bcma-hcd.c           | 10 ++++---
 drivers/usb/serial/option.c           | 19 ++++++++++--
 drivers/usb/typec/mux/intel_pmc_mux.c | 15 ++++++++--
 drivers/usb/typec/tipd/core.c         |  6 ++--
 11 files changed, 90 insertions(+), 51 deletions(-)
