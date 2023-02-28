Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249616A59C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjB1ND4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjB1NDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:03:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886BA244B1;
        Tue, 28 Feb 2023 05:03:16 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S699uX015567;
        Tue, 28 Feb 2023 13:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=FQgWiucIfrZHjaHrW0pJK4guvTZBN3i19n2mpoY+i0o=;
 b=sxQlbowv72vLqwjZZ+Xtm79w5+bpQJcHd5zyr/CvOVcmXUS8Rq9isYM9NrVh4qhKOx0o
 xyfdngONW2ti7Nqb5QMFc7Rvf4lhIwhwHiZsnafKUqEFcNQih2w8zgESBJbDuAvMNuAe
 qC1es3ZA64jHOAQehOSPn7GLie1oWyBVI3WDJDXjSLfQi7NYSFANcffVS2zujylIe7bu
 kMFoXNDeYNVuLqoVm5LiJd98lTp2Uq8o82Kd9pCZzqQlUtdT+i0lo13DUhdwOort/8lu
 oiTlbOugvJOK8NvNrtGEwjDK/qYG2LEftvV4rsXf/1lHxERcHDO5epsqORTVzEhYvbI7 ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybakp6bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SB0eR4015939;
        Tue, 28 Feb 2023 13:02:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s71n0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njbc3HNK+Xayc+gq4K3q2ydss2qmBASd7fZBdchuRYxYGRtqljOsunQvL59p4K4nvWFVYeSkoOlC03bNHG/hG0wc8y31iqK1eClcUddNPr2HPvmBktthZxvxVp9Rj7P9Vdu1OaImv3o2IbnbuHNgXtKAv6a9uvZwmBd0t408J1f8HLAptBie+ncM76WqqKb0S+B2A81z9WES/GV3/jFf7+3+EU7tCgLvAF+GJ+hzyr4FtF3D2oE9CXKpC7ymJfcB8betOb/DwNjt81t734GQypGvgKNX3ACqbT3dLAupZ7NpA3rtE2r/1mZFiF9fVVL4iE7ff1+4I9ova1xF3szKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQgWiucIfrZHjaHrW0pJK4guvTZBN3i19n2mpoY+i0o=;
 b=oGoFvIGsvpZktsXngiLzGK2XmwED46g9SE04uM4gGHrJuvMbQyhBy68CW9iX3we3wuH5D+4Yq4moPGvJtT6/SUmt/tMPwrOT+h+n7obdgtzy0BlD93EpVKL4Fqfwmq1Tt00j1q69gNJ9o2yAWo7AHis9vI/MiZbw/Ne375SweXumwgdbb5Xn1l42ZdKZS14aCpwCCqCd6I5zXpYg2DPHaAQigVwxPcjuJtKbLfiKNPA9J9+z/PkMKjKz6GPRTcUH2pC4XBkuwRIHpZl8DcBCOFNiLkePcQLz6UCMEMxxp5Q1T1P2A+FXBZ3O5PYdPOMoPgDPYXKrVK71eyOGKGleYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQgWiucIfrZHjaHrW0pJK4guvTZBN3i19n2mpoY+i0o=;
 b=fzP/sqL5C+hkRhwlpwl7qh3Fpc5ZqU4iK7BPTr4NE5a3zoBiPby0XIO0aAQEFGrieFleJXvK1eO2uXVlMatcwwxIPpRnqHYYNQF9k/L0Mw3uxh1UIuYITeIFpO4CxCWQq+7bLne5gc8grGSVnV6vZ7XRRVKeXNkIEA2JysjW0q0=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB7290.namprd10.prod.outlook.com (2603:10b6:930:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Tue, 28 Feb
 2023 13:02:52 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:02:52 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 06/20] powercap: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:01 +0000
