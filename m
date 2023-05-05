Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C232C6F87D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjEERoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjEERoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:44:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E929C1C0D9
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhJ2A014769;
        Fri, 5 May 2023 17:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=x1F35Nl/y1jdMAp6sXSkI9LKCTzgTwzSHQmh+g/8a1k=;
 b=cQFb0KfSxygxC+DaZ04C9ZAfd7TaOnyTEivoUa/hyyJTuJiRg679HczQ3d009Yr0KvPn
 xazBh4o4L8yELnL7y2Y6GaT7iyn+TDNU/Z7NP0aUnAuxWmWVEIiuRoN5rhHGVpguaVzl
 6fy7kdw/ODDD0xKsPpbrdCfncPL+8xmBl7I4vNYw2lZllumcq27LEHvrkNMTy3GHMC1q
 tCN2LQIdqEQRjHdYPiQWH3y5xpLpsxm7Mj//nJQighD1tYhPm3TFzf06lKkbBLhh9hQJ
 VtQmpQUt3h8n9k+ygaCAy21YT5KS+bqj4CVeQZbhy/g0/x6HIJYbr5GkoOtVU8Ej5lTz Fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sneddxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HUmNx024917;
        Fri, 5 May 2023 17:43:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spachws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFubAfT2/OrCTX6BP81JdCqcFzpcBOU2lhsRxqZC0lGs8MtnGa2OAX1rNDtT3QzKmL3x2NlQxWEoEyx0miF1Qd73sgeskVihinJq7wJDUo1YxrjzB5m15xUKk7Id9FIOHGidGj+bmFFXY3R9Z5giuArz7Tm5UWYzo4qQ6SWsRb4aRLzwykpIS2bKT7Ir4qm5+0I8Q7f9H+kHm9mZgQKFMndAgOYw0YWBuU8uENdyWzp8xIexEhCw0E4ZrXiNbmsR+yJf6FSlVPL0WCQnD/HOzZwyE//IYF+7OaxwQepIBYq7q3igYixji3XCRI8lnQsjAR1qQM8oIUgpUYS0LYW3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1F35Nl/y1jdMAp6sXSkI9LKCTzgTwzSHQmh+g/8a1k=;
 b=O4jryDruqPUBw5rwzh2wWM1Gm8L2NENuNy6MwMUxyaMO7VsJficPSRK/1z8aswdR36pcJM285cbQLIUD6mqM44IdDevhOAzB9rS5eG3P5/2fzrZlrvEf/f0+i2TNS5QbKCrwVv+XqPax2hiEQrgF0Pu9QhJ1fyxZ7Ak/0ViSV2X7r/bFWH46wCRbh95AjjhK68shzjJW+5HZlk4Urq9uxCToIOe3lJIdruspoGWxJvLzcmOQ3rLRkAGK77V6yFym8n1JjE6XIUHtMMaNBWqMkFzY3S4Kpe9fYFCnnfcxNxmyoqgeMgh1jgA0WThFei0cowHKvHWWIyMFaioWvXKkJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1F35Nl/y1jdMAp6sXSkI9LKCTzgTwzSHQmh+g/8a1k=;
 b=IOaIVDnzGTs2VjbxQEwlGjDmj6G3mVjl8YwhmzhDF9TCy2QFaTdlBqObQB/cO/mWR6Z8vqqYSfo7IDAcwPwM0JtdkwS8iUViA9BjT/Dnfo7blQIjv+ImyJgst4vANTkGw1XV/4XjUlWKNPOaw1mTzgi0qRWCU7t/KeAJxzxg5EM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:43:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:43:52 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 05/36] maple_tree: Add format option to mt_dump()
