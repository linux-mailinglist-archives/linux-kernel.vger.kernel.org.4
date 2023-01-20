Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6CC6761C0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjATXsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjATXsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:48:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA22D743A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:48:20 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KJxQgd031934;
        Fri, 20 Jan 2023 23:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=IWnSgKNdr2VCxT3u5REcGZt+nhci803lvi0ig9NHZVQ=;
 b=QmwpwxPwAt19cRY1hCxoYujMTpW8FSRyJudSZ/IhdnqPlF1VUV4G/6b1YSxkKaKiYXmY
 j5xgQO8TiRBENa31nnxGzmF7PqVOIYh2YAEddviQwZc4NY4uOI/mu82oGRj4V3JWQH8X
 tcRRmDs/f8zA5rTAddkjgVFbjpboYQDZG9bAXtaYcHAP201xZ6iiIJGPGPrg+ei0JT+L
 ZXVv4PAZW5nQ35YeNXkq9sj5iDRKGz3SwFsSW2r6b8E+0VSvmQPX55b2YUzyn4W9b6Be
 dejop+6BVhqqbnfvcKw9hhUCMkvsgEyEceUHNzrBbrdHS1ZPAqH8y0vf72fZ7oIntIho mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k015yqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 23:47:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KLOLCv018797;
        Fri, 20 Jan 2023 23:47:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qujrpfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 23:47:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLj1w9FLJKuyRE6Jj2A/bfMN8IsgQljk6zhL6NIZmrWjYzDUeVMqTjKotZ/gnNbKyYYTeoS06KF2w/FWkm56vc044ojeT2QcU83imG4LQF+waPKT/aDSy/6NDPsaqcgJw0WcM04Tksv6zcNTpiLml8hEiQn7AxFEOoW9bkMS7JmnYJeNV5rRHlmsk6uB4/7G3PYYZnJPXS6i9C+aPALr/o/eo8kVoEEgrvkD9z4jc1OtcqRnmoeLNUeG71ljvknhpWRok6s0Ag9B2TzA8GR2iml9iYNDCSBrXlk1uXSpoXihiX/Nr4Sh6m4C92V5am26f3soz1S+WszfHXktWaDcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWnSgKNdr2VCxT3u5REcGZt+nhci803lvi0ig9NHZVQ=;
 b=GnhaVj2tyhMgFLPK0oM96P9sYJ3HFKLNGklT8bqVhmmgQcU6LWPfW8V4jyShX1L3qHdZejFHbxcFyIE21xi9XZrsPg1tu0OckWBSms0xf+QuEI42ki7ZGGBZHXrNnTwTaiFdUZMFkAdIHGw0Tqw4LGnwzenFXN/KzUDehJo2ELii+y3olLMccNhWzc2HinqhZYFOUVBs9vDr1WU+AVIewnyeyRdP7qOwabxDdc/bkmjaWjjjmAbm3hh3KnLtXw1cJhCQUfTCA7gCTmtGAYcH5ilHDwgiC5196DaUnr3QvCnRqZr97DNaBjpUs5t4Mpnyb9gFeT8GsP5ckoNQoBXyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWnSgKNdr2VCxT3u5REcGZt+nhci803lvi0ig9NHZVQ=;
 b=Tcd4vxXWs7kgpSFZHuqajHdgOTYX/p8hi4n3W5PAQI1owHzpsPDDEOUAUaVn/TpALjBejnoePSB9o5/G5SKDhJxCkYg0Liq4YpXc7hnwL7EBHG/2DBGUd6+UpGfEJDq3JwuU19uc4k+K4OEqJ2/Za2EjNMmhRwY9fqqIKgPkdg0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5347.namprd10.prod.outlook.com (2603:10b6:208:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 23:47:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%9]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 23:47:36 +0000
Date:   Fri, 20 Jan 2023 15:47:33 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, jhubbard@nvidia.com
Subject: Re: [PATCH 3/9] mm/hugetlb: convert putback_active_hugepage to take
 in a folio
