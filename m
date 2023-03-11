Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F676B597C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCKI0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCKI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:26:11 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E2142DC8;
        Sat, 11 Mar 2023 00:26:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhPHOx2Juum1NItQ05nrzXVg3dTffwXyz5tpSx7cH2yXUHXhyPgxXfEfzYMES5CGAugNipwFRyntQ4RuSyJWR+nAOJr3lgC9XPgO1FaPdx32ynv3dNQkcrRkuY3/LIXSp5r74mcvRwM4fHmHxp3l9/I+42wKZ5JnLytYU8yCIbGzR9iYOlQzi69Yyedo/Hc9iZqGhbuMCxlN1cqI79ssG+7g86WFEFqh41rVTqDTVcwUfIQlWsry8qNLadwKKmJyEyhwD++S3FNmv5p1+YCAmaw4qV7eb/dX2LkbUC1Yn6Mzpxdskti8DxDYmRYXFWdDY2HYSg5y10zXOlWmNwB3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ynusF5wU7IzzW80gy1F2YJeOkxbKobnkXUSXfoNoyk=;
 b=J4bmKNB8sNdM2hTyrVV7xBk9zNcuPWHUUMfaJ9DYF/L8PsjZSVszTP3P/e/OmI3rDhcrdXDHzxxo54dswWor1ArlaHOMN7KuIuVr7w0V/yuB/GdQN9KMenHqw6RHNiPTY9fZtGGT2dpxD2CuKmdHFyePY/d/MfQ7UV08xM+5E+ws72YD0/eUziOjb6CBJU87Db2iWMAnwW6SmeUnrwt/t28YEX5s3sce+/p0gXTUgTsuwGgJxWlEs7d0fsON2XxvGNJA8bnjij0KxlE0LU9H27HMbxCL1VB4+wsWQCRbszD8grvWQYVMYoaECMHRmkga+VLe4GW9GEqDkRTl8mLgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ynusF5wU7IzzW80gy1F2YJeOkxbKobnkXUSXfoNoyk=;
 b=QxF46c4Uzr5Q3mWsoKmdjlofh44+zOBQau0gy6QIVV8PtujHsk5BUwOFe/VTjcidAg08YPDeiXUNCELLtvc3EgZxk9LHI525eX6GYW+AcYm6k58H+w+SLrKONIPACEF/D+k1L6ix4cU/HXpU7NWjKGi9keLJ2gYYwy3wbOpjg5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS8PR04MB8675.eurprd04.prod.outlook.com (2603:10a6:20b:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Sat, 11 Mar
 2023 08:26:06 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%5]) with mapi id 15.20.6156.027; Sat, 11 Mar 2023
 08:26:06 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, franck.lenormand@nxp.com
