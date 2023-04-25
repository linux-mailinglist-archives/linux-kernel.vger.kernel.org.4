Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1D6EE3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjDYOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbjDYOL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:11:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8163A1545C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi7CY024310;
        Tue, 25 Apr 2023 14:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=vfyDtNVdaiXOS6IVC7r5v1wf5CbCuySYD4Pb34MHsQE=;
 b=dVn2vtMomqKAosKCqN3WwKI6GtbVE+uK0L2dIzNmTHxUp0emIwkNE9oIvPAiT417VSlg
 RYIkPNwiGTmIuD6+TUVKPiwfTwLpG9ofwtvo6n0Z/kMwiD8w96z/X897pN1oTIin0W/5
 wrURgfFBp4nqVtJEbtlW1LkBj4tsT4LQ5vY69MeAhQmF7/bAJ2GDvesjEjz25ye0Qj5l
 uY+bA6cRHD5DIqOmsKuOvLPxclFjzjaw8XroEHRmLyxkOjj6PVcN1WyJC1LJqlSezgTv
 Xus22mLcNMppokaXqHXau2LV0pjNUxmp44v+W57vJBnMRngNIArApybWlbyBvTtRh0zM Cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46c45fv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDGhel013616;
        Tue, 25 Apr 2023 14:10:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q46168dkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fw5022CHiGeRm1fa166u5E4nSJ/MzxzEhXACImzNAewP+1fZy0i79YMbACM43VIq7+Igv0sPrtSYibpDwmpQ+7xGd9PaxSLl5fXdHFesl52QuBYrUdEOznB5JLo99gWRyH5O5Gzv1adZ4X18K/SEdg97vEAWpqjmLklrREBuX64wFA05IS3632ztUvV2s9/fp67LgUIq1Y+7U54bVhg5dByCW3IPFM1m0nWhViafzgVECvfvzQ5YjSTwkxTP11GmlSczpaPcqRLSilquXKhhYxHjuUXvmhuZpOs4GUoiGg7DO6ajrOwBx7+HNT/g+Lt809xpgEDpI7Gq2PmXLLSNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfyDtNVdaiXOS6IVC7r5v1wf5CbCuySYD4Pb34MHsQE=;
 b=IWjJCM+BVeMi0RaKRCyiAC6b4qdwIyCM46OV6hDcOJTX2t9mOAJKExJ6J/xkud36Z2HMO4L4gSD+rW8zhMLxRd9ZC4bH9Zmx8OkTBDYIi+VQM7OVc/NijMMKhg/yNOJTrDPhFLblp0E7Kt3TLnBQvySaSW8WnRg0Gwaav5r3UFiVXcGtfgIebfPSfFdDfKa9G9zKol0ETMSu8cpk4AGYEZpray+xnK3r4i4rJDGs+Q/h5YPCqJTMsb34lhx3AFohMqAc/jaPIG6RIQLXuP7exBmvqXIO83RL2jCLSyc4QbTV9/6YGL4AhSMERbmkO1dSezSack9NsKoA9CGyjj5S9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfyDtNVdaiXOS6IVC7r5v1wf5CbCuySYD4Pb34MHsQE=;
 b=E14WM0GMEKJbw8vEAwUozSLZlpQWo+oxYWbtkQ4M2I34DiaKEoDe+SUv5sx/JO2/MS92h/ZiazWcnFfxCnJORq4533n5WWGwzhDCXJ2MRghNh9QDovc/Wj6ZhlrpDY5MuNy7JMVoQLE8i5MBcV4GZUqpwU4BovdSrgWr33C/484=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CYYPR10MB7650.namprd10.prod.outlook.com (2603:10b6:930:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 14:10:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:49 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 13/34] maple_tree: Use MAS_WR_BUG_ON() in mas_store_prealloc()
