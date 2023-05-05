Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6F56F87D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjEERoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjEERoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:44:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4874D1A608
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhDHg020188;
        Fri, 5 May 2023 17:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Bn7CJVTTzCGJHfmLE/+2NIyJatFk0uV6AOMMUMy4o98=;
 b=eCLtTp28q5kfhjOyhJ9SQ0tElaDRPrLBIn3+yYuog5+ZtskK5jNa97bQNsx8kGfT8BL9
 eNbrQWJ7TSzad0Q5g056wug7uQbpvX5fhm1j8zGi3KrEpsm/PRJQqO3pMTOtCQNdL1Qm
 ZuVyHUnBjHIK0+rW1IW6FHKlX9s6H/LtSJRzEataG6PLDLdTKE6QDgQ6fKPZnWHbxLLv
 5iusK3Rr8iaakdW4EmBEwpIDMaxdhCn2gqxFwxeuS/k9IKq7BHH625gxB2g4RI9e6dVa
 hpGDKMcpzyeHH7IaU6RrEkKjKoKhTxI6YpK7QCdie6XpCYql6qZcfFsX+e5j6BzbFnjk cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv5crr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345H4Dir026812;
        Fri, 5 May 2023 17:43:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgeyfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1P2+r8PoJDMxG5xx4KTTLPMIhsXu9I5HK3VOUdvOBLAQHz2YBZXaOqzjFGt7A78BZPk2tKDlGBCphGqPEhal9B5bM+JOb74OR6+IzsTXYQ6Xv8Gfdsv4DZeBBlSgZSgRDdqrTTa/eZU9o8kUQASg0JHm5bj74MHiIlwG3djh1+xrilPfafVWP1kuHGJhkyD0KYtMv/9vL4QHZQBm1UBoGRZWVZpkBmOZmnYT0Ei9YwzAIuPG1j3Tsc6ySBItUVEOKtMpi6UYAlc2xQpraip0h9+yR9/LOayqP/rDWMV3XQENadFT2XgmTFGTC6p0yh2u7W2oybaxC7vjfi0fsLjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn7CJVTTzCGJHfmLE/+2NIyJatFk0uV6AOMMUMy4o98=;
 b=Kn3CkRqcOVQA4wGCBuKNnM3yt+VZ9s43Wi9BT1Dd4VY9O8NeUPog1h3FGNjdoEjMzcKRGjKNMztEwMOxXgQa5Qb5DQvA+MJuZ8Kji27si6U0rj0ty6kn30T1/v2aJwe8nI3+9dbj7vBGVXbiv6o6vcN71otwRXK3TwP8SO+9AMfb/frvmohjAIoawEc9GM/smkFaXcO3xtG6OgKxMyd1IwMw643s7WN40C2F2FYub4Oh7jBcGq6vB06d5R/y+KwAilZlv8pm8q2K/mE629s8ZMxm4uX05dZoDP3Dx7D/t2g7NmBhQap4iVMYW+/pxZtak2KymjCYVm4or7fM7phAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn7CJVTTzCGJHfmLE/+2NIyJatFk0uV6AOMMUMy4o98=;
 b=UezRQApuE/oGokPTBepJCJtEnMkfJpTkupfxXt8f355M6AQfLNm33z4o10rifaL4I8TS7K9radzXyklEMd0jtgWROvR9OiukW93po0FNym4puqJf0q27rq+iycKNcCsGart2XDgmvzMqPQfjyN4RlDcoAM306RYJ5ZSz6hl+doA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:43:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:43:54 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 06/36] maple_tree: Add debug BUG_ON and WARN_ON variants
