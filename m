Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5678F6759E8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjATQ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjATQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:28:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0837F4E511
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:28:03 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBaTK003300;
        Fri, 20 Jan 2023 16:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=n9DvzzfSR+clZR1ROFy22L1D8uVN6xWoemiZenh5y/8=;
 b=ag+fwhmE/Q5+uyTnlL1ebxa9taWPUoOXw07KMXJVoUZ173D/lRamLM2vprMIC+O844in
 a6RPhtGKjj6/c9p+p3hHTHeAJJHAwffZEDjqmwjV/t/ucYeO7Q2mXTMSj1bcFH7MMvhD
 fU962EFK9ZGvtXVQOA6go8S5sMjxav9VjGjd+durQbbJHpnbIJHyxzBsq1KOaFa4txl3
 XVYdRA4+LUGxmpyaoC3ildtB1UUqfTv2LTUr9Prv4lYX9sZrGdc5NBNwyZmCVkxUOiiI
 eFMVtzBg3NNFpPqAm8ERYkqxUh4BdBQD9xBs4B6FSbCmPrHT/HRqLPqZeKaf2TYOWrzD ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medn7ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFRFt5004673;
        Fri, 20 Jan 2023 16:27:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1f5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjIWTqYe5FX6HhN73NuJptWTFn10fdGacomMRIuqWaIAzTu4yFTcBt5IOhrsjmDMLErl2ZWxNsKFhSwsPWHg+36UC66uaOlmZj0ZxM9ADVoaKR0vdAl77OR6kP8dYm0tc8bpR5j17t6ufieVSFKxBTY9w+8r8ioC24jOo3cWSh7FqeDsM+NZltFTc/+ag7gNmfvGX2ejJAgxUYfwgvUm56jAaKiKm6mrTDV8xZLApH4Ck+4tzg4OoQUkqgHBRGQwAGIk0g5wWt1U5mbuGsFJ/r+yOZ8M/6VTbCh2cqzhpcxFAFC0wmHtoAhqsRrTHEXh65r8nrCkz6NicbhFjx8t2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9DvzzfSR+clZR1ROFy22L1D8uVN6xWoemiZenh5y/8=;
 b=F1hA9gUt7rUXhsLMBTI9S4CkuKfDbD4XijsT8T+BCpTWKsYk45cqB/+ZDUgtyZlGqQmdQ6fX7tpM4LOiTNrgPpfc+Ztsm2gpjhmM0TYmgLDIayAyiDv3nNAMyEPcf28P4vTYHMrmjUDWPptqajT6B4aIWz38gQguFHzL1M52sFC7W4dVXGaF6AVM/YswF7UJtc72mWdqWyQv70aMfNIgJBg70nHOL0U3+fekiVHwIPPQjP2l+9vOcJ1B9N////np0O/hZRlsl1WUYHyAB2J5paGswHjmmXREUZv6rD27/pSkC9SZ7fEOTeZedrsmDtB2Y0eFWJt3lNcUEnMd1iX8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9DvzzfSR+clZR1ROFy22L1D8uVN6xWoemiZenh5y/8=;
 b=YfuNSgSF8nZ2FeexrVF/ahSWn4gsCyhIu+aiprQZeNOll/3j9sxqJFsb4NDq4g5qnBkmp7zyai/nWJ8X14jAHXXmtl/XsVVGuN9d/+gj22bpds3po0NG8NGw+ytUSXtdSJxSYoKIJujxQGbOO8hTYRSP7nuz9tf2frJvIc2qNEY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:38 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 11/49] mm/mmap: Remove preallocation from do_mas_align_munmap()
