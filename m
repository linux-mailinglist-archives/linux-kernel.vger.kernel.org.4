Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EDA660ACA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbjAGAbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjAGAbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:31:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230DF33D60
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:31:30 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306NiaDw014016;
        Sat, 7 Jan 2023 00:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=jtpI0KVEQCZUtH/7RpvnH9jlwielu2wFGLvm8y7bZv4=;
 b=s6OfTxoO6nQhCprzRLes3gwJxfM9G+bMAlYYFoU93JMIFie8CWQ6Yzb/86zo+Q48tTmI
 c9nLm1+NryRmL0A3MP/oyXSxz8zfiUtyLf9rQBYqYxbtMMMX3yWYJQYsVdBqR3BjO10u
 MZJeoZv31x1RLf1V7W9XGgHTmA7dKK66MoglDQK6T3vhmSiXSHxbKWcKaN2JJCvxICpX
 xAf9HebxlaAxmq5KyP2Dq8FoNFwZgebP26qrc0gzMlFjSF6qi97X6TOfxxSBYVbmyz9f
 ralGW8+KNmuNPXOzmr3xRZZpjn1fwMNsH6xr/piZHrAdV8HxgPvX/oTTA1URGP5A2a70 mQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4ccdek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 00:31:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30702Mmj032518;
        Sat, 7 Jan 2023 00:30:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwft1q7vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 00:30:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jpp1tt7si4lfvhstAqnss0zxC4aDsp+rdRafM/eaZe7gmG+Mc3QBcv1yOfuAb0yrAcxxO8Ldgp/72RXy6fSMY+SyX9cluWCTusMv1aa0U5oTqSWP+If9AKw6aKJxGU5Bopnk/l2UDBbFDKGyf+3V2Ng4MQ9PYx4ejuQJjcch8T9Ata1d9noWGdE9tXsgKfa6NtKbum1BUVLmrDmsTMxjRI2H3dElhTgBDTIOYn0D65psPzxlHAzf2Ao3ddl2CdmQXrVyxAlP2tnMsHKna+ZFLJAFNamlbQOd+ecXhbLVbMIiXnuFUXkpfEThixyDpX6Suc9xMecbDdNzJnb4N8rA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtpI0KVEQCZUtH/7RpvnH9jlwielu2wFGLvm8y7bZv4=;
 b=Jib8uLQDyA0G2iGZ9MwemDtyU8qonU+XInqIpuF4XsHbpR29+9BWSOKtLMeeSp4LFSSOegoiCQfpV1iyVdkfjscnY2E3x1PHafecN+wX7HpcOCrGJJ+ap9nQ+65u++gkOIUr4ebeqBLMF5ghh/wou4xgxBK134Nyd1aqjxKRX8rP7+rvfE4vTxqEsIbTPkF5daLD8LBUM4/VG2dHzp2JWPh0yPEAsE5KqzpqwIHe8aK3d82KUHSFmmPHwIs0LYRhZC0iZL4U8eyN+m4cGkUHz9CCX4Gk3V6gyfdGfcrbCWbNliTZ+4bq+GxqtgotX74GOHy8h6eiMAGEorM+sQG/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtpI0KVEQCZUtH/7RpvnH9jlwielu2wFGLvm8y7bZv4=;
 b=o0uE8QXpmG2eG/QZFoe+D0VEVyerfVflgXlLfEs/E2nv4o7VkXq3U9X944ktUiwPG9mkbhukamJotO27R/TWOA+91YrsV9iVT4XmOug/I2WYHA181ihaFMC9xBracRbY8ebtbTPvDBtC+l403Bnqohp3v6lqOz8Xy9Q4ZSPcoFw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BL3PR10MB6209.namprd10.prod.outlook.com (2603:10b6:208:3bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Sat, 7 Jan
 2023 00:30:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Sat, 7 Jan 2023
 00:30:57 +0000
Date:   Fri, 6 Jan 2023 16:30:54 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 5/8] mm/hugetlb: increase use of folios in
 alloc_huge_page()
