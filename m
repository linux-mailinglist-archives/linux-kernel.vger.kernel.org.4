Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1576EE540
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjDYQHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjDYQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:07:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BCA1A2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:07:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDiZFW006058;
        Tue, 25 Apr 2023 14:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=YYamRYSZTRjLgiYuJg4HLsvFp/mKjad4sqbTTV4Eyi0=;
 b=Jzx4n5jWalKA/Ufad1PtwvrojZOi6SIcpevWbIKkx/7r3nkpWT2IdbmGdm0cmxtejDLQ
 q82UPAdMLl+1Y0YkouIfyzwYAHgaP8l0o4HPNOQO0L0PU8Kx6jPj3DIaroZAz7I/YTuz
 x/HVDtWsT32pvWwmKtskzpe/aWS2I8O8aIyYb51N+ViBzyNy5kJ4D0FtyxQ1FCGnQdMq
 g7AIv7E1mpTI7vS+dCyiEpmtlLjxqlXhCF0nBT3ZK58DeUizYbPd+zyfcTzpDdGjiyRW
 UUVLOCxODGVrOYrTkYi2KGYrdmcSUrlmc56ffT0TJj4RoXlk5j7IzMyUoDvi/0n+PeRT aA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q4661wgpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi2Rb006664;
        Tue, 25 Apr 2023 14:11:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gsqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/uVqmpqu+N3N1SwQXpLYyhO2my9RwNRQSSILBpveKhQ/V5HRRIS3t9AGuqfVfHwepandMMNlF5aa4d4b/9xeNfG3tpeU+CqHmjS8xaAVYehHb/WiCSFU5T6FMoW4PF+gcyzE1w6qrbCILt4OmLxlWov0yHpMvoJC7iW/w062fL0ym34WeQrcXSzaFdg0P3Rn2Ti0AtacJIRpWLNE8pe7PtL+bPE45sjEH9X1uhzexfn+HqjGesjZHmUQ1zZa96/W+Pmm2tHmRwlI59vCfranKAmaPNeaQY4NhKR1HHS9R7TguobzEeojYeInNFxcQ4cGxq1g6lney8/93+1llkYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYamRYSZTRjLgiYuJg4HLsvFp/mKjad4sqbTTV4Eyi0=;
 b=LSzDsZSDLD/YwFlcEObfgC9x9taZmuam5koClu5OHDIMrV5IXhXrrzFdnGgfIWz5uOP2RHC8ac/3j+uR6awVNYCu0DCD0tde12HvLl2s554LVwzbVp2TlG5Iwrl6vS21GENuYhfJJWZM5BDpnemT7Q8uCTr9lDARppEZ2Wgc25HWC51ObrXpq0hOlw5fYLv/uI/ZNWtiTivUdGBb6MdA26aqFzPpwMRa96IB4RaEL2pHXA/xdZ0DlZXX8f+12dkGJ1rwa2YtSd3N94zQlmwnM82ZwNXip6c+rFnxivJjwnHoid2yp7e0FWCxhIijwpzTN8XzEN+1togYWTxkgz33zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYamRYSZTRjLgiYuJg4HLsvFp/mKjad4sqbTTV4Eyi0=;
 b=CCvuEumtzf69RmqC9XP663hzK4chfe7TfRCHa4ZDRW1UhQLyr26ikdN2Dtoi1GJWvkRavJo3+GFb7GtYwS/zMoJn/yU7ZVf09LRrkHGtQ9OHRyGyBrH1QQo7W5hNyAl7fRNAnqe6Q2WeNFFuiV6dM7ifqWup08xIMKlhxAeGTm4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Tue, 25 Apr 2023 14:11:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:29 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 29/34] maple_tree: Introduce mas_prev_slot() interface
