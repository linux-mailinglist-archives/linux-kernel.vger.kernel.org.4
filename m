Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA90743F71
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjF3QGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjF3QGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:06:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9163A4208
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:06:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UEnFvb015086;
        Fri, 30 Jun 2023 16:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=LuvMypRXg6TH4Fk5TMApmb2cbUUiVUCqESBeOtLdewY=;
 b=suW85RcbBf78xcdWnsThEZzzwvaxxHbZfxpIitP4kyj708Lqx6WAwST+0YnatiyC2sAC
 WVPmIFI/BkSU3ltae7vFd5EElzGoGUWhAPFwr01NVhbZrJGg6l+RCmAEgmDZQPaVOMpk
 b3ZS840BPz9lPnhBiQBwnT2FPfgVIzU235wXMtevjkv51z31M0XglosxeBNsP9Yokswf
 Sq/NrmrDn6GNGI+WRmXcLeuXk2RkAN/SUD/qOR1YUar/qK0allkVsGOBaYEggc6yaIue
 xv8B1ApSCYowGJuV05lCtyyjV0MuNfTEAkwK0AcUqBJ+umcocv59Vu56QfwcMyU7DPxN oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq319j61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 16:05:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UFXEIZ003961;
        Fri, 30 Jun 2023 16:05:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxf2ppb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 16:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N71TVR/8IHbnQ8+ZatkG10A24Niq4AKIG584Ft4JJWJa2GhUW3FFQLKIflKH6slDRtfict1DdTPWD2ht7uRzgLjF5UZLzVpI4Xb8K0nzRwBFqA39GdXWDBSRY8dMw6LbwNGCEVuiKl05ERTRNeUd2OfQ7T5YZJH+OvNh4vSbOLF779ag7JF3h2iGKi1rC7GR4IFaQHD/YEQ6RYNRgrAaOCjEGTpAoEmpqcZ7hmGY7pM3QWQZbOivXnXzKn8gZOkKZH6w+mqAdIHs8LUQVvVfsru+v0FzvvcPmb/skpb/mJGKYAIpSHoP0gKiaH/mIwfXh6yc9xJAhGYb1kHXMlwN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuvMypRXg6TH4Fk5TMApmb2cbUUiVUCqESBeOtLdewY=;
 b=jqrzAyECD7Cc8uEEGR9X9FLQZ8+bSPf10L4Z3TXBE2UAJgKW7y2GlZpUcdtzDcYWM7yoDJa7xs5I1bstn4YPdNw7627fYDZGMLZXYkAyBvA/KBbwWdP0Q9iaiSnIYxrk7yurUMZoHb7h/ReidupTJwMAdNGIP5dlx/a92KDF8fNDdzG0r5BxyFsqU/FNwvRA744+VOT1UpO9X0zo/L4R+JpVyFr3ZZWvk9onuHxrJMHEmUhiBYQ0KEm98MVVc50YE8PJaOWZnmBQ54uZ6d2VZID44McUbWTSCeWEzzLzryK0BmWU1D60G4z4X/gT/7o9g1b3n1D9lqqFxaLBUvh/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuvMypRXg6TH4Fk5TMApmb2cbUUiVUCqESBeOtLdewY=;
 b=0UISVctsL1l2WSwltdpY2/q3vS/qRkg+FW0kn0wYJUkh/cLytOd8p6gVwduE/tgOu22cJl/kSuMpDKC/l4vftRbKzSxZOc+ksNwQiTIQ5XiSpbLrtyJi/jw37U+vA9ehviHc1yv5boyBX+NoPy+mUwqAWzk9kYchu0K0rfjCYRM=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by PH0PR10MB5402.namprd10.prod.outlook.com (2603:10b6:510:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 16:05:50 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::de2:4e3f:62c2:865b]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::de2:4e3f:62c2:865b%3]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 16:05:50 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH] mm: Update do_vmi_align_munmap() return semantics