Date:   Fri,  5 May 2023 13:41:33 -0400
Message-Id: <20230505174204.2665599-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0239.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 4befc877-8761-4ee2-e93f-08db4d904a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2q5e+IpiD0vwOkZnrYwLd6nfKs1HLFp05wW/qQn8lg+0+BV1du2Fmkpruq19BvWaxF0i0Xc2njwEQatNJYxgU2k9PXvYiCbNBxVzyK7KjjcaNlk7tvArF2EjVoYHGiumAdGIwq8L5SnX5mrJREenOH0+8i1fcvbx3LI/m01CkjztMz8Ebh//WNZkkDkodC6j/V+dhiPZwjBVxUszeqb3Q/3qNDVUVGdxKylnEzfZxO1ae3VimpMpv/CogbsTHHZf+nEPrpbM3an4pxk4vG5IkLfRjgS+h2Tlb10MBG0SDrUInAlZyBO4osDJ0WQyGBHvolQFxqjKP92xbMWAZaJoYduRt3j/P4zdXgJLCPBz98ULfXNAc7m+szp9dEdV5SsOB2jvdqVrk+5gPDw0YVEs/CbM8pYUU332YHZZb6uaCD6O+cel/rdGA2dBJKWWtLymC1WSBF+Woe/VI1b7I2eQnCGtmx1EgW7qsGgUaoIrGe4s8aAIxP7WJqodpj/eB2xaEM//4Ww78ekMMIDIcxXm5V6TrgCTENFsA8c55GAf4rqE8NLhprMOaBHoZ0ryF3VB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(54906003)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(30864003)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sAL3cuFEGFeUC4MG0VzFz2avl52VLB6KyhfZ8q1h29DWIEsyVf8QdZq9+TF6?=
 =?us-ascii?Q?QCt6cMBaSDDQuh7KzXYvbLdkM+G1iWC2oIWZF/+A6aKe1Pvq8WMEg11D6/Op?=
 =?us-ascii?Q?Ov4H7MGQfRlsioInpcfALTIto4F7dBhN9V6bSMbMeUPIr7pFc6RTYa3TB/kx?=
 =?us-ascii?Q?rvqlzhjTan/vpu/CvGfAgL2obGbYB35w8wbP+l5gnXTuXXojLSS4RKSP8FPo?=
 =?us-ascii?Q?UQL7pvfAsagfU8tz5iynwnkjmN9jSidDfHRqLbyyOkDqSf2Mz++6TfpX+8xf?=
 =?us-ascii?Q?eDQOrSoEcvnLZ8PgEFwBDfhgRsUzFb7jqIjSWIspn4g4yuDKXhw/L87RNYO3?=
 =?us-ascii?Q?vNTvxOgtsQkkZUVDYta0pbg8y52rfviu3ZB6sGWrH5bsofpOaIcrn21h0B2I?=
 =?us-ascii?Q?bpCEGk1DQq9f0W3fKg5IR0LFZ/IRs5iTAb1AfloCm9JbnK/l6LFtfChVmxxx?=
 =?us-ascii?Q?UluLDhyVk/awRUsimEI/S4PEUkgALi82idyYcZ+D4TDKj0a3ephPhv2KAg2B?=
 =?us-ascii?Q?iKnijGQ0p4vQNNmTkieVXPIpTiAI40F8wKIVkTuQ6tF/T0xxYUCM1H2F0sIH?=
 =?us-ascii?Q?dblRjzceJTzNhJlUsR4ElCvpsil4UDgT6ppGTBGRt+HU8Sd9k93dUnjdjOQ4?=
 =?us-ascii?Q?Lgaso2J01gmcJKoEy3olggrMMWykYyI8nqTV9hPltoYpeSl848k/zGwpS2vk?=
 =?us-ascii?Q?wlRPrNZcxzMDed6cqzuiTDBacfuAA3qxlsibW8lQHeOzI9i/WfvyGEMoByTo?=
 =?us-ascii?Q?Y58+QXIAFyWxm215g7iF1gHuFMugkvUcFxpm4hi/0yY4oHaUJoHeJ2TwYSaS?=
 =?us-ascii?Q?wk9DV9Xsq8iAOTcs7cdV1Q1cEZzgH8m84MaXBYJhil5suUMIEnguZewBSfBX?=
 =?us-ascii?Q?1UiH6xMJPrdUcw7HJ48YCDgX+TCCC+0Qva5b1voLfeodqbwJXG+nt5brl4iz?=
 =?us-ascii?Q?XfmfKfmbZIsjXMM3FB+K7g/Pol/PADM3bguzjEAYmIIN9ynVyBpsmjqhkjmk?=
 =?us-ascii?Q?sjftAD8FBkrlXiPIT6yenmHQbA4/A9VOwVsTFq6466hztu/anQATfnTPQlPN?=
 =?us-ascii?Q?hIcvDyrPikIDHb0toEiV45qV+JPmZMljBRc6+tVpkAa7wkqq38GqRcxKtefm?=
 =?us-ascii?Q?BwuO+QlMr542adLQcVUr0bXhDub6rE2Ct0XQXVFzWw8VyeluFx8McUCLb2x2?=
 =?us-ascii?Q?fOKQndK9W/xkOGMVbqyAO/kS+3aT1iIwaPHFifJANHpEN2hJ363aq3lwhSdL?=
 =?us-ascii?Q?lXvnL9QHSIEp9rjo35kDx/5jZ0vlsutWIy2Vwz0i7bDm8BjWlhdgXsQtwVFY?=
 =?us-ascii?Q?3tHb74LgdlK7mxZ0xHm2nn4aQ+X+BJGmD5OZ2tjgdjvwvs2g61CWTRq3OQMq?=
 =?us-ascii?Q?PhBe82Ju6YFZMkp3i7gQCRmaXCh7yPMGqGuDojzJbo1xyqHN068wp1AEu3Ah?=
 =?us-ascii?Q?Ms2aDrtbq3Mqs+5n3Vp4gCJyI3fi7efHxKhGLo+uCeQ8TA8ahl/zCz+fksL9?=
 =?us-ascii?Q?qvhLk1XyRTOuzjkSS48OX10tdPzYUvpJoJTwnUyEdeWnHNYTmFeIElBSLHOe?=
 =?us-ascii?Q?VJ7CuvHGzj0FYGFijaRkFnRdPHTj9cY8+t9fmpqKd7nAFFdZyCatiL/fo4Vt?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CCWSswg8fzRSEnYroiWpGobWytDFM5jJd01ypxQnlbBoWOao3ChqvLB9ImcJhBrR408LjFAWSBbgcPVlLoObObZadx2+M5r6+deXgO4ABgKB/hPryJCr7X8p7zPltRdXiX3iMbpB9N21SrY3TPaDJ1O4J2PRIEuP2CiAFCmM7vawoRuUkJ1ngTrq4cDCO3ccR9odukJHzxBy9HptmK/u9Mh6mPsWiFEhWc8KAn6p8ZzENLE78TOu797BTBH396uVd17P/rMdPgaJXVY4eAJaEu6io0yFucWDTshyV6A7ZpuTb/pYCdJpp0ILZl3Api22wz3inXWfjnELZhYmHZoZqjU6ZH0xZjhIuhtB0R1VYAS+2ovvsVmA1LUESxhY4penw8gmqLO1VD9lbARgT0F1a6IgRh2wk4dZvwb+OdjDrKw6VCONcXXrpBrdUW3Eij1r0A/Az/c4TzlCHPEJYiCh5g+L/4CaeE332DK2RMxmejQAuF25q5AIV5ePl7RlTuimMyo2TCVCWrzu/18kh5Nk8ASqknQ67Ms9tVHP/3gxHBI+yOJyolTwxlBGX4DYC3z42oQk4NWzheumbDFzyrsKquyfFCW3xB430SnImVP67PirDuXCq5gyT2oVqPQYXORcUm8wJBwHnkxmvJuy1B+jKMdY96yfG2tRfeIEnfgQDqAYOBQYhuQRa2QVRP8vEM5bEKT6C42vlcvC3xW47Mxa+UVmlCowyGe+wwgH6EHu2jKNv2BLoVwEUSv2GUKTZ9XS8rgmwqDu/v0OlDIzk3Jy+PjYJ+h3rxWPfwk4ghNX/LumBaeUvg1D7pRGL0TH1E2E8tBDBs4PeG2ci4QXL/esfVudDeM9XX2KvvI1guhkaO4rN/CpVPRQ8Y4JASQrecDnrZdOzydiaRsnZbgv4iOhGQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4befc877-8761-4ee2-e93f-08db4d904a80
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:43:52.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/4GxqRXCvlwcJHQKAut12ICDmSPvFH2ozshtgeKoKwvC4yIrKfsJOq7jy7tiA0a9NEYkEHKjJg7uiaYpuEx7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050146
X-Proofpoint-GUID: fCMBOxz_OERR5Ea3L8s58j90Znkkg6ET
X-Proofpoint-ORIG-GUID: fCMBOxz_OERR5Ea3L8s58j90Znkkg6ET
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Allow different formatting strings to be used when dumping the tree.
Currently supports hex and decimal.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h       |  9 +++-
 lib/maple_tree.c                 | 87 +++++++++++++++++++++-----------
 lib/test_maple_tree.c            | 10 ++--
 mm/internal.h                    |  4 +-
 mm/mmap.c                        |  8 +--
 tools/testing/radix-tree/maple.c | 12 ++---
 6 files changed, 82 insertions(+), 48 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 1fadb5f5978b6..140fb271be4a4 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -670,10 +670,15 @@ void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max);
 
 
 #ifdef CONFIG_DEBUG_MAPLE_TREE
