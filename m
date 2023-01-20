Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F9A675D25
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjATSxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjATSxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:53:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358C0577DE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:53:46 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBYm4029935;
        Fri, 20 Jan 2023 16:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Ckv3Hs5WM16MW5wP9SWlQ8M7ylH1vcV4/Auox2N1Ci0=;
 b=Ucz52MSYvwFineFwHDy4KJXcPfmDfBj9qPS4kftQ6QF3dV8tzntHEeeXEGsGlwGfeSxr
 YftYahIhqqWyCWNzFKtBgeipei1muvi3a6miS++jpbin7dGkV25czmW/c/oJnBr1hknf
 o+7nj7ZEJgxA4LC34nhlQTeCC02Rr7I9BQdS1cPuMYQckmQcemFNBD+SXGaiYdRyN8W3
 Xg7l7Y6vgQ3msW8sLneO5R5B+4Lv77JiJNR6z9Ubk2x+wCh2PixaygBOHJYoGHGu53uS
 atdxe50+M+I48LnbTSxPmxJOJLAtY1D1E2gseV1fzOX1syXyLjkAGkANIqvCuatAF5Om 6A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6cd3f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFY00u013475;
        Fri, 20 Jan 2023 16:28:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmfayy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NalIPyZInnmIB/xQnUiC9VVhLTE/4FJ7oqdTaq1iGibRr1rYYzgPh9h/0eTECIlFuH+hCcGHy1c/k6ikOXDq6QsPbvRUqRXW05Djp4vRkYeCBQximA9rmzByZvh3R14fOce/mB6PoEJ7AxXVon4U6PciLJMsTnN4lMa+dOJnYQzeM82U2WcrUGQUh0wYUOEPNROCtqTckq5fpJnttvI9VEXk3ejsluvuRLpF6WlJST7NXFI4GLzltTNjzNbnW5ddItonOiX/2XXzJQ4IDd3Nx2IwdPkF7Znv22iIwU+i0uruiCCSRaDqjGCNRbcHv9lNsy+MsZV2i3c9M5KPblFxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ckv3Hs5WM16MW5wP9SWlQ8M7ylH1vcV4/Auox2N1Ci0=;
 b=PByR2V6OStb3y4iXRVqaD/1jCkOUkb8bC2oQXCMatAvvaKei5Fi935Pq555sbeFqVmYC7fO8iVVUBIbTCMGDaWSlh3AABX0V0TJ4ytZmibgeFdE1kEWgSOMJcKhSAgvWKdPX2KNNOeosYkx7GnF3bnmbgXeczd5uFAP9GiKF0WoHpCa9DIxY8qEZIj3OMjX8wZLVketH5lqDXuqvQ6TSZBkgAIAHw85Gl5hVGSg1iDwcBLokg6AQB23vVp5lXXqmu67XKJi5k3Javit4oBJ70qM6bm2eagM//i0wFO5H2shZQjy2rX4ot03AOoyzW/Jl/pl+P70r3hyPD7rJAj8BHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ckv3Hs5WM16MW5wP9SWlQ8M7ylH1vcV4/Auox2N1Ci0=;
 b=Dt96/U/3HJoIK+6uLLPn54yv2osG+E+jzSA/kVmfkhTmcq3sCDfV+Gxb1N0W5ptB4Rl/Yvol3EapChEyLvpmk6b5RrMim+QJ9rblWmcONXQH1XV9+sYUD9f96YLdFvgTR4MglK9zJBsa3hQfBXTMBlihH4WpStc2rTQWwezGQtQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:44 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 36/49] mm: Add vma iterator to vma_adjust() arguments
