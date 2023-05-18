Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2D708475
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjERO7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjERO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6125E1738
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:58:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ICEtDO010660;
        Thu, 18 May 2023 14:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Loeg5K+AxFuoMDuc5bDgd5qopMfTkWVEkjprcxbfs6Q=;
 b=wyQWfPo5jw+2YeoC9iwo/3lMYObpL0nKbARz9rosDIYXthg5Ky1n/LjF0g42yczvVA4H
 wFcItkynoCwBk5eZsClOpjMv1rz1fmoPWPslvt9au16yXy1SaTzGDI7dLiqmFvOGvWc0
 DvVHspAVpyevr6z5rcM3i/dtjobGcIS8b8uozuSi/eYxD0oWepUyjmTbEfmaE1Wt+8OT
 mYzdIPqgKYog0h6ct2p/Qlw9EhGAmOqDNx6Qk4HFuX9OO6RFUZw0L96Sial9S4U5QKf0
 qDVM4h7/hZy68FbHXmAn19sfGnOOonQg8NKe7e8H0UlJJykFiQ+gRXsMnxK3Z38Z65rB Bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qnkux8ak7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE4GjC025022;
        Thu, 18 May 2023 14:56:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106vm9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk1e2pUDdctgicmGdak76FX1biAeBLxoBXN4Z2txfuWPxgtbgWEw+eThyvDwzOHx+6IHfZRqQQvZS3/7DGlUQB/gLWqkMGI5AAUdR1co8FkgGC5+Ucekbb2MFE19paYZ6AFOGUE9qz5W6sCosybrv7RGPIZl8eTxD9o25fqwKd569A+4m3DwCuovXeckqymzaEGwwJgFHC/3jJXwNJkuVmkJ8+C7pzD6f4gs71Y8UvVWkYncbe8sDn85Qx2wN0rOSfeLEnFV8gpeOlmMP8v8hVaKO0J4s4tRGVGZSh58R1FrRVWAfueivfjTv5j8w+9M/DWpUC42fqWMWIpbL0XfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Loeg5K+AxFuoMDuc5bDgd5qopMfTkWVEkjprcxbfs6Q=;
 b=U/0NVb9KSUSh9gBjeqhJV9F4aDP2n9vi2zFqKhj+Y/k3p+EJ9TojvruSmTJ4e5bIB6VPcP8FXS61dJnk7sf98OMQgNMJ4cafto7WUEQWc7Hr1ernzjzRzMDcPlzOKDCueZpITCsnBnk4hdJrtCCvBjhek52ZRVv51rm43VqCzzSWCmUMP7rtEW9GTTKkZENULm7rw8QpWALB6znje2hcaoxzZKD4l1QYY1mYF1oaYqKmcUSTNhJjOEyMiNUNiK10Pd+L30Gb6LhlRcI+SjAu30p4yRc1Z7AZXxJJYsrbP9pJDdGnMdQKZaXGj17XhMtaSL1CC0ONGUkyzx08EFdw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Loeg5K+AxFuoMDuc5bDgd5qopMfTkWVEkjprcxbfs6Q=;
 b=zpn7uxSx/vqHUYWk5n72UYwpjhy92qbM5X9WlNXvUGVhAHuo+H93Y1SJ5v1m6YlGhq8QbOGGvm5vIwzDmUngPvncovxUppE0dZd5QtjHPs5KDT8ckQLvdTYTT7zmhiX+x3nkYzYSi01/yEOZ9C46RtFbRiznfjG4NgyDQPxtVJU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:56:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:22 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 14/35] maple_tree: Use MAS_BUG_ON() prior to calling mas_meta_gap()
