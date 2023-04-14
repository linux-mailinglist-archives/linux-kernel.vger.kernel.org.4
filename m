Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B346E2A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDNS7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDNS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:59:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01273213A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 11:59:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGv3GF001860;
        Fri, 14 Apr 2023 18:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=rylOUwPxYgMN3+S0CEAuGDbcgUaIj4jJU9qbdqOaqV4=;
 b=PuFbQH3KGBIflujFCbJGqkfbN2i23EYoVUiwQbqBKpu9knuSMS0WE2Gz0a1J0Gk2rJ2G
 mKC2BqW24hXp3UIxvy0pt+gnxJ94/8RYmV6wu/f2WE/CP/7EdT1zYipYCkcZ9/N9tf+U
 pj6k+DoZ9/Je0+87qZoKeF/QSqf5tmy+4Vrc+cUPyqsVCyLtpMeziCf1xyh3HglCoZlR
 O4ds8hqUA7cYHjbj0Hln9glNMGf0+nYpireU7igT4WqcyN/IzPY2XN3xGa6L1p8kYUzM
 7C4QYFU1JI3jfoyXWKRu2VQEJdzpZ08mZJ4V1I5NYLslYqPcLKwrm2uMhg4S727SifRZ tQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0e7pm54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 18:59:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EIIiBf037843;
        Fri, 14 Apr 2023 18:59:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwdu9vew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 18:59:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgBtJYKHDQ+Ca8dTzekPA0kcKoBEQFJJNvx0ALbeodgzDO2w3KyO4T7F54WOjmHf071NA1OE/DCEtGpueL5xAvsHV/oX5fdO7KmtjGPM2JJYXI8G4WT9qJ26sTN1wWeA1eDKwz3uxzDT3xHInQ6iQRPKnVDGPl+6CiSeXbmpgK/1TYBwnPzChBkXLO3aaSNnHwAmrgM492WI82XdidIIt590CbXqCZzNJpUgoUBpe+cq1PdizCliNnGgiEPUZ6A0upMXC0rOUsvAVvPhzxtlFGzOIYd4hU1M6wZgqLx1cfJpTERThF1EH5Mh69ps4OGmwXcTIrN8yWcU9cFkPHzvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rylOUwPxYgMN3+S0CEAuGDbcgUaIj4jJU9qbdqOaqV4=;
 b=H1AGp0RFkem1WB7sp1MLktvOnDmukS91896+NfVDi6Q2pK5mpZwcVZYPrAXDSd+TFdDqOp4rWpnqEGaUdhJpnKJkGEI21wRYwHziwK1gMZuQGKSNHuJnrOxVoWYprjymE7T6jQ/uz4qunt57KbcMlo3c+fRBi/nUZg2mkyYHwC5SLsrbv8QX64vN9Wn+VDx3aIHxNDNLZqw9DgdbiGYQi3b9qCSB5jRrhSJjwc3wD6ZqLNJsFSEy2WGAO/awr0SxHoznqFiEpIh/XSnFYKmoMHrQ696QlUCMgDkoKjQntSwxUmzJzQTw8y0Xc6aJG05oSKxI/z+S6vPs/EVb6HTTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rylOUwPxYgMN3+S0CEAuGDbcgUaIj4jJU9qbdqOaqV4=;
 b=ybou+qDmGR+MAk0IeqfSdo/o/3PeGHcbgDWtMUKbUWvmrekPPswSU4dIUWpT2G9C8kC9/6fVH7TDo85e0I2BIygJ/9go/Y8SOMRmWFxCzwnA/zZxOQgJF/neAHApU4MFrT/ST+MTSkV+iC6VEbcKXeYbiCtp6LuinULSRVkMfxQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 18:59:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6277.035; Fri, 14 Apr 2023
 18:59:28 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2] mm/mmap: Regression fix for unmapped_area{_topdown}
