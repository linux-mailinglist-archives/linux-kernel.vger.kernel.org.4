Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450D4722019
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjFEHvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjFEHvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BDBFA;
        Mon,  5 Jun 2023 00:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F23620F6;
        Mon,  5 Jun 2023 07:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D897FC4331F;
        Mon,  5 Jun 2023 07:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685951506;
        bh=/h4ptRb9Bs12M5r6KuyA6+HTb9n3EoRbnEOx+GF2aaM=;
        h=From:To:Cc:Subject:Date:From;
        b=0jKrQxywjr6BI8/gNBlS5OWzuUy4dn4R0Udpk23+RFn66X9PWDf0Y6mxF159dhLup
         PPILAhJ7FF0iY+f2Xwwi5iY19ZRK84KbfGgtGrGAsO712d2jXYlrqrgYdJ5WxaY7Ta
         6Mnp9FdHmnN9p7RnooA0ERBkOzdnNxWd6hID+tIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.182
Date:   Mon,  5 Jun 2023 09:51:40 +0200
Message-ID: <2023060538-patient-clapped-4b71@gregkh>
X-Mailer: git-send-email 2.41.0
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

I'm announcing the release of the 5.10.182 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 arch/x86/include/asm/intel-family.h                  |    2 
 drivers/android/binder.c                             |   26 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c |   35 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h |    2 
 drivers/net/phy/mscc/mscc.h                          |    1 
 drivers/net/phy/mscc/mscc_main.c                     |   54 ++--
 drivers/power/supply/bq24190_charger.c               |   13 +
 drivers/power/supply/bq27xxx_battery.c               |  224 +++++++++----------
 drivers/power/supply/power_supply_core.c             |   57 ++--
 drivers/regulator/helpers.c                          |   65 +++++
 drivers/regulator/pca9450-regulator.c                |   55 ++--
 include/linux/power/bq27xxx_battery.h                |    3 
 include/linux/power_supply.h                         |    5 
 include/linux/regulator/driver.h                     |    5 
 include/net/ip.h                                     |    2 
 include/uapi/linux/in.h                              |    2 
 net/bluetooth/hci_sock.c                             |   28 ++
 net/ipv4/ip_sockglue.c                               |   12 -
 net/ipv4/raw.c                                       |    5 
 net/ipv6/raw.c                                       |    3 
 net/netfilter/nf_conntrack_netlink.c                 |    8 
 22 files changed, 386 insertions(+), 223 deletions(-)

Alexander Stein (1):
      regulator: pca9450: Fix BUCK2 enable_mask

Andreas Kemnade (1):
      power: supply: bq27xxx: fix polarity of current_now

Axel Lin (1):
      regulator: pca9450: Convert to use regulator_set_ramp_delay_regmap

Carlos Llamas (1):
      binder: fix UAF caused by faulty buffer cleanup

David Epping (1):
      net: phy: mscc: enable VSC8501/2 RGMII RX clock

Greg Kroah-Hartman (1):
      Linux 5.10.182

Hans de Goede (6):
      power: supply: bq27xxx: Add cache parameter to bq27xxx_battery_current_and_status()
      power: supply: bq27xxx: Move bq27xxx_battery_update() down
      power: supply: bq27xxx: Ensure power_supply_changed() is called on current sign changes
      power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize
      power: supply: core: Refactor power_supply_set_input_current_limit_from_supplier()
      power: supply: bq24190: Call power_supply_changed() after updating input current

Mark Bloch (1):
      net/mlx5: devcom only supports 2 ports

Matthias Schiffer (2):
      power: supply: bq27xxx: fix sign of current_now for newer ICs
      power: supply: bq27xxx: make status more robust

Matti Vaittinen (1):
      regulator: Add regmap helper for ramp-delay setting

Nicolas Dichtel (1):
      ipv{4,6}/raw: fix output xfrm lookup wrt protocol

Paul Blakey (1):
      netfilter: ctnetlink: Support offloaded conntrack entry deletion

Ruihan Li (1):
      bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

Shay Drory (1):
      net/mlx5: Devcom, serialize devcom registration

Sicelo A. Mhlongo (1):
      power: supply: bq27xxx: expose battery data when CI=1

Tony Luck (2):
      x86/cpu: Add Raptor Lake to Intel family
      x86/cpu: Drop spurious underscore from RAPTOR_LAKE #define

