Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B67709E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjESRaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjESR3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:29:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F3110D4;
        Fri, 19 May 2023 10:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtHA6pCTX8HLx0rh5SWmSDAQUUFl3K4cLhlAP8dib2Cn2V7IBnoS3Qdg/RWXUSTqucQ6FbAaqVawFyb651zOmdTktGkVBrjIty3rlPviqggj/zwFvp9/Lzozb23QiKEEtJJs0IGjJv+hLuFDwg3g9PNpX1vT8QTUEKkBlC9oVGnGnafuI+DGSL1fEoPXUc2zQ9OjzibEDPmYv0Vp7H/JL4e6NZw9iX3rORgBU9wwFViNYxyDwmY5LxLOcpEl0pI37eBnQ27tRYQPbcfpStCufk7R+QP9b13I7d4F3kVNhNoNWqw5lVZQDOfgwgsybikYflT7ib3JZgmVEml0xKZ/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmmTnMcgBjF4jGvS3U3PBKUF7f02iPt5jZlaYir3rNw=;
 b=DuIKq/NHGeRffLGzw5BJAu0ssE5YPBfkVsoGcysgM+L3oVNvUGvMto6DeWk/xHKZxxCu57BeUyiX9iKSUa2uzF4Unt1myNOlIXdkXvAD3/7K9BDJj4JcPpvRow1SAhr73HyVxlKmzM5Zg+S4SMYY91eubmPDy05fxvk8hHKQgxNIC3fAxM9U9L4NS7v6mYH2hDCyVlrqeaSfq/OiX1U5fwzD7muDV9ZMKRgh3H8qKUmhinmdZO8mywfZ1B6UCDE3kuCqY6GP1t0zL0hiTCHDaloosmvs9U3KqTOwHKgS8tGOa69X9m3pshhHAo0e7UgQGNtC6KdxpzZBjbPoPmWnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmmTnMcgBjF4jGvS3U3PBKUF7f02iPt5jZlaYir3rNw=;
 b=G6fpXJsO6LQ1+dt62xWjSMrKGkJQFmyZFBxp4boBDgbhV45CUSW9GV1X+PGbcvmZZmTeU48YNjXWIK9Yq7ixy7z/vqO21aHIeEvkJOwQXLbeHTsQVNTS63xBCzSIbV6v6DPl7GA28DUuRJF/wzyPufLIQFcM7twTTvHHWqCQOkI=
Received: from DS7PR05CA0015.namprd05.prod.outlook.com (2603:10b6:5:3b9::20)
 by BY5PR12MB4998.namprd12.prod.outlook.com (2603:10b6:a03:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 17:29:02 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::9a) by DS7PR05CA0015.outlook.office365.com
 (2603:10b6:5:3b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Fri, 19 May 2023 17:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:29:01 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:29:00 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 02/10] crypto: ccp: Add support for displaying PSP firmware versions
Date:   Thu, 18 May 2023 22:24:40 -0500
Message-ID: <20230519032448.94279-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032448.94279-1-mario.limonciello@amd.com>
References: <20230519032448.94279-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|BY5PR12MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6144a0-b669-46b4-83be-08db588e899b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bEqZHsS0w2MEuJ92GoRjWvcXFHCp61QR3IMoXsY3aqtXdwFhpzgd1d12bAWx1MozAPq94ALT2+ZRpPoDXhHX+ieWKhubxwvG0S+c9tXcgh2HfiTVDqU5OFiZJ/5xBtf3C2Q52AJG2GitwwX0SRCXTJkt2DyDXyWd43whgCm3mzcb4dvDjXnsPOwSqwoQdtAs8O1aKBBaLgyJOhSGwUA3gxgBbXII9bO6a4giyuUJGcBmwTkbCBUwqYIe7PjTfRdlCwDx7NXnXB69ldjG4GAmbQy4Z/8/NfxZVAt4MeOYNFpiKqMbXE/1eRPzLToUySPcp90atovzWBGpZ8xpLtc+YjXy7LtvOHBvAw0t8YocmRJqUJtWbmdFEVxde6CCC3WU1Ja1PXXmoi+8xef/eU29soK+Ud2S3761+LSfqrLhoOILHDY7W2iyyDPek1T+Bb76GaY7M97+Ru27tQZToYlsd64MjithpeXHiUM4jtjD9n5SzmYNT9z/PYvPAkNtxF3Iq6CQ6lxCGF30wcQL+jW7rzdIMNWOZ14jrPaW5QYGmBvG2n/crolwHhqx87aSu2r9+9XSHB21qBP83PlhCuvQ9ZarIIxmOdmf9OXOMNzo760y8DOAGWtVwUHUbUttz1nrHIDtaeOHeJW8wrbtdyoq7zSnEutG9IDqCCe/gEkoVqBUeUtYXrsamKQxfpcalnOePso2PKq2gEtKHD+OkhiLioze2eDerSwYTkqtmKR8gMcR+7XHnfHU0ijF8rNT0RGCywlC9B/2K+BOl9sxE1Pgtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(70206006)(70586007)(4326008)(110136005)(54906003)(82740400003)(8936002)(8676002)(40480700001)(478600001)(316002)(6666004)(41300700001)(7696005)(40460700003)(2906002)(86362001)(356005)(81166007)(26005)(1076003)(44832011)(47076005)(186003)(36756003)(336012)(82310400005)(426003)(36860700001)(5660300002)(2616005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:29:01.9546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6144a0-b669-46b4-83be-08db588e899b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4998
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
index 7aded9b75553..ee6b787eee7a 100644
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
index 1253a0217985..76c32ee6bd65 100644
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
index c8f075a7f49f..6c93577950c7 100644
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

