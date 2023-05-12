Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED419700EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbjELSWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbjELSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:21:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D0DD2E6
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:26 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4khv023043;
        Fri, 12 May 2023 18:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=A/hWRGZ+r+UMcw2/v9TIxTDIJ+JR1dErT7KveUbbwtw=;
 b=XhdNmCprztNiPbOY22bYEt11AdWJidXr+P/4xvB9MVf5oHABG6XUENoVIVaxsTsuO9wH
 WHnVYSpQS2IYk2qtcTSQFAoO/OJo56bnb1jjeaoQrPjsi0j8ykzgpS3CtdwMB5PAM9BN
 By10ubKMPRXsAqlQXo2rxROeM+xoN6gvvFxHVU/GZCSvCrIwbYR76Hs//289xaXlahYx
 kbwXapp5fHsVgnchYoiq9I1Mq6jyrK6nHAxBvPsT7lkTxI8lh1A0dsQJam6VFs0puG3+
 ofzj9SLWkF3ibmyaC2zmClNLSZQoUl/ZC7D0TO6TJ8djtB5MCmc1EKVPAHJVP8Y/DLeH zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77gbq1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CH5evc018237;
        Fri, 12 May 2023 18:21:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77mjkgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nINz1+w7Fz81l3mBFUCKCkRaIAIQOZJTj+iRdI5O4Vi3EnD9XVVVs9PLiRoXWYex+aHJy1pk3KlHhBPx0unwxabGJFjFgA9HlCUB3X1fRZSE+e8K7o3J6pbtNwPuqBK1Df+Cbhbx8aSM44lzy8NPYNQCgzOXJ0H7x34JhE66w7yT3L9ARTFrJkbgaoYWOuZfAi0pLDqnL9Ml/6oLFM2TChJ0onyfnXAq0hh/FDo9m/u72b8P9JTwHbwHvWFudGwd5LqOGTYh9B8QfhVZSCvw3C6Xo5bGx/J4WVcFpnpIrQV+poOj3jrEl9X6sLFI3EQCfCGnH9AmYkBTJZYbbSCUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/hWRGZ+r+UMcw2/v9TIxTDIJ+JR1dErT7KveUbbwtw=;
 b=H+Qxvaarn8oja/xPBExlewsF9GVlK3wKUx18qS8rLbNCwkcsosZoQkP3c/bFDHreNQdg+aj7dFdtTPjac7HtQ2yX+iQw6zS2rnZTKd3RtNtDfp9LdphcxgNJsVy7LWWtTgsdbtrHzPtcueaAVey2TPbCs6yiyO9ag56e0GFmFKWbiWE2lwOkPlk1ecj1kcaDkWNYDjjUqew9Bzunj+HgmKZEQnHn96s5v3lhuYS/Qc2PW4NCHtgTJocxmemilFlfTwenKAEXqsIhOx/c8dy9TjrKCQHhoUC2aVinWTuiT+B8aG80J98sq2f3NUpnjqJjCUfiWjzdePZpclat8OdHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/hWRGZ+r+UMcw2/v9TIxTDIJ+JR1dErT7KveUbbwtw=;
 b=winjMvtxhbERkjYdEasM4gJXzMpqe0Y1Jq0u9w3XxHo6jVjRPwHRdnMY7BZleRU3d5PyfOt+GeUgbaXpIXYs8jnzFTL09lDVTplOhfDXgXVYzjxpOVWCGhMnK7XrgELLLKmNmZwt5S4f9fyllNyKda7Jbdt5PNbScyy1mpC9h04=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:13 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 09/35] maple_tree: Convert debug code to use MT_WARN_ON() and MAS_WARN_ON()
