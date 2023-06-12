Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CCC72D500
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbjFLXfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjFLXfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:35:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DC510DF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:35:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKOSrh003998;
        Mon, 12 Jun 2023 23:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=LIeHGuA/NWvSAtjp7bf+ZV/+Jvj6JA36DDQRuK51CZ8=;
 b=Z7NgLYjIFpUBqd1wzGF34CHLDNiS/OEGqUyscIHMsCI7pu3c2zyCw0x5MR9x03vxwYJq
 OPwRApb3HZVHW1EyakhTn3lSLP8a1EFjOxral0XwdCXs8ImoSdy/svMUC/6xWPsVsCAr
 dylzJvr8TgxoNPiRKyVAKX+E8/kW6fOLTo8fVuBQzW4iCpq6H9FXd/c3xzTZRsHlOuJX
 dpIXVnlj8KEhv9fnTgM8ZSuCNnEiI1GW70jZuEj6y97Qu9wvxa6e5bUgXNPjySovSjl1
 r+xXia3jrH01uW5QrZNQD5WegqoMtmjmlGW7V9DJfM+xbkYMsi0EXXyYdbbFr1qLCmGV tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1v517-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 23:34:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CMUv8j016285;
        Mon, 12 Jun 2023 23:34:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3ej9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 23:34:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHqMEQ1x3viBiI64t9In4pn34qFUaL1napxOSXyQ2sxNGoXF3LU4V2t0jBCqOr4Ke4rUh9je4K/nYrRCpInBFmuOcFOb4HGLZEPWtU8y2iG3k73Ug9Gp4QDgcHWJetuBYKTaxkq36xWhW9J1DWif3406mj2PyOnlIJ7HjVnTfaWGaUJppaZ/BQhJCH5ZEkjJ80hjmuw9kTHNaRquPM6J5cDwy5Z0hOgcchtEKqKsM62lIGSx9AZM8ZFNTfq+vGMeoezC6aLpRGsi0Z3ninR0CxPyHXx7RnlrZn+5EjICMpMKu/YlFNw4mrLG95igZzomW4uzs/h2fDURUbgOI0kWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIeHGuA/NWvSAtjp7bf+ZV/+Jvj6JA36DDQRuK51CZ8=;
 b=nB7vrlmI5HCMTWhFON9y73Zvw32pO9WK4Zv4TyP5KJGr6GDnlcF3hcps/tXcbG+K6mFrafIgjY9b/QdTbtR8LIuLqKyDwFAxaidM4HqiKnDcL05qNk5q2gBc/jlb9OXrLjVX98w7KqAO8xDW+4YX8obdc59UCpOTBK0UpXxlA82+QEht3soTS0NXYSCBthLywO6UKASIUlaPnK3sQw+Gl7JxZ+xGeqHrPsC+/sWDerajALGryhU82CRKXHQlPgUlIGbhV7AvIrq/HV/nazj24pb5TUF4mlL21chlk6ylOnbraqwMBmFZHkdNtbM70pyzZnaU71QKZBffEYfdPoKVbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIeHGuA/NWvSAtjp7bf+ZV/+Jvj6JA36DDQRuK51CZ8=;
 b=uU2JyCyBMBnZQNVTNOpOOHgmUNmue1hQtTSFkkrdThbqlCPQc+89pOM+MjuoRmZO6DiL81tbFQfewe5V6a70HakTgGm4sgf5EdG8eqEyDVQAAuKc8up2w7Phfp6KWRtFP00SH2GLoVdwrBNml4ka4uXcKNnYldUVOQ3bdtzmhAE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5732.namprd10.prod.outlook.com (2603:10b6:510:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Mon, 12 Jun
 2023 23:34:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 23:34:54 +0000
Date:   Mon, 12 Jun 2023 16:34:51 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v2 5/9] mm/hugetlb: convert isolate_or_dissolve_huge_page
 to folios
