Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4300E73BE65
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjFWSbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjFWSbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:31:42 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5D273D;
        Fri, 23 Jun 2023 11:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSj4GL9o/CM1r8L/uoSo2U0W7Ir9gnC3OYU906hLzTGvSuE5Snh+2x8PgvBGjuhkDFMXxzjU9vlmGkKQiiAhGzwDoiw7ce3M+AXZv+aDGz2Yy/gFaGbuA8Wc/WIpyq4Nfxhy4ziAZlJJ4I1Sx/2tq2bnnestOc3ulwpq5qEoL7qQ1+UlFBDrMt6lpz/yBYltPZBk8aJKMowZoJr0+uZJS//sskrWUtx6K53XZuEGIx8n/G1nnytBQz/1kfDY9NkzhbhuQKdxDyWxCp98vLey5hQ6xDh0nSKAE7hUwhwbw8S8wQeNCF2/MB35g8/nQZZAfxC6KEIz2Wq+ZZ8kjAbp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOgWAtmbQ9NKRLIoXi4mJluXR/PtiZR/5JkJirvtQD8=;
 b=IRgF7s3qvX6h/8DvzrzyRJJtMnk/yQNKTY0bew07L63Vvb/itqx+b8VReYBmjWcA3WzkEyNB7b0Lza2JkBTnI/Gry4gxww6b+A6UL+gzy9INjmXLZd2s3szGvVECdatPOQ+SzcZHFF55dYos8gnj5QB0mtwabDCpOXEZvLCeADyXOslVCrLK2gTkMEnz4kw0dq9Oeke2OB25mx9ipl/nGPd32tQOYzIcZ6Ij7roOeTxXE7qz0hU1pfNjcTvjgRAwjkF7BwBEYPo77zYMX94JnwIDh8L0j0QTO6WVy3s2qE4WRbmFKXJnlomxR0Z8YnknPuLfIGB4jmAVrENjNakaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOgWAtmbQ9NKRLIoXi4mJluXR/PtiZR/5JkJirvtQD8=;
 b=OJ77BOuUM7i4IuxiSvwauvTQECBSdTBCF0APDh8JQVvYjyoRC1OFaeRfzirtlpR89TcDDzYpLgt+PUad9C4KFuPCa83hIqspw9j7f5p1cdBwETe5A36ntTrYtQNiqmsomtf78e4LIwIDO39STamm6DJRhblF8vdWsyo8pZtGwTU=
Received: from BL1P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::9)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 18:31:35 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::d) by BL1P221CA0003.outlook.office365.com
 (2603:10b6:208:2c5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Fri, 23 Jun 2023 18:31:35 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:31:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 02/11] crypto: ccp: Add support for displaying PSP firmware versions
Date:   Fri, 23 Jun 2023 08:49:52 -0500
Message-ID: <20230623135001.18672-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623135001.18672-1-mario.limonciello@amd.com>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|BN9PR12MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cd502c-92f6-4499-87d9-08db7418133f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0v2IrpqORLZnjNXe1cgmBUfeO7iGi2qXyvChq2zp+WF+m8CWUV8reCj99F3cItUen3ntCTfJfvPMHYvZb5ZsYuBKrEM6nk2fGLCg2MQjqggi5bZ6V4W8N8uzg/+f6HUV4Xfl93WdAmX5IjsbR9b30d5nNXO6AchFp676bdvCs5VB322UonS5872s3+DZNRk9tI+wHsglAZmJNgzvGjw7Y7W4aUiLDzGwDxFkwod0ZHs4Cs4I7bmNe81gqzBrPck1ZdCH3vaoELt4EBRbc27Qj+2rcfRAEzB/TDJWvptpeVis0qj+wTcDWBIf6p3oogyv3gVAuE/jkpNaNv4Hh8L4UUn1TuxD7bBlOcPXmEMT0WukElG+eQ8RGnM90msldyxFX32zYPbSy5Du0f03BBvBOGtmVrgY/oDU6AxdeRnMUkER/+f2mzmCs7U+JXHeJmfUuqWx+E7WV47C4r1yBq1k0ZVKKMJPAccL4chAAvRtXPa2MApzoMvbMjx2+RUjYBO3RANHZvj2H33tKKOA3nJUuNcsfiMPBkvHwN0H12CulIfC4MgEW8Xsyq/IJWAweyVCqEzU4ITob0JVny7L5x0ZX8g6GraGX0EKFi0pRYx3ydfb6pK0aR2LJXHzsrTcRq8KoaYHdlU9KwEZOuNcZDAnPOYZT/JkhjWmeKqsd2/dIx4OG4O8NLIvZeyurApIQjTO6SemS45sCHT3ARDxn8sOkxLVc2OqJyJCqGKp7509jB7POTu45CgotJGKutwAjOdMEZS4QXHYUosPvqVd3oecjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(6666004)(7696005)(426003)(1076003)(110136005)(5660300002)(83380400001)(54906003)(4326008)(70206006)(70586007)(8676002)(41300700001)(8936002)(336012)(44832011)(36860700001)(186003)(2906002)(47076005)(36756003)(82740400003)(16526019)(26005)(356005)(81166007)(82310400005)(40460700003)(316002)(2616005)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:31:35.3712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cd502c-92f6-4499-87d9-08db7418133f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it's not always obvious what PSP bootloader or TEE version are
present in OEM systems, add the ability to get this information from
sysfs for supported platforms.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Pick up tag
v1->v2:
 * Move GENMASK declarations to top of the file
 * Add comment to support why checking for 0xffffffff
