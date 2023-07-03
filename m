Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904C17459B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGCKJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjGCKJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:09:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC5FE60
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80BE860E8B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9110EC433C7;
        Mon,  3 Jul 2023 10:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688378947;
        bh=GQ/bo8iCwzIPO5Mvx+iHoZPyYWCr+8KNQLhnaaJdZT4=;
        h=Date:From:To:Cc:Subject:From;
        b=wy8vfn3L2o5i6/E72KmJYhQyM1esyIM8U6Yw7cbmn8KurrU38osggUP09hHSh1HYa
         Q2dSM1la68MbBN0SXKKLbcWO7Q/8bDd661iJCaAET4Rg7VhBZdPBQZ6Z/7IMrkffI3
         xJQSjIrsvYVPBolT51tYtYreja1IqAzI8PKNcoxo=
Date:   Mon, 3 Jul 2023 12:09:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core update for 6.5-rc1
Message-ID: <ZKKeQTv0ful5Ji_f@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.5-rc1

for you to fetch changes up to a91845b9a872039618d74104c0721376ce092638:

  sysfs: Skip empty folders creation (2023-06-15 13:37:53 +0200)

----------------------------------------------------------------
driver core changes for 6.5-rc1

Here are a small set of changes for 6.5-rc1 for some driver core
changes.  Included in here are:
  - device property cleanups to make it easier to write "agnostic"
    drivers when regards to the firmware layer underneath them (DT vs.
    ACPI)
  - debugfs documentation updates
  - devres additions
  - sysfs documentation and changes to handle empty directory creation
    logic better
  - tiny kernfs optimizations
  - other tiny changes

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (3):
      ACPI: Move ACPI_DEVICE_CLASS() to mod_devicetable.h
      device property: Implement device_is_compatible()
      ata: ahci_platform: Make code agnostic to OF/ACPI

Dave Jiang (1):
      base/node: Use 'property' to identify an access parameter

Greg Kroah-Hartman (1):
      Merge 6.4-rc5 into driver-core-next

Ivan Orlov (1):
      debugfs: Correct the 'debugfs_create_str' docs

James Clark (4):
      devres: Provide krealloc_array
      hwmon: pmbus: Use devm_krealloc_array
      iio: adc: Use devm_krealloc_array
      serial: qcom_geni: Comment use of devm_krealloc rather than devm_krealloc_array

James Seo (1):
      driver core: device.h: add some missing kerneldocs

Jesse Brandeburg (1):
      MAINTAINERS: add entry for auxiliary bus

Matti Vaittinen (1):
      drivers: fwnode: fix fwnode_irq_get[_byname]()

Miquel Raynal (2):
      sysfs: Improve readability by following the kernel coding style
      sysfs: Skip empty folders creation

Muchun Song (1):
      kernfs: fix missing kernfs_idr_lock to remove an ID from the IDR

Vladislav Efanov (1):
      isa: Remove unnecessary checks

 Documentation/driver-api/driver-model/devres.rst |   1 +
 MAINTAINERS                                      |  10 ++
 drivers/ata/ahci_platform.c                      |   8 +-
 drivers/base/isa.c                               |   7 +-
 drivers/base/node.c                              |   8 +-
 drivers/base/property.c                          |  12 ++-
 drivers/hwmon/pmbus/pmbus_core.c                 |   6 +-
 drivers/iio/adc/xilinx-ams.c                     |   9 +-
 drivers/iio/adc/xilinx-xadc-core.c               |  17 ++--
 drivers/tty/serial/qcom_geni_serial.c            |   5 +
 fs/debugfs/file.c                                |   9 --
 fs/kernfs/dir.c                                  |   2 +
 fs/sysfs/group.c                                 |  12 ++-
 include/linux/acpi.h                             |  14 ---
 include/linux/device.h                           | 122 ++++++++++++++++++++++-
 include/linux/mod_devicetable.h                  |  13 +++
 include/linux/property.h                         |  12 +++
 17 files changed, 204 insertions(+), 63 deletions(-)
