Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFED708467
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjERO6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjERO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4F7C1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:57:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6Iq3r003901;
        Thu, 18 May 2023 14:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VDhmyk7oP/1stbX6BGTaGlN6dqJtXdNwYcxrzUyCvQ4=;
 b=uXvGufey76lIxmWIIu9PdtjVtsJavWYY0V92QPBvkPtFr6qIhnRewOmOxmyZbBXMUphX
 gYqe/vwgjNY0V8tIxBt9kyoCze/xjAhF20kA/jVZvi6yWpPidSVhbVIWdIrVenG9EYAR
 FMw+Rkrd1jGDnQ7Scf99VN21c0ouxU9OLOaALDpLjJpleaBBjOWZHe++kkhQnbmRQ0cf
 eUYHD3hr5WjbQMT3duzPd60PXIqlgP87jryzNQbDxX8O+bfa9bBQTaGwwXJmdz9AggLs
 2rQUA3Ph5EVxo8gqw4pwBNtPDcU25sRUeDDuYcfeSdBFtz1vCnp+73E/MHr0KontL9q1 pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33v043g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDsu25032190;
        Thu, 18 May 2023 14:56:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10cwre5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrwxaCgRs+OFVFbUGLeWsIXSsgrrPsTObRjWcgpVIUCw/BFVGByyT1Ms6YaKUNlW1wt7G/s/j/ICo/ykk/achYg0zLyJsqCMgPDbPhpyaYuHXlwT6lNsMEdYgUNBIRBXFFapzGDEUaoKjoI6d+KqmScUlhLFV7JAWiqSZsUNSdqyiwjw8CrbbsLc21OfxecbZ/nv8Cc7sFvjLuhkRFxwVFuTwxK1nT1wc1SEqtSnH6BpYrbEK4cJxYaTmlK2322xtB82UOMyW/kGZ6L8m8HEmpDnOmx7u0Dx4/yLDlWY2IWzyKvLtL7xk+LQiY7osq2l4u+BOwASgRxlz/00s2igXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDhmyk7oP/1stbX6BGTaGlN6dqJtXdNwYcxrzUyCvQ4=;
 b=gpNwzK+M4CnK0zL77dxOrhjvxT/kkxnTzbm4o4KvEdPC4gJd+h/ByYgRkLHnW6mKbzzd7qF+DI14PHqsy+OToZHea4rVTqGHlyLvjsHYXRokWx/8yI4ml7FY855kgd7/VbyazxuIxSRb7WgKX5JBOv2Qqj19lGboA02yz8L4tSf27qtCDCSY08R6Ks7cZ9bPHcipTlExGAFtEFcnC+AN59xfOW73AVDAasr3RqvGUZbEnVvWs8CTzx+A1AHtbXHeaB12z2a1XYjlvIf3zt0ZEUA8QiGFDIjeN/AKpvaCeb1e8yl3L3g6Pv0j/ULbUt4GzCmGmPaAjEqf3vj5VZ3l2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDhmyk7oP/1stbX6BGTaGlN6dqJtXdNwYcxrzUyCvQ4=;
 b=i+o6F0/KaBwjyiRvbcaDkb5x6HDis3vbY82e/ee7WJWF8vClabQZkRNWUmDYL4CWoxEcg/u1nvIhsjj9K8LfhB5YsXaLZZr93bZlCy+4vVAd6X5itMjWlrrxXOU26WmWgeXDAkvToJcRfjDO6ZKBGXozVf0Dz+vbrmg1drBxdTU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:56:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:12 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 10/35] maple_tree: Use MAS_BUG_ON() when setting a leaf node as a parent
