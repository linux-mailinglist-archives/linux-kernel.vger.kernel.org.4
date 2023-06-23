Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B22173B11A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFWHMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFWHMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9501B4;
        Fri, 23 Jun 2023 00:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFC4461978;
        Fri, 23 Jun 2023 07:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11169C433C8;
        Fri, 23 Jun 2023 07:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687504368;
        bh=ihIA8f5KiyTCWpwL5yCkgQRnJ0CjQZnK5aKls249KtU=;
        h=Date:From:To:Cc:Subject:From;
        b=RL/KxnqU+9m0OQ50CvJIIj8qEkKMQRqkAkM2vZiodPCJ0gUuSKTJD0iF+V0knWnie
         4bSC6fSWZhmbaHzVzXSA5VGum+EreFcbO9q/enEMbfqPHSKr5bARhqBVV126mNy+dM
         SKaR0XixzrPPURiAVQcVLbPbUVCt1IhoLa0ybGxFWyJWGU8Lr1SEh9uq3iObY7v332
         d6yxQv1DMCqVQZdk3ANGeLD2z6e/dNPd8sxFjey4fqr4OOh5ukvs+y7aCXRNWjuKBf
         Xca1P53hPAB9jE4FMtY8Ute0NMKQV7iOIcFnPCFoLybGykGNRL15CgqaIItl2ct9l6
         YbEexnEgpJUlw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qCayW-0002Xj-0C; Fri, 23 Jun 2023 09:12:56 +0200
Date:   Fri, 23 Jun 2023 09:12:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 6.5-rc1
Message-ID: <ZJVF-Gq2HCkv49sH@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.5-rc1

for you to fetch changes up to ffa5f7a3bf28c1306eef85d4056539c2d4b8eb09:

  USB: serial: option: add LARA-R6 01B PIDs (2023-06-22 13:45:09 +0200)

----------------------------------------------------------------
USB-serial updates for 6.5-rc1

Here are the USB-serial updates for 6.5-rc1, including:

 - improved error handling for break signalling
 - report to user space when a device does not support break signalling

Included are also some new modem device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Davide Tronchin (1):
      USB: serial: option: add LARA-R6 01B PIDs

Johan Hovold (3):
      USB: serial: return errors from break handling
      USB: serial: cp210x: disable break signalling on CP2105 SCI
      USB: serial: report unsupported break signalling

 drivers/usb/serial/ark3116.c          |  7 +++++--
 drivers/usb/serial/belkin_sa.c        | 12 +++++++++---
 drivers/usb/serial/ch341.c            | 37 ++++++++++++++++++++++-------------
 drivers/usb/serial/cp210x.c           | 14 ++++++++++---
 drivers/usb/serial/digi_acceleport.c  |  7 ++++---
 drivers/usb/serial/f81232.c           |  4 +++-
 drivers/usb/serial/f81534.c           |  4 +++-
 drivers/usb/serial/ftdi_sio.c         | 10 +++++++---
 drivers/usb/serial/io_edgeport.c      |  6 ++++--
 drivers/usb/serial/io_ti.c            |  9 +++++++--
 drivers/usb/serial/keyspan.c          |  5 ++++-
 drivers/usb/serial/keyspan_pda.c      |  8 ++++++--
 drivers/usb/serial/mct_u232.c         |  6 +++---
 drivers/usb/serial/mos7720.c          |  9 +++++----
 drivers/usb/serial/mos7840.c          |  7 ++++---
 drivers/usb/serial/mxuport.c          |  6 +++---
 drivers/usb/serial/option.c           |  4 ++++
 drivers/usb/serial/pl2303.c           | 14 ++++++++-----
 drivers/usb/serial/quatech2.c         |  8 ++++++--
 drivers/usb/serial/ti_usb_3410_5052.c | 10 +++++++---
 drivers/usb/serial/upd78f0730.c       |  7 +++++--
 drivers/usb/serial/usb-serial.c       |  4 ++--
 drivers/usb/serial/usb_debug.c        | 13 +++++++++---
 drivers/usb/serial/whiteheat.c        |  7 ++++---
 drivers/usb/serial/xr_serial.c        |  4 ++--
 include/linux/usb/serial.h            |  2 +-
 26 files changed, 151 insertions(+), 73 deletions(-)