Message-ID: <Y8soFd4bDnx9m27p@monkey>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
 <20230119211446.54165-4-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119211446.54165-4-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:303:b9::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6baf8ab9-e582-40cc-9146-08dafb40b52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O94mWDE/Bo+5EtDU8GdIspqtuTewb8y+gHP3Agh2lzmp65qcXnCgcRw5LV0kDr1zhY3KBd5M2MBDiDk0MsitjzPJgynM1+hIO/nWEVIRiT5v0mZ3sGPUSsVu2J30Fz6hcnUhdYRw60xmancGTbn42GQ2StNFUEDKCI96orJ2B//9zeoioWvJ12xyhdJMb54ePyVMptGpCHByW+9fgkyJZI02bAwq70lgmziLkGCzBG0hfaAjq9Z1THpsgviNuB3znFl4jBJFStCNEoSJ29ad3A45CaW8voa2Vzr1rkoiY/kO43iy3641DE3A3ydl61QN6CdcHBSPjvBw25X97it9qLdigvKGxi6nqPI4Ukt0SQxZQHfnCXa3t39TvKsW0cfKNUUAGF+PhdgEh6UKjLGxcMPFiA1/24lhCqDsPKKHatlEZLAm6dhsc5UBKK6+hvMi88I/9MdMkjdBWSoBnd8D7kRFjuzZrSShA5Ax6G9SzW4PdKcASMnn/VH5GqkksFouETkwGE9TPZp7YNlB4tW+9qx6YKIj7/168NNFxhBW5850E44LZTiA8vqt7VNxCA3Z/Spqpt0HgqvCUUsQavgD2GAs7NFHjLbT3OeDHrriuDVNycw7/pZeLmuD/elU6o+ulrTU4bFjEveXCyAg9nIuNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(38100700002)(6486002)(6636002)(44832011)(26005)(6862004)(5660300002)(8936002)(4744005)(41300700001)(2906002)(66556008)(66946007)(4326008)(66476007)(316002)(33716001)(8676002)(6512007)(83380400001)(6666004)(53546011)(186003)(9686003)(86362001)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2QbtgKT8J8MYsZ2FF1HDbM9jicHJGFZir7piBh8bbNQMMkRgZmeQQQHZV0mg?=
 =?us-ascii?Q?hbtmwoF6+KD3QONUNm87tQIWx0JmhZSPhmDaCtjRe5eNCyG3BhIFncakPG+s?=
 =?us-ascii?Q?WpIDF+HlwoquexS+BMaLVORusMznYpEDkIEPLSM4UxiUq/filGnG3W2LGe0W?=
 =?us-ascii?Q?q+eAz7NPs+x3ne/kOVbt5cLgM8ow6nS/uFxeJLHiVzBTt1/iWrOXd9fvXDhF?=
 =?us-ascii?Q?4kPBtuq/dPZ+hvauf/s8NQJBpPS0WmOydjjWAUK91YQozLUzTr+PPMgmHzFH?=
 =?us-ascii?Q?hnTlJQDif544fB2UFgJIlDiiA/82wqL0Z0U6FMWDLAZ6K+2Tr4tA1sIfwS9Q?=
 =?us-ascii?Q?GUCZ1+bfEEN5UZ6hhWjbQZKR1pZwU/CNgZ2zAuqgx8m2YnSTlH8FYcAUluiF?=
 =?us-ascii?Q?RvL40AMUyw2jTBT8Gv2jbeTDwF4JXQiUVSab7ZJg0FIZVTRhwjzWomIjZX62?=
 =?us-ascii?Q?flmz2uHjqDvfRiVJypqHHFyV9r/5qfHxrRjnz5htz+xvrd2LJ/UDi66auOVe?=
 =?us-ascii?Q?svohOEFV1ynizpRYkYTKNefwwO1N/wLINTv+5OABYyW26fHFGy6Gr5gDrkWy?=
 =?us-ascii?Q?rKJ8Gacwn7FQSoU9qbgxp9OrJRIdCuWZa5DOfnugOq6ta2JxtvwQMiJpZuiY?=
 =?us-ascii?Q?P4DWPQVYNdkOVwAYfXmdcw5UjOB7Dr0gAK4MSF36sPSVpEtLLMYIljl8iPcO?=
 =?us-ascii?Q?WT3oqrhF2qVq9JGilLNNsi9Ew5XYOonuIiD13DNumAX6y5CBRUXlHTSslCTn?=
 =?us-ascii?Q?QlgjbRnzjkyjOyOWY8n+YsrRYg0nDimAm3sbhya+tznZwRNTrg7uX01fZrwl?=
 =?us-ascii?Q?6bYNGXBge1sOOd+hqCWTIT1PA/GnMs5IXf6nYnQyzH7ZWyInAMUiw/1Vw5Nw?=
 =?us-ascii?Q?LJNXXcXkcMq9p9eKofrbN8kQgF6GVp/LpTjtm1JcGmehvzbN9cOQJN12k+Gj?=
 =?us-ascii?Q?qo07iVSXyN/ajTTEiAkkB+FMlN4ENIfz1HVv8qbBJiZBRzH16U+BoMrvdOcy?=
 =?us-ascii?Q?FV6jCkZOEhEKhJYaCJj4rNGDz0+99b+Hea4HZPKNWh4+4dX9gXjdg55MQTtQ?=
 =?us-ascii?Q?/q1kh/vv9t2Peb3JAlc14BUWHDwsXuLm+XMKZQRAhVy57Ls5g27yYsCeBOGV?=
 =?us-ascii?Q?h/kyu3yeE9JgA0HGXkVeZ0qfj18eK4K9H/84RE8H/P3ysYJ6cTwE5sdiJ3gY?=
 =?us-ascii?Q?YdaS3GOXTBcCZoY26rQL+/1lWlgd3ahtgUvdFxFH8ep/qC5pvIoRsriaV1gp?=
 =?us-ascii?Q?kUofXGQKHMQbQX3vwOsxvT9TKvqgq5hSwsp8EsAWXipqKXXFB46se3bI1405?=
 =?us-ascii?Q?YLgQPOQVCd+0MWB47EexfKBIwXOFQv/uKJsX8ApEP816wgqofCiAb2yUBWzC?=
 =?us-ascii?Q?yFN78PceypgpVN9IaNCv8evmg7l7es/Hxum/U546/v7/GUvw55aZP59ixCFh?=
 =?us-ascii?Q?LzTiLHb6HG3CrChab6L+VwDetvWmZTCUOIulXjStWoiCmmKep5l0isjmLD3c?=
 =?us-ascii?Q?S4jH16v2hZPT6InO4r5GqHSLq+jD1CxRJAy/0c66SteZf7rOONTFy8D1O+3l?=
 =?us-ascii?Q?Sv6sE/dHHzQolP3510899Y8PvGTmx//w1fv1hTonJCCh39P5wxnC+wptRxcM?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EyBFiALbiKyHXxFReGM8w9WCDerBbk/GRhP4xxHKPbl1ulBkIl7cc9ddtQMF?=
 =?us-ascii?Q?WvtxG9Cs3Bz5UkZRciWStVH8WsXT14VvP9QOluBr6vWUh42K3HiZGMUlZ6fl?=
 =?us-ascii?Q?ruvyq+O7Nx56b7YfBc1Y8oX/3Ab2UddOa1cR+IoTjtp55V7IZ0zRMwyWCxVK?=
 =?us-ascii?Q?a6NXcHlzNu4ZMGlAb7+qh2zzHtfKBzFp6cX2yjzIhEZ2GMOclcqeq9IR1JnF?=
 =?us-ascii?Q?zU5UE6ktFQOWiBNCcR6BtUrF9UuH6o9ZUu/yV+uNoGeyHbsp0AyfSz/qK2Uj?=
 =?us-ascii?Q?s1UT5rXRn0rPhmIOCTVCKvM7p2vlZBY7vR32rgvMULsr1MklbBd+xKfiOISi?=
 =?us-ascii?Q?1+rvXN9PWA2KkWP7kD4jayuqxof/o7cIc/1rr3PmUfcaiOdk5RnfREIsTLvb?=
 =?us-ascii?Q?mHLmLQzdXE5UK9CvesCecLBBmBlzRNgIg7sEf9r27at6def3bl+Y4Gftpc/G?=
 =?us-ascii?Q?SP9dU5GePQMGlTzdhNusmLbuYRSFUFHarZGp/zFZFcaBjxgWSDy8ZVOz33R3?=
 =?us-ascii?Q?jmYPoQghrv4p3HTNd203s0tfjLQqbzaq/ILMu00iPKYKnEquGCSVAr0ko7yZ?=
 =?us-ascii?Q?b5B1T8tYVkx4FsQ4Py+fY+qbbNFj46l5TVGDOrr6ABjzGxBi4o5cOYQw6q0j?=
 =?us-ascii?Q?aIkrN5AYWUSbtCnLSvLknYyljIczz8dsjPJRnntWmiy5prEnwssgfDYcScPn?=
 =?us-ascii?Q?C/PgvfMi6JPmLgjNqBoi7AaotUbMPjV56SquH9Xlg1HCjApTUNPfOSkgxKSL?=
 =?us-ascii?Q?F5uBKp0BR3SfOtHO5/Gj0fE5F+PQX8cNFMk8W7TuPA3jgLNc3JOu3rGRVHaB?=
 =?us-ascii?Q?vS2OMHSCWF4kkrOdhT8oRQtV9fm/E9cuKbR14JmnO2mtzmJcR7TiMws6VIZS?=
 =?us-ascii?Q?BZ3X/XCJM3dIsCudecgeJd6Mzh58BvLrVaEYAYCvhN4lLduQEkVKUr7uZwyA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baf8ab9-e582-40cc-9146-08dafb40b52a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 23:47:36.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw8+WDh3U8Fz/rLnMaQhm9HAfRLxFkOFJdJ+HrWpPTGAc8z/Wpb6BOJbXHzp2yY2ZPBY81amo8XuMHlOnYlScw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_12,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200228
X-Proofpoint-GUID: etTwYE01R4Zwt396SsfJy8Hcsq7sGhp8
X-Proofpoint-ORIG-GUID: etTwYE01R4Zwt396SsfJy8Hcsq7sGhp8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/23 13:14, Sidhartha Kumar wrote:
> Convert putback_active_hugepage() to putback_active_hugetlb_folio(), this
> removes one user of the Huge Page macros which take in a page. The callers
> in migrate.c are also cleaned up by being able to directly use the src and
> dst folio variables.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb.h | 4 ++--
>  mm/hugetlb.c            | 8 ++++----
>  mm/migrate.c            | 8 ++++----
>  3 files changed, 10 insertions(+), 10 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