Date:   Tue, 25 Apr 2023 10:09:34 -0400
Message-Id: <20230425140955.3834476-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CYYPR10MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: af8f8780-4ed8-4c0b-fc11-08db4596df2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArNqEuaLqkYU6+Fb/KV6c4vfpUYMpyM1hPbQZgtDwtp4KJ6v65Xo/p5BiBRX9XsEXkUCPf8kLmc0zFzUgDBHWEItxGzAA/wntTf9W36jQEIfkti0KVlo7oHhGNBfAeUyRhoa9giG6GZZKF2rdrU+cpwg/mcW/Ebq9BKb7hY5UhNO8LYACkDUhPtntbzH+rwDvBZ4LKjoZ3uPKa1je9VR0AS2S6ywY2/+ueSof00kpbI3bUqcdhlQ2F/N58nD9d0k4NvwV57CG/63UFOz10Bjz2bn5Ek8h5PDZez1fJOGrDrhBSQHMK3SWaoHh+7BEeR7QS3wewniMyO4dwF0mpoPVS4if6jHS1FQVH/W6skJ8D/N9hRAKre+Ab1qB9gAPBuvniHMmS2hpzXrHXXHtbkabv9lWTvxQIkuqIRkypgzytQBUssSupoIyJCu11ADogC0o+hWqWHchOn7DJjF3yKHcY7eORVqioCk6XBnI52c7PWXlMd596F2HenXLvI8zU7Bjaj/0k1Gb1UJUeR4E4XDyFwYp+PJW+jWBT6PTmgV+dZfPBJCy6bfKRSbAZG67TQm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(4744005)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(83380400001)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2lFq5YYX9PWnf3HLG5sl7oB9D++m91p8088gjNnSvFDMgcJLVkKXbXciyqoS?=
 =?us-ascii?Q?BeR4OYhydm8V6MCWAvDHyPxKsZ/JWdjOakUw75fC8o8ng441WfFtohsgZj9x?=
 =?us-ascii?Q?Vl+gXye8eofuqoAGVuWbjVjjHU8GMGNnbZPdOa06QFjJGQMgfH1xy4AgRfww?=
 =?us-ascii?Q?K1Uj2MYwSKN6lzY+lPE3OMfwkx3S/3O8lXs1OEuCpNBM1j5Fx50Gh2gOZ14I?=
 =?us-ascii?Q?UrFWgjzaBFYooukonUVtxGqp/Y9CEvC2xEI20eORNMnEoXoJ9StCMbX5OvM7?=
 =?us-ascii?Q?pNHeUA/Za0x57wHkNHAws7SrXPnGC0DUAA1I1TgjlWI/J8w740eIYtKT3UMq?=
 =?us-ascii?Q?fXhMcSVIi+A25WPxKOzjoM2nvr0mtzac1NqH/avd5HDkM/Q+9mBNPw+PAjGO?=
 =?us-ascii?Q?TApMxpBePG3+ycwBoP48QoeWmv8MhnKsl8EZAQzUZHIU+HAtOFe4LbdDhKC0?=
 =?us-ascii?Q?cXOLmRMMjULl9mzopb9dFrKbWqzqBmCRy6OuWuJ38Rd0mCu7C3pFQbGZ7WLA?=
 =?us-ascii?Q?ripT0n5rGeZb0vJrIVTg+AA8iny4DQ/yEmM6ZxbeD3k8FF7eNvNQdqQwinHN?=
 =?us-ascii?Q?K/enez6PQmEpGfiybSBqcuduee8jAwY67b8fDemrqHXAxY3ONDWjylO+di5A?=
 =?us-ascii?Q?u/ACUbqHzWDPEJi+l280xfY6A6UqDWUH3Iaed+b8oIJemy590t4IvXFAmhRZ?=
 =?us-ascii?Q?vXZDMje92WEKqN8SEZK+DWvUWDvsePnMqeFEnNzxtVEAGFCuJBrlek6K2+M5?=
 =?us-ascii?Q?2AJDhjrLA9WHLS9HkJpMA4n3Txopmqlr2GSU50Hj5iJt/KNgTqy6lyNbzE7O?=
 =?us-ascii?Q?11WBaOTv6bRHDSKrZxp0Lsu3YrApWRbkYnYH5789KoUpxj5EFe0f6jLMHILk?=
 =?us-ascii?Q?/LrH4LkZCJ4nCx6F+EurnTGHliGQaoq0KCvXS059tI+T/80TM5g1yzT4bbaf?=
 =?us-ascii?Q?er7cXfQiKmqfb9Zxum41IY6E9IQEL9hFWfOA1FXEgDNZsnMu+UZkZILaa+CZ?=
 =?us-ascii?Q?GpXHN+6pJ5Z5TZ2xv3qV7DncljhFWLMnB90z5b1H68BsrEbJir6OX+yTGUWy?=
 =?us-ascii?Q?SL1Ewnyo/fBwPDVuk6lxg0sTvTPLd7Fw1Hjqt203UA75hg190IYOWusdnh3+?=
 =?us-ascii?Q?tjNv36D8ioNJNr1jRDXecJ0dRVb1AaEWwMNHGcTGWzD1lWv8SyMphyadvfkw?=
 =?us-ascii?Q?Jz5CAcQd0gEfAd3wzkdNgI7ioTU6j5U38jUqChLrIlAy6xmqAPHBxpLqxdpS?=
 =?us-ascii?Q?OwsXoBKAZyAsoixL8wnozvLpsqRkfCshL+IxxCiURCGWvvAlEil9lWQmMOQ+?=
 =?us-ascii?Q?JWCYrkrd9kV4Esd8/6gGFLBflJufG/41dEsAB+dfw2l6FbJi87x1itPyk5H2?=
 =?us-ascii?Q?kE1f9ZWWq2NYKFb2nT8TZqC9BZcQ/CP9MVKZp7vvU1EoEcjwIQ7SYB/kNpAN?=
 =?us-ascii?Q?fVvjRRU35TKlaaup3jxUf/Sd3ZlHm3iVOsWpcoNXC3S2TzKF39Yr1Tbop4jh?=
 =?us-ascii?Q?I/6YJY7hlUAnt3Yyj0ucoUOLBfhKRfQcC8P1kjD1zDO/n1CQr7O7LaWHf+2h?=
 =?us-ascii?Q?jv3nYfTjXiiSuoxuOE0lvL7JIvWXGx+10PTuNXaHviapNaK9HCM9+ZvMKapr?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Av65hvq9+OPBzaxNEtc1E2Q1dKowb0Hy7P7NiuDuQI6MVVudyh8Ww40jhLF+ev0xKjJdDXZe78GgHzjOcRJZMMc4EQmLKhMJKv47BLYyWRopkmJWuSHiTdGGudUjszUQwNgKo9YtGCTtX9H3QhuF5jTL+uqsWazLZPq37X6fQYI/d4GfQ4cWElqkA4RqTGRejVgsrbMY3qPFcsmSYmLY8xvwnjB2U68qt03Lkt7cFMHdF8GQGBDql3fiaYniWl6MEIk7jt3xW5aHjM6fmlmzaEqqfqmuqcuvhmb7JxASdXMHBZX2dtXTW1QRnjtVCTD0tiyP1rWFb2XEN00jsuHZXuuiHzmZNj2BYrF9Tz8GwHk4ZwgXktTwTZMYGUlRnJhedtHCSeDqLooEmYeX6XEuaw+EAhGxwKFgOBzeCFS7cUccsjK9e6y7Qsl7OpZnINM03sgLH8xXvtDLJesjh4dFV9VDpjWkItRDLlwDDNwYZnnDCJDFkf6ElobNGyLo41MD2yp0n8rccRo5dciAanOXPunQmrifxk48OEQvgEMCSlc126Eow5F9KGq4X15hh7hcvLi8eQkSryxduWXz1btKUYOS15x6et1e7k+pKZOmqTX7NsoL2QNBeG6UCwi9HYpCMMBkRioK3w1hwzEpeALUXAjj4hnodK+qwJ7PTLk/j5nf+cOP+4gXAPk0bq/U7KX9kOGNV4N22KXDORNAx+TFipzjc7ZWLt6Cxg+ERmKhuxV/+78bJI3h4s8neU9AYHLj1D8OmDXuws5rLF3KaGC3oFTVT6TmNnkZMirAhfwZp49nApEQTPWI3KtTDCgl5ebBmQ9GZRZOfzz0BfH/XCr5R1X6p4YRimrt48OmWizOLMM0v+6UMWEAwixbe8CnONdyanK2iq5xWzJmHLouZ/r/Mg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8f8780-4ed8-4c0b-fc11-08db4596df2f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:49.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ujusue6qwXfe72NXNjKIlRucHkFi5jA7UXaPmdMdnTGksPUB1NL42su4Fi91GQ1ZslyYuIX1th22ljjA+sMhtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: YCXe04Qa-LOInenH3wgc7AjEM7OMjHEf
X-Proofpoint-ORIG-GUID: YCXe04Qa-LOInenH3wgc7AjEM7OMjHEf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_store_prealloc() should never fail, but if it does due to internal
tree issues then get as much debug information as possible prior to
crashing the kernel.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b8b8e5d9ed7e5..28853ed23fe8a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5762,7 +5762,7 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 	mas_wr_store_setup(&wr_mas);
 	trace_ma_write(__func__, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
-	BUG_ON(mas_is_err(mas));
+	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
 	mas_destroy(mas);
 }
 EXPORT_SYMBOL_GPL(mas_store_prealloc);
-- 
2.39.2

