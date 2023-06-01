Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25916719D67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjFANW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjFANWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E33197;
        Thu,  1 Jun 2023 06:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5BCE64457;
        Thu,  1 Jun 2023 13:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A701BC433D2;
        Thu,  1 Jun 2023 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625773;
        bh=x9ZPTVpQjJhf4ZniXbV0JFHzKnExJhFKwjJVm5+TPvE=;
        h=From:To:Cc:Subject:Date:From;
        b=yrD/DPlRs/OCA6GQPsyl43WFPxa8u4bj2ATgzhLt7Tm1mVWYnSdRsXUL8kB1Tm1dY
         1zWmLJwDvisCrP4afssTPspX7gGJ4mjr66u2t1bkoPVpcBpydSpGoAXdeDlx1TyB2y
         ayImQZIXiyAPwT+njNuOUcOl/+lQkw7JhIZIhCzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.10 00/22] 5.10.182-rc1 review
Date:   Thu,  1 Jun 2023 14:20:58 +0100
Message-Id: <20230601131933.727832920@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.182-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.182-rc1
X-KernelTest-Deadline: 2023-06-03T13:19+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.10.182 release.
There are 22 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.182-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.182-rc1

Paul Blakey <paulb@nvidia.com>
    netfilter: ctnetlink: Support offloaded conntrack entry deletion

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    ipv{4,6}/raw: fix output xfrm lookup wrt protocol

Carlos Llamas <cmllamas@google.com>
    binder: fix UAF caused by faulty buffer cleanup

Ruihan Li <lrh2000@pku.edu.cn>
    bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

David Epping <david.epping@missinglinkelectronics.com>
    net: phy: mscc: enable VSC8501/2 RGMII RX clock

Shay Drory <shayd@nvidia.com>
    net/mlx5: Devcom, serialize devcom registration

Mark Bloch <mbloch@nvidia.com>
    net/mlx5: devcom only supports 2 ports

Alexander Stein <alexander.stein@ew.tq-group.com>
    regulator: pca9450: Fix BUCK2 enable_mask

Axel Lin <axel.lin@ingics.com>
    regulator: pca9450: Convert to use regulator_set_ramp_delay_regmap

Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
    regulator: Add regmap helper for ramp-delay setting

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq24190: Call power_supply_changed() after updating input current

Hans de Goede <hdegoede@redhat.com>
    power: supply: core: Refactor power_supply_set_input_current_limit_from_supplier()

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Ensure power_supply_changed() is called on current sign changes

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Move bq27xxx_battery_update() down

Sicelo A. Mhlongo <absicsz@gmail.com>
    power: supply: bq27xxx: expose battery data when CI=1

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Add cache parameter to bq27xxx_battery_current_and_status()

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    power: supply: bq27xxx: make status more robust

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    power: supply: bq27xxx: fix sign of current_now for newer ICs

Andreas Kemnade <andreas@kemnade.info>
    power: supply: bq27xxx: fix polarity of current_now

Tony Luck <tony.luck@intel.com>
    x86/cpu: Drop spurious underscore from RAPTOR_LAKE #define

Tony Luck <tony.luck@intel.com>
    x86/cpu: Add Raptor Lake to Intel family


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/x86/include/asm/intel-family.h                |   2 +
 drivers/android/binder.c                           |  26 ++-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |  35 ++--
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   2 +
 drivers/net/phy/mscc/mscc.h                        |   1 +
 drivers/net/phy/mscc/mscc_main.c                   |  54 ++---
 drivers/power/supply/bq24190_charger.c             |  13 +-
 drivers/power/supply/bq27xxx_battery.c             | 224 +++++++++++----------
 drivers/power/supply/power_supply_core.c           |  57 +++---
 drivers/regulator/helpers.c                        |  65 ++++++
 drivers/regulator/pca9450-regulator.c              |  55 +++--
 include/linux/power/bq27xxx_battery.h              |   3 +
 include/linux/power_supply.h                       |   5 +-
 include/linux/regulator/driver.h                   |   5 +
 include/net/ip.h                                   |   2 +
 include/uapi/linux/in.h                            |   2 +
 net/bluetooth/hci_sock.c                           |  28 +++
 net/ipv4/ip_sockglue.c                             |  12 +-
 net/ipv4/raw.c                                     |   5 +-
 net/ipv6/raw.c                                     |   3 +-
 net/netfilter/nf_conntrack_netlink.c               |   8 -
 22 files changed, 387 insertions(+), 224 deletions(-)


