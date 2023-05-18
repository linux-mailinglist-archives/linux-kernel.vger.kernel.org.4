Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DACA7084CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjERPX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjERPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:23:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B37101
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:23:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6JJtw026285;
        Thu, 18 May 2023 14:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=LZ+Rvf0vfOSu8urkYzsX96V8zbxpG3dCO4wDwbgmX84=;
 b=MpYzH4MAXaiZWbvjAYTQaDB9Ej0RHTlp+Ib2swHE/Sl+3V3ykxpUZqif9cvxyg2cUMVA
 bjmUQTmTZAOjDa+NpX+h6kSbRYChdCGlFxGuBOl37+fYSHxBan5t5wBqgD/N67lVVqYa
 ECO18ZNGBZU0Q9HiZDE8I4Z9WHIL/0yfZ+qoUPxZF/X1BNVHfS5ku8DwTwY+vQrDm1KU
 uYeU5zZx/aIkhA6FAg6W28S1vG3+lkfps4avTLbWqXJV+3JVaHpQmhTzAC/iHIxAgf1V
 1g/1iGxalfpx9iUi3DxSIOmFVw0eDdvQ/rUyDjIhJX1qU9qQn7VCYW4eTflSiiXIArul RQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxfc2ucr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:55:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDrvv0004227;
        Thu, 18 May 2023 14:55:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10d66ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:55:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTp1S8Yoj0OHgT+XUBondm4jVWgHJc4Q9PmIbA2nOserY3y7YBE2+5Hyqwos/YRFsmuU7fv+665yxfON8HduP6tny8O9ui3T/beyPIiFCcQ5I7mPt8v5IrAyEHIxjLKM3+D0GB0wVBWWnVp1nMcBFiPOENDIkORY5VqlOM1TgaNLtIQOmovCoL0HDLiGLrrA857Swq2zLVwUbdgOHe+ZFx09KKhXwRF8AUKb7AYkI4zzUnWzDvmtvwbhBf37d/urjLBCiQs0OWlCOF2eRnyugREDXEovYX3s78K5tr+VinpvVflBB7bE+tW1g23MojDg9WUyvcIOtbtRwKrXZvhK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZ+Rvf0vfOSu8urkYzsX96V8zbxpG3dCO4wDwbgmX84=;
 b=CViZc+m1PE3bAP3bEuKKbdmdrBSqOm0jJ8G8y91ypRRH9041tZAQOV0n3sdU6FDoMo4OXjespqmaxL6zqI6eMmD1mLh91tNTpl6CcwnmO/4MEZAXtXTpWHDXfjLmDbQUBs9SUkwsAKcyjJ4TbCkvC25DfKxzZQZclJpJFRHCZPW6BmUEpXwSWDcVKRXlPp72UmjwTACGHgELgez7zH/DH0rs0B8PgIGvH2von40T9ByBa5f6OoEEPoirLBVrnIVYm5YR8fpnxK9pNA1D5lqZkDnSo+eXYWJHNEDYDqb/RnM8/+It+aWWx/g7VSolrrpWqA8NU65Z2OAW2L6r7PyGOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZ+Rvf0vfOSu8urkYzsX96V8zbxpG3dCO4wDwbgmX84=;
 b=nM+F3RTRqlVQFIFTHvv/7wtHJf1UrWFP1ZqiJ88qa7bNyO7lmnnqSNVKvp6P8uyUCkT8RSqOylmlPH5OnAlMU+NbgP7jpP3f9wnV1G3BvTzKlIqmoIXU7lWllnAiWvwwwlrMpG+VvF7XTYCZeXIv1e5ltAdfNXiHwTNfHOKG3kc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:55:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:55:53 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 02/35] maple_tree: Clean up mas_parent_enum() and rename to mas_parent_type()
