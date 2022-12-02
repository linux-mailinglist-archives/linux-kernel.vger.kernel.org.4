Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9036406B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiLBMWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiLBMWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:22:37 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2055.outbound.protection.outlook.com [40.92.52.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3B725D;
        Fri,  2 Dec 2022 04:22:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKiQ07o/gz/RRCKUfsW4BK1XCzsDTbZxzdrwP6oh4OKa/sOR96Fr2UGlygQsJeVQnPQYOeMw5ChXmI02bX3XjOnkGqqp13lElq2whn17u9txpwdDqYFl678MxYEAI0Z6hEPne93UNO9WEyL816EEijsFbMcc7S9wEj2YydwnRqa21rB7lUI1g5H3N2ON6ulkG+t0Tgr04C9m6PcNrz5YGH2yJInra0vjPqJAifYeJNurKesb63DT9+Kh592B+vAXMGa1h3mCThXE/T9gxNJgwg769zblW7/gPjHXI1QGPcZmOzbW0z3YRCnT0VIq6DxzA75zlemkzZsaGDPf8JZ6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WqgbUK4y3F2PeihNirmZKZ8VKhipAeDycKft22Sl6I=;
 b=VxIpXrZhA+TSO4tdxPbkIdyZVl7gpIO8E4X1rwPkZdDU7Yj7YygV9jmcNmf1gzestaHmN11+vZc1m5WSR1rg6NyrK10g18lvgHDAOv6Jcno0V3vVPYKWTc0EoZ5wU3afUpb2YbDsToe2Jr4RG2w8G+e2bbK4ijohKyLjmD+/E0yv1u91jCaDAVpK1tAPNogNAP2L6LJhwYBk2i7eEUlKyFCBYMer0SSqu4wAOwf0Hre0VfJ8IhgX4VoTqLfnOn3Qi/jLtHtf8hlFx33ZSxXQQg2TVDmUGgPRFGWoj6Y73S3Agiq3UPlY6COB9UDN91ee/34ApcCmK4sZ4AJWcheEHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WqgbUK4y3F2PeihNirmZKZ8VKhipAeDycKft22Sl6I=;
 b=Z1jUktNMjtWx91k00rgjsItP5HDuEsqADaINaVwWRgBhyRv555rrnuFUEh2ZIR/Kz+DW6IE/58POvoFnFv+l31Mj8vf3rbJuOHqTDPmw8VrmbOFRPYm5vkMc8/w6U+wLOrSqeCgMFmNSH/0KqPTjOKceZ1YvP5K41X1a3bkfKNePkyL1Kqg4yB0dbefeNYvP4P6DGaYZFwwkgqi9+tFflI3n605yU9B9rRcRFGddzTN1YZYJ3I2WQQC+KSqQtcOYP7JCGPsauQ0dAwia2ljRgbKKrT71NVk1p0bDAQBFSg8aOsaOlyrCLxPUD+5BY0z6TIB5UKkDoobYMV4FVycc7g==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by SI2PR01MB4177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1a8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 12:22:30 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::483e:25f7:b655:9528]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::483e:25f7:b655:9528%6]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 12:22:30 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fixed a typo in bootconfig.rst
