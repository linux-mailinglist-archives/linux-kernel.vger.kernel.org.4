Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA744693B87
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBMBAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjBMBAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:00:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C014F93C7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:00:41 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CNUFbP028251;
        Mon, 13 Feb 2023 01:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=47YODoZvQySuPVZTRCtA5w2nC9XLO0G3an+/1je2NsU=;
 b=J0MrJU6+TNXK9aiFzvLdOqbNwXmIayAOrjTTN5WYknxPVN1hdmNPte/iQv4KZ1FW2CVD
 gyWHUCjv1Rp+oDYrhqAAnW5mRRVGjsy8IF9Kl+sjxTOAXaeS5vZ6RJjKDVee9cy23Hd1
 suQoEXw4oDlv2MuTrJLo3hvKBD6NA3vph3OYPGko5yr0XgH0QouV/b3TLMnoK2RlJTGT
 JSO/yB+CRmTl+i7AL57veqBenod/ttZsY7SM7zVUiYut9nIYESeHIcfwas/VR8QBW1Z3
 +284M7XS2Au1E32PwgRcXpjl01MiqITtpCaOM0/dUEJxmqdc1nLYQYw11UBCIxDblKWb TQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2w9sq0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:00:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31CKxTxp032648;
        Mon, 13 Feb 2023 01:00:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f3fsec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:00:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxqmnwmO/67dntMgVHaNAZXVDIS/oBeMOy0/Y5Pk2Fb3aGnGaz386CBVLV6OWhcj14lJA14Wy9Gq2ulXztptnk9iaPlafmgHzSCltDNBybEaogGtY5nObQDLRcoNZ0ZQSYTkn6zju9bXHoNuvf+tKqdm7TQ84YP/lEkrziiK1zWFBvVP26+5bM3AYFRdGomCE5rmtQfT29j5doavNMEawwCq2K3SvenmmlPWPh5qWwMTuBduh+v6DYtQL/gSjGhni0Q++CLpLn7+ALGKSsjU4neAXEFf4PrU3qes/PMxeddtz/zTHgv1F4c9mSy49ovhuaUAAr7p+YiwA/jQhwnErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47YODoZvQySuPVZTRCtA5w2nC9XLO0G3an+/1je2NsU=;
 b=US2j+FJWOFp6rpU+r1lxL1LlHdgSKLojhSN2drl9Bl6jzsEqgU8xGS3p76yGf5lC3Twvz/1bHepcQ7LYo3LI5KuFFeB2/GZwW5/m9CntP+KXAAaEI3iQAj5t79gN2bSbAyYxoYLFYECr3/R8Ev6FR91fn5yAByP+zKgNEHk5l9yB95a63O/+B1+tcCt9MXSEFuhXKOMf1UyaK958bHyQ3CYLbbwnf/SWKLWdItIWBhHALy9ptDDnQPetEOLN8RRo++7/Rei63A/a0jvzjzHBrWnv5TlBiz+shm9qHtLkeqppSveiWyQWCapP06h/Tn3Uir6D9axqV2Ur0R68MYKXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47YODoZvQySuPVZTRCtA5w2nC9XLO0G3an+/1je2NsU=;
 b=jJaeFYFgCV1gGNEFoaA6d/cD/XahiZjTJG/uWgBOSSA5KJGHHdY9rc9Yf7r2GSixqFdgjZXfPWFFWhksChtimR44A/NTzuI2u9AgkMK7n1+v/xW4V14SKijwaFfCvwj5KflvX48KdmfCt19Y+M+6i8b9FM5HulGQwvXFIAki8mY=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH0PR10MB4921.namprd10.prod.outlook.com (2603:10b6:610:c2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.10; Mon, 13 Feb 2023 01:00:30 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6111.009; Mon, 13 Feb 2023
 01:00:30 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 2/5] kernel: Add kernel_clone_fns function to setup task
