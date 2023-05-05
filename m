Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541C66F87D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjEERon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjEERoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:44:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD761A614
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhIvK029381;
        Fri, 5 May 2023 17:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VFSQL5/0YuqNDgTT1gzifbZK16he4AsT0QLV48AYt1g=;
 b=ZaugMnNjTBk3nfgwsdnS11VSGluAiwHbpfH/QUkdKUZxZmxcll5/XfV+bpQp3o+dghf7
 DzBvPqnkDpq4Oy7KJ3mwhn9C8E+mmV1tNy7p/gDN96xsk0CrHV8ahfA5tmIFw9l8sdLk
 dGW1uI3/CllmBEmFCR/bwJw2Jc2jgLd78eo3jCKF7NOCn/K7fpMEYZjkqnI9bNZCYCyK
 rQ6zDILNor3VIt2pX/PFqGVdZn7tpENiVy/tVRHbkRdXOY8nLmLUNA4vImQ5THUyf2sx
 QZmyFjuQ7dI1LYlaq5khMsrIsSFGEbXtxOReeC5KrNOjJuSQTAjkBnd/Hun2US9f4f+H Yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1wf4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345GQG4V026938;
        Fri, 5 May 2023 17:44:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgeyp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl68ta80GoKxNU9lBMOqW48Zg/CJGLdYVvIcYAM7APyWLswHAkpPG4+gvT1r8TEoKOQER/Xi7Mo3HUDY+MkXHtnZW50sj0/tNIqiv4MjPwgp1pliqh6UT+PxCB3ruTbQa3uYDbo3HlPrtpa4HWhRmQC97yRe66zLrjTZFy3JD9IgQPtqsf9ZALYCsqBGgpdxCciA1CFIEcBuQ0cDGc5lqWz+EywjnnAXWuBKpHT9zJtAczlYWwhqN3rMbid2G8+qGGbmcVrzjoYi15JcZaaBH3Nhp1KKXFfYSdL7DcOVp9Ar9OkUfucgdiXCeCdWXKnZWP/ZN/XrJnZpQjerXZTpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFSQL5/0YuqNDgTT1gzifbZK16he4AsT0QLV48AYt1g=;
 b=dvybn2ZVjQVs0rS26I3uOrTRV6jyRoZXmt1LHfFsCwi/CTeAMAGO2NDt2W/8Pbm8Uq3xIdKSXxDAXtujZXoPaIz4CxAVEixwAhNWMUUvLmDgzLrs3otvEZAKqjqFyHG94NfvtJbtpfOsAgLq/14yUG4rnk/hyPtwWISSKVJHvbN0+GsLFq72xN5208Out8WvYEvUXPHIxdbJpmdS4bZsOyArwAm4I3XubKGDlhoMguvPpLngU5L+ON+aVDA3s/VSznqi7j7DB2qVMiBNJiRR7/YEJNfxSwEcHIM5s4gBEuM1Yjq2vXRP2/lf9d1qObN7vg9MHXHaBbBSplw5ThLTJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFSQL5/0YuqNDgTT1gzifbZK16he4AsT0QLV48AYt1g=;
 b=KwRBA/bbQoIig2JQmIDR5UoSQRQu2EUvr1CbFZTUaxVRH0yQ8HcTsRCzAcSCynrl4lnZYoABsUxAvif8047i0WB968fx3o7UKX93TO0F8SoXBWK/sX0A4YNP+eYqYEcPy1vV/PvThRddSYbfx0L/cNHyQmnlt4rrkXK5igniTmk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:04 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 10/36] maple_tree: Use MAS_BUG_ON() when setting a leaf node as a parent
