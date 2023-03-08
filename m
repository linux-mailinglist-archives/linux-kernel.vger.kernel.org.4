Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821326B125D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCHTqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCHTpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:45:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F298974A4;
        Wed,  8 Mar 2023 11:44:56 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HikMw002833;
        Wed, 8 Mar 2023 19:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Vfdit1UvAVWvNBjlQZFiEsu43oPyGguPJPIRIefao90=;
 b=tcxcwiZRb1zHrOjomRJeHoo4dbc5+fypLw88IbBFKnAnK4qeFWDAj/iRvPOVmkBDGqKW
 OjJ0XGOG2D/425I4lZzW5qNSY1SmjEtRfeGxicBVK3c6yD3RNzUEmkXs+cTzrWsC63ly
 YsM+mlVEhzgZraMhRoM6XKk/ugeLS2GbHh3XnJB3rP+AHNdQFx1FxKwXgHOwdCX3UTpQ
 eFOP/9iK1hlRk/dOzHrwibP+6ms5eFmKSx5YNK6NrF1/8l8cb+6H0upJtzocygmexLCB
 WCRNpH8+3p++xR62HPcY48Kxb5lRH2AJvizqYpWwhY8g0ihxIAe0XB9fnF3uvc4EFW+J Jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418y13av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328JPSkY021689;
        Wed, 8 Mar 2023 19:44:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fr98196-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrCHPYtcFT7vUT3Slty141Cqu5U93LlNaeTcIFs0lhvmFuVLCezwreR1hW0Y+V5f1kLIwW6gcUyNTbZwM8kBZcq/c/GTJqXYdS0pJLgIeWhANQoPPxweRSFAGwDByR2ArcOvE5n3VA9+BpHj7hD9zbazieBbirRehpSgAkZtdTCcnn6reznu+ZiZR3lANwUGmVfWJV4ZWgm0cRiy/rf9foE3/xxhASBpTiQ8xImf64kQ7jnSNgtI4Krpv1EjsKlnsYP4ho/E93/uPjJPtZEH0zY9wjGZQesHPjZDrSvHMPJ6igl2B4BNR4rRxX17NnYjBH/qiHhP2YVxTzBdB08MOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vfdit1UvAVWvNBjlQZFiEsu43oPyGguPJPIRIefao90=;
 b=GXjQU9r5jFfHFPoC1ZJI9nzJ083mb2tlTNeX2H4PtsYysvyEqlZh5JvgkixyTEadqESBgAK4y/++cDmby5Z36fEhbh9z7ofhKzaXNEJHUzaGBoEdgcfv1i43xLug2TWv6CK10c/svxPmz2IxS97i47BDesVccBqugpNnKxLkgcmgWCHh6WwHEHP00vALyll5Ppjady5OIw7Z1Cx20U0p+6MZOB8mHfB4RA23kIR5iXPyvTYmY1WI0ATNyArMyvl1oX9eNPsrC3BATM0tEaeYT39K1eefJ0heGb3EQwTE2dAVYgBJtCjLPLT3U48UyAwR9VBftj7vkpaw/TWgbJgVPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vfdit1UvAVWvNBjlQZFiEsu43oPyGguPJPIRIefao90=;
 b=mo99q12h3xQ3EQ4nNaRSOzbQQ5A8wR1iQq4tHMm5YuQxcgxeGJhEZQ0Up/Hm/lPU05ivf0lRh3MdjnPs570K4xR1gJ3BaG3Xw4LgBL9RkRAy4/tMaCPfo3RPLDxuqbI7wsJ5Hixm5RftJiTekXichxiwUFjEy37vtyNQS3zGrUk=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 19:44:22 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:44:22 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: [PATCH 16/18] mfd: omap-usb-tll: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:43:05 +0000
