Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B7672D0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjFLUlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjFLUko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8925C1726
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:40 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKO4xs029655;
        Mon, 12 Jun 2023 20:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NHXrvplhxn0Psdt+SxrHMdYn2tB3EVdr75v/Rv24Kts=;
 b=MTYsbnLQTHG3B1ZBJh1Vnbxesj8PTLlLZa3VFq2m8BnRj8B94gPqYSGcme9HIUovnwzC
 5fKEwvTpBpb1BoL3N8Uk/37z/aPM3wSx6stMcAvXsPkDoFeaxnBB7ROEiL5y+cNB/Cyv
 CsP5bWMNLvEWYoIOu+KE8qOnh2eYmgbT74IX+hv8qE07pS8YCdkQuwBzISqbyhcgIyCB
 el3McO/pSL77Ikx9D4OLRz2P0jBdx+KPiGOaLNodvvcsWTJG5gxBtwtwvj6hN4vAlT5U
 ndApqiUlKLVx9bmx1NxVWp5f2dyStAqUVxTkpbkcUGo348mYItR6kfvqSQS8WT7Phs3Y 2g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2akv47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJd8Ku014064;
        Mon, 12 Jun 2023 20:40:25 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm31597-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeCKY+tvXV7mKyT+zr5vHSyaEgofR8qDl+ew3w4GwF1qvXvh0+k2P9yzF226lCEUeqEEyikMi47ZEBHThbJmu+Reu+dPLJYIVqJbIOqKSsVsDiIVA+ub2mu2qiSzjgX2Hp4Rdq7hV2KLOBLFmZmKEgMgvjMK/VFezf/SrCy//xooCreT2x62zDhjf9G/a72kjP4KYmZUTTNr0lZNzkDIJNisFfYhatvMcoIGhgGBi8N7viAu0onjOnjZFODibQOyHeSaDXb7LVYsW9pgMRqXB78nm3+MQ/oenhGKYURkf5UKhOUSWJAlywbFqRgU4xvTSpkkkpV9cLFTGiAdsYK7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHXrvplhxn0Psdt+SxrHMdYn2tB3EVdr75v/Rv24Kts=;
 b=h+yBukN/LuIo173e4U7A/q9dGExBNKR6ZF1Ln9bjpC3QB2LejKLmOWTvLAGfMvdrKLulqbcKjRbd5qrgkEITtJUJUYB+WLVUmqnsMn+P4TIjEZXaV70MReB7D0c5tS6VPJb2pZr2MozIlLz5J5XNLrTmuF3xQoeqsqkzDd8SBg9Sil/Jxr6bsoQ43vw8/+WE/p/Su0sNoQs7P+IkZAj0tTHeqcg3eJJ7mC9n9AsGZ6PnyvCCx3D+8UbDdQc6yoJmF5+fI/uNywDYZ4vh7fhu0JEheOUBhbrc5GH9A4xp2cQ12/hMvvd9P47BcptXFT6wMwE0F0vI+Pa0GFeyDuL6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHXrvplhxn0Psdt+SxrHMdYn2tB3EVdr75v/Rv24Kts=;
 b=jXrGt2b+y24Rtba3QF6+dStV8krEpn2d17YXcexs6VwN5dyBNhBAIZn8gnMCMFnpgkLPuPbQ/qg/Ys/gHrBJKhLGKGZCu1laOLBwxUqdP8VmJDomAV8ckG2v6Rh3JsBtCMhAYfz+gh7piIWiuxSLXphCXL5coVVEtDPgJBXsNVY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:19 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 08/16] maple_tree: Adjust node allocation on mas_rebalance()