Message-Id: <20230228130215.289081-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0452.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::32) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3b252b-30a3-48c6-d25d-08db198c1987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eMme4zimQvmQxOBFzhkhNAtgbj3kn+CRZwXGyqZlfDo0dUYOMHUiXgs3PavjDI0yM5rO346O2qFapUDOMN+HB7WRnNtPpbran33iB2K3rNvGHvg9xUFMG4GD4Qnqh1/4QIkj2I/WNOdRUUdMGYnpYhqz3RRCfCJoFYhqh+xZhoxsN2RN313vlrpd46k0c5CNXGZKzLXdWKrKOFGagx5AKn9wyZTfT/RYo50EUKkK1bhz+eYm6t1pvr9ZBsDPA3W5MECpznx9frl/M6byowpicBOU3wI8LZ7R03YTFdrU9EdnRIMr1zCeBeyM6fff0D3XUdEnSlvLS/bJWtPhYw+YnFVlyRShrGSXjWIwV5xdGP/phU/AwUgiBnfeMfmH3oO5ztDEqX2LOB0IzxeOVw+6apVUXg/+FhDSKjE1rKp10bJqYpBlbSni8nT3ccld6Hs3nkdlDPxfDO8p/CWILuMumYSTmcjRsf3j7p+kLUAXXnPUWvqZJnDBR3XtOMkYuC6lUlxIUKJtN6+G96d/T6uJb8w3lwxtC6KlYUwc6+eRREsNBYjELLeB6nJGW2BXJpWoUovEXzW0VlcNo0qBL6D8blQ1EcCRqRQS4Q4+kSLeNe3Auph91bh+YxS+1DbcE4/ribB2crn6aOP+yUEEplvCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199018)(36756003)(44832011)(5660300002)(83380400001)(478600001)(6666004)(6486002)(2616005)(6512007)(6506007)(1076003)(186003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(8936002)(54906003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z1GXgPzyg4MEKyfEe0hdcusMO9zq2ldKsUjgPy5aSVuvoYuP2rhZt+HI5AxA?=
 =?us-ascii?Q?gsdZOSCi7gN8NwOVrgIOCGEUuQgAMzsLg293ZG0MNGS3IQCWBAzaxQ2iWUAI?=
 =?us-ascii?Q?qPzA3dQXq5uNvfMjI43sOGae3Vd0SXOiYhhnDWldrNwrgVoG0mSlWiy6bIlZ?=
 =?us-ascii?Q?jvyriwj7IawWQC0Ri9n4UArbNCn0rjnn8XfePtDdrYZDVZVoMehn3YlAmAML?=
 =?us-ascii?Q?LVU9g6MBx6HltDY/RCDl6eBu3bR/s3EiRNFnPIF6AWTJV9MwzEVuVyqI5Rcj?=
 =?us-ascii?Q?uZ23HEo/BQbI1YDSGoC1hZdAI0h6AOmbn3eGzLShqTV2AMmHL4jyWACjdc48?=
 =?us-ascii?Q?Rk+Quz0HmIwBArQi3QJufFxdLFYroK1LfSuKdJDvrQebWIj3+Ho+WQSVxOFF?=
 =?us-ascii?Q?+8zzq/plOFFTNKjG8LAPSMWMW4ZvUS8zM+GWmrG5SYj2aHsClnrWxFn/p1UD?=
 =?us-ascii?Q?FjYZCtj94sebKqbqvMaOqu9TqOrdDupqq1Cbmr3aBSdxYLdd5TevcbcZPhTN?=
 =?us-ascii?Q?NosfJ4E4zfR5xPciXEZRaii5H8gfRUN8UuPkwToQFK5jFfu3aYNXJxZWtKcv?=
 =?us-ascii?Q?CmHMxBplNtiFCqV9nA0XiU475vt9uUytv18uAWl0YtomtOs00f9gq+BM5vRw?=
 =?us-ascii?Q?t87aMbs/dPHdW7sA4j5D6M9ku/mhIDWxn/pmenPGYK3rHF+hN11BCd0POHeU?=
 =?us-ascii?Q?/qL1AP/YjegQAuNB/b6ym+qE896uVkDVgmWHCgO20LNdGEV752/0n9TN1BaB?=
 =?us-ascii?Q?VJx+01TVMgj1LRrvXKwE1vFLxYhPSLfDus2s1fDUlcjFz+iTxFrCM+RvsBFh?=
 =?us-ascii?Q?y+LUcztpmZzfQBhaTr1pzb3dR3Ay5Q2xC9qj/koj5Li0RRCvrJwGeJMNiZhD?=
 =?us-ascii?Q?llg9KgiNUZ0Vit2wnqwtdSp/y0t7UkffnY0lGmgeqU9LdNrHrOIejeYWoIDT?=
 =?us-ascii?Q?KZlxEDGtyigWFpAtGycyssn/cOvHx4+zwpJtYuRusAav8Fo0Cq9/TwBzBqX4?=
 =?us-ascii?Q?R6mKKnVRNAOb6tKhf+vx/JoDoQ1rCVBNfb3VoR6ER4D3KkoSczixh/nSGCrv?=
 =?us-ascii?Q?oy9BI82sVr+AMeVhiUoSn7gvcGS2f4a5ahXZjQR2UyneWhmq1vPYGimIWVKr?=
 =?us-ascii?Q?3PdZczRRHfTp6DLnDLw5s/x8JlgZxeprx89F+Exq900iXD9XErwMTRJkfj1U?=
 =?us-ascii?Q?l5HeBtiHenUsuHFT7lgOliFdK3JEGxlBV907AugmcPCIqMP2Nodgcim5WYer?=
 =?us-ascii?Q?rtr+OfNhvQBkdIt2Anti5KX/z77hQ47WM9smJS/cSaS516iwEYVDhta8QvE/?=
 =?us-ascii?Q?m+3yDN2s0cgOAT2YEXCj5Mt7aJz05jlj5MIJhZzVfiAZW4rFSc8b32RIT6Wn?=
 =?us-ascii?Q?HwDCCuNkg71AHaIh+PPV53Hab5SAq3ppoYcWxDb3RhDvsCCxdDd8sUu4hMvb?=
 =?us-ascii?Q?+8fq8GstK+sZhRRIEHKPFrSDhs41lPUy5PkuuI/BvW7N5UFgp3k1/KMsxEZm?=
 =?us-ascii?Q?N1n+7dJphK5h3YU/H4bfBB5tA7rZ+lQw6ytBt7nQGZgGtjwmKZaqfOqjWs+c?=
 =?us-ascii?Q?sOQZ0aqYau49eeUI07mBfbJM7TjFxpwN48pgb/Cktfegx3sYQYiYdkxgZj9P?=
 =?us-ascii?Q?YjchTypbFzYpwZxWazgrrQ8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pbVlmLLwp9ZD+c1KRygws509lXphS5UkyTMug0CiaoIvWnNoue4epSp25xCtI4v35031SvDSpjF9VWdwN8JR98tqS2pWhfsCL+FL+mKOS69E81h59savWiT74ZPvdWEXclukLZagEj2ChF2byf4UWScb1m/8HqHYqBCov+jr+d1Bk2xdjxfv1i9Ch3+jYAoCpRupxhROoaT1LsTJo/jtZLNXV9qVon2p4D0JevA3uilGCYC9gY/irZjsEgUN2zRFjDcpliGnGER7f6gJClFYObheCA1lLKoQ+EYzK5nT5+P9dmRflU3sf1oDYvFhBSa3u39p3sE8L1UWmDQmI0wwtuU+hqPj5Z6GKuUy2NuyhwQKtLG+0eIO5ozq02pSKIB5Xq1Zx33a/HkxW4L1fdqfh3TURc/VSa6KruRSoN5KlkCD5Zj5l1rZQwWZcbv2FAxVpKMSMTQvrwgYzo4Z2E+zHoHjXNEkNp+msir+Pvw6ltb/UWW4ryVFbIJ5n/vqxsNnCvPyDINWdSWcQKVBhFOX7F+BcN6znct81hMHIssuRblB82QIfbPlNWvQeEHxDGU2SMWQ9YmWfSzUtZCW0srWXLaEgSV3FIh5FNfkmnMLy0ItyxeTRuuaD1/NpNxHcGQAgodgdJG0ostM8eK8ZTZnSYDpCIdMOrQvIcd2/9BGGYbTFl86J+qc4sC4/2oCdUJlG1V13JQZYvb8/QpXSZTvctwVldVhzki46ZwZP7k3EUqib+VVNaZ2n/QwYjK9FMFX8v5p8/VWpzCwBkIRdslRyHOfzMtwKm70guyjg+GaQS/2wnFd8sWkWbwPmpLmk4DF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3b252b-30a3-48c6-d25d-08db198c1987
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:02:51.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efSz30/eEN1RNmggqBinOKqBjDP/pk/dlpw1Dj1UDdopqdboneQqNGYKhyCWrmbsfNvqPXiW/tF2Frst2T0kIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280105
X-Proofpoint-GUID: lSf_WKqxc9smdVa9ogEkuXP96VXVck07
X-Proofpoint-ORIG-GUID: lSf_WKqxc9smdVa9ogEkuXP96VXVck07
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/powercap_sys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 1f968353d4799..df806a788a02d 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -675,4 +675,3 @@ fs_initcall(powercap_init);
 
 MODULE_DESCRIPTION("PowerCap sysfs Driver");
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