Date:   Thu, 18 May 2023 10:55:23 -0400
Message-Id: <20230518145544.1722059-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: a2aeb6e9-7406-4004-05c4-08db57b00bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWXZdMbxWCy+NY4XjImZXS27mW/r28Bs0fABoO2U0SJr4+bt+Az6iRmFBTfP4i6lOnXSB/BImTX2b0sbaf+RNP7zrg52PPeSL8UDDNf+Y0y+oShCyFOUmLg8q3k8/5yWFCGyfKHbIPe0uScy1uugDvEyIscgLsasMmfzY3omGq5aIqI7MixqsDIVp1BAiYrT/WiCe3zDPgqSu2t3OacKyuE2jfm5P+F9wGwgkSI1RRB7CiGNWXw9NoLq1fZm6GOAyQLOwkiIBCTdNoHaoa9DKgv6tPuUCtMWdh2BUA+aLeJ83D7PYFsZJZRM2lY5gvkRE7DWtjivrh602veML1bGec6IPwH6XfKC92h+Kc7uSnFgbPPOcwBu60SUjFqACUf0fT9yhqMkkmCI8jYaRUmnnVhGIyTEEHYdrpZibmQjAEheGFaPdBCqfA9XJSMISdcbksY/euSBBBc/pBHGRrwJtQpMY+DkRyacS6phj9BS4+HNziRv4IxYICiQq1JUzgN2d0XzIlzJPh3hh0f+CK0O3mklsTZbYnX/iE26KPP8r0sqWyNcxCrK6Geexci37v15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(2906002)(41300700001)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VVWpvfEsmBpmTEuKp2WMeWipyU5IXrFdJcz5uvY6RCrwoFbeSPoXHmMHQdRR?=
 =?us-ascii?Q?NV+V9YlEDW7dA5uuHieuK8PvbOepGePo5LGhdd/z2fDeTHu84v/TXq3mpGhE?=
 =?us-ascii?Q?QMGMeA3tlq8bCK6iMXJKHlZtNjx2b6xCgnIS1pfmDvcGxVqp+OzEoHHgDlCV?=
 =?us-ascii?Q?yd0uPurUml0IypNR6Rt9dfd68lThgtsXFb9ZecruYW5gCWZCqUm9/ZitmvU6?=
 =?us-ascii?Q?gmSwtvxGySxIS8K9lD6PDAe64aqzDizETFL5bU7cK8VWSi2GgtJhttmYXnrx?=
 =?us-ascii?Q?NZtODL5vxqbuULy0IwHOS7xntEuslAXRoCUTqWENVpf96sSpruNLg2eujSb4?=
 =?us-ascii?Q?IqYPbzkHgnwwIufeG6tVjdQ+fi2CvRT0phL335x0xWSXxHEsYM9fg7IUuSlU?=
 =?us-ascii?Q?FxQgGtQZ6EaRe+mPD9ngg2TuYeMUYXxjTkDDZKRVWYIdH1qyKVutTFhAZbgA?=
 =?us-ascii?Q?0zxLxsKYE1jnBP+nkk6WKv1UnqQ7uyN50fH9ksqKJ5WEqkjdmd5/1XAAmtXV?=
 =?us-ascii?Q?Kd4S4cx8XTBv8z4qWd4dasd98Yeg0Q7uZGNvRSfBHXWTEHqEv0fHdfPXOEwl?=
 =?us-ascii?Q?Jkqlr/sMmOJTrbS3IvJoWj8lMF6tRmDFvSb53yDQKY5vf9FMOADuihoBXNzQ?=
 =?us-ascii?Q?xiEbZLLqCLrdNk4EhKGYObqXZLEmLW2vwOQyq+k9IRVNH1Eg5iHSqa8zEzgU?=
 =?us-ascii?Q?sXGzviZunTJjWU/Iost8aDGp1mVwO3F1DNPiIO5sRq93BAOUVuf1MybB4qP3?=
 =?us-ascii?Q?MTvm7VJVwEI7VX5R0ZjNlphj3j/vGsp3Ro25y/Vv6YUB92DSq/wUfODZF+Dl?=
 =?us-ascii?Q?3ZpuQTFxtv5PW0jo4gTp9I97C270dppysneo8KgaXvlitQ7FTYBds/KUjW7J?=
 =?us-ascii?Q?8jkC+UEQ21o++pwiAZGB2p/T60ckDQw5Ug1xbHCNUWO/ynXBjygmNGiNGNtM?=
 =?us-ascii?Q?uuWSUwNG0QaD/+w7iyV23exbOTz5KeoJCDuDCwPjVd3CBc/d1h48iJUDCFf6?=
 =?us-ascii?Q?uWlcSmT+Ox9UFfpoyjQhOROkkO4YBolZFpcQlbmAlnn5295truEDOxMFvBlt?=
 =?us-ascii?Q?xvxLQgyFo81TZZ+eOTockJdbZIQbD5JJ2qPBpDGu8E/qBIEMsr0GRAdSPm1E?=
 =?us-ascii?Q?b9T/adrd1SrX9VAtD45HOkO43Do/xj98wezsXjVwtzWuK1GBiKtfQIuiy+8i?=
 =?us-ascii?Q?PbsFaGOqZoFGcCZCwS6ze2WMMvqBU8RbWAm/llUrX3Kebg7TshDFS+igDGMA?=
 =?us-ascii?Q?jXWh86l/DW+qbKFoFn7x5RvyfbPA8ckR7Owc2bIP3+AmdfmpMqIqwioG583I?=
 =?us-ascii?Q?EkDG5iS0p36lQfUxNmjiEtscaQfnLISji+dzaP8bysufZcM8KVrz4WvYeMSh?=
 =?us-ascii?Q?KnCtdiLitKkexvC0R3VF3bmLzRNqLgOsZKMzvofTG0SpAM6ACfxUrc9UpJM1?=
 =?us-ascii?Q?mu/wMgR2gKLV2fv0wx1JRUBd0zKbkvvDBTYZVBIQNC7aYOgYhfM1WLYqbvpk?=
 =?us-ascii?Q?CKJV8XBqJQJeVZHFXp131TVaskisWCxq0P5RtSOW8VuLy/i9h/1TQjc+5OM+?=
 =?us-ascii?Q?wgC8cBi2ddmPWAqWARoZc+6EqyCiuXKNGZU9lYDu6XvbGA33BviQEKt7qbol?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9sEC34dFuew2JZ4yQ8hNGfexZxdgbV/AxIkjDuV2x3S/oInh0MjzAL9fUnwiSuVDiOx57aIA/yWAu+yXlO6oahSWO+pGoNAa7ENh72tJao1t2ClrxVIllk/qCqO7g+u6zWs7BVJHEqJb2F3BUi0y/2gt45zpDPw3Lw3IWuLfgkapy/fSGaYG5Wsa4r1dHLcnsP+yNp9EPyYjzM7CTX9K2Ln0QOb0fk3SLzdonj7aTxSb1ea1p/rXr+c5TDSStSX35PySZQzDZi0sNoJl+kJrx4hjVMcqDlPRvug/S0uQB1hUJAys32rl3d+knFEkOayJZhwuBcX1Nymg1XvI1s+gtLAYvnv6DCn2X5jOZJnjTQTw+wlwDYRnY07OfHT7CkSgBL04Zr2S0n5+Q8yyM3IdcoFlt54xe+zYj2qB3eq/N1/AYlWu42XWawhcGjJ2DHUxygAlhznUkIyNigv4WHkaLW+vh51h3+A0VQSWhjYTiNiiyD+AYYpZhZYMGgcs3XbP09SDhUO+sSou4vVYNVlJzqPEdTnPHeLHlbezV42PbEp9AdrShNEjNGZnfVuK3LIsimnmeiZhBBHrfWO5slvB9H2YWg6Y+xFuwOlIOXmMolvcgp5r5RQGjBs8S+lGJapiSA5Y4+kuqSn6gI9aZ3TZUBY9QDOruehSKVzANsQ8p3NcUf8293LHC2fA20LG1SCbscPiULaXaMRvh0PshsgdfCqpijblQuNZmOleR6yZm5RrLwcWr52wfe5Cx9/6BDuikLw1o1xA6SnQse8+AF6oS0bbyrnlz1SkLNTiML+MiySQH5Bl8DDeE5omBUvCmW6im72/vm0L7afUwN00clkPG3oJAx0dbjLlriqi2lgA5iBj3MEQ3OIjG+V4KC0y50yTqqChuB34J7a5003UnI56nQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2aeb6e9-7406-4004-05c4-08db57b00bd0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:22.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWBpC/bGZY9Mcd7Aira1dXfUKpOi+HtEkgsNZ8H3IKa551kLKZeBrwvF3US0Fgln/p7e6wc5DTRRntMSrfUsmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-ORIG-GUID: hCMlzqsSuwi1bxTbegoNwJmik0KNaLfn
