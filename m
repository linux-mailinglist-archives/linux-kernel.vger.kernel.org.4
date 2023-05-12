Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8C701000
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjELUya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbjELUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:54:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE0B2738
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:54:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4knv023066;
        Fri, 12 May 2023 18:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3YIlBAFzfGCQ5M2VHn0qgaBT5Vs2S2TInPApujgd1e4=;
 b=HYnCAy6xw6XMvlFAc13PDRlmvCVyN5wvF+lASVn25NdL9BbZaDOwqv/MRzb/d2dpTNia
 Dd6Xie7LJ85uyFLOBNJoDYWmH7EpqXSk19r8DBQFY2iATJWXSsiAv2mrEAghwFUYykRG
 TWECXrTIMWVx50JTnYk8D2JKoScfGLKuiaKoTE3wEW6h59ci6DgExLMymbDgPWLr8pfx
 VQblRA1xlpRr7mT+TDg8CpCyEWCszx0uiAeseZmtXQxUykLnDLBUkiqjthGwrKfafx+g
 Dr6pj7+NdNY+zfIM5M0tsbf8VZzlFsrRn1OTMX67dmFURTPcSnpl/67A70vAzvQ4lUsC yQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77gbq39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHnCYu011668;
        Fri, 12 May 2023 18:21:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf815700r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjNBU4o2XLu6a8L4EBRJ9y6RZCtUz7Wiw59OAh4ldQacYWEH9sC0MXwvWdPAdo+QntXwF9cUfi44L0xtv8P9DyrP1g27zpXtJ1TfXM3TiXfqpGNmOQiCLSSx9XWj+Qb0vh9clm3E5g43VnyLIExwC0Ex9zKv9tP1/JbJQ0ir6DNgOQdFXGHNl23MYpyZUxOHuJKAOS4YVwtBKnQZJqS5QHH6ZajN8RWR/fj9EdHwBs2A1IeXBUqvh/ycq0hFlRsr+Lm2Sv3N7we/zc+SbdwXroAKDELl5AGQrqhffTj22F5x3DdzY3AkFytvF5uOY5CCKVwFg2vpJ4jXCKd/XfVvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YIlBAFzfGCQ5M2VHn0qgaBT5Vs2S2TInPApujgd1e4=;
 b=DxBJDQpbbCaz/zFLoOF6tkJCvCdT+OWNGpIS4ZG6axmNN3ImrgpBcu0/yK3ZXFPmuN8T0Tm8osRU2Y4/mYE5Td3+jqhdE6QWVkUsycSMbysiiMfsSG6/SyamYgS0oXMI8tAN5AK0CU280B2xlW279PkD7IFFpMsLH7wZ4CPkrUOrK4umwgCqvUN7aUIRh95k1sSuAzEdq9YrefE9nQp/ITDJC94erve25qmRZizprmGWyJVC0H2v7kDXaveL0zIuao7zLItp8+nhX+6m5IFa8nWQdpu7CTltSoLe+dYvJXBufMZO6j0wevq8IzBBOpEWhrHnwLLWerusZAl9P+jM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YIlBAFzfGCQ5M2VHn0qgaBT5Vs2S2TInPApujgd1e4=;
 b=CwyS2FgBTYsmDoWA/yy/ZcPd2KGYSc9VeGDTOfAvxb/FH32ZSBfbG1o9JqUYJExIptkDIaWt/+Y6Co//9MbBRAxuTEmYbYWEVtA9R4ysUDqGwvNsoA7MQ9xqh1y6eLK6zzq34sLtdsYkUBnE8WEQHPuM7jUXOOS3HObMTmrrt8U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:21:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:49 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 23/35] maple_tree: Try harder to keep active node after mas_next()
