Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D418617421
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiKCCTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCCTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:19:31 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2158.outbound.protection.outlook.com [40.92.63.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA72E81
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agcA5GtaCmmnf/YuFNSqeNKtapEcZsGrYEUv6p3uBYCfDpmZ9njiqsB4+8a3oAnloYUJP2mu5psiCOwvO9btdceF7V0Eg1uAEi/hy5ZkZ5vi+rr8WnW2bk7JGX0sLqSWAdJWtygjKoQ4nbDo1LOVlXrQSi5uC7y96s7O7Pt0tPvAdfEfMFkcxqJf6XG0u/rmS48B7vWHZoZ8gD0cbrpmwxjrfCwmGouTVqxNJOS3PfyTVZROaFDUI0wTc4s/Em43eh1PZKqAz+tzaVVLNClJ9Ow3qvDpSe/bwYKcTtwxCJFtPROuuuTaHrKVMmZj7IA8sf2oM3jNSJFwySqyzrWujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4zbF4xJ11BqP0i2f8tk+o7TGuST9k/dTH0bwJRGXcA=;
 b=VaAtz4YJ+T/vsm+eQNaXNgkapr4RQ+Xon1NcfmeblrMdxFtTzAm/dVfor/MfCU3bSPjlrTgG6q8eBcO43SRz7b2aNLyg8j1qSVPXBeZvd79HQla1q50kC2IuDJyQq0myGzwJp4Cyx6jcEmJl2Zfky8MDOAGvUq9GCnWjaI6fOWVHSpx2OWxm9e7nS731FbA9q7qRCh40hUEb7hTcsQPxM0+893ljeqv3ASK/wFVYywN6YCOdeFaabry8z6JNDELFdLksUFt8OgqnyusZTImyXf76r+TLcxI7+IMsavolmGSu0XaiuOAWg3/TxeCqviDCN0CFrUCg2d8DZ+WW7SaafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4zbF4xJ11BqP0i2f8tk+o7TGuST9k/dTH0bwJRGXcA=;
 b=S/7wk97XhV0kJSxqYnbzLZydQxNO2goO2mpc9fVIbTbfNQFkV3b0vHDYqJYEPiKH1Od/95ps0NGK0u0BYnm/eCRc8Op4Ntzda1OLExtzbGKYglYFOt2cnMIf4iK1Z2Nwqh7CCbogUe2NSV2NLMkQ/Q5mnipU1NmSeGWSGycKV1guNhO4Sx5L0c6TuK68JyfKFmFcvLMRsLmQ3BUID0kvNozP4Bp53Y/WMkq1H/4VGq004hG96hx4aBKUzyNLEghw7ToGJK368oMyIAxbhjzbee3W5dAS86SN189lp+eFWm7hmcCs1BuLJIdGKTjEGsyUxm7le9DlDmoqWRT+Ia1XYA==
Received: from MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:172::10)
 by SY4P282MB2058.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Thu, 3 Nov
 2022 02:19:26 +0000
Received: from MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8e6c:7cd7:be5d:66da]) by MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8e6c:7cd7:be5d:66da%6]) with mapi id 15.20.5769.021; Thu, 3 Nov 2022
 02:19:26 +0000
From:   johnnyaiai <arafatms@outlook.com>
To:     akpm@linux-foudation.org
Cc:     mcgrof@kernel.org, wuchi.zero@gmail.com, liaohua4@huawei.com,
        linux-kernel@vger.kernel.org, johnnyaiai <johnnyaiai@tencent.com>
