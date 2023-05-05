Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A76F87E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjEERqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjEERpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:45:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AC31D94E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhK1k014772;
        Fri, 5 May 2023 17:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=7MLcv1G8LkaXK+scWyvzIEbLLyWLzRFzfze5eok9DRY=;
 b=IK4PLajCpJL91RsHVIlHBl4U0yo7jk6WT55K2/ajXC3jCsnFKABSxVwaDdTLB4TMgBG9
 C1Wj/pF84nyxJBoUXeXUWsb9La3k7+5JkkEQOWXIpLVwsSa8By2lTw+LdA5BzwSjYdgQ
 r2rk83gH7zBNbQUsGxsAe00qx0cRjuG14fg3q4PY0Y/DDXUvHcPlpFCe+mJ2i62YAwb+
 zxPaEZ5wT+O369WKx3BYLCBspCCUEgTIkYru2/V3GBaO7VURetSOyloZZow7bA+5RmmD
 gjv12OOTO6CFWCy35gsc4v1lWSmxLSYQ13RkEXTTiRSSiT5FOr1aW3ormOs79krFlIEW IA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sneddyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345GjJFG027445;
        Fri, 5 May 2023 17:44:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgetgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe4kzE00OXGSPcKOLb0oyx2IzfGyCRInMHugbYBC6zQAoyHg6mGkl+pTa953gyKjKFm8glzkMVNPq9MuOtTpssSA63KcSOh5KWf+13L+6APU6oj3/8kEKlFQ7zn2GVnPdWHJUYCMbzof6I+9+TTgLIa/GkhX4EgYufIIa0uBaXP/EemnTivA22Bz8FZiAaeudjDzbrQUscjYAUm+TKOTExyNfeiUqRJRbX2Ab0RzBNigF/fAowWNcWEW+fcpU3p+6DUTPkHtN6Yxav+UVyHs4CdRdx1a+Ancqqg7cKYwuaaPLnKfLC4pSPbmHeG2ZZt6BM347wtPQXK+yUsu+XWing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MLcv1G8LkaXK+scWyvzIEbLLyWLzRFzfze5eok9DRY=;
 b=g9yQonYfMQDhlbbUN9asWRGs7qFbPUGsqslGUs7ZJQhK1mI3dMcl5AO/WcA8CJeTnoBf4q8E95KZ2Rf/QsbVpdigSq/Vds4hdDLVE8DOrkWHgCfPsJZx8i0AIEQlzKJgvPiAMk2lXjbsZOviHqFa94zRUu8Z8QH+667nLpJxoXVb6z3K5YDIhmfx7aghMgjk0wbARuWD7XZGgSBstJO5UBjo0wAx3YMGIFM0zSNj2rxwBS/DvJTCo3oT8ONFwFkmgeS2VDToep/W7hRLTD3BU6FKmAzH8hfx8ayZGuto1BuCYt4/Eh83LRkBnOhGR1Fv/1MWbcyWPULKkBAsZfO1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MLcv1G8LkaXK+scWyvzIEbLLyWLzRFzfze5eok9DRY=;
 b=iWsfLkWzSbo3RaijkPv3emGWAGcOiTXiVYrezna96yWAnmnn3QyB4mhFJqJVu3ZxlBneiNI9P5Mo/3V0om/bW9W4u2dRtkqELDFQRqWi9Xs6BzKQYlV5A8BLMGq51XPN5G/1bXFLbZ+87uqtps+KSUx8jX8tHU9hm4R3+UO4hSA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:23 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 17/36] mm: Update validate_mm() to use vma iterator
