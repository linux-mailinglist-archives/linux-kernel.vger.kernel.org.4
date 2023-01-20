Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D688675CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjATSWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjATSWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:22:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37B3524B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:22:03 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBb0s003343;
        Fri, 20 Jan 2023 16:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=DgWGq0X/scR3Bp07oZlHCAr7L89jhXEut/RbqohpkU4=;
 b=znlp0omuS3obtb40LTAYUauurUB3+Zw+q8jxfONOlX7G+7g7f06MXSiEJFlDf4AArp0F
 fKLNLg7fu0J0RyOGuoZW59X90Sn0PDSUGtUnAPhp7MD3SG6eD19niecUROFebS7Khk+G
 0uWLpqECa9Hr7GYpAeAbR/0QvT3sguUy++l4Tjcj9iBl1QnY/z+IaBdBKFRwarS5OBiE
 dhHJQL1b0by/mBrGxyk9jtQkSv4hPixz1uq9BQshyyfeEKxtZMbLApzrik7DLSovw5NL
 L4AKpRMxgrfqzAomA7AbMne2BJyz+9Vijc+s30N/x4k2JWxqoyZmOrb2B5O02JsuqOky pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medn7j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGBRDL013478;
        Fri, 20 Jan 2023 16:29:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmfb0ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyAyZsky7jkbyY60ZtXde2/eBcg6GtkKXX1X5VROUGlZM+wYXJsgXPCY+j5gbLkdmkJnibfLjjtCr/sw0KSpv4kkYTSxZ07iBP3o5+76xUL+FGRjWUkDmnG56eh89fFtpgkzoYU43M1UPXc41xAVnGVgc4nlK+DCsVYdUC4EmYcLdhTIuxOgQ6capVoMIxEtNpLMGRWI1de3TOr5oGUSgjdLDY5bPwby3VoqIenS1k1lp4V//PO2e8lisLi8ytscRP/YabU+mCy4hiXM4RS2iS039rZH5c5MXXruhGbcKJiRB45Igwc2FzwGaVqD+KSJEP7Slo6tPLoBvjsck8tUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgWGq0X/scR3Bp07oZlHCAr7L89jhXEut/RbqohpkU4=;
 b=jx5dKVN/T1/0/80d5nCa5Lr6V7LgesjjAxxWEw9jxuDb8hmvQ9jhRHPqTybzxBAq4NnXjZi27StD7NZYsDtO8ZETVU9LiszRYlU9uo7tDN+ctdz3s5oqIXHWlpypHeOxibYDPjbZLn6zD0a3sKDEMsoIS1iJPskUOCvNnU7Q5FCS/FrPNAUf3ij+bLriYVSnGGWBgrbxAM5CODqjMXVrkDVJHoGvozPo4Ponsn+sJXJUAsoIJRTbUrYr76VFry8n7EJiwF+eC4bUuCA3Z6/7r1DCBg0pQYV0ZpWPUVbeq6hW3hN79lgDcIANy8LLqoW8KjLdQNXd5Y5CsNFqxTCHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgWGq0X/scR3Bp07oZlHCAr7L89jhXEut/RbqohpkU4=;
 b=xYrFXEM/LFd+JkW8EWcQuQTXaJ2cMShEwip+D6ACRvJsCexvbXS43BKB09bXE/wQTTRz/qSe7hz33EIOyfL3se4yDfzKgFvEUlIBBb37rDFp3keePE1IeAZORxvAfUS72N5Qdsx5vUSoPsAxkPzZuZzt3Ie78NA933J9u/I7Uy0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB6400.namprd10.prod.outlook.com (2603:10b6:a03:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Fri, 20 Jan
 2023 16:29:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:29:08 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 45/49] mm/mmap: Don't use __vma_adjust() in shift_arg_pages()
