Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A7A6EE3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjDYOLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbjDYOLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:11:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF3D14F5A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi7CU024310;
        Tue, 25 Apr 2023 14:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=aZS8RD999fUgHdsJnnn80kjdGzDf6FA1XiFSDSQtpFI=;
 b=qSl09W8wn8ygealFzlkj4JZX1Pz6E7GJPZMWyvAHJt/ow+H9QOcNxhgnBhcq66P5GQBW
 s/IXO8Ti51FPvKCsm16LAVlc0roQnQ725Ursv85tczGnPRzoRtcEcV5CLE1cv6UtVigC
 /+zi96+u7+8QcfhpYnhHlQBJZFPnpB4c4yeoJQZkPKgLLBSxsCimzsCsLUfcM7+0a0EO
 wje1NITNOYuDDaqDM8/h2qagBaWsVqRUj6muTQ+4j3qrpHHesohcC9OCWwJw9DUaYpqR
 Jg0MVE+Tkk/uXIciS2sWs7xL5AS6GzdU3sLxK2I8pgssRKoDcOfLi+pYKl6SvF/ETnz/ Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46c45fup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDXeU7032632;
        Tue, 25 Apr 2023 14:10:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616qsny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ginNR8HuvBZAVH04OcErruBgsBGzEYbAZ+EOiZqD3JxH6lE7mcl0P7XPqRVUx/Bf5+j97lEpqhuWlhB7CMy07zszG4p1Y4+3kXACU/EYXvK0vF0v+8I+f9/X/FNx/TbhahISU0DaXxAvaLrEAhrw5kwBy+SZerT1AAGnipsOKr1B/sKnN/R1hXr3eQFp2TB6IiMwYXGogCbOlIIH3bAEIbyhazo+ARXMD3ZK2b0SswqNH/TtOCBm6gXgeB3H4xnNl0MOYKG1ucZjC846F6oNBfmGD57NhX4X3BYTa+RGxAdg/wQJ5Luu7AEgN7JYe9mvoeo7lDEF+xiS69xOqa0NAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZS8RD999fUgHdsJnnn80kjdGzDf6FA1XiFSDSQtpFI=;
 b=dtX11oAxCfvddo2Ll2Jc/Q5Ik4rZ21Go0dbzL2881/DUhfe6pxM6Ulb8B6ey+N8SB6plCKsnXq4NEpcsvD+6BL9fwX+7zM6giy193hGMemDeaTUTH+7eI8YAFq3mpnCHEsNm4Uv/oXdsflgcmDunyfGBKeYmPfStkgX3qiDExTJcwxh6is0pWmj3xoHz3YUYfDn90EVE/ENWdHA030DDv/nyF4hMAoxUliCcDn4NgQ/lbWwbZK/w1TnHbAWoLr0ZlxLQBmb+1yb+vRAlD+PlKwiXDQr8fcWNIiyvDEHQIIhDKVdjQVX1rzVGfTVAKuxR5IJsKlme7SMsCn2xLvvJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZS8RD999fUgHdsJnnn80kjdGzDf6FA1XiFSDSQtpFI=;
 b=hovDSzQ1v8EhmDQ1BJk3ZjZbiql72Uq8Zj+WmFgVsiIbr6jjeus3paq1PFRAJ+vY7aFfARYRGjKhYId6ejJ3hegQBjCyaAxo98I0VtCNf/o3SmM2pDLdhIfxtPxng3Bajk+vIAqTfV7KgWWgWGe4GcW+9OvvWG4iPqCv9E1abt0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CYYPR10MB7650.namprd10.prod.outlook.com (2603:10b6:930:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 14:10:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:42 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 10/34] maple_tree: Use MAS_BUG_ON() when setting a leaf node as a parent
