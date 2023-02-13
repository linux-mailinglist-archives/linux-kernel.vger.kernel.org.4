Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A422693B89
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBMBAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBMBAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:00:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BEE93CF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:00:43 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CMOaov031940;
        Mon, 13 Feb 2023 01:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=rJOQ1LaZH7f7QpviFzPATJXPfOIZ3hSpMzV3kYQ/XtI=;
 b=OvDE2pUehjbli7O2edajMs4a/gop5WxhT5Xl4bEVKCXB6hlbBVq4BgDofE804ejHDcH5
 dF372+PcqbdSB/EdLSnV3AQz+DBrGmrOprTgwmrlBPs18AOsgI5u+XzyWcXd9uUbnCXh
 qMpZXuWWYk0AnoVCPFnb7e56rKK881UJe+2e6CxLt95AiPiGCBBAwx+cM1gHJH7U2wtd
 4A6BV1CdMa71wHbCXaqRhQitqdm1P6jPPwV/Fq1ID0hfLPLGHpi7/JTBP82ziLOdNzzq
 SyXpzDmIloM753kBU+deHvZKshBp8eBHzCzVdk0MdW4tRfrqgfwRUTVAXAREIOI3RkHp vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mt9npv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:00:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31CKVBA1013539;
        Mon, 13 Feb 2023 01:00:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f3gbd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:00:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUumJympmRm2CcnnsI6xf0rWAavbeGHDA/o7jmQL7d+nUEAM4/VbbF5P04xbJJbKysmXIsi9Piwqy55WaRD91LesRqPuya+Tp1v4YJHpaCvI5PdkJkMVe1KhJ28cVfbgiBVWH5saPe72YUcvnIZ+4AAOnvRINgaS6NCtS/rsEeyoUnohNjJOeekVK1HIvPPeO/tHvnuNUsq6Y9XbivPStzD23VCYiSmj0S3tKyjr8ZvhCFCdVWnF1hrTqatxbqTQ1YAv+1AQ0BLKt3tuiiF686WltOF9E4WXM5G6SqJt9hyX+OSbc59bzz1NK5DLFCqxZTbhqYBp5UHIbtURNKTRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJOQ1LaZH7f7QpviFzPATJXPfOIZ3hSpMzV3kYQ/XtI=;
 b=JxNRpZHKWukFA0XwiMwnTwesTpnweP8GdzgenJwRuSZezRCAxkii9feJgrkc3gd8OvxnNf+47cGxbL1sOudVqhjs2vzjQ0rLnt59sUm5njR/cHp6QJjO4SLpX/2h4cv1Kpa1FcGFVLo+cbi251OiZ/lBNqNkoPmc8s2m2WgRJPC4ejALhJ2m/bU6+ND5Pt8Ohg+htlEKI3pNgvDMEr/jQZtZl2Bc3tFzldRPNuQmu/HSi0VID7BFGifdbNbhxw8V/MiA9fR8xvmgKevkVmx7LUuBja6TVyI2Cn2a28uapFRQ1cZ5Dfpb8PBNV7jSK84SqztHGn3J+tyaFllNtrg4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJOQ1LaZH7f7QpviFzPATJXPfOIZ3hSpMzV3kYQ/XtI=;
 b=u7fVu7mOxd805TmH5RNVK8tLHDFE1ZCjVi2QB4lcfK9C91jIfbJMBFEyF9iRoDevBzpxQA8dzve6r1c/QOqkc9qSseNw9q1xt8POzc42KElbJHPgu1cQ8jdCvEwDGwun4hS9JJB/6CbACYuYfOHr4JNLUggAcx6GDBozaz0druI=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH0PR10MB4921.namprd10.prod.outlook.com (2603:10b6:610:c2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.10; Mon, 13 Feb 2023 01:00:36 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6111.009; Mon, 13 Feb 2023
 01:00:36 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 4/5] kernel: Prepare set_kthread_struct to be used for setup_thread_fn
