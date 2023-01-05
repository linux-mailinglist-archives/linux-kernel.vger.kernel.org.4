Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6365F6A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjAEWYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbjAEWYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:24:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE036B1A8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:24:11 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305LpB14005613;
        Thu, 5 Jan 2023 22:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=eecO9l16wgHR/RErMpVAnSz8iNcbJGkvHJO0r9JPkTs=;
 b=zXgFkVVoJdtGouG52rnr54O7oTNv0AOaHH7P6GfUcSp/qYWjZGdJT0gb7QmXyszqjows
 HXHt3LOZRgCfNhv03nbYBvmXGp0kth07SkF4weJVIyfEyb7K+7IzxjKXbP1/g8XFkXuY
 u+j70aEzNhRA+lnztqddwO2gu5K8iq0ioisDyHKqwopXOYwFXXT/fAAuZqJj0e9Nq/fy
 JZnKitDOLLP1DuSbJxqqwrOBbkA20RdEPSUxCgdFqyfrcmLEZzRJhVBU3qHUt2TmSzbk
 v7BgUNZhErInd5ULgQ3y9CL41RJ62iZMVCLyM9eZkZgDvTy+MsCPGlu5HuJgupLugb2A Qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya9yma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 22:23:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305LpeMv007665;
        Thu, 5 Jan 2023 22:23:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwft0ajh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 22:23:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLOkqF9GYkKHl6PFUwbAhDQMXd9WDYpvmjHWfMU0vhajz0kxmLrAxWPdvxjbcJAsJIK0PPT4E2FZuEtgd1luXrIuY3owBoiM6SYIq5iofwjpNT2iEZtPjCc78brT0gEXNKrXAPH2q8Oav4OWf66si8B71NWuhoSX2+SG8by2DZBXbJb6gp2fZtYLnATSeICvQ4nvk4fhyqU5XQbs4kUlUETDqmtAfa6GTGSAP4wnep7ypHfjinLvOF/adJZN5pUkpxs01x4n6JyGVso7vfI8KOHPtt1gIm1vSqzK9HKlfyn/QBtCB4Slv2V4NHO4Za7a3AGoyfHktJDHXJy6/rrihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eecO9l16wgHR/RErMpVAnSz8iNcbJGkvHJO0r9JPkTs=;
 b=lf30CEyZNXMqNjVDs0AGn8tZs+SAGSyvpVBfOYBf8n1sYR5zjAL191aSIvUHsZrqaX8eIUqhGs4p3TPVQ7368cebHJVz15HNmEWc/KNs+YiGHRTe7/GoVB1vEnVueBkqarlHNJiegZqI7VCiZEUBz6nTHxWXgc3UB+y7lEEVDK5sUxqyg8ASfJw/7LsswePK2O+ZI3BW2Cd+6UVaFP77b3bkRHozG9SGPF2CV6JlvTN46YtvluRqHk+t98y4TvXCyF0VI8Qa9vqNlbviKMxH4i3XEf3glrrXecO9cN3RkxUGCcIPktUUC2kM0czU6kl5x2agP042/DVHurK8q2tlOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eecO9l16wgHR/RErMpVAnSz8iNcbJGkvHJO0r9JPkTs=;
 b=OVmVKFaGsSKiPXpgMItSbTje5RkrgTGExMlXir2v96/CGacNFzimxVGol+pi0RnflEOyAv0LhSgYHYQEmmyEprmNRtQ7cKOAPUF6A40sUDdr1LW2gBN+C9FuR/+kefVZh2JnmAY3gPrjA6FOXhpPheYslCV0JQkfdCwX6Ckr2xk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4773.namprd10.prod.outlook.com (2603:10b6:510:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 22:23:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 22:23:35 +0000
Date:   Thu, 5 Jan 2023 14:23:32 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hugetlb: unshare some PMDs when splitting VMAs
Message-ID: <Y7dN5GWQVdG5BvPw@monkey>
References: <20230104231910.1464197-1-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104231910.1464197-1-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:303:85::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4773:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a9838d-316a-4bed-df77-08daef6b7c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iBKcI9Bn1tRMPPKU2kURlj73dAzIRZAZoc3mYHk4YzBTBaYy0hucqoWHPN6BrChVwusrlja6JdW3XgPzTw1kfNpWJLMj49dVPkUpLPCQ1xNtZIsHec+9uFylY6q0crWlBgt6ismuw/kY36PvkTPFsFLgADOWW5duSNs4U3nKj/Q3RM+AI8YZxx6xgNPBsWttI85jwVK7134ZBZJiYiCzl9qChw7v5Sax43sjRoCu9AL3VMGAe/7dqZayPqTgv0ApOOqvC8I2/FLoWXMeeFxUy4Lh7C4P7DN8Mt7nCeHzAQ54O5Cb5fEtybez+YNzBx/HAUpXqI6fGcgmR6mA4Ads+zQevx13o4SbOTSsjmDe21AwhfhVr+uO+JrBQyJmCpDD/DT9p9dTgmkgUKcXXdXmZNppbALd7OsPzRd7cLB1Zx+kuogGz5iw2fddeONrOA8N4Unf6zyrd0EjoNezIo1HvgIFrFSdHjAXDEshQwoHsOyM4ci6OgfR2bVFP6csE5coqVT77Vn9T3JL5odlMjb8gP2ADGXjnmQ/JFELXNhiaXEzdpvA5wEIpdIOvKCefLS8ilDx0JAkOR8BLFPegZbGkiFB3SsCKvHaDb539mgwSQfJIr3InjincssXHxBoDSzSsmjhFtRMGJCgb8KXcoNHIQ57q5VIpOYL72T+3XoxNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199015)(83380400001)(6512007)(6666004)(26005)(9686003)(33716001)(6506007)(86362001)(53546011)(38100700002)(186003)(316002)(4326008)(478600001)(41300700001)(66899015)(8676002)(2906002)(5660300002)(8936002)(44832011)(6486002)(966005)(66476007)(54906003)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EyfqThwhUvpoD02EB+HW/qO3+/zQkpABb0JJM4WlMtiyBNsUiOEx1KBbiNqv?=
 =?us-ascii?Q?gJWnKYX1rN5nwkpzcvnHvEh/3QSwYwglUquQtabYnuit9SmOa4dHhMt8k/Tk?=
 =?us-ascii?Q?2w4gFrwuBens4ct6JBVdGpGMBqUtA1JPtEp7hPBwfIK8EgPnseVp5KCskwIx?=
 =?us-ascii?Q?FShiq6OtFmXTOfINgFKQHirxwmjCZg705xy4B8uEetYfATwbZPJQzNB3NJ0I?=
 =?us-ascii?Q?UD8PZyDFlYeLPFLQJN/7TNE96Dn54HLIMZTy1BrV2YMj/Y5ef7Rq7VZRURlD?=
 =?us-ascii?Q?848cAFIH7tL6u1OPnWmHiMeTBaIx3Z6DPz26MVAYjr6DzZ2FEIQGU8rAMTcJ?=
 =?us-ascii?Q?ev2ZrsEbJNvYoq9i2fsZWSFd9Sc63L3svhXgWFsoN94Zke+bhoUNYURRKgkJ?=
 =?us-ascii?Q?WeMX0Tl/gUeOIF3ayO7iyhukBalE0M3owKOOzgIfkXVmY5kwBR11caKykJVb?=
 =?us-ascii?Q?yijdBCix/0kTREcHQVqrKTLsxKx6NweYta/r1U9QrP9ZQyEASk877VGIbd9G?=
 =?us-ascii?Q?b1hanSBdRo8Q0Vsvph/kH4Nuf29PwstQaUl/eJcAbosnuQGU4of4KJlxZgzx?=
 =?us-ascii?Q?ML3GO71bUoMsB9EHDW5Xp8+5uKNBL95b630OuWeQCa+u+hlhzbyF6jnxvC+f?=
 =?us-ascii?Q?5IUBkNipJXgqaXoQ7dF6Bgm6OrDuZkFMcLhJg708fdE4hy9h6UWFkuChbLK6?=
 =?us-ascii?Q?XAH9YW7505kI6qN7i3sludtFpwwbGvBUWiNsWKd3/HIRokeqfROzo994PkgO?=
 =?us-ascii?Q?QEH+HrCXA4HHyp/fxJksNPAe/XIJdX/SJ188XkUTz6oyxCj+9WwTcWAINxFR?=
 =?us-ascii?Q?+TDp7VoVkdYmOtl30DFqdTmbt7t4oEUaYnjXWcyK+7zjKqHyqfMoJ0HOoUlN?=
 =?us-ascii?Q?qLfYhdOtN03zJQR9k/Zt7fX+M6CdlVBgdU7pLI0oxQ5S7CwvImzcHqiGzyjV?=
 =?us-ascii?Q?HzaPoSXTALIuvMJNAv3A2FCgciHYx2VY7ILxQP4TI6vwM6Cm8NBo9cHkZUq7?=
 =?us-ascii?Q?PNUtViy0/W0SgAtjllqaCGvslVPmxIk6Qa+Hp0K1IuZXJACnw9bZZ2DhOWBi?=
 =?us-ascii?Q?nbrmAE3jG6ZPrx4Ml8qUTrQsGq33yfFKq7RquD3/hjU+iCdjq3yw+ZEmX0gw?=
 =?us-ascii?Q?XFWqaikjIVfoovS5+0HH+Ob3UBA/nn21mFas10ZXSnBYtbRopOPaqDteM0Ru?=
 =?us-ascii?Q?MwuUe5tb6xo+zUKHgJyo/aEJq37VFddd7i8jNRQMg5H6mNKpVJvvdHr+i/jd?=
 =?us-ascii?Q?V77XpqYHTx1Gs+9VOXEbUFVNN79vbwNtSmkIJsZS26lBodo621vFwTMwoQMS?=
 =?us-ascii?Q?kbaahOuyhgYxNFwLfzrWiSfL3kFwH06LBcTizz6MEth0EaSJvwb/0VkH6+ym?=
 =?us-ascii?Q?yyGzf4iZqG97bYssWqcrvRCnZyCfB7eMbG/kPx4PlnVwBUgz7SF7F+bOgqbB?=
 =?us-ascii?Q?HCfF1fbAECoLdWfTeVSQAjeHB/+5fh8aBrfZcvnqyZuqhLybw098kUWd/ZJI?=
 =?us-ascii?Q?yNMtgtHQmUv4e3U7eYfozPusj5+f9OGozP+gQ73vYml2gSPbMgo/Ff/e+oU5?=
 =?us-ascii?Q?HHzq0K5E5hvi4noHstIwNY37g7ucekgCgXM1dlV2kZLbyotetllgT6ItFv3/?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JlTMfPhe9Y6IgAPjZZ1YGZ6xoD2oNKnXAvYXYXB/zEWTtOdT3D8dVNeJ8L7k?=
 =?us-ascii?Q?CqdLucKl1RBhYlrHGSKdFVCCRoaTX61EaAbpVQVomZzQ/lGlXpdi8ykL0UT9?=
 =?us-ascii?Q?QyXrxQmxGI9TGAidLMTZ62k6Q6nFrjJ453T6Yp47k4HOB7RDR5/+rvW+8mww?=
 =?us-ascii?Q?vlh/kzxknfK9rNYA2vh56LTMLHbH4WqiezaXxsnv2UxCd+v7VNiRrc5hotll?=
 =?us-ascii?Q?nBTmkP1JmTl5fP/BzU5dhYKcGzCWuFm115tdyIFoXfvDNjh1NgkcY0vArcus?=
 =?us-ascii?Q?BqlJAfyvowavlQCoy6dIeRWfeqXiQRK1f1OoVC3uxQC+3I9K1xjSLpOA9lxR?=
 =?us-ascii?Q?vPNTpIHxFaf70z9NU7FtJTS4nsAiV01DqoTwhfSsxvSGSSp6YRoyaiO90fqm?=
 =?us-ascii?Q?FTZyB6XQb3OcWfH9u+u4gClxjQ5QKdPUwfDPmIPv8LhKEFw9kpz/9UtwgUQE?=
 =?us-ascii?Q?qbSih9I6bTF5+xRg9dznntBsjMwNEidY7BRoJ6U+uL/KxTc77Rz/hlywaU7E?=
 =?us-ascii?Q?xcVF4S5zinK8M52sH2dzLpCrWYJN8TDJJgSovCaRFZz4Hr9xApKc16KdVHf2?=
 =?us-ascii?Q?kSJB1m/nNQFjFc8okLxf1K+jIE85w273ztky0f+c4a6DbOAR0T4FlTa1m8fJ?=
 =?us-ascii?Q?3WSS7OAWjIEF81D6XqbLgtzoCWf2s8yT4UuEtUzgTvfsjrPB5v9PaDVAXl7g?=
 =?us-ascii?Q?W7I1Nwi/0wzXnrC19gBWISz0NOCN6E1+hlTyc9WnS0T0VuH+A7+W9Sf07+nj?=
 =?us-ascii?Q?gpLQCKWaxhP+cpKI2nPj57Coh7+Y1sImCegYhjd7NzgepdoF8joV9Hq5xGn4?=
 =?us-ascii?Q?AND5Y9BXSmzx/juFn8SXYDDJTGPsWXkwCi94DX4AtLlgxwJiUj9Wn/tJ1T/A?=
 =?us-ascii?Q?ijcRAi5lakc/fY7DE8zHjR3PtR5/hmrMSeT+SqJh7+wPagMMrVtV08HVNEZJ?=
 =?us-ascii?Q?my2DFfyUsUkR6+LmSVzjPg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a9838d-316a-4bed-df77-08daef6b7c0c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 22:23:34.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7R3idQvbLksrjad5pPOJZyYLC0fnufbe7Kp2B1HNJsc9OTUXoX0qpAbqWUrir5Dge34acrau1fG1YYoH54WUVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_12,2023-01-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=950 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050176
