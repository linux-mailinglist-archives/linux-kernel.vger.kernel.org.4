Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD0B6439DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiLFAXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLFAXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:23:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9211DF3E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:23:45 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B60If3d030810;
        Tue, 6 Dec 2022 00:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GXTKIHCH5XH35kXhugDMMwjDt10ccKB5jG2sWmtwurA=;
 b=NMqpAR5dg8gkNwicL5KPggq7aTgleNj+rlQlGWjiz2KgOr2QeNO5VjJqGnPGAzQZ2iaH
 MeQzxpJUIP/eXVAEcYmxPOa63znm1hQ+dY3VbD8XcyutT/Gef5XBFYPpdHGfw238imtv
 iTZnAkhRTqJnAQx0N3W6bH2XWxQgd2AzEagx0bBmoXHqDE3SuAXV7U2jstgEqor9f14A
 cCQXCi0BRm6IZjrjodlbdp04QJQro4naUt4SqANlE4XvtOh1t8CEyWCK8u21QjaY/T0x
 N+xNOVQIAXOkNsmLlaz9EJhVP5elixiLVIqAvvkiTP2tQgO8H+BhuULIGU6wnphljFTA wQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ybgnmpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 00:21:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5NAYTJ039138;
        Tue, 6 Dec 2022 00:21:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8uce9cm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 00:21:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKKdiOYfaBFrHBKJSLOj+KEwrG8Z2hGciuYSv6ZYvNQCOnc1c5ekAHSDJxI7PJiceoA1grrtRp/71y3znz32Si1QCcwZtS3TyLIyqgPEEDoVKRxzNSry1THQYPW5I8L0j48d0uuYFmDA0EKnZP+iGp724tF0prXv9B29TgQNqWLmikMGQlt1KEhPyHl59qdmuZQh5kHFkvXaHtDsCOaoHrBWLIzkf7bbVtUQ9KW2GJXizl7lxZFFdgiKTRRJQd/h54KNNC454PRvd05kys9R6N/qb38U9xitso0BJwrj4zIyScnMqFdJMH182bASTijJ3QVLkaE6AKuW9hYLoW0KdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXTKIHCH5XH35kXhugDMMwjDt10ccKB5jG2sWmtwurA=;
 b=nIaBKzIZe7+GdAyHO4gMEl208n8D2WhBAMOZxXWezIA1xxuqugVXN62svK3Kmn5Wy9uUp/EU71M2PTrnv+Jtf1buOSjOz7R8fIo8myaHUDCCP2wx4+ZScu/7izvrROMZygpQyYwaVV5ISCS/sH1PrnH99WIMILTQLysw88mnWee4XXHhp6CzW909DsKJmRxyndN6k/1qMazQNlFV9NgNejVJJw8Y0i8m/+5nbADDWYVuNg74wTy8QdA5iWj4Dw1gNDoceA+CTtzjAJcCW0OtuqjUqacGmbGMRYTIJZY7ZRFBUmQeENdTpriIr+MqJhmDpS1uCinLZ2HmKyqftPkcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXTKIHCH5XH35kXhugDMMwjDt10ccKB5jG2sWmtwurA=;
 b=iaEvKqPcJwYB463lXfC9k1ZjMp76YNvYHP7Kb3KPKHlWukz9BvHqcbc6BNX9s6v/A45EPm9O5eyD+1YatXSoNk6AD/p1SLLY6xkxfBJ0qHqrjltJMt/6SJ5lIT/FJXCAo++D1M3Q5gqgA2okRVMP3EWaSX/M79NHUPvDEXeDG08=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5631.namprd10.prod.outlook.com (2603:10b6:a03:3e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 6 Dec
 2022 00:21:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 00:21:25 +0000
Date:   Mon, 5 Dec 2022 16:21:21 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 10/10] mm/hugetlb: Introduce hugetlb_walk()
Message-ID: <Y46LAQ2c/ixCTEsX@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-11-peterx@redhat.com>
 <Y4bnkO3ikp5bu44x@sol.localdomain>
 <Y4d4qh0ACmo455Nj@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4d4qh0ACmo455Nj@x1n>
