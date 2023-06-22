Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B565E739AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjFVIzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjFVIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:54:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9564D2126
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687424078; x=1718960078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zx7iUd56gjTFG6wuRYinNxSOIWG+aGygrZmK9b7NGDg=;
  b=oDxYDEox2QTLRzYIw4E5p2IbOZwFtv+6MVoJpip7tqRN+xDVeNbsjzZ5
   i7B66Y81vLxHR/MZr5EV9gSlLBzsWRbNnyUXewEOnn0Q+fij6AUKFBcsB
   w49hf/h6y8dLqLh3W6zUUNr0YwBANtdbBLfawbAJwuhNA6VPI+Noxba+L
   5ZUsGMLwS1E0/fPUxMYI/JwcgHpaBVq7MmdTNhcj08jAHK11d3RYkfuCO
   UNObr0ltJtrPOsiwAeK5sRamVVSWHQTrQEkHpdxH4g9HMDuwpaQbNwyK+
   /kRP8jIzXUoFMzQ+d9Jl2QiduZe4+oobxk3RnBDYdA6Ni+mWaOd6X0ekC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="446804338"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="446804338"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 01:54:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="804704449"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="804704449"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2023 01:54:34 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
        Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Date:   Thu, 22 Jun 2023 16:53:49 +0800
Message-Id: <20230622085349.573942-1-kah.jing.lee@intel.com>
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

This patch is to enable UBI and UBIFS in Linux defconfig.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..23a6ebcb1a9e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -470,6 +470,8 @@ CONFIG_IPMI_DEVICE_INTERFACE=m
 CONFIG_IPMI_SI=m
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_MTD_UBI=y
+CONFIG_UBIFS_FS=y
 CONFIG_TCG_TPM=y
 CONFIG_TCG_TIS=m
 CONFIG_TCG_TIS_SPI=m
-- 
2.25.1

