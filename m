Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5636FA1BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjEHH7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjEHH6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:58:54 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8FF93E2;
        Mon,  8 May 2023 00:58:52 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3487QqkI011998;
        Mon, 8 May 2023 00:58:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=+B5ag8dFVtpwN0SZ5SqpLzscY+yNxQ9wFCU0/rDw4tQ=;
 b=jwjuiN6tKGg8BfmFubTD1l47CWirLDMNf1Igp5nlckO/+1X6I0fxqJIclzONcjNpzk5G
 s/q7Iw/0Nlt5LocmrNXQJsUvgS7YDyQWfSZbNewyjPUHrmTxPxVzJq+SZ2YfYThAhK81
 Zhrb8ue7ALCHp4ZOxu+Soz6vIuNNqMEzCTCF3Sn8HFnPjp5A2+RsBZ6QPqhBNHsllGtC
 EAaG19Ygmr617eCYkn4VeoaKK9v1GiPDUVbm/iusjEcI9UwubNzxA2KYh013Y+l6WLNb
 f7lo+BuVWRFDWEA3cdH1PJpQss01cB7RfMRU0knFqNcpR3iY93eLi3BhiKRMszxXQEkL Zg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qdpe43n4a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 00:58:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5F6/ZHmIlUXPXJp0/Fd279R/5JHAbwTMnoSgTI2j3IRVlNu8Waac9yPZHtP33SpLCa4e8dJiaU9Bggu/YG9xOe4D+2/3u28yqGvwgHakfWUfn8Y02i42dJV1CIcTL6cbT9BsVy5zZ7OUGJrFXsIc4kCGIxhvfGPwQ8qg7q0poU+LHM5l7mM6nnvZ+i3bQtH5b2BKZPrmXfPw9wOl45dWH5ZGIxeMgdJJVhnIxFwVqBRVl+tQ4Ahf+QZdbvpYXNLpdNcFwurAwC53+kwYN8hB25ZK793slIJxyczeqR+vqY5LcW5uaiPu8wZh2VvUrIvH+YdRAJiqx1BAseAlQbh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+B5ag8dFVtpwN0SZ5SqpLzscY+yNxQ9wFCU0/rDw4tQ=;
 b=CML4ENGtPbpT5YGnJ3WO0VvoHx9Ccy604N22HMXCj5KWIobLwKXJLtaBHe07rA9oocsgjKyAHghYBI5Tv4BQE6ev+F00PvPtkcPO6m4FfcKbyDKJHZ9XqQOXd6qOeQnfYNcBqPJsqHVEjAjEg/osF2WR1uXV+Bph3PnSSjXn1E7jEJCvGE845PIjaTx+/DIt3jyyqXJzC9gCiYWvaYjLubHYkDscaoxfZH63gsX0er5Mwl+MpeaguFBD1Yh9aPK81ogFyTkOfZc81c+YGhOW6RpvG9nbRvzZHPxJ8XCZCSqGVmAzhK09+/Tfm/HYILBLlBYzPdGyqr1S48+1fChRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B5ag8dFVtpwN0SZ5SqpLzscY+yNxQ9wFCU0/rDw4tQ=;
 b=n5GOAP8KygGVlUw8XIVI+s0/GgGmgyrv2XyltIlzx5P/gKeRjaqlRcd66XubZDa6IjUu05E9+PkLH/F7KtNbXPWzK3yemnuj/bzfqP6y8pq0C8o5RJnPnszG9oH+fdFN+Cf+dnWgbUcrJsgqFjTz43CXZnbIfGeurV7ebA6IlinCQt5qn3+OgXGvSqjZlxSoFi+LaxQsglNPrgEJTqsLR38k8UzVEnbovUkkiZjCqadvZfz/GcFOZNv+K8j62vqkNZwSv89rHOQ3Hoca2bbY4OnM0OlfALQIBzjw09d8icAwxAodqumKRMX+XorMUAmnnGW+sU/Dx3XghCUB63bjaQ==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by SN4PR0201MB8821.namprd02.prod.outlook.com (2603:10b6:806:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 07:58:47 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 07:58:47 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH 2/4] audit: account backlog waiting time in audit_receive()
