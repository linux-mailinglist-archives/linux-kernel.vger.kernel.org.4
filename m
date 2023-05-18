Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7C5708707
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjERRe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjERRe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:34:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5988E4A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:34:55 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IrSF028535;
        Thu, 18 May 2023 14:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kwlks45KaPTPCTeh1SIB2wxYF9YvjH82mk47CFRH1M8=;
 b=W+rvc7VcqZBBQQhDlN4VTySouhjp+IzjWHVJx3etAYJwd9d/BbWBJvlY5JV/jkFqY4KI
 n4tdIfL9O1DfCFHZRKQ2+jJb6ICAYSlmXQ3UYSjrWxeBimEGmzGDpGZuCwMRbqSv9Wxn
 RZSW3XnIPWygdFxFOZ+zi4EaFsJ1fN0h7hxy4V/5FqUf4/bnoABbDWmwzdFRjBTCsU/9
 Jn7yjyDxlq+o//H+3mvWjT2OZrDH8bZwumr0tkDm/mM7ywKIk6UvQuCOVm7Eb90IJ9Uq
 XaWx3k/BRUjV9PkDSC3mtQNOpQ92sCrGC30qnn9RNadHNQpRy30QfG6baprfa0VllzE4 vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc8f9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IEC28s040073;
        Thu, 18 May 2023 14:56:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106mqd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnrxVp0/+Bs0lFCNtMRBMnGbOlDuTweZuQxUbKnxztQ6nbbJKk98GX7+AHWhbv9o+ILb4BarV378da5VQGx22qi67ZPzuGOzPDJImZ2X1vZAaUOAyU8rXbZYBx+/hbVyiVYrb2aKtR7eNjN6rLzUwziWmuQCByvr4trUfFebv0bhhQP4yzO8UNubYa+iQbk30925tMYeUzOS4edgz92yWZALhso4zGAOkEktWtSkmOTAlwJWEOxvztvaqSaA9d5TFLxxM4Iw2TDQi3l02HtA+7TQaG0NGy3oxsE3UbMWKflIzOi5cRPdGQh+IfofOkBMx8hjFzqlA8KTL9HNPJ6DdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwlks45KaPTPCTeh1SIB2wxYF9YvjH82mk47CFRH1M8=;
 b=BKOd0QUX9eiKLGKilaI6dMQ8w/enhuLxb/+ibeMnryXfPCtNUSQcDDlrj8NZVYA43dube+C1sgBXXsefPWwMybLFOWdLg0EZLxfCGf1a45X7yfdKjh9GLOqH/AD8+AX8hJib42IL9S4WhVu0BIWE4iHPCAC6DL9DadYwbR+7ug6WTzWzV+8GvNQfn4hlPgTtIhI/djZykj2g4pruSvNDOKD3TZwHsXKSfrTNW6jxd9/zw9hPfqL7m/qq/dXL2ct+0hngShjzv4dCUIKjRCTazmv2YoPwBI6IAcL0vPH9KFrzbzVICJMlOSCA9GDjalNMstcPZ5qox4jKveZZ46hRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwlks45KaPTPCTeh1SIB2wxYF9YvjH82mk47CFRH1M8=;
 b=MxCsY87K6JH2yvzXFP3qO2YzdxBQTVv6E+JIDj6Y+lsZJrvvxxlahU9Wt3PBe436slICsMRgdF1YChPyHulcmWQRF0/eAqQaeD2KKZgqgaAs5z/8v3gHx9u2JM1sW1whmP42YeVk5MlP2nk17wmB+mpAhdGzIydXx+Zd4hZjZCU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:56:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:45 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 23/35] maple_tree: Try harder to keep active node after mas_next()
