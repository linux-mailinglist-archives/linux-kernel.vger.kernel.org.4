Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610646F87DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjEERpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjEERos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:44:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769401D969
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhJxF028056;
        Fri, 5 May 2023 17:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OrIdgrVzXbrkBEQdhLJQ1jIQQYwRAY8yiv0L2JjFINs=;
 b=y43tW54L0ZFqjtQxUJOeFbHyShrGs2Hj4bX1PgjK3r18/1bJSqG9RxPqktr6CN/JDaqL
 JbRFO3r3kBUOesCD6Zkz2LnLFco8odYmFFL1KzeNQNpUgp2K/Vgx7j7aCh6xZSbcw7nh
 +MmoEnFFf8TgFBx0KCfs728BEwWHGA5cRfJ57IbeAQZYwEIJUvgyeyo/2CMqVCvv3JDI
 cw/7hxa+TwAFrVOMBqPrURgor5WsTXSwraeAqfXFklm6rFXOQiTVDaBnNr2rHqvQ0JYt
 c9TQGOLrrMILvUIr/z22WOT+wXreNiFgMmYCTrwt2tlJ1aGrSPBcMXCU3MvBvSdF8Ol6 Cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t145jc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345Gc4Gg020785;
        Fri, 5 May 2023 17:43:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa5exr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkNsTRsn0VrJ8vD2djYdWBQoODjNA74eVemBcPXOYCEzuMQFdLUmi/Q7SZ35pvlGhJX6ak+SdCPQAcQNCUq3NDe7oKOm5JxbqNDXsUGuqLGgaBXGaWEpIbVU8bCaUvdrRyt3PVYj20dry4EhpalaPSxjNZ+ZuGtMRvJjXGDZk3IatqA10ezu/MtnnU2ZnF8qq4K3/mwdV3l1CNBTGmTVJLJX7jwAX0eOR92enD2cdjm9ydTfJSUN7fXBlyr5DB6BbatkbMuZW3JfJFUXVJAsBplSLmJpdAt2r2wiMoLcnsXc+EHtks9kTSxt1zkFZBF3dP9zpIM5LjY8pJ6/iMlxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrIdgrVzXbrkBEQdhLJQ1jIQQYwRAY8yiv0L2JjFINs=;
 b=hxCaI3azltygi4qQ4PvUPj5sujb5oNqABXIKJu8J0TnWzS32Qr0k/UCulkySWv+EDuVRcC7RKhugpANozZ9lkaB1vyAmgJ8r2tY7lXSq9nyD7BdpPr/LNWWFfUGF/iX31XyO56HpJiPQF7HC5IL2iT/lldN+4WFPcspfJOPGi6E9n2f8EglWjfVP3dVt6xjJrRYyXXlpTzFfvWKxNOjdLKR5teC/+AZQAgBrHEF3gXS+/opBdLoKtTVwyhxOKZXIRKAJOFpOf985qBKMwDPdfKSiOuUIVpPp5WB09vCoaoVX+/CoifdBaC6bgoxneKB3XKpIMn+cleWVFwLKTRyMAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrIdgrVzXbrkBEQdhLJQ1jIQQYwRAY8yiv0L2JjFINs=;
 b=j6d+1ESRn0w5FG+aGapFL4NW8QhPmg563ASwqS0fcLbvghYQUyzlYZAYpg0hNqM1zPmpSUIlsrb/E61iHGIcM2h57r4oFUOM4y+dsV1XGC/0WNfAvv2PkOdiein9o0vqQ02xFQfB8nrry90p4huNWtSmZiKZQoBPKwAN+ol1CfM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:43:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:43:48 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 03/36] maple_tree: Avoid unnecessary ascending
