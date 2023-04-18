Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0896E5F60
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjDRLKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDRLKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:10:14 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488E42D40;
        Tue, 18 Apr 2023 04:10:13 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IAxcIF002805;
        Tue, 18 Apr 2023 04:10:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=fYSak5K6+MJK4jXm1xATgmbX7duBun81BvVMPV6D+eM=;
 b=lJOAvf0nd75M29miqeQDxBfOgW5XNnt8LzoQKuY73vOEyMuciesuQxP1w6kVZBmS2knD
 eX70Tt6wxwg+YKvLi7thEdtdWhEJ1mi4sAprW/s59Xkpf/+C1itDjsOQneerilLOMtTF
 fWcuNnSaHrDpLvjnMKlY+So8zDPyjuQx4TK9D0BoH9IHw+uOvJFEHqjmwabh+MiaTnTx
 syuaBKVAAS/mXhceLdPhJkuSo4Q9U3mc9tE3GHYNX1PLkM28KZ422HB8Gtg9TbRBKt2f
 gxcUNJJqgdOB/PmEDUIh824XIvA9bsIqKYUTXVAIy0kfcgKOmkQZaMuTG4MLtHvMAQz0 KQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3q1qy00870-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 04:10:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkERNXElXDSC/ShBJergQSlO7nna2Jenm6WqzHHaL8fUCubndphsPt0sxer14b4DoknjYZDNOkRPyoaC2B/wd3sOBjjcsz07E9BW0iiuKx028NDlChZlic44Gw4R8J4vgCFXMG/ie3KBmPizYGFgWBNXUApUVvGoJW3bsnPSAxBh2aCrl0FKEdXwEQNfHgaqVD76N5ZjGEDxHS+FrngLxMDinw6FCY95b3PkJzqrNbpTrHCLvC4IyCbC/EXf/S4khB5PheUsBqwW6J4WYBeKyq9jpNoeTMwZSoEeKfIz64ab4fuC8rc2Vgni3ogCwAOPaGBv9FxOsdGu0rqKsdCbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYSak5K6+MJK4jXm1xATgmbX7duBun81BvVMPV6D+eM=;
 b=aQJZmVdgFhwlGMSHmuJv16zpCthCuQD3TpgmrQLsqqxx2jreH7DMBzQsg0bRlUKcBzH7g6z+a6K8Z2PUNDwur159XBGcLQQ3GQ8VA2eLpn9uzVl2LCbiTBltQ+VCmqx5+VeOLXLl7Eqzs/V62RGw4iQhZ0w0EHC86kwmOB5GxxtsC566vJGkfbus1OLOqLZtBzhBN1yx5CpKvnQ3ic2lZvflf3xoSyspYY1Q/jlzSGipEsHXAfnLEVIdsqAN6C1/z94X9iCVzW2hrX6kf0w4f8UIVPZ6X3MTretpkAbcFCJQ9UX5lp6HbLEV9eEtvQ1lIYKnisZqv8hvpwZS2FWGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYSak5K6+MJK4jXm1xATgmbX7duBun81BvVMPV6D+eM=;
 b=FKX82JzccpwS/OATIhke8xGqS8DLPC//2ZWGjsn/Ym3COhZ+Uz8CBjrqsBXH1rZU1zUjZYCJI5SZ7fQdQEHsRep2N4Fd3V6QLgcGiKJvu8yStMUP2nfJvxfulOEP+s3d3X3xOaMMIjaW2TiHNDMGmVYa+zG9fGNBVse9hfoP4qiM6FrX7sGxgE0ba+LL5cPLaz4FJsFPrRc/LWtuBXGEp1ovORnJPHbPOMGq590xZaYcSjfTlXHU8fn6TVRQtO6A1hV0wb+uNEk/pAfGeRbosF3q9iW7EQe/Kzjl0lkcawkmwG7tbehZ86T91PdQ0eAxspyVLX/GdwIOpLXt3db1wQ==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by PH0PR02MB8421.namprd02.prod.outlook.com (2603:10b6:510:10d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 11:10:05 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 11:10:05 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH v2 2/2] audit: replace auditd_conn.pid with auditd_pid
