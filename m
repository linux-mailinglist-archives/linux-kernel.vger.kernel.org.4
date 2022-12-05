Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C53E64399C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiLEXhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiLEXgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:36:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52432126D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:36:22 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5KOVfc021673;
        Mon, 5 Dec 2022 23:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=w8aDRmCLx2RPaPfEJWmJ7hQbmO9zpKZvqnn8mcQa77k=;
 b=OM80RKNO8VX/kTqkYGrPbdboUJ0Y2SJynPEp91roizpHapmomLaLpnuttSWXlBilN/O6
 BFtzcSxHRA3hoANzfXjj+dtjCxVmTgvhVxLUmQ2CF27PEiP4PRqVs0LwqU0ikPi48eE8
 y84DT9UjO9N02wHDFKS1oo4WEcqs6AFI4HUUQWBM6pbun10yVWs5qe4+cKZbPIgsT3YL
 iLXfI9hd8Yv+rgGKDarathp2CnEjfQCKeZbvtETGQ/Hu7kGY2VZeixgSTsxoaKYgrGh0
 vnysBONvXFqsoDJpdxRkqKntcmjCy2FvaTo629B354XKoEZ9wLX0/ZFflctF8urtigtY 6g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ycf5r7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 23:34:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5LWjrX009377;
        Mon, 5 Dec 2022 23:34:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ugeyhnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 23:34:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI7wtvkWXNAI8uRFx0jGkmhwnojza4jbt81foyhC9TVR82ikziyTpDWekTOAfHhtGqNffP764Mla9tG+zhjbdhQRtkEO86tDFHhgK7un+MUUtjFF2Y7CtowaiYznkIuYaTXUxl21US+2/3XlCi1ATksl71J07unPzBWKIW6W6D8QF+gYPAtO47IdbypkToJsJGgvF+T+cP2UNva4i2otRDSQtCt6J0yJT5U6BAbluq3E4rmuob1DOiOBk8Kbu/QANrjsVahKSAHxjPUmaW6cQh6ny8/V+8IQ4erdhSn8er826mdIkTTyj99JCVsmu9sfC4ITuT5MOzAzA29d/txHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8aDRmCLx2RPaPfEJWmJ7hQbmO9zpKZvqnn8mcQa77k=;
 b=HQhd+6auNqj2P/Ece5E+415nay+0T0IDDFKE+GLIPVuhfbAtmQpLL10cXQdN/xn2t4BHp9k9ruHKNbYW09W+FPpymAaaLkFVGLSLaBp67f0MVQWM3FkP5X+PQuPHJzP13PY3DJVpvMcaY5WUoI8TIIHjLn15/n/yldvRiv64PTAam59h8EGCdBDol6141U0DlnhV6dY7y/kx/xDXZMH+MO/hirwUGmpX5eoBKD/TdYPEZ7Vd04/Kxgfitdluevqinga/xEVIA2hZ4jzZw1OJrQc73/cjtEA8s2rE4pWxVGpbYcVPjygspR52N7JBnpOLoWk3un2o/tK+5WAXM3zhNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8aDRmCLx2RPaPfEJWmJ7hQbmO9zpKZvqnn8mcQa77k=;
 b=YeEG0CGlU//BnBclIzu1El1xgfNwiGV/1nyIMt/0wI8UHajAWETLFE3dq7q0HIdcn/qlPMk1uIi0ASyb3vJcEv1pXR8u6nypXMZmoQTyK8F73R700FyooacCcSNGxvVveJG0tSyfNG0d3Ah7oyv0t850cws5IIA/Ml4h3T8jUcM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB6745.namprd10.prod.outlook.com (2603:10b6:208:43f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 23:34:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 23:34:01 +0000