Date:   Fri, 20 Jan 2023 11:26:37 -0500
Message-Id: <20230120162650.984577-37-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0094.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: c5016deb-c407-422e-dff5-08dafb036648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmTh2I8u4wjJWE42rZxwW7wHs44LHQdCR9OoJzxjGGYz3oqra+KzHGsiKQ+eIPni1PDgTigs/2td5y0pLqsqbmjTJ387psbexrjJvfX8kSbD3Eq5Yny/W019mHWSTEw90BT1ZngLqdu1O7u8S8ugbc1HeBC4aHKuyLlM9NoG85GpOayKjXZSwIWS3VqmecS3eM1dJPPw6JCc8YeXFFZf8qNM9ZC5ceUe6xelcibg2sZ6VdoYCPlLoqPo4Qk2OaLFHdD78aa/4d0HC3ourv7bSEKx36rcylFfp+F2kTahJcXXgqyLNPvLl6w5hDZ0PrMvWbqOGfL8qvieLUfmDIQPPs+9QRu5jUHr18c6jF/6FSNaoE2ygSOVzCyU3urrDM8dMY9uWsiyPMYfdzA1dp6QRgFwyy2d53xzlJBE/mJ+05WSle/nOeftzQxGiZn6d8bBHNlZPw5NPjf6CzmXL+Juxg03HUMFR3jsEYVpjnX2O7s/+CfvsS4DniBtK4Hz1/bXJlSlNzgDBpiFc33R7Zcyk8mDzjbkIdbf7/fh/10TxGBTPp0s3JQcZbSEDVTuuSXhKBdvplH9t0unSMtU8/OhMAh8OcHsIh2a3nYFT+SiYI7WQZj+DtoL5su/S+khkrQt6yEIWQNdBVAvRvaI0Ul2Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(186003)(2906002)(8936002)(5660300002)(2616005)(41300700001)(86362001)(8676002)(83380400001)(66556008)(66476007)(66946007)(36756003)(4326008)(316002)(26005)(54906003)(6512007)(6506007)(1076003)(6486002)(38100700002)(6666004)(478600001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6V9wXpmvyK9SRsYTRTb27j7C4SBmZbElEfQkVStcCR2Nt7uN2n75BW0XpWK9?=
 =?us-ascii?Q?M1gHbUPV8efPv1RH1U4CxZcV2RXkPP+HilokxJrg8Y9PSz6cfOWqS7N8n38g?=
 =?us-ascii?Q?HI2+W8scQhQE2GhUHauqldqLwI6p7ZjDtB3A8uPClIN9c2CtltexSp1M8U90?=
 =?us-ascii?Q?W34jQrQFPaJYHUjIEdjAvi3+kp03sJ7+xrv2SATGhPHuL+rzC0RQc+44zBYB?=
 =?us-ascii?Q?tPWf1RK/+j/du9+IoJjrck2LD4YaMM89VU/sxRV6MMMWb5Ec2vQb7CUK9AQ0?=
 =?us-ascii?Q?YLKv1Az7N9XtQ6mTQpMPeXRrcCCAQ8hKtLhzgSKAjEwWTfulvntokd/TTPZi?=
 =?us-ascii?Q?gBPI/PWo5SuNVQX8KuyWBtynm6a+ixqF+AKz9U3APLbV2XOHYxX+WJMBJ698?=
 =?us-ascii?Q?C55KTupCayDjcEjfH3s+lkCzl4B1A5AeXzR5K9GWQvXUGO0OPg71YC/LByn+?=
 =?us-ascii?Q?KrHpydHmgFHJ97D8io83WzNyy20rkSauDZqDriVzQ7yXmlCpW8HLtFSK7ddn?=
 =?us-ascii?Q?uD+pvFZJJ08b+AWwyIREnfBi71ZGMMnpV8PuWbC1Fp/1EnzxC/Z9byQvXo59?=
 =?us-ascii?Q?ywEgFPDffzLhMF1kiIbtmF/FwjFZR8IeGlC50Ys49W+Jdj1A6OKiiV19BjCh?=
 =?us-ascii?Q?5dYy0uFAopbFjwXrwv1aw3YHGfHCNAd9o6zjG0m6DahM+ankeHBWXWLhz60P?=
 =?us-ascii?Q?iKVRz2id48Dia5xxIb6knq28on6iLt6HnXq19j9cR3Xfg9K6DTv8YWnYrf6p?=
 =?us-ascii?Q?B+SEVUF2xtnPPqP1GLWBDHrgfpliXxDcz/b0y3Yg8OEwfvrxyIwxgk4TiZRb?=
 =?us-ascii?Q?y4w/SzNat8kbeWEfDLy1vuFvednYT5spfBUtJTBx/zVWzV51EXiv20Jz4K+4?=
 =?us-ascii?Q?B63DN2ocWiNMTAlzgEFzE0ah3M1TqumV/On9YPYW6Iyu0MR0EmzliTrUVj0U?=
 =?us-ascii?Q?ATPZeDwx8HrQScEK1+octq/h+tHrfywXgPxINeXIlEGa6Feyhs9MMYqa4B3G?=
 =?us-ascii?Q?+nDohE8DZlLD7EwDnXBY75CmH4Py86HiQaKlQBftkgZ5+IklTFFuLhdgHJnu?=
 =?us-ascii?Q?IoJA1O/fxCNCtEUuDeNtqiQi6Q1VH8XakwCu68QLdIUPh9ww7AG5isWLoFOd?=
 =?us-ascii?Q?RLfH3NsgxsFTi32jKGOqyk9gs8bD27U1BFgRCVio4n1fB1QAPXTUlBiI8s2w?=
 =?us-ascii?Q?G+I4kAVAAezs8JYNaFZR6fPgzl571gtTATsjDmyr6gGMx2m1Qa1Ej3vqRW2V?=
 =?us-ascii?Q?GpwjMbZYGKc0KWkuiQ+RK43u6j6KAmbXHbaFBmL0Ld+xh6RjpjnbfX7sMCxL?=
 =?us-ascii?Q?AhWr8Bfx8GZEnwRbA3lk/Zy5rt6XhnXiitbGsRreKiMwVUNHvy8Bx5iuE5gd?=
 =?us-ascii?Q?eFlHZ/Iq2shIIWHNZRImam3pmZwO1N2JBQEwN5PYQ3TBPsX6TDA6XuTaJceD?=
 =?us-ascii?Q?UYNZJ2NySeFH3zDiiic8fWa0C0zuoS4AAYcS8ZG4HRIaYBNg1Jt2WlQX+qSw?=
 =?us-ascii?Q?rY5DTDO5l61LbGrgCqr2eytaymiWR7/SgqCP2wQyiUKv0dB34wXcbmowT5my?=
 =?us-ascii?Q?mViKRs+bLcYq4U5043bshWbPYLQIYzSZfPc9s1VSCtqCMNLgTxQRgfKfw5+0?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IMuS+JDj1uwjXdWGe7GPd7edfUptB/CXvmA1a2l3Y1JHjaUVihRXqDbdJUMSYlteX6TJe9yoB///7PTeWuiyIsX44OPo38TqbIhzZhyPZXOZnf7c/9zDAUkvL+S9qmP6hp+4SApOwzH3FZG7duPq75F4b2ujSX7FqkI5QVzcd2IHmzUFUCFhVmRWjcE5FQuwL9CySwNdZrtmhYN4GfVrG4KgyRuT0eGjCdXzNncsxowjTD6RjdtG8V6xlNqgSnVy2GgVoJLw7X2gif4UjWjXDwVxShHSGrGCigxgOnJYaoUqUZWrfP9p8QDTD1wvuHIMU1EjOzD7xPr4teIuGr/CVqfRo81cC2rWI3xj7jE7Es+00itL8wLZ5L9tnBPXEV8UwMfEMC+3/aVJ7uozg84/n+RwagB+58DG5vhB5VJO5PXUAhgziDwBIukGHwkVoIhQvbyDzX4LqRlYa71VngRpjElgismE7CAYMiOnwhsHEHU0E2acHhP/5qCRJA4HAgUffvVi3PoHJ7DKboCY+eAMZkqKBz4AAJjb0G+smJEQUPK+Wtj3MOm8cMU/JAsOx+MS3YmxQp0ChR5Huwo7NdTLohFhiJI+GvrN8OjakHQHdGh6YySAfRhXIh0MG3KokNw7PhF/LF7E2JTvjbXzOquVi+r4IDRcZC8VpReF1x7/aSr7jBYc/SlehPR+m9ljLwpEAmbrEMFqRyOOJhcOEitqcc3z2WgvvxQLEMpiGz7hYf3UD3eRonJnK/gJdPDod97u04eOKCnlRr0fPgiucV291RxP6f15118lhmkNsXRfy7S8cWacH7e8fanWdjKeBk3u4CQyxtYfD4haq4m58OxqAgucoi2pAl+ZhHqsJMPXiGFi6u0pgJfstDvNs7hEJr9LbZIhGDLSFFDsKUGRhQ8Zwg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5016deb-c407-422e-dff5-08dafb036648
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:44.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHUD13I4H90STpvCOdGsQi990R7AslB9YJHfuO1Imn69rk9bG7M9xjLg9OOPAJbAGgLzvZIYTZ/vIXuSYyCGhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: 90ONoGs3pW1eDAO9ik817fUgZDmLBzNh
X-Proofpoint-ORIG-GUID: 90ONoGs3pW1eDAO9ik817fUgZDmLBzNh
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

Change the vma_adjust() function definition to accept the vma iterator
and pass it through to __vma_adjust().

Update fs/exec to use the new vma_adjust() function parameters.

Update mm/mremap to use the new vma_adjust() function parameters.

Revert the __split_vma() calls back from __vma_adjust() to vma_adjust()
and pass through the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c          | 11 ++++-------
 include/linux/mm.h |  9 ++++-----
 mm/mmap.c          | 10 +++++-----
 mm/mremap.c        |  4 ++--
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b98647eeae9f..76ee62e1d3f1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -699,7 +699,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_adjust(vma, new_start, old_end, vma->vm_pgoff, NULL))
+	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
 		return -ENOMEM;
 
 	/*
@@ -731,12 +731,9 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	}
 	tlb_finish_mmu(&tlb);
 
-	/*
-	 * Shrink the vma to just the new range.  Always succeeds.
-	 */
-	vma_adjust(vma, new_start, new_end, vma->vm_pgoff, NULL);
-
-	return 0;
+	vma_prev(&vmi);
+	/* Shrink the vma to just the new range */
+	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff, NULL);
 }
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 479c79204d96..75b6d06d69d5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2834,12 +2834,11 @@ extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admi
 extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
 	struct vm_area_struct *expand);