Date:   Fri,  5 May 2023 13:41:31 -0400
Message-Id: <20230505174204.2665599-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: a48b9924-86f7-4e8b-26c1-08db4d9047ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXbA8+KnrhWjO4zLk0vKPMhy+/iB1irJbm8QVek94K897VdRD6BWLpB5GF4DN1w/TlwZCeqdlkTUUA2xp6UEKHfYkk5vpjkyrmI1Uz6INculkQyP8Fzcah0RUGWyI8j8U0iQztDRUtNGsbOXZI/shklkMhPp8wx4KILvSu+IoH1/nIz3N2enK9xGFLITSk7G5zecVaKLeJitiS8JDVGv71H2cqkFmmlxFvn45L7Mhu1ONtN+8ddZTDzwoU9aeu7LnGyxV6LtaG6AAZoLBitczYcN/8eTphUOAkakYOtOT280L4J+5ZPenmYJS16+3p9hIy2t1NyP7TXuHWJZCwWYT6qPfoLSp0rKjTGqf5P06+AoRXTBNefShiMFi3tMRrdJIfucF1M6UMvurTnVXN0mWbZUceXtBKi+IP2XEvoC8JgwuteSUvOMskeNNH4esgdLDYL5pGkoiCqDouYyko2RlovzTsgUL/Wtb6v0OJc2JFWXp5N4oIOpXXVWj9OilGw0O587Oro8rZKTUT0k/DLyxvIvDQ/7ChEnAlA5OBG3PEs7Xg7tPjwjKv4kYyHUNHCi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(54906003)(36756003)(86362001)(83380400001)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9NaWmodjH5uXy9D5DX3qYr7BKEOE48IHHEmnl2ME3U6gvXEcZFxjU2Ni1yTW?=
 =?us-ascii?Q?LYD+iYfDn04v/ZlmjREJPrV/WNdUGjDdYjWru/3dR+kUjv1LHaWCfr0JQfqt?=
 =?us-ascii?Q?ap9r9cbbfEzg36sRgfZlyF2npXWajJYnYzC/H/EGxPYviavnPHDySXvkGzZN?=
 =?us-ascii?Q?2xRHE7+erOoYlD9jEYxjjTKCGtGs1acsvbCEP0IZbbCbSRzjefuY04GlPbtc?=
 =?us-ascii?Q?uUiyGVjnp4LWJBAWGRTLbhCJS/9yXoUISDPXvGQSyL9aBOIZjNe1hT06EHhh?=
 =?us-ascii?Q?bu/RYLdwBLUUPmzELklLFsOZXqURjoHr6hZdfWxgz39AZ+oHASW76hNj+ou0?=
 =?us-ascii?Q?PWfITJ/TI7Ris1b3qw2Cjl3Z/ON53QhLgGqWosloRKiSNsJUiDfRKZz5JhSI?=
 =?us-ascii?Q?B9Do75PlOYIQa067ogMuGhEhBSRGPZZWLDMWE4WGOr03LcqySXwzsI0/8NV3?=
 =?us-ascii?Q?JcaVvW9ZJpZgUHkBQPEoGrM7ZeSkDb5KnDbhvi+1H5GJNPikoxpunpIPaDfA?=
 =?us-ascii?Q?nzDIH8UbU12qpNnGymQJwGxFlT2i6CX173drD0hiyvlyHdhCLelkmOaYH8RL?=
 =?us-ascii?Q?Rpa9obB4vQowClQa2QXOiGwhaUUiNf0DPZuzTHPz1Q2MLrcJyuuFmAbQr5zH?=
 =?us-ascii?Q?7Z0MHEBlS+11WBtLnP5DPFdDlDxx9AxYRS2rjbtqqGKLHF4p+JIVd+HHKNtl?=
 =?us-ascii?Q?Wd2qbFv16oQ25PxSzNyyHHmIO/Cyk+hsB/Afeq9xrfT71VQszj0L8KydVGUQ?=
 =?us-ascii?Q?5jFCKfB0wAPbJwNCzEjs3PxSm6OPV9BEpV4QEnl8XbLwYo76fCUSEFfXVr2j?=
 =?us-ascii?Q?USuynBfXgudWIM5aNk7VCYFHAnKq9EKdIFY/JxISfC3qPpBJMCrhOvRwVSob?=
 =?us-ascii?Q?jxxoCN538FUnhYM0Xlz5SHQBQfJXUi/bAzp4ptHRpbItD6TmBCaM55IQZJqm?=
 =?us-ascii?Q?QhaT+qd25LkPWYm4YIQy2csiOgqU40rgfqDw4ttKa8eDfgBL9auFosnvOMiu?=
 =?us-ascii?Q?Pbm/F5tb2j53ANeNwVvfEQs/N6D0cq3bD7ybCL5Gu3nHsb4CxuNZ0/7G6tWM?=
 =?us-ascii?Q?w7QX06/jnMGeyCvGLRV++r2UoXQ2Q7P07G8iLD90h78YcKgcjifykvqZxKfi?=
 =?us-ascii?Q?TxrKBQz7wV/g2rp4ev5FAFd5k9Uz+h37b2S1l8f6+vN73igrd5QrEIBX+OXH?=
 =?us-ascii?Q?xtAE9wZi2OUpH1bJV+L8FsSSAhi+wrFrRYOk6t3UQ5OjrubZi9d+VJasWUJ9?=
 =?us-ascii?Q?2QYYbKV2BcyyP1/6UzGW8m0ZEn74qM1m+2SvuNGl2bQYxsnPTgn4q304xMF1?=
 =?us-ascii?Q?5QotT3ZF3Sze6BBql2JeeUeSMTvM/wKK3odKR80r+KXPrG8YNasYyCCOChCW?=
 =?us-ascii?Q?qNEW3VM8e3+bWu2HaiZKgBLeeTdGudxDqRogrcddhe5TuXXNsUYUwNuI+Xo6?=
 =?us-ascii?Q?8vHA04c8UXImSS1USQyOABQjxWg7OqVSWJGlzFtKX5DxLrs/6jFjt9EEXG6f?=
 =?us-ascii?Q?DKDGccny8G3u3lDGxIl/1u1fw+5j9tBB7WrP1PfOfZORSVL3FYrAVbPEUbDx?=
 =?us-ascii?Q?Zo0d58h4wZNV3hNwTdLo6V5YWCmN1/wUlcdtNh46OyVGx354ufWHGWWj1qdL?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ywQK4fOtA7I5hYHVQdc2rQdnfcsFatnmRb3NooBRWA/Cplq4DPj4hc6FKep+?=
 =?us-ascii?Q?hUNDvcMgwx82lTecEJWRWZJG1UaJ6a2oUzw20JOWajhAS3fn8zN+/QDLTCQs?=
 =?us-ascii?Q?Pf0CjBO6rdvaiB/fDzuSGQdr/CYvfym77L/uRE0B5k3w7w1LO5ypSKOew5Aa?=
 =?us-ascii?Q?DoP585hmzsAvE3tAIaZxLJ3wz3jPLQEiYs8N8Vhrmg/1fU55noQ3NzIz96c8?=
 =?us-ascii?Q?klpHCJkAvTydhYLhyWlSQjnoT9a8THp5/8doRkUif3hc9wtVzG+LKd2TcZEm?=
 =?us-ascii?Q?7rBpwvW0eXwVy/YcE82UKHr/OqApCR7Ulh+pmlJ3AS7vQiwkvpzw3qU++QDk?=
 =?us-ascii?Q?h+4V6HNCwbui6u0MY5SpMPzxoVLCcmuGPb2KTuDhLl2+yR+j/yQqLpp7s9fv?=
 =?us-ascii?Q?xpKLGdxzAk40mth1XqPWMU37zQ/giX3WGDCeeb5QaxTFSHVCCQPtS3AYctwd?=
 =?us-ascii?Q?u/+rtqfWKFNrwL6PYw95MRV0p9hd1EpBbBpacMhsMjqK4t6IFhoT3Zua4Op/?=
 =?us-ascii?Q?f1vzFB3SNCynO/m0HMNWJfwUeDc/FeEbk8MXUqSHT297piKs1XgFXGPUKucs?=
 =?us-ascii?Q?29tjEjR3/w/pKtc4UA/0mQ/g7z8XXMJ1LI0XDMqNw1afDAlzRclL3gVtLKsr?=
 =?us-ascii?Q?Ahos/3Peuj9vbv64X/U3ovTSdIABvbrgwpy+mPPk2ykzP97qcyeo8QZMnGJZ?=
 =?us-ascii?Q?8+UdXicY02TfsI6Aed7qXJdjys0BvwazusHzra4P6iGDrN5stHLxQSVZzwqf?=
 =?us-ascii?Q?pdhnDvJB3CVH5ZEnyrkuT1sorA7i9CxxhNtrDzQrIayskX6vDeZ6qqnWYQaP?=
 =?us-ascii?Q?Me8QFG0if4VpcZ3zndHhRbq3QxuxXYSYv1/mGZhoSZgwpFY2ZNtg9SpaBx7r?=
 =?us-ascii?Q?m/sjXXlZihB8BelQeSwF/KLsDId7Nxrz/f8AYJwTURcG0fFtg8B8OblLX/yW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48b9924-86f7-4e8b-26c1-08db4d9047ea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:43:48.1355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ru2Q0H7+/poI4+jlfCi7XpFv1yVxGMoZPYz+J+dfAh57ubmjfZOuBsL1o36FQ6LRvGVZegJIakeMV3VTu563vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: J0hXzc_hJzr1QCEJs9xYqcCFlyOvRn-j
