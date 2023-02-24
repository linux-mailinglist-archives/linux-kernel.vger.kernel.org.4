Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61A46A2288
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBXTvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjBXTvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:51:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091FF6C8EF;
        Fri, 24 Feb 2023 11:51:33 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEo12p012027;
        Fri, 24 Feb 2023 15:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=yt3JDqC+bypfwY9OITqR6JBuxsnRiaQ+t8opVpTMuSk=;
 b=W3gCb7D6x/Nb3JIXeTvXVoYx2eGkteQV/fubPjNL10XPmRIvOOa1rq9829T3F+W0tZ5i
 lcsPIdXMRq+2mVpZkn0NY4oKpbqmO6T5UPwxNL3b59/v/mxd4otHtRe7dH0n/CJMDT2j
 y5qIhzu/OxJ6Vv1zX6snzT5Zel1uu/kXPO3MuEvq6Eris96BGpvcTBgDbcxmWqQxw5kJ
 nP0dAqm1kTUTjk9KWKFAk1C8VoZ/JXS7cQe9QtzVd6dlTSDHz7q1KuFtMZnL6hWkNk09
 uddeMzDY1KgSZ+r1H06CGXty4NvSLXdKK5nvTznT6saRjjMDkaOjjBIShsYn1wFLYKEB xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpjad81m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODDoqV030234;
        Fri, 24 Feb 2023 15:10:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49kxq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMZmWN11sPJYHiWJJEX4R7tNx4Wz4Qh/m1USWKETCg8G/vp7Agyy/AJcHjl5ygqKC9umdKVHsC+n5iOSoA0anX/9Y2mIvi0sJIUDBzqhRRokhlSm5pFqa82xZjbdiSnpMFcz1ZtQ5NaHtkNGH7obbj4BlpzK+QzBtgG787dLLCWMk5RKrGoCMk2AUbVXczktiRrh2HjHvRj/MQN7jDstfrySLhfZaQ7VtcNIYd+yJ70kSoX4bRIFT+FY/a+6tPo7NuPbMp/ZtYI2l5awI0Yn8v7fmzx7OTWUWFvlCJlomRWwdzVWO6Lxe9t+/DpHHAWDxr0NF5ZMgfnHB3e+St4RCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt3JDqC+bypfwY9OITqR6JBuxsnRiaQ+t8opVpTMuSk=;
 b=AVvOPOl2RTBclCCI1IUa7ba6nWynX4Yq9kirA0qpl2euqSe2YceuDHfTCGlwRfuIZqZDSBf/yW0z7E0h5kePLFsueMKh8jEVkn2VzxVC6FxtnvjAKSUXG5qcvR7MHaANlp+j5SksyYAIZa1TDSPqnwJe/0MilO4xgYNPIxUaScPL/QyLRouX5gkoTm3ThtrbgMr1UMggAcgb5TnqAETwrun4swDlMxL0Ba/j1k3CeG4AGit3C4oxbCm1SykjGxqrBfRF0X+usChsJtSyVOjTe7UKDQ1XyBKuCYdb4SrxhAmeJFyWn0CVo5TsAh65VZn60HtF3iUpAz7OZqemDNJVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt3JDqC+bypfwY9OITqR6JBuxsnRiaQ+t8opVpTMuSk=;
 b=C144hd6G9zhk5BHdYvvKaH7utDSMSlFI2QwZFewMbAUIQ9VVJAWSFz9qtQXn+9CB011q9ftTx5fJZeDVbl42ntC4sD7LQhmMX6qNN+aCsGCqzMe61meNycl0e1JybooJI4UkxatOzkoAV/uNDjSTCnwF7M4Qdko4yFWFOX7Eq2o=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH0PR10MB5244.namprd10.prod.outlook.com (2603:10b6:610:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:10:05 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:10:05 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH 22/27] mfd: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:08:06 +0000