-static inline int vma_adjust(struct vm_area_struct *vma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert)
+static inline int vma_adjust(struct vma_iterator *vmi,
+	struct vm_area_struct *vma, unsigned long start, unsigned long end,
+	pgoff_t pgoff, struct vm_area_struct *insert)
 {
-	VMA_ITERATOR(vmi, vma->vm_mm, start);
-
-	return __vma_adjust(&vmi, vma, start, end, pgoff, insert, NULL);
+	return __vma_adjust(vmi, vma, start, end, pgoff, insert, NULL);
 }
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index c7d72475ba6d..b6bedc07ef11 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2213,12 +2213,12 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		new->vm_ops->open(new);
 
 	if (new_below)
-		err = __vma_adjust(vmi, vma, addr, vma->vm_end,
-		   vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
-		   new, NULL);
+		err = vma_adjust(vmi, vma, addr, vma->vm_end,
+			vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
+			new);
 	else
-		err = __vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
-				 new, NULL);
+		err = vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
+				 new);
 
 	/* Success. */
 	if (!err) {
diff --git a/mm/mremap.c b/mm/mremap.c
index 71ba8eddd836..2176f0cc7f9a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1047,8 +1047,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 					extension_end, vma->vm_flags, vma->anon_vma,
 					vma->vm_file, extension_pgoff, vma_policy(vma),
 					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-			} else if (vma_adjust(vma, vma->vm_start, addr + new_len,
-				   vma->vm_pgoff, NULL)) {
+			} else if (vma_adjust(&vmi, vma, vma->vm_start,
+					addr + new_len, vma->vm_pgoff, NULL)) {
 				vma = NULL;
 			}
 			if (!vma) {
-- 
2.35.1

