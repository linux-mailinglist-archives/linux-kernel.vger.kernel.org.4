Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21D6A8BDC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCBWdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjCBWda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:33:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E3518B3D;
        Thu,  2 Mar 2023 14:33:27 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6TE3007328;
        Thu, 2 Mar 2023 21:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=x9RRmpMyPV9ZTfFwakDi5pdqhnuRIkgPYDSpAF1Xuk8=;
 b=B5DzLpI8hjNmtCP93mdHQ3y+9J/QyxZHMoAGSDrDYtp0UgLRlsg+7JB4xKoWXd9BIjCx
 D3s8l7TzhSc9HSE9ipaek+fSwbqm7lF8dkZWcG6p6lgChDwYuYNCkc03W4Lwty+9IulY
 0dP9gQ4GUItwqCuEudPY4aushzra+c2msWcwLCljnBViRMNzxO98FzxoMppe6OTBSvRM
 5LI1ozp2ahhSPJrkISv6LaEKPgJfJqGu5JUxwqtYv4U6MIUGLMsWN+Wd+wiyENRn4xyz
 AYzOxhZt5UHAYMXoLhcQH8Qjofxp5zfY0jQWXpSHRzc1f7DEWWTDc8ApnsDnXG9hEAZG SQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7ww2ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KW7cN005047;
        Thu, 2 Mar 2023 21:18:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8saxx3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URFpTTx0uo31gl4/OiKJp9QJ8NQ9ZGgDm9SB6k4m3cmWYHX+7XMdrNp5LQ9DfAXPWaJx3YgmrsJbhd3uLqcp2WJh2ifyJBYjHFIufX8IWJHq3bpLooxMNQv7VAaJX+lmN9dpDtEDcktcgtcf98kvgd8Ic5NmNFB4i/KfpruHZ3VaRGP8qSyIjMUCPIw18zi6fV4GNlxu2P4WkisygX9s36N8wnj7oQEw0CZFm7YLNsUTN2EvDkhN2lr9tbuPlEBrGlTN1Ge+FrPW54ywZhe67nZZ8SapAqHAX7RrxxnKJWFyWVuVL2Esna/jB0H+JMWjrO5uhneUiRBq97GIZ9RBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9RRmpMyPV9ZTfFwakDi5pdqhnuRIkgPYDSpAF1Xuk8=;
 b=E0I0pz+rFtOZa1HvUWJMHSE2K6m4YMPK3zkT270gHuIS9HSuNy4lk5nCs+dHKrxQU7d9zM7TI0xma9WQtMl7Mz4K9K07R2EKfhXCfyXZ4/fI83UsYrBBcvbR2cA3oD/jLvnMjb1J2JVL7iaR+2Yj/2KYNO6b6X547kbL45HPzcIoGxpe3pvDPPUsFgDGNcQMEDuJv0X3/6n23GhRLQ7LoPZBDvxhmlc4xynTOY5M7A8OPX2cDSQEMHtmp/rlODInj7Q/AZgx7t7+1wUvupx7q+6/tJfo4YUqamSkYx1G852+Y6Z2QlKBIEQnEauvu9TK86LVp8hLzhAkcXL9+bEBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9RRmpMyPV9ZTfFwakDi5pdqhnuRIkgPYDSpAF1Xuk8=;
 b=b3skxJ7cSYDMpFbgXSprLEvw2DbQKKmyAJdfMqz2/kTF5KnEYXEfgF04yxSYJuXwtxZNMOr6UtS3ngKkShcYuwsHCSdhm7w+CLMpW6EoM+DOJl+FvZwx57oA9Y/0xdxMJcNtoCwTFgqVj3A/deFG9IgYDF1geXD0ul9vI1xqMLY=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:18:54 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:18:53 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: [PATCH 09/17] fprobe: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:51 +0000
