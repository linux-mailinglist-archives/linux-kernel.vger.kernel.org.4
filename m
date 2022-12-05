Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF866437DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiLEWRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiLEWRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:17:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7C318352
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:17:04 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5KObNb001366;
        Mon, 5 Dec 2022 22:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=I2BCwi+EUdh7yaLy8J0cpkJ6d426EvFV434dRXsduYs=;
 b=tl5oV7hPIy8p9Ic0dDr+tGLsrJldunryq3sPCPWPY4s6907Bq+ZpDZmOznNJq5m7rnfs
 wHGzmypT6Xi9yLIHhU+MCct/vKd5c3c1r0NZYMDiPVxM6pSMFiID4lOeIqNejboupnXM
 CEJi/MPtO8RkvoTwZv19UypwnNLz/b/rT0xhZdU5h9UmpQUl9Yy5DGoKUm+JFL5R3kS/
 uMFFxmucOgvCoffZ8R48iU8ItBRJWmDQ8CiUTuWlkt+wAixqAr2xgUikkovYupqvpbDv
 e/TduM3FbdGMnArb+kHLaiKBR6D3A1tBag0NgeX0RYkJd7NRbYKAhvn6B5p1HxCgY+7+ 6A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ydjdqvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 22:14:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5L2RxO012717;
        Mon, 5 Dec 2022 22:14:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m8u92mb4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 22:14:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqGx/iZfiXHheErGGOnTdPFVU0KAVZHM5Kw1IKCBLqtdoln1+bWhx34OmS8P8wn0Yrus8dlhyzxcB1B1zJ5WHl6+9tNibLYptn+lmGkUOROwYj7Nalx78l+Gg4jk4iOKDgKU2DtZ4hgAHBbOLhp6Ps/94P2LjbTkTNEQpEyVZBCSwwhKQYXwL0B/fUlWZCQ2of5RhevSu1e0cXCKMEcn0op6FicvTTjFv5cKwJ48h69icKE83e/1J8QfElmzY6l2JNCGlubLNfObR210vRjttweQU2DPTYkgpxzxHiPF+dpj7MIsz/ZuQMxBc1y/Of9IxBFTdz++ctiK1FIR52vhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2BCwi+EUdh7yaLy8J0cpkJ6d426EvFV434dRXsduYs=;
 b=cHUT9b35tqvgUa38usxVlclh8+18k/U/Yx3kaeczmgWNb0ETHFxtQQiEeaNMICg6DuCxaV6ohL3eroI4OmR6cpfK32w+0tyvw9Wm62F+62zepga2bv+sWwGjMjm1RMYjJz048WgHxIZ2OFLYJkyxvhHeTIp/2V+2QTWVxFolcACK1CcEWT0TJ+yWitUK5713P5sx0CaB/UgaaJwaLATnSSfg0gx6l89j9D7mVi5tfhh4tSilGRpRbUzV1zMW/6CJkwCPdcSPuVkXudw+/ERXAd1P+q7HU8N8caTzqhD5vDxK8Y6VH2rpOXnmkrVeQviLgyWCMfvcJ429pJrlU+cucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2BCwi+EUdh7yaLy8J0cpkJ6d426EvFV434dRXsduYs=;
 b=o4FUzLsOXVYZqMMh/+BuXLVYbKSpVVJsKiGno81pTc8SwrdnBQkgZe2k8E2eW0+Dv0egi0YMXjwMYKUHqOLeicW5BGoxXFC0lBRdsuUXzuC+6WGctEPaPwP8RKytM5bsWeIjmYhmaon3bu21piuuyroydWdRYHSl53BACRInxUM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4434.namprd10.prod.outlook.com (2603:10b6:303:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 22:14:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 22:14:41 +0000
Date:   Mon, 5 Dec 2022 14:14:38 -0800
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
Subject: Re: [PATCH 04/10] mm/hugetlb: Move swap entry handling into vma lock
 when faulted
Message-ID: <Y45tTl3tleVP8fA6@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-5-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193526.3588187-5-peterx@redhat.com>
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 0098020f-0e8e-4cca-2d16-08dad70e1b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6a18HJu4TCE+ZEKciA+/mVZfe1afKmYlP4ZeUI+ZzlnZdycAq4NZxY0/CAtwbWc8TF3zYuinbHhZ7kERIt2WXIY2X1faWz2z0lOLoTKsM5Ba4Qme4i2o+MsLW2x1IMc2cfo+9dDreDJrzeS/BndddQiqJtazNkshh9pUQGhsL3sC+q5GZw/NWeV8bfBdIfduXIYY6RewdPGxCNaganQBzA+xrLA2N7YL9YEZumJQf9PhL8rBV1Pm+wbJEkbtbSy//Y6ei9CN5Je1bXMinkCTDVeVyzXUa0pNEEKMHjUmILe3LWS0h5vi/gne1USTGIeZ7g22UNjIRNqj+fgj96IlkJkaqTXirX3nqu1Rxj0IDzamgp9pnjwUVvNKPABzSHKLgxRR9YBUs9SZ7kW5QrnsThwH02rMGHR7eCI8eWnZfE8yoInK+Wun/nmszjuvPtQLyirLXBD1LnVF7c0pXiQVKWaBJ4jpXoEJHIKfqfp1cEsmW9HhFfSVJPkexJcd36l2hGv7MJDNNtWXO4Q8dNTWRAzomi07tkKP6LUccrOMEP0RcrKfWDIJkAshoqiqhKQ9MVf6l5dXvN3oq/zLwoUQwwaBgnbjfFoIfOFtkLTbGwgG7Gts/LLg3oeCY9TnjZuV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(316002)(54906003)(6916009)(2906002)(6486002)(478600001)(86362001)(33716001)(83380400001)(38100700002)(6506007)(6666004)(53546011)(26005)(186003)(9686003)(6512007)(41300700001)(4326008)(5660300002)(7416002)(66946007)(66556008)(66476007)(8936002)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8MW1rEvKSQoyZOpE4cUpBZxEuFUNheEUSH/Uck0QES5wwfLf6ZJw6rKKsBlp?=
 =?us-ascii?Q?6w1O6CQBMdTWBGCEwiUoJpl4F0aeWiLoqHSN9xnQY7oAXX9k8miBoojDMSlo?=
 =?us-ascii?Q?9nvmIA95kbS0LOq8Qc4ZC9i4hMJSLBoUefsBAAvWlOkHOYmuqAAt6JISgf0j?=
 =?us-ascii?Q?qMzRiAzC3e0doKnFOWSoUFwptrBZtyOPS4o+VYDgPzf2d1p9DOcUcL508fmX?=
 =?us-ascii?Q?GIaRjyklL1MguPwk3DWabptprT/25kyKgJW2CRO6BgeU+KyTbSyFsAbSJZ/G?=
 =?us-ascii?Q?MCvbr3HXajoW8hVH2D5tPae4EGtxVRkmC0w1I4GGBHe4+d4UAaTfzhzDA7w1?=
 =?us-ascii?Q?rUKkUP/aiuDXxAiLtVhS3WIxzUpz1tSlLcAcmJ/Qmr6b/XyOmQda9HphZcnS?=
 =?us-ascii?Q?ugKnmR5JxvIWw1DujRJrkJbLtuWpEOHW0gG6RGB/63iPWD0JqyjbLsehZ/Y+?=
 =?us-ascii?Q?F1VMve37lxOsg0NaZ1fw9hlM4QrK7lpZNFwqY670fdYLzERhaOgJn5uSHReH?=
 =?us-ascii?Q?nkm0CXw5oqNhzumifPJ6EmD93EIlHFzMXtkexGYWEumRN+EVCtNpGnvaOua6?=
 =?us-ascii?Q?I6C50UHTc6O7AFpf7N2DCdPwc5gH8QZpbh486Xpt7RGOcgXiDRlyXO2YP+PZ?=
 =?us-ascii?Q?+OzYUiYzcw/YU74f0llvpOsM1iWD2HY6pjhaqtnEI0nEfdstrfAmlMlTNsfT?=
 =?us-ascii?Q?K3+A/7HlSlDiJleUUpOgo/z7sOy0ibtZc4EdYD9y9QDDoTtBJJtMs72cfrNE?=
 =?us-ascii?Q?+c2QUJx24hHOnRSSPe1BTgcBIKX15ckLBQptiH3i4tfFMtpIrVzQU8lUEUZL?=
 =?us-ascii?Q?hr+iDmHzE9sARm8tEdKudYkvklBuK1sPCelziOZFhodQJquIpu0H5pb9Zj0b?=
 =?us-ascii?Q?+pswOH3Y5yHw3t2L0ENOwZTaAtA8+42rkVegrIzOai3kns5cAiFVgJHwywS+?=
 =?us-ascii?Q?wkuRO8kE4PE8pNUr+sysa5oHdz9PPI0xZmLpEJS+cKRQH+QDK6g3JoCJdM4e?=
 =?us-ascii?Q?dhjtenvgftNGeHDL9vpOE2wl3zWP3h75zwed5WMA8Qi4ozBrsaaVwyGljd17?=
 =?us-ascii?Q?rZjPTzzgJombWit29mqjX+WoUx87wNI6vbJLV0gpd9ZdGK3GhEnbld3QNWi5?=
 =?us-ascii?Q?5GZY0TfD2kwOZaDAdg7mNXAi16RAat+8/oIQdsXym41IPLCeTvEVDSXqfDmI?=
 =?us-ascii?Q?J7wzB4Gvw3MUJ7G5HSqaBdq3qNGZfQouZMY88Q3OU7Zx0nFvGrf0SXMCxZxD?=
 =?us-ascii?Q?mgbdiNSDaygR0LWIgkg/qbyUhL8zWCio3AcLg3As+NzA90weH2mPUIwHttnV?=
 =?us-ascii?Q?mgQ7mh71VbdASxp0ZhwNLb7FaSrLuoSjhmZtlBttBKa66aeeeClteko1DLPT?=
 =?us-ascii?Q?LkM/AZbSqRLBE6Zz43I0yFwF5z1FSwXTypxu0XnwXVWh52H9J7yQsqiLI+sV?=
 =?us-ascii?Q?N43c2qovTO/nn9DN0aVTzEUovVoFY3T9MhDC7WmizXtfUkCFwNSSqM1kJqKl?=
 =?us-ascii?Q?XKNgIsLDmsrdv/bHBvbgTwg0/Jpn6oyLQ0ie3zXymcMqn2+Vfzk7/xPvm1id?=
 =?us-ascii?Q?Ptt83vYz9dVBkkVp/+DFSgqvgTNj9jbsXLSrCWybpn56eIITwUhE3GZbyyrj?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IBIzR3JVucTRpwdaxIcjF4nIv6nnqW0iI8TjmnkLSaJdmo3SsrJzXidzci5I?=
 =?us-ascii?Q?4wuCtxEu7t0KN0gMG6UjwERWd1eNdDM21b2guEymd4SUVNBepCVx9tvTo94s?=
 =?us-ascii?Q?SkoA3OYcP+q1LeNQ5z3hJRvi9IyxTu+4qQWqvYbkhbP+snZOHTDOECAbb0Ci?=
 =?us-ascii?Q?lMyk38PwbI78SsaDKMy0BAsJjU6NEqJvQwlwkkQNxvONH+wLSrbo+qJU6/QT?=
 =?us-ascii?Q?/1CiF29rj17W/gJq3SZiON8UqGBfLZLzSa5JytfKN3CJl/WiVZm7sTy8vxVC?=
 =?us-ascii?Q?q9XNS+21xIHSu8Wdea3/m0sfYNo07BvKBl/QESuMjwk9DXKzAYCaCaxYNPh2?=
 =?us-ascii?Q?mNP2OnrWZrPX97WhugZZKAGJ+zVZO2umq93toWW+EDPEWXj5Nr2fjuhzXzIi?=
 =?us-ascii?Q?y9aBHSfLcN32tNhiLp+qWsEzDWkbErGWTR2zkIeuJ8rMtnz1WRep05wUxLjq?=
 =?us-ascii?Q?IKCw5lCe65IHFgxI6jpXv+lgz62+6TRUp7RzyJ6E+7bm7rrsvQkLWcOZFs30?=
 =?us-ascii?Q?Iwgs2G7lLHSwYxG7YD4grS0vSdX2rmcnWGP9jTkGGEV4ZAW/O/JB9dajmbXH?=
 =?us-ascii?Q?/Rb+n5aoBcM5qDxNBRbvtt8noVCehPUS8K6D3d82YhRt43Wk56LxFd/LIdRO?=
 =?us-ascii?Q?TB3ZIwzp3PmLfRNWGhDERa4II5fgzeOjceb2SnWPvc63NpkhncZwlf5yo+I4?=
 =?us-ascii?Q?Yd3AG2b/A8yuOLkifrb5cdwaAuo6GRzxBM5Hcj9LwQkFSF2qniNNc2kphpGo?=
 =?us-ascii?Q?3yWn5rvxrcGI2qwCIYqJlX7XrQrztnZPgNzYJy1kHbcvOjKP8+6OnuOI+4F1?=
 =?us-ascii?Q?P4HKK217CVYYw3QG/QsLmp+nsmXdH9EgLfpR1vWbLmbBnpHcrv7t+bMnKNz5?=
 =?us-ascii?Q?x5oio7nUczWUEJuzqovzoX1IifTvwjK/klELnKcU2dA/6VKg2Nt9hXBuu4pc?=
 =?us-ascii?Q?0GbhmNV7w7t57j0i0TsyaTW8W79Ez6c9uoIEKKg5/2Y7jtP527LBY74eQa74?=
 =?us-ascii?Q?+Za8W1QD+tMUGuYPuu5G9T96hQJwofBdJLIdavv16ebeWHIpMtlHknxG8XFl?=
 =?us-ascii?Q?tuNwcs7xOLhHWbftKwub/UKkxH72IAiswInw2YNeEQ2WPsfhFGI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0098020f-0e8e-4cca-2d16-08dad70e1b82
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 22:14:41.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4AC/B+z2TSoHqUJyrLiFK3gi6iWdY5AuoCQEUQ/lg8hwQa8AZPUrF8IcAAQod9gYznInr7+yhcYanM5juRs0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050185
X-Proofpoint-ORIG-GUID: a0O04wRCwN2IQXeySuzUovQTf_usDSNk
X-Proofpoint-GUID: a0O04wRCwN2IQXeySuzUovQTf_usDSNk
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
> In hugetlb_fault(), there used to have a special path to handle swap entry
> at the entrance using huge_pte_offset().  That's unsafe because
> huge_pte_offset() for a pmd sharable range can access freed pgtables if
> without any lock to protect the pgtable from being freed after pmd unshare.

Thanks.  That special path has been there for a long time.  I should have given
it more thought when adding lock.  However, I was only considering the 'stale'
pte case as opposed to freed.

> Here the simplest solution to make it safe is to move the swap handling to
> be after the vma lock being held.  We may need to take the fault mutex on
> either migration or hwpoison entries now (also the vma lock, but that's
> really needed), however neither of them is hot path.
> 
> Note that the vma lock cannot be released in hugetlb_fault() when the
> migration entry is detected, because in migration_entry_wait_huge() the
> pgtable page will be used again (by taking the pgtable lock), so that also
> need to be protected by the vma lock.  Modify migration_entry_wait_huge()
> so that it must be called with vma read lock held, and properly release the
> lock in __migration_entry_wait_huge().
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/swapops.h |  6 ++++--
>  mm/hugetlb.c            | 32 +++++++++++++++-----------------
>  mm/migrate.c            | 25 +++++++++++++++++++++----
>  3 files changed, 40 insertions(+), 23 deletions(-)

Looks good with one small change noted below,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 27ade4f22abb..09b22b169a71 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -335,7 +335,8 @@ extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  					unsigned long address);
>  #ifdef CONFIG_HUGETLB_PAGE
> -extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
> +extern void __migration_entry_wait_huge(struct vm_area_struct *vma,
> +					pte_t *ptep, spinlock_t *ptl);
>  extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
>  #endif	/* CONFIG_HUGETLB_PAGE */
>  #else  /* CONFIG_MIGRATION */
> @@ -364,7 +365,8 @@ static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  					 unsigned long address) { }
>  #ifdef CONFIG_HUGETLB_PAGE
> -static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
> +static inline void __migration_entry_wait_huge(struct vm_area_struct *vma,
> +					       pte_t *ptep, spinlock_t *ptl) { }
>  static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
>  #endif	/* CONFIG_HUGETLB_PAGE */
>  static inline int is_writable_migration_entry(swp_entry_t entry)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dfe677fadaf8..776e34ccf029 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5826,22 +5826,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	int need_wait_lock = 0;
>  	unsigned long haddr = address & huge_page_mask(h);
>  
> -	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
> -	if (ptep) {
> -		/*
> -		 * Since we hold no locks, ptep could be stale.  That is
> -		 * OK as we are only making decisions based on content and
> -		 * not actually modifying content here.
> -		 */
> -		entry = huge_ptep_get(ptep);
> -		if (unlikely(is_hugetlb_entry_migration(entry))) {
> -			migration_entry_wait_huge(vma, ptep);
> -			return 0;
> -		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
> -			return VM_FAULT_HWPOISON_LARGE |
> -				VM_FAULT_SET_HINDEX(hstate_index(h));
> -	}
> -

Before acquiring the vma_lock, there is this comment:

	/*
	 * Acquire vma lock before calling huge_pte_alloc and hold
	 * until finished with ptep.  This prevents huge_pmd_unshare from
	 * being called elsewhere and making the ptep no longer valid.
	 *
	 * ptep could have already be assigned via hugetlb_walk().  That
	 * is OK, as huge_pte_alloc will return the same value unless
	 * something has changed.
	 */

The second sentence in that comment about ptep being already assigned no
longer applies and can be deleted.

-- 
Mike Kravetz
