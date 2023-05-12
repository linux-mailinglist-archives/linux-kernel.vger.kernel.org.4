Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820E7700F62
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbjELTl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbjELTl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:41:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C346A76
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:41:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4ArL002642;
        Fri, 12 May 2023 18:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Zaghmy/7GiJUNSvCefyQrWHFexl15SpP+wZF1jPxsFA=;
 b=dCiCxrf2Zb0gVYto1rYVjtO1l9g34xkUmpAlQ5iQ/k//pE6pt3H6FGomgha3HrJ05S/K
 zWJuL+GnuSPujMt2POL/uHvImUCaMJSoLbs/gA2AV4Az9BenkSP65GwKzOw/H+C0Cq0i
 gYmJkVNpizNmStJ82Vw9ZZAcRuE7iQzLuBHurlD7ybqEgcwfE37WLxXGpDpmFVkoofOw
 fMrrSeVYpMGsWFPGn/L7EVhl1Tlm9qvxY6kBCFrsvtPcg6VcLgRqdi3SgOWRPt8aFFd6
 YhzWK9GHOfbx9Lqga0vCzOcJ8nrlcAkPv8hldEhN1hUl/Y2/U6a8KFxJmGtyDNltPwbB cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777bkxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CH2feh014337;
        Fri, 12 May 2023 18:22:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8316cjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cndsrkiq5qRyYxAiSn5TZBdfYX7BDUS+XNnxpLCzXn7AlfPD253u5X1HM0z6SMTFpEcFp7Le0qB8OfkVOgOXMIVKQY5IgTecda1fJZ/tEubdhIwXQvw2v4JL/0bBUMClSn13EEIj2ofiOIPmHk9ekKc+RqcwVyUwbl3TGZS8qhlB6cDI7iYImHf8lvQGDAB/wer320a7ssGtTE1icLObrNJEhW0HOTFEp8r1x2RAhkXekrfvvg2fK4VFmotbwAKmD76Q0c3jk5+TB61r+LShziVN+8HuD/2e6tbAtw8Pz9bT2fkNmxQZd3MBTPwwh9n9zDgY3nzxgr0APLnhE2mtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zaghmy/7GiJUNSvCefyQrWHFexl15SpP+wZF1jPxsFA=;
 b=gAG3IR2ZLzo1VJOVnEld5flAXMJQdWmNUMA8Nxodsw30moacRcnEyPDlkHx11HMvrU+fQxEFBEMwp3PPK8DyfMyJvW7o/gwv+1PnndFUZvXlEswXbrC9+doMlYnc8kanI+9IM1vktApTSDPYFB1/OjTdAJK3CmTYrzziyTfcorLD39YzBRy28nZxhIQjD9DSIaeYPj2pzx06hs0kpXt//YTtBuKY8lW6+Xu9T/LebkN1Qc3vY6pSq/ieidGqx8qPTk1URG428O1W3e+toqRnw+TqjZUElRTXVMc04dAG6ZeOWtSo37JlI1TZOvcDacuJYnwUnsnb1eIL0IHVWON6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zaghmy/7GiJUNSvCefyQrWHFexl15SpP+wZF1jPxsFA=;
 b=ZObDX9xmgIJTa9jrbSHzgb39OCPbfdjKhVwA9mUZZgb4dvO8yfaUlxE3WWSPyNqPAvW0PQN/ykJMU1l0G8O2Gv+gw6WPg4CBMdQp0oeCORv5Kn8+SKfIEU6aj14hTmd7wmZfakxWkEIC/FU2vX4DDULaBbBLIaFdRu7lD/G4sUk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:22:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:22:00 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 27/35] maple_tree: Introduce mas_next_slot() interface
