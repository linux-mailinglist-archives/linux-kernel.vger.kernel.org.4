Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098736F896D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjEETTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjEETTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:19:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC630F4
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:19:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345Hh67X027907;
        Fri, 5 May 2023 17:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Gf/8bP5/7Y00ZHHg7g7YJwogjH7fdNlLAETXhQj1hlo=;
 b=JRz8UCeQg/lp+oANpW7FqbF0I9zKGRTP8PtjhoNtTIrlyhIVNR9nDw6e3x13bAxDfh3C
 /rQ7Y//Uil0gTmSZZhUqdeP4Y/Bl2IB6+D94SO+gybzPza1koN3dnMYATK+BjzQ2qqWF
 VYNc17/7Hhel51DxW4VGUv/6TjxftC6krX3NSBRehUeTatszuLy/Q9X1oh1OnStTL3PR
 sM5XfZ8r5KCV+FfCb74R9UECDXPDEslGZ5iN4dKoUQbA0VnNclkRt9epdVl4n7VB4Evx
 MfjWtWHcfkVKfqiLOmlXOmF5043SfG1vPDtWwBRu3YoLM4lilPLpEvOSPoPru8s+yDB5 2g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fwf4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:45:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HeiVr027286;
        Fri, 5 May 2023 17:45:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgf0g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:45:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtQmmrVgCPCqKBM/Mwk0PMjZ4mj1giX5kBX+WRDUWzd17cJ/lF9F9u3wErvKVPGiQpnqUfXfyqchO2rRhHicy1QYLbCXFkzDVpi0v1XQkBLCXOc9lViS2XOGJPcLGjhe3gvHULPxumyAyFdxM2uGqYnBeuXdzKWLkZYDlgRfsTn+xXiIsrY3Dgg3mVljJ385p3K1DKU9Iqo5rsQe7v8n7cU55m5yW273fxGsJLzcUU1u4cbLTaJjX79VrCIQKl+8GDcd9z0i34R6mU1JpzzzrEA8QPyCQLspropNckd51ajsnADKQQC+oSSo/ANi395HhkEQnu8CORc3PIVVbUUbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gf/8bP5/7Y00ZHHg7g7YJwogjH7fdNlLAETXhQj1hlo=;
 b=JDam4/Y2nmBCagYrejtejkk++tVJ1cEikUm9d20H5bVrpvhFA+Ne8XwKF8nWyKznCf6Uu5Kcb8TrYMywdc5OUQmqFfoqeWfewGzVXXLy+2CU+htpG4+K9s/kcgUi9yIsziVDOcDY24wvMiOE1P2TsApzMLGUTv8jvHpEyUJorjw767MgNjhY36yT5YImSgvCEIeL+gnHpoXTbX4YwudbzxilXqYLOxR96em0I1LcQ1E1kLwu5uOS+G2J3LteiFN5HRvBM1mLsEXd2YYq73ayeXLGtPCImv4q5Ag92i2mY+bx5GpW94Pp8STjKWjMTiXPJmHl3SJ9JwvxO73K1sdhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf/8bP5/7Y00ZHHg7g7YJwogjH7fdNlLAETXhQj1hlo=;
 b=nnW2+GK9jfDBDBrdAOcai6p7rIUKiwAg/sp9DMWUJA/hZYNGv7w3a6pOrybqConfkVvPsoBxEsCsYBgc3tS6U/S3dcClDPH83rxcSvR0OK+Cw+xGKwKd+vH+xy7Jc4ORk3SCRrA1LB04bNv6JsSNduHaaINWivlUEiDRWTKzSik=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:45:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:45:01 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 34/36] mm: Add vma_iter_{next,prev}_range() to vma iterator
