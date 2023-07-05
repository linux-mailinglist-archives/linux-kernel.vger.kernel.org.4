Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA993747C63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGEFYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjGEFYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:24:31 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60AF1730;
        Tue,  4 Jul 2023 22:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nv2MpoLgdLOLZQ1MrpqxiECuGeYKy5T3xSS5FXAOl+jAGtqBcYAHgJ5P5dTuuNjrBGrlLnUym/1bcn1BnZ3W8Vbffj/sPwadO8V95dXsNyJMa0DrnF7wIfdb9ejZ52nWjwzRKpvjTML1UhOzYZ674v/c7yloHfZ15OmROjI/vnvSxXQk182sv3Z4bmRVXQruzOrQgnHW8VV2GZCAqCdFATUe2hqp+UAl8nAU6vVPKPordwDYsjNAOwUnaocded12qH4GrrGX57rutRImaLO1kbDap2KRzDPKyCIT7ooMWYx15X5NDslmhbyyDZN8yCH8A/DM1C9ls95mJluzAA2RbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LeQ+2gP8IdHdI0fPj2WLgHFCAUgSZ1j9TJQHRLSFcM=;
 b=m8+EP5P/1JAe5EmqMB3L64qixa+DoLf7OdoPiFqTCMxq1f1qa8BtI+ejzyUE9kWFZ0oJfuGU4wV/ABU//5qC814An650vhbomyS+5azap0oUTybR1RMV3xD7ccJHrj6NSRUumMRGVDJ3cctChTj3ZKq50KF16JEEou0VFIPqC2gevQK1XGqRRZPu5DhG5fGxZlqwxxc54p4cZjwL512jsWjD7CEe2TT0x6pA1Vn/6WdVVDIfE6ZddXcfjpybaUQ8qt5jOKGPdevXmiNB4bk6LIjpmVt7Z/uujTkR93WoK9XeM3hSiz64GJMhx4IYPxIADzjqacIGPNYzhIT/SPXUcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LeQ+2gP8IdHdI0fPj2WLgHFCAUgSZ1j9TJQHRLSFcM=;
 b=gilquPOv+sEtLjR/PqQTK33vmNoPY+JnYf1fguTvQmpozul0qnfs3prnOwOETFf+yts3TMEX2TKdg5GwwLO+/GHZZW77fr7BVPnsEU16X+6e08jmRsST63jEjAe97tS5hDGDbYkE33G79Vi0UwIGOPufwIkZF8krCqd3EV40jMhdT8O/lynX6mrqdxTD/dxI5sHTMJqaXePiUugcEcRMS+OLif+LcmOyH9NGWUvjfLXmFQXc+WWDpdPzi/51ht37CcTigTroRm4q8xLw1YXlSCjA/2CxAME8olUJcp2ry0D03cwx7lyfM6wrh/yDrt9YaPrmR//dBBXL6qOLsPyxnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5123.apcprd06.prod.outlook.com (2603:1096:400:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 05:24:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 05:24:11 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] Input: nomadik-ske-keypad - Convert to use devm_* api
