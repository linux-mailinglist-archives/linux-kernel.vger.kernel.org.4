Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785296A1E30
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBXPL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjBXPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:11:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4186CF25;
        Fri, 24 Feb 2023 07:10:39 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEoA0E008485;
        Fri, 24 Feb 2023 15:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=qUOu7ZkR90CCRUAP8ZKAezDONFH1ftTYXG7o9FuDeO8=;
 b=Uvcgedbxgb4QcJGuUtniM/dw2qgPtOI2yDvB3iXqoqLcGWbgdunzwk/XNa1/tthf5bc5
 hs+pXz/vZRpip36+DxV3coepl0jrfuHzs+ul1Ser0k3FB7eeVXqBR9z7yJUx3IsM4s1Q
 AvHDmimSAwKtF7itsUsbtD+t8s+Y95yCYHjI6Ln/2rag6oLm0JdkLLnVIWY3GERbhzTu
 vBW+faq13CK0MYZ3byxhqOq7jdQ0ITh3KRbau//UQeJnRDEZL12i6PDm0VLBjd7UVNjJ
 Ss0ip5p4rwPUbWRAN9rybMF6TZcDdCUp48vlnNpsPPFa41AQWzafgODIN2HDDZZpEvV5 5Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbw738-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OEkZBJ000677;
        Fri, 24 Feb 2023 15:09:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nxsb4dupn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt8mF3kdSeO/TGvGmrbnc0n3RHgE4IHFyH/XpzfKGu7sQA7FtBFdemUMcTuMLyk23OInXjRFW1Wnm7Lhh3sz9sIX+yJFxZiz84ZcRG7vEbjuM/G+++FNVxKEV8qyo42aaA6l/BhuwQp9u+3+UZRv2A2/999fGmjCgXLMeLe74s3ytWmkOKY1ebb7pQBy+5SvC2e3n2DUn4oeQCiyc74QAG0Hw/bMEGd5z1K82dXfVXNTiKUjxbgf2OSfEyMSWKPj0QApYwRb8wXCcAMVBCBEjPCopeOcJ7/2RKhRLArixufWB1FsjWLQnhAh8q4w3vhZAw0MXI/fhbbiMWUaPcs3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUOu7ZkR90CCRUAP8ZKAezDONFH1ftTYXG7o9FuDeO8=;
 b=fdfBZpGGBPqnkcr+f/n80TQnGZ7baH9hOZatPD8D6aHNvRZOB80ASl+OABMfxkmbLYe2JiWrb3/yOxBkn0BGj3Vu7KMhGOuxm6lj3HFBD0m5mf7gsQjbldxSatoZ1UYbUwA/s0w8/0NLOdhVOYoy3v8Hx6lDi2/Lw7u+FLY4FhNhN/zCWEzeHReePWZnabtRwk/N36VDUJHtVY2Rlbku5tidoa8+dY+Skgdz16PO9VUfdaJW/uqZnt0bni9QPmi+UtRLehvSPE9M0Gl9jbDDGgDgcnOFBQmM/v2SBZXsbM0GaF5CXgRVeMdJ0CQVgdvPwK1OfeQ58r9wPD3HNnWPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUOu7ZkR90CCRUAP8ZKAezDONFH1ftTYXG7o9FuDeO8=;
 b=jv7alJh23PPKkaGYvx//RCKOFTpiUPQg2nKd8AnqpVHyGTHSa+r+Qy6nT6nUDcrw76hiWahejLBdXSo8pKRgLjYT9qMyRXMM0PzXVvOgTNrAaJN8RxA+U54vYnFQBvoo6Fnh4FKtdgO59PM+ytAaa51XWFOKj3+QTDjmM6liacA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH0PR10MB5244.namprd10.prod.outlook.com (2603:10b6:610:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:09:43 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:09:43 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 17/27] memory: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:08:01 +0000
