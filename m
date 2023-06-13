Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC772EFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbjFMWvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240428AbjFMWvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:51:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0107107;
        Tue, 13 Jun 2023 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686696700; x=1718232700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0y2SXSYUlk74dD53z2Wh46+0OJbeHYYcJ6sfyOXUXL8=;
  b=mkCkTyNFULv+VrYm5sm25awZkKyN1Z/Zb8mFU7nJ005Gl+fJ1E/n7vxT
   /vXSrE5NpAjazGGeI5oxrKajaKqtXArjkzUp0sGfqjXEGO1GAVUUpYo+R
   DzHrDtunt+QeT4zk8uZp1hg7HnCHJJbI2ac74q9oNs5RSGd5EuZIbU6T4
   tV/OhTUbLCpx04RPNhwmO4oeV4kLIZit8l1IJIBxdSS3EKlQ7Vv0q+8HX
   X+9y4r9AIbcX+c3meRYGU7QdXlWAOqjCX8Lv0tCoscSEWfi8nVxsDaybS
   MHzlXmQ7QWqbhrRJVrcokkV39AeA/C43PoawDFXkRFRJcXW/Xrp3oxPm+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444842204"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="444842204"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824589655"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="824589655"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 15:51:39 -0700
Received: from rjingar-desk5.amr.corp.intel.com (hciettox-mobl.amr.corp.intel.com [10.212.23.107])
        by linux.intel.com (Postfix) with ESMTP id 40262580BF8;
        Tue, 13 Jun 2023 15:51:39 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     david.e.box@linux.intel.com, ilpo.jarvinen@linux.intel.com,
        irenic.rajneesh@gmail.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, hdegoede@redhat.com
Cc:     xi.pardee@intel.com, Rajvi Jingar <rajvi.jingar@linux.intel.com>
Subject: [PATCH 8/8] platform/x86:intel/pmc: Add Meteor Lake IOE-M PMC related maps
Date:   Tue, 13 Jun 2023 15:53:47 -0700
Message-Id: <20230613225347.2720665-9-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613225347.2720665-1-rajvi.jingar@linux.intel.com>
References: <20230613225347.2720665-1-rajvi.jingar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Pardee <xi.pardee@intel.com>

Add device ID and register maps for the PMC in IO expansion die M in
Meteor Lake.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h |   6 ++
 drivers/platform/x86/intel/pmc/mtl.c  | 145 ++++++++++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 0c899efaa206..0729f593c6a7 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -478,6 +478,12 @@ extern const struct pmc_bit_map mtl_ioep_vnn_req_status_3_map[];
 extern const struct pmc_bit_map mtl_ioep_vnn_misc_status_map[];
 extern const struct pmc_bit_map *mtl_ioep_lpm_maps[];
 extern const struct pmc_reg_map mtl_ioep_reg_map;
+extern const struct pmc_bit_map mtl_ioem_pfear_map[];
+extern const struct pmc_bit_map *ext_mtl_ioem_pfear_map[];
+extern const struct pmc_bit_map mtl_ioem_power_gating_status_1_map[];
+extern const struct pmc_bit_map mtl_ioem_vnn_req_status_1_map[];
+extern const struct pmc_bit_map *mtl_ioem_lpm_maps[];
+extern const struct pmc_reg_map mtl_ioem_reg_map;
 
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
 extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index da3dba8c653b..2204bc666980 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -784,8 +784,149 @@ const struct pmc_reg_map mtl_ioep_reg_map = {
 	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
 };
 
