Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE85FF414
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJNT0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiJNT0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:26:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8581DBBFE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1803B82351
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 19:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E7EC433D6;
        Fri, 14 Oct 2022 19:25:57 +0000 (UTC)
Date:   Fri, 14 Oct 2022 20:25:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.1-rc1
Message-ID: <Y0m3wla/xisWPOkN@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some arm64 fixes below. They are based on top of the
arm64-upstream tag you pulled at the start of the merging window.
Thanks.

The following changes since commit d2995249a2f72333a4ab4922ff3c42a76c023791:

  arm64: alternatives: Use vdso/bits.h instead of linux/bits.h (2022-10-05 10:44:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 0e5d5ae837c8ce04d2ddb874ec5f920118bd9d31:

  arm64: Add AMPERE1 to the Spectre-BHB affected list (2022-10-12 17:36:06 +0100)

----------------------------------------------------------------
arm64 fixes:

- Cortex-A55 errata workaround (repeat TLBI).

- AMPERE1 added to the Spectre-BHB affected list.

- MTE fix to avoid setting PG_mte_tagged if no tags have been touched on
  a page.

- Fixed typo in the SCTLR_EL1.SPINTMASK bit naming (the commit log has
  other typos).

- perf: return value check in ali_drw_pmu_probe(),
  ALIBABA_UNCORE_DRW_PMU dependency on ACPI.

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: mte: Avoid setting PG_mte_tagged if no tags cleared or restored

D Scott Phillips (1):
      arm64: Add AMPERE1 to the Spectre-BHB affected list

Geert Uytterhoeven (1):
      drivers/perf: ALIBABA_UNCORE_DRW_PMU should depend on ACPI

James Morse (1):
      arm64: errata: Add Cortex-A55 to the repeat tlbi list

Lukas Bulwahn (1):
      MAINTAINERS: rectify file entry in ALIBABA PMU DRIVER

Mark Brown (1):
      arm64/sysreg: Fix typo in SCTR_EL1.SPINTMASK

Sun Ke (1):
      drivers/perf: fix return value check in ali_drw_pmu_probe()

 Documentation/arm64/silicon-errata.rst |  2 ++
 MAINTAINERS                            |  2 +-
 arch/arm64/Kconfig                     | 17 +++++++++++++++++
 arch/arm64/include/asm/cputype.h       |  4 ++++
 arch/arm64/kernel/cpu_errata.c         |  5 +++++
 arch/arm64/kernel/mte.c                |  9 +++++++--
 arch/arm64/kernel/proton-pack.c        |  6 ++++++
 arch/arm64/mm/mteswap.c                |  7 ++++++-
 arch/arm64/tools/sysreg                |  2 +-
 drivers/perf/Kconfig                   |  2 +-
 drivers/perf/alibaba_uncore_drw_pmu.c  |  4 ++--
 11 files changed, 52 insertions(+), 8 deletions(-)

-- 
Catalin
