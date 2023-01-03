Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5CD65C741
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbjACTRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbjACTPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:15:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AB5140E1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:14:32 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303JDr4F000990;
        Tue, 3 Jan 2023 19:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=o1pwg8coY/UF8sIXZqLBGXJKgxdhtYJT0zB5UJI+K/Q=;
 b=0o5GNMlZzKEgBYeriJDA1DcdeOL28k9HpXNoUBfQLsLGu5zsgFW4uiA8NRGdLm/4SMWS
 JlQD0jYUOnO26AeSX77Op4XdsJjB1qmA7UZxBX4QHWTqKQFvqX57Jm6ZWwbNNGRIiaSB
 xMokgIX82rUuCGwIT7I56lVhhsEejaTgC70zznw8Gq4yoi66PbSQHLykzOIT9UYGifz3
 8pILBbwQIrf+/4q1+IUx/hQQmfhHrjqsVW6hSKl0ii+aO+iSd1Ly+zAx6pj6LmLoq8k+
 OEkmcWGzv7UCm7KawktzltVSt21z6JmgjhfPc63YT0TW+b905MVebbX6PFHtF9S2iKJW Fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqmxj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303IMXZM012211;
        Tue, 3 Jan 2023 19:13:58 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbh58q2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO5il3iXV/XP2PVS4Eq6Y0o67XRjQY9XgK/1TPLpTW/uJF14YJF9PTKBHaGGvNW+TmJXemO+RovblFYhUim4uB6iBRN5Om+AzZiJDMXSAAAdjSM4cT6bFMwWt+opV5TYrZrVM0laH5CEj9tzWMG5pirpbTwUApu03imtxiY6Vg4RF8IjgmuM3f+uCrB73dxib39L9CTmUVFQZbpV3pHVdGFhC/XIkpeCZ3Nprvq2yUkJKjlIPTyE9RzOAp3Q7LTcw1upKRCxaC/WCucXeQrGxIhNtrzLYzZ07BNe0wdc7tyfHOs7BD+B5Wf5QfzACNune4qoTKAZazf6Y1V0uSF2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1pwg8coY/UF8sIXZqLBGXJKgxdhtYJT0zB5UJI+K/Q=;
 b=mW5ti+sMatxEBDVlgZRrhtFxhOImedqzpeZmoXbjSUYCzOnJH+7yLqNZk589N5kNRflNwmi1JTqEodkV1FW0sc2v43uvA8xzj0g/UySf4OEIWwFTCtmdRNfBplnmhjNDngUPr/BOJFPx1o/poodVu+IlgsxtoqjnsbzGtn3VCtxxrBGCV52cy6UPe0nYEbP1aSkoxso3xczWZaPNWEwWZ+90JRVdf+32Pbky0jdwoh2Xs4BRhjOt/BFXbFqF+mvWDxz2Stfe/pqJR2oFYiybJMUutb7Q+628BnA3IkeqHTizf8KQX5KgjuF3GpDGHSZp87kt1XHsu9LfM/PyIOzwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1pwg8coY/UF8sIXZqLBGXJKgxdhtYJT0zB5UJI+K/Q=;
 b=KjSc4/JUXFqTifWrfaeOJmQcfX5cWP+ktHBfi9iA+3U5B8gtcPx1zSZfK2U2nhbpa4SUVMvdBcKc2UcZEqfAb4YX2SLlV8WE1e+CZOZKc+tNCbwrU2Ov6Og9/zniSFH2BVynyjbaAZaE+oET5Tl0Ec1GlVTiN9rPqAe18aw20SE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7332.namprd10.prod.outlook.com (2603:10b6:610:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:13:56 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:13:56 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 7/8] mm/hugetlb: convert restore_reserve_on_error() to folios
