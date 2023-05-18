Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E69B70846F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjERO7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjERO62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A75E186
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:58:01 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6Iv19012574;
        Thu, 18 May 2023 14:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+1Cnymg/7mO2nO6mlpzfBpp4aHgiKpcmRjtkpJNYvLU=;
 b=Wm7+RcP6psDXAeM8Mr328Gyj44F5Ujrsdo/HbZhmXffZi2zhE4pTfARx7TfYVJOEuONw
 S+ZxK68wRQZe6ZrNHEsRZthH48HSWOgtFi7WJ109M5OeJ9ZxUgKiMu1xlE1j1u7233Ti
 KLX77RWq5xt0MkaPim8nYULZYGXqu3QxzqE8k+wJtVimo3WO3G+ShiUVKfpuR1+EbRqe
 avsfJMIB7ZFewVoQVZqN6Z954VICBjrq2V0YXFUV6OUburx5kq7PV0sBgTLD6x5Nda4J
 DURd/fDqEejJtqHLzcfbECpl2j2EdgwdtMaYaqrTKjIQcjEORFbWQgaEXW1bmcoqvZ7c HQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdrgxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDMtjY004153;
        Thu, 18 May 2023 14:56:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10d67c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKphV88DHwmuTQIXLpPqtdKOc8PgYy1ngTJ+Q68mQhdwnIZvZFY9pYAD7gHvNTJ+h6znbj5AmPdQeL0td6/I6bAge66PQmxvTeVFtQp+vKwzYpWBiRM5h7YSh4nJ7xzpKoJbfRUtBRMhgDCqPwEMJtEN9fQdLOy3bnHpFVc/wyFNJi3RCPkI66DK8RK5bQhRXU5GBRd5z5D27sSQl9BLzX+DGpvb1Sv13gQWs2bkgV35lPg1cX0PCBPHBwXMP5rqIjMM2zKK7OtyAgIsYRiYBgBSEAyg5d/OU4OSmp/UfoyoL4ZGjejAT0Kb7D7LC62ICE19GgkFYsYFbFC70gRCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1Cnymg/7mO2nO6mlpzfBpp4aHgiKpcmRjtkpJNYvLU=;
 b=HkbI7rcAY9HAhyJks5+bVXxDIblaHEbYYhUWiDj8axOCPNNwbU6X4aQ8CWWQnlO2WA160JBk3fAaIqTcuRdHMu2U0GnecJwKv4bvt91Jax647dvPny04uyeQ016+AYqx0gp9tyAUxAvZmxP8UsYadqxyM9RS4LxqzYZoJeO89+4ADmGkkqWZQnGzcxB0Nhy3KvYLiWNUjAlxhrix60BKAvKOcyjnAZ1JHAO32x+e1/XODVPNZC6On09Sin6r92Z2N8v9KqwhYtyNmJK/0QSXnZNixTTRJqadUQiYHVlm09IAWSXw1fx3aV9G7SUbWAc4NEq01FHLxUwc5iW/GJvvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1Cnymg/7mO2nO6mlpzfBpp4aHgiKpcmRjtkpJNYvLU=;
 b=eoa1fJSok0ZweMopdFVzFu6/FUmYifE3vWlhI0FnoyxUiGS9pMEyVQnSWJp5u3IoCagvwSXAcCvmstt92na0v/3Ridvrj5+5yFS0u7SAo83tPtLMNH+HpQusiHca/E2WFII340VARA+iqS7fhGxNezzNED/mYkXbEQPDO0e+A/w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:56:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:18 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 12/35] maple_tree: Use MAS_BUG_ON() from mas_topiary_range()
