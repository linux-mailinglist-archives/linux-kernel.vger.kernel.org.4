Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5396193EA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiKDJzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKDJz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:55:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2133.outbound.protection.outlook.com [40.107.93.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060BF1E729;
        Fri,  4 Nov 2022 02:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPx1k1YMh+5HosLSV1k5EtquoTOw0z6RmrywscZKzqOdhqc1SJ99LyJwmjsrKHzivF18CKSutMgHsoHJGk0fPCZSHSjxOKCeZ72vruc1+NjpLp22uaJV3JXvEbR/d0gru9R6qNcKJ/esxLx0m4HwoHsKvZLZt+T+8NBcxhYQByBwcJXzMXBultodiapTCH/Yl+lbkEx2tfoBiGqOPiboiYGQlie7rB1UxCraNvuNA2arUNr5EqiTRDVpa8415/g94zJxf/bRv40d3W/3kmb60/wxYX2SiVaXxrBuwCSUr6oNoFyiPzsR+OCVFewAHfPtwYZyQ1c7nC6zCgVRFfui0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hreFLFt6rCwrwgCetqHQEFThZRZypj5DlCNU2UJcU+o=;
 b=f3z6M6X+1JbEDaQrHN4heN4RAGiFWQmuqRdTw+4jRsUAmizDCck07vr/ulZJxf7zNlGYYn/OLRXunDQnuYsg5PNk94XI0YKkKIpwT/W6sfunFdJClWTZbW1Da/hMJuVyhIxu6qgzumsFBSOwM3k+uaHv6Ml3SkzGEXZP1+7g+Nci2unEbIG6LteGhYpGUhiouXGENFKaCZr4z/jBqsj2At/rt6HhLvpWF4gcbvOinyXwX+nIj9ovxOgLzi1DCvD3Qvb4sFwiry4lWG+DkctUQrWfzy0CYEH6GoTMxUDc6MDtyKCUIv/N3BD0yVB6VP23NgZb3Qg8kZWl4fMZPeN4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hreFLFt6rCwrwgCetqHQEFThZRZypj5DlCNU2UJcU+o=;
 b=rLGa/idTxr9ML2Vcb1glDGRjkvbY7NxsILvCiL73dOp/IH2G0Dj62LAXK2H3bErWKWN/5J6zCU5zQiMQjoorNFFrcyWPEmFBrPI1I3pwe6Djiaxrfdpfg1BiE4wuWhgNja/geg8rUYOQa4ctF1Ub9Pqm7wVDb0P84svug4vcKJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from DM4PR16MB5004.namprd16.prod.outlook.com (2603:10b6:8:43::15) by
 BN8PR16MB2706.namprd16.prod.outlook.com (2603:10b6:408:51::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14; Fri, 4 Nov 2022 09:55:24 +0000
Received: from DM4PR16MB5004.namprd16.prod.outlook.com
 ([fe80::41d0:e051:35b0:8efe]) by DM4PR16MB5004.namprd16.prod.outlook.com
 ([fe80::41d0:e051:35b0:8efe%7]) with mapi id 15.20.5746.023; Fri, 4 Nov 2022
 09:55:24 +0000
From:   Chevron Li <chevron.li@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com, louis.lu@bayhubtech.com
Subject: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: fix card detect fail issue caused by CD# debounce timeout
Date:   Fri,  4 Nov 2022 02:55:12 -0700
Message-Id: <20221104095512.4068-1-chevron.li@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:403:a::14) To DM4PR16MB5004.namprd16.prod.outlook.com
 (2603:10b6:8:43::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR16MB5004:EE_|BN8PR16MB2706:EE_
X-MS-Office365-Filtering-Correlation-Id: cc052394-1c8d-4462-167c-08dabe4ab1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McO+p5LKn8QFmaxdBViDXnO3b89WdQ4OukzgJyOE4l1UitTs1yijFyAXWpZLKUHuVZBYmAUQ5/RsuPhz49jf1Vhq8B+gnWksUMRx9BeOuTfSab+cmAvXmNMhxZGU15iQ8vxg9h1E8XK6rM4owcMeJtHvFcS9XZXK1qc/hOR7g6KX9oBQeEt17VxL1PQbCGkDUz99eHf+uaVz2NElEt9v70T6OprX3bU0tWMndM4xCdpc9fWsEWh3C9fkDWFFVQD9ZYzzJf1L2cly2HV+BSdXT1RnBcG1Afd79qm7QkAssuuFn3bbNXLdGatc46gyAYcxrcqTv+v50W3+hTvyHHYoFNtkUOl3CqyCH+9GSjYCT5ex3tQzvMe/rtqr7lgj+UjKCHkze1Q9g3EMCGXVOejC/5/RzubACd//wj+6ieoeIpmeNegJKF/jPN1cUFeNVPOPy8CAAWJJDkBIdfyHctNjxVpaXsNjCUNRd7Pwyro/V21wqRVFSz58jWKF+K1wYJwonbCZdPjeHQiz7UAgSsMdyWPeTzRvC0Fxc86G+J1+RBNkHPQ7ecWt8qoP61J0cbRPtqcv/N0K1jFyH8dDuRmN4kNbjdDzRYv/PUOtmPm6eBdo1lyP/L/p8k2SKXGBV/zhuG7BD2IQjVTd324Ah8H8sbs8Pdqi6Fwd2+cCinPYlzVBPeWPSRSqo4t/djM2fptVj+seNb8RKnFCkiF+o+L6Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR16MB5004.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(136003)(396003)(39830400003)(451199015)(36756003)(44832011)(66476007)(86362001)(8936002)(2906002)(41300700001)(5660300002)(38100700002)(2616005)(1076003)(186003)(83380400001)(4326008)(66946007)(316002)(66556008)(52116002)(6512007)(8676002)(6486002)(478600001)(6666004)(107886003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7t7xkGiJu+0xnkwEgSi3waOLFzrcGKhDRUdpdRbx9ImJGttstDsEJO7GcCyz?=
 =?us-ascii?Q?ltLICubiGCeeup+Bq9v5GTm1QOz1sHQlOxubrTp36s+KR6zVo4l5OOmVoSpJ?=
 =?us-ascii?Q?VwI44mASXynGHzuyWkst6nQm1lP9AlN5fFTVGnKqv+MYLrpIoAhRJ3x9/uOZ?=
 =?us-ascii?Q?63/kewK1z1up5/g5SSwlaijOdCwRuiGHqqfIyRU7/3Wsb0SYyDRIDggqlWcI?=
 =?us-ascii?Q?wnLPOysZNXJGflLIltgZKsi16+RC6Y8KU4UhmxzMyY8OSyA85pf2cNKhxHay?=
 =?us-ascii?Q?KG4QlGTTwEGqoFTLUAoXUda+f62Q7uvOSDjgejK2VYbwFKjqP2Ddit8Lua4o?=
 =?us-ascii?Q?znbqzPseBBNVsMAGyq7dlkVFZl8yYWRkYxlCTm+OEhWV6jbMQ7kVM4FV+xFZ?=
 =?us-ascii?Q?oHu7gVEMEJZXjRRDDTwk8edCn89ObQKCDFD59RWnqa6EoH8tCWqd+M3k0+6t?=
 =?us-ascii?Q?fnbZUydTHQeNgFaqYEQq9iReyDeAiYPGlWaWLx0Sp//34q0YAA09dl+BPe7n?=
 =?us-ascii?Q?AsbbxGsr1YoyFX6QtKn7sQajLjLdPrwQ+aEVGTFUIAT2D747MhLsRbeDiw8L?=
 =?us-ascii?Q?sZN47oLJKUGOfnAoNez3Lj/cB8VDunCZSORy0yT3hkRx76lLsdT8a0V4JBLP?=
 =?us-ascii?Q?Q+mgDaoXazYxgmv0NbomSxs8+EmsOldM7Tz83+Zk2o60P9/hFsAf20m8gxhI?=
 =?us-ascii?Q?DQF9q2ZLszBCnxHrVzBFlTBo0+6YiB+aPCBOewBIFqRkAiVIjhbDOLSrBiJr?=
 =?us-ascii?Q?6N40DQ/wIA8xOVOELU8vqlR6weYuoM9qk4YDGJZzyTfhjQzDtnRBmJ5L3cSx?=
 =?us-ascii?Q?KNXT4Bjt7mdgWU8496SLK5sooqYkefC9BPJklt49Tpy+kCaE990MxbhA0Y/g?=
 =?us-ascii?Q?dWenI7OvPDJbDL3/OrigNe3VMrzUwhoYZXpcTSvb3KMsZEFYUNtjM20ut8nO?=
 =?us-ascii?Q?ah6vfX6Q/DskWyhiTs3TWuJXxs2hDgROaM8gcqS/mxGbhAG9jW4xIHKF5xOs?=
 =?us-ascii?Q?+1QCXt1ft2KIKt3ywIehh781B4s0c5Pt8qADJo0uKgPj2c4AejVE/sbjC4FN?=
 =?us-ascii?Q?gH6YqC8cDzub65wyX//+sjLfpMTfpIqNnniDsyicucJYDzJ5oc+Mtd9NxLjU?=
 =?us-ascii?Q?HOSlMo3xVBXFj8UOf9AKvEe5GV7bR0Ay4FoN7UVHajM5j4PyTW+cwI+xelyS?=
 =?us-ascii?Q?jW3Elp5kB8yPFVCHuUgjLLFCc81G420Pqo2Z5ZLsRZOLT306/Mm5qPlmaeMF?=
 =?us-ascii?Q?pbbujUlyP88WCts8rAjow8C3HupaCeWDR8Lt528pp9eTdr04BiBt09RdL241?=
 =?us-ascii?Q?oPjuOEMRK0Hc9abNNErUcri645r05wkRtbHjvbE56kGsAPc+Sg+02fgMWQ89?=
 =?us-ascii?Q?ZAfZFS6sCVzPwuaNAbCNYblDrsjg5J5jB/RcBd2vHUC3+SSTPWtsZ2BZCf+l?=
 =?us-ascii?Q?3SacYUg6w+1cgjM6ABbqJrUvqTUgpXogBdmVWkv8E3H5Z4ohRs13VqiZT41V?=
 =?us-ascii?Q?pzxsP1WmqSCPGbE3Qgftz2txlm0j76CZxHGfvzZDeO1X6NUZBEiInYjktENJ?=
 =?us-ascii?Q?Mjy8CcS8qJAtsWptPVcXUu8nHA7zIQFpYhKPzJsBvde7jpV1H1NP+YPFY4qR?=
 =?us-ascii?Q?xSKbxN3MMWFPFlUtGPseGXVtQQ7wb1ni81NBdS9jpzxBWZFclJzWvzahNn2W?=
 =?us-ascii?Q?6T51mg=3D=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc052394-1c8d-4462-167c-08dabe4ab1ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR16MB5004.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 09:55:24.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPoKzFi5+tnWOpquxdi4lbZcV2tVc52Y2JtedVwxonNVH13MZHEVcjDbNMgydaeXPXzIhOm5wG/ka/N+lhnJRUgqsBY2hwpQPC36WR4abUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR16MB2706
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SD card is recognized failed sometimes when resume from suspend.
Because CD# debounce time too long then card present report wrong.
Finally, card is recognized failed.

Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
---
Change in V1:
Adjust bayhub chip setting for CD# debounce time to minimum value
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index ad457cd9cbaa..bca1d095b759 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -32,6 +32,7 @@
 #define O2_SD_CAPS		0xE0
 #define O2_SD_ADMA1		0xE2
 #define O2_SD_ADMA2		0xE7
+#define O2_SD_MISC_CTRL2	0xF0
 #define O2_SD_INF_MOD		0xF1
 #define O2_SD_MISC_CTRL4	0xFC
 #define O2_SD_MISC_CTRL		0x1C0
@@ -877,6 +878,12 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		/* Set Tuning Windows to 5 */
 		pci_write_config_byte(chip->pdev,
 				O2_SD_TUNING_CTRL, 0x55);
+		//Adjust 1st and 2nd CD debounce time
+		pci_read_config_dword(chip->pdev, O2_SD_MISC_CTRL2, &scratch_32);
+		scratch_32 &= 0xFFE7FFFF;
+		scratch_32 |= 0x00180000;
+		pci_write_config_dword(chip->pdev, O2_SD_MISC_CTRL2, scratch_32);
+		pci_write_config_dword(chip->pdev, O2_SD_DETECT_SETTING, 1);
 		/* Lock WP */
 		ret = pci_read_config_byte(chip->pdev,
 					   O2_SD_LOCK_WP, &scratch);

base-commit: ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
-- 
2.25.1

