Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FC766A5F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjAMWcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjAMWbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:31:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFEC76EDB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:31:45 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DLYhPP015861;
        Fri, 13 Jan 2023 22:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=JSuCthEGD9mFVQwtGBQpQYgIPpxHUVzJky4kAU11Yd8=;
 b=k9zcBAHm7ighNBzTNll3x70ykerRhWlMQIObu67JpHW6szowhyfO2t3vctzZiZYlZq50
 5ygl5YDFo4oURmK86asQTki6aLhoBVBicPa2LZXu5cKgObGT/qWXBoB2jfQvR34gyeOE
 qInbcnH+g7h1XLg3jETw8xLF2j01tM7IKs+eD0rf11Qj1WkIh1vxnhzRFL1r0vExEQSD
 iT4tLr4w1ivB+1hmdi5k40sW1s7vCK9nP/ujExmhIiaH0sl48pNDsp7ar2e39OBk6Abv
 qiE4goS6Px1rBTdtRhk6BVXfnjFvyeEAKhVIDnMzUFypYMbBqBmDRGP4biAKQSqjoJBy pQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3av80phf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DKwdPV006693;
        Fri, 13 Jan 2023 22:31:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n3etdjktp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3qwwdmQIIr41OyH3VJcEb98gJatl6EX+A6HDELIudBUTWyBZxLB3wUEeLQF8/q7dYaqnqec/w7lWVI00lXF6ghmgwsLvCMJWhbfSsMZjYKCL2wCkW1FUiW9A8b22s0IulPMKCois86lUdVJyOvfr64AmFnFfh588cGS9wWgW5fGoj9UsTHHXMyNcv5+7uQZ0FjxjIbwcXX9wG3twjQvMHju8hQlj68HSTd2UXYEfnp0AGvoXxoyaudAZYzgAx7p6CwJeEPBhnlsMUXucKe6kqZ7E64+kw/oeTP1RKDGm1v7GmxIIhFpSR6HrMwWSUoYGiFwfspTOrht4G0rrXvhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSuCthEGD9mFVQwtGBQpQYgIPpxHUVzJky4kAU11Yd8=;
 b=h6i6Q8R/nKcqJFpiPcfsf+npzun/SH6g54hhpnPunS5ZKogdVamfzJfIH6ZPE6PcKgYCwZAWsX626gsEKDmcD4eQcN/GY+QIydrtY/yjBNs86d9oTEs1YTuGEJU0C0s0+wUEBIFYKXiMFWUwuo6vU94Hv2EzZnywcu+nxTrBx/FExq6vGgtvo5KcWaDtGJ0mm6hajjAebALSdcWR19TOLo+jt+O/KXx8AM4ZXWioDT4LQReWLW3272eFbskm83LJaiTfINsj2zNTcAPUu9uv/O9IGjgJd9qIdnsx5uLiNFIGe5rCOW2OH+ix4r3nh2DWdU5sdW9zheNYGp5HMgwUig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSuCthEGD9mFVQwtGBQpQYgIPpxHUVzJky4kAU11Yd8=;
 b=tq6pBPjhzrADvnJ48bgAgb7cdylmkPLp7Bqh/y/6KsoEIF5uhWbY0Lk63mYm7P/BFCVuAymVCQ025spURcMDr+QU8YJ4tHQYlQPWWlOUdi6Y7aoQ7wv2Xee0c/hJNd/NWOMcNkdzZPzzO/ti+OJGRuZx8C3krqd5soo0sMnFhUE=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 22:31:13 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 13 Jan 2023
 22:31:13 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v3 7/8] mm/hugetlb: convert restore_reserve_on_error() to folios