Date:   Wed,  5 Jul 2023 13:23:44 +0800
Message-Id: <20230705052346.39337-8-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: cbb546fe-d2a1-48a8-aa3f-08db7d18104d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKoA+eNGLFhGFQhbTG8JJ5bKDPx/NdzbjCIJhBMvqV7xtTTY2Ir9HbdyHKhvKii3Mgj0cwJSIV8o7P230FGXeLH5Fo6l0GSeusi96/HPIECreajQDB7ssuwWHfxSeZAA2fSLnrCZGLByT6WqIvW5IWqctgJYcWULUSnDH0UOtTbse6Ocsj6uNb6BPtb+QIG2dLFuEIpZ4cwIUIxA8e47q5vCcKYaBVu0X9K8NXIuH2F84gMIey8Wn9/zekBDIHQafb8Ai7xmNTJwXQzlkQo2wpZcEGwRshcbyPsActTtoDws8win8OhWRDeu6qnO9QdjpnfoNgKDsIWFDjjODKpXqKNmfJ9IuaET0vY85egmSblYNYiu49wYeuRmXa+rdZJsGUnnfXjAHfUc0EZ6k/k0EWv1cWg6+JluS1bU6FvsqsxYA0gdRlJSBAKpblynKKGhtlT7xgMQpcSzP4UHiCerrVormftkfPj2LIJXEcEj5W7m5CB0qxh6mE2tHc/TjM8XZr8R77eCXZdYz2M/x52A29UQ2TszyWLdw2+eo4ek1HdJWtzrkeEDdwT3MFrNkBvKI2fmenrehltBlMLyoMqAV83U6NnbcMaSlStWpuT8agD8Op3pfjfS0CUkzZcokoV6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(396003)(366004)(136003)(376002)(451199021)(41300700001)(38100700002)(6486002)(38350700002)(6666004)(83380400001)(1076003)(6506007)(2616005)(52116002)(186003)(26005)(6512007)(86362001)(478600001)(66476007)(316002)(2906002)(66556008)(4326008)(6916009)(66946007)(8936002)(8676002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1dpPscsL4nLGO8DDTbSkEoA8mtQiJ8f+qGz3S8veGbw6y/q6BsDQl2CTVqEa?=
 =?us-ascii?Q?IAZEt9BBe6zZNaiOxxniMHqEm99kvi7uJKNCYeCv/NELHUxsxS6pGJ9sPB/n?=
 =?us-ascii?Q?OHdmWHvk2ZfSFK/vbz1G0tqcrkfDsYSQ1MvJOczzbnQWXJZJ7Iq9gMv6fD6y?=
 =?us-ascii?Q?odquv3ZRbNA6vSWHUMJgrMDwtWMXEMP5pRSLu1EDyAGpzbyFKDqqpj5JKUOl?=
 =?us-ascii?Q?c0b/jm2NsJfK5QFjGB/kUQwTE92xyTqC93AuU6VF+UDG7WBA9MATZUDUd9us?=
 =?us-ascii?Q?CYFNdjUll501f0JAQxakyFXrYZTNJdanW7achEQYPIZGCx+7mMlLgdsOKGsq?=
 =?us-ascii?Q?QXsIpViDMbYqvlnyKW0K1t2/vUetLZ9Icegp9PZAP4pHNtaN8s1ObcLIuiCJ?=
 =?us-ascii?Q?76mhultN0JsVb53bVtDa95g/64SGv64fflUl1opMx1yw+B58bRVX/A4idihV?=
 =?us-ascii?Q?vqAsVKt1b/T/ymV5psGla2Lxwya/MuFr61+uDXvsMANTlhxCwddV7yYkis1Y?=
 =?us-ascii?Q?3A+VSl16iGoNJMFeo6+rhTRvRAa0rhL9NrBirYMNGO5WOO9O5l0oFprl3LBE?=
 =?us-ascii?Q?GXZlcXfmveoGc1vY40wsTiN5ki0xI/TntNTb3nPx1AfOMvxpMukfsG+DFsdU?=
 =?us-ascii?Q?nkZDjHGPRQmeV4TPpMf2ng3WeNnsYLwugqHbDWy+1Wn83tF8p0XLAubXirlU?=
 =?us-ascii?Q?tlDxJzLIC8UG9E85Row1u4HIUovMm0xeYiBvlFrujE6bNxc8NSSHB56qwDdR?=
 =?us-ascii?Q?5IOXl473T1bhF6kkhwokA3Jg4B3KyHaUGfM+86MXc8q28jb6CHdZ1aiPWf8x?=
 =?us-ascii?Q?n9QvYipbVVUOt1DXFmJDRyw/0zlRoqe4SBI/vZZc5MzHCN8qONrAP1VCFbK3?=
 =?us-ascii?Q?1VLK0WFL3gXFaKPLpjy3u/YtHeqTazU1pTGxKzRqZCFNO4wriBFNJJwxy3Vz?=
 =?us-ascii?Q?6PYWFB3zC2e3gM4pBbbiCFYlRBk0x4/a0A0z9STBSEXiBWUBf63yqpL1tI+B?=
 =?us-ascii?Q?hAXfB2azkz1UCVv1XewUeDNV3WFDVmzGISABc8vSYQh5GZQp8NUx2+gZ++7y?=
 =?us-ascii?Q?thiMgb1OVM/B+uLmw4dqkLAJWCvGCWN40NVpBxtYltruWCE7zFXQJ+1Gtl2E?=
 =?us-ascii?Q?X5q6VL+AtQ2gdCId3OfcGD08QG4NbPuKcZQQBxj2eNnsdl8lKQBR2yKILlny?=
 =?us-ascii?Q?kALKcwRAtdxRj9kTln0HkDGOkrQemnuFqtd/ObfB3RIL+/Pj0I5LmZfOs7tk?=
 =?us-ascii?Q?njUBDDTdtPVxdYOPRVzoZL3Niz/rL0Ni6mHPn03yMOuW7Bu0jCEeqSk360D8?=
 =?us-ascii?Q?WqtcADndsrtCXi+Uirg8Goyr5bI0oB+DN/QgcAFWLf/xn0gCEw0KN2wvrDll?=
 =?us-ascii?Q?02o84wgf6D8kSa+94jPBMnmvnhZneco3HType/ueiD5Jfc2VF2ZPIcBiPSxZ?=
 =?us-ascii?Q?Jbb1/HzzT/W69sOU+WEnjLYjJhyZPSmCrqZ504+5AzIiPtUgNIu2B60q1ixb?=
 =?us-ascii?Q?vetcfU8LEcXC6tAtsXGf7TMTY3krw8YaMv+4gDphucQIHLNxpLudey7UV1tV?=
 =?us-ascii?Q?uMCcbRqedEEy1IFLHo/IQ4vLKGJiIno+h1MaVmev?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb546fe-d2a1-48a8-aa3f-08db7d18104d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:24:11.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsKTLn6l27NvYCuJBKqnjheXQQIx6psvijuAhE1dG2XI4WX+YE5um2bmd8WZFyZ9ghCMxx3DddjLHtoYiOwefQ==
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

Use devm_* api to simplify code, this makes it unnecessary to explicitly
release resources.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/input/keyboard/nomadik-ske-keypad.c | 76 +++++----------------
 1 file changed, 18 insertions(+), 58 deletions(-)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index 970f2a671c2e..93318324e9e0 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -225,9 +225,9 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 {
 	const struct ske_keypad_platform_data *plat =
 			dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
 	struct ske_keypad *keypad;
 	struct input_dev *input;
-	struct resource *res;
 	int irq;
 	int error;
 
@@ -238,20 +238,14 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -EINVAL;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "missing platform resources\n");
-		return -EINVAL;
-	}
+		return irq;
 
