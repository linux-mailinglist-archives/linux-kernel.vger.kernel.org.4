Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6E708466
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjERO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjERO54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:57:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA6F198
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:57:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IqxI003904;
        Thu, 18 May 2023 14:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=036u3Np0Z36ocna1vzafx6uHq45BbcXy2glhvh2TOgM=;
 b=hvi3MrDefed2tIKCpvjfMw8Unh25ICT7jpd/IQacZE5ou+xh/vA/gkMCjskNmvg0yzR3
 P1IsezX32l3Y/5iESrD66yjYoIxFv5OgvSo9Uu89fiB6Z1uNRot9FwOGsgI4sUoJnYgH
 do7XI57TtIdQ7o3GSQAhdehBpbuYCnaGUROqsxtBjemcNl0Tck/8FgQCXJQbeNwc2PyO
 DOIoo0HMVVBLrrCNehS8aFG2P2BcC1S6DA8RHresZ09cdQ2NgQqTEih+4BC9CO719hVx
 LtZkRDgf7g1LQEZxKHwTQXX7Yh1ByEIsAVHT7gvZgFxkWcHgtaXwjmc30xFp/EsREoZQ jA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33v043j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IEIxHK032121;
        Thu, 18 May 2023 14:56:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10cwrgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHmiyYdd4foSjSoIL/OPxP2G885OV4W+xpoV1yEJh6a0Mziyuvz6alxnEctmad+3L2uRt54376gdS4w6zx+iRMcBfF46u5LKi4fq3m5AjyYPOoOOTWzWL42dqc+G7jBYQupAb5kmcHtcW2KEp7KYwK/1Txd0IBVoFy92cDzK2vfR3uiajvTEVDA19989SEJJ1QqcdoxWRfjl4AMt0PcCLmQ9R+cp6MRbCSS7LL7aArq1wwkbo9HcPMh+o38eKH1XuIFLJ19gxMkpD4J9Je4H5Mpe2yfntUFJ2RgjUg1XP2OMRy/k7d2EtSXZtE1wpwabK5/XR+ykiqkoEbrMZUXHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=036u3Np0Z36ocna1vzafx6uHq45BbcXy2glhvh2TOgM=;
 b=jWHvhzSEgjfKgU7zCAWH/QaQoBozHO9pAZBFXhZMEgwspekVNOGX8+OJSi974XpiB2K2bZaMxC9G/JphP8LNqRLx3BC5ugEKYXFkTClXnmRIUQ2kXDHS3tSF7tIpRY7mAuDI1qq3rmEt0vmBXASAGKO3vJp60BTui0hYvvXxiBQT46ydHcGyRc/BJzbK2qPiLDIZhFa/WXfSZa9BN32cbEggLIhxMPTVheOr5pZRRbBSCnps3z2NSw5lI6EEhlKGh6+uiPOyPiR2CgZT8mBzm6MuPEddDSfAuLzgvoKGgL6bsOAm2XFY0dADGwzxPizVulMzAGfEeSUR3vJUGwaieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=036u3Np0Z36ocna1vzafx6uHq45BbcXy2glhvh2TOgM=;
 b=NRtpEKvzcS+UI7ZQ1HFjA0EtT8YIud1i9Z6HYnRAHOrosch5H7a3boKhSFwdhIfhc+ldjXLNx5DiieUla3vXqaTi1/gn1XDlaK9l3HKm7xE3AMoPwZ3F7mQONIWTEXLfdraBAAFkVAOQZohvbCpG/o2dkdZ2MZ04dIc8b1/0oCc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:56:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:15 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 11/35] maple_tree: Use MAS_BUG_ON() in mas_set_height()