Date:   Fri, 13 Jan 2023 16:30:56 -0600
Message-Id: <20230113223057.173292-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
References: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:610:32::26) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 15eb3f18-121f-442b-b1e5-08daf5b5e0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +h0wskAd24U8NZcCTltxm//scDJMWT4Rnqp9OM6OAp56uZD7YzzhRGHPvCDLNhuqdF6/NdFM21Knoemo0IJ8GWO25WGoMl03m5SNdo+2kyWebC5xeLlYo11rwF7fKtrbB+uT7GSlwlUNDi7qrf9xafrHh7cbId1unGvXtp4Eu+z1BVqN0Vyym7I03LEZGyjmb30Wbv4HgCK6aiZsst+44t0VfwcdhGhPubBnR9wUDgB/1ZECgGhNdY7SkEl2mxWrk3LlDTtDWfLYmN06VSoDTIKZR6JlB0kj8TrBvXsMPdZrDJryZTqPN0OMZmPiCjavOYIWaLCJMWgcoAOnbzI+mQbhX2/Xs5U7blDuXEuWxVSqEG/jqGscV95EZTkqpzr6e8cPs4/Ckll6oZYf2Uceb3RoL7eiQzeewZGhbtAEF4/iFwC14NMy2jJS5xorrxCd8nWtNj8Pw4BmSre0/XJugDIynhqiLBDOi5MfZgGndxU235XL7ptWaMlOkq3SOyaZlvkq3JfuHqJdWLugclYiOBMurrMoJgk/Vjy2I0GaVHoSgqO9005A/vs1JFff0g9MfUbQwY49/5HhvzGo3fI/bIyu1JreLzaDq0tAWcAu5C3rjGNVahA0JgOjoFs+ve865oT9fR7GeToxADjlb6JRnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(44832011)(38100700002)(86362001)(2906002)(41300700001)(8936002)(5660300002)(6666004)(107886003)(478600001)(6506007)(1076003)(2616005)(26005)(186003)(6512007)(8676002)(66556008)(316002)(4326008)(66946007)(6486002)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QxvetK3TwS2Mh+SE+KgToFOY5HxuN7OZGD9RGLpkDnc7d8kTLjCqs9v8LR1S?=
 =?us-ascii?Q?Ehw7CUsT7VndLQVXrWTxpoZ+6sU3dmJhEiteMYvV+f6CeAHzDecSNEqDkWXr?=
 =?us-ascii?Q?ejTcYg+A4MjHb+Bgc/cEvK8mya++sP9xR7AfCeQIATxyFwblMQT4BYd5Xx9V?=
 =?us-ascii?Q?5Zmy3YVaG4B0NHgkJNW5Avds9wfLE2okTxzTGgt998zShGPqps7OHzSr+iGg?=
 =?us-ascii?Q?lbla/eBkvHiUBOZGPZNmlqaU2+mYqB3FU4oaY9QCB9yIvzInXTnG4fZk3U4j?=
 =?us-ascii?Q?rexU2VdtrIKWPQ+aaSJ/9+bYDe2+ZQypFgkiI4cnj2+UD9Rfze3qB3bM0oZX?=
 =?us-ascii?Q?zkAlgBvno2tDZVWWtzwLC0Ow2Lql1o4kmLNaQnIfr6hU+FsGcktu8dYVWCv8?=
 =?us-ascii?Q?xa6vzwIHZQclurrUZt0JOOYZpEPtyZGuPBPSwWgPG5nukg8Ig0oPRqVGOTgH?=
 =?us-ascii?Q?+ifXULk7wJ1+XvPYtquHCtO/cb0H916DppSQ7zCmpAdL+JUR4rnJBKj1Lb6+?=
 =?us-ascii?Q?0Skb4NSxqY47UEoM9e1perLd12JY1p4j1f9t4QtIoZdpjVSq4KSyjUpTgJer?=
 =?us-ascii?Q?KblSBnPe3/gfyQ9noZuzuf+KYSUTKtx4DVgB+5V6Yqt17LSUyDm5l8hK2EXE?=
 =?us-ascii?Q?kvfM6mxlXzQjOE2XL9MFTzigmTXJ0AwJA2eCFrZ0ydGqy1fHKoWtFttTSCmm?=
 =?us-ascii?Q?VnkhAxz2LSphzlnuhuZY2gu7EQVWJOugm09XyCZ8N/Z3GiQaWov2Wy21AcPB?=
 =?us-ascii?Q?hSOz53VNOauCT7ek6BAY01fPJWNsQqgBcwOtlWH0M8q0JfH9ZmCqFBCaQ+wk?=
 =?us-ascii?Q?4OsS2Ww3NbOk6CaNZmaj8OWtx+HzfX6TXCF7JPcp1vharEalcanT4NvtfyxU?=
 =?us-ascii?Q?kWAEC5/x+pgp8VbX6pek286t7w9i1e4Rme4EnP906skBMtyaztLOJ+htHG2b?=
 =?us-ascii?Q?QZO7/l0JOp7Io2eBD9KkkCmMe04uuj4/HBmRhwEE/jRO3CSdJSFP2HNtId5z?=
 =?us-ascii?Q?TF80VRWnuDtFUlpBz0f032DUPB4hGkUXwzjy86TyUAexgIXWib1Eu/1lB7cd?=
 =?us-ascii?Q?2mOoYz6Uc3fOWTVpGulb3AdyzQ/c2ox/ZeRzPFprjGpOjES6TCjBoja4GZFB?=
 =?us-ascii?Q?s0xH9N0ejcI9yktppDFDg+3qVw/2kTYpghNxj8KzDJvIHEKkBI5GyiggmYcM?=
 =?us-ascii?Q?pgSALksQrcRW/TVa7/Y0uUefShgv+49Odf4qC4kPgIyb+YZckdRCwNn2K4AT?=
 =?us-ascii?Q?4uOJJbyevU0hjxrxOAcl/nVVxpA91IvuxprfspNkGQShJj95p350QIr+LsiE?=
 =?us-ascii?Q?WB6Z62du5BBPAr+6a5vU5mYn5aCcn7/Nng/Cu4ClTctGpAQjxjXq+IEo/8DD?=
 =?us-ascii?Q?l2E2J4uuk8NpxA9cewcahvQKT4CQ4s2OSF2wXwT2L0C7Zg+FNYvXIEjULztJ?=
 =?us-ascii?Q?PGuUaS4rJxy8v1lM8oPX4g8iFIiC/bEGykzAq/ImUqbibv0pyMssOrVnRJyw?=
 =?us-ascii?Q?3lNNontGNK+bNjR7PhqS5Mdbz6MVaHy/rWRt4lOfbxEzgwtK/objrLuE0S1a?=
 =?us-ascii?Q?rItMd80uSHXpFIHbiZ5eTsVAn/XWW6i+To1bMmSM4fJcTWfs0iMisqIsQDpx?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?K7tKzR7MXEZVYBwa4fl8CI4LRwPC2LdoGqQEmwAxE8k3Bd7hy2dH3fxWmK2w?=
 =?us-ascii?Q?+m4dV46lona9FlWJA5+TK0NZGVJwDQhdlXho+zM5myNvsV3DNlhQVqxFW97y?=
 =?us-ascii?Q?Ke4/OfUmJjNWAplgBxQbdWYHR+fSP1b8TbwjIQ7YDS8MlnVWw9MJEK0JC6+2?=
 =?us-ascii?Q?+srpbfIUneGscsXI87HeTo/UtXFHBXYxgE6qyltLoKZJ2QzHFd/mVUnpEWvc?=
 =?us-ascii?Q?VsRJSbn89QUeRPKRxjPC8efZLmhOdLQPPf24fou2CP2/1vSdBamQ8YS9eYOt?=
 =?us-ascii?Q?sdtcCAXZ3RntlBJIYmk9MCzwRGdOJjmvtpJKA+ll7lpKmUbwY1R2JA+kfIim?=
 =?us-ascii?Q?24Mql8NtWgSnXFWK+eqv7ClvEpdomzvml49gip7VHV1eEY0SHzcrEd/M8m2M?=
 =?us-ascii?Q?hwyLjIDsDAdUXAxwKFbgE0qdJiQNO65Qx/H70fHgq6ms+yNBAVyFGMzBz3V7?=
 =?us-ascii?Q?fDlkNt3ehyMEg9ih+uForfEOqRAItp2I/fC0r7sq0P0x2jJJQ/awv+7ava64?=
 =?us-ascii?Q?UKy1aMVNgFexU+6z4GNPzORqkvVU3KHkyG6yi0+ch6rdMPkQ1tHIOh7f0afI?=
 =?us-ascii?Q?sJmnJJTSmOt5oid8rzg5kZvXiZEROzUzHja2vo5mFun0iqGC9zSGUrnRm4lN?=
 =?us-ascii?Q?fyIHBSJlHCVPzoOcySlXLVPFvOXTzIPJVdlPAbzLZjjQAwlv3KTGWgK8jM5d?=
 =?us-ascii?Q?ODKYaIHcm0HxJP5a9Zv/T60JrksZYbDxNGRutbyv5i2Ij8i8RqudhVu0nwRg?=
 =?us-ascii?Q?KmGROVxOVDCsM43Bm0R9x/bLjsAAE0xg8lGFVUdc2vlmNnd0Pu2b7rMNNl3E?=
 =?us-ascii?Q?8wyCOPk4McqSXRviM4RPIBD0CotTm2uWkTisrQjNP1q9ZUeOeix7fQ8h/ZUF?=
 =?us-ascii?Q?OaboHQvJxxq8lBmVbJtLXSG2RPbqAbaroCz/t2n3IDYBm++PDuvEKD6XUXBZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15eb3f18-121f-442b-b1e5-08daf5b5e0c7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 22:31:13.6509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKoedDfAvgXV6n76aOwJ7bYcqGLQfzNLRg6mL/PecsetJQS8RTyFM5Iq+LiFKNIRsWHt7JrjV5YN+BlrK2YTO5zPAFG6ZKAgsvyoeFfX1w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130154