Cc:     vijayb@linux.microsoft.com, code@tyhicks.com
Subject: [PATCH] drivers: crypto: caam: jr: add .shutdown hook
Date:   Sat, 11 Mar 2023 13:55:43 +0530
Message-Id: <20230311082543.2474013-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221054047.2140558-1-meenakshi.aggarwal@nxp.com>
References: <20230221054047.2140558-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS8PR04MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b32f962-026b-4e13-211f-08db220a424c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p0vwsB3hVS212x/Q9mQBoTm7LGzuRsP4Bq6Gxdu5ojsDVpj2uKJ6Cr7lUdplXGN7GSmNyW/VVhlQPEBkCwaCOywxL203R6XJ2OUjwykwCRxQ0l8Ca6lXDJlfnHWpMsEtGx02aM3VljfK9Yjgqd5QK0Ec2WFS/4s4twZY5NDq+w7H+g2VI8Im6craKrWsDRvjMUZwaNo0zf/XsJcg+p9SI+2hnAJuCvYrF6kligd6On++BYnMvBku7fmL6g1H5DcEHcX+9+wwvzLbMup0HFl+LFfDNqqrvxq/ioKQjbA0Ddlcm/MlpC5vbPW+pdRFxS6JHxpUR6iwkk/ewb97LrnUzPvKEAEshc0fqdTgIR3r3FfeqBld4FLJn6r6piFf0XC7iFsutDARIsOnzjpcEA627OnZyKzZNF3vX3RGLWu5s9InJAwU9Kvjxh8M3Hd832hxDPOXbmB7DDqRL/PDhmoDJK4sMYk8QAnvkLxBIDpngVvPSAZ3P5pd63/JeYoOHS1Q++wZILDNz+0RMWJmK0vYvhykxcx+iF/zn+6CeKqE1sXOJfEfIFMwfVaufWtEl+3nTnU2Ue3jx3r+m6OO6CCw0iV7sVT9OHC7uDEobBtgbagppyacv4d+IVQXoxtKswyTe3Cwj4y0OAUxLZ6zDSrEb5gKCIlGWjok7MNnQvHVBvD1HlTe2toHwfbCYWrUpo0p+nrHhXQoj4jJmBKRBIDLCfQPmKbB8RfXFEk1YroJY+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199018)(36756003)(6666004)(478600001)(38350700002)(6506007)(316002)(38100700002)(9686003)(52116002)(6486002)(2616005)(2906002)(6512007)(1076003)(186003)(26005)(41300700001)(4744005)(5660300002)(66476007)(8936002)(8676002)(66946007)(66556008)(4326008)(86362001)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2c90QEYK/W+x2Z1iMkUjX7c8qD+LHjVdBYzRpe2yyFXyDKMS9jPtjVVN8t24?=
 =?us-ascii?Q?g6+eonx8xRskcnwhtqEmgi6G8+3XHF9aMiXRDut3L5Z5sfWS4gqy+WZq9S78?=
 =?us-ascii?Q?k8vR713w3Els/Flh+upchnTUSfDqFtB9Trn+gZf9AIbipG+QC8ywGk6n5Dx/?=
 =?us-ascii?Q?xiJDghN+1LP0+jktzwJ2vkQH4upheodAj8m1txH6JgNW8JF7cc5AhAyS0eqe?=
 =?us-ascii?Q?4B621aKicYPU/uNfv2BMxknrJF3gV4zpwwCONLHDPO1dqnr31h/sCXLQKiOM?=
 =?us-ascii?Q?GYTzdqTx4OY5IeX/sXgU1E5T65I/wpBHqWllZgDtUxZ26QUKxt70W/yhM2Ne?=
 =?us-ascii?Q?6dxj8+tXWaKGk2HwmVsu/SER2PjuH+OdjBGA7nL1z02a31+NbDpzEgkQ7/yf?=
 =?us-ascii?Q?+mYubLQDEhA0fpGgHt/H9mECico49LvYX2HI26+jU/Ikr893wfr/BLf8W2SH?=
 =?us-ascii?Q?ZVItpCouD1d30LuCYYFuLYuXqs78jL4+uW07cU/sUoc/aKPWrLhwKzVsvMF6?=
 =?us-ascii?Q?H3GDTDqa4xVpWgfdoIFRaigkxm8CaNATGjkUJP1xuTwrJD/UpyQRsNmyfnst?=
 =?us-ascii?Q?H9VZCDFncVIy0Z3HqOsvTy9UCkJWZs1fKAQcwPmzYiuFvbb1G1b2UqHJQLR0?=
 =?us-ascii?Q?SrOzvrkZ0pmzTMMBtirm2ejQOhvN67/Xd/HQk3avDG8YsTeogUFoIwNaQM/i?=
 =?us-ascii?Q?WOxg3guMt+FFxapdoQpHPW//db7uF8UoVujxf/DbJVJaOk9pY3Qv5S+/6QFc?=
 =?us-ascii?Q?Mo4G+V29WwSA2Wo9PrGaWOv8ok/gT2oIhgt9ihjPKKRKi367OGOvwLpR+yW4?=
 =?us-ascii?Q?DfnPTS9LAyPOtyEXdyZgXq62Cqa57dC/XCnIClsc0LdFRx/NLSRED1kNE8QG?=
 =?us-ascii?Q?0514loP3PMdkz0ocK8Bm1wQPQXpBI53+ADIkikZlLwDrkGj67gScFS8PMHrl?=
 =?us-ascii?Q?wVd0X42EPEJnKaBPMBii5ndmRISeaSF4NqkBbd0XB3SZE4ZaICvFY78FEU9Y?=
 =?us-ascii?Q?HSw3161QcAawpZn1b71X83xSOBfprJwvljxjFoJTYQKmWoZcMxzvMBshm/LO?=
 =?us-ascii?Q?d8X8LMKk2DFgvRSc6b90kP/UVSYr9ueeFZPcHRpozdga81nLWZf0e/OlNq0M?=
 =?us-ascii?Q?qZSq4xfPmRW6tePqRqFHCZdHX49r7CtAlGdXbLLiZS6d7sovirvT/LmnohUf?=
 =?us-ascii?Q?Ios9ZYh6eeQjIYFcttylAn3cRg4kCGSit005gYlCm62NFNV2KvXx6lbsflCX?=
 =?us-ascii?Q?mAHAaPmYUefYNe6O4suwxbm2SFzml6yawFWgmi4CwNvZQWcUbkDlrdd/Silw?=
 =?us-ascii?Q?zrujxG6XRgqvP7lWaKJuyzS7NkEbSSUA1/LhSuaRjcRGmnsmt77fQV6rTfnW?=
 =?us-ascii?Q?UrUb3QH9i0kRSRHhdqiQ//jVuYCe40Idl/pX7QKrdyurWNfjUpXsyLMDsmz5?=
 =?us-ascii?Q?pj32u2lRqQ9jEZte6LPbQKwuYqWa1lA0aVKyBBSTCxcCMgY+VWczLhGCHiag?=
 =?us-ascii?Q?Ow6QTNElRRRDgXbOvSg9GaXTQ9S5VDkfIDaPiLn+VfS6VQ9WoGHdme+YRT0B?=
 =?us-ascii?Q?Hqiy6bSsN6AEDq+yg7SmzesrssmvfE+gsRRBqd54f062G6YC068IziaPgFW+?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b32f962-026b-4e13-211f-08db220a424c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 08:26:06.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgRNvbxCwwFxFvTPfNwJNenQbK0RHygOQhWfJnUJ70DchJmI6LtgM2006ReqhgS1u//tU9oW9E5OK1EaHreEy5jcjRQpdqQycXk/wHa9OjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8675
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaurav Jain <gaurav.jain@nxp.com>

add .shutdown hook in caam_jr driver to support kexec boot

Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Tested-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/jr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 724fdec18bf9..ca5b49ea3821 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -163,6 +163,11 @@ static int caam_jr_remove(struct platform_device *pdev)
 	return ret;
 }
 
+static void caam_jr_platform_shutdown(struct platform_device *pdev)
+{
+	caam_jr_remove(pdev);
+}
+
 /* Main per-ring interrupt handler */
 static irqreturn_t caam_jr_interrupt(int irq, void *st_dev)
 {
@@ -618,6 +623,7 @@ static struct platform_driver caam_jr_driver = {
 	},
 	.probe       = caam_jr_probe,
 	.remove      = caam_jr_remove,
+	.shutdown    = caam_jr_platform_shutdown,
 };
 
 static int __init jr_driver_init(void)
-- 
2.25.1