Date:   Sun, 12 Feb 2023 19:00:17 -0600
Message-Id: <20230213010020.1813-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230213010020.1813-1-michael.christie@oracle.com>
References: <20230213010020.1813-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:91::23) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CH0PR10MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: 281049a7-e8bf-4448-010e-08db0d5db3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnJgyqGyagurapRuxU5S6C7pALFr4Inara+KJ5b+8tQXA//7h0cBwUieqT5INBl9DFp7KOUEoiiqQtvrcoAClHSaZRoJtMRal9k06WTRvtEZNzFhmrmcE4pgeUryda4NutIcu2S/Mx8R5aERUxWpb9+pqvEpjZfn75wNQ8AexbqWd/GxQO3SJtN0MOUVjbpFEa+xKiY7TDjX1wRF2S4rbVE4tHfA2FwI2rTxKW8zOqnZM+MSwq9kFpaxynYU52ZLOGzK9GJoextzwpmeGUsyKNTRbzPnY8yIs8R1+911VA+pw4pHybT/2jEdfOKaO5nxTYss679dIXTJkUfqczq7iiAYbEHRJOtdBKBErrWB5k1F2cA87k/yR+VKUDtbXJuqD2MDuCwBXltXWDYJVM2PFq8NDdi3PpKr+IvJh8wCSNZkoVge722mEKpMvSiJQbjpRFSVipD7JCsMjNO7/U77ARPwc0gnqj8q+uBM7kUGfeJEtMmV3+wnmQ0eWcy36/hVv/gIGWRp2miRJZXQl2qIk15nI7ODjKQfB7AoQp0jpJHDxNfdnuZ5GqVtqkbLZfD1HKhQc+EZhboyUagHwFsPZ6wQ2M7EpZ1CkMLle66zkYt+2837EfFpr9RkaiDl4sn3XkzGi0bIrSrplDlN3o4Kyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199018)(8936002)(36756003)(2906002)(5660300002)(86362001)(2616005)(83380400001)(4326008)(316002)(107886003)(38100700002)(66556008)(66946007)(66476007)(8676002)(41300700001)(6486002)(478600001)(6666004)(1076003)(186003)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZwNy4fMM9t5oIK/GekgnkV+JHW4IlU7wvp1ZWXvDwWkMCJfLIX9eCiST5PFV?=
 =?us-ascii?Q?KmmK05Os2bYGSmRnnxS9tjmguRd1GzMrLhLr8nU55rmn7PtlRPXYeVQQxwIc?=
 =?us-ascii?Q?/8vvdHuUag8E2PjPPVRH7cstsIX5EjyhipgMnCaHZuZEOLgYY26xn2I59FPZ?=
 =?us-ascii?Q?C0O+bZL9abFPQFLJ/6L2Y6W1NFZapb5ZJ0gOv8HCEWSeX2qL+s1mVXgGkE8P?=
 =?us-ascii?Q?zxgpphv9a1bo+vfYgomAVx1YyqZGQ64uw25BPTli0J363ufrrckEpu6Bwmu8?=
 =?us-ascii?Q?9EAO0h8NliUbv3tcHGSAC6U5HFWkg9R4KUloERITTZgCK18D7/2q/gU5CtsS?=
 =?us-ascii?Q?pLPBQZyG9Av7jaCRchC3jV8kLvIAWTvmtTOvwYDldXJKGVI3zU3dgA+78nKR?=
 =?us-ascii?Q?H1q8Tij44IbKy6xka+7O05Wxzmwalxx6lGiybesE/HMhWTa4U2Kp0SsYlTYI?=
 =?us-ascii?Q?Y9E7hKHijC2L4QQJmG/V7NsOM0ih/FyVDCxcidEymGwKsxWzx2kYVGkIT/Ib?=
 =?us-ascii?Q?PZCFvLwMltid/4ctcCnfHLDUq/35QgoEqdf9rR7zgYr86PHP78mZwTKn18fM?=
 =?us-ascii?Q?YltPEIDOb6MQvSFy0rYCKpSrnMqlaUGg44+UcpWaNqbqydW9CFemjZ+kB0g7?=
 =?us-ascii?Q?oC77rc4YyPdciz3Z/V0hFV1mKNjdMhS7ZRUU1rmvRe+TJrZlEWXCvX+zpJQE?=
 =?us-ascii?Q?yYQUe33BrqSLBNuqquXtnd2l1kEe4jYsjFWdZoaUJ9GW6y4WPJtnpOz89htd?=
 =?us-ascii?Q?l5LbEsgoAdWdEg+MKScRbv0bC4fFHMAycJrkDysuk3ZsNWVpvkF1B6/lJ/Wq?=
 =?us-ascii?Q?REuQgCEhku7lgS+KiP2AfPpsc4QxJ7XiZHUnU0aGpiPjS4nT5kYi6N0ptUjE?=
 =?us-ascii?Q?2nFD/4vZ8haT4nhthkA1aDICcG8FmnogcFe3/fMZZGTANxxJ9yzswSpZ7Ckv?=
 =?us-ascii?Q?Af+j9uKiB+mtQs1Gu/MGZiBdxRV9ZcuWXlLTSp5y/m1R+W70lL8oThl6wOvM?=
 =?us-ascii?Q?i0ZjUvosNh3fILDfdIhEd+iuLxk+MF6hAfZ7MJVuaYKfYt/JUf1cmyGJ7gbZ?=
 =?us-ascii?Q?PujYvSH0QPN4dXBtEjzqkm+hWhra1HJV0qCbkuUGRBmBE4nQj9SEtfSJgne0?=
 =?us-ascii?Q?cmQH8aeyEIzo21v+fE+a3tzt8pYxk1mzBd+G8xA65FYKR45sUnYE1V+hghuj?=
 =?us-ascii?Q?/7aT++DchFDkkKdgbA6G32+Xeimzdd+DDkE27mnBMNyw4bNJCkP+btoBNRXT?=
 =?us-ascii?Q?7Yl0Mm6s2pej3phqcG/BucVZjwyTXebJ3CvteVxM/QdmG38/0xDV8yUSufTL?=
 =?us-ascii?Q?7e19JCGsGTJCBmqZ8149yYASCwenZ08I9SNg/oU4iK9fRMmMlRVlhhk6QQ/Z?=
 =?us-ascii?Q?+J1DSt6T+UIR/cEsL1HW5gbKxh31DJbMxjpbidiCXqa/t+dEWJK/raBSEUQ1?=
 =?us-ascii?Q?BPkuk/OGBp3mrQmePDVzktOwofCnJMkjln0DwLW9nZIquEMkbkByA+IODDAJ?=
 =?us-ascii?Q?66ZmjWYNFY8S4RT8BSOf4kra4E/JHgvgLi50UrhY0aA2BWbaPVK7FlumGUwN?=
 =?us-ascii?Q?2fIdAS4pgdU/xLU87sNWxJVy4xr85H6FzZKmk9Z17h9VujO4dfFYK+6mcwUT?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G7kGqkt6FfwU/KFO7Xp/nJVRwtvFhbQCWFImtGWlMMEkPC2pQWbhRPEK6b7DEZ2J6G8x3MXb5nwKWO1UMLgszNzUDGvlkAkd8+xUxTe+GPVoBALYYnLIc1/Zxjxo0XCruwO0OgcyibT99RNyzkGqmAft9xBs+DzDZZUYEct0VL1Wtd0ZehQiHT23tWbOl5uIb+4c3bNzxfN07sQ2m8lGPN9EKt0VTnzffaqyYsa53Q+KHuQq0rRBWG1NOPIDcbGV8USW+u3MWs851VrMTb2d3woQuHqx4eECa/iLyMQZi4Z57OFRtpaH/Lh+nz1bNvepIYdJYCPFdQ1rGvl6r0MCxpRs62YzF2KQIz63wmbmr33m2WCRBEphepYNS1HztyRt+ijmQBe9TpeKysnmEzkmQ+/nV50x3cy7LsC/Sj/BsVBkjW+Wg32dTvIlOIOi1bNFQjgR6GJXfyFL3yTYPyC5H7BK60vfoLjhKEfPCa6FB/GnYB2/weCbTs2XTeaBjbrhZt7e0qrI2hIz8sVJ5ta/kn5j6WFxRJRr4dq0x6eJWvwiEIZfyt3fstHieCV1eSFfPqtXrjOaV/ZwfxOn+6pS16mVUuvis6sFmKC1RVdfNvA5C62tmqO8r8Vkg9o+txAppj5uaYQmRPafB4PJOKAOI7iCfBScK4Ek5gfSGuJcdLNaEuM9PA0xF02GBCO20H3W4tOrp3yEYNrMYvgx34aFqPZTC3/uJSWYy7DpCKvYGPvBQRMdI7UxcFnsMYM1DHxY9hRF1wmOftgu0Hiy5zdqwxLSOjn7aCu1qCfU52OerPloPRJOA26t+JbRpz7S22Vp/05kK2xrjyT0whhxPtzOlp0Ix1eBHzeuG5m1l/gB9B+Z0kNrbcM3uz/9z1tQgqQY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281049a7-e8bf-4448-010e-08db0d5db3a1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 01:00:30.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ay9orpkkp+xmLlmc6wMH0SZqSC3H33sXbrp+OqO3D48506ZyAGWOxiqr9eUQ+clrHz+a4ZrqPOX6nTgdc30Gtihb97QrDDh2qbpNoxXJErw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_12,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130007
