Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16846684F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjALVE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbjALVC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:02:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CC549170
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:46:53 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CK4qTW018485;
        Thu, 12 Jan 2023 20:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Ll8zazKlpDCzUiZ/avQ+j45Xsf0kzAv847jvl6gqI3w=;
 b=vrBS0oso/Q0T0Krtcl1QY1FPCdewyJ3TlkjPan7BeJ96/LCpe8yzt/ERalNQ2ttxrzt4
 +ut+Lf4cAC+aD5cMi0OB7SihC5wghNZNBJUeSvaUrtKplbWel0bkcJBxPvGvi+nNYaRM
 wT6xTGZPecFAFgAiPUrnzi/h3vVOWzs/OVLjzEpZMzhVmGQxiz5YDv9OqtVvutqZ0N8I
 x4QpjkGyQScipPjQT8xG8n/Br9RkKV0Coq+ecqAQZ31jOFo0sS16C6alU2XYN1klYCrW
 pRa+VXWnEclulprU3j7OuMViLyOWTjlnMfIVn2mxG56qfEZ8HTbC4zGhA2pDN0ha2Rps 0Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n2qxy88br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CKGEL4007540;
        Thu, 12 Jan 2023 20:46:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4cryxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5JZiobYgZTMw00vgK1gwirJ2tvHRAHAM+rVA5eLNoM5rAxQ5iFzCdTy9B4fTFKoQ/nXDnjJ9US3dh+JNDUMSeBsc736pgu2YtKN+ABmHvaSPBp8u3B+wxwrA/XGhlM5iJbFu3r/jn+CGzOqDyI4750xXXDKaplz+J2ppm4N67G8UVp/phqXCvHSf5k8CU5bS+7I2VZXQN0yrqRioSU9Mb1QrK4vuV8TktOtKLXaND9WQAtaFqBu8/YsVOw1tvUpD2P56xXrN6FBxjTYzCVfBc4429UopTE3POJL1EPQZf7EfbS6+dwWRGM2UzgIN9BFH7JEwQL1k8dph3R2iPWYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ll8zazKlpDCzUiZ/avQ+j45Xsf0kzAv847jvl6gqI3w=;
 b=hhSGVfbS/f0BkDY6YLNyldu1o012r8i9NmbIQdzAAwDxpC0H3ImTIxebAS3hQjoeSKi/phy3X7ecLCeCQz3HwVrREHZgmc4J5AWeb6w7wR+42RQIxLe3AtrVGzxLPcWtSw4I9bjMKW5E9Y5o5ktJdyv09k4eGGFVhM6VI7N+fM4kASDpTM23IPndpsnOWgH/W/Axt6z6cXz2tpKiTeP2mtN36rPIhdp3dLb79QumKwZ+IsBtAqWMb25zbmPMYSG9u0RJIgdeZTQ/idNBJdP4cRYbpYffiqIXYYxAnI0/f6N2s/2NazEZwbQNwut/r2wsB0R0Fatrw8j701fIAneB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll8zazKlpDCzUiZ/avQ+j45Xsf0kzAv847jvl6gqI3w=;
 b=lckCxwbRzxRsGALeLw8w67gWq6O6FEvnyNdgWMq0EkdlZF+g6DRQayMY0Bs88zPlNgx/HSXmXmOnKKPylKnqXsMUahVVph+O7niUPkwMqwJSSCh0FTm1fHgH4JG0OIk9KE5OjR9IFE09OyxD6TVSrRO12I2Htwvrh9NYpzyIBNE=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CY8PR10MB6804.namprd10.prod.outlook.com (2603:10b6:930:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 20:46:35 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 12 Jan 2023
 20:46:35 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 7/8] mm/memory-failure: convert hugetlb_set_page_hwpoison() to folios