+enum mt_dump_format {
+	mt_dump_dec,
+	mt_dump_hex,
+};
+
 extern atomic_t maple_tree_tests_run;
 extern atomic_t maple_tree_tests_passed;
 
-void mt_dump(const struct maple_tree *mt);
+void mt_dump(const struct maple_tree *mt, enum mt_dump_format format);
 void mt_validate(struct maple_tree *mt);
 void mt_cache_shrink(void);
 #define MT_BUG_ON(__tree, __x) do {					\
@@ -681,7 +686,7 @@ void mt_cache_shrink(void);
 	if (__x) {							\
 		pr_info("BUG at %s:%d (%u)\n",				\
 		__func__, __LINE__, __x);				\
-		mt_dump(__tree);					\
+		mt_dump(__tree, mt_dump_hex);				\
 		pr_info("Pass: %u Run:%u\n",				\
 			atomic_read(&maple_tree_tests_passed),		\
 			atomic_read(&maple_tree_tests_run));		\
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1e7e7249a0cf2..084868865849c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5699,7 +5699,7 @@ void *mas_store(struct ma_state *mas, void *entry)
 	trace_ma_write(__func__, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 	if (mas->index > mas->last)
-		pr_err("Error %lu > %lu %p\n", mas->index, mas->last, entry);
+		pr_err("Error %lX > %lX %p\n", mas->index, mas->last, entry);
 	MT_BUG_ON(mas->tree, mas->index > mas->last);
 	if (mas->index > mas->last) {
 		mas_set_err(mas, -EINVAL);
@@ -6753,22 +6753,33 @@ static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 
 /* Tree validations */
 static void mt_dump_node(const struct maple_tree *mt, void *entry,
-		unsigned long min, unsigned long max, unsigned int depth);
+		unsigned long min, unsigned long max, unsigned int depth,
+		enum mt_dump_format format);
 static void mt_dump_range(unsigned long min, unsigned long max,
-			  unsigned int depth)
+			  unsigned int depth, enum mt_dump_format format)
 {
 	static const char spaces[] = "                                ";
 
-	if (min == max)
-		pr_info("%.*s%lu: ", depth * 2, spaces, min);
-	else
-		pr_info("%.*s%lu-%lu: ", depth * 2, spaces, min, max);
+	switch(format) {
+	case mt_dump_hex:
+		if (min == max)
+			pr_info("%.*s%lx: ", depth * 2, spaces, min);
+		else
+			pr_info("%.*s%lx-%lx: ", depth * 2, spaces, min, max);
+		break;
+	default:
+	case mt_dump_dec:
+		if (min == max)
+			pr_info("%.*s%lu: ", depth * 2, spaces, min);
+		else
+			pr_info("%.*s%lu-%lu: ", depth * 2, spaces, min, max);
+	}
 }
 
 static void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
-			  unsigned int depth)
+			  unsigned int depth, enum mt_dump_format format)
 {
-	mt_dump_range(min, max, depth);
+	mt_dump_range(min, max, depth, format);
 
 	if (xa_is_value(entry))
 		pr_cont("value %ld (0x%lx) [%p]\n", xa_to_value(entry),
@@ -6782,7 +6793,8 @@ static void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
 }
 
 static void mt_dump_range64(const struct maple_tree *mt, void *entry,
-			unsigned long min, unsigned long max, unsigned int depth)
+		unsigned long min, unsigned long max, unsigned int depth,
+		enum mt_dump_format format)
 {
 	struct maple_range_64 *node = &mte_to_node(entry)->mr64;
 	bool leaf = mte_is_leaf(entry);
@@ -6790,8 +6802,16 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 	int i;
 
 	pr_cont(" contents: ");
-	for (i = 0; i < MAPLE_RANGE64_SLOTS - 1; i++)
-		pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
+	for (i = 0; i < MAPLE_RANGE64_SLOTS - 1; i++) {
+		switch(format) {
+		case mt_dump_hex:
+			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
+			break;
+		default:
+		case mt_dump_dec:
+			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
+		}
+	}
 	pr_cont("%p\n", node->slot[i]);
 	for (i = 0; i < MAPLE_RANGE64_SLOTS; i++) {
 		unsigned long last = max;
@@ -6804,24 +6824,32 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 			break;
 		if (leaf)
 			mt_dump_entry(mt_slot(mt, node->slot, i),
-					first, last, depth + 1);
+					first, last, depth + 1, format);
 		else if (node->slot[i])
 			mt_dump_node(mt, mt_slot(mt, node->slot, i),
-					first, last, depth + 1);
+					first, last, depth + 1, format);
 
 		if (last == max)
 			break;
 		if (last > max) {
-			pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
+			switch(format) {
+			case mt_dump_hex:
+				pr_err("node %p last (%lx) > max (%lx) at pivot %d!\n",
 					node, last, max, i);
-			break;
+				break;
+			default:
+			case mt_dump_dec:
+				pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
+					node, last, max, i);
+			}
 		}
 		first = last + 1;
 	}
 }
 
 static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
