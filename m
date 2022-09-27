Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A25ED0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 01:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiI0XAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 19:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiI0XAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:00:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6BA6747F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 15:59:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RK7neZ009576;
        Tue, 27 Sep 2022 22:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Tvonom0PvcA3/IzXL46kUpM60KUc24MMytnnZVRIDx8=;
 b=DPpt2FhT7P+Ddhvra4d4EVKOBw0UjzVgpZhDJzmtqh5mzfGxQtSIBEVXXYR2wg61Ld3q
 57sXy0FJRSJPvTvpc8oizrcnO8WXlMo43H5GF6lzbAvxjuyiJGRROj7hK8qZ5XrfuwmK
 0cW5+YUyfXvkTwosjTz2G1GXjPDkmD5yMfxHnKfRyjSE3msFeFy26ujmSeuy/3o8+Ned
 6P/DRCnTf2aHuQBWBj7sGN+t5g75a1IfyXmC80TRMH8esgGphlQnb0MMPL8oHw9y8GwD
 4/ngmtaAuIPEMKdtZUV4BD4WPU8VcFIAnR3Eo64rnOz1zLEBmbQ0jkP/jQz7tdF0E7go YA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jstet0dp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 22:59:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28RLXSrZ001509;
        Tue, 27 Sep 2022 22:59:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpv0ypj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 22:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge3XjqQIQISYOxL6jvALTlWp5I/vzf7sIdVGMh04trSW2B7vCRI9tWpkxVJrIK8iHRuSo9n4AYqlo9naITvFSiY+v0k92e+RZ6+1G/HKPgO2X+/D1GLFrpXINc0EqxWn0knhmLOdPQKT87v1dLU4Xe3FrcFobumF8hpvyTtx6JW0xoZ9hXrJ/G+TcBnwx+wmF0N4uPdsGWdVGddNPcy4FGSG5HsuH+B0IN41WtE0HXC55JuswKTRdeb/9R8JjEjK4jI/NtUzzgQ0NKGSqWEhTn5zhEG6td7WNhjDUq5kSX1Vn+fy6L/FImIHv87cgcbodcIqQoLwk5qzVyQETNTXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tvonom0PvcA3/IzXL46kUpM60KUc24MMytnnZVRIDx8=;
 b=doUCZ0pAK/1ygRUVLgw2T1gYcKOQ/RqiYMHAOYwAwBGB5y3lzsrmovQMe9Q9xnG/JxL72c+uqkK/JG4ECJUiDjOBkgYTT/Irdlp5yiL9gC0iOybcV1sZG8XvVVt1OpF12Pg9CtFP3oMNXbSDf1Hhnpo3gqPfJuawplO44LtFuqxPLLqSyZ1ecGT0CBmcz+gAT5bSmqEjAHqt7p6Vm4GDlnKkMLijUWZUuxFDLW3fZ1R/Ww+77Flnz4MjTOu1pnjfIGL4A2Ni7OOdDKqbaNXKkC8ro1NkV/I9nTzRKc8lc4nXkxjt4fi69xQLux32CcxZzfYeLrCXDfpxjBbooh3m/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tvonom0PvcA3/IzXL46kUpM60KUc24MMytnnZVRIDx8=;
 b=h5ZcKVD7FrMLXPFgWTAvDybGzub6GfUDpGvce2hfw5Iy+7Oe/F596CdMjHB3+2d7dDybovRHjOQqfiZhmwmuThCZsGgIUu9LQrbICp9MJ0LTM8BmqaYfrUIFaQPF7eI8p5kHT76dpekoMHx8VT/LrrH+WP4A/OaJMWip1ZLE7xU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 22:59:50 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 22:59:50 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-audit@redhat.com
