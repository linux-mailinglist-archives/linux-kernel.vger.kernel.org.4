Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A320747C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGEFYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGEFYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:24:07 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F75D1700;
        Tue,  4 Jul 2023 22:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMCL5+zVbIbpUkG9z5yRyVajCPWZOpCXraRX/rnG+fHO/C/68GkprpXuoahApE7uTWSk76lVBMPzHy0Kgper589Wh6m8R0LXviVpTpgAv9qRwAottaatn9shwItH0QUGlwy+pEIgpvLdKTBhScyqArS/mETohBzzn+7jQ+JpqGsFEuVxqGDRlwmFP9jVKyWLjhsj7k1TTREFDO/Qn66lMuLGwzagdsCx6HIkchrEM+U4P97lFSSUahj+hncsYdyw2KqZILBBJy3MBpA3r5tXzJgfOIPCBVKu3o6dTmckz/zaZyGIG2IUSlBXCubFTh3bH8iy86KD/Alo8rCJwOzX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elem+0WDlBD3WyqlAui0kZiD8s+krn1DbKQivdHJZE8=;
 b=Tfhv9L9A7RK9W7V6bM1kKjcztKSHWPG+yf16u+vS8zfaAC5aabHyBriEZhGl1h4CuXu0k0DYNOEXP2OrwmVB8FeLO/qgphOKHfNE7ZnJ9LfgkHcJjNA80h+TDXsukwziXRv9ddOCUgIpZ1iHYGn8LUEl+w6W/LVUpg2kzup1tcOLI+E3XrIqyWPs9+64zCvqfANkIubXdMqNshZsvTGHXV8f5zYLvofZSWxvqcf6zmNp7HvOeVpJ/4akFHb+r6YsKc2Uiddv+H1UhtvyPVEjeOEqoVrvT51MBtw18q2CcPQIX6khDm/tWegU/7wLQmpVY3/BNIqWyZxvb6jjnuQPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elem+0WDlBD3WyqlAui0kZiD8s+krn1DbKQivdHJZE8=;
 b=O8/5PcI46P6/IEoKEP14Nbsp2kzDlTnpvXaHXzHxJkMGbOQ0h6zbfRno98aHo1mC18YRNtagBEL0QxmKpj7CZJ7USdL7R0exmMhBzOPblVSjk/bJBIvrgGHROEzBE0UyfDbxqzdtR3ek8arm5Y0X3f2bXnZa9VKYfdsqkBs8Hb1xLPEU8QY1ircRGWMhKno5fBHndzuPUyWs1Kb+tE/F4qyfP6NVcRnimADdaOoNeZqZLWZTOaTj/sN1QA1ea/vY0Qa1w6ic5j7ZKOKWGOv8FPShSoTux8R6UbSxpphzxnI109bJxztk8krAas3uYtVPsMXw9VsIuGBlXO8US3eoaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5123.apcprd06.prod.outlook.com (2603:1096:400:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 05:24:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 05:24:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] Input: opencores-kbd - Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 13:23:41 +0800
