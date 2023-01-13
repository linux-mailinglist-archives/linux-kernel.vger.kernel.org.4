Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E93668844
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbjAMAOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbjAMAMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:12:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9619E228
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 16:12:33 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CJXpj5031537;
        Fri, 13 Jan 2023 00:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=xE74zE46SMxHMw+I74CWb904QuBbkN865bfi0ahflnE=;
 b=NGf2fEkeLb8F+VilNOmnJ8yFAkMO84fmUkd9sCXdIO/fEF3fNJM6dzXpRmVkGuxs8m4k
 HzDBSV2fl1R14uBuGlyq5aCc9yTRKJk271+ASuUyybSlYYi+NAV6rJ5sW+juV+oeeQu4
 IPm4ils1piflJqI1C+c0L0tvM4CMhud2La862KnZRdyoi4ZdvobeFsdbKhSvMTHga+d/
 ufs5alS79LNX7QjT6IkdzVVNbSUzzNdWOO4V8s89nWkFrNT2XYZNuhrJFEXi2tZmhE8M
 OdcFhMG+MLV5ttv+dJ3xXbTqPn303H6fWUs67ds2n7QCznPFbngRY3UpB02U+fokXNiA Pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0scknm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 00:11:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CMJhvC015991;
        Fri, 13 Jan 2023 00:11:49 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4rg8jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 00:11:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUsozvz1UQZ4vVJX/MV6Z52WErDc2VX7baNo1MfpHwVWq/JmjlhBcUgDiUVgiWfDXbibYtu+SehkLTNtMejCCGli7scZxh1cRUA2CQs5CRqHT/eHm23Uruk0ybZACqOHbE+fvKdbj3zjguu+CbLiRsBwu5Z00kzJRBQdvg04B8FD3lcM9HIAP6nj9sMEW6BvSBd1tbw9zK/Rv3RZJDxIvv5FZ1V2dd7GIvDbTb0nTvqHS4338CKoPcOUKPR0xVjgei+6WMZCKPzpSM95D4+2rNFfV622JNnWe55ARD3G/HoKtzgBhRaWuuFvQ6XGs3/isvMSZ4NeJFEDAqQosNVy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE74zE46SMxHMw+I74CWb904QuBbkN865bfi0ahflnE=;
 b=B2zpJIRatzTXE/5RLQPkEn5R+7N2Vcf0CdakHSO7ib8oAiHZCMTjjlIUuwBqHvDLNXu6hllhY60tdpXDmz+OmieYHQUbPikHYMsANohAA9zwgu/0DAh2KDqx4ATGmkRNOG177dqwFzFnJ4QvZeFE/0zdLogrtOlUDWDBQkpv/Hj0qGyE/oeNPdDG7uQJyMYYRNfcMMHCFuU4bP6RmhRXoHfnHhPOYvvSdJXyUZ7YMGlY96L0byzrkMrXLLnjNoan4xJP7nUs5TVM2iRe5pS6Qv+5QP/MExyt24T2BNIZGvWURUior4IfZggbZo5rkMHwSAfBpqd63aWGeDHew2RNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE74zE46SMxHMw+I74CWb904QuBbkN865bfi0ahflnE=;
 b=kcT5DO1zgpLemcqtVU8YLmMvA2ERZSIXK4SW0YEAdop/EaQf3v0EKrEYpZKsfBw8Q9jyizZgIu1hh6oIZmlFuUjaYzVe74/0MKrew7Ax/zx85aVaA0pog0JmFXN/XEfxL9A+Au2GWIZxqpixkS+hoVlpME76pldiS7xv9Qb++kc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB7448.namprd10.prod.outlook.com (2603:10b6:208:44d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 00:11:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.012; Fri, 13 Jan 2023
 00:11:46 +0000
Date:   Thu, 12 Jan 2023 16:11:43 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH -v2 0/9] migrate_pages(): batch TLB flushing
Message-ID: <Y8ChvzGVG5Tm9tQQ@monkey>
References: <20230110075327.590514-1-ying.huang@intel.com>
 <Y74WsWCFGh2wFGji@monkey>
 <Y782h7t10uRVW0RC@monkey>
 <87a62oy5o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y79tTXgEeuzzqFho@monkey>
 <87ilhcrzkr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilhcrzkr.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fd8f3c-11e4-478a-84cf-08daf4fac248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bttsbj0Sif0qEv9/TdsmTyW5NQn9YB3201K7DUK+CXCREp3TWtuaPgmX0P+2h5GqEFWWF/9DBg084do8YXi3IqQpGiqbV6A5bMcZUmGaHH2EDAvYoM4uMBzh1DYhj4BEtFEaOTIV46z9iGN/x9W/6zyp9ex8pl1hEuZTKCKhdSN8BuYs1fRl5Iv3Ob97xLxsc4lb+xNokopZBhHdOZrAeanVBAVzBmRSVKcdbllzId7SY/9HGNn4Xbecor1Uf9STf5+CIKEE/1MZTCVy3O1kHm4CyztLamU8Lcj0darperULNzoOs3kZ4XkDHRlLcZuGrMol2yKSrTuvkwFTPl2Yaweis+YxiBlrNkBS0PGXqhsvSu78x4WM36lpvgvAe41b6MXfHumrme9q+bYCyUB/l962Tn+LVJqgRzZMC7XYPchYf+Mvn7juA0oib5Wr5wk/vmhdPlutYvWNxSarlL8mNMQ7j6hw0UDUce87s+nsBQQ97cDCRWrCrWU3+hBlwIIWm5bpmlmSC+aVH35ctYwCLH+QISAFLvvfBAgXnmy+7jXb5lNb6qX3vlRRqvpmM09W5jBF5j+OsIc1/o4BbQv9XX4wiwJSPnwQ4E6w3cFbBOXSeycQXSJWIrmbBeRdiCsekWSpnctDYpywTAWVDYAvfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(53546011)(6666004)(6506007)(6916009)(66476007)(66946007)(66556008)(8676002)(186003)(26005)(9686003)(6512007)(6486002)(478600001)(41300700001)(8936002)(7416002)(5660300002)(44832011)(2906002)(4326008)(38100700002)(83380400001)(33716001)(86362001)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VEXpAxdoGV6yio7BAov0SsJHqV6Hvl3hH9cyt1UJyqBrLiEHrgMrs8RLpv8x?=
 =?us-ascii?Q?yBey0+0km0Cm8s/4+9x2EpdVQC6UQ5F8tv7P5Q4vm7LzKmGgXT+NCBgRSZeX?=
 =?us-ascii?Q?GYO4Z25cBulWSHZL3JSpQmlNLgClh1oM/X0GypZMX989TzfP0LWgKRCWnyyK?=
 =?us-ascii?Q?n6YYsFkz+M09xgMSToraaPIy2qbNBQKg3HloHqLy4Lc/4tvZLYaMXADciP0i?=
 =?us-ascii?Q?HIYfXKGzxJLzSpry62hNiE4iBTOV9wGPGOPVifei8vugCwX3lGt3vf7EPnrW?=
 =?us-ascii?Q?57jKgHvIVozSCwoLZ/IWGZ4RIwfsEde4rvX1YC+oBA9m1lroAasw95qV2tck?=
 =?us-ascii?Q?FuldRgMuJI3bvfCKTZXJ6DeRSu8ppouDy2t1ac0cMt5dSrfCsjQ7r0Ohbuq4?=
 =?us-ascii?Q?3ExDJ1WfHSe85MSFR0CEvyO5yXzJBmwNpYNBcYwOGwO+dAiYMatMrbCzPaz4?=
 =?us-ascii?Q?+cqTkq6tkAgUY5qs7LRixna8Wf12RRxMu+K1B0zP5HCy2+e0qrUaxAmXL37F?=
 =?us-ascii?Q?f/jdcO/MKVzCG77Yg7IdITqZJ9HJeVp5OqDrItWCShtYZBEPY2mQxA1Bx8aA?=
 =?us-ascii?Q?UgcbfAPbUoBO7PlmFQW/7uZ3aiCr07Rk3v/+55yb6JVR7YyRoj3L3ShTEzEs?=
 =?us-ascii?Q?UgRtyQyfRDcsx7R+HNDfr+yksGqvaZuF5/pzqd0eaUbqGZDUz+ZgXGISM5wP?=
 =?us-ascii?Q?9IkADbZgBp6i3nh2Qn5Cwcw1CtRlFBYi/M/wqw/tLC8k8mxkJQm/+i3EzJ9N?=
 =?us-ascii?Q?9YCmM/qGdsOFmpn+OFRySYoV0bZRxFb7tKYdF9Uv6ZM0Kyca+z1ipBNMuZ/J?=
 =?us-ascii?Q?7yZBhdknMkh6yxmHby69irqEjkcZLlDsuyvd4IgQ/8MEb41/PTB9TQTH0ND2?=
 =?us-ascii?Q?UtttEW1AzmDo1d1cuIkUEj3jEjZg/pRMPBZnE8T3C+umO07PEv5Nqy23220C?=
 =?us-ascii?Q?hbUYlKWCkO1lpbsF8TnPvXHvlo8/6If4lBgUkjHp/P2ORDLfiNgOXm2URvTW?=
 =?us-ascii?Q?yemmEhpT0shM0j8Uo4oQQcEixNwBK4RjUNEFkCLHF5pnkSevqE59PJIkLD2z?=
 =?us-ascii?Q?yX2cM2Q0L1nQfuLuKSxJOLADeBHvcdt6+Fp7D0we3in6My6vA5K+NI14MHQV?=
 =?us-ascii?Q?QaKYLgELhUtORRiIBPfCrkIsdEhej/0IzgcDR1wCIrfx4KiXet0rTsOetuqB?=
 =?us-ascii?Q?75yCMBFPRQKFIq+FZ32thxSPEKUD0Sm8ztxbCU2Mld6oVrodmjzGP7zeC49N?=
 =?us-ascii?Q?Yg8Ow8y3MAuVhdNBwy3W3m+/noN1XNg+OXa3lO2J/azTKJwWrMMiLjC535sE?=
 =?us-ascii?Q?j4+UY2oKeMqJeODmJwawjN8Uulh58rzyNneZThNOxOqwR2GJpgz6PpHomNKP?=
 =?us-ascii?Q?qq5yf9LXJrOlqJea3P+vQYgM1LjT0B08M2Q7w9x2r/ya3iD/Ax4X2cb9aKRE?=
 =?us-ascii?Q?3o9Z9loEdHMIwGycH765laF3VrV9dl4/7VcNwvfmvKhmPj3m0tWm4JLv2NJF?=
 =?us-ascii?Q?2w6jwPYR9UCK4qsEI+4O1268b8zVXd//gOBPaoZrvg1tHJUr4aWVEEzp5qn1?=
 =?us-ascii?Q?0hk5HJSsgUTXUEZjoW7i3IQHerQrkPaJcwfBp9L9qMnpgBC6q5duV4uocENH?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3va0iHa7V4jxaF2K/eEWbLeyqwQeBSvCavhSFRXHQKf384hlK20BJBEE5Fw2?=
 =?us-ascii?Q?pf/xEvfkE1b1l8m2WVTHthqZzFnMx9BDgNlqndplAfiz0b8Nu4hJxRyTG/HK?=
 =?us-ascii?Q?GuBy2FgtlvTj6cq9FSfH15QiDJBTSWuyZp5BWuO/lmW7byA0nVaFtj+0X+PJ?=
 =?us-ascii?Q?FRZgEygiQLYeZ1cSx300zvYuK1KTM8jV7E8YAFx2RlaJP3diczmiGw0iY9CW?=
 =?us-ascii?Q?jkvzrFL/bRle7sbOVOJWwU8bAW+4FIrfnqWHvGCaHREH1jqREdROvi4Epdbp?=
 =?us-ascii?Q?lZXfDXSXr87fPHumBJh0EuJtMfFfBK8/ohxE7xbukTpuhGpx4KPv0SGmVEHB?=
 =?us-ascii?Q?75k63Y/GSY17KsQtaGAEdGnjMMPXjF4BylEi4KKY+cgnluNBzAfB/ZzBUF6p?=
 =?us-ascii?Q?2XWN8lR7ac2OVnv5l0Yb6AzqAboatfU61akxhwQD0U4iPIt3e7PzCdeBGTrc?=
 =?us-ascii?Q?P0J7kpJGP1HpYPdH8vk+zipsSlY36B/hfwpe0zV4M6RRFWnEgii/1U+gh6Hh?=
 =?us-ascii?Q?KAXE6V4nqx7BpboolVR2U6tagxi18+UsXy6o6AXWb6bYx6H5wyJuGfSZyE18?=
 =?us-ascii?Q?7pISqCMqlreISW4vcfCHMbCAPlTRXj5HMhH93wt/gy7CtLSribbKUfR1eQs/?=
 =?us-ascii?Q?TwugjRZBL41Ql1dddXuiL+KIndEoAsr7RXWgradhITvQF9b2DoyU7U/+seK1?=
 =?us-ascii?Q?GkD9Vza5y6OpUOUmX6jT6PWTgMZdR7/8Xso2kXM7NAFN4MrQZd5pPX8FaaIN?=
 =?us-ascii?Q?FNy+3xI49qEyaJ2SnKIO6ScMt1QIpur0KXP8K8vfmWn8301DzFKGL/mUVKIq?=
 =?us-ascii?Q?17eUgPY0IOIhdXs+LJkpN6313P6H67m0LsPpVURHs8FGRidzD8biaOEh1Vx5?=
 =?us-ascii?Q?3h9hqaaBhVxuWAjoa3BILIhIeVHgcX/7yXeVNDjL2c8gMqUSMriqgrcqLuRZ?=
 =?us-ascii?Q?meU30ar3UrVT57H0C9afrQBu+BUD+LKmC8bvPXyKmSe8Fd4BhAK5hrEuno+s?=
 =?us-ascii?Q?UXF/mFDSEvRvfLvABQoWb4DUcfk66s4/hmbEPTv4IC4EnEgqVIsDe8h6j1Kd?=
 =?us-ascii?Q?ENiM335u?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fd8f3c-11e4-478a-84cf-08daf4fac248
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 00:11:46.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itprnVvtLSxDq6SlK98ZmQ3ad8flO25tFUtirn4HNWLWaTSsR5Is//xe2HBE/rV5E2VpgQ5JMCSF8A8Flgwxcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_13,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120174
X-Proofpoint-GUID: Nf4_tqjCLlBdFRcGKPBtsJ9KAucTL5g2
X-Proofpoint-ORIG-GUID: Nf4_tqjCLlBdFRcGKPBtsJ9KAucTL5g2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/23 15:17, Huang, Ying wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
> > On 01/12/23 08:09, Huang, Ying wrote:
> >> Hi, Mike,
> >> 
> >> Mike Kravetz <mike.kravetz@oracle.com> writes:
> >> 
> >> > On 01/10/23 17:53, Mike Kravetz wrote:
> >> >> Just saw the following easily reproducible issue on next-20230110.  Have not
> >> >> verified it is related to/caused by this series, but it looks suspicious.
> >> >
> >> > Verified this is caused by the series,
> >> >
> >> > 734cbddcfe72 migrate_pages: organize stats with struct migrate_pages_stats
> >> > to
> >> > 323b933ba062 migrate_pages: batch flushing TLB
> >> >
> >> > in linux-next.
> >> 
> >> Thanks for reporting.
> >> 
> >> I tried this yesterday (next-20230111), but failed to reproduce it.  Can
> >> you share your kernel config?  Is there any other setup needed?
> >
> > Config file is attached.
> 
> Thanks!
> 
> > Are you writing a REALLY big value to nr_hugepages?  By REALLY big I
> > mean a value that is impossible to fulfill.  This will result in
> > successful hugetlb allocations until __alloc_pages starts to fail.  At
> > this point we will be stressing compaction/migration trying to find more
> > contiguous pages.
> >
> > Not sure if it matters, but I am running on a 2 node VM.  The 2 nodes
> > may be important as the hugetlb allocation code will try a little harder
> > alternating between nodes that may perhaps stress compaction/migration
> > more.
> 
> Tried again on a 2-node machine.  Still cannot reproduce it.
> 
> >> BTW: can you bisect to one specific commit which causes the bug in the
> >> series?
> >
> > I should have some time to isolate in the next day or so.

Isolated to patch,
[PATCH -v2 4/9] migrate_pages: split unmap_and_move() to _unmap() and _move()

Actually, recreated/isolated by just applying this series to v6.2-rc3 in an
effort to eliminate any possible noise in linux-next.

Spent a little time looking at modifications made there, but nothing stood out.
Will investigate more as time allows.
-- 
Mike Kravetz
