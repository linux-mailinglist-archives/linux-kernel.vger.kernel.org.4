Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354A771906A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjFACQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjFACQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:16:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153E6188
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJkDWo009444;
        Thu, 1 Jun 2023 02:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=1prjPOCurqnWH4L6WzWAHY38RL29aaMdFp7clnJuEH4=;
 b=H1gLBfzet3/HjANoit9cpUcxCDUhY2O+KMNTgDR5zSEnO0pVQzr5TM5/vdI/IkdLE9FU
 6KcdEzLYFznxRGZy/tHc9LhXMeG50xCu+fdBOX6rlRCDo7Hbota/OQbnE50O6U0fFSJp
 H8hkRw4lDRDcTBfAxSgz9luo/9EX9u/IHLrbN/x5HAi4L1AHomDBfRj8IWgfXeH4mwmK
 hThMpU+NFbPn81RlqIeibusg6V4KeNMZn+Fce9Cy7THQ7iMlcNzqRsn4w/3v8CCJ1ILc
 SVBhrU26e18STP5iL6mYv94A/+8NaFdwwoZT8OLE3NGoA97n4uJJRQ/zU/yRyc1SlDcP ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkqjr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3510E5Vd014631;
        Thu, 1 Jun 2023 02:16:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6gr6q-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY8EXKM22eahcHthmR+YXWlF4/pyi/yCdd2cq4X6gioNbDPZnDBejKdpIWFuJvDKw5eUwLBb+iPB+dcMom6o5z1OyWKwRbTVfykMbOorqy+OQBbKEEw6uYZaWNSEuJMJocvokDwkVp1oXFG4cMyixZ/s98bim9p6GsMFPfRXN/N+azl1JXeUAyGuWYHMKEzlyGmTv/0tezcEdsY/qhzpaBeCadcvZbE/rsqxKRCE0nf9yMeclkwtQPu2ce6YaapYEmWXUbVtKuBd7+3YwZT3Ryc9RyTLvRJShRw//oDMOTrrYtMwaZ/2UXfn1ZUfi3ph4m8fN7wu6QqJyXX/+764Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1prjPOCurqnWH4L6WzWAHY38RL29aaMdFp7clnJuEH4=;
 b=daU4vgZHK5NDe9vEW6E6vPy1BXhcsUkHDDQ8im58Fz9WCWZdkU79maJ0vPj7lglCQe3LpckQ/n8ieQotUTWXaHK6bQEmDC0WEsLfvoWnrxFnjJzoL7fgxi4DW7HgOwLERYDYOAPbFwA8EuuhgQVuXklSs9B8zFhzV7dd3m26zMWF1/RNiMQu0dFbDATggiZOOHgGZvgU6XhgQy1gwIbGLrjLSJK4B+njVjX6prdiw5iICmfkFB6zNtboZfmn2S1QYr2EFc+TwIoV+kPn2qsVYdF3w0fNnEHpUSynSsQpumNj1e/+Hx2hZBzAJd27XEKy/g8SauvUcxcamgRHx6Lp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1prjPOCurqnWH4L6WzWAHY38RL29aaMdFp7clnJuEH4=;
 b=roJFJtwwgLYLJEeFrgzoavIzsX2H6l0c9QgU7LOyw3rmxR0TrqRipLfrFh77+wWmUeUKopUXGvz7B+4w50F9rBDWYB3mHPFtiCv5B9VjqfmfV6OXo7KApVzY4eISwHINY1a6xoChdiDgcKqVlaT4oD8nkP6wQ3xLmUJCJlgiVOQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:31 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 06/14] maple_tree: Introduce __mas_set_range()
