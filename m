Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6966759E1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjATQ1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjATQ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:27:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A1BAA7C5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:27:32 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBgxv011445;
        Fri, 20 Jan 2023 16:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=gS3KTwVPc6s2WWRLi73sZo8sF/ZbFlbHir4kobMK1ng=;
 b=T4R8gAKiYEhqiU0wUq5i9pHTFU6E9uY2YjPK5G5ugQMsCxuz9HlirhNKwRR0+D+yxIiT
 vLZyBdAAXBSLD1VIfmQrcH9XtQLXXHAXm7uHOOqo5YKdU/coztkughbbxHOJJmNDAXbY
 /KBu/ahZCNUexu7NEnDIgW7ucJGIRQ8w0sc9bHpsh4gAy7NenT2qy28U8YW5uhx+rJzI
 1MPKRtSE/fn7//XANVNNoPDP2fDCcAW6vSdIDjmq74rTAUOgXWf0zVviPQOfaIOnQ5sf
 INHVWOER5LlkMW2Da3xw3m8UwtTBDocSx8ryGrcsVORX1YTzZCkNvZLRPCt+fgrAL5K+ cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895aqp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGN1Ng018798;
        Fri, 20 Jan 2023 16:27:23 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quj9xyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbmBsbCqGwb2bP/UxQsUdlXYVYmkwv5tRe7UrbnytYtyWjt75w42WXAQpcg4RsisUktjM0+lyhCDXPztn+aZ+BDO2c03zcdKy3gmJAQq//Ynt98F6H1s4czBMHzZencqf2ZficPrzbvZhfwt3MBc7SEk9h6DybE3eIH4XoBZk/h6CKPvSONo7JqYtC/RZveyo0cXTbK8whtp6bghwkgmq8z/b2Tt/9bmNL0FBK/bL/CkGyDZAcX64W7cSJ2m9zKgMqpvPo3Z+2FsRH+Fk0N83pmC6bYwLhYxni5ZUAJUIBoA3YDhALeSfZn6R2vRYIoBXY/5mlfstSq5vPnUKzkAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS3KTwVPc6s2WWRLi73sZo8sF/ZbFlbHir4kobMK1ng=;
 b=BX/ppSx+ke0G65G58FQrJ1+QkeuDypGMJs/piKZPfmu4CY/0LxKUOns7Rg1udmJVTvMEjDp+NBDErOevKFOXeB32xVRlgYmGAeh488Xd6FxNjgTzp7p93MBOop/ChsAVJ2hkpyPRj6oAUdFeHfWA1SEIPOjpavmvByhq5dlg8BbxW/yFhfpehEI9tVGT3rI3DimEICneu5mQOklyrS2IaGya04Uf/+gtI1XS0ZRKjzwMwgMWgtPUYlGi3IkOmsfHzYoscUUDQ1yfzTaulFH11HGsXw1e0MoJllHpMokfpFg8DKgpU72+8N1DJRIsGVP0On1CJxu4Zq7QdfB2B65cUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS3KTwVPc6s2WWRLi73sZo8sF/ZbFlbHir4kobMK1ng=;
 b=vM/DKI3DoVvae3M8NqcQc1EuR/bt2dMZ65f08Tl8VqSonuLRChontrjB4YPND1AwCPb01z4Z2UX2H3r7Qhsc85S1jXXwGowXpdSqfPKvnzukrf6GrErX5gFlBQE7/GbVIBDJcSjUSgsLkvzFXwQFZ8Gmu+xtnait9HRxrZ5T6NM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6026.namprd10.prod.outlook.com (2603:10b6:208:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:20 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 04/49] test_maple_tree: Test modifications while iterating