Date:   Fri, 12 May 2023 14:20:24 -0400
Message-Id: <20230512182036.359030-24-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef86968-e9ac-406a-207f-08db5315c094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrj7KS5gg6U22Q7F0TNNa/5Rz6sJ9xTmQZbaH4Ha3+H49CQnJMm4mY0acTywaYeO6qi3qrEK+VGMa6tziSo1syNRCf1r7GRQfLs5XASPVn0sNWtDzE/n5jOrC0MTHb2qyhBMMDU/uvPl2iXZfw+9IYaYnbpdMuOT3bUnFdIjp1vGfhvoDSAhxwSN5MfldAThMhvDbdPI4rL28gqzn3gNo7Fs4Z9eIcHNE+9jwlvquB0JwYx7+ehq2zw62aFgAzJ27oIsaGkGj7kjq9QxXzLt2M5iOStgj6p2HWBghTZLmVB9ApSX7N/xcFiZ+cArZSYhDPJIY4FdrjXpgN61jE8TVxVM2ynOvN60Lx1n69kcfqp40ab6mEH8aF2zcHJwAePyCRF6P1E3suV4rNvt1aSTgyqNGaImx15WIiGtwbntDgPi77adfrwy5V7Y0HqcfboZ59745SmHtATQlbTBLn0Xx55TQFNygrD9Kp51L9Ou6FYsD+vSwHMnbJejYiMhO0omu3YfWUo2Uxa0//SSeP92+1soHhzP2hVpCVnyYS8rnDaHFuc/QDB6lGtz6zRHzBS7ZUxQWibiI7jm6rLM2q0nFbZ6tbVfmX6C9E0qvUgY/ouOezTIgH8hkMdvrc+kyTorKKdG2FTp/XK/dZ8Cy1NwTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(6916009)(66946007)(83380400001)(5660300002)(6486002)(316002)(107886003)(6666004)(86362001)(41300700001)(34023003)(148693002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zceNuZX/tdKXIpwWQXn6Wup9zrYAsUVGPaVCYaEONN/EgFGAMZ1Do0K03sqp?=
 =?us-ascii?Q?nC4eWecG5AFAUqJAbi92XHX72d5nORzhRUcY7agCzAKOq/Ye7vdsSt+R6qJK?=
 =?us-ascii?Q?odukV9BjLlo5t1EeZ9OuidlFiL8d4jPAwOcbaaS4ChnCH6KxcwqeMiKUJGlr?=
 =?us-ascii?Q?UoclgP/bpLyUIMYuKBrlGa2MRELMApNhmrfVZZMLOdXmXdAiDNYxKnm2N/pF?=
 =?us-ascii?Q?anrpwS8tKWZX/bx//rAm7nzVnY/0S+kgfI7gXPJW1dbQfV7PixDfpM4+9uYd?=
 =?us-ascii?Q?OHEaMWsM0Uy6K6EYxWLvVOefvSlD3frDETC6scnp7z6GYN8etCAZDx0FeZHJ?=
 =?us-ascii?Q?qJDFr/7NU7XIolDEwIRnlY6tAzVTcLUjRltrZURpvj78qPd9wZ5g77KpDT4A?=
 =?us-ascii?Q?YbYB/1bs70K5kFQf7lil6VPa4xWsHy28MYGU925HJqG2ookyaZPEs10t5zZK?=
 =?us-ascii?Q?zn86uX9/Xt6QlV+Fqzg212K+0AHUnEexkfxEyMH90ag7xuTcjkcVrFy2Mx2C?=
 =?us-ascii?Q?oWig/FzxovX6Pv2roI5gSNblwEIhN/Qy3PMPNNNQ8P8Jx9rlrO8TJkZbt/Qz?=
 =?us-ascii?Q?io9mfNPhHv82rXCAptQgJTjgUTXKdUk7aO2NZcyTD9UiZd7Uuw8eAQItyI9S?=
 =?us-ascii?Q?mck6jjNP+46nsYW3o7rPH6XfsJ3JKplJMzlwUwhfIR+b8C6SRJZfeRaF7R3c?=
 =?us-ascii?Q?ydr0zDtBLmaO3UuLqSSUyLkhNr023OqV/bgxbTCg2zR6AgGHsuZbjvvrR/18?=
 =?us-ascii?Q?2mS4KRk9dFNujLkZibuw48Ok9cZyXG58ehRKjqL5C23AnaqB8k3lCJ+StFim?=
 =?us-ascii?Q?9VWrMv4x3hM3s98C2lb3jcGsyUWXM8DHBNqigvmy3Y1glgt5P+VUnOrhnkx0?=
 =?us-ascii?Q?nYtqdRA3HMTpCduwCta3M61vt5OelemhqNZtEOEevzvRJuVNMQ9JBYpPgzLZ?=
 =?us-ascii?Q?9EjECfueT99O9ePN0eCM0HLN5HGj7hWBiSEsGfpvh1/3X2ynKfPfDg5grQIp?=
 =?us-ascii?Q?vk7YqhDu56ppi2iCy47PD2CvNigdsJSoThVQ1hYyQHVV/XJkNouGLzemIh5F?=
 =?us-ascii?Q?EptzFFsIg30uPYQu6kWbenRG9CMfTJr5lmyIgLAfAwc2nFz7d4M2YIfDv48c?=
 =?us-ascii?Q?3th4L2DV/m00GcjZO7nVGg4gUZt3PY6SBxKUCmRakGzMhvtx89t7Y08A/lst?=
 =?us-ascii?Q?ryTCqiq3CGB3DUS/rB5t9D2LixyZJifj9ZaSGGzYnjJx+9NXjerkLOkpJFrV?=
 =?us-ascii?Q?v3Sw7vPKRUHCADXoXotFP03tfsValXG7QUxRzY39EflwK9sv58fdYg2i79G1?=
 =?us-ascii?Q?+q3GGFgZm6q1pm1LC11GrFME5oQahQJcp+sOweEOWCduS7Zy4r68taNZh+2B?=
 =?us-ascii?Q?1p2o6U7LfWXO4eOFkDrOeErT7RPEixOMhMRRvaoZ532ANDy3dhhOoNOwkz9X?=
 =?us-ascii?Q?3R6kXBCqfZ0/UNJ7xEZG/i/8N9dJ/mwOZalTa9I5565l9KDrPIjRiyqf5Zfw?=
 =?us-ascii?Q?zCzbuoB68tUUQlAAbtMsZBmUghqZWUBkn/WCxKuD+vL0PFWOu3fzrXBRAPrz?=
 =?us-ascii?Q?YlW6J/DPmznup+fQSRySTRRuwvDTzJEU/Ai8r30gOzdP+OXXfKwSEXw9ownD?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e4fFV0upExBfoB1ckU73+6rNphfFiTGg56YtzekMmzbjrsDUDTNh6LQ+Xsy6kbkBfn70x4p5PoviflQ8oLZQiX6NjJcK3Em4Ob5fU3eLCs2h2rsTxlRfycoLCgw/300wDS8omG1KdWfCgEenRHh6acMgBpQn3dROkQE4hIhftkWvywIwggClv0NMaaK8Qpv8ZW2USd6WYgwDQQifZmOGb6LhKjM63WZ9Shtz6ktr3LTo8M3pVzJD1B6/xzwHjWynEdrz20Ng7qKIb48FOakBX0e4/F5TEyn1YklpMu/hrchMqeCbnic4kmD6S21o5e4lsVOB8qVGzeGo8aBWPD/MDofWPziWS6tD7tIPOmH/wOCTKUtTjELou2V87xQBqahrkhHuG9UEbgHMveNLbnveYpH6dHj7Yx5/xnnopAnzsf2pCRpr9WLJrMrO9W2CN5mSAauxDJggw0Dov1p8ERcM62LytoyddmuXJwRYwuKbzmxFHYbpxXtCExUpqsIfT6baRL3ubJkt4ABo5guoFEDpUZK9nYFBjrD68Tn0lXCf3g6y05/ZKkmG2Rhknhmvzc/w1mqcVKHgUc0KCDDaLEtKH0YDbrBgMiCl6t5+bu3yJniGjSI1jleKTw78xpjjzyb9AuEiugxw2SjSSxZ/0XLuWbl1qDEfd7HGEl+gK+rCgA4/snx2sli8e0gcyn9z3qJnakYyV+H8glwcS+6nYkhw8b+XlmBXlXt3Xt75KI8Un1mNuqL4PIKJkIS5WtxLfSW+R6CqpHeppRyIZBLnjsJTFIT4+l+myBs2JGxZ/ca97osu7sDVWPNs8tp1eBF1twA/6qZJhvRibaUWZxhyi7EqHgMrSLkaH0xurPtHHMgGo4I+bJd+hk5PSFRoxR0qybG4Flf89RzhBG9r5UH/lF7XrA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef86968-e9ac-406a-207f-08db5315c094
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:49.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ejo6fmRijm0fzGVuBWiA8MifLBuiG6nmXr7GXaTSRvQyRS4CdphmFzI9lNGT6gy02IGor8zQw5HWq6Mm7xOig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: y86mGncaSUL0_gSnKgVtwzje2rfbvAwU
X-Proofpoint-ORIG-GUID: y86mGncaSUL0_gSnKgVtwzje2rfbvAwU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the mas_next() call to try and keep a node reference when
possible.  This will avoid re-walking the tree in most cases.