-			unsigned long min, unsigned long max, unsigned int depth)
+	unsigned long min, unsigned long max, unsigned int depth,
+	enum mt_dump_format format)
 {
 	struct maple_arange_64 *node = &mte_to_node(entry)->ma64;
 	bool leaf = mte_is_leaf(entry);
@@ -6846,10 +6874,10 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 			break;
 		if (leaf)
 			mt_dump_entry(mt_slot(mt, node->slot, i),
-					first, last, depth + 1);
+					first, last, depth + 1, format);
 		else if (node->slot[i])
 			mt_dump_node(mt, mt_slot(mt, node->slot, i),
-					first, last, depth + 1);
+					first, last, depth + 1, format);
 
 		if (last == max)
 			break;
@@ -6863,13 +6891,14 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 }
 
 static void mt_dump_node(const struct maple_tree *mt, void *entry,
-		unsigned long min, unsigned long max, unsigned int depth)
+		unsigned long min, unsigned long max, unsigned int depth,
+		enum mt_dump_format format)
 {
 	struct maple_node *node = mte_to_node(entry);
 	unsigned int type = mte_node_type(entry);
 	unsigned int i;
 
-	mt_dump_range(min, max, depth);
+	mt_dump_range(min, max, depth, format);
 
 	pr_cont("node %p depth %d type %d parent %p", node, depth, type,
 			node ? node->parent : NULL);
@@ -6880,15 +6909,15 @@ static void mt_dump_node(const struct maple_tree *mt, void *entry,
 			if (min + i > max)
 				pr_cont("OUT OF RANGE: ");
 			mt_dump_entry(mt_slot(mt, node->slot, i),
-					min + i, min + i, depth);
+					min + i, min + i, depth, format);
 		}
 		break;
 	case maple_leaf_64:
 	case maple_range_64:
