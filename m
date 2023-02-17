Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AD169AD74
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjBQOLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBQOLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:11:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531076B336;
        Fri, 17 Feb 2023 06:11:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7iGpw007518;
        Fri, 17 Feb 2023 14:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=3VXIG9WkV00ZulvRQaMHURvl/x1M5QUywnCTQDLjLa0=;
 b=c1Ar4vL5BfR7xXSRlV0Y6Ym0ZgugKXtVv+kjCh9SMl3/sAZKwnR0MTFYE02Fg/Cv7/9u
 3N3FGCasGAwC8FJ/koaEGBi5ApZRQwcFwqoTyxHoxB+yqaSTXm0D07bCaPQS5ihsL3fT
 IvDaubzBJ7OrQUybYJj5NfdIrujwtDkpcsde9xm93KLYHIHbhFTkuP4aMlL91IhNuSbP
 GXy+Nu9oC7Gsw3jB5SXWuHibEkYZ+JLANhdyAJ0gkW3ab0zfpWiJX9xu2FQGUTYRoddq
 TknslKFe2A991j3IhrVaf6rGVfI9fRdGoVUf4TFl1VtyaWQo3E+VAQsHXuINbar3HayD ZQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1m163db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCjqrQ015303;
        Fri, 17 Feb 2023 14:11:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa7n3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOPEtTQn0uQxOzTHtCLJC9kzMB169QkqVw9fAW7NMC8DIgnQEut4p+IfLzwRHK0j1lh3N619Q9dvTwoBaE4yfX7dQ7FVeu/OZGqJ5uKSziWbtAzJgQFhFTGe9uyt3w9nr2b69zOOQyM8EPyDwzUhVo/N/5PbtghDn3Ic4bj7caWWo3wT5Z/FQyHVdZtuUBddZoPRkws+cOAfeZw/psQgA4BgL0U3g9QIyvck0lAxYbyUm5PbkFj30D/0GHBYKkEym4WREX3XuAA2Y88Qx2eqOGwejk9w0MCJ8BahU0in1e0MrwkEPOB6l9igKrQHF6XVFx33Qv9KE1hFjxiK72RaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VXIG9WkV00ZulvRQaMHURvl/x1M5QUywnCTQDLjLa0=;
 b=VZtqJrR2LFeaAVztCOJPIj1v3XfjfTNlN4KSEC3VAOpW2mF5k4a9NFijUGeOvJ5CwgegnG7h0Blf+GF1KO94PbVhhCMCHqH1dxDCOW2K06ml+lxiIvLn7gD4dAiEDFkBLxwqDxjMOG7HHB9I061F/j+FUcPjAezCpSiL3HS7joSVmfhPc7YAUe8LlHcg6YofUzm9WOWmHN67d5KmtMIvVeCy4TKG9TAEnzqcReec0hcASqZCiX0qx/2eXMfqn1S7NumdJuOVRx1+nuUuTM2bmpwN3r92xGaSulFEjAYv1n2HlZLFMuVQQrx812dGQ9WiMsqWTbPZnf9xv7AAvvhDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VXIG9WkV00ZulvRQaMHURvl/x1M5QUywnCTQDLjLa0=;
 b=hCiHcYoA30qE4Is2jntZRid21G/qzhhtoPgBwOdwZFjo2naKkjWrBO+ZhN/UiG6Mi7/UNZWvzUYW2tL4L4t32lt7nGoxIRFDipInlAXBvr0QM8Jsxpu+4UPPcOqr1z+N1rYVRDiLjp2GiGuReMoYIYAWXH23xBcSvBKeUrztnjc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 14:11:14 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:11:14 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: [PATCH 01/24] kbuild, soc: fujitsu: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:36 +0000
