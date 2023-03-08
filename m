Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C682F6B1266
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCHTqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjCHTqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:46:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA24E85379;
        Wed,  8 Mar 2023 11:45:41 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiCrW003041;
        Wed, 8 Mar 2023 19:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/WyOj0J0K/oIqLF/NCdiTDxqjTcvuZ3i9Y1qst5rgmk=;
 b=NvGP85OqWVImYwYMYnWtOHubitbGKBuXyCCzpMKf58KN19OMQIHzytRXeICeB4gRCImI
 GYBifdLUwP4n2ogJo9e9SiAuZ5G/1H3fOk2OekiHXfyrqWyvk/JPyJGQOsDvc1z26Dny
 ZFl+k+6thA85n/FN3H9Xw4vEr/1MJQhiA+qodHLLCEiddu4Xo9wg9WXH7HVrst8iMm/T
 w35cTrPuP9vj7fhEERjv+O/vJx6uF7/tD/YkB9/pJlFKu//tVyTDUmYj6YekWe6uPjRy
 gMtlTexJ6CJXR1N7/ULZ0zW5+8WZyA9Rstd4SFaHkdmEmALdi6RynqfsjAjA0FCXx7ym LQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415j144y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328JI8Ik015552;
        Wed, 8 Mar 2023 19:44:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6femr9q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DV/EnZSF65pnnR7JcjBisxTn2BCxCcRiudwhB42B8Tdie+ViGGFf0OHfpqTuTTUpuuyYSKlPmIdQQZMWIhvHDZkp5T8rwhuDgR5p+5DHl9OZR6huX/nQt7+xP2Jhq/B+tUKMGc4UyMoe3Uu/PpVSgPJM4+3+jQ+7KkmMbOOYbs3Z63JBmdc6WJWPwehsHCxG4l6hSLHDZUzX6t1vWAf0Q62khtUR8TTqBz64g55jh2A/HAHPBCsUQ47t+7ztQNLdaeWYPNTlNU531igiW8QnJfJRXKKzYXzWyJCxUMmIhQ6Me+9SksLGr6GTOMvsX1TwZ7l/U3qEN3DSKLxrWy/h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WyOj0J0K/oIqLF/NCdiTDxqjTcvuZ3i9Y1qst5rgmk=;
 b=oNqm3CYO2RJwy7HSZ9hNYLimcPijWHWjVd3dF0mI3m0XRcWCHtY+OikAeWIAt97lbVcADCKSSsgv2iBxD7NxbuCFsetJMG9gJSquF7nNOIl/ukLUEz/rhhrck2Q1JZ6YEsaQA+BiaJqKR1G3TSAIcXhn2h5crk4U7Ma+OIDmWkY+VA2FhUMLi8pAnj97aDRI4KOHy0rP3nnNcbek0Dl0lZVaMCpMduUXA6ZENFbMZgaOaHpSHE+RYFQVPd+Mza8G7fnrRGYJveXeHQJwnJspBOKfYj8cxmLVJk++I44mmYwdLwWMgEDs/hwGJ8VTLJVjivTbEQ2Or5Orse88quDoQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WyOj0J0K/oIqLF/NCdiTDxqjTcvuZ3i9Y1qst5rgmk=;
 b=h9UHXnHg1zxy/meDD5wzO2A5vtGLeDO3AIN/uh955hAlP/z2gcb11HoPLAVMrCxyD+s/a06TL56y9XxkkywNbSa5ujAuRBTIUN/SuDThv50HWJeE71bT0mO0ZIVnmo2B9x1SX3AR7F+at7HxVE2PFsGOBSty2LQW7cFYeR7R3Zk=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 19:44:30 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:44:30 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: [PATCH 18/18] mfd: twl6040: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:43:07 +0000
