Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CDD6F8A02
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjEEUIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjEEUIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:08:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1305210B
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:08:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhQ8a031799;
        Fri, 5 May 2023 17:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=MconJcdQ5PNIkXbmMn9lrZAStfvANxcQEAkfOBppt3M=;
 b=OfC3ScE4aeBbqTiteIEFigFxppLwCPgjYxRFeMA8yt/JtQd3c6B3MUYlQkjTLjkDZ7uJ
 c5pDX4Vy+dphtlqv2VfP6zAFizIhb1NQztHvktd+JFqLOlwn4gr8ELgB2L2MXdX6dfDj
 lXmFJbEjAarMQTIlibHuWu+Qp3YMD6t5gDHnD3IVZCu63wJ9PMQ+OjULq9RMlB3HTvku
 smcAvM5md2tXQxEo5hKGUKffhITcG5lU0ULBpYpwZ3dUnHw299gnlqAyM1aFYDYwTv+C
 6xRnp4awTjtEXhSyulOPh+M1rUfylErQ2u3SK9gCtxbZ/cu+h0FgdeBamBf00ZoyniO/ 3g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d5nf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HQSiT026716;
        Fri, 5 May 2023 17:44:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgf06s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEaEPZemYCIBJCSjiPRQB+oOQfIqdEAXauXik8pHJTyzudkDMD50H8Zz9IRunGJolVnpX6MFTfBbkL1IinCuGzGqxMfm9TZP9Omd3jyC6we20onv3SQEXKbOf9mNhzpe8yyvrpcMgZpO5HQkYkqhbtrI3TUnMzAJhQBMsYMI/62LS1W2493XOPmdNogqGCrCfyGfLWnQ9pXpyC4J+20u30spvFjyk8rmh7kBVflHaIVqquKfAJ4eXqOK2obaa9ivQU9ge8PEBG4YJsfv86UrsmDHFMwVpMeBWo0N7Pa2uwCOL4AyCr3PFqWlJk4qUeURrzVOxpjF5otpU/9X+RyGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MconJcdQ5PNIkXbmMn9lrZAStfvANxcQEAkfOBppt3M=;
 b=mubBLQvGPVkoE3hC0O/n3I+/eysHDKFbcU2Fm5Hj/2Ko8UYXWf4PUgt1DqH6m8whRj2KP/88F4BZG7+Od99UWHOaqztmIp9HU+QGgu+LK4CTrib0fuscslHdx6CbFEGHJqFm3GBEwYj03trYQ1TpMk6GOMVOpIswwe5C3GmyRrKke4CDRVAkpgzfHW3383nggf50HoevknYI2V2GmuYmqWzIY7kfR8My4zhXWa/xjNj9aJ/+m9AQx8U9yYi2ddhNFO08sk950EcMCAI0XMuUW9lcMMBjqScOOpX3zYeYp2WdmRLQS4iNmFRgnB3LXtuaaXU5cMHkJLDd4z4zXi+fCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MconJcdQ5PNIkXbmMn9lrZAStfvANxcQEAkfOBppt3M=;
 b=lxcZoVEALTbh73ezma2tb3kUZrVF3lTVF6FkQyz+kbp9o36zhq3Ctxd1deTvbW8/45aMSKeWt+hyqc4ISuJJIkYGLK/8UBfJ9WRhs2n1Xsxo1kuwgDkq+s8oifZ1591f8TsABj18BeMGbmyZOmdLhdW6Ufqvhl8CYnH6UJI3v9Y=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:41 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 25/36] maple_tree: Revise limit checks in mas_empty_area{_rev}()