Date:   Fri, 30 Jun 2023 12:05:19 -0400
Message-Id: <20230630160519.3869505-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <wiuXi4KmjgTocOZMpHTZuZP+y8r5wYynvvT_ZPXyG+TYA@mail.gmail.com>
References: <wiuXi4KmjgTocOZMpHTZuZP+y8r5wYynvvT_ZPXyG+TYA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0264.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::25) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|PH0PR10MB5402:EE_
X-MS-Office365-Filtering-Correlation-Id: 296bf6aa-d713-426b-250b-08db7983dfb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yl3PUeJ6MskAUtdyC/tTJBHgPbH5u1P7aEZsm0jjNr+L/DHqg3/X+yhQOlK5NOLixsRVC1DzKj5Xv+JAH7dRZZdutL98noc5jlyKeuN2hNhRJp0EsKxq9oFQs5ZqRVHhbuZHBpm0AXTlHnBIUlsWpnquFAEpKis0lM0e9ITeWumYCdQ0tXhrw2BMlpeWEMRDTaSaF22a9QQyRuP18DFnjRx1e5aCV6D//4r8kwP72Ixx+fQsU1gs6Mn6jt0gvYQm+bbOvYSSg/FpQ6L0mBcfyAatpt5y8n2jHLi+5cvuuGeVw31s4t1MQO1D0P6VOFWL5O5Q8GfMCSCwrjA4k4f5G7j8BXColYWu1c8ZQwTTV0qMuHd964JJAPjzhCn2I6JRfTqXV1vJM8YT83mWmAk3KShMBKpUR7eJfE2jJ4BeGQuS+72awIpRKXzl85Qp111JTMAikKZMmcOQzpvLGFW3cEfV0x4csijpvhF+shrqZZIQlVg8ahZP6AdddrW2M3YMBX7vPNgKLGhij7AHyvphGPWkOIRC/DyBbL5egWyFLC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199021)(6666004)(5660300002)(54906003)(110136005)(478600001)(41300700001)(6486002)(8676002)(107886003)(316002)(8936002)(966005)(26005)(186003)(6512007)(6506007)(66899021)(1076003)(66476007)(66556008)(66946007)(4326008)(2906002)(86362001)(83380400001)(2616005)(15650500001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ZH00XvdF2epX1KWGLpnVtIZ7DVvdy8vzRNUI9BBxw0Jo8+2dmFot3sUSIi8?=
 =?us-ascii?Q?K/wYXFmrPNsAf8OGDkatOb9JNcK0a2i2EMl+ye4Ck6hxbRQZ/VkfooeICb0h?=
 =?us-ascii?Q?XwBtHoYcWqfqBTQl8BUfQGNfQQKow5309gURhxzKCxQoSsqt74Aa0GWS1i6i?=
 =?us-ascii?Q?uKHIBUTNSP5tOS8ugEPQm+3BWlPa7nQQ+1TP3lpTcxZBvDfYoxAmyHheq1uT?=
 =?us-ascii?Q?37bYhotVlYi/j2CzMMxChGfBuAYH1bry2YOAw/2nelqY3GwLKYKXkKFxtci1?=
 =?us-ascii?Q?wLR0OjjSJhlbv80GK0WzZVWHm+gsGROeY8m9uKbsS0kroJNJzpV19KRjUzTw?=
 =?us-ascii?Q?JNHpBAnDRrjdZW2iesyz6mr9bcKdU3Z2MBYKUDOK9Qj1yxQ8yh/nTQ7KPHop?=
 =?us-ascii?Q?Le6kSHYuuvPrs6WcVv2EeG7qW8yC3A1azwmAHtC+O1deGINJ0vWrnzgDuWUL?=
 =?us-ascii?Q?dSTs8u73nqbJMoAxw3/jfMPiuxCsgLjcHu7EAgrT6EMFwPyL5V/NcENVvGQY?=
 =?us-ascii?Q?yiRlakys+qjC2mQ58+vvphHzLz05yZ46Qnltx4TK2rdVcSFZLpFyjhqxonJE?=
 =?us-ascii?Q?88zOtno2x4x5ZasjIfby/tdyP9tDSX2rVm2PlzI55m2iPVrNoOv7Vf+FhIky?=
 =?us-ascii?Q?FwjyeQJpsODVVoyyau0rSExSl2j6TZM3o/CU66xtWIIYUlt93PLc9ZJc9Nz5?=
 =?us-ascii?Q?l/UPsBWk+X7cOzMQhoUEk/s5Bo3Nhjz+ZF5qFq5g6fNdY7F3OHX4ax4Tk1jK?=
 =?us-ascii?Q?XMenkE31vGpe/woa57gJN2Q+ywLsTs0LlN6ygLQbAxGMDoxD75PHoOQYBl4R?=
 =?us-ascii?Q?ZNn1YMMJXa3gbpftuf7nh4XnQXTZd1QncMlXMBFql/SXr+ZSDlvuFbkYWjOc?=
 =?us-ascii?Q?aHTZOyQfO1IZRLmPsGgni6CfD/6y0J0k6b7xu/Sz7567l/yqmphGLEUdPS2o?=
 =?us-ascii?Q?JRUuaTmPdYSQ4SZkHsF0CfP++T1Z0Q6UzVH+BzHDO5a3zNNufZHvFL+SG+YP?=
 =?us-ascii?Q?ljNLIuywegvL0QMv5EkR11+pnJ6qszwt8MRakmR/dDfT8VTEs2br7n05sCHf?=
 =?us-ascii?Q?RWHu67G0u0bhmR6v72uO1TOK00qE4Gkh9wIv30cFPM5LtthgVNxzdWmtjkB9?=
 =?us-ascii?Q?D7mbXMiH6lUdVQ8Ohbd3oHSIQzQHyFs6l7IqLiNLbRdX2P9cSe7xb0TPYwc+?=
 =?us-ascii?Q?pXZAkZ4+NmXhEKWS8sS0AHB1gXsjeN+BwGDxB0el5geDicS5bCasSO2Gc3IR?=
 =?us-ascii?Q?S2RUJ7639aoWxyQnhBQ3219kS/ilUss+I+BKkgq4SgB6SsaCEOtPxLRDI+VJ?=
 =?us-ascii?Q?7asNLj6qrQgDJvr9hJJTnKY8xmjympCx4wA7DaJOQsbtkQuBsbh1xfxT5JPz?=
 =?us-ascii?Q?m22VRqGI+JwpkS3fWilCaibjBlw3/WiiyE242m3m7KdTnOMGqNzYKTXgwJcY?=
 =?us-ascii?Q?vbINcqvc+YVUyt57XXDNT8Fi5ZNlaUS/WsI7bWwl1I8OylQutc1nX6DgfbQu?=
 =?us-ascii?Q?cUrQEkOuJb7wIURWcPqnB/R9Fi/IIcPNe+LR81nhdVrAb/QsTqXgcFdYDxLj?=
 =?us-ascii?Q?HEzvm6YPy1ge7YgHx8skOL8iMMXl94bLU2CQxhaYEfViEyH+jYxR9lg6AqeR?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gsUzLTyfdcs2CQcihGTBcUTJq2BWxhmfwrqCbpSJAKwSQ2djH3lQZj/mEbqO+3pel6K5dNQaxlz+P28C6IStgrP1jeo6dx22DFxp7xUj2pd+SYeA3qlq1nYY0Q/OGoLqkJZlSQtrnmKxu4OV85w9F2xZwkA+TOrz9sgqUAjVCXGC1rjI3Eb9xp+Zv+zcLbWlIQXd/TNWlJw2EU7W8pl+sj+SzSWizmVzj0hCgr97zDjrtDT/k+ZnlKK8Q+bs/pMzUjEIRceGlqE6XqWxTRnbX7pnuRbLd/sFCqjUZsA4h4pa202pSQ7erM3hbOcFt7oOXSI3oVbGWMQAKJTtV8N3dj26ZAVTJiaMHgaIEUjm1u9+jRZfPvL6+dbIe3tGtFDwv5u1iyLEDQpWukRph/S2qDorxBHoP/EUpcHutbSgrC55CqktGTVVXuQTZ7E4R5c1D2Perp2vUrXL2pmCcQZZ4AIexdPG3dNZRkGMX0m9ACwOr3l3pgJ+n6x0uSZWeA0A1C5/gYSmDuL5J+LPTd3xsjduE4Fpdk874kcrQ6WoZKLA4kRIU0G32YMRFSY8cG97NuqgI0+YsALVd9lv1dJAzfRgJn49rEUeLRNgNhtqn+RmNz7CePKYLWd/mqJ86RhgxXS5oCQjLeYVLVCujoQ6Fs6DNfOIAobdYGDyy4yX7E70YiRtUMuT6N8RtfFda+ewMI1fA9CzIXI6pD2UDaNyQ7uz1it3iXC/q3zLYdIXbhwgbNYMEEu0a5oKcTs6V/9jJCQ7ZcUP92ontVMRxS2BjTaO4reM5PbQej2Gca6e0R2YESA3WsH8YwjQZ/G3F0haACmI8Q8rdflqEcMGr049ODuOuRXza9sk/2bJ+Kqn9f2bKwGeUKX9AFwhcQjTXRg6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296bf6aa-d713-426b-250b-08db7983dfb5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 16:05:50.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHLZv6Y5YxU/NJBgBYnjQ1PRMtEazvv/RJEq0N+ZB+pBySRe2Eax1aai0SLE1OyvjzVhrQ+qxlZc9oCZ+da8qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_08,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300137
