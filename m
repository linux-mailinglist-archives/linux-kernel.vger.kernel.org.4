Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEC76F1E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbjD1S4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346468AbjD1S4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:56:08 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4D64EFE;
        Fri, 28 Apr 2023 11:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGInx/Jn6V599fH7MxVZeLu6BjNL8iXLN1wXyxJ/Dx/qVoLbrvL9lgCPoFBugR8HytE49xmkBoifC4St3+zgEberJ4VKDX7ezMtGgwl2ZttO6PJxxitOG7PiHh3j45adaPAPQYn2ljmUv18s4KIdbzXsmrm8CyQ25QczYnoy8BJQ2YEMlo+iA5vUJv0qgQ6+Ujwot4OmLAJ2m39pEUs2vfuSUlYSUBiDx1jHZJP/boW4BI4h4FsXldCLU7oHiSm4HIvVWVjmDKxWZPxpzyGtPrsyWD+Ph8rtScBdwtlT9JMqPus3L68lYkbmJFDhWJyIV13X+she+8FWC8AZZDXKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8pXCP4cZAIIewrP9UkvRDq/kcEppWjyHw+UNk2bTMk=;
 b=QmtTVVE4oNxr52I58W7NkIHcfji2gGyOjVoNGX+Lui3whKiPew0SC5WU5BrmA1wMnqjIaKlRUQtHnNk8EPIv1te2ptcN+3gAqcq8Ov+75+n0noGuHyibq+PnDyI4Mb9DW+GyPtt7dBNXG4RA6l72IyUgMwkcIwBq1BD8qAE+KPPcFRlAOby/3LYrkN+QlWYS4R9jGXTdnISw/qe0xrSKxIsrw6v5grbc0pShSZJWLLZH2tJhIKkszq9Q3RSh/Px9xE2fvxmvq2aPikDO419JOkizFK7WOTW/hUY9Q2ISoa85Wn45p2IPiTtDBDRHbmRdvYZmupZ8BoQRI38n/RItjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8pXCP4cZAIIewrP9UkvRDq/kcEppWjyHw+UNk2bTMk=;
 b=4oihphtGh1XFUqMIRBfPVQkR1glHiOcEnohDDodNj2iCO0ISDTpK4LQWIK5PRW9JmxALSHY2YNwX1dzVADoqelWYk+TCPDWXsrcG57FaO9FMQ8ndum4nYIsSqA/vzPJyS8D3L7jvf7TKFzOYhAFQSlZKhyauSoxnfRMwA9niLKg=
Received: from DS7PR07CA0024.namprd07.prod.outlook.com (2603:10b6:5:3af::6) by
 BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.23; Fri, 28 Apr 2023 18:56:03 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::76) by DS7PR07CA0024.outlook.office365.com
 (2603:10b6:5:3af::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 18:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.25 via Frontend Transport; Fri, 28 Apr 2023 18:56:01 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 13:56:00 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     David S Miller <davem@davemloft.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH v2 02/10] crypto: ccp: Add support for displaying PSP firmware versions
Date:   Fri, 28 Apr 2023 13:55:32 -0500
Message-ID: <20230428185543.8381-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230428185543.8381-1-mario.limonciello@amd.com>
References: <20230428185543.8381-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|BL1PR12MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 1206370c-59b9-4f27-4274-08db481a363c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xl0xSvkO7B403rdB4fY9ykvhLqrKF6ugCuD2ohZYEywWMyUqb2t2AtRrZ2DklFEjIxj1YruOO+miXl7FPPnfcUd+ITarvfTOiSCM42d3rHGk82TeGmw8nKgnqkgFqY8Rn3Tss58bfOFK0NRjJq7Hp+SxyZpzN/IieeOnOoo3gofkVbLuNzJwIp88KMyyV7gKef5Z+Q/NJ8kJjZZI3aUKTm285FFNOPR2ohKVWVXu+U0uLed96prB02K+kXUbDPeC6LI4Mc63lf6cdGvhft7iixUS3cPJOxC70Yphlxv7gaYBMF04+rx4pZpVx29ezBvMSHipEcjmksirrcm3aOcmvA9F9yk3rFZuSAVX5aWLg0bGVVnRfxdAUdaW7W0/i2YbqFn5By8H+jj9OR09lzc3JfQx6DgkAMUB2HiiVuHZI40rB3u1+ucmQf3qF/oYxXogm1Y+8OgnoqKcS7Unp92ONowCDhzUO1lcMYscJfUC+ljltZ3LK1jgmirKd5zLikSgz6da/M3v7UmOIyrBJQBmv/DyhgfR0Z8WOgGswwAJnBPX/haBK4Anl283iIuUMdC8cKN24NZKIQdxvsbIa7qWP/67jAzs08L5ifyXaYRUfTED04Tgb8xFYrFD/831pskK5G7DfSqytWJ7Aki0EG1O5tQPGRed8SXmZn+Yf6UgThA8ZbfJWTha7qg7foGwfnj6cLEHB2J7Qvih9HJmAqWmd7BKx27FiwXX2z3ayBAB29SaFSl1RVAg2FSRV0DBUj8oaVwe/kt36t76BZgM8v88Q9fGim+mqEKkQCQ5C8WigR4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(6636002)(110136005)(478600001)(7696005)(6666004)(40460700003)(41300700001)(83380400001)(2906002)(36860700001)(82740400003)(86362001)(5660300002)(44832011)(82310400005)(81166007)(356005)(8676002)(8936002)(16526019)(40480700001)(1076003)(186003)(26005)(70586007)(336012)(316002)(4326008)(47076005)(2616005)(426003)(70206006)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 18:56:01.8544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1206370c-59b9-4f27-4274-08db481a363c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
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
index 85e3dc8853e2..7ef7c09b4a2f 100644
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

