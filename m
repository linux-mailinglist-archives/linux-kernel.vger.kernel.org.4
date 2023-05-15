Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3652A70260C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbjEOH2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjEOH2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:28:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0E8FF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684135714; x=1715671714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mgbFI2LcjG+t3blbDMXWX8oWe0oop5OUSyXsMN4g61I=;
  b=kOGr9YKvw/QWLz2wKzL5BH5wFXn8aBx0X7pDpHS+lsdmtqvYLXUNHOzc
   xmLrs0D0QZmEjowO8R1iOo7iX+cI30zDroaMtl3cMPTJh3IusvxGRIU18
   TemTdGJl42IU7ASPhl/tjxDxqGrWl3hbWzklzI5imXS10HKJp25uYw1Hd
   uZQP6MlRda8fIjHUfaHIaMKzspCRUG+TZ1Wb15QdTuk/foiga3zl5x17I
   8RO0D2dUDQJj+wMRYpNNbTCirJYSie2GkujoC6me19mgiP5eFepT3/Cwq
   mM77rqZ46lr21KzhSKyP7KWranK5ASE1EofszRpHWcthVDbcNILZ3ys+8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349973278"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="349973278"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 00:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694916013"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="694916013"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 00:28:27 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: dmi-quirks: add new mapping for HP Spectre x360
Date:   Mon, 15 May 2023 15:48:59 +0800
Message-Id: <20230515074859.3097-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

A BIOS/DMI update seems to have broken some devices, let's add a new
mapping.

Link: https://github.com/thesofproject/linux/issues/4323
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/dmi-quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 58ea013fa918..2a1096dab63d 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -99,6 +99,13 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)intel_tgl_bios,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8709"),
+		},
+		.driver_data = (void *)intel_tgl_bios,
+	},
 	{
 		/* quirk used for NUC15 'Bishop County' LAPBC510 and LAPBC710 skews */
 		.matches = {
-- 
2.25.1

