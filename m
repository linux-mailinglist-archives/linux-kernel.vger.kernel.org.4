Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCCB5E6412
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiIVNsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiIVNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:47:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C3DED54;
        Thu, 22 Sep 2022 06:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 229FD6347F;
        Thu, 22 Sep 2022 13:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850E6C433B5;
        Thu, 22 Sep 2022 13:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663854416;
        bh=37Il2yCQHQKRSZhahyU45WyhOadLsemdGPbLtWnIC+A=;
        h=Date:From:To:Cc:Subject:From;
        b=RZxA0x6s+vHbWuBArvXHyePVv/QiJsz2spvYDWruluN6iQSTKYp0epe9L8mYLcAye
         NfJD4bT3u92w5zxT+PZpLNL0NJpsRTa9pkTCPq6XtW9+UsYHwu/TEHZ+509OVf3PEv
         RnhHzd0fibaCrinkEfr4PpL4de5D3H+ZbiyosaKizV1AHoGg7yEnfEAvw1N2ce74ti
         Z8fwovjqNi+eL9Flu5kxxBnjggmd2vFxnxsnAdDE9oWD/wPHk82RAFxERKGpFQf3xa
         NFXbznPesIusM7iXOe+Sh88LR1/yapRQMZF/N1zvNtmEjwHs5zVxDw2Oixc1EO7mIL
         HsxpoS7o3aKEg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1obMXd-0005Jm-Ug; Thu, 22 Sep 2022 15:47:02 +0200
Date:   Thu, 22 Sep 2022 15:47:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 6.1-rc1
Message-ID: <YyxnVZCqZekklv8V@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As Stephen reported the other day, there's a trivial conflict with a change in
the TTY tree that made one of the set_termios parameters const:

	https://lore.kernel.org/lkml/20220921151109.174cad24@canb.auug.org.au/

Johan


The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.1-rc1

for you to fetch changes up to 6b2fe3df7c0ca3cf9ee9cea4470462fa708baf87:

  USB: serial: ftdi_sio: clean up driver prefix (2022-09-20 09:45:50 +0200)

----------------------------------------------------------------
USB-serial updates for 6.1-rc1

Here are the USB-serial updates for 6.1-rc1, including:

 - a fix for a very long-standing FTDI SIO regression
 - a long-overdue cleanup of the FTDI type handling
 - support for new FTDI HP and HA devices

Included are also various clean ups.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Amireddy mallikarjuna reddy (1):
      USB: serial: ftdi_sio: add support for HP and HA devices

Jiasheng Jiang (1):
      USB: serial: ftdi_sio: convert to use dev_groups

Johan Hovold (15):
      USB: serial: ftdi_sio: fix 300 bps rate for SIO
      USB: serial: ftdi_sio: clean up chip type enum
      USB: serial: ftdi_sio: drop redundant chip type comments
      USB: serial: ftdi_sio: rename chip types
      USB: serial: ftdi_sio: include FT2232D in type string
      USB: serial: ftdi_sio: rename channel index
      USB: serial: ftdi_sio: tighten device-type detection
      USB: serial: ftdi_sio: clean up modem-status handling
      USB: serial: ftdi_sio: clean up attribute handling
      USB: serial: ftdi_sio: clean up baudrate request
      USB: serial: ftdi_sio: assume hi-speed type
      USB: serial: ftdi_sio: simplify divisor handling
      USB: serial: ftdi_sio: clean up attribute visibility logic
      USB: serial: ftdi_sio: move driver structure
      USB: serial: ftdi_sio: clean up driver prefix

Liang He (1):
      USB: serial: console: move mutex_unlock() before usb_serial_put()

 drivers/usb/serial/console.c      |   2 +-
 drivers/usb/serial/ftdi_sio.c     | 485 ++++++++++++++++++--------------------
 drivers/usb/serial/ftdi_sio.h     |  22 +-
 drivers/usb/serial/ftdi_sio_ids.h |   7 +
 4 files changed, 245 insertions(+), 271 deletions(-)