Date:   Fri, 20 Jan 2023 11:26:05 -0500
Message-Id: <20230120162650.984577-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0048.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: d738d6c0-c0d5-4af4-cdac-08dafb03342e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfoBBBzHFzigWelx9R6Tvw5Awac4jnAt9Eo2z2oxmjx9bwRQCj6OmSGX2zl16l1zDj0R+U0nIzO2A2513nOhxCuFC8zVe7zDiprT6LTXEW3JUYBlYCri3CQm3oHHc3i8shXV6OgjUJIXHYSZfdLE90PCEZl8dShluV6afhBjAuNvFqhwOlmltIqxY8GK1MLJweUkekUou5gnQPVYeZ+5I0LO5ci5bgllVyNFBV6Ixt8ntvPXDpORNDr45deEYwD0iGf1jvEbvNpSx4plBN6KNYiVEllyjHm/QepKpPe3m2bQ/7iVzMQlOblD3Wk6a+Pr12tXZls15/0CI45Th9OKTafsrPgz1fFWrrSltOpAfthjftMtqnsB/X+0wUtd09gm/JNEu6HNRLcYXnS26Ldr/8f4vyQx8iysJd4aWkxfnmVSSR/VEp2qjGQTDDmMI7IGeCiz1PUJYOGobQNUsFH+MSIlKLywOakjT01j4S+rovDHp8HKSG5Eh2PqSSM082OPP6sfMhZWAAeyAVghRE90hs7CAXe4Et4FbTauIdRLm5vrgbO+UvFlKtCTxuTjDYoNWzm4XAozW7ptG6DfxFKbn57lwyYuGOGyT0OAhFb+db/2bMgDtRreFw/9uXcoZplYCoEBMsWVIgMOw/FjGr9BHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(5660300002)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(36756003)(6666004)(107886003)(38100700002)(6506007)(26005)(6512007)(186003)(2906002)(54906003)(6486002)(478600001)(316002)(2616005)(83380400001)(41300700001)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HaIQnwXBcn32wjMviVBEssVPwO2/wYjEVlqRprzWnA6i4YZIUtrAfURRB15H?=
 =?us-ascii?Q?V9TxEvOmuzHqEHK23txZ2dMafridlbT/yGJaJI6yjOCGmDTxOFw8ggPeZIFD?=
 =?us-ascii?Q?2kS42ZufuJdPei1eLlT2Td7JgK8pESQueBhbqc1J8ad5q+jbLFl06g043+fz?=
 =?us-ascii?Q?akmYvvOdIsOJcPRs3jK/6fl8U3YbI4VlwmhEK4/mgDrbcmX8M/MoCxbiV/ed?=
 =?us-ascii?Q?eyR0TIct6aX8+OEd3fJW3MGfbV5vdzMGNIsufx6J9OoNDWVdgFFEXYUClQcq?=
 =?us-ascii?Q?rR/KNZR0O6PE5DsJZ8Yq44I1q5s6+is5BDqMSbY2f9mRbAptkWpf8fH7ep6l?=
 =?us-ascii?Q?AAEnm6FSrO41JuZuicc+T3rmIxI+5MWNVKB+qdcrtlVT+plHIht49Eu07C9S?=
 =?us-ascii?Q?WqlVFtfbxAuIcVd62xo1le71CegPPPS7jaICrqoQvhpUINcrazJC8uOURz2U?=
 =?us-ascii?Q?WxCOJQaVlHprHmBWLWTDS9K0FIDNDGn5mRcMj8GMKKI3IOPQ5umLjfZimtVn?=
 =?us-ascii?Q?JT8mhNQBHFySTAvz5ljjRUXoznBjanIMCJhTpOZnkAJi8o/VKqiCKOBKPagl?=
 =?us-ascii?Q?wfKAsk36cJXusT13Aeq1waJQ5UQhG4K6WcmzZD6l3kQfrUo2ab6fVcPJPbVl?=
 =?us-ascii?Q?c4mDBVna7dxDI119dSlAUJhhMWD/vjfMVhRKjS0ePKQlB1Z1SJLyqo7D46F0?=
 =?us-ascii?Q?ilPOToQTChTI7gDzA9i/FU5MKeKYv8h5uqE9OgGG9OtzkgiY8Ne07ST3BRea?=
 =?us-ascii?Q?/05qSWesSQAYOq/KcSgqG0kYA/ml2KhszyYMJC9l412Ro7WuVmFUsDVjg5eF?=
 =?us-ascii?Q?8GTACfcpRcisMalhHF85/UO85v7Mg/m727VkY6X6/GYaUl5ZsuMzQm0edaKJ?=
 =?us-ascii?Q?oFjR0bCWe+5Vo5iU6uRPZ++ZHLRhDAlEFI590VFhsadFpWH/oUj0MhqISX6B?=
 =?us-ascii?Q?vMXgtHHOGHJogz7MXPIcsJmWgM/xP+M4GAuassQ/w1CAon1ROEhN+VVKuJoq?=
 =?us-ascii?Q?aIXqylmvF28/P8FpMu1vB4TI6d2ia9WL3iQcVlq0Tvdv3kKOXQyzsT6A61kj?=
 =?us-ascii?Q?PR7EA9RTGVxx/bhve1jDz5G4yRMfXzCn5J+mdI5r+/MS9M9RPTRrZaQhx/Dj?=
 =?us-ascii?Q?m0EKj264YxmQpG5FX+u0HqQYD6JxhFpMJkWEBEPg7KkHXFrFuTpdXHT4doJ7?=
 =?us-ascii?Q?CeRj5DnOGFWUGWdTE25+3IiH7MBrgDz9Hv6YGgwg80aX8lY3+yNnB+R2t8nZ?=
 =?us-ascii?Q?gQWuehGmXKn79yWuXhR6aRI1GAW2nAwn6V08Q1BoyE/Cc9+XMn+AvOwEUzvO?=
 =?us-ascii?Q?p7Nls4cs7s6g8Rlcv2EjRwVeXYBzMMW/THUvntmlm6llid/SDENrSbMIgR2X?=
 =?us-ascii?Q?q/8ujRGRsh0OpgsP6S5w3gjdebOUtY2zwNyza8nsEZ8+S6VPClbTvM8yz3Yz?=
 =?us-ascii?Q?0T/MHutUGn284yowRYaz/TmiBAxcrn3VA+hdyO/6y0JM8lkPaRyjJu56P/TG?=
 =?us-ascii?Q?86AQ7qMvkK2IvVG5HEKkLn8urE23ge6jEJtrZhvl2OVXmJzt+7RKzVtwvAez?=
 =?us-ascii?Q?kXNUkzZOEuNrlvt54kkwQeZd3oZIH6obKITTPSzcX7v6nftkGuY2PUZRkeyP?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H+IDZm11rxetTJc7xbL8vJVjrQ0GroBq+l1QFOqSkWtN8VGRKl+wBnVPeKlFFYDjO+jUeqQBbgRG3/36ask2FMb6MkMbYV45klmAYc+0dP++Q9QckdgkHjj+nP1SnzX9s3TP3PIQd8NDLaTc+5pQZeXK7kknzUqxh8ghVdsiBF4WT9wGy1vAM/EXr3HiXbFlvEr/Q7sbzvCDW2+LE6T5puwncvb3REEDd7B0CR6bqiMHhcOaNDhEylvQMcQwuudSklRXHb0+wZ0bZr9CqGssBU12L4sRMojIzVkQWn50z1y9kb6JENLGkzDKotC4CgZxxbSfMDCEa0Pzfxl3BAUxyoedoVz+cSsG2MMPSSFi53TEF+Feh0cqs1PZugyAc6CWut8hui4rS4zyVhpH0w06D/Y8ycjWhVbzOmCa+zdk9P02y9sNtEXYnL+LFeBZLJ1/NL7SUU58F3VfghmrnTCreB5c6xk403ScOiJxZgSuZFIAO1N8Wlu+aKk/AgrGtWQdK2ooIXOL86HMDhtQS0K3U6iGOR0NvqvPWnqNFi99WS+DRZ0h0MNRA0NR+lRMZQG/KCZ2ce+i44gY6TeJkfFAlQoeZ9AcczALuWm91QiPNfAbvFl6bIucmbjAF4h2MFiyQjx5kPluxZActFZfmALn895K5emyZeJ8fje6BoUSq6krSo9aTUzEGzzSZVyVZG9EpFTdDo8SREY7FDY4OxywvJsetPgxAd98nFBDx34CXtNeX6l23Jt40olMyd6aS3XnZBgy0La3vOyz4y+GmrzhncB/ZosZ92D6APlp7y4tTEMpqtESxFfN1gMS3oJvwVnMjtmbDkXaDNsa4BHaDDmw6Iicb1GmAcdaxCKX1QS6VlYtvemVO29cnJa6+eHF5zOgJVcTpJciJqm8S3abTXmydQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d738d6c0-c0d5-4af4-cdac-08dafb03342e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:20.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yk0PWXKJ3Xqnw3IgASwUnw4/iy9LjhXOE1qKTceDdc85iqdN+nxvptVsyhNX28wFv2fv7Up2J39sbgItP4DAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: 3JfszxDPea2d_D0Qe1bDSsUwlTQiJ6mL
