Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596756BCEED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCPMGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCPMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:06:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C5F65A6;
        Thu, 16 Mar 2023 05:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678968361; x=1710504361;
  h=from:to:cc:subject:date:message-id;
  bh=OzAcioscik7j5ytPlocSBa883d3OO/wP/79fGOzLC2g=;
  b=lDNHnbwQllzfrz77U2jWV+ivEMJSJnBYuP313okst6JJ8Sz9+PLHknNH
   fD5PkUGi4mt3bY76B5pzOQXXB+dtGOxVqPvMwiCtnKTGX72XksVFcLBol
   rJdvq9b7g1B5QIDDqyEj3wiWcg7H+AOzlUZZTHcWNvOhj4bR2GFl1hIJM
   qRQXd7U4VFux6DJ5RQLIAItfgTBu1/WWjXNYgoSrHSS2G3gPBDpr9JDFP
   O2yAUZziRJC9ln/JoVVJA8spEyLVQJYVIxIJ6m7L/ySWiQ8EWpizX40BX
   Pn8VlwKGSda9r7v3N0UdxJCv/WcWSjJZFS4WygQuzzUXWZBoPL/gqCzTY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="365656967"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="365656967"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 05:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="768911547"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="768911547"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2023 05:05:49 -0700
From:   rashmi.a@intel.com
To:     ulf.hansson@linaro.org, michal.simek@xilinx.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, kishon@kernel.org,
        yuancan@huawei.com, andriy.shevchenko@linux.intel.com,
        linux-phy@lists.infradead.org, mgross@linux.intel.com
Cc:     kris.pan@linux.intel.com, adrian.hunter@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        vasavi.v.itha@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v2 0/4] Remove Intel Thunder Bay emmc patches
Date:   Thu, 16 Mar 2023 17:35:45 +0530
Message-Id: <20230316120549.21486-1-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rashmi A <rashmi.a@intel.com>

Remove Thunder Bay specific code as the product got cancelled and 
there are no end customers or users.

In V2, cover letter has been added for the patchset, modified commit 
msg and patch subject in all the patches.


Thanks

A, Rashmi (4):
  mmc: sdhci-of-arasan: Remove Intel Thunder Bay SOC support
  dt-bindings: mmc: Remove bindings for Intel Thunder Bay SoC"
  phy: intel: Remove Thunder Bay eMMC PHY support
  dt-bindings: phy: intel: Remove Thunder Bay eMMC PHY bindings

 .../devicetree/bindings/mmc/arasan,sdhci.yaml |  25 -
 .../phy/intel,phy-thunderbay-emmc.yaml        |  45 --
 MAINTAINERS                                   |   7 -
 drivers/mmc/host/sdhci-of-arasan.c            |  29 +-
 drivers/phy/intel/Kconfig                     |  10 -
 drivers/phy/intel/Makefile                    |   1 -
 drivers/phy/intel/phy-intel-thunderbay-emmc.c | 509 ------------------
 7 files changed, 1 insertion(+), 625 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
 delete mode 100644 drivers/phy/intel/phy-intel-thunderbay-emmc.c

-- 
2.17.1

