Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DA46A1E34
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBXPLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjBXPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:11:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05586A9F0;
        Fri, 24 Feb 2023 07:11:12 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEmwlJ024909;
        Fri, 24 Feb 2023 15:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=lPZdgEPTsTdnv/Yrk4b2vQxTXO8TalhMi6jV2539eaA=;
 b=hBfnv4TGX5firUlvJw0b7yIs7X3JWjz2mAPBgqAAE5DR8oLY5Q5smx+44FfjJXy1SyNz
 zH1kMOwpgifHoJQBuQMgvRQqQKQx2531XkUzfS4QYWpxJHDaIEH1RgNcKs1fnsFj/X+9
 O5LNra9wZ4G/L3N56PkHtq0wVdkjgFH2f93ZPw99lWVJw0tjXe9aiGzKbXQ6qBcNpLEc
 fHUG+Ur4GCS4MN1le4+9woKOD+GivyphW/s/OWcaE/D3x4C4cD8Snj1fUTJx59GPk9m7
 VIp6B7iVSH/ySHukWPtvo3YhCR0b+/6LBBA3VUXcKhBODQHlacCJTQiB6LPIME539HXL 3g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dwatq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OEhwxV031603;
        Fri, 24 Feb 2023 15:10:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49qppc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUvtBgzOENFaH8wiwhWLoZZJhg5B2qV1duaNbSLZ10oal7BhVKVhF0tP/KR/MS8mGnjRqGTqhCNB3zSVMYU/u40iCGfha35A+NksrrDEcBk93Ed2wjOhA5WjqGGMoQVVeGxqpwkNj7Hhx9JOHA6VL9Dq9QcglmFnQpSlKU+Ma8nWzkdaFMQV1I5KqRWA3Vwzi2mplz1Cd8pBinsY6NFiQqgfG+UwdnQ7vB6hYmxoWfJMbqC3cv9av+IVc0sNTVFtR4dkwiCsQG0k5oAdKfPEM0jcXgTKLj+xv99878s8tLoX4n+bdzawvW9OojY5Oq5W3xOsccTu179TlzksAiAISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPZdgEPTsTdnv/Yrk4b2vQxTXO8TalhMi6jV2539eaA=;
 b=lr92HpwazrRXnHAkUlaTpZdSOTr/M9M2AeSPpBunVTkaegFJ5lUB1tXE/a+rZw0LvFPBrwDSiYhq8hubmqxk7GMTy++OYQ2LI3E1VGHGn1lR6sA5Zde1vYhnTAGxs1io3iD/VHlpyuqcsNJqNoGpG707QTKJs7D2KZ+Ro5MyDQK7K7J3OB8xONVVZVwnHi3UP6UfaCVpgVnx/jjFw5GQeJmNdmn7pZIj7DJSu3ABKPaVriUv6X6ynCHEmUQNlUDGA1C13nPU3NiOrSRom1Hnt+//Y4cPHsGiN8fJAM5Ub+JEN/LyhVm2az9YL83Z6gQTlPwux++u6Ih9AZz0b1fRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPZdgEPTsTdnv/Yrk4b2vQxTXO8TalhMi6jV2539eaA=;
 b=qpc7k+h7yJocc9r3UloZEQJUE7WAhYJwsneKY+YuHknIdWJCfBTc2x7pzhtnhCE5UsrqyNV/GvPALTCvIV+D6e2BgURNohojAX8Mfzo2PHbU2P6fcvEIGR2+MSd1Phax/QyBUZS+PvZcgNcDfI/f++C3Tda25dUXrSTZsR6Zeks=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Fri, 24 Feb
 2023 15:10:19 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:10:19 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 25/27] nvmem: core: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:08:09 +0000