Date:   Fri, 14 Apr 2023 14:59:19 -0400
Message-Id: <20230414185919.4175572-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414145728.4067069-3-Liam.Howlett@oracle.com>
References: <20230414145728.4067069-3-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: c31895fe-4e47-4653-fdd3-08db3d1a5fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lM2E6fLDgmQPKwjkU3oXw1CHzddsUmBZx+QFCBL+0pIvQWBGla3JJNqUhICEGQP+6tyAOyPmJc4uW3IBhk/K3qRoXm0mn+015AXE9oMqUAf+pGUXkarf1m00jpQ6lT/2ci78pcuKSkGTVe7uTdeCC66Bb8S+Muwn9DiCl8NmW6GQ23wf6UCttJKbZxiCGzD3Cq0iG0CVY4cmHPRhIOUr56nFwktu4IAdHYiPtnJ9oXO2dgN6J1H2FH8H46K7tBwFWje3xfr8eGntDpz3nMG3OeA0CAjMgLRcgz1bHhKO46OsxWjLkuwuFHjW533KQL+WF70v1U8xkJzx/9tGy6V3kh4+WmxHrqyIV5VPzYHRQahpR7ic3owptNQXD0yj/82g+hH4bnAI9cC1HxGruiprOFpRWovo+SvOJq03tJ78SoNUAQ8Hod89MqP3yiwcYa6ebG204AlCMEXjGa2kf4hali2FYFuc2W3GM96oXKyS2ti6sod1h/2helWU1PzHZfKOGS1yjlKYVZqwFaA8qDpgbfza0zGQXwhsc9hAb6G0TRsud83P8ahhtKPN8Nhfjxe7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(6666004)(5660300002)(6486002)(66556008)(6916009)(2906002)(66476007)(36756003)(4326008)(66946007)(86362001)(38100700002)(41300700001)(8676002)(316002)(8936002)(478600001)(54906003)(26005)(1076003)(6512007)(6506007)(2616005)(107886003)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?teb+CElq38nmt14+ZaaJrU34lpCxYaSxubNPdGttyWvjn32V1Ynj4O7LAON4?=
 =?us-ascii?Q?N5S8UydgtuhyC1M52zxpsEmV5Wdf0nF8aDfvhcLkBdfp4HqlEjgL/i0qbmTx?=
 =?us-ascii?Q?Fhf3B65R2OjmSlFJMxS7OAmzE1ZH+7u3k6o+N/ztIFkjBUB8V1f6jACaHpRk?=
 =?us-ascii?Q?g6xBr+h4LmOCgckuMXbM7g+FBf2C1A1213PJWbztpvCw30KD8YDHOisCcpaq?=
 =?us-ascii?Q?l46aKR36U6oQtPuqTa9knYuFBTMZgx/3kjWek0zrLL64B++tuyxUT8UFW3Pd?=
 =?us-ascii?Q?iwgJIoAVNl45ivRouglo4DoMlZxG7TZYa3bVTtXqBoPgn3Z8nh3ddvCZzAd8?=
 =?us-ascii?Q?xQoTsl8NZ1/oaoIATgGGrBrJ5iwyNj4RZ3cyN6XQDlsVVRoXQEuV5Eulw6c0?=
 =?us-ascii?Q?8gLVF7+CPWna8SscPhLKRBWVSKkySDO99rP4/JjO+3QpoRggJg33gPrCUFBt?=
 =?us-ascii?Q?00DMMf2y6213cBQvkEYWZ4Ma0GdXpdt/Z5/R2t2FeqlMME1GKQ3flJ/+9yor?=
 =?us-ascii?Q?tVZNVt7kfqVvu+hT5wTWu0yIuwCW3jfEu40yU56pKyhdenhY27AYW05Ym8mV?=
 =?us-ascii?Q?Cu4yMyZd4GEv4peRrIJr8fbDUSz9M+KnHuiPAZgsBrfNm/zQqQEjKo8bjK8P?=
 =?us-ascii?Q?XQFYf0caua0GbGCFKvZ12brOuSqjEiD0wDonvRcxyvqBCro00jd3v2g3EPJF?=
 =?us-ascii?Q?7AJKKB33TFrc6z9uWJvxcUdbexz/EFUtjnDueIfYGcFwoWsMDj/4IKmP+JMt?=
 =?us-ascii?Q?IXslX6g9k9ClAw4y0GEWwK2rUqOiXi/aOVUIpcV8moB5m+l5o8inLJOgXSRR?=
 =?us-ascii?Q?OS1oSrV7+05ndh3tOJ+lTxN0GwDpmVEGt71/SbCQSPyNMxp3gJVmtnnn8jCh?=
 =?us-ascii?Q?aZFmUrX4Db2beJodQyjaTwXJhb5y3Otzdg93Ej/346vwgRjMV8IFf+Y2UQX6?=
 =?us-ascii?Q?COouftYHUFuloFllxi8SO/7mofH7mEpKceGCrBceW3FtGuFhjwwXxt8/lP73?=
 =?us-ascii?Q?mIrEzesvB0n4+DTyR4u+rMly0+r5XzJjRyTUGc4Q+7H2m0cajSv+8eUa8ZFh?=
 =?us-ascii?Q?6gQvWqIndDea+QQ/T7FjjgJw1kxusvA45pakZ9MVZaOEJW+8XnNf6n/7Y1yG?=
 =?us-ascii?Q?+eMR/dnn0RvLdcjQ7MHWpYdLCKbgJLsPg8BrvDU0bjPAG8AzQ03hVc/joMUJ?=
 =?us-ascii?Q?zKN/Ke4QZ4Ej3mgWmWIVwBq45Z1QWPR1snvnQ7lLkSHA9grwLmsH1kJRFwtY?=
 =?us-ascii?Q?BbMaADj5AAtrjjsSzNTfHdTQ/39wL2THycrVlEduVsQ+7ViG7MV5JMOBnW3D?=
 =?us-ascii?Q?Swwh4p801Ruk/3jSrHT/5PFSEyd5ZRP9kl7J4lG043Jc4v5yOs5p7+HPQtu6?=
 =?us-ascii?Q?SFt7hIiKuVAwTFO+XRGrorq8Neu7JVMcGOjFnoRBkn1EeGYFu1h3E/RFv+w5?=
 =?us-ascii?Q?zUFX71DMqSqzk7dpkq67qYNq5lh6CnhHaHeevZ7N8T4oqudtDAKJZxk1ohF1?=
 =?us-ascii?Q?oze7GA96oOr4nwjoo7ITHAlEIqQ/usdVWM7eQLRYn7K0n5XkYoye9aqZTSKW?=
 =?us-ascii?Q?rnoYSm6dG0khKMVVoG2Xs4vUULxkQZ81jB/CIkQXSNU2UxBFRAN8gk4kCMXF?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ncrs1hw+KGddBgy2uyku1x3zywDOxgGn6V9jE9ZWBpZQWZXzw6MXViDMuDerd3IGvWt8KEGwqea0+cpohwuNkTBiRPTB8irZvla256IVynkYP4oRif0adDPzj1W3NV+R0ErChPVWQaGVhZeUiFhBpQL1lSSF9SQA0mwQsH2INb16XUfMBh0cmnJpFj15Hy8JK4F6KImqrWYz8ZZwKZP2mUhz9/GEFAqEL6jvhawaGz5YaYsNv95pFekAaxxidPHbuw+B28VrDym6Mnbe3jaCbS0nbSPKela3lpujsWt5M8Rmq52wOr98aVQivKMnwPqbTWXiy0ct263D0zQ14JtU8pOCyI1FQamwWN10wuczX0qT/urkMxoPQMxOk23Ht6yrxi3I+FaYbIx67BSXAi4Au8YseGD8pw37EQjXO96t+oU0/1cfiySkrPP9YTbxjZX8qOKGztoTWKjFZYOc/BUs07nFkUQIh+tcDc8gAjTmF8msA5cyV5lBP58X0vfw53xBfzVzu8442Q12LpB5j16XAq4bhKKWeWq7I4NjVn+qvnCLdCR6GlyrR+k+YqR0Va+CBkZDseBs1leO0nI14OnGzLumqooMjpAHRBQWuBbQgJEJNaWwlsxLwcSBUewgRAnTxX2pdBRyBgZyZdBW8mRwem/8xukpH08M/pevR5pxrkEkPsz7RwhTSfjWKt5g7FCEo/Ue0x4owLS1unxk9cwU9t6IVGRaEO0gqOmmb1yG/H3eUum4114/fS+ipD98+dO0n3HM9q3YiLISojxyU49OoYV3vhCiRupNAZOGNdJBIIP88h2KWo92UQkTQ2X0Qd3BdgW/FGLQY2YjwjEJir4FmazM1Eqmgj7rN3xFJag5g8uaSLfADSJ77qiSzBqlBdM0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31895fe-4e47-4653-fdd3-08db3d1a5fb5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 18:59:28.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLZPJajovjXINs/JkVdnEYmddnEnrTYxrldAFvqib+ge91/37GmG2hBMLI2dUpzZo0lFH/Ob9X1xCIk7/Vyo5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_11,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140168
