Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2906675BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjATRih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjATRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:38:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACFBDBC3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:38:33 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGE8WH024790;
        Fri, 20 Jan 2023 16:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=qW75i3gO1AL14UINgLGt4T1VtHbdI7RuZfXcZaqf/6M=;
 b=f9mnLy4rRcTz+4uh+LkpFJ+/CpKiD1bt35MaKJZLYdHyikF+ZwdpgOirBuAOr25m8KCc
 0veAfghFkv4Q8yf0ow2lyIjg07egJ6auEft9PWdKfSUGxpPuV+8fThRVcyOKT5iYM18A
 mHSzSwZyc/0ninp+mWGMAp7jKF7ZMyPkmJ3Y9JZeE1IFB7ht5aIGjaA11nBe3sJr6Lgr
 sRGQk+/s8AIkbkkNdpMliN2thaFRFx14py313bsHTyjVYTH4huvAzxVG3s+4MIm2qvL3
 lWNJI+hJAvo6A8OI5n2GGAWWMKTIw7RI3VnxbykuduUKiK+bAbwZHyP+A6LaXMAiEwZY /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k0154dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGNOdL004659;
        Fri, 20 Jan 2023 16:28:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1gdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoHB894K4QwahExrL9iFn/9eKZrnHDE+/fOXzCRIcuCpXB4jLhw6KfMkzkTk6yc5AUIZzD2uP5MFzRhvvYhFDB2Ta6dsYgfnqiK5oZ1FM+OvZVhoUvbUGFoOZsX+rdtGkuJURW/El9Ypaux217gmfHds1tx8Ypj8bLStveWTmof4qezgKljHfdqWpFnf/LiMj1ROlEmB3dXXeWAbuABSXbng44CPtQ8UClR75GMsQtD6+gXiak5LB+4wyW1/8piq4Y5IgO1baooyYMKOmNX1AijbdLOpMzVDx/lWr5UgC9cciFOzyFlnAwVUkPsaqQoEJ+mQZHSJmLU3z8kxxR9wwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qW75i3gO1AL14UINgLGt4T1VtHbdI7RuZfXcZaqf/6M=;
 b=W5pLIscdgARAuh9SflbpSd26a2RwWRopbOgSWQqW2sKER6Aq0deGXrpslfB9b+NkKEMpYE1M1c/qWQch14mAWMHSiFT9YksXBGZ8gNavW8A8DSTIz6ImoftPCbcibrmZfu5c7+wl10vmfAhtoaL4gbgA7NmDI3APuQIctEAwDeFSiTvXWh924GoINrB6vcSoCso8JBu4RSXRbKcTqumuScnTsUpVj/MGT7sHZCy6w5hQLVDVeh9JQL/2n+RDAKIZwTHBs2c5Yt8ORK16pI7U47WS3cae2pPSiVwrDrw8QhbcHGZXc4PR5BE35qeo7UVneXkFpRRb7PLcDtCgwRRnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qW75i3gO1AL14UINgLGt4T1VtHbdI7RuZfXcZaqf/6M=;
 b=V/BOAPYlhXC9ALADKfkh+2HBSPWAYnLzHXNbBWz10fHvnlR8NCzIhMuehFjs29vpg9gMWhLD0SVBiA901jG8Nl9EY1mPN6FKZbnjPE6FoMDF/wR6se/7ZIvtQnuLuDGOVeMDqkEccOXEBc5ZFb/Rp3iyOYLMbOH/dmOBiJ/1K8A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:28 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 30/49] mm/damon/vaddr-test.h: Stop using vma_mas_store() for maple tree store
