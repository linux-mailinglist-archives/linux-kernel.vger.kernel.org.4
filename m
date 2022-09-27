Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201E35ED0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 01:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiI0XAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 19:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiI0XAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:00:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6795376452
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:00:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RK4N1K026979;
        Tue, 27 Sep 2022 23:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=doGTvt4c218qallqIfNAD3gdoSuAGp87nU5OgkD1OfA=;
 b=M204EXvHMi4ByJaBtqxxad22QDpfJ0OBaf+6KVt3p54hWuQYl5vuWgMrrCvuz8uhWMqk
 UYQfnhZMk5dM3TATjyZNiLFfr2db0EvhG1RELtpiGe0dSwnlDeKl7fhlX8YMUpljwI2y
 r3/8/A+ywjNdt52NGT8DxAsYT2W1f9wBKAi0xMPpPw33d+9h1t0kVnNaTWmtaBl9+05K
 nZ3SST7kllWvSyrFOAY/DwVhFANDzBh04NFC2uSA4zZ4/pmyFSBkoRHUMsu4oGdNDqcQ
 GygCkDVPQn4DdUxu/dRW4OstfYmN4kG0YUmHPP4rHQRGm0GR4YV0en6OLmHwfsoSXze9 tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstpqxt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 23:00:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28RLS3xi002590;
        Tue, 27 Sep 2022 23:00:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpruqg3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 23:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWBaYaifS6ARbvkO2xMBnhg1EgeLd5K1NSLEc6c2kHzxYhnbr4koXEsdspAVuxNag3a6xkUOoaBuAtfDTJAVFtPSFv5RTH2OHIcLcCnD/+l3Lu0n1jjcw/1uU8qoJ7beSxJWzfF2Xej7PR5VtlZMUhr7OggvalKpgQrFBCvEbYAyuOpb/oyP2SWVcVryE0bA5PGnY+gze8ymYaWEIB6GtvZN5I8vnUx3TRu0OksqJJUj72ctSKsUMvnlATEqizuKX7OXuFS/2kgaLagkETMEXyZyyNq5tOkZ04AV0V8ij6oYphsrxjyZyYJ0+XDvrtPAoS2eFKRqKAkQKNmmu09fvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doGTvt4c218qallqIfNAD3gdoSuAGp87nU5OgkD1OfA=;
 b=apD34cWLcltTSukZSpyD6lEby/ygVm9QQf8+iXz83kDdjJBH7dW1cxDeAz7KJdSklV5ydgzbZ5+8mgZI99pQv2Q8iKncALM4Pas77YqdQER/j6QdTNWIP37raa13WLhK03csxtN65dP6vG3rA0u0NyxRGbI2w9q8YfwgLUs2CjPbTiTUQZLt8VuDzHnFb7Rs0s7G6XjnF8CCHe2raGG5obd0YK7SXXIB03P1DhXqcJRP3AVm3kGAdVZIA0lUhEQ3Lqs5KsRWRog+rvM4HyYQsuLVvBJxAfo/GHTz0A5mKgs0vmf7tLHkbZBsQceABnb0BCva4CJF5VlojHevTxpB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doGTvt4c218qallqIfNAD3gdoSuAGp87nU5OgkD1OfA=;
 b=lPbMHH/I6NC37cWX+CzYzVPnsaKChxVcC/x1oUcoYRqtwyARDgWHNCP+To50s7E+ipQ5F7ulMw/LhRKx1ustbQXLKlPW5Q4bSDsxU1tpSLyG+DU+rGE0YW79mzrJJtVYiUDv1cBf/FlwFM7guMn40xyLDIs1jzmtR0RkiVSAu9g=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 22:59:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 22:59:52 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-audit@redhat.com