X-Proofpoint-ORIG-GUID: hozuoUoSJEFp9VzBVnvDtdGGMWMU2rQD
X-Proofpoint-GUID: hozuoUoSJEFp9VzBVnvDtdGGMWMU2rQD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree limits the gap returned to a window that specifically
fits what was asked.  This may not be optimal in the case of switching
search directions or a gap that does not satisfy the requested space for
other reasons.  Fix the search by retrying the operation and limiting
the search window in the rare occasion that a conflict occurs.

Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Fixes: 3499a13168da ("mm/mmap: use maple tree for unmapped_area{_topdown}")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---

v1 changes:
 - Add comment about avoiding prev check
 - Remove check for VM_GROWSUP on prev since vm_end_gap() does this

 mm/mmap.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 055fbd5ed762..6b9116f1c304 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1548,7 +1548,8 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
  */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	unsigned long length, gap;
+	unsigned long length, gap, low_limit;
+	struct vm_area_struct *tmp;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 
@@ -1557,12 +1558,29 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	if (length < info->length)
 		return -ENOMEM;
 
-	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
-				  length))
+	low_limit = info->low_limit;
+retry:
+	if (mas_empty_area(&mas, low_limit, info->high_limit - 1, length))
 		return -ENOMEM;
 
 	gap = mas.index;
 	gap += (info->align_offset - gap) & info->align_mask;