X-Proofpoint-ORIG-GUID: iJWBLKehgH8KA-N_kviyYsXgAnEiu8zT
X-Proofpoint-GUID: iJWBLKehgH8KA-N_kviyYsXgAnEiu8zT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since do_vmi_align_munmap() will always honor the downgrade request on
the success, the callers no longer have to deal with confusing return
codes.

Update do_vmi_align_munmap() to return 0 for success.  Clean up the
callers and comments to always expect the lock downgrade to be honored
on the success path.  The error path will always leave the lock
untouched.

As part of the cleanup, the wrapper function do_vmi_munmap() and callers
to the wrapper are also updated.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/linux-mm/20230629191414.1215929-1-willy@infradead.org/
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c   | 70 ++++++++++++++++++++++++++---------------------------
 mm/mremap.c | 26 +++++++++-----------
 2 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 141c618847ac..a970542d0055 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -193,8 +193,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *brkvma, *next = NULL;
 	unsigned long min_brk;
-	bool populate;
-	bool downgraded = false;
+	bool populate = false;
 	LIST_HEAD(uf);
 	struct vma_iterator vmi;
 
@@ -236,13 +235,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		goto success;
 	}
 
-	/*
-	 * Always allow shrinking brk.
-	 * do_vma_munmap() may downgrade mmap_lock to read.
-	 */
+	/* Always allow shrinking brk. */
 	if (brk <= mm->brk) {
-		int ret;
-
 		/* Search one past newbrk */
 		vma_iter_init(&vmi, mm, newbrk);
 		brkvma = vma_find(&vmi, oldbrk);
@@ -250,19 +244,15 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
 		 * mm->brk must be protected by write mmap_lock.
-		 * do_vma_munmap() may downgrade the lock,  so update it
-		 * before calling do_vma_munmap().
+		 * do_vma_munmap() will downgrade the lock on success,  so
+		 * update it before calling do_vma_munmap().
 		 */
 		mm->brk = brk;
-		ret = do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true);
-		if (ret == 1)  {
-			downgraded = true;
-			goto success;
-		} else if (!ret)
-			goto success;
-
-		mm->brk = origbrk;
-		goto out;
+		if (do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true))
+			goto out;
+
+		mmap_read_unlock(mm);
+		goto success_unlocked;
 	}
 
 	if (check_brk_limits(oldbrk, newbrk - oldbrk))