Date:   Fri, 20 Jan 2023 11:26:46 -0500
Message-Id: <20230120162650.984577-46-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: e94ddc92-55d9-47a3-feff-08dafb037434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQHxR2pWzR/1tsle9p/F5GY1tkSFd1PZle4Jng1LNb/bqLJNaJWVT7qlFRqSGv0Wk5srly8UaQgwOYaFkF86DxXMd0lhd32fPMf0VdxaIEsT+wlDx8tW/KW1qpknE2XJUcezret94y6iJpPMGepdbnX4+7XyADepjw4YQ47tBCf1nBJHl88ZJlTd6iT5CQTa5XzQlj82ZD80Dia1TTkqFsHeD1/2asflqsmzfcyQtCls/IoPV2uh2r6keRJXoRr7ilFaqgBg8S845HxKtFffOwPvu4os3HCiAIJ8iSzX+qsVJTRkGQnYwLQWL7Rub1aO6VBuR4nS7rEEklpU9PkEZgwYQ7wxpzEp6kUtv6mY0ZRVnySC0lpIl2lHoHXaItT5bG6Zbj1w6QN/jL4ZR3ovVZSA6aFx72ugzf4CO/V/baD2MMKHvACe7nUpmt919lAwAEwCNkACg8vKWPUmIcXZvpjrpQkH4H4xp99tsCnr1SRSuUpmhSJgHi6fuBs5Jve4zG/aC+OS0r/dMQTsr4tEWQgkDTItpnuGT0VMCl6USBV0pDy8LWniF47YNudmjxbK7qpsDyp2sdFUgw5QlHJWgVLLpSEL6kZEZeF+lHnIg8ovdrCQc/rmDuE2F/ETVfMHMEfl20v5wXB54uX4zbFDsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(316002)(54906003)(83380400001)(2616005)(1076003)(2906002)(66476007)(26005)(6512007)(186003)(6666004)(107886003)(4326008)(8676002)(66556008)(86362001)(6506007)(36756003)(66946007)(8936002)(6486002)(38100700002)(478600001)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c6Tbx1w6jgzIwfod+j5h0hhfeufKfIpvUJDfb7JfglJlCh1e2WV5T3jr92aM?=
 =?us-ascii?Q?Fo6X0/xYSzWhe8oieeXClm0qCO20VxpdwUjOdRCynRV/cdZOMM7lTsB5LH2V?=
 =?us-ascii?Q?bOqzSHfKHw1iP4hgsa0uPlKCSE/iyHJj0XSoSpnfrb8g29C6H5Xdd78Cdpqu?=
 =?us-ascii?Q?VsuQRpcm+HqNHMzf+TNCPlaMhhu2AAXuMRB9lzAID060rizixFvtxjZZOuTH?=
 =?us-ascii?Q?iaOftyU90W6t1fJbKlqXy/u+MOLN3JCyL2w09zApjCRROQFCfxV6qDZvz/KJ?=
 =?us-ascii?Q?6lZEpkU4zhizqj8jSO4jU8qr5sOAQNP/CGmCTosJcOzjax5CwqnyWlZOzhqr?=
 =?us-ascii?Q?lOYSdDsKhObIW/Y3/+TNUK5zXbIAGBcy42uTMJSHrv4Z1DtfPlr39LsD86VY?=
 =?us-ascii?Q?+PiGBZ34wXT6q0ROOFMkE/zo6+BjILW3oEKOG1gTo7BOhTW7+N6XpQEOAqbd?=
 =?us-ascii?Q?CanQH2uvf+GIJOsTxVHGPPttnmTRR0i3UAiZYqutLXY8Y8MhD7Pw5X5c5WQO?=
 =?us-ascii?Q?wvJz/ymmd7ZVXMnQT+OdRgBwT+XFZjrwIcdFXRXYPk5bKiJI/sV6APaTWlNf?=
 =?us-ascii?Q?i57ej9yZke6x+10AotLBQNEqgJIaI/bTKbbG/5QTCMvVbVENSX2GkX4k6yRa?=
 =?us-ascii?Q?hwyHeh2hhqC9nsAyB6qn1sMYmChixedSUFznNRljVOydTCbS3LmcSNOtn7/C?=
 =?us-ascii?Q?JPbBo/KKOSj0KYp9BX4E9kvqSggnnlG9D5cvW/8IfqDxVT5oOfiWsyMc3XDJ?=
 =?us-ascii?Q?v3vlzpwvI0c1milM5HpMR/IjKFKOg69iHEWn1iQgkPz7a745KM9S0UB+V/pN?=
 =?us-ascii?Q?fvb8TEUzB9RIfG+quFWJgZY0bzXLHCQH+MvoTACnvLxCLlGTIdnJV/PUuoAG?=
 =?us-ascii?Q?uJKsvRASl4Tp/N4pW2DfQDsOeRigXEh/hZewiCha0N4DOACWz01GXXhWGCeT?=
 =?us-ascii?Q?1iHW2WB6iGMjuGDysFZdfRlItkVSZzSD00bc66kmBO2HHnIBmrn5rKQwKCJD?=
 =?us-ascii?Q?YFgyX6OowSzLCKYjGp25/3phDXuRyXLE4B6qQ9K0UIPxsiSKZ3zFQIIzBkz6?=
 =?us-ascii?Q?Z3CqL2ugt/Aun04Dn5zfEJc4HEFnpW1Alfs6HyIYc69vqV9RlIzvnljkexhK?=
 =?us-ascii?Q?EjH1w454GWopkwEMQV1i37ZYLLgNmqFAp/WlyVX9MEUXdj4XVVq4BjSV5tpE?=
 =?us-ascii?Q?PIY7kEMd6Yg3r+BJI6PFRejub0oTGgsbXtOXMkZpaQ54rwW9g0/OyQ54TQCz?=
 =?us-ascii?Q?DmrRs4654WI2Biw0H7eW1BEIa2lztoHL4EIGP3Ax0BUOh/If2Z/NF4MRSkj5?=
 =?us-ascii?Q?srDdC+qt5hwgGoLzgMl1mmUazo2fb8ZFcaGc18EjXOoquyzQ98h40uc8LWmG?=
 =?us-ascii?Q?CyiqqRAUhS8/3ePJVKiUAcEwXX2S+BHx93MV04ucBFBE7+77H2dZU8fueeNN?=
 =?us-ascii?Q?dIV+/crPdxfafq68OKeaf+PXM0LNFNP8gkF3oO2/VJ9q9L5w3pXU93ozV9BA?=
 =?us-ascii?Q?iT2oMUWI0CDoB7+hoWCNJiM8WmUYrkbgHo76Tp9Bw4f1UBpR3qTEbBkCW6jK?=
 =?us-ascii?Q?OGhyAIyEB4lmYjZM1XzrKkAetjcuN9LdrJOvzQ4tSVHRU/fojGszGRRU98Q1?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1QrNr6RWcvR2X3Y3W5yt+5PkNpPabym57wgqZVw37b25+BXeUPyqyrt4Wqt4xP8QB8R0DCE7H8PG19T6CjuZFVdYYlGWs3HfFjigRdZYQ2aZj1Uajk7QaYRso3GPY8e2zv6EXz4F3B78JlWiekRg6xdgXW2IDRYJHBaEHGqVZXdF0uXifArHM0HLnnOnV0iSXORxB4uPJTeLFiBPvL3uojEHl2FKIEUJKsN4kTvQ1C3GXQL7dWFPGzWYN1yJlCFSPB5Jgt56QJJjT7Hf72uYJ1anvG8zkudSzDwEV0ITBVEdDOzhBiP3/osqTUCLt5OuMXuJuyuw9MAqn3UQp0QvwJdrLK3D6LfBX4jS9Fzc29ZuO/17WxDjxB87G+TfbL/WS4h1Acm/AsZL0vWVOtbFHZGinwIUMYD+JMZW6P7vVT7YlsOACw4YRVCWVqwI2CwoTjPMiIZB/wJF6aO1WmTaeI6/NZixeVG+hFXGm0uZWvtLRRnOfkLhnIMmChuPrqzRE50Usdk02cDYdGAvsNTPps38M+jBOVwKHZ8LeV4U0DmdTW+Aa0MhbKCNWlq4mrwzYg7xBKS0v/f/fRHJRH6j10voHVpCsXBhEzbyLVcsXxEn18U+RwxlRHyBZXTRiNuhBAuaxeyte+dIKf1qB2HJDg90xO630f7d66kxo7OmoMixCv/waRRopdBS8snsjRbVAX2xyvbiatS6KFtBTB+uBn73JQo6ZXKUUm/jD+oeud9Ou1cCnBf+KqYEB5U1pj3FqVkBE2VvFsex9/BInc07Ti81UAYe7XGzGI4u6uu5O8NN2B1snklkuqrA/iCEaLsU0g1nIxBxl2j8h7/zgMKbH1EegaNpBHmbtGC8htkOXjdhy16FbXfi1CCdnt42gXiKIe8XoNXSH6FKTrVfm1UUZA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94ddc92-55d9-47a3-feff-08dafb037434
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:29:08.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSHP6pKqT2agwhjqcjPjMg42vthD/DmmYQHQWJCkb5DIPLoh9hOnvLCOxSXl2rsod3NbGqFzlbpwJ+xAcA6JSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: QJThX5d9G1cd9GT4kxrKs9aYJFyEswX0
X-Proofpoint-GUID: QJThX5d9G1cd9GT4kxrKs9aYJFyEswX0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Introduce shrink_vma() which uses the vma_prepare() and vma_complete()
functions to reduce the vma coverage.

