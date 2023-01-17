Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76B966E6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjAQT0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjAQTQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:16:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636BD521C9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:29:53 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HGSYkA020285;
        Tue, 17 Jan 2023 18:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Oh8j5JfAQkUPI8oYF+iUmi7/QCok3tXE7mRi6Smqwf8=;
 b=eB8gVcxXjGhHjIYF/fmbKrlYRjJp8nBpR2ttqkOHTQfUXoPKjGi9qumZ3s2GfagiK5Sj
 jDpLw+2xjkb0bGNCgBGBhfcQLT0KzteQpgDGnzL0lKsvlsCgraYo51k7nENTTzg1kqLL
 Y60EKHdtUx/GS1z8irqi1WqS0b12Ru0lppPBTl0NuUXyXjc9jA+Z8m/jvXKCdgZ0xPXV
 lfWDu9XsrWxFM+5abEefaeQku0Ot5+ndITzHCjazxx9BGQcV5cH+yY20ay00IPm780t9
 qnj/CtdDWk3fp3f1/oIGswoAn7aRjqPsC57zzCBtxT9u5eo/5OfTC97h6VewalY67Cr2 bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtunjk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 18:29:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HI4t5E015217;
        Tue, 17 Jan 2023 18:29:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq4preh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 18:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPYsWBhKRBI7+TZ8aTsRAdNdTIj99SivgVo0JQiibyW/7X8N/CAKrcpN9Fg9APE+k86YX2U2iAeywbZ8QTbFFH6oBV3sbhAyM9GJYo3sApa9ozS1dxQtncZve4GM6bmFbt2ftwIwJoUj03irNW/8gaJRBJUKMvO7uD2mCD24b6PFdeg9Y5JEUP30hhrBLoNsEADeCWVZ6wk5OEaEBjjNu5ffn3Pdg3986XRcxOu3CRa/WbAv6K/9OSWAcf80bLE24TJNzxD0s69wtA8B5D8C5DcNA0gBrUkUBjSK051x0UJVi+2ZEqQPDTOOPzm54bP3pehUpZK3fM8CvRLK8NGFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oh8j5JfAQkUPI8oYF+iUmi7/QCok3tXE7mRi6Smqwf8=;
 b=hcX1ce0cTsUpa5+bdYZ6uwY9YeT56vST7A6MfR+aPQga+bNn98ZtmExNGqkt0iQT4HS/35ojVqWrrIlllmiFxKkXaN4pfjxUEQNjLtt/Co5BR3AL4UJD8x26V/IR1GBz3uoyBvla+cUCGC5wwY3E0/kUaeEquIfTJF8lIfvapiTVf/mfBBB7/6ajM6iSeBK/XpClt/KJ6wQi2l19hBECepQnpCWNn8Mu9GAUZdCQwYL+bZKkjdARGVaEsmuhNhFzoRtFDIDFDuz3MYHBnBxRdP4DMdsWUeUWBTU7ypxJozLsodbxYT2Bbg2wiIzb5femCNN7aosi1CsU+Zi/Goe1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oh8j5JfAQkUPI8oYF+iUmi7/QCok3tXE7mRi6Smqwf8=;
 b=ApU3DH030b6rm9cj3saNJ9xNKqQdqedLl4zpAduX+Qk1caDu7kE7u+Y1CZWZQSrYWJ3ZhCrjOclfuU5Ut2w+qt1G85uXxTyt033513V6MOvOh2zKUMhUeCx//UZc5SV4BJwBbN7vh8diyRhQmPnN8sBDsr+jMku7BjPUM6dEszI=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by SJ0PR10MB4639.namprd10.prod.outlook.com (2603:10b6:a03:2db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 18:29:22 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Tue, 17 Jan 2023
 18:29:22 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        naoya.horiguchi@nec.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm/hugetlb: convert get_hwpoison_huge_page() to folios