Date:   Fri, 20 Jan 2023 11:26:12 -0500
Message-Id: <20230120162650.984577-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0091.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c40f27c-e882-43b5-dbc7-08dafb033e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bDhXkP9XtavSXDb12rK4t0E7KbWJercLzxQQlFPsuzrVDpkMTd/NdExWcce6/zUrQEER6UgjjD/uB68SoVqWj1SSdqrPOU0pC8vyt5TaTEkx7N1rQFjWAmGSh3Os+Ylk644n8MohkeI6Q4wJ7lwpGs1Qwlt2jBaWGJA4PI5rTBQF0GL/M+y2DJhisBvAaWvCWhMr8YZQIC3opPyUjIZP+zfRwcKJ0c/285VslU+kU4y2UFzezwgWXDvEHGe28tzyAG4norar5VgC5v5/+oTFJc2APMs/45WYHl1+jojaOoLoROSSuqcH2QT5nxtsj+ByIf2dRa7TwucX/uxbBjQjspvEhJ+Wla79wF/GVdkvTti5dLky1Wm48gNXz1vZ8rxwHK7asZGxEUJ/fRpCEQX7tuShe0WFHaHbXwYI6ccbeMHiN7StEhb6wbfH/HQTnFGtxR+JUtM1MNz6W6wjLf5h1krcfFW9rwKHOxo5TQ+d5lGmlw8YvB3WLtoKjVxHngbfZDrUx1n6J7vHzureVTasE1puWuTZ6gSu+WWI0F6qyleiobtMBm5x9Ty1nfd0qadAdRmm7zTyhD2NeDIjkwKG5rP8SCkSAO1zBu2F4zOjsQajen7lNKJ3PlE7bJJJ89ZlvEuAhZjaqoC3N0SSR5KLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IShh/5K9kQbl6bguGLtkPri0moAoR5xH++woNoOvVf5mqZo/7v8yscpj7LcQ?=
 =?us-ascii?Q?4OooeLptg+SNfnDooOEgLJdPUxuZDW0DHFEUSduivAyR5tBHO4X7wO/IgFIY?=
 =?us-ascii?Q?+Y5mk94QI0lReWtBI6b7+qgQX0pS7EwiOq00bg0sj5gARK1LJUF8z+O9LiS2?=
 =?us-ascii?Q?wzqfxF1K8Jx+g0q6lI8wlhfXH2Cluece6D2x9DX57KmBrbtulYVxx0hZlup7?=
 =?us-ascii?Q?BjuSqFKuXkJ59+T1Z5qTrtY07v91Qt6W3pTWZV/Sgw5eVhc586/iyMd3gKgL?=
 =?us-ascii?Q?+PNLJ3KbqAuisasONT9h7w1TPHoTAjoj2bbnswBb3ZXF9JJP5/ub4b5bR9nO?=
 =?us-ascii?Q?KHBEzfTYHUaWQNcUmrzUWtwnr3eYqeRc3divolcYZTt0ojv+0cnzx2Cz2TNT?=
 =?us-ascii?Q?o0NZvEMVGO0jo6oEV7gTswTGl1kWP995lrEyhHvyDM50l080iqqnnLi8AhIh?=
 =?us-ascii?Q?H1BWsQKEtGhUvLkRXOgbFkRT5TwjV4R0KFgvSJr8W2tmQQfuLAJ3f8DTZtWg?=
 =?us-ascii?Q?L6+08tgFV8YdU6QldX4WvunEenMhAVTiBJSP4hrPVqf6x/oNVt3X8IM18eiH?=
 =?us-ascii?Q?IfQ6OABi4V9h3GwO/BgmWPt8xtZuMhwpMUBGCuiI0c4QOnOEzjMRjicot0g2?=
 =?us-ascii?Q?076kMZAPkCRJZFFhdGx6VIGmoQicQSY5bRVudQrLmgST+uINqnOAg9FMtW0E?=
 =?us-ascii?Q?udCWcSRUVkuq86SSzfiBhlxpbcg+Qiihvl+Ue3i2C2xW5w3So9vyqJDNFRNW?=
 =?us-ascii?Q?YZd6Puu42w8MlfYQIKDcBdxRy7JCkzA+vH7Dufcq8kaiSIaqlcM93fqSSAtA?=
 =?us-ascii?Q?tBGWOcFT7txogJE3IqVSChoRCGIxDK9IZCIBG+RojYRVffwTRCT1riNvCT5l?=
 =?us-ascii?Q?0iAzY/2kiAbGenODipP+wWUiW0W15crORemVn7a8GxsE6Bz6nMeXU8AO1naA?=
 =?us-ascii?Q?w8Rhcl0kfG1MCuZtng6Tw9SPL147UArs3xkwZNjMIP3Oxn/UDd1pgEXOOCRO?=
 =?us-ascii?Q?UGGZB8WoOwz6Qnxpoud1PdxB8Ib0I4bgSN/AF7T/tc43WBoOWIXlKp14sHAy?=
 =?us-ascii?Q?8/s1NK54C1D5MI1oXaKksGwDdq+7q6OlFoBHhvpwJmrjMJoQ3i0xRXjk03/I?=
 =?us-ascii?Q?rnlkpIA8flsxaYVFxy2N2+Pl5c+ScXvcWQH59mAu5gnG1KpsVM6uB6ZcBbFo?=
 =?us-ascii?Q?LPfSiVoKIn6HsAob8rqdyRYrBUB8kv8rcaCAy9v+7ySfJR8mtE96090H5BnO?=
 =?us-ascii?Q?TMsP4uUcJ9WX42aAUh1AAxdWq4Up3LOFBMN3ZEQaR+d6DiuuU2yYBjtLO5Be?=
 =?us-ascii?Q?SqBcXFXFAiV2GLgQ/w6ACNGKWw1b1yzob1PAlHj3TRt6XYW/oE5YGhpCdyEQ?=
 =?us-ascii?Q?2KfouHvqc7E79xuIisyeGgLDW44UQB+Z331rFl4xCQHjh9eDgy9tgrHreAhH?=
 =?us-ascii?Q?TBIjqrDmfoR7Oepc2wmSYM1K6Abq1jv0CjHKx6GHncoUO+oGFR8I+aG3SCCA?=
 =?us-ascii?Q?4LXW0A+kagxEgbhWE1JqtCQ7xmi1ZUGnbFByNl8m3JHayE3lPU3SiaTmH9ND?=
 =?us-ascii?Q?e6/Ed5tHXmfAr/9D0cButSZ0Qq/7LQvDvpyQPHE4xonssvys8HAiLiV6A7vz?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qf6yofR9oG6qAsNyrrEWTfFH2XU3jdMhDmWz7g0gRRRVWiwnvthMSxue1dDqjSe7r+utBVNA13xohu61cBRARJgKmuqdM+HMdvoyr5qbP52hdvjw+S4R/FoUo0D46HJ40hkLYVvp0Tls6iJueop7yp9yhLa2E3o1b/VXxcqhp0nHD2GnbQ2+BmdOifn6jOlxERALwGjtvuDAGsU/g8DFDF2OZ02QL0P9MItTJp4zSyV8ghhG7hUCysxrxmxTy30FzEcDp59K/v71Fb7EYwJaRCEFJs3ET/jkUtXbs/Yp88Ns0lYRa3Dxh/wgm+B6nsremhfJMIUZIg2f/xfsvD4t1wQYvKx2mjm/RiRnJTnoLD7LyF5XEIRHCeCPbmy1GMOtBPFq3dDX9s1VaA4HZbJVNQ1vUyn6vhX7ZWEedadqapswIXZSS2g+TCYswwbQqlVx+7WKjcLmuj4RNPQL3a10nWv/QBCl57Kw8KRkz4GVUS7sKnuq0qmu6BeJdeLtQ6es6NA+V0rslwtogPDwZLVgXSkg40wO8Tngw5BZ5SC5PvOQT9I5Jx/SzW+zWY86marbwPohpKHMXZXK8MLQHDiGEHkYpmORUWg1OxH3IpXaVgRm5uAy5i6vMiGWEkJ1YdnDprVIkb1EXUPWJEpr/tVjMuIny2q7+/tHerdxF8J1xhT83wBCQZEHp0Yj+WAh4bOakbAFWNFjVTP9/9g+bW7sHND9jGSC3HQMjRTk5tcriKp+uBp5VwnQ//2a1Rjlurh5PW0ZBYIRLQe7Q0/kiU702DUkBFLrUqxXvch4zjNqhzkUGgF2lp5NaHg/RY2CPa5HWtPVfXzUbhjhZxUzUM4axvt74enhJ/BDHeZndOIEriN3U/SFs/4Bub9QB9JurzaTNw3rxauQJz5XHkTwY8Hd1A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c40f27c-e882-43b5-dbc7-08dafb033e4b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:37.6853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbD+40VVAKtVCxQAOsv/N6dHSI9j6Qlo7VhWk2R8TvizvJhOpx7yl/KlVF08wrhf3CLMF+m8YJjGilTuldbK8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: hW5qTn9xQYiDDlI9WelrxEfP5UvM2x3L
