Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3E364380E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiLEW0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiLEW0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:26:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A655D10544
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:26:01 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5KOYkG031530;
        Mon, 5 Dec 2022 22:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=lyUuSNLRG2DHG/zPBgkWXW3BaCIhDogHnb+F51ArlaU=;
 b=pQfPRO19yW7eNKf1wpQseSu9FYBnWzBqPYfDP57voWeyNSdBENO8IxFmD9qr2XD/TSK4
 ZwQm8NXRhEM0AXvFSRudHs1aAIhKK9pEGbR+AMAM/zSfe4ADClVPlcWzis6xCZGt3JB0
 LdaVv9Q0FnoxGg+EaAXksmeIDRAbkpcZ4KgOuCpX06RQh1hwBb6zIDj2hLAnKTbhr8Xs
 UPlEI3LPz0aYVhSwvQEDoJZWjg9/iN9Sy+nPg0hP2HM/f0w1q0gD1HiSRpO08jMNeAZ+
 YfhCyNCvnG71R9/2JURSpny7zISKR0t4jR3CdI4SPgIMZBByrAIA4AqpxusZDhBi8O5C kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yb3dbfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 22:23:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5L7FqK018775;
        Mon, 5 Dec 2022 22:23:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m8u9ymtp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 22:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8kXtWYzeCkYlRFxm341xlF4mfMlzRRF+Q4mTB5JCnlgHI52OO1a202cnfl5/AVdTuEIt1870Z7YTGqys9KvhZ4W+QIGSJXN9Qy2NDu9z+KEeAtmjN9EQ/gsf5tNj7XiOR/OwLRxGMXb/Xe8y8KfCUhtkFQQwlYoe9n7AqNV1VBGIWQVTZaSubIVZnq16FXl4uGFKzaS/nRTXm5Q8ngWLngXqcPHx/QPCzPbnx5xRTAjT/e51rOWRbvfvrrJH6OExRAFu0mKzjux77XzAaHvXebb4HQ5U9CpwayTgIbrFyNfu5WGGOixFD7N63WV61xevtwCTZHKAoLMGt3iZyCTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyUuSNLRG2DHG/zPBgkWXW3BaCIhDogHnb+F51ArlaU=;
 b=ZvaQfe4++iTXzIyZWXGRTeqDMNpoPk8F2efzeYPQpod/IBcXInXUPNavasZNup1AFeSsNTs6fZSxJMt+N4h9KNHIxwVrVv+AzAsDYlfctGlq1lePR6QsWR+HnvrTeJn4eFft2CtruqePnd9oJQnqKI3sFfxxKiCxSSuhAfucqTrFEUx5Bb8sldowzh4WkK8BRHFJoh2mb9kL5/DVQtAj9ZhgkLAHSZssff1vgBPKtxZedw8i+m35nL78kQ0BoM5BEMJJ0MPTXPxWmGnrE7hSYL4KGzGdNHioyLNWH1WZde5CaC0kavn1B5z8wpCqzd8Oj4jpza5TJr4/JzgarBLJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyUuSNLRG2DHG/zPBgkWXW3BaCIhDogHnb+F51ArlaU=;
 b=cseDPq07DOeKBlK0Ah/XqpNyhP07FUPy17dK1fen5iodX1NcFXHovj8EcRIN2G0ig99IQ8mBBa3NC0SnSOnglBtXrjqfRYuM1XhEt2bMtbMRrjuvIjqb2/ezX8FPx0pdOIFnoD04+00q253Cf4Eaa0s0qnq36mPZOKWRPRUtCMI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4632.namprd10.prod.outlook.com (2603:10b6:510:34::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 22:23:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 22:23:40 +0000
Date:   Mon, 5 Dec 2022 14:23:37 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 05/10] mm/hugetlb: Make userfaultfd_huge_must_wait() safe
 to pmd unshare
