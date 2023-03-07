Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83FF6ADC92
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCGK5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjCGK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C9A574FE;
        Tue,  7 Mar 2023 02:56:49 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32783r29002147;
        Tue, 7 Mar 2023 10:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=aH3QiSSDoKP7O5PCyGmv+RmzwMLrsmbkLrjNr9mvqeY=;
 b=gqPfwmP8H67xvIO52f2Q1c0+ZjE4pbDuaAmlZ15kGDIVPLg8tgYLwAi2UNdt5aCKVXlx
 SDdSlO8szaXgV5aAKYI0T5j5s5z2bx1V+rpxnlaw+5A2KPm7H1mHRnOusDDx+3mlhL3B
 DpHqJ5/nA+unO6shANstNo5Vdr7h/vQZ+n7J2QtS3JPGSXP4k0HhSx3JXn58W7Rup+qO
 W6VGpTTRy8XCz22jCj6403BVgjd+o0D2IwD5nwrpMJIesdBfVZxvjfk/PNkzxB0jOdES
 nDmI4ZSZZMJNjVi+AovfNc1uK319HizIbihaf1EyFaAWITodIH+VqEtPd1X3AqQ838wZ ZQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4161w5fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327A86Sf037277;
        Tue, 7 Mar 2023 10:56:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4txeavfw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1wLqQz6bu0wN9I1kk7iJQj9xqGF2hH+cryN445uSfLh2gFAKG08tANliGcUSVzyNH7t97qAB4XMR3803zC3Qv7Zigg8wcQJfrkfrjgu8BVudfciUVdtHMGHlPmwQKpyriOt5c9Fr4NWkwiSvX5zdVxlBlF4jcYOsbDVB4pKtg7XcVj2jjNM9erUsnEfZhIYu1C/WurYF9IxuNISP+jBXGhzNIuoczXY+sClmiW+Ex6U7kABtsegtAYnXB6hVqufJHqY5nQ25ozA9Gw2ukKI/fqL7x9Vlv/hgRfSunywnMzJI9U+g9+dDmmRusUDBQPhZn6lCvErmeidHWoTd+wjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH3QiSSDoKP7O5PCyGmv+RmzwMLrsmbkLrjNr9mvqeY=;
 b=PJRKqCYqml5vzkfxEk8u57AVxHTThwzD2i8Wtb7txG4g2oYYj70geD8AiddG9f71WqpB5LAlXUC71QSSPA7dZ0p3V0OnpWHM2+JPPPymKrqd9fcKC4od9YaH5CHR58uIizf+rsA/9Ic4vm/i89C4ODwNq5VfTsMvCe2q5W1KCPRD+EGkZRTHB9jXpb0P5GZRZuBR609KU7Wtjqe6EDXO535CL1l1l4TNEX35Yb3L07jwwouZXbDB2peeXKmZzizQPeTOZe+5ZweuUmcpO9Kc6BL5mJtH3l5Sbv0q3mB3tX3brToFu6cZ0UwjSj3xkoopq2Yb2Lt3QJ2XnjQauhpsDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH3QiSSDoKP7O5PCyGmv+RmzwMLrsmbkLrjNr9mvqeY=;
 b=osiE0N8sWqg2xKv+kVsZVnnFxtkhIyWFRukviyXgtoc2g6GKkUQxbRXSJ8+2bfRS0Qxz1QuqF7OF65FlJgpFctwNMm/p2xiqarTtbAwitmrOwyZt5NuqzhRX2eXxoY8ht5UJqtYwCD22BQmlcxHtPnHtEtnPsDNjV/9N9ploA+k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:56:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:56:45 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 08/11] scsi: scsi_debug: Drop check for num_in_q exceeding queue depth
