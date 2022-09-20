Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1425BE1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiITJXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiITJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:23:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D74FB6BD79
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:23:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1005D139F;
        Tue, 20 Sep 2022 02:23:13 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B74E3F73B;
        Tue, 20 Sep 2022 02:23:05 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [GIT PULL] Coresight changes for v6.1
Date:   Tue, 20 Sep 2022 10:22:38 +0100
Message-Id: <20220920092238.3798762-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the coresight self hosted trace subsystem updates for
v6.1. Kindly consider pulling.

Thanks
Suzuki


The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v6.1

for you to fetch changes up to 5fc1531dd771cd1481116a66f992a190e01efce6:

  hwtracing: hisi_ptt: Fix up for "iommu/dma: Make header private" (2022-09-12 10:12:25 -0600)

----------------------------------------------------------------
coresight: Changes for v6.1

Coresight trace subsystem updates for v6.1 includes:
  - Support for HiSilicon PTT trace
  - Coresight cleanup of sysfs accessor functions, reduced
    code size.
  - Expose coresight timestamp source for ETMv4+
  - DT binding updates to include missing properties
  - Minor documentation, Kconfig text fixes.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

----------------------------------------------------------------
Christophe JAILLET (1):
      coresight: docs: Fix a broken reference

German Gomez (2):
      coresight: etm4x: Expose default timestamp source in sysfs
      coresight: etm4x: docs: Add documentation for 'ts_source' sysfs interface

James Clark (5):
      coresight: Remove unused function parameter
      coresight: Simplify sysfs accessors by using csdev_access abstraction
      coresight: Re-use same function for similar sysfs register accessors
      coresight: cti-sysfs: Re-use same functions for similar sysfs register accessors
      coresight: Make new csdev_access offsets unsigned

Nathan Chancellor (1):
      coresight: cti-sysfs: Mark coresight_cti_reg_store() as __maybe_unused

Randy Dunlap (1):
      coresight: trbe: fix Kconfig "its" grammar

Rob Herring (2):
      dt-bindings: arm: coresight: Add 'power-domains' property
      dt-bindings: arm: coresight-tmc: Add 'iommu' property

Stephen Rothwell (1):
      hwtracing: hisi_ptt: Fix up for "iommu/dma: Make header private"

Yicong Yang (5):
      iommu/arm-smmu-v3: Make default domain type of HiSilicon PTT device to identity
      hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device
      hwtracing: hisi_ptt: Add tune function support for HiSilicon PCIe Tune and Trace device
      docs: trace: Add HiSilicon PTT device driver documentation
      MAINTAINERS: Add maintainer for HiSilicon PTT driver

 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |    8 +
 Documentation/ABI/testing/sysfs-devices-hisi_ptt   |   61 ++
 .../bindings/arm/arm,coresight-catu.yaml           |    3 +
 .../devicetree/bindings/arm/arm,coresight-cti.yaml |    3 +
 .../bindings/arm/arm,coresight-dynamic-funnel.yaml |    3 +
 .../arm/arm,coresight-dynamic-replicator.yaml      |    3 +
 .../bindings/arm/arm,coresight-etb10.yaml          |    3 +
 .../devicetree/bindings/arm/arm,coresight-etm.yaml |    3 +
 .../bindings/arm/arm,coresight-static-funnel.yaml  |    3 +
 .../arm/arm,coresight-static-replicator.yaml       |    3 +
 .../devicetree/bindings/arm/arm,coresight-stm.yaml |    3 +
 .../devicetree/bindings/arm/arm,coresight-tmc.yaml |    6 +
 .../bindings/arm/arm,coresight-tpiu.yaml           |    3 +
 .../bindings/arm/arm,embedded-trace-extension.yaml |    3 +
 .../trace/coresight/coresight-cpu-debug.rst        |    3 +-
 .../trace/coresight/coresight-etm4x-reference.rst  |   14 +
 Documentation/trace/hisi-ptt.rst                   |  298 ++++++
 Documentation/trace/index.rst                      |    1 +
 MAINTAINERS                                        |    8 +
 arch/arm64/include/asm/sysreg.h                    |    1 +
 drivers/Makefile                                   |    1 +
 drivers/hwtracing/Kconfig                          |    2 +
 drivers/hwtracing/coresight/Kconfig                |    4 +-
 drivers/hwtracing/coresight/coresight-catu.c       |   27 +-
 drivers/hwtracing/coresight/coresight-catu.h       |    8 +-
 drivers/hwtracing/coresight/coresight-core.c       |   28 +
 drivers/hwtracing/coresight/coresight-cti-sysfs.c  |  213 ++--
 drivers/hwtracing/coresight/coresight-etb10.c      |   28 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |   34 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   29 +
 drivers/hwtracing/coresight/coresight-priv.h       |   72 +-
 drivers/hwtracing/coresight/coresight-replicator.c |   10 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   40 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |   48 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |    4 +-
 drivers/hwtracing/ptt/Kconfig                      |   12 +
 drivers/hwtracing/ptt/Makefile                     |    2 +
 drivers/hwtracing/ptt/hisi_ptt.c                   | 1046 ++++++++++++++++++++
 drivers/hwtracing/ptt/hisi_ptt.h                   |  200 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |   21 +
 include/linux/coresight.h                          |   23 +
 41 files changed, 1973 insertions(+), 312 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-hisi_ptt
 create mode 100644 Documentation/trace/hisi-ptt.rst
 create mode 100644 drivers/hwtracing/ptt/Kconfig
 create mode 100644 drivers/hwtracing/ptt/Makefile
 create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
 create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