Date:   Fri, 12 May 2023 14:20:28 -0400
Message-Id: <20230512182036.359030-28-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0419.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 82aad837-3aaf-4ec4-7fb6-08db5315c6e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBXVrafXLMrqHOnZZ3aslQ22fOveEpr5XBB3x6ekrBU42kNUe2nUdJ+siVmWb3cRBM1PlAFyh+6r4xtd0d30ewk2aMM35cbADBpa2vb9F0vkwYYEy0Y9T6r7uWw2Hm8T11c/RYTYp+/Mu/8f5DUuhXyNocXCKGRYOfbF47evZn0WXeZ2nc/XdzkXv1Wz+dw8zLLYSEQ8K+1vVu30Rw19kFj6FrA9yvBtY+a+QEOkiQu0kX5jw7vKfCUdFAS9aQ4fGsOg4R4DcoQD7mwEoS9SzlSV2E3IFjU8HfKmtuCG8yUXsq5csSPugCBuSUuKyDXhBbO7nn3TSAw+KaXTIWE3F16LVG3Ams5Q5kKtTigjQsIA7Y9K/wi+pIKnJh6kd0zP2VeYfthe1iyjHp58mNTxFiEbqSB5dvwltDcih8LtS+enLTNW8JfJ+GfkujwNgzdhdO0iw6gdL5LlFtZTktCmRq7Hnorp++7iVAkeJ8KPow6EDPd7h2dJQCF1760v4TOD6Ob+U8NLpUXR0UMPQh6Bz1ImbqqyKKBYpib5elpa2VdSwGR/b2q5n+Qay2n+PGVU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(6916009)(66946007)(83380400001)(5660300002)(6486002)(316002)(107886003)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NNTDp61Wg9yONCwUAHX4ALpVLtnwzAFP/v4c7JKuRUgzDuuOr4j6zheZwR+a?=
 =?us-ascii?Q?PJ4PZTRXQcWJbxgvsStgmQJCZ8JkNj45QGg9goCd79lEAU3Mw0+UHbFcMmru?=
 =?us-ascii?Q?w3Odw3725jnjqr3CpxZXTXtxpbc3OaAvJxPlsbV34T//ogt8QrpllIlnxPSD?=
 =?us-ascii?Q?GkHzsQIRUYyLM7UklUO0F9oUI1vQDnTTEfDroCCGqvCsrfdlkuUu+yp099sq?=
 =?us-ascii?Q?SO3AWUha+rJjCu5r1jJi4a0IglH7homk3Ng/Trm2mlKo/yM6JjCtOBt51f30?=
 =?us-ascii?Q?8oSrKlqeZ09yDdVKDvQm2Q1b3xCvHWtwBYEZjrrePb61D/ivpuQUi5VcabRw?=
 =?us-ascii?Q?DJRAzGpWD08Ez+x5eGm+D6RCBTLr5Bmds2lwT0yBXI83HhgCjcKKi74usDYv?=
 =?us-ascii?Q?jFRneMw2mvSCaebZ5eG8zMZPP24037pSdmQyxFTZ95mZkqPPYwhk8Ti42pi0?=
 =?us-ascii?Q?kPs5ycvrvJ+pVMgxWnVH6EvTC3NsHPd8PJ0IzCz0KS6BYTuLySeA7YJo1UWk?=
 =?us-ascii?Q?bkA6gEBIdtlkoaPYAB1Ocu0ETycAFmSCGvQfw73X7WAfJmup14RdHzscSgbA?=
 =?us-ascii?Q?4BdII8jvtdPzbRG/CmP265Alod3yHIfOZXtSWEKQLv2sntjzH7G1/oelmk7i?=
 =?us-ascii?Q?vgOgOjv4m9tpYjR/1QXteAzV1L5Po/sT7a1LH+mbz4UKw/IStd/aKgQnb8fb?=
 =?us-ascii?Q?3TCVy71yIN7EljVnCS0D0yc+0gbQpLVdfJuQiZDHzV99RpHGyWWdETGW+hBt?=
 =?us-ascii?Q?keThHXHC55scAYSt+la5P3kn1WITYBw+MsZC7jHsUjNnjJShqWtrw0aTWPq+?=
 =?us-ascii?Q?gMh3AJ9/v4ZQvmAeuRcHTYOAd5xwLHFHlNsMmd/t/p1/t9zia2COot3FmA1a?=
 =?us-ascii?Q?kssSGKroW+nRGBKT7L4Eci9uPdwyg2ycD+P+e4x3W2/b/7FN31ioC+EQks58?=
 =?us-ascii?Q?fYgRU7LZxX9P9VzYZBYRASWM6g5cKsc/I+0UqoiSNqRn0H7PIKpf+3Vm6I54?=
 =?us-ascii?Q?klVB1ai+pDVfZQOUoM+9K+/SIr5WetYhihi8jJVDOaErc3Y4FqmGpDoH8nKM?=
 =?us-ascii?Q?DP9ubDP6F12tBYeTreGim6ISaGltMNCNo3qSw2svmA0AGOBx4T8sTNuAm2Up?=
 =?us-ascii?Q?EuJFmRGBx/I2r5SZPCXCMKzM4CRaDNiOShipA0EqWj7hQGGwazVQFjWB+Src?=
 =?us-ascii?Q?LpP9sb7s7fwS793Kt69CMGBE+Irvzkdp0xtpBzNhCozR9NhQaSABBZpYkOR5?=
 =?us-ascii?Q?mPaYwioHf0IoXRNc2SYcTuwyJ1qfH3z5q9NIMRlA/zawmhOY27L5WdkFUSRK?=
 =?us-ascii?Q?ksJkCer1Hgf2kkOUEZhDEdd7+lTWLfqbj9X8EPH3LDg2HS5pVPuOMc15H44A?=
 =?us-ascii?Q?S9Tlt57y42hUDITj6gUn9nriTewY9+PGxLZZ0VxxgLvOSvnOfN+xCg7CX4Fx?=
 =?us-ascii?Q?Tq3LgCZ9VFhFjQnYXRAA8x7liY1rR24Pf1/nOf3rD3v7Dt8buAAM76hCCejb?=
 =?us-ascii?Q?hhElBmr8p3BareVvQH1zl5vFJ99slbbdt1UPjeZxgGMWOA+TEISLU7zdfqxa?=
 =?us-ascii?Q?5nGnfWAwtjGwLgahbZKo4CUgn/DgfXG03fBgrkSqetmvYWPVbf3t+ACQNdNA?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NGsaMg8y9spDlKcNGUw6FQp0qjg6wXe3zyKgjSODpj1V/XHVoZgXxjmhV43VF8/bMJ+LzN6eLfmsYOX2X9j8eSaLSYII1kOhiSH5uY51NvdFZtSaUVj+ZMkPyfAAMTdAkrTfdGYBd4ChrNHg9Ps4A/YkG50bhCo3SshQuWJGWXfF8jH6nKvmRz06qCcH4EH+bNLASNwElSy1MwUqGNuKRE2BccXgjqnQx55AG2wCvXNtiw7V67nRxHlKPXWyhI+bC/r9TDTG8GkgrMq9zFvEPRJ9DAyDCjflugkYoxyP9EqA91TMrVzXBAUu/tpaoOTY+i49Y0yseSwSnR2UQ6uTJ8hwDhwIHFZaFCdB24eUqJDKb0AIl/aazpBfFZst62KyfdcU/+DZTiqg2STgwLA6JYReo7FkeCJQI0yIGZ1ZX0fIgFGksF9zp60k5wlnhNP0oMHIOfO/dXkPUUGtVHibvySNgj0KJ4YhEmqVV+w2iHsEYn8Qq8qEYPvFacmD5SD88sqKX7HDWUYx99EHtQvgq8yPj3AKPbKcoT6qQz8tm6QPXVx86QoPjbhMWiTs+l6pKxmNJFSoRyYljA0mQX+foPk5ixHcfbZRGnLXdw6B6i1Hs1O/bJBXk+fA2OJRA/EKIAWzpcZVlZB2YDSDQxvygYZm57TlbViRY0APXkLAVCdGrGPBu2YE63+IWXeUsd7iZqgl4mv4Fi8J/C/VPGKrXEdovHPkwGdmpXpzYJIubEPq9eQTpAL6EMOcLQr7o6ekJxbF8bl4mkZVznbyDNy+Cgwbk5Xr6niEZyXovoWXf8zdEVhbq/gudwRWRJr0O4GccdsaCyWfFmfWsaOB31r7kZnvMMZtaWnZ6l7OyQf1cMbr1b1iwX8cXEjmbknrSUExKC/Sae+xOzzlQOvxOv1y6g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82aad837-3aaf-4ec4-7fb6-08db5315c6e4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:22:00.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJsi/2/j7i9/udQ6YQl8iCyBKngG+SpUUu2WA/vQ80H2X2RvpGI5jnbuuOgf0lX0pjBci9bdnqgjO3XJiXGUrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: hfgnpl8smReQiLV3lWdqXviRhjBWw6vb