Date:   Thu, 12 Jan 2023 14:46:07 -0600
Message-Id: <20230112204608.80136-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
References: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:5:177::22) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CY8PR10MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 108c10f7-225a-47c3-b834-08daf4de17ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztXmkiORlJP9zEBg8iCbmzt8kS1i8bZBN60vQeAv0Nh/uij3DoAsDbgFa1YXJ1FNzM16KY9on1wCuSEOL6w/eEf4nqvWtXFvvyWh9b/XFcApFJbGHZd5u0KY6gowyxfvXOSA308/iUmiIRNMm+/glhTmswmj00qQfx6dmURRxNJcfbY7Mrj0U/WOVstI8FPZ7CDGhNUcA9PmVh8rnOg6PSmRelMegx5UYpbdQRxJ3A7DgPILhttdvY8egKVpkS/nAZJnLv0+jsTrFouqGoiqbvxMK45nJNtLCj8649fWj75rvRiqfWhZAZGcrt1WcwOn9LAztjb79higtjCR9Pz0ed6dFCnSLSVKAOwEMUGkqN/237GEZQqxwpH2RvVULtQm4/H2lywHSAD0s4Pcbhw35TeuHyleKhpX5jvmCBx0Hccz1Ub/plDprHQGy7slRO8P3rLgBHKRYSp6Gc5zP2YIrLQPCoRtL0IoZLNjVGt15RzsaHAaFp61WtPqBL7skW1zWvaAEZBC8Jgdt78phKj6m+4stcPWA/RIVS7YpaIbRSuRKc9zBH7lShbt/8limW2oOotJN5o84QxKpblkSxGFiVqOIDYcP/4aFh/wfYiJN52DTYazRvoM/9w0O+2TJ5ZcnhmM3GUUk0T+9edEOscewQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(44832011)(186003)(2616005)(6512007)(478600001)(316002)(5660300002)(107886003)(6486002)(1076003)(66946007)(8676002)(66476007)(66556008)(4326008)(83380400001)(8936002)(86362001)(41300700001)(36756003)(38100700002)(6666004)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SI3DttZOqUe+lWKQeCyc/jBlsw+qtdL2wWg6+PoZ0KMqd3ApDrbAWBAieYD3?=
 =?us-ascii?Q?y5dSnQI5h+fx6Wqt8FwYJq3MYG6d5m9gCKsZYl1pmTICiCpNi3oGcYrzgYsY?=
 =?us-ascii?Q?gBuwc9bcDQsOKkjoxfsaRhnVtSAo/obYHUvL+gJma02haFLms48yg1VX6tqi?=
 =?us-ascii?Q?kVZ4K7FOA0JCTf0XQ3uWM4z38XPAclfUhobwML1P5l5fuUlie19xBzNnxC/H?=
 =?us-ascii?Q?rwKd3du/27ccoeFD0IVDbm5CeTWb98jlkf74OjpKmayR8nw1NI0H9w2qnS/C?=
 =?us-ascii?Q?MyNY9RUUTTmSqMU0TMp9Woid7Oo/dcrWwzpW7NvGBVgoaLjxj5iJe/uoC4Qj?=
 =?us-ascii?Q?vTRtBrfRLJz9z0TSbed6QFpi6VsLu8Kd/QpmiNCS4JGO8QSPJqkmB0YtEFJN?=
 =?us-ascii?Q?VzKjOQFyR9fsaRpeBUWKlD6ZTBwIdx/WFCkyhcHqx8rP2y7huF/pExmBEVoF?=
 =?us-ascii?Q?fX+NiXSEW8Shp4w+6IN+nL9t+o0oo7iPVxPl6mdp7F/wZDpi+7oXTpHIqhZo?=
 =?us-ascii?Q?hrSvTp+zynlFKcc7Boc4N2/BetV0IwyTShFg/pKqOFwmhoTVSQTgby9P/Kvb?=
 =?us-ascii?Q?9TW+RvCWT80gjL7qza7JJxDm3OsFZIyid927pLLcznICCetUf6Y5JvWuErVQ?=
 =?us-ascii?Q?nyL74UBRAO7mNEfmxE7z9/yrDhdbN15cn3PlakFkJVDovVoXF7stbPgqqqfz?=
 =?us-ascii?Q?PRGLjDISDyRX7EeTk+WKZxVmqiHtVm7JWBBGwN3D9WCP1EgvKr00oqVHgiTD?=
 =?us-ascii?Q?3fDuaiTajMgUOmwfLAnt32wWqIx8rw4kqQzIvcce2laHPqJyvhYdKRVIzzwn?=
 =?us-ascii?Q?vF560gBON6nvGC4f4rYoLzE6Srx2tYg9hsRUPDOgjH0uXmqQpMIbcBdVPISH?=
 =?us-ascii?Q?+a1wwoCMAixlsfWw4f3PMzKrUCNZFlUAnJUs9O7Jq7er5GtZufq8zMPidNgM?=
 =?us-ascii?Q?+ubc++3vL6HNoZD5zSZUd/+ppiBJSI5jygcVmdGZWH3OWhXE66hOOIWhcz7d?=
 =?us-ascii?Q?SQb7ETaTKFiVnbBcpgkaFUNwrsk3qD58HWlYC/Us5R/8t8wPUlJVFVOhkeQp?=
 =?us-ascii?Q?1vZHBbjNhKOtQu67IqPgb7/yMRx2g3NAnZzt4yscXCNK9nF9IqAgL0C+FKab?=
 =?us-ascii?Q?vU5M8N+Z6mugGR3WjHt0BV1siKm39PEI1V1xuofRIiF72ZrPBUxsiTrLwoIi?=
 =?us-ascii?Q?LwgpVyAFDTtZs28MQ0LOLvkoUpYJKTV3w4xZmJ8q7WI5QGubG5LNlQwyJTDl?=
 =?us-ascii?Q?aRx1K7lpzDfsjSlbC4/F8tXyjWmrX9EB5ZieE0ZUo1ZF1BlPUtC9aGC5LNyi?=
 =?us-ascii?Q?2TIZCUaIFGR5FBtgxDJ+EySSO9aiU6q/NyHKNin8VTVIytQzqqTWisuzQyts?=
 =?us-ascii?Q?J96W8u/w+UcE4pWw8dmqihBsWRUuhlspq0Cv6gT9ZJGz9abckb2EcVq+5Al2?=
 =?us-ascii?Q?ZQEruz5cQkUYDoxMzsRxTZQTRWOtIWKRKVoiUFlyV1dmoVr6d3iwST0fT0br?=
 =?us-ascii?Q?zWu6KnUee3gGarM3EeP7c+Rk6/O6tx8eFdd5U/Fur+ZW99zaFdfpCnk1//tM?=
 =?us-ascii?Q?zcP8AvUXNQ9DFpvA9f4QhxYk8yUIB9asSLDRo17ruigG9LqzOOp36InDVoQn?=
 =?us-ascii?Q?6k3l3N/SZgKb022P/jpkATs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PLOwOaPpd8MEzTZ0oi0pmI7FScp+znYVdD45JBOt1uaOaS3yiMxOpsIoZ2sM?=
 =?us-ascii?Q?59xX8480AAyKgMoq/zZ+NNpIEqipVUbMzaObF33V5svc3OUWeqb+P9a82f2q?=
 =?us-ascii?Q?xmztvOX6kPfsxmEAioFYsT5+lLW6tyNUvlxBoZRzD7CsKgwSCuNPZ/bEMq9r?=
 =?us-ascii?Q?ZgWHcP5wtlqy4BMDoK+atgERIkmPzAomaQ9mLgyIwZ/uL8jLzAQuZyWb7Lnu?=
 =?us-ascii?Q?4TFOFq97K/gWd4+mvpqWY3vzAz+j5t9DrI2NKxFGgJqrDnId22Xe6I4nF732?=
 =?us-ascii?Q?rTPYkUKTAAgqY9bFFsM0GIodc80pK2wcGX2OLPkJx7KdhSIsSdUWnmYb+hy1?=
 =?us-ascii?Q?ipY9qijkfFhlbVOw9T/o4qOeBwTOriowpHTSxgJ2xFlfLWw8nzqAQpn079P1?=
 =?us-ascii?Q?wGMquNl81kAOJ1HolcNVz4rgug55gPfvQH08zBbG2c5iOIhaIUSqZ93vop2v?=
 =?us-ascii?Q?zX0HUr5TFot2giRwl0lavwkZOe3BI7EtaDitOE4oqTzY3fHDJpkI+1IIZu/y?=
 =?us-ascii?Q?qGCWtQpaQfUW6QaSDrmhOQhjVd6A5Vec601IJgW1azcxBKMOcdI8PPesZbAi?=
 =?us-ascii?Q?/XyXP97NFoUm5MTXi4RUXvUs8rWrhXELSkbZJIuCaYtFTHO2PWElwJjhqXwI?=
 =?us-ascii?Q?Vvprt9J68ic6zndkjyO9WHh4XlRBUTsbK1+DFUu2FMNpC4W3isdd28UoBJ9o?=
 =?us-ascii?Q?H72s+/BxCvLJgE7HxjOAO+fSj6rSNu9sGNh+3LLKIVoSveFLnHTh8N7OnvNj?=
 =?us-ascii?Q?JpTmkMYS6aMKap7gdb/9K087NdrFq/mGuMXHvvVz+UotcvWGJZa8DJwBG3EX?=
 =?us-ascii?Q?igxOstpF3NYiL0CdZWa1H4DuAyqtELqn+Je95WYBGyXjmjfl4VM2dF2mAef7?=
 =?us-ascii?Q?2ev0dDqWjFhRFrOTeu52W08hDBtXXIUv4x0s+G3DAcX3hZEpOp/8JLW+l99m?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108c10f7-225a-47c3-b834-08daf4de17ee
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 20:46:34.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bm5Bh/miAjRL3Vn4C8+B+8A1am2vd5MPNCXJB9/Xi97mgikiLQxdwGf8arQPvvAJONvnWoKCFryCGgn/qLUe+e62WFEiC+KmuJ8zJyNd1xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120148
X-Proofpoint-ORIG-GUID: t_zKu9hYNDQhq0oGFXB6i96po_kAOu73
X-Proofpoint-GUID: t_zKu9hYNDQhq0oGFXB6i96po_kAOu73
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change hugetlb_set_page_hwpoison() to folio_set_hugetlb_hwpoison() and use
a folio internally.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory-failure.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3fff073da89b..fb98652b211a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1721,13 +1721,12 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	return count;
 }
 
-static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
+static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 {
 	struct llist_head *head;
 	struct raw_hwp_page *raw_hwp;
 	struct llist_node *t, *tnode;
-	int ret = TestSetPageHWPoison(hpage) ? -EHWPOISON : 0;
-	struct folio *folio = page_folio(hpage);
+	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
 
 	/*
 	 * Once the hwpoison hugepage has lost reliable raw error info,
@@ -1830,7 +1829,7 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 			goto out;
 	}
 
-	if (hugetlb_set_page_hwpoison(&folio->page, page)) {
+	if (folio_set_hugetlb_hwpoison(folio, page)) {
 		ret = -EHWPOISON;
 		goto out;
 	}
-- 
2.39.0

