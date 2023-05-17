Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E36706335
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjEQIoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEQIo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:44:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C29DDC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2UpQmms6WnjzUw4slh+GpbbMjFzE7K+qhgRZaJAsVq7cg70dnY/WwDBK82kmtnFKEJIS/Nblb2+1/p+ejlJyaxn+5pRFNqi/P8yfC6/PjBpkXdBLetSr2FJ0fWeBh3CPdQKXbv5vpnWbihTUpm4dYSXaHG8QsJGMRoBXQJgByDYPePFZ3nl9zAZ7Ncmxs1bc7Sig4o+tCMS7zlrf0pfL2c2TNo4r/2EMhlVJdgBcnI/90R6gXrPdMfckRE8xYsu8U00YmNpMw45ZXbImO+P7/YRxz2J6Xyewan+iZFLTurnrYp9j3ZfGA3elMB2dHNtyCtDntW2jZEaAS5CjCd75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzTkDU2qJZecO6YlShyUOc5fqvbnPxyJbmA3NjrFGfg=;
 b=JxyDP8/FTM6oRrLxquyFlyFvVfhVa8dIH8Hl9DpICDAUSzECL46MudKZZhoX8mvsMDQjh1kbAgWnilI7pZEKiz5qXPkmVK2FU02LQbjotBYeV4JQQ9RHXrSB/p4xLJjClppGwuJoAbUcfk4h5YdMB5inZEU/XHq/cd1KkFT+W6sVw2oN3ypTl4GERXVz0k+zs3VatjfeoXCDcRIrFElSJsR1fNskALnXHtth/dHvg7Hl1Q6FF4qXXjb18A4FAGg60uOWi3HwDd4hVX1O9cE6HHnmeS+IcsMYmqY3J+Q52yMzmU9MXJ8M2gEl8giIpR9Zr25q7x+6TtLejIW/vNH+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzTkDU2qJZecO6YlShyUOc5fqvbnPxyJbmA3NjrFGfg=;
 b=EIGMl/rl0uUVuVQNPOsC8NmZ8TrLWxNVjE/9swbTE+3tB1bzEi7H0j+VAUPcZQ2kwseX6qPsvjDDgSENIp7rGpk29AwVklTHz+mOH5wJazxP76AQRQcGNrJAO5vW7e+/jW2f1iGHzheKHmfHlcCyul/I3ByiJQFVpxJtStH/AKE=
Received: from DM6PR11CA0021.namprd11.prod.outlook.com (2603:10b6:5:190::34)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 08:44:23 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::e6) by DM6PR11CA0021.outlook.office365.com
 (2603:10b6:5:190::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 08:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Wed, 17 May 2023 08:44:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 03:44:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 03:44:22 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 03:44:20 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <nikhil.agarwal@amd.com>, <Nipun.Gupta@amd.com>,
        <gregkh@linuxfoundation.org>, <geert@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 1/1] cdx: Rename MCDI_LOGGING to CDX_MCDI_LOGGING
Date:   Wed, 17 May 2023 14:14:03 +0530
Message-ID: <20230517084404.187463-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT006:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbacd77-45fc-415f-40e8-08db56b2ea14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6vRDfA0XokN/SgUWefM5JOUbwjF+2r+H9WChQ3fTHKyVYdeKnOoIsAaO7e2mTsNjlx9j9YyqDGG2qymu8Hz0j31s3OsaKDmTao9QeWIC41gLLSLzRMFSph0u9y3h7lIhVFjcLSXR/MkhT5cllOzeZD4a3BJmEvALBCOxhncTh/Z7mbKElVp+8DiuZx0ivJIEHYcdftobVPmiei1kRZBgx0d/h+3dag0WUvj+YaloblBoWrkhtDSqnb/GsIjXvyqRZ932z6GPiTfr6UdxbVe2NV79gIK76q8WG21SZY/BZa7HCWXhsXnALj3fcCw8ShdXBrN8ZadBOL50glYSfKClTKk/LnfDbeuylNh68LpVEy61QripIfwrr+7ZGnxeqqP6/GE2HOoq9QJWykPJytd5VeG1JnBrXoDdkXMz+FG8h5RvOsF/H7Cs0ZV9vAlJlEHZLJ9Nz110zDhkpwv95c5XsJEhi3wjg0KY9F4L4TTWf6DvYySNX5SkzpFMtTDFEd89V1hGv2vEK3S1/5yhvwt0XFaf9XB0ukBHD3aVqPqbp9VZFHR7v2PDjjyYSMr/F/PNK0xr1D/DT0+Y4z09WdypiQpXu5JXwVSxgp4ZBZ4CZBK0jsHbS9zb9cQOLZo2TjHIlb3ZYQ69oe6MaHbuAE/CV6ujXp5jh0kIZdX5NLlytFdruDj0MqO9FnB7R1MstJGjH1INQ1pRLMiOwWzzqgGzwC0z95O0Jz0Jga254dyfQfxI+hZipVMGG3LUJwfTL5YL7kzWFf1WsNwYlsNlD9kipuwPaklctaC1ly/CQDuTp0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(86362001)(54906003)(316002)(110136005)(70206006)(70586007)(4326008)(478600001)(6666004)(40480700001)(2906002)(82310400005)(44832011)(8676002)(5660300002)(41300700001)(8936002)(82740400003)(81166007)(356005)(26005)(36860700001)(336012)(2616005)(186003)(426003)(83380400001)(47076005)(1076003)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 08:44:23.3639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbacd77-45fc-415f-40e8-08db56b2ea14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCDI_LOGGING is too generic considering other MCDI users
SFC_MCDI_LOGGING and SFC_SIENA_MCDI_LOGGING. Rename it to
CDX_MCDI_LOGGING makes it more domain specific.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/cdx/controller/Kconfig |  2 +-
 drivers/cdx/controller/mcdi.c  | 16 ++++++++--------
 drivers/cdx/controller/mcdi.h  |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cdx/controller/Kconfig b/drivers/cdx/controller/Kconfig
