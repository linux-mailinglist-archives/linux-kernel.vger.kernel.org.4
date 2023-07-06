Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E3749602
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjGFHGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjGFHGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:06:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB7EF7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3yLj8Ud0iXcFX4JwBgwKusNht+LJDXl3O65deGbX6OiZ1DSoyfa7oki0tF5ltYJrD9Ehhz9xtqwWxLQ3asm3Wztep8atqw3Dt5FvunkSfY44gaKIpvv7a96Vkn5rHfQYf3sabsYPSwKUzbn8FYY/++hRyBobT1weOJfivZ/GUDVNVCg0j+KG1j+6T5kqe01r9beBQbL6AXZIkhKyEKXyn+aF3ckZUMNwm/8KY7/139jZ6SyebZTYufS+T0gJ4mOhRFpQZ8AcSJ5QtA+UQyS7195Spdnyhw2USqj64d5cTWU2mrmOudiStPAGLk59ntb5DgG2Tl+2N6fR3MjF5eeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp3sqNUyxSEiAkyOVQFygM/ZTiyoEWoXmpW5rKbx2po=;
 b=k4DLm3dEv3fUMj7awN7hAIMmgoEZrJD3Xt/lgPJwQfeAgq2aaKyOJqES5KGFKuAoBAFpiIt0ZiWImtfz5GTVi4EzY8EuB8vY4ULzDsAICR8KsM51yXwKNPQaOHpCfsvjJNpeJ1WYcmr03dTmFgW4GSWPeXT1aZDH3YLzm1bbMaSbDx9oN+ZeeAEE8VnBCggiLQNyU8kuxeTafen9bdlLndejWF+KENm6jI8qRMortV1wGnEjExOERX4oJq0xqvwbkSS6YzeY5oqg7yy6BfxEfdO4wJNgkoWVXXzX7eiY0+cFl66ui6WMLzZ43VB7Lj+NTT151mhQPhshFRIjKKzgvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp3sqNUyxSEiAkyOVQFygM/ZTiyoEWoXmpW5rKbx2po=;
 b=rGvZ10FRPFY71NcuDs6wMHNFbEWdqzku0YBnI8fsZFgtXYLeo+Ey7mubO/yOWjdjMHVi9mgcFlhnw2avAtlQ254tVskig2fs1WcqqIWJzbYfpqvsoIjRP0zAdi0M0wARwYXxzP/qVshjmeF5FJzLVQXzzLKP67LqbEEHeQahvnsEhQyyznsnWFJ3mnecOheFiUPM0TJTK4RR2ZYHP/IPSYpUqnwYLx4oHKZABhojwdGz+UQz+fZpbij4AzYS9kFmov9ZUUPkFBLCIRIGcpdqoZE4ZzOYU1AZVfGaO7yz9X8hVt8Eb3XR9T/2Ea3PY1uX8EMQsRXmuDAFZbOTCfSVyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYSPR06MB6314.apcprd06.prod.outlook.com (2603:1096:400:417::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 6 Jul
 2023 07:06:48 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 07:06:48 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Lu Hongfei <luhongfei@vivo.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] drivers: bus: arm: Fix resource leaks in for_each_available_child_of_node loop
