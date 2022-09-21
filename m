Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660935BFCDF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiIULVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIULVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3C96FA31
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37DCC62234
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3598C433D6;
        Wed, 21 Sep 2022 11:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663759273;
        bh=fPiCJKp6nrGIanv5HhHDTTn1cI/kdQD4oxVt0AgK94w=;
        h=Date:From:To:Cc:Subject:From;
        b=XCdkhVJl2amefuAsAt+nUUwjxxdw6EBEqxHLd09/+MwB5aks6gyAMLoTnX7bk9264
         pyb7ZVW2wNdK/aSoTDVuX1trMOWUwmTPOMgbXT7LEl0hPfzILP8oPKtIbGl1fXbjzR
         KlZd9kP9YoITD54GxrM42H5LEca2JpD8antgXXbNSk4JBtVxvStPjmDYfclULkI3fm
         tSFPkW04zgLxDH6VUQAUWcKNjvkO1apILkFLXELH5/9uRRguljgskkVFE8vVDzhnH1
         I8+pks0+6VKlKhjKFgDkaKFpjwAsgYLeOQNi/wUe7enkprkcYTSJWi7QCIEiV+ATjS
         Ww9UJyR74vOXA==
Date:   Wed, 21 Sep 2022 14:21:08 +0300
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 6.1
Message-ID: <20220921112108.GA212106@ogabbay-vm-u20>
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

Hi Greg,

This is habanalabs pull request for the merge window of kernel 6.1.

This is a fairly quiet pull request that mainly contains additional debug
support (added trace events support) and new uAPIs to retrieve device
information.

And, as usual, there are multiple bug fixes, refactors, etc.

Full details are in the tag.

Thanks,
Oded