Date:   Tue,  3 Jan 2023 13:13:39 -0600
Message-Id: <20230103191340.116536-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:610:e4::9) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: c04c46dc-f5c0-4a27-89f0-08daedbea8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPKYMrosbJhbm0WQzoqIjR3sgAch7u4douUEXWly5ckXeefg36S93RY/OeqXCJc5noQW8mtZJhlV6/mJAyou9FoUWC+L1VeyVJ181mzAHA63cYhLQmxRAl65zg5v8xjKEPUH+ijnsy07pmbjvAtXzaxmPVO9ERlaBBIB9uMK8WTJFomhez8Uw6iQdx54gDM/CvltGd5eeNTtUFH2VNOxxgB6+l6XZ0IXq7ebC5x0Dd3l2X/GPw2CUjsCYJfHRj9g97yFzBXCstMXXgkZbK8wnxJN9fWOpYlB2tt9WoK6LPY97vp7xgv657elZQX+JRDAAvEH6IJvOyuYKC3qLZSj9o4OnCBapnCNVTPLvuVX/Jt6sSMmEvv3oUFCqXUb6NvnZnWiDAvFb6dyVQPqpEmx2haKDMHhbboVojrgSGRivle/ux1sCDBr/Q/OW+nJGhfC3jOa+9taBnv9qQUaJ9qC2o2axOwqelIbdCZQ2gLLFneDHOgYIBGMLE4kS5b+msylfH+XKB8ab9pfeiYPp838+IH225gNRdfz7HWf0wQvBvw3lL4EggLJPY6nOC2jTQaChZ0u1KnS3ifA280hlCbjWiukdKHKLs2d8m7G28KMDD/RE0eboPubT6rRwF/q5/zSxuBe8LgnFKIRY9pgUcOuFVeogU3ahllKlNm3sB5IyLXmoBsfVLcuHotZPDQtQZZg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(5660300002)(2906002)(44832011)(8936002)(8676002)(4326008)(41300700001)(478600001)(316002)(66476007)(66946007)(66556008)(6486002)(107886003)(26005)(6512007)(6506007)(6666004)(83380400001)(1076003)(186003)(38100700002)(2616005)(86362001)(36756003)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZUPlx64IEtVDVsqNuOPKbwb5mcN8/cM5mMzYfId0YKrTvUOgtP4gRcasizc/?=
 =?us-ascii?Q?7DcvbAeGskw82UDrBFJ9iIrpgVf34dgzkpEy1T5SygW6GrKeTDEdtvksU983?=
 =?us-ascii?Q?6HDOYL/5POoUd2ZSCrnDmg85ogleyGzkBYzzN0z9YM1uuPJ4GZL4WFqyWcrV?=
 =?us-ascii?Q?c/nG0QDovy32u+HE8a5SGikngd6iLh7fNky3CLYhvb6GGwRrZgwb+ctUJ+6s?=
 =?us-ascii?Q?x39A8Xpss/+NFXsbKdQ1vPubKBdz8anpznnJjXuQ6QYeEEInLZTjL/jn9oAj?=
 =?us-ascii?Q?h8wPGD7qtmjIIkia6MuwWpsbREDOjyYDdyKuN5gekY6/i9rwGldAjTct0MLx?=
 =?us-ascii?Q?ADXPuX1JPFKbkw3Nmod42OLKUp/dHPrcoYwBY6aIlImRq5Mbi+dAgmesq+ST?=
 =?us-ascii?Q?pyg2CH1I43KCWSIoKSVoKhwh3BqFNxZ+HOiyaD7FohusR8aLTTr5RrpRVk2d?=
 =?us-ascii?Q?RAsa8+i0L2nuVTnE+TOdxK717yA1OLvTnGrf1bbPqK3rlLfGYv0hglaALn2X?=
 =?us-ascii?Q?/bFrZeTRmYiUnCzWLpw9tg1In47tjxWvuNEMEVS9h6iYQ1ou/ngbwdVFlCTn?=
 =?us-ascii?Q?PvCQQj2NKP8vgg49dL/KqFsZajgvUreVfF9hqU3fAVF4S2MNDRKtaDZtzYmd?=
 =?us-ascii?Q?/ApArYCsnlPEXR6MAipeL6J+DSgGVu/gyRbzd1uA4rJjGxrfyPYPlay+BWBs?=
 =?us-ascii?Q?do2/vg2HV6LN6XtholD7hLKPZlxsDwfwfI0kRdp7viBOIbeDToNpR6bcCRr4?=
 =?us-ascii?Q?ez73tllf8/oGRPCUa6NDHLK0rM4u282nBjgEvHczUdCakRZ1JpDtIPcDmI3c?=
 =?us-ascii?Q?itpsMFeuU5/djftg0YLyQmC+uUwgAIRPP3iJX1QE8UhdI5iZXwiNg+JJdSjY?=
 =?us-ascii?Q?QaDrTvH21wt7X8LRtLSqIUR+ZndF/497WJ/jz385HYtVh1uWw+lX36mp3bKY?=
 =?us-ascii?Q?dp5kcFrvX05w2xnKtk4j7ZX7NK5FvNoT4SE1abmfkGs/mE4I+cx1r2VysOAD?=
 =?us-ascii?Q?B8ZsAJ3uRrqpuSwkkvv+EfzqTD0O5oQy3Bfr0N25bNeBhULRff6CtX68LFkD?=
 =?us-ascii?Q?jCqGTZh6+xadOM/a2OpY91+27kvNdzP/pAZrrZrIZlw+sI24DuWiB9Z1MgFK?=
 =?us-ascii?Q?4hT5wXBcm7pE6ts4yWw2FnpAbIdNi/ksEEHqZXEU+JqLW1FvrDeu9NabzvP7?=
 =?us-ascii?Q?d1IW5bEXlH+dFHmou2E8gIn7VY7Ve0Un4Gv9yNjUopz8+5ualVZHnwmG7wEU?=
 =?us-ascii?Q?U6LD8Q+UsZ7SqLZd8VTGJt86TtIyyLYWfCk0tUYgUYurYGh5HYVkU9Xv+yBf?=
 =?us-ascii?Q?cnYHaQOF2/mjLdddi9HOdqc+nKBZLlJYcXWiOCV7uPJ3BEK7ScoG6//+lqun?=
 =?us-ascii?Q?vXYfU9SZvYhHLW/Dmi5xqSdBvNoeCQQmXhjngUlLmelwgJRtXV5QUKGyq80z?=
 =?us-ascii?Q?6C5UA9H+NgdkT1G1qZ9sh49hwnd7Ct/nZhf4gyTonW7ppBfkOYg/vipqxnBb?=
 =?us-ascii?Q?RQ2p5fK3rLSqaCq3uOjF+E0QsPyi6uzUQLi/ZpVuHSyt9n0ieIl4ynGndVlW?=
 =?us-ascii?Q?nVbQPIR5ZAJ1slwkkWoZBzP0vBK470xxMBb0EzaUd7UxzQxpH+EeFdAdJzVp?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vfqmpohOdM8fXvxLpu/01ZuGzOg7PwZ0ozR2lbajVzx6vzhLZiiuszQyjrcl?=
 =?us-ascii?Q?ryl+1DpQKjtdmAGANtlhKMvPaXe5/B8CtxvPLsj4NuEdZHfulYsm1omOTWxD?=
 =?us-ascii?Q?/JMudIUY5+Y+Irp7aSUUtEg/Kk6e04+DThJwz3eQRmbhCH+rzZmmoZrE3VoC?=
 =?us-ascii?Q?Z8phTjDxnTgOYsTZIuLmHeymr8Uyhd66qXXu44UjG07qwQVkf4/i/oNbARA5?=
 =?us-ascii?Q?QAR9JdJ/KaUK14JrYsMPCvzkq6OEt9gVwODkFdFOnhbxwgiLTFVE5TOv+VOF?=
 =?us-ascii?Q?rWxG4XPSlJFWAzmRuQeUv53JunyUp5AG7GkBYeVWr7qLRIttWamhX3k8KGNt?=
 =?us-ascii?Q?+sAd7+krzmps0lNzz0z9CioMZCwA/5BetYt1P+pPPZpQ6jbKRx7KbZyfWMYr?=
 =?us-ascii?Q?HYdXvy9UiXduwqYd9pX6e9STcxHSW3OOljPBGmJ+xzTiclckR+TF8xrjShvZ?=
 =?us-ascii?Q?seh56nQ4gZ1xCrrf1zG9gWwiUJhFocevt1Ts0FPU2tBn3j2qHTeFAzcXewce?=
 =?us-ascii?Q?nz0l3ZTmbRbM6ulJ/Ay4SooFbiJtogV2cfSyLWKAdZzSpAzb/Wv6lRQ/hz3O?=
 =?us-ascii?Q?HPbEAuh8d8UW7jZOxcNFt9drnGENFvuOYP22lmzpKe9qJuBqR+K3Tbm4wHOH?=
 =?us-ascii?Q?R1wm66NuwZOx0FZEZYmstn3LQXc6f9UL+j3khuT1jrlAQYL68AOfmdTK2LF4?=
 =?us-ascii?Q?jkYsxnEHAkptTkT7x60AvnHDpKQUWAvsmQ++4opGi/TbKfqLAWdBzkliz6Hm?=
 =?us-ascii?Q?+SbUAPJA0MyMOQwS6MbJpIHwS9qh32l/Kn+DVRSK1SbbwfoGveq2FdDEp1mM?=
 =?us-ascii?Q?9NwxWf2tyi/4wVO99msqd5ZLHkPf80QPPvo3U99KOGE6T1uliCuPL5NGd5mc?=
 =?us-ascii?Q?/Co+MIxLnbfhTCLu9slXzwGk1BncD3kONS6EV7jtg4nh21DkU9xNl6KatiO9?=
 =?us-ascii?Q?RIHX+4Ka496jbAogE/ecEhKpoMpFs+CL/RtXYEhUPK0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04c46dc-f5c0-4a27-89f0-08daedbea8e7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:13:56.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JRmlWVWl81M5IEhYBPgVljDqVM0hG+VWqBajXFGXKYugvStYZLQ1th5ndstJd+SggTblra6fFybQfZ1L9X10CXkwReZcNGol+saRckMJa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030165
