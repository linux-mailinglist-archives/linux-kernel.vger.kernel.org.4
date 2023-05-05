Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F391C6F8926
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjEES7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjEES7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:59:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBA51AEED
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:59:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhL6u014783;
        Fri, 5 May 2023 17:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=1Q7wqf4ijKrU09WVtajX7KD9NtJGhpTDiMYTNaVpvaY=;
 b=ZkWmL4wWmD1i7I6lhnFOTr8+xoRB1WVwIIwnLOoMVrs0Z0NtVn8N2aE4m+IMzR13ZvqJ
 cyqxOtHFGXT6Hm1hj/Ln7e/rFVJaytMFFDkWDZrNDOdQqZWxQu1giHS2TOUw1Nz7Mo47
 jeBlYervV8t88QBvdWBs+jbVN0Dr271VqcELDE8RRn1X7a8YVN9oEEf5hUV8joHjBYZB
 Xam0oSrO+9RdnPus3iD1wO0PjIlmY0mg2WpJpFpBjmwXXzgMF8ICksP9I4RaBNp4DtQU
 p8iDmlqXH6plzrm7YHLqIDrtma6J1Gnkzr3TsFhdQ313Vfx+2lsfev5fivpv6kNijTEc BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sneddyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345G9u6o010002;
        Fri, 5 May 2023 17:44:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spankac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyTF1/gOqHkT2quxxq47PPWSTy77nAKv15OSAwU3IlMAe4KhYEwiaIlSNFt29OkTuR0AvS9Eziuf4Dx0V6QinF9AfeIDAHklaGgEEgBTSoSF/+1JSzO/bZSgkXHiL1iBs0k1kTSGypq2CCfnrAoVqbVatBu9+IfWymIOB8wlV0snJW13oRS8HGRt5nYljH0PstdxrJaqWGHpylffpu4epBSsr9Kygg3cZqCzXg+sJB34lUTvnaKnT3pTiUgy1Gwsc+l5n5R6qdfrgOvuhk0BBFQbqXkDjADJRBas0SmIoqYfgO522JWIbLYvJ3tNEP1E+eGfIkx2QauJHyOsd24IjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q7wqf4ijKrU09WVtajX7KD9NtJGhpTDiMYTNaVpvaY=;
 b=hdOhPQRvcGKAF/KRqwOuiv2n+yvbVMcjNj68qdVStrPVavJ9mFXI5Qgkwpj/bHj7P+pkDUqsn+uiaB6gXM5rNyYPkB+Ui8eDGdXalbLeeIwKcVVn7pldnFe4+ZrLVdjoYUDccJIFR2l0T8IHNS4u6rViuX2XFhdVQjLDBrOUQM5BmqeQZmIzQ/zI+Tqwm6bvWFdwZc6v4LfJzxuSVxfHmD0jEufmEdoN3ODvK+elHs4qixBPDnZ56g2rOoxAd1nflfpSR9KfWVmjKQrryRZ4KHn1Yo3QblPoO44KLi8mbBqIb1Ylnkp6+ti9qAuckIhMLWjmIYJgYnJEMHYqGYEc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q7wqf4ijKrU09WVtajX7KD9NtJGhpTDiMYTNaVpvaY=;
 b=QQBL5Lmu4psYV3qeY3794QqZ6mAgKzgPDMfPGypxkbz9QxgCNn8/yrMETGNIcUNKgpMWzJAVNhKSqDvcYyLgLLqV+5lCaPdJm8kSG/8SrtpPaG3DZWFzh+BGEmhEkIYbFL5egb4eKEccanII6iAlgKM+8+sO4EH0s8/aLD9eKw0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:29 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 20/36] maple_tree: Remove unnecessary check from mas_destroy()