-		mt_dump_range64(mt, entry, min, max, depth);
+		mt_dump_range64(mt, entry, min, max, depth, format);
 		break;
 	case maple_arange_64:
-		mt_dump_arange64(mt, entry, min, max, depth);
+		mt_dump_arange64(mt, entry, min, max, depth, format);
 		break;
 
 	default:
@@ -6896,16 +6925,16 @@ static void mt_dump_node(const struct maple_tree *mt, void *entry,
 	}
 }
 
-void mt_dump(const struct maple_tree *mt)
+void mt_dump(const struct maple_tree *mt, enum mt_dump_format format)
 {
 	void *entry = rcu_dereference_check(mt->ma_root, mt_locked(mt));
 
 	pr_info("maple_tree(%p) flags %X, height %u root %p\n",
 		 mt, mt->ma_flags, mt_height(mt), entry);
 	if (!xa_is_node(entry))
-		mt_dump_entry(entry, 0, 0, 0);
+		mt_dump_entry(entry, 0, 0, 0, format);
 	else if (entry)
-		mt_dump_node(mt, entry, 0, mt_node_max(entry), 0);
+		mt_dump_node(mt, entry, 0, mt_node_max(entry), 0, format);
 }
 EXPORT_SYMBOL_GPL(mt_dump);
 
