Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECEC719079
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjFACSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjFACRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:17:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CEF184
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:17:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJvOIU031546;
        Thu, 1 Jun 2023 02:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=FGEQzS2ZqtOSuXKdUJZz96qlDHQ0UK9ObJRJifyRxVs=;
 b=qgjcg80XP8EfXp0dvMK3U8+Eaubp2W2+20jnFCwWK3cmhBLEy9M4JiYUbyaP6eMnhogR
 uyUw6qa99NfAY4QdJVr0EnQK87CIH9zMyGFDEJeELP/21iffKlJ4OKk6dUBAWX8ZwfVh
 FI9OOdE3K4ComtehDHIhnv+PtZsbWeE7qPuY+WiLpMMOEmywGVpiShBIb16FP1W/FhAc
 SLUmWiJLZOZu6DBQIZ1TG4Z74hgdv+JHavCZ4ZSnaA2SH84AaaAfe3Ouqhq+yIpaFY89
 N2ytGMdvTe9GZYKEQTWc4DQyB/Z5vk+opJ4Cv30YlaoE90f5Z9lyHF0+HJTdl6TPrExj 2A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4yhmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35116JEH000447;
        Thu, 1 Jun 2023 02:16:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8qb17j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsAEPCaImibpTnXH3zeIMYVKBYVPxHZQxymPD8Fkm3b2NUAmqZDLjNEWLIUqD3IjWmN7nXuLKnp1tWwS7FjMpIA8EU1EsNdVzzrp6Ph7+2o1LTsSbbT9VO8Ct0Nv+1aFQ0Jq6ytM5Rzd4EFYnDYwhCjJWQKTUos1vVPKot+EO1bHDVnV5GYEZJ87F1NVaWBsj3Gi7JCb8F4s02BqXsL4la5IP0GzAcgMY1oVg4Y0vjCTilh0/gekPXYicx/J4NtHMs6oRl3S0zcK9ff9PvVNXvFpmFuikqmfYRILa5fkxlUCxucSDJ6D34DQmjZF+ThbusTCFcUca7CMaiRV+Kt9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGEQzS2ZqtOSuXKdUJZz96qlDHQ0UK9ObJRJifyRxVs=;
 b=cuYVSxXDWkQR0VXCUwMEc2cFkvjcU1/ysoN42YH+Or32cHrct/LFCnPuV6aInnBVGq7PGL78GRGp5MPv4ROtJ4aJc5XdkIi7Jse1XfhSYOkCEdZhSd2b9M1bY3nLTDcdUmHQzimS4jHk2jiVQ4nDLkXwmEm/C/SVScDbHkjArV6qr3LGfzNJBV9f2FKn/5CNlBwQVokkBOfs8/jSzqY8tD0kC4IhDAHWwN+vgbkvF3vrQbK+PNNsu8uGkRTl2UIpQ16Oowq2PXOV5LoYKzSw90pDZOEKLmahW0Lql3EETAly/1K1pTkB4/71xmu0Enh9mZJgSZrQB62Vvc9k6GuZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGEQzS2ZqtOSuXKdUJZz96qlDHQ0UK9ObJRJifyRxVs=;
 b=j19U8xWxBSYY+Y1Lc1jMwql/tQxm7HJCZuaDYi3FruGNRqiaHZNVTk+JJ4QdUTwgFFMEItr46XHFH56YbzN6tE9irSiymANZpI/45A+oxZvKc/4d2HpZ+J6HhX8TDLdAT7NBauAzvgRh1xiDZJzRLxqAZhaCTYODA+ovLBgq5pA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:46 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 12/14] maple_tree: Update mas_preallocate() testing