X-Proofpoint-ORIG-GUID: pv1G2gLvH0lszx2CIc6ZUUJVxyxK0i7M
X-Proofpoint-GUID: pv1G2gLvH0lszx2CIc6ZUUJVxyxK0i7M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the hugetlb folio flag macros inside restore_reserve_on_error() and
update the comments to reflect the use of folios.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c0cfb075cd58..f8cd0c694fe9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2675,22 +2675,23 @@ static long vma_del_reservation(struct hstate *h,
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			unsigned long address, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	long rc = vma_needs_reservation(h, vma, address);
 
-	if (HPageRestoreReserve(page)) {
+	if (folio_test_hugetlb_restore_reserve(folio)) {
 		if (unlikely(rc < 0))
 			/*
 			 * Rare out of memory condition in reserve map
-			 * manipulation.  Clear HPageRestoreReserve so that
-			 * global reserve count will not be incremented
+			 * manipulation.  Clear hugetlb_restore_reserve so
+			 * that global reserve count will not be incremented
 			 * by free_huge_page.  This will make it appear
-			 * as though the reservation for this page was
+			 * as though the reservation for this folio was
 			 * consumed.  This may prevent the task from
-			 * faulting in the page at a later time.  This
+			 * faulting in the folio at a later time.  This
 			 * is better than inconsistent global huge page
 			 * accounting of reserve counts.
 			 */
-			ClearHPageRestoreReserve(page);
+			folio_clear_hugetlb_restore_reserve(folio);
 		else if (rc)
 			(void)vma_add_reservation(h, vma, address);
 		else
@@ -2701,7 +2702,7 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			 * This indicates there is an entry in the reserve map
 			 * not added by alloc_huge_page.  We know it was added
 			 * before the alloc_huge_page call, otherwise
-			 * HPageRestoreReserve would be set on the page.
+			 * hugetlb_restore_reserve would be set on the folio.
 			 * Remove the entry so that a subsequent allocation
 			 * does not consume a reservation.
 			 */
@@ -2710,12 +2711,12 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				/*
 				 * VERY rare out of memory condition.  Since
 				 * we can not delete the entry, set
-				 * HPageRestoreReserve so that the reserve
-				 * count will be incremented when the page
+				 * hugetlb_restore_reserve so that the reserve
+				 * count will be incremented when the folio
 				 * is freed.  This reserve will be consumed
 				 * on a subsequent allocation.
 				 */
-				SetHPageRestoreReserve(page);
+				folio_set_hugetlb_restore_reserve(folio);
 		} else if (rc < 0) {
 			/*
 			 * Rare out of memory condition from
@@ -2731,12 +2732,12 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				/*
 				 * For private mappings, no entry indicates
 				 * a reservation is present.  Since we can
-				 * not add an entry, set SetHPageRestoreReserve
-				 * on the page so reserve count will be
+				 * not add an entry, set hugetlb_restore_reserve
+				 * on the folio so reserve count will be
 				 * incremented when freed.  This reserve will
 				 * be consumed on a subsequent allocation.
 				 */
-				SetHPageRestoreReserve(page);
+				folio_set_hugetlb_restore_reserve(folio);
 		} else
 			/*
 			 * No reservation present, do nothing
-- 
2.39.0