Date:   Mon,  8 May 2023 07:58:10 +0000
Message-Id: <20230508075812.76077-3-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
References: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|SN4PR0201MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: c9159176-2009-43cf-8a1f-08db4f9a0d7f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFmlwuywKGZtW8lcoQEm8JpVZot24fJmiaiiEGUJYwlnO3I/PcKQ2L3UpJyMBHPfiI1oSQGeSu1r4ozLu6krj94PtmnWvw03mzAV5rcyMVVb5Ek64hy9gjbC/e9iB5qjrj+Drl7cOX327BqPhKQHHiO4/RPv2BPqIiPGJcs6xRx3N10mGexjxuZNBHAbfWjxNesDJ5VYvVjtoV04Wx407BqSHOuHSmooD9A+pryIVeXpzuznFoKP0a7jCEjAD/W6KCGibuM9EAI20fwXMxYA1dP7RvK5hc6KgK8dBohgAG8kF0ue+0pStoNoGkH5dr7vXnlE761yMdksoNsytoL0nVRBKGzOc3TM3F8WxyxP5HMSohU2cV8ukB+dGnghuTgrujRdh+19fWoZPawVHxG23MYU9uFpnSFH+0eer1v0C1Mc4tYgSavs+OCt+gpX2J0r78/nYGvYk1lx0gigw5Gq/sUXiOY9cjE5+YSQgul2BvrpbpAUL5D2r7dA13VIPjG8PKAD7pmolOl7eEz12je6DFBPrRkvZmd1Tbe3Vi+w6j31iTZgmrWS95tX93x32Y/X75NXTuBBHXe1UMOjAbg39/4CP+os3ZGG2fszZ61UK0RfCbL/GchIACWlevVQmg2O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(52116002)(66946007)(66476007)(4326008)(478600001)(316002)(6486002)(86362001)(36756003)(66556008)(83380400001)(107886003)(2616005)(6512007)(6506007)(1076003)(26005)(6666004)(8676002)(8936002)(5660300002)(44832011)(41300700001)(2906002)(15650500001)(38350700002)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6sIB/pZ9+bdeclGLmt6HpGG0jJ7KI0Q1EOtmLYAe5UtMh//9SCEBEkBjcwLI?=
 =?us-ascii?Q?xeJCr6LHZJs+zypIOjxp/Nh7FfeSFQ5h6fMH2YeznwwcXTbfHFGHBGjtJ+6G?=
 =?us-ascii?Q?IMsDvpiHS7gZE5xiZ2YGDXbBQ8ZOn3OZ09NDP76cZLs9lCWTMexZFRCA18jE?=
 =?us-ascii?Q?PjFnIBRcgyxCOxJ81F3eiSqYYjbXfCjG+slRShAme7ovHOAf85c8nHfmr5oK?=
 =?us-ascii?Q?seECKtmO+oEkcSzHxi5CVTmmqCZnHXobkZExpPhipWkrm/kO/83oWalb0AGn?=
 =?us-ascii?Q?jvfqnkb78GvKb/I86hHZH/SZ+24O+Rmk2SNOJdGPsOS7cFphaJCG8OARrj/R?=
 =?us-ascii?Q?IjqjUt106+0oNZ7BovnG980oFchcH7C4SdkjgarKlm9ppcH8J+gtbn3DIge0?=
 =?us-ascii?Q?QXWP3ATpM68yRs1g/v0trhW8StHizkpDqb3EdeY7OGmLrpW5h4kHWk6mGUpG?=
 =?us-ascii?Q?gG+gJBSGse2oNmzuhKLCFgZnrBMw8xGFgwrgWpshNSk9+2NaZ31fLHTA90tB?=
 =?us-ascii?Q?LUCdqusuDnaZZQpPRsyg7+R7LwXedh3dOp4xMH0aWdPYrwsJckp1KOfVlhtN?=
 =?us-ascii?Q?Xm7NOZQTNe6AnnApH6FGycv1k4vRYW0z1UW4FupkCLyPnuHlW/couVZKynd0?=
 =?us-ascii?Q?nvmZMyv5NMyKdAXOKsigMeFXoLNHrpHgUrvisItpp3+gD2qtkERbxJ6+v8i8?=
 =?us-ascii?Q?1tRixzrjh05f8dgTF21T1uWVTqq4r1/X4DGv3du3OVQEUKBe+G5FnnWjUDPh?=
 =?us-ascii?Q?1A6iECEil+s+MMxvvb5Kby8gCzaY/4dS5VD8dKz61kI/5Xt6SXy8DrasEBJM?=
 =?us-ascii?Q?cIPavfxJ3lRsVS3ffS3KczLvKfyA0s8OJvs9t6jc6QTNbqGrlakoc3i5Yi+J?=
 =?us-ascii?Q?uu0eyGNoeL+cCXTRLjEjEYoeX3yiecDeZXK/yqnax6UAMq22UBvka6HcNfX7?=
 =?us-ascii?Q?LxQRU4XF3s8ROP8L8aiAB+rtTGViPrWij0gRokEpRA3/5INRPk+iw1dI0ahk?=
 =?us-ascii?Q?qtyuSxF6i5vouyEJ5pPIK2YlBGlCiVS4is6+PLKFcdAW/sfxofB/j6ukslL4?=
 =?us-ascii?Q?u4AliIUHzWj7aLC3Rw7MFLWUhCXJXBbTLfwNy1l7dCIIV/nF0l/FA7H9zt5W?=
 =?us-ascii?Q?cZVmESHEQJq9JqNeCEc5vWyvKbL7N7ABLmDX/11l62uEb0a+whBjlFN/xnLH?=
 =?us-ascii?Q?GXWGV57M61JCHsLPmeeK25XQksDy0NeuCxaMJJkRAevQ4LR9UZCdUPBUJdZw?=
 =?us-ascii?Q?L76Rccjwbs9PbytbiQeTIr8ICn8IEDC7JcRsmKJeAmd0wZT+uIC+08nv/Hln?=
 =?us-ascii?Q?Q1mR0V8/5GvcUr/hwSMmw8M+G5OnArzRnmtIi55LPmRCnITAOJ2VOmpQnVF6?=
 =?us-ascii?Q?N0xB8GsCD30biz7BeDu2gOIvpOoV4luDkREBXEKSD1Kl4RshUbQY6xZjJn3t?=
 =?us-ascii?Q?NfRxc1rWkfiMDS0MZarQvHmRwP2+glY7HQNdNBMwlYbOVrOCappcbmODst3w?=
 =?us-ascii?Q?q+nE/6CrUoOstL00jiadoHUfAbUkn5jTjQTHQfzY04ePZKlOCQ3oHFjhF/Pr?=
 =?us-ascii?Q?zUomvoI+KdafhwGTgrLXZr9GL/4nocPaq+17zJTordjtMDUdXiCqoYBD51gA?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9159176-2009-43cf-8a1f-08db4f9a0d7f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 07:58:47.4164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDiYPWApfeGUMbM2FkJN2k+vMd1e74wZLLnMVDXm2FKcoRG2j9FHvVgYM4jGiKFrGRaM6WITfsWF98R1UHhrKhx8zFj9izg6SbUeJacCkNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8821