Date:   Fri,  5 May 2023 13:42:02 -0400
Message-Id: <20230505174204.2665599-35-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 082fbb04-6bb0-4457-c301-08db4d9073de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4R1AYLlO2HIgmEZqnf6EzgJ2slSoP+fJ3gcm4v4I5zjNahTUQIqLbKy08M64xj24dLofEoRAtZLuCtcTxBX73XgCwinddV2kFxpdRtjyFmhQ0FaA4LW6Pz0qZzLG0Au4iv+fohUYyQtr5B672p3hVHVQ7IuYGbqAW2hPI85XtaCjyz3tSytF9265yofPBIeqZx8y3sk+Yo0BJ738p9upQipcSiH+zrwXqK2o/SW/s4sXooRu3v2Ng+kER+Fh/RgdELQPTXx0zo3C2vLdCaSsfG23xlk5vroT7kZP/sZPhhWlgNa1nlQFQq+Ik8JMUntEbgg9ja4HO7Y5PihaVmcNkMwiZyiUUaFyTu9DFiwRLdz6sSqOdBChvB8PyUy4gwBVVoxnc7pDTZ8QuPK/DRZi3ozEN8k2o17AYUITZjfZOmCg3x+ULaWbURdC66kAEg2av65327ZW6+laWkMlh28yo1ETeW4auNr0FTaf3n3h4qq2x8gSRO3UMb3Q9EQgdlvas7YsQBhmL7r3K2SFTu4JAd928hDqHzEAPG5OJHK8exfFZrDe60iG8m/No68lGDX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6486002)(107886003)(2906002)(4744005)(186003)(2616005)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BbyZIeChTMfgnh+JEP5QMP+A6jyQlk0gCGp3nBzGw04/W6r3pVCS8RhHB2g0?=
 =?us-ascii?Q?EByFSrhs7+6KU7fnQMt8IO0z2MnZYjcu98NQw2T5h8xpr1b+IhvkRjLChgCl?=
 =?us-ascii?Q?lMYFA1SLvPs+bJbxLGsuL2MDo00LisrDMt5OaJifofXppxDLirW/ZO/3Tv/T?=
 =?us-ascii?Q?5MRDoqP9Z0MBdzT147C8Vw7ix5g36307ee5DE71joGnmK7PCJMBz1eZf3vlR?=
 =?us-ascii?Q?zT/eKTNj/APvUkZtkum0S4al9fYBmQROwCll89sD434t6S1w1phCFTjk3Etn?=
 =?us-ascii?Q?8FYE7g0mw8wTlBitLdL50UB74dUyHeiYDjnTX7mWY2PcRYVDfF+7jct/3bBs?=
 =?us-ascii?Q?YR/1tP2qjDYTVHV3MaJ700TE9eZEMOsCNrv2xpqN+GwnZRD2+FUos4mUPx/9?=
 =?us-ascii?Q?U4zYMFK8aEvdm/SlJjIqjSMZMhblKMmaWhu8XQrurm8ycQXQXBIDtSyIZPHw?=
 =?us-ascii?Q?+2Fi2B/NwFfVn/dpu7UU9npMnH7tpXOZmM+E60met6X7QMc2dR0MWhZ2OPS3?=
 =?us-ascii?Q?qfdjjMwa5cqMyQyFyl3qpVZE7VWNH1OxLkDzIt9IFSxWTy4h+1SH5ajAzxAv?=
 =?us-ascii?Q?eQ1p7YxkGonwCZMHiMnM7/a67Cpy/ssqesMhmlwpDRuVwNJv+JsVjQ23xAC0?=
 =?us-ascii?Q?BUIjkKu1y67Ki2WFixfND2hR10zAKJfakyo/7GjmAugKVRujUhs3hTpb8sW5?=
 =?us-ascii?Q?zVmB3lqjt+A2Wx0vatg4mDORdWxVgEzHCAa14IAp1cWoyVBd3KHJE9R+LrtH?=
 =?us-ascii?Q?367pf89G+1tQ8zG7/jDqzsJLwn2lPGQopvU8cW39YGE5sOgsQkDP3if8D3Yv?=
 =?us-ascii?Q?vj7C+Zj55SBSAomQACh19U/TU3xw2jFssz3f4v83onfGACIVWhzpZGpYeVFP?=
 =?us-ascii?Q?BTEBglaaMyLlx0MQ9JmWlQd4rE28rzzavOD4oAiPYwh1FRQNR8q3qUgdyH0I?=
 =?us-ascii?Q?8uNwMRjk+jMVIVcmEkSwp3VElajq+fImVg1Ux4JGBTfTepFUUumYWWHwEWxh?=
 =?us-ascii?Q?iWinwFFMmNwGPEcVvhRZSPO9CWqCtdu4udmeuWKpQWv2VswiYl7GF7Ixl3D4?=
 =?us-ascii?Q?sKWfdpF9Gwoh9CiM+yLJHzhEwCxhA3FJP8+0j3KS9ynY3wUftcT78ZVHMd7Q?=
 =?us-ascii?Q?8sovrAtQdw7PskC6cbsrvexgbqecHyn8wN63Pmg4ITLoEiaYppMnVmXebmhR?=
 =?us-ascii?Q?rlkiZK/fjFSp12Flvf0BbzzsEqdFyHuzGHjRCf5dx8zvQGueRLFlukHAJ/je?=
 =?us-ascii?Q?XGtyVSVKO8HN0Edrp6mMjGCQIF9AmlePjxZB9KRDIOb8nbFX5xuOMxWutZDJ?=
 =?us-ascii?Q?8S0r4WuT0kFArY32yPblEbmmu67HRjn/0mJ4AksnQMtDcw3faqlyq/xk7QcG?=
 =?us-ascii?Q?0goXee2Jyf90Ope859M6ikuR/yTPocxlIZvANwB0vC+/UGGFtmXYTU3bkQi0?=
 =?us-ascii?Q?HKm81BgE3uIqnb3qDFZ6/84vw+KVCRnos60zCc8BMSPmCjrG7Qi80+9z95ha?=
 =?us-ascii?Q?KRCAXAdYfGmNK7ZjTt508doInUArJCv2bz2Iy9jfAh+D7SjW1cAH3yWju1OU?=
 =?us-ascii?Q?cld1yMYOcU9HoC5pbNHUMcmGdzlZIKEzISFSvKTHW2RkA5ArXyvH7tp4dFeF?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w+gj/DHeSkdp4xir/S27ijB5aHDGVQ7ns/iR3ovqIQteG8YUbz7afCykufL92B4/ODiXj6iLNqyeOo2m+H8A2m2+PdyyJ2UPBcJpLFrKHB0e31ikPvRopiE4sQWVr8Pk4I0Hg5SqKK5RCKMvq3wI+plemfj1pFCRKVChATE6hOGjwPocL6pP5Uw5W+UGYOZozGA/nMAcFrTf0kxriGgI93jJhfs5EkzzhcOLGVKGCVWmXDcI0UD+nlJnQFwtMyrbcBRQ51Tt6PEil7KHwyfenGydpVP5djz1UJyZvIrfh/gOzcjSl/FdB/GKS+D5qDoUg2kcxvKZwpjE3K+gNnY89DWTHeVd3zw6rpDMZ9hcQMBwXzEBpBGJg4JQgzzMX9XGDgNwyHMsOP0hJQ6z6d2LOIHiMvqH0b5fZtSMDlxHACkmSCeL8kh1qD9Vz0NIe5/KuUTslnRDT0yIWUh5Ka9i4xT/XEBURnT61BmFI5754oT3SabDWk+j2IunyGhdgCPEKbc1gm/20qfwUqTRgI5lbsp70qicr/Mb92YqEzA6MvDhVSh1DlqwZhLUAJWMZ1241c/GpcnrWc21eS4BYOdMLZJ2MBwyquJWG2IzeSFf+3fK6rAH7p85pRmN1uAuhBZvLUog3KGhPXSxZxYJI1otGOjy4oEv8DYYuY3nxQQCOR7BuryjOdd3amIRzOuhKseNFc0W8+UIslKWVjLFAFE29hzN51lXz2shw/NcVdannzLG+nf1Fi9ch+hH0VJHnqH3N8Kflp3oOiCIpN/w/Yykdhdr7dNvg776A2zRRzF7V2KmD31jQ4BqZfBK4uMi3WP4rUeQh3qmXaujzHhru40ShtUhMKcAMubADKa0LgMsFOhsl1de2dqfldjUEzMl9y3FVF0qRwMF4k5O0Z1DjFsSpQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082fbb04-6bb0-4457-c301-08db4d9073de
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:45:01.8708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vz0jVpvArXQLicDcSg4mtkr4MZ8mq+xZQfljJ7ZYQxMLbcNK99eXgS/uYna9+kzEPe+COd7z2z564Ab7FXZnyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: LpADf2_88rKRJitF-YBJwtTXkl8Bpr2S
X-Proofpoint-ORIG-GUID: LpADf2_88rKRJitF-YBJwtTXkl8Bpr2S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1d4e7393efd..1bd731a2972b0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -866,11 +866,24 @@ static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
 	return mas_find(&vmi->mas, ULONG_MAX);
 }
 
+static inline
+struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
+{
+	return mas_next_range(&vmi->mas, ULONG_MAX);
+}
+
+
 static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
 {
 	return mas_prev(&vmi->mas, 0);
 }
 
+static inline
+struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
+{
+	return mas_prev_range(&vmi->mas, 0);
+}
+
 static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
 {
 	return vmi->mas.index;
-- 
2.39.2