Date:   Sun, 12 Feb 2023 19:00:19 -0600
Message-Id: <20230213010020.1813-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230213010020.1813-1-michael.christie@oracle.com>
References: <20230213010020.1813-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CH0PR10MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c209bb6-2c1f-4ab5-22d4-08db0d5db764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lwm6eH+hpWf3x5SHAxmfMH+eX3CiTNx5n+dv/EvrigyFtSQfCYEMRsb8H7aFNSq08UJZsmqVhGQyfiR0JXK+6vhb3A2fpUjGopU8Wv6Vn2TBDPwuR44bt2Z+VEIBA/RpvIrCMHljs7ZkFYxxDS1Hd/JoUgdpnp9y9KmzHhUIxIKS0uzYBkMva00P8UeDlU+4lslZ1P2DwmGHBKTKI8Mezb0mZlw0PZW1VmrWnyMy+5kNNN1YKzU0I0Tjc65u0XgwxDVEGmQA1x6J8Yxd/V0OPTNVI8ODFWdRJro/x0CqPwIkKVLRMisby++1g3NakmKiwL/VFWOvkShaPt5du2+3sP16zepQQOG8MLF+uErCKkc+Taq7QkEO31Xc5wwyQ+ogL+L1MZEjATukhWtTFGYoIlqVvVA2TfqlJwbqJLOrcIj9W55LE3fBKjhB1LyFR534I+ttVvb//NHE0CycvXeHo7U61SPeaZw2pc2bkxWGmvJtF8EabL4gy0sTIZQ4Fh6imeHdBsqPw1rs15Wfi08OsoQexPi3xgWmjViyUY4qdPdmPdodl/r7TbJLJhw/LNkCeH/5MDLzInK3F1LoDuv4Z/Ryt1TfbsYb2RHGgJyGuBNopRvMo7IehKcQ0npuxD023y9Jp9/eYb57Gc8/z6S22w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199018)(8936002)(36756003)(2906002)(5660300002)(86362001)(66899018)(2616005)(83380400001)(4326008)(316002)(107886003)(38100700002)(66556008)(66946007)(66476007)(8676002)(41300700001)(6486002)(478600001)(6666004)(1076003)(186003)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tmKrEgwIpWsTyP3ysVtbXURta556JE5GITEZfQxa/Fn//qU33G9AR3zRZBCi?=
 =?us-ascii?Q?8Yu5L3TFsF42mDLFaVKkElBlrtrbvrxAlX36UwS0JuubLj0Uwn1W5y6fkEut?=
 =?us-ascii?Q?cCuUwFUjQhZ61MPvlXGbtX9YjT9zJhJlKp9gIqCUWHoDlMqy7EDyqjFr0jhL?=
 =?us-ascii?Q?EVoDnga5Lr1kwvpe9fdQ+1lE1zPTzqvUIOtlpL6jgvEO6MUzx/oj44c2agiF?=
 =?us-ascii?Q?kvFNVUc5tCxd/xzGtl34o5qDiLVMro7srfuivLBcu4zAeNNTfho9ltaWWPOV?=
 =?us-ascii?Q?7S9xD9mI3qtmEBlR8B+smDD2B99wbimJ9HzZVMzfV7RFYd8OP9o3dF/It2JO?=
 =?us-ascii?Q?ZX1RoZ4Ct6eeWwIGUcpqvgd6skCFUxzHyksWxSFujuRQbVSpXzs4lrlkbcA8?=
 =?us-ascii?Q?DW+0TetCmFskMWcpuPAoJGjUSkva/B+YHBDcSALQO/5UlpMyDw7UaMRwFVOX?=
 =?us-ascii?Q?bAuWFLredKvEKGrEqN8WbK7HK5AepIaTC5Ak7/9JVzOG83mWpsTlWizklqq8?=
 =?us-ascii?Q?lWtK3V5RhPIkOQXkT2AErz6f3HqjwwX2AFFBY0NSl+Js9DPh/hsZcO2a5Ft1?=
 =?us-ascii?Q?W69sBmILpkDQV0idvtMmZR0JPbQNkIZKVaT0H8bIh2NT26D15oY1IXmsjeeW?=
 =?us-ascii?Q?OXm39xzmVuZGd6+5fyq95Pmgb3VEPclGNyoOqVIyiKJaxHYJKxArA8MP+jVC?=
 =?us-ascii?Q?Up66njiC/7iHsly6T6j/Kr1C+zUHzvgZLm2F+8tKourBtr2A48gN2gpTGpSL?=
 =?us-ascii?Q?zKuCKBTR6qP6s+YEgLoM8pmJhbbI4x3N2dh9zyfy2HWsNNP2g9b+NujK6Nc7?=
 =?us-ascii?Q?XmtbPtwFsjfTt3XCi3vyURF41yed8CjjoeiNGr9dX42bnw5qFPD5n1STz32D?=
 =?us-ascii?Q?cbZLvIa4nUGOr02mi5E7tui7lABxT0qKSWXzimgAMN+58NDsUS2GGSQSRJAj?=
 =?us-ascii?Q?goMXxx4gmG7AQIdd0iL0RWZhyjkkfYE6jFju9uSm+M6SGgk4ALrVUstkH9a/?=
 =?us-ascii?Q?Oq/uCNa3MIHtWKAnFoV4108olFP8MO1XzyM1Uskv4BVjWj5OEibJ1s2XL6Ne?=
 =?us-ascii?Q?k85ovY5Pnt8pl6dYbOduGMbN7H0U17qPmdos7USUn1Lf1bet88yuvu3EVgfS?=
 =?us-ascii?Q?Jk2TgAo3AZC583lLp3nujJQLcZNv3k5v7i5KpHvj/xxBLskNh3wfjCpW8bae?=
 =?us-ascii?Q?z0bDPWd0ytjCHTBaKKUI6SdfoDkouZLR61HlTW8aNFkUmtOjkEsl4Q6Fu/tB?=
 =?us-ascii?Q?HGzLzCGoPq1Wy6Ij1ligKMDc7pfIfdDndN9tzi8OPPy8GtVnyuzlG3iXDhEx?=
 =?us-ascii?Q?N2GUvnHTjJafppD7K+9kSdOsbAfarZ0HKKOJQjNu+Kqoq0XaXVmEb/CISP0I?=
 =?us-ascii?Q?Es3XRm0k1VBtwZbpZcK/aS9Yf1ZLblM1Lf7raw3/eOjtP6aCkqEI5j4MvA22?=
 =?us-ascii?Q?Gp0weTIBzJP7JD3qxwbPf397v4MVbFajWW2HhngdNhNvVu6JapnfxElA+Reu?=
 =?us-ascii?Q?s2ty/YySCBdekFbKy6W4z5N7p907duTgWhysWaonxr/XKC+g0LnW2OsoKWHY?=
 =?us-ascii?Q?HoBzEGA0iesmiOluecmu7Wd4YzJbl3OClhAYbPWQGNpqC+R4xhkq/UGf2z67?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gMmlGCvaO6ikae/o6r3/3TPDVWYrgcIsddPpm2xmhZo1SfRsujZhkEMVGY/8fmWh5rsd5vD3J33++hkntwB98Ny7jyXisMl2eFRGT11bivACP2+mG7ryaMXAr+aOjwJYbScjd6sOLsvH2S3e18aWN27Dm2KcdzQdnSb2t5ZIZJGzR1f0ShH5CVsw21iILt8ezQ0Q4lEuEStss1rFuZGXSxX2zrvofhkekx62lHY0Zwh9a+FsBQgqPHGaYSVJBocnzrdAY6hdA7K9ARY+CWgnmOAPYVbuF18Qba2vfjUpbkE7jEWQ5BIX6QVo5Aq9D/adnFCCZmr8Y75teeLLj8myG1v5GXZepj3SMsq0VwhMz2wNP6R9tXUdSbxARbg5IW42UQdoia2ntMNJ7H9+0DAnroL9i69ykaWKcpZavqMAu1T7IwVsxH/ZHa15LRuIb5X/0nOw2oREiCP+n/tF7TJbLHf1YX+Nmcd5CxSyCd9KZieTBWVumBy3cDW5X67SKXIoWKig2jmL7vbDPQgso+oORZsBqO40Idw34GyaNV/8wpALSH2xs6yZvN/9FoAorKVsBxloWZACK5s6eDyB8MD1DthQ/1noC+ogoPveIvJ/gKy7WdPzniYugFPnU/vE3meZF+UUzTAce2obmbwhr4q49KsuOYQNecmRphtDI6/UIlIwoF6mOxtIYCz31TEnKT1hEpPdHmmIrO2TrYlxP0k7r+/RwKyyJueiTaUx0s5t17R+zB/Sa4AfcXPuJYJqCiKl9X0cywc7lCtCbF4hshq4/ef2YaS12zzQb0maUmtggD7gCYb3hLXmYeodgIpx8SpLwT0amTxvvOHXnOTP+5Cn1yrqaVnW1mV+Y4T3Q0DkUv0vpBupBoILrsul6A2+wKP8
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c209bb6-2c1f-4ab5-22d4-08db0d5db764
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 01:00:36.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: da4iQUl869Qz14S/8sI34UgfZysqzfOY/ebkfCayuushyg/Ho7zFckBwccnzOqOazM0yGb9aBzbjkPU5e4bPf1c+FXzKxjpkFjmB1Ek69tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_12,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130007
X-Proofpoint-GUID: GeV5u-bcwJHfxND2V62cAMi8tNKIUB5l
X-Proofpoint-ORIG-GUID: GeV5u-bcwJHfxND2V62cAMi8tNKIUB5l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This preps set_kthread_struct to be used for a setup_thread_fn callback
by having it set the task's comm and also returning an int instead of a
bool.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/kthread.h |  2 +-
 kernel/fork.c           |  2 +-
 kernel/kthread.c        | 89 ++++++++++++++++++++++++++++-------------
 kernel/sched/core.c     |  2 +-
 4 files changed, 64 insertions(+), 31 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 30e5bec81d2b..94dffdfa17df 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -34,7 +34,7 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
 					  const char *namefmt);
 
 void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk);
