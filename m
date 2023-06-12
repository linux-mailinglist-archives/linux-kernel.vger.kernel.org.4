Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADE272D0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjFLUlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjFLUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A6D199A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:52 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKO0Kn029029;
        Mon, 12 Jun 2023 20:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=MRxZ2xtmGClbLJvupzZ1eM+6XTaXbG4AfbEc1W++zXY=;
 b=IcNf5Sri9Af1Pp52MpQ8lLNnONoBu6JG9O2rPdKKX2uX0qP9/2H3tnUpMi/dkSNaa4yP
 ykSYJN+aK8bTps2pWNpuvP5eflrw1gBASflbW3J9oS9Z3hiQDkdfekOZixh1Sh+JY1Xe
 9YXLSnIQxMU4khmSdNyg8QOAPjWgNlGwtKtpEGFlu1ar0J7wwknxJ2Gwvk3xg5+85Lq4
 IpXuPiFzkh81TEuo108/HyDdNrPb3D7KaQ5b/oYQ4tt78RJscDx3vhHdiXxAdZvuCqV5
 mV/Gk5JUg25ENrdpsA2qBMk3o73aRV64T5Tg6rfX0xczqGfk+QAiRwEolH+WLYorrIfK kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bkxay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKHDrC021578;
        Mon, 12 Jun 2023 20:40:36 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm39c0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcimoHmlH+Eu47TlTCKaKe7YwbDPRoy8/apVgmpA0luVYEWmBjW3Ak+EDFPLCpRWZ8hkR8ofDk1T4d9gB+Kxd8/4fPVNKr6NqUggd5MK1Mb1y8wO6tzIjgP54yVPm9BCjNVDtuqgRcwVBzHHU9WjghYB/NhCJs2HLSDAQeZ88eu7Hbov4RLTfBAmqrN6vTQO1XzGjzpCYc2FZYSKX+NXT8uubn/W2S5y5vvzo+sFPL1phbz2DEuFhZpa5UEr/RfSY0ztiT15EtBKiZg41D+WjTaD6Ll1hy1v4pVHlyftaN/SijanjhJc3EWc5RuGi2ZgDdtHm40l5nqlQI8WUIC7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRxZ2xtmGClbLJvupzZ1eM+6XTaXbG4AfbEc1W++zXY=;
 b=aj8DzMftMhWM2TnwRhlowl8FyKT/MIcT3BMnbiI6fsSAsFSvZzmCJKmHN6iWWnCLPNeIctOs7gyhgxvWpiElg2OGN47lh1+uQ6/+gXo5bdwYexDfk9FgWOq7+8LTXzoVTZWjRq6buMUpwjJA4v03JYyo6PJi9r7wqLKs9WCUGlxvL8QbVSZ2STiIQzm4Xw+6gYicPXhQTRwMhfnpx5PcBVOKLIliB2VvJv4uXN9pomhCVrKNwrNaa1F8mVBF+1tADxXBblO/gseSDKBKw3tVh1X1la1P/vyK1R84XfnDbR5gFQn0mkDEBQ3yXflgpVK5/Sfa59kQqvN+mwU1nE2JNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRxZ2xtmGClbLJvupzZ1eM+6XTaXbG4AfbEc1W++zXY=;
 b=epbrl1ZxPBDqkw9C7c9lwRwMxCHZ/b4IPFxhPGmTRwoFH4WgNc8PjAkdl000dnpui0ucFaN/WZFrIUFPaK4dQ8r3iKdhUFfTr18l/PvCIBOzU/+OF4xjwJDOYPiY7XmSYjDeN/vuBiubUk2HxxM7JspgGZ5y/yuYbazFFbZxz6M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:33 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 13/16] maple_tree: Update mas_preallocate() testing