@@ -6958,7 +6987,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 						mas_mn(mas), i,
 						mas_get_slot(mas, i), gap,
 						p_end, p_start);
-					mt_dump(mas->tree);
+					mt_dump(mas->tree, mt_dump_hex);
 
 					MT_BUG_ON(mas->tree,
 						gap != p_end - p_start + 1);
@@ -6991,7 +7020,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 	MT_BUG_ON(mas->tree, max_gap > mas->max);
 	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
 		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
-		mt_dump(mas->tree);
+		mt_dump(mas->tree, mt_dump_hex);
 	}
 
 	MT_BUG_ON(mas->tree,
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index f1db333270e9f..d6929270dd36a 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -219,7 +219,7 @@ static noinline void check_rev_seq(struct maple_tree *mt, unsigned long max,
 #ifndef __KERNEL__
 	if (verbose) {
 		rcu_barrier();
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_dec);
 		pr_info(" %s test of 0-%lu %luK in %d active (%d total)\n",
 			__func__, max, mt_get_alloc_size()/1024, mt_nr_allocated(),
 			mt_nr_tallocated());
@@ -248,7 +248,7 @@ static noinline void check_seq(struct maple_tree *mt, unsigned long max,
 #ifndef __KERNEL__
 	if (verbose) {
 		rcu_barrier();
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_dec);
 		pr_info(" seq test of 0-%lu %luK in %d active (%d total)\n",
 			max, mt_get_alloc_size()/1024, mt_nr_allocated(),
 			mt_nr_tallocated());
@@ -893,7 +893,7 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 #if DEBUG_ALLOC_RANGE
 		pr_debug("\tInsert %lu-%lu\n", range[i] >> 12,
 			 (range[i + 1] >> 12) - 1);
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_hex);
 #endif
 		check_insert_range(mt, range[i] >> 12, (range[i + 1] >> 12) - 1,
 				xa_mk_value(range[i] >> 12), 0);
@@ -934,7 +934,7 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 				xa_mk_value(req_range[i] >> 12)); /* pointer */
 		mt_validate(mt);
 #if DEBUG_ALLOC_RANGE
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_hex);
 #endif
 	}
 
@@ -1572,7 +1572,7 @@ static noinline void check_node_overwrite(struct maple_tree *mt)
 		mtree_test_store_range(mt, i*100, i*100 + 50, xa_mk_value(i*100));
 
 	mtree_test_store_range(mt, 319951, 367950, NULL);
-	/*mt_dump(mt); */
+	/*mt_dump(mt, mt_dump_dec); */
 	mt_validate(mt);
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 68410c6d97aca..4c195920f5656 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1051,13 +1051,13 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree);
+		mt_dump(vmi->mas.tree, mt_dump_hex);
 	}
 	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.last <  vma->vm_start)) {
 		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree);
