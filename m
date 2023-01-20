Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14CC6759FF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjATQbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjATQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:31:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821A73F2A9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:30:28 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBZwR029948;
        Fri, 20 Jan 2023 16:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=p439LvY40ylSMMh35PHQRibzaWJvjzCCB0xsT/pJA6Y=;
 b=gzJ4dpQZ6L67RXcJ/vR1HbXOPcayCyyABC9k65ZbqwpUNGu513h8gDhoBES/ETctEQtX
 Na95+QGvqD/X5lomZwzDXnnaU9IdTSIX6Wp5ifrMRi9sQ8fwKzMmlFFytotQYkcCKTmd
 yl6hGPTMNbXxc4/tF3MZc8cyrXaRxZPprEQDENncDfAyl8AjSojxKLIu/YJey9wCEoSS
 Pt5WE/Mx2jj9e24HoYc9dZq6cpGtzJUww9TcZhGfEnY4NJ/BWqC+IhkH2fjbrB5bI/13
 ec/1/Z8ZVZ7cS3j/YtwIZuSu43JMVgzQIg8H4xRKPM+RlbU7ZTEaNA5pSOAcbWE76ko6 jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6cd3gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGRab3027906;
        Fri, 20 Jan 2023 16:29:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qud93hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5qiltoQ2tHHm1cADVsmJYrJbiQo6kfCvZSqCdbUGLmCEFeoGzxm1x7TxxGlSM/opM3mckzrpQkw9JFUCpQ6vudVQCngqlbJuXwrDWQrzZgc757kp5NeQ4I/fYkgoKOP+twL8SA+526/Wdj6SuUcjTkdl2OrtaIpmpd2ZOqg0/5Ykwczk1tJlDQQqL2cGzgRBOs9D7mvbNHdX052KPrOJ7aBcdWz/pvl33MMKkG8j+cLAPxv0MOdPbiCqerbqfeKf7hawHKgkmV3U2zaKy2aSqa/ETBLnYJnWruDyy7MtqChAVMrQOlYgUr1ofDTtEA/RIltSS9l3qkqqWNMzp2MRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p439LvY40ylSMMh35PHQRibzaWJvjzCCB0xsT/pJA6Y=;
 b=X4DnEB62l2F6fgoqGNFn5Jiq2CXcWbGAP4h3cw3Bs507YtLz+XYhcgQKGrul5Ud9aOU+SsXJXZM0dNVlt0xmti49qt4nqnL/mo28Sdvr4Lc45aY8kNraxKVTzjBXt/LTwDmbwfpGyGPy8BzxWRhhpRXMZTlRiQlpiyakGFXO6g0mJemnAbaFHIN2daamvo01zYZixSm0QifhCYmLWsjHseutLZpaz5aenc8yFreBNfa5Gn6LWHqEUFmezTKEbF7Vhd9n/Zy6V3DXRQBRBez4AbZ4ZjtiT+kcaRhRsXSEgxEYRChtDgs3H8WE9k8mNW9kYClk7k9CDVuRem5xGhsfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p439LvY40ylSMMh35PHQRibzaWJvjzCCB0xsT/pJA6Y=;
 b=T/sh1UQ4bAsSFIe8bfwsQct3Egn33mYnGfObzS88RIVJalG+hoImuk25u/DFZhU8RxT3H9iEaAFqm6quujMWqllDVjYYO9oj3LcarSZo9PgRpfc+hDLyGJfjvUpWdezGdb4mGbsfVCalEUH59O7cExdh7ygs2KeoNcYo39zMo/k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB6400.namprd10.prod.outlook.com (2603:10b6:a03:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Fri, 20 Jan
 2023 16:29:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:29:13 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 47/49] mm/mmap: Convert do_brk_flags() to use vma_prepare() and vma_complete()