X-Proofpoint-GUID: hCMlzqsSuwi1bxTbegoNwJmik0KNaLfn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the call to BUG_ON() in mas_meta_gap() with calls before the
function call MAS_BUG_ON() to get more information on error condition.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d5ccf7bcf3b5..d7809a7000c5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -963,8 +963,6 @@ static inline unsigned char ma_meta_end(struct maple_node *mn,
 static inline unsigned char ma_meta_gap(struct maple_node *mn,
 					enum maple_type mt)
 {
-	BUG_ON(mt != maple_arange_64);
-
 	return mn->ma64.meta.gap;
 }
 
@@ -1628,6 +1626,7 @@ static inline unsigned long mas_max_gap(struct ma_state *mas)
 		return mas_leaf_max_gap(mas);
 
 	node = mas_mn(mas);
+	MAS_BUG_ON(mas, mt != maple_arange_64);
 	offset = ma_meta_gap(node, mt);
 	if (offset == MAPLE_ARANGE64_META_MAX)
 		return 0;
@@ -1661,6 +1660,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 	pgaps = ma_gaps(pnode, pmt);
 
 ascend:
+	MAS_BUG_ON(mas, pmt != maple_arange_64);
 	meta_offset = ma_meta_gap(pnode, pmt);
 	if (meta_offset == MAPLE_ARANGE64_META_MAX)
 		meta_gap = 0;
-- 
2.39.2