X-Proofpoint-GUID: 3JfszxDPea2d_D0Qe1bDSsUwlTQiJ6mL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add a testcase to ensure the iterator detects bad states on modifications
and does what the user expects

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 72 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index ec847bf4dcb4..3d19b1f78d71 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1709,6 +1709,74 @@ static noinline void check_forking(struct maple_tree *mt)
 	mtree_destroy(&newmt);
 }
 
+static noinline void check_iteration(struct maple_tree *mt)
+{
+	int i, nr_entries = 125;
+	void *val;
+	MA_STATE(mas, mt, 0, 0);
+
+	for (i = 0; i <= nr_entries; i++)
+		mtree_store_range(mt, i * 10, i * 10 + 9,
+				  xa_mk_value(i), GFP_KERNEL);
+
+	mt_set_non_kernel(99999);
+
+	i = 0;
+	mas_lock(&mas);
+	mas_for_each(&mas, val, 925) {
+		MT_BUG_ON(mt, mas.index != i * 10);
+		MT_BUG_ON(mt, mas.last != i * 10 + 9);
+		/* Overwrite end of entry 92 */
+		if (i == 92) {
+			mas.index = 925;
+			mas.last = 929;
+			mas_store(&mas, val);
+		}
+		i++;
+	}
+	/* Ensure mas_find() gets the next value */
+	val = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, val != xa_mk_value(i));
+
+	mas_set(&mas, 0);
+	i = 0;
+	mas_for_each(&mas, val, 785) {
+		MT_BUG_ON(mt, mas.index != i * 10);
+		MT_BUG_ON(mt, mas.last != i * 10 + 9);
+		/* Overwrite start of entry 78 */
+		if (i == 78) {
+			mas.index = 780;
+			mas.last = 785;
+			mas_store(&mas, val);
+		} else {
+			i++;
+		}
+	}
+	val = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, val != xa_mk_value(i));
+
+	mas_set(&mas, 0);
+	i = 0;
+	mas_for_each(&mas, val, 765) {
+		MT_BUG_ON(mt, mas.index != i * 10);
+		MT_BUG_ON(mt, mas.last != i * 10 + 9);
+		/* Overwrite end of entry 76 and advance to the end */
+		if (i == 76) {
+			mas.index = 760;
+			mas.last = 765;
+			mas_store(&mas, val);
+			mas_next(&mas, ULONG_MAX);
+		}
+		i++;
+	}
+	/* Make sure the next find returns the one after 765, 766-769 */
+	val = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, val != xa_mk_value(76));
+	mas_unlock(&mas);
+	mas_destroy(&mas);
+	mt_set_non_kernel(0);
+}
+
 static noinline void check_mas_store_gfp(struct maple_tree *mt)
 {
 
@@ -2659,6 +2727,10 @@ static int maple_tree_seed(void)
 	goto skip;
 #endif
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_iteration(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_forking(&tree);
 	mtree_destroy(&tree);
-- 
2.35.1