Message-Id: <20230224150811.80316-23-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0236.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: aaaacfe5-75e9-4b62-e67f-08db167935b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bqv1Hpnx7ARsvGQtmcFrAxdyzHpdBCvilGSsCeD1KbGahEsz8to9Yuxvslwe1Wa3aGVtOy4laEN0ONxGDs7mC1PGjvPnSlwx7ShYu5/JSKEQllaCJTCFShn7DjjAKpVeF4+3NLHb2cIGUmolbsNyBKekDEMtx6eizRj0xQ+75M2z5HC2wB+PFXh+j2AcOb/0hUyVEwxDXvBJxJMEaIJpR8QoK7PPnoV9bTo/YVJLIx+kbesIrR5NIeVhY32VaIZoETjMf/ZhmEu0r5ENuxQ4B4MKu//aviiz0Ii+UiX2sHrZ+YVJ6vnL05FkzalU5d/0SFXQAC3ydS22v8NZo0n/BPko7tEHas7YKrNbqPBGaE+k0T0pcbl7UITNqpseuzG3V/QiPwFVPgn3juvU1WaJOUbYQ2MHZQ4pe252xbm3DxyiODtYNbR9LHHZJh7ZBVpKnQLKapHi0OSpPZFQvm58oJ2iflJy/ORgq4WuP0IXwYzaaIr0+GishcREfMy6i1vZYzee5PNr36/1hf4lqwHs7yhiwMCu2AUls+hkfgZSLLDM5LjWyQkNKgmTq4MvGktegSGNYDZSJHTq7lkB05kOokj2KCnKUsDV0T0+f4+GmwxsW7BNZ5e6fqwMap5KhglCCm3c9WzkQywcYGMNEn5yEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(54906003)(316002)(6486002)(8936002)(66946007)(44832011)(4326008)(38100700002)(41300700001)(8676002)(66556008)(6916009)(5660300002)(6512007)(83380400001)(66476007)(1076003)(478600001)(186003)(6506007)(36756003)(2906002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1rrN3yyYedfTK4DlNQxPoSr+/P1SHV322FKNofAst45A6TzsEpf0bj9xf50?=
 =?us-ascii?Q?dT4r11lF3meMwmUGHj5pfuOd53SPz7aNy69WHy/TjmDBoa6C1H8PmBxfIOYx?=
 =?us-ascii?Q?WCfi66Zjy6IZ7nmlW6rlddRrCd5K8txqrmxj8UYR9FWUdgVy7S+NqGt693T+?=
 =?us-ascii?Q?wqnFoc2TTcuEBhwnef739d9cH9kDf4xOJhWGlLe6T+leQdKTLkx8D/V7B+LX?=
 =?us-ascii?Q?Fg0nJ+SwUcq0RqeIM7dpVrXlCYH1JRCtVzFtaPsOLUn90T/SN+xUUoI9D8DI?=
 =?us-ascii?Q?BGODZZM+3gfG42acapBj53jK/3uCXm2ninOngaeB9Mj1hrk9gvHZMZdJ8gbc?=
 =?us-ascii?Q?MibZYN/b5CqhkWBjFA5fYvjWxQgbn6bLlXM680lhdCHMWSWxdY7K4xRESeQU?=
 =?us-ascii?Q?L8dhZgXnh20or7JW5PQJ4KQABzqCoPU/dJeeXfIe2Do1KJSxmNTiDKGXrQWn?=
 =?us-ascii?Q?TgYhWndvBCsvy9CIx1IOhn0+x9TUYljJ5gYHMzg7yJn4FhosT6hB+dxf1Sem?=
 =?us-ascii?Q?RQ6N0EBWRnR1LR5LqFxFsraIWu316aQ+Yn/uZ0zyEXXHF9QHF3nJFCa3e5Tm?=
 =?us-ascii?Q?NJ/lSRpEHsXGSLG2PBcyHz6nhIz4qIyMXrFN+E6aDl6AQpEyzFrQ54gIJDiu?=
 =?us-ascii?Q?yGt/uyHEx2vWnIF1QaliYaXFhvqwsyiNWUCTvBRQ1F8gG48SRxOtf0OibG0G?=
 =?us-ascii?Q?cZcko3UWhBSG2AV/WUX05tU0U/FVEtmQruxTGlEXnT8Z4SPnjfXy0V5PvP1j?=
 =?us-ascii?Q?7qxxObkHG8v9lm6IdNFM4sXSPGeYFUOxCaPclwZBJVg8yfcp/GnW8sr9Yaqv?=
 =?us-ascii?Q?fjnEBDB/WtgcccXbDg0I+Z7UX0cqAID/fkKK0rvlRzgy09YJsrILA0qGftjt?=
 =?us-ascii?Q?plhvmc8XBiCl5VxO33LVYXEPdQHePl02lbhfFtItQMdIpjW2bzQ/ZWPUS2+P?=
 =?us-ascii?Q?QJYBGYmpTxDQnlXlst6nXsE0Yj+Pvf8TeLekD3sxNQ+iQmV12YCcSzcZRuK/?=
 =?us-ascii?Q?RXeRb7ESUaAdG3uLMj+8HqUOSvlf6C/UT2WWEgoEbL1ZqmjJuCN8AdjHSKPM?=
 =?us-ascii?Q?h/7+VjtWMDnFYcWetpERFvLLw4cP5ZMN1V9KrkV8ICupyUs6fNLfShlKfg+1?=
 =?us-ascii?Q?QGm8jZysc3dKlIKk2eCD1KV6ARSnxg267YhRsx1y2XcZgt+bqn0RNBy9Isny?=
 =?us-ascii?Q?+KnhOXmCpAmPCcM/MPJ6je3VxJQY1BdJGL3ndqqLFWOpYVhG/0faf61tRClb?=
 =?us-ascii?Q?q3wZfpbLRKZKfHojeKr/0fnvlBAc1+2naLfgzQWoEHswpG369/50abqyPxzs?=
 =?us-ascii?Q?1WIWq0WZUC8aLNhArbROFK6sIuKjyv+MVfktuXzaY5CjOhdTriXFSm0tJAJh?=
 =?us-ascii?Q?LG+JdjOVC/EynM3MZaVClN3s35I1N9AQ9c9+kzxr2sld9dmNlG7sWLxLfdfY?=
 =?us-ascii?Q?tkjte+KZLqdwfJFTflEiApBNzM2iFjzgJrfSTuj/3sQ+6HKNEg7ziDrgze/j?=
 =?us-ascii?Q?3J592e3Aux/fTI3Vcrmt5PwN7R0n0Eal1ONGxT2q01mEetN4S27UqA3tdY3C?=
 =?us-ascii?Q?LTXufv+pKL6R9gFVU30q3d/tf5m7IfycD1RsVySo5gUg4f2QHuAX4ifHXIc2?=
 =?us-ascii?Q?1OZ4WABe6GRg1SRVKXBc9aM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CgTlvGVNDtw3+L4jgn13y4M3UwtMNeIgTfVkjRAPzVg33byWOWBZ+7uDZNGdVjBoWFQJ65+wFk4eofWI9zGRqVKyQHTdgkl21BjCnVyAa2f8dUJp4Bqev4+tpMHzcVDW7nPuUo2m2uk0eDgE2D3VUYKBKxl6HYAORNSnmms2yzg/OfNyZuVNDBVluCSQVQAwmedK9tEAaGdB4wJzuW8SGDCE3HBgI/Tud5/vGxkrK/kxBAlbM74Dr1l815Xgi4mU/jVnvHbvhUN8EYMSFNYVlBfIItN7wh/ha51w9Di2BNol/GmvzQZCiFozDCd4OWXzdBVWlShPj+aF8RodWZZjJBVPPueSUsMck2BndGCSkAvT4nD6sUN5UhAn70AwirJIDV6OjtBnkKDEuvZ97KTQjKahXb2YVBBbh8Tlqs9WdCHuH0ZzP6hfHyCqSbKevkJF15o2I2GkE6jfnka9NNLGGFO74QMr+RDCdu8OJeFjk0XBq9q2ZvuK1c0jAmvwCz0+Vk64pF0XdtpcieTzUsjg6xp1RGudz9JM8cIFPio756sZCAo6VHjSIKChha42riCjwqx1YJX56yUpZ7oFxozlokFKeyaM1wt7sqNeRVQWOtgMTy09MZd22zFPa5pquDmYplBtxqnpQSDsVBLcu0HtHdCwHWQY4enk/6zhgOLlIgSO2dEh0p9Dkq8xQ//RYMJumExKvyoRz3QUaLeYFjaYQvKsBG4U1Zx/rZFKFUOQyRTEJU9nZPkPTK7HN21cLvirvw43GbWpP/BL1n5Thz9AtwrmvMA8Oz1V+OisvQLL9volwxt5O4LzrnlpQKlB6USF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaaacfe5-75e9-4b62-e67f-08db167935b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:10:05.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bU5KVdkS3NkEfvksdM7VF/yd8bvHr34+v05sj+ZoB7q6NtCIOAMbkwGKy85/Vxw3SPniITHK1DjjWHWvCKZ9pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240118
