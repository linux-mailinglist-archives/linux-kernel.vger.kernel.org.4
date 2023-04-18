Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F335B6E5F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjDRLKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDRLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:10:13 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BE8E4D;
        Tue, 18 Apr 2023 04:10:11 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IAxcIG002805;
        Tue, 18 Apr 2023 04:10:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=AEOktionI5XGLaOO4bq/fa365ZtzUsrN+Wlvv98bTTg=;
 b=CmDcJoF2z1nUwVSmsvbl30g1yb2cpWZqWDcKqbCM7K17VbpAzUA7yE4qBUwa7GZUUmag
 yfWuST4ZNv0gIXEkGYR6o2LRSD4O3iWjQ5wY9Zz4aOO/v7i71hf+T7IJ4jAQrMFp6N3W
 9BISVZ2srZ5bcqYVjUutNqBWiwdbHX5iIZROdvCzKVAk/hMncov7WeEiqKPGuZSPH9JI
 4s4Lm8+DkBKG5OERG7lQnKhLRhdsYcOPLja22g3RBTVvg2C45gzOm8WvXH35hUILTtzO
 tREaf3xWdFMW2wRZkVVFpg9IwF/IqwirE5h8rqS4w1SBNL2d8DsRK/ImcpYU4kxSqOZF Jw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3q1qy00870-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 04:10:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKfsgkalClqhDBWjWLS/BmAs+H65Q8aQ0nKvohGUROdfVpGE6IbgJPcpYkvSbRN+jJNeUlrl0uw53fbsw+yAbOAySjkDIe9EV7+B8gIzrQMOTuIXqf2tUBg0qrKL+wp6d/0oTjHD1M31Lecm4zZfdLF4iDto2v7mNRmIv1qtrp62PlcsA4HzcvKnJJB/jzSKKTsaiKmSEnjeColik9lEcMHgHON95jw6JdJg3aUgKUDJv2MhTQxT3T1Eh0BeS7skTXeJIx5v6V5T6corTveDXA61r4Hs566dcPdRD47PK05BC+hzwB2oEuYvNDVf2Q+q3cTcRX6y/vIW2LnyDuCUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEOktionI5XGLaOO4bq/fa365ZtzUsrN+Wlvv98bTTg=;
 b=KZiyd3dI4ndilovybNcKgq2tbPjAdBgR4uh0ZRBL3/adNRf+p8nrQ63DbIF09n9P8jxIkoPjG2H6fFVorZnGrFAN2RvxA/S0rrMILYqMr8vYvWKCbGk/N0fBwsgpufA0Crh/NZIiiB0v0ivX4MFLEVn0xcp9iNhxn8stBBXPamawm5nNhzVTmhco47k3lEWx1hkTNi43SPGKaHUPi9uYYbJ57KW7eMpDUskrlV7ofyUCEN1IDomzmlNam9q1c0d3dGhcK77s6sRQ8Izuq7uEMwe4hJDkrdxWpZWmqJfXBNvTSWH8iobGYEhWbDYultR8q9v9nvttH1bfUI2JIafE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEOktionI5XGLaOO4bq/fa365ZtzUsrN+Wlvv98bTTg=;
 b=wr6rpyJWe04JkHK3d/VJCf0fPEg7ppCYP1haSbbxPd6Hd9cr3e9XlWyr7ToXHH+jlBGghMXjIkxHfyl4VJh+9F/jPDrEuHPbrDuHO2bG/qTgdmx+HLx8OrPz3d42s4EAL/hBb6Sd1C5HCas82JNBe2RHVeSJ26sZOJ8+ky8sa6ZZBx9B3WZPo0RfeW1wtS/hT9F77aGh97t2wxNfSIYV2zOQplHbou5LUaoFKPM1d+ULUdzHdX394QCXBZbwHO+OrL0DagD7dvSKFh9JLp3XwLYtdwJXtbUKcAQiUzr8b+oXshqrC4OFt8FOy/5/39Po0RjhX/347Ehii4/IHgG9xg==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by PH0PR02MB8421.namprd02.prod.outlook.com (2603:10b6:510:10d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 11:10:05 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 11:10:04 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH v2 1/2] audit: add global auditd_pid to make auditd_test_task() faster