Date:   Fri,  5 May 2023 13:41:45 -0400
Message-Id: <20230505174204.2665599-18-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0372.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 985bd068-71f0-4c64-4d33-08db4d905cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzPugKicla7cEoEzG6NWd3pAAbfKx2whgZT4op6dxqCBp2xojaMw5//VcglPbBrp/MYQ6M6plR6nc7vVbuwwOqvuPwhZ0Pnf2bR5X9z5K0hDWygLGtsFkub7+PZ4zZ0Bk+13OJKGq2MIJJ5mGryxyE73kzp5fHa6VXEMplL1CTQ5ma6dUtRarlbN9VfNIrEpsoDfuiQvfW9uXV4BbDcb4vZOYfMHz6fz+CLSGTFV/Z9lGhoBLE+AcO6dyjQNx8NQW1D7P9IUD8l4YS+ws+0D2U2gFjApUPpkIUgyH2tbiwMoJHM7fkmfXUmXt3Si2I0+9VJUVRAYqhFs+Vaw2NGJ/ZQ450fj/QR6tElUbp7SseNy4E3in5uXVYbPOa4pDZ6blVkUhfWsLS7K5Zhatk0KR8uQL77BPciicyOD/TCOM/GVvM8fq2aK4Cw8tLfcuhK0/b6seuM8ID20gGHb4xV/2idmTqUTRxWWRMCBlloxEngn7Yco8hrA9MFtZun6Y5Roenf77qm9uLHNtg1E+gxlp35VyLjOBUfD8TXFRYgdI3+mIeo4yZ6hKVeS0xR/D0Ko
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(15650500001)(41300700001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GwuGktClWtrqY6+oTulpWbKIarn0laHAGNzY0fdblizLTR4jKYqSdBNsqCat?=
 =?us-ascii?Q?OxdY6UHM1lB+0+dGtCjA5V6UOdexO73OdRE+Oulvcu6zAlD5w9oqZZVrbUo+?=
 =?us-ascii?Q?7UNwsqO1+Zn9RFuL8Hy3dS4tMzxpjWAHO46Vb12PTWfIMmdRoM2DvxpvulmY?=
 =?us-ascii?Q?Y3MDPBCFfqV4TfKrFSdElqRLJgzR8sIiDm5jYXIEEHHuU7AyJZW0pKlzeJF4?=
 =?us-ascii?Q?sre9TDgZ/Q6KfU0Q4I7TGbhhIL3eb2hL5MN2m/hRLZZ4NWBBtwmh1zqzGvmL?=
 =?us-ascii?Q?KEeU3PNIiDkxmhZ5UAsOkY4P+/eoEvZKX+WAPRt4SludlHPLSQCXi47Yh9LP?=
 =?us-ascii?Q?JMBQ/Tug6o1Mg91u3aIfLOhlBdfvG2P8nX1iwp/5/KkaSXcnO1iJRF3Ao7D8?=
 =?us-ascii?Q?BRDb8VURYhPNAhzZX2k/Q5kQAVM5dONdC5OALLVaYTOIB2UFzWLu3mwTBdWh?=
 =?us-ascii?Q?dbjmZPomnC3qnWVLBc75TAyk5r5jLEAwLqAzYdAAk1s6hDnsIjDyEZgjnLSO?=
 =?us-ascii?Q?RRjbI1MEnivF6N0mHvo/EDg7c2vqUHfZbEXL0Fo3V/wJa54v/JJFkEkooBtr?=
 =?us-ascii?Q?FDxsrGpeimNCAFIZx/B15PEWDKNe81SAD19hOR/Zz9eB7CSOpqaYnkS2sabu?=
 =?us-ascii?Q?YFmnk8KcnuZrFFlIElgnsr6F+FQFguujZIjSkibsVLAl8zpDh2sd6VMAQ9kt?=
 =?us-ascii?Q?AXFUhA7kUJvmt+ubW94HhGO6D1AmaZNYw8j3xakgqOl+sNiBr2bLPqc2w4JK?=
 =?us-ascii?Q?RVtGeYpetbHFungr77IYtmztwqIcv9y41TWHCRSALXXF6BXfGiwsCygM8S96?=
 =?us-ascii?Q?ESwbsQeSHHYs9qMa1/1+TGhIXuHxOOa/Vij63isPERj7HHA30CCbP827XvxD?=
 =?us-ascii?Q?EJPsZ3DmNR93cyeySq93ZpC7g/NVIGLqRqdpATm6MfZ21B4hTxPuphwGsqyq?=
 =?us-ascii?Q?Dmi4QZ7u/NqlfUvJO8IuxgGWB+qYXnAbYkTShQ1eUUSylnUOoCLqBxZepRVA?=
 =?us-ascii?Q?jDAqLbfMroxRH0X8SCzkeeoQaa1ZjPRryd3n1Il6C21JT//Jfst3xVzfhFsF?=
 =?us-ascii?Q?7lt16wdmaYoTJv6anfZFQewQ7kz3oN2FyW4HsPdrDYWEUCucsYJyeT8eM1rc?=
 =?us-ascii?Q?lHZ2LOyrlgxQnML4iDYNk5rB///llwOeadRM31woWy68TMgL5kvVWpb7Jpni?=
 =?us-ascii?Q?sBAiq4JlCOD69YJR0B6P3qXfWtGziCiHSC7pLyHOo2p8RPF6GYuXDufKis0g?=
 =?us-ascii?Q?yV7ddzt2IKaw25CNtN3l5Z/67map85w+Di4kEskDbHaeGVoOd/tuhkxeW5pt?=
 =?us-ascii?Q?d9+XvKfmizJ4AN+IWba7X9CHZsl84OPzuI5elPCo8cZ/TuSsa2RCqdD03WfQ?=
 =?us-ascii?Q?FlvXBKGT/6R25hKrZt5ok8sKnj6ps8ZWpj71koiSjEH9Shq/VPNTdmHPUaJT?=
 =?us-ascii?Q?05/m5IcxWuyY3GjHL7cn+cD93H3g6CoxBLtyj3bqr25OG86VONmmRi5ukOD/?=
 =?us-ascii?Q?dZPWG0OD/lj6S5Zx2c6LPqDVARsjf8UNPHyTYsB8E0y/GF9uGiehZ++v+hjl?=
 =?us-ascii?Q?jSAEqK6Imh6ZR2TxNxEXuL9rH1iiigFbe6Sc18rMoXfeEp1dvbM4PcTu5ktb?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9AilzcTeUbEZH0NT66iLNdKkxj4R8S6PC5Odaowr+orGLD/tKQ2SBEw6JN9MK47bT5pTjsm6XB+JbSDbS4Jz94OwngTePJtNvkeOB3pyjws9kIzBYPT/D0AjHu5kFucz5RHRA0vPMmdR6h2aItL2ec4j1dJWax2Yqs7pyUPq+c1ET/WlPAB+zlbSPWYWtZcBsPt29f9mV/+UzfRW/i+UlGtxIStUIzjICGYDp6OidoJyaPeeMyQYvXMZnuWEfOLAFK1gCuk6Nx5jEF1hEnVAZo5SOX3gCOj8aM17zxdox9QbTK7OJpwgwqhZN75r4SE17DZV04eOXjmFDE8fWyAFZATnHLUoR3te29BtfYKL5lIeV7KcO83diKo8+Q/mm6wGSQzY1N4QyqRF7nB5Ewq6n34PyZte6/+kyCj70pEpFrIcuqFf876A0PT9SGO9623ilTbWbz486/CnmLBR4qh0d+mLx0e+1JXN/ifYGKfLqi6QE8p4SFnHD6/fq7mYrsMSuPdsZxbdCPBOATSN6zubkPKtTrGsXF1HwNwHqNn4LFgfTKEz1K6nJfO6y36+W0Z6Wqt69QJ078KFruozyb3gjXg8GWsI1L/1to0bw+a4bMX7+Myt7d8pdRquXY7/nEWKN6FGGBB5TfN9BaPXuY3Z67SqgTgKEu6/mkF3QZnE9Banw/bRdlHmMzzCKzuSgwPz4YmY6/dfoWRrU1e6zqkw6p/7Nazu35KZdRipAc2BCZFWEQrdpTnKYG974fq6Z4TZeBsRexQNHv/Ka6KzSMqRDGfIp305b2pIN1JhG+y9c42Ws4RHHiEAq0cgEHwG2GRVKaFiBL9VE24wtPN2lWLAGapBQd/KNffhMIxQ1fQuBEORfAQ/O7U5Q+iBD4kmqGoWtRT4P4ULzGBljKlqkGy5ZA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985bd068-71f0-4c64-4d33-08db4d905cb3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:23.1620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eJofWdbZMBAXytJSw3gAKTTn/mqOLrlLAmTZGUwzk6+T2USHHpAh+bbimQnnPTUHcVMngx1c+yAGfCoJ3VSww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: mMZUJBDvHYfMZPsuDnJdGC0vq6T1RIAO
X-Proofpoint-ORIG-GUID: mMZUJBDvHYfMZPsuDnJdGC0vq6T1RIAO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the vma iterator in the validation code and combine the code to
check the maple tree into the main validate_mm() function.

Introduce a new function vma_iter_dump_tree() to dump the maple tree in
hex layout.

Replace all calls to validate_mm_mt() with validate_mm().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mmdebug.h |  14 ++++++
 mm/debug.c              |   9 ++++
 mm/internal.h           |   3 +-
 mm/mmap.c               | 101 ++++++++++++++++------------------------
 4 files changed, 66 insertions(+), 61 deletions(-)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index b8728d11c9490..7c3e7b0b0e8fd 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -8,10 +8,12 @@
 struct page;
 struct vm_area_struct;
 struct mm_struct;
+struct vma_iterator;
 
 void dump_page(struct page *page, const char *reason);
 void dump_vma(const struct vm_area_struct *vma);
 void dump_mm(const struct mm_struct *mm);
+void vma_iter_dump_tree(const struct vma_iterator *vmi);
 
 #ifdef CONFIG_DEBUG_VM
 #define VM_BUG_ON(cond) BUG_ON(cond)
@@ -74,6 +76,17 @@ void dump_mm(const struct mm_struct *mm);
 	}								\
 	unlikely(__ret_warn_once);					\
 })