X-Proofpoint-GUID: id0zx41dyX_xwUSnC9r6hMiCmxj1NhWz
X-Proofpoint-ORIG-GUID: id0zx41dyX_xwUSnC9r6hMiCmxj1NhWz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The io_uring code will set it's worker threads's name with a
iou-sqd/iou-wrk prefix and then either the task's pid or the task's
parent's pid. The kthread code will set the name to whatever the caller
decides. To set these names they have come up with different approaches.

This patch adds a callout to setup a kthread or io_uring worker's
internal struct and/or set the task's coomm.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched.h      | 2 ++
 include/linux/sched/task.h | 1 +
 kernel/fork.c              | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562b..09bdc71c0523 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1066,6 +1066,8 @@ struct task_struct {
 	 * executable name, excluding path.
 	 *
 	 * - normally initialized setup_new_exec()
+	 * - can be initialized in copy_process if
+	 *   kernel_clone_args.fns.setup_thread_fn() is set.
 	 * - access it with [gs]et_task_comm()
 	 * - lock it with task_lock()
 	 */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 7a61ebbcdfe0..844824e0023c 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -20,6 +20,7 @@ struct css_set;
 
 struct kernel_clone_fns {
 	int (*thread_fn)(void *fn_arg);
+	int (*setup_thread_fn)(struct task_struct *tsk, void *fn_arg);
 };
 
 struct kernel_clone_args {
diff --git a/kernel/fork.c b/kernel/fork.c
index f308a5ae0ed3..057274da64fb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2345,6 +2345,12 @@ static __latent_entropy struct task_struct *copy_process(
 		p->tgid = p->pid;
 	}
 
+	if (args->fns && args->fns->setup_thread_fn) {
+		retval = args->fns->setup_thread_fn(p, args->fn_arg);
+		if (retval)
+			goto bad_fork_put_pidfd;
+	}
+
 	p->nr_dirtied = 0;
 	p->nr_dirtied_pause = 128 >> (PAGE_SHIFT - 10);
 	p->dirty_paused_when = 0;
-- 
2.25.1

