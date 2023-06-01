Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF88719D66
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjFANWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjFANWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:22:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F161139;
        Thu,  1 Jun 2023 06:22:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C05FC64450;
        Thu,  1 Jun 2023 13:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C05C433D2;
        Thu,  1 Jun 2023 13:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625768;
        bh=J/f6faeRfVz1/CP022sJVxdUHJWxvOp4f5UITT+pH50=;
        h=From:To:Cc:Subject:Date:From;
        b=aBeBDQi/x5QNE3GQR2ZcI2hDvWk78IkjIwQm02ThJDHWzyroQpfZWYVBswg/xc5Ll
         kHqEuxSNvzbVvuD0RnNVKeCYLhW/OWiebb9vpptUqm0JGXqtIif2lE5IvPHGelez5v
         oz9TkiRZccrqoD/u9z/a4xqy7pAoZbUKbMZM0yaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.4 00/16] 5.4.245-rc1 review
Date:   Thu,  1 Jun 2023 14:20:55 +0100
Message-Id: <20230601131931.947241286@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.245-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.245-rc1
X-KernelTest-Deadline: 2023-06-03T13:19+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.4.245 release.
There are 16 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.245-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.245-rc1

Paul Blakey <paulb@nvidia.com>
    netfilter: ctnetlink: Support offloaded conntrack entry deletion

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    ipv{4,6}/raw: fix output xfrm lookup wrt protocol

Carlos Llamas <cmllamas@google.com>
    binder: fix UAF caused by faulty buffer cleanup

Ruihan Li <lrh2000@pku.edu.cn>
    bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

Jens Axboe <axboe@kernel.dk>
    io_uring: have io_kill_timeout() honor the request references

Jens Axboe <axboe@kernel.dk>
    io_uring: don't drop completion lock before timer is fully initialized

Jens Axboe <axboe@kernel.dk>
    io_uring: always grab lock in io_cancel_async_work()

Alexander Bersenev <bay@hackerdom.ru>
    cdc_ncm: Fix the build warning

Shay Drory <shayd@nvidia.com>
    net/mlx5: Devcom, serialize devcom registration

Mark Bloch <mbloch@nvidia.com>
    net/mlx5: devcom only supports 2 ports

Hao Ge <gehao@kylinos.cn>
    fs: fix undefined behavior in bit shift for SB_NOUSER

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq24190: Call power_supply_changed() after updating input current

Hans de Goede <hdegoede@redhat.com>
    power: supply: core: Refactor power_supply_set_input_current_limit_from_supplier()

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize

Tudor Ambarus <tudor.ambarus@linaro.org>
    net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize

Alexander Bersenev <bay@hackerdom.ru>
    cdc_ncm: Implement the 32-bit version of NCM Transfer Block


-------------

Diffstat:

 Makefile                                           |   4 +-
 drivers/android/binder.c                           |  26 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |  35 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   2 +
 drivers/net/usb/cdc_ncm.c                          | 435 ++++++++++++++++-----
 drivers/net/usb/huawei_cdc_ncm.c                   |   8 +-
 drivers/power/supply/bq24190_charger.c             |  13 +-
 drivers/power/supply/bq27xxx_battery.c             |   4 +-
 drivers/power/supply/power_supply_core.c           |  57 +--
 fs/io_uring.c                                      |   8 +-
 include/linux/fs.h                                 |  40 +-
 include/linux/power_supply.h                       |   5 +-
 include/linux/usb/cdc_ncm.h                        |  15 +-
 include/net/ip.h                                   |   2 +
 include/uapi/linux/in.h                            |   2 +
 net/bluetooth/hci_sock.c                           |  28 ++
 net/ipv4/ip_sockglue.c                             |  12 +-
 net/ipv4/raw.c                                     |   5 +-
 net/ipv6/raw.c                                     |   3 +-
 net/netfilter/nf_conntrack_netlink.c               |   8 -
 20 files changed, 521 insertions(+), 191 deletions(-)