Date:   Tue,  7 Mar 2023 10:55:52 +0000
Message-Id: <20230307105555.3745277-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230307105555.3745277-1-john.g.garry@oracle.com>
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0098.namprd06.prod.outlook.com
 (2603:10b6:5:336::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6a26cf-bf68-423f-0372-08db1efaa453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsMpJ8jS57lCAzp+lHkFayRroeBMg82q4meaJWWIXKh+hcQfj1hx3x39kJKgG+9i08vAj9I1KcGj7y5bPHScf3ElwDi420fb95kxG0NB8QlVQNzidDaEfHt6w5pKYxtJ/LI7fbONqEuKEoIZqPR6sag+oxuIx6zhCqeCCMD816eunvfFlXiq2JwMaSyx0vZMGyUp1GPM0LNm70sLXn9+3mHhmmkBDIgDgQkRF8vkHOnmPqgnQ+4jtG1ozvNQolmtKXUjafjSOoUCUHlnpTzGKZt1Pl07J4l0gwq+jHutzNqIiHGJQSYUxWhfVFwZgFWuCNx1KUC76+lfTJUEBRRC/HNWhgnSqxn6BYM6wb3BN12mg5/gq4QMdmEpO6VGaTV3RVfpX5Q8dCK+5h/E3xk351iAIaHEcRxZNhPemsAVmIc7K5oEFBcA674vA6t2xttBQCdMcXwDpZBCKIGxjkgVdKQZrpfcowhwd0trD3bhqaEOrNn+2N9GdbhGI7lS0gENCPvgbTOsjZaLxuF8doKPCZF1mmR07TWnLImXCwo+xTLCkV+7neZqVVe0xnlxz8hgYXLT+5xbCBpaNyoUQjt2/dx7957IqrQeywRYeEK5bySKutii19y7XMwu8sior1u1VOK2VbC7yudTgVOGcqixUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(103116003)(66946007)(4326008)(66476007)(8676002)(41300700001)(83380400001)(2906002)(86362001)(38100700002)(8936002)(36756003)(66556008)(6486002)(478600001)(6636002)(316002)(5660300002)(26005)(186003)(2616005)(6512007)(1076003)(107886003)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?czI9ceaWfcZPRqzA/HAr9sW63uf/CynXKpxTEuzbOi4G16Cv7wdPc7mriqdQ?=
 =?us-ascii?Q?EBLN5pkSugH3lwGiHfhPcpgfMgOE/38BKq1t9zHzvVYaBwqWKpWYVSnnQAR9?=
 =?us-ascii?Q?mG8vjN/Aq6Gdq3MplkHOP5d3s/ljW9t8vV/2HoVtSM+YNNB7bQQFC4/rmwdu?=
 =?us-ascii?Q?LN0RVbbdZHQoFEemFwRqzOEudjN8y/A37Hw0mi6IOg6buEa/SmSL3/nZDyEk?=
 =?us-ascii?Q?DQgiF9xFZecKtIw8SFQ46rGouN8St3JjWrd/Sz1esdiOh0W4kworr3IsHQpU?=
 =?us-ascii?Q?wdnQshcEU3AbS4MYjkdWNFXC7Of3medx5GrI3r3+e9cmwmkd7fpkqSj1ffTb?=
 =?us-ascii?Q?AAh4mzzW3+V6kVFOpjZ929SlN6gR7PGH8W+ZOf8VSd/kClM9dJEFCLQUGtG9?=
 =?us-ascii?Q?dckDj8e5Q/IHwnTuaWHQlUfugPTQLGjzeB6t0sJF9S2yPLBgTZhOS3yaybJa?=
 =?us-ascii?Q?6iS/Cyg5F1RtVdO7TVuJtDxNiIsK/V3e+rfL0fuq/pQR9F5Yc0Hthg6amHFP?=
 =?us-ascii?Q?z3EuVAuWdI+c13wgBUWotAiet3tWm8GNcZOZSLe8rqE92cBnATNKJhv38ohE?=
 =?us-ascii?Q?UbMj7fQes4oJXYO5kFksvNjDNoig2wjt0Ew7Wjg1iybDWLaegyRSKO7getGl?=
 =?us-ascii?Q?8d9dhjtTolDf6sTQ7WgUlNn7qAd0ljxPceSQ3xRrBfV1mKnOW5QOFG+YVMjS?=
 =?us-ascii?Q?X9axpGwDLgs1gQ1f9wXeGkY93TdPR/rWEQTF2TFuKbBLLIbcDPFe66oaNv3o?=
 =?us-ascii?Q?RJWc/qmuLQM5OxwsPUrIjwjUY5fTAbcNLzLCgcObybWUYUkUiRQ8uw8S1sz7?=
 =?us-ascii?Q?g7xl8BXqX0X9hVI/pWIJowcZ3tw0YOxPbm8XQsTHfcyHHzmeLp+O6KI7dG1V?=
 =?us-ascii?Q?4nJnnX5CGTkaJ0RzZphs9mKqiCox7DJ7fpOGOhcKMNIJqg1K9DslPdTab9aU?=
 =?us-ascii?Q?ShQWu3dPSdXkmjTyxb/xpub8CbBMVfIHeCu486cBWztOPOsdkMdEFaBWYjRJ?=
 =?us-ascii?Q?zTiXADzgGRTjcoC2FAbbzNDaceVpf8I9bF8yvXFWNnex685TV8CaJcSNSLFA?=
 =?us-ascii?Q?Tvlx3gN1rW2luej4vn+8HKMSq5ouQjekyiWTQh1SPAkJn3AfoBZDELhNECJ8?=
 =?us-ascii?Q?4H4anAOboySg7aJ0tgcjOXVJqIlpfVv5tMM5+H4kf0XKmWlqWfeEtkCV28wE?=
 =?us-ascii?Q?iguY3ieY48enQ87LjrGW4BKpKv91Q/CZp3DYdcPRigN+WzqhYXM2t42uBUzK?=
 =?us-ascii?Q?SkjNBX3Pnoe/3zxStklJN2tQzWWqOunpNk0qeKx6EBtA6b43gz8VW6WQalu2?=
 =?us-ascii?Q?JBWBrHXCvmf8Idw+KDHFyBShRnHelfhW8c/5uKPs2zVfpvO5hvwkoVUxkKR5?=
 =?us-ascii?Q?E5lUsDM9doIK10QWh/kBrD21+NxPM9U69Zo9Ep9yuXOul9sLvPVtFtqtn598?=
 =?us-ascii?Q?VQe8ce/t/IJyYpraAiA09LZIwIcvuANJ97C+YJ21GSzEhNCN0fQQ35KhHF2/?=
 =?us-ascii?Q?dx2py9jjF7sRBmnCzSjGpRI6W3bmRFAgoiPwPDP2ZKXUJcrYO2HGJube9Ve0?=
 =?us-ascii?Q?JSYteR01pBMXzvOLDTJvQdH3l5f+6PZivcL/tZmRa+Wa825Oky++8JDFlLoP?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: urAnGyvq0wqREnvTCLjOZ9LHvjVXqaFJ6oMZfOSQhCrM8EQ4noib4+kX+RY4hX/OjY/qf++v1jHsAaETlEtZez+uKOwSm+umTDEfCDEbuumdo+VjxC/WKQVvsYeufwJf49eXBrpbY3+6wsEAR2sJYjwP0iWgamPy4K14A1H9mMosOibBeS0FMlx/qSSp6ORLrzqxzRgnXSBls6D3zgDR2Qrx7wUsh2NJl8LeJo4hAHSur50uCr8INE8LTd6OKzk5cYmyIGKIITE8HcW4fYIt5BCimjg7mzespRdFZTg3RChSWvN9xt6v4N3ajwG+WttvfX2qTzkpDSS+fF1M1U5EqwRmCSeXRsOGRHxWRDoc/0mVQAEujpXWGKwiYNTQAtplEVA/99LSGb/XCp06fX1MIMHE6ceH6NXn5zS+qdyQw1jOlHcKnzz7M1E1UAM8ZdEVsNRiCJeftajRhSDllYkf7TpQiDzDJhfujr4qDuQ+lhHibo7A7jvGf6HeEkAI1lmAfuHfqLaJgIbu/e+L+4kz9L80gdLWGk2+m0pO6lm7prf8y4fdkpzyqsr7c8j021gXlHLK8cHDZnH3xMB8ShefHaEeJVLyXH6eKKuiLtiTl+QKJ7Rx9lNJ5p7/YPr78mLRGizqmWLuvKPKgbQVRMN3D/oTsZzPbyr4VgB1blZktZ+VV4QPtKWYm4irdxQRlUz7Ec6MAiKrfUx8IS5ThVvEAKMzkcUYkf1HQD/K+HehnXstVeDfPZHtQmxzOrbi2p83R9JkHS36vnlC99hpeWVNjkYVJOU5NPqduj6tNUEDZ3Eh8IrI+5XRs69x0y6m0VnwJXuf4P3T7zjOlldODxJdAw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6a26cf-bf68-423f-0372-08db1efaa453
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:56:45.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmGSjzEePJQSfFGLwynFCvbQZVTs+6Bl5bhpQMrk3uB4FP/9VjkIvVuoDyWQSNWCksULYciZ6mXmYXIQSPgoig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070098
X-Proofpoint-GUID: 7CIIjZz_jvPlt4R0ZuqKSf--GUq6j1Z6
X-Proofpoint-ORIG-GUID: 7CIIjZz_jvPlt4R0ZuqKSf--GUq6j1Z6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-device num_in_q value cannot exceed the device queue depth, so drop
the check.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 6707ccdc07c9..fb7434d09cb9 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5599,15 +5599,8 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	}
 	num_in_q = atomic_read(&devip->num_in_q);
 	qdepth = cmnd->device->queue_depth;
-	if (unlikely((qdepth > 0) && (num_in_q >= qdepth))) {
-		if (scsi_result) {
-			spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-			goto respond_in_thread;
-		} else
-			scsi_result = device_qfull_result;
-	} else if (unlikely(sdebug_every_nth &&
-			    (SDEBUG_OPT_RARE_TSF & sdebug_opts) &&
-			    (scsi_result == 0))) {
+	if (unlikely(sdebug_every_nth && (SDEBUG_OPT_RARE_TSF & sdebug_opts) &&
+		     (scsi_result == 0))) {
 		if ((num_in_q == (qdepth - 1)) &&
 		    (atomic_inc_return(&sdebug_a_tsf) >=
 		     abs(sdebug_every_nth))) {
-- 
2.35.3