Message-Id: <20230302211759.30135-10-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0679.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::12) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a1b5ac-df90-4add-d383-08db1b63b9e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ep+8uFg6FQ7SbagkEQN6mxliR6zItavbQwPCSO7V/2CpZMHQXeFNsutfn5fyaI1N6B2X7voaTEtyLPMgXEKAViDLFvr8xrkm8n+oPYMfTCRS64namqsluzJdqjum5U/r7ah2WrMJId6ZBfVIkl6UXCH/h/yVnqHp99oLQeLzbDvWVdzOwfo1zGgYVruHCLWPmFKEnNwcMn6BQ403BItja1yassk18ZstZXAItomFR5nifwzNbG+8ypAVKbY+q3bog+rlmh1wEVEnV9K+2FO585DP4HkWiFGeMU0JH2LwovJC3hPNzoDpJARYvCw7AVisbrcZjuqlK2IDMRvPC39H5Dgx9wy2x0sXhdU/qdVl85GcM/Rs0FsISoUJgkr3/yko6r0/ytHb1+JgchVvYxPFAxyuB0gYYtKxNLrhAmsn0vk6McnHOrLi6IvgkRVxhXoqnw/PmQygdik8WikBtRjBaw2NQtikwJumfxfAnKmyH7L4gQ/ZRgnCRTO99BpOt5DzSRD6mWndhwlrFiC/uTcccdJ5b92CeFAwyMzCsU9AUNtUcx1jJJye/1DaDpkIFjXpPehhTHK+kWW/c43m23ug01nYgALanpj6BxaMWBsv6zYT4ANt1wZRV/s0aBbI/YmtlidR7+zVx52u/D1PXC1tGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(6506007)(186003)(6512007)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TgdzvoObMLMqOJTQMcZZlsWAtP1rHgCUI3haU8ypFv5BBit+ylA7ReAzXtY9?=
 =?us-ascii?Q?1rXqf9m7vvWAtGg6HH+CJyx7USkyrIsY49jEioySKHEtzdMbte1hr+5cVSUD?=
 =?us-ascii?Q?DmxL9zGW9cK0b4NvMcEyuPbTG3AWnKQ5R5U+tQ0qUzN8OK0MCPfwKPlYNn+c?=
 =?us-ascii?Q?aYUN3uU+gPkTBc6fAE8AsRfnknfi7Fz1CttB5sQRP0oh2pXZpSEBpB5oP1te?=
 =?us-ascii?Q?6Uh9oU6UZ6UlvBsqvFhxgMFeO54csdg1DNCv4Mq9VgFx5TGd4+UsH0/nYk+x?=
 =?us-ascii?Q?y0Xn1qK02aXMUenESRaeihl8CMdBrFUKIcjAUa4ePQT0F6x02RQ7r6CEceMK?=
 =?us-ascii?Q?/4oTMroEeZ+TFuFA6u7SxBzcJK8IJXgzUKYHXumQUt3hOhsS4Vajx8ZwkIUU?=
 =?us-ascii?Q?3t2qdxUHC0tZNZPC2UZ0du0z7eNBL1LxvcbTIERnfpkjzrvkpynF/6iUT6WI?=
 =?us-ascii?Q?CLnpYI6PkPHhjea9x4tz4/+B04swtdXeEoDJhE2/iRvgacBbyye/Wx87Ah1p?=
 =?us-ascii?Q?hB5lBKTCPApV1+wLzoq3tlFBM3FBDzxEQUWExMUmb/d4yh0H0fuPD92SeOoF?=
 =?us-ascii?Q?YzGnlWJ5cexwRvf87jEqGiIisO1xN7AZM9Cg6XJVSfyUZkoLh9lIoU2T8L6O?=
 =?us-ascii?Q?NQrjaRI26le9D/YXtu201zVRBeGplqn0Vg3rxEOklHwQDMkmPYMMXV7/ow/B?=
 =?us-ascii?Q?vqVgN0CgVIqBuz+fHv2XVLx/ei0tS+RV4BNfgk5fkHttf31KOgPh7YqN+ZRU?=
 =?us-ascii?Q?7OmlRbKqrAKWv5vuzLF23QMPz9KF63jQX163Glw/nbTMydd3DhExs1wHKp8X?=
 =?us-ascii?Q?hJTwIYg6/pcVaLikFC4cq5NmIXWB/nRN6ktJX4Bmow99xPGByLcDMcc93P5t?=
 =?us-ascii?Q?kUqZ5kAhkDorTO8NtlrVs12IzrPNqacMHKpDH2Z+4lzauZ6HQaxzCSalZb7v?=
 =?us-ascii?Q?xOKSQ2e21UzAupBDzHon4iV/QEIzjPWQFasqixQfVYru1qU++k3BzIBSenqN?=
 =?us-ascii?Q?b3md2QJ/pUoeYXj7j8lO27ElYg1Nu8sapT2ek6+a7AXWcuifNO/iWUxTvz4B?=
 =?us-ascii?Q?9ENVeGE0fbL7KMeg8+d/eOT31B326tgX4tnxxGyYkL23EwsuDPe0zwwIVmxe?=
 =?us-ascii?Q?+j8cCGHkreSbAIEcvFK1rEKNsRskK0AgJPRcr2G4zWMhz2QrBx7JolPemn7X?=
 =?us-ascii?Q?PZUdteFDy4jMn7sPrIhsp4xQoHvj0oBmBJ3w5YTwiQYS6ihMTO32UCOKXQnH?=
 =?us-ascii?Q?jkllzrugWm6KEzyPu40dN9oMFNP/T59vtfboFhoJENRcRoAtNoS0elC80Iko?=
 =?us-ascii?Q?R+k5G2B4Tc1kh5s400awBFrk9pJVhyF4zAhZeGFNmieaFVSBeo/D6CKS9WxG?=
 =?us-ascii?Q?vsTif1+TRs0z7OcUMmdiJn59QV3CAwNt9LWBF0s00W5/mV4XUu1vAzdHw4sD?=
 =?us-ascii?Q?nYsod7e6ZO/sjlqFawb1C18OAwSGl8MHn9fpL/x0QcfPYE3lwVU/FyDipIgO?=
 =?us-ascii?Q?HG2dG44Jg9V6nN+1s/ZeXrFkhT0CSgaqmZF9pZ0l0e4/yeOPo+wSW3PaVo/2?=
 =?us-ascii?Q?3InOjxW3D3rQPnxT26og1ZeLgxjE8gpvyoQokBa/F4Rfskst52lcKvpRtmAD?=
 =?us-ascii?Q?0lDy63s5a84oBihPnSNI1d0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /NDVWthdeL/gMbfo3CZA7AjkoQlYD8R/r0ed2wIcjHBZj3ZXU/udN8MsCpjlmb3ldtS1ZYxdmJuHpVqfpkYS1Ih4erhVfeddn2Ovu2obkGPaQzwA14BS5vZFCl7cWocbCUk6aiRIJLQY5Ioo2WIAaW1lDGlqo9zpGXas8GDHl+taySSGNJ0ev9fpB0VbmD5WVe0dOmg8QxG1/LdXu3tK9j1TYYflZU13fZCVprZ6qjrif7xCZ9QmMnotyRvclXUufAg+E1lKlqw3irpRloUrgzoqLaL/od8AqFvwgJjhzeiCJcwrlMdwEplq4uE9eq1GRW5QeFNmekJ7ldg70ft7uuqs3LuCnXM1JyEvPvniw0WsEoREQV5uipbkPcvvw4DURzheSsCFCVm6bGZM9B/phHsUgSadP4nThofF9hdseAGsHzdYHqYvYUhyUcqua06T2+COCv0ekPSYu4YdgqzYoZINTbHl4VouVyGxZvrU+/FcuiEEsslYKr+AoIRxGIX2FxBF3gsdHQvLAXweWNdauhqFZKEZa/jPJxiDSr6KfHRyrxKRe91auqtl4+6e9tWFpQtx84XPmZ4eYWYdKYPxOS+yO9EEuYEt/rU3MkbcDFiTjLok3Ce9E2WaifvJB/Hb6+YIStvkoZ/e6GmC9aOOgFRKqXJP5fM76KQ5IhvplV4Ju4n+WPlhGkbyaLWB9A39gOfYbnsTQOIdxUMJWpE8VfRGjcNpoXssYUulad12K2il3JQJjSG2u/Mkpz+Xf51iXO9yiVB7dPRFYYW8mm9ozRUm/UnlnA6n4EZJvYyiZ9ACqYipwJ3bfoZjlsbeqaxO
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a1b5ac-df90-4add-d383-08db1b63b9e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:18:53.8513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOl4vZ/48/Cz0vHl/7LOgq9cMI/yriJSNV1WEjgqGhQZ65zmJcXELW594nVjbdA7tILCHVDKTO/Xvqk2CTpQ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020183
X-Proofpoint-GUID: -J3mMqGIVpeEEb_zL8P2pU8IddsK4HLv
X-Proofpoint-ORIG-GUID: -J3mMqGIVpeEEb_zL8P2pU8IddsK4HLv
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
 lib/test_fprobe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index 1fb56cf5e5ce6..fd6153800e56a 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -168,4 +168,3 @@ static struct kunit_suite fprobe_test_suite = {
 
 kunit_test_suites(&fprobe_test_suite);
 
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

