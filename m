Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51EC69F59C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjBVNdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjBVNdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:33:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C05818A83;
        Wed, 22 Feb 2023 05:33:01 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xZnp014963;
        Wed, 22 Feb 2023 12:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=NTVuEbOZde+p/jgqvcg8eYJr95Mho3xzZ2JnVLOF9ic=;
 b=XrOhMx3ey0pqzD7mVhK2yrNGu1u78iECLdsYvNFzufX/w02j9weGtYrO7QZEcM4RRr4q
 5j5J2u8YZVHS5FW18QgTqmEq47blwJxp3yWHs+meZzSfeWjAzxDJXkRVjeJJnKO4Hk8y
 TgIhUvA+dsqGFnL4sAQwyhKl8R5gtwLS5cNcM+VbanTYmW79Q+Ewxt4i5FGKszrwuzRX
 jecMWHkHVeQksc7cT6rj1vhQmkFkz7CxJaNkQnmGXcpCytJIewZDeiEn9C57H5nfomIl
 a2wO2MMnrQ4QND0rhpEEi4c/KCtjfLMd8ZrUztZz8nO9ITVyXaILKaqPD94owkaUAkSX og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbqntg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MBuiRk023484;
        Wed, 22 Feb 2023 12:16:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46j55f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m92oiAKE+asw6ZpZp3kGxouY1gAklNfAhJ7QwN7GCRoTWi4XWfzzXtOcQbOrFKp7A9Vs1tigj6E85h1RIbFxquoZLU5lxEOgh7Ah9zyzAQWyo3SKvEoFAlzyzqpDMW/qMpRn7ogWBOTivwA6lf4bC+Yv6JULMB6tCPhivw+4fL8oheKzZ/AiQd3Iigkv5bA3ipiub0yehrmDJBQF2aZb5axVwW8XmwCxP3c8U74Aek7olhp0ltZvjgFxKYDyhdIhQ8Ca/wjQ+VjTjmLEX0mi+xZE/67Q5l5mMCgEz1TAMZpLctJixbErhqwTx1JQYl3F0sUAeNF9okTscZCdvWuVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTVuEbOZde+p/jgqvcg8eYJr95Mho3xzZ2JnVLOF9ic=;
 b=TbuXSCOhPyVCT2QmyNUn5TxZ7U3wHyrxz/yy78IXlY+p6X5FleyiSDcSdD0grgyGD+fyqJUusMZDoKrqzFhqw0rMSZdzhi5c8Zlr6JcuUkknocRbY+jnWvV/wmRSJwRb6P5RDVDfxeGl8gvq7bI+SC0sjBdtJ10Uzzvn5R0gl+hofMBbf5IrQttBcMvNAL1uJNhf9vJLsw5jX2pVjjtBtElF4Oys0wVayVfCABEQFDNorsgfdiO6R/0jS06mNSxSzibO9v7vk7wHL4ey1BfTwuFVcTg8H04EActf3KZ0QAOAUAVzLloTSdxxujj95R/xvgERrH9520BG2RiNiE+ZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTVuEbOZde+p/jgqvcg8eYJr95Mho3xzZ2JnVLOF9ic=;
 b=wzqoolyJuPn2V3Y7dtdUhNGIL32FZ9q8Nl5mITeBXpYmXU9tbT5rQc1rWD6Avqh21Y3eoEgjp8cLRDZBjeSUKE3qdvrly5xlqhsjlMwRKsqLyGsEQzKFYwQPwlWnp4eSRSA69xJC7Q2Nbc/Ujdi+tx3cC+4YJbClIP3/PZ5/PCE=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:16:16 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:16:16 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 16/27] kbuild, crypto: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:42 +0000
