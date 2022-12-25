Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B62655D45
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 14:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiLYNII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 08:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiLYNIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 08:08:06 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2097.outbound.protection.outlook.com [40.92.42.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14E12AE1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 05:08:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrERy4yRZL+rrbLbnMMBzg5Gy8XZGOWqGv9RQB+1Og36FCjfXlrbL8QzhUbIkZkYO2Ko47Sxgycz+31i8nxFXI4TZaISMLXon+yrmAO2jlaikV01TaJ9BtUTCyyQ+kbU3rp0yuI8dfG2NdcP5AY5/qieonEk7dEdDIf/R1NeowBUjRbiBVA7Te7ukQvGivmEo/Lu+T0OEnjNZXYXPDRp4db6sIecENCVYEm7+zeEjbGkiOReLQ0GlOLN4dTUdXVfSzCU5Pi5jsEY0tU7nIiuG8REuFkTp+8eZAhMOMie/Dyz9/5ChBIAezTdde2LtW5L3G3kB1s5acjeACc50yg0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i70PE5ROE0KJsfZfo5FuB+kRnETSKd9aAspN0WEqVJ8=;
 b=XFQByTYN23qS/Rg9SIzDNymADHgXW8lKrXy7WIlFq05VAy8gzPxNa8iu8dNCjJ1PWnxbciZpr9C/iomOprFuPhjSkgVHQpTxLm33qVKxdTE+KMMbtILGjUGt85dge/r0czN1qdYG66+v606bBO4WQqs6W+HiodWh4m6ZhQFYogjdzEZUYP0V7ujdYbdqZknbNqjGfTE0yPOXw6Bg9zVvvHzDdsRZ+wvU/eSHLRP9FMmviVZdvCOVGuo3cacGTrbuYm++mHSot4wWhyVSE4FXJuiUrFfJhR2O8TSgz/Kpe00KmedBsmN0XkOhMIfnATGACla1CeVQ+LDG/jqm3jbL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i70PE5ROE0KJsfZfo5FuB+kRnETSKd9aAspN0WEqVJ8=;
 b=HWsY8uNjl4f7ggF9ajm/f2yPGyYTsgWpplhSnIkQTyCmBpvXJb/Mw4KyPK+16gjiquyo1MD1ORrvYJpJD1XILp6RRuWYxCmdHc3K57z6/90mpOviNmDrnOkE8X4xCP5g1YLYLu1iRX8nqPW7nKiYMCn+LOl+L32GJZAcx8v3IBjlW1iGzYgu3JCJcrsCMtL0W5hRcuLWWb4IClX9BpWrtM+9Cpcq9u5rtm/z1gU+GtVaYmu9H1e1EaIgQOkklCDghxQwgNEB4YEnlhXUce6G56jAQ+9Q6W/rtMa1MfE2CBqljWk7zhh3ORJXuS5HQ/N84eadls37yv4GEiTF+FXWhQ==
Received: from PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:e8::5) by
 BL1P220MB0804.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:39f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.12; Sun, 25 Dec 2022 13:08:00 +0000
Received: from PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM
 ([fe80::4699:74fd:8699:27b8]) by PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM
 ([fe80::4699:74fd:8699:27b8%4]) with mapi id 15.20.5944.016; Sun, 25 Dec 2022
 13:07:59 +0000
