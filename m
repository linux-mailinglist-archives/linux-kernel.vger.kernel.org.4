Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D51A625A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiKKMXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiKKMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:23:34 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5165D13D2F;
        Fri, 11 Nov 2022 04:23:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTJuA+M05Gk9TCugVZO/GpraIkpqfglvATu8hGVb8MDvupJ8XjHbocjToE3tgT5ZEo0vFbqcV4ZPpGjMyR2ehJKVKEvVz8cLmN41rx2hFQiCgI9CFIsTl2DalZZtgjVlNWkOSjIxUZ8plwxzlNuTjSb9YgRmMliDnUBHqdma37jDr8lkrlqUmLjsrBiuA/Fro0tx4Nuuc/4Pbc1vVOVNMnoDo1wSzILmZNHJp3lgROTWLsw5dO26QQcavOWMUf0qSsTIhr26MTr2SZHvsPHiIikEvfbrGfoBYjKvI4sB5JXHCeTbgsEc/Fow+DS/1GLMVMhOo27dNHtZ07upUoOaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFnBryl2gJ+sM6vwmfRHWj2Pvb1Wrs9UWmrLGcDNpYw=;
 b=dU6M7S5eL1U+PKN7+CuusXHYlxpAms6BtJYo6KYwd2tuzXWVV8KRzcjcpBLOEO53BrrPRZA4GC6H3V883z5zOrzgzUKbsRD+OYK+a84/ckAyoq33riE3+3xrhDdeMcaNe/bu2lDugvBJI+QXlIGpIfFFGoNc7de9/YCrvIf8GlmfMCOkcgdQRp+z2FZLajEB5ls7XccF9sJogKFSgz36taPcC662QfyIzdg4Tt8yA0eV2HNUqblCGD2OsKMj4HoOWgYBLO9y7fpU6pZzuLSQOtkCKunKf9HfkkFzFMX3NppsjCfQ/swrHBP1WAHtcmVBhXtJFeWyBqSQjAoK8Lrl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFnBryl2gJ+sM6vwmfRHWj2Pvb1Wrs9UWmrLGcDNpYw=;
 b=IaYPSA+gbG8hmYfVxOHUlMwWb3/5d0vHbSDwgOx7v+RO2LW8iD2oKI100CXyqSNlQPT7ZigjLgm3ocdcshsuqAefVJbvLt2wUuNSSUEBmy+1nwr6YBXsQsfvCbST/z1+up7NrFVGVN7f89Nv4JLPovJsd2uU+wr1HKJLMSY7t9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from MN2PR16MB2781.namprd16.prod.outlook.com (2603:10b6:208:e3::30)
 by DM5PR16MB2261.namprd16.prod.outlook.com (2603:10b6:4:b6::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 11 Nov
 2022 12:23:30 +0000
Received: from MN2PR16MB2781.namprd16.prod.outlook.com
 ([fe80::19cd:13c4:ebe3:4284]) by MN2PR16MB2781.namprd16.prod.outlook.com
 ([fe80::19cd:13c4:ebe3:4284%7]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 12:23:30 +0000
From:   Charl Liu <charl.liu@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        thomas.hu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com
Subject: [PATCH V3 1/1] mmc: sdhci: Fix the SD tuning issue that the SDHCI_TRANSFER_MODE is cleared incorrectly
Date:   Fri, 11 Nov 2022 04:23:14 -0800
Message-Id: <20221111122314.307-1-charl.liu@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:300:59::28) To MN2PR16MB2781.namprd16.prod.outlook.com
 (2603:10b6:208:e3::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2781:EE_|DM5PR16MB2261:EE_
X-MS-Office365-Filtering-Correlation-Id: cab2b696-d6d2-4680-faef-08dac3df8ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TG5ToS/mp0lx4LWFzTZr6wcyM3YSlOfc2bf9OdGBObGLFmWGujYk3sUPqa9AQS57t/L6TQoEbHHaVa3SGaSDHi0nrygXftuPt10dO9II+IrXo3ff/FEfoOr+tUuX/rdD3/XwES6rGGm7QAe6zsUBDljtRo2kYA/Rw/0CPa+DXuSOgu8AnJMnEdzVbwigquLDRfFHCJ69rZQpUUQPHdsr1IwnEy0FaUlZwgydJyqSoSrgBRm/H3Bzl0bCr3DApDrn78c+PC61Tm2QMgpO0uhvzu2HAM3sl+1paebutAQrcO9ohlSSvE4Hcz7mJUaETtCg/X7Xdq94M1zbLIHAKawBmkr+zHE93bCSKARdYJCp2dPslVHPhBPFiUcWZBiG30htVXCS1QZf503CucPFtef6fRHWjqZc5VU+LH49gIyRfOsl0vE05bU0hAh+581bq0QBSFp4+1oBUZtCjl+wzjvCMhVAiGWh3MmKBdCm1mCYxFYqTrrz1V+riEPh0idYBwdDXnG7sK/yYTQyGrkolqq8GHe0Qkn2UL6/2i1X1O+IYX4rTp2TyXOIYERcguULNGRNsjhqhzvBaKlQoeQPol/m43Ea0Frf8G774ujeMkdwHZ9x70AQtgQ1JIN42tpn04/lQXM0tbCzBjkT86xMRd6LNv1rZtS5IZuHw9RXAi2ueZ+QkeX6kjDm1lrIVZZ4vU7r1KjPUlO7szOqsW6QaHdbwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR16MB2781.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39830400003)(451199015)(1076003)(5660300002)(2906002)(478600001)(8936002)(186003)(6486002)(44832011)(83380400001)(2616005)(316002)(41300700001)(4326008)(6512007)(66556008)(36756003)(52116002)(38100700002)(66476007)(8676002)(66946007)(6666004)(6506007)(107886003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bMyUvEv/rB4oYtgsx+Lri6uJ+IdgigKfR5ydqgPjxsQym894QrMQOaZGhsHu?=
 =?us-ascii?Q?30kNwmLgaEU4snh22yjo0WMYnkP3FNx++HVj2U4bLIFUBXOo1U0nyrVd4Zhf?=
 =?us-ascii?Q?FjTOSuCBO1zk/42U2EzqTp1/RqWweOH+ug64qxZe9zYR0zsK9zccGnt4wiX6?=
 =?us-ascii?Q?b0+oQUw4EmltzaW5WktDrJUaHWXoMO7uuAgDMtulNMbgvwSDq/BOzDb3LKq5?=
 =?us-ascii?Q?4jWdiz/RvgnrLdOuf9wa0uhx8KDkqqMQN3BpHO5qSd3/kpmJeYYKNnKqVpa5?=
 =?us-ascii?Q?IoBolOONQfZIl8Qd0E+c0U0pOb4dDpkUFA1mG0b6uSWWZ/GHPM43Hf7lmiUJ?=
 =?us-ascii?Q?vo4KZGYcLskzzzBRpwP6m6H/AXuqSk/sFWKRCB0HbQIi9bMHSvGqduJedPpy?=
 =?us-ascii?Q?UqBRL1iqWa+iT+LeO1s0ercxEpB4g1To8j1hovepeDdCPI4hz50Nn379E+zy?=
 =?us-ascii?Q?izNJzK7+IeFAwddnINGhJj+tC8P6E3KA4ZEmuhC1fOrPYgY2Hopx0L0jNMw2?=
 =?us-ascii?Q?wLm1xSXvFga3ncr/NhRpyPoIZlL1Bi7gEOG/L8Le5FZ0lyY/+/Ig/ruSzSex?=
 =?us-ascii?Q?m/xJnpYHYD9w+BDujQuxkfYZAg/nFi5k0DvP+0kZ0UY3d4NHf7Y0YtUpMi2K?=
 =?us-ascii?Q?00KSQ0c6qe7dTBsouO4wyDE+f8/eVxBaWgdfuNSrKHmhw12tTe6/SVqok1lE?=
 =?us-ascii?Q?fBP4aoWg0q5iY1podFNmWH9GZWc6eimfaYdaZJz+62T+iua+rIQuqdC5P3p/?=
 =?us-ascii?Q?samh3l22vLGW5k8zZrI8bPhCQXKQk3T5ZGLR81GpFIboJ/oMmlW6am8actwI?=
 =?us-ascii?Q?URqwvBXg1TS6c95lcy3C+LWiwtatc3hRX9HXD2Z3X2vvd6KB7Trn6KATLrgu?=
 =?us-ascii?Q?rbzDDkHYPaQUhYv76qXZkbElohGVTHh/y2mT2L+2BBb9Vdgb1UnwcgPiOh3y?=
 =?us-ascii?Q?gXxrdWRXYjuc4SC9W4x67lGs3d2mPR6eQx5u1X2vkoPrjL8YeKKd6gzDbfV4?=
 =?us-ascii?Q?jFdxJtpi0O2S5F0srmZN6DylGrn4W0CVSaIE611xEOBSwp6fSUUE0T8HTy3n?=
 =?us-ascii?Q?f5fLrmJtwxcUp8nMkgAn4WHP2Lm1/XM1KcNyWgG8hm5vjznlNB6EOc2x7Cf5?=
 =?us-ascii?Q?FQcs6DyZTwxjQ5RIHLOw960EoB7rbt2jBUoGpwpchSDZPHHyN8pWXWjbGkWT?=
 =?us-ascii?Q?CJ7dy2pGFq57D8z2rVS4tUHfC42Y0d29JJ1EBuMyxoQtZBFAcVLq64j8occz?=
 =?us-ascii?Q?pqsyaiRmECImCRhSD/2cs8TANuVVQO8LbjUkNgnN7BglV4e+k7zrx1vXt8a6?=
 =?us-ascii?Q?YM8r/w/pA9rqYOTimIann4EEkT4ouFpuknVZnYRMHQSBXcq0MqQbN42WKg0A?=
 =?us-ascii?Q?Pjkz3F1ctbMfYHI0mVMv4KbF7l/ku4aWZnM1WVMpX9SdYNHjF5QgnZkUonCG?=
 =?us-ascii?Q?UmVM9WeILu7foayYaCpMXNDdRa31wiueCYxvwCAMJBG3b3iPd9mhtDYA267H?=
 =?us-ascii?Q?fYhbu/aOdWO/lbQ7XM+ZZGgqzN82rFX3qDJFSidwTFrb4RN3IvtSsG6Janwt?=
 =?us-ascii?Q?eXEZcN/w7eSXONh6ZesMebxRmLzBDWtEyfFKRlJxRCSRbh4K5OdbmIdW0K8Y?=
 =?us-ascii?Q?IkxfzFU16vi64TTdMbnxkOwF1mFqTvvhUffS3rXXYEt9x36yLfSMJpswLo0k?=
 =?us-ascii?Q?zrsFhQ=3D=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab2b696-d6d2-4680-faef-08dac3df8ab3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2781.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 12:23:30.1958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgdgHnQQl4GoSV50DPjVBKl6gP/rF8qGPnJCdyk1yIP8OqJbOyOxE4A1FdRCLzMIUDt3gmivNBk2w6uZsJF6dxJfrYNrErzEs7bMOFkAOlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR16MB2261
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cmd->opcode == MMC_SEND_TUNING_BLOCK, the SDHCI_TRANSFER_MODE
should also be kept

Signed-off-by: Charl Liu <charl.liu@bayhubtech.com>
---
change in V1:
Keeping the SDHCI_TRANSFER_MODE when cmd->opcode == MMC_END_TUNING_BLOCK

change in V2:
add the mmc_op_tuning interface to judge if the opcode is tuning CMD

change in V3:
cancel the redundant code
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fef03de85b99..98ee688de50d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1465,7 +1465,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
 			/* must not clear SDHCI_TRANSFER_MODE when tuning */
-			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+			if (!mmc_op_tuning(cmd->opcode))
 				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
 		} else {
 		/* clear Auto CMD settings for no data CMDs */
-- 
2.32.0