X-Proofpoint-ORIG-GUID: J0hXzc_hJzr1QCEJs9xYqcCFlyOvRn-j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree node limits are implied by the parent.  When walking up
the tree, the limit may not be known until a slot that does not have
implied limits are encountered.  However, if the node is the left-most
or right-most node, the walking up to find that limit can be skipped.

This commit also fixes the debug/testing code that was not setting the
limit on walking down the tree as that optimization is not compatible
with this change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c                 | 11 ++++++++---
 tools/testing/radix-tree/maple.c |  4 ++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 555de3a8343e1..5b29d5a916f2c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1103,7 +1103,6 @@ static int mas_ascend(struct ma_state *mas)
 	enum maple_type a_type;
 	unsigned long min, max;
 	unsigned long *pivots;
-	unsigned char offset;
 	bool set_max = false, set_min = false;
 
 	a_node = mas_mn(mas);
@@ -1115,8 +1114,9 @@ static int mas_ascend(struct ma_state *mas)
 	p_node = mte_parent(mas->node);
 	if (unlikely(a_node == p_node))
 		return 1;
+
 	a_type = mas_parent_type(mas, mas->node);
-	offset = mte_parent_slot(mas->node);
+	mas->offset = mte_parent_slot(mas->node);
 	a_enode = mt_mk_node(p_node, a_type);
 
 	/* Check to make sure all parent information is still accurate */
