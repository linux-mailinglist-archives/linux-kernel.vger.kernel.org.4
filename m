Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FED617C40
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiKCMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKCMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:13:37 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2150.outbound.protection.outlook.com [40.92.62.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A0C103B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLAEh8vq3SnzS6IUUoag8PPFtSjXm4N0dI5ZfkbjLEmuGb9nDPxRkxCz/ZNqwCQyopbemawv+s36LL2PaL0stBA6KdlALgdMlKMAbHRmiOnDQNjyZeZtgbgR7j+GuVdCSOf1hhM3M0xpmM0NOFYsTKbru2jbnp3lFFdWJAtbUfXe2/0W1UnLbB6s0O/wJLE1wzHUBYywG13Ky3SWXkn72hsKxu8iJQyTza9zbMgWfuyxmYWL3SKr9eaNI+jNC6EuTYeqiANSzJAeuprfyT5O50/0GzO/zdOQ2NzfMqzk06FAtzMRjEL04y9qKN4wNAUCGaPOA+QwY5gUr9uUwr7ecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPC8DSSjzaUDc1d0LQe3616OCJpMBf721vuenp4E/bs=;
 b=nhaB1ojwpO+wxllEwXx57Z5WvoVb7W8i/F/0qAsy6DssjIqJrZiDzDGcM0C+Y2VASD6e7MWk6pK97vrPHNjwcSZ4nXonbqi8i9VIggoIqvs73kCExlTxZPkdJMVKSUXhOsD1b9UtAD09B9+8u+KXCnLjetY4boXjTfdvjdSbM7qsZJElAYIpv03hvKu9s7CLwmoiTs+P1m/hhrcv6B4iWlRScV5z5rysOsPjOGNNKNy8iH37HsIgCqz8SfRCYVhShdkeQ6LNm3aV58cka3PHh0IMBTYPGvGmfyorXVZGveJn8xo6x86cunRbHpyQ1r0eirXA2r99lAQz6sTYWtm8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPC8DSSjzaUDc1d0LQe3616OCJpMBf721vuenp4E/bs=;
 b=Ko0+XaoCy44ADQ0VLIQsi6P1Rp4+oSKJ3akAyg724xGJRb1gkJzlpW0XzKFxHkt7ohq5FJvsOz+I6Neuf+0eYkBu9m7EnWswU9z3yZXSDBQfBmXWNCMaX1zY+nLYay/3FiYpwMfSUkC9ojPv/S6bMceF4DM2kI7jQqQSy6F4QL7W62lSVR9dWSE/14rhKmfq1SsBYhDeeI92qk6IrZ9BYI/oA+PXyAvBYfYlJfPZS2I1zWPbBRH/6UPmvQSFhYrs++goF0udy1/lUXwaGyBCYWmNZH+yWG/iPeH/Ej9+QlEkmaWTcNneynnjuzbUTjb0QpeYASDuo1tNE6X2oovYNw==
Received: from MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:172::10)
 by ME3P282MB1587.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 12:13:32 +0000