Subject: [PATCH] latencytop: Remove clear operations from copy_process
Date:   Thu,  3 Nov 2022 10:18:38 +0800
Message-ID: <MEYP282MB4026EFAAF1DEBD5EE8EBE072C3389@MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [YsMGbl9h/oUSE0UIQEPnU8QUFBXsqQ4Z]
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:172::10)
X-Microsoft-Original-Message-ID: <20221103021838.3153043-1-arafatms@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB4026:EE_|SY4P282MB2058:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca14112-f105-4ade-8c61-08dabd41d46e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWpSf8kDLYdk2lh6rgwtyYorONpJbsrB/Y1jwDgdJ1pIzPdGbQjVwFS4V/bakH7mSkYF4JqzQnhGJhOFpcbRSraO1Z49CcnnpdElsEgI8HKYsHQknyE4ZFaR+BBVs6iIQ0zaaTEiQ3eb33wbJoLWLhBqQOQ1lSlH3xv7QcWoZzqrbdlXH/TpYT+e8A9M1fbvjzoYx0Br0ewE4Rzf6BM8Z44uQMMGyeetHb1gy+dHfr2FCrwCWWhOga6dNljgvKuD/DLl7ZzZZwvnXwqxchS7+mgbdGnPgBdpQFlFSI5jXcC7RxG6fUwKpMZ6rcWBUALTpRlLq9uGaX4D7aM5SnfIL8F8amzjbMkVg8SZg4b2FvLH6txQnKVnX6sVKP+ptG6aqP43JpawsY+9hYBY/f/PBlWqP21oamUBQUqBsjW7l26DMIaaqcfRqaX+vcXahbh594MUWz1LwyS0r1e7gGVcYlvKq+puiLY1PNG9w34g7v/Pn0I1mmC8UwF+/NOk8KiQp/mV9Jo8l3eOOgmS7JSdoLI2OQrE+V7r6S81fJfDk+Ue/p837uP8aJkFIuT6xblP7YTlJHCHzcXmb6s/bBfu1/zfV2SETbAM941HWmWk6H3JRitQ2tcIN+SDy/5gQwsYQ1CYpUuazn+ARBqxx6Zx8w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kv/u4Ey6SlKjFOfFivgZvqwZl9yCahNhj9NlpgQkZRXwthkb1SoUODLB151w?=
 =?us-ascii?Q?wIKcxfH262k2p2357iZa63bOpkdSGC7fxl3X+kcZg3GHNJRLQ04d2t9FufWa?=
 =?us-ascii?Q?MtxxRVFAW/V4giy3KO+/WY17WtfGhQkYnpXWYNI847UvOUC9hhTZza9mMQxs?=
 =?us-ascii?Q?imFR7flmW/f1ilIxIiyGrootffAk03p5vMJq0NAkmpcFs1fCIMLzy08fwqJg?=
 =?us-ascii?Q?iK8ZKu58K0PuK8jNEY6NLMZgu5wE0kSqr4XsvYhhl7m0baQYHkwHrYtJiTDy?=
 =?us-ascii?Q?/eg0GtqcW0/TGcqbZNpVK/pE+NuBUVsT4cy3u72VI7zEvoxZ0vEeD9DMWFkd?=
 =?us-ascii?Q?9rH/rlGXrQPBKENy5QbNJ/tYI32HhISraC0lb+qxZk2f466vqvNecjR8rJ2W?=
 =?us-ascii?Q?Tog4492mjf6TfuiRVIZwT9ALJ5Xz0VsBmxNmgo3zhrrYe8GISb03DkQVMkom?=
 =?us-ascii?Q?WRpJFBbWfybVXRNNffvo4VdPdgDqhzp5yO9XWpCnd8FvGq+kuOUdCiV9GHtb?=
 =?us-ascii?Q?KnMSU7S7UTDs/92B+SisUmuReojT9Iue1EL+BGMc9RNdppf/0UeAcwUrwqN1?=
 =?us-ascii?Q?Jz4PlDmzZMjyM9Ft8+RyfpuQBuPPzZjcXhWdLcIova85c3SJn3/1msxjnKkk?=
 =?us-ascii?Q?4WOa9d7CWxuQ2XhV1SQ/eBkutbpskgOuzRHunodjAEpGx4VsH45K3bRGOOYc?=
 =?us-ascii?Q?eH+m/2QrTnULm1n+jgEInIW9JzJyh/5nsFLrzxWv2c40n7chhZ9Mp0zER4O3?=
 =?us-ascii?Q?Uh5iwBOrKwmOshNc32KRWnr2+mrweX4Ke3HfLUNBmfOm36lq1tzPUao/b3Et?=
 =?us-ascii?Q?qtZUKE/R1IlETntJMhfkuFjZJ3YHto4PJQH81Y19d5UhZUGa8Xw5ADGlI+0/?=
 =?us-ascii?Q?/JIuTUEps6AnRGWXEUc6fc60SCir2t3vvhUGWmqSeRZW0DB0jLi3P7FWWLUa?=
 =?us-ascii?Q?zwwCOAEK4kuSPNDjYCtZ4+IWqNzSgWz9shjREjx6nBL54IMJK/fPQd5/Q/XM?=
 =?us-ascii?Q?BlZBekGJjwteYas8x3JeZfgypV6C0sGYeINUFz/nNgk3sn9eszua7NYwjm2t?=
 =?us-ascii?Q?PXsO3fHnQWWZXyOd+o8eEuuM1odjqw8PQso8nO5kh2fu01GuXQugUeir9s2G?=
 =?us-ascii?Q?EstLiPAhlr1kHMObw4mnRD2CQLscoTtLJmY+sSdjByMLZcAfwPUkwmgV97qp?=
 =?us-ascii?Q?Jqnp/HoBDLwPNAKhe7j079yA/X/g3PJOH5BMjZXYz+Qfr13dJIVbUIMDn8oT?=
 =?us-ascii?Q?zXcovqvNL8dbF2igNpwSVDp6rcIO8mKh6I9GlTqqcA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca14112-f105-4ade-8c61-08dabd41d46e
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 02:19:26.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB2058
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

clear_tsk_latency_tracing will called wheather latencytop_enabled
set or not. this bring unnecessary overhead.

Signed-off-by: johnnyaiai <johnnyaiai@tencent.com>
---
 kernel/latencytop.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index e3acead00..daa65b313 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -63,14 +63,15 @@ static struct latency_record latency_record[MAXLR];
 
 int latencytop_enabled;
 
-void clear_tsk_latency_tracing(struct task_struct *p)
+static void _clear_tsk_latency_tracing(struct task_struct *p)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&latency_lock, flags);
 	memset(&p->latency_record, 0, sizeof(p->latency_record));
 	p->latency_record_count = 0;
-	raw_spin_unlock_irqrestore(&latency_lock, flags);
+}
+
+void clear_tsk_latency_tracing(struct task_struct *p)
+{
+	p->latency_record_count = LT_SAVECOUNT + 1;
 }
 
 static void clear_global_latency_tracing(void)
@@ -172,6 +173,9 @@ __account_scheduler_latency(struct task_struct *tsk, int usecs, int inter)
 
 	raw_spin_lock_irqsave(&latency_lock, flags);
 
+	if (unlikely(tsk->latency_record_count == (LT_SAVECOUNT + 1)))
+		_clear_tsk_latency_tracing(tsk);
+
 	account_global_scheduler_latency(tsk, &lat);
 
 	for (i = 0; i < tsk->latency_record_count; i++) {
-- 
2.27.0

