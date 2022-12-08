Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DF1647197
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiLHOXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiLHOWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:22:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E8F98971;
        Thu,  8 Dec 2022 06:21:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C346B823ED;
        Thu,  8 Dec 2022 14:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B365C433D6;
        Thu,  8 Dec 2022 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670509301;
        bh=CHUUS11Irklp2aq0yPULup9/8ZfZ0PcKy0w6/BW9dOM=;
        h=Date:From:To:Cc:Subject:From;
        b=QXpxl8NvdTHnmXleeXCFtlVY1zWFVBY2ND4tWwe7H3TUohJeDDoU8nGJzVUwWWNnN
         SURG7f7SVvmdUgulfAvD8LIcwN2oPGmd6pSIYphhxcRTJ7wbd6LJ7o7avOJzlB8BSh
         fcm18g9wY3z/GsaqktDgO9CBKJtTlTdkzWdcs5Vp78xjpS6117esbeLZLlBLjV61rz
         nLUxxG1O/9KN9MT5EBYmrC3Cq/FwUYswhMbV+13e8J+F67A/AT/ezDssFZnFD4eZjv
         2XtCV+gY0gdm1ljDY9D4qhbFocvarUZsGPfMsVZXPGu6k7IzC+trjUot+KdRSKs3x3
         wgy1m+/PHV6BA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p3Hmd-0005Kz-12; Thu, 08 Dec 2022 15:21:55 +0100
Date:   Thu, 8 Dec 2022 15:21:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 6.2-rc1
Message-ID: <Y5HzA49I6EB1IlNr@hovoldconsulting.com>
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

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.2-rc1

for you to fetch changes up to 63b8ed26cd093ecc1bcdd1fd841f238a52c11031:

  USB: serial: xr: avoid requesting zero DTE rate (2022-11-30 12:28:51 +0100)

----------------------------------------------------------------
USB-serial updates for 6.2-rc1

Here are the USB-serial updates for 6.2-rc1, including:

 - B0 hangup support for cp210x
 - avoid requesting a zero DTE rate which could potentially confuse
   buggy firmware in XR devices

Included are also some new device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Bruno Thomsen (1):
      USB: serial: cp210x: add Kamstrup RF sniffer PIDs

Duke Xin (1):
      USB: serial: option: add Quectel EM05-G modem

Johan Hovold (2):
      USB: serial: cp210x: add support for B0 hangup
      USB: serial: xr: avoid requesting zero DTE rate

 drivers/usb/serial/cp210x.c    | 21 +++++++++++++++++----
 drivers/usb/serial/option.c    |  3 +++
 drivers/usb/serial/xr_serial.c |  2 --
 3 files changed, 20 insertions(+), 6 deletions(-)