Date:   Fri,  5 May 2023 13:41:34 -0400
Message-Id: <20230505174204.2665599-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4bd6e8-1585-48e5-aadd-08db4d904bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qgWEQdPtx/18ROW9aY+/n5sSH+IAFtJodIezjiZaSL7Dvmx8JJV8c+v3khatrtWDZzCXWuppeRY7bKxFuI24Vb3s9vxx+jVYzrPWhNJ6PcglIj0uTIBxOViN3e9muF66uH1WrGr5ZRjF20kp/4YFzfDLCvh9YV6b2RLAsgD5NQMGKhj9QCk1btj3YR00oUaeKY++2263TfJansYE1oI6BnhfTInKZJMU8BQyG3wD2B3k9CErgJczPOPBGvlNhyApdwu5G9IRU4nqEAakqQhp3FyBHCCiQw9LMlmuIOFBilEMv++fRLRr024yLTAJFjVSYzcnVhTzVcoDKL0BwTrxdnD1e3qW1qs5rr67EMYemv9loI5UJr9jr9ZcUtfHKyuY3E/vDpS0JnkvA1FTP2FzuGV+4WXyZDbK2s8UQhm5V9sRFXJ/RLPAbSK5ygK/Nhc719NuWrQ5wcX8hmEh17x5aVa3FjJxYJVF4DaQV6QLH1fdDcimOkMJM4ovMQzkGTt1FWkKgZ2zlNbyGprLujgFEIjD2dN6qZVItlBHb2c348x9+vVF9fZXXYv3x4ujDvy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uPs27AAqHPLOhnXFDLdp6tMdzqTcBWvycD8cDDeigTxNRe2DmShZfGz2ok33?=
 =?us-ascii?Q?orUqlpnMnnapJhx40W3NAFysWNxb7G/RluKHY6EugWgiuNP0Ozr1hBTy0Wuv?=
 =?us-ascii?Q?oZiTvBTHrb9lweTdPnevv/lW1t66DJvoWAPoIQaqDi+HunY8twjpQh4bSr14?=
 =?us-ascii?Q?Qe+s614cZpGNEwtXuHS4w5JESgByjXH39uZomIrk5S1PHwrYSAsspiXCNCXd?=
 =?us-ascii?Q?CgIpfeSwMCo9DyzHBoLKPiMxfPmzDw4cCkL7/ginQaZ8BgTzyEN1f8nbei0l?=
 =?us-ascii?Q?HbS6S6P3LKTXtGuRjEcyuaQzoiIVnsenBjcrf8XIeZ6jmae1vcVpOUvh9WZ8?=
 =?us-ascii?Q?jBkhll8JDiR4TUU+/AYpw+aRaxOY/Q15Yx2PvjOlOD6ZXSWz/LwN0Z4uiRuZ?=
 =?us-ascii?Q?iSnwI4WR8EUAysM7o3kw/AkJELkokg4UPIM5dIWhmZm/Gm18rEklLmBckK59?=
 =?us-ascii?Q?GUaIjBV/DK234h3BNH0KC+fAdXArhUpcNWwcL4XAfaEvEV4j8ixtPY/5fnFM?=
 =?us-ascii?Q?AfpBJYMglP6etysCqut4HY6rVjVVy7GxRd6jNJOWSf76VtDksZ3GVK1x2Hvs?=
 =?us-ascii?Q?OhLtvfiZBswgtUMO6lrdSq4SNNNFgIBXMa+fvpISC4hkUzxQPzl3YZ4D5+4O?=
 =?us-ascii?Q?ZGSKn9pX+hmah4NrfZJe2QwiCHEn1yFzXZMvxgJY8nCS78NwgjXYFwU8MihX?=
 =?us-ascii?Q?GMY0FwBm4UKWkO8bZB/F0HG6KgdQRWVpRaCpypPd/GKZz9ycYb1ProINSMo/?=
 =?us-ascii?Q?7ckhjzInDClHAjYAckRltdu3a/gEnbiGIUcThL1wTn4PmBxSUm3EZaxq1oUJ?=
 =?us-ascii?Q?D/vqCElBWrobscCxBsK1VMLqsoL5kX0aLdVy39vA7EeuXI265eGOUEA3hieN?=
 =?us-ascii?Q?ijY3BP05aXq7bp9/r2UIwTxdmsDwrnXBOd9E8KWBV9R6S3/PsXnLB7kYsqRv?=
 =?us-ascii?Q?vdLrplvoIBknH3T+VOCG8qQwPCB71pPkZC2gnpMEGvZf1OMA3b0cYgv8YbGn?=
 =?us-ascii?Q?ZpDRFQZI9I7Yhvrr82nVOCqvNADFzEbV3UQjNNMpowe38yNNXmi7zW4dM6fo?=
 =?us-ascii?Q?aRmHtIikks9gnRvJ7B54pX/3kXk77oIYM285sswAxuCxjgCgt+VA6xYUcxS4?=
 =?us-ascii?Q?3rxmD7Gcr32xHBCAflx3nS/sdTQslWMzHJjjciClNaSSe2FulLv8QvpokC+Z?=
 =?us-ascii?Q?WQu4kbhTY4IJfxQRIyAfGQD9FbGLUa6kRhacr658OZJkH9WwJJg38alP1P3X?=
 =?us-ascii?Q?yceOBrxT6QRryuT7EhbF+h1PUWh0GR7kq3T+SE7M2mF8vFeo4MXDHZaVsE97?=
 =?us-ascii?Q?/nOThOBfuUBdxBv+dM8kvUNIxfDWfTyhIDE/meCBqMY9ZyKCCT/zEORhoCQd?=
 =?us-ascii?Q?infycuXTAgw/QaL6NJ5DdVBexxBgzcu4q6Pz+w72L4ay+CwoC3J1Y/K1meX6?=
 =?us-ascii?Q?vsLaqbIRx8xFNMeOIL/9RQJFvDie/UX0XOq1/78rebc1pJD44sd6greDQoI3?=
 =?us-ascii?Q?vlR2us6ckan5KGTzPxfypzo0cLwliUnyfRXBySDA1640X095ckpEM2LwqiAJ?=
 =?us-ascii?Q?R4E4wRxMZPuDBgDgfAiDXnz511THtNIlCWCZd7qz46XPIxYUkU7YQEnF+UFe?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0tqRSs8lqu2Z5v05hmol47nBAuTF35AkzHRtSTNunzOSRpqgcTUyBmGHjOSLOKVBsKbs03sCR3ZQxPdvFAHCUavtHgcjN53RGvghSPRCjUQ+iFYFff0RVWoHrttbvT07F4eHJW63iWIdyWt/Wq/zD3/5bjiizym+czCo8KBDFmSS2jvDPGKjbfp0eWlzLJGEnuKNuDmx6bKCWXaUnwni8dgHw+G6z02rjI48zCn3oQFNHfTjQALm+Qf8zxaFP0KbxGuZWyPhU8rzcza7y5hDrxro6M+bS1qFM08Lx1uuarALqYi+6qXnlzDSIlea+9MppZjLG+ggzDOK2abl8Agj2IcwnZSyFXsH3T0SjVPmYZUJSTg9+S/2nOASMlIaqIGdIewlH3H4h2U9YHqnuPsu073Je8gDQqOwgeu4Ah6tD7T2VkZplzsAuYt0wXqXiyTueKGRbat1pDqto9qimnGweyO09GZ24KKrPY8nsRhYMuKgZKz0U/bRhMCjd9diYIGRmABwOrAVy6QMxGi39vm09+trSOZmKbz+llOOrn6z1DMAssVWI1r2/XUMVkYI7mAT2UZylpt1PYZ0U8ayi0jw7Y8FTF+iSEBboeK+fpcqyCghzR82WlJBVPhGR/V9depwDHkzwgV7Vpp3DR0ZTWXmsRUDvFUD4eEKw6NR4PF9uNUzBq3J9z0OElyaVkfbE/YSeAI9HwG4h789LwyR9nMrdHusOasKjs6igCtRBcFOB77T1lCadBkS/ktjjk6ndYy/L6voGU81KSiXBmE60ow3zLbD4F7Pm4p/t5nq4jpOoC76ef9oQG+A6W3wcahBM0n0cSyuXzFQgMMoiJZSMNlRG8bZADo9uTC16JZ6HeCdlLga4qkn8pUEIYP21yldx+ai+49OWGCmTxyf4pfAeKeH9A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4bd6e8-1585-48e5-aadd-08db4d904bed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:43:54.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArjaPRTLv1vxnpQN2x6cFjkcgVH6eIvdvLoeNbgTT+pp11F+wKcEtp+kg667FM3X/Vwm5e+qLWeHj+Mg2sTeWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-ORIG-GUID: nR6x51K2FWxajrG9MacuTRyZyrQW5SBf