Received: from MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8e6c:7cd7:be5d:66da]) by MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8e6c:7cd7:be5d:66da%8]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 12:13:32 +0000
From:   johnnyaiai <arafatms@outlook.com>
To:     jgross@suse.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        johnnyaiai <johnnyaiai@tencent.com>
Subject: [PATCH] locking/paravirt: Fix performance regression on core bonded vCPU
Date:   Thu,  3 Nov 2022 20:13:19 +0800
Message-ID: <MEYP282MB402614DB5A4625255B689F06C3389@MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [eVk9YxkbenbI9qG9HEKGEWSKQTydVAZ5]
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:172::10)
X-Microsoft-Original-Message-ID: <20221103121319.3390542-1-arafatms@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB4026:EE_|ME3P282MB1587:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa08f63-312d-4773-eef4-08dabd94d2f7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpGjtO34Z5sByMYWxnXhck/TgnghaaqlSrakbim+CTG+LJtmKkA+jQuDonX6cEouYLNY69jYa3mI3c/n6bl/CZiCcwePXL7jT9AsVTLt0jmeaJySXpxcd6TI3LS+LKs3YA/v+sQnqBu6cwb5VF9+bDmHOTth18zUwRnJkSlvcCGoB5tp18e6p284p58XqsNOjK2woSq5CVafmBJb4MG2zhdzMlyp9crmzUQ2mursqtulAxsgbh42eL1rGLYOyag4Swqj2Qkfi7KIhS21/z8YF6BEGvvTDkXleRDHVCtUpONcQBnoo5iLXtXum3gXkOAsRseo/wQ7NP3Js/kZgkWFf1Nowdi3yUqNdRBbie8O3OC9Vyis7Iv9kf8KHWuUTFeg5eY4vyi8RJmFuGW2KAnCeCmKORirnqKxVuax+4oYeccaj7P9jOnjF5KJ2BfLLB430iFqnxQv/oxjBsXEZXixW1HzkjlRc35D+T/CjpwhpAdei4T3xJls142yHU2i2lV6pl71xisUt3M5TIce/JwjCq8AYCPuKg9gaaz3SaVZawoTTgBixpgttDr5B+hjX5grim8Dieixdl+9NUHMw6ZeWJehG4WOS8ens1GlUX9fsNhZxFdGiXmEz3wgQOLEI+deDWAzb5awwxBOuLA01QYx4g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GOr9jNWEE3xIPdHnormDGq19ZMjIgVSqno5LYT3TDvx9t2FLYzOK7EBx1Obt?=
 =?us-ascii?Q?6K4ll9S7GbU3a5lDpLl7U/QWGrcVpPz8Np6/Dq05i0Db2LOnuQYFEcOUESbs?=
 =?us-ascii?Q?4eEa3CSp/PGMAk6MoWULX6UPNCZgRnd1rI6PqL8gjVClTKaFBWCaB15xF+gj?=
 =?us-ascii?Q?6JAi7kMc1o7jMx1DRd3/fYADmTD5tewQI9u5Vqop6z0lkuLUkP8iZlBV0GT6?=
 =?us-ascii?Q?4ZS/SHGF03kQViU3Ky10LCsZJ+9hPU732nk4GBSkQWI2BwNmNwk8R9JuXznk?=
 =?us-ascii?Q?GLMAvksyi+HtE3Y9HnHE7h/422RBXDgyq6lPFLOJ+PdUp/FPSxjAzn9KJZTZ?=
 =?us-ascii?Q?XbdIzSBvTHQuUoCVmqudubTfyKHiNteYq70SprJvdFaHC+7uHxMvNgl0Oz8Z?=
 =?us-ascii?Q?0NKuZ64y9z2hoYzkc84zsZobOOdGX3mVKk4GCmEcgPEfqJ/fJdQLa/2ER1tR?=
 =?us-ascii?Q?thmYvfWD9/utMyJ+Yz1bE6nFfUb70pL+AA5UVmsZguZxNGeX3gSAjVKZpQEf?=
 =?us-ascii?Q?MK6zkCfPO8s40hx65P1Qs1IzIV5+xY72QQfc3Xkj5FZaHB19sODYcYmMCdpE?=
 =?us-ascii?Q?5/+HMw/8lwH3AQxOkxhHaI106ZEHdCuMi3PDaqmxqFvDbHCCxWvqmRl0smQ7?=
 =?us-ascii?Q?7WhCYqzQy+98wxTr+45VUJmemc/+rIFMj4Kqv8BkYmIP/OMQunJeYKzQTNNm?=
 =?us-ascii?Q?fdQjNfwp5a1coJeatKtFv9Jsa4oibDRslOI+oCeaMNNH8M3CDHhe3ey27o2z?=
 =?us-ascii?Q?ausJw1bscYP719N3h4iz6Qp2/GtYiKFnqFmSt1+d/nb9pv1jpl6CydHZjSRx?=
 =?us-ascii?Q?MqdY5Amo+RXaRj3vDECz4nYR2BYYUlo2XuGBUwX/+TJpspISYDsOeOrVVXd+?=
 =?us-ascii?Q?iI4wN0otiz94XUlher6W9VRGsvc5N3mbpvdKCvvlpfZy+EEzahGoJsaSltIm?=
 =?us-ascii?Q?1scjBgpBYsbfFNa9BGtWeZHj1EqIDW9CIobD5+6xvXewBNZ+TWSQq37XfxRi?=
 =?us-ascii?Q?Q9ngjmOkCichJD5K5UlKn/IaS9RmLU3XcUc2vuypynfctDVYdP7gkx/y0i4A?=
 =?us-ascii?Q?7JHHySHa0R6ZoweTrDLwbGVq+taLVE39vGN/No1E0kIE39EcVfOVpPNdHa4o?=
 =?us-ascii?Q?JBeV6QTfPe3lLLgi6rMfcvZiW+swGjrmI8XzxQ3LKCSH7dNr5B8fcLik3g2L?=
 =?us-ascii?Q?qCH2do6AsOnjsZs/WaERIVomKwRzY2+oOFU8TELJS/rnsPfSTYARu9iXOkAq?=
 =?us-ascii?Q?q+wZM2lk9v70KMybv719W8E2f+GBoZwZC03HVRizYQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa08f63-312d-4773-eef4-08dabd94d2f7
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 12:13:32.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1587
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/kernel/paravirt.c | 7 +++++++
 1 file changed, 7 insertions(+)

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