Message-Id: <20230224150811.80316-26-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0380.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 3575cc86-b33f-4108-cdcc-08db16793dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WL3QaT00psMVfqMZZ+9avlb2/7UTFZtL3knFfqbFGfmHa+Vu+yPKJNbuJtrQDYI/o0mhY6ZoYd+MvDeBBkw3DlraOA7BNFwwvzA2vJx+UzPpFs7ck7/2szC8bQGb0F/yWTzBY5nYtcq486t4FYTsE47nwCWXNfkkoEPnaIhn0voh1kbLmeUIWl53UQ/Nw0sSpZ20bXWZH6Hkz20zduXpYFVIilrnCSL8QzANqSMplAtVcO/B58OjJ4rX7IIaLBhMfUIENbLTq0W94a9VWXPnSUyBuhWglDbtDssO0KYrCL0cKqEoLkuy9AC6wKmkKaZUoUf9tPJU0YsEJNUr7SZg2dQU3DIH9l56J2P7hdyCH5Lke2rlGvI+NyKKsBOzpcAR0EWoXQc3qoJ7czXZHxMqUAzffXGReGzuqRySJERHVTvhOV7UoQLdEDbIiFzwlNJRk3VriWEvL7USD2lRfnx+brlsJ7t/j6SHKHtCDGaa38o1BlJF9vWnpiHnHadrtDOeLaK2QtR9pAXJkk6gAP03f9x5CTPzhQIj/DqxUi6FnceACuOUOO3yduXgh/DBsaXjBB8shxcPVPQBOjz4rPgoW8dI+EwStAt4f94U8ySyBRe12Fs2DxVHW/GjIkOQh9BnF5d4QPUO2L/aFZ8IA0cPhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199018)(83380400001)(36756003)(4326008)(66476007)(66556008)(66946007)(6916009)(8676002)(86362001)(2906002)(38100700002)(41300700001)(478600001)(186003)(2616005)(1076003)(54906003)(6666004)(6512007)(6506007)(316002)(8936002)(44832011)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TmwDtbiXTkdZXDmPZpGihbfl0JkE8xiDdtIFHg17pVkxpclFb9YPsU5HTDFc?=
 =?us-ascii?Q?hDAwBgyz5BeUTfihBIfgQKfUVmvtD4Ibus+VovQRIniOqi9AvkKd8KNBpLHE?=
 =?us-ascii?Q?nvG/lJrNzXF7PMhz9XPR4Aa894ezqS8gQ12wiqXPlMgvG0kaneZXPCuxEOXa?=
 =?us-ascii?Q?HJWPssVfk5YAsahvs0SrMh5wWQ9hY7aHuoNlNlnJN0QBSkkVMj7OAiaAODa5?=
 =?us-ascii?Q?vJhrDrPW0PSEfiD0xetIOAAIPnj2SgSq0tQQ7vFQeZ+XXoAsb7EdwAkZr8Ur?=
 =?us-ascii?Q?PnHTp8nFT22WdyQ+ecUHgaGjlz0U6S+4BqplTkSYTsLEr/rcL5Z/nXGhfUqg?=
 =?us-ascii?Q?ApgIqGxEIuG2m8vG8L8boqulkkKqR3wGdO4MqsGSjHGl1xHX32UYJZ6LNQYD?=
 =?us-ascii?Q?ZWT6AUuqd8/SZtd1l3rE+xtN3qBVrDG/Ncv0WNFNLlplu4M5e9ngNkwmL5yg?=
 =?us-ascii?Q?IlUN+WyRZukRQ/t+XXeVoTPbaLf59B9FUDpctD26Yq6i78S379CTc4l8QPxX?=
 =?us-ascii?Q?XVbeB1lGNIgyUOLWl8Vpgki06e3hTZPFnGmCLOrkuEs/MLBHpweRJhnTxIp2?=
 =?us-ascii?Q?j7q0B703ONmIFlsOU67OTGN7PEFjF+M9NR8D7/oZ0RKyy77914vmDQd+b03W?=
 =?us-ascii?Q?mebMn2IOp6c8gYA7fNZp/1vqOjQ4Y3yN0hfQPgldYbujroy24o0YnhjKiYsI?=
 =?us-ascii?Q?aLkMGI2rf/anUaBGqDPYmMAC+VHu/npV9L6O9Hzas0q5F2ND2FUrlM0xrUJC?=
 =?us-ascii?Q?LWyeEHNGJ2n4T92u5c0k1PX9E1c+ErW3I8Dwc19Ioayz3ITObpVKceSus7tU?=
 =?us-ascii?Q?T9M5jPntrd5mCfwAxZcxGixrhQibQtpAF5WmJQUwVXR2Xr/FqFsRdMkzZDBC?=
 =?us-ascii?Q?jU5+04IF3TT73OSrEjZUAzUR5yvRkRjf+57IzzQ1hKj7hKsHaVG+zZPph1ld?=
 =?us-ascii?Q?lR2FzZ27C7JNVXVvSdEfh/yQ2ddpJoJ/MfPwAVetcZeOudi1IAMV29VhHno3?=
 =?us-ascii?Q?1rej/j51kmMF+Q0eAecpzv2Fo3N81SpO+IzNepwuwb6Fwfon7Mk9LdD9Hz7p?=
 =?us-ascii?Q?nUJB3h8BA2x/tnFMisPuctXWaPEOJfzwVC/eRlJRsCObgl9FMZLQtfevO7z8?=
 =?us-ascii?Q?WBtlReftBpKdtobk6vZ/H9ESfOQ/Nfr82XCm7ny5sLf01n0l9NchGzkI2j+L?=
 =?us-ascii?Q?oxFJjBe4VkIPex0KxPBdFAiI/Zr0LMmmTF8QkOpWRzjC70AjZToD1QICi1GO?=
 =?us-ascii?Q?YU2WzGrCfuhQK3vlLc+i/2k4Qqw7RD+7WpQgppj4y1XUn5ZEFvYoO+31w5HT?=
 =?us-ascii?Q?jNGx8DFuWg1TWqriXIPdSuIxHdfyGmsM4Tzep6cTRlyV9FMJ1u+kejCAv1J4?=
 =?us-ascii?Q?itAogX2rnzeUJuP1LV/KRxSUoPwhsoL0ceYS1GIY9mwc89ZjGjJM3AvHjSWG?=
 =?us-ascii?Q?6aFikzBIUXsa63hjTEBTsC8oXPJvAQ+B/RPR54guWVGJ0fDwGANUGqNZ1PjE?=
 =?us-ascii?Q?Mp2ZkB8GxjhQ7BDEa2n5gG/kuEoOl3//XHKbalfWbjD8/a05NW6UkT8W4BE2?=
 =?us-ascii?Q?2FCk2+wh85z+NfHVYHGyEHI8NaqGVhwnlXWK2Myh490w25vUi120jDGGtO6g?=
 =?us-ascii?Q?wZTvXEUwQU1KUUXu1NXYtMQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qq1zf+59xg/cGQhaKbLuPSe5xM1HB5agQO9ydx4m62rXj088JMn2q260CssQebRDcQAT05yxJ2vTOg7cYCtRfPm1Hc3w/0vsVJakpkrK0R9aYWTM0ZwuDTn8FbR5hhelYkdwQh6fpnvzs4Fes/BzHUxrSCFiqtQ3beFVRMlEa7lvdgo5v/2KcXNVDkmOJHAcJu2cNoQhSIWYtV7wt7ac0SKZ32UmFXKZKVnNwVy2bP2vfbQXm35BJKSXa37xuqOTiXIC7Ehq5UHVcOIR8j9D4h7aUUxG4XAphernC/m8qgKJwZuGqqqQOGgRsiXIHNpeguKqHRD+PRv/gpIKzC6ly0MzwX/N5/OvvoAi6fXcEYaDN9QCiB512ksMm6iFgera4CTTzhWqBT8+iUNV2cCnsgZr6ipgP2ZEprlLZtPy26teXh3Fj+1ldyFrbJFO9JrVE2LTYzn1Ux04bC/EC6BgMPuSN7DxgAnVlcuT6Dfy1I+3zkqtf+XZuIe64FIqy5aCjodN7x5nBF3s3oqAhpBvy7qmf/oSRFVAL2raukSIUf+mtYPeS6VFOoanj0u66RveCJqvPeDDGLLzUwTi5KPJMszSzRyHTu070tk5G7JYn5GLaMHprAhaIxKhLHFYN26sVeQTxEltyZIm45HfmPGmt8dSw9Zm4mIvy46qwS/4DfY/isrSqxB2PiLaIPwBYrfZinIdwaevZ73M0IzO+flFQAeasdmkqnS+8bdY4L8JG3Dbh5sJiXIzLrnXSJFNsQlpgeEx/H5URmpFWPtz+htxL6EuTpf+AmgCju+C/6wKpEKae1RZA/oGluf6e+qP4FKrkSJXJaE3UBkvpnOwIYoKcBct+bAcD5h7NOHwgoZyJe0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3575cc86-b33f-4108-cdcc-08db16793dea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:10:18.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHX6IVKu/io16dVv5PEReH1VX41F4GPzoPwF7Y91DWZzxf7SiWFlouBTvhV/5tqBFBBEHbqIiDYScFjRhLpSzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-GUID: 4C27Bwm_NlLEg1LLdVV4I8mPluNC9ZcN
X-Proofpoint-ORIG-GUID: 4C27Bwm_NlLEg1LLdVV4I8mPluNC9ZcN
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
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 321d7d63e068..b50f25b23325 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1955,4 +1955,3 @@ module_exit(nvmem_exit);
 MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
 MODULE_DESCRIPTION("nvmem Driver Core");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

