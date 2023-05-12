Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BC4700EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbjELSYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbjELSYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:24:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AC9E50
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:23:29 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4Rco028673;
        Fri, 12 May 2023 18:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3J4pneHi36iA5e8D1W6Sbr1hFtHWPs0j8jYZRtGOe7s=;
 b=p70VyN6CUdX8XYkDwGnnHQHjnlslrOOckF6Pn1Hvievkxypx/W2m1zhGgaqu+QKCAFn9
 2HLLzdrn105fq+gkO+lQ3eXyYLNdt177vCMGW89vB/eobzq+uTeWfettx1GxARQwuBBz
 zy6CbVUJJroDRsgous6h2mtwQIWJmTKzit/JomqKWApvoh5rwI7d09eWEsHspI6gB50B
 XOpumzrIaBY4H096M7eIT7z9rzobzrUftWNLbdfTNGfR8Duxvm0do3gLVE/LiJPrpdZK
 FgAiLQBOn7rcbtHDp7qMf22A8aiNu+Y8hqMsudmcvq868HyPPf2wPG8B5JRxYkBtBOA4 JA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77dknmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CH3b1s004415;
        Fri, 12 May 2023 18:21:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pnt5r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3X2Cr9yehOQ5DaWkEMJ8VbtmXz2Ho5VszsbDmmF/Mt1/UnClXObQLN9dBOTsWkutrApdsxieMxv38Gs0faTHEK6JiiPh8UsZZQ9Qlv4jni6DImfpUplAE1QuU8aZ6sf0pDPenL7DANBG95NB5zq3mRimGc49QvEF8p+DJZmQocNgn1BMQC7JV4FmBX5uLVCwfjFTa/o0YPPW8XJhXZqgMWrfGykVls6RGmcHxRfkI6a6asjMlqdI1IZwHVHZHXtWd9cIOOclkSzCxhziCmzGWkv+cPtCat4ioO2i1tPsWqBwQO0ph/GfEXuEiVzDEtO4apoGdhiA2SPr5k36hjhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J4pneHi36iA5e8D1W6Sbr1hFtHWPs0j8jYZRtGOe7s=;
 b=clUaG7qbRfRyGUrL+tz7kXhZT4ADejf769MjQ/AwwtHHpnTH7VoTgQPX2twhCZ9zpX9H0GSPC93qgWAKDpFj8wd32Z8g4AHNpb/O4caiMMHQihJXat3jchVc3YSGYxgIcx4yxAZTLM4zgsj1z9cac4CbjpFF4Lu66BkC2yDX3iIARqJal3qu4OQtDyK3s3DLHkf42ZC9G7ynr052C5rzaLleeK5DFKX9Iru2/W+5tfZC9SvZytmP1961QET3gAS3UhGvsECTmQlAX6ylzwn2hBSDDEHFNZiBwsBtEyOJyFbRFmC2gw5DWiPh9WpySRB4/GrAPHOx6A9GKLw6XOI61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J4pneHi36iA5e8D1W6Sbr1hFtHWPs0j8jYZRtGOe7s=;
 b=YgCPuRx0qzhKOZW5+2cj9198GftUrMLTgK+bF9I1knyX7diJH5G/pQjsiPN2VxuOkfDv8TcngZi4Xi3MXBO96JPTT4+6Lqq+6NVE0xjpzWa5KK2K1sLkKO6CZkntrFDPdGEZzlfpsiyjCNyUNbbkeQJQ1mIzmX6QNy+3fXdoA1g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:21:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:44 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 21/35] maple_tree: mas_start() reset depth on dead node