X-Proofpoint-ORIG-GUID: hfgnpl8smReQiLV3lWdqXviRhjBWw6vb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, during a tree walk, the user needs the next slot regardless
of if it is empty or not.  Add an interface to get the next slot.

Since there are no consecutive NULLs allowed in the tree, the mas_next()
function can only advance two slots at most.  So use the new
mas_next_slot() interface to align both implementations.  Use this
method for mas_find() as well.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 229 +++++++++++++++++++++--------------------------
 1 file changed, 104 insertions(+), 125 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 580310741d892..860f82e161661 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4606,11 +4606,10 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 				unsigned long max)
 {
-	unsigned long min, pivot;
+	unsigned long min;
 	unsigned long *pivots;
 	struct maple_enode *enode;
 	int level = 0;
-	unsigned char offset;
 	unsigned char node_end;
 	enum maple_type mt;
 	void __rcu **slots;
@@ -4618,19 +4617,16 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	if (mas->max >= max)
 		goto no_entry;
 
+	min = mas->max + 1;
 	level = 0;
 	do {
 		if (ma_is_root(node))
 			goto no_entry;
 
-		min = mas->max + 1;
-		if (min > max)
-			goto no_entry;
-
+		/* Walk up. */
 		if (unlikely(mas_ascend(mas)))
 			return 1;
 
-		offset = mas->offset;
 		level++;
 		node = mas_mn(mas);
 		mt = mte_node_type(mas->node);
@@ -4639,36 +4635,37 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 		if (unlikely(ma_dead_node(node)))
 			return 1;
 
-	} while (unlikely(offset == node_end));
+	} while (unlikely(mas->offset == node_end));
 
 	slots = ma_slots(node, mt);
