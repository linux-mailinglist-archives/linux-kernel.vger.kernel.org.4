Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31315733AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjFPUfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjFPUex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:34:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9946B3A92;
        Fri, 16 Jun 2023 13:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686947692; x=1718483692;
  h=from:to:cc:subject:date:message-id;
  bh=vVgGqAyNl5vBCWDr5YPTMv4FWCA16rc2WpNbjjT7WcI=;
  b=kS7aDQ9Va+KJne9epVZRCTzUjTPgV6vad3jyDryNJIFZmFBBUKNQfpjl
   0Hb3bFQsxxxzm/lMFag7bFZ/2F0tef0UwMdgFQ12PqmLAOc7+9mejlqDd
   xgBgDiI5NM6MsJlpYiSHVxO/GXdOpCFfzjo9rGcGXXU4lmCwRNqQX+ol7
   iiNvtPkIdAdKtWMYoJ9hHWDbYb4153NYccS1Fe8Dx0aB+51QnguB5ImEe
   U6IUpl2Il/PtX4RKYWfQW3deeVFzPHd6H/m0E+jwKngOdaKpbvixGyMry
   vaLc6xX2qJtg9fW1m1Uoy1g0Dd/KB3oktnpRbjrXA4rpz6KdzVxhuXogD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="358181778"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="358181778"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 13:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="802964399"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="802964399"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2023 13:34:50 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 4EB536A;
        Sat, 17 Jun 2023 02:04:49 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 489CDCA; Sat, 17 Jun 2023 02:04:49 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH for-next v1 0/3] Minor improvements for Baytrail pinctrl
Date:   Sat, 17 Jun 2023 02:03:53 +0530
Message-Id: <20230616203356.27343-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements minor improvements for Baytrail pinctrl driver.

Raag Jadav (3):
  pinctrl: baytrail: reduce scope of spinlock in ->dbg_show() hook
  pinctrl: baytrail: add warning for BYT_VAL_REG retrieval failure
  pinctrl: baytrail: invert if condition

 drivers/pinctrl/intel/pinctrl-baytrail.c | 32 ++++++++++++++----------
 1 file changed, 19 insertions(+), 13 deletions(-)

-- 
2.17.1

