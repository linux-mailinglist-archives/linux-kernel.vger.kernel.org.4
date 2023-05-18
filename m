Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73C7087FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjERSuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjERSuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:50:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8129EE4A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:50:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IsjN012432;
        Thu, 18 May 2023 14:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=1TdNAGujIkL2WjS4gl/cKBZ4VuW37YWu43lI8MFgl5A=;
 b=N02zp6fb9JGl3bXqiGkEXAQc0P/B0DjFegf/APscMbwKfPIe0IJBuBHEPjrSVhK14GGQ
 wRQxWqvMerQkMWYotsl1dEU+LSPG+vFLScW/BEk/M5kl2TOZKvKz9TU5WzdPOGwljh2t
 5wA8ilLYihx5q8qNE0As99Tm1vGpjYECV9+oxkpeXDNYG39Eb+q2EtrX1JPEDDDxxgI4
 fKAVGltzmkhkCQ5Di3E+q6lHo9wWhdBY4SxgRlYvJLzI2sVEkLqfLKBViCLHGoUyWfE8
 mpe09RbDWiE9hDzRNQvGNbRybK3ox/o+d6su2TEBCujVmTq/KgU5NgLg+VWSZ0HRXkZ1 NQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpjrc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IEc20P033902;
        Thu, 18 May 2023 14:57:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107c9df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcAHddjApTVvAMitlty2XWRPeyzPDENcJxM2Ii3HsDpG1BbkA3edlswsTGiTO11PeDdeA/ov9th1ZdqErEV876FB01nJD+DUibNPk+uZxRH0eOo5qKsim+cCVSKbWV7cPW7GNXT1gCTqRmgH6RMZ4Y5jJCK3CNRD/S/Hal0yJc8FTgkd9+s0lcTrjg1a+HkXBAKY3RNdbO/MVO86U7kjgzxqmHmmaliS/Lmalwf30nhNDIL8dN62xq/dKRHdIuTnNGxDz2z8phIynlLilU35wzr7x+2sc99dC8PTN2GasTbmx065u8MmGBr1B8cDmzUKzi76dkjWMB0NUEbNXd84yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TdNAGujIkL2WjS4gl/cKBZ4VuW37YWu43lI8MFgl5A=;
 b=Btw3d+CWLOSE2mkHj7OHDBZ9kCuY3So8Xv+Gj5TqV7FigcdXYBOLC1LaL3dwmpJbvOsVzd9QHqZplDxqHJe/bNyoPCYHZdGq/PFyaQ9OeafR+n5BOdtmMISRc2sJeN6qPMv+4g8uBv+j75v2jPQZIoTd4AEA7CeP10KbOAsnn64KjbmnPbor5Mb72Q9oF2+/1PPU1qUDPBMnD8HqSXFuwrI8bqVxpNuM/vQ/qShipA+brdarCi0jId/+MENIyLOONeE9SRa7C44uHfDVS90l/PM/5j6b0cMG5CWlAi6e+4TCa1dCBAO2bZt6AUGafb1iy3e7p+wAvVrxAggnO6ESPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TdNAGujIkL2WjS4gl/cKBZ4VuW37YWu43lI8MFgl5A=;
 b=eV56iaNUCrAnbkKRfr7s+xHTDSa+U7VX2pARgVDbdX24MdyJSkwlaDmYMQ+UC11HFOEH0zEeNpz2cx8fm2I2x1a/1yPBohDfEjxJ1deKO1hV6cS8ukQBUVDrIHZEEeoyLN77all8GThjAfRoho/GP7ZhQwjWV73QIwSDuNSYlAY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:57:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:57:01 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 29/35] maple_tree: Relocate mas_rewalk() and mas_rewalk_if_dead()