Message-Id: <20230224150811.80316-18-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0438.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::18) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d2a79e-d22d-4fd7-681e-08db16792899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QODKDMdN85LLfS3Vof0mt0aOCNxlDutGfdMbQ3028UxCikOZdZTNvgJqNtn2ObD8CENAutMrMwb9Md3bqp5zWY9yPL2XFh2fWPOGs+W2zpro/7e4HgaztjAKD/y1QIakEdeoTi/tGcueYiRz3Eay3f3ckbeu95UhfQmeTVbJ4F2ifvWApGL/e+WxG1ut/5nEHwrhJ6gj48WjY5wuKXgqOxFFX6qiw8wZ6j1R5TOLJu99YWdIXmTOVnLPNFqzaw/9Pf27VTLMm9acI/rvYNtlt/mZNaWhKgltRr83N+ZkduQvzAR2sS5A1ma7vx3Zy/FpwLZCkWcUH/K69CgSsrikjEX9xxvSKV1CeQF7Z/LsxWsqhTy/nXqZ5Um9OcK3QQ+8HatKdJSLsJ8RQ4xcTUmSdhgEEFpi0rbSRQJaxwBD3Vl4+UT1uvVVNT8YOUaJYq7LgQIXeAihypigPEJ7k6x8tf706x8hyn4NAstfQHawhE+ZJu+H7IZKuFsUv/es9HcNAjZQdDFI7DoO1ExuMxQcWNCQncKuMZnm7g71sLYn/oBRtmi+yNRgcXMBX7ezsxehJQ344t5MlCxbIMcKza4n95BuTMWrUo0tG1rgd1wh/tF9Jz/pfoKThxJjWHXesXWLH0Yw1phJuSjFwYg+HupmtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(54906003)(316002)(6486002)(8936002)(66946007)(44832011)(4326008)(38100700002)(41300700001)(8676002)(66556008)(6916009)(5660300002)(6512007)(83380400001)(66476007)(1076003)(478600001)(186003)(6506007)(6666004)(36756003)(2906002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dPlgbVjem/P7mwQjMBh7Dq4YntxPsZgswbXZo+a42F34G55d6wyfWeWoFpcL?=
 =?us-ascii?Q?ofOlxRkovqSiObF/OPvKrP8+v31taBtD3iiZc9cYDc22ULH2OJsAsKYdvuGr?=
 =?us-ascii?Q?Br9zCYsXUwdsgqrtLN9ZG5b1MLxcmhBVaO5/G5qH0KCG0komYyvu5Hph9PV3?=
 =?us-ascii?Q?YsctL7TsFSidTx9ACSEWjr7qlAV35uGxPXEc+PSMggC0ylqvX2MRTbll43LQ?=
 =?us-ascii?Q?1ulrsC6uhZ2COgZ/Ogw+zgWv7ghNA4yX3QglyuNfmwWoWk8oORhJcOMZi+GY?=
 =?us-ascii?Q?IOMKzL1ttu+trTN55UILKrxsniE/880dBUC3jh7+x6z3PjgTmbfR4tZApwfh?=
 =?us-ascii?Q?vGWhAmbsFBVAunfBomSmLlyEH6TX7V4GHiiNoi4W58CEzgYSM1meSquYqAJ0?=
 =?us-ascii?Q?wAG2U9AYJ0UqKBbq+zbSJRzc1eTVnIJ9gR6x+eEaTeBHCtK8wmO1LLOGDO9+?=
 =?us-ascii?Q?5gWXW/RZBbme6AJ8QXl8cKYv9/Gr7d9aYqTsslFn/BzTfSnZAuMREeO8AuKr?=
 =?us-ascii?Q?YsRXdoaYMn3+3L66jUnzCNx1NHkvu14PPaxCte1iHhhjOimTNZ75d/x1a7rU?=
 =?us-ascii?Q?AJliQiVZylb9Z1wHNjqrtRQZKHLvAE1BhtUUri2SOyHe1gpbt3cbObShjyvU?=
 =?us-ascii?Q?zGMRvVQVSt3CBotD2w1XA3xqADUrvDxeKpReuxJjUjbYwwFn2I8aAPjqQgMv?=
 =?us-ascii?Q?oqqHTJicC6p/5xFKHpsJgnbQI1/J5euGdsgvQA00WdOAFYYgySus0O0CGklL?=
 =?us-ascii?Q?dAK1N3o3vFAeMCH6/13R0w6eOks2TChyq9OmcYuicyj7STiHE+ORBlD5hX0z?=
 =?us-ascii?Q?PQA7MsThmUN4+xCcqysVWPBIV1XzJbyrzgvNcLVKVQwvoITUw1HkBYDaSiiG?=
 =?us-ascii?Q?wB5jM6HBw6WMADwdUyynuF9vj9VdDxsRBBp1bJUuVjo87w7m4Kta+p2b9g9p?=
 =?us-ascii?Q?ObGO7L33fRpQ5DM84S6aBOccREA0XKfEExptLJGSElyWIRmoIA3zQX99oj3j?=
 =?us-ascii?Q?+K566KGCNZdZhs2m5Cr0AqSZyY6P2EzgQ+/97ov+CW+DjfFoo/w6/7wAGPVz?=
 =?us-ascii?Q?7tEvq8yMkPTZLseDhHZPoxEBbnl4ztraaP9qyJamjrvrKwBFgScL5Y6CImvZ?=
 =?us-ascii?Q?JEaZN2jnp/R2yVxFdsbtcyqBkWM0gK97pJUTGsdlwY3kDrbTvfIrkyzpAIde?=
 =?us-ascii?Q?qbTCupJAZb72mZ/eODPPPsQ5d37Fanl4LiB+pEuXG56civjAvJO5L4Vs2L9G?=
 =?us-ascii?Q?EMoPQExMwvfHv5YEnWgJK4osCMZLE14i8P9tmmww+tyGK4REm+SAitYL6/0q?=
 =?us-ascii?Q?iJey/8zC4D2nru46fhhosN3Dvqy8xyVLPUFslVk1sPPxe2gxDBewoyaL0UY9?=
 =?us-ascii?Q?4dG5MDAJgqUxWXiro72Vp9CYNd8KN2rteIwlHmY8Hqy5ORPCUNds/VjtDhss?=
 =?us-ascii?Q?fgjysAssaPgxOthx5bbF139PdK5WLth+mAIVDi/4YIGVvuEspYx+qXAnwkhT?=
 =?us-ascii?Q?kh9CjYabkMPU/Muo+I76AzhjpMfrZjAd243obXyGWGBhrUoKhVvg49YxzBVW?=
 =?us-ascii?Q?lPwcuadgnahHg7sKjA3Co5kxWYE4Qe0LwxmWPtZy9aM9+HGfQLxjLKSeYvtp?=
 =?us-ascii?Q?PqcrwziIqPj4PqBM8eNITig=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B1HgrHjbCpY+Vn+XgaFd/XAkl7miV1NIshtvR6pxpWzngPuQWpVCJfLJ0Z0hvYSFvLLhKsTZshIOSDgFwC2+GfEjA6qeY0tOfOvAIPzsZPalQPCnoch/Uvpd8rVq+ahQ18kh/5KAV8zgz2XnjFCq+PigIC1hg7DyfEhJ/dmHxnHWdtqmlZaMcO4fhdgrByDeJWpA5oMhznICTy/eDnMky46R7Ar9dadu7GHNLdEVu03fqT0v7G9UivLOF2jPJr+qQoMz4OzDHw7dxAoD5Qaw1h/f008mTnN2iq5K45P8H5pFWIjJuMHoSAE4trKVdI4Ipz0YxXR8gCON8aOwo6zSS330/MrYs4HzYpV+rS/bpu94O6rcJ5L+DweXF1DMtHViO4fEo2Sg/sDbj7UdNuwkkoUvkhNgTdoxjJVu86hWRpatK5HfUzbLMUBQmuQJ5hvcvD1mBhxfzuObq3XIBXXUOaDVjm6HPEb8XelysULapfKgZ97hXdnn1crPDQ/2BCoIl9nvlIRP2Bwy8VNQnxmD+/k08EzeuXodCcRzx34A2gaxe5VSNpHXE1nYbH1nfq17uat98SWNf+vfTUp4BzYRQ/01WYcJ2ejT0LIpJQZMd5OVXlOI4ZS3lHBQWy+0RYBv7l/Dm/SSJfFAOmnC2UYhvYYvanTquKu0zAQaxPZx/EN0LB5ezqACGa3jPSml9jMm1rx7nG+0rhCVqWazrN/q/TqSg85okXo6niGvfXAtbJHzQVaPxDz7Pdecv5EhKJHw37Aop5nWmmkG04GCOjdvPQ0uyU3EBpTe/Nf32NayWVMBqdvDLkjj2olmlTifL6ZAvZovO7e1ed/XhinPrn5jqPuA7nh7DaHRBAIaefZZ0F8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d2a79e-d22d-4fd7-681e-08db16792899
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:09:43.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psPLPezPQRXtg60Lej2+7dOV3dYZSQV6IgWXk+c/Pv60T7sH0XSSw39XxDFbrhoxqYL1COk/v1ntsGB2hfnClA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240118
X-Proofpoint-GUID: 3yTmpsTJt_DjPDYIdmj6XM0obo5EsgcM
X-Proofpoint-ORIG-GUID: 3yTmpsTJt_DjPDYIdmj6XM0obo5EsgcM
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
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/bt1-l2-ctl.c   | 1 -
 drivers/memory/da8xx-ddrctl.c | 1 -
 drivers/memory/fsl_ifc.c      | 1 -
 drivers/memory/mvebu-devbus.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/memory/bt1-l2-ctl.c b/drivers/memory/bt1-l2-ctl.c
index 85965fa26e0b..78bd71b203f2 100644
--- a/drivers/memory/bt1-l2-ctl.c
+++ b/drivers/memory/bt1-l2-ctl.c
@@ -321,4 +321,3 @@ module_platform_driver(l2_ctl_driver);
 
 MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
 MODULE_DESCRIPTION("Baikal-T1 L2-cache driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
index b32005bf269c..0ef8cc878b95 100644
--- a/drivers/memory/da8xx-ddrctl.c
+++ b/drivers/memory/da8xx-ddrctl.c
@@ -164,4 +164,3 @@ module_platform_driver(da8xx_ddrctl_driver);
 
 MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
 MODULE_DESCRIPTION("TI da8xx DDR2/mDDR controller driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index e83b61c925a4..9e8d8e9c5ad8 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -327,6 +327,5 @@ static int __init fsl_ifc_init(void)
 }
 subsys_initcall(fsl_ifc_init);
 
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Freescale Semiconductor");
 MODULE_DESCRIPTION("Freescale Integrated Flash Controller driver");
diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
index efc6c08db2b7..406fddcdba02 100644
--- a/drivers/memory/mvebu-devbus.c
+++ b/drivers/memory/mvebu-devbus.c
@@ -341,6 +341,5 @@ static int __init mvebu_devbus_init(void)
 }
 module_init(mvebu_devbus_init);
 
-MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia@free-electrons.com>");
 MODULE_DESCRIPTION("Marvell EBU SoC Device Bus controller");
-- 
2.39.1.268.g9de2f9a303

