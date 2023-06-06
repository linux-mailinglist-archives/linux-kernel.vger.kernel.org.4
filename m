Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E03A724B81
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbjFFSgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjFFSf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:35:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834DC11D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:35:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IZTM1005125;
        Tue, 6 Jun 2023 18:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=cQ19WJnP8C/Kk7F4Gr8+GqojPD3l4Z2WNv4c6A7HCdc=;
 b=MQIXyvg1WvhxPGhsEQlHUhS4b5bvbRzYG1hlKGCgo/5M8y4vTJWHJ/C2BmjwkzoKyKd3
 8tTZvU9ljGb7tTz4P8VKoxP7FIUPIu29P92JpU1zGFBexJJrTm3CiN4RKCpGEMCUx5Hd
 FIE+dyK4fzRJf3gkK6HPfCAdDXzzTfKzv7X6NxAwakhqI6QfGoVuH70lHMxnRkSUOscp
 JuPV+rri7wlFQlfpbPQN70cKz6iFaw1vrxE9XkTBTc/zxeuyh1ldJaB4kmU7p/kjlS+b
 nbgynVVAoT+/nJSNnnquwj3P0SHNDQ6Ki2oUUv9VUOpGvcUuXziCcIWepUGXpuxWAoiU Lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u001y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 18:35:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356IXsWu003027;
        Tue, 6 Jun 2023 18:35:49 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6j81ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 18:35:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkGbwcG0uwb9k6zbM61VKRQAkhrZViLpr1irmxGZ8+LJXlNw3RyznqYL/1XARxVFwUSm6wOp3o0FfK78O9jZIjqqMM/kuJuPiQ64inPwcUa+i2JNmPtyKNGhVSfi1P6omYrmP2crH7je/+IHFDq0PAcRwjKPkRuflLzmprxO+CNzfH1qfI5/hi2FlyNM0KbK27jGphnIFK1eqUtHHtVXFaeQni0W2hdq9N3MZFL/I1aIqKdTRkNtGLGHGsEecewChJ+yrl/RxOPgAJkuTejjfWRORBzSJDfxZFrCW9fwbW314m/GFd0bYOhJ5Jbhi+ivYn/zuVCre4mutmsMGXnyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ19WJnP8C/Kk7F4Gr8+GqojPD3l4Z2WNv4c6A7HCdc=;
 b=P+U1s1JClnGALlk7HcdkUQ0dIj1qqgJ6yirr/TGiywHerd6/JIoAcO9Jazg99fdIlheiugvrSH4Oj2MmPNcpVVQc7uxqCDFvXjWBiS2UeP/QVwHAUxFEaSjdwv3OkRhv3hQPYlwK7kdCix2fIwPdp42ZN4fC/JP8oAVq0O1No5UUx2v1PHPCLOTSzk1fTWATVik4pQzTSE3Ij+T2bGqloxJCRWrYnC//cGfUKTy3sEI6N8MkkdXWbKMUxhO1cnRTWO8t7uXvCCN8zIX6dEU+IDlcUhriud28aD7X2rLayIhMIpF8ALnXzIRrx4dcF87bvRDpzluO+6QBX8SuVKmyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ19WJnP8C/Kk7F4Gr8+GqojPD3l4Z2WNv4c6A7HCdc=;
 b=pzoQ0kaU+TscOScBUCgaQ+NMailWdsu96i7YvMDeEIEdxCa2Uk9BtnAr6kjNOO59PmWqBY1X5EVV6v1/GQXYuHP9mekH8z/4Iek7VgveAjRgY6lAdzGez+2hm7OZl6dPp0OlsdeC5QGj1YL4tkt2zanj2dlJXCDiSH2PuE9ky48=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB7171.namprd10.prod.outlook.com (2603:10b6:930:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 18:35:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 18:35:46 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH] mm: Update validate_mm() to use vma iterator CONFIG flag