Cc:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH 2/3] audit: annotate branch direction for audit_in_mask()
Date:   Tue, 27 Sep 2022 15:59:43 -0700
Message-Id: <20220927225944.2254360-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220927225944.2254360-1-ankur.a.arora@oracle.com>
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0251.namprd04.prod.outlook.com
 (2603:10b6:303:88::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: de9cae4a-dd10-43fe-bd66-08daa0dbfcc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raMfG1PZi3Cll8tFYulc+2iE9KHLyht/8arCytkvI9PrqXPci2haOtKwuMgtQOUtetUnZdwQ91ZlKluA4PEvmwABrOvTiDzVt/JCzH5+prnPS1x6BClDufR/fQ/df5O6ScRaGKzftVCQT4TkHulaF2GWSUgOti4ECVtQooksMDdaX4/Ck9qwmFQwQ53Onrcr9w0x4QeurJVSOpBSHZJrVUSDGeGcEOzf1JSVXHDcHcm9cI2qCDTXNZeZcSZmWJqCmk70nS5ncUpx9MpjepJYkwi0lZqvoV1gm6o07JdHnFxRG0AWsVCmbAsBGVtj9FtxKsOGcnPdpOpRHjWpGcsmGf85nWfqmVEObwacIws1+DsC1LQ96oQ1Msitv9dOcioLradNXukHAhnRKh/FO2je6h3oHiGx1rw+M5IXGqyehUL0W4IoOjy9ILSRf+zxu0Nf/oipGlUlMDsd2li8jiBk1mRPteyBqljIevEanbdEJLlbZKtSk+GBsLND/y6DN++1tcLQZBxScvEKjQNMTdwqzKbqDSOQpq0BkgZ9bsOvO1IgbbhcsZRjD1MFwkAc6njfIOwYaDzG7aJuN2zwrCDy1bR6hRWsYGp/UrbEHJR3voZPe62iq+YQ0hB16OihCEyP4/8o/YRqTUvIB6+qkFstwZ7Irir0NTCPmtui7vLjnoCrgVHUvcOgel1chP1Zd3+keHGkmZ6rINVueO+BxNJMbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(1076003)(103116003)(2616005)(186003)(86362001)(38100700002)(83380400001)(5660300002)(66946007)(66476007)(41300700001)(4326008)(8676002)(66556008)(2906002)(26005)(107886003)(6666004)(6916009)(6506007)(316002)(8936002)(6512007)(478600001)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+pwxJfYeIuktDUiNnRn8XaWrSrbsoJ1o7ZDzUg6K/AE+0gtr1UrEq6LqkvOr?=
 =?us-ascii?Q?7VsDltvj1teGLJX+Hn1JvQKfOHpIRbKMTA+qhDYxsc2UCpb8YweUno2TJXwZ?=
 =?us-ascii?Q?aXYSCVmqEUpwhVqU565ZM2ed/EcHXbMdjjWQWakW8WXng6PbiCuUfWLBkoOs?=
 =?us-ascii?Q?b9Z0RIOnm6c+Ft6U2j+hovHIst/MGtYSUjluFWSxEXZhII44XjkhMCuADgHN?=
 =?us-ascii?Q?V/TcRmZ3tpPW2UMD9SXZ0o2lriPGpHb6/Ylu1dwuCumyViAOEn6RuCLFoIIX?=
 =?us-ascii?Q?illMNq8Vl+P2YWpynKiJuRxebxosGyH09D06s+WvwutvA1hNjCA2g9MiJJAP?=
 =?us-ascii?Q?GslBcSLX7ShRpDoHWwLe+vlnlyAezVQN0plh5T6SRq3eys5KSG3G2hXVYQqa?=
 =?us-ascii?Q?6WOrPdElM+GynW1k3jSVC0CYbPREk4riSdkzB/bBWubOIEua+y0D2+mdAvrN?=
 =?us-ascii?Q?0H/nHGbanXt9SjiluLFeb9Yw9McLyE9KR18ZNKstOrVSvcV1QtVFLIOGHQXp?=
 =?us-ascii?Q?2+NiOpd7JkestLlursTnNWap0HO58pdgyre2zEtyNhc+IXLEvH4277qX6w23?=
 =?us-ascii?Q?Q8DTII7j3eBxQCIUytNO1drcjfUCSMI61xbJxvCnRftSXJUR8KMpXkLlKzlb?=
 =?us-ascii?Q?opCki3ANcLe7ycHiPLio48EHcvtyGZr7LqM6GRgRVXI7hHLTMbuRPUIDL5R9?=
 =?us-ascii?Q?UcZB/P58OYtErF46VH7fXyQNTuXYali2JgGAM1nZkHEGWTS0NQQMRDQ2rtSz?=
 =?us-ascii?Q?0QM6O4eulIed+RuL1++XCDeLSxtbgQHPpCtx/IjXbU7l7Sqmc2a+bRtJWd2O?=
 =?us-ascii?Q?Xs1BW9+MWnGubkdaTIMb+0IY2klVUsmLuX86vyjc9InAxT1gYsUVKaCamBWu?=
 =?us-ascii?Q?ko6affOFxqvceaxQgA1+rpTX6qGry/rnL4tHEdBtm5H7hztBvr4SZmo7x3Hb?=
 =?us-ascii?Q?pg6X3g7vfQjfb12XIvYdfx5nut4ltN1nDDW4WUxqtUOKR6DLPiyRfExpn+vw?=
 =?us-ascii?Q?eJnWXlttHDhucs8ZoxU+15aouBY9IZ1wKjgPHgKohYn2BVd/n6z63KkovTO+?=
 =?us-ascii?Q?St9GIwoH2X01tdrfVA3F3vPeEvk9DptWZOEvFWedpYj2JBqX7UiGGg63P1ph?=
 =?us-ascii?Q?ql7rE2ai1T+NbqRRNzeWKLkQCtjx4eJAeaLNHSDnB9u4lTjReYi57aMWJhnx?=
 =?us-ascii?Q?oHz3kGQ2f995Cq0qLUbfhEEK+Eq5Ogn6P6Nfh1rF1AFWGy1OUnRd8Mj/Fw80?=
 =?us-ascii?Q?iIoU2LTZXFT5WnTfnL1nyFiNN2qyzgWREykyQxpda9OPDuH5zsb6/AVHLh6n?=
 =?us-ascii?Q?IRO4RUoA5UGyivlSQDi7Y2Zd1DAhy1Ai3SQz0dL6aWNoYFf+m4NwcDFEsphH?=
 =?us-ascii?Q?1LhXtHXsOIKlRckh8RgTIRnXTT4mw/1qFV0ZTX/lOYUY4ZnB+Lo4aEe23lm4?=
 =?us-ascii?Q?wsUOSLx+QzJ5w3rKT5pyr5leVMRDdaClRG4hyGdHNGDPCegvD3s/qFquFUJj?=
 =?us-ascii?Q?DHyOixkRNw7MHR4uXsRl2y37jFzaEFW1mRe++GothPEU5ER+rCKHpvORIwKD?=
 =?us-ascii?Q?/es/0jM5ERL7ANdazIMy8+MlUcBdLdq8vbqglyHF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9cae4a-dd10-43fe-bd66-08daa0dbfcc4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 22:59:52.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d53XzvHardYjhp9KF3G7DW0jaCTQhSpgIbxVRTHgvPENUKzdqCMHiIm9hMjQwoyrxIZhsYWCu315cC9pfyQnvlxnKYZJtxPdvmfKHUV55OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_11,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270141
X-Proofpoint-ORIG-GUID: Z_BTAAb9xJGqByzVkMPpu-hFUF9IQgUx
X-Proofpoint-GUID: Z_BTAAb9xJGqByzVkMPpu-hFUF9IQgUx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With sane audit rules, audit logging would only be triggered
infrequently. Keeping this in mind, annotate audit_in_mask() as
unlikely() to allow the compiler to pessimize the call to
audit_filter_rules().

This allows GCC to invert the branch direction for the audit_filter_rules()
basic block in this loop:

 	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
 		if (audit_in_mask(&e->rule, major) &&
 		    audit_filter_rules(tsk, &e->rule, ctx, NULL,
 				       &state, false)) {
			...

such that it executes the common case in a straight line fashion.

On a Skylakex system change in getpid() latency (all results
aggregated across 12 boot cycles):

         Min     Mean    Median   Max      pstdev
         (ns)    (ns)    (ns)     (ns)

 -    196.63   207.86  206.60  230.98      (+- 3.92%)
 +    173.11   182.51  179.65  202.09      (+- 4.34%)

Performance counter stats for 'bin/getpid' (3 runs) go from:
    cycles               805.58  (  +-  4.11% )
    instructions        1654.11  (  +-   .05% )
    IPC                    2.06  (  +-  3.39% )
    branches             430.02  (  +-   .05% )
    branch-misses          1.55  (  +-  7.09% )
    L1-dcache-loads      440.01  (  +-   .09% )
    L1-dcache-load-misses  9.05  (  +- 74.03% )

 to:
    cycles               706.13  (  +-  4.13% )
    instructions        1654.70  (  +-   .06% )
    IPC                    2.35  (  +-  4.25% )
    branches             430.99  (  +-   .06% )
    branch-misses          0.50  (  +-  2.00% )
    L1-dcache-loads      440.02  (  +-   .07% )
    L1-dcache-load-misses  5.22  (  +- 82.75% )

(Both aggregated over 12 boot cycles.)

cycles: performance improves on average by ~100 cycles/call. IPC
improves commensurately. Two reasons for this improvement:

  * one fewer branch mispred: no obvious reason for this
    branch-miss reduction. There is no significant change in
    basic-block structure (apart from the branch inversion.)

  * the direction of the branch for the call is now inverted, so it
    chooses the not-taken direction more often. The issue-latency
    for not-taken branches is often cheaper.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/auditsc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 533b087c3c02..bf26f47b5226 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -789,7 +789,7 @@ static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
 	return AUDIT_STATE_BUILD;
 }
 
-static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
+static bool audit_in_mask(const struct audit_krule *rule, unsigned long val)
 {
 	int word, bit;
 
@@ -850,12 +850,13 @@ static void audit_filter_syscall(struct task_struct *tsk,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
-		if (audit_in_mask(&e->rule, major) &&
-		    audit_filter_rules(tsk, &e->rule, ctx, NULL,
-				       &state, false)) {
-			rcu_read_unlock();
-			ctx->current_state = state;
-			return;
+		if (unlikely(audit_in_mask(&e->rule, major))) {
+			if (audit_filter_rules(tsk, &e->rule, ctx, NULL,
+					       &state, false)) {
+				rcu_read_unlock();
+				ctx->current_state = state;
+				return;
+			}
 		}
 	}
 	rcu_read_unlock();
-- 
2.31.1