Date:   Fri, 20 Jan 2023 11:26:31 -0500
Message-Id: <20230120162650.984577-31-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bda718-6598-40ef-7881-08dafb035cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwKra2zfAXJb4JvdeIH4n81uQ+2dNekujHQUHayVH9UUAS6g7pWbN5WjOf0zYZHd+Wm+yLmZK/SNBY6DgKMJZ3V+T1DI4GoU/J2YSTe+EndRsUg5xkWVAYelHZnRyuRwQ00MZAsl8UgbWRiQPpOx36p29ZqktoDwN+36Iu+lwNBIyyK34sFf1xTfcD9IM4gtSfSwfNAxUEEH4vKRpRLPbXV1/DSJVQj3kWOWMV5wOLYWORD6959A+gVr6nAGJeaDIlH/VwPTxtj+xnYy8WnFMYppVYtPufGHRUMYZo7sUHcHEk5SXt1XjO1QVicfhVpr8dqAAqzzJdsBTicTNLYfShVueEC5eQAUTwTKywf2XzU+Zh7Z+iJge4mafc99DSZoaJTdP7/bQSLjDLlsYfOPxB1dmZ5fKYm+3TUx2LaEHD17qRdRs4W9qsgMHSPUGCOJAheJ3tsxMElIJgTjSa7QP9RNproIAI2t3xuJM50AnyjjPeMlLpFWXKv4xkql1Ughxe7NIcNyl4TEi8WBBLL+xcQ8bBJEh8t+3g6Cqfw/cbJvwJVU/kYxjOFm/hz2hDpQwxVSIfZ2dL7vHGMC8BPwXebhvGc2usYT2PUUI6a6xS6brTYeSPkWUgSftSZ/aXVQs0AOU/pVOtEGDQtyaQLa9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(316002)(26005)(54906003)(41300700001)(2616005)(4326008)(66946007)(66476007)(66556008)(36756003)(83380400001)(86362001)(8676002)(38100700002)(6486002)(6666004)(478600001)(6512007)(6506007)(1076003)(186003)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2sk2EKZ9Uo93vIfZlqHwOyIhKOrHa2I0hjbfU813rtkWt0GfMX505WOCilx?=
 =?us-ascii?Q?1xbtaHLA9gwam5FwnOKPkwfSOhUpqm88ml/fCXpW9+XYHfnnZxtNTaFjcONV?=
 =?us-ascii?Q?hZGpXx4fA1+7dgdQl9IvpOOnoCs6yLnaaPPrVbNRnMsdg5N8FAdAQ+hUE0a1?=
 =?us-ascii?Q?CaNy5gdUr2aXwhLzqH4iQcS4KN94S0XmOGRFsGu0zM3XCRx+EWSLAyn50MqE?=
 =?us-ascii?Q?irGdVHQ7quW4QoCbjaREYY+fxJiRBSIUz16SWb7o1qesvLyROzzLNEg7n7NR?=
 =?us-ascii?Q?MGceJ69/ZbxkrS9BUdAB5MrAm6kpYjMUOoWHVLczYvQUq3M2A2ARIJ4l9d7D?=
 =?us-ascii?Q?OaBm7PN5AgeWHIN2hHmf+xpf2/qTnSACk4WdYJoFaX3L+SlWER1QPKama9Sy?=
 =?us-ascii?Q?UWXf9bel3qPOOYT12eYsPiyHao/s72qAlb5SWWgNl1sVSI92KKYsc3MTdSjx?=
 =?us-ascii?Q?Q5VHj/6naVxmShDDDrNUQ8mwZuV9Ld7cEDftF36pBEdZLvJ205nbK2cicJb8?=
 =?us-ascii?Q?C79xIJYbJ7pHvLbJq4SOiV1Wl1gvVNcPeZzLs9wadBfT72+TdTrOkJWDkfCb?=
 =?us-ascii?Q?I20RR2nbBm3WsFPW5GfzeXCm3fQ/ASNhgOd5K9xRrQgbylqKAsxhtVjWVbA5?=
 =?us-ascii?Q?QtAIq/bssz4DIlWfK61nb+oIZ+u2klG2MEmUyk+bXXeczEEOYbWJEy+9xWa+?=
 =?us-ascii?Q?sLgTSDr2dQD/qzn3QNvRv1EaqlTc9gV0oKEJF0EWHByY6yvgfJGRyTcrV4ak?=
 =?us-ascii?Q?vvjP4RqZpAOCfYXMaZ4ateeS60sXfRcRXGIqFvh0k15Aq7aQgQqm8AGvt7Ge?=
 =?us-ascii?Q?axsoOG6Z6YlsHY0jci01gHliAjwPz9A4GoRen5JKC8JdkBFcxzCUHNwF1BWr?=
 =?us-ascii?Q?GMQXS4T0dPJE2I8ArNKKFSfKEhgq65XNkepSB1bsyxgVIFXCG2S90qSS0yXA?=
 =?us-ascii?Q?3m1AgnE95KrKg+XCV2pAMBhpBWL3Hi+PwoyMx7gVJ2R/w8fj71RosqGMm9Py?=
 =?us-ascii?Q?6GwqSEge7JaCQF99qy76R/L/EPsfXul/jnaHK8bdBe9iwpqUBJpePLzBP9L5?=
 =?us-ascii?Q?hbOLVvokRG2hTLGZUPOb6rUhQWQybOZKmIPuji5fP0iAlw6sxKmxD4zLRuNO?=
 =?us-ascii?Q?1sbxoB6Q1NuwHywM+ZnZt05SOZ+10CnSGyUijJS2lavGzYpHLpXPKYlwblqA?=
 =?us-ascii?Q?g/RVpWk6tAqIsZNi9aXa4yBNVPeUUX7YBFWbgUjMhwFOL3GFuKog+Hwu4guh?=
 =?us-ascii?Q?IkgMK7wxW5WRz9nCXc1ImYQVG9umKT2UW+67TXsg4jAU0zLgLwJelHQaTAwN?=
 =?us-ascii?Q?bzBtznbTik55u+5sDl58yEIkDxxQFM8H2YOBNUwr6bHTBcvIfJGhN9O/arSH?=
 =?us-ascii?Q?rowFi8h9ikRh9jqbhoE2fG7xTR1zguWxblFm2dy7xyXjkWJEYnucDWesm8Ar?=
 =?us-ascii?Q?wWY9ZAcvouQ6eJT2nYzmahHvCSull4xqe8BnYD4BM0gLJIZcTIKJKpTUSoLs?=
 =?us-ascii?Q?1aJYzbq8+A9GjBz94l25Dd23hySl6xlqkaKKuZpp6oRUpAIIf4y06H9ybZzi?=
 =?us-ascii?Q?hONpSGEvMR0NjmDOObPjQmAdnEn5QYgMyUyFRydJR1nLv3Qx8cnnJMhDfg/n?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0il650yBtD7VVECLXg6/RPXCWH4u7w/zlhXfyeUtN+3K2SiWEo13YsMIiPRb?=
 =?us-ascii?Q?+f9NYENy/fqRIbGJiSZqUe+xNIQz1hgLssLCHg+BUKXctaiciDlI/qvAbeO0?=
 =?us-ascii?Q?udNrcEQBO/vbsXC8CzgoxsTCzi4auY/pBHaqKM6KUBIN7a/3P2Z03Yff/OGF?=
 =?us-ascii?Q?nWj0YKIoxHQCP7R83EurJ4cxnpfj96CW57xBxsV5ZLpXZxBbtuG1jCk3rMWO?=
 =?us-ascii?Q?8IYRlA/n8d9/AuYjRv4yXbRox5+4EFDgcyI1WfBltHm3gmtYMM7/wrYv8mtw?=
 =?us-ascii?Q?kOaKZoXovbWiz/O2Jte6wBat/E592g3Thg5UQM24UBH2wayS1oXIj5IByWTt?=
 =?us-ascii?Q?dqB9xvTbIFTvCeUwDV9by4p1DB8VpS0Bkuw5QQa0D0Fy0zwTP6VoOFMAYaqm?=
 =?us-ascii?Q?CTeQeXvcqEtdQHCByEzVHlSh1/VuqQpZSsbtoQxj5wGCZLwr32pfAph4joQ2?=
 =?us-ascii?Q?vXFPuPE3SFfeI3ETpU4KjoQInRgk2EHGGBQZgzUqO6gHNcFEF7CVUMSwfh0L?=
 =?us-ascii?Q?7QXuP2VVT8iEViDNT41unifsF+7FmtbTTxtAeARlECp01kjxyei43an9nb/O?=
 =?us-ascii?Q?LnsSHmKxcsXoUJdtw3xPpmGRx048/eU8+WB0NN4j9SBh5jceReX/ltWGmc+D?=
 =?us-ascii?Q?A9HlpQYzrac2909P82vCuMgCjqPx0Tll3UFJRpo69AbAjmimjmh1RMY1Vud8?=
 =?us-ascii?Q?sn/BQSo95/OlRP7wioYkfdezP15YvH4SnU/whlFWXX8LmosWglmCG4FDA4RJ?=
 =?us-ascii?Q?Wj/svlD/MVX4FKlmOFmNy9SNwNGcXhNU4VBxhmCLZGk+jJ6r1AkeS74ThYtf?=
 =?us-ascii?Q?TvER8zoxh/HWQlK+mwG/42QW9ii+nyq1+oj49jSYO3U9iMCrE34tTdOrw2zG?=
 =?us-ascii?Q?0ACkzpud0ViWDP38V/whFqIvUwJNBMCLAJkpOiGxQfCCkiKTWNMEaS+3eod8?=
 =?us-ascii?Q?7f/hpS1+4dW6Yu8Ewj8/eENz0lKIvdmezuXg4rB1HGTsr3WBXV11GPIZmv8S?=
 =?us-ascii?Q?kUHN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bda718-6598-40ef-7881-08dafb035cd7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:28.8538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h89grnbE46+VW71RpZPRbqCV5YJIAc4hSn8lr3we6MpLoX0/ospOqrEjh8RIKg6opAJuvfFddVqqEvFP5IME8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: Yir3eKu-FTDfnr3b3AGrDtg0yo9fEHvR
X-Proofpoint-ORIG-GUID: Yir3eKu-FTDfnr3b3AGrDtg0yo9fEHvR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the removal of the vma_mas_store() function by open coding
the maple tree store in this test code.  Set the range of the maple
state and call the store function directly.

Cc: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/damon/vaddr-test.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index bce37c487540..c4b455b5ee30 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -14,19 +14,26 @@
 
 #include <kunit/test.h>
 
-static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
+static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
 			ssize_t nr_vmas)
 {
-	int i;
+	int i, ret = -ENOMEM;
 	MA_STATE(mas, mt, 0, 0);
 
 	if (!nr_vmas)
-		return;
+		return 0;
 
 	mas_lock(&mas);
-	for (i = 0; i < nr_vmas; i++)
-		vma_mas_store(&vmas[i], &mas);
+	for (i = 0; i < nr_vmas; i++) {
+		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
+		if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
+			goto failed;
+	}
+
+	ret = 0;
+failed:
 	mas_unlock(&mas);
+	return ret;
 }
 
 /*
@@ -71,7 +78,8 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
 	};
 
 	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
-	__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
+	if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
+		kunit_skip(test, "Failed to create VMA tree");
 
 	__damon_va_three_regions(&mm, regions);
 
-- 
2.35.1