X-Proofpoint-ORIG-GUID: 13AZtyuj9uA1DBJt5sIKYdUodte24rcm
X-Proofpoint-GUID: 13AZtyuj9uA1DBJt5sIKYdUodte24rcm
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
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/88pm860x-core.c | 1 -
 drivers/mfd/ezx-pcap.c      | 1 -
 drivers/mfd/lp8788.c        | 1 -
 drivers/mfd/tc3589x.c       | 1 -
 drivers/mfd/tps6586x.c      | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 6ba7169cb953..3c57e537d57f 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1276,4 +1276,3 @@ module_exit(pm860x_i2c_exit);
 
 MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM860x");
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 3d5ce18aa9ae..8d006f6be48c 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -528,7 +528,6 @@ static void __exit ezx_pcap_exit(void)
 subsys_initcall(ezx_pcap_init);
 module_exit(ezx_pcap_exit);
 
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Daniel Ribeiro / Harald Welte");
 MODULE_DESCRIPTION("Motorola PCAP2 ASIC Driver");
 MODULE_ALIAS("spi:ezx-pcap");
diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
index fe809b64147e..18583addaae2 100644
--- a/drivers/mfd/lp8788.c
+++ b/drivers/mfd/lp8788.c
@@ -244,4 +244,3 @@ module_exit(lp8788_exit);
 
 MODULE_DESCRIPTION("TI LP8788 MFD Driver");
 MODULE_AUTHOR("Milo Kim");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 1f6e0d682cd9..cbfe19d1b145 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -502,6 +502,5 @@ static void __exit tc3589x_exit(void)
 }
 module_exit(tc3589x_exit);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("TC3589x MFD core driver");
 MODULE_AUTHOR("Hanumath Prasad, Rabin Vincent");
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 2d947f3f606a..90e23232b6b0 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -638,4 +638,3 @@ module_exit(tps6586x_exit);
 
 MODULE_DESCRIPTION("TPS6586X core driver");
 MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