Date:   Tue,  6 Jun 2023 14:35:38 -0400
Message-Id: <20230606183538.588190-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 784e13e1-2b05-41ab-e144-08db66bcd802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCgNiKJKwjTIZzYh0G7R+YMjTnnkwT3O0L2081Jj4+NQqQ58EpMGYOdEcrbOi+Z2um6ekMnGbt5dzCE5k96S7hATwZKI92uprMJ2s7HLxJEi/YUDV5XdCf+SBXF2vJFG2Os9f34Nocg8/ui0MQs+ySPoXx7vSfiEMKzd5FgefPh2Im9u2pW22hQmeN5tF/7tIfmqYxVfDN+LCjJKGHsi/nExs3ObvapaKrL6b4ixrBUty68od2MNO4aNmrNrdjhMsZz3hc68kW6wUWvAngnNGU5OPijuUMK5Vrd/7oEwzo9pMLjzwosrDKe6voshgfkg0j2DkKRFO3nNEYphYsDSUMWgkIoAk5Yc7YfO7CBs1InCeMIGRDxO7F5PPa3ywOgsxPrOyLd53dieAbUTILrwpnHJ75L4m7juuLQHWEryxS5vwqGtY+L2Mxs7k8qTChMWYeWQrMy5XyO92tQIb9DRFshIvz9HQW0c0nO2gCwXSCPX46rSpd1cSq01i99SWeMCobWxa0KImGeodNp2OPGdd9FrIQTKTvfu3Tul/EsMdQukSaeAlr/zvjPO5eGmHzXk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(86362001)(83380400001)(478600001)(8936002)(8676002)(316002)(41300700001)(66476007)(66556008)(66946007)(38100700002)(6916009)(5660300002)(4326008)(6486002)(6666004)(36756003)(2906002)(15650500001)(6512007)(26005)(107886003)(186003)(6506007)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R6UoHtEAhW0gWBumeEmma+sw0DmdTc8bfWMPcBuSf6w05ZPKjfcMGjByUiiD?=
 =?us-ascii?Q?y3t7mFja8AOpzsxuuVq+4lUH1B+6xB8aFnx9VAJaGO/vnLJoAM8QO6SDCsbK?=
 =?us-ascii?Q?tKErhumNZvmmGIXBzQJHI5vsgRnvQ66PQ9HgskD+rI0gjNz38Gz5Dh1FV0Ak?=
 =?us-ascii?Q?IuDQgNXFqKPI2fdCF8P8cNjdtXSV662xIOSCpR6TUmqLRg05Kxf8k/BzKrGW?=
 =?us-ascii?Q?B+/1IgpBj0lRQ2DpEPLdROC6uMyOSY2Jr1NmIv38j3DiKbpE5C8ULnxMgJ4b?=
 =?us-ascii?Q?UOZXK5j4JgaQ9AGa4HjniDlwc1wg+9WDAvFzKevUw0j4R1ngq5aClTPISy6P?=
 =?us-ascii?Q?+c5+HXUtoULf81dvBNSpk9E8oH8+LcNZG7EYOPW3TpFl7cofkmcg3dnmnGLe?=
 =?us-ascii?Q?IncCFs07enex0t9SSrs5D5UsyVsGW16qeq0qkkYlOqPcxnLNdNQjB4KLmEKa?=
 =?us-ascii?Q?Mb5dgtJgUpvDz/AQcd1MCoif+FC1IXcJn2Y8PloJ0zmmOLjqLAxzeVqKnV1q?=
 =?us-ascii?Q?cfjSTO1vwDsA0SmsRGUPA1NxfNxyIrFhfpnFyTiwpwxSccXpphjCioMhhqY4?=
 =?us-ascii?Q?fNbwYzmmz1Ep4u5KOamAG1KcVwZdCWRsFmGXHG/5wfgKaSUbb17Zfe8nuEJn?=
 =?us-ascii?Q?+lh6D+W4rwBQ04fRS+aniQg18goME+yI2VaLBUEKSlWt4GTPTd75MU+QE9xC?=
 =?us-ascii?Q?YRKQxOgtye1bfVWMFC+UA0ADankabPu6GL6PCNtUxLDdfk8TJQyroBTyppUp?=
 =?us-ascii?Q?zlLXQ56v+eWODLtIwlbWctYDQVSbnlGhk+ZH2PktZ7Q2F97B6rPvmAb2Kw6r?=
 =?us-ascii?Q?QMKcmhNT++g0mmzmfcR1JJQ7i38jwJZk4+Guc9lhRKje+sOdYQqXQlWrAQEK?=
 =?us-ascii?Q?qj3r6yPLaCj3PA6JBPeWAl5od22G0bsAh7yf8dtjT7RUY+NLBXsfSBrrM7Yd?=
 =?us-ascii?Q?phSEenuhNjVEYUJwh6FQGR5Y6a9y1Guw7F5QcactmkUISLx7tXd/MnVuRc44?=
 =?us-ascii?Q?vJLnOl3C7Laq3r1iSuGLJgmCi81FlyYPWb0grvE1FnNwkWPwiDq21FpZ/wmo?=
 =?us-ascii?Q?uRrTjKFmQLZd/H17DhDkScg64qen/SCTJCCR1NzsHoKfGniAhqUmbavTRlTv?=
 =?us-ascii?Q?H9ECFXDadM5lE3vOlcqLl0DuqdRDzRQ+oxIxxC02uKjdhPqbokiSkas8PFzI?=
 =?us-ascii?Q?YUqh1uFR14mOEqjyEsIk2h/0ULXT437IsVJZfwcjw3LZ2Cum7XIOs2yBnYHF?=
 =?us-ascii?Q?ZGyTyo7k30rAnXng3RfR3rE7KCGnA7ksmsBITXi/q5J5YDRI4bEzLz8J5Ws0?=
 =?us-ascii?Q?5bC77JlvdRCwmv65Z+FT8wk3l97ulSbYqauXKO1HEMEXvoE4imx6Ax1UvBoj?=
 =?us-ascii?Q?s17aKaFbll1Y0z4rcPnQRwq4i8RLEbkZ5CDdqG/Cm86R5KX/ZClEZlU58YPC?=
 =?us-ascii?Q?QPp3/bN5h6oCVD/NDH/vh0JPoXYB5aYeHTsR/1L4NNHNafUHo4OZvBnLBgpo?=
 =?us-ascii?Q?fQFPmuZbKG1OmkX9S4KPr46c8bKCxSmnjQ8pY7gstwLi6iAcIeH3abI2K85h?=
 =?us-ascii?Q?ix8bzno8aclV9FfLUqbD4wC9h/U1j4iWygBIrN8a/0j1N4OwmREdHR8naCIs?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RlcQq6ohWNJb3jKHyUEpE4Wz3bsW0M2VzPJhsYJo08gHIEqWs6SZS58g1pCgbMGnAumKKH5RLkRn8MeS04W/3cTf5tz0RPaQLuBkm/Bq+9RLrHrV3ZB9fj4f05yrxsbI5jn1gmCYVabUYsqhadrl7K99Jp9JRL6rUrz4BcITTzytb55U+725WeFZ9BGDebWw0JHhUBsI7nchMd6l5XInNd8iSauPqduNAyZcH4gng2WVXRw1jsbESTfUwncqk34lepVj/mKhgi3g5nRp7NMOm7EtFgq7D1L5L+lOAR21t1yqNLiaWTAi8dVehSF8cmoD2U7sMdDuo0uO+uoYHjsEhdf3A6Yl6XAi9oTzfx+QUq7ToeKkBxL7vgce7PPeJUyzYpMtmQ4064LXrmnf0C6dq6wTVtUJk4VR32ZmR33Din+S2PFnFKEXYyIERHxwH+uOk6yvvUp2r/oJzEP2MFL3wrlc8a+bPR4/Dhm2xc9jtdTe0ejpg0EG8SxXxvF4zfba4P1gwh6oVJOYPZaZKGzX8ihydeHAYwltmJj0lBJmAQRTfXqwvoRyJUzrWSLiFoLQwSg8FqgOnni4v/TCtrBLj4Gn/zjHPbw9UuWVBrZSqMFH/7TnztW5g2Nj43zkhJBKqFCc1+ho3FlcmyxdU6bTANh3yHP7qwQ4hDw0hqbLawnfPPs3blp6bVyy1oqgpZTeCSBDTifL7n1Hk3b1/lnXxUfJ6gBcStxgn45hfweaA9Oy4UU96ln9Z9hSsbuCg/0tG2wzJ8IM0X22uPbEBTdTkwYBK4JOhZVpd/O5Hzufetn4l9FBSBsJk880qo8YzEel/1B39wo5OT1xfZXprL1Wcw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784e13e1-2b05-41ab-e144-08db66bcd802
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 18:35:46.7737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8PXrWZCInxf6NOvpZs20HgoTABsDvpA/qdvrLQX7n7K8AAWzkH1XF8NX062NSDpfjES/1D1QS+wL54/WvW+Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_13,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306060158
X-Proofpoint-GUID: zDhpLnWNxJueeanABtyn4lZwZFT2w7rU
X-Proofpoint-ORIG-GUID: zDhpLnWNxJueeanABtyn4lZwZFT2w7rU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The validate_mm() function was deemed too heavy to enable with
CONFIG_DEBUG_VM [1].  Revert the config option to
CONFIG_DEBUG_VM_MAPLE_TREE

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---

Andrew,

Please squash this into your mm-unstable commit e9c9b8e9753d ("mm:
update validate_mm() to use vma iterator")

 mm/mmap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 71733953ff83..7c106a164c0f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -299,7 +299,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return origbrk;
 }
 
-#if defined(CONFIG_DEBUG_VM)
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 static void validate_mm(struct mm_struct *mm)
 {
 	int bug = 0;
@@ -307,10 +307,7 @@ static void validate_mm(struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	VMA_ITERATOR(vmi, mm, 0);
 
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	mt_validate(&mm->mm_mt);
-#endif
-
 	for_each_vma(vmi, vma) {
 #ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma = vma->anon_vma;
@@ -353,9 +350,9 @@ static void validate_mm(struct mm_struct *mm)
 	VM_BUG_ON_MM(bug, mm);
 }
 
-#else /* !CONFIG_DEBUG_VM */
+#else /* !CONFIG_DEBUG_VM_MAPLE_TREE */
 #define validate_mm(mm) do { } while (0)
-#endif /* CONFIG_DEBUG_VM */
+#endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
 
 /*
  * vma has some anon_vma assigned, and is already inserted on that
-- 
2.39.2