Date:   Thu, 18 May 2023 10:55:32 -0400
Message-Id: <20230518145544.1722059-24-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 43704bbf-2109-449c-db78-08db57b01950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8JEUyvakc/M4fuVlyw0Z3bc6KuZktHkfNLS0/JON+QyR5eodfsCyPtVPx0gdkttqE7wMzJ2Pc0kMjC/QsqlTMUtuOuG2BFSv71MitFoE1Vy3EMY7BX0LPm3hliVJAxJ9kJI+zPSaed6oK8vroEa0yXoNuoJWBKCJAc86zrDmnEaJs6Adzs1zXCGqwXTSYsBt/Pi9G87NugZsc7pX9ts9nwh0hIA9CejcSEli1mJq2w/Q7sldxTfouqoE81Db3AnpcVYqihpWnCNGRmK9BuPy1978fyduvh/9Rp91vvzxubn6nzSu2Gx0/WDgd9RZZuf3dk8lV4YhHrzNuCjt1HGjzsIayXXpdOF+fcOxejYrDCRxp0RefA8YR/kBG3FNLIhxkQFNFSpWfcbTsxH8CWhk22MtbC58UzFu927G1BraZF/0D0bYDnFQ8F0/E5EqbX+3sFs4JrgKQE8UUT68//uVJsyG+904tob6wr7yx6uKYvnWaI895QAdMLw8uGIGt4pyjRHB5P/eslSusZx+Cxl2Q9cji3NL4Mm4i6AQeOift2XkT/lHWjArKJgzoYx5XMlnl3OhcgRQbIP9GV37377ymWuQKOscSYjTQGvPcyb5j1YXFdRZ1joTgt8sFnjl3Nn7hJf2DrQUdAIbtRWcZFURA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(107886003)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(2906002)(34023003)(148693002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUllk+MnSeuwOCLaD4aw55TtOV/5uAcGoQYSZCagWz06Vjk5o1bWtaQ255EM?=
 =?us-ascii?Q?FK2ihophjHlZoXCKbZN6Um+y/MYl4UCozp6sFHmNPz1evEpEqs4HfatVjbQj?=
 =?us-ascii?Q?Jcep+fgfEv/O+V1l4WcuiZrcx44oX9HVGGHzKm34vM0hsy+TZ8JJY7m4lMya?=
 =?us-ascii?Q?grLiXkBBdNjrakAJoaZW2vaiMzw8TejczY/gPlM2AVftIflzHo673U5be/nb?=
 =?us-ascii?Q?Qph2I9c3WePYGxNM32Ovmv2kYI+bB8CcxH/0TO8XaBPmFDtihJKSWezRXsdd?=
 =?us-ascii?Q?KcopsDHmy6opovZxHU7JFjih/bHa6zkvPAGUu4UN37U2/62/WsF+kfA1Xe/7?=
 =?us-ascii?Q?rmnYvZ0qLlOxqRLLxTGp34zPXBG66j+/328AqvflL3CdOEUZeAax22GDYPNT?=
 =?us-ascii?Q?uz//PlnaUbVGSPTiPGXb8AxiBVuEleoDNqdMP1r9Swvx2pPytJwQBK/gWnPG?=
 =?us-ascii?Q?k33Nbw4l38rMYsnQAcQiIk9P2lWSoi1ehhVAtTbttb8Y6Ubg6k43B0fbJ480?=
 =?us-ascii?Q?PbA1hW0VcHKFO6Wfud/ZbOzNliwI0xzOuyXBgpjj420s69X2HR/Q4J/hClys?=
 =?us-ascii?Q?3sxCuLGOTDS9RgZtjAAbIsofJVeg8BtkID68kNuhOwDcWb1C4wjyJNtOEU0a?=
 =?us-ascii?Q?6vckQc7EkZ3f+GttG8Kzd1gB7RxP9xk0DhmjTzUhW7L9G7WHxJq8qcmaTECf?=
 =?us-ascii?Q?Cz6tS+uB4phXn/OR3zIctv4rCYauCgFApwL9iSM9qcwYyYdgLLxaZpG4MsKL?=
 =?us-ascii?Q?DoNpexYRvEnydvTa+QxGY5e4amUiww0g4G+abXKc6gQJIGk8JPlAIucYiZRl?=
 =?us-ascii?Q?Uzv0ZDADP+d4mjWNWuahAdPEFNNtbEwSDNHU2OAPmYAd6/nxLo0hNT9W+IB8?=
 =?us-ascii?Q?Qzsazr4Ls0ohjl6rM/jBUv+tWAo2k9ef/kusXUWXWGZGVLUcJF/Dc1m0d1jQ?=
 =?us-ascii?Q?/SHy1DPZZIHEE6zzzXHyQeu+uSvKPOSqHAKI7SonWqMo1g5iUUO8CzOFDqPO?=
 =?us-ascii?Q?lNd/xMY4zlc1y9PTiBswbRzkTq7oYCOVyrIrTsMdSM0egk4DK838v75Y7IXm?=
 =?us-ascii?Q?Kd6KnV4L73lE+QqwSyv2bCfq7I085eqfZDb04vjb0xJBqTHcIYUZck6+r2Rg?=
 =?us-ascii?Q?dwu0giNB3MFfkxCOw3rYc9bweIM4EpIo130klmpbjXAeQCsK200pJKfBF1gj?=
 =?us-ascii?Q?HsigCRu2P4gIR6+/7/owUim7XVoWxsWVr7zKLx/NnFcqGTk8RuYWXVOwxWUh?=
 =?us-ascii?Q?DO4bU2DzmiV9tS7ddNDFDZggLBhT8OZqbZIytEAexHzT22lTbiVW1LhYLYt+?=
 =?us-ascii?Q?3ZWqazhVfazcd7d8YN3j0N3tNvuWDkYy/pCeJOwnkCHzNh/m9YoqMkFBUQgU?=
 =?us-ascii?Q?kryw2kWe+WzqdaTbLr/vsBNWoJ96cfnokNm9m+f5v4JX+NwInWD8suLUDOOp?=
 =?us-ascii?Q?Xu458RT3yyfXfem9CAofFd3WQZ7SIFxNTL0SQZw7u8UG4qR0rbRleFCJFFNE?=
 =?us-ascii?Q?qlso1yDIQFxcKKug2ktV2/syviNOnzb+2oouRsv71laKpDMUL96kIZ/cr3Ww?=
 =?us-ascii?Q?Gt6WIcC2g/X4CdMqD/KVPcMO6hodaJj38dzTQVgEj3LecTwKzEVS7cEBTMTV?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cArVtuG8sgTpV5ggGkAz7saxom/0P5nxU0ELE6IvLQ6pbe8TUWQbahFAYsHsigapdJSoj1sTnv0qWJbHk0fb9IBNgbyci0saGwDUsH5rrIAr0neAepnT/8FaLXBUDIFCI5/msMCXjiZYgqErv+Ue+QncbfvyfnqrEMI8Jpdp9HiJ+arufe+Aux2EGmPlYlodqDdwrb0tvuqXcnRxNm3rNECYxl0NuQErkV0gJclVizqOsE3Cql7VhXnjwRBjzmQEsEjXDO+VbO7hXZbW2O8k7aYM2Qog0iC3/ZaCMNj3Y4yN6M8PO1OlA6nkOZrryHB+hbmCpxkGailXoYucbYN9udXBH2+ANCenwb0Pr8z+EPIzpQS/a8AuSXmqit5gR3uLjzay4DoQGJxiMV7YQEKkpBYosc9szULZp7hOGQuhnYtH6rMVT75ibO8wCIIYAjTDUHRXJ7+TXUBToH2Qvig7oEsdTITc1A2WF88CVSsNia8mblrUmc9IykZmAr5dc8moam78libP4dVhhprBbn8Nzo3l5nsmtCP5bVL/uK/tRv2q/nGSql2B2LjVuOumSAqXUPFaTM4S1O+LATkQhRa6CEK/61S5rwoqR7jlo/b5aOs7Pjx4Iyri8lYdvFMNvy8hoi8W0O68B2OdQvybr3r6OgwNYo0zylzdfaubpw05i0F5yiDXGpvJgL7xM+c7h8cw687aq4zRT3HuuEwxkCY3XogbgZvxSiikr6WOAwbClEhBNT1r2zr+YcLqRKzf7vgVUP8LxiLrzSyRQ/NqwD0V1jFQfW/VdSQHphdYNMcO7kZfzm81EKceECLlG8L/SLrigKCghYHmYvw8RuCCFBA6nA/rF+GzuzC/jLdDHBNrEedIwt/RiGlnK+rCW2y3aiGQP3FabWBkbaSpeLtg3RIpvQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43704bbf-2109-449c-db78-08db57b01950
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:45.4894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6Q2xjH1+S75XyxWwhAgVPs779yy30DkFKE9tcnB/xpNI4H/za/aTRi6upPC2sx6vCZOyWbSid6Tj1rZQenKNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-ORIG-GUID: hHG3fmaLQ_gb4abwatAWfcCA3_Cs3aQG
X-Proofpoint-GUID: hHG3fmaLQ_gb4abwatAWfcCA3_Cs3aQG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index e233f41ed4da..09142af08214 100644
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

