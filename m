Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D396C027D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCSO5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCSO5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:57:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6151EBFC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:57:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DFA4B80B99
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA34DC4339B;
        Sun, 19 Mar 2023 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679237835;
        bh=rQ2FJMNAGosin0KbWPMNNMfnZEmtHRqNjoeHMVd/pG4=;
        h=Date:From:To:Cc:Subject:From;
        b=c4ZaOdurZsjVPSBgA3g3WgozSnXqWS0nSPTaptA+CO+Gib61O3X/dW7AAXDJah5oS
         hi2I7yP/J56m4+zbGtUKPsuDoTRhieesZWl7fVzoEAFefgZ4SlTetC+s+TGr8kU9QW
         NBD6+Np4fakryKWrlgmxnGOlZQEZV5YjP27JzuVU=
Date:   Sun, 19 Mar 2023 15:57:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver updates for 6.3-rc3
Message-ID: <ZBciwlyC4qJ63339@kroah.com>
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

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.3-rc3

for you to fetch changes up to f551592f72563e119bdec5b9d5242f584111b2aa:

  Merge tag 'icc-6.3-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus (2023-03-16 10:55:42 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 6.3-rc3.

Here are a few small char/misc/other driver subsystem patches to resolve
reported problems for 6.3-rc3.

Included in here are:
  - Interconnect driver fixes for reported problems
  - Memory driver fixes for reported problems.
  - nvmem core fix
  - firmware driver fix for reported problem.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dmitry Baryshkov (3):
      interconnect: qcom: osm-l3: fix icc_onecell_data allocation
      interconnect: qcom: sm8450: switch to qcom_icc_rpmh_* function
      interconnect: qcom: sm8550: switch to qcom_icc_rpmh_* function

Greg Kroah-Hartman (1):
      Merge tag 'icc-6.3-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus

Johan Hovold (17):
      interconnect: fix mem leak when freeing nodes
      interconnect: fix icc_provider_del() error handling
      interconnect: fix provider registration API
      interconnect: imx: fix registration race
      interconnect: qcom: osm-l3: fix registration race
      interconnect: qcom: rpm: fix probe child-node error handling
      interconnect: qcom: rpm: fix registration race
      interconnect: qcom: rpmh: fix probe child-node error handling
      interconnect: qcom: rpmh: fix registration race
      interconnect: qcom: msm8974: fix registration race
      interconnect: exynos: fix node leak in probe PM QoS error path
      interconnect: exynos: fix registration race
      interconnect: exynos: drop redundant link destroy
      memory: tegra: fix interconnect registration race
      memory: tegra124-emc: fix interconnect registration race
      memory: tegra20-emc: fix interconnect registration race
      memory: tegra30-emc: fix interconnect registration race

Konrad Dybcio (1):
      interconnect: qcom: qcm2290: Fix MASTER_SNOC_BIMC_NRT

Michael Walle (1):
      nvmem: core: return -ENOENT if nvmem cell is not found

Roman Gushchin (1):
      firmware: xilinx: don't make a sleepable memory allocation from an atomic context

 drivers/firmware/xilinx/zynqmp.c      |  2 +-
 drivers/interconnect/core.c           | 68 +++++++++++++++---------
 drivers/interconnect/imx/imx.c        | 20 +++----
 drivers/interconnect/qcom/icc-rpm.c   | 29 +++++-----
 drivers/interconnect/qcom/icc-rpmh.c  | 30 +++++++----
 drivers/interconnect/qcom/msm8974.c   | 20 +++----
 drivers/interconnect/qcom/osm-l3.c    | 16 +++---
 drivers/interconnect/qcom/qcm2290.c   |  4 +-
 drivers/interconnect/qcom/sm8450.c    | 98 +---------------------------------
 drivers/interconnect/qcom/sm8550.c    | 99 +----------------------------------
 drivers/interconnect/samsung/exynos.c | 30 +++++------
 drivers/memory/tegra/mc.c             | 16 +++---
 drivers/memory/tegra/tegra124-emc.c   | 12 ++---
 drivers/memory/tegra/tegra20-emc.c    | 12 ++---
 drivers/memory/tegra/tegra30-emc.c    | 12 ++---
 drivers/nvmem/core.c                  |  2 +-
 include/linux/interconnect-provider.h | 12 +++++
 17 files changed, 160 insertions(+), 322 deletions(-)