X-Proofpoint-GUID: nR6x51K2FWxajrG9MacuTRyZyrQW5SBf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debug macros to dump the maple state and/or the tree for both
warning and bug_on calls.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 100 +++++++++++++++++++++++++++++++++++--
 lib/maple_tree.c           |  34 ++++++++++++-
 2 files changed, 129 insertions(+), 5 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 140fb271be4a4..204d7941a39ec 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -482,13 +482,13 @@ static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
 }
 
 /* Checks if a mas has not found anything */
-static inline bool mas_is_none(struct ma_state *mas)
+static inline bool mas_is_none(const struct ma_state *mas)
 {
 	return mas->node == MAS_NONE;
 }
 
 /* Checks if a mas has been paused */
-static inline bool mas_is_paused(struct ma_state *mas)
+static inline bool mas_is_paused(const struct ma_state *mas)
 {
 	return mas->node == MAS_PAUSE;
 }
@@ -679,6 +679,8 @@ extern atomic_t maple_tree_tests_run;
 extern atomic_t maple_tree_tests_passed;
 
 void mt_dump(const struct maple_tree *mt, enum mt_dump_format format);
+void mas_dump(const struct ma_state *mas);
+void mas_wr_dump(const struct ma_wr_state *wr_mas);
 void mt_validate(struct maple_tree *mt);
 void mt_cache_shrink(void);
 #define MT_BUG_ON(__tree, __x) do {					\
