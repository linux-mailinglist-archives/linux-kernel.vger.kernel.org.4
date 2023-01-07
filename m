Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533A6660AB3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjAGAQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGAQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:16:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76397FEC2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:16:27 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306NXUXY024443;
        Sat, 7 Jan 2023 00:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=bsiQcfYWYhz0V8rWTuuZWoEZCtrJ1nbZ8cVESqFtG+g=;
 b=nTTaN3glBEMiDRUUHKN9LuazmCCKlXYOsd9wEIcia66h4uBOy3xOMOHvTfwFbWJqyRrq
 lKKBK+fVkR2HA26lbsqHa9U1MmLN+23nkJfjcRgIYHtkRryTSkOsjXZDxZNYadFzf41C
 wTiVd/BLLhC/iVqMqm6HqIaPFTAvLG98h32VQ5YbqGZh+QFf5hY4AGpFdo3bznCwbSdI
 OR23ouuBp1cdrsttY2oT2PfbQb0pgAtaJNB3FOI/6TetuHQ/Un9mIU7Y7b+i2eISN6u/
 7jvertrbwtrBbUEa2halX0Kv1ZrVxcpvnSvMWnHCv+FnHIczXRJGBSiNmLKWpCKKCslR OQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcyac63q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 00:15:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306NT1hm032494;
        Sat, 7 Jan 2023 00:15:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwft1pxk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 00:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftSNHnTyU4vosrly4fkOxWtxHCOGAd7qVyoeGDZeqUiu1+Ilc5SRE6uI7MBC2euF57UqtmpcifGBODIBFOiMrgORaAwyL2/lCnMTOgqfUiiDkUTkacrW5SQ7RwLFr5MDync+A38igNAztq9xvrxcTdFQgboeQHBdwwdNFfu397EyWWUhpPFq0rh/ynkbxp1zJ4IW5J6vfCX0qvltzNg2MM7sV/5x1wPMfdMTt8rYgtcEyMgftszrv1Eu5pnBUBxlRO0afdSGUYCOa6aYzqP44v4oI7tLNonk9QcwgvJkqAVsnAXEUlsqAP2/tuKn547v9kjipH1ZJZRyB5Cdn/fbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsiQcfYWYhz0V8rWTuuZWoEZCtrJ1nbZ8cVESqFtG+g=;
 b=lXvm6OTmZTJ+nUsfZSFgzSr6+s0rdLyXphsSqJTItzA5pI1I0HpsOovQyskpNvL0LghtxCMSPCCAFui18MvNjagU34Scs/VMBhi0IGT04nPLrZ+C5JFPJgPSAHZ8u49u5IBmp2h3GTV5QCuzSonX8wWeIw11qi5b+9Y118ZQY0pBt9kf0CTf5Eg+UqAV7pX/bpbmwJA7C4p0TKj70NwJ0y3ZfYp3KpMNmgRIKsCHkvtYuFGiRt7i8FG/w+ibr3RdgLvyXEm9PCAI/DF+wcYIxsvDsVRwHlc4rbL532Jd4RAHyb1MIYg49TPAhhwbqAGEDHBjkhFI46gV5zHxDfGZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsiQcfYWYhz0V8rWTuuZWoEZCtrJ1nbZ8cVESqFtG+g=;
 b=M8959dNz7+RpO0kx6Zhf5eHGUYMACs9L7WkXLBcla+p+FG+4Mzk1LMV+WSVhmD5ONK1sS/AyMKOQSNUJQOIRK3N4bb02RcH5hbMatKMjIRxo90Ad95bS6bZfA00Gi5NJ3erxACIhZx3V8PuVNLDmdTTAHL90HT+/TxyJVpP86HM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4263.namprd10.prod.outlook.com (2603:10b6:610:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sat, 7 Jan
 2023 00:15:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Sat, 7 Jan 2023
 00:15:39 +0000
Date:   Fri, 6 Jan 2023 16:15:36 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 4/8] mm/hugetlb: convert
 alloc_surplus_huge_page() to folios