Date:   Mon, 12 Jun 2023 16:39:45 -0400
Message-Id: <20230612203953.2093911-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0022.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::35)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: e008042f-87b0-4306-a25f-08db6b853cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPNPgv0xdySK9nUTM2NSmF/o5nEeE0G+SwuTw8CkzuKVP0huwylxAb5KKTMRNrH4Aus/P5wIW4RW+y6KpuPOjuLP44NPqNzlVnIUW2CcZh7J08xxtVOTEYbdwHwpAcSuz4dQnAnWziPWI8gDoQOrldiX01PWXpzq3QecwpxmucW53l9qnokVkJ6DLSVxV1OQAhwCAPqKtdZsSCua7LMpI4xljF+Sra0LNqf7xz/tN/9Y28ASCq1QeZwtMFCHxr/SgvJbgS8UQQ/hs6QwL5dB90Y0h8+DfNKsxBX+tSEvD8XY+MF8ZPAXUpdnHW5Px97W62fq64MODe6TWuCnqNB8m4E0nSkt37Bd8EbtSO/g5HLybLaqllDv4FjPbX/Y4hBS3Jt65E2IUKPz+8x5PhGJqwsHkRvk9XcxelCJX10aHa4qvAz24/I//6STcGOrTBdVU1eTZ19jCCFvFhV0Yu8xhNhvbgTLxSfmIBwY+0hRTy4ISR+MG6Zyj4vNoXQxDttggU3U3pUS9vmgwf1s3iN/+ztgrljnHAOffHNcNrM6QqDuLb8S2Tg4lX/Dz1zYNu+t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(2906002)(41300700001)(4744005)(6666004)(478600001)(6486002)(6506007)(26005)(1076003)(107886003)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XWvSRhor7AQa9JMh4Max+JDrbO8Wj16ciljHUWr7kk5CMStDoTD2k63bgXZ4?=
 =?us-ascii?Q?hZ+Prnq7Fa7w0dtxA/tm78nDowciqSgFuXoigXjrcLwloAud++sfJZosc9N0?=
 =?us-ascii?Q?x8S5iREbcpAIex0GP4btu1rnPTPtwmVE0lTykgetFWoV9rNzss21RMmYKdcy?=
 =?us-ascii?Q?MkP8NhelEy9OvLr30PaZGfPlDLib1KaTrNdxqnKEh/DhYH3OlTjSfkrpr8A0?=
 =?us-ascii?Q?E6aAwHpqaRJXDuf4VaXYqYJ7sgzxRfROw/a6rMv5LlPKgr7OnbwO9vqIyvNh?=
 =?us-ascii?Q?IlTZAd0xVBRczUg+EZkd4FADRegp2w2vMpHQZS+WF3zcuWSRn6RbbjXv64v/?=
 =?us-ascii?Q?jGJEwIWUdba6J5R7SyAGc9xs1OmPNiug0wyp7+GuzOBx/Ii7sNZLh/Qbj2rp?=
 =?us-ascii?Q?PsyNibiN007HRKlx/zhuHDn1JUBZH2aiO6uBycrosJrPKhrs8SjRu/99ivq4?=
 =?us-ascii?Q?AwNfX+DsEkQgNeVGEfQJWGcNDekqXTQCHGIUVDuOLJ7fBtOU1bXUidepAbSQ?=
 =?us-ascii?Q?Xgcu3ShqLFD6+m8PQkDLzh9EIQQ42GS4hRv/z7q5wN5lfbKB47gn4yAy4lNh?=
 =?us-ascii?Q?R4AO70gU4qlLk6RZGDJxhOwrQiPfB0QLGYjHDUDXSLDDpH0coEX4E19ht+c9?=
 =?us-ascii?Q?LQAo+wWUBhYANIrBjmTYz4hRcxmxQCJwILUAHMacbeeiDrbVUGulNpbJScKT?=
 =?us-ascii?Q?7CqbBhrZBrYv+0bKe4T2tDE2Zh/WFIgaDzsTwaHlI+HFNGqoiATTD5pkgx62?=
 =?us-ascii?Q?O6q5/o8lxjtzOpRK3MN2+kmXW28Hw+XVxiW6iAuh6pSpQCi44akTuSLDraZz?=
 =?us-ascii?Q?DFXSlluKYuHp9UROqTXf6ULbp30bvHgCXx26NlIz4yryrV7nAY75Jx2vIWmJ?=
 =?us-ascii?Q?HQpyGhZF5REEevAr0blwSXhgWTHUp8V+H+KONefcWLt6GjzZssZaZLFlW8Bm?=
 =?us-ascii?Q?W5qyZeTWwRuy3hIF1VHFvRA7ei2VxhwC1NuYDRnwr2FwFDDOczLGtnyQMh7C?=
 =?us-ascii?Q?qzN1YWCg2vzFBrtsGBQZdBLPdzpNZEb2QOS5BbhbQvGpV3GCsNpbh0pAKcH7?=
 =?us-ascii?Q?N66Qeoc9wpOFrXDF3rpxquET9zGxnJHrCW57m6XmGgcDl48T7dRgQ2OA8wwF?=
 =?us-ascii?Q?jQe3/F5Cfj8qX3X73u7PiJl+LrNkzurWGKcIgvKmm4mFSq3cIcOoD3OZcuUx?=
 =?us-ascii?Q?9mUIycQw3a6TiL98Ioe39tvPMak9fHSSPCm7jbw108ptd8oqC8S/LgtKto0H?=
 =?us-ascii?Q?vU+smgqYK6Jm9JSrxvnUY8HYMxnndaAbuaFriVzeotmxlXCJkMIXlkZsw8m9?=
 =?us-ascii?Q?DdRXjgTGMgfc7JAwkNggOJYQTb0EJXue0e6nCcYHdMv1v4PI0T7jptdmpwVg?=
 =?us-ascii?Q?APcQwZVALNF6AtohyWNUuoecXWE58kPueSa8usyeGiltEFJcGQcz3IJ/rY9E?=
 =?us-ascii?Q?k27NZ+5sUlBisvPY59EI35+U6rPL6B365wCvmDODPfibhKnshRWALnm2F0Hs?=
 =?us-ascii?Q?a9yK3Yl9bEjohWV2eTFDR2W5kkmZsXf0V+66tDE/fKpHj64iBFRdhvzPYSgo?=
 =?us-ascii?Q?FC3+Z+/3t79xubtzR3BqR5RL3FQoTPH02OhEiBy87x+nxwvGvBD3IRQUA0/l?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dR9jozdjuPvNRFS5X8/6aRy9Bhp72XzS+lZKzdY7VRnP7UMNhBDPf5OoYr0N?=
 =?us-ascii?Q?OaJ8ptCU7e+M4HPVpTIFlgQnpH4cYKmKFGkXxX3hMgPK75azpi69wfk8dOFp?=
 =?us-ascii?Q?EK64lwq9ImiUpV2zk2AxbgQL2MtWk5RfOt+kds61FBi9QKBTtVVrjsD8DwDY?=
 =?us-ascii?Q?P+fyP7ZNcfXRuANvk9MUdedDRDnzFEfxYlclH1gDxDVJsyriz1yOJl9zFLgA?=
 =?us-ascii?Q?glGH7NtFZ8GMw5Z7PKGOel76fZq0dtErXvD2kTYWkNrXNfAfOHje6WdpzjpM?=
 =?us-ascii?Q?4Fy42dbYIhArvpbXlSkdJLi/okOUwL9ov6rG/1RNMjVssgZ361R8Or8RURhT?=
 =?us-ascii?Q?2+bOWGmGQJH34flwVmHBPZqbK8b3ztS6mcLclI5Le+ODAxHLrk9//hRRvXJI?=
 =?us-ascii?Q?tVUq5LR+dzlj1yjIuRz5LtntJe0o+jDBymu77QMRYx9CNt0c4AeFUvRnyVkw?=
 =?us-ascii?Q?uMlmrv5H7x2Q42Z8L20jmpF+ictDOiTw7l/X+7+qbxVl1IihhAV8ef031kVz?=
 =?us-ascii?Q?m/zNsqajyWDI9vwKDus4xeli/D1DCHnpwseUxPjIp6sZt3sHxDR7sNlxu7XP?=
 =?us-ascii?Q?Y9yBOFqs2+eXW5W2NJ7gJJy8swXWOLNRfOaam4yPkihRGzDPi6quj1bQltsv?=
 =?us-ascii?Q?H1pTBdKpsgFYG372Ra+K473eBwTzSplSQqrWXx58e0muanSUKHk5gHLeDT3h?=
 =?us-ascii?Q?ZQ7W+ybi98iICW+bdGXe9DAHSr0otGfBxNVBOjKXmmGvQWH0zT5SqUHkm2ns?=
 =?us-ascii?Q?e+VaP1sw9lxhAnO3O7sYvDndScTuzIzBEgeyloM0A68BpMjvGhxbSdH7s7zD?=
 =?us-ascii?Q?mCpPmZKeX64v85lKjgX98I6dCDes09ZluMsJuPhXNCx6m9zuD/7eI2fM/a48?=
 =?us-ascii?Q?ESitnTCNOTHujQ/ELSPDr8SXkP3H9tqvuO4HzqJGjFP4RwOfwYMde3ajano9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e008042f-87b0-4306-a25f-08db6b853cbb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:19.7620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjGx1C7VPhciuCMNfUsQjVTUv6XMx/efITCxS6d/wyAqG67SxtJjpf6vEKt3yxHcF6ToOmyjNzmyut6N6YlzUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_15,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120176
X-Proofpoint-ORIG-GUID: S0vO_-NYP_drEBiC1puPCk0BtsjcqveT
X-Proofpoint-GUID: S0vO_-NYP_drEBiC1puPCk0BtsjcqveT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_rebalance() is called to rebalance an insufficient node into a
single node or two sufficient nodes.  The preallocation estimate is
always too many in this case as the height of the tree will never grow
and there is no possibility to have a three way split in this case, so
revise the node allocation count.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bfffbb7cab26..815c64f4c370 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3166,7 +3166,7 @@ static inline int mas_rebalance(struct ma_state *mas,
 	 * tries to combine the data in the same way.  If one node contains the
 	 * entire range of the tree, then that node is used as a new root node.
 	 */
-	mas_node_count(mas, 1 + empty_count * 3);
+	mas_node_count(mas, empty_count * 2 - 1);
 	if (mas_is_err(mas))
 		return 0;
 
-- 
2.39.2