Message-Id: <20230308194307.374789-18-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0101.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::10) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: da2e98c8-9e36-4ad0-3507-08db200d88e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gkaGDj3pxgiXFK2TTiuz0HWlib1bD/IcyB4KQSU4cqlVDbZuYVukxN5B/bXMITGUrwAOcoYKgmmbnAqBToCSygzCCdxCVFJFBxJXldISh4ILRyabpR9qWdlqy/3t0xCB2pdm47H27tmaQ9U+8mBU2l0fnuhQ3Mv/i3+mrizAHi5h2JtJDQF//8Ubod1nhrw+1VtaZKQDh9V0Yl3K+AczWjsLgbhFwzUflV3GMzgj8M778ItfuKFYawnQOlUHDkS1sBWwCqFrTTDMFTQa6ymaOhQURay01tqeS43bpc65rwy7HTZ1TX/DJt4QUFY0VpwTZ3Sivcsy2qcuouB/+xtDrnOwL8lrct0ZE6JaMiPbq5P0Y/vebISGm5br8fd59t7mMXTUvC9Ee+GPi53vfdkzLt8S89fKqe/ahQBzoPtf7qDTGSRbtJsQSWURnqaDn4lBI+93wQAHZhU1D6mS2B2pRcGhlCEmuVZrDzzoL8DFSTMbP4Kzbrq6YF0/zse0PIs4j41o6JdgwhDsElozOnG+jSJ2T0uQwfx698s1X8vfp3bh8GGKA255tKdiLI5dCJW50+mlCvXYcWoGd8wWLPNfUqvceHaCPKapBZkUew7n4Xak3rYBsWERyxBvQWeP8HekygfswPNwfT0ks9UgGjVFLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(44832011)(8936002)(6486002)(83380400001)(5660300002)(186003)(478600001)(1076003)(6666004)(36756003)(6506007)(6512007)(316002)(2616005)(54906003)(86362001)(41300700001)(38100700002)(66556008)(8676002)(66946007)(66476007)(6916009)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BA6xI0Xof5XV6tUuu0RZo+bswZQpAdW7k7d2O1tMKrXUgabjBYhPnvB9Ms+D?=
 =?us-ascii?Q?uueHaz7jXMclZtlgo0YpzpyB4/MI/wqlNuLkRUL2Eyq7edD9au8gQu0JgACL?=
 =?us-ascii?Q?kC02ZU1o6M9lK8OiRVEyqMOBlWTvryILA/6xoniLEsiLjnZXpJBvm6FzPr9W?=
 =?us-ascii?Q?yfSEWZEk5bqldtopzbO38lX+rcfiGzYy32jJQRilyaQek3QjxoGx/I8asWhJ?=
 =?us-ascii?Q?uAsOj3qtozotWq60Hon3C0CIG9Qx6Kfi3dhFSuOG+zQGG3cEnKNavb/o6Mhs?=
 =?us-ascii?Q?WUxVEDWTuoKXACkhVODW30QmkRLaQVqjrw1RF12cuO4XPpsW9MaOSslb4KEf?=
 =?us-ascii?Q?Q5NeXeuF20HfTXBRS3CL3s2UvAoBE9qhD35k646argLya7c9Oo5cQHR/SwtX?=
 =?us-ascii?Q?IQMSAX6nT93bO4tBEUTkFSKmjd49MJLAo+Pd9rp9h1OIYWneqaeUxi4jKdM6?=
 =?us-ascii?Q?vXL/PSOMxuzHlX0Zi/bVFtgH11a1CcoQOjC5AhjhhviSrUE0tetOkZKoiObM?=
 =?us-ascii?Q?EDL/y5v6jMGT8c4GmaGHc2UqTfZygV7R2ej/FjJOH15+fEVqvDpMpbz1SYul?=
 =?us-ascii?Q?Hp+VmJNxsTMETLALgA+BwGKyP+PgItybJuSZQg7jOadA+qst6gUDELg2mDAz?=
 =?us-ascii?Q?3CVNSmLUHcDOwhu2HvHKBFHgXLP9Vz0sJQqstiaUQBAUzn+85pyvMA4PMSil?=
 =?us-ascii?Q?bEJFtEVpYFJLseqPPJFxOOE4i84a1YecSjMJP+lOqSOiAW6lp1cWTW//atet?=
 =?us-ascii?Q?Om9m2e+VHCgERJT0hbPweDOGiQAq+JMP+pwd8Z9h+0qqXS28Jl0edcpMsxaL?=
 =?us-ascii?Q?hyzOT6SwWR7h1sxH84V9mWg/Rn7fChle/7ZjQz3l7OHMe6N+ztfm2Lg1cs+w?=
 =?us-ascii?Q?lvWvHYv/rVxpsEh5xGcC0YQdVKfcHjUnTL2e50JdoqhLj+w12tzWeBlKoeng?=
 =?us-ascii?Q?fVUNX7HgGb4ttVE7ZTcC3FFVHWB4naG4HrJbKe/9+NZMhZdVcr5upGUi35Qe?=
 =?us-ascii?Q?lklDTsrlecqS2wfJATInB+0pkfZ/pPdIws16h+9l9NGIFxSdNl/gov6hG5Il?=
 =?us-ascii?Q?R1+AaBb42o8qxsWIg7u2Vg3qYGOzZUB9lsX9pffUQaG0xLPmgKjFROQTWvla?=
 =?us-ascii?Q?EPTUcbDVlAyjyICtlFyPE0FIpqdluLknNWbGLse2A8+8p6pSw3+Wo9LKcqag?=
 =?us-ascii?Q?ttYbBKLY6uVjlq3tfzKn7dIhSwXWkVB0BSuZEcj07lhbuZRl8EGX17SLQ0yj?=
 =?us-ascii?Q?+3LhW/DYLsMBBbBwumPYN0g1iYijcLcvc+kVxiJYmJJXEmIQj/wdeZTG4mc6?=
 =?us-ascii?Q?r91DjONae/isDsFwZ9bbIA4lfMzcG996KaEzJo3/c14vy7dB7DwN2Vr4mPLU?=
 =?us-ascii?Q?OyFrurU0NJyxH7SeH/mM6CfGFggOeQP14vwuOQZZFucnfvMkYkyKxgrR8+Kr?=
 =?us-ascii?Q?JXHbSDop4JqmmMfrzKDtERoh439eusT3r9WB2a2qs0mQeWUDE3CzlkbOPY/V?=
 =?us-ascii?Q?PtnMOkJCZ6eQ+ExUT85mkm5kWCIfJva8GMQnYTBn5fLzZn6UV2i6EqI411PF?=
 =?us-ascii?Q?T+uwGJQ4LP5EUpjgrsAc+npzchabsGc+cxWYRKV8EThMMlL059Pw52fNdXc0?=
 =?us-ascii?Q?KLNKeAjJ36hn7JYJzcHIzEk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DB9iGBz5FFFJpKQOoFlO9S0dNa91yhHjjms0LrHzVgI9FN/nyPSFD/bf7qnECLRYDVb1Vhvty98lK56LV3HUQ1DdnkI0E9YoK01N9W0N8lqYFRpLk/z30f7Upxa8KOiXbNlY2324XJhcbXcv8jqIVgs9+WoP0cIIzy3QtHe818u/0COygBGFIt1jjsxlOl1zrzJ6Z28Zis5y54ykNEZMUlS6lyj2EFB/uspLNYHw99lG+drhaD5fLoruf1MvhRxolieYa8634Ma+d8uwG0J/Xklng914u9YBvzBX8aXsgZxR4vtTof0H3dAGQGFXJ9h7nqW+Td08hNCbXTyJF6/5E1KU8u8/IrO7/bBAAt4fbhYGq1X4sscPU4vMutRzhg7gySNizmOxX3X2MujCn07EX49ke50jroh1Cgd/Gt596QLjTSW2/QKsXkwm4xo8kZPa6+shTuG2fauE7UUX5PGez77U8Bs24Y17B9SQyBTQNr8zWWmWVvGb8E9c3ow9ppC8mTVmgqVjWkgMhYoRTpw95EloAh0R2gi38XG48er0jwaLnjCDFp+dRhwqoFsxqr2BAvBsW+JxiKkRe98DyTsb4/rHWyZKTi35b4LEeUZvhaKpGvFnUlCPfIzt0dEsRZaDw+ld+p7RaFZG6DQxPWc3uuNg5+bzVIAalz5mcIK17VTORTf9QbVIYYkz8bjP46UauVB7UqpsaBg6FQS6AifMzTpGXQwtLhCBPLz+C0RhoWqu5cFaIG9PhOV5uoToTy9Bc7v9MPtx1Y8BYZmvY+mV1jeyqnsRGk+wVMw8uxcDMajFCwNtBP6e1wer7onT6CZu
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2e98c8-9e36-4ad0-3507-08db200d88e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:44:30.7315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSeFa09gYnIlf9gqIVbSj8ENemzhn9+izkdzARFB85Z3jRfGlZqN99R/RVygkwMZD1AtU5SBNdAo8C2VGS3DLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: 6rXVO0jsSBkEAIuVCw5W_78d4gRGGdlc
X-Proofpoint-ORIG-GUID: 6rXVO0jsSBkEAIuVCw5W_78d4gRGGdlc
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
 drivers/mfd/twl6040.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index fc97fa5a2d0c3..e982119bbefa5 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -839,4 +839,3 @@ module_i2c_driver(twl6040_driver);
 MODULE_DESCRIPTION("TWL6040 MFD");
 MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
 MODULE_AUTHOR("Jorge Eduardo Candelaria <jorge.candelaria@ti.com>");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