Message-ID: <Y7i9Php73/tzU2a1@monkey>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-6-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103191340.116536-6-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BL3PR10MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 744fb454-b4c1-458f-b47b-08daf0467199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4Pv8qgjqw+lSSCvYHjOqFZ7pwJCRGzuNUg95S5Ygmk3T0bftHgrZDjj46mWpKnV+Cuocle/2ybHb4PDvBH+H0E+Nm9KlPYjazK50XOq4eXLXw37rBdPDaLakrt3Q6E07X1rHiux2YmlyUN49JTM1iIpmmvmcP/b0M4IDueUBLDZnf+2TcWMTknI4DV1oxi36Wa+6FDtu2cUNx059KkrKiPXQxiIx7XSrSNP+Wxjx48Rwjc945bcqTzCUQ5KDlK5wUtsTqNkcZE05dcjcyMF3U5THMAoAL5fMlDFfbFJrLdCjTRXEETRDZCjWOzVpFsrG7DUOG6hwQIcRzh0fA7XycaUhJygL8EhpnFQ6IjpbwUeMduDKkejkXtecJzrd81TPgGAJIa1TclWtS/mcbkbhLDDoddkds7ZWjYRnT0b7+gR4C3h1KGwR1zkDt8t+hGLsQa9BTyiz2y1L0DF2NNDck28KT0KM4lxXjHllsdEkVFq9bowMZdMGxjMC6T/ehuCvXVmbU7iY70QiDu/2s3qaDoESCQzyxfPLaDVxJFxscvsvwfO/6r/fxA3QRVdX+owGasA1I6TZXFQAQdSdMVSgx0ef8rfELKoe6ZUwoeB3xFAZvNkHMhgcTNtqDnWrpsaMJ7PgzpHBT50n3WmhTQSoaK5TGxdP6/FL2cXPbJrkDcEt1zT12XVTeG6cKkpOv6K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(66946007)(6666004)(186003)(86362001)(26005)(4326008)(8676002)(2906002)(6636002)(9686003)(6512007)(33716001)(38100700002)(316002)(8936002)(6862004)(41300700001)(66556008)(6486002)(66476007)(53546011)(5660300002)(6506007)(83380400001)(478600001)(44832011)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oNz6TTGABEOdbQ+yVNoqD5X+m88pGx7SIr8yuGc0KtU4wpuV9J6Ug35Tmtg8?=
 =?us-ascii?Q?EHON6glHEq2eZGBPuxG9yDkj4nuEgq4l5C4POGLblxXULAXcRx2p6UX1IAYI?=
 =?us-ascii?Q?huXYaTp/mzymXjkh0S84uwIHlkLKEDiPHCet9xj//Ur0wLxX/xKvE6sH2+NU?=
 =?us-ascii?Q?mMdTCBZBvxQH1YpT3T0jOxZ3dWknjqu27cJdA/k+ibz/aNNaEC2cGHtB6C2o?=
 =?us-ascii?Q?sSD6r9h7iAS8TE2wX4/m93vhFGO1ytmb0TxroB7dawHsw1jEFbNkDWZMj26f?=
 =?us-ascii?Q?hr13TP1HjYgLzZMs1fpZR2yK8yJHDng9AtOz8ATdUTs0ocyRfxEao7DTKbXe?=
 =?us-ascii?Q?yGaW8MN2Fi40P+vGfaqcw7ERwE0Nn2cZ8fDXGWbF/uRJuFdxQ8EkiA/qhvYD?=
 =?us-ascii?Q?dRbfKL8dItiIumUxmexwS+PFod4Xopw7DOnbKRBSJiubl85tY3GOPUFvzEXf?=
 =?us-ascii?Q?G+1h3a3bSrXZXP4Sedji0KLJCICaHuY6FT5wdSLKmhHMqDaSGnrf+wDJM/1R?=
 =?us-ascii?Q?M9eBtpaiepkRyLosBYD+7PGRE+1DQKrSiLKJZAKdiCvim5lTAg+jTIbhpm+D?=
 =?us-ascii?Q?TLYFy6TXSdTy93WH3MKddDKpWCrsFcis5Gi8N9GJMKAE75Phq3V5X200zxzP?=
 =?us-ascii?Q?f/qEQayV7yGGHAOv5Gb3Hcj9xJ06aHSJ7XChIASyth0e0OS3i9oOLnCRQ22G?=
 =?us-ascii?Q?xp/Z4OqrdFkQCpITtgGyyEZzZ6rY9pLHGnn1xmXQth4ptoS7aYGH0ojpDBLG?=
 =?us-ascii?Q?PfYmv5NBFt8nEDEYXH7yjeBt+xHH6gMp5hJbn/kmcxUnSSUhgtVe86rk6UXS?=
 =?us-ascii?Q?pEGIZa4VjFnnht5VzRx4N8CT/ZErMk+hdAz3g/9T0o2xwo6+e0RSveyYFfXE?=
 =?us-ascii?Q?GqDM9ZmfapOPN7WtOJm4Svpb/3OaxTQX7eVGXnPoYPvz8tfP3PpDK43N64bo?=
 =?us-ascii?Q?SSfJTxmPnO56XtUcPwlGh2CHvYRDVdd27Q2+L15svu5a9BgOKtaHa62sNls5?=
 =?us-ascii?Q?9BZOQnL84H55zHua5DkTh5bVSifS/1dF3rcXR6nPM3VZno7eoQCVQ0umjDXd?=
 =?us-ascii?Q?E5BwmXwtqlsepKDM+vQqqJWCMOhbKhKTy42kELlYKFJMlgOo5KwSce9YmCT7?=
 =?us-ascii?Q?3canj5BG28cj8qWHVMECyvZQPI4s2vu28QBpkZBIWLw70VxPjVQPHhZ3c9md?=
 =?us-ascii?Q?20UXsglc2RjaRvjV2Z2BdKrocAc5Cxk0FCDySBwHpWqtCWhaR3KtYDqtv8Bj?=
 =?us-ascii?Q?l8UetDG78kvlqKrR/3ejPEAXTcXraSjLKmxKLrWTx7FK9s2knMbK2P/orvig?=
 =?us-ascii?Q?g3aqTA7k+kqNZdUgpm8GZeqGac8Y0/4ipBomvjivukqPgqLuFJpafklv9hOF?=
 =?us-ascii?Q?5WMRoWFpE0ubwLX/7caBhIeyDSEPSztj+4yo2Df4fqbH7UQqivGZyG6pwHBj?=
 =?us-ascii?Q?ig5VwH5LH5EA+kP0eoquglCeFj7ipyqH2JaLrFztROQbb3abryhJtS7NsAEx?=
 =?us-ascii?Q?ZADXJTqftVBJWUvY//aQo9Dl5mUED3dAQLQ8LxONmgwZUK9bIxdUf3KPLGbD?=
 =?us-ascii?Q?turKvfnnRPnyiy0NGPwvbpJzEfzVLrTMMDZonDXrGcu4kOo+3Wf6otPVBGWA?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NQpv53DIe7+Ba2svh2vFZdw0wz/yOXO55gzfUt9tQhGDkZ4MnoPi/kVVZfGl?=
 =?us-ascii?Q?cbjzPSQrWN3MkjwK4uXQ0LFwN7WKHXbp7EpMN3PDAqMRKMTXXms5QlPjxYea?=
 =?us-ascii?Q?SFBwG3V97uLFq4cAU02KBfzgWfPF7NU8+fzgjjGkrM+qdtsoVcWEdYumyjER?=
 =?us-ascii?Q?Gp8iQrBuaZ89id6tSDZsWm+fwyYj7+x3V60HivQZZhIk7IHOO2Hiu44W2U1x?=
 =?us-ascii?Q?q634dQE1IRBUGsqzdZA+22XLI1f9f+y0MHk/b6Iy0jvx5R3dG7htiK7LEP0m?=
 =?us-ascii?Q?qv4u1L4Q/HcxJVEGouBtazSGYlEXh0RHht3PelEuwbHZNvCS5Ln8IpU+spdN?=
 =?us-ascii?Q?OQWYIxwLS0xIgEN40qzdhEf3M6NIW/Mdp/8ElpMOOQcPcW137rBJje+1WAOd?=
 =?us-ascii?Q?xfJ30rgPh0zmEd18JFllONh6QambAe7CXmNLP8Gevwvi1aG/vrjkC1B8ig5E?=
 =?us-ascii?Q?DWOuDLhSkNBqDkoiWn9QtOoq67vdkbrEpbJSyATIuYtZi4bx/c/4lxaIyh2V?=
 =?us-ascii?Q?vB9++trbussWOuO40Gln5LWU2kHQ/CY3isvgUt92Ai0O8wAZGVSst39A8bWY?=
 =?us-ascii?Q?eSiEszkg+f0dx7/t94ah1vAU8mU6KipLSMKRA88yn54mFrzBDU9m0WXh6qXJ?=
 =?us-ascii?Q?FRli3mHQSi8auV00Y/TSvbu4ERdqyIjEoZ4+GvWbxjIGJvWVO0bYIo0uzSHH?=
 =?us-ascii?Q?NlAOhZOm21Gnpss3beeK5jyl3PDS7pWI0inTkfWudbXrk7jlM3VC2pXi8mvY?=
 =?us-ascii?Q?DNVWE3R2UZPg/Tnsr5Kk4qwAiwqHIk8SF1kxoDtIYloVR6ODI4rwv329Gnlz?=
 =?us-ascii?Q?rAUpwRh1g6L6mao/hpNotJU9F43BkEa4ngNdj1d312iDHASSjvBqiUr9uena?=
 =?us-ascii?Q?pUpFJ/3ehqpu39QbKNJhYbJK6xvyky0P1eaoKYTu8UPuqOTrN+SjHV5jb2WL?=
 =?us-ascii?Q?UWgT51gecYMI+mksTUkb+myc+dpLLFgCKWgVeM2URoI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744fb454-b4c1-458f-b47b-08daf0467199
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2023 00:30:57.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfDPHSVA06MI+dPxSgmJkLXBZH9CDvytXUBHemSnDxbeF3q4pVGFbtVduQy1AW3C4B6Lyuttdv7g40AuUcttXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301070002
X-Proofpoint-GUID: 3C_cCm7kQcCsxInOxaqyrK30_ArNf8fS
X-Proofpoint-ORIG-GUID: 3C_cCm7kQcCsxInOxaqyrK30_ArNf8fS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/23 13:13, Sidhartha Kumar wrote:
> Change hugetlb_cgroup_commit_charge{,_rsvd}(), dequeue_huge_page_vma()
> and alloc_buddy_huge_page_with_mpol() to use folios

