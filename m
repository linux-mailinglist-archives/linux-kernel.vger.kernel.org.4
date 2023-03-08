Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB06B1248
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCHTot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCHToQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:44:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C2CBAD24;
        Wed,  8 Mar 2023 11:43:57 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiBj5009956;
        Wed, 8 Mar 2023 19:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=7pB/7fGSKXZ512htikMUhhn4WInoL7P60vqlVgQFOl4=;
 b=Cc8ke5qN4r85x17qS6/wICWNMv64fLn6ixTSsqhYfToCoAWci3sj3rbTjZab73Kku7iN
 nysXLI4kmJDMp79zUDz6f5Jm2M24tn6kpDhdOFArePid4EPgTC+ULC61Vx96QILPXglt
 5U9GcqwJQ5lw7LJMhXcb7OIsAo9AtzpMDhrH2/Wcq54UJbJWdZnCycoIJKj/iSgyDjtp
 84RcNad/zTcAxxiTljpybe2HpD4YpWfC3XgY8vkS9J7fKomlh6iTvLUNvAhJEqyWtbtF
 da05rxdiKJsmoiOurJrAPI086uOC++Am+bJpL4aBfDBvGeaSTpdI9HyBhyYXpeYVMB9v AA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4168s2ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328IMj9e036506;
        Wed, 8 Mar 2023 19:43:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g45y02v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bibo/OmQkm0FXtznAnOjcDGSaWfDAOrkt1Se2zBZQwyst+iVhoNAbdnaDlxnfSolDVebQIxaUKMqcjNXxkDxvo2XwSQzPVpgFt4PWVUu19gI0wrbyR2ESPx5EYLJmkV/KOpghM9UdqR95OAo3fTT5rykWNS2gmTyvT3m3I1O4FW8pEwl+SoVy3ORKXy2aAndmHaZby6eFesxhhHGvK1jK9d8XbsqGzhhIN1D/ty7cgMLZ/nKRg0403yzAHcnJlqJ3k1kQ7iRlgZTvgtHJH2b0o0WFh8ONf5CkE058/HL0EjKkoOWsRDT6f2KkM2Wf9xMa2BfsMpzKqadDc6D2hkzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pB/7fGSKXZ512htikMUhhn4WInoL7P60vqlVgQFOl4=;
 b=HXGmarwY+SY9Kv6SjQUuTH078FqU58HdzKtFpt2+m6VewOOk/PqSxfS3JaI106U70gfR1mVRRwxkUMNnYli4rd6EaNkkH0O9/tcme3FWCGnGTmRmv0VOGqxh5fzHh9oO/Xfbcgqhu3L3hOkFUe6jyLcW+BO829G5SNT6ETWaF/mW4PtTHDIyg+iFLAnCzLUX+aC9uyBSX0e4e+NIQbBKA2EqEPXIVzMMA6NRO63hJVJ4z64Iizvs7Ej2/XCU/CtiJ0GD/cZ/EqN9Vxf0Hm2Voupgd5+CevuVYfS2XD9oP6756qlJI/akGIGeytaXDTWhkt1Wd1ft911YtGfuemuZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pB/7fGSKXZ512htikMUhhn4WInoL7P60vqlVgQFOl4=;
 b=RSvDo6wg9hI0mp7HnNAHsZ3z/3HzJ94dualR2lavJkjk+ekAOlFUZn+QKwaXxd/C49MrOqy9c3abdg1nmOeOO7/faVPEYameX2P9y4N5s+KC+MKXCvZ6I1qVS7igQNIW5Jv4ks/oEu++vIwNAOY6j30YoFXXmETHqVgQM6dT2UA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 19:43:52 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:43:52 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/18] mfd: 88pm860x: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:42:58 +0000
