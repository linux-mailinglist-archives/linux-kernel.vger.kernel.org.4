Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9332D66CF03
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjAPSmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjAPSlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:41:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AE42ED46
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:34:58 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30GIO00L014849;
        Mon, 16 Jan 2023 18:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=FWdcYio7b4jnYw4TdGz8nRcnfUAyLh+t6FwUIvmc9os=;
 b=XFp3lsv5U8zPuD8WvTT6Y78Nt40Z3Kku9Dcx7dxg6Ke4VaOj8eyCU8iRVkmSjolL4CTw
 N8AkLiPAlHfsAgWygR/eiW51kushuulG/OBlCLCFPKGfis54E2MrT6vo/fNSX+JXoIlC
 dWKWVGYndonSB1A9dUPTAE/mJUyvsR8VSVlXidIkgZYm2z3NR7wqFb+P2H2OsD2E++RR
 KXiUAoZ3870O8QMKhIAyiuFEGIw8X5mFkB1DYmYWBGkJmTce+WiPlhJ1ytVRX/4ehG0L
 ArpTaEZ8ZTrnXr00LUofmVL53PYOVEqJA5HS8jrNRWsBdaMikaQWIkAhES/kW5JyDDLC ZQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxt37vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 18:34:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GGkFCv031093;
        Mon, 16 Jan 2023 18:34:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rx3xb8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 18:34:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHf0xG4OLTAA7GnNmqQRgqvc7taPUgYVIBkhU3nXMZqE80saDKnAp10XqPNLt2BGsP542Ss/LYHHPExfiB/PfpjN5QnuVUNseyairi5tlibMcPd9RKC6w1r8FQw3dqLEY1T4aJBGdYdTpY20pn552FwIDyQzH6uBcA+VgrGQ5BdWmlMcQ7FWY/dPmSX4A74Hs77FgIa94oLO/eDB0H9wOWKbJk/smuQgtR83O64ml7ZLz/DyoyMnqx8jiQMl+1NbAGeEkwUQd7SRat0WRbwknyWTWQ5TiyV0oyF1ih9nsp5Uu66RQIUaJqB7juGSZEw1LlWDAaJQxfEGwT4v7ot26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWdcYio7b4jnYw4TdGz8nRcnfUAyLh+t6FwUIvmc9os=;
 b=bblmcT80l9QA7mB/dcaiEQgDOXgsc4dAx+BZk39M0ozP2cynIemPmEHf840zt8rTKaZLYQ6L2wotyGFCJLDgS5BGMAyECv3Aw6qawYmeq/xnj5xIdOAAan11o29eizJu827Obt3WvFwh2uPjgmE5BLmvb1x6JgVz2uIC5D3emqPleMGLSjtOHXvrVkGBDnpzX5NgahwF3nrvpinOJZNfFnFiet9KcO3dc7YlvmqtHbplwf+VirsRLnaAufsLu++tuFqxEp5YgG6eEkdj/oCQjuR/S6wAKISl3ZQbnNVjJ3Mm7P0nOZDqgRUhSMIhY8XQEkMjtfcDg8gCOrn4txnFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWdcYio7b4jnYw4TdGz8nRcnfUAyLh+t6FwUIvmc9os=;
 b=Nvk1eDmU89JM0l5V0D9019Xo1NOFbPVyC9jLOcIWdVXP88F1JnChwhFG1AHNV59FzUmRLytnWtPaXzOZ6kWftq1+4lYKvc9kIfJvi3WpnbvqLWpuJiOn4wqXIs11tU9C5VYRxplg2sIwF0oNIDOoK7wM8terP3VGE0nD/tR+d6g=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB7352.namprd10.prod.outlook.com (2603:10b6:208:40b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 18:34:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 18:34:41 +0000
Date:   Mon, 16 Jan 2023 10:34:38 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8WYvmNdSkk23nbO@monkey>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <Y8TBbxcc38GsLmjx@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8TBbxcc38GsLmjx@google.com>
X-ClientProxiedBy: MW4PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:303:86::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: e793496c-f806-4072-2c81-08daf7f05448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCasZWWI6DtQreAPc/MlTmJjecwiUZ9Kx7RID5gH7X3YqNyWZpSztKkwWLTkLnMyVMr/JfFzPVGBV/kfVXJ6VhjDLrIhAJuoHVlbiMnrY+C+i7C4GyQXMDwmrhg80VqNwUYWnminipQ8k2uMTq7C+EKUxHSRXMHvL+FcNmNmGIdouiLa5i0sCyvqaEAPkChwYZwxUY6bL0IzfCzj8qjxLfnMf8wiTHAvYBwsidWmYrkQHBdQNIf0zdXzCHLcSWGm4rlZTRunixMIIIgl39Hk9/veu5+96+ipxg92FHGdYA5uwqZj0JcVdlAJ+g83e8sCdZsYjvu9pirWaLkfeTMhqFjPPpzpdTrbQgqUJuimd1V0RYAnGUrIYiUO2TqkOwJr/SwYHl96drouiSQHODjpq3DWU6UKwe0/DO+V3W1//hTjKnadHgZZh1zm50Lihjw0VPIhc1sR4MiuO0cVk1/lnW1HEPdnVDix0zxAz840x2/i/4R8iiGYU/nmqBYUmTVuQBydGb6BWO73fI09LFXr05GYTtf+lICeoPOVMLiWog++8ZM+t20oRfyDBTT9YZX8tR7oHOARalJPWgR6HOZJ+swkihOq5j2vA0sHoTptwUTitpkTZaMF4FhPi+BHCHiRsWR9mN0mSoKfALblsRKLvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199015)(186003)(2906002)(9686003)(44832011)(6512007)(8676002)(316002)(4326008)(41300700001)(6916009)(26005)(54906003)(66946007)(5660300002)(66556008)(8936002)(53546011)(478600001)(6486002)(6506007)(66476007)(33716001)(6666004)(86362001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M5fvC8v7BDuj1LBf4nGsVYbxlaleyPUSp7tBDa5iZ5CFYTt4TzEwfBSFI5NR?=
 =?us-ascii?Q?bIqpLvtuOKcM5Z3C5kHpl12Z4m9uiNXNq3NPbaCG6djyASkD33qVYVquAmGl?=
 =?us-ascii?Q?4O9gHfYQkRuOUmSX/nyMuC+z5uquuJbpnBo8+CvxNF5GeSNXznso+KiQFutA?=
 =?us-ascii?Q?5VSfhvQwhQsDYhItzo1DmQR+W1YtGbvfw5ffCnDrNaQQSrNd996jZvl8nEpL?=
 =?us-ascii?Q?HUvMRdBA2UG55e7+nVOWp5in21A5PdZOXvUmreok4pPhM2oBZA2RcHbdC0wW?=
 =?us-ascii?Q?UB2EP8X/WudJzzwbYQM96wq7njVZxZ1t8sb6aZmAyx3q5eE/iQi934FYGtYB?=
 =?us-ascii?Q?yeMiY0Qki1ZpKXvQpKkiILefwvMrtZerVl72JoL8e258aABgNrTK3rUOzBiq?=
 =?us-ascii?Q?yzvbGRb/Cdnfk20gCHMpLLv3qQasp2O8rqQUGYsF9bSlQ9AGsA/3idudkpoc?=
 =?us-ascii?Q?OPGeGl3vWdVAFSJKpyc71n9qkdhq0kZ+F3dkk8IK8hqzWfhHFU5PENnC3A4a?=
 =?us-ascii?Q?dDMiy5b275cl0LizVAVV9n0nB5ySUVaO+ikjqeONnWaLGu2yRsaEpFI3FV4V?=
 =?us-ascii?Q?CMNwIJUFUDOBgqhpZ6GRajqzK6WW06lGc7Vw9kuwjEDyknTuJCrrVAJJ76ua?=
 =?us-ascii?Q?8w1+DIO2/JHgrmFQ3VG36ZhUssH3g3kTMzsF3bSnGCgoy3LF8/O56tkdaBEB?=
 =?us-ascii?Q?RoZlJxe18yZM+uSxe5xT6xkip4XsiiKKjR5DJ3B11F2ZPeAK0siZ880XsAOS?=
 =?us-ascii?Q?S0KzQLKMrAoOLmH/CDKJtDIK6mKYdkk3NemTRYd2NLEs5eLiGgubLyqGfioh?=
 =?us-ascii?Q?zJgA0/7VDTrVsTtlzRAlzNoSO8iXczF3kqmzLzYuVZqEU6CPBUov6YbgPAKM?=
 =?us-ascii?Q?HIvDW52Rl7SwUP1gtaMAxUos2MIpmc87wVryoCHCxJrQphM8WguQlV07YIhp?=
 =?us-ascii?Q?TaPqqADXjHRYat6TVjfRHR2/3tIUl6KRhPimpdUkRwxXNJjuYF7TmwGU0Fjt?=
 =?us-ascii?Q?5fjfhjuevH27e0c71yogCDqhkdxMYed9Y8AQfkJ+62y0q/DjTepVM3lqV+Eo?=
 =?us-ascii?Q?88efs4U0ZkOIbg1GLzobQmWvgLE+Ob2m1MJDl1lh89MYf94gQ5fpxOmb4ta0?=
 =?us-ascii?Q?dqiiUjkCOtcgSc9mZMFxrmY0hIAUiSydUlL4g2iPFXhskJc064uDb+F8RWAC?=
 =?us-ascii?Q?g4ocPM2anW/WVZ2OdgJY6+f+cPlDUyaayC8YWBXrWaFbfmRaeqefNEy7uRtJ?=
 =?us-ascii?Q?XkW/kEbdJiXKDTY7m3wSiZmTMjJffuRjeOFCn+I/gt2D3PJWlTSayd6RZEBr?=
 =?us-ascii?Q?GMI7UmSq4p04TthtLtPnRPWKijoQOcidr3VHji7jwmag1tXRWOWBaXX2WG8r?=
 =?us-ascii?Q?EICzH68D0cbnFjiiEVCcQrOP0HO5DjZKyUexwhfArPvzQOcvmdrjTN89l5gf?=
 =?us-ascii?Q?m36I1mRsqiLKq5rcoFok4tcR5yfixZcNnWjBycnr1xSmvMYzJmwLwCGanBTm?=
 =?us-ascii?Q?V1+wiJ/MCShGgqHnpeiYB6A4cxmdUCCYkJ3aGwsq14lnHCLWmtu3f3b9u7sk?=
 =?us-ascii?Q?Ld2184CcHSDWKNGVVWTm/b//Dx3oMtZG5ESACK8oaLgxoBDGVXrCJ3EgBTbb?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EvFghjJBYEnCEFEjtCLLj0FAOACezFvxUouOxl8nFFWfTT7AumXdpr7N/31nGoI1ljuk6stNHaxXZLQgSU9dolLQSWOZac21Us3fvXR9viwklq3spRJWHpZ8K1Fanlz3oNgAuCr7dVG7PDZ3kPRDH3kOXgwyvjfH507ZhvfW/T0nh8W25WZv1NaGoPrb+YxRWU+Zv+C/q9X7X/MCJb8kzjMKS5UNGiyBWgt/L4/DYg0hhuaCADa4XhpySXbHy/jZqbGFGEAK2xeBz5pJ+YL7raNvEW/WS6ElNdLKkIqISCUztXPxjHNQaSJODN2B1cn2LuwgTsYc5/upguJ8jnxhEVCouahL10Q5Z0P08yhJBhrpaff6OkHul9Gp+MVOU38nJ9tRjvNnG0XliK5lW4M8ITLW8L8YwcB13909g8Pj8Re1wDufEFDE4wkBqWpMBzDbRFAG3KJplF8NiU0JWy65+N/CRtdXQqk3ot0FWb+qZr6X44fcFJ33AcCVWoUrL2wLjLbbSrgQyLF6WD4P15FuuwVFjOrsLIG/d3kcAwQSppg4l4lJ57URYdwWefA01ywMKVZ4niHhMys7xWXABADFkkTsvhWa5f3loFpfbLlvw1P48sab/pqM/OiseFQdlcRj2KKmQEaOytFeK84dG9TznIK6lo4jjsjuOg6XuwZJU8BlKCxFjYG7yTmzDn8qHROpaGo3V6wrKMnaBfl0WHU/sX7rpStAYka3bJpJEyl9/9xunv6pQ2Rm4pyqNO5dN+pDMh1aJq/pgCBfBsYyjGk8tSexp82roCDXhwjAFlKc5jqzVHWkHYcLgHncWz529U3r3xcNqjwCrjC9L/nYlby0CaUZJ6PV0z7f2rI15+jaKDxJzN5HUJWufkm5tx4egzlk3jVYpAPcNMNRQoznuULAQQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e793496c-f806-4072-2c81-08daf7f05448
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 18:34:41.0510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruNHN6cVX+DBdPWi+P1FeXL/6hdEuNUAHXWEx2pxSPCC/rkUJCqoZdrBd3DYXfRsj7FiZ/QxTsHv+I09h6sP6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_15,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=829 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160138
X-Proofpoint-GUID: gCofOHV_6rFgIE9Z0JUlVVjPUcflAWXg
X-Proofpoint-ORIG-GUID: gCofOHV_6rFgIE9Z0JUlVVjPUcflAWXg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16/23 12:15, Sergey Senozhatsky wrote:
> On (23/01/09 12:38), Sergey Senozhatsky wrote:
> > 	This turns hard coded limit on maximum number of physical
> > pages per-zspage into a config option. It also increases the default
> > limit from 4 to 8.
> > 
> > Sergey Senozhatsky (4):
> >   zsmalloc: rework zspage chain size selection
> >   zsmalloc: skip chain size calculation for pow_of_2 classes
> >   zsmalloc: make zspage chain size configurable
> >   zsmalloc: set default zspage chain size to 8
> > 
> >  Documentation/mm/zsmalloc.rst | 168 ++++++++++++++++++++++++++++++++++
> >  mm/Kconfig                    |  19 ++++
> >  mm/zsmalloc.c                 |  72 +++++----------
> >  3 files changed, 212 insertions(+), 47 deletions(-)
> 
> Andrew,
> 
> Can you please drop this series? We have two fixup patches (hppa64 build
> failure and isolated bit-field overflow reported by Mike) for this series
> and at this point I probably want to send out v3 with all fixups squashed.
> 
> Mike, would that be OK with you if I squash ->isolated fixup?

I'm OK with however you want to address.   Thanks!
-- 
Mike Kravetz
