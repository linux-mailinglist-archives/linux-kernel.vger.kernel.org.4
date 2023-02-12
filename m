Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F586936EE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBLK6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 05:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLK6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 05:58:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6C130CE;
        Sun, 12 Feb 2023 02:58:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 225C6B80C99;
        Sun, 12 Feb 2023 10:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E188C433D2;
        Sun, 12 Feb 2023 10:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676199488;
        bh=ihRlx+tYwmzXrATCPAflGyTAltQtRUqgsAbFDZbEIcA=;
        h=Date:From:To:Cc:Subject:From;
        b=0IDJQfZ5u8iy2Kt9PiPML0IyLKadjCdSAPpX4NH8RER9teLiAkz4cR0iCkF7MZf+K
         7XCHnkS+QU+2tE5re5h/CGPcX3ivPRXWxjnJpAooc9M0QSOaUzMhGmkWPwXEgxGp6w
         uaajgXeCvwwx7xUqjNnZEj1skCIJzTsGUPYR30AE=
Date:   Sun, 12 Feb 2023 11:58:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.2-rc8
Message-ID: <Y+jGPeHQov5f+pXH@kroah.com>
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

The following changes since commit 4ec5183ec48656cec489c49f989c508b68b518e3:

  Linux 6.2-rc7 (2023-02-05 13:13:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc8

for you to fetch changes up to 303e724d7b1e1a0a93daf0b1ab5f7c4f53543b34:

  usb: core: add quirk for Alcor Link AK9563 smartcard reader (2023-02-09 13:23:51 +0100)

----------------------------------------------------------------
USB fixes for 6.2-rc8

Here are 2 small USB driver fixes that resolve some reported regressions
and one new device quirk.  Specifically these are:
  - new quirk for Alcor Link AK9563 smartcard reader
  - revert of u_ether gadget change in 6.2-rc1 that caused problems
  - typec pin probe fix

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Mark Pearson (1):
      usb: core: add quirk for Alcor Link AK9563 smartcard reader

Paul Cercueil (1):
      Revert "usb: gadget: u_ether: Do not make UDC parent of the net device"

Prashant Malani (1):
      usb: typec: altmodes/displayport: Fix probe pin assign check

 drivers/usb/core/quirks.c                | 3 +++
 drivers/usb/gadget/function/u_ether.c    | 4 ++++
 drivers/usb/typec/altmodes/displayport.c | 8 ++++----
 3 files changed, 11 insertions(+), 4 deletions(-)