Date:   Fri,  5 May 2023 13:41:53 -0400
Message-Id: <20230505174204.2665599-26-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0335.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: fda8e013-9356-439e-4d47-08db4d9067a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wnCs504GBYqBF49N0B9dc8JBRksncdKi/gVSmJeu98T+wcXLiiersXbAUiEk86OaiHNhPXlhjgEv24RdqKrD9wll0Z/49eucB3GI2Lw8nUvmLfO1BObnvQAI/tu1wJ777IOdJrcBtzRzb/C6+zbC8VC1lF3VnPGMcFCQjK0PMbP7BlWj6BZ9TYeaXfbb6caHHWy/p2t4Y6/jsqLts/BY0+cDk07FNHBPgwtsyy2VCehMsMxkws+B4A9gQbDIzblXTQegFXQqevRzszmjheUHSEAb1rtRVjZyzThiROOYMcm7SKmID/3SZrftDR0QjPS2NwGod5bXGNJnpY9SHP9mQ/11wxuQ5KEN+AuJT3y6S095rNYn+04Dx47U2+2HiCdkuAJDdbsJYdA9sy4hkM4Xb2C3bAq92RVkdZrlPWnxavbOD1qIXOq71JZgwO+Nch6MBIG5pINL5p5SoX2VOwS4cZFXR+/4KHGS/Afh6G+Q8VQcLfS0vJEK3YZ+Ki8lpGSvUH2oVVGwmMoBH/W6aghlZrGdHb9iOAC3JXNFDXA2RTtmuDxKFdV3012IHNdswamT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(54906003)(316002)(478600001)(6666004)(6486002)(2906002)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FIxG9Tcd0goeZoETjbYuqFcy1Jo6CuaPlCBdQpGbg15EQLp9UPUtICi94fjh?=
 =?us-ascii?Q?YrP49IP24TPGEpAYTOLiOFSHbCyLISiDjnbA/2pzOCfR++sfbmQ+gjKT1d2k?=
 =?us-ascii?Q?zr0z5Mw9I1tCNbVMNo45PaOFg489xRQ+m6cFRVld+9cHzbcC7Kk2ijFTqt+o?=
 =?us-ascii?Q?Ha3QPXQK7Sas/YYGNg6MNRq1Hxrp08WpK4FeQXWJGzTsgMflneVqL7YkEE5f?=
 =?us-ascii?Q?MF5lTSlaw+cUTvdOJ3ayA/PNwXI6zLyYxHmbHCP8KuS+2EucVcJtuWqSc15s?=
 =?us-ascii?Q?4TEaloXVkB+r8qm+RBsah8s+EMGPXpibMZKxnrbF0e5fHfAPhicrkQjqZCLb?=
 =?us-ascii?Q?rCmzo6XOy6b2eUrwLcfHfWxKD/z8czzX8LTC3KDKTribhZjREICY14HCCy6P?=
 =?us-ascii?Q?EuxQF0ETtuVGPaKOYG5nkJxDbEoNm8LQbekAEGZMBypRtlQ1n7QC4J+/CaYs?=
 =?us-ascii?Q?upPRHpGZHkolxV0iDs93PbvnO5H6FJz1JlDynCZQydy1lzgIOSAZCIP7WFRW?=
 =?us-ascii?Q?uWxlX7iC/dXazdYPftw9Kn0CxmCRW6LRZ0lhQbVGA7Ja+wUT6+sUSqQehWj0?=
 =?us-ascii?Q?ejU+G2fDh+XIklt750h/o7nsA2gUKr0nFFgxLL5IiUqsLCZBscSyULsI76Gz?=
 =?us-ascii?Q?j/A515GI76aDEGIAgoYG7BlJN9f5n1fedfu+oOQ6+zMfY+LrpO2RLQWJdEhE?=
 =?us-ascii?Q?eLnBfupnOv2nyI195y4LOtdD2vgz7non8GOcPEngi9y3KgcSpGVDW2Dh0/Z+?=
 =?us-ascii?Q?cuaw4ZwiW30ntzOwNj7xiBxZnMDOWxnK4eUvu6ba+jkfkt4hQJnesDD9C85S?=
 =?us-ascii?Q?MXH9/QHqStTROdqRegquVMWOGzyKAVhNAImZPMcIHkoAkzQbuMWHQMFTr02E?=
 =?us-ascii?Q?Md6zHXiFs2/NPth31/TZnavpvX4sdbCBt44C7/kPoXB5tXSz104WBIsysIyX?=
 =?us-ascii?Q?n2tVmHODON4QmNvlKUVOwQsex6FxPBwyQKXCCLe4TdZbHfT4Rcu/X1yJsMw8?=
 =?us-ascii?Q?I/n0yi4uh5Yk8az7XJdrNcbF5Pj4JP+NzpXMgEF2fZ3H/ADLJFRJCR2Q7mvm?=
 =?us-ascii?Q?/QFuMpckPPP0eZSbP4oMSkGvIeuQ5J0VP6FJvfB3AbF4HRT/gg5pQq/+NKTM?=
 =?us-ascii?Q?eHl2r0e/VQ3CRFIfQVKVqI5iGSdOnxEgWXYVZNnJWOG6h6wecKO6TKLwvhkc?=
 =?us-ascii?Q?OIDcutWw4j5OvnVeXkTwnxw5IFD3F/157gdQNTN7MvlFXLTLS4wMV//MCK6n?=
 =?us-ascii?Q?2s3yadXtyDneHR9xmShruWQS2eNOKwPglLxIZuvQ/5BwuysvyQ7FBKcdwf/2?=
 =?us-ascii?Q?4fO5nxyPsq6hLGdgcU46LGLiBKHGeXzK8clCf+vp9zfSJtq59zTQyMBPDO+D?=
 =?us-ascii?Q?HNatXNaGCgpGD6kVV32lhs25czbS04ofquJndCGlOstk1KKlHxTaFDA1BK7C?=
 =?us-ascii?Q?NDK/QuYShQJfyXirL9MgQj2WDk/JaAHeR+WxRT1l1PA08EDXqeQE8LF19KaY?=
 =?us-ascii?Q?GymMFy3IYjAWVu/fTOC5wYdKioB1WHqellTNEebAw8sAT0w8EiOL0iHgZuNE?=
 =?us-ascii?Q?MKyxKVagH3JTWLcYmcb37W222qyekOsKcl7xuOxIbFflZfP3cidaChwq4dKM?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?U9nN8lICLlAwh2n9NxEkFMas06TEUuuwKZi5c0HDZwurXrPKOxhHsUlgdk8X?=
 =?us-ascii?Q?l6ktaqMfxajI4HrfwVkQFiPWEU8mqbOgOZcoMA3jzZIBTLh8YHEwITg1zpEn?=
 =?us-ascii?Q?rlRsWIXQYlZlNZOFwAMv3pizpyhMrdxqsI9/dnPZRNipBU98pI5jLRPFzUCx?=
 =?us-ascii?Q?CHrSWYxLTskQYD8j1VadRfgNQRi8b77T80S+KKGA0pz80WR5xd0TQjiUEk4U?=
 =?us-ascii?Q?TY3xvHJjoL33qOgyRDB7yOCTn56Le3NhMN7Gi66tOvsKb3122Wyk6M1yGek7?=
 =?us-ascii?Q?8TlUmpX6CTzEPZQ7ak0cO+M99FxL5UTf+Zev9bUL0NO7ecoAPTJc/RVlbtrj?=
 =?us-ascii?Q?6qGkR0V+P3PsMlzBPx96ssRRkid0SaQ0sfKBGlVrKRRC1C8kjr6xigZ4eSYd?=
 =?us-ascii?Q?KFQ3XOC9KYlVGjTUzkPGpqMm4ORO4BwjelKOBd2EoWOvzcX6nfyz180p6oXy?=
 =?us-ascii?Q?xBcKFAXLiue254i8RMIDodeBQ6TDmKeTEYrM8o08wqYHdm9hMoGG/MIdOZdb?=
 =?us-ascii?Q?HXw7VxET8BXJsn61CJv05JGBj2yL2ZSRpuDADI4q5zSW95MsB+h4TyHeysVn?=
 =?us-ascii?Q?zqDgMaa5C6v80rRaJ9bbsJcbyhEdY/PiU+S+WVjjuuCpZaj5y5RmILh3PZtr?=
 =?us-ascii?Q?6UJqACekHXVEWam8E/sDC7EqoTOrw8dkujrwBnkQwihJ5p5iHAaOllZQP86l?=
 =?us-ascii?Q?qLtGY3etFP1t3Xcq9S0Y3qHIPkhiInRIS8Ew46xukkssh6+ZCvl0gO3/4+tF?=
 =?us-ascii?Q?ZFk8Byt2a9sO0/i7hsGSteZsKqh8hoKyMC2eSehy8Msocw6CbAsetlR3ReL7?=
 =?us-ascii?Q?tIyKo6tHTrMw3gyl7FwPqzwdqPWvIYHdsLef8f/lms14aea84iWcFHjMUsWU?=
 =?us-ascii?Q?aSM2D1aPj46wcShEZjoMAMOP18FCEKhBsRBmmQYLEWHAEqihNoM+xvGXfE3+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda8e013-9356-439e-4d47-08db4d9067a9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:41.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5As6icTo3WN9Jm4XB6OAX8vpNrzD0M/FqL9zMflhRePU47aYYCXn00rJcDwX4Jx2UnegL5HU9gL5dp0rgAguBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: -KxCpIEoAxnlQMhiRl-jqgc5MUcL99VT