Date:   Tue, 18 Apr 2023 11:09:19 +0000
Message-Id: <20230418110919.221578-3-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230418110919.221578-1-eiichi.tsukata@nutanix.com>
References: <20230418110919.221578-1-eiichi.tsukata@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:510:f::15) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|PH0PR02MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9b389e-bdc8-4a34-bd11-08db3ffd768a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ba8SDoVHh0w0GIgGlT4rX/vQLKisV4OUMQnN++Vui3QRCqj/e3cQd75QaBzJklkXZ415OUxaqUCYEp5HaxWZXlmX/izyQrpMpTtqqfdWPcK4dtXQKdbaZe186N0fpVImFbLg3YggaY7ioqG6zgs6C0nWqMlrOERFmWEI3HGQ0oYUE/HDEDQ2jA8VVH+oaKuw4lbqxuH2boYYMjNeW9ImY71o8wL2QFSu9KT3PbaymFwLAiRe1qxraHoY7CNFjsetpbNr3LMi9i1zRsycYqKwg/pNcev9PyZClGh7jBTmkppLEUwJLdjUwAL8YR5Bnco8XdNnDxtlH/s80ylXxHS+40eryJPLpI39OF5B2rjk6pQ6Mrrwa5/pyZ/xBLp96fMobbPJOp39p3/C8Aw0rNcgeCY/b3kMZ436NGp7AovbF81eXm9mUjVROs6t7PZcE69mZIkQbgkOaOQK/ujVmTpmdDla0i0rz/ghvNVYlTTGN5zUC+BmLhyyQIlg+fQKJrjo31pIU8yghKOqajQi9hnTX4MyJCDZagfehKwY2IvOBvkRNqKz8Bmek5id7r2wDI5dIJTpjEt7WUs1ALqc1IIEO4+k9DeNelkVy54pNELFiyC6ghYL2u6sYMlpG5JjAIE0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(36756003)(38100700002)(8936002)(38350700002)(8676002)(44832011)(5660300002)(2906002)(86362001)(478600001)(52116002)(6486002)(6666004)(186003)(107886003)(2616005)(6512007)(1076003)(66946007)(6506007)(66476007)(26005)(41300700001)(316002)(83380400001)(4326008)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ahi1DH1UNXmls6Jtc2Ghcu4XjBY2VdjbzhlgTZNRfGprJuZCAmogrjvd+DE?=
 =?us-ascii?Q?CTY+KHlzkUVO0pNtaz2vzTdCiWzPy9J2sQauqg6qhhak8t8w8EbWYw39n8MC?=
 =?us-ascii?Q?oDdFe/jp6BqesHmg+zv1WXLZj52vGjezfFgnlVAWYRSS4NcPPrQF4VmqNiJx?=
 =?us-ascii?Q?xNRLIwDF706TyVOo1iExJQMDisNxiTKJNoezrJXohwKRwQByE9guHt97Hll7?=
 =?us-ascii?Q?8+GNI6brlhDCvzZjzsUaaKlaPlzhYzJ8HVJM9sWPugKU803MTe+PjFzugm86?=
 =?us-ascii?Q?+6vV3xpnDL8Lpg8r9s4EZIx64eQz5dbeaBChIVfEQV3n0tpq4JOUg//NQ1uW?=
 =?us-ascii?Q?2oIWh9hWBBajVDfW8l5YxUQcUsNmYV2rCpUiu+G4SlcvyIEK6bcaZ8tXXBSo?=
 =?us-ascii?Q?slvOU7oGFsp1awD7AIbjz1vdYf/Mgvx1NDYyAOcNPeP5A6W82YSoY1p52/xY?=
 =?us-ascii?Q?NRUXZjuxvX3UEz7KbaK6lgow0Jc51oMAvX/Kwp5zgpvoE6OQULe9Xjy+xZXm?=
 =?us-ascii?Q?8d8Ea30K2SKcdIen5KwEmDtb8jquro0rw7bayo5Y8gngz1/o6jm9kHb/B198?=
 =?us-ascii?Q?WL5Gkf6YLx5EBDJu4OZmCI6RlDnG0WJR0WIqIHlYJgl+nCp0Eus+oLg591lI?=
 =?us-ascii?Q?7rgVMfaR+wyxAXPeBwDzx4Ie2I6NRcsh0noAS3WyrOZHyJUca4XghbP7lZcZ?=
 =?us-ascii?Q?o4/4Udj5+EWAMWljBcaFN5e2Bbmvht6klt6PcvVVdfha2FYY1FPLs6oxW46Z?=
 =?us-ascii?Q?ijkMXF+l2CVEUJAn9sOrIuM2ruDF32ryFpwBOSYhVQBrxs81SHnxhhBlvksy?=
 =?us-ascii?Q?T4NzEp8vGyDhEMfQSXNzrA4mMTPxd/BynieSM50rDRXxvHf+SI9sEqtyEK9w?=
 =?us-ascii?Q?SpqIezYVqHKz3VHHEOcI6Z6j4H9myzOOc+kDv5NcvrOUOHF7YSn4o0FUlxYA?=
 =?us-ascii?Q?i5Iy8uj6dj/OslrOX5sG/QrqC5nUB2dGcSMmnj+BiTB2Lp1VvSfalqJ16sHy?=
 =?us-ascii?Q?11FKw916DNfKaQfqj7fnvpFwUHDS1xrhj623mvF7YLASHFlYKrRu6h7MgbZV?=
 =?us-ascii?Q?KSSGHkfp4S5GarO4YusGQfAP8Cy5dFNPHeuH72JsBNmQgpXNLQE2Esk62o+u?=
 =?us-ascii?Q?/SlBoe+RVdiBM3KFRQn9XjCu9LeqfDzZeHD2PltZDTliAA96KUVgnAaQ+GFJ?=
 =?us-ascii?Q?bkMFVMtD3dO0097SA5xb5FqIQ98yJQ+JuCy9nwehAE/WhDdHT89r78TdsPLI?=
 =?us-ascii?Q?sTYvxuQHwQSlPHl6aAXgP4bLUI2lPuk8DZ/G4Nq5Ec/CKWhrulR23kBgGwBa?=
 =?us-ascii?Q?Kif6xrqsiUCZ6Ssaw1vu8kZ2gmaz7JVdlkgW2fUxfyGV7PvOJzcDoLiAMRJu?=
 =?us-ascii?Q?Gy6Kg7YPUW8kGZZcIr+5DfLA3aub6EDvCkA1Ryo6fIIThexIkskJZiCD7lPv?=
 =?us-ascii?Q?T93kJcFK/CzzZjuPJMxttqo/A3IybedFK/yfmeTeWs1NXu1mJTKtHHw/MfPN?=
 =?us-ascii?Q?tDWP1hsJ5r7JKwuQk8bWdJqlmPJ34Zo8mUnZfS08CTf0gIdwPzfLTp0YwrWA?=
 =?us-ascii?Q?43IgDUxrJ2OLdKvk6CB7fBrPLr2KuKQ6UjqQGMpkzXHODsbVn1lfSu/iF+63?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9b389e-bdc8-4a34-bd11-08db3ffd768a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:10:05.2861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUWAvhOZnIe7HF9dVv9i+tKCA/1QPfeXljcEIjlvtOj60+vhCksYc6eccxYlrxGCm8nXMR4iAAy646d/2y/FZNysZkQ80Ptng2cFlE+V2Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8421