+		mt_dump(vmi->mas.tree, mt_dump_hex);
 	}
 #endif
 
diff --git a/mm/mmap.c b/mm/mmap.c
index e96f96c69c342..76eaf12f13903 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -301,7 +301,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 extern void mt_validate(struct maple_tree *mt);
-extern void mt_dump(const struct maple_tree *mt);
+extern void mt_dump(const struct maple_tree *mt, enum mt_dump_format fmt);
 
 /* Validate the maple tree */
 static void validate_mm_mt(struct mm_struct *mm)
@@ -323,18 +323,18 @@ static void validate_mm_mt(struct mm_struct *mm)
 			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
 
-			mt_dump(mas.tree);
+			mt_dump(mas.tree, mt_dump_hex);
 			if (vma_mt->vm_end != mas.last + 1) {
 				pr_err("vma: %p vma_mt %lu-%lu\tmt %lu-%lu\n",
 						mm, vma_mt->vm_start, vma_mt->vm_end,
 						mas.index, mas.last);
-				mt_dump(mas.tree);
+				mt_dump(mas.tree, mt_dump_hex);
 			}
 			VM_BUG_ON_MM(vma_mt->vm_end != mas.last + 1, mm);
 			if (vma_mt->vm_start != mas.index) {
 				pr_err("vma: %p vma_mt %p %lu - %lu doesn't match\n",
 						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
-				mt_dump(mas.tree);
+				mt_dump(mas.tree, mt_dump_hex);
 			}
 			VM_BUG_ON_MM(vma_mt->vm_start != mas.index, mm);
 		}
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 75df543e019c9..ebcb3faf85ea9 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -1054,7 +1054,7 @@ static noinline void check_erase2_testset(struct maple_tree *mt,
 		if (entry_count)
 			MT_BUG_ON(mt, !mt_height(mt));
 #if check_erase2_debug > 1
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_hex);
 #endif
 #if check_erase2_debug
 		pr_err("Done\n");
@@ -1085,7 +1085,7 @@ static noinline void check_erase2_testset(struct maple_tree *mt,
 		mas_for_each(&mas, foo, ULONG_MAX) {
 			if (xa_is_zero(foo)) {
 				if (addr == mas.index) {
-					mt_dump(mas.tree);
+					mt_dump(mas.tree, mt_dump_hex);
 					pr_err("retry failed %lu - %lu\n",
 						mas.index, mas.last);
 					MT_BUG_ON(mt, 1);
@@ -34513,7 +34513,7 @@ static void *rcu_reader_rev(void *ptr)
 			if (mas.index != r_start) {
 				alt = xa_mk_value(index + i * 2 + 1 +
 						  RCU_RANGE_COUNT);
-				mt_dump(test->mt);
+				mt_dump(test->mt, mt_dump_dec);
 				printk("Error: %lu-%lu %p != %lu-%lu %p %p line %d i %d\n",
 				       mas.index, mas.last, entry,
 				       r_start, r_end, expected, alt,
@@ -35784,10 +35784,10 @@ void farmer_tests(void)
 	struct maple_node *node;
 	DEFINE_MTREE(tree);
 
-	mt_dump(&tree);
+	mt_dump(&tree, mt_dump_dec);
 
 	tree.ma_root = xa_mk_value(0);
-	mt_dump(&tree);
+	mt_dump(&tree, mt_dump_dec);
 
 	node = mt_alloc_one(GFP_KERNEL);
 	node->parent = (void *)((unsigned long)(&tree) | 1);
@@ -35797,7 +35797,7 @@ void farmer_tests(void)
 	node->mr64.pivot[1] = 1;
 	node->mr64.pivot[2] = 0;
 	tree.ma_root = mt_mk_node(node, maple_leaf_64);
-	mt_dump(&tree);
+	mt_dump(&tree, mt_dump_dec);
 
 	node->parent = ma_parent_ptr(node);
 	ma_free_rcu(node);
-- 
2.39.2

