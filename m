Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF156A7FDD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCBKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCBKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:20:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6E28865
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 458E661552
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B74C433D2;
        Thu,  2 Mar 2023 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677752419;
        bh=lUxwLcyL3jfyWqQLMr6tMcK4qBGZsSbHbSqmjNPGnD0=;
        h=Date:From:To:Cc:Subject:From;
        b=gxw5BCEjJcoBmCLsoG+5zzp886glr5Zqw6mNpadPLqsjXJrX/4SELa4UhYYHjiql8
         mKU9wnPwDb6AAXLZiIbuKS8IzyHRemPMW3sN7K+WXs4/AXoyhiLC7MEYEb9HwT6cbA
         okX4w79ZNhSkfMUk4SxyQsI1up1/YPIXsvCY3Es0=
Date:   Thu, 2 Mar 2023 11:20:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 6.3-rc1
Message-ID: <ZAB4YGjj/M9scmiQ@kroah.com>
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

The following changes since commit a93e884edf61f9debc9ca61ef9e545f0394ab666:

  Merge tag 'driver-core-6.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2023-02-24 12:58:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.3-rc1_2

for you to fetch changes up to 0c058fb94ae0e2a68639f4569de1c3abf5df7ad7:

  driver core: fw_devlink: Print full path and name of fwnode (2023-02-25 10:52:02 +0100)

----------------------------------------------------------------
Driver core fixes for 6.3-rc1

Here is another small set of driver core patches for 6.3-rc1

They resolve some reported problems with the previous driver core
patches that are in your tree.

They solve a problem with the bus_type cleanup as reported and fixced by
Geert, and 2 fw_devlink changes to make debugging problems easier.
There is one known outstanding problem with the fw_deflink changes in
your tree that is still being worked on, and it looks like a clk core
change will be submitted soon for that, probably after 6.3-rc1.

All 3 of these have been in linux-next with no reported problems (only
reports that they fixed problems.)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Geert Uytterhoeven (1):
      driver core: bus: Handle early calls to bus_to_subsys()

Saravana Kannan (2):
      driver core: fw_devlink: Avoid spurious error message
      driver core: fw_devlink: Print full path and name of fwnode

 drivers/base/bus.c  |  2 +-
 drivers/base/core.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)
