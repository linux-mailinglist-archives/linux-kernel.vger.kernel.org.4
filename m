Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFAE668500
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbjALVFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbjALVDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:03:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FDF544FB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:47:02 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CJXnaL023237;
        Thu, 12 Jan 2023 20:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=tCuH70LX61NaAmPZDpiFd6AZPAtH40sYk1LROkus1Zs=;
 b=bFwnqI3KaWXNtxZP2dfsh4NiIlOirHr7Lt3UEX1qi2hCJE2u+C5ownCCQ6LSAOBV084Y
 LGKJoO7XnZXqStLoKfw4HNGyn69w2J5DmNcBg77oTsUWqNnmTMJgxvPhY4ADZa+6ekBR
 ZIjOUhbz6eq3ckddhbWS1b9D6X9+/fErTbg7zXG8qtPplNK4ZB6Ds6vLWowR3ehdlE2O
 0dVQOgVj3uVc3d9vTRAcoqxrvg7CMBOELmj/gdz0l9X9NMqZbAK7oLZvdt4wpPQu28e2
 ufn2lXejFk+2kmo5RXuFOyWVNdodMWdvnDIA95vWrj2DZLYom15Y3rO/HL6c8gfgZc0Y GA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1y1nkhd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CKHvDh005280;
        Thu, 12 Jan 2023 20:46:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4brr7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMIKXKrZihcPHT3CmW1falupQ/SqOQNWfMZoPDraLt3H/7u0t1g7Jl8uROOrBf4DQA0ok8r/XAHe/su3Lnic+CV8YVYg2H+Mtf2RdTawxx9V8+eHvD73Sr4U9GErx5vHLnaNzV75oDlBPO+xufOijbwoBwL5a0DA13IV2Vdrw7lWvkXjEc8RjlOXfEL9Xg07rk138M08t7pIWticZNzZzJRs9JAQlMT1CV5D1pyuOXoNmDA5oCCN0HH8dZxauCLDsMan6+aNHJHlZNjqh+DrhcyfXdMTbmEzSdveTyK7Img065gWPw+N/jrC58pY2inUEJz2UU8/sD8gv4438tyXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCuH70LX61NaAmPZDpiFd6AZPAtH40sYk1LROkus1Zs=;
 b=RCOhZQ6H6aTiRXqxwX/1j378vv0ThQBrOItXbEs8usulaoRocASDNw7kqVcWKo0P2po53l7zUCn4QyVD/22zVHFmSV2hjPh9I9BUmFSBpLWzhTmg4t9928Od4StucNcBh0CP310wFXvy35IHG3a1tIOmk5cUzfBJnyPQ+p73P5UeMwSVKIFVtVkP0fRDQ+y2MnpMLlpE+2/qIL/SH6MByU1xD8uJ7GH+/7LwACly77FsuuLrpQ5Q98jLofQMHimQXJdFOXqN1GzgInajXNcnd9LEfSVsLPwkLTSwuK/zcljadatxUT3VF0GUKE2OPCkP60gyKrSxcOuvwIdV68prGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCuH70LX61NaAmPZDpiFd6AZPAtH40sYk1LROkus1Zs=;
 b=qnjAOCIS2Woot2aOMjFB8tcrUlZB0DMIVTfRR1EP9wMQeplIjU7MbjUIRsdkj2Ob4/bZuUFBpzHnxG1sGycSGGTOPWlFAFmsbc71BNK7W5cWAWpQBAszXmDrtSkO7UksFtjHKL6TPeD2sexKfj3fMjNKaT62z45+i46e0FMmHoo=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CY8PR10MB6804.namprd10.prod.outlook.com (2603:10b6:930:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 20:46:37 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 12 Jan 2023
 20:46:37 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 8/8] mm/memory-failure: convert unpoison_memory() to folios