Date:   Fri,  5 May 2023 13:41:38 -0400
Message-Id: <20230505174204.2665599-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9321ec-c6ca-4807-75e5-08db4d9051a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IrhhRdvB8vv/17lhNS6AdWofb8lZZIR5z3871A/n9DPKkaqeSIMTcCDr+XoVO1+HqVJfsBSTSqrJU1KcCQIGDs+xeuQYLGV8c2adVIXLAkqgP4cM/x/K+dtS5SINQYYGavq0Z2B9NwO5wUEU8fcwepkg4WWE6Htfhh9d74NcjAMCLT+6wL73tc2y8vjpMtBT59+KInzZXk8r6VbX+Pzf2RXWkKfHjs/SyCgeb8dEmd6UOK1YEoV5buTCXwVlNrLS+TOZnxGyslXkhRl0AGn5+tFAaWVG7CeFDYcI97Uj1+l3vrqbcz2lWiYVHtSKY+yc7JATTj7HqNnsbDNzVY2Wq4k8yQaM3tdPgc/VHO5+DxXLDlFo7a1LY4H4wZVNlCK2xEBLXcPif8bNfG622yYIFJebmuHzoVpCPMsrn/4aovLQzkrNVa8+/pximnb1oQgSoooJ5z/8LfA4/0oEZZhBXsP/gTm7TaOQG1JIGhx3ucg0hHqnLM3nFWBm+eZmVm5hd7q1a8+A8+6DIeH24S0ANh38vXnqXHdJTRqY6DJHR458eytg3zXMfxNxRcPo8c1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?By2OzFSEbXewBukove7VeQG2ACqCGtvk6ajnT2N+tEfsTinSf/QvwA4K7Mkf?=
 =?us-ascii?Q?1qsKY9fm2mk9077xxrmrRdS0dHJV9NmGIecdQxjlBwMowMW43KAxk6dwXO1q?=
 =?us-ascii?Q?Vobf/AuNeRFmAEqFDTZtyxqFOfnCiflZxgay9g6vbLDKLNBGwWjOu8pOwCOt?=
 =?us-ascii?Q?TzzCs81oRReynPlPqAsNFiU/jv7A48Haxg2AzECZLt/PzZ86VMEoS+L7RZJG?=
 =?us-ascii?Q?6Yv77fBRVCEuuhTQ1WaDPmGXJSN/+I+9U4Y9Tr3PFgc3GbVxXKiWF6VWzxo6?=
 =?us-ascii?Q?P5CCVczLUwryfvxb/VImrXst8psxDq3Fxxe9OFbLdIGBOd+mGjeXU9wFVpvV?=
 =?us-ascii?Q?tPXWvdIFcfE2EGusYdQYPeuRYx7b2BG7DzhjhCyIqs3HBTXQIJ7VqffPH1Gh?=
 =?us-ascii?Q?unctVE9IrrVSYDp0wKK6eCWJTa5qaUTiCJ+xJg2OZTNduODAz0vISoMhhKYk?=
 =?us-ascii?Q?rCPif2qSMjtHtvKAj0MqHYyjKHzV33F6y4+pylLimYQ73RVW+LR4/iLUcfmD?=
 =?us-ascii?Q?eNoRjI/JY46p2283QjYWZPkU15aiZ1ZdwUiFbD6tQNznlHdNQ7ChPm2DpUyd?=
 =?us-ascii?Q?utCA42DjR8NsEl7jQJ+YFZeybWN8izJnzBWijFMtc5GYJtDqWJSa3rzHYXi6?=
 =?us-ascii?Q?sXBJCsTZgslxsWHnKXCukjNUDtE9Pj3BV84ZSo2V8EB5ds1D2C9dfAwtcwD9?=
 =?us-ascii?Q?WoEeQcZeGHva/gWxsOpMCyGihCPs0SEtSUOsH434FNTUim2RZIs+f6IGYoqj?=
 =?us-ascii?Q?Zt5YD8DIZIBIbF8U/nFVddC3abzvdXie3EMXZthvsuZhtBn88rQvsUUtxbrc?=
 =?us-ascii?Q?PEpXxZXrZseEvGA8bk3J9gpxGWXba/VzpsdW2BliX/FSnQdAatiU+uCiLKzl?=
 =?us-ascii?Q?cmpsV5ITYVXxZF9qJvv8ftXLDpbBdU07Gjzmo8lGEn56MWyE+lQPkOaqsAUp?=
 =?us-ascii?Q?+dYGvxDEDuhvXuRvC4AbiKvW3TsbckQ7qm/Ps/pJzi7v5eEq99FpVb7kdob6?=
 =?us-ascii?Q?dAoBNgfqxDEmxoCh4t16KBD0UG9jqYUUWwvIOoF/9sc99QEw8MpbnPheY0pk?=
 =?us-ascii?Q?oORHV4Si8Ue2WSenJ68Qmj+IOlzJTVlWwZvRx8ine25FKBl9yOR5Jvv7XQgs?=
 =?us-ascii?Q?IqpEmPFxxqq5kfsY+YyxdvsyXjzdxF24eeqdlNgeS7cu4g1YyUa1yTfjx/XC?=
 =?us-ascii?Q?qhR3iy83xPuqL70PW2hTM6H/UYckhxKyqbzDHGaHTXs+DY/GGcmsv08W2Pbc?=
 =?us-ascii?Q?o2eqIIK5nLbtBAmsc2LRdS6Fw3h+JT5OuVaJnOCqIE4QPNkdD5cWx8EUfRM5?=
 =?us-ascii?Q?8sHZ1pZ7QUI0mNdqn3ullJGjTZesHYSIClxR4Tw5gn0Od+JieRfSOXcJL/5z?=
 =?us-ascii?Q?nvmp0K37Kq/QFQoYrgHXpvTPLkHWnL4gPN685uH/2pp9qi6hN/JONlGOgvel?=
 =?us-ascii?Q?Dt9doaSvP5gCTgoR6F3W7P0Jme4tbIEri9tAydiHDah6BaBDSP8BCHrXvItM?=
 =?us-ascii?Q?7qYmh8FOyz6KG/ySkVrycbH/gUaugu4CFswu1E1QYkNGENq+JOtc7HlTAKXr?=
 =?us-ascii?Q?ukJRCgO2t5h+oPm0v7K5y+EICE9r8fN/0OxiEyz3qbni2fm7WIIqybDonIAq?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XmCub5lnT7WXu04XcsDNzQGJJqNxZA7+t0Uo0X4CrXlD23X+QMQXVm0/XpebGNVjhvUKIu4aeH3GWnlGe/YzvRI4wfyz7eXfKWP8OFMGP/euhfeLrtGpLeADXxBwnttTV6qRPGCVuLMEbfMjHByEfVOiT4nH9Mp7NiNSkvxXV6Yitd186phyI7IeKkT2tfbE70GlXFCqGa1EulbqWrxYBksiuz1sHqM5N5dWe6u1ZII3XI4BxS1t21NfUDA0pxDWbTYrDn9Q9ePnqCijWlmRbYZd5/iOffSYi+PJdYT42VPvnWaSwERXQBQ+KattU5plMM7hfzoxvePixijD/bCsAvU3S7GE9ASXDPQHjo9A7ykhbaUv+aIa7kbYVs6yokwDCnjAhMxpLSblHanF9ebiQ2luBDhBlM/5k4aKKPMA5jRthFPJd0i22WruUZGVEfGnPluimBdUwvSAxkljVBVBUN+YP33r2lu2/X0jsACRNyE6I1t6jjWhlHA9PVM/mKiZdE+w6GYVH7M5sRFKtl/8gDnpKqJn4gjB+hoUyg83C9sb3wdBlrWphaIZ3uzbY8IPOx2NrGh4UZHcf7xJIU1UfRA/N4WBZ9ojUDza8RrjuejTOlUFxxJ43eEAgdr7jG8CAgKhFyzSp++Qqtm1xMQPsf+Ocdg1iAWV8rua1RndHE0+5hf9T7YUTTFNh4dFzaGRYGbKGAgkZFQHdLSvq0xEyOMi09ihUqMZ3P+D3WQOkWCVg9JOmLX/gvYo5/WKwaD7QkswoWnF2s9CEC+QgR3dowdDKmEf7JiXsGTn2joIhiSHsoYM52nFYPhit4FRoBJpC+/b4FPaab8l7YGIfeiQn++K+d1lCAob/xCeOvlxsm6Oj/omy77raPJ9GJjQ3UUzZUoxU4r5ETrFOgmHV35z2w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9321ec-c6ca-4807-75e5-08db4d9051a5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:04.4688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vb3iBgdDKw1izveosrSgKJvbQXEJZ0ikD+pBJYcdlHc/EdN6GOYgMdk+pdPYAUZFBXGPfi8DBq4I/fHnKeTnSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: e9RYm0PeKU_u5aA2vraGPTpuqLugWopS