Message-Id: <20230308194307.374789-9-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0504.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::11) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: da409113-7ada-4e0d-dbf0-08db200d71f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKT04ZAnPT8n7gTmINLbq3J54SnCr7Ir/Grgz2dDbWYed8v9TpPDvK+rAnu2BA9sQwaGGjeW4jwxtwwJRZCM4nv9ohDqqkeRCuunVQV8sfmri90qEvdKX08MM6zeEk51zvjADFTSW1MexNHCq0BFM52eaYqLAHKzyGJCEaOOgTz3wHXbNEja4W10sD05v/KaN0leMPQUP3nvPfYTG3LHU4owr8Jy4Y3lrtfy7Ir1yNXLj3FogQT161Cr18hrWHIiB5qtlEYI017kEeNhZyNuuaaKbd46ulw3Y412Z6pbOVJBVnMljptVaTrQ+3kaLv4TSt0E6Oc+ep+8HHABwLsxDHELkV88QHygS96NCfF7rudjI6TCSkekzCFRc2IrYr7X5GqIqBPLPmGrPmJYpXOP1sF/U+y+07bzA4erBMTMYp0OtBQm99OGdmpFcG7H5XNGN0xrsz36S7ESp5m32qV6u9eA3mpnevyjDtmUM3c5xf6+BffRaQw3yyJ59JLjE8NZ+dQedZGa/Qqz7kJ+66K6z81HOSz8A5Xm4Fl+gdhvLN+vqSAtW2SLPpldeLLiYUisSil13sBPtDiYTuWXnH2Ay/hbhPj5R/UNLk4h+NcArzKT1KFzl8JCy13QvowgolSrOpGYE/Kg9/6Hyqk9G5Y14w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199018)(6512007)(2616005)(316002)(36756003)(478600001)(1076003)(6506007)(66476007)(6916009)(66946007)(4326008)(2906002)(66556008)(38100700002)(8676002)(41300700001)(86362001)(8936002)(44832011)(83380400001)(186003)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+R8yiZ9wnCzt0QldwdcLcOxk13kmKm3J0sKgzxOKwVLrcynkCkirlycGLplp?=
 =?us-ascii?Q?yNCP52kdYsXn+gZ+Ky6fXixmrDs5JlwfZ9bhJaBy26fWKjwjy5imUltsIfbZ?=
 =?us-ascii?Q?NFgFfWvumPfmPS/jfF9FOIIEkCXGoRH1uIehS4MUQYmXMMPEOwlB16g9qKee?=
 =?us-ascii?Q?jEKms8DKujKJ0Koiohw7oViWsJhzUrPTTWhQkIvwQzPtD4SE9SBp9N3Mps3l?=
 =?us-ascii?Q?l0q7HMQbZlh0XbtqlBFfkJDvXM+3iPwIBxI7vSTlk7MRgRHTt/2heEQjdJpJ?=
 =?us-ascii?Q?jrLBfLG4c1Mu3ziOqpJGzI6lzf0X8Tm28HlJ5UXcINCvcphFE0XJrlpXxWS+?=
 =?us-ascii?Q?thaboD/zXG//eN/bazJqFsgNf+9JM92jq7OcWKe5hnRv1e1bg12RWZZgyE8Q?=
 =?us-ascii?Q?7m6toCWIiICoDqyiY2H7X87oqlyU61jGxxTIspQ8uXr+3JD6sC8sJ3xqYTCm?=
 =?us-ascii?Q?mVrArHu/UiIou7UuejQsAYussi2JOT65mRhu6HHapTBfs8be2XudWSjQmlNe?=
 =?us-ascii?Q?cCsdm+uIA3tKKDREQf8kTL11kBVHJ9uZVEto/tzk5in69WoxiNvjNciHpdeM?=
 =?us-ascii?Q?hwHpVHd4S2zUa0LPbGnX4+kUinDw/oGcUTFZZcU0yjgximdUNplZL3xABO+V?=
 =?us-ascii?Q?B74o1ris/yegkyJoeC02Fa/0GThoAPzbJidMaM2yKj/0524wuYYmx+5riW/S?=
 =?us-ascii?Q?Jvs8rag3FTTyWHeYZvq+o+OKSOkM/HyBLFzl4TQRizg6ZUBhfbGZEmuza7gr?=
 =?us-ascii?Q?MXowh1iemUQ+R/xYPFDDjwWIsMQBtcUVuxafKXBXHD1uYNRxiQnxddvjrBER?=
 =?us-ascii?Q?TqPUMrAOGhblh6eywfDbe/uH3xTXAcJZ6PV1Qh8w8mGTAXHNOrrwlUF3N/Iv?=
 =?us-ascii?Q?RqUIh0r4DH5XAf/h7WMBgmrOz/U0ekgDBCjeKDMUEemm1jASPGU+pFjpvXSY?=
 =?us-ascii?Q?+xXnIs3G2q66qntr2lDI3qJe3RKoassNRzatAiz1Ha7hdOf24lZgBeIezok+?=
 =?us-ascii?Q?/MjBMg2npBGzT+4eKbPqa34uCQu5boGevfXYhrZtQpTbYOgFQpcgfi1K1Xdj?=
 =?us-ascii?Q?ReqbdBVqn7PUINNSvSxBWxziVcelLZSbI57FsbmlejeDBZNdWMCuQxsSyMIw?=
 =?us-ascii?Q?ai8v9zZ58B7TOGQY22LmPFbk75LP89vy0XRU8xeicw/5nDeNtjm+wMz8t/Kq?=
 =?us-ascii?Q?4bdtA2nLpJxlDXTdD74wLS7jRh3sgVUzUySj1YOMBe0qWrnmpOBZ+27VwyBN?=
 =?us-ascii?Q?SytTuv2sU5+chTxLFkUqW8H7X/7lhreFicnNao8MNT91P+Vxl8hPa7PIqd7h?=
 =?us-ascii?Q?EZmvdpT11XMQLyFn8W9XasFV9RkksfqOu8Mtw8SlmipG9NSl/Pg5seW7dV1e?=
 =?us-ascii?Q?A5ybIrNcVhGjOhUrcKhEoM8IB8e9IwOlRBUJ/PJgQ5epNNtPzQwKgAV1V748?=
 =?us-ascii?Q?DRMXMlBXW3tmtDhAmoU9+8F30Lh1PXYt+6E7L2WohO5p/W6ag8kg+bV7yJ+j?=
 =?us-ascii?Q?FZeIFeqpdH9u+UURWUmF7Maa+Ba0Pwl6s30Pis3dOwRl1MqP0AukwAlNK6A7?=
 =?us-ascii?Q?Ig8DUKbUKp7l0K6MQuofrEeajhY8V76qCrELjHfWCPf7tz3jmHZkxEiEwQvt?=
 =?us-ascii?Q?pLCYViSKMBeDL2QzfBlNP4w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: maquJ6LrWoUbl1jiRrooVgDmeiQFI8kRd2y/a5jXwFMm8+SA2ocJ6PVofSIGh6TI0EAnnQztvEbZTczJzmXifv6sqz4T9O08xnQCrMfCPTrCkUauzqKBU8T0erZcQFHAktIkAqdBYGenAhWb89YMk38DQGP4XImXL7MZcFd1FMXZ81t+MJ7oN2zQtAGiqorG+GXlr3N8t49c4ZSA1hQD4mFeG6MDA+vZA3EXsUyAUJxDOzZpWKLC7YNOQogjnspLPe+GCanO/zwum5nsDp6Vrt9tE0bp+LcSxXzXEo11tyiNsIDJ61+V/jpNviAesGX36PAJoFX8LObmMWUGIJrzEDZ4uBsI52iQpDdeNFW1kzW/80QS0PVY8p9kcxFzD1rbSljkoP6wGUBsGYRaaygIkepLYZbuwQ7ZBTvGH8OFZXiExSI5Mx5cJPlZhjux1EI3DWlyqdg9pfJ7eZo76Tv3T/VjDILcY3vkFUU7zz4y+D54ge8/29DVXdG7v5bvIGKIZnpTEh8wp3ErGvud/klw3LQkuE4MKsWDsbd2Aj39s8c2tqSbipeCJlvWyejn3sWB5Lk/niCloRe8Uu4WGQGkzJ46ijcRwTGpI4qyPtUlhL0MfqOcGe+A5R7UgOYLcuT4+PbzeqaCIaR9+e2ab7QQGZuGp4Cf0qLezgqvB/QkDTt1lA/Pv9hrcKelObsDvaPIOypLVHdEfLP5paXOAqnIXrDkCB8+sQvWAjkwjkZPI9R+IHPNvfpnyNzL+tTsHIfTdiM1zBQHwnhG8FUtCWIbnTKprvEMDlT/UKNQBUT2iOg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da409113-7ada-4e0d-dbf0-08db200d71f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:43:52.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ythPh7ia6g+bVv1HKp87NtQ8zua4V+VcR54XehqL8/HDMSu9s5dC8oIr6Q2zgTrUjQgwXq85XpBnfgcsOduow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: O03Qt7gvtUudxZe9AtoOb7BQzAJNG1aw
X-Proofpoint-ORIG-GUID: O03Qt7gvtUudxZe9AtoOb7BQzAJNG1aw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/88pm860x-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 6ba7169cb953a..3c57e537d57fb 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1276,4 +1276,3 @@ module_exit(pm860x_i2c_exit);
 
 MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM860x");
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