Date:   Thu, 18 May 2023 10:55:21 -0400
Message-Id: <20230518145544.1722059-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fae5ea-11d1-4c0a-df41-08db57b00955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fSbEg9awxoHeKFAc0ODXlmPmWQ80DWHn6JX2jUIz7Ka3uAQ8DRW6NNp9txjWHK2aPgkUV5s278rsN7114S0hgGMdmcqjU8op0VBkdkgLc5sBYNh8gluMCvXxo/tosACNgydlfFzZta6UnfWYK3BQU9cgBEQXbgY5QNILClRt06LMJzDvJB/onPvswCqzm8DNtTxwvJkqfDOMtJS6dsPvmZSYytpw00hXDocVyTDpHVmowVNKg3nnFJz6MrHZ8dXBuwQ6Fd5YGtg0eQBGwhfW0yPzu/50J3o4FyU4u0B6+zq9qoyohzcAjxbN6t+p+jJTyCDgHWEItUbcZXSg8QtWDeOvA37M4XASGCn85m1TNpPXviH9WlVc2SZf3v9RsfPY7ZRqCi8ssY1vawmabQ89CxZCE/SyWUP9g4SVV88ouIIWib7OLthUH3QQ08JCzWHW3Mz70P64dnp14YIchrMmSqiNTKdu9IN8B18Pfs6Mbust2l/7Q/RkL9xaZDluAQ4SweY23JB4TAVDi27BDXAHqnYbmRPWb+B2w/CPG1r6T48A4ZPaKoGm3QgQzcJzc9q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(6666004)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(2906002)(4744005)(41300700001)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p015azz8/5xBh4eRlQJTMe5RmYh3YNN84I7mYs+ceT4i9ltDTgcgGT/tji72?=
 =?us-ascii?Q?HX6LdSXuviNij7xlm2hmoPxvB1VLgRHvsAP4Oo8lT4ixkYT5pWj38LDA8N7m?=
 =?us-ascii?Q?MhGUFDVDrACT0fesyD4x2wT5EYP5AMEmRjReeMAAwj3gQqbJSObrz89qEk/b?=
 =?us-ascii?Q?0zzwy6n6L58vFrjWCwCtZBSOZmFa5+1rQ0s8TcRfKWscSJSo7WsZdsliPJcY?=
 =?us-ascii?Q?PETadDoqw4v8xMVtfMn2yfSXCXkCwyzoCxrUgfWpVEuGFHjwUmSQMD7WsUO/?=
 =?us-ascii?Q?DA8SGHK7uLBoluuXtEPZ74A1k1BGE9RY0NP014dTxE+0HfvfV6sK+0J8aa5z?=
 =?us-ascii?Q?FoBLx0ipGF0y/4oW8PZpAO0FNFUjXnaGwsfw2pNmDEbpbZrkRpbrUH89cvJH?=
 =?us-ascii?Q?BQYvjH3njG7/ZSDXDq74ioiyg0j2MSTNBTMqUirFVtBK2wNCiH1b3oB6bFom?=
 =?us-ascii?Q?N9eqYNq+3eE44ytaxS2+iJ/3IBMwCaKM9OFkZRJX0W/FhNFDI3WoRviC1NX2?=
 =?us-ascii?Q?W3Mo2B2afacKltjbxJkGtOWTnkvFJXlHnUatbfNXNXF+um95+dL+VGu9Mh6l?=
 =?us-ascii?Q?1cvbu69WQvMa0LOPdxnCZiXzF6f0DvbSmoe0B3JBshGOzcYPh1TykbBJxoxR?=
 =?us-ascii?Q?NQN+Ezw29ZRHLI2FuXs29aoSS2UIGCthiarUjy2PPvgeCotIYX+0YySZiLbm?=
 =?us-ascii?Q?ewhsXdgyKfKcqkyOc9RMFBce5rR6PCLW+ZdYeVWc9L+2O9uVsDT1H7V2rUGI?=
 =?us-ascii?Q?muHGMg5ksgqt9gEwpffiUw9obGcJxpHkfS0DNaWP6AJdnILS2sIxtHD4n6vT?=
 =?us-ascii?Q?aN81jCInQVGR3wuach354vY/0qzctxy34thfFxgKIQRckdigb3pwEDBfJaiq?=
 =?us-ascii?Q?jnB+5Qahz59MAiQ/uSriELWoizUWjGG9zhx3okESgewtnV+dH/QzZGqHfZ4/?=
 =?us-ascii?Q?sQgGkfS21GruAZ6tTzmc0T0QlgtXFICDXX6ObZ0+P4SKlWI4uLEmfAhu76xK?=
 =?us-ascii?Q?K2hlI02v5kCafd00fTMlC85m2NG754hi8UoIUJLetXO0RqJgZ9k3ccCdWLkW?=
 =?us-ascii?Q?8PvOvzFgphkq0HoAF3ZO9mlEZgJiwWSnSP/xNC6N7mHPO/VsDeA0lrnhcPjG?=
 =?us-ascii?Q?HIY0+nY98tWCaYkvyewFGvGsFXzFbEynokigk5gCpexkjxJqZtjQBgq1ajQ1?=
 =?us-ascii?Q?CUQzxT0dOBpjBVCElzgM+J2cL2QNy+Bw8h5VhqMzvqe2X/sc4nlO5S8Ew/oI?=
 =?us-ascii?Q?YWGnc+T1epikp9u8E8trVcMZh7DpTylBTHq7PyfZh2un41mGFr2VvGNhVBpW?=
 =?us-ascii?Q?pA+xoJNhvrHBP7N1UzFKef/1+jz0rvN4uwWTVzipthFpTFwQ7q5JrNMqndgx?=
 =?us-ascii?Q?p4lvaTJRPrpsmgQSEnC9XSDe5XFIXXoLdLU1GTljGupMKZh8bG62wmld6iZc?=
 =?us-ascii?Q?A+YtnXiLUU9eXZCI/hV0/Nk04AZkrmLY5cC8oBvevjniTogjn5ivExd0uA9K?=
 =?us-ascii?Q?HimOyMuObvG7D69Sx+0yYRCqohBVLBkKo7Dz67UJcd8j7rTA9D44UsJfdbzr?=
 =?us-ascii?Q?b4+B3UbqQ3a2c75jGWAjz/8VZ5NMqF96HK+NwySoLIz4h2cdHnB2MNCseSJn?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pYhbGgMyRLAQOy51i9K/BeAcWlMIPohrK9AltZ2+va/01BdxSkp61r2VOWVzDU8C7R7fRTTyPXwognl6wtISRGS+sXUboS9+dLgwqtu98o1obd4SZSn1OfY9ibFD1jylrYg5dDt1kh9Bx0wmQXwAOAqmSAYHHSzhDRjHAbbyWBGAaq9FUDn9tetOwIHBoA877C0JVW+OJ5UsPe8ws79q2L6XcNMQlOjksQyMuque+7gxTLMJ8B09V+G/wF1jR5jlvxF/j5i/pgCKNs4ItzutiRGLEwLCnGVM3dUqjQ6d8ws2Fc8/8naBONvZPAclnokeMx8KRPr7Nueo/YaD/lk0KODF30mAN7z0xr4slWrtbkJCH/t61Kxp23mHvc0vabP+dQHQKQvpPb+9QJV8WAJjM9aWFWEgn8jttPhVljA4F4ArzXvXMd+Mnjuav1X0kEu1/DG/xlcniwLvnlIR3n2p+dCIAUhUkzWQcRdSK5WwCGj3uVUE5j+3Jmkzz/5O4PFRJr66TNUWExGlulDQoqVIZW/PLyImdmrehYFgnM7tpdzBWKL9zEagZORl7tu5NTl7ndI/Vw7/mcZqzyGV4hUClj+FjvDHdAyj9OviYe3d+x6aunvXFwTrbKmwwykJ4NvXpWaMOK82UQ4mkNkB3s4k5hX04G4It7W8VqzBLiPYB6gmB/woR+JOrkWmWvzz74o7KabfHJvCepxjmCUziCDMogdx9a/hjZMUAgK9VnhNOibJPmfzwefXDSHQpMP+iMtI6u6FIEa7WlsxkwKRK55I7UqsoYYG2KcJw9q8WhR/0ymNIwKEQn3cfHNkkHNsc5jnlB9DHvMuO3KwRRw4RwMj0u+b+k347ok+N9QRoeOoKpvHeyf4RNssub3pU0GJLS+5zY9MF+SOyrELPF1Chaezag==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fae5ea-11d1-4c0a-df41-08db57b00955
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:18.6545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ru3PJnR2uupRfvvz7OinE9R9uYU4e5d/rjnvqawPBib5+Ht48vClmwcpVLL1g5FeeMDk6J14AVlsM13gjmFbCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: X8EkVB2_hK-VlevvEUyDX4q6VxMad7mM
X-Proofpoint-ORIG-GUID: X8EkVB2_hK-VlevvEUyDX4q6VxMad7mM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the even of trying to remove data from a leaf node by use of
mas_topiary_range(), log the maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index da441042ec8a..824967872d42 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2345,7 +2345,8 @@ static inline void mas_topiary_range(struct ma_state *mas,
 	void __rcu **slots;
 	unsigned char offset;
 
-	MT_BUG_ON(mas->tree, mte_is_leaf(mas->node));
+	MAS_BUG_ON(mas, mte_is_leaf(mas->node));
+
 	slots = ma_slots(mas_mn(mas), mte_node_type(mas->node));
 	for (offset = start; offset <= end; offset++) {
 		struct maple_enode *enode = mas_slot_locked(mas, slots, offset);
-- 
2.39.2