Also clean up the single entry tree handling to ensure index/last are
consistent with what one would expect. (returning NULL with limit of
1-oo).

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 89 +++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e233f41ed4da2..09142af082148 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4726,33 +4726,25 @@ static inline void *mas_next_nentry(struct ma_state *mas,
 		if (ma_dead_node(node))
 			return NULL;
 
+		mas->last = pivot;
 		if (entry)
-			goto found;
+			return entry;
 
 		if (pivot >= max)
 			return NULL;
 
+		if (pivot >= mas->max)
+			return NULL;
+
 		mas->index = pivot + 1;
 		mas->offset++;
 	}
 
-	if (mas->index > mas->max) {
-		mas->index = mas->last;
-		return NULL;
-	}
-
-	pivot = mas_safe_pivot(mas, pivots, mas->offset, type);
+	pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
 	entry = mas_slot(mas, slots, mas->offset);
 	if (ma_dead_node(node))
 		return NULL;
 
-	if (!pivot)
-		return NULL;
-
-	if (!entry)
-		return NULL;
-
-found:
 	mas->last = pivot;
 	return entry;
 }
@@ -4781,21 +4773,15 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
 	void *entry = NULL;
-	struct maple_enode *prev_node;
 	struct maple_node *node;
-	unsigned char offset;
 	unsigned long last;
 	enum maple_type mt;
 
