Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94218617C38
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiKCMLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKCMKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:10:37 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2160.outbound.protection.outlook.com [40.92.62.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513495FFC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIOcWcvynZTg7v9DvhPIR+JDKUq7hUN2/wzYwAuz9bRnJ8gzadtjTxIXKMW8qrcVUSUkjQmNqTrBfdoYHJ5PZNbd/xvpF+ufvLOYLBbYLIHaP3J1qIfQq2ar8q/vtnmRDf1dxCVJZl7YFdQkcgWGp4ahNrpHdKXEX9t9dcK9JnmhuX1bbNL+1YBWeQsPqKCbMn3Cm4sbPqCFup3IDOr/fNzKtWc1vxAXy8o991erAsJsS/zq/fKMdqGHCsOCAIDlMV2ncVHWPFYW1PvfN9XADca4Y05A8QcSbNRnD7e1XtFmf09+o2FltMOFUqsDt4vMR/RcelIhmKQP4Wm8QreS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yX3ezV2JvBkM86f//lxDyPUaeQb1gYHJwFXmrV7Hdg=;
 b=UB4ZaYJXtTZAgLzMu9eNJJzIgaf3s/XSUTTwTsT5LLlE1xCcAk/UpApMKNzXghPTzW1SZnCAvmeI8kgLvj7HIq/9rjq54hcPXv+4GuON0uJ1Ty2KoViQUtxy8rWQhp/bvqY0g+dvz1UtG3TelduyrHEpoHCepB+TAFGpMIwIQtI9meKE9slvOuh75QOUmHtxgvFs/Uo4xf2zUavptD0XnLdCZUGoR7p/C5bb/Xtr6wBYCWRJe5SiXTvI1Kwjpv1zEmEaHQLl6b+gIsHJ0gnb0yUKDsMXYVJBgPJWaQTcdjjzZfQzC9g+wJSjWo0S9vK014079LbP7WDbjwS5uc/amQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yX3ezV2JvBkM86f//lxDyPUaeQb1gYHJwFXmrV7Hdg=;
 b=p9TZx8gu2A4zaa3RAsa4AWrZqMbmMgZpf8wRv5eK1AG+QJAHTni+msEhNftSrs17fx5Da3jNJZGGNh54VpYb64IJDLiQnS5Zfa1+mokGA6qegkEuiFTjg6lLWCljNuFqhSgWgq7uinI04sqmLWw+rjYZR8ZJAUG4AXAjlcYG9NftLxmLwJshEfoz12TgGd1FWn790V3uTJQYRr5TdrDUkxfRLQCmu34/zeoGpQAPJfIz/8UykAEVVCD12TGJrxzdJ7+//K7OOHBZc8mAR5ZxI5v3DW4CN2jvtnOo9cbwUpC090sSQBzhLFpc8hYjXC8jaCYFTGtI+YbcahHtJHnpyA==
Received: from MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:172::10)
 by SYBP282MB3043.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 12:10:20 +0000