+const struct pmc_bit_map mtl_ioem_pfear_map[] = {
+	{"PMC_0",               BIT(0)},
+	{"OPI",                 BIT(1)},
+	{"TCSS",                BIT(2)},
+	{"RSVD3",               BIT(3)},
+	{"SPA",                 BIT(4)},
+	{"SPB",                 BIT(5)},
+	{"SPC",                 BIT(6)},
+	{"IOE_D2D_3",           BIT(7)},
+
+	{"RSVD8",               BIT(0)},
+	{"RSVD9",               BIT(1)},
+	{"SPE",                 BIT(2)},
+	{"RSVD11",              BIT(3)},
+	{"RSVD12",              BIT(4)},
+	{"SPD",                 BIT(5)},
+	{"ACE_7",               BIT(6)},
+	{"RSVD15",              BIT(7)},
+
+	{"ACE_0",               BIT(0)},
+	{"FIACPCB_P",           BIT(1)},
+	{"P2S",                 BIT(2)},
+	{"RSVD19",              BIT(3)},
+	{"ACE_8",               BIT(4)},
+	{"IOE_D2D_0",           BIT(5)},
+	{"FUSE",                BIT(6)},
+	{"RSVD23",              BIT(7)},
+
+	{"FIACPCB_P5",          BIT(0)},
+	{"ACE_3",               BIT(1)},
+	{"RSF5",                BIT(2)},
+	{"ACE_2",               BIT(3)},
+	{"ACE_4",               BIT(4)},
+	{"RSVD29",              BIT(5)},
+	{"RSF10",               BIT(6)},
+	{"MPFPW5",              BIT(7)},
+
+	{"PSF9",                BIT(0)},
+	{"MPFPW4",              BIT(1)},
+	{"RSVD34",              BIT(2)},
+	{"RSVD35",              BIT(3)},
+	{"RSVD36",              BIT(4)},
+	{"RSVD37",              BIT(5)},
+	{"RSVD38",              BIT(6)},
+	{"RSVD39",              BIT(7)},
+
+	{"SBR0",                BIT(0)},
+	{"SBR1",                BIT(1)},
+	{"SBR2",                BIT(2)},
+	{"SBR3",                BIT(3)},
+	{"SBR4",                BIT(4)},
+	{"RSVD45",              BIT(5)},
+	{"RSVD46",              BIT(6)},
+	{"RSVD47",              BIT(7)},
+
+	{"RSVD48",              BIT(0)},
+	{"FIA_P5",              BIT(1)},
+	{"RSVD50",              BIT(2)},
+	{"RSVD51",              BIT(3)},
+	{"RSVD52",              BIT(4)},
+	{"RSVD53",              BIT(5)},
+	{"RSVD54",              BIT(6)},
+	{"ACE_1",               BIT(7)},
+
+	{"RSVD56",              BIT(0)},
+	{"ACE_5",               BIT(1)},
+	{"RSVD58",              BIT(2)},
+	{"G5FPW1",              BIT(3)},
+	{"RSVD60",              BIT(4)},
+	{"ACE_6",               BIT(5)},
+	{"RSVD62",              BIT(6)},
+	{"GBETSN1",             BIT(7)},
+
+	{"RSVD64",              BIT(0)},
+	{"FIA",                 BIT(1)},
+	{"RSVD66",              BIT(2)},
+	{"FIA_P",               BIT(3)},
+	{"TAM",                 BIT(4)},
+	{"GBETSN",              BIT(5)},
+	{"IOE_D2D_2",           BIT(6)},
+	{"IOE_D2D_1",           BIT(7)},
+
+	{"SPF",                 BIT(0)},
+	{"PMC_1",               BIT(1)},
+	{}
+};
+
+const struct pmc_bit_map *ext_mtl_ioem_pfear_map[] = {
+	mtl_ioem_pfear_map,
+	NULL
+};
+
+const struct pmc_bit_map mtl_ioem_power_gating_status_1_map[] = {
+	{"PSF9_PGD0_PG_STS",                    BIT(0)},
+	{"MPFPW4_PGD0_PG_STS",                  BIT(1)},
+	{"SBR0_PGD0_PG_STS",                    BIT(8)},
+	{"SBR1_PGD0_PG_STS",                    BIT(9)},
+	{"SBR2_PGD0_PG_STS",                    BIT(10)},
+	{"SBR3_PGD0_PG_STS",                    BIT(11)},
+	{"SBR4_PGD0_PG_STS",                    BIT(12)},
+	{"FIA_P5_PGD0_PG_STS",                  BIT(17)},
+	{"ACE_PGD1_PGD0_PG_STS",                BIT(23)},
+	{"ACE_PGD5_PGD1_PG_STS",                BIT(25)},
+	{"G5FPW1_PGD0_PG_STS",                  BIT(27)},
+	{"ACE_PGD6_PG_STS",                     BIT(29)},
+	{"GBETSN1_PGD0_PG_STS",                 BIT(31)},
+	{}
+};
+
+const struct pmc_bit_map *mtl_ioem_lpm_maps[] = {
+	mtl_ioep_clocksource_status_map,
+	mtl_ioep_power_gating_status_0_map,
+	mtl_ioem_power_gating_status_1_map,
+	mtl_ioep_power_gating_status_2_map,
+	mtl_ioep_d3_status_0_map,
+	mtl_ioep_d3_status_1_map,
+	mtl_ioep_d3_status_2_map,
+	mtl_ioep_d3_status_3_map,
+	mtl_ioep_vnn_req_status_0_map,
+	mtl_ioep_vnn_req_status_1_map,
+	mtl_ioep_vnn_req_status_2_map,
+	mtl_ioep_vnn_req_status_3_map,
+	mtl_ioep_vnn_misc_status_map,
+	mtl_socm_signal_status_map,
+	NULL
+};
+
+const struct pmc_reg_map mtl_ioem_reg_map = {
+	.regmap_length = MTL_IOE_PMC_MMIO_REG_LEN,
+	.pfear_sts = ext_mtl_ioem_pfear_map,
+	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
+	.ppfear_buckets = MTL_IOE_PPFEAR_NUM_ENTRIES,
+	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
+	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
+	.lpm_sts = mtl_ioem_lpm_maps,
+	.ltr_show_sts = mtl_ioep_ltr_show_map,
+	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
+	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
+};
+
 #define PMC_DEVID_SOCM	0x7e7f
 #define PMC_DEVID_IOEP	0x7ecf
+#define PMC_DEVID_IOEM	0x7ebf
 static struct pmc_info mtl_pmc_info_list[] = {
 	{
 		.devid = PMC_DEVID_SOCM,
@@ -795,6 +936,10 @@ static struct pmc_info mtl_pmc_info_list[] = {
 		.devid = PMC_DEVID_IOEP,
 		.map = &mtl_ioep_reg_map,
 	},
+	{
+		.devid = PMC_DEVID_IOEM,
+		.map = &mtl_ioem_reg_map
+	},
 	{}
 };
 
-- 
2.25.1

