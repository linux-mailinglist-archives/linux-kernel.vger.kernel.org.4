Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA81708528
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjERPjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjERPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:39:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9F8D2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:38:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6Ir7f012413;
        Thu, 18 May 2023 14:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=FZc89H8cc3jCASthTOjGzkEfMxavJWu8DLVc2e6ZxQ0=;
 b=tUSgWHxp5dOcpVKMLY+NBufRXIHQulwLgrXU5O9hIUIJSDUIOakObWh5+NoQNYyupPml
 8cUtspTFSMTulBIjk6jFoMXL1MSLUat6r/8EFqpmOlOQUHsPF24gngKlL8Z46HPDKfRf
 eKONDH2RFKx5oNQRUrEwW1v3S2dHRXqlBmc7FJ0Ozh1Ko1NRAd3e//rL5Rrk5f/7WkH8
 4wQpgC1S8QGiOeJLuUufBrNkrRjfzTIArN3VmktGK2t1O0Wtoz09V97bAOccKGuc3zqd
 0NMpkZJZO7Dbe06NYXw/ja6ehQ1uEFVOziUWJLK/7TNuhYd0mKeQDdUoHSJLf48114Tj Xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpjr85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:55:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE8DIw004253;
        Thu, 18 May 2023 14:55:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10d66jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:55:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L26YVZQfOFQcycfoS1mdW5ipR7KMXwFssJKTxaa8DmDwuK/MRVmsd4i7GR/yfWjx/+VkSxGu4WGrNbxBYlnGSDu7OTyXxbzDlWNxHRGPgeTWFZr/whQrPATuKHj0+Fe2fWVA45ZLFO46dY83UOhYYftpLETjByVF9Zhzo/W5PA7X+yh+i3Qu6wP0TaWYTUDbUpKAmZhqIRdI36Qw43DO/c3zlGQXtAVJWyElhysXFTL7PFquVOTJEPwppbGNP2XDrgcfAUNb590bVSXsRlqVSAopKJKXsJIMveyA0tLVkmXceVdZhihHGBeKXnlaDWAgYf6fx9UEpykNhoeS3GX+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZc89H8cc3jCASthTOjGzkEfMxavJWu8DLVc2e6ZxQ0=;
 b=S/MSgTUHt/GaLWNhGeNxPEQFGZXuX6aE337L36wsqAh4jXbQcs22kaPTsM2RWmr4NtQlDXRxHzYoZVG6lafdnML2zX38cT59K1t9kAIpsXC5YTxg8/XUfW8HS+h0I1VHl+/bWELKSGhvvrYYuhSSBrxuKNDhOHhoYKo1l7m5c41QgPLXYh2OlITWMzW+f3AJGaL9BgLXmOtrnLPFrZ5DNxucNhIfio12AOcU5J9Jq1qAjbfE9bCyrHx+UJElpXLq/2ateyFjMWka3yvdZmcG+UiHT0p30tZVs1bH64sbj6BGcHqwY9Oarbcqtu/D+8BPohLVSJKxFp9UQoKiZpW72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZc89H8cc3jCASthTOjGzkEfMxavJWu8DLVc2e6ZxQ0=;
 b=K1BWzRg7EiO1+SY+Iiba4AoIDvqn2XjLz/BLklGmmL6yt3psOdGuTcN5jBtyuaJPsXlHnwYtyYZ0irSCsIoOYYcg3r3hy1OYwE5WwRG7Yy2efNdlT8BfurFK54h+O+rEJtV6K5hoigsYfFGMCOXdvNC5xbRnJFklIweOV9zewG4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:55:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:55:51 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Binderman <dcb314@hotmail.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 01/35] maple_tree: Fix static analyser cppcheck issue
