Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3066F8BBE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjEEV7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjEEV66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:58:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453554ED2;
        Fri,  5 May 2023 14:58:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhMh0003021;
        Fri, 5 May 2023 21:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=BRBQnDDddLfCjbcbkKLQMn/lub96IJfv07J04va9bpY=;
 b=u/hvYcQ/wmvbkwrpMIF5sTQIPXfbwBFWcaG+qiXimIWI9hREjVXlYYCmZB+tYt5venRe
 ZCWm+ugN8OjAzWhWXzNraG6UgyYiQABkY+KTCLKoWBeWnQOE8jCsfcFAHw4XPZoBxpIj
 8jvecNJzTMEHbs5SrLanV1Cew9ExZU3dFpBGqdzG4/LlZopa/6HnGBzEKXN2JDYMInyQ
 tY+hP8Lqogjk0/Cqc2T8kUN8/8PLRuVxL9O6alHklcAkmc7PGp5rWaVj1P0znA2SYrDL
 VDw+7k8UfnCNqAZTyVqva9XOU0AoCcYTvx9ZH6inn7IICKEZyojnDYwnkBfpe7YB4e+1 Sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburge042-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 21:58:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345Knh0p020798;
        Fri, 5 May 2023 21:58:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spacxyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 21:58:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS9OqaRr5dHRGwY5tAMVPd/DOH2CA3SSqX3C7gZUnoSlKnO9OpHxqHyF4Pkq1aFV/vg19tGOByUBotlCg0zY9aBxOKF6f+QUIy1UyPU/k8tElXz7xyIJt4tmMoGrEf3no9Pi3mUdcrp2Ad3vGhYvViom3i1OoP3oFWbt3oA5USG/4DE1f3PRROs0gRmPnlOl7X8I9DetNnDD0cHW/wb+qx8uEfSV5Cj9glgjEjimZ8raUqSpB63bo7YiLQEpPB4iThXH4lYodMwb7eWXZGJWAPYrxfTxMP2bwnDr8DjaOy7+TKxEqklfvCFRKY5DR3HZephrUrBZs+voVlL9NfTUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRBQnDDddLfCjbcbkKLQMn/lub96IJfv07J04va9bpY=;
 b=agJA/EC5L5SO8gKmX7dX8FEqLKos0dCPYzyDvlI2N/GobP+z591yusDuF+E7IIItVpApQq4QER1ITelQbndY0nK7ck3pKId4EWpe/6qCOz0mJXEmdlDCPH/vtjONP4I9zLnKQVlrWrOXjL4HTgyXN9sVoDK3VbkabGdIxojJDoLixjjnyNYs2qA/Pyqh2WXW3rgwOCUislxWyjW/vO3QkBVmtgLWeRQh2UaCnFAya6zcnYb+JMnDt53ohLCWtUIIaY/lyf6ew1mGl2e4tb4yXLqwt7TmUMK6frpieNQV72s1n0rswYzJzusruNHJX4qSvdkVt0bW63daG/qpsejgKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRBQnDDddLfCjbcbkKLQMn/lub96IJfv07J04va9bpY=;
 b=bbCU4t+wVVJFtlS1qtduWqbuEwpngoBdF1PM2KXIlTfVLl5OCZbywvkJedN7sduaJp6A8dYJkRQ8yb6n0FRAM6/rhzCKC+3GO4F8+jE5Yg2XaaKc4JsIhj00ZE5HNLGqr+/m98wi0K/7DgCCNPgZjuspT0nDGp9yBX8tdrvrwr8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5104.namprd10.prod.outlook.com (2603:10b6:5:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 21:58:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 21:58:10 +0000
Date:   Fri, 5 May 2023 14:58:06 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, ackerleytng@google.com, vannapurve@google.com,
        erdemaktas@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: revert use of page_cache_next_miss()
Message-ID: <20230505215806.GA3497@monkey>
References: <20230504233858.103068-1-mike.kravetz@oracle.com>
 <20230505185301.534259-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505185301.534259-1-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 84cf5695-edd1-4d42-c6b3-08db4db3d0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXW3MKPqRwMaC6ST8lQCGMjF10zGcfE6gvpQ70yq9UvS1DJKS+xCTdaQmiwinHa4vFXLnHDa3S6MHmD0fjcNscmLKRvofxW+lr82joU9tVrSyjzlbYhNNDfSOYiL9x/HjHIUkOmmzl6O2S0wdc9mnPK7n7xlN8A6OLPwxxmjUB2Q8smUmLgf2OImVgSJg2Yjz1nIc6XuwWmGW7lcit3K3P0J+G7hZEL00Wrn6rtZwiAi4XzMarm25vKe5I1q1Bq9wI4Lb+/nHa36JPdAYUrBdLwiOGKL+5a0yQ0m6KvdevfGsCi+ymfc2Q8jkGEkixwo9eLeItRmN5CnWW9G4q09+N84j0h6NjaUWZMkGTbZxrP0hoPW5qvSoWkTvuRNESbEA4+Hxj213b9bvKGpAmCuhqmYUiYgSgaTFLHWrg73ezqf43XCjweaCTeB7T3no25iZdusxc7Fpm3jxY2Dy+btsr/7WNq5wmiywec/jrWK48wgX4CC1RNQ0sdOceCcC6ZLGD8vTij5IUf00L2Jwf/tndnElaabuCI8p4Mmzc/r2hI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(6666004)(33656002)(86362001)(478600001)(316002)(66946007)(66556008)(66476007)(6636002)(4326008)(6486002)(966005)(33716001)(8676002)(6862004)(8936002)(5660300002)(2906002)(44832011)(41300700001)(186003)(38100700002)(6506007)(9686003)(1076003)(6512007)(26005)(53546011)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8g5ZojZ8v/0WSDddnyh2AnxjqdoNMTSXSwbVd3rZrGX0ppEGVRHOzzj4KgWn?=
 =?us-ascii?Q?o6HFPPJSPHky2UGG18TxiNRVxy5okuWIIwKkO7EXE9HtgakoYTViaeJklX81?=
 =?us-ascii?Q?x/IOXYwA3Dx3iKsTlB8RXuQVl2RBBhitXn0WRDhrH4GJ4AiVJfiEnJFSOITw?=
 =?us-ascii?Q?+IzMqMjQF5OFyuvqtpg5Ur0oXRHN+MBFH4KP4qmVyg6togHBgCJyp4VPuIwD?=
 =?us-ascii?Q?6bMQ03GoRoCyAt8FInW83DZL5t+8Awggf2+ozH8HX/okpiymfppB2KAlmop2?=
 =?us-ascii?Q?SU6nKCNn9VYZqLqzUGRpZIn61xJ5Wv9bibBJdTXLtmsbnbB6b1JQFXLx0aNo?=
 =?us-ascii?Q?kNgjplcm+63ex431izcDZLlXsedccnewyYbDUAWrWeDLV9dGpXWJ9G8OYrOL?=
 =?us-ascii?Q?u/bhtiQ2YUPmKuBgAvCTdsJj38DgvXvyUxMpeV5AA0LSwtfMD3L8/aKn/fHE?=
 =?us-ascii?Q?avTspT8yDQKeRYUKZ1y6fmwpFSrbOMxUd5EFYfsqxL3qnRs5NvJ+QAjU0V64?=
 =?us-ascii?Q?lobu8oxUUtQwOPuXciFaz8MjgtAulgHtp2QgBUmoUj10GvR+JS3snCQ6DFMg?=
 =?us-ascii?Q?yG/6lXuoH/9Ssr2fOArglmCCJi2A3ooyIU3evgtfnoRXNt3QdWDw0arvxR/7?=
 =?us-ascii?Q?epENpgIUR9AiS46h4P504dpazm8EVdHKztJdxlLGrbx1Xh2J46zYI6ckpo8B?=
 =?us-ascii?Q?YWHmr/AdoFae1cWXCYnYKeGWjfmSx+WpguajkgTqjiHg9oZmdBTY0swYTcX/?=
 =?us-ascii?Q?zsGvEs8VhaytesNCTFoowLEBSCZutERSTpXZ0ExvoCXzvWjxGOPCC/ojGVMI?=
 =?us-ascii?Q?3ZdztvXMZpi+FTulIsYn7kB0ZgtTK6X0+3RsFk+h2FKzeua/DfoQ4R6s2ohP?=
 =?us-ascii?Q?nWi8sH7DH7N+bhis9q1dpJLbUH1Dw5dTBeNgkYx2XTUvds0iy+1PV/GBV1qw?=
 =?us-ascii?Q?6SsIJVWTbbullC/bhXrkyIbKg5iUot7mh1RJjVlt94tiJIrdXO51emTADCZN?=
 =?us-ascii?Q?Awjh/SBXHpav4OMhxPr7BDbA6fKDUT1CgHNjv8v1lXExUmEhiu9ZfFSLrMUO?=
 =?us-ascii?Q?nGcUsWbDkKQiWqVL6VFyupqwGiLM25zvKxSov6dcFv8t0XXgdqZZNrXjrBlO?=
 =?us-ascii?Q?ZdnbFbKmwckkYIoOHDe9J4EoyCsxZ4ZtKpO5b3X5Z/V2JGopbL6KxbAMA0rK?=
 =?us-ascii?Q?lReEBcQ9K2xVBX/CLNk7DjtBuPN/rjbBdI9KwPa7Va3/mKLUDfbXRzazYr8B?=
 =?us-ascii?Q?PCWh9il7fEGjRrwFexA7MZio1eFhFTaUbAtP9uRQT9H15KAifnVFdHJxpd+E?=
 =?us-ascii?Q?l3v0ljiO8idPyYJCr2hN/AW9ofo07gybgQuMzberDyjQaOpwQLF+XGJsXIwE?=
 =?us-ascii?Q?5p1LvGcQNjZG8dvAqAEEGIzP7dZ2pLeUkNeRW9NjcziFSnLtAiKcIs1we6dX?=
 =?us-ascii?Q?YMbAT02I1G1Tq2jrBYXTjH5UCtqjqVsBTiPtiAxetOzjnuve2xC5G1RZJYFR?=
 =?us-ascii?Q?7G8t+EcVyfp5Vk+a/oYekB0OlnoO7Wt9hV0te/U/z5L5NQ3iSxAJjKJGDURm?=
 =?us-ascii?Q?HHv+yrUzK0Jkw0KlaHt+5OhaJsOzP3zQmA5D2xEa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XOsTMWscfs+ImLGcoe8A4uSaJdmdde2nL8mrcV7Xrp0gymKfHbVp2yKkvuNY?=
 =?us-ascii?Q?MvvMUy/u5YYkVNWn0zO3XK1WestgMMNT+2waKW6/+dIPgZ/TH+qYDNYyWmlY?=
 =?us-ascii?Q?1VqdN7KV7dF3rfQ/K+KZMZ4DD0EFaevJPK7x1fCfPfB7kADcrpMTUjcGql4v?=
 =?us-ascii?Q?kUcmFVd1lWJLWZcMfCZAJZJLhn9bHvTYre3/PXsnDdI5Q82eHv8DG4pj62o5?=
 =?us-ascii?Q?rWxLCBdOSWi0DWSwrJZcF2+Opu6FXE9XiZfnDRqr/Oe7YOgcsPZKgid6Dd81?=
 =?us-ascii?Q?1gnW/GWKZ2alv2H/N47gqwimYgKk4wTWRqvH0qIBGmDN7oEyiY4TwKKRhVRG?=
 =?us-ascii?Q?5GpIuq9TPvOakw1gZ3lkBFZYuI4VYkeV19SXrQE2khRHXS7vb8+eLnVnbQXy?=
 =?us-ascii?Q?wBdKAR1OAfbrGXGMjxiw1I/IzOs1R+bzwpDlac2COFmgDhHb00Czkgsu3V3D?=
 =?us-ascii?Q?Z8sdueYhcmuUpJeNsaxKudzKA2X3PhfQJKaxjrfuuBpBaFdsCH58NVvPOo+a?=
 =?us-ascii?Q?cRgG2HOl+9Ea5PnZaMRMBfJyKcS6f74bghPvO8ReHirUESscHu083cpjQdLT?=
 =?us-ascii?Q?VfI1sm+xPPktCxiUhAscPIMsRhoyPEtEfqPqMzAefgvemhuUCwkTlAKGU5yg?=
 =?us-ascii?Q?48gwEY2wNMp2wXjP7LX2utnOKmgrOGD18Cg92UbPjALu7PwiXr1F5p9oq7km?=
 =?us-ascii?Q?lHSVdNMHf1TdW7iVpfwNdITU9AROXzCetZv8CkQXeWBTGIhfDeFT/IbAEQbK?=
 =?us-ascii?Q?Liua35h/lqtvrzfRIXZwHQ8s8jbmlT3BeQSwZPDwPIScKo6BMrF7rPWUy+ef?=
 =?us-ascii?Q?KIf33Axtxk2VhxamVGWZ3bCS6ed1p5b3Cn2NOahYCwFlZHySI3trGaUFQmBc?=
 =?us-ascii?Q?XA6bj0W/171cK4yh25VvHby2AkioKz+VsgGH1jHfVbhAGnlvgI/IifsRHoaZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cf5695-edd1-4d42-c6b3-08db4db3d0a3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 21:58:09.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRDGOibqqaOt0VYM1RMx1JFrI1yCAbb/DxIUJ5+lrZ4J0Vnewar7tcgcI5j9GO6KSWnk3fiI8RpNM5kVXbI31Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5104
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_27,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050178
X-Proofpoint-GUID: FwGLv8YSqFo9RJm-Gghti13RH8y4P3D2
X-Proofpoint-ORIG-GUID: FwGLv8YSqFo9RJm-Gghti13RH8y4P3D2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/23 11:53, Sidhartha Kumar wrote:
> As reported by Ackerley[1], the use of page_cache_next_miss() in
> hugetlbfs_fallocate() introduces a bug where a second fallocate() call to
> same offset fails with -EEXIST. Revert this change and go back to the
> previous method of using get from the page cache and then dropping the
> reference on success.
> 
> hugetlbfs_pagecache_present() was also refactored to use
> page_cache_next_miss(), revert the usage there as well.
> 
> User visible impacts include hugetlb fallocate incorrectly returning
> EEXIST if pages are already present in the file. In addition, hugetlb
> pages will not be included in core dumps if they need to be brought in via
> GUP. userfaultfd UFFDIO_COPY also uses this code and will not notice pages
> already present in the cache. It may try to allocate a new page and
> potentially return ENOMEM as opposed to EEXIST.
> 
> Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")

Small nit and a question for people more familiar with stable backports.

d0ce0e47b323 added the usage of page_cache_next_miss to hugetlb fallocate.
91a2fb956ad99 added the usage to hugetlbfs_pagecache_present.  Both are
in v6.3 and d0ce0e47b323 (referenced here) comes later.  So, I 'think' it
is OK to fix both instances with a single patch and reference the commit
where both are present.  Or, should there be two patches which is more
technically correct?

> Cc: <stable@vger.kernel.org> #v6.3+
> Reported-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> 
> [1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
> ---
> This patch is meant to fix stable v6.3.1 as safe as possible by doing a
> simple revert.
> 
> Patch page cache: fix page_cache_next/prev_miss off by one by Mike is a
> potential fix that will allow the use of page_cache_next_miss() and is
> awaiting review.
> 
> Patch Fix fallocate error in hugetlbfs when fallocating again by Ackerley
> is another fix but introduces a new function and is also awaiting review.
> 
>  fs/hugetlbfs/inode.c |  8 +++-----
>  mm/hugetlb.c         | 11 +++++------
>  2 files changed, 8 insertions(+), 11 deletions(-)

IMO, this is safest and simplest way of fixing v6.3.  My proposed changes to
page_cache_next/prev_miss have the potential to impact readahead, so really
need review/testing by someone more familiar with that.  If a fix is
urgently needed, I would suggest using this for backport and then either
use my patch or expand Ackerley's proposal to move forward.

As a backport to stable,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 9062da6da5675..6d6cd8f26d76d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -821,7 +821,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		 */
>  		struct folio *folio;
>  		unsigned long addr;
> -		bool present;
>  
>  		cond_resched();
>  
> @@ -845,10 +844,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  
>  		/* See if already present in mapping to avoid alloc/free */
> -		rcu_read_lock();
> -		present = page_cache_next_miss(mapping, index, 1) != index;
> -		rcu_read_unlock();
> -		if (present) {
> +		folio = filemap_get_folio(mapping, index);
> +		if (folio) {
> +			folio_put(folio);
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  			hugetlb_drop_vma_policy(&pseudo_vma);
>  			continue;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 245038a9fe4ea..29ab27d2a3ef5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5666,13 +5666,12 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
>  {
>  	struct address_space *mapping = vma->vm_file->f_mapping;
>  	pgoff_t idx = vma_hugecache_offset(h, vma, address);
> -	bool present;
> -
> -	rcu_read_lock();
> -	present = page_cache_next_miss(mapping, idx, 1) != idx;
> -	rcu_read_unlock();
> +	struct folio *folio;
>  
> -	return present;
> +	folio = filemap_get_folio(mapping, idx);
> +	if (folio)
> +		folio_put(folio);
> +	return folio != NULL;
>  }
>  
>  int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
> -- 
> 2.40.0
> 