X-Proofpoint-ORIG-GUID: e9RYm0PeKU_u5aA2vraGPTpuqLugWopS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MAS_BUG_ON() to dump the maple state and tree in the unlikely event
of an issue.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8fd83f21caf00..a594f1d88d062 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -453,7 +453,7 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
 }
 
 /*
- * mte_set_parent() - Set the parent node and encode the slot
+ * mas_set_parent() - Set the parent node and encode the slot
  * @enode: The encoded maple node.
  * @parent: The encoded maple node that is the parent of @enode.
  * @slot: The slot that @enode resides in @parent.
@@ -462,16 +462,16 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
  * parent type.
  */
 static inline
-void mte_set_parent(struct maple_enode *enode, const struct maple_enode *parent,
-		    unsigned char slot)
+void mas_set_parent(struct ma_state *mas, struct maple_enode *enode,
+		    const struct maple_enode *parent, unsigned char slot)
 {
 	unsigned long val = (unsigned long)parent;
 	unsigned long shift;
 	unsigned long type;
 	enum maple_type p_type = mte_node_type(parent);
 
-	BUG_ON(p_type == maple_dense);
-	BUG_ON(p_type == maple_leaf_64);
+	MAS_BUG_ON(mas, p_type == maple_dense);
+	MAS_BUG_ON(mas, p_type == maple_leaf_64);
 
 	switch (p_type) {
 	case maple_range_64:
@@ -1740,7 +1740,7 @@ static inline void mas_adopt_children(struct ma_state *mas,
 	offset = ma_data_end(node, type, pivots, mas->max);
 	do {
 		child = mas_slot_locked(mas, slots, offset);
-		mte_set_parent(child, parent, offset);
+		mas_set_parent(mas, child, parent, offset);
 	} while (offset--);
 }
 
@@ -2705,9 +2705,9 @@ static inline void mas_set_split_parent(struct ma_state *mas,
 		return;
 
 	if ((*slot) <= split)
-		mte_set_parent(mas->node, left, *slot);
+		mas_set_parent(mas, mas->node, left, *slot);
 	else if (right)
-		mte_set_parent(mas->node, right, (*slot) - split - 1);
+		mas_set_parent(mas, mas->node, right, (*slot) - split - 1);
 
 	(*slot)++;
 }
@@ -3104,12 +3104,12 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 				mte_node_type(mast->orig_l->node));
 	mast->orig_l->depth++;
 	mab_mas_cp(mast->bn, 0, mt_slots[mast->bn->type] - 1, &l_mas, true);
-	mte_set_parent(left, l_mas.node, slot);
+	mas_set_parent(mas, left, l_mas.node, slot);
 	if (middle)
-		mte_set_parent(middle, l_mas.node, ++slot);
+		mas_set_parent(mas, middle, l_mas.node, ++slot);
 
 	if (right)
-		mte_set_parent(right, l_mas.node, ++slot);
+		mas_set_parent(mas, right, l_mas.node, ++slot);
 
 	if (mas_is_root_limits(mast->l)) {
 new_root:
@@ -3336,8 +3336,8 @@ static inline bool mas_split_final_node(struct maple_subtree_state *mast,
 	 * The Big_node data should just fit in a single node.
 	 */
 	ancestor = mas_new_ma_node(mas, mast->bn);
-	mte_set_parent(mast->l->node, ancestor, mast->l->offset);
-	mte_set_parent(mast->r->node, ancestor, mast->r->offset);
+	mas_set_parent(mas, mast->l->node, ancestor, mast->l->offset);
+	mas_set_parent(mas, mast->r->node, ancestor, mast->r->offset);
 	mte_to_node(ancestor)->parent = mas_mn(mas)->parent;
 
 	mast->l->node = ancestor;
-- 
2.39.2