The following changes since commit ceecbbddbf549fe0b7ffa3804a6e255b3360030f:

  comedi: convert sysfs snprintf to sysfs_emit (2022-09-09 10:37:52 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-09-21

for you to fetch changes up to 259cee1c2422bcff7ba6bb4e8179faadb52ebdee:

  habanalabs: eliminate aggregate use warning (2022-09-20 15:52:27 +0300)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v6.1:

- Support new notifier event for device state change through eventfd.

- Add uAPI to retrieve device attestation information for Gaudi2.

- Add uAPI to retrieve the h/w status of all h/w blocks.

- Add uAPI to control the running mode of the engine cores in Gaudi2.

- Expose whether the device runs with secured firmware through the INFO ioctl
  and sysfs.

- Support trace events in DMA allocations and MMU map/unmap operations.

- Notify firmware when the device was acquired by a user process and when it
  was released. This is done as part of the RAS that the f/w performs.

- Multiple bug fixes, refactors and renames.

- Cleanup of error messages, moving some to debug level.

- Enhance log prints in case of h/w error events for Gaudi2.

----------------------------------------------------------------
Bharat Jauhari (1):
      habanalabs: fix spelling mistakes

Colin Ian King (1):
      habanalabs: Fix spelling mistake "Scrubing" -> "Scrubbing"

Dafna Hirschfeld (3):
      habanalabs: fix bug when setting va block size
      habanalabs: if map page fails don't try to unmap it
      habanalabs: set command buffer host VA dynamically

Dani Liberman (6):
      habanalabs: removed seq_file parameter from is_idle asic functions
      habanalabs: add uapi to retrieve engines status
      habanalabs: unify hwmon resources clean up
      habanalabs: rename error info structure
      habanalabs/gaudi2: add handling to pmmu events in eqe handler
      habanalabs/gaudi2: add secured attestation info uapi

Li zeming (1):
      habanalabs/gaudi2: Remove unnecessary (void*) conversions

Oded Gabbay (11):
      habanalabs/gaudi: increase default cs timeout to 10 minutes
      habanalabs: remove all kdma locks
      habanalabs/uapi: move defines to better place inside file
      habanalabs: move common function out of debugfs.c
      habanalabs: remove left-over code from bring-up
      habanalabs: fix missing info in sysfs documentation
      habanalabs: select FW_LOADER in Kconfig
      habanalabs/gaudi2: free event irq if init fails
      habanalabs: MMU invalidation h/w is per device
      habanalabs: failure to open device due to reset is debug level
      habanalabs: eliminate aggregate use warning

Ofir Bitton (12):
      habanalabs: rename non_hard_reset to compute_reset
      habanalabs/gaudi2: remove old interrupt mappings
      habanalabs: remove secured PCI IDs
      habanalabs: expose device security status through sysfs
      habanalabs: expose device security status using info ioctl
      habanalabs: perform context switch flow only if needed
      habanalabs: ignore EEPROM errors during boot
      habanalabs/gaudi2: dump detailed information upon RAZWI
      habanalabs: send device activity in a proper context
      habanalabs/gaudi: rename mme cfg error response print
      habanalabs: add support for new cpucp return codes
      habanalabs/gaudi2: allow user to flush PCIE by read

Ohad Sharabi (9):
      habanalabs: add return code field to module iterator
      habanalabs: wrap macro arg with parentheses
      habanalabs/gaudi: fix print format for div_sel
      habanalabs/gaudi: read div_sel value from firmware
      habanalabs: define trace events
      habanalabs: trace MMU map/unmap page
      habanalabs: trace DMA allocations
      habanalabs: fix resetting the DRAM BAR
      habanalabs: build ASICs from new to old

Omer Shpigelman (1):
      habanalabs: add cdev index data member

Rajarama Manjukody Bhat (1):
      habanalabs/gaudi2: assigning PQFs for ARC f/w in PDMA

Tal Cohen (4):
      habanalabs: fix command submission sanity check
      habanalabs/gaudi2: new API to control engine cores running mode
      habanalabs: new notifier events for device state
      habanalabs/gaudi: change TPC Assert to use TPC DEC instead of QMAN err

Tomer Tayar (11):
      habanalabs/gaudi2: enable all MMU SPI/SEI interrupts
      habanalabs/gaudi2: mark PCIE access error as fatal
      habanalabs: avoid returning a valid handle if map_block() fails
      habanalabs: fix vma fields assignments order in hl_hw_block_mmap()
      habanalabs: add a missing lock for in_reset indication
      habanalabs: fix H/W block handling for partial unmappings
      habanalabs: fix calculation of DRAM base address in PCIe BAR
      habanalabs/gaudi2: read F/W security indication after hard reset
      habanalabs/gaudi2: print RAZWI info upon PCIe access error
      habanalabs/gaudi2: increase hard-reset sleep time to 2 sec
      habanalabs/gaudi: use 8KB aligned address for TPC kernels

Yang Li (1):
      habanalabs: Simplify bool conversion

farah kassabri (6):
      habanalabs/gaudi2: change device f/w security check
      habanalabs/gaudi2: log critical events with no rate limit
      habanalabs: send device active message to f/w
      habanalabs: fix possible hole in device va
      habanalabs/gaudi2: get f/w reset status register dynamically
      habanalabs: remove some f/w descriptor validations

 Documentation/ABI/testing/sysfs-driver-habanalabs  |  12 +-
 MAINTAINERS                                        |   1 +
 drivers/misc/habanalabs/Kconfig                    |   1 +
 drivers/misc/habanalabs/Makefile                   |   8 +-
 drivers/misc/habanalabs/common/command_buffer.c    | 127 ++--
 .../misc/habanalabs/common/command_submission.c    |  75 ++-
 drivers/misc/habanalabs/common/debugfs.c           |  35 +-
 drivers/misc/habanalabs/common/device.c            | 147 +++--
 drivers/misc/habanalabs/common/firmware_if.c       | 184 ++++--
 drivers/misc/habanalabs/common/habanalabs.h        | 171 ++++--
 drivers/misc/habanalabs/common/habanalabs_drv.c    |  44 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  | 123 +++-
 drivers/misc/habanalabs/common/hw_queue.c          |   4 +-
 drivers/misc/habanalabs/common/hwmon.c             |  24 +-
 drivers/misc/habanalabs/common/memory.c            |  57 +-
 drivers/misc/habanalabs/common/memory_mgr.c        |  10 +-
 drivers/misc/habanalabs/common/mmu/mmu.c           |  31 +-
 drivers/misc/habanalabs/common/sysfs.c             |  10 +
 drivers/misc/habanalabs/gaudi/gaudi.c              | 185 +++---
 drivers/misc/habanalabs/gaudi2/gaudi2.c            | 671 ++++++++++++++-------
 drivers/misc/habanalabs/gaudi2/gaudi2P.h           |  10 +-
 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h      |  21 +-
 drivers/misc/habanalabs/gaudi2/gaudi2_security.c   |  26 +-
 drivers/misc/habanalabs/goya/goya.c                |  62 +-
 drivers/misc/habanalabs/include/common/cpucp_if.h  | 103 +++-
 .../misc/habanalabs/include/common/hl_boot_if.h    |  37 +-
 .../include/gaudi2/asic_reg/gaudi2_regs.h          |   2 +
 .../gaudi2/asic_reg/pcie_wrap_special_regs.h       | 185 ++++++
 .../include/gaudi2/gaudi2_async_virt_events.h      |  57 --
 include/trace/events/habanalabs.h                  |  93 +++
 include/uapi/misc/habanalabs.h                     | 137 ++++-
 31 files changed, 1859 insertions(+), 794 deletions(-)
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_wrap_special_regs.h
 delete mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_virt_events.h
 create mode 100644 include/trace/events/habanalabs.h