Date:   Thu, 18 May 2023 10:55:11 -0400
Message-Id: <20230518145544.1722059-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0264.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: aa70db6d-2356-4a60-a885-08db57affa89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3sTEtXCdo2+6jk9rK03VO7xdSwMkf1Bb1+yYiSfVQ4pTrdmm+BvXti4Nwb0fVJhnWw2/blWM8RiT7aKr2muuHx06NMxlEJXyf0QKdh89OG5TuwsUN8sNEtN927VrxtoVSLrMqadf35yI+AFRC2w6TVJUxrIm0LK0SwpN+23c+awcdnkDoYNwd+e0Fy4hZ4PLq3EZQcWRAoJu3vpR2q1AdxjfHi/mkh0u+3e60RRpAAMImBILwlFh1qPEn9D0//HzhF7dx8J40LKYLJIk2PYw3Dod+0RHf8cN6x+8Dcx02+4GLqzxomOO1LKskYFzcqt5FIx+uhPo2LdlX+pG8c9KJOxnTnJibLubPSPSZfgPOzafIzQkjla6++HQfoh9CxLnIY18zeUqPj89w/1sYTBCfG2/Bqwj2mwIWE26P/Lvuv/SM3nbhWAKSqASVzCjWiiYedN6cjkQaf4PXHCiyy/O9r/heMWmuZlvbKr7MMhG2vkIf+exxlSI0L+/HLNuzJufCpR75Wd9B5wwbePjLYv782pvOjNLLn/td9AY2u8l/doQSIWwdEf0VIEJIA2xb+e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(6666004)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(54906003)(2906002)(41300700001)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b6pu5IW9bZpnnn/+MB3vZgzesGibpLA4Ln4OixEk+twHknTZGk+Fc09Sgong?=
 =?us-ascii?Q?On4UywvOR5THSt31fURz6ckmH4QG9Tyw9FX+8EdHyla4Qs62QPHB81X5HPBB?=
 =?us-ascii?Q?HXng7MDZLBUd+ioNrXaZLtU1j6TKsAgNqt2V3I7qbCjOwtwQu9Mul9MU0Rbj?=
 =?us-ascii?Q?yVKpaN4dHsxd9aOSYnkkqA/qBVjKCE4+LA1slmnL6wlDo9UJi779MENanZdO?=
 =?us-ascii?Q?EGBtOJKxnfpXi86Pbf8na7wJTpjAmY472bUbVKj9rMZksa6gVJ0aABXTNojq?=
 =?us-ascii?Q?GmEqf9z20MKsVer5+2Tg9njvqTQ1mVt1OJ/Jwseg/HQ016/R1VgRR4oZlug8?=
 =?us-ascii?Q?PZ4aw+GVeQ9madYcS/YiyVfc5VscrXzWe87SrkfkgKm+nsK5Xzo9ubf80bBk?=
 =?us-ascii?Q?ZamNZvWUic6biyOL5/lCf73i6tNgUUJxK6eZA3U+NbWDxJkNoRfhcIz8RKok?=
 =?us-ascii?Q?GNpuVgi7r8kmn4hRH6FEbO9jiHKrV2TLQvcoNd5q19UE9VZU1a376tkeRnVX?=
 =?us-ascii?Q?SxoaQaLZszDeREe0O/Wxe7kgBORn/G1p3Yka4e2ssEa9xpfXLch9t0RddyUS?=
 =?us-ascii?Q?XOHhfTAoc+3YSy1SuRiOQOD3lkoeKg4954g1mkgAokf3pGbx+DXXbCwB/8JF?=
 =?us-ascii?Q?YGVMpKGcMg1kKTknmJQDmg5a/HmdGODUTf8i/WyjKKXIDwea0IY+rrXXCWZo?=
 =?us-ascii?Q?c/NQYa8MEA5QadHkOBeYZJVckMWRrMTcwthxT9vCocmhOiCnBbgE0GaCKluz?=
 =?us-ascii?Q?95qf5vnhWJu/9FYZhLg8OULDJIWP8MNdynLCtd1rUNYjSR4vT6C+LMG+IGSp?=
 =?us-ascii?Q?J6swKLAN6cVNxfiBsCKJ6Q3CXa/zFapTdHeee/N9ZGA+4ZuscCIv+N/zFsvB?=
 =?us-ascii?Q?4AEMZ9vdYGZTnmbkdbn53s0ED/Jf9kbGTPbfrgiI9sB149NxyOuoCEu+VLMX?=
 =?us-ascii?Q?stuBJzl67Rm+8Kxhm32cRqpRlj1iDZk+BdeBj+pNAFbCwiZFBp9GqQMhbnfI?=
 =?us-ascii?Q?+Uzu56NWQgXKyQ25tKzoFM1Z5B6JVCBfISVsrT1jtlUe33F2yPu7JVBHVssD?=
 =?us-ascii?Q?aDxtj6Nm8eLVEgSd637PK1olEVldmRqqygOy0LgA0ydPVgUsRDA6kq4ypwQm?=
 =?us-ascii?Q?J0Rnpm5+LigkBQIuCOXPgoShgO5RVaxm3553T0pb7Pqo3lnlnA70Lr7vffFr?=
 =?us-ascii?Q?H4xZnl4eR9JgScDQomT+XQFxNb0o3lxuvMA9dKZmizuTJurvEpD+HwAReMiK?=
 =?us-ascii?Q?LFhVOfZF4E1sxGeOe6xnkx+qCS33nbtKzcOcLUMO2Chlc5as9fPOh0QRd5Ik?=
 =?us-ascii?Q?VSqR0LJMQBsot76i9xwxJ4oCwm0bqg/lEsa7KiKBc//cNM/TmxT5rn0pStDe?=
 =?us-ascii?Q?7R16pRyv8lSyjttbZ4VBQ+3MEXZ2Qzh6xYNeDvUQxEmqXmuMnfruTgqSP6UR?=
 =?us-ascii?Q?viAMOV1mb8LgvYybIo17R3y4IHbW7FYI5JGb57EYgZ+VVocxyskiWC1keAr4?=
 =?us-ascii?Q?SaAy3ToOu8X8BlxIo2B8rUEMJEGYgYNiNsu05KcHlobhHm4JgxXNMX87d6Hc?=
 =?us-ascii?Q?sETgWdT23yYOKRunAwof6Psm7dSiRpmbpHTPP9xxZAzNdFbNWlMEo1jJs97w?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1fQYSlU6drH1SVzKi4KpbIcftVnjCY7FNUyZpwt3ZYXRUbPzYw39sm1a3QGs0IH+VZh8aibpkYTOIOyv8F74zj6hWaGgQeO4Hind5f5OKgifaPTN7u6QLRYSGEBN3YcslI+qFU9edImJg317bxEj5san2eGUeYvSMWhm9TF7qGzYmtzebQ7OcyxJ92hpksXBMC3qPFHnzIFQF/+ydP4GwkBgJXo6VRJfUlvU8PCOcxJhe6uPE4ha9feX+6dvlWrhJhSmxy6CU9rC+oGoZOalQUu6F6O4XBhYcw6vqy/rmEDDRJX2qI9cpyN20C44QUWrJFdV/VWzRP3Oalz00KyuypSMTQOKqjzXREWdpU4ZK4UUFF7XoM1oYLjV8pHHTML6JyJt0RGoPz49YWOvO+Nmc09G0gQyqqh4IxOO4JG6LxwgOe+EJt9TcTWQAJ7hwQMP2xoossc23QEPLDevutR3ZjUUSiOuV2Ibxa/fzZp/XbagbG+PelKq82SYUEE2wB2EvczH299UAUUZ5YN+Llu/M4xgRO1yBQgAY43aWHKFVsO/fmA48GBJKpP08fX6ObUp+cALBCWYaf2WreFqV08NQiYnIZtzKpXYrAem2313tDXzV0M2PRadLGKE/Fket3+VPY6oSIkC1C/p7QmhskMtRrFQAYa/GHoSTfTa/KS5ZdqgC+Ld2jp3mksHRuMdSOB/wQ9W/c89QvzYTmhls7nPqPFLijQdq2Zu72bLYhMuoPHuAuesXaFT4WbvM+DRnwZwUmkJhbYa16k8bsD5dCGId68xi7AUcP+u3u1kyDWM+/l7vwiN0PbBkRGtF5HdJVNZhrG4mMina/7Ra1yKodh5jMrjHe095Yg0LpRgquv1N8xT3qBNhy7wUK0Ysges6kzvM3IdbQxaPiGJbIaFZqVCXxJBgPe4Ln3oBFEWH+wtPb4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa70db6d-2356-4a60-a885-08db57affa89
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:55:53.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4ytq9wxpB+MLhhBlNYMq/zz5aZ3dCyPKWfrYMZMW/pvt7RmzzSns1TR5oaKxPJMpTNBuVkSkT/DC7L6/4rdqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: 2-EBsmM22HTK43Mc7VoOyHEq5PY1Ov6m
X-Proofpoint-ORIG-GUID: 2-EBsmM22HTK43Mc7VoOyHEq5PY1Ov6m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mas_parent_enum() is a simple wrapper for mte_parent_enum() which is
only called from that wrapper.  Remove the wrapper and inline
mte_parent_enum() into mas_parent_enum().