Date:   Fri, 20 Jan 2023 11:26:48 -0500
Message-Id: <20230120162650.984577-48-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: e7320fcb-5ee7-4648-574e-08dafb037745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYx593t9IFDBbbgT0mW6R9qaHboZoqbuFv0kzKwcq4VGh0RR4CTg0cEJVfDWBUBJ3khnwqnxpr4FoSyHOBSm3H/vVe7SZddzm1+6SWnm/u9uOmqXyv2S76wVcM7dOJt/SMT9wfgYiyUkZHYwi2LeXRJBJIFZ5aq1ekf4NDImjVCa4OGSQDHil7xqgjclASZOAaBUWZGOuG4utolYECcqbnicb8Kdw8ls89SvHJpODQXUvHP8n4wp7uFSRtqvJq0P/TN+TrMEuKM57j0yTHP7tUzepC6RLshKUo84zf7UDPGDPv2ZpTAgbyrh1AjtSWhvJ7nA7cLRMKfz6rWtWm149u3kS+2zy3cLWZVy/5IHGkolvYDzwIMo/9azJ9qlznLgzJ1TkGeRIFMznG8fRRysak5WbIqp6cA0Rq0nQmcynxijBvA5NQBg9ylgcXGDtDAkXVZd+QJdbOv+3w1YFinCNtzLAeytANUIw/SQJ8Sa54WGv/dqwPdyjMRs8jg5mwA1PkgWlByPcN8pJe5RlF68bIpGfPQfDOD+KiUw9o83QTzw/oFAGheqENYniQPEw6cQSwGIIQZYZh5+z68WLFlslWVb8mb6w2GyXGDfLhdaUXxQyabqFrv+uSbst57qDw9I4F7j8786nJGMBY3US2+Avg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(316002)(54906003)(83380400001)(2616005)(1076003)(2906002)(66476007)(26005)(6512007)(186003)(6666004)(107886003)(4326008)(8676002)(66556008)(86362001)(6506007)(36756003)(66946007)(8936002)(6486002)(38100700002)(478600001)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dMiR6DdJrl1G6J5qc9hU/FZ+zKE2GD2EVZOuwjPKZb0Vp8gD+giPqPfq8oMW?=
 =?us-ascii?Q?kOOpWlEw3K1RC16xz2An5Ox6ML/bK05P1Dp5F5zu66/o6PZPBzyL6ezsZ3TC?=
 =?us-ascii?Q?j7h2qB4LCckScPtZ5V7WPLnNaXwqpoucU7GOmgoZY/bpbYYgC7V0iABGPqcr?=
 =?us-ascii?Q?8XOjp/FbCToC82ao74NHPr3aIW8jIP4WeNEV26EOXaFl3v2JEpv3D2n3eoSy?=
 =?us-ascii?Q?rRijVPIdmdqYp+34d9Q27A+2OJDUjxtuEm65frAcyrLGw0k18KFMqa8rcxoV?=
 =?us-ascii?Q?tvTppaQDkD9/ORfmi895ytRoS+IQ4gHspJk9AbTCcYNtJ/Tbq7ZSbev5+5uZ?=
 =?us-ascii?Q?pymdhF9CEcnjYuznbZ3IAdFhIC19tHCk1msPQsHN9vif/XQlzDlcvm17dBmO?=
 =?us-ascii?Q?H4qN4mCdG1pPbwpsxUUJKhAweG3/QXtm6huRBzmqXGgBj6I5KHbwHCLuQx7M?=
 =?us-ascii?Q?shhs2MM9PoVAmx9dvirBCmS1955Vo6l1jW7pbiAlkTNxFp+EJE/yGXJxZlzW?=
 =?us-ascii?Q?KA9H55tZutysB/B3KKGGhEWbkHphWfooSwgiciC9Pd1L6kQ3ducansHNvuHX?=
 =?us-ascii?Q?JcvudldyS9Dddd8xa/ik5oQRJD6dDKrGE704++p9cgAyJ6kWEZi225qg0NvX?=
 =?us-ascii?Q?sQFVWkw3T6fxMpK/aTAfbtGkm/IJo9ba/IJNKL+LRZ0/XW5XDyjMGe8ffXEe?=
 =?us-ascii?Q?4ooVtMPRzqPqHVjTnJxUZgichpuVYT+1g6svq5NZJ8YEnLXYhX1xp2Ml5CGH?=
 =?us-ascii?Q?QtH1cblFWB2117wDvjnKCpO7GUa9UXC/wDfizaEJaCazkD4sc/TV1rFLpxzz?=
 =?us-ascii?Q?bxTa7kcd2yvd7OEWsmZc29WPfhnlQzosVvuvnNgDsl/+hkJF30xyBRCNR52f?=
 =?us-ascii?Q?hhPuWfYnXCuKcJps/DI0iR3Mg1QG1Ztn95iUhqUrWg0Rl2m8M7TgtnBfMYtN?=
 =?us-ascii?Q?t25DZckha4C4FlYXgiKMLEYqrlNRC+4y9mxyNwBfX+79+DxcJI69aO37nipr?=
 =?us-ascii?Q?1WjPCQsKVSggh4e0AxeewUga0PpaIieaeJMpbhY2LN4ha72J+Q/tJpYg7RXE?=
 =?us-ascii?Q?iTXz4R+kUcwZw1fcWdXEKYD8Pkb7WDK4HtDAUKBIXsYzqMSLDUxmahA8njv6?=
 =?us-ascii?Q?DWDTqK7ubglXSXCZQei1jcXqbMzIimywGwluFw8UX5A/PjeaKy9iHBJ+Xaqo?=
 =?us-ascii?Q?+VAIL9Vwm0+L5quQPa3Yho/IIQ3zrHxJUrb/YZPk+po3qL/IeQ8iX96V5r4U?=
 =?us-ascii?Q?jjyhiF9VN0jMOOwFPwB+EIZGIxGqdYn4RRTkz1JcLgUNYD+x1v+oIn9Qff1/?=
 =?us-ascii?Q?rCKu6UUMOjRV2t7E0HGJAfCqFklQsYhdwAnsIuQqG8AXGCfGPsoeFk+7iovz?=
 =?us-ascii?Q?uHtd2Or9F3mRZTfstGaXQS5jpopFi1P+4mUyyJMUD1b7PJdXqYhkI/+9w8pr?=
 =?us-ascii?Q?SPZbEHZNc3LYghP84vx3nNoMydngSeZ7FyKtWz89ArLM7YsOE5yKrKx0V2++?=
 =?us-ascii?Q?v1dfD57qAUm4ofwa3pcxWJvwjbB5KMr/zd5N3/2YUeNx64mtrx+REoeJtQwK?=
 =?us-ascii?Q?6PGcfC1ISOGRphvhSl8djT94km0L7h7AuKhWAFu1sBn+nsguyRbNF6QfYyDT?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TbAY4ONf7Rq/64aG4AUgDGEaIKMy+kHzTgvYD9/A273XS6EBfi8Fsk9C6BlVTfkeTo+Hc61CIYt+rs3WJUZTo+T0pHVeBNoW5qzC/DfLifaHmeAn0CUiWGzcXDuFUO9Jdk/Hg3Rll4ZWWQQQ2r21YSP9RN9+ly/u08e49hSsB8hWZcxIwDt6OoY84WTh/VAYWJV5SYc91iVD8F2SgwYUHCXp8VcD2SePAwNS76kM4YKoU7UmvMZmOnk3TAF6T2+woA7t1/kLT0NQ5F9Gf8es7CEkFtTnK97eMAMMvQEHdYFGnr4sMa5nqN36H81sxfmIuyAuc6hKWu3QH4FgS8UuzXmpL88LGlJ3h+btMeBYZkvyU0HV0kVNZdfTLYb9uO67N0HWjepy34jq+aqTpJNcICnxK45U83vP7WDpzGZAL1h6nkedfUjt9fXPeiCNAKwY+HA9oB1nJM8L1Ic0jFRrm2ZpuX/wp4QGIWCTsmBJX/tycX2kh4tribZpzV4pfZPDO6qRUAzf72XgFe35hZyl+h1RD90koIkSnS5uSz9UjCZ31KWdNKbqXGdLvDqCraN8CZb7z4IElmv0CwCsXcPH6E7TQodSOWvW5mULLwc4uZJzVc7UvF/oOKtf2YD8BZ/8AVnURJUdgaZBp4VujYic+lEseZymJGPLLFLWACApgpi8yG1odAHOrgpusLSFI564goUyME8l/kUZkIJVX4nRSij/EeTPvDuLebz7mzpTMTD0oqPooioHrjADeldtKbVR8gqYkBvWMXR00yhe6fidtWKEkze5L2cp7ggl0/Pk5GWsPovrPv+w/7803wJchHqfK63YQWu3NT8R9zs3R1gT0TBlJpP2wEq9Z9xPBBa99OCwrvGX7nwDbr7mrY0Vj1wRky88JgZSiW5QFovJQLx5aA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7320fcb-5ee7-4648-574e-08dafb037745
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:29:13.2884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ljlq6GJMDYKlSOJfKZcF5uEch9tEPzDWg50s03KpzWcXdTxbnEFvP3wzaONGptuRhwsvS0cUoXL8ST6UqJI94g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=943 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-GUID: VxMPMMe3WqhNmYsAdGlkJR9vdHg59Rij
X-Proofpoint-ORIG-GUID: VxMPMMe3WqhNmYsAdGlkJR9vdHg59Rij
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the abstracted vma locking for do_brk_flags()

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0a2b19633174..5aa048e9ff30 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2928,6 +2928,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	struct vma_prepare vp;
 
 	validate_mm_mt(mm);
 	/*
@@ -2955,18 +2956,13 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			goto unacct_fail;
 
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-		if (vma->anon_vma) {
-			anon_vma_lock_write(vma->anon_vma);
-			anon_vma_interval_tree_pre_update_vma(vma);
-		}
+		init_vma_prep(&vp, vma);
+		vma_prepare(&vp);
 		vma->vm_end = addr + len;
 		vma->vm_flags |= VM_SOFTDIRTY;
 		vma_iter_store(vmi, vma);
 
-		if (vma->anon_vma) {
-			anon_vma_interval_tree_post_update_vma(vma);
-			anon_vma_unlock_write(vma->anon_vma);
-		}
+		vma_complete(&vp, vmi, mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
-- 
2.35.1