Date:   Wed, 31 May 2023 22:16:03 -0400
Message-Id: <20230601021605.2823123-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: cf938d25-5525-42c8-00c4-08db6246401a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIOiZenpDZWn8zsqDf3pOh/DO8ApqnUHEqbvA4gCO9/SDF2HRfgFLib0ijVvOXrSwjmeUAxxgEevFhJ9r7Vzogtkq4pjyw41SCifBFRCReXq1VmFrP6s9Cat2Ep7ttTI5Ner3CQCiOsyQnuvwMBCZ2Ut6+iZOjne8ZaPxpycEhefgtCK1TtxwooqjO8KIDwb6u8H9RAwp4uUGppjXLUAFODwPIR3A55urdgyHTh+8EoO6UglAgXxKfVi7AtoR74zIh0uwkArbZkkQ8pTOreoq/cddhy5cNI2SdfeDCP/GfUey07zjrgTWfwrP/jhYq7FvPg4MY0qQItwvMudc9Tga+/RSjqGexf66qgZvAbINbyzE51mhz7FOi89y/3xr6Wt4f2io3gw5mZG1zQaZv7sYHExOWw6WS/GvxI7wfWgFaWmxVW695AYJvq+Dj1vygyRjGkifJT5duHKQVIC3KI4GuZ/VWHwE1CC/TShHFkzfZydk2hdyRU75gw7RhYtt6raHEw9c8rKQ6Egk9fwaAWtKJsQrh2sGNKQ52JGZF8fsre9NmRAnyR71IHlGe7Gf35k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9An+2WZJW41Z3wJnC0OwXhar5vexrNBCC5FwwTWijRyPFZOS/Sh6wmPhQx6o?=
 =?us-ascii?Q?H2F9CuB9WNoEGSTuaxGtsaiXsC6g8s0oxugSj2+XeUj6DJYkRtX17QqnjZYS?=
 =?us-ascii?Q?gCqPjWP7W9a2ydeDa5WNQg3SP26oTVe/ONopwKPn8QsVE6q0OYUGVKCFeUVO?=
 =?us-ascii?Q?fH1JwXDVOe1hXDqkiePip9kUietkvvPa64ubi7my86FI6acNyxkLzD92gQQB?=
 =?us-ascii?Q?e8jugvwBUMF9uM7LttJhBuDNwT8+0RUGf/yvZUVcaKrigVs73crGxhyrSVK6?=
 =?us-ascii?Q?h+Y+X6hFcUHdoXrE3fbAJ/Co6cLs0NhoPCIf8TewdsT0ILTG/jtEY3UGOa2f?=
 =?us-ascii?Q?9n42GP50i5IMwVmZAgzD196NaJr2jAkzRCUDQtf0W/cLoRv8x3whzET+NAjd?=
 =?us-ascii?Q?h/uvIL7FsiEp/AKpVGAEz80vaKxyNr9hAdduLhc3fM8nb0NvUeg5kowHHqm2?=
 =?us-ascii?Q?NlCuCCV+GVSig2dd+ghGjbvE6uOWgIgdf9d3W9+kzbac5qgYzk7sl/qvxL+0?=
 =?us-ascii?Q?O9zMgQJF/wEGKpcanV9tcULQK9lCTZaooeGaoDuaxeu2jUzIxAPuiwNn4pvF?=
 =?us-ascii?Q?7dVS3cKSm23wjEHfb0ejyQ3Vhd0WN7/W+doZ+naBXgyx5q5RO/biKVFjFh5h?=
 =?us-ascii?Q?63uqV+Tw6kD7EqWrpHW5f28wIWFHvLUwQDKB2zB6YEDyEfylByF0CKyPiLW1?=
 =?us-ascii?Q?EuvwlbXQA6Bmxcw+aEwlufEqSWvS5TtixZ2wfwgzSMXxceNWALKiLLJbqh3B?=
 =?us-ascii?Q?a2VyTKNiLV6QVNpQ6EU2Sux69alPAFlemTABwK3nVnXtVp7ioMEY636YW4We?=
 =?us-ascii?Q?Eh9HtyBFg0k170HUJb+WIA0IWNPJiqLGnl+lRAxE5vkCGmHPi2wscpMiWS4Q?=
 =?us-ascii?Q?tmxsevHr90RcjJddRJ+JnqB7SR7c/UEwX/m6OqZYAQ6gbBU6Y7bP2JqLIgUD?=
 =?us-ascii?Q?zBozX4bLVV76R33P7FHR3VuNdb7riJe1w9QV9gfIk+j4/0+bYRECbJFLibll?=
 =?us-ascii?Q?YOKwR7pcPVu7q4lLtQgi54Kb6MLjrBkfsnG0bbso+J7P94fXomDg0r4ErS3Q?=
 =?us-ascii?Q?RhQ2cRPGfnnRlcHkQIU2UpLCv7wUczAIW+yXLMxCODJTn9y6ei55ZSJabgoy?=
 =?us-ascii?Q?CI4McuIgf9nAIW2yoUyHJ5RG1AFkwb4uo3mgwCMYBODoGx7MAslPQVIbYijJ?=
 =?us-ascii?Q?8x3mQfjyWAPiRP8brlel0ECDCb8crJArs7bsM8G8Mb8qdVc5fRcs6EMgRB4X?=
 =?us-ascii?Q?iGp4vAo2VuHWRFcuBW+sohReUyKl9VDHHtoDHZZnl4ecHX3fiBxTqi2N/XhQ?=
 =?us-ascii?Q?whQTsmvRhIo3l2UiGrJqEVYxuRLzIqREb2wEMGrokJvjBS2HaAxM0N7XMakJ?=
 =?us-ascii?Q?v9Ps9vU8OptXD8VCxpAtVx66qa1cyorUJk8LaUTjid1H/WO7OHnMLPOWepAj?=
 =?us-ascii?Q?fWNRecmKUS/Ghjs06dA6RDm4Y3TeHtnvE32QV+UXm1XKpVDKqMAsZMh4yuq1?=
 =?us-ascii?Q?0DnZOladJA9bICVyVG4CaAdeQawRM6W/Im4oy0Q/lzEm8S+1tGOjTUqQnEBX?=
 =?us-ascii?Q?SdSKwFsbIpoD/IbtlPCL452ZVxa6eEtV0kqH4ptUYLC/ogNO3C4BOQxStZVS?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Uko0V+o01m21aI7a3RxmIcx5x1mUWMwvlm31X4Wo4RBABP0okbsp5sdJk40BJgdQwweqMzb+HtHjTYjl2D6KgssQuW82lMSfQzQk6DiKZPNOTMlaVDIQS7ht+hrPzhxqGRsRfBNwb9gtdvlDUiUqN4z7f4DihWDFV+r2LOsUBVG5a3s0CNxvOOQR/6awO/7KMCr4gwx8RkW1zjHmD90+3d6nelgNHZbwqvFEYFSdGddS5vQUdBxd654RfExdKZ/pQ9EZzFCEhW2e75RoNoXVaLpxcoWtM14bMT8NgdwxTSVWHwhvB+WAdExGigrD3J8mnq7lmRg1ZQfCB+fJAZBWrWKBbflwG8mWFa2X3/nHJr7t/yY+JOfTNDEI+jSgT7wVhg6xbSnY95X0jqZmLSS6aReC6NbKrV1HHb+V0mhMLTYP4WdHdkrUAslmM+sLMo2cpR0jFkmy63sEOY/wspWKIGVd/lBuU0bgZbOikD9T2ozyEQaQYFbZuFnHgYABix72aeKzEbUuQwmynGRteRaGEKODUIbdpOJyURenEOaDeoYL4Uh+0lqkvbjVFlKASfirrpS1mtQpqwBA8LB8LTjxh4qiwwJuONbE3zgMzSb5fX5wZ6ACL+rghKM1YP8mqvPweq0VoVWuPiWFK8RB+QjUavr/N1Vf2KqaEyxIAUDKmh9qJcTWoJbLYKmUlySLrMC3ZjB1M7JzkZvt3P1HAlj6RpyC0KCYzERBAC8dEYk6+D69TzKdqgogFD3GphsPdtxhn/2C2TzdpF53i5UHKO5svc88U1mm1Q6YXhcPkAEd+clVdxa8qo1xExTqYmgDpOlFSDIPeF8rm3iXLNLUnQdydzR98b8Ae5xR+z6CoLhBQxUNAsOP9AMfTfk/ntk/9/Tv+cUgLwgV8JmI6ngP48JUmw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf938d25-5525-42c8-00c4-08db6246401a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:46.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RE64aboa1KYXYHTEN6vxcAhWqCPGeSkYVGi2IxywEYQQ9B1/B6CAAfsRsekCRcAlhTv8rzNUUzPHQn7bJnGvRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-GUID: yxWeFdedYE3QSHAAJHXDI6NmtaRUDcBt
X-Proofpoint-ORIG-GUID: yxWeFdedYE3QSHAAJHXDI6NmtaRUDcBt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/maple.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index cfadc4b75d51..14d89ba186ee 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35383,6 +35383,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	for (i = 0; i <= max; i++)
 		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
 
+	/* Spanning store */
+	mas_set_range(&mas, 470, 500);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
@@ -35406,7 +35408,6 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
@@ -35420,7 +35421,6 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
@@ -35434,7 +35434,6 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
@@ -35448,33 +35447,37 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
+	/* Slot store does not need allocations */
+	mas_set_range(&mas, 6, 9);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
-	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 0);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
+
+	mas_set_range(&mas, 6, 10);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 1);
 	mas_store_prealloc(&mas, ptr);
+	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
+	/* Split */
+	mas_set_range(&mas, 54, 54);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 1 + height * 2);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
+	/* Spanning store */
+	mas_set_range(&mas, 1, 100);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
@@ -35482,6 +35485,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mas_destroy(&mas);
 
 
+	/* Spanning store */
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
@@ -35489,6 +35493,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
+	mas_set_range(&mas, 0, 200);
 	mt_set_non_kernel(1);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
-- 
2.39.2

