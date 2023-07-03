Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C812D745581
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGCGfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjGCGfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:35:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB5BA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 23:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688366110; x=1719902110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/dPeAlBJmTopWuro2rTiMptBTV2ZiXDs8660987yeQg=;
  b=hUYO6GbxH8pzd00tx6/rJjrj7iOAtxFOP6i5NF00wXLiKuVFIEKiaDt1
   gdRhiAmQk8jPE6rwS6F86ggY3JSDp+IqZ4unMuyqZ8tPxFD1JQbv1eLEi
   LH4ohLHodqd2Digu0EF2hT8fJXKmMMWOmySisV4LdyYjwPmt1FsVAj24h
   2OcUFNqFzPJyN01+6354D9/enVnbksTHKWozX+zPxs3rrpcnMBtQZ6fKV
   mqCn0cSYnjWUVJ2mBx1PyyzNN1gc2IXzvfjYkiweieWIni/pk3gky0ZZd
   9+XQ55dob+zz8nij4id3OrSe+KQ2SJfT3I+o3fze5u2QFKpPz+OS+BD1O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="428846994"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="428846994"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 23:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="788399197"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="788399197"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2023 23:35:06 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>, catalin.marinas@arm.com,
        conor+dt@kernel.org, kah.jing.lee@intel.com,
        krzysztof.kozlowski@linaro.org, Markus.Elfring@web.de
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org, will@kernel.org
Subject: [PATCH v3 0/1]: Enable UBIFS support
Date:   Mon,  3 Jul 2023 14:33:11 +0800
Message-Id: <20230703063309.1342330-1-kah.jing.lee@intel.com>
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
The patch is to update the qspi mtd partition range for UBIFS on
socfpga platform - Agilex and Stratix10 boards.

Alif Zakuan Yuslaimi (1):
  arm64: dts: agilex/stratix10: Updated QSPI Flash layout for UBIFS

---
v2: Update subject prefix and defconfig config place
v3: Update commit message and drop defconfig patch since users can configure
    in menuconfig
---

 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 8 ++++----
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.25.1

