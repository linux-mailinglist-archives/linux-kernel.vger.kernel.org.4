Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61074A786
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjGFXWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjGFXWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:22:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C91BC3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 16:22:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366Ls7re001701;
        Thu, 6 Jul 2023 23:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=WOJoYpIaUduKyF7OvcxpDOgaqYTi+r4pSDEQgG8EqGU=;
 b=OA5HaQjxAT6bv+VbyRhvg3NbjGAgpuqWK9p9IwFiiRZNx7veL/FcMvPo8iOluswXfbwp
 o4ckvhgjTQypxBTqdpoz3WQcG8CmhQ9sm+IkWz1kUrzXMUojq8pyzcqXNlKSPaGLsgAN
 pu72L77Zyjybc5UYrjL0K5utdPFAFzVISGxP6yAqDyB7mF1DeptbuU1tFM2Nv4kNwRt7
 hlFXAPjePcOQa2Xp1bPufCrLjJM922Vo1sUv7m4Q9GXxVdL+xNAmc89aSbqhXxJAWa+Q
 D8JKZrtm+t5v8ETb/LI6qyXqqOP38u6DKkCsOObz4o3VFbSgOXa8D09MgEy60ni/n5VA NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rp4md87j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 23:22:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366NBbac033353;
        Thu, 6 Jul 2023 23:22:12 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak7wbub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 23:22:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/IP45VFlsYLf2vMC9Pejn1VX4dcI+ksnEa6ygqgVaCeidbkzKXgBLfR9Ef9aC/9E6P1cW8OhivGPEDJNQEbXxTdzcHHB0/NlNGfMRyEedueP5wPwQ9+s0kq6omTjYaZ7mXZlIU5wFnSPiypVJsj9+eYm2zo95E1fMydOercHwQoNCoO3N3JbQ6X+Pj6NcAgFJQe8lmpXixZYFlGK0YWRntmV263g4tet4S2PCwntnON/QdA3lqrt63LHBocr12hSpOX6mPBBdpHY00JmABjcTCbCsC8S4m8Y0MfbhWwhtCKVkjv4wvjyCGYeLoY3R2zS4mXGZeoBTqOceU18iVoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOJoYpIaUduKyF7OvcxpDOgaqYTi+r4pSDEQgG8EqGU=;
 b=Kh3wezXw8DzfCdlmmYthLyYzk0JUutY00mMr7YXzLLn1FckuQiCm+I+zptl91FQ68gl247hnlqqjGdLuQqmbd5IRiwJPQtnuEgJdDjShjgreCQY3Awl2tYS53dgUZ2cG2HjoHa9ClSf/P4QLL9dSmTdC0MJXk34OaHNvEtDkUNL7Ts82n1IoanEqI7H0ZVrbAzeQezQ02JYY+l8safgxbVUvWmBzyd8K3bMl6xwCX3hmcGzGk/WlzzKe1nWrpLsRZjzop/Qs/+SoiAW/U+2vyw0YXIvutthXjvaDcbYuTGrxmTPHx7Wzk1c5Q4AEqX0CEhH2VJkuj3iU4DBE4mhiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOJoYpIaUduKyF7OvcxpDOgaqYTi+r4pSDEQgG8EqGU=;
 b=gkmUzxe2ZFBM4AMBmFtsVC7j6zW9Lp3VE5eD8btOqurC4t/qiqzLJqHUJcx1PcOKY2pDMMkAXSe8cdXSkInqZ7/zFMe0a8Sn/P9mqnBdSwL7UUDWSqYdvA3AZ8gqbzyoEVNxWTMbrI3cULRbnrwjcwkTUkD0RaTZ5uStT44zPdA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB6199.namprd10.prod.outlook.com (2603:10b6:8:c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 23:22:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 23:22:10 +0000
Date:   Thu, 6 Jul 2023 16:22:07 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 4/4] selftests/mm: add tests for HWPOISON hugetlbfs
 read
Message-ID: <20230706232207.GC3768@monkey>
References: <20230623164015.3431990-1-jiaqiyan@google.com>
 <20230623164015.3431990-5-jiaqiyan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623164015.3431990-5-jiaqiyan@google.com>