X-Proofpoint-GUID: hW5qTn9xQYiDDlI9WelrxEfP5UvM2x3L
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

In preparation of passing the vma state through split, the
pre-allocation that occurs before the split has to be moved to after.
Since the preallocation would then live right next to the store, just
call store instead of preallocating.  This effectively restores the
potential error path of splitting and not munmap'ing which pre-dates the
maple tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 09a5b6e00374..83d25fcc2f6d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2329,9 +2329,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
 
-	if (mas_preallocate(mas, GFP_KERNEL))
-		return -ENOMEM;
-
 	mas->last = end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2422,8 +2419,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 			goto userfaultfd_error;
 	}
 
-	/* Point of no return */
-	mas_set_range(mas, start, end - 1);
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
@@ -2431,6 +2426,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
+		mas_set_range(mas, start, end - 1);
 		rcu_read_lock();
 		vma_test = mas_find(&test, end - 1);
 		mas_for_each(mas, vma_mas, end - 1) {
@@ -2440,10 +2436,13 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 		}
 		rcu_read_unlock();
 		BUG_ON(count != test_count);
-		mas_set_range(mas, start, end - 1);
 	}
 #endif
-	mas_store_prealloc(mas, NULL);
+	/* Point of no return */
+	mas_set_range(mas, start, end - 1);
+	if (mas_store_gfp(mas, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
 	mm->map_count -= count;
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
@@ -2475,7 +2474,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	__mt_destroy(&mt_detach);
 start_split_failed:
 map_count_exceeded:
-	mas_destroy(mas);
 	return error;
 }
 
-- 
2.35.1

