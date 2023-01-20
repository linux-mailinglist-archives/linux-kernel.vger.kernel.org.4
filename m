Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92F5675CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjATSpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjATSpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:45:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADACE5590
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:45:03 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBggS011434;
        Fri, 20 Jan 2023 16:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=yzRCK8lB1VXL4jFBXek0Jo49vbE0RIMVOuZES8MqPCk=;
 b=akBdDFE0EyCEMmc9b82NgQK4mFB44JriolKjcP1Peqe1T5NagTw+V1Pw4v2U0YWD9CY1
 HRyIEaT5cuutireZEkYGwIxY5U88hlKqriGa5tgkXRLiaXvb90XGP1pE+/+IxdbOR0Q1
 sbEdqfeQzGJwcZvr2Ua07BV6/UChBeey/09Uw5Ug69c72qBU0PbSNnDhqcJWJylD1uJ8
 OLLkbavfNDi8ttCNF3T+HDBZqCwmtc3YJmg6qWqE8f2EmKQNEbvJsGgXAhsjpZKXDNMZ
 ct+vKt7T8NdvIoh8wYDNEP+voSnyqeTHfUHExpQcLCo/bYAlV1lViJxqiKLLyJrV6KMi Ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895aqtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFKRdk004601;
        Fri, 20 Jan 2023 16:29:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1hj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvhyYUjWP5WTIwn2hQi/DZ9jsRUEhCqOCzjDKnucwPYKbFW0O/XfM7BLXGR4CxuoXdMEymItMl7EVqmo71Jp3fwTkpQFezZyGz3gd3Ma5Zoid96PBX6p/kxHGjwILAWYC60po24tS3WgqIH4MmujXdZeYUYmkZnoUqOeSdpYLZEyuLUBszYwTjhXSSAK2oOV2nwLgB5w0I1DRDF2lNukj/nSb/k5jljwd8+5axjU69qoRwe/6TTJghCTVs14N0LmbEuuQgcB+kCTYLBJNmaJ4Ge5hjoftEc8lMT2KQv7D0RjejbCBkzl9rnrAbvzBFTJBQPdkGpPvTR+HLRbZTvj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzRCK8lB1VXL4jFBXek0Jo49vbE0RIMVOuZES8MqPCk=;
 b=CTQ5H4qisnxiIT1aZNPwjVWTr28Gtoq6S+p6tZJwpS8KJNSYBsdfiqzMbwNJNnZ3mNh5tVh2oQfDYxoKSkJ4eA5/I2vSGPGOVsC/az2FM4z3Ue1r/BttuojFCQX+7TtHGpItldQrZz07H8TUqzOE5KS0OY0FJTWmIcqR4aAJHqIKulG0Ed8UhsPY6J+qJ0wPH6WGEKloYim7p0HJ75fhAlTZoZfeDr0zDlcwACkfzpk7MCCa0I2l9bKGSEe+H0q4Cu0iudqYZSIzEG9u/edL+ljeSYtDuoLqkNrKJtuS1i0J5Nk4zofsVjRh5jnspMkPZyDjFOYBI/E66FsJHzPYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzRCK8lB1VXL4jFBXek0Jo49vbE0RIMVOuZES8MqPCk=;
 b=BagWt6YzuRE3+yofVpO/kDkRf5ssFRD3+parCLDVBUOX5dc8UlCfknBouAWYIOs5OT7wufQVHerG16DFlQthN7HpEuutpA0+cO3YcKdJoRD8sOFy8cfqRQB7r5GcXguTeJ26E3NuTl7lGsTdPJACvT9QLtWXFohRZi/l7LOu5jY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB6400.namprd10.prod.outlook.com (2603:10b6:a03:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Fri, 20 Jan
 2023 16:29:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:29:10 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 46/49] mm/mmap: Introduce dup_vma_anon() helper