-	keypad = kzalloc(sizeof(struct ske_keypad), GFP_KERNEL);
-	input = input_allocate_device();
+	keypad = devm_kzalloc(dev, sizeof(struct ske_keypad),
+			      GFP_KERNEL);
+	input = devm_input_allocate_device(dev);
 	if (!keypad || !input) {
 		dev_err(&pdev->dev, "failed to allocate keypad memory\n");
-		error = -ENOMEM;
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	keypad->irq = irq;
@@ -259,31 +253,20 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 	keypad->input = input;
 	spin_lock_init(&keypad->ske_keypad_lock);
 
-	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
-		dev_err(&pdev->dev, "failed to request I/O memory\n");
-		error = -EBUSY;
-		goto err_free_mem;
-	}
-
-	keypad->reg_base = ioremap(res->start, resource_size(res));
-	if (!keypad->reg_base) {
-		dev_err(&pdev->dev, "failed to remap I/O memory\n");
-		error = -ENXIO;
-		goto err_free_mem_region;
-	}
+	keypad->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(keypad->reg_base))
+		return PTR_ERR(keypad->reg_base);
 
-	keypad->pclk = clk_get(&pdev->dev, "apb_pclk");
+	keypad->pclk = devm_clk_get(dev, "apb_pclk");
 	if (IS_ERR(keypad->pclk)) {
 		dev_err(&pdev->dev, "failed to get pclk\n");
-		error = PTR_ERR(keypad->pclk);
-		goto err_iounmap;
+		return PTR_ERR(keypad->pclk);
 	}
 