Date:   Sun, 25 Dec 2022 15:07:53 +0200
From:   Roi L <roeilev321_@outlook.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86: kvm: Fixed a pointer coding style issue
Message-ID: <PH0P220MB046007160DEDD6FFA11E4F52DDEF9@PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [LOozkymh4Au2in4LWTOTpCdILA8MtVZc]
X-ClientProxiedBy: AS4PR09CA0010.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::14) To PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:e8::5)
X-Microsoft-Original-Message-ID: <Y6hLKWrM2Y0efFMI@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0P220MB0460:EE_|BL1P220MB0804:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3db8c7-b1ae-4e53-99a5-08dae6790c0f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDucLC+VYonqH5jFHWgWXDp4j7QWaz9OgfkBgb/Pj9E7IeeEnDo7DaMzy18JPHPQLemfXmLDj43zBlSXppCGbQNkdD+H94hr99PAAGv9Q2iSvf1LYKrwnMGvWMl5bvIoF9K9BS58h5x1n4ImAKaCoUu7QX2aGZPZgw4aNKTlR0cNbvciU8M9bDq6i8o/R7KgsVDxDLPaCsczmcsULCqIMiCoIg+tRYBmf7XGAKMAfqqVY+5B0b1RbAk9X/JZt76WkLJB+MpiwzURKGpRaRhlZ/7TvEpFmsVAkX4XK6VF1XoSzwbCn5KivsrrVX5sLUqYK0bbXITM8z+x/wtlYtOtuyvnKpw9cfKalBBFetum+nhbnaqQxPiQW0SuDDsJe7yBAVOp2hWxAaeFXb+AvgtIEMX/gIWtxnaSjTVKkh/RzH6mw8+CXMvR7e8+/7w9KGXK02l9Z7rdzkKneaSJM6plNWgmFPZEdUogOh2euRZhpR4+C/7o4ZdNhBKHzowmvxLXD58BCMQl2ED9lcfIpEr0JtenffJLXspaq43fEjABrrTLIaMP2rVAYiERXLRyliNZD7Td7WCHk4Ekr+Zo9oZBCZfp6HM1eKth+sptANkZySc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6iz5NIpyPWi2k6xPJIHxIP/NfBxGNrTs8YAIuax3z4RzjF47T4C7ynYl1/FX?=
 =?us-ascii?Q?Zq+c9FNTGZnHLhf1FxKZpM9Ccf/4vrhb08JrT0lF6x1wU5nQVgtDay3wUv7X?=
 =?us-ascii?Q?zEZFP96ts5io/ywthN5PDEIdlMSBY4cDskfmy1FqAcfq3AbOLaxg6eQE3EnP?=
 =?us-ascii?Q?U6vWr9q5bv15i4c2XgoMXKSKeFamopJEbGaYkXR9UhK8YzzfoAsezURiXlmK?=
 =?us-ascii?Q?IA9Rzg3ZaSzOGf9Xb6J9XLSv4WkcGDWe/LWJTE6BI7wTlz4bEPsUo3EZeyq0?=
 =?us-ascii?Q?iKXDUrB3/YL3XT8NtfcGUyfeofaxG4ZJgtHVic3fqGh16rwosV1Ph/Ze3KrH?=
 =?us-ascii?Q?ARh3kgoU4GV96mPm7d8sPZIOmjiEyxFJPrM2UGAsbKh9gFgCSqYnYfzzQCgN?=
 =?us-ascii?Q?Cop7V3cVFw0UBhZ2l12RCDsbQVsye6jOJSA2Q0iYyI26h8pTZHzCgQz/HLoc?=
 =?us-ascii?Q?w7fKEJGCIQ4lcwt32EuvcqwWYKg9iBL2ZGvZKNwf75bZ0UWRIX/unFJCPkHf?=
 =?us-ascii?Q?Ta2IAiyXE/nXONTVOazfPRIQiukstYjxHYtaMFANlQG6hxvD3kzMXkvGoNtN?=
 =?us-ascii?Q?K0Wyp8RaUV4LYXTr1r8NF2s4Mq4QK1WRiebBdH2cJolk/n9VmCOOARIS1Jdt?=
 =?us-ascii?Q?q1TxzVYhmcgv8QRSIZb17NXtRovoSjrT/6mjDbfyRyzbA98GPMsOsm5kYbDR?=
 =?us-ascii?Q?tSGv7wNQAAtNBUBve1mRy1q7Y070yZj2n3q/kd+q8oZx6ilA6O6GUDNsSiv9?=
 =?us-ascii?Q?h2geiZ7T1gZ54rD1JY8bV5lsfNyt+8pkXPpALHZ2AihmXBBPDeVsbQDy89a0?=
 =?us-ascii?Q?a0vQyGpGMVtmrEc+PMQ1EwdDDqFqqUfN1QTEGTgz5hl1eIMA85BnFP0vOtm7?=
 =?us-ascii?Q?hI+X991gUvTrUutnuwvoaCJ/z+6CyP6g9LwHDgQPLIvoQVM7rXLk2kDFDlf4?=
 =?us-ascii?Q?T06xhAHzaFqUJDdEt7X8zUlwmAE3pBmthGNTd6gvJR68Cbf6+qQAqAMBFO55?=
 =?us-ascii?Q?lccdNi05FXUAmhQKIpll5PTVdXArtsulciYUJeQMX7iUSdmFJPfu0hKRMhzi?=
 =?us-ascii?Q?jXszklGCmRqWnMJJQh6N30hpbv5Lv7ou6vWtzk666oQMf3VjRybQzxpPtIJW?=
 =?us-ascii?Q?4nbVCWAQSDnZiF1UHUEN9B0bRluBMrRCwfpsnQGTI+Vjcvpa2CgNfTxdn5vM?=
 =?us-ascii?Q?iy98sToGEaTuGaeu9XrONHldjrNHjHAKTBxtzjGxPsSJq0/8xZYEXNiW3nmH?=
 =?us-ascii?Q?nTyc0Mf2AHrOnP50d9UqODCyoqLS142/Hj7fXkmquw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3db8c7-b1ae-4e53-99a5-08dae6790c0f
X-MS-Exchange-CrossTenant-AuthSource: PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 13:07:59.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1P220MB0804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a pointer coding style issue.

Signed-off-by: Roi L <roeilev321_@outlook.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 312aea1854ae..6a10a4c79361 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12199,7 +12199,7 @@ void kvm_arch_sync_events(struct kvm *kvm)
  * address, i.e. its accessibility is not guaranteed, and must be
  * accessed via __copy_{to,from}_user().
  */
-void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
+void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				      u32 size)
 {
 	int i, r;
-- 
2.34.1

