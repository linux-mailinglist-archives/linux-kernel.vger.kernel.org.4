Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C1B6642CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjAJOH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbjAJOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:07:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F5BB1FD;
        Tue, 10 Jan 2023 06:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673359663; x=1704895663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MrltX0Mbfq5di0+cEUd00fzCE2JUwG4J0N0gH0rA9sM=;
  b=KCUGyR5GingMfiNDGABiPev6egDpKYNW1tDH/NGJ09oweDR8oJo1DEbn
   rHo6nbTJ+XOcxvHHDrQshMwUq9gvAZNQgaxz2eBP7GTSHJfrbrD4scuFa
   IlmHjoNj74xk5WAgT/qjCFAOPPn5HudH9jRO3t7RYAlb9/HvWL9ndQANC
   3sCOgXKeVnw4bmKJvW5OrsfJuSAX3dV/9FTqV8nE3wfSduSOy5rJ5jDF/
   VnathzoXVMKUntBcTtjujTWWCQ3mb9Kt0LN3xebuRggvMqEJFga8v5DqJ
   cu4vboZkSRGIfpE6mKKT3Gpvp7ZItxgLocxTYHJrtwZHPMH43vF4JLFAw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="325156495"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="325156495"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 06:07:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="606971784"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="606971784"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2023 06:07:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D6F65130; Tue, 10 Jan 2023 16:08:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/5] rtc: isl12022: Clean up and simplify the driver
Date:   Tue, 10 Jan 2023 16:08:01 +0200
Message-Id: <20230110140806.87432-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

While looking for something else I noticed that this driver is dusted
a bit. Clean up and simplify it using available kernel types and APIs.

Changelog v2:
- added tags to patches 1,2,4,5 (Rasmus)

Andy Shevchenko (5):
  rtc: isl12022: Get rid of unneeded private struct isl12022
  rtc: isl12022: Explicitly use __le16 type for ISL12022_REG_TEMP_L
  rtc: isl12022: Drop unneeded OF guards and of_match_ptr()
  rtc: isl12022: Join string literals back
  rtc: isl12022: sort header inclusion alphabetically

 drivers/rtc/rtc-isl12022.c | 93 ++++++++++++++------------------------
 1 file changed, 34 insertions(+), 59 deletions(-)

-- 
2.39.0

