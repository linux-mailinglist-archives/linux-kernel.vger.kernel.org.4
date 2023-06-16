Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99196733D02
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjFPXmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFPXmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:42:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE433213B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:42:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GLXvT6013294;
        Fri, 16 Jun 2023 23:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=yqgOgxc3AlANO86bhSA4B86wA/g/1LTRKJ3DXib2VK0=;
 b=ad6Q0mTSwUC6xFhoozTBbwnd4MhKuOatAVwhWkMOTIFNAcqmH6dggmel2O5BGYx8elNZ
 oXUXWaD1oCf2bte6zHm+twtWeml8cwK9pLrfMT7gisnkI5nmA9I4gp0/YCL77to6mGGg
 k79TqBE7yS0evRwtFhyKV/Af02MphNTnbFVE+0z0q7diV+7nJS1IRoZmtjq50h2Rh6Dn
 Cc0GOrqV0TmqruIHHbzOyai/KyaN7cZBBEE5CFQCmE6BYK5UeXlQg4KCQrej5LZ3YGiP
 /e+dMetO7SOsAl9q9ZCauicM9upV4vSeelO7IsI9kBS/SecCivIfF1ij2dK7tq7us9kc 6A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gsu53rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 23:41:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GMMGXG033622;
        Fri, 16 Jun 2023 23:41:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm8tjqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 23:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShMl4hDlFJVM14SuYmvNyH6VTT5M38Fspaa8bfjjtk/pfmJ0HJ6bP6/3SlKLnMdwC+fErTG1vddcGVboJGqFBAEKmpiPbh0f2B3/suJthw2G58tViZ0DcSPlJEt+2hxKY+6pKEVZOFKpHJEW4WoxQdJC4mL/JKXqTmDE2rbh+m8lFtGofcQANTqSHcEvk6+XCyw6OHM2u+TTFwGKrLRpSr/jm+OiYG8GTk6gPcvjm3jp0ea6z2FpeTa5hkFWYpM56JG40edngU1F87MzTPNtYqOqGUklG1IvIGb814NZnSbCD7Il5Cl3I30xYmzA1aVg1y8DosOYYItvVJjJa9beoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqgOgxc3AlANO86bhSA4B86wA/g/1LTRKJ3DXib2VK0=;
 b=hGw/wWRzQiAu5vk5rS/0MKb6KetGS4SS2XrMYKU/HU1zyeRYRbhBphdhID41SNG+SCldmimExqyGzAOHkw0LwxWQTfHi8IlCU/8cGGoqJchOQcFbFOGRoSqPPoPQSVfkBL19pfigVBlQ9QuSYWHP87PRwtIaudickUQ/if7t9tcNislah74DZF5sd09/fyhm5nKMxHCu0VVwlphTMAeGwSAO4LG62jBKgAlSvGUMVtcu3PIfVFiEYzuIBAAj8D9S/UqMOsvHkkOvYUucr/drzMqaIeEuED5Kha/NX92QziOumj2y26CBq+lUg8d8kKHjPAyxtqNS8YngoepyFt7dYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqgOgxc3AlANO86bhSA4B86wA/g/1LTRKJ3DXib2VK0=;
 b=y+ByLZpw4DXkQ6gqIM6tmjdCN5zAgyxART5i0rOpsd8gWzNUYw/1TT8y7mszjtynyUMBu/bkCOWd1DzLxOl6jjK2xVQFAC0GTrjrveBQ4yy5bi1fWehGTsJ6xtoz92FpiOQCY6BwOtNxtcfe/jw62O5DKjz9MgBtsEgSnuJiYWg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB6305.namprd10.prod.outlook.com (2603:10b6:806:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 23:41:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 23:41:29 +0000
Date:   Fri, 16 Jun 2023 16:41:25 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, david@redhat.com, nphamcs@gmail.com,
        jthoughton@google.com
Subject: Re: [PATCH 2/2] mm/hugetlb: add wrapper functions for interactions
 with page cache
Message-ID: <20230616234125.GC7371@monkey>
References: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
 <20230609194947.37196-3-sidhartha.kumar@oracle.com>
 <b3faab36-370c-1635-3ccf-33d51f53859c@oracle.com>
 <20230615233624.GB29046@monkey>
 <b9ba6f95-5da5-2cf6-00d0-77650ba2e7f3@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9ba6f95-5da5-2cf6-00d0-77650ba2e7f3@oracle.com>
X-ClientProxiedBy: MW4PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:303:6b::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 307cd0c7-3071-402f-69a1-08db6ec334ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: foxqAPLVsIz0ESZGJP3WGY9/XIvTvSAxiORlLg+FAPmNaHrPDaIjsZ4xtQozKUJG2Cskg+7O+zVDO8ACD/PJ+2yn4qWPAagXYLhFNZ6lTclUbUfN1dc1TJT5bN3rHX9Cp1HUroLSmnxp5MWkRAG6fgmarmdjEvQwbcrb6pQr6clZfv7T8EZ/n9Vr/dknbYU097pKEE8+UB3yKj/V9ImpuHJBJjW+qfERN7zzIA+BaBDwfa/x7x1DVLJ0bQUtcr3/tDP1fKCDCxDwakN1wUur+ICDC/qM3tj2PC3rQWfI/m/T1zpA8FTrYAHJzErIaXMIk8QIYblYYcdSeaK2Skk1/t9wGx+THzSQNj2lbTcxGmbSIaZpChoM0t8G9vRy+z4ZWkvuY8aHKvBj/2Zhzhrm5DNLlWqI9D/Zu7ObdY/9hQu46tOH9hDfO4L+I8iqYbgQwCrqVveag5Blflhrt0WUCF96o+swLuU0XePn2GARBmESUoC9zXVRfO3bOjsK/stI2sMXqQllTrMVN7S9SWtcbEz0a53P0sIqpAv1NV6Md2KyzHRUjL7/CTS5QbGjLgE5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(26005)(8936002)(9686003)(6486002)(8676002)(6512007)(41300700001)(6862004)(478600001)(1076003)(6636002)(66946007)(4326008)(38100700002)(66556008)(86362001)(66476007)(33656002)(316002)(6666004)(53546011)(33716001)(83380400001)(44832011)(5660300002)(186003)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tQshehlwCvMJS4nudC7Y8qgD3BFeW4ACrK7ikgLNcxaI90BVjscjUJqWiqj9?=
 =?us-ascii?Q?4hHFgtqoJ16dQX7tvhFp24nP1GqcAshwLz+h1GjGG023govjx2uyICpDtWvw?=
 =?us-ascii?Q?s/28mNGjP+dxYh8A/mYPXCvSneZ4H4dawn6QnBBNCMeuCt51jf8W7ax2HcDC?=
 =?us-ascii?Q?vncJGeM6/OHuAEcszW5Y3Pzw5+CEHZrn4fy7zb17wkMf5TOYzCaXfmnjg2Sk?=
 =?us-ascii?Q?UYj5M9BIIvtarwRoVKnfkrnMN6tMj5/7pF5tEqamCAKzJCpbrj4dXV8xP88y?=
 =?us-ascii?Q?b68wrLfhF5z9Gv228jLo4S2KFLSp5mRfkIy1UKO3+gbqtQ+cASBBeHY4nlF3?=
 =?us-ascii?Q?+1oPpZcYHBXtDrDcFKzKo0OBPJkCIEIccq5wzbLmx++3/yr2oUr8eBd01VqV?=
 =?us-ascii?Q?QVlyzkfXv616VEiKh6uwPheoIyvn2UNrPZp5GMQsc6NoXm1yaQ1U/JGTR7jV?=
 =?us-ascii?Q?bmM8Au5SH9xHOU+D1kL+gRi7JvHHOCTuNMxkdFyiD2/muXJwN53HuQAk20DF?=
 =?us-ascii?Q?AKjz1U95VtwtLYzkA2yzXN1G3IQyUtbs+GG9x8bS658hjOdR+LKfCN3sNJcN?=
 =?us-ascii?Q?EFbbgxm4zTnDwdF9AtAMwEfNMwQ62sO2fiDuScDPNu2dE2cpK6pzISTOpywq?=
 =?us-ascii?Q?f3ZyZ2msks2oNmNtRvMPi5fC7ZYhz+2xHmBsi1ObbUVa1PnXYYboeUJvYm1w?=
 =?us-ascii?Q?KCMqEoh5jl7IZr2+5oC1ed4Qla7iGbn2eaia/lJgz8zMa2XQ1h+ic0iSn8ia?=
 =?us-ascii?Q?JlLzZKy9YncWMy8u6Ep/rB3fcU1q2Uictq2OKHd206HewC3O2ESk7PbeARwu?=
 =?us-ascii?Q?Gv9uQnyHqDOHq3cpuND/0b1sI1l/uZHzpXo1Ld8H3QfaoY91soFI1NG6LPeN?=
 =?us-ascii?Q?PNfg07+UVWiBWV7AphIxM09mcFsaA0U5PSBlcuI4LaaDB1pOsRZMCWeYwHD1?=
 =?us-ascii?Q?ecl9xa0XTXoll9lA+gSzE6mJUv4eUKfQkKseAUkXs/cRKqb1uh6+STn3ArWf?=
 =?us-ascii?Q?Idz8ur5sOK8lOEjdRmTnt1QwbNdcq94cKIRBYJ5/7R6QkxryKo7DpGGv3N1Z?=
 =?us-ascii?Q?145V+zo6w5lMpTW36vjlxzOeYzAjQc/AsnSAP7NgmiDrSDX4zon+Pk7J+PqX?=
 =?us-ascii?Q?gkCYxJr/C4ZtfTYZ7BmysykXJB05O0nCz7PHGjAzk6Dg7MSDlJFx+jjUJAsP?=
 =?us-ascii?Q?NhuhI23nsY/9YZ1RmbA8ZUsHdi4VIRmW7k/lTvsG+/HjzaVYXegjEVg2dsrQ?=
 =?us-ascii?Q?5/QiUtnmQakZOJJscykEelpvEIDec8rCQuBYYKo0neuf5WvYnaGfuJz8mE1J?=
 =?us-ascii?Q?pIBUrtJkcYzR833NSpkcekbA71z8Gsq7WIOIic6u1Ly+STsQpQ3YyGra1Gfy?=
 =?us-ascii?Q?0QmSOh1xracu0yGvzqQrn5Ix5IrnyMAKZ5pnj2vpPOJai2hU3m5AVVX5zQd6?=
 =?us-ascii?Q?Ya53kAnU8LR+AQJkcI7bD4iCfEZB5jgU20E8rnpr4EMAq2IF+znpZjYlpbHL?=
 =?us-ascii?Q?K2tJTcEsOrI8yw5CJ34NFZOH+J3stL4GV422unBVhQnwPtkltvQfGNT/BLF1?=
 =?us-ascii?Q?6ZdIY3aaVBmyeY8RHVBrzRID/s9AGPGJIChO9NKsDAUlAiy0kZC2zc1v0QJ8?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DUjUviwrNfeXu4u6x5W4RY+nWZR1o3eO5dFRDc0jnQ05uDA33IQpCDn8VtEC?=
 =?us-ascii?Q?+uOI5VMooQXom1uBFF5yTKqCONlhm+4zLDJtnggLRMD/vrkEsi+9+VdJsk9n?=
 =?us-ascii?Q?NUBuHob8wYEIcsq7nGoPYvrMIR7X/OPk3n/z4tEovwRmbIK6XkSZSwOaYsSk?=
 =?us-ascii?Q?qviosa4Zu25u6zSm31obMPkT4xmUgPwTx9U/hy4+onwSWVODHYfjMAwnXqk9?=
 =?us-ascii?Q?V1N9o/ABPZSPeMmtp11niUqLk6ectXGiWnpVqsYsIn/dAEkaDkTKS3OcPD6g?=
 =?us-ascii?Q?vkgN6YWMMayhRtBRgZUixkGg5X1Tbjeqpxo00p3fICsMxcmrn10xDN3AYwb6?=
 =?us-ascii?Q?B/UjuqxJitGOJ133TgInDhrSkyoLNE8loBDlXT2EieuDtZUzDu87JgOEJNSU?=
 =?us-ascii?Q?kj14cNhr+x1BWU7gxQeacuJQmFD/QYbYagIx+CPJRXq/Fh0FyuIDTRg7cZfo?=
 =?us-ascii?Q?JSe11V7KlvV3pXYSQpoxPJsMbzlmZoZJPFBcYtreFNQ6S4LuWoAUch0jv1M1?=
 =?us-ascii?Q?Nskr2290r/SNWqmxenZyBsBl2wudiPEGYztTy5Wgtg6TVZxJJ1J+7NKEHZyJ?=
 =?us-ascii?Q?QqRH9SnIoIbteb9q8+xR1nvTBfzhAH6GsGPHy7gZO4wC/ulbKjtP7I6fgv81?=
 =?us-ascii?Q?7npL+L5FHKLm/fzueOGxFGqNvUYHAY1BigXCeWf5u/QpzXNnUAWmsEccc6QF?=
 =?us-ascii?Q?O63hLFZrKH+bAXE+aTeKH8qm5CEEglqm8fFYmrI7fubWYxGGXANhIvcqU4ay?=
 =?us-ascii?Q?O8p5ANjZxlGdyRgEof8DnvaBzM8xIcLOqOBZAmBjYgwVaCYmubogJrr1ZqW9?=
 =?us-ascii?Q?eHljjuJJa1cJllM88oPsQnZ6sOs+3cbBOrF20gWEewkWJCH54okhav8AEeXZ?=
 =?us-ascii?Q?9y1mrBd/x61s5xHqQNFGOKJwEAd9I+IqONO33DMYdfIr2HjXLfWtPUHtrv0Y?=
 =?us-ascii?Q?E4wpPtqwDGh/ZjSd01LGt0u0QH309K/ieTPVHDTpkiN+ZHMl5JWi1jlHwCc+?=
 =?us-ascii?Q?e8Cv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307cd0c7-3071-402f-69a1-08db6ec334ba
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 23:41:28.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQTs7COYQColcPvnqDBM1Bp7/NrWI+m2pvAa0QD6vqojM1Mfbh9+aDSSorW/wVWpujjXhyt6WTsI651X+oot/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306160215
X-Proofpoint-GUID: aycEheQcMR_MCy001-xQPOcdYc-fObs1
X-Proofpoint-ORIG-GUID: aycEheQcMR_MCy001-xQPOcdYc-fObs1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/23 11:52, Sidhartha Kumar wrote:
> On 6/15/23 4:36 PM, Mike Kravetz wrote:
> > On 06/09/23 12:52, Sidhartha Kumar wrote:
> > > On 6/9/23 12:49 PM, Sidhartha Kumar wrote:
> > > > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > 
> > Like filemap_lock_hugetlb_folio(), can you just add hstate to existing
> > hugetlb_add_to_page_cache() arguments and do arithmetic to convert index
> > to PAGE_SIZE based index?
> > 
> 
> I wanted to avoid using "magic numbers" through doing arithmetic shifts to
> convert the index and instead explicitly use the linear_page_index() helper
> function. However this does add more complexity as the function parameters
> are changed. I can change it to doing the arithmetic shift to minimize code
> changes for v2.
> 

I would prefer the arithmetic shifts.  The only magic is that it assumes the
page cache is managed in PAGE_SIZE units.  My guess is more code this this
would break if that was changed.

Matthew may have a more forward thinking opinion.
-- 
Mike Kravetz