Date:   Fri, 20 Jan 2023 11:26:47 -0500
Message-Id: <20230120162650.984577-47-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: e83a333b-891b-47a0-d314-08dafb0375b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4oTl2tw1M6w5b2PMCJEdedrcGBBOzN9s7pceZgD67HeVOGlEF9nM/nvm8nn9ZtxnsPd9NKZp2GF5e+i/N2DZLJjEKsW9meDCqbnhFbMmUlH4qZWSt5mitkYQrVdq4/u1Y+/JLZJO54B0kTlQjtXy14yX04eoV3WkTjPPadCPdEYYeM/NUAuKBlvhGxGwYKVQV4eQ5IxgvhTUMi2f15G5+XtcFPBqPk+tMBHoU8YOULDzpPXVb5sYDdK9YC+16Y9G3nNApogCUcwq00Dtz4U7j1I1e+nRMnq1OBmVLdpN+1U/OtWdNgFgl+9wpHztzHUCAlDDOkGGGpRLtsrsV+nCne8Rw5tAlcGRZnrCn117IjTFhHdWTOdizw7dIAtpYvQd2BeAzPH09eUt+9Iredt8L9ac1kZm4HjK2y365VkvjZ0+QLDiiz4LMwZUojvZLV7RR7lT89x3syIzk5xeDz1GSURZOcbM9rsXQn/NXenTU99htf0dbStnHZmHN2TXeLdzEAxkPKbE4T2MeMe7rkhjcBUGdFx5arjyuhVNb9I2vnPzoMiwYqlSb1hLCbVib4hw/6IBjDj5IrKy73y7wkeVSAVTC12A+T5NMLWTVt37PF0WklnDmOgioKOYUFhR4mIRq+7RdUiS2qPQHRpPgvwfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(316002)(54906003)(83380400001)(2616005)(1076003)(2906002)(66476007)(26005)(6512007)(186003)(6666004)(107886003)(4326008)(8676002)(66556008)(86362001)(6506007)(36756003)(66946007)(8936002)(6486002)(38100700002)(478600001)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1+eDQEfyeHozBst6tof9LBMTu2vP7Zr1vfotaHWjKMoJ0/fWTNZPZUxgmwUJ?=
 =?us-ascii?Q?NQ5bZ8xGlNHjBeRiFpY6uMdSM4O4bTPpudTuyrDVPZhmLfdagqHAtA40tN7g?=
 =?us-ascii?Q?9vUWzBhoTfivxaSyL4tbpJVA2jK8wnWyopQokrUNiRn5OZLeaEcBPxF6knQv?=
 =?us-ascii?Q?H60alFnj2I/b634ZqfnjorZ3iShPHyPebQq2d2G3GEYX6ECkpT6HcbHctU97?=
 =?us-ascii?Q?CiNyxd24aBgVfvb3TvD3eifIfCHbZPI5kUE/VGrLiGxb0ONOW/aMsiEIlp7u?=
 =?us-ascii?Q?gmBRUFZ7SCiYMdvrUdh6ai2wd/e5OSGWiUmIje+VyISBq6b2rWGF1pgGlajC?=
 =?us-ascii?Q?zNPfvq2GBLCtcIUFpZSlYuf+yTzDmm724bDxT2mxouNxQjnPLJJlJSdMhhOe?=
 =?us-ascii?Q?0SVGXz6XvmhS5EeNLHxXqtf5TR2QydU7ib9Rpj6UVA9ZBAfCLjfNpW8Y8s0g?=
 =?us-ascii?Q?fhtr44myZVATYSEIJsVskM079ui5vuPRhjuU4nxmewCmLUfYKs7GyKlVLyz9?=
 =?us-ascii?Q?ad1+9REBHQSxaIo4dv+WUb2wCPwdyPAIEWeAbx1AZOEO+TKxsvvxt4Xnfs03?=
 =?us-ascii?Q?XE7Wm2NDBQye1LXRbzUXCOyBFMpWPDEXv+cGZWjF/dGzsGRro6FYdDzb8wFc?=
 =?us-ascii?Q?U8aDpEtVvmHHZW+pHW65vnNVTCcXUiSwLfafHSVH5UE+BNZogbtrkOtlKPiF?=
 =?us-ascii?Q?26D/iAOrYApRk0okUsWzCPtTrrKeNl4LRdo0Xz+nnor2Z6Pyb4+d0qDV865+?=
 =?us-ascii?Q?+I5tQ9lQvyw9UwAhZf5MKbzZ2mD6LcHyEaFNKTUi6tSOuCpKdPtisvOUNdOh?=
 =?us-ascii?Q?Oi/1T/0NhRn/Maz7zn1tMiJL6xtBrijJeL1WRrTilsnmW3E49iaG05GNyP0U?=
 =?us-ascii?Q?2RySE1vy5rVzpLo3uFz0xhJnCOZ72Omyzjx2sNOhZ5FCK1NqnhxH2bPPP0xW?=
 =?us-ascii?Q?Ab/U4/UcWnQh4ieMh9fxddsnTdr5XAJUsNsC7JLLZ+T2nTPDpMfDc3Ctfm2H?=
 =?us-ascii?Q?OrsHmBhcxH/cQhVmiifekngwx3ohB/lGFsy/SUxPb6emYyI9n9ZT+oSI51Uo?=
 =?us-ascii?Q?oejgf9GX/H9FjoWCqH3r5ltwTy2NteryZQK9WeL7mZOiR8ByS+BAtbXcwYbg?=
 =?us-ascii?Q?uWTlGfD1db741sXrkU1A+LfN2XqgxG5bxBVjb127jdmWZAozaWlhaSB+1073?=
 =?us-ascii?Q?clpIqrBkpDw9G+qLOVxgwFsVYXHK0MRfBG/8ppqHHOnH29/6hHeRbc+a7r5O?=
 =?us-ascii?Q?EOGlFv1LX1Bzo1OlyjOG8RTgsyto1G44nU9Ix3JgHb/u6BujUVy2sBShU7rR?=
 =?us-ascii?Q?16yKmUThlIkSO29QEEgUtpX0wdTY8H3luBoCp5U5CQZ3SDDrTnE9TjqoJLSt?=
 =?us-ascii?Q?fYD9NwGSO9mLIMURAi0YQEOfzc7TMUlZpigO0CudiZVKcPP4Bllr0Qly0hrm?=
 =?us-ascii?Q?7jyjzAhF7PMvUPzYj5Vu0kQzlV/Bk3TJqOn1AQBIQenfi4JiXPGGfZShw11P?=
 =?us-ascii?Q?1UEMifzaFnMnEMAe0HyqxycMNDuYpTbdL89teBGWYW1g3G2lDLwIriNnXm2B?=
 =?us-ascii?Q?uSWWq8O+yYzMfbxS2OGNw7fu0FCDb1PRGM8wF0VIw1hfhjAij2IVNMvCP5ws?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 30W9Bla8auDSjKcB/Ld96PueVTEZpXVASfw3rzss19lumLw7A4+yP43LSzv7MYjBbM8EPuHZY/TVTD15md3zhivxAi2Rg/oLpleDHlJYPOBE2w7Mh8sbmC2YqR1K6gxzntCBV0e8m5j8816xKpVLO8WV3ZF98FsJZ/F9tS78wbOJgQ6qy7s4Q/XJe7fNWfxOerqZCElFNZMgQATG/AlqEzb9cCAHLMBZM1RRj+3ju1EUncPTTTohOk4te6SZwU+CT3jrqdnAwJpDiMO+36yu0E/6Gr7U2PsR7uLCTZE7Pe7D1VyTOD9ue/0l9WRAZptcu4lwVnvk7Jr/ooyq3NIbWY6WtuC0xYwLOQKoU5kwshKc+VlfZ3ksvVBEXeuP/Yic+4UMXIJCeJmfOfm3iWE1/AxF7bF20mpZSW0yRFB4RvaB6KytegDLlFkZ2qItXwu6ULEJ6ZUTHppCklE5puPDeNe4NP6Iw1Qzs/6fLBHBsNTl4ZrIaG8cXsGgER8oL5fm7iAjPaaMKIcVKBRtw9eo8WqUcbSaWG8Z1zuIV6voW5PZq5PdGLcTLlIvfLlwjw4bUHCXBK4B3O8aR1gS8yzsjCnf3juAYhEu0sczhlJbJ+ehrJaXdCgqY8kwseBZihHiGwwHLIpySTMydLwCE2lHzgbylVB9UKoI1TGXb96btOtfjeJrA79Uj4FFok17nxIrO7AQ2Jaeud8o/k7JQ0PVjcnaTn+O/3C7q69zat33vDAcMTebLxPGThZ7Fp+Ml0bN/Q9/ay5rwSgHpheDQc+iT4KVHwoKEeOuV57/T7Knu5LUUD0yc4UdkBG4uoiVENFpzRP5d9gTzC0lMWrsqAn5x4nisiIjyPw0eMWB7atk5qndhYYn+QVo8746VMpR4t8ifKIxbZuypzCmU6bnVBWtMw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83a333b-891b-47a0-d314-08dafb0375b4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:29:10.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BajcjBk5L2gJqLH/Oxz6C/i9qjkQoY94CbmBl1eda1Gp1CKiFfyDJS3+LRqVkfRloN5NPdoZE8t/g61mMQ92Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: 5j2vBZ0C55qN96grw7sN7D4qdjJEavul
