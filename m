Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897F77500E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjGLIOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjGLINw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:13:52 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F78BCA;
        Wed, 12 Jul 2023 01:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK0CQch+cV9vjOIaZQoMc70Msn2PkWmSVE9dtHNUrzxSQ2gjwDCgaMCkGlu1eDgVs55I36EkAfLnjvZs/0ZdBujKTzsILNhyqpKU2TPgutRK6mXAWK0xxp37mXlQOZkhrTaMhOFDLi3sDSglHe/o7yVklZePo5fXQPPfMlBwhI5P1YoWXfL3BiPyURo/miSwgO/suaCg8xtE331NuvQKSIf8ZN13jp480LB9XHzGb1wy+f2TfkcemDKXalGdNpke1VJsi8soOvXPHgPvdH8xAT7mNkvEdTeShaR40/EMLp6h8q67Yo6hPnAz1yd4BxTc3+oYME8xMS6y8y2p2e+A3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vgvj9i8WuHJ3VFRZLwvhoKTz+hGp5LXPh+342T76Zic=;
 b=ZV1jwq6ZPdTUd6WtvmcCq6Jj86ETtblQU4zNgtyqCEvtpAYiOTgfb2W9r5TyxS5zNpThDhDqihf0yj+lHqm3IHq7BHnx61Mvlq3YuJJHVakZ9yfq9WSYWf/qmTbERzPfL15eBfj2LwQaHHSRfdZxNLZgEJjTsAvlZV7vnAyyHXHKljCJD5nUHzIqw6FHjAw7aQKICWrSz2oLGRPopGEDPgNfRHrjDqQ3ecpja5lPBHFhzrmDVmq5vZ70O2f4FyeCDxNFE4sBvmHbJ2uwxjPR3qVq5hvya/AZlNNSUskX4uaOxhg6i+CyoTTxiN82WI7tYL0uw7ePjRn0qguU7u3eiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vgvj9i8WuHJ3VFRZLwvhoKTz+hGp5LXPh+342T76Zic=;
 b=Vdu0LxHgoY1fy0BfJIoF24gmwhp8vCQnrlDJ84FSZBEe/9AJwXK4+NGxqvlIdjrNO1ncqTRTcvBWz4sl/f2D1a5bxIq3dzKQYlbPAecpc48yVOFCOhiAZsjoEjbJL+PZUABkWqUp7BuiEkT2LAxVCGU5WFjNXgcZG3wI8502iN+JCgG0NAnNqQNurnSFc22dcscH+1luH/J29hLrDLD9/khZUDTQlI8lQ7pHX3nO0VGrOCH2/q41zgkGRHO1sCpfIk6w3hpcKOWFRXiMO11XfLAPKYEhVBTYxkmZC2E84VyI906Nyp1y198/6IyEnQ+GLXGBerWu1iOoWLSKYCjV5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:13:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:13:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/27] thermal/drivers/amlogic: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:32 +0800
