Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49406FEB1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbjEKFWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbjEKFWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:22:03 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E391421A;
        Wed, 10 May 2023 22:22:01 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B1GhEG028406;
        Wed, 10 May 2023 22:21:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=+B5ag8dFVtpwN0SZ5SqpLzscY+yNxQ9wFCU0/rDw4tQ=;
 b=iCMeP4YGIvagnDQxRUTLPhFmH+v5q1JLB3y3z0WbqV4YMbg3RUgH8UGpouYbIot9ubC1
 T/zmKbpSDrK6VVGUVSSpW1NeQ3C8dQhFpiyXsLBmcHnGVy6MfckALOvSkyJRjLxiBcpG
 RzZF6ZwVjJDIiQbbhM+IV5UvQz72Tbpg/Vrdmx7c6TYkb6GJ2LX+NTTzH/QXK9oz7R1A
 RGaDrQ0sAiU7nlvVl2m4ftRkKbGonABM88GbPUciyeqmtVZ+LKqU+XNa0fwK092XwrLP
 m4FPH+d5o2Tv7DYb5w5TxW5hsvHuPdys8sCBQiyj6JFiHUk9U1CrUuRAlGfqn+uvsovs zA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qf7jvdbvr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 22:21:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fICjsY42UyToH4dHQ69KH8PW5G25fZlnCDBv1Ne7VnH+6AtuWEDThE+jBzEdk3zEAn7kyMeUoMHUIVQnilNTWhwTlPCZ4lUCDlMiJSXAzBNnanVgBB65WrWn+s6YNPz2PLN+kAXBXAQP+6XtADtljLUvaDiuCllaHOzq0FQ1AL7GAydQiA58rac0Y541vd1Stp/Nq3turHbg+OljFminPwxz+DcGpcvXJmrSmx4/73CnauxK3xL4I4oXUxKQnrTbeVNoSMEuEegRrBGpyCNjUpDFyp19MsFHp6h8GvHbohEF/jVNKxuWi6yfbh9Ywar3/CKZa8hFOtXsbk4a+dnWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+B5ag8dFVtpwN0SZ5SqpLzscY+yNxQ9wFCU0/rDw4tQ=;
 b=bJ2Dxy2D0Uiw8mdBy24iRF/+VgcXYBMQUz1dz4YkXOhIEfaLf+gH22YQeuH7DSgPVXRKuoRt93mBzYEoogfNbn5PB4yRAXhxtS+ZLlQ/su6XemlEK5bGLz2EmBZa+KxV3bjzPWy4QrDEPVlxAEbs/fBVX6Pp8rk2NNdln3ofu9vxg8vL0zcElo3IIa3coFJNqnSUpzmQwCvgH2u4JV5rZ8Im5/1j9T1l2Co3wHXFDg13jdmjqGER5EaswafuAdE185+D0Xyl0DHMyWXBOfx86xn5oaHshS4dZ5DlBT+UTs8KCbK4GvvdqJ8/HVtLXB/lAPUTmJ/BDGEo30H57LZ1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B5ag8dFVtpwN0SZ5SqpLzscY+yNxQ9wFCU0/rDw4tQ=;
 b=klcv2M70+Ceab5lSntUdjE9MNXyZK6JCRjhQ+9M7PjoWcjU2Fv8g4ROxxUNFcfImZR6to5JPguMQFs4ylbr58KX+no+AUDB0k3nFnECGTHOb/+WZds5SR2EQz9n8effezinkKrWH3K4BmCbT3bNdRS2OWKLNl8mfgv283GxEAE6V+k6LzQ0+Ke2j8OE9Wy4xGo7EZkEdi+ereERdNJB6w7K5tURgGtVARHUJAhhzwjFv25V2y6kswOvqQS9uzfXXwYjHyaRZSxAFEeTgabTR18yWzkdZrPv/azZ/jUnOY2H7KTRGvux4NW4Y5WtWkhzysjPXtvZl6pM3EgQL1TKDMA==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by LV3PR02MB10006.namprd02.prod.outlook.com (2603:10b6:408:1a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 05:21:31 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 05:21:31 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH v2 2/5] audit: account backlog waiting time in audit_receive()
