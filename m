Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99A767B7D7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjAYRG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjAYRGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:06:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360DE59B4C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:06:20 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFQ7nM029151;
        Wed, 25 Jan 2023 17:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=kg6K/uovRnrO0MaE25vLuqZe0ttrD5ZD9baHCb9erk4=;
 b=qqwDUn7pjd4SAw4vIsCzQGgdiTvQlp3SyfQUqV/vqJbb4t3+R027AzXFB/1Q6lfhh0eQ
 bezbtha+MC2vVrEdRa+/H2oKtJGlDFSkbdQ8TADa6rjQAOoqR+GBtozPWFLmNGxnxyYE
 Lw/Yg0us4RL6TtqIJVwgDFEd+X3Xq9/KsaVjN8HKS0OY8carToqA6M3+U/aXZOxnAApz
 HgHvc740n5UaACxM/sOdVdzRK/QWqLjp3J0hTdxIDclr1XHGEyRIEn/nrMbciNJT2ZVE
 Medouw399I6UpycrAF5bCuu6FXZv6HJE16+fuc+2PLMM5OxxDNczw96Q/MEqdRC7J/Xs BQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ku0dts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:05:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PGGUXF034229;
        Wed, 25 Jan 2023 17:05:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g6tsq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3E7m6wmbp2JkFAaDQyZowX8XHkUMpisMmHAk9kF/wXYM+i+EXDaPHjMNGKEy2n08AG/tCjfNAI4dWEHK52f35OIYWfr+//HqiWMbiladbx3ARVfzwX8bqap2e+qgeudrx1eUmjHngzoVbg+kDytMak6xaxA+pL59TQNvRtRslq0SIjCakV045xbjJWGAJ0MH2LxrRgdYZKDxlrtieTmfMX+8QIeGX25z/rLfVA00vC1DwLmQNYaRGwG9UxkW5vhimZjaD+b8jFvvkEVwhZ1CRNR2K9MUZ2Uxue3Vwb54JMSaXUXhI6S055uOdrMhFJqtYgs6fEyyTqLQ7UsP0OwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg6K/uovRnrO0MaE25vLuqZe0ttrD5ZD9baHCb9erk4=;
 b=P4tPLbC3Mux5ApNkCS+3ELHezme36v1vWGmu0IUcseb9ic3+yAOpMz2eedN8HTX0jo+SlD64ASt/NYsWk4qw3zSW3gMBKS+KeBY7GDgdD6Z2w7emQHkgpBEbEECkIUxifozfcC1fymNe54TlxNYrL1cIeBFeJIMyqu4rkYMF1lyfR/2+khCJODdt3o7BTByH/xcSUrD+LeeC908/wKReRe3EbMAjHBtvDbNtiSciqtd34jcMAGpHxHtSgyzSb+XNmQoOmoBaRnuEkIvAMqCxizXlVG9zAUAiu886Hw9BamYQXyzMwGa0cgu5iRO9DF7eOIOOdmXONk0yNxk4cEt3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg6K/uovRnrO0MaE25vLuqZe0ttrD5ZD9baHCb9erk4=;
 b=xfm7MMGkauoejhQzrGTMEBpiXF3gL2srrRapX2BS8oVQF1wJWGrGmn9Odhq/RU1KUmGKMcV/S8U2mqQQzfciTBFBxN0VMdOQB1LcV1RsIon7SjbYjgddT3lDyNWHsiDPr8n+Ej+DS942VmBRQN1d6khBvN93SSIVpqVaqRaJslA=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by MN2PR10MB4384.namprd10.prod.outlook.com (2603:10b6:208:198::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 17:05:51 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 17:05:51 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        gerald.schaefer@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 2/8] mm/hugetlb: convert hugetlbfs_pagecache_present() to folios
