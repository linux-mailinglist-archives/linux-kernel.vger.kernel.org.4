Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211386A5C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjB1PiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjB1PiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:38:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DFF5BB6;
        Tue, 28 Feb 2023 07:37:55 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S6I6YE028420;
        Tue, 28 Feb 2023 13:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=xF5NE8Rq+bslCgh2SnoKUFVeH2z/fWJcA0jzMh7POr8=;
 b=SFK0NPWIfrbMUsaravFS1KQR+kQHzuWWEnPSHKJ+wPXd1nyb00ZnelX4m24qn5crwG86
 gNTaEwpWoZaqGNS1ANSAsdWv8K83f6oKoQHEz9qniRIc3Xfr/5bPH2QXwWuddtbDitFI
 BIRPgkadKYCH/NT+AuNlU0JllmEk1J5GXTttw26K6F5srhdvvCe2WwyYTqQBRHeOmctO
 zjyh9eVUROkHcmWYT/VJRxynKpR4i2yq51ycNIYqbnzofA35f7FjewiEbx4HTt7o9oNA
 8Cltp+81g+mOfEJ49+sgrNCCP4jUA9Roi+6Atvq+4jIQYcjWrkZb41jwu3F0GtYMz8SI tw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72e3rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SBrnwN001235;
        Tue, 28 Feb 2023 13:03:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s6gg53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKwM3OTx89io7DP/e/7u6xDSRtPJmI2a3+MllyRqfiGBwlHew5j49O2AVgMWo0roWIzmD5fwFcxl+GajvRmTv0l6GGuqYC/6m9ByFsqagwkXA4v+gZvrWyhSediRnX8kjL1cM82opC/X/qNfwTKzrU1+Zw0pqfJRbe38dl1pV206lPiisC0Nd0HYA2QdQoRqFuUL69cQ8Re6YXzHuHHJv60C6A46rhON7qBbTZKsq1y3HdrIMTijwehRS1XNv+5kOXPrDv8fN6gl1+ETy8SC0CkOGJxWoI6doVmK+ZlxskZI5m0H1Lv8wpK9gvuhCH1uUW9fYum8DetGRMusCjRNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xF5NE8Rq+bslCgh2SnoKUFVeH2z/fWJcA0jzMh7POr8=;
 b=GtEn00NTl20L59Scy01yM3Hj+7bcz3kQJAGeZB9VxPgxEaHzRrrak7F/2BhQ/aCBQ3HnXpkUoXAY8ClEcPwie0g3L7ilr1PdyD4UxUkxpUJfou9U5q+6v8hfU83sXy6enQQ06cxftHaafcDfoI4weRhINgwTafOPpzI9amen28mR3fv2NeAeApzce52v9M6hUjt7cKCpJFEiY7tQyu0qswiYoojwRpxFp8/IIgB2aP2n7ZWpTqQGgmay4rcvWA5ecQWWZXr52T+TABmzogpbGxNLmRF6RglMAn2Nz3aCGWS/CJPZG1t7cQQ/KjhBw190qBQkXPu2dopCxgb9z5LnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF5NE8Rq+bslCgh2SnoKUFVeH2z/fWJcA0jzMh7POr8=;
 b=ARS9m9NaC2oJqdARegH+fgCxiI18tdBkRvXyNkO+Fht+qpMLkYOIyQ8qxebtz4MgbHGNO5U38lAJeQ2wfNWU8nGaH6Xh3bq2VtnnVPziXKPXKFlfZuqFX82JlyJY6Ci+OaoB/k5VU9gt9nYUQs1Y0kGm5PbJJNHxoyXEO0f63nA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Tue, 28 Feb
 2023 13:03:56 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:03:56 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 20/20] soc/tegra: cbb: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:15 +0000
