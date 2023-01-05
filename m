Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB65C65E56A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjAEGMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAEGMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:12:00 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2061.outbound.protection.outlook.com [40.107.215.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D278751334
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 22:11:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBBbbmPeGsWY+k6tcKSCvMoAG9Wvq2YCiSJPCpGKPbT6ixCecJzBcbo7z87A64jEAxSgdjyDbIxfCWonnMIevMmmE7lXIOz2Vn86P5oFf/qpwR5SdYpxbERbs39IHCvn9a5E5o5iY+3I2RFu1nKrdr5R/eu7/pk+CUSO2zKnnpTcuGOwITXeJlcVx3+WZvoAw/Zhr9tsAZWRZran1pHFfRm3GmegQSQ3Kceo2E/wzzJSAKb/oLQlnO1tpWqKkmy/mOPPPPIreabPqQtOd1ehHE9SAiC9LjS53EQZozFgNkDcjmwEqyNOmfurje89pTL4QoXNRxhmF7lzVKNquxEfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rKRVSzykACwn5bikUEXNKnXq2+ovWPNIKgtEAuVvWE=;
 b=bRYik8UMnGdYUGkT20/uyyAlc9bYGLcWflvaD9VP/FJSTVOQ/cOjYflHpJSsHGOhptCDSf16svJjatEZx9oG8Bs9ZCti0XcVAffCLFuNNFhmLooqBVFlRMVvvzzPQOz54aucTROeoAz3P5aryQUCKW71GUiOmtg+sq0UD/WxFcXMRTykFWuxYcv/NkcKwiebymBHTzc9/NMD676tb5XJd8E/0UEScnpot6hguwUAQiVWYPp9WHdj29BNyuqjX8U5MQIdWijqjP3gPc2TJSnx4duJzW0ppx6D29cbZbMODjp619CxYYaGEi3Dw2Bas9h7dF0jQbtP7oZRyYUZ/SYFrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rKRVSzykACwn5bikUEXNKnXq2+ovWPNIKgtEAuVvWE=;
 b=b1W43QNAAXyfYzzDfVuwbe2R59UKH2ApHqnbHFOkN4OtFFU8QRTvmHUPI2VPpa1PFoLVBZ5qeZ5VrXp0zgT1lgDjuh7OfbMAVrZMbw2BTBffBLjtg8bilbvOXLspzNhG8cxEoBmiAodLc2HerfVe/u6AzevUVnVRHz8kP4xL6iS+87YElzCjfn0ue+jHmm38FS09nVMoJtHpAODgDPnHWqkTPGh7x8hnpo7EyqHYUl5thl4Ga0BSEbHNrJMliJ+D99Hnq2Eo24eh92o91WUIwAYayv8quAD8lvZFDVfndgUSeScZLyR4JpSG4aHS2CwyXrEv7CZGW5xSHDyZH95vhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR0601MB4291.apcprd06.prod.outlook.com (2603:1096:820:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:11:49 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::6ddb:f49:dd40:1b9f]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::6ddb:f49:dd40:1b9f%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:11:49 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     s.hauer@pengutronix.de, shawnguo@kernel.org
Cc:     linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] ARM: imx: Call ida_simple_remove() for ida_simple_get
Date:   Thu,  5 Jan 2023 14:11:23 +0800
Message-Id: <20230105061123.2085-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|KL1PR0601MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 339fbc73-bfe7-4a3d-37cb-08daeee3ba67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwBMhY1d6VB+JaHccK9Zg9OHHa/TnF+OYkcZAD0YZbd6zn/rIFTHpIDyzMDpKGsrLsy0PBW/jQIGeio7zvYyLrqa8fti8QdGP2oMI1zWHY+K/riFvkajLKlJQ/ZkekCPanNHsapRcbR1I5WAG6VqUgfiZREpahsyEJ1RCekqRuO/UsxMHhFbmj7aHRc+zbjkE3ePE6BbWjfcPC150V8fO1pyHCix2wY7FOHFVGiXcrDK8AfuyaxznlLLlLTJhqcAQ090boC70LxVL0N4/rCOtKbUXtvBe5sfdS0l910FBALxRQXEFusB8jMPdFtmdeTzgauC7hAJGlO3IXd5s7KVb/DoQ1N79HR3T/E9dYg/tEbaz3pFui20nVst0dxHRAGoFfn9+NMFh6Fr9ronE3RZLoLIo+yqtBQd0GU3dHCjv79FvJ6VLpd8Q2XG68fXBc40yvdgsgdTpuw0Dsx2vb5LQdvvhsiFaqWNSEOyYr2uaoKPTp9Pahs8+mi3/13Zh3nTqDoVQ1MU2Qw08j32jSmmmIkS8MchhsCLNFqd1Nv+ZpmI8QlNdwI0Un8oW5Zv8z8iL3w8+anfLkFPvpOkqL/31eriEQYTuyhgyg/9cGLoCQNzcG4tablObRZdrxRpmTWjssjqqEuKlA6sTYIK3mnvo3RP86bDRse87L2qZsghOMvNcnRdST+8A9HwV0WXbLm9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39830400003)(346002)(376002)(396003)(136003)(451199015)(2616005)(83380400001)(1076003)(86362001)(38100700002)(38350700002)(36756003)(4326008)(2906002)(316002)(66899015)(41300700001)(66556008)(66946007)(8936002)(5660300002)(66476007)(8676002)(186003)(6486002)(6512007)(478600001)(26005)(107886003)(6666004)(44832011)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3u++U/XaQ5RZv6qoehCKSJREEizrw/yzjrHb/7ea+HCVx4l7QIth51fJFmgl?=
 =?us-ascii?Q?kg8Pk13AiaVk1sj5ztSbUeiOk6xfHty7DjIlQbosumfQRCE1WRQS6Hzr3U6A?=
 =?us-ascii?Q?qj3SZLZnetCi+ddEKr6CAhT1zcIpXZdIkHdKZ854PN7f8eaa4OU2ddb3UQib?=
 =?us-ascii?Q?MAgHzZzbv+ke6/QVRJkY2T1HC3Wb4Oo0D+LRNmkZTCGmPxQLrTzurCo5Pndc?=
 =?us-ascii?Q?spP5zwxFkpIE4VksdvdC3nuUhKnFLT61dDwDySgYJ0n8RlcKAvyXXXZBNUGF?=
 =?us-ascii?Q?P7PQG0h/54Q1cZRFlGU6XegNSzmI3w3IrDhNmE2om8tpO7bAwr7+ODHKqrh2?=
 =?us-ascii?Q?3P+2Rjp3y1NkBAsdN0/9lbwxXOtFk1swb5v8kbd1EEKSa2mZG3fvKnL0Wqz2?=
 =?us-ascii?Q?E5ARhjxPreyj/TZeANUQf0VE2I2wzn/VkisNbmexnCg0fLTrl1u//0G8nqYS?=
 =?us-ascii?Q?80Wz0tBOAP1jFIpPxXtzzgwUajIrOSo8l8qWWNFB53IsvUcJmnNv9kPxq3Ag?=
 =?us-ascii?Q?STw42zIGYk/OYay85vzIY5LhjnxpklpFWbR2P2Pqnk6o4j2WEQ/WCAXFNoej?=
 =?us-ascii?Q?6S2U4JnTdS58RcyvFb0LiLVKUjBK/f1qRCJVZbrTbgziKUTKW+49TNsrehEe?=
 =?us-ascii?Q?fvso0B7qLveVzdL7AhSJBash7DEXnz24DrUgEFerNNW1k4pgnrvsT2z9ekDe?=
 =?us-ascii?Q?UlT37WWkEczUb04OCWei2wmcS/SO+amMhnxMo44a+jgNVCK5rUOWVjMGhlYR?=
 =?us-ascii?Q?F0IlOvlIL1DfwajLIG7AgqKvM/U/hfYSiNfPWSgntcp/55dGGzDXE6UeY+GO?=
 =?us-ascii?Q?Azo/Psx//nKSC0t5Cao6m0wOvyMqqzJmQWBM5phi3LQnJdUmBOpqSnOjZNzq?=
 =?us-ascii?Q?ZD8kGNGS/mRU8rlaHsx0hR1m5FrahIUnXCbTFlU3gsSb3BeZ0xCmBH3TyHj2?=
 =?us-ascii?Q?VPwqTelkwsCs+KDJdptFhf3Kh9p09iX7ETETKUJj3fGRjGwQ+Mwm1hMxXcub?=
 =?us-ascii?Q?z6TPd0sy8w6MVnunpT+4jjZqWuUna0Y86q/vOxBqLAeHeqBJhdEpKrlqr/58?=
 =?us-ascii?Q?SNfvhI8zEy1AeOLUfpusbebpIGhcrEPLKYCCpIXuqliamEGYnLEVliQ5I1Lt?=
 =?us-ascii?Q?iyu3jE/qk3XOBhjtBdVIe1HCWlE39cgWdUkuHI7O57S251MXZlvhStaj2OnK?=
 =?us-ascii?Q?8+ztgB3be6d3ufqiHaL17x6i0hf5S/6SVaW0cSFi8upCYy2V9GNfp0kUA0tn?=
 =?us-ascii?Q?71oaSHZOCJM8MaL8IPmJ5LXJuYKyVQuad1+xds2GoKPAXzXSDr0ibWopfXSp?=
 =?us-ascii?Q?YP4Q7B8yxdmfLOEW6yPWfyaJJV1b00x+N9hlVQdtLNaeSC5jAf5G7OBI1jKZ?=
 =?us-ascii?Q?YpxkPwVBn6XlPOBxVmuoPdGLJgQVsFO3Lhrk7q4TPR8me52Cy3XkR6NEQGXI?=
 =?us-ascii?Q?V/3FyQimodGoESxyHgOGbxVzzRIleVtuNHVhEP/LLxLQIb7jC/6aiBiYGtj6?=
 =?us-ascii?Q?AzOb6YNmWpRpHc0D9IJQ37UCcYEdEtwUveO0a7ksb9utwykexo9F1vZrxVhK?=
 =?us-ascii?Q?/XJo6B9OJS84Pz97Zs0RAM/WAFti26+dwHD1RsCFfy9YFHPe3IT6O18gyN2N?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339fbc73-bfe7-4a3d-37cb-08daeee3ba67
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 06:11:49.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzYpK9Z1X93OXP5voHyqfchiyFwE6PmA307bdS5yPtn0KSsHOjrhSkfKeQTCYWNLUyAZSE8N4xh34dVj6D9veHehFeTWe8Ww0Y6KQgV4J8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4291
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function call ida_simple_get maybe fail,we should deal with it.
And if ida_simple_get success ,it need to call ida_simple_remove also.
BTW,devm_kasprintf can handle id is zero for consistency.

