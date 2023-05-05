Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937906F87DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjEERpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbjEERoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:44:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3991D951
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:17 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhL0H031584;
        Fri, 5 May 2023 17:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=d6ZJYb7OBgZ8fLZD1qapOKPbyb6wU+xw9GGDQ21f5yA=;
 b=3iF8LE2YLKxfuIKGgF1GL4OcQVnMJJx99axeD/eV5X89F4sCoIeKzzV7DeStfHu8viqM
 Zx/fQc1xVEsbq4Stg4gjKG9NeOUe8K7Ex9En74CQtLFhwD76r6nnPfQLDoxTlKlD+tRn
 eJT1AbPbkccDht2oV5u5I9ihXn3x1gTEIkyDOsEwYMUFDAYhbFjiaOw35N7WGxTPe2VX
 iFlbrLgHTEAhNB0Z9MBa5ziXHLY3IYztqBD6oLFNL5ihBK9+WlcLhoP1/n1uHwdfRtSw
 Ze5sChU9u6Mf17rRt0UHH61WYIHvgyFYvU/ZUoPhwE8mST3PAZmd1OxQggMWpq7Ez7br Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d5nec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345G1jbU020766;
        Fri, 5 May 2023 17:44:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa5fa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao7O8O3xDuZhbRN+hHDl1KDXLzjzM1Q5hKjBmHHOrdXSZREpTn7mXvm0cwXNxDMx8VqNSn2zdbSvTaAqMXnnuqsHkBeP4zzAxCVH/ufLlIF/DCjxoqkjgO94va4elFNbba6R77aLODIaQf87difOz3+lCEQR+S02M+RKjt7nxu9iHb1dH2iYLTYHi32RhFjxWxhZf+Z9YJne5XNIYBusZ+YX1RVXW0NAuDOm5VYnS5lB63Ml+1fWXPvL2Iutv6jKDaMTEsr4k4qPXrsxfYwfY/hkVNyHCBZwzYimI0FOfUeQeMSUynEGUFZa2/x3sZ6iCoo6V39+MZgK3MlSMjV/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6ZJYb7OBgZ8fLZD1qapOKPbyb6wU+xw9GGDQ21f5yA=;
 b=B1lh5tg7he94N5YowKDmg/W3w0tcF02zKqbZ2cBaicYe/W3gPX1qkk+8b6xpashH/WYzvmJA/7kp7scTkXzTag9PBjXFITSEKO0XDlsZhxeo8Rr/3qGj6dr1+ap66kcGpP64BwusPDnDdd09We1AlaDzJbk3Btpui0NhxbzZTfQunLa1iMtICFn+sUP83Ipk8acbqk1I0dyJzrkkA1koQ+fn0anCrQYLeNyM4iYV4QMMNjIL6jtw+DsjSigL0iUy8YLKif6uVKpeaCtfg5T+blRPAsny2ZI5D2cofxTNOVsxrWfdj2EGVA0vBmz3eCWHKL+B1DGvN+QQ3nQgsituxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6ZJYb7OBgZ8fLZD1qapOKPbyb6wU+xw9GGDQ21f5yA=;
 b=XC32+v/n6cQDJJesBuUJCrLnWar2uE2FfiDByIosaY/vkgNZ+Su/xbmQDQN/J8oXCl03WEUIQvXqx9MqDFj90K9r2mWxlL0JAwuJkfgAZVGRs9dxLv3VAoyW4WY1yn0QEMSYFePAE3vWs54M2p96rIrLKGXSnX7YqA3C8AsNiW0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:10 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 12/36] maple_tree: Use MAS_BUG_ON() from mas_topiary_range()
