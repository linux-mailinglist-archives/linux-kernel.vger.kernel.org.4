Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08306A1E14
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjBXPJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjBXPJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:09:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C604FAA5;
        Fri, 24 Feb 2023 07:08:59 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEoQUj007421;
        Fri, 24 Feb 2023 15:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=nXQa6Hq5cMMQDzZaxDz50Nyt4nG9YgR6lf2BBTG93Mg=;
 b=p7fkXkHfNYiRvjZMS29cTbx5DJcC/AXxEzlTq3EUm+UAVjpqoLWKgUgN43foD0utdvnr
 pC0cPeSBg88MlFlIWsSzgVdESwKUOY8HUVglh0Cmofhx0rGLsSgOdqMkyBusHRejpHAO
 B/qsLtaYey1VaavlEZmamohokuDerIt/WigoI3WCb64Zom9sBpFevgzFfNDWRmh9K6nH
 u3vwwESf4XN/igj/cclUQB/lKE8XhYUBE8/zthDNTGcyugpN6V8arDYyzUKRG1KDiVi9
 mKckawdJRYaQYMM1dp0M4l8BqusBrbo8OqCKKkwpo73mWJEmBvttqZhcPL4pkkEOI9eh JQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn90wb30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:08:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODI1FX017898;
        Fri, 24 Feb 2023 15:08:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49v80m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfGoS/t4pLOJzAKjPNfbMazZdVSWWeD8qq1GdsJX8gmWPVa9cGdXtkSZaGxTECuP9ElOqQkWoXJf7LP3C/fb1Cyo4gwsNtJxefUoa8wiCIU0k8ZAkFAkc+2ABnqwnudZ+O+bWbZcKm3Pu4SjNaR3wUQWsIDAFIfVQO6JwXKbY5Wp+SX0XfhKDScaL8fJ5xZQxvPxCOw8wGRSZSMFjzNSUYZDezKvVL320Npzc3oEVxWrM4xpz0j+lFuAh2WIUHpuaLXHX9MRZCCYGOvwNwIlLf/8Ly7s0YkLp5zBhxBqED+W7AgWQbzWT8Gp3OENawdvsq6ZrwyVyu4giAgNFE0hkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXQa6Hq5cMMQDzZaxDz50Nyt4nG9YgR6lf2BBTG93Mg=;
 b=JKXc7b/rAXYKXvX/U9BIbxI0zrfLVGBhs+9thgnuY6tYjoPnuPc+YRmo8FEr2kJ1q2KUjyVm1UojhF3chous2cse8gwzmdc68RRdImuMQskWk3vi9a6LWEPKbkmkxnESuwaTXZeJgWKWy0BGUt+LqYa2b6vk3l0hehb8urkFJE/IVwEptZnqcuohEN+P4yiIz7HQz5NeFZYoHhzLx04yayQpXmOmqnvfWfMvNv+7T7NkqeJFfnmBaYSYlF1PbN3eJ5M7BIry96oiQaoskZx8zXcMGO5+fXXmcCZJWv8Fls/vdDyt6YrT43RL0EhARXgq6wuunGPdUYpUfgwd7IuaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXQa6Hq5cMMQDzZaxDz50Nyt4nG9YgR6lf2BBTG93Mg=;
 b=SwainZDxPHQ3mnejP4vLHdDFr33KgBQ/g3noqtalnGSwxmSyOsc+g3M8bVQJ5oB4okxiqFhlXCp2wC8kPWQ2X8nSphwkSGlpk1WwbFR816wVUDMDMcWzB1O8umXO4xPUVc2TBRFfvFmen8dY+CH5chv55pejSvdjIcKDn7Qnuyc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5303.namprd10.prod.outlook.com (2603:10b6:408:125::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:08:52 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:08:52 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 06/27] interconnect: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:50 +0000