Fixes: e76bdfd7403a ("ARM: imx: Added perf functionality to mmdc driver")
Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 arch/arm/mach-imx/mmdc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index af12668d0bf5..b9efe9da06e0 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -99,6 +99,7 @@ struct mmdc_pmu {
 	cpumask_t cpu;
 	struct hrtimer hrtimer;
 	unsigned int active_events;
+	int id;
 	struct device *dev;
 	struct perf_event *mmdc_events[MMDC_NUM_COUNTERS];
 	struct hlist_node node;
@@ -433,8 +434,6 @@ static enum hrtimer_restart mmdc_pmu_timer_handler(struct hrtimer *hrtimer)
 static int mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc,
 		void __iomem *mmdc_base, struct device *dev)
 {
-	int mmdc_num;
-
 	*pmu_mmdc = (struct mmdc_pmu) {
 		.pmu = (struct pmu) {
 			.task_ctx_nr    = perf_invalid_context,
@@ -452,15 +451,16 @@ static int mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc,
 		.active_events = 0,
 	};
 
-	mmdc_num = ida_simple_get(&mmdc_ida, 0, 0, GFP_KERNEL);
+	pmu_mmdc->id = ida_simple_get(&mmdc_ida, 0, 0, GFP_KERNEL);
 
-	return mmdc_num;
+	return pmu_mmdc->id;
 }
 
 static int imx_mmdc_remove(struct platform_device *pdev)
 {
 	struct mmdc_pmu *pmu_mmdc = platform_get_drvdata(pdev);
 
+	ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
 	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	perf_pmu_unregister(&pmu_mmdc->pmu);
 	iounmap(pmu_mmdc->mmdc_base);
@@ -474,7 +474,6 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 {
 	struct mmdc_pmu *pmu_mmdc;
 	char *name;
-	int mmdc_num;
 	int ret;
 	const struct of_device_id *of_id =
 		of_match_device(imx_mmdc_dt_ids, &pdev->dev);
@@ -497,14 +496,14 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 		cpuhp_mmdc_state = ret;
 	}
 
-	mmdc_num = mmdc_pmu_init(pmu_mmdc, mmdc_base, &pdev->dev);
-	pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
-	if (mmdc_num == 0)
-		name = "mmdc";
-	else
-		name = devm_kasprintf(&pdev->dev,
-				GFP_KERNEL, "mmdc%d", mmdc_num);
+	ret = mmdc_pmu_init(pmu_mmdc, mmdc_base, &pdev->dev);
+	if (ret < 0)
+		goto  pmu_free;
 
+	name = devm_kasprintf(&pdev->dev,
+				GFP_KERNEL, "mmdc%d", ret);
+
+	pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
 	pmu_mmdc->devtype_data = (struct fsl_mmdc_devtype_data *)of_id->data;
 
 	hrtimer_init(&pmu_mmdc->hrtimer, CLOCK_MONOTONIC,
@@ -525,6 +524,7 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
 pmu_register_err:
 	pr_warn("MMDC Perf PMU failed (%d), disabled\n", ret);
+	ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
 	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	hrtimer_cancel(&pmu_mmdc->hrtimer);
 pmu_free:
-- 
2.25.1