Date:   Thu, 18 May 2023 10:55:19 -0400
Message-Id: <20230518145544.1722059-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 4269abef-2577-4133-663a-08db57b005e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZFuZi2t9sqcZDDNzCXCIuCDYoQnBf5ovDh1xu7cDDGGys7QmscK5VmrOhrsKRebNwdQeHonGJWpVExepa8v7uCTbuVdu6nd9RqgkK26+gOoaUupvbaO52hQtouOKU5er1TXfKtrx3IhYhwwiCZw3Rir+GPG2addSRz6U01xSi75gbXAe0t1m/B4Zcp0x45PJ51BU+B//ntUmnKq9oyGhCkAZUQH4BkIhKBLZ+bZkHVXL715dT/gSbZ3AMoLwttjmHHnBEr/de8DjOOr6T89vSMX9lQN7bKYCYdeIxPqWaD/4bCsq9ijTSj9nTvEiVyMhv6g7g5ynXU1FB2zbgWlSckLGs6jAuWA9W6hUAY9qFvozURGs+ar5L7sM0cqyATBaklwl5jmESZakp1CFCGI8q79mEirglvlN4vIxL/xHukM3/t2NgEEX5oNAj5yUsR/gMD6T+GPCiabTBmI+7mcW05q7tFPJUi+LqTwsY1M6SYQCeStJW/eCLrg3GdN3SBdUZihxWrnrI37owGRHadeXjBdYcpmWz6Bjj1t5DKlKmi5CjFYD1rh8C9sjMyHVmvpE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(2906002)(41300700001)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?akrhMQMkoKvHbkXyr69YxpfK7W/CnLsWe2uelHEVe31arPXwxxIuQchDFzm/?=
 =?us-ascii?Q?mTQksOsDYfpFtLzrOHk44TYDx1iXlzIyfv7hut1O7X9Tm+E2kOVgVZ0rqIhV?=
 =?us-ascii?Q?Fcr5cUOEq8JCuju6XqQAusKSdpIWrCGTlRQuOhuuwjdr5nbjuWPE769bFUKu?=
 =?us-ascii?Q?ByK11FhYRSPFLB4rCGI6P756dphVzvNiaMmZQELjg59I9qKtPP652MNFQpiR?=
 =?us-ascii?Q?B3VuRqJ+0Zn49X0tK8X/WdWHXefE7y2m3DzrbSsH3gGqPjXHux/lwWN/Bcan?=
 =?us-ascii?Q?uKDIz/hG21SVfuXYPC46c+HWDrGQA79ZUFYcyxOEDMdDo08+B1XG8AmefI3H?=
 =?us-ascii?Q?OIj6cVrYjpMZI/m4OFnTQn9ENpHJnETDlYBoe84mfnyi0+j3rUU9RY7WPLOy?=
 =?us-ascii?Q?+SEgNkrFPcBWGNb6u59rcHfu2gjkLQB0Nk8eqc8eL8QayzJIa+PDGncD0hNX?=
 =?us-ascii?Q?r9uuK4LRSCzLLQxgSqcbnerdZ0fdUEDHvCczjQdArumL3J5OaykEEvBJX+Vc?=
 =?us-ascii?Q?Z0ZqWst7ud7B+NKLcmUyiBTH1rQjUFlzogaZj/IoFQKs/DoHrjqPMcbwKhaM?=
 =?us-ascii?Q?XhjN9KfRW6LfowW45Z2c6g59/IL65aX2QetY62QO9ftmw6bhWt6majcbfIpA?=
 =?us-ascii?Q?8X1mdocbmIphLNZ+yEhHqP6y3PnNCypBUOXtjCXa2ItUo+J/6miCmEPuT4Hm?=
 =?us-ascii?Q?EK0TPM8L2kYc2opRdAccufcj5qV1w9NKjMelB1lcvO90MUJ+UU0Gw54A4vC5?=
 =?us-ascii?Q?FaGYP52i8VmOCmEh0d5lLc5Xhtuq0fOmhlYtNlcO6NW4eb+86SZA6OfW3nZC?=
 =?us-ascii?Q?+PbviqfYEJX2CH6O5/BY/mNA7vIXa2odb/FJqo2JYEHelJCinXE3VGL+5IAm?=
 =?us-ascii?Q?GzDHjtOv6eBmZ+aC8hQdqlj6KS0Ivm8kELeH9n9CwvbE2aq6QQec1MHJc25S?=
 =?us-ascii?Q?7SQQ8CcjKtK/KniPS9Wh3GBDNRXEaAlTHNIhGsENUV7jz+ozSePj/rKjb6Hr?=
 =?us-ascii?Q?L4DCWSx1xnPppR8ex9glzSTwVzuf9uaF99bCvFtW0oXy1JM/zBDYCa8zc+kP?=
 =?us-ascii?Q?KIl5TOML5pNLUsqXpaumyyla9v5Ot3Hyb7Vz0jyDen8hnt+9v1EVCyeQq9IE?=
 =?us-ascii?Q?sp+nU3umz0hqiwDTY3njtHn0dIBfRiNEzZAVxEz53h/yd0vMYKkGfecISUZm?=
 =?us-ascii?Q?m64Pzaj7HDQIKeFbex0eSf88h3/aohNi69JPJbE61A9T8dKOJ2sWnqztaLZu?=
 =?us-ascii?Q?UvZOs4ej8Yse3ifJgmCo1Bdin0VCUz+BpqfUERBoPtNefWR28GdFGTc9qCRw?=
 =?us-ascii?Q?ts6H/6hNNRvl3k91fcLM8das5fuuIBHZg6zxXAU/6rjy4gNoTfRRmhTqR4zr?=
 =?us-ascii?Q?H2p0D5dvVO3rkHDUhRVANHN++qyYcANccp5uly81K4uvtxVlTW45TsgC3ker?=
 =?us-ascii?Q?WrVChngRk9VIoRhYJ/2tTemMWvLmbTIKUN+vY7A/fVaWs4vq7ZXWrpWl4bZV?=
 =?us-ascii?Q?Y5hVN0hHaxV25/TLGU51QbWM1JfeqGkhhPeD2PmJ0P6iFNeT227Eas7urvEv?=
 =?us-ascii?Q?40+a3ygOEc0dbAHtKFt5WoYTUpWI1Y23nnf04QO69aGyUQrPipb1Gz2pT4WA?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wuWdz9mi+Cm4eBF7qqVJ+KFTs84aJDsblgSnBG6DvH/wgCOxqxr3y2kLPw2DX4Q63NENRWDUy83f8v6WtDtZQuirK/vIRB+T1focj/wVj39OM5NtbZ7OdiDorSBbTm83ujkC376khVNNKM/Ko9UMdspsh3CPvDM/8n7eFqIXIgk7MDhFyc/tk6dvIOsGdiF55/p94CuwbRETVTIH8IX8lXrd6H8jSHljk+HIN/4Vf/vMHzbUY2wiRB8sG44K08luNWDRgwCdKkHSIay2Mu6BK1gMka0vxCuM2uIy/KPtQ4gNi1XBJO6qYPYMS8DE9P7e3utmopV1PRG9KTqIrs4t+D6jLzkyYeRRmVZx639ENPEK/3MHvI3Bgqkcm5lSAqfKiWf9x8+bFeFeC6WSU+BwOp5pc6U1mvEu1yeZ4xXtYTJwYMvStxwzHhR3CjdSG3hn5PrO67eLvGmd96NJwr9X5w5RhzmxbD3anSeVFxD7rb63TTQ1F9EbyTj3QOKZG19Etvjb+9WdDHUa3q0g0c7zMYvtp65/0qaTI6G/TsZS8NqeES7T5PcraUQC9nFICBXyqWFkAt+TRWgT+o4gEPQUxatlMpy8Xc7T91FbcPMwZ8Iygkz6iOQPDBKMxzR3gZX1mfNn9eoZ3aW4tld3fkAW9zGWlLwEvJxpWr3n40sCOTLOYXOUMn+S93hWMibFHD7LrNNlDcrwSRPyWqe1tJpkexV1egJVYmSF4Dr5MtqWnwxaTEvglP2sf6aOqghktrS2CF6dsMCHh20IQFKyUWuwMkKuWiBpEgxZlPuTg2APbXUwVXdwri7tZMKZignfQDqVZ36Ncxy+yadz+7Zk0IlEdLH+miukUeVJbxgmOuzZvCuF9Jt+eZZD/t+SOHFXVPQeSVG6wJkMpZe9mtwdKdUp/Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4269abef-2577-4133-663a-08db57b005e1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:12.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dXxUaLB+wtr7cPtm++CVNAso55KOTv7XRzAv6c0zoMDD46HqUFg3UZIqW1TLT/OEhzNthwCXUK3BMtS147qmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: 37e9NwwdYmB95Jzq96JnACwfoCjKWzpd