X-Proofpoint-GUID: WmPAuRydJWMT_9fIfcAmCOsX7g-5ZJNA
X-Proofpoint-ORIG-GUID: WmPAuRydJWMT_9fIfcAmCOsX7g-5ZJNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_05,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently backlog waiting time in audit_receive() is not accounted as
audit_backlog_wait_time_actual. Accounts it as well.

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 kernel/audit.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index c15694e1a76b..89e119ccda76 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -628,6 +628,29 @@ static void kauditd_retry_skb(struct sk_buff *skb, __always_unused int error)
 	kfree_skb(skb);
 }
 
+/**
+ * wait_for_kauditd - Wait for kauditd to drain the queue
+ * @stime: time to sleep
+ *
+ * Description:
+ * Waits for kauditd to drain the queue then adds duration of sleep time to
+ * audit_backlog_wait_time_actual as cumulative sum.
+ * Returns remaining time to sleep.
+ */
+static long wait_for_kauditd(long stime)
+{
+	long rtime;
+	DECLARE_WAITQUEUE(wait, current);
+
+	add_wait_queue_exclusive(&audit_backlog_wait, &wait);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	rtime = schedule_timeout(stime);
+	atomic_add(stime - rtime, &audit_backlog_wait_time_actual);
+	remove_wait_queue(&audit_backlog_wait, &wait);
+
+	return rtime;
+}
+
 /**
  * auditd_reset - Disconnect the auditd connection
  * @ac: auditd connection state
@@ -1568,15 +1591,9 @@ static void audit_receive(struct sk_buff  *skb)
 
 	/* can't block with the ctrl lock, so penalize the sender now */
 	if (audit_queue_full(&audit_queue)) {
-		DECLARE_WAITQUEUE(wait, current);
-
 		/* wake kauditd to try and flush the queue */
 		wake_up_interruptible(&kauditd_wait);
-
-		add_wait_queue_exclusive(&audit_backlog_wait, &wait);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(audit_backlog_wait_time);
-		remove_wait_queue(&audit_backlog_wait, &wait);
+		wait_for_kauditd(audit_backlog_wait_time);
 	}
 }
 
@@ -1874,17 +1891,8 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 
 			/* sleep if we are allowed and we haven't exhausted our
 			 * backlog wait limit */
-			if (gfpflags_allow_blocking(gfp_mask) && (stime > 0)) {
-				long rtime = stime;
-
-				DECLARE_WAITQUEUE(wait, current);
-
-				add_wait_queue_exclusive(&audit_backlog_wait,
-							 &wait);
-				set_current_state(TASK_UNINTERRUPTIBLE);
-				stime = schedule_timeout(rtime);
-				atomic_add(rtime - stime, &audit_backlog_wait_time_actual);
-				remove_wait_queue(&audit_backlog_wait, &wait);
+			if (gfpflags_allow_blocking(gfp_mask) && stime > 0) {
+				stime = wait_for_kauditd(stime);
 			} else {
 				if (audit_rate_check() && printk_ratelimit())
 					pr_warn("audit_backlog=%d > audit_backlog_limit=%d\n",
-- 
2.40.0