X-Proofpoint-GUID: 5bTscqf6diMvsntDreXqtd4LaLPGaKlJ
X-Proofpoint-ORIG-GUID: 5bTscqf6diMvsntDreXqtd4LaLPGaKlJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the hugetlb folio flag macros inside restore_reserve_on_error() and
update the comments to reflect the use of folios.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0db01718d1c3..2bb69b098117 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2678,22 +2678,23 @@ static long vma_del_reservation(struct hstate *h,
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			unsigned long address, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	long rc = vma_needs_reservation(h, vma, address);
 
-	if (HPageRestoreReserve(page)) {
+	if (folio_test_hugetlb_restore_reserve(folio)) {
 		if (unlikely(rc < 0))
 			/*
 			 * Rare out of memory condition in reserve map
-			 * manipulation.  Clear HPageRestoreReserve so that
-			 * global reserve count will not be incremented
+			 * manipulation.  Clear hugetlb_restore_reserve so
+			 * that global reserve count will not be incremented
 			 * by free_huge_page.  This will make it appear
-			 * as though the reservation for this page was
+			 * as though the reservation for this folio was
 			 * consumed.  This may prevent the task from
-			 * faulting in the page at a later time.  This
+			 * faulting in the folio at a later time.  This
 			 * is better than inconsistent global huge page
 			 * accounting of reserve counts.
 			 */
-			ClearHPageRestoreReserve(page);
+			folio_clear_hugetlb_restore_reserve(folio);
 		else if (rc)
 			(void)vma_add_reservation(h, vma, address);
 		else
@@ -2704,7 +2705,7 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			 * This indicates there is an entry in the reserve map
 			 * not added by alloc_huge_page.  We know it was added
 			 * before the alloc_huge_page call, otherwise
-			 * HPageRestoreReserve would be set on the page.
+			 * hugetlb_restore_reserve would be set on the folio.
 			 * Remove the entry so that a subsequent allocation
 			 * does not consume a reservation.
 			 */
@@ -2713,12 +2714,12 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				/*
 				 * VERY rare out of memory condition.  Since
 				 * we can not delete the entry, set
-				 * HPageRestoreReserve so that the reserve
-				 * count will be incremented when the page
+				 * hugetlb_restore_reserve so that the reserve
+				 * count will be incremented when the folio
 				 * is freed.  This reserve will be consumed
 				 * on a subsequent allocation.
 				 */
-				SetHPageRestoreReserve(page);
+				folio_set_hugetlb_restore_reserve(folio);
 		} else if (rc < 0) {
 			/*
 			 * Rare out of memory condition from
@@ -2734,12 +2735,12 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				/*
 				 * For private mappings, no entry indicates
 				 * a reservation is present.  Since we can
-				 * not add an entry, set SetHPageRestoreReserve
-				 * on the page so reserve count will be
+				 * not add an entry, set hugetlb_restore_reserve
+				 * on the folio so reserve count will be
 				 * incremented when freed.  This reserve will
 				 * be consumed on a subsequent allocation.
 				 */
-				SetHPageRestoreReserve(page);
+				folio_set_hugetlb_restore_reserve(folio);
 		} else
 			/*
 			 * No reservation present, do nothing
-- 
2.39.0