+	tmp = mas_next(&mas, ULONG_MAX);
+	if (tmp && (tmp->vm_flags & VM_GROWSDOWN)) { /* Avoid prev check if possible */
+		if (vm_start_gap(tmp) < gap + length - 1) {
+			low_limit = tmp->vm_end;
+			mas_reset(&mas);
+			goto retry;
+		}
+	} else {
+		tmp = mas_prev(&mas, 0);
+		if (tmp && vm_end_gap(tmp) > gap) {
+			low_limit = vm_end_gap(tmp);
+			mas_reset(&mas);
+			goto retry;
+		}
+	}
+
 	return gap;
 }
 
@@ -1578,7 +1596,8 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
  */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 {
-	unsigned long length, gap;
+	unsigned long length, gap, high_limit, gap_end;
+	struct vm_area_struct *tmp;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
@@ -1586,12 +1605,31 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	if (length < info->length)
 		return -ENOMEM;
 
-	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+	high_limit = info->high_limit;
+retry:
+	if (mas_empty_area_rev(&mas, info->low_limit, high_limit - 1,
 				length))
 		return -ENOMEM;
 
 	gap = mas.last + 1 - info->length;
 	gap -= (gap - info->align_offset) & info->align_mask;
+	gap_end = mas.last;
+	tmp = mas_next(&mas, ULONG_MAX);
+	if (tmp && (tmp->vm_flags & VM_GROWSDOWN)) { /* Avoid prev check if possible */
+		if (vm_start_gap(tmp) <= gap_end) {
+			high_limit = vm_start_gap(tmp);
+			mas_reset(&mas);
+			goto retry;
+		}
+	} else {
+		tmp = mas_prev(&mas, 0);
+		if (tmp && vm_end_gap(tmp) > gap) {
+			high_limit = tmp->vm_start;
+			mas_reset(&mas);
+			goto retry;
+		}
+	}
+
 	return gap;
 }
 
-- 
2.39.2

