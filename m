Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9498169B831
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 06:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBRFiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 00:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBRFim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 00:38:42 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5955CF1A;
        Fri, 17 Feb 2023 21:38:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUhT2g9pcpG0fpHLeP/wT1vVG3NLY6bMnLmEVwB4v+Q3kQD9+TfE5n1aMqyHxBPGvs4aEcCs2FSHP4PX8mEcuzhdriZBrCM2pDAnASIzCAMLXlf+fBYi1nh4Cu6gi86O3w6lsnFr6CkG2GlFj+tcT3xq9jQLSUbHqym6M4FQhvdU9c75Z9EuCEYXtGS2fbHRLAUrd6wlozryK4hg5NaJ+Lttl7p5dI7XjZhIJyx9kC2XGHCeXoagAFYkB+pAWJ0/vd7mDoNcZXg7KUw6oaH7/MvwsIc+gL7BNIfN34ilVBfObtC8IHPXZ6EZ95t2/CA6ScRGBAfc9EYq/lS4+JwsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em2WKHdphSWEBzT622szO6xsFNYNKys9bL7PGdNfLeo=;
 b=g9jkBEwEtJwWlo3JejZapbapYXh1d3lU2XikmfdWqsauLGRPUYJ4Sk7JM6BGjIqE0Ouhqo8nRjgN+izqj4HPaBxDtyaoC8+7dKXay3M7DFbWrF5SZmW6OXutfEm5jIMKkMcbFDt+dQvHYPRo8KfP23GLLZqqWh6INOEf2Ogjz8fX76d7fgV68UU8PuM5nXTd1w8iqQxPhLGagiPDxdhIgWKgJFdMtqxbLIFNniIqnfsrUNGwgaAXQzGtxtwXB04/uaz4gEiJVxDN2WKv5h/3/HoB5AondY3FBQ1S8uTeUhm/aLIpAazcuAMgZWRuXMmMyvP7vIg3MAZ0phTb/ayVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em2WKHdphSWEBzT622szO6xsFNYNKys9bL7PGdNfLeo=;
 b=LFUwxob4fkugwK/m9H8OkyEDWZMAk7Sy4PNGzf/wuUjUXNotkiqmFbIxxoZwwZAqhfC+7KmAYbed+cqG1HtV/VdP3IHZYxxmCERqUh7qjaMuFmXjBAt2PbCqjZDElzVUHFUHRohnmuJPylFoFKeNLKt2B9L9xCeUyn9lEz2bkFQ=