Message-Id: <20230705052346.39337-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705052346.39337-1-frank.li@vivo.com>
References: <20230705052346.39337-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: f97ab19f-1090-4817-d868-08db7d180cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VBvSoGX4Q/iUKkYtFQb4cxQTNeUScQStDtL98oAnCkV9Du1mCsV1ucCo6TXb7jAzbKUZ6va7BoataQ+/neTdxH7e6Vr7gABK/tRL6nPi+caftaMSsKd4xmp/q0DJEtYEPOuq8qFdsbtYS86B07OM/h9WBTL910UeQ92+YQetcmujmfgiTjBT0t5Qa+M5Q73jm55wfEFKs0LvAnQxtXF2mamVJDvAyncUcazpu9lDuZVY3fRBKgqXVpzdmgXKRziYG3Lp3y5gYBGo3F/7ajKgGW4HGUjNc/cGuzee5gzW9BPIHFGuhCbpFgBd6XTKIRmeawyJT6EqAsX/c2aQkd/KvfHY1xHejU40iFkKxXTq3VyrbCsHYvM1CRt1yDUD4G+TBbCstELzRPmfflkqIrKaDgM6XdTA4LIgYh5YNVd1xfLVPfo9qgZZnd7UFyY25B4p+1He44SwgJbKtZIFuY5wQXtzdfoLEcIgy/49MkHxftMwEk991XI99hbNQPqUZIxotqS2KmR8JcFr2RmssAKXUipCAEBFGbMmGLwqkjiMrCft/4u4FICCm//ostfekiOUWxf+Jt+672XOh9+/t/rQJPFHf8KcdzHimpsf+ht9nJoXVIeT6/Qag2YNEOXmiMIN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(396003)(366004)(136003)(376002)(451199021)(41300700001)(38100700002)(6486002)(38350700002)(6666004)(83380400001)(1076003)(6506007)(2616005)(52116002)(186003)(26005)(6512007)(86362001)(478600001)(66476007)(316002)(2906002)(66556008)(4326008)(6916009)(66946007)(8936002)(8676002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HZ4CKHvVB3KCalucto0rwFGNDWqE91ZULzrhphCt3wRfRPoydddbjrmpAzox?=
 =?us-ascii?Q?A+XdlJHFpC/h+r/UnytgBrQVoFSNE3Q6SiNFulgSUGID/4LH16JS0GCaerdC?=
 =?us-ascii?Q?htMbTLVQ1nuRHEUSH1bzqrkXNDhWWuaXpib9aX70LW6HJ89xIPYW9u6pJ+Wf?=
 =?us-ascii?Q?3KPNor9jJNLvcztDA3+4rh8EJYLOnWCbD0P70zQJXPaLNm1a0DzoePwxl9jO?=
 =?us-ascii?Q?iTH7gWJzL4MNgtsNa/mV/i4dXrQw2fMx2YWrwBcFnG5B9xp5yrKEyRauVtxI?=
 =?us-ascii?Q?GvYNavM37YbNlTgko4HC8yHBYkmQaikcmDP6kr1wjraVvqSPP7SXsBMuBcQf?=
 =?us-ascii?Q?b13BBnwV14rQ+7h/fk6IlLDmUrtVC39LRXEbIdblnHJiuee8EeN3ZZ/5rxWD?=
 =?us-ascii?Q?/2yx1K8Cq+iXdbXnRVA36wsJMwAKNJKiITUsaoO+W9QHneDiW7xa8aLTOOrO?=
 =?us-ascii?Q?xkBYNoSBmPbxdPhQsEKcr255d5eBD2dj1e2AVAlViLVLGPyDuSFfxfrTIHEz?=
 =?us-ascii?Q?h1gvTbADonUcCTyIA2XD4nh0Euu86KQiA2pL65kpLVJTPzr4pLYttj0dBIFe?=
 =?us-ascii?Q?edehFGf3JygvFG7eaB0MRdcOW9c2PqdLW82tiJTlR55HjkeWRoUQ9R3sw+qk?=
 =?us-ascii?Q?vNGFUdNT0mUsnNV8XiHLuF2egEG9auYew3894a4lkrhclRlSFi0vmUJYlmmM?=
 =?us-ascii?Q?lMmnWFAZU/hIOha9zYq9OaR8vqgJu3w9wJ/u4R7PVQ+Fj4Ay03qJE+kwyDMt?=
 =?us-ascii?Q?wtweo+cXXKUgvY91z2OQcNXi9HZIgCqXxz2tBWR/z+HdRJr6vJhunFXI9nvX?=
 =?us-ascii?Q?WITLA5oMUq6u9kO/i4y5YUKA3cmBrbkUBsu3giqqhlLaT6+hHWavI1ddxCxL?=
 =?us-ascii?Q?BV6sIdBYGT4fXChkHVs6FtyahpmWElOADQkk3DyA6DpwkGB4UsEmLWl4hDAO?=
 =?us-ascii?Q?DbJVjPbYGBKuuKxxgDLv8zOUjX0K0sak01t6Ouu7fgGZ7dtoMIrSas+EdIW1?=
 =?us-ascii?Q?FNdLS3Ljiw7oqLJxk7apYlgTcVG7k7lrJrWZKdHL1QNGgmMXtitN2/s2ehhQ?=
 =?us-ascii?Q?Z4YA6O/687VIhPbrXOl/u2vvXRMQTHY1FX840AbVDjeldjYi0dkTRJyX1gz0?=
 =?us-ascii?Q?QEYeWrkeSsw/gwSu3WtDabI6xjffKW5l6RzH/pYTNNbkEZdscA8Jpe496mHY?=
 =?us-ascii?Q?dQef6P/tdR3KE8YaVZJxgM9OqBVY4pzxuZpwhIDivb0Gskw2itjcXljmyZvH?=
 =?us-ascii?Q?s3ZdEaCQLGAwbvLrpk/fl5F9/j+rbaHKVQHjkAO4wRigZyw1MtOU3+qxyQE3?=
 =?us-ascii?Q?T37nfQMTbGxPol0iA9Ko90iTRlFcqsygafs8CfUBThLnt61yDHLC2J7MKv2w?=
 =?us-ascii?Q?E6yj02ODfW9VE0xZUq2IlbpIlUanfkpH52KsaAi2EnuRMTXF/WCyL7Hxrldz?=
 =?us-ascii?Q?Yd3UFqHbdMHKLy/U0+KJpkCPWnm5dfxvfJKJeIk53VdOOpWcm//+JLZQH7Q3?=
 =?us-ascii?Q?qYsUAIXWSmGToiDBYeeCHj/ikchOjsCW69G3WHpw3cyGhkHXxIXP+S0KKmnZ?=
 =?us-ascii?Q?Cd41c1f7kYBjThBKQX6fLl/bqyRfCIRiW14kb2MM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97ab19f-1090-4817-d868-08db7d180cc3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:24:05.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14tK6fPEOg/seuVaYMOZFyar/e8uymiRlcMSkPBA21ZMErQrKbc/Pc5MP8uUBnYtZZS8XltQCrJborHbL2oWYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/input/keyboard/opencores-kbd.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/opencores-kbd.c b/drivers/input/keyboard/opencores-kbd.c
index b0ea387414c1..7ffe1a70c856 100644
--- a/drivers/input/keyboard/opencores-kbd.c
+++ b/drivers/input/keyboard/opencores-kbd.c
@@ -39,15 +39,8 @@ static int opencores_kbd_probe(struct platform_device *pdev)
 {
 	struct input_dev *input;
 	struct opencores_kbd *opencores_kbd;
-	struct resource *res;
 	int irq, i, error;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "missing board memory resource\n");
-		return -EINVAL;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return -EINVAL;
@@ -65,7 +58,7 @@ static int opencores_kbd_probe(struct platform_device *pdev)
 
 	opencores_kbd->input = input;
 
-	opencores_kbd->addr = devm_ioremap_resource(&pdev->dev, res);
+	opencores_kbd->addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(opencores_kbd->addr))
 		return PTR_ERR(opencores_kbd->addr);
 
-- 
2.39.0

