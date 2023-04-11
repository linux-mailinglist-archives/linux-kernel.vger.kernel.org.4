Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60C6DDA08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDKLtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDKLtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:49:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BDAE40
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681213735; x=1712749735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gdqzNey9v88AME0HCzq4ZT5UoKs0G2Cb7/F4Vv0vD9o=;
  b=fbsbvOGKSI9podb85JCcgk0oiyfKCBGSTOfbMItLmf47Lonn0LMiZ6kA
   /sdTLOVM9OVbCQ+vgIG7hnwRy3NLDRgnEBvxh8EzvyiBmlsOUtVQIaD1x
   Svm2Ku4T4J3nGLvaiHnubSxj3/81zP/EUcP7urU76ifxwlbTVlZ2sUlIl
   y3MLT6BLMglClHD2fl6yGt726gCDzYruK/o+RvtdIDWrHwTI1RMMWFwh5
   noT4f5AW6e5+m8x5RenuD0F9XzabHcKkTnWNKDW5zRj5UEjiTp7a02SxC
   AlAEWJs0zawbEQvO5yldy22crwAaus8jdaPD1sz6bAy+KW7UK35IWrMYd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="343600839"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343600839"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="777888101"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="777888101"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2023 04:48:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2C915438; Tue, 11 Apr 2023 14:48:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cwchoi00@gmail.com>
Subject: [PATCH v3 0/3] extcon: Core cleanups and documentation fixes
Date:   Tue, 11 Apr 2023 14:48:21 +0300
Message-Id: <20230411114824.82960-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few fixes and some cleanups against extcon core module.

Changelog v3:
- dropped NAKed patches
- added missing tag (Chanwoo)
- dropped unrelated change in patch 2 (Chanwoo)
- dropped misplaced tags (Chanwoo)

Changelog v2:
- dropped applied patches
- completely rewrote the patch to handle name field
- dropped kasprintf_strarray() patch for now (Chanwoo)
- used new IDA APIs (Chanwoo)
- added tag (Bumwoo) to the patches that haven't changed

Cc: Chanwoo Choi <cwchoi00@gmail.com>

Note, MAINTAINERS shows what it has and hence the above Cc is manually
added. If the database has issues it should be updated, but it's out of
scope of this series.

Andy Shevchenko (3):
  extcon: Use unique number for the extcon device ID
  extcon: Use sizeof(*pointer) instead of sizeof(type)
  extcon: Drop unneeded assignments

 drivers/extcon/extcon.c | 35 +++++++++++++++++++++--------------
 drivers/extcon/extcon.h |  2 ++
 2 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