Date:   Mon, 12 Jun 2023 16:39:50 -0400
Message-Id: <20230612203953.2093911-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0459.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5a48c0-6f83-46c0-09cd-08db6b8544e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTnRWMa10E//Wi8VKbRnnGkbaj0JZuu0gAyfz0ZqCIAc+YZUSf98zEumXAnTygNMOY0Uljs9wUyNHHu7tQbNl7xY03PpHdaA3xugZVW6e/e8M61DGb4x2ipj8Zjn6LXUqqbheqKAlxvLIthIz6WY+vVugBn3RUyCxdl5szTBO9UYTfqn7wjzgLa0sSP9xW+pQvNAnwcXGtum7U5X2B19EEqXw2t7ITTvSBAk0cQorM4CSEs9o8DWkpGXweDZO7gIgdsXDyJoPym3e5F0WGD1m7L8LTlP+rkJbiNTGBpOlCSmvHJOPKSxKQs1uLIqzDgBcxmnTWVH3EiTIrla8d1lloLJK6rafclhnAykKAy43hu/1x4KG/3lxsZlQPHWfIWxk3i4OygjbLDaKX5XuYJiF4xYY5lzrHaDxoY6UEI+H3w2gy93ygojBDD6UY0IuOOcWxsN1Qbrcjlq6mQNgEFw2hbv9dPGXGdKum65Q81Bk3aLnKaAxsbqFlgi6xexnJjRUWHsOrO6zPuqBXnOrcC+CjdLnnp326ARoNwYk4UXOmGz+nmrRQdh5F5IYs7LzApl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(2906002)(41300700001)(6666004)(478600001)(6486002)(6506007)(26005)(1076003)(107886003)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JVvSnXGbvrE98OH3ILkMsiMjD/w36J5v5DU/iMTJ3Fj/orOsVBagVvnqRND+?=
 =?us-ascii?Q?D1lw+r6aLwkXVQsxclzr2adlQ9AhPvU+LxO8i2giOzC6JuHTRObwQB6eZOSk?=
 =?us-ascii?Q?M0XxN4iUVW2vksig93BZWzODMLqQp2xMe5876MTTmlEGpSKC50BPn6OrT2NN?=
 =?us-ascii?Q?81yN/2Q7zcOLA9tCOmbilsHmHX6/En/NiFnPvoOOHoTrCuPvXEJ4CzmGle4T?=
 =?us-ascii?Q?fybSrihr1r7Z6lDzYQMrC6mVK7W3Tjfesci2r/JYmc7rhIzKXldfm+nlA24R?=
 =?us-ascii?Q?85fb/0UJ1XyOPwZIzDIKRvHgF0VYLCUwOaspMvKaU5DwEef3uYPeuIzlvGt4?=
 =?us-ascii?Q?lO1Q6R1eMWDDDqdZ7AKnkIbgOzhDWvctsZBnHnDCd8AP2LrLdED7MMbiiw87?=
 =?us-ascii?Q?/37rx1sEOU0SNsrAcuLboHUcuf+QYTFGxoQDmGzWRucx2826Hm7nDqWK+SWm?=
 =?us-ascii?Q?I/WlIIno/hNpkSZTEDk2mHgaZlgJWb5pfXHJp2W2DU9jGladLOEVix0qlNb4?=
 =?us-ascii?Q?wsl5VHQY2PiDU9+MFhfKWHjeNx88DbS+viHKVbsGv4mwqu3teSqTFwZvAVCf?=
 =?us-ascii?Q?L3n+JT6eM3fmAfhN6Cb8t1cVXSbVvrX6dEFpZtxtU+zr+7OdQtbEs9biS2bk?=
 =?us-ascii?Q?AFj0dhbIZsaJGpLUEVPJr596klTyF74wtUpFCeu3pVs1e6T0pp6niOflgeXj?=
 =?us-ascii?Q?fj+FqzmXM+IjqNv/a0swNvb4LQGgULhoV/flMTDtcuWHhjmP/qqQ2gwder9Y?=
 =?us-ascii?Q?NhGSSBNTgjexzLfunisTYazflsBy26r5ErG/RdWARrt962Dt3frxvycKA59I?=
 =?us-ascii?Q?eBZDiwSlV3HA2erqmbjn2nj3p8ydEmQgsEZvAEWPZ4KJmOx/19T0IcY+7mIf?=
 =?us-ascii?Q?Bg3pEyNA9XjCyVa0DZncv4b3gI8UrfpjngKnbQBNbQpqvhEQ2XSE4atazq6V?=
 =?us-ascii?Q?kK+k0rT/y0zwKZn2SUol7C+QwRjEXIR5XCcT9/BZsUek8U8D/h4AisRnJ/ST?=
 =?us-ascii?Q?Ld+x98JLmNSYv9Oxg2i7cZ4kyCejZv09nCSddoBvfT86hPSUz5m1ONVIsjkv?=
 =?us-ascii?Q?SMzc33H4t5P/2krJ97iqMxnPAOrBkyBwZxleczVoiSBwKcnVEBK2ey/awx4Y?=
 =?us-ascii?Q?xeINOKM5/i7i/g8F0dcCBgoMljJbboXy13wPPtE57VsRdwO348qorz6Kp4Zl?=
 =?us-ascii?Q?SmRpfkQnH8kKjDQzj9YWjzkO5Db77vdz8FVQdj9rZhWlw8IerV8urVTHLcYk?=
 =?us-ascii?Q?GYV2VzGgpmX5HimS+ISp0zU3q3tC7q/eXYWDVJidLTuIsPG5dM4EuxTZu8Yk?=
 =?us-ascii?Q?LYWcP55LgkJwG9xgr5BhyoPdeOlsKTZbVCMVQ7ZNxJJaBryaSfxfJ/LDaC9U?=
 =?us-ascii?Q?251nrJfNhVhMXKvwZvc7lXOl3RVREn4ElfFghC9ivvqxJHBtzrdnwj7AThXX?=
 =?us-ascii?Q?994mGi0WGFVCNE73Yebz4Lz+xTZ+zxZ70wAAVn66bqBBBTzooPQbEGWYfxSB?=
 =?us-ascii?Q?vLVi05aRETD4+RxSOcRL5jcyIdy99ZsEmOUbodbp0W8dmFWjQqoxmDFahtJK?=
 =?us-ascii?Q?sOug6GjvDu+AAjsUFeVZLOrt39Mpmk5Ih7NCVlIVmTs0vP3hSD1bF25mypfY?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HvCrmC4BmhNSk3U3ZQz4VSirFvSqp4b4SmQm+NUz0R1YDmF0qZSVPmTFeBn5?=
 =?us-ascii?Q?Dibz4PiW2VgqREqaF88FraIeY2pRqbHCCVGNXIxa+O+T9F/HBOgwPvaxvrtO?=
 =?us-ascii?Q?17Jf32C/24l+7qKQB3vD9CGbmosLD+WVfRUfCsjLcuYXGl3GrOhJbpOTy9t3?=
 =?us-ascii?Q?RXlFei6Jq/qV+Tr9t9dvBPHvWLFk6Uqmkmltdnjmlg8xEvHQwlrXEFQZ9dZm?=
 =?us-ascii?Q?HkffCkuOjix0A+po7mEeNBxvRXikgqxnHsoiO+nrrKYzqsvzoNdAKKQ8aaMb?=
 =?us-ascii?Q?d3FH+glvB7xKVF8IPuESyyOtt223xHnipcpxhAACo5q37OZcQVRl+5DCoZIV?=
 =?us-ascii?Q?PfokF5ZjZZDtFzr2Q43Oa23i0+1mN38HBXqLbkIByP3rvQQvDBFvy5P5IPOM?=
 =?us-ascii?Q?d/46rw3lDwQQo9DB4WUI1401FAWWdWtiV1eHu6VsD92V/ojdV4KgKpqhTbWy?=
 =?us-ascii?Q?CSFtyT+eLt66XLhRPGvX4ZjyeiwGBV5NAet6/mbit2tQuLGJUd7OooAq33RA?=
 =?us-ascii?Q?Fz4fsQwz2rbLAjax965BVwPOWgxWfnzRMlUmt+p0jclEKXXThDgO6MrJba36?=
 =?us-ascii?Q?lKlJA03I7jsp3Rqnbl9DmFiEVgUHSOfyHx4gNxAeu09IoEkCRo3HUO2PnBT1?=
 =?us-ascii?Q?7sgO5k6IpmKmiNXTlTmyLPLPR3C3ud4Vaarl4jOeLpMjNYvJVZsSm1TLBYoM?=
 =?us-ascii?Q?brpZaCzdYS7h0EW1QExg1BSCJl3KegtiPduxuTvGuz441K8BosWM/bPk1oS+?=
 =?us-ascii?Q?GDH2WXj5U+hj9A0+Sb5Vag2nLvXVq4ECF2gjVzceq+bGoWbvzRysPb94AiVu?=
 =?us-ascii?Q?3tsEGqBXP7oN0rriBhaKQeyI0PNmQcEewHE1+Oc9+LOqwkk3/GMqIDoNjnEL?=
 =?us-ascii?Q?cFbvTTm5wKqlPBNpke3i/zkXXNJ43bZcvj/0N/n6Ydn7JwLrQIrb2shU+euL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5a48c0-6f83-46c0-09cd-08db6b8544e4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:33.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbRcOS0++mY6wySA/HWvJf11Z9U7xpmOHVk4S0xFYiFp3iCr1EiqGf7NJOc5qLyB+RiHjV/TxanwxqLHz40U0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120176
