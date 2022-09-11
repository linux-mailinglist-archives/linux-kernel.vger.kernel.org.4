Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23B5B4F59
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiIKODp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiIKODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E233419;
        Sun, 11 Sep 2022 07:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD7A5B80B17;
        Sun, 11 Sep 2022 14:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D289C433C1;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904989;
        bh=GRV2tQa0RAvPCK+3aZDH0ELBAMql4z6Q7mw6IXBUTMc=;
        h=From:To:Cc:Subject:Date:From;
        b=Ni8gSIo3yFGnqW+JZw6vuHef91H4O7dWh08/aS2K77HYzDx0cGrtmcTDqMMJtgKrA
         lPC2D86i3oM5nvTHY5jmOVnVzJ3/Vg5pcdtuvkJ5bZvYY8EoeoHj3/FQABbBhBnxg8
         FGjygsy3lyMEaWXx9iN8BiWICfRw4+wUKk9rospeyfknzROTD/CMr07QJ68+GjSIQH
         IKkX1OnWm7wuVX/wuW45i2pKMi0M0OCZqBstepRb0RFQTKb+KXowIzxs6mtztKnOii
         kD/B72vQnjtOGoOxhBzQwgZN9v7317yr/xzO7BqHuTNzCAkMplFhm1nu72SWPPfwhM
         oTHrJJiRepTCQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYL-0007wW-Do; Sun, 11 Sep 2022 16:03:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] USB: serial: ftdi_sio: type cleanup and HP/HA support
Date:   Sun, 11 Sep 2022 16:02:04 +0200
Message-Id: <20220911140216.30481-1-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I finally got around to completing the clean up of the ftdi_sio device
type handling which I started years ago but never to around to
finishing.

A recent patch from FTDI adding support for further device types has
been rebased on top.

Johan


Amireddy mallikarjuna reddy (1):
  USB: serial: ftdi_sio: add support for HP and HA devices

Johan Hovold (11):
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

 drivers/usb/serial/ftdi_sio.c     | 335 +++++++++++++++---------------
 drivers/usb/serial/ftdi_sio.h     |  22 +-
 drivers/usb/serial/ftdi_sio_ids.h |   7 +
 3 files changed, 184 insertions(+), 180 deletions(-)

-- 
2.35.1