Date:   Tue, 25 Apr 2023 10:09:50 -0400
Message-Id: <20230425140955.3834476-30-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: e73a2624-c676-4d7c-1466-08db4596f726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VpW36Zhzpec40RNopzK+43JtdMUir+8uOBT1HKteQcN+lkXcaTAe1Jr+fIZ2OkPmMB0ox8gk9+60o8Kco2dM9l8ZzuqDvlA/HtBLoc2MihSRw3lyGlg/I0DwYqL5Q6bEkBh3V6cjzJh8mVgt59VSHiNhFdy4ZQPaZ9biAUeVjpDfF+XVztQetUPjOxbxfAI+YlCWv+0lhxCz73768jODpIlhEKqG0LlQ/FLQiqImqOsM4A64fuyZ3IGf0r/JNRVInRkRgG0GqYA3bhm2RSAbktQGfWJw44gsTlJCeNK9vWoPFLtUEu05ejDzxzVSsDdCsPfUfZi/Jukc+pjKIa5Q2KgUoS2R9Zr6KZK901mETHCaNSkLC1DeLL9jndYM24efl4n83Bhvw6kEAraDR2lV2spngOc2lYpSndlTEzMtsrM2MzfMLkL7PZzx7Q+tpLmOqWmuBfBV+uBkspd1833KOBA8iMbqW75r7Lwt0CDccXiuzggDY5/U5H87GFCBQ+VSW2wLD0RiSpnb33ptT5qpbVCTQWF9izy/eII4u1zYO+1IkUGQT0Um1mLx+gIWLXw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(83380400001)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z3Zv4eni6aaNqCt09KnOaqZSM9BCdlVd+Ex8GbyKyzCpYp+GaBORrjwGHei2?=
 =?us-ascii?Q?hTHi94/xnuDUF/vCt4Bab+/bqRcTuSmdPrg66WPEs1lYZNq0/2irAqOZw2xM?=
 =?us-ascii?Q?sCksUVyq3kAbkQT5aCfeKr0eCfdL9xeGFfCZNhjoZFFtg6yug+OoYbYOBvz/?=
 =?us-ascii?Q?zDe/RtS3Lq1naXu2l+IPGH6nnr/BJw/Wz70mxgoG0OGHurvzRPUXlOs+ydOn?=
 =?us-ascii?Q?72E2WYTWHcGuMvn8cGL1LzvjQ/6EzY2WCEx2ufkbk9zhbUz2kq+zGHX0Ch/p?=
 =?us-ascii?Q?Xv89bvOq0YDrzAgmvdvGkxlMdfoj65RMW175GjjBUum7NPdy7W4XLTXLQMbE?=
 =?us-ascii?Q?91SfMciZQ6tDw63f9fakWAyS8Y+2dBS+QiHNRkPGh8396wt6Ri3WP23UYxlT?=
 =?us-ascii?Q?59ydf9wWsJzOHjaKjANpzRzKotqXzLkYqR5X7enRbTUCZONiQnQkHCslUPph?=
 =?us-ascii?Q?M98XXc6MnvvG/GA6alsB/Okg+OATfvStOU57SRvKXfaOx1eP6J8Ix4AsNNDB?=
 =?us-ascii?Q?2IK+9MwRg+k8zDlU7LyMv44m9SvqxNZSbI2acYhU09MiiFVhQfGIpoxxn33F?=
 =?us-ascii?Q?maAEpiYd1a9LZ5nR9ylqqzasKyp9Fe3vr5WF80Bs6IGtWV/nah7QBAK4jMBD?=
 =?us-ascii?Q?CIR2qnL7zJ6kQ6Pnv1RAklnFzUeNuzpylJ9mX4oMe254iBxhmamvmJffrGA7?=
 =?us-ascii?Q?uPo18pE3IBJnN8JJGTpNVP+qhF9AhAIQOxNpBy+5cD/FFD20jZiSPYYSOruH?=
 =?us-ascii?Q?A7bvXaKn4Vxh/9JClSjaw6vxgqgURl8RpOrnxKy1zisE0s5psmay8ySRJFz1?=
 =?us-ascii?Q?UDuVkrh6jaqTbDmE8QX+Nhm/kr9Ed37blOdYAYnh8wxfj9TFrAQS46n0dyWE?=
 =?us-ascii?Q?UJIEb3AxjaOXIgxau03ryBJLpefUf4sO/pIkvnBCg6KBSrDf0lU1I2i8z7CI?=
 =?us-ascii?Q?8ZM9G6641nWyUczP8tEejxNF0ZFplOf/CB8ZCCe6WLoZFzSmmmy48mjSzvsw?=
 =?us-ascii?Q?T4dWS+QODoOUX9n13/n+dO/UalKtUr0JoAyQFRmLLsggKUnXlrldJoW8p2zP?=
 =?us-ascii?Q?FFsgBr9jyLCb3bAbKmqjH1IQdLFxd72040ZmwBHYICrPBWCy9FeSFl3awBG8?=
 =?us-ascii?Q?f0KL5Au/cQe5FZT9XZoeLkU7VkZfT4byYI1OIarbipZHSka9ylq78g+pLyVx?=
 =?us-ascii?Q?sQuICeByuljOuxCBsizb5XwLmgqDSyP9evVrzjI67iJEsuLdzfOGnGEF9ef5?=
 =?us-ascii?Q?62eaIUBb2TjSNu+gBFU/+9dDEQZZfJdiPdE0Ssiwxmq/YYYafmDw3HHRGuQK?=
 =?us-ascii?Q?FOKneCoZtxFgxAT0VxARcn0HkbQQB3u1uf1BZmArLGcml07rCR185tX723yh?=
 =?us-ascii?Q?ZvPD/3Itce9kbcaOzeKMAOYAbYl52lcYRalAcWaQFzX3A83XayNap9jeD2vl?=
 =?us-ascii?Q?GGgJVCOEGRqGa0uWffJ8f8r5I1o8707CNogtcdXagIi5W//ZiGb2DenAEizN?=
 =?us-ascii?Q?BHF0/rFSkvEj2946Xg9649LzNZysGT/4inmK2g46ZbMtVls9Zk91jHijZnYF?=
 =?us-ascii?Q?92sHgicBQjXgJlDX6WzRaGzWEtz+roUsEuu2d9YvPF+qTWobtSpik8XyloZK?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: efq4GwUnMOZtQ65lLeFEvexjjYGffu3eXDYWzgK4w52OzUC6+1V3N9N1KNKdjuErhDJwWSHtCpxnllOvSJkiq7BODMET2MRn2thwoFOR5Yrkz2oNbAhn/gvknDfIUdW8fmuOgTu3YpNAqLhdUqaCEWACth3BDjhJDtvqgILGhRfAkZJGmM8I0dQignzgN7o8tfRET0AtHcDFrTkydRuwDGIEi74atKnlTI/1dNl4ZUAiQTsrbvGpKFCzn5IQILq9F1COnxkaz/qBDU21t0LhTIg21gTiYqi02q1ZRnz7MHkw9tbh90mSv9pz9SZ6nZ4Hrxgp+bz4PvDnM2FgChW25lPboXIplIrUWpQlHJIQ3ZnYV8A+klteELR53glup2M3fzSmmAGwbsMqSJHvUAdOI192C7SWrjwhI3M+1QE1Ov/HzT4D6gx59zB6N0VM9sehAVB2sQDmLc+y8sROkbp4AeveoWufDjIWvL9rfU5MQsBe/q185mIn+gx/ab67EaWdwK1wjDKyloUJbxxXEce0pYGMYNb8xrK5hat0t3rBsnbzdvnQKeT7uuZ7uZ8UoWVj9YxjLVCmz6ow+sL9kNEyDnY5f18+5nLFPIegmGNfrXEGyxs5tQKBsyBKkbV0LxtxhAXIhtZLitoo+Kxdle/hAZe6YClQy3xsNHJMPwBCHYm0B/HZkjOumXY6Sl6uby2NNo81dlALzmJFIEAgisYvEja1sKNtk+iyuPfy3wwTua4GXM3EIYgzr1dU32BHldrhxtCtjx/4xV0bPnIKLUYFLKqqtYgsQDsoQ8bqyzF5i4jtsCJihnZYyvysh04iaqvmUQBFGfTazCUVsrSvtSqMmK7cMyV3oEAM6v+oVGdMNPyGV4h6QPPtv/Frevkv/JgH/Ao5nKsL0bIIsUCoqgVieA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73a2624-c676-4d7c-1466-08db4596f726
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:29.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9FE2lq3YdVjZEus60R1urlrAHpoPvJdwDuFCKlIoBwKxCbMKQ8uXCwFTy1aOuKSAjkq7lQTpf7Fzr2WuYDJRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-ORIG-GUID: yyV82fHQyKw0x2EgS-D7iU5jS3UIpNKH
X-Proofpoint-GUID: yyV82fHQyKw0x2EgS-D7iU5jS3UIpNKH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the user needs to revert to the previous slot, regardless of
if it is empty or not.  Add an interface to go to the previous slot.