Date:   Tue, 18 Apr 2023 11:09:18 +0000
Message-Id: <20230418110919.221578-2-eiichi.tsukata@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb6b2d54-c9bd-4ed5-f0a6-08db3ffd7615
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwJSYenQNSlH0j2/2cj4HGVY3YsD5gVaL+cQSiGRywBxVSNu9tq2nUWGOdHyBGxGaAJ4kC4oMf/OHuYy6fFE9eLnV/op5XJSTIq99LjtRRNj8C1H56Oi8qcWiKNPLuNLMlucQolctAjVbA0VZXo4gknU/DtP19mCy0uysSkZy4O+NBIfxOaQ3Bds1KVQ5nN7qM1hn8HLOonnoGnqlqCGcmU3s5sZLXYX4mLlPSdKqiKgwWlkUFiBPkcd+ZiIUUqQMTUm5cSE1EohQNLtCnzqIZ8E4Ete5nEoFLJAz1ZDcx+aepatdZQlZjaj+0SnNwAA8KXrli9TrDQYgQM8Sr6uUec02tX5sephdYyeGp/SMD4zTn22fkZcEIOjzZMWjZR7Z6Tlugd2DYlWVHwtN4RFQRjnP53p5ISR+Or5ZL+xp8tshHjC7/IjRmd+KYnp66qo7tNeIFiNAHIUdIe+16VBxxtyavdm+QIquI4b5535sFWpsbOFklkKFyeTfdXixKFS3sATOXOnP3KiPTgd/6he5+h3I+RmQIo0p5mnm+3/K5PvmF2tEyFipHwfZmYvfWKsYeb1ghT9L6dTiYWiqGB1RDKyTTrjTtrgRl97Hy4fcKO9ui/LxoNv4OB2sGXEqcVPNZIK0ljQlkattCNSaTPHRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(36756003)(38100700002)(8936002)(38350700002)(8676002)(44832011)(5660300002)(2906002)(86362001)(478600001)(52116002)(6486002)(6666004)(186003)(107886003)(2616005)(6512007)(1076003)(66946007)(6506007)(66476007)(26005)(41300700001)(316002)(83380400001)(4326008)(66556008)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWj+M2Tz1S7FXe0e3CgRV5jSLv/382+SJK/zXHgp/MEvMXLyasred0XYskgP?=
 =?us-ascii?Q?Ap1qNrnhuiER3T4DFGRk7AqHiQakiNAa9xF63YVlSMbdxME+xGESoT5wL3hK?=
 =?us-ascii?Q?skRioAxc774PVmVxsGyJI9X5gaanNbbVLXHF7bQT/7m1Z2Pyn5oeNWnjFNXA?=
 =?us-ascii?Q?AQuaMsEb9cHHvVCBy1biWMGtgA1ZmZvqxCM3FI7/KwHFshiiikrZI+ketTgV?=
 =?us-ascii?Q?2/FMyVAdxNOadMLCT9LqRPHvDn0tbgEwj99cFCwT+Ho/qIQnuau3yKMz3BLX?=
 =?us-ascii?Q?dpcJmjxpweBsv+jvlpbSoWOfDV/O5RerO9DeiTJL9DG7VOrI77ScYfm3GF2W?=
 =?us-ascii?Q?ZqK9Pgnql8VEyBUx69eM3Li7srW+mNIMyxEaHzEnr8qZpi6Twvw+DuRTRlrF?=
 =?us-ascii?Q?7MtxGpqtSVJEqipgtA5rDW1SQ4MK1W8jqdABKWXd7vPw2gazXtCIphbgMzyS?=
 =?us-ascii?Q?6oA6QZWktbqYmgzB7XZA/ZspZqy8WIfgjHAduYasC7ClYpOwkHLj5UcuqzTy?=
 =?us-ascii?Q?4ipEFcSYnrtLwaHIH6kq+sY8WxzU5KdKhfrNdZBx9e9b/bSef7ghRkaR3COr?=
 =?us-ascii?Q?5OmqYjf3zG8meB+tEIgl1sNAN53o5fvH3EAy00ptMMqjsNJCPcEO1RJX99DB?=
 =?us-ascii?Q?uS4f0lEKMbcVGGItBQuGnxdIzLLHkJktOFnzjR8FCyOdNzUZm8o2AUmT5eKW?=
 =?us-ascii?Q?bzx7XX/337exGVHSgput+z+GtoeLYfMCguSOjURsiaSlEeaTa2W6V3ekpymE?=
 =?us-ascii?Q?4Tj7MZhXhK3zhx3/+ZBNVU/VSVNs0cwz+FGIc+i0q7AVriO6NPXQ0m7Ky280?=
 =?us-ascii?Q?NMNFkhQsSzhWxZFtXAOzb0OqqqTEtY/BS7ZRbh6uUMx+NejcVUnbaXvUByKh?=
 =?us-ascii?Q?lMoIgKl18iGuYu0S+7z/NOIEM6U/VYXpYjIHbfnMr7A8ikcvziG8r5/75wXW?=
 =?us-ascii?Q?7mcaI/ztploYlKJvsetX7kuiBvSuc7YT4G79srwVaSG3Ph8+iqDOlmAEl75i?=
 =?us-ascii?Q?p9MnKl2L/LmUordU5i1IDf1bqKVwJZZscNLalWQS8RGZ5LIs+INAK8GLpY82?=
 =?us-ascii?Q?Oit+F5SyDpdmvS+v5RH4eyU6vPsSau5VwM2FxGbMopX41djxWDKTDUYI3PM8?=
 =?us-ascii?Q?mBlqUIx9iKKqGDrA8aUkcXlh/n+i34irMf/z2LLIYe1F8mMY1RC6ggPEa4g/?=
 =?us-ascii?Q?Uw4Fd0MOKd5UJpm2RG1BWLCHBkpBzrkcmW4CcNGcFeKZAiYAYvlRI/2czJHf?=
 =?us-ascii?Q?9CCsYky2z897Uqvzw0PIwq3xJ435pU2Sr7K90w1two6Stn4v1iFckw+FgkGJ?=
 =?us-ascii?Q?noYuh69TQRMeWx1HLeMVeu2jBENHAEw/OVdt2QG7VfjRlr/xTU0Qfv47652s?=
 =?us-ascii?Q?tSnM3ihMGnO2LnZFTEZwQtKTs1b4yDfeQlnIsIh6d4TtvkOF8vcDD5BWrMdk?=
 =?us-ascii?Q?U8dO1EIaXcECzGXNC+RbwiixB4dppKzhwaNSiAq8WS1tvCoJq/xKMGrvipQ3?=
 =?us-ascii?Q?3yqeVzvvdS68QdbGmQKGz0lzCg/PxqL8zCmsbtelelGahhqoh/n83e6kemiR?=
 =?us-ascii?Q?G2p091/7rBI3kzKIqJGhs/0rk3EeEIyi8C4Gjk5kpxYpL7DAshNqKY7xq7UV?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6b2d54-c9bd-4ed5-f0a6-08db3ffd7615
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:10:04.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cUUj0+O0XnHWLSqqMQ1pah8jkQnbGQ8aXMtqs5hktDQdvVsNksv6mY3+JnQtM2rvJCAb4Xi3h8k+6ZXk6J+I5LqiQDQzSKNZDRcj+pEM4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8421
X-Proofpoint-GUID: X1i3E_FeZuRklVHeqyuiPuzCh87-4mkY
X-Proofpoint-ORIG-GUID: X1i3E_FeZuRklVHeqyuiPuzCh87-4mkY
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