+#define VM_WARN_ON_ONCE_MM(cond, mm)		({			\
+	static bool __section(".data.once") __warned;			\
+	int __ret_warn_once = !!(cond);					\
+									\
+	if (unlikely(__ret_warn_once && !__warned)) {			\
+		dump_mm(mm);						\
+		__warned = true;					\
+		WARN_ON(1);						\
+	}								\
+	unlikely(__ret_warn_once);					\
+})
 
 #define VM_WARN_ON(cond) (void)WARN_ON(cond)
 #define VM_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
@@ -90,6 +103,7 @@ void dump_mm(const struct mm_struct *mm);
 #define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_FOLIO(cond, folio)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_ONCE_FOLIO(cond, folio)  BUILD_BUG_ON_INVALID(cond)
+#define VM_WARN_ON_ONCE_MM(cond, mm)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #endif
diff --git a/mm/debug.c b/mm/debug.c
index c7b228097bd98..ee533a5ceb79d 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -268,4 +268,13 @@ void page_init_poison(struct page *page, size_t size)
 	if (page_init_poisoning)
 		memset(page, PAGE_POISON_PATTERN, size);
 }
+
+void vma_iter_dump_tree(const struct vma_iterator *vmi)
+{
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	mas_dump(&vmi->mas);
+	mt_dump(vmi->mas.tree, mt_dump_hex);
+#endif	/* CONFIG_DEBUG_VM_MAPLE_TREE */
+}
+
 #endif		/* CONFIG_DEBUG_VM */
