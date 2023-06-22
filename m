Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98157398D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjFVIAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjFVH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:59:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB819B5;
        Thu, 22 Jun 2023 00:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687420791; x=1718956791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N61d6qM+RBKMdklc4MnkRjGJayI+qHEHLd53+uPTlp4=;
  b=kcmdIMW1gGLv7BfVERZT3x1mnbBYILLX3c7Pecrrw5T8M2y0bcvhqTfz
   vLiTPLoMop9XuhGfHUP/woLgdFPwlvY0mV4fZCMO7dgoZy5TK86DUi/wx
   c7Zwhgk2fhisbwcKmiKINdemnF4X3w2xcQzVjkrPU3eTaxvERtBqLKfRw
   hslDyfrTOndY5WIM0Vw7o8QqK6IpP5C3pvHaw/WWK2mIixymr6UZBTqqV
   0tZlv/3di4u1G8f7JHXPbhbOuKYI6G52aIXGETs8zcYLtp3I5iNsc+E6r
   xQuhOB7oDagQDZt/TCR42KK9Jq2JsyQO0F5oh9j3Rf3gNR6ZMvNut54Qk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="357912109"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="357912109"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 00:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="1045076176"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="1045076176"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2023 00:59:44 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH 0/2]: Enable UBIFS support
Date:   Thu, 22 Jun 2023 15:58:33 +0800
Message-Id: <20230622075833.470675-1-kah.jing.lee@intel.com>
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
socfpga platform. The subsequent patch is enable the UBIFS in defconfig.

Alif Zakuan Yuslaimi (2):
  HSD 14017166971: arch: arm64: boot: dts: Updated QSPI Flash layout for
    UBIFS
  HSD 14017166971: arch: arm64: configs: Enable UBI and UBIFS

 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 8 ++++----
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 8 ++++----
 arch/arm64/configs/defconfig                           | 2 ++
 3 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.1

