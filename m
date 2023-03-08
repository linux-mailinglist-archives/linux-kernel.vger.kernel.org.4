Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD866B1238
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCHTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjCHTna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:43:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBD73B226;
        Wed,  8 Mar 2023 11:43:24 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HidSk022952;
        Wed, 8 Mar 2023 19:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=shoBhCYnr6ezsZI6aTcvo8XAxwdgGR+5AeB2gWWPFUU=;
 b=JJhNRekWKJseCoNiVsPdFG1Ob4EtFkqGRukOQRgFkhvfasA8FjvD4O/SKhRGv1W+fQzo
 rhw91PauSatzINJeePwod4ragEinlMVW/T6zJi+ba3oCrPSzLcDWOERhXg+YIYqJLxAY
 yPYvk9IFphaBkHZM+ePit6SGObwRO9qKsqSR0nVx5Zvk60Qpm/KDkSLQQHYoE68AkSnA
 db9pRDKD3cZYbMARZ6ogF70XrYgzOpKbhZB1os6Q0PhtLDADD0El1B9ZC2+Tfg+yf2IK
 OXeRFzaC3aaK71mH1p2iACr2/0Zl/PQWQoLrLVLw6A/zHfdL+zJ0TK+1YyV2NZ5bvvox Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p41620y7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328IKiUe020791;
        Wed, 8 Mar 2023 19:43:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fu8f0qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOwBxToUFX4BeKqIN+JJdhKgcjuAPQ9fVafbJaatRAhrKkD1TuU+KWAJq5fmlCoGgSqSWzDV+3jAVTe1RO/gD5pCxYcHcxS+C4akCSSXTldKa6mKC8rD+zMER75e0kMZ5um2UEOgLMeK/zGKZ02q3EyFt0m76PqHV8i6wsMI3JnRVRAwOUJaYoe1feeGu5O5MXQb29ovT5nhQ3fcjc7buMQIGU4Q9LPhPt0ASX9qvbgHtmfoojrj5B3fps3c0nLy6FGOv6DA+/DDveHl6+wuiI00pQGzv5vOWjJ5D0jMplxmrgiVR70OpeDhN6oBwdo8ReQ36+CzSJslvnxYaHfpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shoBhCYnr6ezsZI6aTcvo8XAxwdgGR+5AeB2gWWPFUU=;
 b=HfNxapKktbOAXMbGuwilcxekkMQ+a59FbaxQes7Igb4mq1uGAEzUT6pD4Edh9rLxJFFtT6rKh1n33jtOjlMVkSauvO2tJpbb6zwcS41pzTYNA3HjpkH4qqTcQpq+aB0dh/n82rZ/TocSpYjcPVSgAJ9Wit2/kTzicnnwg1zUfqvVLEQeNnrM/1yDqilwKui6ogBMEkqLKjSXCV4FKL7AWmdHyfPT+jmJ5+TGOQYc6WmULNKGkV0lU+uskN5J7RIA/WOfiP67cTbhDjTrXE+rnwinOvNBlWTeUe9nobm0Gx76LHqDy9imNuQ970xkiF1bn2qe54mWWAC6/fV2beVZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shoBhCYnr6ezsZI6aTcvo8XAxwdgGR+5AeB2gWWPFUU=;
 b=M9aRww8SWdlpWUpDxZFu1w5d7pFjOIKjCYmpSlQcplgk2BX1vv2Q5AV/GXgJQOc+ImIgfG/hk//3JTIByYlkVqcnLkYX2l/RDnbI/o/YSc0B672bXiF8EgvpHqWo4fLk4Enl60/fjtO9p+GCgJ7qXy2AxcgSSqsoBifG1KCgMIA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 19:43:16 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:43:16 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 01/18] mfd: da903x: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:42:50 +0000