Date:   Tue, 25 Apr 2023 10:09:31 -0400
Message-Id: <20230425140955.3834476-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CYYPR10MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: d93acc99-006c-44ba-535f-08db4596db06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdJzv/Ff6UGp12bjuFdwmtH7FPD6WH7Cdb1Qi7UsoUGDmj/pYcKeDWGAGs+RpvlQGiXzo/uUuWDOYDDPiPDu3V+QjzXQULWGvBNAaHLUe1K+n0Sdvzx4F05xVH9xq/juUIyuGJp5YmGN3XewqBMaHHG3WPt+vbqBlED+mDYeZPF3rSgNLCGPp5GzJCePfaYregtI56W9Oh3cjKaIfwEtK0DPj4u6VkvnT3vz7U3oRC+EPmqLeioudsL7Z1DuDT4fGDYprQ1oME2Mr9Zjh+2tcNUO1dNU8QFm/fNQ6hoqGOomLSpfL5dZpadapXM/0/XvzNWAn1wz2a5PDiAEV/sr31DpFJuKNGllKKqf75b6bDmBNCciqTGHocT4s2FzxMvsgZbi6OhB2c5rRMa6gt/6mtBN22eEoVmKn8vslDbnHtmbHuuBpgoGtR3e30zZQpohwiqOKssCO2AjABsgFPVJ2xH4LrHXEEad5M9j050zhAwXwO5sVMz9S6G23PkUbKfRSdAHjUUakZtDoAcSAOzsjsIayeXWqvqe6eaGQvHzSrgVLqTBP+wu0L1/QToy5mZo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(83380400001)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?At+f95QINEROlHceWSzT+Csbqqc1ebgMRM7/V2ODqgOFnLoLmMMtklo62sRO?=
 =?us-ascii?Q?o3oE20IkeJS/x6Yq/d6HhXNu9pPqZ0y/Hz5h1jkK6TXUhq+74gQ0xEOCNi42?=
 =?us-ascii?Q?pOo3HHCKgIMHIui92yJGHTZaQJLq6liiLVyx5Gp6+W1dVhXsReyQKDtO4lHT?=
 =?us-ascii?Q?KOuHA4I9ItivGQgCO8ena6GbPCHph6aRL4mNHS7vtTWdyHXV8Vd4yt3oPE1m?=
 =?us-ascii?Q?+t6JJqdyK3nmXiaP7sSGSFzHb331qq1rm8JB0ZAdoOaVngzyYOc2UCUGu59/?=
 =?us-ascii?Q?U5hT3kScxd80Osu8XYQZOe1LOpa1LQN+LtkXujnCOlS6KlnuVCxMC4rsne4k?=
 =?us-ascii?Q?HESdTwgv18aXQSfh3wiaBG2cQiEoI5I4c3b3FiL6zXWE8UoDeN29L32q1d1h?=
 =?us-ascii?Q?8c1rd9pmqsG8vLDCnKF/ecmfbq0tw6bgUJ4BnmdyK6OKovGjMVtvTVfwgMRc?=
 =?us-ascii?Q?Hd0BDd8elw32cv2CsA/Xv86pEDsmrPojTguKzDGzyiUhuD0y/50Z/xnLIUH3?=
 =?us-ascii?Q?wcBRdf6MRL/MXxsMFqkJgm9dotVwtm2Y0AvHqmGAUwQnPLu4iWevIs7e0BLY?=
 =?us-ascii?Q?q83dfE07GkdKlHqnCCmLyLXol0k2TWcxl/OjMsr8vrWZPUGCKlPq+VyPAuup?=
 =?us-ascii?Q?cGuIvT98PuQ9pP2Ov/10a92YT+e58F4JH6Jbo9gy117QlkMLQQvQj9KxDIRo?=
 =?us-ascii?Q?wnbTLcM4JtBOsLyT92ooDP7DSbeRshz5YUBP4Hii2vmRJFmsbpQbgysgUeMh?=
 =?us-ascii?Q?GQ1ZfMUcySJUPtABCCSMHgqWunHPBxelvFLCYnEeQELbJLG21PMqWvJlgYlN?=
 =?us-ascii?Q?gNSOBKmEEmxQJKhO6sSzN1+bQl2Ki1uapOO5GNWYUH/Xn1B4fNbQfVgclKC0?=
 =?us-ascii?Q?25vTDlsYKcnJ0jJ6sykBTiApghRCPoTEaBVkYRgWO/wtEVpHUmoVO2levsh3?=
 =?us-ascii?Q?3/UXIgxX04nYycFSx7kmnFmkW3bbSKudK5j5UK5yL3IYzBCYGnpN8dIv6kL+?=
 =?us-ascii?Q?YPYfstoCrxB226jSQhtYjKtmRquhuluV0aGbKqJvvfGeUCdHS80Yn8jyZeRr?=
 =?us-ascii?Q?qDT/dv47LYYwIS4iXuLGe5XLEZsrCmYTfYYJwlCirjvsjz04ym5QiijZ7vKY?=
 =?us-ascii?Q?IqNPbc0Uvb/0/+No5bEQHwvlsBHfRfKxXmzGruztBNB+OyEGqzcBkyT8CJCx?=
 =?us-ascii?Q?ghpvmGMpJhk8Cc7hg4FhcDwI5RzK5PCrKKHn4NgWbe+SFJtZg3FxMYNLo7VH?=
 =?us-ascii?Q?nQbSO/4zForp361mK+LFhY5gNT7AbVmyJxxXKRIPj8aG3PCF6NMVOUSbT22v?=
 =?us-ascii?Q?TOHhZV6iYTUTGQcXjZZyzN3ioLYf8fle69ZLTsJKxVAADssEyRPIFLKN9ih7?=
 =?us-ascii?Q?LJ0Q/2umkJPb6cMBwDhCL6Yu4v95r34I0gKiMjI5FVldYO8B293fN2WCsq0j?=
 =?us-ascii?Q?nj6/yePcmzNZUk1qZmx+0HU4+inLg33Ytz69AX7KFC0bN1jNbbmZV7/39fkn?=
 =?us-ascii?Q?RTxCuF3ZongNTxsHTju4f0dQvk79UOc5/YIiFWeQMAlUA4AOE8l37tgqauRn?=
 =?us-ascii?Q?b4PGEXSVqVmnjVIGJF8EYk1To63J06giFEnpHSDO9A379X0Pbz/nBcPs1IzX?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l6eGb2ANKC23jqpNKfgQQwUc/LDm9z24Z0EARmqZGkSzeCa9ZZxXUVEY6BC/LS9RjxL21G83C9TC9OwRikVeN2JEwoAHOP9fLt9oITOhiE8Ltg4Z2H40Q0kT6tqqCWPtHMbdqbvbSlOaWMrEqa9x2zul139jL1UJT5M5rmSMywmZS20PmV50X37bZ5jhhPzCKv/xnFLMUt51FEZD5m7Xg5tQUPbqqgD28w+euKOLEfmwUBQ4Ta7kPIR6+yBj2DhYBCU+SbU5BBahItnaj3LXybvSkn11mdBox5UISwOoE8C2UkmybE5QP+LgCxDbbCRyUdYBnJsbx0VnWM9XWeH6tQxQ4gL51JtsW5iAJZSN83yTWCMhqmWkb9mE7tTgT9XbT/7NUc7yKg8lX7Uu/ABbeO2ZBbfP15cjxkNodbdNUV4qSaw8Tg97NdbFUKCUAkcmzvH3C2MkwjOeChGimtHa4zNyT8+sOs2ZjyVhNRtiFDCuqoZ35CWPG/950j1voYL/tN7YtOy2+9pheL4o9YQAcr5LeAvTrk3a2rKw4ndK0KY4lRO8u8JM/am5khRnWWGXWYrI2NjnWfrw8sxNIkfVT9vZLPM+5DEW0qRsWr/SFlL9yBtAW7k6pkgJ8TwHJcTw9BJW2uxg/CJaT02veDiXQtb4HrkBXk7cjD6zMePU8G0BRNjTgqt0DaCLCwO9jubwJr4xx89MLsJUH8zIOaWzJMBZBmx8+UDVgfYry7HnehEpEmCJMYOGBXB6kHvJXJuJQsQnmMBplkypqnh2SBopSZgEEPCWBVOoZ2zFAzPiv8VgnEVaavU7VvaGhzBuqR3oVmcVy/cW0R29rptw417WIbNjKhSa26ZhhjCGyBopMsMt6FI55zN9HAsAQHPqyx9oAaxKs7Tih9Z8QJRhmm66Dw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93acc99-006c-44ba-535f-08db4596db06
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:42.6032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSOynljhkeLzPFG58VUq3pVqNF6RNcjAbKMqlKlWLuBiN0TSKeIgdr4aB7s9VLteKasChsT7/Ki5RIyDrQHdvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: OHm_kFK_F9__pGBtlMlXIDF6DwxufVgl
X-Proofpoint-ORIG-GUID: OHm_kFK_F9__pGBtlMlXIDF6DwxufVgl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MAS_BUG_ON() to dump the maple state and tree in the unlikely even
of an issue.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d22a337e9cb6b..441592be039a2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -453,7 +453,7 @@ enum maple_type mas_parent_enum(struct ma_state *mas, struct maple_enode *enode)
 }
 
 /*
- * mte_set_parent() - Set the parent node and encode the slot
+ * mas_set_parent() - Set the parent node and encode the slot
  * @enode: The encoded maple node.
  * @parent: The encoded maple node that is the parent of @enode.
  * @slot: The slot that @enode resides in @parent.
@@ -462,16 +462,16 @@ enum maple_type mas_parent_enum(struct ma_state *mas, struct maple_enode *enode)
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
@@ -1741,7 +1741,7 @@ static inline void mas_adopt_children(struct ma_state *mas,
 	offset = ma_data_end(node, type, pivots, mas->max);
 	do {
 		child = mas_slot_locked(mas, slots, offset);
-		mte_set_parent(child, parent, offset);
+		mas_set_parent(mas, child, parent, offset);
 	} while (offset--);
 }
 
@@ -2706,9 +2706,9 @@ static inline void mas_set_split_parent(struct ma_state *mas,
 		return;
 
 	if ((*slot) <= split)
-		mte_set_parent(mas->node, left, *slot);
+		mas_set_parent(mas, mas->node, left, *slot);
 	else if (right)
-		mte_set_parent(mas->node, right, (*slot) - split - 1);
+		mas_set_parent(mas, mas->node, right, (*slot) - split - 1);
 
 	(*slot)++;
 }
@@ -3105,12 +3105,12 @@ static int mas_spanning_rebalance(struct ma_state *mas,
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
@@ -3337,8 +3337,8 @@ static inline bool mas_split_final_node(struct maple_subtree_state *mast,
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

