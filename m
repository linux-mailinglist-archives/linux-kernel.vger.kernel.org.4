Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75A37398F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjFVIFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjFVIFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:05:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99118E57;
        Thu, 22 Jun 2023 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687421112; x=1718957112;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JWCUKpf0KP37qTSf6RCX5zqUGN/1rszFQcUfaea30M0=;
  b=IkdfnP4svBAYLkUTQeG06zY83nTneLQYHaPzdBnsSijh1H2Gs2Npyw0R
   7M3j0mbUFWmfhjsHFh0xQtWtX7jpX2Vv4+6tCiI9ZMP/6s8GWXn2cMEA8
   ucGPjVWsR4mOhG6NeIr1RLL1Nrnrba1oalafXuipiCVU8wpmBGopzoLzP
   eCUFWKuVZOQNSV6O1z8LxfWk7E47AgFhAlGrH1Czy9C1LIYFYkfuLCj9W
   rjtb6HLPajDW1iK2HaLcqbu4VWib4yTTzbpMoSrjHhwvoHy8G+gsNR2yv
   UDHIsukSV2QPJppxgK7fvXnS18s7trerYO7y8ijAXSZaTX2P6JOdmJTo+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="390091984"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="390091984"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 01:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="888991362"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="888991362"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2023 01:05:09 -0700
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
Date:   Thu, 22 Jun 2023 16:04:35 +0800
Message-Id: <20230622080435.471363-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
  arch: arm64: boot: dts: Updated QSPI Flash layout for UBIFS
  arch: arm64: configs: Enable UBI and UBIFS

 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 8 ++++----
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 8 ++++----
 arch/arm64/configs/defconfig                           | 2 ++
 3 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.1