Convert shift_arg_pages() to use expand_vma() and the new shrink_vma()
function.  Remove support from __vma_adjust() to reduce a vma size since
shift_arg_pages() is the only user that shrinks a VMA in this way.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c          |  4 ++--
 include/linux/mm.h | 10 ++-------
 mm/mmap.c          | 52 ++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d52fca2dd30b..c0df813d2b45 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -699,7 +699,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff))
+	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
 		return -ENOMEM;
 
 	/*
@@ -733,7 +733,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 
 	vma_prev(&vmi);
 	/* Shrink the vma to just the new range */
-	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff);
+	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
 }
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 287e340ced01..cd6947b1dc99 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2831,17 +2831,11 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
-extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *expand);
-static inline int vma_adjust(struct vma_iterator *vmi,
-	struct vm_area_struct *vma, unsigned long start, unsigned long end,
-	pgoff_t pgoff)
-{
-	return __vma_adjust(vmi, vma, start, end, pgoff, NULL);
-}
 extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		      unsigned long start, unsigned long end, pgoff_t pgoff,
 		      struct vm_area_struct *next);
+extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end, pgoff_t pgoff);
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
 	unsigned long end, unsigned long vm_flags, struct anon_vma *,
diff --git a/mm/mmap.c b/mm/mmap.c
index 4bb8d219b53f..da58f428c5c0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -685,6 +685,44 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 nomem:
 	return -ENOMEM;
 }