Message-Id: <20230224150811.80316-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0374.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 8647662e-4267-48b7-5672-08db16790a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBj4LA4XlhcrwApg7cXdStLgUX3ejnzhXzEH20DZJqFf2n7PIEbpyqdUCNAWq5J34TSJg7feZB9qlbk8eIA/RnrJuNQN5k+teWViZf1LdzZNAYQgsVKC/y8mB7I4vIYT12/k6J7BllYkiJDBUgIo7PWufOdoVYokbUlNGu1e6+O7Ru5spskbQUMjD3NkzWpZ4uaAbe7dhIX3LeYOsEuuHzh5SJ3X/saazDdis5qKRgW/gPB1k66UlglC0xH8Nw6bIZCeX2OFUKi3fGtrEMoNCdWVoT91XiSOcqgLwKXIGoRxCu6je3lLkZSmT8pLzF69w6sZK/uhffQOJyMY9RHFBls/r5iHhLH4Vs/bnS9Pl0e94L1T6jxCkhB1Z9Lcu1keekvOeR4InZDuR64N9vGPim/f7BfYhZkabCuhl5WM4tg7131pXECzgBe7VGl2cEtSxpNTeb6lwEJz00d2ba1eVcBjtaI1TibAOQuZKK3Bfae21kgg3d1W9FDnfYLCqEyfPqnvps3L0SGcoSSMf2ay+3YpS/iSPysUanhOEXFZQSTYV902otB6Vz0/EApQr85wrndWro75zippFPLvOkleksg8/Ehpf/UPauIVinFYWyAjPwkHbbVtClh/iHQYoUDaUOo5vp0Pzu3hnCEs6be76Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(36756003)(6506007)(83380400001)(2616005)(1076003)(6512007)(186003)(8936002)(41300700001)(6916009)(4326008)(44832011)(8676002)(5660300002)(2906002)(6486002)(478600001)(66946007)(66556008)(66476007)(54906003)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6RmyBJKVct9KUvQhbEbWPf8bmoEACAABySEJgfwmENJBAlriXTAq/bN7Rl+Y?=
 =?us-ascii?Q?l/if/VYtvI0VwWtmiWIaHgKIB+cLA1H0MnzdqfDMzEWDO4+dal8jsgyNvkxD?=
 =?us-ascii?Q?SVZgS20GGRMD+YKSlqmPZZIy/i8uUWuv/r73JPgYyUWGJxCPZ7M/Km9P1uZ/?=
 =?us-ascii?Q?NMM4V58Hj5f/Z/Mqwk7/ABMSq+8nCOvJ6gWCEvbysj1WrGAl1XUfmnTPrXig?=
 =?us-ascii?Q?hh/Y5AqpZEWPSaXvCn5VefTSObbJONap6HedI2NS+Ks4ND1oQfNU7ktCPsGb?=
 =?us-ascii?Q?cnOhEpo7hXS9Vk8FkLxlUnkjXVSyioDfZxpmbesPhPKfe4D1uoUugoNpgwbs?=
 =?us-ascii?Q?YoTZWwtwx1v2yGANthvAdCohgrfrrJfhqwhGZjeq3/kTefuCbumli7Wsi1Y1?=
 =?us-ascii?Q?s+Z+86xi61EkO5A8pe/Qhp422NpPKKlk2JvRRKlEzuW8HP6SSacFxINCW5wu?=
 =?us-ascii?Q?QNgMtVnQNGCdKkHo4QOj7Kbj5WTXtBn9AhQL2AFm0m1WOgAasidsxR/lCLes?=
 =?us-ascii?Q?cJRmTVdRul8q1pknurRaTqhA0GGy1B31jiWcTZftRs02WSRDsVzOJgHONJRo?=
 =?us-ascii?Q?6pJYC0VjczzijRvQmuQc8TJjUsn6MqG34ViXIzFNmcVl1qvu7R/r3muqHior?=
 =?us-ascii?Q?+Eb0LrCY53i1I1j6rv/qC+mNshjNGvqDFprrM7NWaga3ARluBY64i9hfo0Oj?=
 =?us-ascii?Q?pMg5YEfX6S9mRAXzZ7lZypEbPzygjw560Gvz1Q2lHLEP8PF8GXL4OgFQ77Y+?=
 =?us-ascii?Q?OOMJnD4QtuALvcKzD1K6i8lqqbJo9YEo2egEq2t0v1C+eoiWoPHccClQUM4h?=
 =?us-ascii?Q?ZxRrMmDeMYNdJUGY6sXi2Asa510irNwCRkq4cv1YEsBW9M4q6aEIDNVLqOqd?=
 =?us-ascii?Q?/Fuo6NmocEx2gHrpKP5rPsAWmf1gVgcmo8obbvLjyvCOBjLCgoTUpMZEldCq?=
 =?us-ascii?Q?d3Cs1svCQLdMjRHDtS2AoQcn+82KsUGLchEbTCR15Qq+HRTm1RjPgAGdr3MN?=
 =?us-ascii?Q?a2UZtqUwmefUl/qmLUOdQSpLLcg5SUOZOiY4a7WGeFXolcImb0QhwLP5pQ87?=
 =?us-ascii?Q?WsmuhLwjGFK/NvhPFrw8qWZfptSOsTaMKe7NDlBspHIO2ZSNQ2uPKlb4An+x?=
 =?us-ascii?Q?5Rx9KbL/sGAhbTcYJRgPKAYKK2H80bZJSDOYMvnL7Ldz0+DdNDDogqYJZ0sB?=
 =?us-ascii?Q?0Ibhteufy0QiXqcbf1oYCcZVfw21sNbv00ady6l7zSJwI8UU/dPIomxaivDG?=
 =?us-ascii?Q?kMGmOp+2mgEFXXN224/Ils28jDa02BuW6w/I8I6KHI+kT2Mlx2NLZk1HVmGg?=
 =?us-ascii?Q?MmZP5dmajSjZ3QFODbbHxCx0hSXYw7uVzBSoMoV6d+JyzwEqZm0YiXVxgK+i?=
 =?us-ascii?Q?5QcDmpx86YrjtYYyPoV3iKiDaciJ/fjBc3mJDCkUYdr+JUwE60Fw07A+SGt+?=
 =?us-ascii?Q?05p5lmByxwx1ti2/5bF8tihFB9Ecwzoc8qwWPPBRqHTDRiw8u2OAEInDF09D?=
 =?us-ascii?Q?XiHVfdRI2Amp611bxw+BwGz+1nriMVEF7PmwsIJM1sASpgdw0Z5vwteppdY+?=
 =?us-ascii?Q?lg9UNXb6uwCs8NNejJNjP+4Es0PRmPy40Ls/VmR7oOpwtT+TA6OZ45v5AhgE?=
 =?us-ascii?Q?aN5O3eM7UlJXBAMhJhNFccE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R5LAUO8WzHKz0vJrI6ZNc2pprwVzpLf4qMpoKoj9Yby33wYHQCjQfpuD3zaThXVmMo7Fi7WaZoshWjGRkRGtTjKh/oWlBQPsFCJVBWCpvyXO0a3CGwm0HGOTGhoNKx/hpXPyaxxvSLBC+6bSJLV33JTxwbUgRo2f8xf/Dr9mWfp6vwwJ5tfoUKkpBpYj+QqLY+XK1q9rzgh89amkqQxrf97YUCDOuxIirFvq12UeMZKqj0ZQ/JYVb0uF5nCJ6spd7GjKVN5LWhfmiw3a2Zr8eqRV/TOhp8teT1eV/3v6CpOFeTBCE93elWvS8OmVQ8crbDQ5wwPoap8wo62hnEipRAvEv6z6O1Q6BX73iF4BkCt7KKdgJIDxmt4+TaSzK/c9Fwf1GMugCgUr96hLptbpSR51yuQMYYpDfHCqrg4w8IgnplhQFPjHOojAVrTnly5CLEjad57SY3VfRaB/97SaaqqXnUH8+NI3p+VDkygJXRXUy0IcaCetB/EP1pGu4fdl5nZwuKSrYx9yxXinwbrpCbjsHvjUVbgvT+MebE0n4z0q2za2Y44NbnVvQB7F1LcmU25Wq5qWgCVaaZdenj2axhndSFT5jLjwe4KK2FbKcbKaoXKqvSKM2DQnNd0EW2iIEWN1TFJHLWs0d0Sd56b2KezLSuE5LYwr85f2dsPTu1smNDdkXDYDevOBJ8wKGBAlgMvluDI83HpXQDYv+4zSvyTpVRYjZ26k954K0WMEXANbxHYbNmyoY35pTe4OFddJIJsHRAdGrRSJZsKCEqocUgmRMN701tW/X5kBVkkcxdu2RypFK5xC8vifeHP3w0+c
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8647662e-4267-48b7-5672-08db16790a6d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:08:52.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T96eBaaLVY/kzhXbtzZ04PteOQ1YUhJDeNO+YQMBMXnpx5cRRhp2Bd7pmzIlcXaOxXaMV7+ioTOV42UYl3T0PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-ORIG-GUID: d0AwGvKwz_GsBEgupHQP-s40AUf3BS9z
X-Proofpoint-GUID: d0AwGvKwz_GsBEgupHQP-s40AUf3BS9z
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
Cc: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/interconnect/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 25debded65a8..de61a639fab4 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1146,4 +1146,3 @@ device_initcall(icc_init);
 
 MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
 MODULE_DESCRIPTION("Interconnect Driver Core");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