X-Proofpoint-ORIG-GUID: 37e9NwwdYmB95Jzq96JnACwfoCjKWzpd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MAS_BUG_ON() to dump the maple state and tree in the unlikely event
of an issue.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8fd83f21caf0..a594f1d88d06 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -453,7 +453,7 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
 }
 
 /*
- * mte_set_parent() - Set the parent node and encode the slot
+ * mas_set_parent() - Set the parent node and encode the slot
  * @enode: The encoded maple node.
  * @parent: The encoded maple node that is the parent of @enode.
  * @slot: The slot that @enode resides in @parent.
@@ -462,16 +462,16 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
  * parent type.
  */
 static inline
-void mte_set_parent(struct maple_enode *enode, const struct maple_enode *parent,
-		    unsigned char slot)
+void mas_set_parent(struct ma_state *mas, struct maple_enode *enode,
+		    const struct maple_enode *parent, unsigned char slot)
 {
 	unsigned long val = (unsigned long)parent;
 	unsigned long shift;
 	unsigned long type;
 	enum maple_type p_type = mte_node_type(parent);
 
-	BUG_ON(p_type == maple_dense);
-	BUG_ON(p_type == maple_leaf_64);
+	MAS_BUG_ON(mas, p_type == maple_dense);
+	MAS_BUG_ON(mas, p_type == maple_leaf_64);
 
 	switch (p_type) {
 	case maple_range_64:
@@ -1740,7 +1740,7 @@ static inline void mas_adopt_children(struct ma_state *mas,
 	offset = ma_data_end(node, type, pivots, mas->max);
 	do {
 		child = mas_slot_locked(mas, slots, offset);
-		mte_set_parent(child, parent, offset);
+		mas_set_parent(mas, child, parent, offset);
 	} while (offset--);
 }
 
@@ -2705,9 +2705,9 @@ static inline void mas_set_split_parent(struct ma_state *mas,
 		return;
 
 	if ((*slot) <= split)
-		mte_set_parent(mas->node, left, *slot);
+		mas_set_parent(mas, mas->node, left, *slot);
 	else if (right)
-		mte_set_parent(mas->node, right, (*slot) - split - 1);
+		mas_set_parent(mas, mas->node, right, (*slot) - split - 1);
 
 	(*slot)++;
 }
@@ -3104,12 +3104,12 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 				mte_node_type(mast->orig_l->node));
 	mast->orig_l->depth++;
 	mab_mas_cp(mast->bn, 0, mt_slots[mast->bn->type] - 1, &l_mas, true);
-	mte_set_parent(left, l_mas.node, slot);
+	mas_set_parent(mas, left, l_mas.node, slot);
 	if (middle)
-		mte_set_parent(middle, l_mas.node, ++slot);
+		mas_set_parent(mas, middle, l_mas.node, ++slot);
 
 	if (right)
-		mte_set_parent(right, l_mas.node, ++slot);
+		mas_set_parent(mas, right, l_mas.node, ++slot);
 
 	if (mas_is_root_limits(mast->l)) {
 new_root:
@@ -3336,8 +3336,8 @@ static inline bool mas_split_final_node(struct maple_subtree_state *mast,
 	 * The Big_node data should just fit in a single node.
 	 */
 	ancestor = mas_new_ma_node(mas, mast->bn);
-	mte_set_parent(mast->l->node, ancestor, mast->l->offset);
-	mte_set_parent(mast->r->node, ancestor, mast->r->offset);
+	mas_set_parent(mas, mast->l->node, ancestor, mast->l->offset);
+	mas_set_parent(mas, mast->r->node, ancestor, mast->r->offset);
 	mte_to_node(ancestor)->parent = mas_mn(mas)->parent;
 
 	mast->l->node = ancestor;
-- 
2.39.2

