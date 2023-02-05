Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC8068AE16
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 03:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBEC7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 21:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEC7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 21:59:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35BE4481;
        Sat,  4 Feb 2023 18:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675565948; x=1707101948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GNH7lo4Wy4WNGKH6hRPPh/3G04IHu+IylJ90o+/5rmA=;
  b=RXoWafzPcU0UR6cA6s+SXZCFzEvGJqUxfs3OaLx7Qk8NbEEpPE5bPp3F
   m/ZS6M4OOpbva2oAJD/VFT+SlB4waXtZivRTvMm4gNCWXlSyURNq/vq4Q
   TFDYVWPC9URCw0fA19R4vSb5mR4FcWbj6ZQODtLzI3f9KHnS6AsiEoyxU
   g2yZRKsl3/NvZifDpm8zeYtS7YaN7P0L9lQ6zj0G5B+GzQhJdwYvjaLMO
   7zK0yqZxq874jGOr+jYIAh2IeLKuFT1vjb5v6UgViIoYPmEk+tgKZJwoZ
   LRptAtB3DvcPsFWQNYMPXuNPnjxxqs0laFjes8ewivBmtxbHlBKpghmBf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="326705485"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="326705485"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 18:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="666142165"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="666142165"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 04 Feb 2023 18:59:08 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/2] intel_powerclamp: New module parameter
Date:   Sat,  4 Feb 2023 18:59:00 -0800
Message-Id: <20230205025902.2899734-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split from the series for powerclamp user of powercap idle-inject.

v2
- Build warnings reported by Rui
- Moved the powerclamp documentation to admin guide folder
- Commit log updated as suggested by Rafael and other code suggestion

Srinivas Pandruvada (2):
  Documentation:admin-guide: Move intel_powerclamp documentation
  thermal/drivers/intel_powerclamp: Add two module parameters

 Documentation/admin-guide/index.rst           |   1 +
 .../thermal/intel_powerclamp.rst              |  22 +++
 Documentation/driver-api/thermal/index.rst    |   1 -
 MAINTAINERS                                   |   1 +
 drivers/thermal/intel/intel_powerclamp.c      | 177 +++++++++++++++---
 5 files changed, 180 insertions(+), 22 deletions(-)
 rename Documentation/{driver-api => admin-guide}/thermal/intel_powerclamp.rst (93%)

-- 
2.39.1