diff --git a/mm/internal.h b/mm/internal.h
index 4c195920f5656..8d1a8bd001247 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1051,13 +1051,14 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree, mt_dump_hex);
+		vma_iter_dump_tree(vmi);
 	}
 	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.last <  vma->vm_start)) {
 		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
 		mt_dump(vmi->mas.tree, mt_dump_hex);
+		vma_iter_dump_tree(vmi);
 	}
 #endif
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 76eaf12f13903..bcebfd9266324 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -299,62 +299,44 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return origbrk;
 }
 
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-extern void mt_validate(struct maple_tree *mt);
-extern void mt_dump(const struct maple_tree *mt, enum mt_dump_format fmt);
-
-/* Validate the maple tree */
-static void validate_mm_mt(struct mm_struct *mm)
-{
-	struct maple_tree *mt = &mm->mm_mt;
-	struct vm_area_struct *vma_mt;
-
-	MA_STATE(mas, mt, 0, 0);
-
-	mt_validate(&mm->mm_mt);
-	mas_for_each(&mas, vma_mt, ULONG_MAX) {
-		if ((vma_mt->vm_start != mas.index) ||
-		    (vma_mt->vm_end - 1 != mas.last)) {
-			pr_emerg("issue in %s\n", current->comm);
-			dump_stack();
-			dump_vma(vma_mt);
-			pr_emerg("mt piv: %p %lu - %lu\n", vma_mt,
-				 mas.index, mas.last);
-			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
-				 vma_mt->vm_start, vma_mt->vm_end);
-
-			mt_dump(mas.tree, mt_dump_hex);
-			if (vma_mt->vm_end != mas.last + 1) {
-				pr_err("vma: %p vma_mt %lu-%lu\tmt %lu-%lu\n",
-						mm, vma_mt->vm_start, vma_mt->vm_end,
-						mas.index, mas.last);
-				mt_dump(mas.tree, mt_dump_hex);
-			}
-			VM_BUG_ON_MM(vma_mt->vm_end != mas.last + 1, mm);
-			if (vma_mt->vm_start != mas.index) {
-				pr_err("vma: %p vma_mt %p %lu - %lu doesn't match\n",
-						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
-				mt_dump(mas.tree, mt_dump_hex);
-			}
-			VM_BUG_ON_MM(vma_mt->vm_start != mas.index, mm);
-		}
-	}
-}
-
+#if defined(CONFIG_DEBUG_VM)
 static void validate_mm(struct mm_struct *mm)
 {
 	int bug = 0;
 	int i = 0;
 	struct vm_area_struct *vma;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 
-	validate_mm_mt(mm);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	mt_validate(&mm->mm_mt);
+#endif
 
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 #ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma = vma->anon_vma;
 		struct anon_vma_chain *avc;
+#endif
+		unsigned long vmi_start, vmi_end;
+		bool warn = 0;
+
+		vmi_start = vma_iter_addr(&vmi);
+		vmi_end = vma_iter_end(&vmi);
+		if (VM_WARN_ON_ONCE_MM(vma->vm_end != vmi_end, mm))
+			warn = 1;
+
+		if (VM_WARN_ON_ONCE_MM(vma->vm_start != vmi_start, mm))
+			warn = 1;
+
+		if (warn) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+			dump_vma(vma);
+			pr_emerg("tree range: %px start %lx end %lx\n", vma,
+				 vmi_start, vmi_end - 1);
+			vma_iter_dump_tree(&vmi);
+		}
 