Message-ID: <20230612233451.GF3704@monkey>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-6-sidhartha.kumar@oracle.com>
 <ZIdYzZGSUzYumrCT@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIdYzZGSUzYumrCT@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:303:6a::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b7751d-113a-4d57-af88-08db6b9da023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpqrruc7WEwU6lGTITLVQJQDwcocwezSCC+vGgYQBQLD1TBt4776m+J0Xtomtj8Hzd10o8ReBZdFEHKaExC8Bi0jolJlErSPjsjRQ9m2SOxZRubf9/KILg7dDsWfrb+uKg39spHTuHgpkb0xuSZ7jHbUpXWgzWRQsbcvYAgeu6WDGN+eGl7vc44KgPOiItEAfHl9hNIAXB2MQjPShi/B2hdTIWVSEuzJ9y1G25iXxhJYVlaNJ8kCMl68x7y9Mb2fkMpXQrLI6sRwQXS3m8B9O08pDcNI2WNNeUM0Rw+SLvtaozsZAsfhSNKkJjIqzsfT0g6BpZtdDLGrHqL5EMb6E8jUeGZdjY+GWPsGPmWNSp4wYwcYaSbBEJxHF8FfIRSCbt/m6ld3QhZLLqJ13A3cA82W9TFZ/UbUMZpDQZH5rWcXPRRevShHvX39DMf2llU1bhEV15xTcjwwmo41nVz9RU7w0T2LB6sX5k7W2bwSX4smQDNdVW/WOBlV89nRKsQMtxpveKCEuPANva8sp0Q27lW6uy6LnrfgchVW0or84sTmeLjaVIrv+++JcK7qWBqCinPw7Nv32d20EmSTU3ShEcXZiQo2Q8pgEYAvMltEctk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(66556008)(66476007)(6916009)(66946007)(8676002)(5660300002)(8936002)(4326008)(478600001)(6666004)(41300700001)(316002)(6486002)(38100700002)(53546011)(86362001)(186003)(83380400001)(26005)(6506007)(44832011)(9686003)(1076003)(33716001)(33656002)(2906002)(6512007)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o3eRxNYgDtIYi6JvXymoiPIIUBb/oUGcaPf7whxrKSVXcuMQ4PoAc6oH4+vB?=
 =?us-ascii?Q?+WSxFcKhOGRcoVT7sB2gUcV2UsGZY2xkcMGW8hBE9b25ZxcOJlYU4GlRNDbh?=
 =?us-ascii?Q?Sfo4Qg8uj23GCIi4EYzqHx0koo6Dks/TncIuZmmuoSXNRTpq/beLNT6OieqT?=
 =?us-ascii?Q?sj04R/gXm9gagV4JKIyx+7HMoGONK+UAn5HySo4dMLfUyka1h2Eo066gKa5i?=
 =?us-ascii?Q?Rb0ggCphoHes2typ/GKjoJMtOsRCna2yABR8j8PrORcyIJSe+gGrX+NGsugK?=
 =?us-ascii?Q?GBTj7VnpTq0w9g6V6rex20qOr55KEwtLW8FKPHSzwQ/a44Ic60G1CTIbPefP?=
 =?us-ascii?Q?c0mYuW/DP7gRpaDArQZOGunnnTwK1eJkhqxFosh8uEW+OoFp9PLm0+4U9DcA?=
 =?us-ascii?Q?2qL2reGEAZvxECmYWxRQngZUNVh+cagIb65kVkLatOHyBpnMtx3VV8fhPaQE?=
 =?us-ascii?Q?V9CuJ9F9djRQNf9Ic4asj87y4dbeF28gs3liFftcrXVdWgexX1xd2uy0E4gr?=
 =?us-ascii?Q?KTix29dLse2d/HPJFlLpOZSLMwdEpZkz0kyNTCYrJ9P4+uGlAR2ZJBo9Kf3k?=
 =?us-ascii?Q?GgyOIpazKwAdVPsvc/UtplAO+9vEGkyGPzfRJT/JAf2moFPP4lb6GaDwNSee?=
 =?us-ascii?Q?YVGCuE5m8smCaFgOH8uY8urcUD0UqWejCUwEHh93hqa4P6OB2mQvvKxVOWYa?=
 =?us-ascii?Q?ED1X6ejNIQArvtU20HNDHOtUg2nqcDAhuGArv6QQ7XxepJPCelogeuJkIESc?=
 =?us-ascii?Q?NCgDQ7d0V5V5SIDbi5DbGcG34dtydKgOwCm/itdEkH+hx6+AyOqq8XxtfJH1?=
 =?us-ascii?Q?+IjFitikpgyW+y1pzSliTGsiCofw8gVLliGFcZjkI4TgBFUcP8RB9vEgYgoO?=
 =?us-ascii?Q?WsgUBK3RyfTsmN8H4EnLWx4xv0i4NAWkqnxmP/vNwiDahv8ndZsmOrUnTVGk?=
 =?us-ascii?Q?zqAPOcisGs4+EXVs42Ss3ZzlBXol1i623XUEb7vKgfvj1HNy12InNdWlW64P?=
 =?us-ascii?Q?KNTNRMYo7ZnYcBw1GOEfRakfZ89fkuhgWtjdg4FO72vQ0tLJaZhy0F9HNouO?=
 =?us-ascii?Q?6t7WFKnGrYihU2CH2Omj67LIqg3pL+KCYA4v8SHQ71F/IAp7Qk6hjDuUukWc?=
 =?us-ascii?Q?q7hqi9D2R1GbvOTkcIQt7dHT1tXfRPgRB3EBYNR+l9EL5SD4wCiI6yJTz9Ah?=
 =?us-ascii?Q?nUjEV4SdyGHCzFxTbzwef+E22hOsQX5cmz56c3kc2PZ6pHn3VtsWYjrHMPXX?=
 =?us-ascii?Q?yU2eAtQWNflgKTcoAmxy0O6e6JQ5um9QdttP8FpzwjXBc3exK0cijL4OThBJ?=
 =?us-ascii?Q?+M7m3lcCAX1QSLXkZh+f7m1GsDSL3X5g55SIQTlIeGERE9flJ2kDPIg8tpXz?=
 =?us-ascii?Q?IDkBwWjmLhNiAUK4GOsNSzUNegPxGXnrD1rC/U87snHTsg+NcDerKOvkW0O3?=
 =?us-ascii?Q?/ENMCgLegoZuU22imuHWjLS8H8WMw4jrjDMXD7gpecgXHesI8oodfrSjYGcl?=
 =?us-ascii?Q?hkYIgcdn74/p3Oo2+NemMdMFgNBRe9II9n5ngQuaJE3XoZHXfZxfkSrYV6US?=
 =?us-ascii?Q?fuVGCi2bRJQ2FrScgKn+162UGK6B9aIJrfZXjiz/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NdA6wg9fFGuK4ggpNlBGPc4mai9w7m6RXBeznr7mYQ7zD6GFk8pUGzg5LTdq?=
 =?us-ascii?Q?e5aboRzh1pwJJ+xKOoYj9r2Omj0geLMk0F+Q5bgiA878ylX/GRBtNdAYK5Pd?=
 =?us-ascii?Q?R2kqCQiQQJ2PjJKH2X9RlLyQRedw1Ino+wujYJO8Ov1niPe+r0GzYni2x49Q?=
 =?us-ascii?Q?tGlUBU5KrqqaJyOOA8adI9JzgQkpdgEAYcmvKdEnKNoFhDzPMsN/Qq3To2wI?=
 =?us-ascii?Q?LcwcPBP3uydbJ8Pl1UJTKBheN36Jm//6Itft6LVzjYU2J/nwSWaNo4vJ0djk?=
 =?us-ascii?Q?n+FZRnDRU/7DJD8GwWmFa6O5gyzf1kF135AU9foQNcZTLXl/Xxx5WdIuIwwO?=
 =?us-ascii?Q?s8EgsNn7ly6U9UkCeR0FEwA+Y+QPcIOJq5gdhMGWC0+uCzU2L0+8ARa+cIZI?=
 =?us-ascii?Q?ijg8vjjeNwj26jlXUM4KBy/xQl6I0OzeQ/RtDzitteDRe3q80c3NNTIvhvJ0?=
 =?us-ascii?Q?YRmwtjMeWY84igPd4yQ0HHMx1l8+m47Jrlg+F36mhfzdZbrYZ/fwzxjn9swq?=
 =?us-ascii?Q?4RMYrlbM4GJXy52ujyCF0x65re4OboLreVw4H59JnLWZNYIduSbim/11v+un?=
 =?us-ascii?Q?6yiVz8HvcMr+ISCVoGCp3VFIsO5aNyr4YQGfuiCXVGuvktofT6znspZYnaw4?=
 =?us-ascii?Q?NkK9PPPBLZuEDI6kEafNcac7KVufp7Iv+ponHuafPtQNbBBgdTIHOUe3uPkd?=
 =?us-ascii?Q?HF1bEuSjV+2S6YnydGxOTkwXLYr23AnXyFqILDKkkEJMaSwz9FN/yeGMBkb1?=
 =?us-ascii?Q?qlOpNldkam1zDI5eE1TZOwCR9yKLSLmctsjsG3AC32nIWi43IHLt6jLrRRdN?=
 =?us-ascii?Q?+DbfF2xf2JLsBj6CuoxPU9On6PRVssZIaN9IKO2nZUW48BA1AnoN5KDNekJr?=
 =?us-ascii?Q?1zuswxyXSCx5O7SFEMP7GVJeda9xLOwYkh2D6WgnRaTWz6hKWfBApskChb74?=
 =?us-ascii?Q?WwDnhCG//gAc+IcHNi0XXgB6CaVa2vyqnbPSDbQX6qxZuz7ysn4FR6ToqTdX?=
 =?us-ascii?Q?jkIZwvmHx6hVPh3eXgyTpJBKdhcEpHlTJUaLqe0VnUuVnJY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b7751d-113a-4d57-af88-08db6b9da023
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 23:34:54.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTbKvUP6h2YMXOdS9n026UXELiUGtSFJciv9U4lzUI6QI6OCKWwlb85XS97q+z5HaGrUMsfKNsMS9OEFwfdNmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_17,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=723 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120204
X-Proofpoint-GUID: yLHsBx_W6Hm-bw5dZsmL_CNhkKZI7Tbw
X-Proofpoint-ORIG-GUID: yLHsBx_W6Hm-bw5dZsmL_CNhkKZI7Tbw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/23 18:41, Matthew Wilcox wrote:
> On Tue, Nov 01, 2022 at 03:30:55PM -0700, Sidhartha Kumar wrote:
> > +++ b/mm/hugetlb.c
> > @@ -2815,7 +2815,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
> >  int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
> >  {
> >  	struct hstate *h;
> > -	struct page *head;
> > +	struct folio *folio = page_folio(page);
> 
> Is this safe?  I was reviewing a different patch today, and I spotted
> this.  With THP, we can relatively easily hit this case:
> 
> struct page points to a page with pfn 0x40305, in a folio of order 2.
> We call page_folio() on it and the resulting pointer is for the folio
> with pfn 0x40304.
> If we don't have our own refcount (or some other protection ...) against
> freeing, the folio can now be freed and reallocated.  Say it's now part
> of an order-3 folio.
> Our 'folio' pointer is now actually a pointer to a tail page, and we
> have various assertions that a folio pointer doesn't point to a tail
> page, so they trigger.
> 
> It seems to me that this ...
> 
>         /*
>          * The page might have been dissolved from under our feet, so make sure
>          * to carefully check the state under the lock.
>          * Return success when racing as if we dissolved the page ourselves.
>          */
>         spin_lock_irq(&hugetlb_lock);
>         if (folio_test_hugetlb(folio)) {
>                 h = folio_hstate(folio);
>         } else {
>                 spin_unlock_irq(&hugetlb_lock);
>                 return 0;
>         }
> 
> implies that we don't have our own reference on the folio, so we might
> find a situation where the folio pointer we have is no longer a folio
> pointer.

Your analysis is correct.

This is not safe because we hold no locks or references.  The folio
pointer obtained via page_folio(page) may not be valid when calling
folio_test_hugetlb(folio) and later.

My bad for the Reviewed-by: :(

> 
> Maybe the page_folio() call should be moved inside the hugetlb_lock
> protection?  Is that enough?  I don't know enough about how hugetlb
> pages are split, freed & allocated to know what's going on.
> 
> But then we _drop_ the lock, and keep referring to ...
> 
> > @@ -2841,10 +2840,10 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
> >  	if (hstate_is_gigantic(h))
> >  		return -ENOMEM;
> >  
> > -	if (page_count(head) && !isolate_hugetlb(head, list))
> > +	if (folio_ref_count(folio) && !isolate_hugetlb(&folio->page, list))
> >  		ret = 0;
> > -	else if (!page_count(head))
> > -		ret = alloc_and_dissolve_huge_page(h, head, list);
> > +	else if (!folio_ref_count(folio))
> > +		ret = alloc_and_dissolve_huge_page(h, &folio->page, list);

The above was OK when using struct page instead of folio.  The 'racy'
part was getting the ref count on the head page.  It was OK because this
was only a check to see if we should TRY to isolate or dissolve.  The
code to actually isolate or dissolve would take the appropriate locks.

I'm afraid the code is now making even more use of a potentially invalid
folio.  Here is how the above now looks in v6.3:

	spin_unlock_irq(&hugetlb_lock);

	/*
	 * Fence off gigantic pages as there is a cyclic dependency between
	 * alloc_contig_range and them. Return -ENOMEM as this has the effect
	 * of bailing out right away without further retrying.
	 */
	if (hstate_is_gigantic(h))
		return -ENOMEM;

	if (folio_ref_count(folio) && isolate_hugetlb(folio, list))
		ret = 0;
	else if (!folio_ref_count(folio))
		ret = alloc_and_dissolve_hugetlb_folio(h, folio, list);

Looks like that potentially invalid folio is being passed to other
routines.  Previous code would take lock and revalidate that struct page
was still a hugetlb page.  We can not do the same with a folio.
-- 
Mike Kravetz