X-Proofpoint-GUID: 5j2vBZ0C55qN96grw7sN7D4qdjJEavul
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Create a helper for duplicating the anon vma when adjusting the vma.
This simplifies the logic of __vma_adjust().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 74 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index da58f428c5c0..0a2b19633174 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -620,6 +620,29 @@ static inline void vma_complete(struct vma_prepare *vp,
 		uprobe_mmap(vp->insert);
 }
 
+/*
+ * dup_anon_vma() - Helper function to duplicate anon_vma
+ * @dst: The destination VMA
+ * @src: The source VMA
+ *
+ * Returns: 0 on success.
+ */
+static inline int dup_anon_vma(struct vm_area_struct *dst,
+			       struct vm_area_struct *src)
+{
+	/*
+	 * Easily overlooked: when mprotect shifts the boundary, make sure the
+	 * expanding vma has anon_vma set if the shrinking vma had, to cover any
+	 * anon pages imported.
+	 */
+	if (src->anon_vma && !dst->anon_vma) {
+		dst->anon_vma = src->anon_vma;
+		return anon_vma_clone(dst, src);
+	}
+
+	return 0;
+}
+
 /*
  * vma_expand - Expand an existing VMA
  *
@@ -645,15 +668,12 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vma_prepare vp;
 
 	if (next && (vma != next) && (end == next->vm_end)) {
-		remove_next = true;
-		if (next->anon_vma && !vma->anon_vma) {
-			int error;
+		int ret;
 
-			vma->anon_vma = next->anon_vma;
-			error = anon_vma_clone(vma, next);
-			if (error)
-				return error;
-		}
+		remove_next = true;
+		ret = dup_anon_vma(vma, next);
+		if (ret)
+			return ret;
 	}
 
 	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
@@ -742,10 +762,11 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct file *file = vma->vm_file;
 	bool vma_changed = false;
 	long adjust_next = 0;
-	struct vm_area_struct *exporter = NULL, *importer = NULL;
 	struct vma_prepare vma_prep;
 
 	if (next) {
+		int error = 0;
+
 		if (end >= next->vm_end) {
 			/*
 			 * vma expands, overlapping all the next, and
@@ -780,15 +801,14 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 					   end != remove2->vm_end);
 			}
 
-			exporter = next;
-			importer = vma;
-
 			/*
 			 * If next doesn't have anon_vma, import from vma after
 			 * next, if the vma overlaps with it.
 			 */