Date:   Fri,  2 Dec 2022 17:52:03 +0530
Message-ID: <HK0PR01MB2801DA243B726141A97FE92EF8179@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [koO9s4oCpu2uDj7W1SoYwMckAFvfKXh+Bgfu0nq2R2vU1lGftbbLjidYkfCxEmogU6S9uycLyGo=]
X-ClientProxiedBy: PN3PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::10) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20221202122203.7219-1-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK0PR01MB2801:EE_|SI2PR01MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1cedd2-a788-4366-f322-08dad45fe13a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l14s3v+HFpbrbMc1a2rEfEYpynndN6sDdEauSokdLGuQwdltbgYpJJ76tI4FDd7K6JH/okFN/mEA4euNflC/RdK4LeJqOkrH4ZqD5GWLmMvVDKXCcd3GB2B+1XSGh3OFxJtxLtf4IaUdE6qR1TrWPjRP79zKElZeR4NNytWR5W/fZTNxtlq8zLrXa6BFI5rvduWlcTVWriZVVGb9hcrXpyMUchFZ+HxUKGC/+8eocvm2ifZSTVPwi1jE1U72Wese6btygwQx3v1DX32HRCwK+eiC1DHyhm7cV8qsInl8cflp1HHh2Xk/vvYdGVUG+oprV4ze7vXTYHtvzYsmd/UxrLr8kpF0983WaBTu60chN2ljM2Re/mglecn69ttUBH+ycGnSV+uqcA2NprKwwa6JKgIpH0i3iezxDa7Vi+PgoQ72lf33aool6VdRPUOLUHVz9iPAOaREfbTLM/tjusFLpTt5zAAMeSO8RItQ4JjCE+bYpnVp8qe9DSwskEWegupfwkibO/Si6u0TTZ0VXKrbLrhotrdLoYAPNzkvP21ykU/4Z+3Y6Y+CuayBwdze7DFXR2c1Wz3i8P3VsvzOqcMaZmLmPT/5lcXg0OgL4seNeiY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNHlY/FvcJR6sj9y1fXEjX/c5oOtq2Ns0VVVPA7/wegtnWxETZvXwHgjqr43?=
 =?us-ascii?Q?AeEzOJ8gaOJdiHxom+vIILqwpd0tYG9mdFcmrw+NFP5c+6PbMMV28yiuafnb?=
 =?us-ascii?Q?E5ZlXnwn+CM6iKpAkmdEQCjLc8sFRjZVyCsP225FtsZvZWfDfLDl1fgQhAhJ?=
 =?us-ascii?Q?DrZ3pJVUJkRQlmbg4Mz3PhSsRJVjNc9VTIeGcuzuVcqNpG18LjD9z+CevaZL?=
 =?us-ascii?Q?/yKefbG49+zMFZ57iHAbV1SFPLoc5AEm1fq3qrxbpNsR7K8iTa0Csei56gIK?=
 =?us-ascii?Q?NCyQqDuqlUiORXMo+O0n8tf2/4U7mUZ6Hls8I2d8yRAzRFXyGF9qplNX5ajW?=
 =?us-ascii?Q?Nn2G+7biBQ+OstDpDBupdYfe3xe3sw2NeQhZFGA1csS9Wv6AlCI6aYVr/4sI?=
 =?us-ascii?Q?UyMoWcCxVzxpbLdgwTuYZj17rcuNsnOn9pQ0V7JYg/Nf/+1PzXwFGDJWLiGy?=
 =?us-ascii?Q?1GPvhjzhJryt3A7XgxnKRlP8koFKFBAQAEUWuxhiNrt9N+6AulAcDjviO++y?=
 =?us-ascii?Q?sIrPOrZk6wNKHsQR5o/asaESVmfw1XBIdW5cQuokEat3y24htqkX46CIe3DK?=
 =?us-ascii?Q?gCiALJEPtcszLykdTa4aUkLNTlVp1ijEMIQKbN5BKVbBbyYhYyUO17SD0vJb?=
 =?us-ascii?Q?UHsyIe03dYkXSH+Tze5IH2Qe6G7wyv2Wd6FAP3vvAyklzKI1dNRBTTKw9l69?=
 =?us-ascii?Q?kd+9+0jHwpytJSBSVl7Pf0022IpnhcSpnfD1mxwzNyPf5OhnAlmj5nPJWVyK?=
 =?us-ascii?Q?3rUZcMkIfZj6xVM6zd0u4R9xefN2amwedWdqC9mk/Y9KACIj3W9Ijplfm+mC?=
 =?us-ascii?Q?JjDhjC1TN2FFDvCuw5moER5cAmmaI99y7puzXMG5a/LEGtf1UVDwEC+rQkZy?=
 =?us-ascii?Q?kV7G/GFCopzhX5IQD53uoT/X290fuLa6JHwdCKgZL/MYH3kkAYbXrvWTrkUS?=
 =?us-ascii?Q?NleZDcSrU0eADLrI2LbSAFZG+dU72PTM4PDTWJXUjtsOehPlPMsqrQkSdxN4?=
 =?us-ascii?Q?+P/BG1zGpWUhYYzY7cIlllO9mqDy/1IhUh89eT/aQT/s0jOWxFax1SNf7IPu?=
 =?us-ascii?Q?y3Ml6jQhw/Q4CqLwDQQ/6MyqTw+f7S7oj/d73VAWeVR6y+HCYy7NF20pEHpH?=
 =?us-ascii?Q?6aKZycvYF5IsRZhnle0OTjal7RExWgXTTm53nGiZxlvlHKGDrek1xCtMK5UO?=
 =?us-ascii?Q?vcvfcyLBcAWWne/S2w+6HSQAJYeVV7l04DEaZQtRtfOJkU0p9TVIrxD9JYIJ?=
 =?us-ascii?Q?/qtXwAlQ/1R2kNIU3kSku9q9+FfcCtHRaWWTvWlI0QxBBG++E6UAU0gMKURZ?=
 =?us-ascii?Q?5X1Ge9EilMVoIA0dGhErvWlrOHZlrXQ6L9IzolOvf/Y8UizIwKmzIRliOZyx?=
 =?us-ascii?Q?JJQ/Ppc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1cedd2-a788-4366-f322-08dad45fe13a
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 12:22:30.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4177
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a typo in the word 'concatenated'.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 Documentation/admin-guide/bootconfig.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index d99994345d41..9355c525fbe0 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -229,7 +229,7 @@ In addition to the kernel command line, the boot config can be used for
 passing the kernel parameters. All the key-value pairs under ``kernel``
 key will be passed to kernel cmdline directly. Moreover, the key-value
 pairs under ``init`` will be passed to init process via the cmdline.
-The parameters are concatinated with user-given kernel cmdline string
+The parameters are concatenated with user-given kernel cmdline string
 as the following order, so that the command line parameter can override
 bootconfig parameters (this depends on how the subsystem handles parameters
 but in general, earlier parameter will be overwritten by later one.)::
-- 
2.38.1

