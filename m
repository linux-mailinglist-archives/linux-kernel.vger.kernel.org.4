Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20456759E0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjATQ1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjATQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:27:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC168A701
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:27:28 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGEBVl006200;
        Fri, 20 Jan 2023 16:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=PUb0fe4OtfYx7f48NaavsSNotcSXWvrwwRQeG6HouxU=;
 b=qQgUwm/0Sijdf1KOg/mgN1EGQfC7lNYHc6LEsK4bQh08SCzMltRSEebt93wIWoScZzQf
 eMe9H7D4lzXyxQZjzB6sd4pY7ubJo+bLFoMPKOFFcUKYIfYBfPuP2imsdwFuAk/qgxyh
 yde7F3Zssu83HDISHBjpZEUPjYcQaz+/p1rWZOqm7PGMd189UrmO+Ss7rUV9hXY8uJP1
 JzR8CArM14u1aeVpUiht38CGSnppn/0/GajmZMFCgd8ldM0tKnoN5DdxmpvLPCIA9wPq
 83/28G5r/QhrMvZUvWTo5mLbgfcU1uMkYhHeBhrMhyQX8RBr+n/Hb35LM0I8ZsO9KgJM og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdmfu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFU5vq027848;
        Fri, 20 Jan 2023 16:27:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qud90ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DraRlCaRRRtFWdL+nMefSx88Ol+GS8Dzsy0qb6u+KLrU+IRjMy7DWp7xvtvw4lTbzKQF7l1vVVRFLSewiCsugncEsXygRyMQoD9sKWKQmARXsE0zyLF0t64I9vdhnpPkQBao693canrZa/OshhiNZoaffH/5TGQQoV91xX4JkFNFF2/pXUFD0PP/wHrVwn+zxyw8DaNHTFz5540DnNgmvItG7l5shqSwcVyo/AOdoFuQgVCOsvEY87cPTEpoWFiOA682DHT+gjxX46/+uCMHRhSlgArAzP42kSdRIf48RQ3sQKJ2ngSWTlTodPbYcCSQKruOvDlxX6AjMaFRoPNOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUb0fe4OtfYx7f48NaavsSNotcSXWvrwwRQeG6HouxU=;
 b=HAMcCYjrAq+HuyqaIdeCG4GUUAi9RWqYkd8EpoumiLUnhbQ3/tf42r+qoF1572QWFzhKY2UCjLvsZZQH9xbf5TrPuSuZv0F1h8CPTjFQtFzwcrAT/Ef3F9EPGPVe2CO+BA9AS4JOZoLrTF+2n/QUVVmuXqYHziB8TS/UJjz0/US14967JXzaK4J4uNpQU6ZwAtjZVI0mOSWbAq/wkRo3mopUfvbKeaqosqKUuVnD5PwWEOlvo/47qUQpG5lejSwzUfmVUw+hslZ7t7z4AeWeMxqu7FPtGFAzXHZyl1vko3hFSB7fl4vbMgENAAjjG09HDrGMcCy1Bx2FJPBqJjWCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUb0fe4OtfYx7f48NaavsSNotcSXWvrwwRQeG6HouxU=;
 b=A2GbUwe6huZiX3xLfQv4zMl4FyqtCMkF7NFshBVSmpANop6TL/X2VYbZZ5PMwjXg3TZ0WF7SQRFix2/EIadmGha6Vx2XhG4f/ZVLLYZhEbRKP0JmStPHY7zhpylvm/Heu1iagI0xDXr8p43ObuIkgg0yiDn2yKJTt3Dw4/ViZCk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6026.namprd10.prod.outlook.com (2603:10b6:208:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:17 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 03/49] maple_tree: Reduce user error potential