Date:   Mon, 5 Dec 2022 15:33:57 -0800
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
Subject: Re: [PATCH 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
Message-ID: <Y45/5ezH6uwn7Cfy@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-9-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193526.3588187-9-peterx@redhat.com>
X-ClientProxiedBy: MW4PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:303:b8::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6d9119-9353-41fe-95b0-08dad7192fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUwaiJlQ2AoVLejAIy8dVE8rzqLM8SDYWGpHj2buFRRV8+yfpq3tr2KKrtCh6VWwEiRzQ1ht5Q5kUSOug+tjAguNNuXdRItNq3Fa8Lv5w98dwM4h8HlI2YufSsPF0zE/07FBKu7Z6RcTdbaG859Ch3p/EPe5BwZLEiV/smvyVwnYTSdtmu/UXoeGFJo1765/PMgoq/JsRjAyuJhv96RHF0wqyxJbFz8QhqotwGkj7aFKT/rDF8kO4tuF/Ahp/3Il0jZ6XbpaJtgQ34Bs3sPo05GL07T0wASHIGs47x6tpakQ9lMCXuQ2i2YyBosXNLEGaF0INYynNeVGVhYOrI1XgNLOAiTwpIqWAzwyQc4KxmvOGhB7xyYIOLv5YE4fInlWoE9T8lOPblUutuYCCGgU5gCurHUfVtCUQGqANpRYpWoOqIKXZsGfiFq1a7QWTp8PMvboerxRdI3qQodt0qLdxnb5h7oElfXwpx+/1xA7fvkh0cclv5mwu3rDXY5S8T2IGMjZaDWyRGH8fSjcl2amiukFHl9eBijnowU9mk97X0xe8wCG10LN4xeoCne2k9vsuPElGnJMcuVa1FmoBc3rZ4I3ykQbtW7ehl3pEUY/uQZ7GDONU7j/1jX6DKXgXFMM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(86362001)(478600001)(6486002)(6506007)(53546011)(6666004)(9686003)(44832011)(4326008)(7416002)(5660300002)(2906002)(66556008)(66946007)(6916009)(54906003)(66476007)(316002)(41300700001)(8676002)(8936002)(6512007)(26005)(38100700002)(83380400001)(186003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gPph2o+PhE/zK3Xl42QRL6Q8+x8zgydNaxyEvr3ZXt8HxH7L93iOa3+JlrZ6?=
 =?us-ascii?Q?9vnXxt5svZZCiRlAOqA+Wkef2GfbFVBpKtZqvR+zvrNfeH+RZvf1Wv10/FuD?=
 =?us-ascii?Q?Z7KbjSIrkq7de6lsqt2yAgPOqr7UDsTQlpsGMpFjbH+6Jv1tOxswytxq7hAX?=
 =?us-ascii?Q?IttMly1hd8+r1WwGnyw6qzee6MHuBClM77iwPkgsJjjFT5QRpDJTDbwHmZP5?=
 =?us-ascii?Q?5LS/Y4Rd91TsihIib2xEl+NkcGNp/J4498R1dbV+Apj9eIa4ZRujt/DXWfOD?=
 =?us-ascii?Q?kWdSf/GohO1IljWfUiOm9nnh6LjXK4tust8SOX45XWPfnAScHIZAjv5c++Lm?=
 =?us-ascii?Q?5tFSJBYvLuSxMJiPP5VeTqtIsww5fifJxjHzxPmSpGomJrdLD1xJDR9q/AqS?=
 =?us-ascii?Q?4FFo95HqlkuWGbS+HYzT0lAGXVAJh1KrwYA9smMNRBq1bDTNk5ek7JS2jTOP?=
 =?us-ascii?Q?LMJPPf8yV6Ox7kbNCdhf0w00ZEahRxBtZl6TLTkLtruUuQXqjAM95kZbxhLx?=
 =?us-ascii?Q?t6EcZaNH1sWOpsKG3AHuCqoMX0q8Spk95E41IL2qkuJRBVI8qUqXOWsKQaqS?=
 =?us-ascii?Q?2VZ8jOVvVqc22mHvDHydk43s4UFh6WFKKgXl0EW9c9zAXLvjCQoveNyyPG50?=
 =?us-ascii?Q?Ibfeb2EHpNLgwSOsYWl6OzuXGJ622TzgiN899K9xw0EO/OJ/xEGtUDSKneFU?=
 =?us-ascii?Q?JNYlr9qC/cMxpBqj9FUtvvVwbd8MbIPwy2MvzGWCzVO9QqKQPgOxKnP3vFyf?=
 =?us-ascii?Q?mUkJ7dRl7UXaGpvw4DPCb2QgQ8ooA5yiyW6MX0w+HbYRt70syuirlqul2EuO?=
 =?us-ascii?Q?XMK+78CGGmDT90MB2QvBw50Di0Ooeual5Z5Xpy086sIoz0gSdSPL6FcqBmZO?=
 =?us-ascii?Q?pHzp/6F6uVUT4z2k5ITllzonunE9mbPn2J9JuMOVYMq1ErdGRchI2ZtJqRfg?=
 =?us-ascii?Q?WWbUoOKMYwrxp1x4aU9pd0V+YtCUnHgSLSIy9NcEBtUbNMd5OBNDcdhlTGYE?=
 =?us-ascii?Q?6rgLwxwWmD1QyMRJBXNoA2mVSxi/7XYd34TTSzTh/cUN23rxP3vNqLNXKVgM?=
 =?us-ascii?Q?uMozoitLmvrjnA25FynnR4WzbDy7ywAaLx1RshzurIYXSc9EVUYAaPkgf+01?=
 =?us-ascii?Q?InKaC8JLMt+oCznTi8RloQyinyvQEuwYJn7QcIlFPuyjsO/Ys9rd6crv7Gwx?=
 =?us-ascii?Q?7sNgLNQ4fSqfq+DidYBMgDEWjvRILR9wxCDf3/fZKcpQP4iDxSoSHsKn0oIr?=
 =?us-ascii?Q?3QwhmSxSZ9qNAzdoMIGlWtq/rz3L03nYxbqOe6AS6ksqKL9wY7IqhZwiwqGS?=
 =?us-ascii?Q?Igw6mcr7B+RuMig7ae4cYELVGSpTfWZgmXdG0QsS3tgZE6fSXICxOIOx7SoX?=
 =?us-ascii?Q?ahDLEcX3dLwxtLOlCa/hI4Pp7LHowngxdLrWVow/eFinNSGY+v4rcyy4tbCI?=
 =?us-ascii?Q?r0lwk4k4h7xweuztc0s+t6PtyGQWUY6OMKyQgQaA8KjRFNXBhL6SWAL4jAiW?=
 =?us-ascii?Q?v97vJIqjElGPWtjNuDQ8UDmWTYGbHCuah3aj9LnUSjdJDvvivAmhUSh+GkaE?=
 =?us-ascii?Q?ilYNYg/Ba13BQ+XZz/EBzIILCLv/ENDWGt4feb+ywb8p70zNYeaSCalBfUjs?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2EAzZD20144210q81NgWFBDytzIDME9OvA64CTmUA0Ky93MuxjutiBhwRK0S?=
 =?us-ascii?Q?O3uwihHJGDu6eNlnHI64RigzKlpiSTYoYFUpbRsGJnNPITbMyAlsqN9t5Iyp?=
 =?us-ascii?Q?NBSdINjuT4jZKijeWOpXEkIpQWBkQ5de/mh2wpzXkHPYwhY4wVhb0moVJq1K?=
 =?us-ascii?Q?wmfERMozgdMJtquYDiByP+T1HCR34YFKINO/ZlX7w05ZAEvUldF1VmKy8gp9?=
 =?us-ascii?Q?yGCeEMPrBihYYn0sokTo9tA9BgKylxVdStnQvNhH/Dk6eEDd8yVLSwUfbc9Z?=
 =?us-ascii?Q?dTtRwHt8CS1MhoWjD3ib++CFhhQi3fto9SxHwKvpZXDAgdjhrHX3jaBBm3OP?=
 =?us-ascii?Q?bEEJ8IMF8jVNcCjtRtas3T3xNJ9aAZhjaEAaVKwANWWMkf+RtY3I1Glw+YyV?=
 =?us-ascii?Q?+JRTxVEfA928cIdiwGRDEKK2Azyv0nXfjdQwI4j2UDtVgZxIEnMgv9bZnxVQ?=
 =?us-ascii?Q?9l+8ng0cBj0jjjVxBMlzYhbtUYHf5mTOausOF9pVGXbJHcM1HH7Gi0OyAr64?=
 =?us-ascii?Q?J7WLV6gqR85kef8qMWfY1lTZ95kbeNFsR8oTSd3+DD2iAdnf2b07m5p/Z5QN?=
 =?us-ascii?Q?eePrvrez/pYiRvsX5MnNqbq6gPOoWiibfNVwE1G+VwAYq6MHgNK69XSIx0Sw?=
 =?us-ascii?Q?fKLLt+2l1DgM1h6wRrUjNXSL/VKBTRyZg6lILB0WYd3YrHlz9loryFh9lLk9?=
 =?us-ascii?Q?d0Y2Om9ufR0Kt1omGg2oqrRfztHtDI6Zmaog2DDVQU+5lTuEdmehLwkvetai?=
 =?us-ascii?Q?NT2x0dAdu+YIsET/Cb/j3VzccfLEaIzDMLiyQNtS/LlOLRREtx4RH8jGOvN8?=
 =?us-ascii?Q?PHKpz2XgqDh0MYzsWX4oPTHm4ENGIkQubsvekk9AcjhaLPofLYAT+L3WsOoV?=
 =?us-ascii?Q?ZYUMB0/n5zZ95AmaCDGCa/kvjVJZwLBBIj8LEaHdVke1BKVVMi8DMeNVLFoC?=
 =?us-ascii?Q?JolNH9QiKM8Pstu6r53WAbzomh+ILEc9VBmJG7ckjywdl5CDzlQyzgMCucdO?=
 =?us-ascii?Q?XziOhZpWq+aw2bg9OfAKZxG2IhRYcN29nx8l9vMbO9I40x/Bqd3Bzcy5WjGR?=
 =?us-ascii?Q?VFImWuOyWJJusCd5vpCimisDO7TsvZjlxoA4Lc1SkJ8cDOxbEUQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6d9119-9353-41fe-95b0-08dad7192fc2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 23:34:01.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEavrg9WSGu9hSiD0zR29+CyKluukxPH4iIAMWxjRwY11leP+a2A3W33uev2SrFCo20QJROWybJyxkRiCBYQFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050194
X-Proofpoint-ORIG-GUID: yZEX3FPl84t36iVnCmxXBsMhEIOLu168
X-Proofpoint-GUID: yZEX3FPl84t36iVnCmxXBsMhEIOLu168
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
> Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/pagewalk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 7f1c9b274906..d98564a7be57 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -302,6 +302,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
>  	const struct mm_walk_ops *ops = walk->ops;
>  	int err = 0;
>  
> +	hugetlb_vma_lock_read(vma);
>  	do {
>  		next = hugetlb_entry_end(h, addr, end);
>  		pte = huge_pte_offset(walk->mm, addr & hmask, sz);

For each found pte, we will be calling mm_walk_ops->hugetlb_entry() with
the vma_lock held.  I looked into the various hugetlb_entry routines, and
I am not sure about hmm_vma_walk_hugetlb_entry.  It seems like it could
possibly call hmm_vma_fault -> handle_mm_fault -> hugetlb_fault.  If this
can happen, then we may have an issue as hugetlb_fault will also need to
acquire the vma_lock in read mode.

I do not know the hmm code well enough to know if this may be an actual
issue?
-- 
Mike Kravetz