Date:   Thu, 12 Jan 2023 14:46:08 -0600
Message-Id: <20230112204608.80136-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
References: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:8:56::11) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CY8PR10MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 160283f4-a515-4a5d-8244-08daf4de1916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODm5ygdpxO/xlxZ7aTNSpggIaiW3/gbY9AAoXPDciEARMxNztPwDlVkPnNJZ8pRKgjzVeV6HW9RDdCpPqayWjt6sOF6JVCpr2DwwlfGpmhu8nfzmX00LJ62Q9Kgw3wMkkY57oumfK8G5IDEcvj0VY3dLy543JCCV9c6moHAx+6A7n9CTxLuarkPJ4voYHdR19ciyEzDdSZ1yHhFKvafKRvbIbS+yUCBr345V9FQP09ixUHVHIoPWUrjok3us7IZt58vL1bOJdrGEkAmTT0hwBMM2Ce1tr5SPZf5xF90/XwBJIo+KWyg8AkOqV0RFI0xoHHXS7O0f52fkcfjP67kv2Jwgvi2W8oVFoVJG8HQk6BhOeAOOZh8hKzVRYq/rJdNYK5Udbxfa7e9gdY1ARtWvFmlo+7JNMFO0HnvWh3Q9JHHQjhA/eD2iHL+C+IPsRLdZIr7RxzM0CPgmhkz+MJjubOj7DE+8vQwszgLLkqs/jQ2uqFJGYGfStlK/FA0+MWsP7YkB5OJrfsF4qB3/xQTlFJnbwAVCaKotOxcA1IlB+LX3nm4VruVYB5cUq3KdjwwTRRfdJwT81isvaOwKEdk2q/UbPHRIUfnj0o73V5GWwI+Z1cfnkmZ1MNNVPNKFk3RDNlc7i55BNvq82KxmhXGs9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(44832011)(186003)(2616005)(6512007)(478600001)(316002)(5660300002)(107886003)(6486002)(1076003)(66946007)(8676002)(66476007)(66556008)(4326008)(83380400001)(8936002)(86362001)(41300700001)(36756003)(38100700002)(6666004)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iU2jqVIU39p6E/p5/hOM/1ulHa97LScsbH08Fb6x41vr7tQtz0V4+yTrhnji?=
 =?us-ascii?Q?9NiM6W7gyZYprNMylNrZc0Dpwriidnt1Jo9PnbxI2YDYyIoJnKcrz0rxtuTQ?=
 =?us-ascii?Q?a1UF/eX8LWP569uL/v5ka1ByvEzG0TljP7C0X5Z2GEVOTvrebqPF7E3o7LKS?=
 =?us-ascii?Q?z6qcu1d3K8ppVtkGydob59DYaePMdpmKOpE4bwgBMcuI1QyzVvljN1ipYDQw?=
 =?us-ascii?Q?Te0ZY9f2/Jshf0AjGxnKJreXvZHITl1aQBbUICXsMfDX+T6E+XuvhTegKpJf?=
 =?us-ascii?Q?/oNzx9i6vBN0+nOn6efOb62+9Cm9PRL4eaG7nIWKKAiUu44vDsa5JTBUGFG7?=
 =?us-ascii?Q?4JypzWEQXU1puYQt2yZsgvTbuNmDESm63Is7eJRaa7p04fEos3+je+V5Pjjc?=
 =?us-ascii?Q?LF259Nhz45L41mYW+ebqiVVFq9Pga9AVHrHgtD2BXBJLVdNbbLibV8tRnZOI?=
 =?us-ascii?Q?DFjKVQ5GkkXj5q57R5JS/m+NYN2BfmWOkprvuSRu5XYcCLd3P5HDthE9fTQh?=
 =?us-ascii?Q?yIAm3cjsb0jqx+PkNKPn89wqpTkLv2VwFxnqTc7EgC51a243pLA+OqUKAD7P?=
 =?us-ascii?Q?n6Wq6PDQNJcWE386MTS8m89NvC17OVRYSKbVHSEanLKxMsJyfcdf30rM5/It?=
 =?us-ascii?Q?3ptxKZ3qS5GNaS/RXcrBKSHvdUc1EhfZfPIDb66qfekFz58vmu4l1bz3KEgX?=
 =?us-ascii?Q?MxEEWodUivRVlkLuMNk0TYw23YHgFbl2/hTwbzmpMsHFVLo40N69x1Q1+fPm?=
 =?us-ascii?Q?UhZlJj7/2XrYo9zut6YJdYHP0CFXQHqfy42LXR76NMEm3iRkxgvk1EXfrdCI?=
 =?us-ascii?Q?1E9MRV39RdZmx9kFg/1eLS//SMiqHKtfr1W5W6ZIdAgvYBS6HOxks5iPv96b?=
 =?us-ascii?Q?+zBVCVM2ww8r01d6RC+vH/bLPt5fpbrAyMLOFALxh7o7f8nv3MpOiIgWfhYq?=
 =?us-ascii?Q?FqDSSyEwAqiax6kVe03LoZ56gt9tI2f0VaWDXhQ6eg7EZ1m0spxosrjqh8F0?=
 =?us-ascii?Q?eqQHxGR3qfCxLg4XJygOfMOhD0VnLAUtMCQWxJahxB9+TgXZ25GmFa4BW/ww?=
 =?us-ascii?Q?o8C0qoLZggwXGe1WCCNHxoStf5MjsPy4htZpQ6y95RIlUxN9mUvJ8jpFBXGR?=
 =?us-ascii?Q?MWkupv/KjEa+hAABxQF/n/3zRRNmMHywczayotLhlpRslWTHC5R1oiSNRSKt?=
 =?us-ascii?Q?Ke/23fPwlL8ZLhCm3JGefegA3h7v2BRMhhI1i9q38d6atMPo8Yo3Gk9LuQE1?=
 =?us-ascii?Q?S65ygznAzo6eGh159Raau7/nYpKoUyFDN3hKVpAdHOYPOjkHeEyFVjIOXtmZ?=
 =?us-ascii?Q?OF33IhGlouRlrxPf6jp6UGm56uvhXrniXyI5DunDaTSoLNylzHIA1XYRZzQ/?=
 =?us-ascii?Q?8gC0+D/mNEHslM616zFSOh3Nqcl73ylIJNjJDzhUy398+q85bNwLh85dMJHn?=
 =?us-ascii?Q?mLURtzhHWSjM2X4k4BFSwrjHnxmEv2a3Lc7Now63umV4KiDZDHxYy9w4uNdg?=
 =?us-ascii?Q?bUJgWJ+6RKIWgwHXV71hY2VYGwHhk+ehp2HGJljAOitdGUOr2Bv+izf2KJLy?=
 =?us-ascii?Q?jY5Sd/HIGhBnegcK1vY2WFRg6+0PK6A8VrMe1g88OhCvZxjdfCMOsQitpkCu?=
 =?us-ascii?Q?ShAMxxousZofuMmP/n0Jcrg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZE96NTJhkioZ1959X/s9cAgzzomvxPneCPfMhHaWpkGH+9dQq4TScO987+/p?=
 =?us-ascii?Q?5YytVlfaOeFX0N0R8jtfsaYNwBSiQJGolLHXHPd1TS9VIkHTe5NKceH0xnO+?=
 =?us-ascii?Q?RYkMWfVFsHU+SFvaJErFwhMLEx7Ld/BRARVrRLVp/TSg7MYn59TkU6RDrZqG?=
 =?us-ascii?Q?aPZBj7sYOBgUzmsetsQAXyzCQgaBcWRqBOrIzdmnHGFkjlacyKN91QKJeyLu?=
 =?us-ascii?Q?VMmykiy6TD4jzidJMwRsmGTfATOUODPBDlUbJbHASx66VvgGquBuxUojl5h/?=
 =?us-ascii?Q?A6v16/K0kmDQRniVJBH8bsO+QZGbfPqmX8N3n3LtlG7UwNK4J09rXHZzBtPw?=
 =?us-ascii?Q?q8xaDw3/S/M6o8qOcP5tL5n92QK5KWk/g7iIA7FUChkDdW4iCdnATGcMkMov?=
 =?us-ascii?Q?syYXw4Yw4NwFjA30ctjnv6k5bBNv7i85glfKuQ2Ne7SGDrGljcWoZqEKF1D+?=
 =?us-ascii?Q?sOJs7iOx/1q7ZJxAV+b4In9SnyO4qtr1GBDD0X9ZSJiLut8W8lrK/84ydmu6?=
 =?us-ascii?Q?kljxbaFqbriXkUiQ8nVm/wYIkiZGo8Ui+G80EGD/wuz+CCX1Rv4En/2LEdGu?=
 =?us-ascii?Q?ZJ2q8LVND1D0zS79PHK+akhQMcOu64QlYbhtzjuaTHLiPm1V9NIbJrhYO8Ol?=
 =?us-ascii?Q?yfeeSdIGGeg9VZgpzP3NaJPmEKBym5OYgV+1KgqY6eL9FziYXJ+0Z0MEfJ8v?=
 =?us-ascii?Q?BVjJrSIPDRM3HP9UaTISDR+iMh2a4AjMFwkdKvF/1YCyEhRPcYsBQgmYGl6M?=
 =?us-ascii?Q?T6R8cR4z1pW7+y+5uV0qq2O7F6PQ5upj0cQfwa83VcDBoeekAnvQSbvCJ0qs?=
 =?us-ascii?Q?ODitYqNKpVjbeXlScER7mB2SnPVgp0X4mVtALnndbh7DuewDOpuztqOz6J7C?=
 =?us-ascii?Q?G1onyUp3r3IS+2e6p7Su9DVwIWjtKJKZemRBcLbyUkkx2+sAk0r1YgcLyz0Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160283f4-a515-4a5d-8244-08daf4de1916
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 20:46:36.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mvapwMG79qpDm7CpSON1nNIcek94aGdASGn2wrLRUvFWvudMimT9Db+/07cmMF66GbVEx6YAGMDOjSJkGR8TIhgiZHdRapFLr7eTPML3K8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120148
X-Proofpoint-GUID: Up0ZQxvXtFXJ1c_RKKsgAcBm45uK0Acv
X-Proofpoint-ORIG-GUID: Up0ZQxvXtFXJ1c_RKKsgAcBm45uK0Acv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a folio inside unpoison_memory which replaces a compound_head() call
with a call to page_folio().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory-failure.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fb98652b211a..c53588ea5993 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2335,7 +2335,6 @@ core_initcall(memory_failure_init);
  */
 int unpoison_memory(unsigned long pfn)
 {
-	struct page *page;
 	struct folio *folio;
 	struct page *p;
 	int ret = -EBUSY;
@@ -2348,7 +2347,6 @@ int unpoison_memory(unsigned long pfn)
 		return -ENXIO;
 
 	p = pfn_to_page(pfn);
-	page = compound_head(p);
 	folio = page_folio(p);
 
 	mutex_lock(&mf_mutex);
@@ -2360,31 +2358,31 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (!PageHWPoison(p)) {
+	if (!folio_test_hwpoison(folio)) {
 		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
 				 pfn, &unpoison_rs);
 		goto unlock_mutex;
 	}
 
-	if (page_count(page) > 1) {
+	if (folio_ref_count(folio) > 1) {
 		unpoison_pr_info("Unpoison: Someone grabs the hwpoison page %#lx\n",
 				 pfn, &unpoison_rs);
 		goto unlock_mutex;
 	}
 
-	if (page_mapped(page)) {
+	if (folio_mapped(folio)) {
 		unpoison_pr_info("Unpoison: Someone maps the hwpoison page %#lx\n",
 				 pfn, &unpoison_rs);
 		goto unlock_mutex;
 	}
 
-	if (page_mapping(page)) {
+	if (folio_mapping(folio)) {
 		unpoison_pr_info("Unpoison: the hwpoison page has non-NULL mapping %#lx\n",
 				 pfn, &unpoison_rs);
 		goto unlock_mutex;
 	}
 
-	if (PageSlab(page) || PageTable(page) || PageReserved(page))
+	if (folio_test_slab(folio) || PageTable(&folio->page) || folio_test_reserved(folio))
 		goto unlock_mutex;
 
 	ret = get_hwpoison_page(p, MF_UNPOISON);
@@ -2397,7 +2395,7 @@ int unpoison_memory(unsigned long pfn)
 				goto unlock_mutex;
 			}
 		}
-		ret = TestClearPageHWPoison(page) ? 0 : -EBUSY;
+		ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
 	} else if (ret < 0) {
 		if (ret == -EHWPOISON) {
 			ret = put_page_back_buddy(p) ? 0 : -EBUSY;
@@ -2410,14 +2408,14 @@ int unpoison_memory(unsigned long pfn)
 			count = folio_free_raw_hwp(folio, false);
 			if (count == 0) {
 				ret = -EBUSY;
-				put_page(page);
+				folio_put(folio);
 				goto unlock_mutex;
 			}
 		}
 
-		put_page(page);
+		folio_put(folio);
 		if (TestClearPageHWPoison(p)) {
-			put_page(page);
+			folio_put(folio);
 			ret = 0;
 		}
 	}
-- 
2.39.0