Message-Id: <20230228130215.289081-21-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0113.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4665:EE_
X-MS-Office365-Filtering-Correlation-Id: 927700ae-1eef-405c-5d15-08db198c3fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfeHC+q7KTciOEHRf2CJ9jtOPN8NgfwjTw8TZrC34aIDzHajGZ25Gu/xFc12xRtsQDKN5teuPnB1IWEN8kqLtqfDzv8CpguV2XBR//bLvYykUEp7xEcZ1dPv4P1I7G9SEZN+TnyVTtPxrTtsWXJoHe/e7jP3eBhsj7DvKaOOMgvGybM+7T5FQUHI3jZvfU/3djVscsib4qLIwqWb7+YMgI/YwWD++LYGlSjEXLIstiz8W7VimNBoduGyj5ewwiTppDS9G2a8tTmR22L03oY63tYFCIyZXuoGTQrSxFcPU0ZEP67uMDdra5/xA52F0fUFtOH1kNqxMRYFH2ppchcFdFfPSA1kHuEZ6RYVAW+9igGaVsbBmy9oyuhlJBRfmHmom74yayxseqDObz6atMvVMYPO0diH4fInW6JGDSRowkOELfqXpwOUubdsfLoyUreSNHMQrlzys4WKD0zy1MW+JVL8zep3zW/MGmRUDBKWqw+IvfhFep0H7hRT0neJjxnmw6vX/Nh9KBqkWVOle6sglqeBtZ4ZloMILFNcbi+h+pz15+57pt45FwlzpdMd/xWOHkezSbayYdOGq6hYTVqQaPSYf/S2CVS4ZCrxCUmlISx5hUfyIXNmpfHowuuYl+wNtEHnRKBk0sHLb2ecFGwang==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199018)(316002)(2906002)(36756003)(44832011)(5660300002)(8936002)(86362001)(6512007)(6506007)(1076003)(8676002)(186003)(66946007)(2616005)(6916009)(54906003)(66476007)(6666004)(38100700002)(66556008)(4326008)(41300700001)(83380400001)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yC9cXXj0SPYsokaG/ZgsM/L1NgdjkGFdWwQG5DwJ2W+8+0PoswELe4Oqczb1?=
 =?us-ascii?Q?J0f/zBTQX+BaSJWs1B7NdwyXGWFAJRMnBO9w0JY3ZU6fSDmOUk61nmsyH/YR?=
 =?us-ascii?Q?e8kd6n6Y0hmszMBPz8qSJ7UYRx/tqfBQ9QfxyZ7PyiCWDhQV0uNc9khcC9DH?=
 =?us-ascii?Q?03rXlx57XzY44Ys/H/ew8Le+eV2pGg3jYVpp/p5NhBBJGPXyssruk/BfQxPP?=
 =?us-ascii?Q?zuOHVCPhAd2jSOyjcFVc63BxTT/MpWseDSTBL/iAZ3s8JP5VxRz6xQiRczEQ?=
 =?us-ascii?Q?u54jfLDvtAX7dweyB12P2KwrQIZmIN9viEOEN7PVDs//PD2+ZHJmrzSIQtPs?=
 =?us-ascii?Q?n9t1k9XnQK6meCmJYlp9/G1Dz8b0df2z+MQ5ki/qh/JpXSCO5uv7Y57JV/7l?=
 =?us-ascii?Q?v6cTMhsdzWuOtwjFYpXKXV3RVUM8N2djTPyCSGPE2l1YOlWQSEFJ3kMqWu59?=
 =?us-ascii?Q?qXXFpyK81iPWnO58sLR5+LgEc7D+eL1/lK+kgM/aBhXcsdIQSG7rtIgv07JF?=
 =?us-ascii?Q?4g1df37QCs9wDiHgdTOxdHDSxQw7nfPPFYwemjKIdl28mRo4CiCMBZc2eGR+?=
 =?us-ascii?Q?wcT3IjZdg6Ux8fFNKTILY9mtjluQGFgKUtNXiEjKIq1Q6KnaSq/4V1Yi2X6d?=
 =?us-ascii?Q?8MNOWEHrpdQfyltZ0MUPOBeevP3s2dqo80UYEDPv3SqI1CbXyb6UjW+cT222?=
 =?us-ascii?Q?zDGYN+/+VlCHXPqnVHysUuId4u4gi++Pr8FMLiBoqq2sXFY76tmFJGg99ta0?=
 =?us-ascii?Q?sJqGtPss/m+7itzRI3/C0p6NMSkeNtdsBTOtz6ssEilZqNjQWGTrIXt1lss6?=
 =?us-ascii?Q?F2BUGD5JKGs9Oy94+eLoEEO/CON2oQDQnvUoH8r2fX8ZtBlleTDtX0rwhkA8?=
 =?us-ascii?Q?O0zpNOexRUaH7V/6VfJJ4JvQ6xM1+S2xgjEIGhsWs1ntxTgDZu6n7rqRaT0T?=
 =?us-ascii?Q?f8Krwe4KqtLTRt59Odr1zhAv8YLs+4WQDI7jOa9J1Uon516Dug1Z7bMQPqOt?=
 =?us-ascii?Q?1vaiVlwpoXJo0HKC1EFJG7U1TLF0cdPuLRLlx5bgb86YrnrTJUMg+ZN3MW0n?=
 =?us-ascii?Q?u2cHmRe2vZwasY+nICFoGgGkNQlAHJhomBgJjHOE8O72cXxz8Ry8nA+RDDJs?=
 =?us-ascii?Q?az9CVf773Qo0AhvQsFPeeDjn3L9W9PfgM2M9udUo00VR6eqGHJw5rwfMN8QX?=
 =?us-ascii?Q?AA8QedMvGAWYSfRttfdEqXgtOKOio0roMpxSHToWyHXEeCW1KqXGCoQ8u5eK?=
 =?us-ascii?Q?6V6zEt/Y8FFxdjYUgU56+Iu7GGF7Jzism6GVdryBgdVLavQYDs3FtVYW36uT?=
 =?us-ascii?Q?bg2OHFOKIUohR+RMUZIk6wKidrWoaUPBtgnbdoUSD7jG7X/McixHDILRRYbP?=
 =?us-ascii?Q?FqVBiDgabnBajLPA/BAn2/2L+9DqIFUw48LhfHEORbS0PzNB0SmsKbEudqaj?=
 =?us-ascii?Q?WkM9chi2JQ+C6ZfnJk1z1qTKBK8ShKUdtVkPZepK18wnltd595hBSIvYgscU?=
 =?us-ascii?Q?fICwn5Qsw8K3nvRuNOVcL06Pp3kL1QWzZhNkIsco3kZ9NXHh28vogZVKc1Li?=
 =?us-ascii?Q?NuDSDzv/7bwWN6Vyyb4dzwLXEpSzkHwfIX7+lgncMaw1WIRjwZ4rmmSimqJP?=
 =?us-ascii?Q?UQLU+aXf1OHXqM2J/Oqgb2w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uetryF6JdfnOIrHHP2PmltYTmyr3M7OAJ9vaCwM/y4EmfR0o2sExMmfs+lFjw/JgomK9p9MPXxIH3kqr7QBEFt0FMwNAio7JXhzeXsVLgSh9N+n59S6zzJ3HvH8hVrSHmN8yBaqWMiJVtv0yq2pJQZIWh7stTe8zjzI3ngZ3YXxiGboux4NB3QhbH/xgn0oyKvYaW60LJqhk0+6Of6/gndF1Ntt59R1wsTYSTJaIXGPXMwnUBWdvI8YdJiD6WfU2EO3W0KfHARHgUnGLqgAiqaYD6/gFLRZ5c9ndOga4W5tgnoPhw7BdjsTCq/krMhqXdY1r3nGTjc5vZF0RZY/8b9Gzff4uecgWYtcl64Ac2OCNL79sgK4KUU1twYKsR4iFTjpDapqYwIZxpXYkGN7WRMllb+KMgcQG40EnzSP3b94YNLdKjrmCz+ROy/rMpZtF+GHmtIG/tZUk4iWWUJV0wMqTsii7EkGQN+G9r70aJ2MuB/gazkmWdWM+jdslR4HbzIXNqxjzfTKFZ7ALaNhzp0ECmAvxbjoAnuxJ+UjVcK+WSP9tpA1xO0y3yc9hEbWRvR1+XpoyAny/ZlAZO3fBfajUiDKlljPPKyR5Ly487ub8tZzOIdswlZCaRPoxgxWJQNCFp7Z8OO1OO7zg4Ut0fud7o6AWVdZ/jPu/Y1lQg6znBzJZJG0x8AI7udoI/nye28UvV/oL+7IUuu7L1csPNi51CVtp/lEMY+84JD9Sof53opZ0PnbMSm5Yg/kZ0LVK70BewqnYX0cHoLlRvZQ4KcBHJ+gHrysj+EPeWgXqCYjhqEjFJwXMHnbbh8nXDBoL0VABgLEZwnU9LPqZvWDnMQik9vwoZsQCPpd1GDWFaSHeYxFGPdbCJ3ytFAFYA9+t
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927700ae-1eef-405c-5d15-08db198c3fe1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:03:56.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7s/kEl2JMOM0+c94zUbBmazDDFhbvthLBz+IrMq+8Xk7avNA+yIr0l16NeQm1ZHQ7B1J6p6EXxIwyCRccZctQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280106
X-Proofpoint-ORIG-GUID: TK2GnuY26DoGoAuANXAvAqfI5cw2nMcD
X-Proofpoint-GUID: TK2GnuY26DoGoAuANXAvAqfI5cw2nMcD
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
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
---
 drivers/soc/tegra/cbb/tegra194-cbb.c | 1 -
 drivers/soc/tegra/cbb/tegra234-cbb.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb/tegra194-cbb.c
index d4112b683f00f..a2347e5b7c00a 100644
--- a/drivers/soc/tegra/cbb/tegra194-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
@@ -2359,4 +2359,3 @@ module_exit(tegra194_cbb_exit);
 
 MODULE_AUTHOR("Sumit Gupta <sumitg@nvidia.com>");
 MODULE_DESCRIPTION("Control Backbone error handling driver for Tegra194");
-MODULE_LICENSE("GPL");
diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index f33d094e5ea60..7268bb7ef448f 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -1218,4 +1218,3 @@ static void __exit tegra234_cbb_exit(void)
 module_exit(tegra234_cbb_exit);
 
 MODULE_DESCRIPTION("Control Backbone 2.0 error handling driver for Tegra234");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

