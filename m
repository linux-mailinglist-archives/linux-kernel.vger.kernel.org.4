Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA5660B55
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjAGBNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbjAGBMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:12:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE1D8D5C3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:12:12 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3070xie9017895;
        Sat, 7 Jan 2023 01:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=cGcbmeD1RfC0scvWwz6cpflT7qzCeF+N7vW0hv2ngJk=;
 b=vMA3C/t2Fh65CNjw+lNWNc8EImUp2viuj0ytFyEHVLbiUr5lwMp7Oc9/V+eB0TyGKiaz
 EIQocoqIoCouRXgnW1bYG+VItn1HxEDvxVUXXXu5ZrqnwHq8A7U3wr7UMviYp82cgTSp
 8Aq+IRXqLltCyVEjnozEy1MB7DWG0WhGtt/W93sdkQhmAp1vTkmRgdh1Ma1QfIopsW0a
 H0Z1Pvps2PKANlDqhrDuDX20b5hf+ZaToq0Z12kJJyWhLjZAzqn6MIEKnX8qbiIdbcps
 n/UqR1Ty3dx/d0Q08hInLH9qnKxWUJaw6j3neXVCA/m7gkuqYGdaU9PcTJzxxGN692qM MA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4cce77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 01:11:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30700qAQ023345;
        Sat, 7 Jan 2023 01:11:42 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkgukdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 01:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIDi1KnKuMir50+4HeykS86jk81SYDErEBUEAHXFRsHmUgNhGBzr9vMq1Svzwj1SyAwOQQgDvpfT3n/ojTLTJrMxoDq14ecC0SF1uK1fLjOaZuCXOQ4fxDQ1bxLAju3s0X98S5zmQYpXdIA83vkehhxfFVScFqkzzscpi38bssh+qN+XsxBL3r5KmnvPcRrn+zD6STDzp6YzFL6ZHBSZVWjn2sZvfTyXQXBKpab8oO+hBlFoVqAgx6no8FiOgspuOHDGT2tpko/u0N4jbagNpU+1APTh2ladZxsGSWYCw9nYyM7xdinnnuTlpsPpoHPxqtXd75dc4UJ/dM/l1plymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGcbmeD1RfC0scvWwz6cpflT7qzCeF+N7vW0hv2ngJk=;
 b=QUU/goc6eHz08/9j/ulgtdJqIZEcLnEdpWH87sP+w9r7K5kJZ5XaHhGlbDsZqW1l+anDDU+GH8hKC2ppfZFgrO1+ohwb61LrJ90NncD57iS+Z2otmAEK8paf0FMe5u9XHOiCB0nOs26MP5v7h+HlUvDETJO+O03GUZzq+TvlGxZco4mqre0NdWw+evlHeAo+jq1DpX5xzNSMMN01lNwQgyUPieXIGBje4r+aPDtIg/XkpBxj4ZSk+l18CN9NNYF+9T87QoFRpUTpwmPPyRluj66K1i1ZPqWJPHRMFE6M+I8lJyhxbI5BUwKlkn/Z07a/vHNm4RteFezx4mlP4YJT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGcbmeD1RfC0scvWwz6cpflT7qzCeF+N7vW0hv2ngJk=;
 b=tTOgcndBd7+NjjEPf5KolQsiWe1MWegEPcOvD579QBi7yNiur7d+XtNtdtR8jJ2WTjj5dBZYt/yMikmQJOO6b0NUCKAFWg6mkZB/EOojtvKJuFG3qI3W5822sAPdYau9kinTTOVVMU4W+Cckqigl+yolyAaKhCpy8CHUP3RVjbI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6911.namprd10.prod.outlook.com (2603:10b6:8:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sat, 7 Jan
 2023 01:11:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Sat, 7 Jan 2023
 01:11:39 +0000
Date:   Fri, 6 Jan 2023 17:11:36 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 8/8] mm/hugetlb: convert
 demote_free_huge_page to folios