auditd_test_task() is a hot path of system call auditing. This patch
introduces a global auditd_pid pid struct which can be used for faster
check of registered audit daemon.

Benchmarks
==========

Run the following micro benchmarks:

  (1) dd:
    dd if=/dev/zero of=/dev/null bs=1 count=5M

  (2) UnixBench syscall:
    ./Run syscall -i 10 -c 1

With rule:

  -a never,exit -F arch=b64 -S uname

Results:

  (1) dd
    Base line    : 2.572 sec
    /w this patch: 2.418 sec (6.3% faster)

  (2) UnixBench syscall Index Score
    Base line    : 860
    /w this patch: 953 (10.8% faster)

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 kernel/audit.c | 39 +++++++++++----------------------------
 kernel/audit.h |  4 +++-
 2 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..9426980368e4 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -71,6 +71,7 @@ static int	audit_initialized = AUDIT_UNINITIALIZED;
 
 u32		audit_enabled = AUDIT_OFF;
 bool		audit_ever_enabled = !!AUDIT_OFF;
+struct pid      *auditd_pid;
 
 EXPORT_SYMBOL_GPL(audit_enabled);
 
@@ -208,26 +209,6 @@ struct audit_reply {
 	struct sk_buff *skb;
 };
 
-/**
- * auditd_test_task - Check to see if a given task is an audit daemon
- * @task: the task to check
- *
- * Description:
- * Return 1 if the task is a registered audit daemon, 0 otherwise.
- */
-int auditd_test_task(struct task_struct *task)
-{
-	int rc;
-	struct auditd_connection *ac;
-
-	rcu_read_lock();
-	ac = rcu_dereference(auditd_conn);
-	rc = (ac && ac->pid == task_tgid(task) ? 1 : 0);
-	rcu_read_unlock();
-
-	return rc;
-}
-
 /**
  * audit_ctl_lock - Take the audit control lock
  */