Message-ID: <Y45vab2k+S4DN1vd@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-6-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193526.3588187-6-peterx@redhat.com>
X-ClientProxiedBy: MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c887081-d43d-43c0-c9d1-08dad70f5c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vDwghdcISQBdlbwJHm62xoKmiyLHOflIVSufT5oLdl6U+/OrktdvX8OR0TRqc+CgTHYTmk2fFmM+rUJFCCV8QUBJjGIO0HmXI6grUaTcIriTqapCJ8uVrVYMF1PcoNjquhQeYrENaszvrNfgaWdgJ4uT8+g7Ct2dDrPAcwYFgPQ1Ndi1DVtGtsexGayBxfMyYVApWfTS0p4mGRztlCgjDD3HlYu8boZh7cEW7itfoO5Phaqw44lFPcWDgzMexgXHAVLnKhvZ1rlPJE05vSdPCCQGbMjTtZsJMQkXYVPdhxt36vXRjPlhtBveGaB4LyYLef4NKqQ/+pM8nnF1d+jeLdcTM39b9NsIYDiZDWHLfx9tlEZYMdkQLT1MPkjllYBnA+8p4yojIyNPVAzd6RoiEUAfT+J+Di8Y1Djjw+cvUbhZk5pA0iA0Go1/2qmVXMEn8mAhTPdDHovlW0BjsMzt3O1ywv5fmOvoUlfShWaf0M5AvHXUGkjenbiE9HK3IbFclg2xG174Fs/DR0R4J3R+AfXLDqaRW0TdndnXp65+YdQJCTx1KsCiHKMLXPE9WSppAPhwQc5AOzE2NZuqi3CCKENXxIrvBR71m+vJCGw9cy0RW58Iat1v6klMJpeRfFdcutNzj7UUpzH3X61g9KVL8saBdk16/rDYv7GoHUmh7NXbwnoCYBX31RtX0D2SdMURS0X6xrEsOKVvMMhayWZ4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(33716001)(6512007)(86362001)(6506007)(53546011)(6486002)(478600001)(186003)(83380400001)(38100700002)(6666004)(7416002)(4326008)(8936002)(5660300002)(8676002)(41300700001)(66946007)(44832011)(26005)(9686003)(66556008)(4744005)(66476007)(54906003)(6916009)(316002)(2906002)(14583001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WlFq06T4gmdvR1r9vGy2nshvZcB/xXTScRQ0uOTTPDHN1sCenuSNyoAIjYQg?=
 =?us-ascii?Q?SnzdRHTkr36h3QJh5jMpeH0EZMSQ/levHXTk0OgXNs/r0aPTB5bYW332B1dU?=
 =?us-ascii?Q?8xuUIwJAOMDyN24a1x6PmNd+uhq/MRerz2sRhlgdFF1gtbWZ9IM4hMP7G3wz?=
 =?us-ascii?Q?dkR4mC3nEjgeHggGLmRCLd5pc7BQ/gcc0O0axp8XpAg7FfA6m0EWZS4oPUCS?=
 =?us-ascii?Q?+4y19dHJxwcR0J9brjnaPG5LB8UdxNDFARVWxHwOpEZYR20dsfy9ybx5tpSS?=
 =?us-ascii?Q?Z5gc7vrol6OzairAMkg0e4zGLG3QG154O+6t+1ghI1tMooII3YEsYP3OKVpJ?=
 =?us-ascii?Q?X+lD5lvAXuc8fBKJb30RC2Pys2FVYVj0+U9e562H0vZ3hSxqOBYuaIh2wbEm?=
 =?us-ascii?Q?A+lSnNFp60MFLyfLU4XkIrd8Uz3uYbLtJqPlUH2pQlke8aiDRkfqrMXVst+F?=
 =?us-ascii?Q?A4An7tE1D+O5/SLGRbGkbQqW/zqiVus9RUBbqPVB6nrX5MFNi69qY2XTajTv?=
 =?us-ascii?Q?yvSu0ygWHDLkqAUArwluXjKx801eZEkv8HX3AWuw89DjsD1iarP77YbhdusJ?=
 =?us-ascii?Q?Ay/GuCdN0A0puB6WPkfa0M7UZH/cwrZk+qo8A5OmP53CWvlrwxUZwms0qLo8?=
 =?us-ascii?Q?yMub5DfAaZKuDqPcKBggPfKvyFe+h2iLpQePiu2C19klDq1gLO+m2FYr8/lb?=
 =?us-ascii?Q?XATP9z0MCzItHkbmWLDa8hnxZuiw3313giydldHiezVYd3imgg6mzwjaM8Ww?=
 =?us-ascii?Q?+qZoxIlvCVFAHUv1SRzrbixUEVzeA69ibtJx2dj/f1g3YRcCq0YmjGLcD2h9?=
 =?us-ascii?Q?mSdT5A5jcuUiQFJ8vDUsWD0bWS0mkdBNxqeIirsOkZC5mzYqZfGfY5RMDGj/?=
 =?us-ascii?Q?srcAc73GreX1ar70qg328FWDWhvKIG4ktFrF3Rv64Ow+qd4ieCi8Efe2622X?=
 =?us-ascii?Q?N2ugzkG7PUuNIp98JOWLlL7wlOMzPMVWva6l43QQ9POZ2NPdSohwz9z0Cp4U?=
 =?us-ascii?Q?9eRyd/qUIbNPfmYMHCuHNmTPxWBFcZd+CJyI2UMxx2yZZIRzOtzejin2oalK?=
 =?us-ascii?Q?kscPPNzO/OrRwmaiQkFx8QzMQK9ZHZQ0kIffpUp30WHMoYJ7+u0Q7K7+wiTR?=
 =?us-ascii?Q?ksb3gpxufHKb+9A/wTpuH/lkuz4Lpb/jJD+h5vi4IuOtaIqm/t8oFYFPRf6+?=
 =?us-ascii?Q?uERPJAa9HqerBgCMHxh7xVBjQRirzs2Fvgix8gg2bblDn+MekevTT+8N5KYq?=
 =?us-ascii?Q?uGvWmTtnYfhsah8A+L9zPni3gIMCn3o2LwAir+rfTr1gkbS6SyQ91JoBPHbm?=
 =?us-ascii?Q?nffGL4IjxPgXCxXrXRMDLdytyA62nOIh08KbynU3EjQ/BCBqqEoqh9FpyaK8?=
 =?us-ascii?Q?ooDclUtu+816tQy2PPkH+JJy3/n/76Kyi+D/w/NkbsA2Q84D47hm7KjT6Zi/?=
 =?us-ascii?Q?Q8Zloa7HKEZfIRc5QUs8MO4Ly7pPyW7LiCPQA0t3qlFaiEXE1pM36pJrYCiu?=
 =?us-ascii?Q?taEo96wY3Bp793abaUAlKWabhmohTGfq5n7vzWBknW5pU+Bbwr70Ol8se3A3?=
 =?us-ascii?Q?fZUrzuWNOe4ST7V+Iyabfjg9lgjPCLbrQjIoFYcNDH5Ek4NpzLREea9rT5FB?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ds+KxYrxEVL/kjGNf3+I9jRSuV0MMJEpX6IPxRkutIlPofAIQTPEepuOF1xB?=
 =?us-ascii?Q?TfUD+ujI8lm6EOUn1tci/7V9gEleSrdCRjNGoQJ8cMiWHEVkyZa4m1s5Yj+E?=
 =?us-ascii?Q?QLHNlRYJhegjBvFcU1ttU5n/KWDIl5UNNPo9FGSeEbHk5MGcS8u3ozgzQytc?=
 =?us-ascii?Q?uj5xD5FmR3P7EDdv/kVDGfuhcvOFNu78+UhUqlOgPYGEF5ERdHhmfAVq8NG2?=
 =?us-ascii?Q?/hV+TmCKldAxOActLyhP+61yIxiexJ0SABSijbgQ4MyC3mGkafX3rarlI9JB?=
 =?us-ascii?Q?je1engnDu5ZBVYFP1iHobRLsDNK90i4N6vm4NUDvM6imw8mvqggM186AGkn1?=
 =?us-ascii?Q?W+DZfgBwghgfP/lGpVXgn8Ed2jibUOPzdJdEGAfLHkuZA4fPaIBbs0H7XyCo?=
 =?us-ascii?Q?3uBDgEIj/kzPIlJrPRbN0EOoSiEzvBTkfonmnAZ/Cp1Y16NP/yPvoYU2eHS2?=
 =?us-ascii?Q?jlHGAZ1sdN4NwQZU4IcOPqaEjcRFcsOgAYsZcTEQ7YT6FKmswnlvqdPRpcnF?=
 =?us-ascii?Q?7/XsebEF6gBZ3HuoFdhYuhbQAJSLdu/ex/K+z092p6IvJSuZeyHa7YgOogg0?=
 =?us-ascii?Q?IzVXFkJdrBXcylf78dh9wHijXuLljgKUdpJxI3LGwIW19Ipi3eJj5lPskq1e?=
 =?us-ascii?Q?7Rqx4Xfns0XZHtfwdueF5ppeKE9qViZ9tDan5X0CLyucJAoql5s7crA7+lO1?=
 =?us-ascii?Q?xyWQOXLJuvMrQeMdMUl1xl/365Lc7BBi0SK3svOj3D2cKk3rEQu83xQURox/?=
 =?us-ascii?Q?svKFZnGjVRHIQzQdHldFQpTXL5XGfrZnSPzLqpV3zIzgntgWSbDY17KFJ388?=
 =?us-ascii?Q?Hafvw9w1GilPLV4+0vtr/jBFKJ9upbAhBhsYFe6+0AYKm3F1mLkIXeWRPyhR?=
 =?us-ascii?Q?OmP5+xDzcpspXVALIwkfKL5XSvGXQDGqkdutnrISCUNVJbtSGFda6UsVphoc?=
 =?us-ascii?Q?6EsoEFHrTHGoNWp3NOyDJWkzrdCBECyKS5RcUBF3SXHpjKYyTEFKmq2Wsc6E?=
 =?us-ascii?Q?lMBlZwLAcIlnt5hz84xvFEQqjAzqr1ql1IKob4nRNpNU1dHEj/FvbYU7LXZ6?=
 =?us-ascii?Q?DRhhB7F5kmqp0Y9F7Ezor647qe4ivTIXWJwSracNZTZ5cj7PsB8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c887081-d43d-43c0-c9d1-08dad70f5c53
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 22:23:40.0603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJmUeq8ZIiEeGd4CdgiTWT/QGmWfEpsp5R/v0SvHPYyU0J7FzDS6+AvWw25kOks+OJF8zLfWgz+dN4fXUTr7wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050185
X-Proofpoint-ORIG-GUID: DnN8UapDRJ_G3FfN-M8inNoNdbJsSGow
X-Proofpoint-GUID: DnN8UapDRJ_G3FfN-M8inNoNdbJsSGow
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:35, Peter Xu wrote:
> We can take the hugetlb walker lock, here taking vma lock directly.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

Looks good.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