---
 Documentation/ABI/testing/sysfs-driver-ccp | 18 ++++++
 drivers/crypto/ccp/sp-dev.h                |  2 +
 drivers/crypto/ccp/sp-pci.c                | 64 ++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ccp b/Documentation/ABI/testing/sysfs-driver-ccp
index 7aded9b755535..ee6b787eee7a0 100644
--- a/Documentation/ABI/testing/sysfs-driver-ccp
+++ b/Documentation/ABI/testing/sysfs-driver-ccp
@@ -85,3 +85,21 @@ Description:
 		Possible values:
 		0: Not enforced
 		1: Enforced
+
+What:		/sys/bus/pci/devices/<BDF>/bootloader_version
+Date:		June 2023
+KernelVersion:	6.4
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/bootloader_version
+		file reports the firmware version of the AMD AGESA
+		bootloader.
+
+What:		/sys/bus/pci/devices/<BDF>/tee_version
+Date:		June 2023
+KernelVersion:	6.4
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/tee_version
+		file reports the firmware version of the AMD Trusted
+		Execution Environment (TEE).
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 1253a02179858..76c32ee6bd657 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -51,6 +51,7 @@ struct tee_vdata {
 	const unsigned int cmdbuff_addr_hi_reg;
 	const unsigned int ring_wptr_reg;
 	const unsigned int ring_rptr_reg;
+	const unsigned int info_reg;
 };
 
 struct platform_access_vdata {
@@ -69,6 +70,7 @@ struct psp_vdata {
 	const unsigned int feature_reg;
 	const unsigned int inten_reg;
 	const unsigned int intsts_reg;
+	const unsigned int bootloader_info_reg;
 };
 
 /* Structure to hold SP device data */
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index c8f075a7f49f8..6c93577950c7b 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -8,6 +8,7 @@
  * Author: Gary R Hook <gary.hook@amd.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -24,6 +25,12 @@
 #include "ccp-dev.h"
 #include "psp-dev.h"
 
+/* used for version string AA.BB.CC.DD */
+#define AA				GENMASK(31, 24)
+#define BB				GENMASK(23, 16)
+#define CC				GENMASK(15, 8)
+#define DD				GENMASK(7, 0)
+
 #define MSIX_VECTORS			2
 
 struct sp_pci {
@@ -88,8 +95,65 @@ static struct attribute_group psp_security_attr_group = {
 	.is_visible = psp_security_is_visible,
 };
 
+#define version_attribute_show(name, _offset)					\
+static ssize_t name##_show(struct device *d, struct device_attribute *attr,	\
+			   char *buf)						\
+{										\
+	struct sp_device *sp = dev_get_drvdata(d);				\
+	struct psp_device *psp = sp->psp_data;					\
+	unsigned int val = ioread32(psp->io_regs + _offset);			\
+	return sysfs_emit(buf, "%02lx.%02lx.%02lx.%02lx\n",			\
+			  FIELD_GET(AA, val),			\
+			  FIELD_GET(BB, val),			\
+			  FIELD_GET(CC, val),			\
+			  FIELD_GET(DD, val));			\
+}
+
+version_attribute_show(bootloader_version, psp->vdata->bootloader_info_reg)
+static DEVICE_ATTR_RO(bootloader_version);
+version_attribute_show(tee_version, psp->vdata->tee->info_reg)
+static DEVICE_ATTR_RO(tee_version);
+
+static struct attribute *psp_firmware_attrs[] = {
+	&dev_attr_bootloader_version.attr,
+	&dev_attr_tee_version.attr,
+	NULL,
+};
+
+static umode_t psp_firmware_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sp_device *sp = dev_get_drvdata(dev);
+	struct psp_device *psp = sp->psp_data;
+	unsigned int val = 0xffffffff;
+
+	if (!psp)
+		return 0;
+
+	if (attr == &dev_attr_bootloader_version.attr &&
+	    psp->vdata->bootloader_info_reg)
+		val = ioread32(psp->io_regs + psp->vdata->bootloader_info_reg);
+
+	if (attr == &dev_attr_tee_version.attr &&
+	    psp->capability & PSP_CAPABILITY_TEE &&
+	    psp->vdata->tee->info_reg)
+		val = ioread32(psp->io_regs + psp->vdata->tee->info_reg);
+
+	/* If platform disallows accessing this register it will be all f's */
+	if (val != 0xffffffff)
+		return 0444;
+
+	return 0;
+}
+
+static struct attribute_group psp_firmware_attr_group = {
+	.attrs = psp_firmware_attrs,
+	.is_visible = psp_firmware_is_visible,
+};
+
 static const struct attribute_group *psp_groups[] = {
 	&psp_security_attr_group,
+	&psp_firmware_attr_group,
 	NULL,
 };
 
-- 
2.34.1