X-Proofpoint-ORIG-GUID: x4PoJTAPY4JeOCEGCA8KeiuUAXZZJjOf
X-Proofpoint-GUID: x4PoJTAPY4JeOCEGCA8KeiuUAXZZJjOf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/maple.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index cfadc4b75d51..c42033172276 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35383,6 +35383,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	for (i = 0; i <= max; i++)
 		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
 
+	/* Spanning store */
+	mas_set_range(&mas, 470, 500);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
@@ -35406,7 +35408,6 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
@@ -35420,7 +35421,6 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
@@ -35434,7 +35434,6 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
@@ -35448,33 +35447,37 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
+	/* Slot store does not need allocations */
+	mas_set_range(&mas, 6, 9);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
-	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 0);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
+
+	mas_set_range(&mas, 6, 10);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 0);
 	mas_store_prealloc(&mas, ptr);
+	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
+	/* Split */
+	mas_set_range(&mas, 54, 54);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 1 + height * 2);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
+	/* Spanning store */
+	mas_set_range(&mas, 1, 100);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
@@ -35482,6 +35485,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mas_destroy(&mas);
 
 
+	/* Spanning store */
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
@@ -35489,6 +35493,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
+	mas_set_range(&mas, 0, 200);
 	mt_set_non_kernel(1);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
-- 
2.39.2