Date:   Tue, 17 Jan 2023 10:29:17 -0800
Message-Id: <20230117182917.73729-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::13) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|SJ0PR10MB4639:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bac1b41-f737-486d-cb1e-08daf8b8c0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilEnUfKNzbwR04Q1QMI57w0VL3Rl1CHnLPmZkpgRWrsfgsSrg7c8KnfEj4o/aZgqv2EdGd4z+YP/wUaiHidCmZiL9JL8qd5qWcyZ0BmeP9jdSwYo6SdfCb0+1GuJJMoqlWJdUs66a9yioc22sXJlMSPpUG73twHL+ZgiIkas6fobG3yFf9KfJoRhlAPK+kgPwelOcMXQDuMtRulapJgYXssjq3KRwNQEIDCpo28aehGW2Se3AThyOkTUe3Sr9LVXU/7JtABGmB+kfjdEnpKSeUKKdP2j2BB217sG2bJa0OUpGvPapZ9Eivmdb/BvZGgJPqfySNRnueBVMCYJXJQX/THL41Uu0VwvdExtVJTfuAJVVR/EBInQYBvO4szdUmWhPYWInA6+kmrBFjpKiyMVznodApNsj9hwYHIKJdMhZzgjbFrW9aOe5qGNjUuuxwcsxL56Nlh4paOTI+r6yoHJ+ckKXPdUpKLnCP5EHQLoTkpUSx9mUd+dQ6s5TwEm3EIlF0iBYdamz2sV3h0bK+dp0K7X8qZISLzU6sX3ygV+UIFZ2hHAQGFFAgwx9eVuVIV7mdKbQJ6nViy64Dt9OUz2kGV6kKUj4iWG6JH/aYWITxfMXbnxklmeYvHYEo1ZGPq8IawtHDB/tiCzbgxEnoeYZnqKcdXeAuAOMdL1lS1geBt4a+7F0fpp0wLfMAaT5x3B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(38100700002)(86362001)(8936002)(44832011)(5660300002)(41300700001)(36756003)(6666004)(66946007)(66476007)(4326008)(8676002)(66556008)(2906002)(1076003)(83380400001)(2616005)(26005)(478600001)(6486002)(186003)(107886003)(6512007)(6506007)(316002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8+VAxGnwfpeUxiM2LMYWKDGEkrcq5AMjE1AukGOh5FXLRmLP3ga77qI1sfk7?=
 =?us-ascii?Q?laJ1hVbuN40zHY6jpQqWpyG9MKqp19GLAPEcTHoev9Pg/1xVElsCa6IAX26b?=
 =?us-ascii?Q?4gryAitidfoxAIHumkBOg2/t8PqFfi1+i5gAr/Y3VjDSiNwHynLoL5rMWJLk?=
 =?us-ascii?Q?dSsc5hrqMCEJB7mdy/EjBrlBlRuSgY8e4/vSM+syzuWqsaKb+IzRL/+4+m1I?=
 =?us-ascii?Q?ePZI/Ioqhyi25nESNOhk56bTbzLwT1A2Q+P4bMJoj9aIl11DLnV5d6VoFJll?=
 =?us-ascii?Q?FGiq6jtQnk2VIPCWiV06pGR4OeFqNzKFePKVNFMO5eNFH+/TXPzawVqIG+OF?=
 =?us-ascii?Q?HUKKqP2L26yiYA6tYDDl+VzUnIB74uwXtEpC0OCzw1Ers7zVj45D+f3mVJZR?=
 =?us-ascii?Q?SyPrECv/dMmjXPXEOMRdkb3qI0U7LnyERsaCVpVyG1WhhrxVFwIUa/iHo65z?=
 =?us-ascii?Q?L4FLxFO1Lrkl7lT6guwb2QaM6ZEsaRiZKYA/TzpOeF7WCy1H/+k5mHZXjvRo?=
 =?us-ascii?Q?ZPY+2LRQ/jVleAAiBXha1qgnXLspL9fcXlMkXTVDtzsdKD4iuW3zzDKfEyYa?=
 =?us-ascii?Q?7U92dAZYJy5yaKC92GZV84wcgGKtG+1qml9VFDg00/Dj8s/TTpwtTvp2POm1?=
 =?us-ascii?Q?uP6vppz2Znnp2xe+B3yzZLlPKVKyKw5tHkyrCaTx9jnYBAJkvEsFEyV8+3tv?=
 =?us-ascii?Q?P6V+FUGkMKwlOK/TT0x0qWpra2EJKCtFPsEsttWv50iW/tosskf5LCbV9tog?=
 =?us-ascii?Q?SyMLg8MnnlG39Ml4ZX4+afiO/iaXc2WtFpGKR0u/mHt6VRFuOFMvCe2cTQAv?=
 =?us-ascii?Q?n99a8R4hCxym2MzgsUzIGq1Zc+02WpQC60hw7bqcIBWWVd68SrszC7brO+ca?=
 =?us-ascii?Q?qQG3+5VI4vMUe4IjWNi4YI6yju6ZiXE+xACcHAcT7ISZqkI0yQ3NQbsD9fTE?=
 =?us-ascii?Q?HonKaD5ffjO7X5t1vkODZ4V+WrO7raHxo/Q5tmNkVq25nNL2VX01eSClTEmP?=
 =?us-ascii?Q?MhP6TMRiqJfdZzAIYbFZq3w87YD/sjsb8QOy8n43gwxPvd7YhQFq9XS7DOMf?=
 =?us-ascii?Q?2XWpJsz1ENsitA6o6fQ/V4/QUbd5wd3N+fgW5qbiLU4xUGZZ1gZPsl8l8GWK?=
 =?us-ascii?Q?olHIx/0G/OeC4FFqTCJFOfkEX/D2n+7MLy8yRpyfvAiIjpqCVg242u6HyowR?=
 =?us-ascii?Q?YSjS1AEPTU/YaOnwZcCMrcsizJodtbDyQh3e/D9p4XUg7VDUpjipQJH968y5?=
 =?us-ascii?Q?++aDi2p7lSyuBoepGx6PUlFVXibYCgE2GgBJAWYFOFTl+xaR1mjk0XUkrfUv?=
 =?us-ascii?Q?6y0JssYQq5vK81jaodRNBr1FE9pG1BSZtBevTrg5OqK/nRRz6qAiVm80oOmZ?=
 =?us-ascii?Q?ReIgzs/rDjm372Fh/JSsFCpyzhEAybrrcco6fU/PKS4+YpS6OoPTMBmMOvt+?=
 =?us-ascii?Q?U9lUqIghVakzwTmJHH5F7Wi1X/zSEKUVLW8uxDPcG8Qz9qCCOYK8lwuyOz7G?=
 =?us-ascii?Q?qLw4rJnjUoDhdK4irXxpG1jPVGsAhmxcmumxHdDLvkAkxZ/jMZ9XwB7pNNq2?=
 =?us-ascii?Q?XseEkb1G4xP0bC4K63gkrCZyPzsDnHXh3bA/0SSIRYRR8HNw7cuGQJ94KGR/?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JtJ3ZoHGoREZIVT7YU8hQbmefmPr9WPrOCxDLp27Dy9VMVr4CYjVDbtRZHvs?=
 =?us-ascii?Q?R+jCFL1mj2DRWagVLP4LPLuqzh0Ri8ywZ5et6ziMS1yUWtRfW9jNY0R64KeV?=
 =?us-ascii?Q?iFX4RZS4XjfU624pXPUrg8q9yPumXTMZnDdUM/EoLjFuF0slmCwKMI/v3ldJ?=
 =?us-ascii?Q?mXHKHZw27Bqp6okpCKM5CSTVwKv3oRQKQzS2vki3IuK+SOBFHRzx09GzM7Dp?=
 =?us-ascii?Q?5tMKTNiG3AqIubrdqe+8UIRHqzJ2WF1ClOsdKnKVYRSCP4veK0X0pK0Bb0g6?=
 =?us-ascii?Q?jDldHmytVFM6uYjMldSeGiZdTjhBMsR1p9QsZ79O6twgXZdEv8mLNxyCE5f3?=
 =?us-ascii?Q?hqIm61t6gecvaDzCZYZevxItQm9QKbCuH7/3pSUl4LHldRfoF2SqiDjmSaR0?=
 =?us-ascii?Q?hu/8d1SF9w8CMqbTQ/1u+TtEaHQ0UM8ZNrfbXrpNZkAknLqPRN72KaGUeaSG?=
 =?us-ascii?Q?a1cPiqjJchzEmpWAjKR1MssLBZYBDY+B3JiGciAqwU3tLLny4O/Smj381lfK?=
 =?us-ascii?Q?AW7sxh6UISSTaOkQ2Y2AFKmEoIxbJIjG9RVbuzHo4NZeJFnWVdaOTP4RNlKy?=
 =?us-ascii?Q?2cU5RFmQHLjPJOQld0XS9FcsgzxWEqJBR8pn/3s0qr3nCIOn/QJ/h8e/hECd?=
 =?us-ascii?Q?K6jFiebCNIAZd9BsjqRej7DSBa7w+alH3Sa1g3k+p3zx5CacqvP0WAMfs2Z3?=
 =?us-ascii?Q?xglXhMJKlTnNIgksHM8fkmBNLEoCrDZhVVx35WVcsahOpSJpimLBQ2JhBulJ?=
 =?us-ascii?Q?sevOq0t4RK4vYWyOpVAwZOYHOeVAF6zA9TyCm6eUlu/tf9nmqcuomkXoehtV?=
 =?us-ascii?Q?w94ui2C/jXAmgN/U3uOT9KDrRidVMO+aTXiYNE16hyRO2F+QM44JZJm5Mx3d?=
 =?us-ascii?Q?lLA05HE8ZegUVne2HET7RwLHsHZ6K0JCx3f1CgfhYmqcQ2+Z5rnlHu2VdvG5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bac1b41-f737-486d-cb1e-08daf8b8c0cd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 18:29:22.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+BHIM08+V3G/mOCaCZ9TWEEaJbZFshJ20skCuTUbkoQKvBM8JUx9jjbBNh8sGTetk5RyGM8QTKz2y+evQUZYU/AR+sp+IcRpE854ZjDNGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170147
X-Proofpoint-GUID: 8pqPNnBuN-3T6ifhF-0wjLJ0AFASGF2k
X-Proofpoint-ORIG-GUID: 8pqPNnBuN-3T6ifhF-0wjLJ0AFASGF2k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Straightforward conversion of get_hwpoison_huge_page() to
get_hwpoison_hugetlb_folio(). Reduces two references to a head page in
memory-failure.c

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            | 10 +++++-----
 mm/memory-failure.c     | 22 +++++++++++-----------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index eed1beed23b6..076bb8c037af 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -171,7 +171,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 int isolate_hugetlb(struct folio *folio, struct list_head *list);
-int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison);
+int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
 void putback_active_hugepage(struct page *page);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a5340a807874..7a7422a43538 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7284,18 +7284,18 @@ int isolate_hugetlb(struct folio *folio, struct list_head *list)
 	return ret;
 }
 