X-ClientProxiedBy: MW4PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:303:8c::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 028c6114-302f-4539-1931-08db7e77d281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRBn5jzI2rUunTVp5oK80e+n/Y/dtzL/zY9PjtQrNXLAFLNyK12LBixvnLF1N4PJ0cJiBm2p8l9BuiHVmfqBLFJ/kLHh6OjTOd9Er/qaUSzE/7gGuzchQeUGB69BASmeJogWoHZuzcbDcTFO1GsIjP1LtYPDL4TrIslWkFCwWK7YvYHu2iu2UGvSyTI9dIR5iUubvGdRM0aUFYt4j4e0VcRbK7TP5CpIu733ySrv0/xBgB9hj60qp4cEAvdDf1wZvjIYdYaM2w65eUScNMccMYvORnN1FrPH7EAJkkY74CcYeyO4m8PSN34Asl4mJRY8UsfZJKXwAnunglb3GrBomBbYmsOl30TW2zix9VjgcTj+JJQOtDjfcIWt+2PFmps8f3M8Fy32LUZLDkhtl+FV7IbxsnHC1Bc4F/+epYMe0LvgvMJqVCP9k12HJ4CUQq1r1eZ4WObU3NJRmEobEtZofL36dCK8JUFkp77Huw/aHY5uwoZZUJLspF3pXiOLRwp5461lYKTNPojudjdqNyXwgzPVzavthZaW8MSp6/4F2dxJ7GVf1GeoUhNIRNC4wLqD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(66556008)(6486002)(8936002)(478600001)(41300700001)(4326008)(8676002)(66476007)(66946007)(6916009)(316002)(6666004)(38100700002)(186003)(6506007)(6512007)(53546011)(1076003)(26005)(9686003)(33716001)(44832011)(4744005)(5660300002)(2906002)(33656002)(86362001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OQqYpK8+nwb7X5Q6t5lTalIAODJ33P2FzeiZy3QYUwT+7+x42mAduCyMDyHd?=
 =?us-ascii?Q?6zH3zjOtXeEhq+sQ1oZM0RqNRLAC8DTCBgsC1LC9EMtxPzxa050fgOc4sgwr?=
 =?us-ascii?Q?juWhNThBhohVJrAescKWcKgFV70GLANaEg3uz13XZHIepPbeNezGK6eAFBEp?=
 =?us-ascii?Q?mPIp9zr/K2rKJWwh1hBne65o4mDcv2AXC2AhBtH1TauU2//SzbiDLYeeipMO?=
 =?us-ascii?Q?XSESgTa6cZ51Pw/4bu5YEBcaZqtDnwBDIEmjn1WqsRbKb4G8mDBI8MCx8Mgv?=
 =?us-ascii?Q?2hD//uFBSEEh7n6x0uFPgtHOIoZ2oCX2t5troM/xzgnltjGy6rXIx+oSXXYY?=
 =?us-ascii?Q?wH30YzwXf1lehHTuYOBuTPB0GZTKjVFq635YpEKp7ARUpYHoyeXn8OMaJTog?=
 =?us-ascii?Q?71mt0jLMOi40AfWtY3F7JPOF/qVWSfSDFzqOkp3xggR/+U8wXfg/N9Gt/kju?=
 =?us-ascii?Q?DBMwaFJEhCMD+zeR3NBZZS0L97ay3smn9/ysXQb9q/CPsKNUC/L29bD41/pO?=
 =?us-ascii?Q?A7Zopoe7BLpvsRq6Plh18fT/HgoEeVZAqQ7sjklVHxKVj9HqmIm6L3fH6800?=
 =?us-ascii?Q?ZtplsC0oQWYfp6YuKzGOkyt6mv/qOSXFJOV26UwegD+84u16rUAw/FSic3fh?=
 =?us-ascii?Q?77N5USvN0rEos/Hw6xtF+sEqqIgRdSrrwNw/CG4UVz9ZXK7/V55UgVmLO+tV?=
 =?us-ascii?Q?rtO747sVpJdZVbgbCPIUNI/A9Xwez7tM4lGyIVqPlBWiOcKfkyUOEIcMPdqi?=
 =?us-ascii?Q?mO1IOBfOokMPkd39wvPOqzEPHkwv5KJBz+jeAJ5wGysPD95ka2qaSEBENpwF?=
 =?us-ascii?Q?FiZ0HjQXbHIELrA/yHtYQL9/yuxsF4jOdTS71SlSUrRckQ0xkFmzJ3pnYpMK?=
 =?us-ascii?Q?SkeiuJYa5hp/4wCJ8Ekd4+mErArNOk7ZOesmK4nWpxWrOp9KMxTHXKCoM4pN?=
 =?us-ascii?Q?rAY6cS5WGUmbM6dhoGFj90RWisrQgOpsRqZnlNQfOtu32wCxra1Mt4rB3PXu?=
 =?us-ascii?Q?HiEuglrFxlV41z2HwpIGyLB5z/zEimkUTSyG1cUAureU0DGNu4WqwA7mIAoI?=
 =?us-ascii?Q?CZP+DvWMDBqmxSC+ppsvBVDj2ZVIeNnba8D/fS/tbo/DQtGT5MDaKsexITnS?=
 =?us-ascii?Q?AbKradDW3zdAC9Dq9pEMl7OjyEkZjacl49ggm263BOePW4cGq/aUoAZLD49z?=
 =?us-ascii?Q?dyKCCmoQbkQ4b31b1Zm01Pvs520st2f6VTSAkgciTWlZs7BPNWaGZzPaHC41?=
 =?us-ascii?Q?THgEdYsxNn4iJT832M+6EFONBki72kxjwxh3juxIVQZGnzNHw5rVNwUvHVsB?=
 =?us-ascii?Q?H+r9am/ADEqwE97Y3WRTtQAIJnAZ49N1Zx/rJma8WbEvkCBv6WY7mPSi16h3?=
 =?us-ascii?Q?uGwXBQ2Eoq8dkiMXSQQkgbuOyYd3xtIC5nTXgTIi/ZO/xmJQCzAlDXfV7iaR?=
 =?us-ascii?Q?YaFBmi7h494MYnDmE5/zihOLF3fi31hZ67t/BsfcO/TeUZM4BH2WyUUthtG2?=
 =?us-ascii?Q?3CiEWgFH4tJZdBTQV3oCpJt5znqygOuSivJlFEixq0h0WYN8HgVXpD9Z3DXR?=
 =?us-ascii?Q?JaTjGdNgNyYcPWae9r1oUhK1peN8rFG1p30/C8tKK7FanESbB10ds18eyHDl?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0lsJo17jltb04jvL1op9ZavrZ2fq69gXJiONq5GYOk9uhtmREPlcPh3B14Zv?=
 =?us-ascii?Q?MWzyGsAdGnQ6eqJiY4c551URsTbFwCbf5ytdiZxOn0EztSSgtoLOUnmcIVof?=
 =?us-ascii?Q?U2NQ35t3ZYiEW6kulrfwtVbGyoClg1Z1GVs1zTU219skaUXIAV7nCGIbqqel?=
 =?us-ascii?Q?Ae6HDjShMb8YiXKfBHZtnGUgb34ZoIyOEnetwThGnlX2VmUViZqwVqmEZ/vR?=
 =?us-ascii?Q?ccPplhIrOTSE2+ss4mDLjzrI+24tizJD4WWg8SG3e8Qe7bbIYIDg0uOY7ipr?=
 =?us-ascii?Q?PQf3RN4+tIApW7d+U/bjpfpUNH+Stvht+DHlkMaR2Kv3S3nvcnjmZb2a9TFk?=
 =?us-ascii?Q?AnTvks1g0zH73odQ+EV/oUw2jmV8o71xYKjVT7Cpm4Go5guw3SJxRdhuoJOM?=
 =?us-ascii?Q?Y73iQdQFDkFqfzPVJGXoRM4vWimXjcIWnb/orKLvSM7J9ZjoO1Kvv+aF3BY2?=
 =?us-ascii?Q?ZnonjIyk07jYMJdWGsWPhDjZA7vy6FJvCui2aQoabP8b77IGLvMe65q4GHB8?=
 =?us-ascii?Q?1Pbc619OYUoKLmELGzdFb1bHMEUrkS6ZCAaOhZ9lniokkGVhnemz8Mj+Tgwk?=
 =?us-ascii?Q?IdnMqfM3ZqnGG4ZZJBedDoyAqHeY5iaBlEq9/CmEThtYtMTH8inYVvRGREgZ?=
 =?us-ascii?Q?SVRAfIORyjTSBXsEWEQsf0hF1yc8IleOMHCmOBBOXDKDE69W4ieH+a7mil/t?=
 =?us-ascii?Q?x91IfdkcbAlzl3bTgP99vZghLJmzeR6qcEZHdmFwdNsMKCnIJzru6EjiBKvF?=
 =?us-ascii?Q?EsDDYqwTYqzM+Xqfd87K/9ytRvnXC6tJwni8EzfmabDHfwaKtwSEPqP61sBk?=
 =?us-ascii?Q?kZd+GXEH1sc3pU2AvwGFZWrDJc2X6C5Ljvmn/KP/xC84TrWgDUodBv0LWDnl?=
 =?us-ascii?Q?v9bPyOOT/x/5rHyRurzzJM6d2qyh1XUy+WQ01McwYIs12GNroX/nm7hdu6o9?=
 =?us-ascii?Q?53BQqsS14hEwqOd87o8uG0VaK61kFbDCOMmadb2j4uI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028c6114-302f-4539-1931-08db7e77d281
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 23:22:10.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyoqGPBQdb/sBPkv8Lo8iChxNOMJxc5U+OBhf5k/qeR2jQd3eYQbFz/me37Ww7PB9AuOVhoYXENsix6QbEW9wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060204
X-Proofpoint-GUID: VB39SPZGEbmRcNxtv-fGtA6dsGhd4EQh
X-Proofpoint-ORIG-GUID: VB39SPZGEbmRcNxtv-fGtA6dsGhd4EQh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/23 16:40, Jiaqi Yan wrote:
> Add tests for the improvement made to read operation on HWPOISON
> hugetlb page with different read granularities. For each chunk size,
> three read scenarios are tested:
> 1. Simple regression test on read without HWPOISON.
> 2. Sequential read page by page should succeed until encounters the 1st
>    raw HWPOISON subpage.
> 3. After skip raw HWPOISON subpage by lseek, read()s always succeed.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  tools/testing/selftests/mm/.gitignore         |   1 +
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../selftests/mm/hugetlb-read-hwpoison.c      | 322 ++++++++++++++++++
>  3 files changed, 324 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c

Thank you for adding a selftest!

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
