Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87CF6B123B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCHTnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCHTnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:43:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA374FF04;
        Wed,  8 Mar 2023 11:43:29 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HijBD002789;
        Wed, 8 Mar 2023 19:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=1yMw7bO3pNhqn3btTwIyqzrxJAqGrqo7wsS+QGQNqs8=;
 b=09vlzdx70w4/a/dY64kPlfg9R5LD1xB+8lMVp26k3LDySVzZObrO68IrmiSeNECZ7+3/
 +wI+Cwcl9Waw8VWV89jyX02YDH2zNUUxxQXjZ138a9WsdEhl2TpjY0d6hFfw5BCbeXYz
 g/lmrn+mrv0n9yoX6V67I+3nI+lCeMCPp+gJ7bc62cO4vdji/QGg7s7RhEUwYS64fZrf
 vqGiQhDzcd6egr/jm9mZTZWFjQ83feU9ZEFEg9sfpZLj3hBCgMybAiPBLDstBpo/r6Rv
 7l0Xpa6wwqxEXkdLCybAlRmAn52yOQzWNRPHZhRK3/D7omztNd6IauT7eRqFJsTPH0qh BQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418y137c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328IMJbS021723;
        Wed, 8 Mar 2023 19:43:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fr98059-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLHfbnkMlm+HRlAvpd4w5Ca3wAUDvytLCPiDNFYaub6ku+zhN03B1ic9ptGS1Ca4hHtKeOrq2q0SDY//JHKg2RJ1WV+9eiov8PnBzvP/MAA004Oe1LGWdqvMed+5p6mCF7nIUQjUJ6hPtCdTPAOEe7t0WAQBeEe/lXICJ6ywT9qfI+GrwAfLHdvZ8tiEH0m87IvcrB5J73iK7/zWXCS+eAflZh6zZcMc03EBwH2UUTuEjUQdwPvHfutU3ZA44630LtRns/4CrRPbunB1QrAy8Z+1qENKnzCK8X4efAGicXb8FOSCFJXaNrE3OYkOr6d2Sm8NOm9BsuEDnQfzEsrL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yMw7bO3pNhqn3btTwIyqzrxJAqGrqo7wsS+QGQNqs8=;
 b=FSDUTAPK3pk9OydX3+H1Kwkfx/8BCNlcv4AVXhf3faRaDdvInPM899nunZXazrZ5lMHx/8iwaO4lt4tQDeW+fQEKXzONaRC0EaO6/Pi4PybVNChcOO3w1F+cPDvk+caOi6JFhM0bt969MmaEcZmg6OzglS6DDSivTGWfylA/B901LJOAzLo4s+ZoD1gwCowzyfJCi/L5KmSPHfqqi1UutylY6uimm0P1g+Od8/k9l3t3vV8QqxuLLNSPJ67hoZLchFxpfKkC+IPzVDxgs3Ou7oK0Hq4nwRz4vTP+ShXJLT6Za9xXFqcXR1/V9m42V6iTrazZiQfgzejUCFWROUU8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yMw7bO3pNhqn3btTwIyqzrxJAqGrqo7wsS+QGQNqs8=;
 b=jnJN1Ir5CVW33zgJScpqnQF7z32iRnBY1lajs2EyPYeNFlvVkoRmOqHih0qXXu96WTrtpXwSluNGOqLLkZPJIxBzZR23IcKIxlJ8GP6Tn8bFemEwL2opDXz4W6zLW+/d9XX3qvXZQThJf4O0+pXgTJO7WpFMuypikZw4BJi//2c=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 19:43:21 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:43:21 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 02/18] mfd: da9052: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:42:51 +0000