Date:   Wed, 31 May 2023 22:15:57 -0400
Message-Id: <20230601021605.2823123-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 782a978f-7a23-4a19-cecb-08db62463700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: py0oU9qCVFh7z8SX+2hQ5A8fXOLsQOppAf2Mh8VNa9LImNv9HksWr4OKP+Om9q+6OABLpl/ANNv7sG1BxDdtsiXe/dV1acBE2C7uoOMYmcu6QwA4UJpZi1Eb0a1WNVn82DsWbVxD2BM4nvtR5lE52b8iPYV2e0tDUBC5V6/21mAp9XgfRZHlPkWksX4TMnz/282IweXxhrsPXPTOUuFuFh0kyC2vwtn3RX3IJ31nixDxXDvHRhfh1BVTD0iNTlaQ+YWxW9XT6wZy9KDsvVGT1u8jsL/ZaLnYqDZa52iXqDwhGKx37H2PGAF3dnyEVdJgik7l/tiNqcYK+pEh1GBY7tOk8B++PjcDu/3zAf4X1EpRH85MkMVFRvAtBSb/4sJU3DMHPex6mwl3XjhbjZMMYLPX5kBYpvdEv2+igBKeeS90uIpc0BGFCgZ3TYfOqc0vq9U6mZD+brTdfJoCKKZYTjpGQXsvoavngAtHjipKbD2+ld8gnrc/0baMWnV/HEsc12T0U1qQzHk3OWNn1QRQIA0aQhS+NWiBdH7uNXP5vGFQXijkDnxdJ1t73TfAkoVV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z7VBLwXiAs7THPPHUptWOkNagWQbYoqXfVQyVdndSfBn5np+qe3bG7oRE3Qg?=
 =?us-ascii?Q?rDlv0JQ1ZYQVVO1paxc+DdDtRPkliBWrXLVsXjmGu/cxVutYr2mYsWORtjK3?=
 =?us-ascii?Q?rCqWTTHe38IjQdtTfmX6TFGey/xllh+VmJpeLmHDe67JdJFm6kXfnd4uL/Qr?=
 =?us-ascii?Q?Nx1ZXm3O7pSWHbtjc5LsibTlukWZp8eOYO83uUwBrqf7S0+FRarStNlJC5G2?=
 =?us-ascii?Q?K8oLOin0mM5QCylxtctUk/oN0AftPnmAU9GuhlJBUC9vCg9kS76bH7TB9S3t?=
 =?us-ascii?Q?uSFfFubjPeEVe9Pq9qdP/srl9RSHDabZX+2MlreYNWuJ7/Ln/waYsZOn1uyA?=
 =?us-ascii?Q?tVNCo5TQM+3oLaysyXVJi/ntrMuj8XfrlfUFzD/eZ4OTfY3MvuDfJbX+tZy0?=
 =?us-ascii?Q?EBcxZkZYFMfASPvqm4hMyeOEZXI30sFjsA+JZegD6K0+l1yQF4RG+QXiRstN?=
 =?us-ascii?Q?B0fPYU43zJrERkT2RuFJxH46Ovt9xxQn3e2SyEUPnCKhe4FhY7tIR0IUC/+D?=
 =?us-ascii?Q?rS9BCkuhuncTbQbL0CHL/OC8uc93f/rzsA+47lpo9d58dXhO7rVwFrV86Nxd?=
 =?us-ascii?Q?l8IBrhGKUhc4bFLjSjxdNFF/TskdUqn9vf1Tln1KCT8cAU7JZ3bshzxEqp1m?=
 =?us-ascii?Q?lbNDXkPK7Bggps5tuFIaCKJoAanmuyVCeeBOCeELnjp1Yrw/VguVu0AFJQWu?=
 =?us-ascii?Q?rvhLYVvBS6joofEpgxaqcbRFIryLdBIPZlRKBTS+ZoKteUiqZ/ivjvzs57Mn?=
 =?us-ascii?Q?LBmTtQmA62lTcc8YPZa+JbeO1Os8EJTD9mQE5CVlsK5DnZHLv7Y0Eg64D5ry?=
 =?us-ascii?Q?JV1mMDLrQ9y/J6l3crgg7YU0MBiL2Z0Ze/wvb9KTQg2UDix+WGOyeb8kcUM+?=
 =?us-ascii?Q?69A0Vfy4IvHLRFspyG/a8xamI75rBTH6gRbQQT90KidPntppRxA4sKqD8l0h?=
 =?us-ascii?Q?pQGL+QMqoB0HRig2a/CyZ3Nvje7h7OoJQdlKSpPAsx3FZha6Ae85B5BJyob4?=
 =?us-ascii?Q?HvCFtzQ+96UYtkBWV5eHRjuDOL5Yq4DZDO1leU/mVWIo3a3Zdvz8gGzoirT8?=
 =?us-ascii?Q?DQxMi04G+Q67NpWWSkWBITTDN4eHyETCeOsSJTq/BHN/PomXFT/PJ435RxBo?=
 =?us-ascii?Q?LBDtTQxbiJPrDM+8zBzYGTdAnnsXC/ucJ79Qyx7MHSDDcraldkncNrcxPPz4?=
 =?us-ascii?Q?N9ZMcxxSl7Zgmg1NDik3OwAXW+eZGzqS4MTC25uUQE0IsN5sBm3WG8yF3QoC?=
 =?us-ascii?Q?5YH11a6pTdGXoDojxxugAy3Bw/LW8Tq2AakrjYN3TM1Jrwl9rhC/1Tdso7js?=
 =?us-ascii?Q?dcKelQrGUWYoEhyXuoSRV3jguzhRazuqDRQAWsThWurVStRzg3kja2WV81rM?=
 =?us-ascii?Q?Mi1GCZlWHc8n//+g1bgWogMt8pl2cvHjxX7Op/bRqQ/1WcDCGokje476lw4X?=
 =?us-ascii?Q?VCmQbKRl37ULDEeod3A1rPVheQMMhfgkg6WqRKnKG3jWK4sq+GJCrIJRQiTM?=
 =?us-ascii?Q?U1cDrtpN0gkn+wpnEyEVwB2E6PZp4bDF0p9kswRTJGzDNGcDgXjceU1FNA4g?=
 =?us-ascii?Q?CYBeggQovvH5Ca1w2A2ajBsSwB5gxiT1Itv1QIOLqKhKL3YrtNlx89hxPaoD?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uFIw54tQt9vr7QTTc2NqEXOM0D1ZLKNMZVBX0G/XVoRye9SgMO51CbwQ/qFYEnbfBA86LQs+Q79+F2CFbnz6+fdQyrTWkS/nNGVkxAj1lk199H3UEaPTKS+LuHSpsghMhQkn4B3RzZaTEEx5mOijY8yAo+sgAN1XNmi4RF5ncpFSpfxw550n3Xqis95IUy+Tmnd8MsIvx9e6NVD2AKbQRsT50QxWss5+/6kvV4zojFqhWPGAa+a4jbld+mfsKgK1q6SisWHihYyEMRCXudgMONTIsCo/f09HcTXmvMEB7aWdv9wX4rvpUuzADtK/6yXPg8D+7G0z+xD0BoX7nUDs8vkWG85zIy+4WqZAskztM1SDZtP05CvdCqbnCW26SKXi0uyGH9qdehZ1h0VdiFZCNnsaz2RjIlXaA4iT22Ve9qWmoCKxUhEOeak530Bf9zs8JvNyTw641vocA0vHthJhD8w3Yphs3vTWaxvoFjb+F1uRMGJyLPT3apyMZsOoBo3tYUFI+6qJrT4rRcFb0ca3gZLNaXoj8gqlAw2SnWEz+JGH3Cx9yMHrNEyo6NKdAuBymPvaUFaQvv3KsrIVCbdM+rlfW5l3BUY0SQCaZMVpeYSM1rfm2tYlbpVqPBf7WwnUuM5SYVbCCvYzErnfOdbPdgWy1BEOp0mSWadebjZ+1RW3cjAKWwh9w8nYm5MEmc6wPZ2mrwucCYD9fvbd1H82+kwQcb3A9XStAUWgZBAH2SEAzhhHNX4nURQptwQMdLfOMbPq6jbDRjVSbGRRs+bgMsBnFIiumyx5ZE7875IP7or3JFkcz1xoXzBoqZUOBKZUbMh7ODjPzp3i5RjBBQcJHSTCdHxyr2T+nJ4Lc+EoKcf6POoCCa2/xEaSe5cWGEIXj8lPyAxuoiRRyxEtqz8/VA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782a978f-7a23-4a19-cecb-08db62463700
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:31.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySJKx9n8d1cmi0zt1Zi1x6YaQBDboGnqrpN2D28BVB6Eff/hWmBcF1HMPW71irhJ0qEoCV3vYbBhHlirU6sK/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-ORIG-GUID: GABSCyd5LAz6YkP_IBOwTFah-VR4goXr
X-Proofpoint-GUID: GABSCyd5LAz6YkP_IBOwTFah-VR4goXr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_set_range() resets the node to MAS_START, which will cause a re-walk
of the tree to the range.  This is unnecessary when the maple state is
already at the correct location of the write.  Add a function that only
sets the range to avoid unnecessary re-walking of the tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 295548cca8b3..ed50d8f459e6 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -531,6 +531,22 @@ static inline void mas_reset(struct ma_state *mas)
  */
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
+/**
+ * __mas_set_range() - Set up Maple Tree operation state to a sub-range of the
+ * current location.
+ * @mas: Maple Tree operation state.
+ * @start: New start of range in the Maple Tree.
+ * @last: New end of range in the Maple Tree.
+ *
+ * set the internal maple state values to a sub-range.
+ * Please use mas_set_range() if you do not know where you are in the tree.
+ */
+static inline void __mas_set_range(struct ma_state *mas, unsigned long start,
+		unsigned long last)
+{
+       mas->index = start;
+       mas->last = last;
+}
 
 /**
  * mas_set_range() - Set up Maple Tree operation state for a different index.
@@ -545,9 +561,8 @@ static inline void mas_reset(struct ma_state *mas)
 static inline
 void mas_set_range(struct ma_state *mas, unsigned long start, unsigned long last)
 {
-	       mas->index = start;
-	       mas->last = last;
-	       mas->node = MAS_START;
+	__mas_set_range(mas, start, last);
+	mas->node = MAS_START;
 }
 
 /**
-- 
2.39.2