Message-ID: <Y7i5qODkPz1mcow/@monkey>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-5-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103191340.116536-5-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:303:dd::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: f5de9e1b-0c54-4738-cb36-08daf0444e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTO8IO6zazAhyCVjVFfo6ufH5flkzYe5Ckm0n1kjhVQf8Fq9dFfibbGcEQw1zyvmXZHdADY7pxSVaLcOad1sl+SLzQRn0z0GoLroJEqd74c/mkX6Cm4X99jEN51nPSkDP/jCLya9PYxwoLc4m8eCXLg6SbKq0+7pP292375hRbpvYgAfQg9x+rzRL/5JQFrarhoz2DBlgeKgxy+Cui0vG4PKmauvL0hFR7kp8Bl9Mq+S3uv/i/p0g1N0qiN2GwR2PnRdkqviWXoS5sUS2WG5/koajTjLBb8uYrvZTvjBfWwD+pEDHkJfWzbO+UHfSMdn07v2o0s4XWEuGNpoM3UaDcz/DKgTRj83KXTkwwKJ8UXGEMJElJMLmvnR26IKYklbn5q1xFdcD4CLeqcg9gdoM16Ea53nG1lEsgs9Chr/lT1JWaYEtS1Dk03fMU04AlUOOBtw0AlPMkGuOGJdRH1LCIuX+lKTCDG4yxs0VaWruP1k4Wx9Tw4TwAwS9/jHBOwc/5JJSWOwbsE6X4vaLQ6xWrJUj27IDpm+hOfOC5RaEEWl1CrTNg+2KEgz1XloGrwcejhzOxDeUzl9kiw1CFxmRrDxqeB/3PDDf+4HrzFJ9oy/jesUj9CLYDWTFOVtOfZqttgulBTptt0jT8jFfq7ektY1CJZjEg2ZTEgBJHQaSVkBpsZp2nol2lH40Qk9r06O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(478600001)(33716001)(86362001)(316002)(8936002)(6636002)(6486002)(38100700002)(2906002)(4744005)(44832011)(41300700001)(5660300002)(6506007)(186003)(53546011)(26005)(66476007)(4326008)(8676002)(66556008)(83380400001)(6666004)(66946007)(6512007)(6862004)(9686003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M9zNlpy7MVCXY6r3pxTmT6n7typF6vkoh3EVktcJAzW1H451XaRv+quErhFy?=
 =?us-ascii?Q?xiD74vILp/sC0CamRoFbDqPN9O2wAjaTncEHDly0awkQaP0DLdnM7vaFM+lo?=
 =?us-ascii?Q?GnchT7BScLkHLQbpSS3zBjspGEqDs/m9cStmqh2bkBc6U0E52yQBdHz/T/VN?=
 =?us-ascii?Q?Wb87nJ18gULTP6XRWDFljYcR5PPfPXqwZ76UEBQsXLO+o93Vxk6QeM0q59n9?=
 =?us-ascii?Q?THdk7fWT4RwajDrzugCx0EvqT8cmtYOc8bYz6msRXbiiMGV3Me5y/l/G6eQZ?=
 =?us-ascii?Q?mcm14hgWhy+0yl6du9X6pFTKTL6/v4limwHFCZvra8cTLARBTp5XskKHxvIa?=
 =?us-ascii?Q?ZHs5TJE5s4UWp5TGohEKJlEmfynGPm7HSut+VJEZ8GtcLwteIlunp180HCfA?=
 =?us-ascii?Q?BcfPpWeZFSoPbt2LAfTtkUHgo5MA6RqDT7ljnoVB1jf57UV5cVxdsONeWv5f?=
 =?us-ascii?Q?+lKimRkIBQEMsuomIdzt5emxH2aW11x3vhudGN/X5daXoBiD5s8IY//5o2UK?=
 =?us-ascii?Q?AtdKofOgRs96Yq7sOHvL/bvCd3TbkXlW8AuZLjTm064b2bj/qkWV9mAg5mEJ?=
 =?us-ascii?Q?QXv7UyNppuOdLUHWiTsjUyB6+tWKw6pRHfdgM0m9FWABBEJp+TgctmyWV0eH?=
 =?us-ascii?Q?GhOuicNddqfjiNWyiI5fAy0fCMLGd+FjzFpOKtKCKOoWoyzK/Rqi8ybbc7Q0?=
 =?us-ascii?Q?Au7GRBOhtfu/xLDLfH+MTLA3ad5KsWsRpkNQmOGYCL8eiHrGhOeJHPUuiyac?=
 =?us-ascii?Q?+SfB2qTDVCXo1WYZTOGHgg1x7Tj2H9E8iNzqSqHXsGfFEVtT1DcO2dU0IFmc?=
 =?us-ascii?Q?edUEtQLqhqZHjKfQ/JBim3ApAX00ncQtV1H+z+XbKmQPOKMEGoPI6eMFEDKv?=
 =?us-ascii?Q?YE98w3TTboiaqgNRUTh4wIxzMTS7ad6x1MIUvbKoc2kQ2Mh1Pz5W/IpnTZDA?=
 =?us-ascii?Q?1dC8kjN5U8WZThBDLVl+K8oj31Gp7vRtYsNIg0XEgT3JtsyQJQsgetRsroEg?=
 =?us-ascii?Q?xItki0Zm714nVQYL1CAGtvK+aEtEfxk6x+VvAjA8kwe5yweVKFEHYKgLu858?=
 =?us-ascii?Q?CtU+iQ1/8Ev/yuTmXYOYY1euVlsP94ROxrIIUTNiLgL68Hpld6VYyFL1ph4v?=
 =?us-ascii?Q?1FYAigI1RMvlHSibOZh4kdAsYd1dFnErJjblAdG07if7kRa+mYdDZGp8l7HG?=
 =?us-ascii?Q?JbZKTCNN3NF+OxnbkrWXQZt4GOptKAKoxdh4rNSDEq8F6tjWqLxwkn31Q3VV?=
 =?us-ascii?Q?t3avRIfAn/LARksNwyJwKOD2tHsyUDU+ac3jwjUXxmGz+gYwgJgidbmfCqbW?=
 =?us-ascii?Q?Ftj21LHHCOsswDG7w0RJ/11BRJ4IYS34vt9mNAJEPp139RG09pw1OAQE0801?=
 =?us-ascii?Q?bl56bzDR2fHBYJkkiGIxNxK3Wi1hR/nZfurJKjQHnSfdlUJLcBXH+4AXsyo2?=
 =?us-ascii?Q?UmF14jj1pi3x8aZ6kNARcd3E437tbMcBIQVg3Y3ZGr54YzXdJLSDBRi0ddSk?=
 =?us-ascii?Q?bfg5BIoWkqV6VEOa0xdq5fP6SE3rGN8tyMI99oluApcr3KZhOwZHYTOjjy3z?=
 =?us-ascii?Q?aXz9qMOzq0tJIJwljAe7pVwY9lsXTPzAKf5TKWJBO/TuPkhU+n27Mtli/mvq?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vUAuFvmMrPA/7X71ZFggRD3BzPh92j9S96b/xUStPUzE9qICFTof+P+gSa+A?=
 =?us-ascii?Q?x27g/1qFA8q3f1c+JtFGo9fjFwsTNa5UXQ81tXwtQJAC7d1hVV2tA3BA5UVE?=
 =?us-ascii?Q?Hzn57JNQuzG8iYmzqdh6rVx/b3ZZdmhZtRnkE+CT7f9W5VSgRZW941Y5N716?=
 =?us-ascii?Q?jehio36buESA0jUDw68FxiKKJ1k2grg7u64avATokkyWrusT6Tz2EIXh4mvX?=
 =?us-ascii?Q?xLfrPZyihSXdm7wS5Ewltdnb/U0R7DTYF0wGLrftHMxgN3IMZ86fqHhyb/oD?=
 =?us-ascii?Q?GWqW9pgnG8oTnlvsJPsS8HgiALLmydHQQ6BM/KLvbD3pOIk93ugZA4SU0tsT?=
 =?us-ascii?Q?kDRih6wWOUWdm3nyrLmFvW2wwjP0sEFmJAxtu+9EIsK2KoJVySIz6girQ/Te?=
 =?us-ascii?Q?WW5EZg4Nhrc/SOOHdTr+yIyQ3w4nergPxFnrcJxSzWOhC58eYZuyrC5bh0Vh?=
 =?us-ascii?Q?cMcr7EDskoxVU0eBTYkH6pua9ltUtd8vyGoWc5eNG1XVuw4G9rpRR/lWswEF?=
 =?us-ascii?Q?vE4CmzebtVPOgn8uwGrVT4+UJwnXCUrRZ+LJjU76mV6pE3c/AlH9l7ySjxiY?=
 =?us-ascii?Q?6EOGx6bUkqaCC1yjhDOYzvinDxYfrHKItTdxOuD0mRokBdUXfON42+Jt1iZA?=
 =?us-ascii?Q?XXHjxhSzKav1yDwPtYOqUynBFNWFtRFmeIlulGFQzkt093d3+N8cRzXGjGnW?=
 =?us-ascii?Q?KkudHu7gXEFaFj9jYV+XC7zj5Cx058vK8GbvSGdAVbWLXJU+KT0aIcxQS6pe?=
 =?us-ascii?Q?/4wqKf7lnxNjwAeNdDNbn75LYPIOPWS2XlUr8p90r0cvEpnc82BRxIYbrRrT?=
 =?us-ascii?Q?u7KUsmy2r3ZhrzdLmSMPiaAPYWJ0X5ciPOUsNN7EB9foSN2D4/v3yzIsVRCd?=
 =?us-ascii?Q?yfP2XzNmkfPZFlqWjOa1CEBQY2WjIS1D7C55WSwPSrLmiSAiRQoXllNVQbkA?=
 =?us-ascii?Q?OvvWLOdArU1sz9VfOUT6/6U98bzbgn4r3EsL65z6Onw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5de9e1b-0c54-4738-cb36-08daf0444e49
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2023 00:15:38.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQ8xO+VFbiyV6Vo0P8v/WBhUcfHFJjyPFES8sBYdMvkOOcqR/jUkVei+dcarGVfGC1ARxSZ2yOhXtI92jWnW5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301070000
X-Proofpoint-ORIG-GUID: YiEKvJMAiExP1fXV4XdkgIqt__c5vlI_
X-Proofpoint-GUID: YiEKvJMAiExP1fXV4XdkgIqt__c5vlI_
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
> Change alloc_surplus_huge_page() to alloc_surplus_hugetlb_folio() and
> update its callers.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)

Looks good to me,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