At the same time, clean up the bit masking of the root pointer since it
cannot be set by the time the bit masking occurs.  Change the check on
the root bit to a WARN_ON(), and fix the verification code to not
trigger the WARN_ON() before checking if the node is root.

Align the name to mas_parent_type() since mas_node_type() exists
already.

Reported-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/maple_tree.c | 50 +++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9cf4fca42310..555de3a8343e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -425,28 +425,26 @@ static inline unsigned long mte_parent_slot_mask(unsigned long parent)
 }
 
 /*
- * mas_parent_enum() - Return the maple_type of the parent from the stored
+ * mas_parent_type() - Return the maple_type of the parent from the stored
  * parent type.
  * @mas: The maple state
- * @node: The maple_enode to extract the parent's enum
+ * @enode: The maple_enode to extract the parent's enum
  * Return: The node->parent maple_type
  */
 static inline
-enum maple_type mte_parent_enum(struct maple_enode *p_enode,
-				struct maple_tree *mt)
+enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
 {
 	unsigned long p_type;
 
-	p_type = (unsigned long)p_enode;
-	if (p_type & MAPLE_PARENT_ROOT)
-		return 0; /* Validated in the caller. */
+	p_type = (unsigned long)mte_to_node(enode)->parent;
+	if (WARN_ON(p_type & MAPLE_PARENT_ROOT))
+		return 0;
 
 	p_type &= MAPLE_NODE_MASK;
-	p_type = p_type & ~(MAPLE_PARENT_ROOT | mte_parent_slot_mask(p_type));
-
+	p_type &= ~mte_parent_slot_mask(p_type);
 	switch (p_type) {
 	case MAPLE_PARENT_RANGE64: /* or MAPLE_PARENT_ARANGE64 */
-		if (mt_is_alloc(mt))
+		if (mt_is_alloc(mas->tree))
 			return maple_arange_64;
 		return maple_range_64;
 	}
@@ -454,12 +452,6 @@ enum maple_type mte_parent_enum(struct maple_enode *p_enode,
 	return 0;
 }
 
-static inline
-enum maple_type mas_parent_enum(struct ma_state *mas, struct maple_enode *enode)
-{
-	return mte_parent_enum(ma_enode_ptr(mte_to_node(enode)->parent), mas->tree);
-}
-
 /*
  * mte_set_parent() - Set the parent node and encode the slot
  * @enode: The encoded maple node.
@@ -1123,7 +1115,7 @@ static int mas_ascend(struct ma_state *mas)
 	p_node = mte_parent(mas->node);
 	if (unlikely(a_node == p_node))
 		return 1;
-	a_type = mas_parent_enum(mas, mas->node);
+	a_type = mas_parent_type(mas, mas->node);
 	offset = mte_parent_slot(mas->node);
 	a_enode = mt_mk_node(p_node, a_type);
 
@@ -1144,7 +1136,7 @@ static int mas_ascend(struct ma_state *mas)
 	max = ULONG_MAX;
 	do {
 		p_enode = a_enode;
-		a_type = mas_parent_enum(mas, p_enode);
+		a_type = mas_parent_type(mas, p_enode);
 		a_node = mte_parent(p_enode);
 		a_slot = mte_parent_slot(p_enode);
 		a_enode = mt_mk_node(a_node, a_type);
@@ -1659,7 +1651,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 	enum maple_type pmt;
 
 	pnode = mte_parent(mas->node);
-	pmt = mas_parent_enum(mas, mas->node);
+	pmt = mas_parent_type(mas, mas->node);
 	penode = mt_mk_node(pnode, pmt);
 	pgaps = ma_gaps(pnode, pmt);
 
@@ -1691,7 +1683,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 
 	/* Go to the parent node. */
 	pnode = mte_parent(penode);
-	pmt = mas_parent_enum(mas, penode);
+	pmt = mas_parent_type(mas, penode);
 	pgaps = ma_gaps(pnode, pmt);
 	offset = mte_parent_slot(penode);
 	penode = mt_mk_node(pnode, pmt);
@@ -1718,7 +1710,7 @@ static inline void mas_update_gap(struct ma_state *mas)
 
 	pslot = mte_parent_slot(mas->node);
 	p_gap = ma_gaps(mte_parent(mas->node),
-			mas_parent_enum(mas, mas->node))[pslot];
+			mas_parent_type(mas, mas->node))[pslot];
 
 	if (p_gap != max_gap)
 		mas_parent_gap(mas, pslot, max_gap);