-bool set_kthread_struct(struct task_struct *p);
+int kthread_setup_struct(struct task_struct *p, void *data);
 
 void kthread_set_per_cpu(struct task_struct *k, int cpu);
 bool kthread_is_per_cpu(struct task_struct *k);
diff --git a/kernel/fork.c b/kernel/fork.c
index 057274da64fb..bd60ecc6b29c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2190,7 +2190,7 @@ static __latent_entropy struct task_struct *copy_process(
 	audit_set_context(p, NULL);
 	cgroup_fork(p);
 	if (args->kthread) {
-		if (!set_kthread_struct(p))
+		if (kthread_setup_struct(p, args->fn_arg))
 			goto bad_fork_cleanup_delayacct;
 	}
 #ifdef CONFIG_NUMA
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5e7c8f3f184f..b67c2caf2ccb 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -46,6 +46,10 @@ struct kthread_create_info
 	struct task_struct *result;
 	struct completion *done;
 
+	struct mutex name_mutex;
+	const char *name_fmt;
+	va_list *name_args;
+
 	struct list_head list;
 };
 
@@ -107,23 +111,58 @@ void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk)
 	strscpy_pad(buf, kthread->full_name, buf_size);
 }
 
-bool set_kthread_struct(struct task_struct *p)
+static int set_kthread_comm(struct task_struct *tsk, struct kthread *kthread,
+			    struct kthread_create_info *create)
+{
+	va_list name_args;
+	int len;
+
+	mutex_lock(&create->name_mutex);
+	if (!create->name_args) {
+		mutex_unlock(&create->name_mutex);
+		return -EINTR;
+	}
+
+	va_copy(name_args, *create->name_args);
+	len = vsnprintf(tsk->comm, TASK_COMM_LEN, create->name_fmt, name_args);
+	va_end(name_args);
+	if (len >= TASK_COMM_LEN) {
+		/* leave it truncated when out of memory. */
+		kthread->full_name = kvasprintf(GFP_KERNEL, create->name_fmt,
+						*create->name_args);
+	}
+	mutex_unlock(&create->name_mutex);
+	return 0;
+}
+
+int kthread_setup_struct(struct task_struct *p, void *data)
 {
 	struct kthread *kthread;
+	int ret;
 
 	if (WARN_ON_ONCE(to_kthread(p)))
-		return false;
+		return -EINVAL;
 
 	kthread = kzalloc(sizeof(*kthread), GFP_KERNEL);
 	if (!kthread)
-		return false;
+		return -ENOMEM;
+
+	if (data) {
+		ret = set_kthread_comm(p, kthread, data);
+		if (ret)
+			goto free_kthread;
+	}
 
 	init_completion(&kthread->exited);
 	init_completion(&kthread->parked);
 	p->vfork_done = &kthread->exited;
 
 	p->worker_private = kthread;
-	return true;
+	return 0;
+
+free_kthread:
+	kfree(kthread);
+	return ret;
 }
 
 void free_kthread_struct(struct task_struct *k)