Message-Id: <20230308194307.374789-16-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0546.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 2daccae3-5a0b-4d7c-de75-08db200d8425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g64u2CtToLz6LqK2T0e6LY2KY7YUYFioJMS+kKbUlpsmP7/GcNfQq7rK3XRUMoTeVEbXZNSCjmYnVbr0Bdy6MGXD5K8QLmVJtfPpRjCxprDs9bu32oizYkcsqifpJnS8VIn7nW7t0IvFqjRB2/f6Py8/7see9SFTBCo0cm2eIPzEay0YYSBh8s16CAuSRDIchggmcMQbuXdDWgqA6m5doNf4ck2XzMRLJA8dI7sM/bheN9UTaqYzcbgtTkr/vn0RX+vVot6U9C2ThYxhu22ctOH25UQE/A3zJnybFmNsDdJFQYgMr6AkISh1i7lCpW19v4Szb0dZk8qqSjuxeOH8IbG43ktOT2lo/Y7keevE6cTYl457o/onF9EJnx/rXoJjksqkJ9UVetlq/xLqegfW/pkSQta43VXvejTBz7gzPzpmdtXXamaCoUNfrVXqSelb0TQR/LBMlW89UYR320FW/cQ7xSUdMHuaSB8Gm1g5XcAeXnBoeuIEz+AScoTQCyixr0gkoG4YFFyvr9T8c4vqaxYgHrDzQF236rzO7FeQITwDSh+s492E32gllSrdEWi2HuBN64lRtFkfN2RSA63FlbAp894Otj9MTFUAIuczlFX+rqybLeUb2pT7oUOlGP762/VBK/NqkTYvljwHCS25hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(44832011)(8936002)(6486002)(83380400001)(5660300002)(186003)(478600001)(1076003)(6666004)(36756003)(6506007)(6512007)(316002)(2616005)(54906003)(86362001)(41300700001)(38100700002)(66556008)(8676002)(66946007)(66476007)(6916009)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mvVytJywB9Qn8j8FZJLVhoFf+6KoDbMN1fbSjqh6JAjQRoSRK0NFre8eeSDP?=
 =?us-ascii?Q?WvY3p+8k1vXEtwFFTMnn1DXvmVzJO6r0waYExKykh/DbzBjWyvKdxJbAqUh3?=
 =?us-ascii?Q?qUPcfSXZZArFun6vEZUitqj0j9U5ITBTI+0UzMxa+lfQyurPmqZujq+7zhIH?=
 =?us-ascii?Q?TAnRWpvRySX24oT5YStE9N/bX6lbfg80GZGnXlgZp3tL2rF6H0S8NH+2vRqk?=
 =?us-ascii?Q?kpcf9kxAyRl8U559J4EqL4gsY+h8QfntPVu3b1lxDmhDOx8pmz+o+zrInZHw?=
 =?us-ascii?Q?lA3zluzvYxa9A+V/cFozmG8ge6eORUY2Jbk0R2uezZqxo+w9slttjs08aAcN?=
 =?us-ascii?Q?6oGGRG7l92sPVNIEZSg+0ZhR+mr4fXDc2CAPa3G8QJlNl45w1nrUbJjprbdb?=
 =?us-ascii?Q?jtMGj095vHYqgeAGawTJU7F1HXsE56WI6xu+HAvzk1BBKXbGC+xYyBKAthDL?=
 =?us-ascii?Q?8IY2cpVP0P3EDSKmVJfVJ3lZpodipSNrgmreEtsAHjvocO540TtQ3pPuSyxF?=
 =?us-ascii?Q?HVSSr6jHRJTsujdgpCGBOXCcCyhXoXifAQ+ruf1NzrkYqepAKlDXCLMo1Rna?=
 =?us-ascii?Q?hUFr+TbwxpuLouy+sRdfdBBuVLGHDtt1toMOiMsxGMgtlIlRKcmN7zHpAVhn?=
 =?us-ascii?Q?OsYYlpSaF2pVWe2jvnIrAmNYPtBZ9pTwVw/cWn13g3PCiQm1+SbcBUMf19L2?=
 =?us-ascii?Q?85P1HffgM3kGEGqxLkEnMVUpzjOngiaSj9g70C377rdTurZ+VoMn360J6VM3?=
 =?us-ascii?Q?7Be2xcxvabxNICVpJv0hVQenigwu4qb9BS3EYdq05KpAAlDhD2sOaxlPyx8Z?=
 =?us-ascii?Q?Nma8Pv/5WP1whX59uzgGaP7vD/Bk9W0pXlrRNtxPFinEbEjwS/mB/6cBQAda?=
 =?us-ascii?Q?Act4fSVPE/+0RXBjpWAgQtDq/jlXfNP/yhhulOhNQr1RTqv8/3UUxsR5d4MZ?=
 =?us-ascii?Q?EAUa7pvGJqgWywNxi6ruMz4MbeZ/w/N/RjfC0QJvi21NtYgj4nDDSjT930Cm?=
 =?us-ascii?Q?T2GB56cpbBlSq9hYlWdv+qvza9mEE2AvQSCPYH5zo7MBwro/PQBvdpJ1qyyj?=
 =?us-ascii?Q?Vqn/LCxjXbdv3SdtMl/ZDGJei4NM3spasV460rW1Onp+StNC37JdcSYxznAb?=
 =?us-ascii?Q?Z+ielStxn91jQvG05/QM34pX0/vXtKPUXxzoJJikt4W6qNMZLCLhqv7RQNQK?=
 =?us-ascii?Q?rNzXbzc2tQsbGjY8lcLA+U//XSEk2EwfEWRp6fXfwQu8aH0V27SJc8WAEtGf?=
 =?us-ascii?Q?n97g2mqiXdrWmDbWSGPK+DqelykW4hDBm8UlPneZjtClb84SB5YAP1/kdRyZ?=
 =?us-ascii?Q?ZQtPXA1dvBOipkL2Wxnaygi3t6Yk9XCYrGLuRNireLpMzhB2lbcjri2tOJxa?=
 =?us-ascii?Q?L5mSJdGE8vswq9meAwDsadg9ZWGfT5xzhq8KNb081EvUPTLRaDBTcMz+7fP5?=
 =?us-ascii?Q?UBzolb68A6iuFFKJCgDRSUqmqMiA0rgS1nfkqXcP9TGqn0woXYtMwnJMyzMa?=
 =?us-ascii?Q?18nhgiPluRDOsBW+okmWcjw2AJ4BGZ63OJdt/Hh9uTRAygLNs3eOG6P9BuKC?=
 =?us-ascii?Q?u3GJ7z7L2KVZ2ogyt3p6dARnjYnU4bs+Jn8+JtXQonu2Y1Qs0Oz+hIrjAEWb?=
 =?us-ascii?Q?hq9yN5GS3pCY1oZM/+gzTP8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xJQKlK+Gwsv06wg38Qz+235lt7OkOdRHYSjJn+JSsjY7tGq9HeRCggWJPHZ1vMT3TEQWldUX/7b2P1WnVmcsfCLJemwKHsJBD4gw5eFhVrQpPs+MZo6RZKSkrRgil3x8W6SayLvG0cAAEnJmRainvy0E6OAZcHrxOTADA15Ti4iuLCystR3QTAFq+S1k32/AVsZZbcX/4V/qTIugTDTxQO8RXSSxbi9ULFn/B0Un2lLzfA5Y974d1SENIhy3gvGsDcf7tLOaCUb5LtHw63aXn2kiKlxKfPIdgh8kgV9gjmZIB8XVDQGzDuRKMhVopKnUPg4qkYCnl2YWKln/XyNPa0umkZLfcP4wCeh45YAVeDH9UG/Qc67J3cHgPUTMLILda8nNS1g75fq9tXGe8y5vNJCFpB29WaESz5r2A1EGe3275djfcSqDXRgDaev8yMmKghw2qD9yHz2Vjdg/2fTVla5tAXHZKR62zhpNOu/44DFIUg750raByrAEMl6xv3/BvfZIoxJnu/Hvh/GV8SndH58Ee66yjBQbx0h/fCvH1gi1ghQ/o4nkhFY8gRgjKJ6AHQm71r4AAQ+Q6c+zfnCpvLjsYEfrNqjunwUbrWV/Db1k8YRz6JVnu3RoCmvfGHpTbEEHe5PnRQUfP71b5pJpI1FYdPvQkoUckBkRhM5YrSPkXcop3HxxvVszf7BwYh1bNRNXi0GtmJNnmzjwUMIWFyL25mYcsVolM/4iJqxfRzfQes+imUfTccJ4tPLM0Ir03J8PugXugYrXkBQag3sUSLHBEYwQeAvas+K7XbyTpBFY125GBWtc/kIymogg9GsK
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2daccae3-5a0b-4d7c-de75-08db200d8425
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:44:22.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rNRUGPPqMbkMowduVogDzuU8LKmN/Ta6SBToaxVz3gQhHiT4mggN25TBhaDF6c9rpNEcfsidkV0LqLJZHMjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: frUZpBu5T1xKQ2l06ka2xMxNrsqcfnFX
X-Proofpoint-ORIG-GUID: frUZpBu5T1xKQ2l06ka2xMxNrsqcfnFX
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
Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-omap@vger.kernel.org
---
 drivers/mfd/omap-usb-tll.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 080d7970a3774..8ca4067da6cd3 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -450,7 +450,6 @@ EXPORT_SYMBOL_GPL(omap_tll_disable);
 
 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
 MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controllers");
 
 static int __init omap_usbtll_drvinit(void)
-- 
2.39.1.268.g9de2f9a303