Date:   Wed, 25 Jan 2023 09:05:31 -0800
Message-Id: <20230125170537.96973-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
References: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:254::34) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|MN2PR10MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae529d7-f5e3-4f42-46d4-08dafef66999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHh4HTrhPWV+gNp3KC1//UeEonEAbQoFsyQbNNelWonqzQaI3y2vJs0kavreh1hxfMd7k3giJA5Js3ApzHOhNwXbbCWtZfEQEAwe1B8RjbF2o7+30zNTmKT77moKyLto091VD+IU9TQMMABHc+u2e8tenMGZSYHkKpOzDKxvUWcMMB0dKwHw/QCCNG22SiZE9MADINwjuGErjNWzBQUUNVQjhTBq3ldjd7SxMLZ5rbfZ1iOoI7yKmW1to1RmdIzXjF4ng4e+u2SHKf2qZkZT51otWHvPm4Sv6UHn3//y6OT2hvLal+E2cRuvwlj9S09mU35MyUHSc8GsNMh1nZxh0/EvTiXgDqMf9MAfhWzP9m+mjCu6uAgJQEWxy6uioAUpA04TK8PJXqZQ/7nJZmscqKFmTyszd8wDTz0vR+jyijaFJ+V+F24z7S7OYkIRnq7kq4w1kVUkSVQm0cSXVMCkeMP10ecYukTT2L+/KaukCQRhEBB48I0f/bnC+FwJQbDgbzsz+V91QQhH4yTO5IJ93KhE7P11kdO1OePBRiBIJq3NMGJBZz8OvkWdl36LB2jOFNAI0rFbTh9IY8WGjkKFazto+Ja4dsFH54z2E7nsbuGIe1/UmJ3Ob7fgmSqgW1P+2TlkaxEpuqpnA92Nn2hVwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(186003)(26005)(6512007)(38100700002)(66946007)(66476007)(66556008)(8676002)(83380400001)(4326008)(8936002)(41300700001)(2906002)(44832011)(107886003)(6486002)(478600001)(5660300002)(6666004)(2616005)(1076003)(6506007)(316002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lRwKCDUhY0v5II7Rh8aU9MIVFsCZlkjnRuPHUnB5d2+j6oCriw7SNPOEuB8I?=
 =?us-ascii?Q?M1+PR5VNCadMiNzmb4/9mMqTYDsKcUEwU2zGozew+ayGlH2rCmNpmg+pVgjF?=
 =?us-ascii?Q?O5ud9zXymAlyC7jDAtPe+p+F7lI1Ai+VzeOxH90idp6368qxVmP5RHw8Q4Pz?=
 =?us-ascii?Q?vbMYZ3I5AnAr6CkjH5lMAZbxockFcgjeecWdaJSsnpLOxFEe3ZXo8NN1F0xZ?=
 =?us-ascii?Q?pXEeaayKK1TmyeQ/KXcElBwGFgUxO3SjOP+NodTorrYfDM4DxZeq1cyNw/pS?=
 =?us-ascii?Q?t2mdMzu8WML1G6pdIoaitX1koZbLgg0suWVLkOziiXyipcVxaeTgcsNnltG/?=
 =?us-ascii?Q?S283XqcX6QjnrUizL9Zd4J+UDXIXeOCpY5Js+MqxQV9mHg4Z+EC+OWYyCLEk?=
 =?us-ascii?Q?HvzZGu1papAQ2z/DqB6oaACuQaFqRRKUCd7uaWVqxSvZGrPz3Hs0L5hAXqvU?=
 =?us-ascii?Q?upvM3q9Ms4IVrKPbatBblsj7q9g9rN6ONkCDUCCLCy5osqYrw+Ooxpf6GgaS?=
 =?us-ascii?Q?oMcst4G5IJzzTois5W9VmLeFy8GmUkhC85Hc7aBSpzBsIT6r5GaDCLr50aCD?=
 =?us-ascii?Q?lZthplVzpas/7v3PpXppl0qgICUHS/2icbLoW+OMkZ8e3OoIlRe1hVB6VtX4?=
 =?us-ascii?Q?jZQxtfvumlh04YBO8031KxGuUupy2e5j5j/Ciw7gyd2DZWFVC/nGCa1LLZjq?=
 =?us-ascii?Q?4ScVUVdvDno1dtQ509X9vD8obfPQfu2PfVMYp9l0Pg/LjqGe5Yuhxj4kU0Pw?=
 =?us-ascii?Q?hGGo0lwMd/YI4LjkX7GOxq4jjcRZWHj5u3kECYHVhFKTS8n/f8TmSq5apXeU?=
 =?us-ascii?Q?jesXwAemRwEcGv2z8iRHSp8yNeBkVEhY+IkaCgHiXZOEsfMzcTd/8QAUJdCp?=
 =?us-ascii?Q?hAkDOIF/R3b/0QaivsNnzJymgN/Rhbx5OqTM9BlnsBrHJkM64PK88qeKev8W?=
 =?us-ascii?Q?ld5jfbqRB7Q2fwx40Xup3e/jJXimusvpYdT8FSSGcuJd7CzMHkzYgmI7w3VO?=
 =?us-ascii?Q?VpsqyRsgBMgkBuaoCjSZUJjIW0hidfNBycpjV8E+s975CmXNTPtQffCodYBJ?=
 =?us-ascii?Q?6nd2Nc6UMo4AajxROpNXFFGqAIjnVLncByFkK8nUANX4OGkMM21OW2EDexUh?=
 =?us-ascii?Q?97LlsCxMy6I6posQQ+5tzB22WLCfy8TkkSrKJTsNUp9GlK3sY9JBSkh6902Z?=
 =?us-ascii?Q?nw9ixcJMiKy8AVjE89ncj6IEZC/ZpZa+g0ctWDBBcq6WcNFwJ7K5tHKvNtbE?=
 =?us-ascii?Q?3R7zF/wU1BwE74jebfohOMjJUNH/L35SsaGadB9Bv2D/3+Ledm8eD7rpPg39?=
 =?us-ascii?Q?5wTZ4dSI+ToskYpu05CwXR5CO1/omalGpKOKm5eqdW0pjYgEICGuRGKN74mM?=
 =?us-ascii?Q?9vfXSm7r0smZ+mRvG0WYuhGCmIQgmGz26nbVUoDBDB5PmL6nfB6+pzaV+IOe?=
 =?us-ascii?Q?3Zwh7/GcYvtWcKUdQ4bGF1BYPRXdA+Tkikt20oOTrETJMPMKJB9Otv1QpOe1?=
 =?us-ascii?Q?PGpjtvU6AdpV7ZbMbiW9QbSFgqslRDOxBnJ79qpLNvF96nhzBRMJcKp5w14I?=
 =?us-ascii?Q?9HI++6d7OAcjYnBNI2m/TA1YusWeLDRLOc5zQyDDKUuibQ704GtNkibSt3V0?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?H9Y9Ocxatk+ymj4kdcPSeLybaU3ZiOaaTF7+hRSL3jehUeZPsObJmIBYQqxZ?=
 =?us-ascii?Q?QAVmVh64wYNeNCOGaQCb9DpmpUhJIIfUe/sLUs5zm3+src3J1t+Pip9Wyxbx?=
 =?us-ascii?Q?f3OT1MqRT/Ib3q3eKEIBy8KfbWawJNOx752Y37bX7ItvofGthynMxIcA7UGc?=
 =?us-ascii?Q?wq1gIkq1eepDSfSH2J2SXpoiULimdnwtIsP/oPWIpQ0DBP7gbKoqmCnD+fGj?=
 =?us-ascii?Q?p3TPCSHYZ2gtFOlSzwy5Aie0ARgMwIrZMs7kTrTFX/9AczFMGKWWqq/7zT4n?=
 =?us-ascii?Q?COmU+PT8/I07Lwv/e3qh3iRy5IWMQo7WLW5yhBTfFUnpzxOeBCnsvUJkRsgy?=
 =?us-ascii?Q?lHMbL3Lz8Q5FOvpqNQCRS2pilUDxOWbScNYIT0lpl729DE24DpfbW9WW6ZV0?=
 =?us-ascii?Q?mzxIiwn8gZZaKu/EjS8qt1jy9twGEB9ero6ghuLmPHjb8FDaCNkOXmr+ir2W?=
 =?us-ascii?Q?Kj/dmnoe0s1PfilWdMG/zgh4oD15TMuk42n7lw7LIwacfPv5jy5wfjvG/ds8?=
 =?us-ascii?Q?HhxaXhP/ayVtZmKLmxpTUGPt+MqOKmGqMITpiDQ1P+pJHsFM9pu0KJBfUmGA?=
 =?us-ascii?Q?kjkWNkW64sr32eVvYpOPcNRViSnAMEGTwxCV6zFE6TLoNnzzqQ3MlHRxrMhi?=
 =?us-ascii?Q?NP62cYLqesJ2KDA3p6ZXS2OZLjlzg8fHDN3vD1nq4fiTnhI14ljJk2c/HDwd?=
 =?us-ascii?Q?CnMDipL7qq9baJIR32FaBTBDxu4ihGDENU3DA/sLf72u7jzvBa7YZCMN9b3m?=
 =?us-ascii?Q?ANvImsuAdoymDTtLMIQcgxGktsG4pMkm0X2XjoOyY40Kl37NQgDmswSF37/y?=
 =?us-ascii?Q?lsszPaL504az2C/6XuznIoP04fZMOO1Tf1fJnuOJ5GZmsKxAp8NVzATmbYCZ?=
 =?us-ascii?Q?fcbiOHeSNxiiQV1SAJBsiNFjIdHbKXskAriDfzPgt5AHYQSzPQJemIRThcC1?=
 =?us-ascii?Q?+zHznvB1nZ+tnFIbDUUpkVVR3S/bHtq/qPju70LftAg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae529d7-f5e3-4f42-46d4-08dafef66999
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:05:51.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ha5phOlvjnGgBhLAySqbvJNKXk915/EAvWTmRJYgAyInj0OhhpdeJsR+f1jG3SjvH8Yj871ueEUk6NAb6XKfPK0w0qmKfxcnxjb6uu8rmaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250152
X-Proofpoint-GUID: cEHhU-R-nztFGelfKgcaqYl945ldQ-Ei
X-Proofpoint-ORIG-GUID: cEHhU-R-nztFGelfKgcaqYl945ldQ-Ei
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor hugetlbfs_pagecache_present() to avoid getting and dropping
a refcount on a page. Use RCU and page_cache_next_miss() instead.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 849206e94742..e506a46b7871 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5651,17 +5651,15 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 static bool hugetlbfs_pagecache_present(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
 {
-	struct address_space *mapping;
-	pgoff_t idx;
-	struct page *page;
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	pgoff_t idx = vma_hugecache_offset(h, vma, address);
+	bool present;
 
-	mapping = vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, vma, address);
+	rcu_read_lock();
+	present = page_cache_next_miss(mapping, idx, 1) != idx;
+	rcu_read_unlock();
 
-	page = find_get_page(mapping, idx);
-	if (page)
-		put_page(page);
-	return page != NULL;
+	return present;
 }
 
 int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
-- 
2.39.1