Date:   Thu, 18 May 2023 10:55:20 -0400
Message-Id: <20230518145544.1722059-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a29ebe-abf3-41e3-fed1-08db57b00765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNDX51mYlwmH6P9Bq4jaBsMufTuAhpUd2rmtFj9d9XGEnsuvkq5gf0Y1Ts/5bKtlZD+waZerMKgn+3gamFj6Rw2Vsaj6WzQFtgjZ+H+oS+A6jkq+t6N5cnhBZsGEyXpqJqF8LaMEN0Rm4O7XjP8dl2QMrrBqB9IvA1HJ/jr85b5ybNRMSLt9ymnq3sHpKQv3iCgy4PnVHNliLjPexwm2ZLhd8NnD/moxKexSAXBoXTpKiraN8WX2u8AwB+yrh4xT93b7cAvvR0HQm4BfpCbDlew0dDoyaXf32yhxXPaIZVGYiYEIIHyn0/7IdphHUQ0VvunyUmJR4LvbShlagk4q3w6/hfqg69D6SAkYRyewiXFhxoFEPxuN0K80j3FrM7Qmrm3zFjCflQKd4kkp9DR58/cK70UkBvWWwTApk0VG8iyA1zj57SS2Kpue5YRHz8EXsoQlX9pauLdCnVIVeekLlu/k8wAjCL/d8Xh9iuk84fSynCt7V2UYtdR8asRr9zsIe6ySy1m65Efzllo9Rrr3stD1JPun5eA/6nS0JxM45tGbEmklLqF9J0oca/ViDcMh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(6666004)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(2906002)(4744005)(41300700001)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cg+KYeQgfl999tunnQdsbEfXaSHz5XpWFuN+X/ZGfn98vS9GW2riC57d7+AS?=
 =?us-ascii?Q?QdHb51goZI17ONwOAdG0bIq8t1fmln6So/QuDPiwBl7vWFm90AnoXe1/rUd5?=
 =?us-ascii?Q?fhN2eJDEnTEyTiVt+VoJarn8oz+T8ld+B0OJxeLOHiMWpPKUXGIV+YHf2jQJ?=
 =?us-ascii?Q?2Mk//65wMyh7uBY/KijBk4bESWKkhviGJFAVXwx5Troq+UeYgL52ku8Q73i/?=
 =?us-ascii?Q?IyHhJMmb3A6rFlGCysLQLK92PLNxpDGD88+bHSE8CNY8ZiKEIjQyKB8G1mOu?=
 =?us-ascii?Q?NqAMO+xigfACafiuZt+up4JY18mltUU4m4TulPujYGJmi8vIChO6vFWe3SDv?=
 =?us-ascii?Q?fh/DnFHZFwTkP2Y5GuM7ViAE/0Um2ZwKLbjgh5eXji1WFGm9AF4qkfPuvhHj?=
 =?us-ascii?Q?zVwk4xxtw/+cJb9re1lVvhMhK5QC5/jGHTt0oQ4tZlVm2KYs8lI7RF1AlKCX?=
 =?us-ascii?Q?YhvrlyEPmlxBjEraP+93772Nm/iWr6HC1B2e5pPpakBubUvRxkWCA6quPrw2?=
 =?us-ascii?Q?RCvT0zDOx4Na/qhu265Baip8rHLCNCrUkZ5dXnmPwTnJ7T/1hqrJfpg+NqNN?=
 =?us-ascii?Q?v4zI5g8k7QkRgiLC4dYLCgKWiVparffs65CAfA/5Dw2S8RlUgKmqSBOLR9XL?=
 =?us-ascii?Q?7xy2OA+3SsH45OqlMcaaaXVvoTuWzQ8zzniDBzEyYJ2ISD7fFRW0WE5oZW6V?=
 =?us-ascii?Q?RTU55Ey5pbhV8Z7DlkB2/XOdjRpVZ6YoVbwuzVuH1xWHifRlMVUhr9uyw+4F?=
 =?us-ascii?Q?czUUOKHkfX/O/JwyK+Y2paSzhp9OSNVYwkAha45B6Q+9bGxgt8otj/x/8JNt?=
 =?us-ascii?Q?W8Nb8b/gVbXeH9sJ5U5IcXW8N/YjgLctxlF1t48TEChPQbmW3ayNjPA2LqJv?=
 =?us-ascii?Q?4eWHLOg7j9t36EGjlXuwhtb8g3uaknn42ZfKheS0QObqUCiJXrEPnnf3fXN9?=
 =?us-ascii?Q?PHVGhLJDEFgZ8b6AvLqZxMvnZsOboM04QkCkjYCkrSpx1U7AgBtwJePwRsCB?=
 =?us-ascii?Q?X1QkVMFWSwu/Ebiu+1PPiggoVvxw/Bn2RYrilrJidp1DaO8FWxx9HmnPTYR2?=
 =?us-ascii?Q?zqTmx/psHmXJ2Wmua/F+Yf25PV9tco2AvqqmgJ3VV+OgKkhV4FDy7rLFikgA?=
 =?us-ascii?Q?xIe2W/ToYykIEjj76dQgAr5ZCaeiwE08z0Hv0eDs2kgAfZuOMPuXMt1N6GZc?=
 =?us-ascii?Q?sSi61rLvowBuaN9SCXPkE6//2OoFyIxmzg3xB23CKRKYkjFptW/cxXSTtigw?=
 =?us-ascii?Q?EyjYhVAJW8CXneLcorj+OHQI6kDsu5R3Zh8Ff3kPwn09XATv0v7XTAZPZ/4l?=
 =?us-ascii?Q?TQruKZX0zOkI0WOe7RgTaivaklPOq6/W3i/MCx21QjMpzwk+aqo7V3lzzuiz?=
 =?us-ascii?Q?6Qa50tAaK4UlXZWtC7sdWPqQ1Slw8/HyCBBaw2VdYIU0Y+Q2j7CMEuFkicjK?=
 =?us-ascii?Q?rV01VvxQrmhI8rm5JxWgUW0tSLZC/vjil63Soy0aZwFNQP7RMSNDd1Ii9euq?=
 =?us-ascii?Q?LYApYz4IL5SBQZEh/p1pefnzXBG0juPZ03sQzRreIa71oaS2TLI+TIed2Mzt?=
 =?us-ascii?Q?x04sQwQWMZuvgiJv4NMjsS483VoO+ga+kYCmWFWeuNlOIKMjCaDw/Y0NSsrn?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4xqJzALnbbxx614B1b11DEfhjI4zT8OXeSRqttNsCvXhNLiSZFwVk13Jeb+GNpYfg7dAlU/CCHCig+8xHMEw25YJZpcKYBmYWQFggwJzOKxkKeX5Iu2KWdeKOl8+Vj4R2s5O/n8DuJhpoeQNiCeevlNAm3idrMRnYwqAG97ctthcF91Isq7RCCHoSDJBo4/9G0Ojn8gOYyaysjhgyQJZQAh5QlQf9oCV+5CghOk/IknUJAuPKC1PtDU4Ahg5rRu4TTGRpKr6meideotn3fYPlZ6B1WLyy/B71Ga9bKnObX6laSBMD6aocWtvV5IOTcs2p77umVJpmA3KtNLBjmsadfVRFx0V7gjzd7RyNL6T2yOPbnWRPsfTLbsel31dNKOx5XDSrXWUn/W/o7Hi1GFxoVnQTq/ddNoOu2SxbMO+I3ML5Gx0ntM3J1zsP8HfmGGhmE7vYMElt3DDb4mJhv+Xh/wBfnIcRGkaNYdwv9yjwde7Aa7UgvkTNsHthYWnx19VQoWrD2qH0p0aX7qc5/K/qXoceNnw57k37ciNqhRoWH+ub+Krw/ev0JBMQno3MVu3vChSNvKVU8tC1lR7Y7+/1YSmvHiDjsA5oI9YXvzRg3tTuxkSVth1NnE1CIkZ6henR2KO4er5r3nnXorrfXHjk0yWjjY/e/jc5pTr5M68zcmPuV5Of33/VkDjNayPHHAj86PgZ+6GtKKVJoZ3Oj/vgRCa1jPR1ZUvi/9ckY1ezW+GSxftHu+s6CRgyUhRg/OGLwiOpBTYUMF8/8cPCMgvdaSgFEXwnlrTNQlTQwPhAffjHWy6kb0VdENcUSsVNODcAhFBfAGUhIxvFDFTS6FosgL7/N/mLd/krRX+2a0YIdlq7BnvlyN+x++H8XzSKmrHyqQMTgu46v67NTIhOGFYbA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a29ebe-abf3-41e3-fed1-08db57b00765
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:15.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNSUg9jAvQWqqDCnIG0OmbIvKPNxnP3c0I0sHJSAraPiLd1a2WcJfn9lxfl4kFlzrrIB6rdj3QUR1p89DgRakA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: -pMsodl5__u1cw-MHwCjLQ4WtzyHTN4z
X-Proofpoint-ORIG-GUID: -pMsodl5__u1cw-MHwCjLQ4WtzyHTN4z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MAS_BUG_ON() instead of MT_BUG_ON() to get the maple state
information.  In the unlikely event of a tree height of > 31, try to
increase the probability of useful information being logged.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a594f1d88d06..da441042ec8a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -194,7 +194,7 @@ static void mas_set_height(struct ma_state *mas)
 	unsigned int new_flags = mas->tree->ma_flags;
 
 	new_flags &= ~MT_FLAGS_HEIGHT_MASK;
-	MT_BUG_ON(mas->tree, mas->depth > MAPLE_HEIGHT_MAX);
+	MAS_BUG_ON(mas, mas->depth > MAPLE_HEIGHT_MAX);
 	new_flags |= mas->depth << MT_FLAGS_HEIGHT_OFFSET;
 	mas->tree->ma_flags = new_flags;
 }
-- 
2.39.2