Message-ID: <Y7jGyH9Atv3sPjcZ@monkey>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-9-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103191340.116536-9-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:303:6a::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c716a18-b23c-45f2-97e8-08daf04c20f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: la5HiFL3N8e++o29bjqZCkgJH3DxX3AkWyWuY5S6xgLM0lWuVVX/GksAubVXwyyXtNh2oieXr+wCAHuqatPB+Q/dm33xoCr2xYHrJzkIgwHLNWN2ADOlfIcBt2zrooc1Cgx1NDuKE3hvPebGTCxNV/tWCYl8AwD8CYCZULJfLamJAxlQ9noXjQDotNKOmB/NxRtSJAwhNDtETL96Z29jiNWnTSnT9hwxgsaiUjzALlNyUtV14aYM3cGXyjrCqqrG+RorxYns/tp06vlqX3S2Mh2rjlEMzejKaptEZitWl7Eit9ZteOqOpKl37Kue4daK4xa+RiK1sR4zysLlPnZLXt5PbJvL6f3GRvyrxHwdMMui337YK9jrTgjJffXoXB777b+Yn/bwrqqZHCGe30q0U7POkYslBmNR7xNU1zlPOYTA5cgp5SQezA3K183Ntl8bn/eYzwhsGfKDr34LlnslVhaZC/JhBRS+Bxt0nzwMBUXIhI/vcXx9BfFdgngGryH0UjFE+aZYbiX6Pq5aGJe80x3/92KoLkB1h+1KRFgZY/RnArb4aqLrT8V7UYGhKWq0o0SxeDULiu7OAmQoic2MIzusXEpfj2GDpBM3KDUYHNK/erqavK78i9Iw5o2BYer/8MwDn4j3knxmtnjXNyIK60HCCcp6CXPOaZOe5E6dzLkoFRESZX6whPxj9Xpah4Rg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(5660300002)(8936002)(44832011)(41300700001)(8676002)(4326008)(2906002)(66556008)(66946007)(316002)(66476007)(6486002)(478600001)(26005)(186003)(6512007)(9686003)(6666004)(6506007)(83380400001)(33716001)(53546011)(38100700002)(86362001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ucC8i/aRNpBAZaz1pChMO9SAn+0N9D9ibCzuOyJwhW9zqRaDW7n/x+Dsi8cw?=
 =?us-ascii?Q?KYodDtujbQz53JSs7zLD11wxpiTxuoK1BUCw5wJ/X+L1HmI3ZIdNxpCCucJT?=
 =?us-ascii?Q?gfxgZKB3Fe+uhGBiYPi+al1uJ2mKH/Q3Qh6e67Cz6ZFox+j9k21JvL3SSFjG?=
 =?us-ascii?Q?NIlKStKxRiLGMzA2iHk7xMeuyJWM9iVOouEquPzKYDQonMr0ANLqaR4M9xEE?=
 =?us-ascii?Q?BsF4Rxq9F2v2ZklwSeCGvNJCRdEaLmSCIAkQYeIxWtpMZcclZG6/mpgXNIKr?=
 =?us-ascii?Q?tYZtU7E+VTL/q+ldr8MonUjI7ydbCj7GpFSGzstJbVZ067MISv/VjPLMSDNX?=
 =?us-ascii?Q?VutCZWFiWVCBTF7kHv1iMZndk2O39Kk+aUt2S+BGvCBYVK1XEocKDEFhvbaQ?=
 =?us-ascii?Q?FjjdP3jIkWw9lq9RmUtMA/hZiK5rR6JUScv7Oh1ESlO6eddzNtVfvTFux0qo?=
 =?us-ascii?Q?22eXBsuootqhOw3Y5FSdUlKzjLwUjAAJGjE7wzmK1mVX8Y189g5qTcoA+bLl?=
 =?us-ascii?Q?EA2qXuhZvbXechj/94OHMm2JpzmW264xj73Kl/d59474cIVvYlIl1PjMDEM+?=
 =?us-ascii?Q?5dnJgx/Om1eeA8Orb5WoBQpefI1vyixjM258OxNzGF1TpSsN08M6S7p/FUAy?=
 =?us-ascii?Q?QKCZNslYMvAHZWyRRw8u7qcJo6aRM6zFtvx3kTsKZAcyiZJA/ICMLtSEUUbR?=
 =?us-ascii?Q?GnrTZbmwpqZ7SYVYCmcvICDvzdbvMSYyIkGad2BKj3STkSXsFFRDV/q4TNwX?=
 =?us-ascii?Q?QAEzQ2wINyF/S+6jvp/UbxP45PlOFU8xzhRSfKHrBsZisKHzEDwCjgkmM+hL?=
 =?us-ascii?Q?BhqEs0Yth8LAIvsms1edut6WWv8jlakzCTLHcNEGnrqXbPmh4YkA0PZ8QsBB?=
 =?us-ascii?Q?fV3F2CF6awPqQ290/mPeGijLRC1nyMrBPVSD9EtgFiHJUjqtYoTZvFLMbsZt?=
 =?us-ascii?Q?pVANslnoOI5sAHX0oytxMm70Am9NqjdcqMSmis6EWDJc77M+2i99qGjwcCjH?=
 =?us-ascii?Q?YQqKlF7qI48aiT06scCZDR+U1jnD7HY2bep8i/INXmxlAE7caYFE/peWde5h?=
 =?us-ascii?Q?cEtqPMhQfts7KK6S9QP35+z116RcC8vwCOdyuV/UF4da0wgIHpSR906BKNLk?=
 =?us-ascii?Q?AksrO+sMW8CktgRnXPcLbMJ2SvcmWGEZcVyJ4Kr7EJyUX56J3RHB/WfDnw8S?=
 =?us-ascii?Q?jLe1tqv3COdkWtdHeERJpSrkTPoVz8EwpJN9mYS2tWLrmVh5fGDjbnZTT2W8?=
 =?us-ascii?Q?9UfpUIOak/Svtnid2CiyRWpAb7NpmEVyGPdt7MtBBfREwUMUrg5uYYKXN5Qt?=
 =?us-ascii?Q?AJznjsmDWFG8tqIfBSjJdLKw7mxrV/Vpq18Uu+g/Mb+ch1nRfgOyU+xgWs1G?=
 =?us-ascii?Q?fDrUKIQ8kWLYXknuCjOgsQyED5yfJgw9iXINFf2oLxT/RZXT23s37xqtq7OU?=
 =?us-ascii?Q?mzQPV6x+J8F48znjAO9QUxR1GJ7K0+35hr0lQKc4TKmxI5iInHu8cfOSt5QG?=
 =?us-ascii?Q?krVQzsN1wftGs0TmgSJjqWqYKjGnvphSikBI1+ruUTTEZBq67STcNycZTWSE?=
 =?us-ascii?Q?qKsBHP5k6TykKoYnReSl7ABEWroTl3nnyrl7fJUjxmIyc9s7BW8Kgc4U/9/A?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?76UFK7bvm03u6io49BFSB/QDMtpImylCUhi3PTgGSbRtaRP8+YoJdYxJXNjp?=
 =?us-ascii?Q?Dh/i/PZwVnVwrZqIpHCYakeBEWlcFvI3GqYd+8nFbea8RsVoTLuFLZgFth/T?=
 =?us-ascii?Q?QLs/RmC9nJFVbvhcyaIF9ajzvfvDw2jJQh33oBg6/WLWfVehO9To4tM5GdDM?=
 =?us-ascii?Q?0Sy7m4n1E9wjuFNnjCfCW4M8Rz6azxsNZ5DGpyAXC4eySF8JEWUV+QloT4cF?=
 =?us-ascii?Q?9gSIF9XhQXnmZ4YP9xkWfmxKgYtAVtjsCphnam+RbdA5WtEZz/TDrubVYk4q?=
 =?us-ascii?Q?GEysz3C/Gg+uZDpCtHHAABUPJk8gl9iFQil9bD0d49IjsobYockUQQlTxu53?=
 =?us-ascii?Q?yxAXQchd/EpnLGfSveyfVq7PZ32g6uJ1+O8cGIBnj12qut3qe4d01ef58byR?=
 =?us-ascii?Q?DjvjZ3QMleQYL7wU3UN1BQwHc6wNa9FyTGrbJqy0/NvLztVOa4TABEbI3mW4?=
 =?us-ascii?Q?Q/ylI4reLE8loD5Xz/N6BmkinJdhP+8IGiA7w4FeYVBb2mi391PFb1cmE95L?=
 =?us-ascii?Q?XHypgOKciORjZ8IaHtl3aq9W1X3uoKMjZQ45pfXp0E1P+zSOGcyBCRo/Gp0Q?=
 =?us-ascii?Q?SYYztjk1UCBh8A+1/K+xezhWLoOB2kgdRhcRht47F4EIV0mwd+a78LMRkdDO?=
 =?us-ascii?Q?CDHB/KZAqeWwAZuM2t4kRtduAAyx4Qkr1qvzn71d4JwTBsjNuBqVxEmqXV0H?=
 =?us-ascii?Q?UuNYJ6QerGOAS1720N1L+ySD0IR3HjG1nAiucZAZmQJNhCESc7OT4cAa4t/0?=
 =?us-ascii?Q?H+CEPpVkcjXCSwJ/cpG96GQHxwAe1MsWI7GPPDQYrlg2mgUCjAgKYCs/WEXn?=
 =?us-ascii?Q?59Cq08tuX7cK/10mu8aiL64Dz9yJjnDnoLMEiKTEYrnkU7xU4Rx8E7iQcJGe?=
 =?us-ascii?Q?IK934GubJREWEibKMf2a1DJJ8UNggn3REh4GzNKBxOnAD+kbB2mOdfgU3pdz?=
 =?us-ascii?Q?KNLbGAZEYy/sS2Fs+JTG0JI7mesCtv4G5jnW4t/LiAI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c716a18-b23c-45f2-97e8-08daf04c20f5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2023 01:11:38.9815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vneLYfr+QgpNVpapY2mtfTLl+CudXkFwvTHLfpQ4sO9EHUyQ5d+Q5HZ+jogck5pQgwYNov/orj4Y1YwwZNm5DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301070008
X-Proofpoint-GUID: qi5VIvYj1dERgzkKt9RaLp9YcLfPmvc7
X-Proofpoint-ORIG-GUID: qi5VIvYj1dERgzkKt9RaLp9YcLfPmvc7
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
> Change demote_free_huge_page to demote_free_hugetlb_folio() and change
> demote_pool_huge_page() pass in a folio.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2bb69b098117..a89728c6987d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3438,12 +3438,12 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	return 0;
>  }
>  
> -static int demote_free_huge_page(struct hstate *h, struct page *page)
> +static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
>  {
> -	int i, nid = page_to_nid(page);
> +	int i, nid = folio_nid(folio);
>  	struct hstate *target_hstate;
> -	struct folio *folio = page_folio(page);
>  	struct page *subpage;
> +	struct folio *subfolio;
>  	int rc = 0;
>  
>  	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
> @@ -3451,18 +3451,18 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
>  	remove_hugetlb_folio_for_demote(h, folio, false);
>  	spin_unlock_irq(&hugetlb_lock);
>  
> -	rc = hugetlb_vmemmap_restore(h, page);
> +	rc = hugetlb_vmemmap_restore(h, &folio->page);
>  	if (rc) {
> -		/* Allocation of vmemmmap failed, we can not demote page */
> +		/* Allocation of vmemmmap failed, we can not demote folio */
>  		spin_lock_irq(&hugetlb_lock);
> -		set_page_refcounted(page);
> -		add_hugetlb_folio(h, page_folio(page), false);
> +		folio_ref_unfreeze(folio, 1);
> +		add_hugetlb_folio(h, folio, false);
>  		return rc;
>  	}
>  
>  	/*
>  	 * Use destroy_compound_hugetlb_folio_for_demote for all huge page
> -	 * sizes as it will not ref count pages.
> +	 * sizes as it will not ref count folios.
>  	 */
>  	destroy_compound_hugetlb_folio_for_demote(folio, huge_page_order(h));
>  
> @@ -3477,15 +3477,15 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
>  	mutex_lock(&target_hstate->resize_lock);
>  	for (i = 0; i < pages_per_huge_page(h);
>  				i += pages_per_huge_page(target_hstate)) {
> -		subpage = nth_page(page, i);
> -		folio = page_folio(subpage);
> +		subpage = folio_page(folio, i);
> +		subfolio = page_folio(subpage);

No problems with the code, but I am not in love with the name subfolio.
I know it is patterned after 'subpage'.  For better or worse, the term
subpage is used throughout the kernel.  This would be the first usage of
the term 'subfolio'.

Matthew do you have any comments on the naming?  It is local to hugetlb,
but I would hate to see use of the term subfolio based on its introduction
here.
-- 
Mike Kravetz


>  		if (hstate_is_gigantic(target_hstate))
> -			prep_compound_gigantic_folio_for_demote(folio,
> +			prep_compound_gigantic_folio_for_demote(subfolio,
>  							target_hstate->order);
>  		else
>  			prep_compound_page(subpage, target_hstate->order);
> -		set_page_private(subpage, 0);
> -		prep_new_hugetlb_folio(target_hstate, folio, nid);
> +		folio_change_private(subfolio, NULL);
> +		prep_new_hugetlb_folio(target_hstate, subfolio, nid);
>  		free_huge_page(subpage);
>  	}
>  	mutex_unlock(&target_hstate->resize_lock);
> 