@@ -131,7 +170,7 @@ void free_kthread_struct(struct task_struct *k)
 	struct kthread *kthread;
 
 	/*
-	 * Can be NULL if kmalloc() in set_kthread_struct() failed.
+	 * Can be NULL if kmalloc() in kthread_setup_struct() failed.
 	 */
 	kthread = to_kthread(k);
 	if (!kthread)
@@ -423,6 +462,8 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	struct task_struct *task;
+	va_list name_args;
+	int ret;
 	struct kthread_create_info *create = kmalloc(sizeof(*create),
 						     GFP_KERNEL);
 
@@ -432,6 +473,10 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	create->data = data;
 	create->node = node;
 	create->done = &done;
+	mutex_init(&create->name_mutex);
+	create->name_fmt = namefmt;
+	va_copy(name_args, args);
+	create->name_args = &name_args;
 
 	spin_lock(&kthread_create_lock);
 	list_add_tail(&create->list, &kthread_create_list);
@@ -443,14 +488,20 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	 * the OOM killer while kthreadd is trying to allocate memory for
 	 * new kernel thread.
 	 */
-	if (unlikely(wait_for_completion_killable(&done))) {
+	ret = wait_for_completion_killable(&done);
+	if (unlikely(ret)) {
+		mutex_lock(&create->name_mutex);
+		create->name_args = NULL;
+		mutex_unlock(&create->name_mutex);
 		/*
 		 * If I was killed by a fatal signal before kthreadd (or new
 		 * kernel thread) calls complete(), leave the cleanup of this
 		 * structure to that thread.
 		 */
-		if (xchg(&create->done, NULL))
-			return ERR_PTR(-EINTR);
+		if (xchg(&create->done, NULL)) {
+			task = ERR_PTR(-EINTR);
+			goto end_args;
+		}
 		/*
 		 * kthreadd (or new kernel thread) will call complete()
 		 * shortly.
@@ -458,27 +509,9 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		wait_for_completion(&done);
 	}
 	task = create->result;
-	if (!IS_ERR(task)) {
-		char name[TASK_COMM_LEN];
-		va_list aq;
-		int len;
-
-		/*
-		 * task is already visible to other tasks, so updating
-		 * COMM must be protected.
-		 */
-		va_copy(aq, args);
-		len = vsnprintf(name, sizeof(name), namefmt, aq);
-		va_end(aq);
-		if (len >= TASK_COMM_LEN) {
-			struct kthread *kthread = to_kthread(task);
-
-			/* leave it truncated when out of memory. */
-			kthread->full_name = kvasprintf(GFP_KERNEL, namefmt, args);
-		}
-		set_task_comm(task, name);
-	}
 	kfree(create);
+end_args:
+	va_end(name_args);
 	return task;
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e838feb6adc5..289b9941b58d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9925,7 +9925,7 @@ void __init sched_init(void)
 	 * if we want to avoid special-casing it in code that deals with per-CPU
 	 * kthreads.
 	 */
-	WARN_ON(!set_kthread_struct(current));
+	WARN_ON(kthread_setup_struct(current, NULL));
 
 	/*
 	 * Make us the idle thread. Technically, schedule() should not be
-- 
2.25.1