Date:   Fri, 12 May 2023 14:20:10 -0400
Message-Id: <20230512182036.359030-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8385dc-dca3-4afc-160e-08db5315ab62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5oYBhjlHT9Z761apDY9CkT1BchBEb/Ds+XngQZ207JZDtqHoJHORkznHEQsXZt9wwB7CXR5Vg5L1DVoG3D1Ue7tyV722Mcf9sNMXcXf4zIdUyHuC2miKrkH7nxASP9nm+Qqlwiue1KSccnXyZFrgchH6x4BT8Jx/j23jjYvYk/pzCYrPtnJDGiGKMOuNZhSiyYzK3bcCvww0zKMgV6gtq5IbzEnB+G/d3J2o4bkxaFLo/mtaR9Dt8jspEiSGEaMo5WuermrV7njSfVdzK2hu+qY6QjZGAiHXtKYMrFSlZDQYG57dZWb8Uw0JeLt5PSTL55xD+pOtMI/RwbLDynpgsS13eUGMmWh1h/lJ/gBrrVowitGMZnzBqSR2xoN6JJB+WE2JQWAzeVfUdxKXynXMSQswluSxL80unuXOf0DJVThhV+NvVnf5YH0VxiXk1zcKVUEevVsSguowWLkT/T5j+D8mPi4/1u6LiJA1uVPcyH+5lhxQmsH+7Ib6uC3D+M2EUFgG7EOB1Zl7xD+4JqpvKveGt4DqbAGJu+NUdQISRT3Cj3wlM3uiU1jftqyqUJV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(54906003)(1076003)(86362001)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NIJZfOQl3U3NRMWb0mvcVKVYLjLSu/6+xDMZeyiC3blzBV4cdrR4Wm5epoq0?=
 =?us-ascii?Q?hy8N1mLw9pnll0IUOCWQ+b2ThRTJBE0CjTbUc3dXZC9/ShdNJoGlgnCvn+iy?=
 =?us-ascii?Q?CMD6AfwgcZImrn/5ak2nuvPQn22//5moE8xyueFx56Jl8lGzE6IHLGSVijM3?=
 =?us-ascii?Q?V5qxXfJqzhQ31h+5mkUJ+41Lkp44ZVpuEx/PPpNikP/bkPKRdKzZhajpvv8n?=
 =?us-ascii?Q?GD/qrLdGlhLasANrPEmpe5prBH3cjaah6vEKvOFq2fAKB4z0A566mQVrZAJw?=
 =?us-ascii?Q?HfLnT3g4/VDEJoFKPbzFZdJUH511oJr+B/JzPfUz1vs9HSvdG2L1iKx4oMjR?=
 =?us-ascii?Q?mo0UVeC1l4E9fJ+KExmzT4NlwnAtjf5jfMjQvbzblvP08zzQCcbjXgon1nXV?=
 =?us-ascii?Q?WOX2uIZpAkBP1/Tgc/j7AnL3Yf+Br2Wz+8yhVU3iVYf/SSgb2WlUcdHWCI9e?=
 =?us-ascii?Q?x/Dqx87GeGNgHCOKkGUS6DHCmZYIIWkPdAOzaaNY7Nlx+cV4MeCmCEiieFSs?=
 =?us-ascii?Q?TbOrrZjyVVLrQ/x2+f3dSMhSMHwcKaZEyyX3UjWjLJpBWDKTsgvDPMxOGNcw?=
 =?us-ascii?Q?BIzfKEnhtSeutxky3M7pp1J1JUJiAoUuhl6LRyDLzw7WEqhSj9PA1NYI/ZJt?=
 =?us-ascii?Q?yBRHS195mZT6cccM0HeKK3Q49dWCHi8WIu30vCO7QaZ7vakDJ0A/3J9ByMAM?=
 =?us-ascii?Q?eGvO3CnVkeHnOEav7UefliUZmTgNESkox6cNbLBWAmnrP+724hkb+2iv1JVP?=
 =?us-ascii?Q?WhyA6jCXNm6D9Uud5syQnLZsMz1D/rOzGrgDCexv8KjcotL4t+XTkWNSJxRg?=
 =?us-ascii?Q?llz1aRpjJnfPT8RapZ3FdrsAp/H0kIEsznTLcUO2B+ZhfrQaPlGYrh/Oxg/X?=
 =?us-ascii?Q?h8YGCT+yLz/KLQR8jnppDysAar7lu/223ictDAzo2ugF0qiWo2vsCE3h+uV1?=
 =?us-ascii?Q?fD14FjNpH8qU6HJGjk0ZQiHD/45pQNDEDYoeL3HTHcln3Wn/hHce6m0RSVOj?=
 =?us-ascii?Q?iogX+rXQSi5wCUFh7FsJkZSAWExmInMP21Y8+2CK2PsIbRZZEjA33SWdbYgP?=
 =?us-ascii?Q?mprbkTrGWeLIftGEsuRgKgOAHVz/8yPkkaYdlQHy55cf/rs8Baco5CZRIRr9?=
 =?us-ascii?Q?CmYPGMHsZmdC7hfJwNyEAxARay48a2QOEavJEGtrbAXhv4glOrsPtbW/Sx0H?=
 =?us-ascii?Q?v2D1BFtp6SG/ftLV4PGm9gRlTOOPyBs1/kH6i/WXPjUaF1EQGlwjdE0/9vGG?=
 =?us-ascii?Q?P9TblcwBqZV5EWQF0KG5Xw6IZuSZxEL8iIvx6slNm53af5eaM3ZnlL7ghmRm?=
 =?us-ascii?Q?epfPNvlsAPqQJla4iYNu/2jcrTlzi1P55ZF2zwzeIVkeDEliE/FolaJLDzN0?=
 =?us-ascii?Q?UTsXBSQX8uAbkrhPVUsaT18+8TVtyBND+secnn2IAAIa0oe1e1uWUCLxTgJ6?=
 =?us-ascii?Q?MFuWTCAXdkjh0LL3GGVS2PIgK/G7DyCxyDZey/4zF8R3MBFrpF3/fvW4Lvd0?=
 =?us-ascii?Q?VWovdM+7TxcPfC14Vg0KqBJ1HdSrYk3lVZ6TKjLg3/E0yG5VMcEBUocw/6Yy?=
 =?us-ascii?Q?fykVmBkT7sZxqam/JFzwFdQ0KoI+XBF7dwFFbh2nd8LuH99pfxnLzo0wCbO3?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9Gu+QEPkRgjYpRywp7QhOjXCGEkdBB/dPQAHihRou2qUF7zODnGGP/+WhLomOajj4id3L9XkS0DHGu4/BHRgoykqiSSrB0LU79Xq9/gRTbTVXqtzqDUI0l+wIxjRO/jyaty9h1QCdVwbKDfnJ8kv9dkwx2wtK74e1/OThdL5Xqc2k5j2lHiGMGw8KxXUMZ7D1LkqH9VQmznhOpkLgOx6oNleht4bqht78q1JLiPeJipFNZzLh72HmZgTVRYLVSkXPtjN9BL8us3O8YcCs8eMVbyw6igobkGylW4OZewQt4HYcEJIYcbKoo4x+HwFl6iHEZhRXGzc+1m4wL1UI/oyKmOm/zsM21rCK7stcKuLrpMy5Ykd1iW+g7XxCI3osGkXPk408R1wsHupJvikdBD0WYPTgUb4evH/LMgPNehwkzTUh1NsbBY0SjkzY2imX+stFoHR5TJiBv+lvyNvx8SiuzXskf+koQAs0h34deoIb7XgZSP4/Abd33Gnp/+NLKdJl4jtucdeb8OdWehEUmRkCrE9yeT42KLqK8/qS4EeFEL7Smw0BamHkJ2XzHSLdv7Q7ZjBYau0W1LDPfzeZGWTTWKgC6nf1CGeNfOZNWuza+4nLhAkD+9YVHDZTKwTCHW72pVvoSVaWYgTag97kMZkqzQX//ru7fZI3OwmgjbHLz8EdqKudRq8f/CIRlvgTPigMAI2ioDtTPrHWj2wZ4uNZdmdqJuPaGHWgroCaFDscaXcXJflB/5pTQ9H2ydM7kx0PnQkohnkO6lw8itAkk0zLtzP/bZ3ui09nhxwHLALXeY4zqD20MVrn1q69ONY6Y8jL5yjz1ZaAlD9i/t+b+VdYTWqA+dPF4kn5DsNCTMRQrMlnFjk1svC4O2SAqO8O2d8jwTR2HQ7PcuP153VsPGKUg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8385dc-dca3-4afc-160e-08db5315ab62
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:13.8790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQ9o4o3INAtCaW8ujKhBVsFxzOW3V4uRpH4JEgCGcEDEd2J0aziC9T0rkVvlOCnmzGbb+HX4jSpMAEJrS9NKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: 4A_otSfq3BCvFwcrPSxyoZdN5gDbAVIc
X-Proofpoint-ORIG-GUID: 4A_otSfq3BCvFwcrPSxyoZdN5gDbAVIc
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