X-Proofpoint-ORIG-GUID: -KxCpIEoAxnlQMhiRl-jqgc5MUcL99VT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the maple tree is inclusive in range, ensure that a range of 1
(min = max) works for searching for a gap in either direction, and make
sure the size is at least 1 but not larger than the delta between min
and max.

This commit also updates the testing.  Unfortunately there isn't a way
to safely update the tests and code without a test failure.

Suggested-by: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c      | 20 +++++++++++++-------
 lib/test_maple_tree.c | 27 ++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 425ad922bb2d6..580310741d892 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5282,7 +5282,10 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	unsigned long *pivots;
 	enum maple_type mt;
 
-	if (min >= max)
+	if (min > max)
+		return -EINVAL;
+
+	if (size == 0 || max - min < size - 1)
 		return -EINVAL;
 
 	if (mas_is_start(mas))
@@ -5337,7 +5340,10 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 {
 	struct maple_enode *last = mas->node;
 
-	if (min >= max)
+	if (min > max)
+		return -EINVAL;
+
+	if (size == 0 || max - min < size - 1)
 		return -EINVAL;
 
 	if (mas_is_start(mas)) {
@@ -5373,7 +5379,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 		return -EBUSY;
 
 	/* Trim the upper limit to the max. */
-	if (max <= mas->last)
+	if (max < mas->last)
 		mas->last = max;
 
 	mas->index = mas->last - size + 1;
@@ -6409,7 +6415,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size);
+	MA_STATE(mas, mt, min, min);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
@@ -6429,7 +6435,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 retry:
 	mas.offset = 0;
 	mas.index = min;
-	mas.last = max - size;
+	mas.last = max - size + 1;
 	ret = mas_alloc(&mas, entry, size, startp);
 	if (mas_nomem(&mas, gfp))
 		goto retry;
@@ -6445,14 +6451,14 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size);
+	MA_STATE(mas, mt, min, max - size + 1);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(mt_is_reserved(entry)))
 		return -EINVAL;
 