-	if (mas->index > limit) {
-		mas->index = mas->last = limit;
-		mas_pause(mas);
+	if (mas->last >= limit)
 		return NULL;
-	}
+
 	last = mas->last;
 retry:
-	offset = mas->offset;
-	prev_node = mas->node;
 	node = mas_mn(mas);
 	mt = mte_node_type(mas->node);
 	mas->offset++;
@@ -4814,12 +4800,10 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 		if (likely(entry))
 			return entry;
 
-		if (unlikely((mas->index > limit)))
-			break;
+		if (unlikely((mas->last >= limit)))
+			return NULL;
 
 next_node:
-		prev_node = mas->node;
-		offset = mas->offset;
 		if (unlikely(mas_next_node(mas, node, limit))) {
 			mas_rewalk(mas, last);
 			goto retry;
@@ -4829,9 +4813,6 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 		mt = mte_node_type(mas->node);
 	}
 
-	mas->index = mas->last = limit;
-	mas->offset = offset;
-	mas->node = prev_node;
 	return NULL;
 }
 
@@ -5919,6 +5900,8 @@ EXPORT_SYMBOL_GPL(mas_expected_entries);
  */
 void *mas_next(struct ma_state *mas, unsigned long max)
 {
+	bool was_none = mas_is_none(mas);
+
 	if (mas_is_none(mas) || mas_is_paused(mas))
 		mas->node = MAS_START;
 
@@ -5926,16 +5909,16 @@ void *mas_next(struct ma_state *mas, unsigned long max)
 		mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
 
 	if (mas_is_ptr(mas)) {
-		if (!mas->index) {
-			mas->index = 1;
-			mas->last = ULONG_MAX;
+		if (was_none && mas->index == 0) {
+			mas->index = mas->last = 0;
+			return mas_root(mas);
 		}
+		mas->index = 1;
+		mas->last = ULONG_MAX;
+		mas->node = MAS_NONE;
 		return NULL;
 	}
 
-	if (mas->last == ULONG_MAX)
-		return NULL;
-
 	/* Retries on dead nodes handled by mas_next_entry */
 	return mas_next_entry(mas, max);
 }
@@ -6059,17 +6042,25 @@ EXPORT_SYMBOL_GPL(mas_pause);
  */
 void *mas_find(struct ma_state *mas, unsigned long max)
 {
+	if (unlikely(mas_is_none(mas))) {
+		if (unlikely(mas->last >= max))
+			return NULL;
+
+		mas->index = mas->last;
+		mas->node = MAS_START;
+	}
+
 	if (unlikely(mas_is_paused(mas))) {
-		if (unlikely(mas->last == ULONG_MAX)) {
-			mas->node = MAS_NONE;
+		if (unlikely(mas->last >= max))
 			return NULL;
-		}
+
 		mas->node = MAS_START;
 		mas->index = ++mas->last;
 	}
 
-	if (unlikely(mas_is_none(mas)))
-		mas->node = MAS_START;
+
+	if (unlikely(mas_is_ptr(mas)))
+		goto ptr_out_of_range;
 
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
@@ -6081,13 +6072,27 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 		entry = mas_walk(mas);
 		if (entry)
 			return entry;
+
 	}
 
-	if (unlikely(!mas_searchable(mas)))
+	if (unlikely(!mas_searchable(mas))) {
+		if (unlikely(mas_is_ptr(mas)))
+			goto ptr_out_of_range;
+
+		return NULL;
+	}
+
+	if (mas->index == max)
 		return NULL;
 
 	/* Retries on dead nodes handled by mas_next_entry */
 	return mas_next_entry(mas, max);
+
+ptr_out_of_range:
+	mas->node = MAS_NONE;
+	mas->index = 1;
+	mas->last = ULONG_MAX;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(mas_find);
 
@@ -6518,7 +6523,7 @@ void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
 	if (entry)
 		goto unlock;
 
-	while (mas_searchable(&mas) && (mas.index < max)) {
+	while (mas_searchable(&mas) && (mas.last < max)) {
 		entry = mas_next_entry(&mas, max);
 		if (likely(entry && !xa_is_zero(entry)))
 			break;
-- 
2.39.2