@@ -512,6 +493,7 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
 	ac_old = rcu_dereference_protected(auditd_conn,
 					   lockdep_is_held(&auditd_conn_lock));
 	rcu_assign_pointer(auditd_conn, ac_new);
+	WRITE_ONCE(auditd_pid, ac_new->pid);
 	spin_unlock_irqrestore(&auditd_conn_lock, flags);
 
 	if (ac_old)
@@ -652,6 +634,7 @@ static void auditd_reset(const struct auditd_connection *ac)
 		return;
 	}
 	rcu_assign_pointer(auditd_conn, NULL);
+	WRITE_ONCE(auditd_pid, NULL);
 	spin_unlock_irqrestore(&auditd_conn_lock, flags);
 
 	if (ac_old)
@@ -1263,7 +1246,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 			 *       run auditd from the initial pid namespace, but
 			 *       something to keep in mind if this changes */
 			pid_t new_pid = s.pid;
-			pid_t auditd_pid;
+			pid_t auditd_pid_nr;
 			struct pid *req_pid = task_tgid(current);
 
 			/* Sanity check - PID values must match. Setting
@@ -1274,18 +1257,18 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 			/* test the auditd connection */
 			audit_replace(req_pid);
 
-			auditd_pid = auditd_pid_vnr();
-			if (auditd_pid) {
+			auditd_pid_nr = auditd_pid_vnr();
+			if (auditd_pid_nr) {
 				/* replacing a healthy auditd is not allowed */
 				if (new_pid) {
 					audit_log_config_change("audit_pid",
-							new_pid, auditd_pid, 0);
+							new_pid, auditd_pid_nr, 0);
 					return -EEXIST;
 				}
 				/* only current auditd can unregister itself */
-				if (pid_vnr(req_pid) != auditd_pid) {
+				if (pid_vnr(req_pid) != auditd_pid_nr) {
 					audit_log_config_change("audit_pid",
-							new_pid, auditd_pid, 0);
+							new_pid, auditd_pid_nr, 0);
 					return -EACCES;
 				}
 			}
@@ -1298,7 +1281,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				if (audit_enabled != AUDIT_OFF)
 					audit_log_config_change("audit_pid",
 								new_pid,
-								auditd_pid,
+								auditd_pid_nr,
 								err ? 0 : 1);
 				if (err)
 					return err;
@@ -1309,7 +1292,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				if (audit_enabled != AUDIT_OFF)
 					audit_log_config_change("audit_pid",
 								new_pid,
-								auditd_pid, 1);
+								auditd_pid_nr, 1);
 
 				/* unregister the auditd connection */
 				auditd_reset(NULL);
diff --git a/kernel/audit.h b/kernel/audit.h
index c57b008b9914..93074c2d4346 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -214,7 +214,9 @@ extern bool audit_ever_enabled;
 
 extern void audit_log_session_info(struct audit_buffer *ab);
 
-extern int auditd_test_task(struct task_struct *task);
+extern struct pid *auditd_pid;
+/* Check to see if a given task is an audit daemon */
+#define auditd_test_task(tsk) (READ_ONCE(auditd_pid) == task_tgid(tsk))
 
 #define AUDIT_INODE_BUCKETS	32
 extern struct list_head audit_inode_hash[AUDIT_INODE_BUCKETS];
-- 
2.39.2