-			if (remove2 != NULL && !next->anon_vma)
-				exporter = remove2;
+			if (remove != NULL && !next->anon_vma)
+				error = dup_anon_vma(vma, remove2);
+			else
+				error = dup_anon_vma(vma, remove);
 
 		} else if (end > next->vm_start) {
 			/*
@@ -796,9 +816,8 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * mprotect case 5 shifting the boundary up.
 			 */
 			adjust_next = (end - next->vm_start);
-			exporter = next;
-			importer = vma;
-			VM_WARN_ON(expand != importer);
+			VM_WARN_ON(expand != vma);
+			error = dup_anon_vma(vma, next);
 		} else if (end < vma->vm_end) {
 			/*
 			 * vma shrinks, and !insert tells it's not
@@ -806,24 +825,11 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * mprotect case 4 shifting the boundary down.
 			 */
 			adjust_next = -(vma->vm_end - end);
-			exporter = vma;
-			importer = next;
-			VM_WARN_ON(expand != importer);
-		}
-
-		/*
-		 * Easily overlooked: when mprotect shifts the boundary,
-		 * make sure the expanding vma has anon_vma set if the
-		 * shrinking vma had, to cover any anon pages imported.
-		 */
-		if (exporter && exporter->anon_vma && !importer->anon_vma) {
-			int error;
-
-			importer->anon_vma = exporter->anon_vma;
-			error = anon_vma_clone(importer, exporter);
-			if (error)
-				return error;
+			VM_WARN_ON(expand != next);
+			error = dup_anon_vma(next, vma);
 		}
+		if (error)
+			return error;
 	}
 
 	if (vma_iter_prealloc(vmi))
-- 
2.35.1