Message-Id: <20230222121453.91915-17-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0318.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 786ef094-136a-4964-744b-08db14ce98af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ClxuefDHLoiFcPV4xGEV1niakI493lbvcUzq944q4aLTYQDECyCgd/2QEytKjtJJH1OJE4rNAl+JreKKTNslRiw4CN73yZffxwjSGRLOdZ8ZyKgfCKJaoQrneM2XljOfnK+XZdLQk/badEF1chG69NGX1n3VKGJtxJwyBbUppnQBCyRBFBPtdLMFjbn6NAl6wfGBrNSr4o4CkIz7MVmRk51+iIyKxbcYjrXjFuh32HBtluFfANFe+UQp67zHQqUST7qjHR+JlHTb5nUK5DIvfqQERBntbC40A5cJvL3zIQQHOaDtxFALnBRssNgoaRWdA8y3uQi8EywBGac4M1uAi5+W/okwnV/w2pX7i3zeDpaew0vAifbwtJbkX1rBnoiCQbAPnsp2wNImJ4KawZWcBhSfGTMhRc6lvgFs+aBXxaPoh5TBuy4KgLO4QC5fE1s0/IOiFs5tgcDbrJWT/EyqrcM3HvzU2CPHHHJKtDdeADf/OOrH4hrHfiBy0ezN1VKns9Lre5EanfliveuAho3TeByZ2BlN06c4MllTdYhltmrLvOu8Iam1Gtpv3uyLPawO2kmNrzR42eaLm/G5I5Waop7t4Fm//8Buv11BUw2rQ4XYjXhwaebJNeAXXffCydT4XyoC7TbcxDIDXkuKYIHPCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(36756003)(5660300002)(44832011)(83380400001)(2616005)(6512007)(478600001)(6486002)(6666004)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Qhv/igHSNoy/McfdyrHsc1qKtzUws3jMqbmHQe9B3F2TLvg0ODYWJ744eJz?=
 =?us-ascii?Q?DVt4z2CgkAt3QElx5fpC+g6ou9TRFZEfx5r425X3+3a40rsxMfujyOJAKIQK?=
 =?us-ascii?Q?URQqMBwx0VH9SDWLN/LNXcASPQc6Gf3pglxzfzFcpvJiIHFv6DcV1Gn+DfOD?=
 =?us-ascii?Q?eG9cHknx/J//fIB3i/FE9Zk5Uaq+gKXwgrVGXo2EW211lNIL8zf0V/HYUHUu?=
 =?us-ascii?Q?0ClTE0mjx9lQDlImVffPfgV3opsToF1ad4AOFFx5tHmoVzPacT42ccihhdVu?=
 =?us-ascii?Q?xV/1Vn0Yjn7cyL5LVFfZszGqE/HTdNCi0PyLl0IV07bkNAxUjGygm6cYvk2+?=
 =?us-ascii?Q?WDRv06iHGRm0m5IppMqedJfKYEnAzMQAWFj8bPYeFnsbLV0uQ6n6TsU5T+7J?=
 =?us-ascii?Q?BihZEL6atT4zCJu4ygDTjCj5y+ONuE71aSpO64ZFS71H0YPS7vD2IoVQLngj?=
 =?us-ascii?Q?OGodaE8TgbZ2TqTqHkbjzUUIzOwp0OvwNUc3yqjsDmL0RGvbqL/yc0B63sIq?=
 =?us-ascii?Q?JK1NWn782hJeAjmTIQZiEg4cZM8HoDK203KLg+sg6/yzI6D9KMhlbMTIdzvn?=
 =?us-ascii?Q?gN4ME+w135xlHHWc816UoknEoISAXECvER0+dM2+Ckq3u5MrotDQ+HJ2NKLI?=
 =?us-ascii?Q?5qaIydzsu0dYCnp6+t4MbeXYyAAlHvjk1ZBodBSbGCzONX4+HpZRs/g1yYwe?=
 =?us-ascii?Q?zufLjsji0b5SIKzHrWZ0kijsZ8i/jFOhtFhE8HgXCC0164Oqu/N3zLPdByxk?=
 =?us-ascii?Q?f8AWcT9fyJfC9Yams73xuRqShNlwuOe6Uy9pDgkf8m5sgVSUZaIKpJ3+RCjJ?=
 =?us-ascii?Q?15Xv6Te8QSstgQ146+EoFIMLvX+f2gKgRw6lb7091+kWcrJfayStHfhxwLoJ?=
 =?us-ascii?Q?gbgvd/91hOAo1jnthArCmGdRS/FXs7LbQxOVbz+xRezdmoLlJA6Iru5WK5Aa?=
 =?us-ascii?Q?l0Vd21lFirZpbM5dsQOarjKI02bjzUZdwEemYbVHgXWc+uSMK8SXpbQuqHvp?=
 =?us-ascii?Q?E5I835Vn5yMHxSm/Buuo+4pyoqlphqYrHl1uSsNbUtg9sko94m9jmlMBaqTS?=
 =?us-ascii?Q?owUYpW+nf2U2bzPDykJOG1VEqU7MjsLpKOGweZ8oiR7tYtedlhh4T7mW0ml9?=
 =?us-ascii?Q?D0FhBwa4Mc+O3RVn0ZDC1+Xk4fo5LZ/fYnQS++5eyB0lEzt6mQzO8hqG+nN2?=
 =?us-ascii?Q?SzjIQPlQrjtqz+xcI8k4co3qLJdsCrbq6lXE5HceQGK43K9l3TagYgTyKsOP?=
 =?us-ascii?Q?tN2T8PPqBsaIoHSCWgAntkm3xQ5fMOU8eyzLO2pFcjOuUhv/c0lnu3Q2QRjI?=
 =?us-ascii?Q?kb6Y+aH+AQwGJ3WkrcQ5e1lyeSTp4FB9kTr4cByzHfaK+ILk/Y8bnOBv1Bb9?=
 =?us-ascii?Q?dGHOcQ+LH4LDeKSMRJCx1qqhajPawD1D2ZCBlmvMIXYzdsQN43qSAN75cXOo?=
 =?us-ascii?Q?nN1KBomg+I04qS1yUTRFlI5zcxRCTgUBu3fC4YPG37UuA8a9ltweggATTbHv?=
 =?us-ascii?Q?vFun9WjJMUAej3ub7p4QxN8MTMHGEg/m53rBG0bJbXgFBd5bMclh+DctqV7B?=
 =?us-ascii?Q?Ekqe3H+mvG0GxkkDqulGWns9WgcvaqeJ7WR3Ahej0i3mWKyytdKak6uZcr/R?=
 =?us-ascii?Q?T23rgym+PHGbCK6XZUFPCoI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +2aC7NRZhkft5VToiWHsFXdgUUA/vY4mFifIaCbv/Qs/yNL8Mj2J4iSNEmAOOH+NUPFjEsOJT8FYmesSmDFVPJ0lHNIChWAv4qsg4oJlZeMXlEEi9FxGUeSAkU1s3j5nFvzsjQS9dx8MjvSAHTctF+5yoetu5oHgR2DDOBW3Qh2kgQtdq2vvY2UYRoE/UmxO3i1YyOJwec8X7slAzM2IViC+hPM4SoFJXltucCw212rOW+DeS3DS2ZH9wgPbkHrelWzT01qUa//8tk1tefoShaQXDewouf8CIAMnLfr8X59bKnyLY9pQ64UpcQq194AIxkFMZRO92BtSSoa9xoBnGudwmzAoytcIscpoKgpL2xy9M90pVYVapPVf7slrg16bA3OdJ0SF1Zsc9gjddRCKJrpMkqsCuJljOKiPZ6hB1pAZ6cCxm7crt9wfadqETWCKUyFXx2KOLUW9g1wayEntgm/76ofBIBrav7/orccxuCg6o+CFmUw7ciszi88jVXBwu4er1qZAGb4zXDH84NyReF6GFnJEtWzO4smEXi21IwOssS+UZVp/FMR2REN/vBAQBHvH8y/yGVLckOro3UJ/VqL+767MgpD7+e9iDIyWtbNTbOFzg6I9e29egCUXQtAMoX6mxO9PumfLv1VP11Zb70U4phtCvkhC38V8EzBQi7H9+NbqK2RdsvF7XAyc1Uel1alZH6tzEdOsWqKtxRHtAgk6SMdf9ifR/2w0lNjtZ+VtPy2eDTj4xI/N2k4EFM8Kf7K43AKAk0zncRGKbpmfaUS0y0YREJAs4ewmi/Nlx7L830lhBPpR0OGWffmTb9BOnLymj3gq9/m2KGW7b+QpCIw4jGvgsUodhJvAHN+LF197q/SMgvtqfRw6ASr+kqTc7L6O2S6NXyfeM895uwnJExcx+f3zeeLQYgg4NXPzihs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786ef094-136a-4964-744b-08db14ce98af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:16:16.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwjCFNSFUZSSKgM4pN32Zizx2G7KfEHohYN0lkMvKxSyYObcF5hQrDfMZMj5MYzyPlNpCG1ogWAfu+4qORP/JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-GUID: 7SoA89snVqvccuRruo5nybOtdW4UxxZ4
X-Proofpoint-ORIG-GUID: 7SoA89snVqvccuRruo5nybOtdW4UxxZ4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 lib/crypto/blake2s-generic.c | 1 -
 lib/crypto/blake2s.c         | 1 -
 2 files changed, 2 deletions(-)

diff --git a/lib/crypto/blake2s-generic.c b/lib/crypto/blake2s-generic.c
index 75ccb3e633e6..4ffe3d927920 100644
--- a/lib/crypto/blake2s-generic.c
+++ b/lib/crypto/blake2s-generic.c
@@ -110,6 +110,5 @@ void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
 
 EXPORT_SYMBOL(blake2s_compress_generic);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("BLAKE2s hash function");
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
index 98e688c6d891..71a316552cc5 100644
--- a/lib/crypto/blake2s.c
+++ b/lib/crypto/blake2s.c
@@ -67,6 +67,5 @@ static int __init blake2s_mod_init(void)
 }
 
 module_init(blake2s_mod_init);
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("BLAKE2s hash function");
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
-- 
2.39.1.268.g9de2f9a303