index c3e3b9ff8dfe..e7014e9819ea 100644
--- a/drivers/cdx/controller/Kconfig
+++ b/drivers/cdx/controller/Kconfig
@@ -18,7 +18,7 @@ config CDX_CONTROLLER
 
 	  If unsure, say N.
 
-config MCDI_LOGGING
+config CDX_MCDI_LOGGING
 	bool "MCDI Logging for the CDX controller"
 	depends on CDX_CONTROLLER
 	help
diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index a211a2ca762e..3a1fbc3d409e 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -31,7 +31,7 @@ struct cdx_mcdi_copy_buffer {
 	struct cdx_dword buffer[DIV_ROUND_UP(MCDI_CTL_SDU_LEN_MAX, 4)];
 };
 
-#ifdef CONFIG_MCDI_LOGGING
+#ifdef CONFIG_CDX_MCDI_LOGGING
 #define LOG_LINE_MAX		(1024 - 32)
 #endif
 
@@ -119,7 +119,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 	mcdi = cdx_mcdi_if(cdx);
 	mcdi->cdx = cdx;
 
-#ifdef CONFIG_MCDI_LOGGING
+#ifdef CONFIG_CDX_MCDI_LOGGING
 	mcdi->logging_buffer = kmalloc(LOG_LINE_MAX, GFP_KERNEL);
 	if (!mcdi->logging_buffer)
 		goto fail2;
@@ -136,7 +136,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 
 	return 0;
 fail3:
-#ifdef CONFIG_MCDI_LOGGING
+#ifdef CONFIG_CDX_MCDI_LOGGING
 	kfree(mcdi->logging_buffer);
 fail2:
 #endif
@@ -156,7 +156,7 @@ void cdx_mcdi_finish(struct cdx_mcdi *cdx)
 
 	cdx_mcdi_wait_for_cleanup(cdx);
 
-#ifdef CONFIG_MCDI_LOGGING
+#ifdef CONFIG_CDX_MCDI_LOGGING
 	kfree(mcdi->logging_buffer);
 #endif
 
@@ -246,13 +246,13 @@ static void cdx_mcdi_send_request(struct cdx_mcdi *cdx,
 	size_t hdr_len;
 	bool not_epoch;
 	u32 xflags;
-#ifdef CONFIG_MCDI_LOGGING
+#ifdef CONFIG_CDX_MCDI_LOGGING
 	char *buf;
 #endif
 
 	if (!mcdi)
 		return;
-#ifdef CONFIG_MCDI_LOGGING
+#ifdef CONFIG_CDX_MCDI_LOGGING
 	buf = mcdi->logging_buffer; /* page-sized */
 #endif
 
@@ -281,7 +281,7 @@ static void cdx_mcdi_send_request(struct cdx_mcdi *cdx,
 			     MC_CMD_V2_EXTN_IN_MCDI_MESSAGE_TYPE_PLATFORM);
 	hdr_len = 8;
 
-#ifdef CONFIG_MCDI_LOGGING
+#ifdef CONFIG_CDX_MCDI_LOGGING
 	if (!WARN_ON_ONCE(!buf)) {
 		const struct cdx_dword *frags[] = { hdr, inbuf };
 		const size_t frag_len[] = { hdr_len, round_up(inlen, 4) };
@@ -700,7 +700,7 @@ static bool cdx_mcdi_complete_cmd(struct cdx_mcdi_iface *mcdi,
 		resp_data_len = 0;
 	}
 
-#ifdef CONFIG_MCDI_LOGGING
+#ifdef CONFIG_CDX_MCDI_LOGGING
 	if (!WARN_ON_ONCE(!mcdi->logging_buffer)) {
 		char *log = mcdi->logging_buffer;
 		int i, bytes = 0;
diff --git a/drivers/cdx/controller/mcdi.h b/drivers/cdx/controller/mcdi.h
index 0bfbeab04e43..c881f3ecd8a9 100644
--- a/drivers/cdx/controller/mcdi.h
+++ b/drivers/cdx/controller/mcdi.h
@@ -170,7 +170,7 @@ struct cdx_mcdi_iface {
 	enum cdx_mcdi_mode mode;
 	u8 prev_seq;
 	bool new_epoch;
-#ifdef CONFIG_MCDI_LOGGING
+#ifdef CONFIG_CDX_MCDI_LOGGING
 	bool logging_enabled;
 	char *logging_buffer;
 #endif
-- 
2.25.1