Message-Id: <20230308194307.374789-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0121.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::18) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: c00902c5-6172-4c90-3157-08db200d5f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0ZZIkvMiROZIiZBPyqw0gX041siqit9FFiWRMhzgfDbnZLhKCf+LC4B/B04MYIPUmTd8ARn+uGv2bqmE1GTHCeVwXm+b9DwLE7QRqBupevLkIQONQBOzvaHCLZL570/mEgMnF27P2oIcwgbXEev65E7D5Lh1NNsnUDNyqFcufWqwiNIgUv86pjCeAWlIU7jyXnGD/aouPe9gjNwNgyABpf8JGRjdybzkP1VzYFgiLAYz45gjvu7wk5WjyDni47GeujIiq0K8BzUba8CG72CWaZfywJUf9alJ4cTuT0oSYQ6z0Hrze7hYuejYFDBc3SVyxy5Wi/aqmbZKHbXTLjb3qNOIa4wReXZuxotYiY0IT8mFxTU3ZLAr2qkwYbu3QVbYg7FfHjs+S5uSSRSqVNm9W+cC0nVs8eA8XDxegukRahtSPqpMEUo1WsSV0qvA81cMh7kMcClk8qGiLRGM7Xbf74Z1ey90m+1POECrt/IONeMfFmseJN/8JRmYwG/urSRJ9N5wpcPEld2sfUZg7hupAh4UjxqBDTFlm9Q+LgHnpiDIY121+gVy1z0qHnqzLrbFWm4LW1D/SzGEo5f7adIOxYV4JAukcJSkkeCalFJgfRKfFlMfcQvVxLPPAH6OpCO/jsLmysORVVI8Twu4QN33g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(5660300002)(44832011)(38100700002)(86362001)(8936002)(6916009)(36756003)(4326008)(8676002)(41300700001)(2906002)(66476007)(1076003)(6666004)(2616005)(6512007)(6506007)(186003)(83380400001)(316002)(478600001)(54906003)(66946007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5cZwwux7nYDs3AmEo2Oz0fg4aDB3MSUekfVi8+lLoaV3ZP7+0HfAvoKsL+9W?=
 =?us-ascii?Q?8SNtfhpmMph8jvRKb2fSSWMSRwlE7KVSpvF+Qd/LQAM7bRu7SaEhKYLLJ6t8?=
 =?us-ascii?Q?13NIPvbQIdUowX32pRfJt2Ru1FcgfbSehyzrMWGWml/UTbA3v6oEfITleKOB?=
 =?us-ascii?Q?txbk2+VJL1DgG9HpbEQKaxLHh5d4jGA4LiZLdSUZR+KR+ZoAA1Nadl/c/oSZ?=
 =?us-ascii?Q?E+PtOnQx0+qlRVZCHpCq0W1cRly4fWANpAzzJLf1SXVguRfNOMJvqe/71QCr?=
 =?us-ascii?Q?MZ52MrXzp/ivy7uKCtzv32Tc7M3uPpqPA8QyX4yCefp6fo0gKsFzghJFHOE/?=
 =?us-ascii?Q?MWuk7F9W2bW6S7rdSMrXiBzi5f8ApwDElVqKfhURryUh1ItF3/o47j7ljtPv?=
 =?us-ascii?Q?mGDXDHNuuCmMDsrcU2Kvo+mL84aIf52kJAvQGAzJbPsK24Yg24TbkAgc2pKi?=
 =?us-ascii?Q?7Vm2fgqKhXMXpsPa0re7PQEqsCixz4et+/J+rJLIbqQqzVzar/wy1yk9cYGy?=
 =?us-ascii?Q?PziE2wJ6zR6ox48lWf+P2nI11lzfMTmgHwQ955nfG7ZRLLpdxPSGViDATbtn?=
 =?us-ascii?Q?PSKaDKnCWOHdKMwokIcmrkKKS1LJY+1jHE+n6GInN+97vytKcNo1qVsVZkPt?=
 =?us-ascii?Q?uLvuD+mLqujjrdklz04RUMYymzYkq+C3xG1NnghYCJEYlPqxcHPyz1oJrRTv?=
 =?us-ascii?Q?QFIGkKjubiQ5wp/N0PJi2uqZqmtwGm/t08fTwi/b55psyiqjo1q5oNGMKohy?=
 =?us-ascii?Q?w9Ft98LZ39kyXRS8mu4DXbM3Cr6lJXcX1PEmop60gzATjpeX1ihiLYajEZH0?=
 =?us-ascii?Q?xU9PFK6nAYHVsHSlgvXsXRnEbFiXsBcfTt0e166eqhIvfRQ00vf8Zk1df1N8?=
 =?us-ascii?Q?tNNrLM+4jewpAdvap2ODiWIoKKTrX0fqBAWHwh95k0zQW5sdAc59Mi/faBvv?=
 =?us-ascii?Q?rIiwZLj9n1uQjnAOQbzeLIPAaPqxy3aj1IFViYBv8HaihKQWoXjHiBHkD7NF?=
 =?us-ascii?Q?KDNLgMhx36EK94X0Z7ORy1TzHsIlt4RVAsuZaOxr4K1eDtwJVRFFc/W4Sh7H?=
 =?us-ascii?Q?EnpKyhkG9Q8D8/FhvwGZGML4Yc2Y6Lc6aC8qIBNyu6KG+Q55nxDLgCV3quBX?=
 =?us-ascii?Q?Mp2yQWrs9MWmbchqhy7sHeWI4RKxtea0cnC2+lsF8KWJaCIlChU+fP6DZulo?=
 =?us-ascii?Q?f99L0caVzGlXxnaCmfsVS+aFRgGpDCF11SOPk9ctiP9KGX+0TK/wU0sMZpf0?=
 =?us-ascii?Q?u/e993TPH0e0rVjGbiVLHY5tGw7pr4mbBwTBiTKfbx+mlJTYsmtYs6/hWT4P?=
 =?us-ascii?Q?d+nILrYV+Xlt4qDloJKVvKrR3uttEKAZAT9S9dZ/o233Iu0T4YyZQQqMYCJV?=
 =?us-ascii?Q?h/F9Xb29jiOPT8/A8/KDH4tspeSILY9NPjI9Gat5AyVhct/yE7zW7Z1YPSO4?=
 =?us-ascii?Q?G9frDWV805nJMLXykNc4ZDOk4jlXdxafjR9noM3ag/YlyiIuks3iPEfpyaT8?=
 =?us-ascii?Q?a0Gsj6EY78zhKxFx+KYpF9Hkszcd36Ykol6m1hqKi47q9ZSF9IZ4C14VPvfS?=
 =?us-ascii?Q?rw3v/xKqdlufjoEpHuUDMaOYXtON7TF4n5Zc2STj9CASlyCvOy91GAV05XuE?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z9WS1PKEFz7N0xXDTB/vD215Jcd9sPQT7k4g4gy4ZFDOFqOO+bq8RcprW4mqr+wx9XAZQj2qeY1TUjQSFQd+UrZSb6DRY5QjgZzgitbQdrQUiTkfrerAqTgAR/BhUiAAO7tvHO0j270ITXlfVawr08m2IqDAncWHxHR7hB8RsutSsxyHDLQmhVCqKpwDKf+3s2wqIrtlVImGI117ufcPBZh7gYlrlEDHyMKS0yR4croPJbee6dG7D2D+ylCzI1pAlMC5Bq24urOCpQy3qtOQlmgb7qUqS5aR5VChe5DIaKm6mdpoMvyNmnSFGg7iWtjmuzYIUbgQ/WDgKOgnAUUKA75InZJeBfnojflbT+HcySbCGjqHM7XzC+G69OPTiuWVK5yhDwfnYRgk1fL0onK1mix+Z1DOmEIym73g7A/4Mo/lgefOH9Bu23l5ckrktOCvZvkEqKjj+y3khYXEXya+F7TZAEKi+HwfxaB8L7N/Fvxq6iC3W+2/MFXNwynoHmodDjSuzOAgjPT5QUMm7cZyBvzBVzuebq/J0T5o47mMxp39IxOfEOR3oRSP9uLztbhNPcY1a5lx/+OLt+8Z4mL/lzafZDff5IdU6I+IQsjEy60nQ36+h9KsxfREp2EIDfU8y9zYzdlxrvOkO52CoL2curoM9ybD/YjMbg5J3cq8MRI9hxACY33ru0N8JtIAkXJanBLwskl9I+yHVjDS6enYhinjN3pgQoDJmJyzVt7J3WI86TruDNFdGFW5m0Osh+BNjCHvyfgIWgRbelIRjWmlwVMJ/t23siynUcwYKD9klGnshVnGxFgrNHJ9nV7ky1ww
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00902c5-6172-4c90-3157-08db200d5f4c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:43:20.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9Wznwg6YS5YWtuDYGIBDm8G+xBJxoJtTIBv/+svAcOjgJkZCTIgnPr1yedxJ42CZRZ0GA1BSi0jeEvhsQab5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: j-WllCiIQRL7eVwi8u8QE_HoibIArf3i
X-Proofpoint-ORIG-GUID: j-WllCiIQRL7eVwi8u8QE_HoibIArf3i
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
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/da9052-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/da9052-core.c b/drivers/mfd/da9052-core.c
index 8b42d2f7024f5..150448cd2eb08 100644
--- a/drivers/mfd/da9052-core.c
+++ b/drivers/mfd/da9052-core.c
@@ -653,4 +653,3 @@ void da9052_device_exit(struct da9052 *da9052)
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("DA9052 MFD Core");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