Using MT_WARN_ON() allows for the removal of if statements before
logging.  Using MAS_WARN_ON() will provide more information when issues
are encountered.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c3ce2bc594123..8fd83f21caf00 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5698,9 +5698,9 @@ void *mas_store(struct ma_state *mas, void *entry)
 
 	trace_ma_write(__func__, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
-	if (mas->index > mas->last)
+	if (MAS_WARN_ON(mas, mas->index > mas->last))
 		pr_err("Error %lX > %lX %p\n", mas->index, mas->last, entry);
-	MT_BUG_ON(mas->tree, mas->index > mas->last);
+
 	if (mas->index > mas->last) {
 		mas_set_err(mas, -EINVAL);
 		return NULL;
@@ -6529,10 +6529,9 @@ void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
 	if (likely(entry)) {
 		*index = mas.last + 1;
 #ifdef CONFIG_DEBUG_MAPLE_TREE
-		if ((*index) && (*index) <= copy)
+		if (MT_WARN_ON(mt, (*index) && ((*index) <= copy)))
 			pr_err("index not increased! %lx <= %lx\n",
 			       *index, copy);
-		MT_BUG_ON(mt, (*index) && ((*index) <= copy));
 #endif
 	}
 
@@ -6678,7 +6677,7 @@ static inline void *mas_first_entry(struct ma_state *mas, struct maple_node *mn,
 	max = mas->max;
 	mas->offset = 0;
 	while (likely(!ma_is_leaf(mt))) {
-		MT_BUG_ON(mas->tree, mte_dead_node(mas->node));
+		MAS_WARN_ON(mas, mte_dead_node(mas->node));
 		slots = ma_slots(mn, mt);
 		entry = mas_slot(mas, slots, 0);
 		pivots = ma_pivots(mn, mt);
@@ -6689,7 +6688,7 @@ static inline void *mas_first_entry(struct ma_state *mas, struct maple_node *mn,
 		mn = mas_mn(mas);
 		mt = mte_node_type(mas->node);
 	}
-	MT_BUG_ON(mas->tree, mte_dead_node(mas->node));
+	MAS_WARN_ON(mas, mte_dead_node(mas->node));
 
 	mas->max = max;
 	slots = ma_slots(mn, mt);
@@ -7133,18 +7132,18 @@ static void mas_validate_limits(struct ma_state *mas)
 		if (prev_piv > piv) {
 			pr_err("%p[%u] piv %lu < prev_piv %lu\n",
 				mas_mn(mas), i, piv, prev_piv);
-			MT_BUG_ON(mas->tree, piv < prev_piv);
+			MAS_WARN_ON(mas, piv < prev_piv);
 		}
 
 		if (piv < mas->min) {
 			pr_err("%p[%u] %lu < %lu\n", mas_mn(mas), i,
 				piv, mas->min);
-			MT_BUG_ON(mas->tree, piv < mas->min);
+			MAS_WARN_ON(mas, piv < mas->min);
 		}
 		if (piv > mas->max) {
 			pr_err("%p[%u] %lu > %lu\n", mas_mn(mas), i,
 				piv, mas->max);
-			MT_BUG_ON(mas->tree, piv > mas->max);
+			MAS_WARN_ON(mas, piv > mas->max);
 		}
 		prev_piv = piv;
 		if (piv == mas->max)
@@ -7167,7 +7166,7 @@ static void mas_validate_limits(struct ma_state *mas)
 
 			pr_err("%p[%u] should not have piv %lu\n",
 			       mas_mn(mas), i, piv);
-			MT_BUG_ON(mas->tree, i < mt_pivots[type] - 1);
+			MAS_WARN_ON(mas, i < mt_pivots[type] - 1);
 		}
 	}
 }
@@ -7226,16 +7225,15 @@ void mt_validate(struct maple_tree *mt)
 
 	mas_first_entry(&mas, mas_mn(&mas), ULONG_MAX, mte_node_type(mas.node));
 	while (!mas_is_none(&mas)) {
-		MT_BUG_ON(mas.tree, mte_dead_node(mas.node));
+		MAS_WARN_ON(&mas, mte_dead_node(mas.node));
 		if (!mte_is_root(mas.node)) {
 			end = mas_data_end(&mas);
-			if ((end < mt_min_slot_count(mas.node)) &&
-			    (mas.max != ULONG_MAX)) {
+			if (MAS_WARN_ON(&mas,
+					(end < mt_min_slot_count(mas.node)) &&
+					(mas.max != ULONG_MAX))) {
 				pr_err("Invalid size %u of %p\n", end,
-				mas_mn(&mas));
-				MT_BUG_ON(mas.tree, 1);
+				       mas_mn(&mas));
 			}
-
 		}
 		mas_validate_parent_slot(&mas);
 		mas_validate_child_slot(&mas);
-- 
2.39.2

