Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8305E7DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiIWPL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiIWPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:11:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5445133CA6;
        Fri, 23 Sep 2022 08:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3803ACE2526;
        Fri, 23 Sep 2022 15:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB93C433D6;
        Fri, 23 Sep 2022 15:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663945908;
        bh=vk70JID/GHP8eJg1LQHkRA5bSH2AshLHuYckeVqGrcg=;
        h=Date:From:To:Cc:Subject:From;
        b=qYYRrBVRAUyYNOYov9qjO/wOqN3SvD0ulDGp34PogffS3WqIIXfETDUCPOeEspwfl
         nmUxzZUaHWWVT7w+Yqtp6woQi0PfLmzB+y6fcc16LsBnQJKhVrnLo+DbPztft9BCM4
         s7n+jJ+OnjJhMAvFCy6Y5mhlPrEmS5mds4qi02A0=
Date:   Fri, 23 Sep 2022 17:11:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver fixes for 6.0-rc7
Message-ID: <Yy3Msbnbxhs1OZLD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.0-rc7

for you to fetch changes up to 47af6c640ed82f111dbce0b3bf4083a91d61e324:

  Merge tag 'usb-serial-6.0-rc7' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2022-09-22 15:43:18 +0200)

----------------------------------------------------------------
USB / Thunderbolt driver fixes and ids for 6.0-rc7

Here are a few small USB and Thunderbolt driver fixes and new device ids
for 6.0-rc7.

They contain:
	- new usb-serial driver ids
	- documentation build warning fix in USB hub code
	- flexcop-usb long-posted bugfix (the v4l maintainer for this is
	  MIA so I have finally picked this up as it is a fix for a
	  reported problem.)
	- dwc3 64bit DMA bugfix
	- new thunderbolt device ids
	- typec build error fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: core: Fix RST error in hub.c

Carl Yin(殷张成) (1):
      USB: serial: option: add Quectel BG95 0x0203 composition

Gil Fine (1):
      thunderbolt: Add support for Intel Maple Ridge single port controller

Greg Kroah-Hartman (2):
      Merge tag 'thunderbolt-for-v6.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus
      Merge tag 'usb-serial-6.0-rc7' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Johan Hovold (1):
      media: flexcop-usb: fix endpoint type check

Ren Zhijie (1):
      usb: typec: anx7411: Fix build error without CONFIG_POWER_SUPPLY

William Wu (1):
      usb: dwc3: core: leave default DMA if the controller does not support 64-bit DMA

jerry meng (1):
      USB: serial: option: add Quectel RM520N

 drivers/media/usb/b2c2/flexcop-usb.c |  2 +-
 drivers/thunderbolt/icm.c            |  1 +
 drivers/thunderbolt/nhi.h            |  1 +
 drivers/usb/core/hub.c               |  2 +-
 drivers/usb/dwc3/core.c              | 13 +++++++------
 drivers/usb/serial/option.c          |  6 ++++++
 drivers/usb/typec/Kconfig            |  1 +
 7 files changed, 18 insertions(+), 8 deletions(-)