Message-Id: <20230712081258.29254-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4091b3-856e-4c91-7e81-08db82afe915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YaVQ5HxBs/7drPtb4H+hFYP4ih46/4guW80n1zFNN5z36G8VEZmKdi9b8x61qLzUOlSH1ess5DtG3q833bf+sj/ar9PbRYuLn4oX87ri5yiDxZIePesu8CW2R+CR3l5p2q3c1i/4Q0W8lmOAoVI+us2zBg+5d8+thE8a+aW+mTzL1mdVfAMJs1xhLPEM+vlVEy+bQS+NC+h6pe/21z1ku4A+6KBqtNmJQmsEIPXylhJeLXZ0ffqCrZeiZolauQVK9YRNISHAjScAijtPQztSEPB9XVpmZH4BzOvqX7/JRts4xkP1QqGxL3cZCs4d5XcMGWg8gCR3gWsu5L7GXMRe8DiS0zD0V6BrT+2i4ssw9V0i+z/e0MEw0VEyNh2CH0g1LBwsGR8NHF0h/XY5WxUII/EbmlMiIiAixMKdyrt8fWLYkqeNAJsxRdGFYIjhHtiXBccHDDIjuhen3cCskAZPf7UGhPWqGzEX3CjuKCM4emN267RCHyxKZnZLuO61MrDixA42lcBaUcagjpBGlaUnTIerLThvzJOdiSy4XcMZSZ5KCb/xB9PtkkOA8a1JE4cAsSmS5o3tvTDM8FCnBAaqaQN8DOKkM9I7DkkcVFxJPSBcDHdFyXW3o2Z8b+DV+Y/t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001)(66574015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LytNS0dQeWpqSUtqeGI3b2t1NTh5VmVlT2xobnhkRER2Wk9ZSW1kOUg2Q2sv?=
 =?utf-8?B?YVBHcWxidzY4UlVEOUhJa0ZNNGwrcnZ1V0ptRi9mcHJDY2pFUkNnUUlockU1?=
 =?utf-8?B?aEZ2V2dQRWo1YlhsR25lM29XdDdkUmpKRi9zRzU3ZEVZTzN4c0lMREJyQWZK?=
 =?utf-8?B?VlNCWFpOYjhWTTVqSEtQY1hDWXoxWnQyT0JIZXdBQVdsc0l6RUR1dEpNQzNp?=
 =?utf-8?B?Q1Zpc01FSHlHOTZqWWs5clgrczhtclpIckFLOTI0ZGRaSDB4N0hkWnFzb2oy?=
 =?utf-8?B?SVBRY1lEZG81MllSVzE2cnBIWC9mUVNCczcwVTd0TDFwSEE3Zis3eWRsZ3Zp?=
 =?utf-8?B?eUhGaHA2cHQ1MFUvQktHbG81THZxSmNxK1JRT3B3d01DUU1Xb3F5dWF1d2Jk?=
 =?utf-8?B?R0dpM0NkeTM4TmJpVTJQSUVzdHZHMUYyenJPZVRkblFzVnRJQXUwcGpVN2Fs?=
 =?utf-8?B?NStYTVBXRWpDZmJIV0VqaGZTckVveXE3aWxybnFSMXZSbE5GdTRQaWkvVUV6?=
 =?utf-8?B?U2hWb3RiODlsV3RPLzdNL1k5MDdZWVEyanMrUFBUc0pKd0RBZXJWaHFWOUlG?=
 =?utf-8?B?MzB5U0RDL1FzNlFBM1VXdzZZOUZXbkM3TzZoeEJPQjBQd0xjRlJia0dISFFn?=
 =?utf-8?B?U2R1MXhaM2YyTWtidVRoVVJPMGwzR3BSR1IvL0NtL2RHN0NRTlJYWGpMVU10?=
 =?utf-8?B?djhxN1UyVCtvRENQQ3FIa3NTZENXOVdLaHJ1WUhwWE1PdGxpcVJNeDYxNC9U?=
 =?utf-8?B?N2h1am56UWt5MXp5bFJPdldQNG5lekg0NzVrVXhwZkFZbEEvV0o4d3ExLzhs?=
 =?utf-8?B?QmFxVGxqZ0FhUnI5VnNWbi9aSWgrSGhZRTlSNkJ6Y2JleTZPbmNXVXp1NEE1?=
 =?utf-8?B?UWdWTmcxT21FK3BxUllMcVRPRENkSGZlM3plaVBvZUpHcnBYODl0MmJLdUUx?=
 =?utf-8?B?SmVOU2pFdEhDMXpwSjdpS3VZS0RhamNRRjVTV0d3RFYxY1dweXFsRElwZnVG?=
 =?utf-8?B?U2pON0h1em1BTFMzK3RiUXVFZDJQa2FSbC84azFna1A0enFxeHI2ZHdrSTdX?=
 =?utf-8?B?WXhJZExkMXFvY2Q0RFlROFZqNnZFcjBmc2EyRkFEOTRYQjlVWWJzaS9rbjVi?=
 =?utf-8?B?MXhuVDNLWVJlREZCMnZwS2lzMW9JV1gxOTU4Ump2ZHhYSm5ZMHBtZTR1Smkv?=
 =?utf-8?B?c1VsK0FFUVRYcGh0QkwrUWVkczQ2TjFTWEp0NHNEZGZuZzF6R0hlN1pzTUVZ?=
 =?utf-8?B?NzNUYWtVU2NVTUFRZlBQcGQ0UjdHbkZPTmhrc0VjVWFHcjQ4SEJwbDh2UHdw?=
 =?utf-8?B?MnNoeDZZUDJEL1V6bHNEL2JESElSQ01yWHZ2TndqT09YYTlzNmFJbnRSR3Nn?=
 =?utf-8?B?TVFZbmppQ2Z6TEpPV25yVUNmOTZ6WUJXR1hocUtSYUxjMHQrdGVKc2daSit2?=
 =?utf-8?B?UnMxdXdCQ3kyaUxqQkRYdmxuNHFCM296cWNIck41UEpUVGxRaW5tMS96WEkx?=
 =?utf-8?B?RlVEOTNERERXZzR2ZnF4VmZYRVVlbkVUdXI4QUNUZDMrU3d1K0VYMlJ3dHVL?=
 =?utf-8?B?cWZRQko4T1d1REpLMHp4VEdXeWVacGJtT3lwRnVDTlRhc2RTck8rWk9ZZUVw?=
 =?utf-8?B?cWIrSngxT05sQnR4M3djVTJ3bmtvcWExMDlsVC9ieGd5azhxRFN2Zlh3b1Jp?=
 =?utf-8?B?clhZRm1sOEFrVmlJVTFhUUMvdXpJSEdsTXdNbk5PNzMwVFptZU9RcEs0S0xM?=
 =?utf-8?B?U2RZem1xTlh5NUVuaGdkMko4MTRZQkNKbHV2WGR4Yng5alBsMkhjb21HVjVL?=
 =?utf-8?B?NU9PM3B1K1ZDcndRZ2NqVXFVaEpTUVpWZzE0NUZnRlhnNnJ0OWlZbnhodzF5?=
 =?utf-8?B?ellHSXpHM2xtY3lPUEEvL0FEWGdsRUNqcVNZWWlhVnFVSjk2L2R5WG83ZDVz?=
 =?utf-8?B?ZG9rdTg3bXJuLzdNanBqSU9kVS8zZWpHTkoyb1UrSm40V3h5SnNqVnFzcjBh?=
 =?utf-8?B?d0ZhQkhqWkI5eUdIMGF1UGR6TDUzSXpSTjRwa0Z6WExjV1BqWXVTRGxMeWVK?=
 =?utf-8?B?S3RMTWhOT3U2STlqT2NxbjM3VXRzOWVld2tEODNJcWxnazN5TE5BMmEyd292?=
 =?utf-8?Q?xs/8wuCfXwMRzDFxDqV9I/gKz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4091b3-856e-4c91-7e81-08db82afe915
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:13:44.6496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BciyjHRJpLHa5vuFCzM08WPHN5NGoox5vGoe9OxnxrTnsHmXLGjD3c8dYavKMYIh1Dp5md4uaSLL2vStBNGcbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/amlogic_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 756b218880a7..a95c8959e5af 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -293,11 +293,11 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int amlogic_thermal_remove(struct platform_device *pdev)
+static void amlogic_thermal_remove(struct platform_device *pdev)
 {
 	struct amlogic_thermal *data = platform_get_drvdata(pdev);
 
-	return amlogic_thermal_disable(data);
+	amlogic_thermal_disable(data);
 }
 
 static int __maybe_unused amlogic_thermal_suspend(struct device *dev)
@@ -324,7 +324,7 @@ static struct platform_driver amlogic_thermal_driver = {
 		.of_match_table = of_amlogic_thermal_match,
 	},
 	.probe	= amlogic_thermal_probe,
-	.remove	= amlogic_thermal_remove,
+	.remove_new = amlogic_thermal_remove,
 };
 
 module_platform_driver(amlogic_thermal_driver);
-- 
2.39.0

