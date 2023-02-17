Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2C569AD90
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjBQOM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBQOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:12:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CEA6BDD9;
        Fri, 17 Feb 2023 06:12:13 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7iVSJ010831;
        Fri, 17 Feb 2023 14:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=A+xJETEKI0gM0X73p6dl6J+4zhVRlx9w0oS3m69vXtc=;
 b=IdjAsJ+Vt9ZLdc6lf2EvjtO1O0gMAajN++VI2aGPqFTAsaGtbqzt+OU9svY8uv2QNgov
 AqKXVuASY0LxMpRfv4H3hN6Yss/UNdusX9XPbe1ashSvAeqSszR8aHFTatYa3Vi321rB
 GcWdQw1VYD81y9/G5XUvck1eJ1KaJw6Jy6J6j3+Icu7SJdws+HNgJzhfcBm8LmpEJJbV
 luAPjL45H2DaS8Fb6rqxJLtxhTwpm3xsFYXoRX8pGlXnUOnaNlHaW8Q+DkDM1OnuZ8RB
 gqYUcvhmDzsEw8k8PXPUosP92ZTbHS4hR1He5yr45skY+VnyETewckc/A9barJH/JYRU +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1xbe029-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HD0w7k013834;
        Fri, 17 Feb 2023 14:11:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f9uhv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2tGHGv2zR5/nYc6/INKIic0uy1WtnJDLYY2+o14lgVBaJ3L6DIRmbA2fTnRd2PU5K/hZ1pTgWO6TZ97KXo5JzcOLQEgg98XfowC36BDEKJrenjVTRYvig+yK4bLCb1mLGEcAwIaaG+1+twPFXsFLZ9P35EQ8z2Nklec+H0M9rU1ny4Fu4RIbgBbCxy6Zxewyg8J45o0YUIViKB7dO4/1E6j3S6HLvssQRQvdAxLNpyjf05OepYID7nBWfkEdRJwG2mlJ/BFfJ/g6Esl4neGms9MKrcHZ9ARhekcAgeIRXGSfGldzcxhidCBC3xNS0ZD0VozDuukKHyJ4xh6evme2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+xJETEKI0gM0X73p6dl6J+4zhVRlx9w0oS3m69vXtc=;
 b=MAP2IzvmEZVzxZxRldf1GkQsU7D7wn7PIro8aPzGpcl7cnxeR+AFcp1CS6W4C+c4ELJ+CLsLNCGt1Ks98xbKBljNoOT3U/hIPknMeY4s8YmZ+X/iCFo0vlyroTXXzhkvvFhnHt3dXQWenu5FbzCB2y6oauOmJOeSoOCnVNrvkBm3AKIIjDk8kZwagN+dicVDA7yMywtDR4onJuTs1wPaf0yBXDr1JIPMUwj1A/AFHhNb5U/3V9zJ0SyyscS24ZiJeq9yyl+9Z+rvHdXsQVtXOOfdz1QWfucbEk8ZAJrf091TX6JYu0i8DlvcWrBs55Km3iNihsNvsusW+bU0u2utfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+xJETEKI0gM0X73p6dl6J+4zhVRlx9w0oS3m69vXtc=;
 b=dCIfmk/C0zFESxL9FtnXRPdep9+uxO9YkwOcqMigI+JGQ6+rr8GO6fjz0t2TTnjgIopOYqvKd5IwY7JnrIChNbm32VNutlQ42UdG1OFYTv9ZriItHLVAPk6GSE+/zBfhYFFSo8qkM05DYZcbCdHR2LYKR3ltznl0/ITTrg0TKpc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 14:11:52 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:11:52 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 09/24] kbuild, ARM: tegra: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:44 +0000