Date:   Fri,  5 May 2023 13:41:40 -0400
Message-Id: <20230505174204.2665599-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7a18dc-bc9b-4fb8-2ca5-08db4d9054f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Jtn4BS+ph1ohbR3TT2hvh7yICIYZp39CrtCg1R/s6UIYsQEuiwQRZ4XCid2cAZcasr4APOnMeMEGt8Vm13z5UrBEvBwfd4xBplMxzbl3e+FlolkG2DWfwa8+4vdWH4B/brWEAoI0QNzNTNaMEEeAY4+dY/x6yZ/yk7un10obTqS4ZEjhvJi+ICFwIE27pAnBbfNrVOvwA6I6NHGt7DqggbvCvnAllPpbXMPyLhYPkhYyaVjUDE38kY47zxLeDgULBDgV/aW0q/S2q3t+SztdXwWFKVQyuptkCQFsQhm/W4193kjuWTT26l8mf847Eu9Xle9m1IePZpf36xeaopsC0Il4/35Vdrtp7aO6GsWZw6FEAFtVj4kDg7J9Mk8ysMrQjfWArheyKlxd+peKYv16xrYR4SDIcxoQJqHvDsPhqwye9QDqg8Y6MtLpmUNnkdfLrees8fD0yf2XThm7NKR7zLiUbCBThwU1oZat8teamM47/qRr/tExrAVpDEaCzL/+A64XLWV0urLzzBj7n6voYqRn5aefCYEkHb1PoeiAXLX5so3DazgHUA/rnF6xjXo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(4744005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6MCUG2NXuc8fNEMncc5ZHZ8vEbXVPE4+XqpTS526zY6J9a65w3DFukpm9wu?=
 =?us-ascii?Q?4qzzQr3cwmJyf/bNMJuFukJSOLOMznS6WIYA9T34wSHzvLzExX5HXNhamVA9?=
 =?us-ascii?Q?ljkK3ZlgwXampXTjlxjdprNz3nl6Nz78vWQxss0mJFV47lnezpeX8jFj7l/g?=
 =?us-ascii?Q?OjVo+m8JXhQr24hc7Qah7+KLMVU+e6bafFOadLg84G6uJe4lnUNCXoYgmG+l?=
 =?us-ascii?Q?jK7ljraRhHcJvgYFnTKI4oQlZ1r8GZ7TRuah11Md/5E4OfXx5AxEth5jOpRQ?=
 =?us-ascii?Q?PTH0xe10kxdkBUCeClrG8bpAEXaKkN9uG1D7a0X7r1PnThohIN1ZW7SBlBC+?=
 =?us-ascii?Q?0XaI5wX0Pc4jg3az0Wj3+ucoFdOVMLBYJZ1I4dOB5PqE/VWOVCJ29/FjG9C6?=
 =?us-ascii?Q?zKbxPoLOHdX1WYBxANYXqbUlnVehEjudUE7HazUIylAIdAvVcxgrlNxUZz20?=
 =?us-ascii?Q?uCpOrpG0DyBxcJ0jq7YDvcq3HmMxrsUk2dA54s0+ELa07bkyRNuerLF2MYaK?=
 =?us-ascii?Q?LwhdV7K2otj/nw94hgiQ5+5D1MXsPKS7sNQrRJcxH23BXQg1xfcBG2BtlzzF?=
 =?us-ascii?Q?hVnlnSWirFfbeQvx0AKtByNas1iGB6G65PqzFUAi55e9p6eRvWSeEcHDPiuT?=
 =?us-ascii?Q?7eAG8LfnGcjKSCyMBlGFvRDpK/LmR572VO3yzfzDmVuo/rbEZAaGIAXPt1Fq?=
 =?us-ascii?Q?HemUDY12Ad8DOGJ8qynOAm2REzV+mvtjJI7kCdY5KMjKXeZ6Ks7PYgMLpGur?=
 =?us-ascii?Q?JRKNoaBPZcjfPSc7DPk9Qen5vC+yNGEcxmpct/xZljqZuJbeqFHctGHRTC2b?=
 =?us-ascii?Q?fd0RdPXL+FILGmBt6ScbKSa6gGV3akdtp64p+CrkQNbNy2QhdjX/plOtmJcw?=
 =?us-ascii?Q?cY9hktZdKM5Q218bj9OmEa1v4vVFp+w/yaFyoIob1viAS0N/Fux4PC3M/gCD?=
 =?us-ascii?Q?yB2OD3kOZ6zyPdjckyDIZWktg1hq379IGXoUoVXlrCnElLCQFv7UI7g8eW6G?=
 =?us-ascii?Q?I4VrvnQ7hZHFQvyYPpv6qK0wQa3/6sClK+Jtpyqdm1MUFFpydhm4u8IHkjmQ?=
 =?us-ascii?Q?bfVOliuSiiRB8ZUoIKadKkJd5ve/OUNG2A/FuoDrKyv8F8ym5OAaCM8H8c2I?=
 =?us-ascii?Q?quvV04TgOE38J6/w5UiG4huEKplEt+GBTda59DuLXmzwACa2kIhf/76Ml8nZ?=
 =?us-ascii?Q?Ec1gO9pU79OOQT3qdTwyXcjyN0CO1yMOHrnnw94UxlWfe8h9byYletkuKKRc?=
 =?us-ascii?Q?faMeCwJXuy9HZnbvjcsWONvR6gWBnKcBfASnVHUagL169WblQh6r3vXSByMu?=
 =?us-ascii?Q?tjEf/QLNy3fe6MB4ddNCMNPegEI+IrayCX8SpkDfeIaSQR4zCLs/hgWFKz+6?=
 =?us-ascii?Q?fLEHUZAplENtJH2MYWsKKJGJSiHKmSWZQc7QX0q0P6DQFfHcZicnoni/Ae6J?=
 =?us-ascii?Q?Kvi1d1pSRLRUMwt7CWSvGI5nOFSkZEPijFo0qOxX1S/K08xVWAU28JFuk/qU?=
 =?us-ascii?Q?wQ/XdOL//vxGBu7gWYx6EZoD2k3WIwmNCVG/k8nkZUUP99zhQ8ZbVihoOhwd?=
 =?us-ascii?Q?ITWG2byD3o2pSoNyWedDRB+edjXXGK8AsFOQ2VWpmz+afOofvQHKEdIX8gCL?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hqo/LqFDf6dBMwSfoSe1Vs0JnSfrG+M/Kj7I05F3vAnADhXdKQCCAtlIdXdIOSpeHIHwMRkIDW195OwfJpkWUZHNqiQERun2oy748pKDeSQnIT0LcCUYFUg+5qwnxF4G45uSQPaWhJghaN9TWnf7p7Ob4nKzIt5SZB1NNaj7cdhizEaAuJax/WYgtQu4SMYTJZ3btFQO7IjpTTY0sY6j6r6C8lvpoe9B3ob79CVMKMWbfxFPizRWTw+2XJsOkQcXHTV9t8YBAsvkpOf5LdxkOIzr/mbNTFCMlWIFwQ680JZXdUa0shjUjYJ4+ueKMaljWEF1n4J/PSZHI912wERgFEB0s7d/83IdosVcyxhy1gzKBpqSYbUfXVuNCYIvq4wjFfQa8diBNwJZrqToPX153Pbpfcxmx01je0VhmtNK5jJFwPYGltexhVCpqWoiU/gfHiLplpwTxXaK7pZDZttXo7A937XkMAgLv2J7sz5ifvn7QxZdhj/rdrt+8aYk0JGF5ZD8YrqWDPwWnIm5hAqCJ6/U1EiVlX8QzJCrSjBYPabKOuJbUjGnZ+baeV3F9mKF+XsGDJOlH1yvScx+VM6eO+8IE95RYhWvp4IVEEn1ixUp4hG4Uj2xrvmcsoepx3llhHIytUAjvTzaqJ1uzHLDkPKB8gUsK5lmZl7QjFUl2exxLDeRIMyj42slN189vztByJ5ORDtQtljSMEOPWjkASCJuvFFaPN4vSY7gqwecklGkrBXPKt635lN8wGhwV4NyyE/Nk2L3QyRlp6dJeON4EerbJwW6FRvISA/pnRPhE9PVNkkaQZwTdjIC+eOVOoJtImMDv6GQZuoWaymewCk6f1RnxERpD7TOHv7/+kWVWXgyq/eHIidxce9Dc2i0kmHAXWAM13BhtHg3iJPdG5Yetw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7a18dc-bc9b-4fb8-2ca5-08db4d9054f6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:10.0225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CsVVBf9UrFAK/Uh+hVhkmfka5BypDZQysjjBdgERmHjQAvmE4JTZWtsyRRcbgD5LQtSgaiPWu7HkRjqgLmIzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: k8_3q9NBZ-H3VTUXg9N74yRvCI0c2oW5
X-Proofpoint-ORIG-GUID: k8_3q9NBZ-H3VTUXg9N74yRvCI0c2oW5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index da441042ec8ac..824967872d426 100644
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