-	if (min >= max)
+	if (min > max)
 		return -EINVAL;
 
 	if (max < size - 1)
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 19b130c9dddea..fbf7b6f227f34 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -123,7 +123,7 @@ static noinline void __init check_mtree_alloc_rrange(struct maple_tree *mt,
 	unsigned long result = expected + 1;
 	int ret;
 
-	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end - 1,
+	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end,
 			GFP_KERNEL);
 	MT_BUG_ON(mt, ret != eret);
 	if (ret)
@@ -701,7 +701,7 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 		0,              /* Return value success. */
 
 		0x0,            /* Min */
-		0x565234AF1 << 12,    /* Max */
+		0x565234AF0 << 12,    /* Max */
 		0x3000,         /* Size */
 		0x565234AEE << 12,  /* max - 3. */
 		0,              /* Return value success. */
@@ -713,14 +713,14 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 		0,              /* Return value success. */
 
 		0x0,            /* Min */
-		0x7F36D510A << 12,    /* Max */
+		0x7F36D5109 << 12,    /* Max */
 		0x4000,         /* Size */
 		0x7F36D5106 << 12,    /* First rev hole of size 0x4000 */
 		0,              /* Return value success. */
 
 		/* Ascend test. */
 		0x0,
-		34148798629 << 12,
+		34148798628 << 12,
 		19 << 12,
 		34148797418 << 12,
 		0x0,
@@ -732,6 +732,12 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 		0x0,
 		-EBUSY,
 
+		/* Single space test. */
+		34148798725 << 12,
+		34148798725 << 12,
+		1 << 12,
+		34148798725 << 12,
+		0,
 	};
 
 	int i, range_count = ARRAY_SIZE(range);
@@ -780,9 +786,9 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 	mas_unlock(&mas);
 	for (i = 0; i < req_range_count; i += 5) {
 #if DEBUG_REV_RANGE
-		pr_debug("\tReverse request between %lu-%lu size %lu, should get %lu\n",
-				req_range[i] >> 12,
-				(req_range[i + 1] >> 12) - 1,
+		pr_debug("\tReverse request %d between %lu-%lu size %lu, should get %lu\n",
+				i, req_range[i] >> 12,
+				(req_range[i + 1] >> 12),
 				req_range[i+2] >> 12,
 				req_range[i+3] >> 12);
 #endif
@@ -901,6 +907,13 @@ static noinline void __init check_alloc_range(struct maple_tree *mt)
 		4503599618982063UL << 12,  /* Size */
 		34359052178 << 12,  /* Expected location */
 		-EBUSY,             /* Return failure. */
+
+		/* Test a single entry */
+		34148798648 << 12,		/* Min */
+		34148798648 << 12,		/* Max */
+		4096,			/* Size of 1 */
+		34148798648 << 12,	/* Location is the same as min/max */
+		0,			/* Success */
 	};
 	int i, range_count = ARRAY_SIZE(range);
 	int req_range_count = ARRAY_SIZE(req_range);
-- 
2.39.2