Date:   Thu, 18 May 2023 10:55:38 -0400
Message-Id: <20230518145544.1722059-30-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: dd711551-0b31-4383-f603-08db57b02294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVTT/Qc0ChiVrnwiYIG7Nz592w57fbzIRx4cEHEfYIXd4aQnFtW8xGw9yN3i7Yb3AHYxnO3vGenD6byUiMYLR0hyG/V9PijKGcjqOawU2Fcfx8vP69/7OIn7lG2UqB/N9RUCzCKV/Kqc2yhb3Y6C0JXkLT7RFnorovGCxgYlESf9QW/duP6LLAI1Q650GPEN69uwCVBmrLT4EmYUGd2uxH/Hf7xYDr2P+28jjc6Zy21DTU7urssKFP/sJ/OyZIk8uRTap0zxRN5wF8T1oXK/0fynZC9Q/zBvO5WhapoK8gQj7TQo9dY964t6UAvXs2zVmE9LaChiKMhoYu37Xs5qlkMgu6XflI209//XcVpgJVjDt44ApHcB94TDWetodU+Xp+cqJBT58Wi7JEBLqPJpx6S+tkgUXbc/mGPWXEnte5qmf3UJysuCvTD/7iyZSVj0F2VuJ3votp68XUxOAMt7//P1Mxjfjyt/CsB/MaBrBjNnBXprNlXZC0OhlcAjfhx/xeNaNixdN7QSuJKaAg4d0WmOMTlw46PJTyhPXPePNs69z2FHD6q1ybsp0AAXzBLS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(107886003)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MsKkEMMUPAnC7kqhfbzLuid2joXAkuK/2l+KWKmeVZtEd/pZDddD5yRdpLBI?=
 =?us-ascii?Q?Mb81e/6sex3ne1sUwC9uUiDbfCXcmr4XEfCn0wgB4pZ/NgpqAETK5h0492k2?=
 =?us-ascii?Q?gsNRe3ErDMgtzKj9lP0mNACrSf+6YEOE9WGTb0qVblStVSGWoSak9+Yh2ndT?=
 =?us-ascii?Q?SybNyXqCeLekrgzOXi/1LUyba1UEPQuyVvGjKuRarxcyEIKOFcgs4z5UtzaU?=
 =?us-ascii?Q?SWcJsNHqwsGCEFQLstSL8SjtjXiW/6G6I5RFo0xvbX1HIeenhWjweNeuly3X?=
 =?us-ascii?Q?oLd5Sn3/RcvZka2/Q5a2Q47rUrzFbFLQd+Th/41NU+zO9m/Qzdg3t35FjP7B?=
 =?us-ascii?Q?am0eMnfRH8TkJszfltZ6S/4fm2IowGB2sLlM4xv3tBlpO02CtPG5kCZzLj16?=
 =?us-ascii?Q?Pw7izlmCO8MVxCNQtymwy7t377LTKyPmicw4teRipyeDO6n31zmsAr3x3zD7?=
 =?us-ascii?Q?PGyMTE8OBnWI+OGAw49E7tQABKLs2Knhtda/9IRMHKt/WYv7b2blGOBs373a?=
 =?us-ascii?Q?KNsBv2dG16W817J5Gw+ydyX1LvNWoRLRKS8hjQYCphDyaHVj1nTvPSZo0agr?=
 =?us-ascii?Q?H+iGPN1Q/FvhlQgZSvVEN+MmsZu76lDKMPaFECywLvkizGSfLIEd9MtZYmxh?=
 =?us-ascii?Q?ZHzo8h9nRqznmDA4uvCrYaz/wrElynFW3RlRq3Vf3IjrcAqDU6ZcRPEZ3La5?=
 =?us-ascii?Q?/Wyyj1GqCYG/Fb/pm3HQmsg00o92EUECk10TtBOMYYswXxSdpHwDA4iKJPzW?=
 =?us-ascii?Q?CJNoRiwvuqEduV1d/YhlOL6rYz2wLzjjBohNMRzfLmFQkvZgA0KcEHJ/adw3?=
 =?us-ascii?Q?2QUAqlwV9DI1ixQw1lE4u3lunv96jpfBJOU78mpopCsep2pP7eGiit5fhFdG?=
 =?us-ascii?Q?dvST5N7o1wnfDGn8K4zRLcXnDOHt8w8F77TcL5uvcgpqcwyt+3cOJD72zfK5?=
 =?us-ascii?Q?6H5yySnJZ3jQxs/lhcQEj0if3JlZelgzl849iGbxSckt9JNhIc2SKlBwIulE?=
 =?us-ascii?Q?TGf5Ra4ytvI6io1cTRUTg/kwzV1/h6369s4HxLhwZBOzOc8dCbvn87iEvdPP?=
 =?us-ascii?Q?c4ygk1asduO81rhCBIBxR01EoVonakPFn8BG8G07hZzx9Zg1BTw7j79EwNBq?=
 =?us-ascii?Q?2Y/A/7hXwMwOuKDHli8tXDwQHYQEP8iKZ3seWfPIXKElqLcO6I4kIhFBKZDF?=
 =?us-ascii?Q?xfbuqA/0QBOM6m8PCwejNk/KkH7ENcEopccx4Oa7eSOrFZ6E0ifdxUTxskIs?=
 =?us-ascii?Q?5EX11eNzvYlseROxdhhi1Em3qIIEsYIhmNnkcIayqp6iHwttA8fO3f4farKD?=
 =?us-ascii?Q?/TM1g8un3cWrhel49XNIY/ZNHtN4k25eiLm2iZiaWupqtVmjOz4fDQo6MJnl?=
 =?us-ascii?Q?CGfF0bFTHidda/gAI8Zz6i6qVVEDXX0MuItHT0kiS+gbcJTn73jNBkICtzUG?=
 =?us-ascii?Q?T5ChnIRKc2zAmJbvYWvOrSsNQL2eAZE9eBnxj4nGmWOFt66zae25drLaaO5d?=
 =?us-ascii?Q?7GcI4zhSmJcZuWHyg6g7DNQ5Ut5Fl5W+JodyVhE8rkjLrUrW1j1eJ7HRR1I5?=
 =?us-ascii?Q?a3Jpjq5sM+UDSPgHwj3GTqJqxb1QmjP/fhsqxOTG2GlmZ96mjr/bZmq5NOUa?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YqM7WHgn1DQ5swKStdlEp2d5VlzZ6pN7lWoyjdkxZQHYjHc0oII7B5lNRqyLTC/OKw0rxSgrojtuel9vzahhkzBj749dtdab19wgtGCqGMM2FeFUtYGpIP71EGEm1vex3GuaAa0p+aXSdQgq11gcmVDYAiOHX10FT0FopM3fWcfOPiDjBP+D0KuVZm7w7HCMK0EjExuwyTrGc/FR+SUN9KXhCFhTUwYWta7bNFEYW8OJpAEBj+R7PXj6pUWlcq1JR67R28hkrjvdoLOlUDYkeJBJPQOaiQpQ/sKOkeyUnziIYFOYdRr2PX/qlR4onX+5DWFq43j06+JQiHfYvtgkYtIX4rMFKP/g4QBAr4EFgvCNr6tpb41KWogYSWakwdiSLULoN1aoyaRSkMd5zpqknXp5q7mFCw/7Bl/nLxMb24HdWAx0TL5iAGxouhJ1Wa/tLPPVxUjrLDzy7njv6muIIegoUIkUAXNnYLv2KeljXkiGWjWl8ndwMWgrMsXg6r1PxOXbb1LYr3wcIN2E/7suErepYA5SgvqXPIaI/b5XhAtr9TKRb80sIQw3hCUIo3wd29raOpxJybbuQdgqsV7tuV0fKqWP2ECgCpzeqW741DTUjKb3LfQRmG27UybdLSvsnzwNnTTFADHhutfaS72Fp/idOBCEHH/tcw92P8umS7rhsIrWVo76EKZfEfpxV1XHk9pWs5a3xT//op5irqIjsROeTjFWWRtpOR8GbwcKgnsfKhcCEGE6OdPTypNUgFFg/dvwQVtjDP34utbR8h5FqlLxZmr+2BwvXuyd6oFv6AfbnXwVt5YJohMUrl/XgVLELFXIrdPOF2XobIHhigkn3WncrsoCjc8ZhWJ6asDiLX33gAeUUA42ZNhq9PSpbhtFZjm2TLxrTA/CFtxLvFemwQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd711551-0b31-4383-f603-08db57b02294
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:57:01.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMz5lKPJnnUtDJGjwhj4Eo6SzNRkN6UdiOiPBkUCs7gtLept1isA7gQSoBmC7TORe9lY/Csm9IJo9ez+67UJRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-GUID: 0lz_w9n5r3UYf7QH4OwgEWtPkTAYBtYP
X-Proofpoint-ORIG-GUID: 0lz_w9n5r3UYf7QH4OwgEWtPkTAYBtYP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions need to move for future use.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b5df37be7a15..25748014fe34 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4497,6 +4497,25 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 
 }
 
+static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
+{
+retry:
+	mas_set(mas, index);
+	mas_state_walk(mas);
+	if (mas_is_start(mas))
+		goto retry;
+}
+
+static inline bool mas_rewalk_if_dead(struct ma_state *mas,
+		struct maple_node *node, const unsigned long index)
+{
+	if (unlikely(ma_dead_node(node))) {
+		mas_rewalk(mas, index);
+		return true;
+	}
+	return false;
+}
+
 /*
  * mas_prev_node() - Find the prev non-null entry at the same level in the
  * tree.  The prev value will be mas->node[mas->offset] or MAS_NONE.
@@ -4676,25 +4695,6 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	return 0;
 }
 
-static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
-{
-retry:
-	mas_set(mas, index);
-	mas_state_walk(mas);
-	if (mas_is_start(mas))
-		goto retry;
-}
-
-static inline bool mas_rewalk_if_dead(struct ma_state *mas,
-		struct maple_node *node, const unsigned long index)
-{
-	if (unlikely(ma_dead_node(node))) {
-		mas_rewalk(mas, index);
-		return true;
-	}
-	return false;
-}
-
 /*
  * mas_next_slot() - Get the entry in the next slot
  *
-- 
2.39.2