@@ -283,19 +273,19 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		goto out;
 
 	mm->brk = brk;
+	if (mm->def_flags & VM_LOCKED)
+		populate = true;
 
 success:
-	populate = newbrk > oldbrk && (mm->def_flags & VM_LOCKED) != 0;
-	if (downgraded)
-		mmap_read_unlock(mm);
-	else
-		mmap_write_unlock(mm);
+	mmap_write_unlock(mm);
+success_unlocked:
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate)
 		mm_populate(oldbrk, newbrk - oldbrk);
 	return brk;
 
 out:
+	mm->brk = origbrk;
 	mmap_write_unlock(mm);
 	return origbrk;
 }
@@ -2428,9 +2418,11 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @downgrade: Set to true to attempt a write downgrade of the mmap_lock
+ * @downgrade: Set to true to write downgrade the mmap_lock.  Downgrade only
+ * happens on success.
  *
- * If @downgrade is true, check return code for potential release of the lock.
+ * Return: 0 on success and downgrades the lock if so directed, error and leaves
+ * the lock held otherwise.
  */
 static int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
@@ -2566,7 +2558,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 
 	validate_mm(mm);
-	return downgrade ? 1 : 0;
+	return 0;
 
 clear_tree_failed:
 userfaultfd_error:
@@ -2596,7 +2588,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * to MA_START and sets it up to remove the mapping(s).  The @len will be
  * aligned and any arch_unmap work will be preformed.
  *
- * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
+ * Return: 0 on success and downgrades the lock if so directed, error and leaves
+ * the lock held otherwise.
  */
 int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
@@ -2617,8 +2610,11 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(vmi, end);
-	if (!vma)
+	if (!vma) {
+		if (downgrade)
+			mmap_write_downgrade(mm);
 		return 0;
+	}
 
 	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, downgrade);
 }
@@ -2628,6 +2624,8 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
  * @start: The start address to munmap
  * @len: The length to be munmapped.
  * @uf: The userfaultfd list_head
+ *
+ * Return: 0 on success, error otherwise.
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
@@ -2900,14 +2898,12 @@ static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 
 	ret = do_vmi_munmap(&vmi, mm, start, len, &uf, downgrade);
 	/*
-	 * Returning 1 indicates mmap_lock is downgraded.
-	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
-	 * it to 0 before return.
+	 * Returning 0 is successful, but the lock status depends what was
+	 * passed in.
 	 */
-	if (ret == 1) {
+	if (!ret && downgrade)
 		mmap_read_unlock(mm);
-		ret = 0;
-	} else
+	else
 		mmap_write_unlock(mm);
 
 	userfaultfd_unmap_complete(mm, &uf);
@@ -3019,9 +3015,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
  * @uf: The userfaultfd list_head
  * @downgrade: Attempt to downgrade or not
  *
- * Returns: 0 on success and not downgraded, 1 on success and downgraded.
  * unmaps a VMA mapping when the vma iterator is already in position.
  * Does not handle alignment.
+ *
+ * Return: 0 on success and downgrades the lock of so directed, error on failure
+ * and will still hold the lock.
  */
 int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		  unsigned long start, unsigned long end,
diff --git a/mm/mremap.c b/mm/mremap.c
index fe6b722ae633..0509354bf7e9 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -913,7 +913,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	struct vm_area_struct *vma;
 	unsigned long ret = -EINVAL;
 	bool locked = false;
-	bool downgraded = false;
 	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
@@ -1002,21 +1001,22 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >= new_len) {
-		int retval;
 		VMA_ITERATOR(vmi, mm, addr + new_len);
 
-		retval = do_vmi_munmap(&vmi, mm, addr + new_len,
-				       old_len - new_len, &uf_unmap, true);
-		/* Returning 1 indicates mmap_lock is downgraded to read. */
-		if (retval == 1) {
-			downgraded = true;
-		} else if (retval < 0 && old_len != new_len) {
-			ret = retval;
+		if (old_len == new_len) {
+			ret = addr;
 			goto out;
 		}
 
+		ret = do_vmi_munmap(&vmi, mm, addr + new_len, old_len - new_len,
+				    &uf_unmap, true);
+		if (ret)
+			goto out;
+
+		mmap_read_unlock(current->mm);
 		ret = addr;
-		goto out;
+		goto out_unlocked;
+
 	}
 
 	/*
@@ -1101,12 +1101,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 out:
 	if (offset_in_page(ret))
 		locked = false;
-	if (downgraded)
-		mmap_read_unlock(current->mm);
-	else
-		mmap_write_unlock(current->mm);
+	mmap_write_unlock(current->mm);
 	if (locked && new_len > old_len)
 		mm_populate(new_addr + old_len, new_len - old_len);
+out_unlocked:
 	userfaultfd_unmap_complete(mm, &uf_unmap_early);
 	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
 	userfaultfd_unmap_complete(mm, &uf_unmap);
-- 
2.39.2