@@ -1124,7 +1124,6 @@ static int mas_ascend(struct ma_state *mas)
 		return 1;
 
 	mas->node = a_enode;
-	mas->offset = offset;
 
 	if (mte_is_root(a_enode)) {
 		mas->max = ULONG_MAX;
@@ -1132,6 +1131,12 @@ static int mas_ascend(struct ma_state *mas)
 		return 0;
 	}
 
+	if (!mas->min)
+		set_min = true;
+
+	if (mas->max == ULONG_MAX)
+		set_max = true;
+
 	min = 0;
 	max = ULONG_MAX;
 	do {
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 9286d3baa12d6..75df543e019c9 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35259,6 +35259,7 @@ static void mas_dfs_preorder(struct ma_state *mas)
 
 	struct maple_enode *prev;
 	unsigned char end, slot = 0;
+	unsigned long *pivots;
 
 	if (mas->node == MAS_START) {
 		mas_start(mas);
@@ -35291,6 +35292,9 @@ static void mas_dfs_preorder(struct ma_state *mas)
 		mas_ascend(mas);
 		goto walk_up;
 	}
+	pivots = ma_pivots(mte_to_node(prev), mte_node_type(prev));
+	mas->max = mas_safe_pivot(mas, pivots, slot, mte_node_type(prev));
+	mas->min = mas_safe_min(mas, pivots, slot);
 
 	return;
 done:
-- 
2.39.2

