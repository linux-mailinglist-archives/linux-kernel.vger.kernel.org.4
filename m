Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170D66DA5F8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbjDFWsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbjDFWsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:48:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C7C30D4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:48:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336Efv9N016539;
        Thu, 6 Apr 2023 22:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=grRRpSyMQvyK8edJhQG6CyoJvWpcTrPKjst0yZVKuQc=;
 b=QBltCibGWntLrCjx5LoV45fVZX/3k5FA99WVgemhlAKQpSduWY81xpv+Rnn8pkwUiwsF
 87yCfDxOjO8SUf/xixRPTIPBnQ5NdqukFFySuHWNgFj9kWeUuVScgUox8Nx6er5Tt5nM
 04ZEBKcuMPT3tBJeil/FZAefaZo6+B2jJzuoEo/sgpLl3sAWnIuGSaa4+XpDX7mt6FQR
 i6YYiqMGjx2nv68mecFzd/hCMlAJWreDVPGsGYgCmOx5oxFJI6C/txQkwnVpf5boNN2X
 zWrRi/ik+O+25LwkbS6HpBQS7V83MGVPi3CtAUfKZbR2//fJtqKk4FzgyxGr2zFyNFYz ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7u3ydy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 22:48:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336Kp32H036519;
        Thu, 6 Apr 2023 22:48:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptpayss0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 22:48:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSpz7TZmc9wYAnnro7Bd8nNon48B6VsEW/6vfsceC09x0dDVcaUZnLnNYtvIg/8fERH7g2WoqPJEgrz6rFXyQJekdf91XVNsaezZppf0dCcGzQ1zPxXbGIA/HXUz1BGpMLAbwHhjEhqhu/jH0aXxdE2+XlRizwFo1fx0ytaSKRMnH/dNrmhah6B4LEoxxgsPF4rTa0eyEVMNobDpIKxDeznwEhl4uecRJ5dDbekXkusixnMhAKm6VgaE9VSJeDgS3XRAO2bpKiYkTQztwIF2mUI4o6Mt6H3jwLQDneor+lN1KEeexC87ZxtOzwS9Cbd9SgR7KymeqPPX7AnDja7uNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grRRpSyMQvyK8edJhQG6CyoJvWpcTrPKjst0yZVKuQc=;
 b=m0nLDnlMHdWpvslIEgsJNvdxf4uEj7yTlQ9/phX/y3M1KdRbsO6tVGgyS7nGmBLOCsUJgSzMwFRv5MtyhCPsAkauZJ25FbjhkCbB/xeLhLWMfomCCCkPdrj+Shede06/XPtJMZByTEIW70KfSfPsh4Dq+RpizbpneogMB57Unkj5rcNVl9JkZbZq3BECHGdISAWNeKiXvtNghom1XdAsXiiJQwHIRnlZqm9KcSwJHqVnCjxEtQxe7E4iCjOjyE52WI7StxFHPpmHl7UreMPLUi4dNaG/I1Ufoh4FgjeJcJRNCALiaR96BI2eYJe7ovEyNs1ODkeIzj4mSogPElRMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grRRpSyMQvyK8edJhQG6CyoJvWpcTrPKjst0yZVKuQc=;
 b=zdoatdFaWXv9Ygky0p1yWBiyCf/aCWuFgMLZ9ObdpSfPwFgus1BmSKuwI/yTiNcjhcTgmkJ+2eUyspqTfDm43iDcUR1MkED10g4xao61uEUDBqJgF/sPSPTnyKFcdK4Hg81Gbci4E6c4pS90+WN0tRCEnJ8zV+iZa6n0WQAIQQ4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB5733.namprd10.prod.outlook.com (2603:10b6:806:231::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 22:48:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6277.030; Thu, 6 Apr 2023
 22:48:15 +0000
Date:   Thu, 6 Apr 2023 15:48:12 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        sidhartha.kumar@oracle.com, vishal.moola@gmail.com,
        muchun.song@linux.dev, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH v5 4/6] userfaultfd: convert mfill_atomic_hugetlb() to
 use a folio