-int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
+int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison)
 {
 	int ret = 0;
 
 	*hugetlb = false;
 	spin_lock_irq(&hugetlb_lock);
-	if (PageHeadHuge(page)) {
+	if (folio_test_hugetlb(folio)) {
 		*hugetlb = true;
-		if (HPageFreed(page))
+		if (folio_test_hugetlb_freed(folio))
 			ret = 0;
-		else if (HPageMigratable(page) || unpoison)
-			ret = get_page_unless_zero(page);
+		else if (folio_test_hugetlb_migratable(folio) || unpoison)
+			ret = folio_try_get(folio);
 		else
 			ret = -EBUSY;
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ee8548a8b049..7b53fe287ea7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1257,28 +1257,28 @@ static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
 
 static int __get_hwpoison_page(struct page *page, unsigned long flags)
 {
-	struct page *head = compound_head(page);
+	struct folio *folio = page_folio(page);
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb, false);
+	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, false);
 	if (hugetlb)
 		return ret;
 
 	/*
-	 * This check prevents from calling get_page_unless_zero() for any
-	 * unsupported type of page in order to reduce the risk of unexpected
-	 * races caused by taking a page refcount.
+	 * This check prevents from calling folio_try_get() for any
+	 * unsupported type of folio in order to reduce the risk of unexpected
+	 * races caused by taking a folio refcount.
 	 */
-	if (!HWPoisonHandlable(head, flags))
+	if (!HWPoisonHandlable(&folio->page, flags))
 		return -EBUSY;
 
-	if (get_page_unless_zero(head)) {
-		if (head == compound_head(page))
+	if (folio_try_get(folio)) {
+		if (&folio->page == compound_head(page))
 			return 1;
 
 		pr_info("%#lx cannot catch tail\n", page_to_pfn(page));
-		put_page(head);
+		folio_put(folio);
 	}
 
 	return 0;
@@ -1347,11 +1347,11 @@ static int get_any_page(struct page *p, unsigned long flags)
 
 static int __get_unpoison_page(struct page *page)
 {
-	struct page *head = compound_head(page);
+	struct folio *folio = page_folio(page);
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb, true);
+	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, true);
 	if (hugetlb)
 		return ret;
 
-- 
2.39.0

