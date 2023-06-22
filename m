Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3108873A0FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjFVMd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjFVMd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:33:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57614DE;
        Thu, 22 Jun 2023 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687437235; x=1718973235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+xXBsZeu/C5n4y0VRWD+a1OT5/PSdm3EkgcA5DMOcs8=;
  b=YbHQFvzHBV8MfT0ERF86SNmzRmdVRcji4WNnn9plZIbokjANiMSB0LT5
   uM4Pg8e3WxnCWkbxk0GKNIw9rm/ylnMyA7g4gI28JJvFgz45HREcSQobT
   CgOAXXsmyBwOWiJ4ysm23nWIEtLN7ysa3S+Xvwv9Dl7pRSCojJk203f96
   aQ8MQV8FmUO55BfddfG/d9A0A22YzoybbDd5OxOGFeEPy7rbgjiySrPx1
   J1F3Ls5PVQrLCs6e7F/RMSa1upjEqNON1dhe3WYRRvBY34n5f+Y3imAXy
   GA+WD99uISLN5E8WL/XWLC4qqkHVwVOBvoZKyK/YXHhTDfvvu3qirPAil
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="340811035"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="340811035"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="961566685"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="961566685"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2023 05:33:49 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH v2 0/2]: Enable UBIFS support
Date:   Thu, 22 Jun 2023 20:32:55 +0800
Message-Id: <20230622123254.593308-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Hi,
The patchset is to update the qspi mtd partition range for UBIFS on
socfpga platform - Agilex and Stratix10 boards.
The subsequent patch is enable the UBIFS in defconfig.

Alif Zakuan Yuslaimi (2):
  arm64: dts: agilex/stratix10: Updated QSPI Flash layout for UBIFS
  arm64: defconfig: Enable UBI and UBIFS

---
v2: Update subject prefix and defconfig config place
---

 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 8 ++++----
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 8 ++++----
 arch/arm64/configs/defconfig                           | 2 ++
 3 files changed, 10 insertions(+), 8 deletions(-)


base-commit: dad9774deaf1cf8e8f7483310dfb2690310193d2
-- 
2.25.1