Since there can't be two consecutive NULLs in the tree, the mas_prev()
function can be implemented by calling mas_prev_slot() a maximum of 2
times.  Change the underlying interface to use mas_prev_slot() to align
the code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 217 ++++++++++++++++++++---------------------------
 1 file changed, 90 insertions(+), 127 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 7370d7c12fe3b..297d936321347 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4498,6 +4498,25 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 
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
  * mas_prev_node() - Find the prev non-null entry at the same level in the
  * tree.  The prev value will be mas->node[mas->offset] or MAS_NONE.
@@ -4515,13 +4534,15 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 	struct maple_node *node;
 	struct maple_enode *enode;
 	unsigned long *pivots;
+	unsigned long max;
 
-	if (mas_is_none(mas))
-		return 0;
+	node = mas_mn(mas);
+	max = mas->min - 1;
+	if (max < min)
+		goto no_entry;
 
 	level = 0;
 	do {
-		node = mas_mn(mas);
 		if (ma_is_root(node))
 			goto no_entry;
 
@@ -4530,11 +4551,11 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 			return 1;
 		offset = mas->offset;
 		level++;
+		node = mas_mn(mas);
 	} while (!offset);
 
 	offset--;
 	mt = mte_node_type(mas->node);
-	node = mas_mn(mas);
 	slots = ma_slots(node, mt);
 	pivots = ma_pivots(node, mt);
 	if (unlikely(ma_dead_node(node)))