X-ClientProxiedBy: MW4PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:303:8d::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: d69a1500-3a47-4492-aa1c-08dad71fced9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHuIBJkjDOljU8WcxDwqvsgtScaMZgwvefxnmIZRC1kkbMRihpnqKAq4gomKgXajTXHPp2/Ul5QGMAcGw1TyhK5cFZLClNSwcyV/lVQDgVa2wPTAUj2nOisnngRYTm6TRshuFi0sTQjzDHu6I8yBgSMZi2bb2laVlHvqSUx3vVOYoxRfgwDbLArNsW3QG0gT0fwIOcK9CTr85EXtvBdUpXeGvcZ58C+dX3ObAWU8qV1XDPX4ouwka+8dyrVR2wmvvXG7Mt4Dpp2lTQswugsVdG+MmQs6xAQ6BQPbOxs6KNjbJzQwh2wIToCS1zzldSJWDfWaAeyMhTg2leiLleOis4W3rSG7F39Vt/B01On3NYhBsiu0SHw3ds5bHMdzE53cRYWS2otbUooCBWvUnlLty5rv3IXJwx5myjAcQt9WNHgnHy+v9tbrUnG3tT8wKB1jYbsDtV+MwHXv5LM7b1eTwvkMlh9MF7gx2uT3/QZW5hyLJYR9KM18SrgV81r7lgfXLU0wsy3ULC1Gu2Jh3vktvaL+qEmUaIu//Qaqe9ufLpRsyPUFSXSi0dKLe8dUQZu2GXZvQML8HXKYMobwEFhnLJZmsCMxzok1WeyOZy3HqKNHZjTnd4+KjTRU1svhaQsOWu9SbDBne0ADiD5D5zHUIAixNpStVgJvArOVhPvBt5DJ/H5RDX6tQQZBRrYTUbCd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(478600001)(83380400001)(6486002)(2906002)(53546011)(86362001)(38100700002)(54906003)(5660300002)(7416002)(6666004)(33716001)(44832011)(6916009)(26005)(66556008)(8936002)(6506007)(8676002)(4326008)(66476007)(6512007)(9686003)(66946007)(41300700001)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jurbdKu0V+6gffEfZw8hk71xMdnULvVP0ly9i/QxCEIDLRILdcQcukfrNzIC?=
 =?us-ascii?Q?CX99Gd9MfgDujpQ1zYv12XeZbisx9bGf3AA+1s1dQShfdKSOE9gDtmThisYr?=
 =?us-ascii?Q?IZJDTjAMxyG24Vq7No39UlFytpa55ayAkGtVDoqEh6bOlFGVnMLg2ptfp2pv?=
 =?us-ascii?Q?QtKJBD9Dv8vP6vi4v38wKcaDvAWq5MdOrzMSl5iyGvI5Ox9wcgFAXT0ERfHZ?=
 =?us-ascii?Q?6WrQl1je5IFNlbJgG2KgVnHKOR9MOOdvKWMN42bCLRiPNHSifo66B70tarJf?=
 =?us-ascii?Q?FhNERxDK0pHgXKF0ddBrOHicfynLDsWVSi5LzqatRMDKubnBa7sJpNCM0htP?=
 =?us-ascii?Q?sPJ/1iw6g5ajRDbnUQFWceHCujRyItApSiItEnrj7X4XPA7EsWmIqMUvM5Ib?=
 =?us-ascii?Q?ScS2q93KU1xjMsAESO9LOA+xV5VFPUu2xuY+l3ZVKIxdzCfwqIcQhsOR004B?=
 =?us-ascii?Q?hPmWvUcfa7/qR9dzalSMsXFWDD78TknJxNjT4ikNRypoPfA6ngHve0hsMPIN?=
 =?us-ascii?Q?MsJIzqjA0emalrhP0Rtd0sybkQTog3XD2LGovm+v3gBJjwx7nNZIhciJEQ6P?=
 =?us-ascii?Q?lQIrC+KpTJb8cUs/DDUqfzcIBGXsBrdxwi3dKcKe8gamAAAGZFGHiZlHJq26?=
 =?us-ascii?Q?13pXKze5zy+TFl/UEHmXpVvZ831FWaw/z/14uu8KH0uuSwAYkrjGN37ftC4B?=
 =?us-ascii?Q?tXzmkueeFxhvr1YE0r0iiSGHHCfDK+/OegQWIefHUlZZgjdT2ohLGiBhoELg?=
 =?us-ascii?Q?/eEWkZ3GsJPfFVCNA6Y9mt4klYqfmbIITmxA0+6arT6rtG1Lkj7Lm/O8yKtW?=
 =?us-ascii?Q?Bv5O1Ob5MJUKTbkIG7CaLwVoEStjp4DxRoMJvSCaD2GUQOSbScoD8uIKrJoV?=
 =?us-ascii?Q?6ENgIKtUdpnAO9kY84emgr9gbjOOJ92esQWzg7MWqyXetbqbPLO3XLy5B4Pl?=
 =?us-ascii?Q?mEkBcfGiQ/EV4mwPw4NwZL41uF8BtBePw/PrDDpWFV4QsV2VTIv/m2DgNGxf?=
 =?us-ascii?Q?2JFj0XvAGBzaMaQafj0We19ctmLi6OJQFOkixz/7qUGqhzhUiF6fKwSe0CsA?=
 =?us-ascii?Q?RqVgDu4GJouq6VE0vaNnmm1iMKMtZWu1UbSpo5eAUc0dTAIOuSNZOWf6KMZp?=
 =?us-ascii?Q?j4reYI8ZCRrw3dSd67LQgSDkr5NMjojwZBVt1TvdQxDsCFvDfH+K3WsfJ/QH?=
 =?us-ascii?Q?mqyUsW9z/oYURTAq+HkxFuHz+fAP7MNlFHSxzNKnI3ut0tl/SSJr3jRVPbjT?=
 =?us-ascii?Q?29yXArzeKx7X0qHHmeC7Rs3GxfumREEVLDEtWP2WwN9NP2nQOeIj/0Rd3GM/?=
 =?us-ascii?Q?ffQY7FBUQQr7/T08DGmNQ6SQwaIQ/fhzM3lLpWHIQd+NpEO7FrR/ZPVhIkpG?=
 =?us-ascii?Q?bI8dl7ml5jJvftH7SGfiwsTm65JGZxgmWqJb/nfCztEVWxJmmQ7AbrdzDKiY?=
 =?us-ascii?Q?9JtU1DKp8YqvVAOb94zxrwViLtZRjjFzYdOXf4bY3/CWyMHacyxNX2XBVEFp?=
 =?us-ascii?Q?4m7vd7zwMCRrkj3ykz95qDWfSBMIiv7FPVE4x5X6ogPU0blJTL7sBnWNpuES?=
 =?us-ascii?Q?sA60ZkVB4DftL2xmmshBx5NGd9R/JlUXZ7hEaHfF+bU2RPpcegnMM3pGf/HJ?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tvr494/mnd20kvYy+I/CteaSZvsknNX9dfvgPmyCQs+y7JVco/NoquNYLv8i?=
 =?us-ascii?Q?+KNBb93QD3PB9tC4unb6ijlvWB9OUgJN3Ygafr8d2GZG9ETqyjX8XGVUT9BJ?=
 =?us-ascii?Q?usjl5wTE/JMVz4Be85XHNz1uUyThv3RqFrMm+xqKD/K0zJHWAl0zX0GCQ5It?=
 =?us-ascii?Q?pQHONOXx3CYgLpm3SZjAFVofKrluIcT5By2hfHj6YLmLuXTlk4o6v47lWpjj?=
 =?us-ascii?Q?3Zt1WEXMSFy5uitQ//lo70oLbqSgpKZ1z7bIPEPrS53hr+N6HGIC83h77aue?=
 =?us-ascii?Q?U1GaRYxjQhgEa8pKITd9nzM1A7nBYEVSU0ONV+R2vw2GS6B9Dz4nQogX1s8r?=
 =?us-ascii?Q?ZzbMjNe4BAR0ZOH9KsaUl7jZcC7D0dnm34+x0ZBFxxVG9w1Trpa04wbs4t8/?=
 =?us-ascii?Q?E7bE449hjbFMl0bXnAUqB6DNFP9CBinO6DP3judLkEb3NTd5NpqzNBZ1GQUT?=
 =?us-ascii?Q?rMMjxIxF0KKBDfPT8Om1Vl49eChBbv2n22siXqvOelRSdJBk3NUTSKQR3G2L?=
 =?us-ascii?Q?u/4+iwF2xxlWxyZw1z+Vd5xNu90+tRBWdNG3nW/caJnXBKAmYtgAO3DmS/MQ?=
 =?us-ascii?Q?3rfGKYNbpMxpP76lMwnPcLKq0uv8AuQEb/5aLIwROhVLfmrfnxQhmj51ii95?=
 =?us-ascii?Q?XkwYbfAEZbfDM3xc9f7gPBbQQBDZv33TAg1nJVO4vSHupR8cuu8LMtr9qM+a?=
 =?us-ascii?Q?F77LQVzheVDohWW8vqsZitLY2Ta1OKuC+KLWIe6PZM9ZwAQEXW7MaYG/zDNb?=
 =?us-ascii?Q?SwMoBK4wESPnCiK8DBIVNTzvbl3+ciayqVoytEzEXLnRj/uBO/uS2kDNsEN+?=
 =?us-ascii?Q?f3yKAAOJka2iSYysEZtJ7Wf+4Y4ett+feC2AlIPSKutHOpHxNZAgLnHzGY2B?=
 =?us-ascii?Q?Po6UWeOF0O8/QOBMGuuoUL7X0yrVFI6pvLaTEfQh32cDCiGVIQjCo40QWQv8?=
 =?us-ascii?Q?L5c0Ew4dmt+byKmhw1WKDG1qLhbs5yClWqvPjnhv5bswP6Bx63b+FkybNUG3?=
 =?us-ascii?Q?tUEixniamTWewETe8gverijTqT3HdU47Ib/ESmQPQm8JC/RAAt0zmKOvQVj8?=
 =?us-ascii?Q?fzlstCJtH1xccD3rOzu9zljoL/aB1JdJ2Pd5npQXyrM7MdG5kc1WFtNpAizo?=
 =?us-ascii?Q?ewypEw+5VMGrvyy619kw/iY/Ef2cRKFaVQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69a1500-3a47-4492-aa1c-08dad71fced9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 00:21:25.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49qJiICiak+W7db2wU2yY+HTvdG0SyNshctCV1h/Nyio6w0qo3nNa+NpxxtqsD8sjn1GpVBjzdSpTmTxJ9l2ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212060000
