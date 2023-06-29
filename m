Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44233742427
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjF2Kqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjF2KqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:46:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276281FE8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688035570; x=1719571570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zhLC9JAzQNOB8jyzT8cMCfKVD3PidLJzPIIHOo/ep4E=;
  b=L9JYyc7sDAqx1OIa2Q3TjOqAmeKyqruccChTDC2HLCU4PaV/l2pggyS8
   S8iHJWBEUTgiszKNIesGjHdEmv2voAiPcmx2NQKenmsXBcncbxnN3NF7k
   Za/pIu4gr+HL5eNebdyOsaHTGiXyPMY/vY9UQjnOAeaWcyJSxZPojRLKF
   88087Rd0rKC+h0GDaJIuWJ78+t7KJpIARm3V5t+xO8egPgRiK39iR1n3E
   1YF1Nf62Z0W8yh8+OZ1zRzMr/U6+7N5UIuPH+ZfO38w28rlc2lgxuqV6m
   4yyeInUAg+RvHk0IGA5wtnibUEDuL+LfxlwDUyBCynGh4sFc38F22cAhz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="362115081"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="362115081"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 03:46:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="963948379"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="963948379"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2023 03:46:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AB1AA358; Thu, 29 Jun 2023 13:46:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 0/3] ASoC: rt5677: Refactor to use device_get_match_data()
Date:   Thu, 29 Jun 2023 13:46:00 +0300
Message-Id: <20230629104603.88612-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code can be simplified with device_get_match_data().
Besides that couple of additional changes, one for maintenance (patch 3)
and one for making IRQ domain agnostic (not pinned to OF).

Andy Shevchenko (3):
  ASoC: rt5677: Use agnostic irq_domain_create_linear()
  ASoC: rt5677: Use device_get_match_data()
  ASoC: rt5677: Sort headers alphabetically

 sound/soc/codecs/rt5677.c | 41 +++++++++++++--------------------------
 sound/soc/codecs/rt5677.h |  4 ++--
 2 files changed, 16 insertions(+), 29 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