Nice that the only 'conversion' was to eliminate the page to folio or
folio to page calls in those routines.

>                                                     so alloc_huge_page()
> is cleaned by operating on folios until its return.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb_cgroup.h |  8 ++++----
>  mm/hugetlb.c                   | 33 ++++++++++++++++-----------------
>  mm/hugetlb_cgroup.c            |  8 ++------
>  3 files changed, 22 insertions(+), 27 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
> 
> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index f706626a8063..3d82d91f49ac 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -141,10 +141,10 @@ extern int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
>  					     struct hugetlb_cgroup **ptr);
>  extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
>  					 struct hugetlb_cgroup *h_cg,
> -					 struct page *page);
> +					 struct folio *folio);
>  extern void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
>  					      struct hugetlb_cgroup *h_cg,
> -					      struct page *page);
> +					      struct folio *folio);
>  extern void hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
>  					 struct folio *folio);
>  extern void hugetlb_cgroup_uncharge_folio_rsvd(int idx, unsigned long nr_pages,
> @@ -230,14 +230,14 @@ static inline int hugetlb_cgroup_charge_cgroup_rsvd(int idx,
>  
>  static inline void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
>  						struct hugetlb_cgroup *h_cg,
> -						struct page *page)
> +						struct folio *folio)
>  {
>  }
>  
>  static inline void
>  hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
>  				  struct hugetlb_cgroup *h_cg,
> -				  struct page *page)
> +				  struct folio *folio)
>  {
>  }
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0b8bab52bc7e..640ca4eaccf2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1209,7 +1209,7 @@ static unsigned long available_huge_pages(struct hstate *h)
>  	return h->free_huge_pages - h->resv_huge_pages;
>  }
>  
> -static struct page *dequeue_huge_page_vma(struct hstate *h,
> +static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
>  				struct vm_area_struct *vma,
>  				unsigned long address, int avoid_reserve,
>  				long chg)
> @@ -1253,7 +1253,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>  	}
>  
>  	mpol_cond_put(mpol);
> -	return &folio->page;
> +	return folio;
>  
>  err:
>  	return NULL;
> @@ -2305,7 +2305,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
>   * Use the VMA's mpolicy to allocate a huge page from the buddy.
>   */
>  static
> -struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
> +struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
>  		struct vm_area_struct *vma, unsigned long addr)
>  {
>  	struct folio *folio = NULL;
> @@ -2328,7 +2328,7 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>  	if (!folio)
>  		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
>  	mpol_cond_put(mpol);
> -	return &folio->page;
> +	return folio;
>  }
>  
>  /* page migration callback function */
> @@ -2877,7 +2877,6 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  {
>  	struct hugepage_subpool *spool = subpool_vma(vma);
>  	struct hstate *h = hstate_vma(vma);
> -	struct page *page;
>  	struct folio *folio;
>  	long map_chg, map_commit;
>  	long gbl_chg;
> @@ -2941,34 +2940,34 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  	 * from the global free pool (global change).  gbl_chg == 0 indicates
>  	 * a reservation exists for the allocation.
>  	 */
> -	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
> -	if (!page) {
> +	folio = dequeue_hugetlb_folio_vma(h, vma, addr, avoid_reserve, gbl_chg);
> +	if (!folio) {
>  		spin_unlock_irq(&hugetlb_lock);
> -		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
> -		if (!page)
> +		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
> +		if (!folio)
>  			goto out_uncharge_cgroup;
>  		spin_lock_irq(&hugetlb_lock);
>  		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
> -			SetHPageRestoreReserve(page);
> +			folio_set_hugetlb_restore_reserve(folio);
>  			h->resv_huge_pages--;
>  		}
> -		list_add(&page->lru, &h->hugepage_activelist);
> -		set_page_refcounted(page);
> +		list_add(&folio->lru, &h->hugepage_activelist);
> +		folio_ref_unfreeze(folio, 1);
>  		/* Fall through */
>  	}
> -	folio = page_folio(page);
> -	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
> +
> +	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
>  	/* If allocation is not consuming a reservation, also store the
>  	 * hugetlb_cgroup pointer on the page.
>  	 */
>  	if (deferred_reserve) {
>  		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
> -						  h_cg, page);
> +						  h_cg, folio);
>  	}
>  
>  	spin_unlock_irq(&hugetlb_lock);
>  
> -	hugetlb_set_page_subpool(page, spool);
> +	hugetlb_set_folio_subpool(folio, spool);
>  
>  	map_commit = vma_commit_reservation(h, vma, addr);
>  	if (unlikely(map_chg > map_commit)) {
> @@ -2989,7 +2988,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
>  					pages_per_huge_page(h), folio);
>  	}
> -	return page;
> +	return &folio->page;
>  
>  out_uncharge_cgroup:
>  	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index d9e4425d81ac..dedd2edb076e 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -331,19 +331,15 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
>  
>  void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
>  				  struct hugetlb_cgroup *h_cg,
> -				  struct page *page)
> +				  struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
> -
>  	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio, false);
>  }
>  
>  void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
>  				       struct hugetlb_cgroup *h_cg,
> -				       struct page *page)
> +				       struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
> -
>  	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio, true);
>  }
>  
> -- 
> 2.39.0
> 