Date:   Thu, 11 May 2023 05:21:13 +0000
Message-Id: <20230511052116.19452-3-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230511052116.19452-1-eiichi.tsukata@nutanix.com>
References: <20230511052116.19452-1-eiichi.tsukata@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|LV3PR02MB10006:EE_
X-MS-Office365-Filtering-Correlation-Id: b0fb040b-e18f-4f5e-b9f7-08db51df9443
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHhWAqgsdm1iD1pBKgzblkcY/wyoBo0BcKhYeV6DElXSWluV+s2d2nGMaOJcypx5ShLVGFOW+KABo9H3LQk8BL39GnhNsa0R5mitqPwRXqyFUN9qvediNBL5AenOrApGPQ2IUY8yGUPuh75RBm22xavL3va3Bvy5ipWuqPWluzMDBuZLSXrmj0rauEl1tzxZlJuYPu/CSyRf1UquXW0BpH2achrszNFY4fFBnWa/VNAnu5aDaUJG46qNCGtpNQNvfhGHt5g8HD0sqYR3YtqG0H5gguXW3JmLahF+jPrDRrbaHpXcEb5sfjo2qnGesufGOElqqzbh2loxCbplI6YXSWsoQAnzaoGOCb0i5WWYdSsbWyLoiXeoeG2ybIhBHoZazo8SD04W3gfj+OzYTYHWWlamcBjGZqp8F2nfAc+iGVTmjhMq0ZGgbGyUVM8pZk8kHW6Bw+ju6MrJ2Yqb/uIJwih5J2kqxMtoar+rdyOWpzE96XjoswyxKo3DUnHmpNjskAJfz0/7mTwa0QzgesI9CBxptny9wvPrLNLjT8CXB45WZCWgsVifkV2kvFXsZuOnxdDJeuRnHqoQOek7XAMMCkWcspcnTZhAcaF6OyozlFu13HaaIvF+m6xMMl4MSn4X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(478600001)(36756003)(86362001)(2906002)(44832011)(15650500001)(5660300002)(2616005)(38100700002)(4326008)(38350700002)(186003)(316002)(6666004)(6486002)(66946007)(66476007)(66556008)(8676002)(83380400001)(107886003)(1076003)(8936002)(26005)(41300700001)(6512007)(6506007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f9zUtMU7TvoeP2MDqVUlhFUxFFuYOaHgpIBFNot4p5mWIj3W7rBff5gh+6RB?=
 =?us-ascii?Q?a3YbrY5JdR+2gO5TX9uAQKohhiu0Nn/+vSKBKwkF0w/HsDZHuTqSdBNOjT9R?=
 =?us-ascii?Q?4G5T7IaDf56wh9KVxM+8Hp/FwKtuncGs2aUctJwwwOwFix1wI8s6nCp//WPn?=
 =?us-ascii?Q?reoAYTPU15K9tGy0Etu61kluJGGosaXt+OSeFEEWYappqq2nV8x8Q8M7JhBf?=
 =?us-ascii?Q?oYEqnDvbyIsNe11c5imZT+lJ9ygOxthhfL7mmEKXUNslxxdIkTgc9Dk+8oqt?=
 =?us-ascii?Q?rWtwd9kYmWgN9bZf4ngnwr5hTNC8grvk/Ot7NQ4ASs8UVo4iYpYyoqlEFFdi?=
 =?us-ascii?Q?EhPviM6nIIKarDIRccoQaF2s61dfMSm3B60l6EkGFXQNcQzyee+LwzKP0ZFS?=
 =?us-ascii?Q?M+kvQjUPFJ/S/XDZDAGrAmUsPyi2io6dcGo5F3Fxkz7uIIYrZxaKAhIkd2pm?=
 =?us-ascii?Q?rolNr1yZV6DiAQDgmqnB7/SvV6o7U6npzSpF1T/Zu2y2Zni1LvJn1LGBuczO?=
 =?us-ascii?Q?2zIZwWfv21oQ/ALlszMn+On8wwemsHSi+4IaR9qieeULjAj+h2mlBqpeClxP?=
 =?us-ascii?Q?hgKVP4TZr85VbCpDC/hjXlzP3rgt4eyUOK+8lohhGvzmk1ORsqgBtnHViPmH?=
 =?us-ascii?Q?Oq9VqZSD/HC61H2T+cJtu9IMD2DULxF4uWk5BF4WlnJheicfDV1mdNTzfwUo?=
 =?us-ascii?Q?KoPtxabu78hJ0pNdO21Vf+3gn9KcECLAcn2tSUMAE+OQQVsYwA1IOfNlnmC7?=
 =?us-ascii?Q?66SjKizMcIQhcJqMrR9nOdq44x1srfeVogb8Xnd3hDeGFW0L0c+zNFj3VMXa?=
 =?us-ascii?Q?8ihmlmIsSNHAz2auy0RKKQLXy4gfShoq4vPm2FXAEtouQcS/pQw9KNkROwbG?=
 =?us-ascii?Q?8ccnisDWo5R65ZpEpKkGLCdyBYaf6c2oTzXw0r3agXn82bl1ujYq+pl6z47t?=
 =?us-ascii?Q?tKBiD0PXImO6ukzT/G726cYKeKJykrU0HM82F+T1d5lHTjURWqTgQw44ME6a?=
 =?us-ascii?Q?ylf95+Aal8SUZZsncSy8mlA068lQtf2dNr7BomvHbnY4j1A7wdOly587ZY8k?=
 =?us-ascii?Q?AzVEiqMAUTBkd8CjtPh68taLNQAgbe4Vxw0Ls92rICE77jk9DeMCEEFojME8?=
 =?us-ascii?Q?TZNYOZjSLJRCc8I2ruCQoMm5RV/9t9NXuFo4wJUaK/PxHlXitvIep4+czZwG?=
 =?us-ascii?Q?tKoNFGzjcIQcIU/D3TgqaScpjjSbc8Avr54xothgZ8fgARONdKpHvvFIrUE/?=
 =?us-ascii?Q?GqUjUFrhA7WuFNj9TuZabqgDkFyDg8sc6yO23pMBEEXdM/iYIpvThovp8mfc?=
 =?us-ascii?Q?Gf3OZYmUtNr5gEkjpOvi3VSXGuATaXLvuakIttUJuLddbRN+N47s4A2JEl3R?=
 =?us-ascii?Q?p86S23W3L5Dp/mOkduXojbDrS0nqslMi+C8m383J4fvw9tcW7QmWp7caAo+J?=
 =?us-ascii?Q?eGYwqsvOzaLdagFm+0Lf6b5zYcbnLw068UAettcLwwUL+bkMKahkApIH/cL7?=
 =?us-ascii?Q?kTfTi2RJAGPmCfmEcJrrx5dgdykTrjFdyfVdgxzJyLOLGf8alQ4H8GV2kW2N?=
 =?us-ascii?Q?LBIlo7d+hTMltkcm9WNNfTPyGBf812orw806AdqMQrf5Uk+x/T0Oi3jkdYZH?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fb040b-e18f-4f5e-b9f7-08db51df9443
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 05:21:31.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VpHfzq4k/v3VDCRyg2CsB2lGm6tsYsLOpDPAevlW2KbbFOvxHrJWLLUDpvJfiAfuMWqCJLIpBUSaDUJqDwueAZX7l9uQ/iTnqfDcb3JNac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10006
X-Proofpoint-GUID: Xiv-k6Pkee_nLSfCgqpf7U8Cq47IRaiv
X-Proofpoint-ORIG-GUID: Xiv-k6Pkee_nLSfCgqpf7U8Cq47IRaiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
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