Date:   Thu, 18 May 2023 10:55:10 -0400
Message-Id: <20230518145544.1722059-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f98ea4-4e4c-4aab-84c8-08db57aff91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbT0IxPcBLkgNgRxryjbeGWpH3mqD31jIswB9OR0u2fPOXRSobFYl/yOlKm4DD7pquc4MXQsomyfgJqEDSnX6+TM/F5S6BdN2RLBjoao2YT1gf9VteAjuD8iKMxHNCNvjAwGSIP27bqREIYYuUt6B4KaKHH65ROc3IOhdXFhznuiKUaxe3amcS3L5ZlAJAYX1/992OvY83qY5CXc55zwbYCmqBz9QfcNFxHKtr9+s0kyfmExsR4huaVFXKGZ8hD3HvjO8HjGV25slhhjwoKevDpexOKz82QmNB7iyeMaSZAuZStOp2mvo0Pi4+Z6aheIzFSr1oAI1wIIfXZY/xa+NPvHbS50NZ55ch8iBpd9V2itZkrni8RkkO7kgBl68U8SQK4VO2utWpird52sSd7Yno64CTCutibbikeJqzb2bSlND3R9fDNlszC0Kh4rDyEt6AXBFDg0d6I7NKLXXq5EP99poHMxME4wjwZEKfJcxkJl2zB7LHiRIAK7/oFkwRRqEIVLMuEoIw685HpdmWT/IqVfc/4l/1NcDqYDpkLJIwGhBwJ6QlFS2lr5f+cgvLHH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(6666004)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(54906003)(2906002)(41300700001)(45080400002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hhuvzDaaEs3k87y9ZPdJH2veIHXWfdyUDsYUWIuldnwu0jN1DsXyX/EgKr09?=
 =?us-ascii?Q?6qnIZ/6YjlM0UGpqCxH8tK5TpsQFPb/ZCrOt9zKXWz9MeR9Ym9qZ0kFmhEKC?=
 =?us-ascii?Q?tvcr+R2dV69ZuD17JxUULbaeDItrFVj+vTaVUHZ8Cg6OBUKy9mJtIvOg2APT?=
 =?us-ascii?Q?MU0aqpC2cdbPgK5TYFgjMDyWaxJVa0Qq6en4sylXqQWCt/NTZscOaw5/Gm/m?=
 =?us-ascii?Q?K9RRtlm9xUxLE2Mf1/jaP+PKiHRlJvmMUmjXIXZlohOScF3dinJHJZjME2y6?=
 =?us-ascii?Q?vCMJOxhgcVzA+HLNv3yjyx4MmHUdgSbI96kVIbt/jJtfDIIv9irLJdS7upM/?=
 =?us-ascii?Q?vz9bNtSD36qAkKud4MweJx/4n/1TvAA3bLjGiedWGcImPjICCvWEqzcQwigS?=
 =?us-ascii?Q?QkeqUCkrrBonL325bRdrUEJhjNry92BXQLPubh7gFQlbE79eOTzo3LNvqj1n?=
 =?us-ascii?Q?XF7wSLinZOAqlYQxOk/QLo39GPjsY4XN5fL/FwvhQQb4F+w1dGcsRYNkAsK5?=
 =?us-ascii?Q?e4ScS3I6S0EML4PVJro0YQO60E3Ce7Jihg7sH0XeEpB/XYsZZGML9OvFVVC6?=
 =?us-ascii?Q?C/s2Q9HazatZWrr8iQKrSSODF33G6NCjwgAXwE0VGZdWCNb0Gf1dn0a7tgLy?=
 =?us-ascii?Q?NZr9KXVrh4NWJxA5hxck3GhKWvjIQmteie2xrSVXzb/w/6xYMIG5cUenmzu+?=
 =?us-ascii?Q?LrtNhX/cu0dBwuFuxpjgXyHkp6QsibX7uBc2GoSEQPTDFUwGjgkyFPrSrHct?=
 =?us-ascii?Q?wxZYZ2TTVb3gvV240JwRLHt5vac7mr4FKIBpHiJAMsV48SSi3uplTHESqNgF?=
 =?us-ascii?Q?maEyBchrUOA6TcX9wrEHP/gTxgdBBLzEyjE5JBIUFILLWut0AW8t+dey1J0P?=
 =?us-ascii?Q?0v3RiLyKHrUtMJlmL17B+RLRw30c6CsqROP0tu5ZqXS2LgKYCGPtLY1xb2J0?=
 =?us-ascii?Q?lsW2hUR/eqhrNdDIfzNdvhoOTnwlQjOW6XFwX2ZwcK4vRcl1hxEDsNLocxNE?=
 =?us-ascii?Q?W+EBKVnxwSFvRszbuwhjd7ksIwlwsu3ADV3bur9KMcvkkoQ8e+ZDVN7Wjutt?=
 =?us-ascii?Q?DzOJik4VKCyuGiHYAlOod15OILyQtgkLsd43XKj67x/J2enQ0cW/GpjDm9Vc?=
 =?us-ascii?Q?VACJWDonCS6X/McELo0o1sNtGHbeLwwTnYThJJeFeJzo82iHffvSYXOrRCHS?=
 =?us-ascii?Q?IjEj99F4rs7uN5I5CffLShtQEiZtsuq2zncV+LBWGHows0p6Oqp+oGDnpkjg?=
 =?us-ascii?Q?9pqYWoOpGdYM4FIeX4whL8zsnMND0nd7RZJJz60wEw7qVuXbb/+QAQpyKGH7?=
 =?us-ascii?Q?5/YDSWBK8ernlqNiVUL9r4h3LUr0BgLBodFUGmShjEaHRJOOZXRi5um5buog?=
 =?us-ascii?Q?biBMSygR2yPUVUQR4qwPWzi7iEkbTMtavemHxnUf34Bj6jC121iKcb8RkMUZ?=
 =?us-ascii?Q?/ELma/S1T67PcBnLCEA1cuj1VevQ7lwTLoZ3TKsXX4/1i8UciIc7aLDhljjn?=
 =?us-ascii?Q?qIyGmy4ouVxyK4sV58ASkvdYkJYj3YNq5pwcWn3OCYvo7xHLo1kUrWpWYnbG?=
 =?us-ascii?Q?IKiWEgdmQN6cJKsZjoocMbSWuBWsfHJUwrSIedKKi+Uz0hzwt+yuZe8csl/i?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Nmr/qphyWK/o8lLzB44F/ookJYYjDkQtxM0EQtsf9KzHsd1YQucKNTlVDByo?=
 =?us-ascii?Q?l2JgGNsNR0NRo9hL37XeBbWLS/EIpGDIisrYkK4v8i5hMc9Lzh4z6nf8TuaX?=
 =?us-ascii?Q?2/+0j9ghxS0e2utoDdSAEqKz1gwOuLzVZQToA+JHUFopXUPlMSV72Mw9J5Iu?=
 =?us-ascii?Q?y/npuameCS3Xoj/KMKxDX6SkyTAwVfraNE02EoYkBysdFOUDyRnRSeBd5Eun?=
 =?us-ascii?Q?f+fmZWb403Ak+ZImGpxaar416yjM1Z89F1Tm38PbkGIuNJ3I//7SzW2cWkTv?=
 =?us-ascii?Q?Qqkl6xuSbqH3z/LfZdIWaUn45ilAFnHNmWUnpzvaVQZFxB+2yzsUMuY6T83i?=
 =?us-ascii?Q?VaUDubvhvTQ8bsLAhiSGqa+uRr7cGWzzym4CPtihXpIfrJdlEYpxP9i4SHk9?=
 =?us-ascii?Q?M6pR6RPo4LvH17wJlRB5e8Fmaf5bQfUnhIWha0TJee66JRjHgSSB2vMYDms1?=
 =?us-ascii?Q?WOoo1bY45I4Lk5EbXGoUUKr7lkZfIUmoaB1Ri2kD0KWw1XtQMKykRe5y9EXy?=
 =?us-ascii?Q?DA5GKfNF+qR5UojcrQ56g6zPzaYfUuFa6nxqRdU53W6gb8b6E3/pOSSHBdFN?=
 =?us-ascii?Q?q27pNLDuMwZBldBu2QZEhM0bYgda4q+c/MQMAeq1wAXOb24Z/0byNxMSTrye?=
 =?us-ascii?Q?Mc3JMmW6gVHMyHqfbwf8bP5UZLZ+phbJm2Vx/eYNs+gWxgoHYLFlc9bnJG0I?=
 =?us-ascii?Q?akdLjelKuSIajp67d7yDs2tpZb3Xp33/nad09TytRmmeqeHOFuCBCcmBvBcY?=
 =?us-ascii?Q?cZC8ibyKMA2hi59EfPJLYyh4ETZVilayYh2EGrUjDDHnR7hOUIVExzZXJjjw?=
 =?us-ascii?Q?cA6uWct8tpUrVl7C1YriKJyUTlPZvl9lBzfESnkXnZB3D0AJSi2fhzrcpLov?=
 =?us-ascii?Q?SOdoYx1R1uPeRcPczWvxuyURvN8CmNALu0mdIjlQ0FOmZFLxh8l/mPa9Oj0q?=
 =?us-ascii?Q?lYPx//+gA4Hf7WAhpsy46A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f98ea4-4e4c-4aab-84c8-08db57aff91a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:55:51.4470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgCKL9i+gPwGIPHirTd5MqkvPVXSwAwpanWI+eOjKOuPREdgLE3NUEto88EnnrP7H340BDv5/6TJ2AuDl3ebnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: NMKOVRtQiQ2mXTf_azDIsyeWanyjEtnL
X-Proofpoint-ORIG-GUID: NMKOVRtQiQ2mXTf_azDIsyeWanyjEtnL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analyser of the maple tree code noticed that the split variable
is being used to dereference into an array prior to checking the
variable itself.  Fix this issue by changing the order of the statement
to check the variable first.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang<zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 110a36479dce..9cf4fca42310 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1943,8 +1943,9 @@ static inline int mab_calc_split(struct ma_state *mas,
 		 * causes one node to be deficient.
 		 * NOTE: mt_min_slots is 1 based, b_end and split are zero.
 		 */
-		while (((bn->pivot[split] - min) < slot_count - 1) &&
-		       (split < slot_count - 1) && (b_end - split > slot_min))
+		while ((split < slot_count - 1) &&
+		       ((bn->pivot[split] - min) < slot_count - 1) &&
+		       (b_end - split > slot_min))
 			split++;
 	}
 
-- 
2.39.2