Date:   Fri, 20 Jan 2023 11:26:04 -0500
Message-Id: <20230120162650.984577-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0017.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 367e9ee0-f3de-4e9f-eee8-08dafb03321f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpQWZHkSHrWvU9Sd37ZNGRINd6MN0ml/CezoO0fpc7UAse3KmpBvwQNhgenqR9bLDu/GIjALMWGpucaXluZ3m3yK05Uym7QuHOPRg0180g7nslchPoNqwnUZu/UdbfIcWeRFsjbt00r6X7UUnQETcBSXQVhUfHMCfxwXaUoE0DLwf9RmhKjmYnBHuwCAc7F0leLGcJ7j8LnrYkUpEPO+xa27gK5An1L5ZJBLgi8R/f7G7vE2GbNgQ5IYJcn61A2JMzdvTraT+ksYVyA/OqE7/5i68WZvxJs7lu25ooQfEFiwkkpUVRM2sHrrK7LRsIulFBx1SRWno1jceuCDd1nyJlxb6YQtmH3reDVAs9GDXfRFOVtoyJM/XZLRvQy4+YX8idEBw21e2CXJ6gKwiJ+Ef4e3kD0CswLzGctpv0rux1JkumrGMAsdI/02LN/LH0D0+1Cv96FxCmjbNU8SVWpwY7oBWARosYG9YtvZ0RSPuFymLUOy2Aa6QD9NGwHfA+MqqzgUb/rVBrUqVAQOFJc+eaHODy7yli0WqrgWyxTtEtzmyAUI65/Sq7GIezvavKpE0mk4dcBDPbWpS9aM1TDmLbcKOf/mckyU1ZqcD0ydOddXJmRXqFayCXIrbVmvAQSlLuM+l6FjR1lKetRks5gtXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(5660300002)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(36756003)(6666004)(107886003)(38100700002)(6506007)(26005)(6512007)(186003)(2906002)(54906003)(6486002)(478600001)(316002)(2616005)(83380400001)(41300700001)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B1lyWx5EdiiVS48zTR8j7G9wKpr5QDLnCPybAtOTBMX3wft9/Xm8gbhyVSMD?=
 =?us-ascii?Q?tz6yPh7konozL5pYUzW89sFNacCfexGAk18VrGm2pkwnDpoICffCd+Auao14?=
 =?us-ascii?Q?3Yc1QLIKT+YXNq7yeaPwE2gtTNuq7jsoA2CIRn9Auf8KFcZeac5ZpTsK36Jo?=
 =?us-ascii?Q?LPvhxRGMGFK+7pOqj4vQy9pTXtX2MSa36pXhe2whkE2zrgP6ujAmXfFShECw?=
 =?us-ascii?Q?ZIfgkHUGdWPr0V+OtSN0tYsVRnRcHZPwTjEurzIBdbRM7L3T/lrWvepkqhMQ?=
 =?us-ascii?Q?pzB6sTSD/pz7ibhv64iBEGRLJavtAvuhPVSNZ03wls+Jj3gQQoKrbQ9293w6?=
 =?us-ascii?Q?Sh76m/Bv4m48SSCHC5c89vuSjC/+Mz88Rep1FK79Drgoe+Mk6YFu5JYo/f6R?=
 =?us-ascii?Q?kCs11qWHdD+MTHiCZl1vv2o1an3SlAc6hBAUkixl5W9nmQ5l9f5QC9bQkoZK?=
 =?us-ascii?Q?RgS+Oe5UQ9dS6PCV8KnifCe615QWzeUZ4rZfTbCy2n4Z9rwbhLJD49rKVrzH?=
 =?us-ascii?Q?PMu6mC4PPkWSseyaGo2JtXvem7V3YQEHEjR7YRlyWFypwHzJCYYRubCP2mm6?=
 =?us-ascii?Q?9B9o+aZc/NC3SFA9ua28Tky4uD2vqbJINDQn4x2Cdu+5QlbfL4qiuoZx88ff?=
 =?us-ascii?Q?paeyN++XXO0vupAUbSIyMybJ52TqZ3HRPq/PQ5aoZixo9+1w/zxSL+n0AkkZ?=
 =?us-ascii?Q?x18Jlpt1W364+M+Tfm0EOsqu1eg5oaDaj2SeXAf+g1NZn6g7I9WV7eQbraFa?=
 =?us-ascii?Q?3t8pL3mZpZzxh3QTTWJHhFIpRBcobArsDS5q6H6IZYR8nAtiLqOAB+dXmkcY?=
 =?us-ascii?Q?EJLPsTNGQ6JCs/jBspeE97Pq4zoqL3TtaOXlSNt6mCcrIrGyW3O6Q/Xtrrub?=
 =?us-ascii?Q?GaTSKX5npLPjnMO28yGGRUFhVbg0S7HGow51Uu4aJdq+z+fk2tD/A1nEj79u?=
 =?us-ascii?Q?xup5cUy/8aMAMVrYBocJnvxy5a+xuk1/PJ8mElwOZOGqHzYFfw26QXTF4/q8?=
 =?us-ascii?Q?XLSFY8jqRu03vuwoBvizVdnxjfWURxd/odfj5j9IbBDmhJyzjVyu0tDtUmBf?=
 =?us-ascii?Q?ARRGnotADAwyWPEaOksu1zLgQ5gVElKZYeKExfG0hNclVfiZsideaquGpXLo?=
 =?us-ascii?Q?DB0dstQvZb5aU2O8J7cxlgtCPCP0FvSu0ENpEnLy07ALTC6Zm5W3xWTQb9O7?=
 =?us-ascii?Q?Z6zai0zwpf2r6Hx1JZ0ag9TY3Pf5GJFYMUuyVGLQ6aFsyES087RKN8jRrd+m?=
 =?us-ascii?Q?Yb1FxxPVPgTcxMx6664chhcZkYFWBcL+zxDkAUfozqq++eI9zH0X+5sj8XKB?=
 =?us-ascii?Q?qZxDFWej2QWFprc6iWroNmap5Doyn4NUtmuquUBxYtDGwLDuTKHTOzCsDPt+?=
 =?us-ascii?Q?9WRukcn8lGDCiif2thUPlPRu4iZn1BBTxwXgSBJCDCCXvueixDCHVX4L/wx2?=
 =?us-ascii?Q?vhJQf/qhs3Zq5nWiAcnz/Fmtwktmcr/FXLhD7sgVae04n8CffdUny6tmUkfp?=
 =?us-ascii?Q?TszGVFVseYSSd7gEpIzJdjmsEA2reyWKJ48IIHgLHWAK6U1G+2cXdFVUg2YV?=
 =?us-ascii?Q?ICWhLGC32xuKtKj5XOPBHIrPQUUpbpVxBjg8IaG/jCirvJ7u1LmvgRTQAcV9?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g+3aDc4HnkeXAXV+sGdH5GykLEiQo/3WNuUqlRHYol2YeSE11Tti/ItQtZLHlKS3WOMrHdq7fpEzAWEam5g+sSiqYr2wSzunex8XJOFOkTrV0IH7nl1V9yp0QEKXXJdq1Iy2a4BcAsaJeH1eG3LzncCqOSGmuT9El5nDpva+PB9auDKdyosHUtkArs9CwasOlvsSu9sqZ0qtCWIBOGDv4HT3mlyc3SiUKSCWlzFhBjaOnF6gvaWZleIwOfFhgCND2aGlcfcAp6IOs5mxG96AEcuoosqhhRZ2g8RJypUKXZmuuL4CILO4k70Dtv6+PXJTQnUya3MObzmsjEzqUYMA0lX7lbsnSMrAmwFLA/92g6VM5soyWxY1XXFsAIewAlp/QG1I6hmidXtjY9DP33xHn4T63HGp2CJYUUYiApU5j03mAftOOi9dOWHCNm6mWvEXQf7+enQKlOStQUOfOMxlSHuKseT124k0ZgV1os0QjZd6pzSDnzcuwx6qNboglE5Az25Y0r6meOHsVPFoMw4Y7pjH+Jq92ccgYijQo+VgLvdWTFTh3Nn1t49MzpNg59IEdEpmwyzEAAxDmhNie55u5bYSVaDcGgc1q3s8yLkaAJ0QeozY3BZylwkXJFfnPStilsS/koteOVgK5E6sfhU1AKnzxrYwvLl6O1eQ8JvTCDXno/xZmNbfI0D/brnARC3iERY1HkkkfxSHE3EjaZpgQFDnIymaBTiOGJt7mCDPyw+Hm1KUfd7Ut6PgoaGWAjYc10RaW6ApZ+eda7fp4xxnoimTPbxcl9wxFQ5v26YIvXHizV7c4vQIoCvAUy7QbEcuNg5mg1czjRV6WNr91JLnqlqVqYw8m/YmAXILN6YOBuxsFG8PwCE/rQWjfu9xseesmBFD7dWNBcMFfB2m2M2tjA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367e9ee0-f3de-4e9f-eee8-08dafb03321f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:17.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZUlrtI43CBkiejGhs+CYLwFD/6ppM+yZHoJycVn1CwmeWMsbsli1OYqbzilOv/sPq0/E0o6/vu0Meqz4ZXJ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: wB_8tCUZxj368edwKWM0Kqe9tUT300jK
X-Proofpoint-GUID: wB_8tCUZxj368edwKWM0Kqe9tUT300jK
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

When iterating, a user may operate on the tree and cause the maple state
to be altered and left in an unintuitive state.  Detect this scenario
and correct it by setting to the limit and invalidating the state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index cbb8bd9b9d25..1af09c6f7810 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4731,6 +4731,11 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 	unsigned long last;
 	enum maple_type mt;
 
+	if (mas->index > limit) {
+		mas->index = mas->last = limit;
+		mas_pause(mas);
+		return NULL;
+	}
 	last = mas->last;
 retry:
 	offset = mas->offset;
@@ -4837,6 +4842,11 @@ static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
 {
 	void *entry;
 
+	if (mas->index < min) {
+		mas->index = mas->last = min;
+		mas_pause(mas);
+		return NULL;
+	}
 retry:
 	while (likely(!mas_is_none(mas))) {
 		entry = mas_prev_nentry(mas, min, mas->index);
-- 
2.35.1