Date:   Fri, 12 May 2023 14:20:22 -0400
Message-Id: <20230512182036.359030-22-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0079.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 1758a05b-93ef-45a3-2a98-08db5315bd86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTluZxZor43TbNBSSFAHDytdII41oTgVmIOBCMBB0w9iBCyjaXUtzLplaVawDRlI1Dwh/6FSm9QWlynCeqOiH4svxHR/alAvz6926CZ9uSrZ3Idzfir6t8m58XLVs4HRTO3BUQDk8O5Zy8Q+XjKZadvHdr1LrcRnzyebAaxNUzJD+3g+BELqeQvGeq+gmzOMLw7arUsDbq0kxCoy10daGCjs6w5cpDS2JhTcN4VGZ9PO4tCjANeQ7r+C9gUwhNGQ5Bh3Gy+7qA1f+hgWdB4zzCmsVm3reEOxhLna3sRBZ0FepE+QsJjtOHeLGKWdh3yCt2wUzUViJkXivaUJuWbndh1mN09fH3vuJNs/RkGJOLFF6Ysyfl/KAqZu1i87zTJ/DwHWasrU5sk2OERRi+Cy6vI/08Ih6DZpcgpqXVvX4P8s9hB7oTTVWXOLZ4ygx+e+QxCe5PF9KQThNB9ozobeDgK84tS96KgQBwgGVRlgGm309xiXCrC5j7TpCqrOyN1KSopB09CHHFFYTLgKmcZLcyHniw0Bp3TchNlDMlrYdX24DU5SXDdOndjkaXuE1Jo0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(4744005)(6916009)(66946007)(54906003)(83380400001)(5660300002)(6486002)(316002)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rg5c9Lx2JLioAi4uhrhuD2MKQtW/Sog5in41CEITrHaA0B8SsD1YSiyINY7+?=
 =?us-ascii?Q?qp1n30muPafFwjuh5RX8ZqHGxKWKeXKKm6qK+zPiB8Rcg8US5YdNPV+E1MkW?=
 =?us-ascii?Q?LWCFkAG1YtRfeNhuDYGX47kjlZG42MMlKenemJcECeRMgdv8Ez0BKlzGm3IT?=
 =?us-ascii?Q?TPAjmmc7tuQo2yR+byc2yWl67yNbZU5d+hYTRGUfAF0x6TnGTdIhjw/BOXFS?=
 =?us-ascii?Q?cerwkzOJyO9ZkhsiG4XOgzs4oUrHkzYa08rSFVwJzZ8clTrge5S2N5aL/Mk8?=
 =?us-ascii?Q?24ChJqH/MYqsyUgVQzXBG23k9O2d47QBu7filHi0v47ebRnz6qFeK0tplFTZ?=
 =?us-ascii?Q?83GzObuvG/l5jSpRhXSeRdRygorsguHITqfl0JKxKJ6ATJ9HNY/KeLIs1hgT?=
 =?us-ascii?Q?Y89yRVwMjVC8hcn2ysobw+VVRsWI/LTwv5E3hZOWJAWmEDUkN0p6X3sYVti4?=
 =?us-ascii?Q?Qt8RrebM8aeD1iQOBASgUmeY0ndy6RfQc7g0rupHdbjH1IpuiNplQHkT56mP?=
 =?us-ascii?Q?H6hxglkKmcG5v6jXSz9eWoQeJAgNVLsE6xpN2eDakyySderPycs1P/fHLk94?=
 =?us-ascii?Q?r+kvLjnG4EPZTuMbSR9AmOtlvulxvwJ5hRhECelvKgE97X7ZW67FrWgpoz3H?=
 =?us-ascii?Q?lnwgrgzmOxj/h8oQ2YBk5T5HF4Pk3TrzG2f4vJCcj9zV3n0XdIJ6ou6BGlUH?=
 =?us-ascii?Q?DuQTCZD57dWVVHfexEEZ4uZoggwvjSOzNppiDk8HI8zqSwhVvbDn6joGQcAZ?=
 =?us-ascii?Q?MS38+V47nFLm/SPxHb7NrIm3PQs/keU9dZPbcbiAWB/sAaTtlqnt7lIwN4Ws?=
 =?us-ascii?Q?KLZ0XitovgMHMK2auvLN2xF27Bhk3kcqFgGVARw5p5uwDZt2eLQlBuMa/ife?=
 =?us-ascii?Q?uac7GgiUyXpSfhBp0agvZBMGQQokpCAMf8K24Ky8QhqJ4EP1NE2yEGOks5Zn?=
 =?us-ascii?Q?ioe0eBDivVwOB4T62iCLUTAfIjWxiRqRbrLXAj2PxThDW4lyC+mGQJN1azAN?=
 =?us-ascii?Q?pexe8u2EihTrt3Rgb4P/pw/bI2CGPkvmdePU4E812ED1ycM7mqAYZWMZbgnk?=
 =?us-ascii?Q?1u05AURYOqgh4AuHbA+0Z8c6pRl6CqgxvWZ8/+XQ483vW4wR5Oz/1c1HqS6n?=
 =?us-ascii?Q?lGNvjjCN5C4K+xqygNjd5ynYkQ0NNDFaSp9qz66kwWzPWeOW2XLcsHrW8ZbQ?=
 =?us-ascii?Q?cyVGH4LoZ68+7lH8WEicj5FcChgFSjlLn8XiN70KhHAAQnAIZ+cvk+5ZseIT?=
 =?us-ascii?Q?rxc/d/npgXjluAllKhJnLm2FQWosVRozKoBPaSUI2PnuMREKYA0xgJLphJeg?=
 =?us-ascii?Q?ouq70uOY/i2bwmBLY/ul51q8gyImTiRqRVYXU6HKTcd0N8LpXqddBAyYYgLL?=
 =?us-ascii?Q?EWdngQlP6d22pqaHgH7u+P75HQiiQiqQqNVH8UPNbvyS2pCowB/JyiazMcHk?=
 =?us-ascii?Q?099tsXCdPg3k2dQOztavb/uOCV9q9apbCbiT0meKZ0MLjdSWw4DYFETJxDvd?=
 =?us-ascii?Q?6RREFD+0cpGspWm2aGoQrDbkLNv9uRRi7jkean2OfztWQCKzalI70FHVqkbL?=
 =?us-ascii?Q?x410msFhD26w/WXwk4pqhS/doRl4In9eJw/312VPDetz4bZnb65fk0t4fq0q?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dmVE13x5kYy1gCXNuw3Id93sem6Rwg9M3nKTYkjey+3BWf0jWVEVM+qWLQfz?=
 =?us-ascii?Q?tiMDkhk5p8jOhLJEK8XfOrw+xRUsQMrZMjPNqldl5rjXhcf94ePt75ujH6U+?=
 =?us-ascii?Q?vUn9c7+YzpzxR3K0wGPhXqVllWL8AhjaxCxNRn/jVkmvTeAResp1MZd8Nv5B?=
 =?us-ascii?Q?ATVUHmcdeKngeQ+GMUyeeYF6JPyvYOc8MjceIc74OepqeS7rphA+fl8v+tei?=
 =?us-ascii?Q?TesU3bj3a4kfAUk805UlaHvMRJIgPknloqXekstguCNquIiHBC1mGQJwnOQ2?=
 =?us-ascii?Q?OFor8WMWaCv6/xHG6wo3vg7hqtz/pCPelDguE1deqCUSKjCIVBHsjSrGAhuv?=
 =?us-ascii?Q?8bO804fnfXGP+J+uj9iRRaDRiO1187OxIs+ouCLnXoYQLHtiEqlonXNqyxOa?=
 =?us-ascii?Q?t2A/sOURl2E4rSSUZODG7ZxTz62BYXux5nbmgGQ4/FBmy/zuqT+MvqG+5dVl?=
 =?us-ascii?Q?iRhAz8X1sCTKbn0gGUDb6CwSjomoTnqOekuC8lZeaDkMxCx1jgQ9rLg5diQ/?=
 =?us-ascii?Q?n+d75NyomMUqQICEzqDKcYn5kHS2l+azn5GGXedKFHsUrxUwQBoPWUGCrvpr?=
 =?us-ascii?Q?L/grdW6JK08I6HBdyuL2TyCVXx+7qNaAONjkadswWiPiu1qBmIXT03NsIrjI?=
 =?us-ascii?Q?rSmfb6+vBXx9bMTyP7zjr1On2GSRZ+QKln6ux3LJSUGJ98aL4h/H5UdCRQ1I?=
 =?us-ascii?Q?TZlw9ZYaoz3VRkM02GEoETCPv4yVsk5q8qo23kN33D1x7mf2kYQdIlARDfA6?=
 =?us-ascii?Q?zNz79jAihHSJxzHeokEhrMbQzgCHyBosabIniho+8SaBTAALgIIURGBkfTC6?=
 =?us-ascii?Q?6T6VKUpIz7JLWGLWBenKHymMeaE9MtEUQ08jiNkz4AIExx7Ulgmtf8hPUoQi?=
 =?us-ascii?Q?cmc6Sgt3lDtt1QfgAwj4IAH16tYjCwyd6/i+ll+7KugIdb/06d88DtEQGjoC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1758a05b-93ef-45a3-2a98-08db5315bd86
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:44.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xa/j8Qt1rkUwsFGTGx0SMCj3HHs0N08PEpC5RjWHNahPxkGCX1NC3o/DdeidkrFC3PNx4nclLVvniNBeML5yoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-ORIG-GUID: 2Sa43_sfqGh5WLDUEQkRmckLBqrttquT
X-Proofpoint-GUID: 2Sa43_sfqGh5WLDUEQkRmckLBqrttquT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a dead node is detected, the depth has already been set to 1 so
reset it to 0.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b3e5ae43ff8ff..e233f41ed4da2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1396,9 +1396,9 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 
 		mas->min = 0;
 		mas->max = ULONG_MAX;
-		mas->depth = 0;
 
 retry:
+		mas->depth = 0;
 		root = mas_root(mas);
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
-- 
2.39.2