@@ -1767,7 +1759,7 @@ static inline void mas_replace(struct ma_state *mas, bool advanced)
 	} else {
 		offset = mte_parent_slot(mas->node);
 		slots = ma_slots(mte_parent(mas->node),
-				 mas_parent_enum(mas, mas->node));
+				 mas_parent_type(mas, mas->node));
 		old_enode = mas_slot_locked(mas, slots, offset);
 	}
 
@@ -3251,7 +3243,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 	l_mas.max = l_pivs[split];
 	mas->min = l_mas.max + 1;
 	eparent = mt_mk_node(mte_parent(l_mas.node),
-			     mas_parent_enum(&l_mas, l_mas.node));
+			     mas_parent_type(&l_mas, l_mas.node));
 	tmp += end;
 	if (!in_rcu) {
 		unsigned char max_p = mt_pivots[mt];
@@ -3294,7 +3286,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 
 	/* replace parent. */
 	offset = mte_parent_slot(mas->node);
-	mt = mas_parent_enum(&l_mas, l_mas.node);
+	mt = mas_parent_type(&l_mas, l_mas.node);
 	parent = mas_pop_node(mas);
 	slots = ma_slots(parent, mt);
 	pivs = ma_pivots(parent, mt);
@@ -6995,27 +6987,29 @@ static void mas_validate_gaps(struct ma_state *mas)
 	p_slot = mte_parent_slot(mas->node);
 	p_mn = mte_parent(mte);
 	MT_BUG_ON(mas->tree, max_gap > mas->max);
-	if (ma_gaps(p_mn, mas_parent_enum(mas, mte))[p_slot] != max_gap) {
+	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
 		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
 		mt_dump(mas->tree);
 	}
 
 	MT_BUG_ON(mas->tree,
-		  ma_gaps(p_mn, mas_parent_enum(mas, mte))[p_slot] != max_gap);
+		  ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap);
 }
 
 static void mas_validate_parent_slot(struct ma_state *mas)
 {
 	struct maple_node *parent;
 	struct maple_enode *node;
-	enum maple_type p_type = mas_parent_enum(mas, mas->node);
-	unsigned char p_slot = mte_parent_slot(mas->node);
+	enum maple_type p_type;
+	unsigned char p_slot;
 	void __rcu **slots;
 	int i;
 
 	if (mte_is_root(mas->node))
 		return;
 
+	p_slot = mte_parent_slot(mas->node);
+	p_type = mas_parent_type(mas, mas->node);
 	parent = mte_parent(mas->node);
 	slots = ma_slots(parent, p_type);
 	MT_BUG_ON(mas->tree, mas_mn(mas) == parent);
-- 
2.39.2