+
+/*
+ * vma_shrink() - Reduce an existing VMAs memory area
+ * @vmi: The vma iterator
+ * @vma: The VMA to modify
+ * @start: The new start
+ * @end: The new end
+ *
+ * Returns: 0 on success, -ENOMEM otherwise
+ */
+int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff)
+{
+	struct vma_prepare vp;
+
+	WARN_ON((vma->vm_start != start) && (vma->vm_end != end));
+
+	if (vma_iter_prealloc(vmi))
+		return -ENOMEM;
+
+	init_vma_prep(&vp, vma);
+	vma_adjust_trans_huge(vma, start, end, 0);
+	vma_prepare(&vp);
+
+	if (vma->vm_start < start)
+		vma_iter_clear(vmi, vma->vm_start, start);
+
+	if (vma->vm_end > end)
+		vma_iter_clear(vmi, end, vma->vm_end);
+
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
+	return 0;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -800,14 +838,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	vma_prepare(&vma_prep);
 
-	if (vma->vm_start < start)
-		vma_iter_clear(vmi, vma->vm_start, start);
-	else if (start != vma->vm_start)
-		vma_changed = true;
-
-	if (vma->vm_end > end)
-		vma_iter_clear(vmi, end, vma->vm_end);
-	else if (end != vma->vm_end)
+	if (start < vma->vm_start || end > vma->vm_end)
 		vma_changed = true;
 
 	vma->vm_start = start;
@@ -820,7 +851,10 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (adjust_next) {
 		next->vm_start += adjust_next;
 		next->vm_pgoff += adjust_next >> PAGE_SHIFT;
-		vma_iter_store(vmi, next);
+		if (adjust_next < 0) {
+			WARN_ON_ONCE(vma_changed);
+			vma_iter_store(vmi, next);
+		}
 	}
 
 	vma_complete(&vma_prep, vmi, mm);
-- 
2.35.1