Date:   Fri,  5 May 2023 13:41:48 -0400
Message-Id: <20230505174204.2665599-21-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d311488-954c-43b0-95de-08db4d9060bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALOyuUfn8+roYuDqNx4Y0Aec/UzSNNV6PtCJuIhUBS9Ks3+Y0VNTG7tWwO05JPoK3mr7HMiWUOkZl/mqZDTv4jUKd36i4AQLqbFR0MrG0gkd9i7dWyLcqAeswW6GATxQAg6/uz13rGoHZnzyA1FQK5YCwbPh/QBSYflN+CulhOEUHTyc3FvzdIvgZo2OuX9QQQbj3MgCMM+Vv6T5Ss/l8lYgj6w6bs97qvNdWa38L7iwiMTBxUhP8CB4MQ5b/fj/0iVu95IsHUcleB646GEGbsZTP1vYhzTBYv3gG8XF6uI1nqYg1vW0DncasQoXCOBWd/gmKIX4jG/CEQnkZ9HAutdvPKTJHnV2vq61uIKGE+5QgbyQYcOS9rHiufBAkvS1qvNR7nKEZbIBH6S+PjtvhY53QujmoLODFLovjakZJ37TdxqhpB1WLB1ZVAkeOela2aROfuCMN3erzxHwseFWPGlDQmNt/AykITl7+eWfjj0+mF/3nwQYasnIhz83uzULnbQ7eFyQgcHZsZ8/LfHFHcza/xS4939L7FnutlJhKULY+/PQ1yedPbKLBUo9kHNd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(54906003)(316002)(478600001)(6666004)(6486002)(2906002)(4744005)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ho1ZpQVFkR0Z1pgAVCuZ3BCUpWygbhpCZGaEFXaRDnW80QrUDnHOJl3hEVvi?=
 =?us-ascii?Q?gSZFQZS8ilW5HZJhElfaXExadbh28dSYV1/hfDD0J+3kQRc4BQKC8yBQW9pt?=
 =?us-ascii?Q?W1cOuWJbYtar+DtoRkUXaQTXOZgKYw4sDtMFwSI8fsqzlxaEkK4CWJ1/dMPc?=
 =?us-ascii?Q?CbX6sZAiCyUwwQFQFoeoZUiqMrHuOFV3rJr8r1Zvq130oCyqg+QXA3ZJNKFY?=
 =?us-ascii?Q?+YNVNZMwyHZMQ84+W9u5/6IuAevl2EzK/SwJO/+/s3PQEyQHLiVfeLoEg4rZ?=
 =?us-ascii?Q?E/LZ2S+KpT+Hc0CHJGuCi8Xb6WMlRYWKXyJQv9Jy8OsUDK005OncyUQS6MkH?=
 =?us-ascii?Q?F+qgAXLbf4uRDPwv4otEuZgMO2ig/1Iam9SqNL1dORJRXAkmNoeQA3ghK7VG?=
 =?us-ascii?Q?DsrYQKGJ2MYryBmuoswFbzJoPKSPLz0O/VZPygwF+RBsWBlBSPsxasLsl9qG?=
 =?us-ascii?Q?VxeBUPa/rKqIfIhpg2eBMxcpaLkW9DSVMvdrYm//3vKd2OcCrNaw6+NCPYu7?=
 =?us-ascii?Q?To0odliTmot1bsIHij+7S/9ydkuNzbqNXkQZeZUoOFAJp0+cyOFobAXzFaem?=
 =?us-ascii?Q?PBrT2H5/GKNYm7/50vLUn2Ldvyq1w8yNXQJlh3ltz4NjR2tshdq2cyCFO91S?=
 =?us-ascii?Q?tatQfYDL+hpQQaxKy6EizAotgP1pJm9BZu8iXG8qXr+ZNfUbfGg7k6RF/JYV?=
 =?us-ascii?Q?2RLqR3tjMhEQvniv7NdCmFHBR93V4UJ46trz5r3iGQUFgEXLnWFoJDjYB+Fk?=
 =?us-ascii?Q?kAxtdldzitHARugJzbVGDNCURI+WiyK2bO0twPBBY4rMM16NxoO85F28qp5W?=
 =?us-ascii?Q?w69+TgXoKBcMbdF077CabKVS0KDGVdB6a4ZpStraYIG2QYGQm+H/uDqKayiC?=
 =?us-ascii?Q?9tiDIZKBGbyuXM76MnSkCiEvVOkketSoG3pjDCVlsSVLLsznOEVt4nBqj+/o?=
 =?us-ascii?Q?kr2ig24WKmwnvkXJudwcEsNd591E8wBGG0jP8DnnlSssUqhjzy0+vXrDP0OT?=
 =?us-ascii?Q?ossL4Bn7iTzNsR75FCPUMuB09f1zKI/6FbUmw6wcN9h+OXMNPctVfBCjFPse?=
 =?us-ascii?Q?b2r4uqpkFgbZvfT/uR3/oYh4mPD75XUMQWztAJd5W854NYyzGIUyH0PJ70Xw?=
 =?us-ascii?Q?JuvRoqmBV9M6a4+V+1cl+gtAF+fc7ijXyiHepuaCXH2ZtoOLJb8C1TZguHd9?=
 =?us-ascii?Q?6L2WzYho4yPBoYktLhBNmHDbdQUKAfRSvkwfEqky2rlAqQEOWnoro+ZGYWSr?=
 =?us-ascii?Q?Ux54gxxYnCy+flIUmfTJwXL/XhKLK58NgnnUtQtc3Yb51GQmlgo/1BirC+QW?=
 =?us-ascii?Q?mcTWETO9df4UDzCI5Z6wuFzdcADcXC8HIawvqJNbDcFnD07ge32E9PpBsAXD?=
 =?us-ascii?Q?CwCNJbbZW5RkEyOgfEz1h6oYlJvvuYVuP7MEziAHqakTQGI0gZ+DJuE97n7Q?=
 =?us-ascii?Q?ItyRqltBclIOjYCU4X2gNB/TS7tdEsrBSgFKAbMEffunplaw8l1u8MFI3ZBY?=
 =?us-ascii?Q?+8ZHd3pYAYocjlCVek0AOgLOzZrCnxmTileAzkcZRm8WqYq4mfYg71AkAV7G?=
 =?us-ascii?Q?AZ0atzNqJHuWylbUzZzSs5i0brbzO9mlpA29PkCyc2ZIzgghb017M0PCvZYE?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?79ydLZ+LhDsktje6fthWjr78SFFOcLvpiYjitBzKgSyOlvirSaMvrCKZm4AP?=
 =?us-ascii?Q?L04qby8cHDzd5wW7xauwySFpelUHpT6whYLt8QZ4udWpRuU1VkgBml6cprxU?=
 =?us-ascii?Q?JyJCQil5Dr9dAtMoTcTczRcYpaPyv3FWRHSKNOXlJfBp+trNZysqk1TOFH25?=
 =?us-ascii?Q?p1tIbv1ASMSWNyS6FQah/WZobk95BsvoyaGwhecnMFYA1D3lXohgLOaY1fAL?=
 =?us-ascii?Q?3rPQMMNTNBMcATEcK1/HZoPwaxVi6N6HTxR5ffTf0AH5QLDiBL1iZOPaDa/U?=
 =?us-ascii?Q?6Vs8XPSpJdG0qTUHL3UZ53kP4ju6j3u/1hkg8uSZ6V7oUlrsoqgBwZqA3ojB?=
 =?us-ascii?Q?HLYl2SwquVz5ZQ9ACVjaV4yAVhAaMGRCCz5s+pqwjfVL/JqRc956hLOo9NnZ?=
 =?us-ascii?Q?dSNKJusZPhU4/osGRso48Q+oA+5fKiXFa7ybG98bbwu2JpE7pZUQL+dVzupP?=
 =?us-ascii?Q?yz8e03mavt6AkOyeD+wDNvxHyr+xpUJofYqHhwGqyY5UZGe6pnTRlqSr+mRz?=
 =?us-ascii?Q?8PZACl7RRshB/Tsa43MmEQmUPnyLcp/WjEUBTLP2rfTTs0RcNomRfSrWiK2+?=
 =?us-ascii?Q?dZmH/qM0mj2VapM6QKhW0KjSJrNIi7tmFyO34qMnBAgqq8IfHr/arO4CAU3w?=
 =?us-ascii?Q?HluA59anlHvypb1VfMMaSeUsguqCJ6MF8S+QCbltambefg3ngAoxLlEXW9Ww?=
 =?us-ascii?Q?b7U0ezA2PIolFE7h/JrTODfS7eeN5TUKHpY9L64dwnZVu7D+TrU7L+/czi8k?=
 =?us-ascii?Q?XYn4fX2CgKKxupLBouC2KwaPat0wyZG01cG24wzi0jgZgGueokbbvCxy2mfH?=
 =?us-ascii?Q?tlfvl/r0gBAdB6A8909evMIpoE6OpWkeeM6WCobbG3jjxlULzz5ujppKDhEu?=
 =?us-ascii?Q?0wUFpoIf4llUHeicG9VMnoXS1oPuAQAsYfGpsMURRE05bbShkJkuOVIG1g/5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d311488-954c-43b0-95de-08db4d9060bb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:29.7589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9d6KpbDSP0aEGjvdPiVjZKeMTDlL9eVbCPA+rcC3mi9mGM0oeCdltm2cs3mz/JZJG0tApeU6aBUsX1U7RLdewg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: SxBNqOKL3vG2YZUa9cQlUCztbLguSzmX
X-Proofpoint-ORIG-GUID: SxBNqOKL3vG2YZUa9cQlUCztbLguSzmX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_destroy currently checks if mas->node is MAS_START prior to calling
mas_start(), but this is unnecessary as mas_start() will do nothing if
the node is anything but MAS_START.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9f3784f4a5b7c..b3e5ae43ff8ff 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5816,9 +5816,7 @@ void mas_destroy(struct ma_state *mas)
 	if (mas->mas_flags & MA_STATE_REBALANCE) {
 		unsigned char end;
 
-		if (mas_is_start(mas))
-			mas_start(mas);
-
+		mas_start(mas);
 		mtree_range_walk(mas);
 		end = mas_data_end(mas) + 1;
 		if (end < mt_min_slot_count(mas->node) - 1)
-- 
2.39.2