Message-Id: <20230217141059.392471-10-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cacf9fb-1bb2-4934-6aa3-08db10f0eae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbfrnqG7uihYdEYYDXxTTUy7j9qvtqacCGc1UFk+oub/hmaW40Vmq+BiO6ep33+TLKa4QNQt4ci9Rjg8CRmCipPqdtPWxtTtzJxeaP96K6NAEcJXC7ix9SwcvMEjPT5DfcHg2aF6MQlTY+szO6pBOymeN0Mpq+3tC6q41P24C7qwahE5OU0ms7Ny+9uV9xYBRuLgHzWtQNs8ql5hZv1569jA4OeoVQTlB3C393Tevrao9YEe1bqhNta6eKIT35baDVUPsPTqAfX8WI4UJ3XJgSxY49mBo9a1mnNvpCc+URVjR5XH3DAiBWENN8r2Y2OOXyLAeGu1dppdcJy4IrciQH60qiQDFC2NYPNuA7PEe3fqDJkb2rUHVrtEJo/we0C5xqVgpxA+FNsdh1cSRbeiMJ8vrApAkdzy04RSvS/HF0Q5y/WSi5egr8iZ7oHkPGhLogIx1jHX+zS3BAq3PrQX0xpbZD5N2WCwMrt2L5zr61cj92cwPsEyUJ1Ifs+qNg7X7wZaAMebMnas66YCme/JY/uqb0ja6EjCCn1T+njJqef0+UeXwFszI6LU6VP6thXlHKDuiZz7XNnUEjiKjoEzvJBlZhVwDewctMGNEmkYpxH+0JULDqAuTKvZWLqLM1weSwEy6k8ELzJEYuD6+6ne9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(44832011)(5660300002)(36756003)(8936002)(86362001)(41300700001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(83380400001)(2616005)(6512007)(186003)(6506007)(1076003)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5qpxmbkLlsKBPIjNMUHmABXfEV9qKXlRBXCB+FRifGyYewWowaYqitmCgS04?=
 =?us-ascii?Q?/Tkz4spqFsKBYziEiEdE9ltEOn+eOSJpXvFYg2CE+KfR1lW5gsz8XxaKIbCz?=
 =?us-ascii?Q?OpgQjm/qWzhp7140XRMo5LtnZf29W4ELSJUtsBldTFnISO3qVgac+8uZ32MZ?=
 =?us-ascii?Q?uMFJV6zjKXxlXrOndchItoNLb58rsExTMy4jd97vnzQV2tLyhvRTPWrxIrbB?=
 =?us-ascii?Q?tv9n+DWsuU16j3uv5vnpWXxGwwaj0CbvWcO5eOCE4i48ki+UbSD+sYCqNPxc?=
 =?us-ascii?Q?Mn70vsKNF1QVJhbg9HL6cOtktLIvKw8lattQPJFho0zc3CztLDQo23JDWeJP?=
 =?us-ascii?Q?MVBbDDBqrPpZtVpHiXTTveVhGhd7kYQRlVBBVyIxl4r/5D5vibJi0bddeIVy?=
 =?us-ascii?Q?JmOQf0s2gOUuBkD0WV4q8C54jt8gUEMpX7tyr2f3FT+kcy7dWHHYJxthz9iY?=
 =?us-ascii?Q?wys73TJY2yylFoB1SyORmwrxIZchORlNY5Kqu36qhC4TVud+84fF5jo9oWTo?=
 =?us-ascii?Q?gm9Ch1LKnT9ZbJ6K6hzs+S/nJp4531zWJoIVk1G4WG9ZchlwG0A8yeITUrAb?=
 =?us-ascii?Q?TV30EAlTBLq9hViEYHd0vcyHKCHf+lg+24VEvhZPZ4Vex+QGEvxnT0I7cSyt?=
 =?us-ascii?Q?jHBah+/yHWhnm1SBzOlqidVbmgreqIfcPDih3bKLO0wQmQVHtWAMB9+pRqHs?=
 =?us-ascii?Q?TPoLIC/A2WsMO88WDYcVcF8bhOYvsG3jvjsS7a9Av3Vosa3GmLFb8wTGUnp6?=
 =?us-ascii?Q?axGiZTbWj4Cc8JANzIdfpht34ylrIiPeOhWFClRQ8ER0pJSaZkdWIwuIqd33?=
 =?us-ascii?Q?Nj5bifOZJuxnZco95TgBElIkivPUsDv+tpiJTrjx3JRiCF1SagEJBUQdsYvN?=
 =?us-ascii?Q?WCVOGBdIhKu0NvsY9BAFfbsTIYlDQsUZsrVt3EmhmiW5T+KH7wJmHuWft7+I?=
 =?us-ascii?Q?kxVfubTurFraqeHsNBYiubYhOdTRxjWSoVhEp+nSTyvyCLPOP4sbHXFanzZr?=
 =?us-ascii?Q?+jR6Qdwans4VGxqpjANrsebrclk9SRJ0KElI+8FnPaKJjCGm8ZqDtqhuXQz2?=
 =?us-ascii?Q?OMO/yEKvucsOI9B8J2Fmuq6wSaCop4xLdx02O1lRvq1/a+f6+bxiGwQTrB1J?=
 =?us-ascii?Q?0QsmZFddyP+wD1v/S0lIEe8RdVqmSogZI/JqXDcUUJomiY67SMmKh+6TGNk9?=
 =?us-ascii?Q?iCZM0U7jycrIRHLZUdWvPzJW2/20vySZ6+/GjEzDtV90vB4O+1XisbOZA+CT?=
 =?us-ascii?Q?E1OuMQJJO0YPXtLetOucVM72trMQnFh/UisphaWeUlmElFedHlbjrm5OWYLU?=
 =?us-ascii?Q?QdExpddom1/uvLL3fN+wPqBhnlDyzmO+njw7Sjl0WKHDvX2BR3DMAajL+Wtl?=
 =?us-ascii?Q?TSZaHSm83fmL2KT2wIDWoF2KZfNNYfQaZ2TN6Np2Lc7lRiorkctYecJG8bLQ?=
 =?us-ascii?Q?+t6cKzwLiZgIBJoblC0EGNBXdOnCAaXP+i3Ft9tq3S1zlrQ43c+dWo1KVNin?=
 =?us-ascii?Q?GUIRkCnl/mdZRK+d0lg51zYwxu1qPttdJlmhS6dlY/kHHfOFle971KMDdYIx?=
 =?us-ascii?Q?SEfF0HWEZBNOzOoNK/xq2OKnVZyYWl/MggsCPImIpM1Y7upDonW5J5/HOiRZ?=
 =?us-ascii?Q?rwonSwsy/U0kT0710cDnClk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sED/ay/TWE+pWObPf1cuBVP5+MGjsw95+WYn9e6Uxwa5x20+MppZWXfHRU9CcSa0CYE2T0Erivra3e1f7KckVkt857TNxzylIpiuku2M1GPMqVz05P1H0BKhCgtlWucpjnoF3DOGakkkDjUD49oGkZwE8WfT0MieqbmOran5Ml4O+hwgO7FpbwxGPIlMpIcRaOCxBNmltP67BPDbGhEneJsUyTmMvyFVZBTkOZduyRsrG1bj4cJ/EymP2QjLmRD4AOb3idB1jIYMqGUFiUR7Zu5FaBFUl4Ae0SLLrmdv9zahLb+2etwzxSKFC+posoMusQPv5ahXgq8RhZaTy81zvnv8q98fDjNTQpH8OUgdntvl6XoW+SdWZLrLxtOIg/IxVFGFBEEGSefK3gyUXqrFy4nw4nWIqQXP3ngeF2hNQbwsKObJncxLZfmuMkEIjmtfoDM+Hs8WJawZwFFQwyGNotZSbdggBPriG/VumEv4h/zQQWH+slKUHnbhu+4JK3T75Q5TUtI/gXE8NToyYAFR03bLd4ZxK/LineIc6CnnGscUfyeZzIwS/+beGjf1SMgKRjIOUMz/y7IhTV8+jeTMU5uv0+XctzB1yXl4i7KTK3vJhQjwa7iP9ZG4Sze3m1+2cPl1SYHakalRl+e/pBu5281O2N/99xwEanmphS2BaMGwwoe33kcTwW7L8IySdfpafhEPhlO096CkZooqeYY47J9KrsdDWk8QNFC/kY2UWkIiLxbanmCxOL9Th+umlD8X8fm4s3hGpbWgomP56GM6Gek9NXhl4ZIS5QjUNb5naqRpgFdfiHgbRuNU5xToPbqWRvGRyVLYRscXQmDftg6gQrXuVXdLthgIpfC3vGQoFsUW7Ezz2HYdufoJBE0Q6+34
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cacf9fb-1bb2-4934-6aa3-08db10f0eae5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:11:52.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIdA67qSdHirCrBIz9jfn7qxUy6LnZZ8G1ddM4COwqQTvxGj4JYubdDFEzH1/X0nUXqYRr5AEez1OOej6wXD5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170128
X-Proofpoint-ORIG-GUID: REgEsS8smleY3_YbacjQl7GLmRKmcJD1
X-Proofpoint-GUID: REgEsS8smleY3_YbacjQl7GLmRKmcJD1
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
 drivers/amba/tegra-ahb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index 0b2c20fddb7c..c0e8b765522d 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -285,5 +285,4 @@ module_platform_driver(tegra_ahb_driver);
 
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu@nvidia.com>");
 MODULE_DESCRIPTION("Tegra AHB driver");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.39.1.268.g9de2f9a303