Message-Id: <20230217141059.392471-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0169.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::6) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 27392f87-7442-45df-9384-08db10f0d3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRZXTSXoPHqxa7j4CfmNsfaCgsXL90oxzuey5VKNaxv3MkRpeCgQIdwAlMWIOAqx8PH+hO4W1qqhSd3zZ/S3y+W1vJImU5Xr6cVa8Ugf7Htm6Qi9GPcIHzq9UKW0lUWz4zojE/IEVVobrxA7WPkwfMV152FrF4Qo6tX7DI9taatU0k5KgFK+t9/CiHuPZD9hWj9qTrl0OMZGUGOBC+xuGJ9Bh+QlFDoA1vPyIqa7c+kNbcq36o8kjAKIIugJ/56OtHVIrL7DSTNLHdX6lQp2alcFnCgdvuXtB2CAY1oUd6cOt5A0RRV9rQaJrgj8+ymChvKRG3aqmfdyN9NgYCYopG8Jc0MuNNPQUj9pw+vkzMmh92VqhMCAIRvGLnssc9eF3ZXyOmxJZxXXOQm5xrw/Hq2WSj1ZUCThrSPDo2XTXZlylnufqojXUySqSJf/OU6GhwqA6BY6SDWA4gD51q1FZpqUxmRjVPg4oTZQGrEy9vzlrVJimFzellecHIDDM+tgXu9+cyGwRyS10EP+N5+WuknE/JlxsEuBqxj7s2ln6KEA15r9aeeSwITRD03a3CkIHR1UHsQOVTef+5pqheCr3c+3ZKYe23HCQtxJNApGGPR9/MsbizbPHFyDHHNtIwmJqQigma82TgUd/laS/kshdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199018)(8676002)(6916009)(83380400001)(1076003)(66946007)(5660300002)(8936002)(2616005)(316002)(4326008)(66556008)(41300700001)(66476007)(6666004)(6506007)(186003)(478600001)(6512007)(36756003)(86362001)(2906002)(38100700002)(44832011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c0QrKmnr/YBfbq58foTnOeZB1nYxKKTejMAirejfsapJtNgscLWiQNZoBuUE?=
 =?us-ascii?Q?W+84FngqusnOcQSln3mODMtklzFbpXvM3YAy7Ywm9wONPO9cJyc+HY4S4ED3?=
 =?us-ascii?Q?kpngMXxe0kKNtOTb3sGubKwV3HBUfaU5F7hcCbUDTTBJgk/yhgj3AVWY39Je?=
 =?us-ascii?Q?lAOAKh/Y0XGlj4qZjPmxhd5FbTsUtNhIkQd3h9mpyPHAY3MLtOjoiDTSmOMe?=
 =?us-ascii?Q?dBRyEISgbWyOdPimU6VN29L7idfFU81ayMXWAAHnRISzrvL2bIwkvv8KMePU?=
 =?us-ascii?Q?oOqjOaVrRXNEc4jIsoMSqtagQzw2wHNmIpdibS6vkZk9kYpzOlUm9th6qAwt?=
 =?us-ascii?Q?C+qC5uHtrlpM8YCWTVNpT+yGY+9gPmzW8a5A1WwK1QrXW8t5Kpl3pAZ4JRxF?=
 =?us-ascii?Q?q1qL6usoubDVdmhPOFdAcyky9WmWu0SuKYJGXb8d2FqZ0q4S69nVKxqgT7YT?=
 =?us-ascii?Q?1dx4hBLJprA4kgKjfm5kyK2KOSLUpfIlOnsw+cB7rjpzVBGy39Fp3eFllp70?=
 =?us-ascii?Q?moB7xojdMbQPZe+tWTFj11DDc/ImouQus3+mF4wy+8aAVhX2OZGqCwMm/EEL?=
 =?us-ascii?Q?JxiPW8yUGCn2dbBoJXbNlDbnV4xDCe9MXj2kPvP6QI5iRYLgXsnESvmYHXM6?=
 =?us-ascii?Q?eIX7Sh5jvzlqSgdyDvE1ERpy8IDJJBikLz/aMEgM5AcbrjjNDIdTL9rTgQMd?=
 =?us-ascii?Q?gzvf7x/wJ/ig4Tv4bPcGsxiuekbig+Csc8FQYg5GPruN9y4rVfKxkgW95kMy?=
 =?us-ascii?Q?Rq/7DLGgdshyIykNEs2xjgDsCI4Sq6TNCZ3K2Bs+52JE+1wZKEcAyKLMnWUR?=
 =?us-ascii?Q?IhM08HPSV9/61x0djUT3YIPKXHmVRJUmw7hotYnXiSp31MPItxbcHzPJGEOF?=
 =?us-ascii?Q?aG256M34MimdlA1NzZtBHk7vY5u5AAu6LkMmmBYvOgIQZ9tMggghdtQF1EwT?=
 =?us-ascii?Q?PmsOzx0G0Iop4fy4/Z0kU7lCzSpYzMjwahX1jRPiWowG0+9sSmwsEK37Gb7l?=
 =?us-ascii?Q?LsC9QXctK5A6b6O+8ltxVzP/c8Lr+2nYaszAEU0g24IeyhMxhgY6kEYLq9jY?=
 =?us-ascii?Q?bMoJgxAsoiqmNUarh6pDF00y+zMpa97fS6KcWtdEt+I9ugQiQ7/RD94ZAnSR?=
 =?us-ascii?Q?uqLXpJ9MshFxrQ6SxgFWeRxsMZIIVAxUw/2ub2Bt/QRY+WTjzdSYiaB+DoAm?=
 =?us-ascii?Q?Y+wm2MTO1oT8ZjmDlT8EqH0F5m7H+lXlOHBis3CXJ6OiB8F4xKCK/gYW8chP?=
 =?us-ascii?Q?FrvSF+6S80MAp8K1I6odtAwai3wgGRwvcPLMNlpzm1TATSRa217cnQA7u71F?=
 =?us-ascii?Q?sgfdskVH1KGGVWde1fAVWYfVbXieRLtsEY9Zh6qOW08B2hfh7bDV7Qtf9N0G?=
 =?us-ascii?Q?OBjAB2N3QW/XJGrnT84vDNZfSN5uApc8EYRdI4rH1OAsBQhe7LObyiidWM5E?=
 =?us-ascii?Q?aUxayNRMigviwCemkrsPvoyTX0MjAVybcXjgDBRmTA7EYiDKHWBsChF2lyr/?=
 =?us-ascii?Q?md+yFVA/feYjuxLgsfVam3qzLaFCcd8NIU0VwG7Qb+xmYUUSYRtyg5lwhpK/?=
 =?us-ascii?Q?MVknY9zyg/pWnrzKG8eoGdMUftprhqUyClYwLWP7n1ScU4gqdin11d8n9F1K?=
 =?us-ascii?Q?AZPF6QChNlbcT2FL45VU9bU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ViVIvbjVQFX+79ZF6IFwqncFAgVvClN5PeA5g9Ethso9P7s2VdD63UyFtiLgv1Z383ATT4l+gjebeO9JqsnlO/4AQoqAUKQxmFZYYYyKXXXTczx8x4nB7mlRlgHw88ooo7QxaWCesiSlEhMRjXCfi2bMPqZEKuQKlKDGZmSyHgAxm/EoNWZmqRdiBFSfUN0U7e2nPs/W6PAimjktG0SdQN2yMmaRD+BezREUE5smrWTthh5fwIaCw8VFHzZa3himNGe/Kf5X6UOo6Dr68FqOdcIJUBiI5pQ/m1t16nCRz5L260gtJqDRRjUNRm1AT7CMYTqzMv0zKD1T174BuQWW3uwzQuFCsqCRMYcNeWPdb8XytSSYU/RnmIDBTJRYWBwLd5Sfl6l8ccr5wr2QwLVf6tmdHplkXcNkIvNEPVAPKcXkndpuGPdT3/t1LM5TVuLQ6rulh6y0YatZUmbRuVr1JgjwNUfCQRfxSBz1r/eN7+HRT3x9IPylcKQ5fPr+vF34aTwEVEvK/ieLcuc7E31RFxv8iHBJuzV4JzvREl/nxRDqvyeTh8zcmMNOSDZ3TYDwPBwtpmp9jqjjkL9QnwbWWkS4u/pUwnsHcTd8+1fKZIpBto9we29vlNGfoEeB8tChNiwN4dwdjd0RMn3ihRPXePS47vI8Sb9cgeyL6vzHbEWdGArLoHSru1Qk7trlFqINtkOYOsHSDuMq4LNQhpzmeIMc5JfpTzvYHqF308QMgKS7epbhrKnw4YfbHWGCHWLPyjkSyOtC8KiZByMp9ufD+FVTqkZ45Nj/qq+t6tbYhySZR+xWJueWcD5Yk0LWFpcJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27392f87-7442-45df-9384-08db10f0d3fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:11:13.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJlePrUFS0QXvbB1mgV6nCELzpdwEZ1Ne14spHeJDT3KKlJSOTpR7dDj1DyH23zbWb6zOVKzbWzCWSINjBvPZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170128
X-Proofpoint-GUID: wVgNw3Fvq2ukHdwthfuTlno1HJIRKgG6
X-Proofpoint-ORIG-GUID: wVgNw3Fvq2ukHdwthfuTlno1HJIRKgG6
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
---
 drivers/soc/fujitsu/a64fx-diag.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/fujitsu/a64fx-diag.c b/drivers/soc/fujitsu/a64fx-diag.c
index d87f348427bf..524fbfeb94e3 100644
--- a/drivers/soc/fujitsu/a64fx-diag.c
+++ b/drivers/soc/fujitsu/a64fx-diag.c
@@ -149,6 +149,5 @@ static struct platform_driver a64fx_diag_driver = {
 
 module_platform_driver(a64fx_diag_driver);
 
-MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>");
 MODULE_DESCRIPTION("A64FX diag driver");
-- 
2.39.1.268.g9de2f9a303

