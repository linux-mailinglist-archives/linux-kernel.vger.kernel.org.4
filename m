Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64A76A23B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjBXVX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjBXVXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:23:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B285A1B2E5;
        Fri, 24 Feb 2023 13:23:21 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OHhq1S013474;
        Fri, 24 Feb 2023 21:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=9ijP+0Ez8MrRHNi33VVqsyqCspkIz3u8pa5JpYnDZig=;
 b=Vq7/u3/fNb0/hQfdSzr+S2sNWSJbCFVmPNVZLyuztmqS5UV6iSG6OHppJpxtPQgrrhzQ
 OmN22JGU1BX6H5Oay/Ys0F+VP/J0Wh6hOiAkBWV6C8uXX8m659iF+e5kiUHGUE965nWM
 MSJZMId1xJ51yfLc4kNCiEaNwznnHbRzU4h/wbFrunfzygPNTDT53gLKAr0zpmU8sb32
 cqMb7kBMQjTcPwts2+W9RbD5J4TNo/ijomrAQ2b6M0psPYMi3afHpHo2iOrozdfeT4GJ
 2FpT/IVotA64k+06wqsIShIMw6C0Yeqg2DsceJE2LhM1zDKTRST2aXAsHRjuR8PlQwUP 7g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnf3p7p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 21:21:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OJlumC025950;
        Fri, 24 Feb 2023 21:21:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4a145q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 21:21:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlcYT2lNvUSL0rWnF5FIg0UvfaxLJ6JCan1CjRhG38FVHnKpRFPVpp+737G0HF9lvQKVyyZqgQS7jCje6+199aiCkp/TvQU4j5Jfj9YNu+W4wDVrviXGnpt0jf6QOBsBVQtTJKG7hMEXfxjVA/3J5kMC9gpgk0aXzF8PjVOWl5aQwrnua7TOxeu/ToBCX94G3MuOJZ1N522T1ZoEtx6XIvWiNhV68QrGzMHyqiaicY7qog7X8VKQixJQvvtUBSkf92rm2BWyz9rTmx/2d9BnFTP1evgfFRZqRmXhp37wHG8T7kk+rib1kB8i9Lm9H4xmZFFDvyN3HxbeKlWfAgXstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ijP+0Ez8MrRHNi33VVqsyqCspkIz3u8pa5JpYnDZig=;
 b=QNO2Mg7hISdqZeC+ssC7vJYAQ/wqyFB1+C2LRo2Wx3XXmVgOJtE1EyrAKYzpzQsFpKPs0JFk8CdGSIsD4ZV0rVqymKmjgtszZKttxHcdP3vPrTbXrOaA0BLsr2yt+wfcUNkHMUjRheVT5VKHyHE0en/SyVDsxoOv7bOr8YPy9tYGbf8Me0AFWMo1Et/3GnGmjCGxDO8M7qFZL4XUCmzEB05dts9Lk/n9ARaebV8Geqw38H3PFbno30hDtl6R/qlP1FJawYCeSbxMt0NGVcJIG44jGsf92J/CgQgZFihynj30FPrxjb8luGxGVEWNybBLhOdXVwqG17JGkf+XFF3kAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ijP+0Ez8MrRHNi33VVqsyqCspkIz3u8pa5JpYnDZig=;
 b=MZ4jtBl79wgwljGFLr6Rm4M9aDXe7bGlz1lKPcLNf98DRxwXjXUo6Bvvf1pYyweilWusPBzMqdG2zAK2Wpkimnf9g1avYzDRY8JlU1kTuHNuAndWTArp6E84/cfR2CCUtVLfu1lKgPx30d4vHNvHkxqXMnIvDz4LRya+BjJB9VM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6441.namprd10.prod.outlook.com (2603:10b6:930:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 21:21:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6156.011; Fri, 24 Feb 2023
 21:21:04 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>
Subject: [PATCH] mm/mprotect: Fix successful vma_merge() of next in do_mprotect_pkey()
Date:   Fri, 24 Feb 2023 16:20:55 -0500
Message-Id: <20230224212055.1786100-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0321.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 49500d52-30db-414d-6d58-08db16ad090b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTs/bPleESBd9ECcqqeOoFzi8y8kHRDOVHfZuV6MekN3o6is3Bl/Tdaznbm3TS0ztPwK0DUeBcBXvl+DL4/1FuuVFxnYuX7tGNZ1opqqjJZJBbinfKS3ONWZlAIYdKceq1tavP3EU9Yc/FfWRtRV1sQArMPNLwEK8kSk4ILo90M0Ils18eajMp2pBVs9KWu+1nz1Ke5cQEY4Mu5Rmw/Lj8DNgxJ2G7TjyYZh/7andrU3pQj/FCE+uBw/B+L33VoNYNmBHrxxG+YpaZ8mn7XbEHdhm++vnudkyfPSWylMKp+0ZzOa8ZV8bEkA7tnpjaZH8aswC6TqGa//xthUha/4lP8jEsZr9/LMO0VvJMusWDuyOO8y1KnuHGuRLCzQYftQu4u5TDoWnpo6ynPh5pkgTRq1Js3zlUlw1cukmvAjx6tgzmmm76tx5TrAN5LK5W100mF/9oMVk1e5W5uK8gIbPNGhAGvBm+7q/QPqczfY4+o1pn0lrus+l0JOlNnzH7OtUNsO/FQAsMs5eo0XO6DmFWp3Exghbo6rCe258DhtHnp2QxMfspvNB9CCerPqTa9spDl9OYtypu4Gl/zg6hUslStRZmUTp6lt00ZrNjftizOqpBewOJsobbJOEY1XVPdTHwpTdcYN2fHURor5xihHSxpWxo/5KcLblbslHm7B89o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199018)(36756003)(6666004)(6506007)(966005)(478600001)(6486002)(1076003)(26005)(2616005)(186003)(66476007)(41300700001)(54906003)(316002)(66556008)(8676002)(66946007)(4326008)(6512007)(5660300002)(2906002)(8936002)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWyx1D1gpqP2uT5R0YhmZwVHMP6RRIwiiVj7zqUEK2ZL+WgGWvYYG3fjTH3J?=
 =?us-ascii?Q?psSdTeBWQZPz7sKGROH+agsbDml0Qr3Cu1IuBkdHzT9XFEcyuwlYtOQ0YWOy?=
 =?us-ascii?Q?Cr+G/BxDsHHzPt3owaXsWKC2BZDJ3Xk06wXKjM3XdIxIg9DO4e9E641F1Y8j?=
 =?us-ascii?Q?Wt9YO1jWzf3rSMYPaiFbiL7Gq3hwEjANn7SNJKVFcBI03hMfwFtwY9UITgJH?=
 =?us-ascii?Q?zc6IILN1EGVfpskFVaCIwR1S7R1Kxl4/ZC3RiEBGzt3sDUMvOn/7d8hf8a3D?=
 =?us-ascii?Q?nJIBs6FOcxq95e7MMjyl4srN1jkVxrB3tci3A/mt9sNoChm2cjcsaECfpIZq?=
 =?us-ascii?Q?Tw1urXz9w4L0m4k6SJjnU8UQFph4bI/ZFMUQgC3zkV1I77FLZjlLiAb1O5OD?=
 =?us-ascii?Q?JfiDofQogvg8Ks1kZwaAgQIlCpfp2QCW/oKRxnAGY+Bf7CkiQwMF1drPibj9?=
 =?us-ascii?Q?fAiOJvwvm7WG+trEWlyXfg7GJVXlZIan7rdDT6vNP/XYWmRuZiuleuHIKlh8?=
 =?us-ascii?Q?vObkItm/Uprucg9SyGbec4BhTPkEZPD6787DKZySmQbjEHlNCunyCAxXf8XJ?=
 =?us-ascii?Q?FM+fGSed7IcDo+8o/V2FZh6fMqcWZQXha3QZnPx9hMj5qC9tvEjK1/2XD1JX?=
 =?us-ascii?Q?s/CyM0KKqjDYXez/QE3lT2ZXLA9dmviU1XkPGfESM+9P2laJ+awqbbfh6qhT?=
 =?us-ascii?Q?+otfIYM5TWsQ2AaF7NjP0UTaG6wtxzmfmWxVjOFiNOOYlbZJ/aeJKmfIlcEZ?=
 =?us-ascii?Q?r/h90wPYLshCR1MgR4yFctE+/vTPuR8BQp8XSwEOUWBe45eB3B/W1Nxmyk6b?=
 =?us-ascii?Q?wAwWRhaIrWDcLIG8GOsMvYp1t/yhxZlICKXxhiBWr2DseHjb4QZuMlu5alZt?=
 =?us-ascii?Q?ymSfi68JgA/PdIMOSeg7iokIQ/3eICRcH7PQGCnShUpfSGJM3MMni0GvovVs?=
 =?us-ascii?Q?0Ow87NqzFsMu8iq1WZH9+pU+Y/c2AqqGxoxPr8ZOamsRsVvs2olsYbEvoZUp?=
 =?us-ascii?Q?Y9ZoVpeLFb6Q0UMQ4bSXgtd+aAbBMeuQR0G+Y7D57JMhShOibjF2MTEsh4eM?=
 =?us-ascii?Q?sZ7DeWO9dp8XZMZeP7r6AsmtUSXarsSp5GdOB8WNYh78/eq2Tk7G3wGLfqHK?=
 =?us-ascii?Q?5QPb42cDaxf67sTojWbKGUb76cYZcdz+uaOLxaaBtzlt2JWbNTBcJLQaG7Gb?=
 =?us-ascii?Q?4o04nHcZ3M5dR0dw7d2eh/MjhnQMaSYtk+jiAP7CcUXVfgGbtRFOC8sJP2bw?=
 =?us-ascii?Q?7K61U3OZXNjpNvuVa3HJUPJXIsV7lA7NJ+S+tdtfK8K7JuknGno1jLLOMaP8?=
 =?us-ascii?Q?htqPf3e1AD7UMkyZspIfoS6T33CYeHSHW7TASXX5Y7BvV4o1t768nUrPJkOk?=
 =?us-ascii?Q?Fz+k4K/68ymWz154JY8c04fI9c0USKjjt1tZTu95tQwFZFtpuwpB1xrat4M1?=
 =?us-ascii?Q?56H6oVta/9ZLFFHTIimIFCAyXGry0KuVyU2sE6Gjn/acrgQLMJsnfdRepEpr?=
 =?us-ascii?Q?zbf6WzPOKqJGsl4+i49bUil+XdWOislXFGwWQrbEDkIU8PrK6Qj7liA9tv4O?=
 =?us-ascii?Q?AwmQdUWWD0OpZGx77FQBxmEs7I9abbTy9jc7b3dGokKjImLH2BLUVhP+D+cb?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cuYyTTJsKtTH4wQ2+tlti39K38TuJszP0J6LMt5zIAzWh1nTHB3RkpVkyzkjsOUYWMkYP9m3eRmV+0vmT+JJaNHywF2fgCU1dAWtgbtIhWujWwXBljbDlWC0k/ybBD4uZ89g8OauAw5qcxYVhL9w5NePDtNhjNfZkge1C4c8+hcODtSgi9I2PnlucTAaxQmHMAKqq++OYdquhDGHGZ3hBiKQHJyKP9RcteZcwaq5dqwpCQYA6YSzCJloqzHu5aQojv7Jt3uHkX9PgIXa9Na7/aAF0VUpCeUKxOyvI8xtddkzo7GroqYcY+fXxywHXHgj/nMVIK5Ul+SCE+909N0oPMILAuqNlMlDr+bTZZLZYdzRiEtn7EmAy+i76/dtNO47PNE7Q9IU/AmB8UthDbAUHsjQ/CiN6rtootpXidiNyc6FmNcfsuIZHzv6YcTENnZvstLay4CI0IqfterGWkCeUmHkmUDOS04etnK8BMBrqbZ8VkwXULPQRHbFJH36jzdnDTh1Ips5gcR2bEXqqPeDTletoLv21D5XM31gHeP+RFIDWm09NphABjWKsYC2lg9BGV7HdIU4UJyt3xzBJFjIK3LxrwE4hmcAl9uhUpsDWEddRs1vkCuMvH3KM3cRDtBVbKs6ViwWSNaKzxvpKoniN72+zrqUecujKIMQqETyGytZh7Tdzug52+zBzcT3Iyvf0WUVVyzQO2eMWgChAW0qgh5D8ORCho5aejZ0xvt8EGZfLs94dknqo+yURln5qFJvTJCzychqOuY362p0vO5rbwLvqvfv1zgm7+S5+/s5ZT86lR5O/tK0w1/igeF3aOTa4buijV4AR6UAjt1M4uqzhXYjjcG0OXUFBuCZeVVWjXZ7+R2TrH3RcZES7Hn6Eg5bOC1y/Uv3rWEa1llZBfKK0i1TxRdYydhBocQjD4eZIbk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49500d52-30db-414d-6d58-08db16ad090b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 21:21:04.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJJ+237b90m94eE3Ei7MJd9fQvmlJaAf0bpNZ7s9+ce/+gdz+gVC/3Fo8DgRWKIyenYQ4yE4jUCXCmQXbh3mTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_16,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=920 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240169
X-Proofpoint-GUID: 8IJZ-n8e17y6yJDLWBmZqQRo-saF_2uM
X-Proofpoint-ORIG-GUID: 8IJZ-n8e17y6yJDLWBmZqQRo-saF_2uM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mprotect_fixup() successfully calls vma_merge() and replaces vma and
the next vma, then the tmp variable in the do_mprotect_pkey() is not
updated to point to the new vma end.  This results in the loop detecting
a gap between VMAs that does not exist.  Fix the faulty value of tmp by
setting it to the end location of the vma iterator at the end of the
loop.

Reported-by: Bert Karwatzki <spasswolf@web.de>
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=217061
Fixes: 2286a6914c77 ("mm: change mprotect_fixup to vma iterator")
Link: https://lore.kernel.org/linux-mm/20230223120407.729110a6ecd1416ac59d9cb0@linux-foundation.org/
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mprotect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 1d4843c97c2a..231929f119d9 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -832,6 +832,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		if (error)
 			break;
 
+		tmp = vma_iter_end(&vmi);
 		nstart = tmp;
 		prot = reqprot;
 	}
-- 
2.39.0