@@ -695,8 +697,100 @@ void mt_cache_shrink(void);
 		atomic_inc(&maple_tree_tests_passed);			\
 	}								\
 } while (0)
+
+#define MAS_BUG_ON(__mas, __x) do {					\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_dump(__mas);					\
+		mt_dump((__mas)->tree, mt_dump_hex);			\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+
+#define MAS_WR_BUG_ON(__wrmas, __x) do {				\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_wr_dump(__wrmas);					\
+		mas_dump((__wrmas)->mas);				\
+		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+
+#define MT_WARN_ON(__tree, __x)  ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mt_dump(__tree, mt_dump_hex);				\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
+
+#define MAS_WARN_ON(__mas, __x) ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_dump(__mas);					\
+		mt_dump((__mas)->tree, mt_dump_hex);			\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
+
+#define MAS_WR_WARN_ON(__wrmas, __x) ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_wr_dump(__wrmas);					\
+		mas_dump((__wrmas)->mas);				\
+		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
 #else
-#define MT_BUG_ON(__tree, __x) BUG_ON(__x)
+#define MT_BUG_ON(__tree, __x)		BUG_ON(__x)
+#define MAS_BUG_ON(__mas, __x)		BUG_ON(__x)
+#define MAS_WR_BUG_ON(__mas, __x)	BUG_ON(__x)
+#define MT_WARN_ON(__tree, __x)		WARN_ON(__x)
+#define MAS_WARN_ON(__mas, __x)		WARN_ON(__x)
+#define MAS_WR_WARN_ON(__mas, __x)	WARN_ON(__x)
 #endif /* CONFIG_DEBUG_MAPLE_TREE */
 
 #endif /*_LINUX_MAPLE_TREE_H */
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 084868865849c..a28b021f740f1 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -240,12 +240,12 @@ static inline void mas_set_err(struct ma_state *mas, long err)
 	mas->node = MA_ERROR(err);
 }
 
-static inline bool mas_is_ptr(struct ma_state *mas)
+static inline bool mas_is_ptr(const struct ma_state *mas)
 {
 	return mas->node == MAS_ROOT;
 }
 
-static inline bool mas_is_start(struct ma_state *mas)
+static inline bool mas_is_start(const struct ma_state *mas)
 {
 	return mas->node == MAS_START;
 }
@@ -7251,4 +7251,34 @@ void mt_validate(struct maple_tree *mt)
 }
 EXPORT_SYMBOL_GPL(mt_validate);
 
+void mas_dump(const struct ma_state *mas)
+{
+	pr_err("MAS: tree=%p enode=%p ", mas->tree, mas->node);
+	if (mas_is_none(mas))
+		pr_err("(MAS_NONE) ");
+	else if (mas_is_ptr(mas))
+		pr_err("(MAS_ROOT) ");
+	else if (mas_is_start(mas))
+		 pr_err("(MAS_START) ");
+	else if (mas_is_paused(mas))
+		pr_err("(MAS_PAUSED) ");
+
+	pr_err("[%u] index=%lx last=%lx\n", mas->offset, mas->index, mas->last);
+	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
+	       mas->min, mas->max, mas->alloc, mas->depth, mas->mas_flags);
+	if (mas->index > mas->last)
+		pr_err("Check index & last\n");
+}
+EXPORT_SYMBOL_GPL(mas_dump);
+
+void mas_wr_dump(const struct ma_wr_state *wr_mas)
+{
+	pr_err("WR_MAS: node=%p r_min=%lx r_max=%lx\n",
+	       wr_mas->node, wr_mas->r_min, wr_mas->r_max);
+	pr_err("        type=%u off_end=%u, node_end=%u, end_piv=%lx\n",
+	       wr_mas->type, wr_mas->offset_end, wr_mas->node_end,
+	       wr_mas->end_piv);
+}
+EXPORT_SYMBOL_GPL(mas_wr_dump);
+
 #endif /* CONFIG_DEBUG_MAPLE_TREE */
-- 
2.39.2