Cc:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH 1/3] audit: cache ctx->major in audit_filter_syscall()
Date:   Tue, 27 Sep 2022 15:59:42 -0700
Message-Id: <20220927225944.2254360-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220927225944.2254360-1-ankur.a.arora@oracle.com>
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0308.namprd04.prod.outlook.com
 (2603:10b6:303:82::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 02edfc00-299a-4e36-8df9-08daa0dbfb3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svPZW8ZK4pphn6dXZm1sr8mVVW1CKQoTP8V9b+RLhAr3AQCNtn31aqfaM9gU2SSSD09rKVCgFxxMIxv4hdb5eQEe+Ty7oobwdBVis4c0LQJkmee9X7QoBL8t/k1QIAwggKPLXOtlceFCiV9UnI6RATayNIqnQLSOonfgfd0c3OnBIGoe5vOnjicBwLPlOhNkKOg+BQoJ9xlUaq9Fayp9lA+pgHyzh9xYAfW0qkJFLzT00j2LPYfbND18cmX7Bq4pQg0DjZtXtZUrVLdTkuxjKe1uvgPROB8N0jf64Z/l9eyz29SatXYhUruYrJsFmmzUjvQyRT6wwNxElXOz59Zxj5UFNpBQAONae7k73k2NkVqW5YL/cIW/CRfOCdiCpq+2tUt5dU9goTLM3mF434p4pck7M+bdNYSOvpOs4M2MfObCkqqTutfdlgzFaX7aEXLyoXJsXTlhK6vLP18oA0G4EAQrHnBYuurXciA+gAIGSrSZqPxi2NYI+lE/UAAUtOmSlIOsIA1OZFdtk1fvr4/bzLHz6YaKf9B8tfkHr1rSaFGzizXFQNo9Es7dm9IGK9wiN6MPrlYhLkcYuFzkHGySjUi7LHLt/qMbi5MvG6ZBB8v/n5Egw1164RGu1xU8DzrauNXaIdsP1NuvzVT5H/bgZpebHUrXq9nKgLKGFkN8+ZtSmzpa6QFLU5/81B6bLz5R6WZcVBkkjgQ2Pqw3p2gYAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(1076003)(103116003)(2616005)(186003)(86362001)(38100700002)(83380400001)(5660300002)(66946007)(66476007)(41300700001)(4326008)(8676002)(66556008)(2906002)(26005)(107886003)(6666004)(6916009)(6506007)(316002)(8936002)(6512007)(478600001)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iP/C9KkuEURBtqImkpoRmEeYIigXSl1xqkYPwyGc+mCrmvBkuGeN3kglUPfw?=
 =?us-ascii?Q?ObsNPrsY/iNgBPOCSieS60Y/t1jRuK/6KooHLWy1lVtNPoH6/res8K7EaxHT?=
 =?us-ascii?Q?akJONTkg6o8ivkXnZqH8GNAY8rHfhYsJxq0xz4NbSgwWoC+EqfiTIhksxysK?=
 =?us-ascii?Q?oxbEhnbbvHQK6+4iSDFb/rUocScR0CBa5KghscdCAlvoSqj9g+QCAakDhJhX?=
 =?us-ascii?Q?x7RU33dO1ICcyGPN+IlF3UsVLseDuRAPDxfU1dDza1/rmoetUG2N8WqLRq8q?=
 =?us-ascii?Q?DIK7HaYZU4j2iMLwqO9RSdHKAfmhNTcNfeuH5otxjuGyjglRNQVi+K/hCFWX?=
 =?us-ascii?Q?gNDb2CdtOv+cI82G/ACUcN8loAvrj7CNtYGMK4sZSN9qy/DQ42z6tU1oyQR5?=
 =?us-ascii?Q?j3vuN8uHv+Ni5yz2hcHF4N1/sHAQjz3efOjxlPmvtjhtnabcdpXSrgs8MqFH?=
 =?us-ascii?Q?QWn/LjvKkxYVJY18OiMhw9KgKJJdKFoXE/7Yav2V2vG8/pkTNvsQl+8osSYg?=
 =?us-ascii?Q?HZrODrWicqWAEXvAHMnpTsyw80BNjqDLbxPl/9ANLumXzfKrZnheMWaTGykR?=
 =?us-ascii?Q?dzc4WJVbvXgttHUrGO6NehQJxwZbpDu8eYH8mM/IZNblQoefpxrkOwnsDcmv?=
 =?us-ascii?Q?Zd9mkBIchBaOivPvxwSncgE0WmCdOlLSkXstxPkHvcohKsWWa0drwWywxlJA?=
 =?us-ascii?Q?cjQErUzHxd82yHgumcWS/dORPZQAQyfFDmRzcPbGJiR7NT7LYytbPP3MYXR3?=
 =?us-ascii?Q?DEvkK24RywB/YdfPqi++hDz2DaJw1AN7S8LRZ1mn1X+hRkraunnTo8Y3HWvc?=
 =?us-ascii?Q?dXEmrZWXNc8j/QASB6hsMyjsmNtdwZ5rpoWxZfBQTkyXLcgNyvvs9q4huOl4?=
 =?us-ascii?Q?c85vEqeUOo+8iqWOUKwwZ+kmmiCDVoT1HqM84UkEccfAgzlI6cix2eKJyqpX?=
 =?us-ascii?Q?6QqR9DYrT0E2vIpWpZxaxFJEJMgWty4pfkAnfZ4j23d93mySipQmQ5a8tX8C?=
 =?us-ascii?Q?KCr5KMSQ7cieOFA5PO/WoRi5R+KyiAKlRY+RdG0JSL6FA/5TDnUOdRMFylW8?=
 =?us-ascii?Q?q1Czi41yNFj7H4bkHPBBjEYsasT/hgdT1jI8cGc7YquMvUu5l1E/FmTSPFXc?=
 =?us-ascii?Q?/bpkpUShRb9uQLZGW8fTMxh2vSTPciSVs3X/A740qU6TrRyKbTOonB64J3dH?=
 =?us-ascii?Q?HxY1uvovyYlpIQG7d3AVoWtuNGMJ16Y72elAIAjossVi0f2RxwOklTgCtzzA?=
 =?us-ascii?Q?9DWEl/tXJuEXTe71aaiYKwSwr2weLQN0JQ5rEH5KtnLV8jFckh909ufMxFYY?=
 =?us-ascii?Q?TJTqFMSKeAS0ydDznPEuanm5Wvp4bVPTrgPh6xs22zaMQfXu0iEcIaayqgfD?=
 =?us-ascii?Q?uFkga8grQEUbBHT9fjFZOhL573aIStZBV3CUTp5M9SUNmCBJMIOy4D6X7eCa?=
 =?us-ascii?Q?i13z7kZfqDTcat5vS6GPz0Ej7oMCKkZLVyvDw8+yFHlS38Kfttug6UdjgbNk?=
 =?us-ascii?Q?jkWgTtLr5GsGqN48IgQMAk3Z6GHIsemAMNolP2UBot07Bl5pewno49KyDtDA?=
 =?us-ascii?Q?y/irGctl4LfMQd/u5q1KlziFgA0cdjIoxg5YRB9b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02edfc00-299a-4e36-8df9-08daa0dbfb3d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 22:59:50.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnvaNTb8VJVHySWTM8JFNeC3udiluiuZbYZnSvXS0Vh47YPOZDJhj3rf4EuJTOJi53/DX3w5LY+fLnU4pEoVmlj4Obwm/6GiP1I6CIU3MjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_11,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270141
X-Proofpoint-GUID: YadM-UBAUlDams3bmhQCuWEfI876zcnj
X-Proofpoint-ORIG-GUID: YadM-UBAUlDams3bmhQCuWEfI876zcnj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ctx->major contains the current syscall number. This is, of course, a
constant for the duration of the syscall. Unfortunately, GCC's alias
analysis cannot prove that it is not modified via a pointer in the
audit_filter_syscall() loop, and so always loads it from memory.

In and of itself the load isn't very expensive (ops dependent on the
ctx->major load are only used to determine the direction of control flow
and have short dependence chains and, in any case the related branches
get predicted perfectly in the fastpath) but still cache ctx->major
in a local for two reasons:

* ctx->major is in the first cacheline of struct audit_context and has
  similar alignment as audit_entry::list audit_entry. For cases
  with a lot of audit rules, doing this reduces one source of contention
  from a potentially busy cache-set.

* audit_in_mask() (called in the hot loop in audit_filter_syscall())
  does cast manipulation and error checking on ctx->major:

     audit_in_mask(const struct audit_krule *rule, unsigned long val):
             if (val > 0xffffffff)
                     return false;

             word = AUDIT_WORD(val);
             if (word >= AUDIT_BITMASK_SIZE)
                     return false;

             bit = AUDIT_BIT(val);

             return rule->mask[word] & bit;

  The clauses related to the rule need to be evaluated in the loop, but
  the rest is unnecessarily re-evaluated for every loop iteration.
  (Note, however, that most of these are cheap ALU ops and the branches
   are perfectly predicted. However, see discussion on cycles
   improvement below for more on why it is still worth hoisting.)

On a Skylakex system change in getpid() latency (aggregated over
12 boot cycles):

             Min     Mean  Median     Max       pstdev
            (ns)     (ns)    (ns)    (ns)

 -        201.30   216.14  216.22  228.46      (+- 1.45%)
 +        196.63   207.86  206.60  230.98      (+- 3.92%)

Performance counter stats for 'bin/getpid' (3 runs) go from:
    cycles               836.89  (  +-   .80% )
    instructions        2000.19  (  +-   .03% )
    IPC                    2.39  (  +-   .83% )
    branches             430.14  (  +-   .03% )
    branch-misses          1.48  (  +-  3.37% )
    L1-dcache-loads      471.11  (  +-   .05% )
    L1-dcache-load-misses  7.62  (  +- 46.98% )

 to:
    cycles               805.58  (  +-  4.11% )
    instructions        1654.11  (  +-   .05% )
    IPC                    2.06  (  +-  3.39% )
    branches             430.02  (  +-   .05% )
    branch-misses          1.55  (  +-  7.09% )
    L1-dcache-loads      440.01  (  +-   .09% )
    L1-dcache-load-misses  9.05  (  +- 74.03% )

(Both aggregated over 12 boot cycles.)

instructions: we reduce around 8 instructions/iteration because some of
the computation is now hoisted out of the loop (branch count does not
change because GCC, for reasons unclear, only hoists the computations
while keeping the basic-blocks.)

cycles: improve by about 5% (in aggregate and looking at individual run
numbers.) This is likely because we now waste fewer pipeline resources
on unnecessary instructions which allows the control flow to
speculatively execute further ahead shortening the execution of the loop
a little. The final gating factor on the performance of this loop
remains the long dependence chain due to the linked-list load.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/auditsc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 79a5da1bc5bb..533b087c3c02 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -843,13 +843,14 @@ static void audit_filter_syscall(struct task_struct *tsk,
 {
 	struct audit_entry *e;
 	enum audit_state state;
+	unsigned long major = ctx->major;
 
 	if (auditd_test_task(tsk))
 		return;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
-		if (audit_in_mask(&e->rule, ctx->major) &&
+		if (audit_in_mask(&e->rule, major) &&
 		    audit_filter_rules(tsk, &e->rule, ctx, NULL,
 				       &state, false)) {
 			rcu_read_unlock();
-- 
2.31.1