Message-Id: <20230308194307.374789-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::24) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eafac1d-4f56-4910-a69a-08db200d5cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3Z9bqAiZ88Wx8YSLSQZX/Nj4WDQ3V7xe/Lgatx0YHro49a/z5WaDeBZk/7+AQlQR3czIiXVuFoA0+SLyqNbTnZ1kiYugBfv6vtT8fHaeHuFaYiraLkkAj53uKUGo3VzgDsrDSXbw0rPjBzHXpt9MRTvvGLsHlT4L6nCqMoeOisDf4JBH+6oIxE7mOC/AUm3cXtpFpYtiBn5bp+Av9XUZhhf+pys/0bLc0stVxi8lUnyBIJ97ZYywFs9gEIFFdEX4bqcNF+v/09inRMF6T36nE9eM9pwxWmabLGN2/3hUAekGZoFD3sVvhdFyZZB1x3w/kSkA8InL9qjd1Sd2qNNvUm1otnAqldJbSgXnKD/9UYpPcjOr9TL31FaretB7NyC7IRKYjSeSGqpzBrd3uaGG4vVhVag4J4dgqjo5xUyl9zakfHG8UWRWQDUWvQ85Gk4SmSH918iGFc3qEIrqN7KhBY4IjZzNVsVxZ+7HTa6veJ9zrnn+0Dw8zFS5DlE4/J4KxSGrz9/NjOa8V22q1uZTTwwGgvM5pfkcGIUJXcPdvyNK4VBwmWWFsboDu/FYKxpgU1mRSQhKfIyDygMyefo6qvd8K91TyYOBk9flsgxobepPE9auf64hqjxBIPXo5FzZ5sTXiY/qWsoMTFQ4zpYHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(5660300002)(44832011)(38100700002)(86362001)(8936002)(6916009)(36756003)(4326008)(8676002)(41300700001)(2906002)(66476007)(1076003)(6666004)(2616005)(6512007)(6506007)(186003)(83380400001)(316002)(478600001)(54906003)(66946007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u3Z5/ssHbgx9gTOZpHIQPpT8xq9/TRO0eYoSbk7sQc3OezuafyWSI0+B5DI9?=
 =?us-ascii?Q?2xMKnn5lZIZcpruLV4E8OWhntqpFp9SXISdbbONPtCzC6AHIJ2yDbs0unsb3?=
 =?us-ascii?Q?sMT2Qdyr7kpMOg6EkY2uVa4pe0bKSHif4vAAgMEq0/qcuGnQMNdeksfNuoQP?=
 =?us-ascii?Q?yR4pkBWtvXRCWsGBUaU7EqGPOpC0lLti/4k85MuN1NdKR6J7CJZkcgUUuEJW?=
 =?us-ascii?Q?tOCbXR4ECZdhyLeK5SFDeCyudLcK7drHUSkvZ2xQ+yF5osmhUKN0QKqNqK2I?=
 =?us-ascii?Q?y09B+P3xSgaTXPh+9EaLaqIbGDRd/yk6spff1v9Hi3m7Hu9wymTpyW+WP1xb?=
 =?us-ascii?Q?LFaXoGx72GIQMOH4ABT0olDAo8kSe7vsfFQKPLuSp4hC3CJX+ajOlBiLINeF?=
 =?us-ascii?Q?ZgZDWSrutOBD3cfrj+LnLmGK9pWjaJKEAJPyzw+8bJ+llYP02Rb3lB03GpnZ?=
 =?us-ascii?Q?z6ebf1y5ar9dKbp0TroShllmdOXDSQDYSTqvFSoGA2Fryzk72VSMXxwKIUEp?=
 =?us-ascii?Q?SHKD7VL2ZxzBoygHAX98IU+xT3dgepoS8Bnl300Fx7hdBxOfnndncZyee1sw?=
 =?us-ascii?Q?JSPdE4NvPew81yquAodbp0utntat5IuqwzG2MfaDwcBhT/f8cG6sL+gZP15n?=
 =?us-ascii?Q?ckqPu5vutFC+/e6a4Us3M2MBs6BC/0wZjuUi07MDjwstH+vfGj9u75gtqfaX?=
 =?us-ascii?Q?gjPxiaPCmR8DbWR/w15RQ+2eqxf2a7ghDwl0+atGRxWDZZ3RJDQlIXqanaJf?=
 =?us-ascii?Q?2z836t933OuoQ80sgFQAh8arVHqHujY4C1aqQoqQAS4ehwo6Lm5BX7W1g4fv?=
 =?us-ascii?Q?UuIHQgmVLWhTLU6qFbrMWDbjVgc1Cre97kZinodhvZym7llBUVt6X9v2wnhX?=
 =?us-ascii?Q?x9btcgbEaXFSU2jDMdEk3JBjTwUKyfAp5pGJlzeAcFRAxXcYafyY6zNRwgFq?=
 =?us-ascii?Q?hYaMhe9B1Qs2hyDqXKA4gq/EhlfJ05ClgAaCs/g2eXEpfe9omfLfvIA5Yspm?=
 =?us-ascii?Q?2frpaUM/DMbjNPlpuw2yGdB87WbeyYaaADJDuCFIxCw9EP8Sg+pjt3BaQUKX?=
 =?us-ascii?Q?4uFyim5gSNf8oP5NBhtPHGlaSnVKXdtxNCDvZLG6jvUTJHX3yJomm5tAE0xv?=
 =?us-ascii?Q?FjoepjQCg81Kt49iqhCghT5rCG9H5X7pfs9210fpgrX+qNkP512UPB7cEUMj?=
 =?us-ascii?Q?rjb3DBVwqXATWUIOwNRM1ahNu9YDar/cVR6vWPHbPTrlHeL29pzKQddfjOuo?=
 =?us-ascii?Q?KaesmyaOO9YwM0SUmzLKAWb0YV71qIX9smjEqaPjG+KtUkD9o7fnPs8efDko?=
 =?us-ascii?Q?j0USf3/3V0rMinm0VrHcPLi92S/i7mWxo6Xqe4oJ6yPEjCysgy/OkW2a101U?=
 =?us-ascii?Q?LTsccuXDcSksrQcO+PY4ltZMS0Q6eByIGg2ZUnNp7YZqZQ4C4K1Q+dEZ1s1C?=
 =?us-ascii?Q?c/ldsjWdJH+TvO8ZSQFR4E5UsgpmCUzIBAjWxBGwMKeIu+n9IjjmBmNb2Rym?=
 =?us-ascii?Q?RdP1LoftPY5fRO6sj1ma2YESSeUzwmtqEDORhmxwtqqxmo9g7KiEop0d6xYQ?=
 =?us-ascii?Q?PsQGSVA7aZNLNk5OJSfknsPQZYfPRGL9r3JuQVDf91yt44Lm1vECxvjXskHP?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AQ8Jx2vvfO04pvTljyBywozek6dgC9fBQRRSUtbyxcbt7I9TJMCp+8T4PL9xQOrsTXyzAoOJDp7Tb6OD1JOeuGXtgabKDMOwF+w3j8F4Ts4tM3CqoJxJYeYL6seXtMGZviMWUsyVihoDgDsIeKfB30TspOMQ4I2Kfj1sWH8JkPK1F/rD9G0oRmK6k9TFjHEVHJMgxUW3elJ90OSkjxhcUchFgbRIULWMhlbmwZaSasvGulMel5JZPEia002P9eJTOElsS041J3DEFzTOTM7MtsLCylt4mMSjgBL6fQl8XqajlxTzjaojzZP8spdC+0twBevRSJU57DXOGs+sKCpPIZBXfVLcKSdnS2VSev6PTY7u5unsXayKxsVo4LxzTtqoELE8uIfuX3EWXAmJidovCK6upZYPeHAYcTW6zMWbT3UKZhKG45IEfCxExQZ63OSXlBtmwYHhEmwyA2XbAAdspLQjPR8Rd2p9S9FCTvHgCzKVUWRTLdIpxOPTTG07VHsGIvYj0RUSFJ/LpEy3zW/rXBIfkUhAwB1igN70BEZr0ILiswhmR51U7YdeOnuqueMBAYfJK1sNEUwZcJyVk17JJrS8ijDlGuX/tQSafUsGwYiAtw0G7V8Ss5c3uLA2jXJWENbFHYEn9AlzoRJgNpQhlwhUAr6fKUdiqfpnDV7ZQ34uMjPCUgGYYT8t9PbFadEG9JZujmvpSAUaqTatq8CqNTT/DjUe4A8+frSDKm0Bret9hSSyMejvKdNPtCF1ej4HvMo2bpRUHg/ydD4137DxDwXeXkG80duMYxKx0zLnc2UukVOaAAh6utNpCzNOud/k
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eafac1d-4f56-4910-a69a-08db200d5cb4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:43:16.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVolo46JIlCySqs1qEXJN9quRMF7W8Avkvzx/Bhlah592yusBfhqop6E/ndfClvM92EaaT+sPtk6Sxr0RqGsOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080166
X-Proofpoint-GUID: hfd2kho1r1haiQnLUcHdXvRNHloNaLPK
X-Proofpoint-ORIG-GUID: hfd2kho1r1haiQnLUcHdXvRNHloNaLPK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/da903x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index 44a25d642ce94..6570b33a5a77b 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -563,4 +563,3 @@ module_exit(da903x_exit);
 MODULE_DESCRIPTION("PMIC Driver for Dialog Semiconductor DA9034");
 MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
 MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