-	keypad->clk = clk_get(&pdev->dev, NULL);
+	keypad->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(keypad->clk)) {
 		dev_err(&pdev->dev, "failed to get clk\n");
-		error = PTR_ERR(keypad->clk);
-		goto err_pclk;
+		return PTR_ERR(keypad->clk);
 	}
 
 	input->id.bustype = BUS_HOST;
@@ -295,7 +278,7 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 					   keypad->keymap, input);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to build keymap\n");
-		goto err_clk;
+		return error;
 	}
 
 	input_set_capability(input, EV_MSC, MSC_SCAN);
@@ -305,7 +288,7 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 	error = clk_prepare_enable(keypad->pclk);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to prepare/enable pclk\n");
-		goto err_clk;
+		return error;
 	}
 
 	error = clk_prepare_enable(keypad->clk);
@@ -314,7 +297,6 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 		goto err_pclk_disable;
 	}
 
-
 	/* go through board initialization helpers */
 	if (keypad->board->init)
 		keypad->board->init();
@@ -325,8 +307,8 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
-	error = request_threaded_irq(keypad->irq, NULL, ske_keypad_irq,
-				     IRQF_ONESHOT, "ske-keypad", keypad);
+	error = devm_request_threaded_irq(dev, keypad->irq, NULL, ske_keypad_irq,
+					  IRQF_ONESHOT, "ske-keypad", keypad);
 	if (error) {
 		dev_err(&pdev->dev, "allocate irq %d failed\n", keypad->irq);
 		goto err_clk_disable;
@@ -336,7 +318,7 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 	if (error) {
 		dev_err(&pdev->dev,
 				"unable to register input device: %d\n", error);
-		goto err_free_irq;
+		goto err_clk_disable;
 	}
 
 	if (plat->wakeup_enable)
@@ -346,34 +328,16 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_free_irq:
-	free_irq(keypad->irq, keypad);
 err_clk_disable:
 	clk_disable_unprepare(keypad->clk);
 err_pclk_disable:
 	clk_disable_unprepare(keypad->pclk);
-err_clk:
-	clk_put(keypad->clk);
-err_pclk:
-	clk_put(keypad->pclk);
-err_iounmap:
-	iounmap(keypad->reg_base);
-err_free_mem_region:
-	release_mem_region(res->start, resource_size(res));
-err_free_mem:
-	input_free_device(input);
-	kfree(keypad);
 	return error;
 }
 
 static int ske_keypad_remove(struct platform_device *pdev)
 {
 	struct ske_keypad *keypad = platform_get_drvdata(pdev);
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	free_irq(keypad->irq, keypad);
-
-	input_unregister_device(keypad->input);
 
 	clk_disable_unprepare(keypad->clk);
 	clk_put(keypad->clk);
@@ -381,10 +345,6 @@ static int ske_keypad_remove(struct platform_device *pdev)
 	if (keypad->board->exit)
 		keypad->board->exit();
 
-	iounmap(keypad->reg_base);
-	release_mem_region(res->start, resource_size(res));
-	kfree(keypad);
-
 	return 0;
 }
 
-- 
2.39.0