Date:   Thu,  6 Jul 2023 15:06:35 +0800
Message-Id: <20230706070637.35972-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYSPR06MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 26342251-5deb-4519-f8bb-08db7def9074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPQpAPV7Sapju8kzzk84O0yqkHVCab+dDKd1oHykMwPS7QvjsxP61DJ1iBC6pt/MrO0QODpI8SRKIjjHnxk+IkI+LGeqSTwevpXFe/xVU+vdi13OBpo9AfrNB8FyTwpc8mM9d52L6v60qMs0g64AfHvWtuThJ4pkcwKSdu+uMqcfKdjqhMBDvT2GHbFNXlmAPTTEwpcMXNn+fRiR2wABwcPJ5kdCkeqB07CCjaTk49dWf8I1VoqUF2RZGius/0hwRWE/rphv0jj3sEf0KlKKbS1uCHGPXApUyPZme6bd3g9uS9+j5nNkY4qqD6o3606sRkZPbav+BuVspzCZEUZL9gkT+XxmSREcRr7lwAiIpTUxnQR4Ha4Gy5z9on8eqjs53UbYHHogbWKvH84JRNfSciFYwLQNPYKvt3IpZ7V1ZNPVCjwNFHO+gsZrFfliQHkF3OYSk/TK4useFRI+bTMuqU3iVqQdYvRGz9iKW9uzjAgsH+zNftngNVsT26F6+DxtrU4OvO5wLccn0vnGkco6vUQutXeGmJwZrUapx71pUI0nuaJM2qDN9X9KTpGjYoSYiHS+VPFCLpmhOCNxTTZR0BhM9xinV7GMxdlts7Qhrwx50cWtFF1BHtkCxRQtSB9e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(4744005)(2906002)(41300700001)(8936002)(36756003)(86362001)(107886003)(186003)(2616005)(6666004)(26005)(478600001)(6512007)(6506007)(1076003)(6486002)(316002)(52116002)(8676002)(5660300002)(66476007)(4326008)(66556008)(38100700002)(38350700002)(83380400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G92gHlr/Sab1l+FFdfhrMIK75qG6wap/yZ5q5tt6fZ68bF5a/iY48vd3DmvT?=
 =?us-ascii?Q?p2RWJlADTTifmOlk3hPZpTocGI9Sl4IBXrYJy8IBf1wsdDbGLImReOGVlOJz?=
 =?us-ascii?Q?ph15eNXfYc8CDj+v/co+lL0JD3cXJDnYJWM01nZu4uemeIRxoIvOjQvpugTT?=
 =?us-ascii?Q?Q5TGMhGfsCDl+fnRguUcbusM/AQheRd3rkpqfYQRVkECosvKo9vl6V3Tm5Q7?=
 =?us-ascii?Q?8hzvKBbQs8014fuW5u0zNobZqxS3kvmgFQ/wZ3IUQt0perho0SXCAVB0G1/p?=
 =?us-ascii?Q?Jggx95gYs4FOtRHooSPTRfdhGNgwX0hXROOoB+jjCYWK7utHnR/Rm1m52Yp0?=
 =?us-ascii?Q?Kb3qeNdB4LRTiSP4qUquTFSJkrhyZCexGtEAajmfW2hWIAyMZ6njwwYfH/XQ?=
 =?us-ascii?Q?vcY0a7XFeigDv+oEr6FPbziKu1DgKLMKfnrZqfyZl2dWB7RcQi695AveDJOo?=
 =?us-ascii?Q?vouJLfqQFn5RnksjoOPSzRnszahm/QsgybaA7zVdtaixyuTdhiFX7IgEYpud?=
 =?us-ascii?Q?9/5t7sIedngDst5yBIC9jkyd92miW7UYde/rW7AHzNNAJo2tCVe/ZrdvLUNM?=
 =?us-ascii?Q?AVApqBgVjwmhwPmNAwSVT9CUYsbxXuraq7pvB6NmUMKgstTg0A/H72GN2ey7?=
 =?us-ascii?Q?vAve449BNttPD9zU0fT/5mviuQ1K+zekbm0RI0Qckgn5hCPm3fzM/6Q5SclY?=
 =?us-ascii?Q?WFqsEqcvFp2w2c2zoZR2TC+20TSRyDLA5eFdLVRrC14TihTJ6+EGoj4+9PcB?=
 =?us-ascii?Q?PgpOK8HlivLeTPWKdXFPWX9O/HCxjoQTgoLnib6AI7L74JAO1tbWeaew2wRV?=
 =?us-ascii?Q?ClwHJIaihwd5XvA4IMo08n49TNxXZMLsBQN065S7dkZKDhGe+lFSCLU9ubwe?=
 =?us-ascii?Q?11SjMhM/WgK1Rtkax/UWToqYSX9wQcX3qnyNHVCIDf2FhQTgqWRo/6Z0YTJh?=
 =?us-ascii?Q?GO5ngxYENto6yNv90/Ibn/CKBUvMPq8uBkJBV4mUUVEwXHOMgfFNIEacJBHy?=
 =?us-ascii?Q?s68ezi9sJnIGZXkTGyVNedR+pe3JsiZAE8zni4ufOkf+zNVVHwrF7OjGDGvg?=
 =?us-ascii?Q?849OZ1fDhAPou4X9V+VACH4YO0cD6VYYuWJtYHxPjcj1PN3sISAI0sX4Gfyk?=
 =?us-ascii?Q?gKCq+02Kj9qUOrznYBprJftCmOoc+glu2VhPRGm5e+auVg1Nq3WWh/gtuPhQ?=
 =?us-ascii?Q?f/vTaJ8uyj+Bc++hKyraSWkSRfP2j0oMd9p9jB73jptJ+d2c/o6N57dkP8zB?=
 =?us-ascii?Q?4ps/QrCfO38/66IgRVG10MxGu1GkHM5RwA9YG0lPIwj8eqxIgSxlCwa7qET5?=
 =?us-ascii?Q?qfYwgJ/SriRxgdtMGsB1XAmmSFuKNBsjkRMzLu6R6XA1Z/a3+JX/yQVojeS2?=
 =?us-ascii?Q?e3sAritYetv+bhMC7ay9ysGY3dug2iroGwwoz5BDL4xH8GdMY4GPrVFdQTDa?=
 =?us-ascii?Q?8Y4G753JwjLtll/lwetxrzxb7gd35qaP0rFN3YlkpaOVFe9thqobo9rJaNFT?=
 =?us-ascii?Q?uQE8FkcvHB7MJQDam2JW7y/wGZFk1UcasApM0HLIe2wtzeM9p8PjZL0KsN8+?=
 =?us-ascii?Q?JQUuCgxtNLZGJEY1MlSwU1zVnqdfemcXzFDOVBQy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26342251-5deb-4519-f8bb-08db7def9074
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:06:47.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0dCw5FZ4mIxEYTsW/1SgcDwrHDmyWca/x1Q5erI0NUj08npjBvlKaS+XTOAyP5U6v7DUTwEqrVGF9y3aHczGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure child node references are decremented properly in
the error path.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 drivers/bus/arm-cci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903583..1f84a5528073 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -461,8 +461,10 @@ static int cci_probe_ports(struct device_node *np)
 
 		i = nb_ace + nb_ace_lite;
 
-		if (i >= nb_cci_ports)
+		if (i >= nb_cci_ports) {
+			of_node_put(cp);
 			break;
+		}
 
 		if (of_property_read_string(cp, "interface-type",
 					&match_str)) {
-- 
2.39.0