Received: from MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8e6c:7cd7:be5d:66da]) by MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8e6c:7cd7:be5d:66da%8]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 12:10:20 +0000
From:   johnnyaiai <arafatms@outlook.com>
To:     jgross@suse.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        johnnyaiai <johnnyaiai@tencent.com>
Subject: [PATCH] locking/paravirt: Fix performance regression on core bonded vCPU
Date:   Thu,  3 Nov 2022 20:10:06 +0800
Message-ID: <MEYP282MB4026F6DB1A248E9EE7E8BB99C3389@MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [wok41DQVUGvISiE4Imh1idQppDAbJPFL]
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:172::10)
X-Microsoft-Original-Message-ID: <20221103121006.3389036-1-arafatms@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB4026:EE_|SYBP282MB3043:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbdf7c6-9089-428f-8b85-08dabd9460e0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RY+dSY11aSq2s3rDFALEr32ZCPSQ7ikyKOjLS6N28T9nhvxDi3H/weEZbGeg+Di2KwfbceYOzB54AVJQ9oZrcDUg48j6DXjIvi/exXDTMIZbfRg6kMKHloWLS0z3OGkoS8YG7i+A/CIdDVxlOMBwdvylXC9HlBPJ/GG0hYMeWz59a85lWDWeZmXykotSnSE4mrsl7Eyljx/xVDnogigAgGWdpK6JmhjASCcgdq0haycQqoWHAxQCXVeCTYBL8wrcoQmYg8OhclYaLIljSdrDKqtmr+mtAw4wkV7X92DIPH/BwH8JodbcEf/2bG04HVV1D6fdhDKC/8xE50HrZrAj43jqxX/DCVM5EhkXMSmNmURAIwos3duabG27wxolDVnhVs0gLDZ24CuxSY1DxuGkxd3vXpY9z8hdz1m/Nod15HQSRO/a+NzV2aWTo7DJd4ixhlrB1zbVcv2uC5s6IEcJyx8eVh2Ypo6gmBjGTOI3EKzt5LaF5UJpip4TCYZQehu7UtRNVE9H8X9/PpLuzfpw5wcDsCKtHiG2cippk88TxJ391kE0JdD97eF3hZP5EWtLIN2GSXCXlbtgShzP/HWhbFDelmxAeq53p7DCuSXR9QcK3WY2Ur5f+8a9xuDmL/Dpbm5WTjUZx3ZAG9CxnrfFxA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lgrOFkV0gj3VrJZYMV19kN0lDyRTYEOrMzF+Aq4A+j2O34iAkOEgwu3qfccM?=
 =?us-ascii?Q?ipmMSzH+hp++c7s8Yo5HfI5gGPZWkRIWieE+SgJ4oei8L1i/lr84XOgGFz9w?=
 =?us-ascii?Q?Y7duzALPZ3OcAX+RZC4YYL8k4iYui4FweuKAI8GaskZ25DUHV9p2r4cdlpE6?=
 =?us-ascii?Q?o69WZ5j5ZmRUPN1DKEVMOx2f3aHDyVZqHUQuB+TR2/ar2cRW8kNaQX4SSid3?=
 =?us-ascii?Q?00chuqtniXWIKtg4a4MXYO+3kW/kwnM9H+ntIaxfl2vo4RS30knxNKYjJSjK?=
 =?us-ascii?Q?SdvPsG3oIQyupqs69WQ/Ovj40qrsW5DlKyXkyJJ4PYstuMcXIDiwu74mkC4Q?=
 =?us-ascii?Q?RxZBdElfGGy/xazoxpLcv2IhL1FQ4DihDm37WlfMFqmoS9x4WKMO1cOm38uF?=
 =?us-ascii?Q?2LPW/nNVfp5M+24JwN8mCGpKCkqYWRpAcR5b7YiBSt3sKXZl1GDK009RX1pV?=
 =?us-ascii?Q?A5bF1+54ayUyVrc6KjmaudgAPLf7bwECjJodyHGrqeFS7j6kdgE7a7pNm8C4?=
 =?us-ascii?Q?qnOKDRTM1bTn4jlIlkoFfape77OI7IheRvFs5Rho3YK8TLCXd9yPyFTOl0Dm?=
 =?us-ascii?Q?FVDpEkca1pQYeNF3hWgcmTcBB7moac+zDq83QcufQ0GBsEgh0ABtG39PdaC3?=
 =?us-ascii?Q?zj0pxwqusuqvDNdBmvP2D/KOv2w9q20Sap8LBdsQbT42qb+W6pBwoU89wJR4?=
 =?us-ascii?Q?y8WpC/S+0wIwZa5KbvqVnBXm2mlGL4vBzqi8CXTJOw69G2SAPldoN19dXCip?=
 =?us-ascii?Q?gwTXkEkp19hvzpQGBrTM+/dWyA0d+Mg1CvdRIt0CAKwmKwhgZCfIyszLGupS?=
 =?us-ascii?Q?5a53DLbFtR6ngLEubjJaj3tX6yHhn6wHuek1t27z/DajfEkuZlRqCY3qOCn1?=
 =?us-ascii?Q?HxohMf/iqF6sB0BSmHyg/24PCL/oD945T36815ODfz2Tn4qw3DTP0kZ46GyV?=
 =?us-ascii?Q?FHnzOxn0WYKBsRYHMeIHy9oaJc4RkbKWjXsTk3mPpoqCqab9EY2COItASPh5?=
 =?us-ascii?Q?5DBJ5GISd4E6Z27bMFhdJ1vDsIRjcXCnbP/KUfx3FCtL7ltazH5V/VjsYziL?=
 =?us-ascii?Q?3Rxcql0+KXTJHhKjEdjUTf/A7ueTlWHkSmnCqpogIwKyDnU3sS+Zg688EZbc?=
 =?us-ascii?Q?A8feSKQAz7s0sk0epnqqr/K7Km3M7vwXyofDGh2bB9mtPRltL2QA8DIbkWnq?=
 =?us-ascii?Q?COHgVbB/4ZAVH/Z/vUY3xB8yok60DmdbZ5GcMlW9aeqAz+xyR2c9vqw9qUw3?=
 =?us-ascii?Q?UOcOgL+9/AQ+MK8juV+v2uyaqihh1qEUMM90p74HCg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbdf7c6-9089-428f-8b85-08dabd9460e0
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 12:10:20.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB3043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: johnnyaiai <johnnyaiai@tencent.com>

virt_spin_lock() is preferred over native qspinlock when
vCPU is preempted. But brings a lot of regression while
vCPU is not preempted. Provide a early param 'novirtlock'
to choose would be better.

will-it-scale/lock2_threads -s 10 -t 64
baseline    afterpatch
559938       2166135

Signed-off-by: johnnyaiai <johnnyaiai@tencent.com>
---
 kernel/locking/qspinlock.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 59d3d2763..529cf23fe 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -107,6 +107,13 @@ static unsigned paravirt_patch_jmp(void *insn_buff, const void *target,
 
 DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
+static __init int parse_novirtspin(char *arg)
+{
+	static_branch_disable(&virt_spin_lock_key);
+	return 0;
+}
+early_param("novirtspin", parse_novirtspin);
+
 void __init native_pv_lock_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
-- 
2.27.0