X-Proofpoint-GUID: VBQc-oM5cSyuE4b80kQn-xANl-asI79A
X-Proofpoint-ORIG-GUID: VBQc-oM5cSyuE4b80kQn-xANl-asI79A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_07,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

auditd_conn.pid is redundant. Replace it with auditd_pid.

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 kernel/audit.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9426980368e4..72a7397eaa89 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -94,7 +94,6 @@ struct audit_net {
 
 /**
  * struct auditd_connection - kernel/auditd connection state
- * @pid: auditd PID
  * @portid: netlink portid
  * @net: the associated network namespace
  * @rcu: RCU head
@@ -104,7 +103,6 @@ struct audit_net {
  * or the associated spinlock for writing.
  */
 struct auditd_connection {
-	struct pid *pid;
 	u32 portid;
 	struct net *net;
 	struct rcu_head rcu;
@@ -248,15 +246,11 @@ static bool audit_ctl_owner_current(void)
 static pid_t auditd_pid_vnr(void)
 {
 	pid_t pid;
-	const struct auditd_connection *ac;
+	unsigned long flags;
 
-	rcu_read_lock();
-	ac = rcu_dereference(auditd_conn);
-	if (!ac || !ac->pid)
-		pid = 0;
-	else
-		pid = pid_vnr(ac->pid);
-	rcu_read_unlock();
+	spin_lock_irqsave(&auditd_conn_lock, flags);
+	pid = auditd_pid ? pid_vnr(auditd_pid) : 0;
+	spin_unlock_irqrestore(&auditd_conn_lock, flags);
 
 	return pid;
 }
@@ -459,7 +453,6 @@ static void auditd_conn_free(struct rcu_head *rcu)
 	struct auditd_connection *ac;
 
 	ac = container_of(rcu, struct auditd_connection, rcu);
-	put_pid(ac->pid);
 	put_net(ac->net);
 	kfree(ac);
 }
@@ -478,6 +471,7 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
 {
 	unsigned long flags;
 	struct auditd_connection *ac_old, *ac_new;
+	struct pid *auditd_pid_old;
 
 	if (!pid || !net)
 		return -EINVAL;
@@ -485,7 +479,6 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
 	ac_new = kzalloc(sizeof(*ac_new), GFP_KERNEL);
 	if (!ac_new)
 		return -ENOMEM;
-	ac_new->pid = get_pid(pid);
 	ac_new->portid = portid;
 	ac_new->net = get_net(net);
 
@@ -493,9 +486,11 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
 	ac_old = rcu_dereference_protected(auditd_conn,
 					   lockdep_is_held(&auditd_conn_lock));
 	rcu_assign_pointer(auditd_conn, ac_new);
-	WRITE_ONCE(auditd_pid, ac_new->pid);
+	auditd_pid_old = auditd_pid;
+	WRITE_ONCE(auditd_pid, get_pid(pid));
 	spin_unlock_irqrestore(&auditd_conn_lock, flags);
 
+	put_pid(auditd_pid_old);
 	if (ac_old)
 		call_rcu(&ac_old->rcu, auditd_conn_free);
 
@@ -623,6 +618,7 @@ static void auditd_reset(const struct auditd_connection *ac)
 	unsigned long flags;
 	struct sk_buff *skb;
 	struct auditd_connection *ac_old;
+	struct pid *auditd_pid_old;
 
 	/* if it isn't already broken, break the connection */
 	spin_lock_irqsave(&auditd_conn_lock, flags);
@@ -634,9 +630,11 @@ static void auditd_reset(const struct auditd_connection *ac)
 		return;
 	}
 	rcu_assign_pointer(auditd_conn, NULL);
+	auditd_pid_old = auditd_pid;
 	WRITE_ONCE(auditd_pid, NULL);
 	spin_unlock_irqrestore(&auditd_conn_lock, flags);
 
+	put_pid(auditd_pid_old);
 	if (ac_old)
 		call_rcu(&ac_old->rcu, auditd_conn_free);
 
-- 
2.39.2

