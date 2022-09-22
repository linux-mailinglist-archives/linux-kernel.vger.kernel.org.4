Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A095E64FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiIVOUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiIVOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:20:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35FC83055D;
        Thu, 22 Sep 2022 07:20:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E93C1595;
        Thu, 22 Sep 2022 07:20:44 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6225B3F73B;
        Thu, 22 Sep 2022 07:20:36 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pawel Moll <Pawel.Moll@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: arm: Fix copyrights and license tags
Date:   Thu, 22 Sep 2022 15:20:07 +0100
Message-Id: <20220922142010.1412640-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of license tags and copyrights for the DT files of Arm Ltd.
devices was rather incoherent: some didn't carry either at all, some
just got a placeholder GPL-2.0 tag, others didn't use SPDX tags, etc.

Fix this by harmonising the licences and tags:
- Every file gets a SPDX tag, dual licensing with GPL and some BSD
  compatible license, as it is recommended for DT files.
- GPL requires a copyright line, so add Copyright lines to every file as
  well. The company used (either Arm Ltd. or Linaro) was derived by
  looking at the domain of the initial contributor. I would like to ask
  Grant Likely (or someone else from Linaro) to confirm this for Linaro.

This was triggered when trying to import kernel DT files into the
Trusted Firmware-A repository, so that the DTB can be built into the FIP
package. This requires both a BSD compatible license, but also does
checks for SPDX tags and Copyright lines in its CI.

Cheers,
Andre

Andre Przywara (3):
  arm64: dts: arm: unify DT license statements
  arm64: dts: arm: add copyright messages (Arm Ltd.)
  arm64: dts: arm: add copyright messages (Linaro)

 arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi      | 3 ++-
 arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts  | 3 ++-
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts       | 4 ++--
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi      | 3 ++-
 arch/arm64/boot/dts/arm/foundation-v8-psci.dts        | 3 ++-
 arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi       | 3 ++-
 arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi | 3 ++-
 arch/arm64/boot/dts/arm/foundation-v8.dts             | 5 ++---
 arch/arm64/boot/dts/arm/foundation-v8.dtsi            | 4 ++--
 arch/arm64/boot/dts/arm/fvp-base-revc.dts             | 4 +++-
 arch/arm64/boot/dts/arm/juno-base.dtsi                | 7 ++++++-
 arch/arm64/boot/dts/arm/juno-clocks.dtsi              | 3 +--
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi             | 7 ++++++-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi         | 3 +--
 arch/arm64/boot/dts/arm/juno-r1-scmi.dts              | 6 ++++++
 arch/arm64/boot/dts/arm/juno-r1.dts                   | 3 +--
 arch/arm64/boot/dts/arm/juno-r2-scmi.dts              | 6 ++++++
 arch/arm64/boot/dts/arm/juno-r2.dts                   | 3 +--
 arch/arm64/boot/dts/arm/juno-scmi.dts                 | 2 ++
 arch/arm64/boot/dts/arm/juno-scmi.dtsi                | 6 ++++++
 arch/arm64/boot/dts/arm/juno.dts                      | 3 +--
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts            | 4 +++-
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi  | 4 +++-
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi      | 4 +++-
 arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts  | 6 +++---
 25 files changed, 70 insertions(+), 32 deletions(-)

-- 
2.25.1