X-Proofpoint-ORIG-GUID: N5f11phvDNJoP1oKq5Qu1YFjfB2tyJhd
X-Proofpoint-GUID: N5f11phvDNJoP1oKq5Qu1YFjfB2tyJhd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/23 23:19, James Houghton wrote:
> PMD sharing can only be done in PUD_SIZE-aligned pieces of VMAs;
> however, it is possible that HugeTLB VMAs are split without unsharing
> the PMDs first.
> 
> Without this fix, it is possible to hit the uffd-wp-related WARN_ON_ONCE
> in hugetlb_change_protection [1]. The key there is that
> hugetlb_unshare_all_pmds will not attempt to unshare PMDs in
> non-PUD_SIZE-aligned sections of the VMA.
> 
> It might seem ideal to unshare in hugetlb_vm_op_open, but we need to
> unshare in both the new and old VMAs, so unsharing in
> hugetlb_vm_op_split seems natural.
> 
> [1]: https://lore.kernel.org/linux-mm/CADrL8HVeOkj0QH5VZZbRzybNE8CG-tEGFshnA+bG9nMgcWtBSg@mail.gmail.com/
> 
> Fixes: 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all pmds for hugetlbfs when register wp")
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 44 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 9 deletions(-)

Thanks for the updates and additional investigation,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