X-Proofpoint-ORIG-GUID: X7PeyrvTS-YKcPX92wJFw_XTqxvmRfby
X-Proofpoint-GUID: X7PeyrvTS-YKcPX92wJFw_XTqxvmRfby
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 10:37, Peter Xu wrote:
> On Tue, Nov 29, 2022 at 09:18:08PM -0800, Eric Biggers wrote:
> > On Tue, Nov 29, 2022 at 02:35:26PM -0500, Peter Xu wrote:
> > > +static inline pte_t *
> > > +hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
> > > +{
> > > +#if defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
> > > +	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
> > > +
> > > +	/*
> > > +	 * If pmd sharing possible, locking needed to safely walk the
> > > +	 * hugetlb pgtables.  More information can be found at the comment
> > > +	 * above huge_pte_offset() in the same file.
> > > +	 *
> > > +	 * NOTE: lockdep_is_held() is only defined with CONFIG_LOCKDEP.
> > > +	 */
> > > +	if (__vma_shareable_flags_pmd(vma))
> > > +		WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
> > > +			     !lockdep_is_held(
> > > +				 &vma->vm_file->f_mapping->i_mmap_rwsem));
> > > +#endif
> > 
> > FYI, in next-20221130 there is a compile error here due to this commit:
> > 
> >     In file included from security/commoncap.c:19:
> >     ./include/linux/hugetlb.h:1262:42: error: incomplete definition of type 'struct hugetlb_vma_lock'
> >                     WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
> >                                                    ~~~~~~~~^
> >     ./include/linux/lockdep.h:286:47: note: expanded from macro 'lockdep_is_held'
> >     #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
> >                                                            ^~~~
> 
> This probably means the config has:
> 
>   CONFIG_HUGETLB_PAGE=n
>   CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> 
> And I'm surprised we didn't have a dependency that ARCH_WANT_HUGE_PMD_SHARE
> should depend on HUGETLB_PAGE already.  Mike, what do you think?

Yes, ARCH_WANT_HUGE_PMD_SHARE should probably depend on HUGETLB_PAGE as it
makes no sense without it.  There is also ARCH_WANT_GENERAL_HUGETLB that
seems to fall into the same category.


> 
> I've also attached a quick fix for this patch to be squashed in.  Hope it
> works.

Let's go with this quick fix for now since the only issue is in the new code
and spend more time on config dependencies later.

For the original patch and the quick fix,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> Thanks,
> 
> -- 
> Peter Xu

> From 9787a7f5492ca251fcce5c09bd7e4a80ac157726 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Wed, 30 Nov 2022 10:33:44 -0500
> Subject: [PATCH] fixup! mm/hugetlb: Introduce hugetlb_walk()
> Content-type: text/plain
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/hugetlb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1a51c45fdf2e..ec2a1f93b12d 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1248,7 +1248,8 @@ __vma_shareable_flags_pmd(struct vm_area_struct *vma)
>  static inline pte_t *
>  hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
>  {
> -#if defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
> +#if defined(CONFIG_HUGETLB_PAGE) && \
> +	defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
>  	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>  
>  	/*
> -- 
> 2.37.3
> 