+#ifdef CONFIG_DEBUG_VM_RB
 		if (anon_vma) {
 			anon_vma_lock_read(anon_vma);
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
@@ -365,16 +347,15 @@ static void validate_mm(struct mm_struct *mm)
 		i++;
 	}
 	if (i != mm->map_count) {
-		pr_emerg("map_count %d mas_for_each %d\n", mm->map_count, i);
+		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
 		bug = 1;
 	}
 	VM_BUG_ON_MM(bug, mm);
 }
 
-#else /* !CONFIG_DEBUG_VM_MAPLE_TREE */
-#define validate_mm_mt(root) do { } while (0)
+#else /* !CONFIG_DEBUG_VM */
 #define validate_mm(mm) do { } while (0)
-#endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
+#endif /* CONFIG_DEBUG_VM */
 
 /*
  * vma has some anon_vma assigned, and is already inserted on that
@@ -2261,7 +2242,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vm_area_struct *new;
 	int err;
 
-	validate_mm_mt(vma->vm_mm);
+	validate_mm(vma->vm_mm);
 
 	WARN_ON(vma->vm_start >= addr);
 	WARN_ON(vma->vm_end <= addr);
@@ -2319,7 +2300,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
-	validate_mm_mt(vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 
 out_free_mpol:
@@ -2328,7 +2309,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_free(vmi);
 out_free_vma:
 	vm_area_free(new);
-	validate_mm_mt(vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return err;
 }
 
@@ -2963,7 +2944,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	arch_unmap(mm, start, end);
 	ret = do_vmi_align_munmap(vmi, vma, mm, start, end, uf, downgrade);
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return ret;
 }
 
@@ -2985,7 +2966,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct mm_struct *mm = current->mm;
 	struct vma_prepare vp;
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	/*
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
@@ -3226,7 +3207,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	bool faulted_in_anon_vma = true;
 	VMA_ITERATOR(vmi, mm, addr);
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3285,7 +3266,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			goto out_vma_link;
 		*need_rmap_locks = false;
 	}
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return new_vma;
 
 out_vma_link:
@@ -3301,7 +3282,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return NULL;
 }
 
@@ -3438,7 +3419,7 @@ static struct vm_area_struct *__install_special_mapping(
 	int ret;
 	struct vm_area_struct *vma;
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	vma = vm_area_alloc(mm);
 	if (unlikely(vma == NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3461,12 +3442,12 @@ static struct vm_area_struct *__install_special_mapping(
 
 	perf_event_mmap(vma);
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return vma;
 
 out:
 	vm_area_free(vma);
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return ERR_PTR(ret);
 }
 
-- 
2.39.2