-	pivot = mas_safe_pivot(mas, pivots, ++offset, mt);
-	while (unlikely(level > 1)) {
-		/* Descend, if necessary */
-		enode = mas_slot(mas, slots, offset);
-		if (unlikely(ma_dead_node(node)))
-			return 1;
+	mas->offset++;
+	enode = mas_slot(mas, slots, mas->offset);
+	if (unlikely(ma_dead_node(node)))
+		return 1;
 
-		mas->node = enode;
+	if (level > 1)
+		mas->offset = 0;
+
+	while (unlikely(level > 1)) {
 		level--;
+		mas->node = enode;
 		node = mas_mn(mas);
 		mt = mte_node_type(mas->node);
 		slots = ma_slots(node, mt);
-		pivots = ma_pivots(node, mt);
+		enode = mas_slot(mas, slots, 0);
 		if (unlikely(ma_dead_node(node)))
 			return 1;
-
-		offset = 0;
-		pivot = pivots[0];
 	}
 
-	enode = mas_slot(mas, slots, offset);
+	if (!mas->offset)
+		pivots = ma_pivots(node, mt);
+
+	mas->max = mas_safe_pivot(mas, pivots, mas->offset, mt);
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
 	mas->node = enode;
 	mas->min = min;
-	mas->max = pivot;
 	return 0;
 
 no_entry:
@@ -4679,83 +4676,106 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	return 0;
 }
 
+static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
+{
+retry:
+	mas_set(mas, index);
+	mas_state_walk(mas);
+	if (mas_is_start(mas))
+		goto retry;
+}
+
+static inline bool mas_rewalk_if_dead(struct ma_state *mas,
+		struct maple_node *node, const unsigned long index)
+{
+	if (unlikely(ma_dead_node(node))) {
+		mas_rewalk(mas, index);
+		return true;
+	}
+	return false;
+}
+
 /*
- * mas_next_nentry() - Get the next node entry
- * @mas: The maple state
- * @max: The maximum value to check
- * @*range_start: Pointer to store the start of the range.
+ * mas_next_slot() - Get the entry in the next slot
  *
- * Sets @mas->offset to the offset of the next node entry, @mas->last to the
- * pivot of the entry.
+ * @mas: The maple state
+ * @max: The maximum starting range
+ * @empty: Can be empty
  *
- * Return: The next entry, %NULL otherwise
+ * Return: The entry in the next slot which is possibly NULL
  */