Received: from BN9PR03CA0913.namprd03.prod.outlook.com (2603:10b6:408:107::18)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17; Sat, 18 Feb
 2023 05:38:38 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::d1) by BN9PR03CA0913.outlook.office365.com
 (2603:10b6:408:107::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15 via Frontend
 Transport; Sat, 18 Feb 2023 05:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.18 via Frontend Transport; Sat, 18 Feb 2023 05:38:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 23:38:37 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 21:38:36 -0800
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Feb 2023 23:38:34 -0600
From:   Harsha Harsha <harsha.harsha@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <git@amd.com>,
        Harsha Harsha <harsha.harsha@amd.com>,
        Dhaval Shah <dhaval.r.shah@amd.com>
Subject: [PATCH 1/4] firmware: xilinx: Get the SoC family specific data for crypto operation
Date:   Sat, 18 Feb 2023 11:08:06 +0530
Message-ID: <20230218053809.1780-2-harsha.harsha@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230218053809.1780-1-harsha.harsha@amd.com>
References: <20230218053809.1780-1-harsha.harsha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: c41f51ec-910a-441c-e931-08db11726261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USfUODFLBA6R69SowVZ855plhfkFPDSqTc8GJnhx2ZdoO7AWlzrahEJAP74i9viHrafBRbdzmmZbzTIBv56wSS9Fkbosh+MSaMV+LQJF/QbG+yDgPoewzpLRDT+EVjiUBaNnUNZoqQ1ZOsJ3+Ovk99zSUKdtA9Pd9mbd+O8yP/Hiyz0nSTIuSuSxWWHHCo/rrkSC5LiqJ5+h7saQGgwAnuktQokJXmyJd49priisLu+vHYpqO+dxH8mew2/VnpijHky/48woesbpK/hJ1P6rlZtkamZsJpUsLQkh7E7XN7tApGn1EaDXNXig0XMsAHYJwiFUp0I1BQ6fWKucQCt7n9wG6sUbVQrJnm0C0Eqezp2BdPOeZBKcjytB5Ew8T6FomWK/G+qbReEYmjIrKHmn2K1HMKBXi1Mtr2C/Z69Ic1+xq4mng+RBjxklhS6Niqs29YGaUS9fA62C82Mm3A0rLU4YsnvYGYLrh9Y1k6UPSyCuV7zkbJPvhMknS1SbQUkmSDMkvUhVvqgSPono+PmOSpsJs7IF3o/maTuCA23UiaKBmgsfti9b38t7VrwPCaNXLikqllbictsA/oup3sTMuiBLmfgmBniBOEH0DKDEGe/RitY83skdrnnpptYuCQXZDTcLNitohMttP2+PrM2K9MO8mmLCd2E9TUhK6izg70Hyc0nMPDic+98Q10uzOZFFmKRDoz+PT1W1U9fkznI3wqZ47sfdbMzmRAOqquY0a+SjpY6YUKHhXuVyIXpZQ6H8PLS5P4S+EbueE1RuTT1NvWlo6YYYc7mKifSTxMWcmDuMxZtPlVRR4LXqFmxWdOvO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(82740400003)(36860700001)(356005)(86362001)(81166007)(36756003)(44832011)(5660300002)(2906002)(4326008)(8676002)(40480700001)(70586007)(70206006)(8936002)(1076003)(82310400005)(6666004)(2616005)(26005)(40460700003)(426003)(83380400001)(41300700001)(186003)(336012)(47076005)(110136005)(54906003)(316002)(478600001)(15583001)(2101003)(36900700001)(358055004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 05:38:37.7116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c41f51ec-910a-441c-e931-08db11726261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get family type and sub-family type of SoC and on basis of that, return the
data specific to the SoC which can be used for the required crypto
operations.

Signed-off-by: Harsha Harsha <harsha.harsha@amd.com>
Co-developed-by: Dhaval Shah <dhaval.r.shah@amd.com>
Signed-off-by: Dhaval Shah <dhaval.r.shah@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 79 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 34 ++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 129f68d7a6f5..10ae42a2ae22 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -339,6 +339,8 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 
 static u32 pm_api_version;
 static u32 pm_tz_version;
+static u32 pm_family_code;
+static u32 pm_sub_family_code;
 
 int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 {
@@ -404,6 +406,78 @@ int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_chipid);
 
+/**
+ * zynqmp_pm_get_family_info() - Get family info of platform
+ * @family:	Returned family code value
+ * @subfamily:	Returned sub-family code value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 idcode;
+	int ret;
+
+	/* Check is family or sub-family code already received */
+	if (pm_family_code && pm_sub_family_code) {
+		*family = pm_family_code;
+		*subfamily = pm_sub_family_code;
+		return 0;
+	}
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	if (ret < 0)
+		return ret;
+
+	idcode = ret_payload[1];
+	pm_family_code = FIELD_GET(GENMASK(FAMILY_CODE_MSB, FAMILY_CODE_LSB),
+				   idcode);
+	pm_sub_family_code = FIELD_GET(GENMASK(SUB_FAMILY_CODE_MSB,
+					       SUB_FAMILY_CODE_LSB), idcode);
+	*family = pm_family_code;
+	*subfamily = pm_sub_family_code;
+
+	return 0;
+}
+
+/**
+ * xlnx_get_crypto_dev_data() - Get crypto dev data of platform
+ * @feature_map:	List of available feature map of all platform
+ *
+ * Return: Returns crypto dev data, either address crypto dev or ERR PTR
+ */
+void *xlnx_get_crypto_dev_data(struct xlnx_feature *feature_map)
+{
+	struct xlnx_feature *feature;
+	u32 v, api_id;
+	int ret;
+
+	ret = zynqmp_pm_get_api_version(&v);
+	if (ret)
+		return ERR_PTR(ret);
+
+	feature = feature_map;
+	for (; feature->family; feature++) {
+		if (feature->family == pm_family_code &&
+		    (feature->subfamily == ALL_SUB_FAMILY_CODE ||
+		     feature->subfamily == pm_sub_family_code)) {
+			api_id = FIELD_GET(API_ID_MASK, feature->feature_id);
+			if (feature->family == ZYNQMP_FAMILY_CODE) {
+				ret = zynqmp_pm_feature(api_id);
+				if (ret < 0)
+					return ERR_PTR(ret);
+			} else {
+				return ERR_PTR(-ENODEV);
+			}
+
+			return feature->data;
+		}
+	}
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL_GPL(xlnx_get_crypto_dev_data);
+
 /**
  * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
  * @version:	Returned version value
@@ -1855,6 +1929,11 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	pr_info("%s Platform Management API v%d.%d\n", __func__,
 		pm_api_version >> 16, pm_api_version & 0xFFFF);
 
+	/* Get the Family code and sub family code of platform */
+	ret = zynqmp_pm_get_family_info(&pm_family_code, &pm_sub_family_code);
+	if (ret < 0)
+		return ret;
+
 	/* Check trustzone version number */
 	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
 	if (ret)
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index b986e267d149..cd5acfa29cbc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,20 @@
 /* PM API versions */
 #define PM_API_VERSION_2	2
 
+#define ZYNQMP_FAMILY_CODE	0x23
+
+/* When all subfamily of platform need to support */
+#define ALL_SUB_FAMILY_CODE		0
+#define VERSAL_SUB_FAMILY_CODE		1
+#define VERSALNET_SUB_FAMILY_CODE	3
+
+#define FAMILY_CODE_LSB		21
+#define FAMILY_CODE_MSB		27
+#define SUB_FAMILY_CODE_LSB	19
+#define SUB_FAMILY_CODE_MSB	20
+
+#define API_ID_MASK	GENMASK(7, 0)
+
 /* ATF only commands */
 #define TF_A_PM_REGISTER_SGI		0xa04
 #define PM_GET_TRUSTZONE_VERSION	0xa03
@@ -475,12 +489,27 @@ struct zynqmp_pm_query_data {
 	u32 arg3;
 };
 
+/**
+ * struct xlnx_feature - Feature data
+ * @family:	Family code of platform
+ * @subfamily:	Subfamily code of platform
+ * @feature_id:	Feature id of module
+ * @data:	Collection of all supported platform data
+ */
+struct xlnx_feature {
+	u32 family;
+	u32 subfamily;
+	u32 feature_id;
+	void *data;
+};
+
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
 #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
 int zynqmp_pm_get_api_version(u32 *version);
 int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
+void *xlnx_get_crypto_dev_data(struct xlnx_feature *feature_map);
 int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out);
 int zynqmp_pm_clock_enable(u32 clock_id);
 int zynqmp_pm_clock_disable(u32 clock_id);
@@ -561,6 +590,11 @@ static inline int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
 	return -ENODEV;
 }
 
+static inline void *xlnx_get_crypto_dev_data(struct xlnx_feature *feature_map)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata,
 				       u32 *out)
 {
-- 
2.36.1