@@ -4543,12 +4564,10 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 	mas->max = pivots[offset];
 	if (offset)
 		mas->min = pivots[offset - 1] + 1;
+
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
-	if (mas->max < min)
-		goto no_entry_min;
-
 	while (level > 1) {
 		level--;
 		enode = mas_slot(mas, slots, offset);
@@ -4569,9 +4588,6 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 
 		if (offset < mt_pivots[mt])
 			mas->max = pivots[offset];
-
-		if (mas->max < min)
-			goto no_entry;
 	}
 
 	mas->node = mas_slot(mas, slots, offset);
@@ -4584,10 +4600,6 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 
 	return 0;
 
-no_entry_min:
-	mas->offset = offset;
-	if (offset)
-		mas->min = pivots[offset - 1] + 1;
 no_entry:
 	if (unlikely(ma_dead_node(node)))
 		return 1;
@@ -4596,6 +4608,62 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 	return 0;
 }
 
+/*
+ * mas_prev_slot() - Get the entry in the previous slot
+ *
+ * @mas: The maple state
+ * @max: The minimum starting range
+ *
+ * Return: The entry in the previous slot which is possibly NULL
+ */
+void *mas_prev_slot(struct ma_state *mas, unsigned long min)
+{
+	void *entry;
+	void __rcu **slots;
+	unsigned long pivot;
+	enum maple_type type;
+	unsigned long *pivots;
+	struct maple_node *node;
+	unsigned long save_point = mas->index;
+
+retry:
+	node = mas_mn(mas);
+	type = mte_node_type(mas->node);
+	pivots = ma_pivots(node, type);
+	pivot = mas_safe_min(mas, pivots, mas->offset);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
+
+	if (pivot <= min)
+		return NULL;
+
+	if (likely(mas->offset)) {
+		mas->offset--;
+		mas->last = mas->index - 1;
+	} else  {
+		if (mas_prev_node(mas, min)) {
+			mas_rewalk(mas, save_point);
+			goto retry;
+		}
+
+		if (mas_is_none(mas))
+			return NULL;
+
+		mas->last = mas->max;
+		node = mas_mn(mas);
+		type = mte_node_type(mas->node);
+		pivots = ma_pivots(node, type);
+	}
+
+	mas->index = mas_safe_min(mas, pivots, mas->offset);
+	slots = ma_slots(node, type);
+	entry = mas_slot(mas, slots, mas->offset);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
+
+	return entry;
+}
+
 /*
  * mas_next_node() - Get the next node at the same level in the tree.
  * @mas: The maple state
@@ -4680,25 +4748,6 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	return 0;
 }
 
-static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
-{
-retry:
-	mas_set(mas, index);
-	mas_state_walk(mas);
-	if (mas_is_start(mas))
-		goto retry;
-}
-
-static inline bool mas_rewalk_if_dead(struct ma_state *mas,
-		struct maple_node *node, const unsigned long index)
-{
-	if (unlikely(ma_dead_node(node))) {
-		mas_rewalk(mas, index);
-		return true;
-	}
-	return false;
-}
-
 /*
  * mas_next_slot() - Get the entry in the next slot
  *
@@ -4777,117 +4826,31 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 	if (mas->last >= limit)
 		return NULL;
 
-	entry = mas_next_slot_limit(mas, limit);
+	entry = mas_next_slot(mas, limit);
 	if (entry)
 		return entry;
 
 	if (mas_is_none(mas))
 		return NULL;
 
-	return mas_next_slot_limit(mas, limit);
-}
-
-/*
- * mas_prev_nentry() - Get the previous node entry.
- * @mas: The maple state.
- * @limit: The lower limit to check for a value.
- *
- * Return: the entry, %NULL otherwise.
- */
-static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
-				    unsigned long index)
-{
-	unsigned long pivot, min;
-	unsigned char offset, count;
-	struct maple_node *mn;
-	enum maple_type mt;
-	unsigned long *pivots;
-	void __rcu **slots;
-	void *entry;
-
-retry:
-	if (!mas->offset)
-		return NULL;
-
-	mn = mas_mn(mas);
-	mt = mte_node_type(mas->node);
-	offset = mas->offset - 1;
-	slots = ma_slots(mn, mt);
-	pivots = ma_pivots(mn, mt);
-	count = ma_data_end(mn, mt, pivots, mas->max);
-	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
-		goto retry;
-
-	offset = mas->offset - 1;
-	if (offset >= mt_slots[mt])
-		offset = mt_slots[mt] - 1;
-
-	if (offset >= count) {
-		pivot = mas->max;
-		offset = count;
-	} else {
-		pivot = pivots[offset];
-	}
-
-	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
-		goto retry;
-
-	while (offset && !mas_slot(mas, slots, offset)) {
-		pivot = pivots[--offset];
-		if (pivot >= limit)
-			break;
-	}
-
-	/*
-	 * If the slot was null but we've shifted outside the limits, then set
-	 * the range to the last NULL.
-	 */
-	if (unlikely((pivot < limit) && (offset < mas->offset)))
-		pivot = pivots[++offset];
-
-	min = mas_safe_min(mas, pivots, offset);
-	entry = mas_slot(mas, slots, offset);
-	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
-		goto retry;
-
-	mas->offset = offset;
-	mas->last = pivot;
-	mas->index = min;
-	return entry;
+	return mas_next_slot(mas, limit);
 }
 
 static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
 {
 	void *entry;
-	struct maple_enode *prev_enode;
-	unsigned char prev_offset;
 
 	if (mas->index < min)
 		return NULL;
 
-retry:
-	prev_enode = mas->node;
-	prev_offset = mas->offset;
-	while (likely(!mas_is_none(mas))) {
-		entry = mas_prev_nentry(mas, min, mas->index);
-
-		if (likely(entry))
-			return entry;
-
-		if (unlikely(mas->index <= min))
-			return NULL;
-
-		if (unlikely(mas_prev_node(mas, min))) {
-			mas_rewalk(mas, mas->index);
-			goto retry;
-		}
+	entry = mas_prev_slot(mas, min);
+	if (entry)
+		return entry;
 
-		mas->offset++;
-	}
+	if (mas_is_none(mas))
+		return NULL;
 
-	mas->node = prev_enode;
-	mas->offset = prev_offset;
-	return NULL;
+	return mas_prev_slot(mas, min);
 }
 
 /*
-- 
2.39.2