Message-ID: <20230406224812.GE14244@monkey>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
 <20230331093937.945725-5-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331093937.945725-5-zhangpeng362@huawei.com>
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b92126b-2222-4495-5b80-08db36f10216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5b+0hB+30nPxxSDW6VA95es4d0NBL8kJMVjsXgAcjUD2pSqbfaxTfsaOKuBMgEEvSGxXU0LZBn18f2fh8mzDwnUh2DM6IMn00gMkLuJEIDmhhX3A/7SXTADKhOzDG3EmVxCud/ac03HbNb+tEuel9IiS4a5Jl0orWs1MMYG+nnoxt1BfLaiEhM+4MvHRlTKzd/gWOoXEe9vbyrcZnCHCO6/nDiYq6CGK1a8jH+0YUCijCrEOz9/XEL+KIuVErN7BGA8Z4Kwp8zYEMS//tJaLkwx0gkzO7rbkDu1+wDncezsQCVArT2aj1hdKfcIqsErThGuZYUru0yTvWs73JyCMLn8qJD1dMChpUMs96VkjryJ2GAOb9XNlOq/SkuC1mItZ4i10+43r63vwDHKcHdo5v/TQbi7xUghV7qZ+pYfTiPNIerPNWC3Ciby5yU/9r0k1XWPDQVsZRynAcI6WqmUTU04PCd1vrV8hvqmMhSmmhFsSwRsexbyu5TA9wRVp0rE//jTX3a0A9APR9w8fz9zC8kg7jJE6hZQodG9NDsiGMb1Z2Yfkv9MLz+joPqmNgwep
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199021)(5660300002)(44832011)(83380400001)(86362001)(6506007)(9686003)(1076003)(6512007)(53546011)(66946007)(38100700002)(33716001)(8936002)(186003)(8676002)(66556008)(6666004)(478600001)(66476007)(26005)(6486002)(33656002)(316002)(6916009)(41300700001)(4326008)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s9czjEC6cboxvc089GPo5y0ozp6g8Fjy8phO/mbW40jRef4bPjmL4n05Mstq?=
 =?us-ascii?Q?myB30BzImkTjZeWgb+DXSIb+ofDeunnW25aoIfpIzNBMexme0H6qW3jOc16r?=
 =?us-ascii?Q?BxiLnO+zPYd7jbHef7x8yiW7VLdA161uyhK2oT1I8z5eco8FEUm8CPmUVADz?=
 =?us-ascii?Q?J5sDW8fCxp01Ea9sUulaqukAyflhLTXl2WyuqlWhS4JJGmO+j3ugADGa84lh?=
 =?us-ascii?Q?LrKRVk0vWbG7TgjAytDtVkLEScK1lB7BvQSL5SSeJVyn49RY78BFPdFHEC/6?=
 =?us-ascii?Q?QeF/GhomJUfPLmXgJQ8Gxkqc9evXqsHz4Q0FBmR3aFkElfI1Xf8ZojyQlfM7?=
 =?us-ascii?Q?Ovj4Yb7aX6AC3cKhZWw4VSb37Kx9ymVLpdbToATDwJh3ElcdRMtBgO4dQY97?=
 =?us-ascii?Q?PSA6jF3B/R5nNDjtr+gGylpeoLSOC69Rw9L/Hbixt/8rUE/CUCdhz56SGQG/?=
 =?us-ascii?Q?Kl9YFZdSjBRIWr6fwk1cbB21KEh03hL4G8lccm9iI9Fo1xN3MdhsTc4NDa8C?=
 =?us-ascii?Q?RZDnZYpcBliTO9+9tkNZWTroeImKlrnKmzYvz1OH6gV1vj+JTwx8JYbLnbyH?=
 =?us-ascii?Q?Iqnwe1329za3Z4Kt2nF7THc7YaxVBULxdbFV9Gl1kUw5WBLyznsTPvQxWAkr?=
 =?us-ascii?Q?ICZ6jjQp1XVUFSI8jcQiGb+J7YZf1nfgCMs9GJr0k5LRm4nfz3npg6IgK9a7?=
 =?us-ascii?Q?t+9lpecD6pB/lUkUCZCWcjMIyZG7a71VpJipQtWqfPzfL/3F1WQ4uCipQXR/?=
 =?us-ascii?Q?rXG2Mye9uhNcznhfmt3rQiVDT6+8tlkpUuagMYcpqjMCNO97y2uYf/0beADW?=
 =?us-ascii?Q?ZKrYtAP8VDGIMMqIvbeD8Ks4zuh/LP2Wz9IlpxccScawLmeuJIf6AQeXGGwJ?=
 =?us-ascii?Q?lJF+skZgx0LF32OdGMtIzLelG3FiHecnamzc/sTlDY+z39H00OCD25i7t/Lk?=
 =?us-ascii?Q?aeEKxfyxaEvT0Xvqq2raWpUwt7IsxwFV9MSgRfi5jaCGy6TVcjcZghn5VZ7s?=
 =?us-ascii?Q?YxiHxcxKDsBlODqz3XYAlxauutAvEX3224v95GvzTB29O1hRHPxUNPpzkt+V?=
 =?us-ascii?Q?UkJfXBu5K5djs+dndQKMWRA4zLLRc2X0XLtrS1XQO9BhAKppFGnho4tWcnFU?=
 =?us-ascii?Q?6mpICxS8zciFNQFk/K1K3TrhTBi2zhgvYzcWnwZOxhgqJ1GMGziDKYawv2LR?=
 =?us-ascii?Q?YAmOmJb3lTbZLbf2wFavDQPUZCmzTyRNERbWwEEnhhm6SCILWMHp9+0zHp9S?=
 =?us-ascii?Q?Xl4TpEmGs5nZVih3X1c6IK5ztVtmUTd3rryJtwUeD+fBPVuRpt9e6DepfL92?=
 =?us-ascii?Q?2fycZqdqNyj39cEuIp8dVL/M12e+i7HStrzyOn8RrDavqrSv2iMnb4iYn0Qe?=
 =?us-ascii?Q?BAErSNMKdKztrynFFc2+TiYK3pl8cmH9rR39CsNFHzPUpaAdx76TcpD/3QDB?=
 =?us-ascii?Q?kqCa68QRjX5UGa3HZFQOLCqK0NIdGcFgMuBwB9gmyavFxAy/mmIHpPOcUGRq?=
 =?us-ascii?Q?ZZPeoxQhUD6JKCCMOMpoPX5NOMmpGL2YYZcGgLJ5Gjct3F1s6TirWUag0/LN?=
 =?us-ascii?Q?iSIgzrHsKag9fNSPiVigIDll6rxeuJylm/fyunbiBYv5WmKE4pAOhtlPJr4B?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pJTY9UVAyW155RzDszB6nG5WP2HdMkmQxJXygD3JiVGmhBUzMmDeUwQftZKU?=
 =?us-ascii?Q?JJt/uHarkBDJ2m0Zd16X4vNW2AlG6PqefgvYRWKVHv8AxzFrHJMI/bTtiTXL?=
 =?us-ascii?Q?eFMCOQYvnZd9lslTs3LFk6PJbCfykZlY5IGWE/wu7OfjkbYAcRhNUQ9kqj0E?=
 =?us-ascii?Q?Ol4STmo+JBsWfSF4cBLqpiZABVsKziaWE70VDKdDYDWeDhQKpJ+WZuUNzInv?=
 =?us-ascii?Q?C1r5/hZVS184VdSA3CuejqxqRQp1jNQUONnmu1NEaOE4xvJ10Cp5PpTp7lp+?=
 =?us-ascii?Q?Gd9DZM8/dlSkYixcygRTJsZDDZdnyztHcyiogTtLUdQ6T0cpcZfFfqq9wuGj?=
 =?us-ascii?Q?lHbTVBnkkJVS6SENpnoPFmxp/1tqGpAKfLkBKNykMRQnZNPomMFyLmTGdcNh?=
 =?us-ascii?Q?fm8rwKE24BfrBO9DpTAPtK8GjqBAgUHGEa8SZED2xVKDBAArjGHb3ZC9rtXP?=
 =?us-ascii?Q?XiXX4Sa8dOFM3XqLya7/b5+biVZu0IfAmBncP/AvxWrEFuRmEjSQ8/HxP301?=
 =?us-ascii?Q?rIZWSC17c0tmMualcqzJfX3CFDMxlI5MKOc6SoMVUH8rN4Oj3q99TwjZI0f2?=
 =?us-ascii?Q?kvasd8wQK4n7MyKcuvGN2BraCkcvlU7UdOA70wb208kQTDMCH5kOY6GFhG+X?=
 =?us-ascii?Q?Q6W6ouo26a84UfLYLr/O4XqprhR0qURIbxrMWmimG1O20jYLn6jrRjaQMz7H?=
 =?us-ascii?Q?4U/50Rkn0ZBBXxE1jz8gLB4h7wayC1lDeGDidgQF2TR8LlgziTYkySFYneua?=
 =?us-ascii?Q?gHPDnv0yEHnoIun2gALzwjqxpJvPOpNaiXshVwgXOgKq6yPR0JwSbuNnVHqk?=
 =?us-ascii?Q?z9CkSFVwsEGk04QhChqMiXU24iQ00YdrAZ9vGFE3doE5/3yhztZySHbT0bPL?=
 =?us-ascii?Q?bVG/X2oNU/73j0uh8KuDube+ZyW2ZpI+WF+IeLOVcxAb08x+Y5Jw2Gf+13WG?=
 =?us-ascii?Q?Zjue5peJhXvKcNkvHPTXVw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b92126b-2222-4495-5b80-08db36f10216
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 22:48:15.5060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQ1HD1R6u5thFdsTcbRBUo9QVmBgVtxiWPuupEEMSfUyFvY4cSLAd7tCf67OjY3+EHQudJ8J86/p+EcLlii+Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060200
X-Proofpoint-ORIG-GUID: KYSK2155WlSaGjE33gj68PdjzLy2rDjp
X-Proofpoint-GUID: KYSK2155WlSaGjE33gj68PdjzLy2rDjp
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/31/23 17:39, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Convert hugetlb_mfill_atomic_pte() to take in a folio pointer instead of
> a page pointer. Convert mfill_atomic_hugetlb() to use a folio.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb.h |  4 ++--
>  mm/hugetlb.c            | 26 +++++++++++++-------------
>  mm/userfaultfd.c        | 16 ++++++++--------
>  3 files changed, 23 insertions(+), 23 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