-static inline void *mas_next_nentry(struct ma_state *mas,
-	    struct maple_node *node, unsigned long max, enum maple_type type)
+static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 {
-	unsigned char count;
-	unsigned long pivot;
-	unsigned long *pivots;
 	void __rcu **slots;
+	unsigned long *pivots;
+	unsigned long pivot;
+	enum maple_type type;
+	struct maple_node *node;
+	unsigned char data_end;
+	unsigned long save_point = mas->last;
 	void *entry;
 
-	if (mas->last == mas->max) {
-		mas->index = mas->max;
-		return NULL;
-	}
-
-	slots = ma_slots(node, type);
+retry:
+	node = mas_mn(mas);
+	type = mte_node_type(mas->node);
 	pivots = ma_pivots(node, type);
-	count = ma_data_end(node, type, pivots, mas->max);
-	if (unlikely(ma_dead_node(node)))
-		return NULL;
-
-	mas->index = mas_safe_min(mas, pivots, mas->offset);
-	if (unlikely(ma_dead_node(node)))
-		return NULL;
-
-	if (mas->index > max)
-		return NULL;
-
-	if (mas->offset > count)
-		return NULL;
+	data_end = ma_data_end(node, type, pivots, mas->max);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
 
-	while (mas->offset < count) {
-		pivot = pivots[mas->offset];
-		entry = mas_slot(mas, slots, mas->offset);
-		if (ma_dead_node(node))
-			return NULL;
+again:
+	if (mas->max >= max) {
+		if (likely(mas->offset < data_end))
+			pivot = pivots[mas->offset];
+		else
+			return NULL; /* must be mas->max */
 
-		mas->last = pivot;
-		if (entry)
-			return entry;
+		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+			goto retry;
 
 		if (pivot >= max)
 			return NULL;
+	}
 
-		if (pivot >= mas->max)
+	if (likely(mas->offset < data_end)) {
+		mas->index = pivots[mas->offset] + 1;
+		mas->offset++;
+		if (likely(mas->offset < data_end))
+			mas->last = pivots[mas->offset];
+		else
+			mas->last = mas->max;
+	} else  {
+		if (mas_next_node(mas, node, max)) {
+			mas_rewalk(mas, save_point);
+			goto retry;
+		}
+
+		if (mas_is_none(mas))
 			return NULL;
 
-		mas->index = pivot + 1;
-		mas->offset++;
+		mas->offset = 0;
+		mas->index = mas->min;
+		node = mas_mn(mas);
+		type = mte_node_type(mas->node);
+		pivots = ma_pivots(node, type);
+		mas->last = pivots[0];
 	}
 
-	pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
-	entry = mas_slot(mas, slots, mas->offset);
-	if (ma_dead_node(node))
-		return NULL;
+	slots = ma_slots(node, type);
+	entry = mt_slot(mas->tree, slots, mas->offset);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
 
-	mas->last = pivot;
-	return entry;
-}
+	if (entry)
+		return entry;
 
-static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
-{
-retry:
-	mas_set(mas, index);
-	mas_state_walk(mas);
-	if (mas_is_start(mas))
-		goto retry;
+	if (!empty) {
+		if (!mas->offset)
+			data_end = 2;
+		goto again;
+	}
+
+	return entry;
 }
 
 /*
@@ -4773,47 +4793,12 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
 	void *entry = NULL;
-	struct maple_node *node;
-	unsigned long last;
-	enum maple_type mt;
 
 	if (mas->last >= limit)
 		return NULL;
 
-	last = mas->last;
-retry:
-	node = mas_mn(mas);
-	mt = mte_node_type(mas->node);
-	mas->offset++;
-	if (unlikely(mas->offset >= mt_slots[mt])) {
-		mas->offset = mt_slots[mt] - 1;
-		goto next_node;
-	}
-
-	while (!mas_is_none(mas)) {
-		entry = mas_next_nentry(mas, node, limit, mt);
-		if (unlikely(ma_dead_node(node))) {
-			mas_rewalk(mas, last);
-			goto retry;
-		}
-
-		if (likely(entry))
-			return entry;
-
-		if (unlikely((mas->last >= limit)))
-			return NULL;
-
-next_node:
-		if (unlikely(mas_next_node(mas, node, limit))) {
-			mas_rewalk(mas, last);
-			goto retry;
-		}
-		mas->offset = 0;
-		node = mas_mn(mas);
-		mt = mte_node_type(mas->node);
-	}
-
-	return NULL;
+	entry = mas_next_slot(mas, limit, false);
+	return entry;
 }
 
 /*
@@ -4844,10 +4829,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 	slots = ma_slots(mn, mt);
 	pivots = ma_pivots(mn, mt);
 	count = ma_data_end(mn, mt, pivots, mas->max);
-	if (unlikely(ma_dead_node(mn))) {
-		mas_rewalk(mas, index);
+	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
 		goto retry;
-	}
 
 	offset = mas->offset - 1;
 	if (offset >= mt_slots[mt])
@@ -4860,10 +4843,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 		pivot = pivots[offset];
 	}
 
-	if (unlikely(ma_dead_node(mn))) {
-		mas_rewalk(mas, index);
+	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
 		goto retry;
-	}
 
 	while (offset && !mas_slot(mas, slots, offset)) {
 		pivot = pivots[--offset];
@@ -4880,10 +4861,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 
 	min = mas_safe_min(mas, pivots, offset);
 	entry = mas_slot(mas, slots, offset);
-	if (unlikely(ma_dead_node(mn))) {
-		mas_rewalk(mas, index);
+	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
 		goto retry;
-	}
 
 	mas->offset = offset;
 	mas->last = pivot;
@@ -6108,8 +6087,8 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 	if (mas->index == max)
 		return NULL;
 
-	/* Retries on dead nodes handled by mas_next_entry */
-	return mas_next_entry(mas, max);
+	/* Retries on dead nodes handled by mas_next_slot */
+	return mas_next_slot(mas, max, false);
 
 ptr_out_of_range:
 	mas->node = MAS_NONE;
-- 
2.39.2

