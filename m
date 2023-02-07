Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF768DEF5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjBGRcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBGRcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:32:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F8F392B9;
        Tue,  7 Feb 2023 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675791142; x=1707327142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s9XYyOhSDhlb3x72J9xbcE+E8WZUiOaJL5RBPD5rP9w=;
  b=jkA8OJ22tTCfTPiImy8uLrDmhlaOltsZN6Qnn4ADb9LIUu5CEX7Ivvve
   PI8FNU4lZISng0znvIF+k0IICNwzts0e7w//ixSbagjLzdcKocNr+N/Wv
   LOAcyWCOUdH4hTVgzaVWjhtgxSHzm1bGExwMfM8vOGIU6/P9ion1UTy9B
   4d3FDmHnnEqByg4IZN2YEOVK2M62RiCm+U1YdnyHEmOx0UJFZRfWNifmH
   1ttWwguceJfZe1rz02fIv3Cvlkk8LER2XiPl2ontEEGWARJQlGLQ68+A5
   l5ZPXq2586Sy85T1/RNg8bASpcC0fhKNJegLK/pim9+WedOSRn04IHUtT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331702652"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="331702652"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 09:32:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="699325494"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="699325494"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2023 09:32:21 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/2] intel_powerclamp: New module parameter
Date:   Tue,  7 Feb 2023 09:32:17 -0800
Message-Id: <20230207173219.4190013-1-srinivas.pandruvada@linux.intel.com>
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

Split from the series for powerclamp user of powercap idle-inject
series:
Use idle_inject framework for intel_powerclamp version v5.


v3:
minor document change

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

