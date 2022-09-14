Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A985B8AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiINOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiINOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:44:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D61BEC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663166684; x=1694702684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RfnAp9f4I03eZ+p3HsaFgjDRx24/Skg9LU3CvWNbqds=;
  b=gY0wKqK76syCcHn87dVp+gV02iTSIYZSd7aOQP2EyODkVlk0Q3ds700J
   XaK20QPMHE3iMezodyCFC/tmHBBkxmZRbLbwMS/bmfpzQPf+z4GkbPEIl
   vmIC0FF3SzXpI1g7eIU/WDqiV848Mt8tmcT4vA5IloMAWKMPdkYGHPWZD
   E92mMXlpM1UJfvh8+JfI9utfcOOaiuLOcu7d8SfRvB3hVuePNRigaKbno
   fevvS1UVMA5VmzHpmnHH14cwc9dIPa/Ag+Phfd+Fk8AP2raEIh7Ut9hPI
   NkXsEPF6iAsFTjchln9i9w0NUExKQIbrRoAqPGnPiApmXNAXhxuMAezH8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324700990"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="324700990"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 07:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="720608554"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2022 07:44:42 -0700
From:   wen.ping.teh@intel.com
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Teh Wen Ping <wen.ping.teh@intel.com>
Subject: [PATCH 2/2] arm64: defconfig: add CRYPTO_DEV_INTEL_FCS
Date:   Wed, 14 Sep 2022 22:44:23 +0800
Message-Id: <20220914144423.605529-1-wen.ping.teh@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teh Wen Ping <wen.ping.teh@intel.com>

Add CRYPTO_DEV_INTEL_FCS for Intel crypto service driver used in
SoCFPFA platforms.

Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d5b2d2dd4904..eb82957f3072 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -121,6 +121,7 @@ CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
 CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
 CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_AES_ARM64_BS=m
+CONFIG_CRYPTO_DEV_INTEL_FCS=m
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.25.1

