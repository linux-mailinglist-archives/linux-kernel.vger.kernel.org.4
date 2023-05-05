Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2C06F87E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjEERqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjEERq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:46:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BE31AEFE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:45:48 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhQ8Y031799;
        Fri, 5 May 2023 17:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=MMuXGwzfr8FrXvMOM1JZ8fiBmFIW5agQMabZbUAl1DY=;
 b=i/tnCyNtjr4ykPY6+rCds6o5+DOeqfcKE4T+D06KzNbH7LOGLYZ9OIMp6uUJhFXbL7Hf
 Ynl/fjpH2rIj6RzQWJJn06FjakI45spuI2ZnM37ov1HPpooxf6h5Ca0SrqdfL+k79Gp6
 soS4fSoHnKiDQgNxY4okVOnsqJ5JNTU617BExQnPblBAG8WXfjKOILXZznCGkxJxr9Mz
 Qpn/e0BdZnuZnJUpbyhpo3V6OJFvlVbuhWN5GalhmnoPOrwgxjH3hURsJfbfUdt+AJuA
 a/AVSUG9P6sSYHOlpYZAGgKHPioEDsFaUYfSMu+5iOl4Wqv2hmfJvVc3mxgdc/rO8kdf jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d5net-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345G4kiO020786;
        Fri, 5 May 2023 17:44:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa5fkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AH+P/Igq3lFtZ0O0GiYnzWCxv3nwfBGKdNaTqWgjx6dRrTQlxauZTXm3wodGHieAG9T6yDexK2mrgzxthfjPcyFVdTbpK9w39Hn1TSQYwej/BFiRWJ6JAyR+tSPhA55TOLXKffyFDuYwfVspqT9bnj7y5tnjeQVmg4245lzKhbXDd/VDFgjg3RLSxMAR1V2ZSwl/z5mKynM7q6CCsq2ku9kzRTSnczv0IjJQEFYOlaczEfsfGD36l/3uFrImGHChyZlcnyu6o17TZa7liEBaYDI34bmUatx+pkIuFW+a9LZ5nwCw81ceHKf2WvSZCZTWchDyo2FI+NAQYktCIkvsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMuXGwzfr8FrXvMOM1JZ8fiBmFIW5agQMabZbUAl1DY=;
 b=C+NQc4a0G59ltkHyvv1g3pzxgW2c4HlgE6ubXun2OwYczTfxlKKL8c6LBfFAUfilz/yvCIfteL3p+mykjk+ygDnkruPtNi48KA0mgoUFcE4+WvM/cSGsIPGCWf7XZOrchkq50QyDRXByp3UGDlb7e1jXZgfjIyLt4Ohb7Co6pR+/3opP0nqDIUuGo3/8nSoaF7LoXoMPz8xXmrl82hHbMOLjjl9MjvGXiLx6sLbn26CR/5EqzI7Khko3jx93sxg+kz6BcYWvxIKYHHyeBm+qUvwQtH+hKBWU//lEQa4jcXYXrMcme0iLxNe3m9R6dO5Hn4TgO/IhDrRAJ+bTL9vutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMuXGwzfr8FrXvMOM1JZ8fiBmFIW5agQMabZbUAl1DY=;
 b=dArBrOQklZ56KX+wc5QXNDv4c/vddk8TELJCP1oNMOaWTRGsAROJ3UAFAXuyc0ndsVyNx2lMhXC6y8TzjaAp0sHPd27gXZ+dAATcdNnXc3y2ZXN+Smh4m8sAG4s/1c53/TrQ9/8Agxk+A8JA9b0SNo+xFe2F36RXiB6ZW9Oys/M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:35 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 22/36] mm/mmap: Change do_vmi_align_munmap() for maple tree iterator changes
Date:   Fri,  5 May 2023 13:41:50 -0400
Message-Id: <20230505174204.2665599-23-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d70230a-d0c1-4412-d9d4-08db4d9063d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGtp06hLuIOkKsm+bxPDffCBzIVPWEjHaJmrnJLDorJ6B6CYvhvQlkrmtFNMVNiwELr7SQsmFsjGsW09e6o1KP4MauwWvUVGcZOq9hMbER1iywfyCASUHO7zhZwSA2iSZc6QFIrrwG5mN/BJhVBolwgSUdJdBV27kJb5ZQAYk6+0Qri3+Z/aE1RCf6hvrws29U1SJR5/7yB7IFMKz9iYvWazcxkLC12LY0nQRUyOgbtbL3iiPKnr3x4W/O3C5518vjdeg1Sq4z692C89/RvGqZnAXQeOi5sRKH2KxlranZAKg+l7XdGPKAtPyiu//MA/jrEMi/QUl4Q9ZI4/jJcGQA9cjhtAV9TLqRJ217g42IrxchwpXjFylFliFkBUmeGXnNcQsccX2dQrbyYe6Nz4NdVBtFGSA8HWmS85/CmTxnl75gzpoCKOpwMaHEJBYYNi/42NpKWT0jdvyqoC6+Hp6jvTLefuBv1+mcRfGtp0jQoALZZsz4qix+Mm/OyvyTQpiVFh2ktMxpETJnk7E7nI63/GhAleyHT2kkvHw0l4F1ijS1B/MZshcaQTVc3LgH4j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6666004)(6486002)(107886003)(2906002)(4744005)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jjnhliEqt5Z95QlRJfFNcuqn1frnleBM9Umv24xq95sF3qYa2uS2L3arYBFB?=
 =?us-ascii?Q?9T7XeY9GOLPgyifH8dpO2Jr5KuYL6sP3cfcxX6FAhUGt7/9ThzQRG1HJQemO?=
 =?us-ascii?Q?xQNShO6jfGJ02j5+w8752qMiavVog9KiEkYC1LIPSZOIgxOKMXlK/9L6rMix?=
 =?us-ascii?Q?mBeI1ImHHGEbTUS7L8IVyi2tcq6ZERNou1DbQ8aLbIzcOTUHsdJftX8wkWkP?=
 =?us-ascii?Q?oM+1vKZwMBL5u3UsRzCALDsjdE4F2c7piSgyP1AfS0OoLG9U+AAyFA4vzoM9?=
 =?us-ascii?Q?uiP0EQpQP3laXPfPDvtlGr991nccoQ5jHyOVuWYnjX1WFZQtEgYKy6VjTv+h?=
 =?us-ascii?Q?TxEIzDf6draLfzkNJo9Kw8y4TJcDt7XFMnewQMFDVDOhqVbIlMNFNoumhlO3?=
 =?us-ascii?Q?Z01aifrsdhnXeXj0a+WI2aKli5B16/IgnrO1YPyK6XZg9D1q3DNUO6cWkI9F?=
 =?us-ascii?Q?GDscbqywfagOqy68t7yQ6w6qyxmlapUUMMSusEATRg4K5F+wKyGABPOs5ZLn?=
 =?us-ascii?Q?EbVcuub7efCvy/jQvWj3oQTopB7tGEr1ukfnQ1VtZgv+Zzmn/CjEs3KExQcw?=
 =?us-ascii?Q?LKYUg8Xho1MOenmSwOG/EhGZ6Q2FXz0AL73SP3F6/vQncauwe3MI0vMUVrFB?=
 =?us-ascii?Q?jSgQO5abPOnRO6t0b4xlGqD7yXbVEuNUlvVTjTzEiLXj16mNDjImhe9OFW0f?=
 =?us-ascii?Q?ae3QZf2R5CKn+PzCGsswiK/vD5SOjy7QczRV4w4KRkQu35JmfwVGKbXWah6k?=
 =?us-ascii?Q?ifzRWJ/K1lvgmCyB0f/UtdBW1MZYuFi8Hi33tlBPf1/rGExm/q+oooFBx1JB?=
 =?us-ascii?Q?FiYTM/OMOM9Cbw8VtR40YKa8Ljr5gMUds6s0ED+aCm6bgWAsrQM44EqTKKTC?=
 =?us-ascii?Q?k5mGm7txlYCSm9930ZOVMnbZAGUJMBghi8GfsJnBSHVLsTVZHUuKtXRM9KkB?=
 =?us-ascii?Q?e076BCQG29XD5+E8QC3WlaxpBziA87baD8oq0zKSSwGMjbqS1qEnCJ70fwXy?=
 =?us-ascii?Q?w83SYX+IxCwIqMCyq4E7OyUM15AqBCX22KpOjmhet4arW/tzgWMeXNZajCtZ?=
 =?us-ascii?Q?LNSQCTzLZrcxbRl7nZxrplkXLif8q+OKMqZqdul29EFLjSUaCchliyUaArMN?=
 =?us-ascii?Q?MIN+r8xzAiez7flOmApQslieXaNA4t9KT7EFEBMrF7X5YCTrMyC6zuPuS6T6?=
 =?us-ascii?Q?blvjdkuKOJ9JcgbaLKmoB4/9Iqf4lVTBqvsjp8iNlnZso9y1o6KxI82uELj2?=
 =?us-ascii?Q?ouLmpo2c1oFsqTzWm5+MlTzHfpBZ/cUAVicMtkVi2cgXoIZjn4ECHpGgKrsE?=
 =?us-ascii?Q?z8RNx9eawhJcdBtAgI0Zn64TsK/xtN5GOG8xX2pQUzO8kpSkxSBHB0kJ6iw+?=
 =?us-ascii?Q?BNFyNgZkld+Yu9juidfIaQJ9qP4IpinXE5bBgBm/U+aT+030oemPhxO8wnfk?=
 =?us-ascii?Q?PqGoBJH2GwKm2LZlxvS/kKIvGZixZNy8ph8UE16OD4dyYzUxC7AbGVXF+y6k?=
 =?us-ascii?Q?uTPhwtw0z4v09kPshixRl1Ogcfh+s6cfq2QOppOB+aLRdltmAGr3Vn7btVag?=
 =?us-ascii?Q?lIIwYA0DzLm3pGlc2B60IPK0DEe2DQkeiwKMu5dBf0xZOJZaQTwQkRzF2xNs?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C/IE80HXFEShCCZ2K5Gaa2bVmDVKJ45b8i+CupovesCMQlpQzQQmWGFUx1xxcdXwNDU8ZT4Zb+uU1L3o3VlisRH8f4hU9l6JfF0Av1+oVxIMTIPPW3rZxwzA8fEvnXEeGZcdJaPwBS8x2kf6roQWi0cel2XMeYMNVvGGDjWsiwGJBmeJ4A3UV3rQn6q8LOkjJFkalTnCYtX+UKM7Zel2fP74rLCrwNeifP6mf5Gr+jaEJ6GGZEJOQ1JYTDATr20bTnhbogUfmfqofOPu9/rYnDIhlHpPtVNcF0sFKhJ4lzSj5gMeYp/zyMoiOESwIjhdDDRqrsA/ZWr1MPEqqdaHTUhqffdk4+/RVolHZBNSlrq5FGYwBZxjLG4EShMRyT3bWK4O2LfRmdN6w1X778B7AZhApljcSKPPB5DrHJOGzfSnP6kC3Jj0+NLh9dbSHQvraZ1WMCdhRhErWEZKxkwyBPPi9SrNMF0tVqI4GXZ6OGVblTeQDV1EYClfkqftN+q8ggrYVH7I/T7QesJp8kiRorAJ+QdF1D9nK9kF1S6MQILHzjM0HaRiM2PxyQvCa2g99xzmpwimQsjYXfEe+0dHVuD/cEBU2MzHWdjxOlg4kRxAx8akGqagcvay2iKknvIhowotc/gwme2GXzBzP1S6X/1pfxTeMELZoA+QnQAIH6/k5kgLVP1etxGYcLLptCrulfuNAH0e6P1HOX966VBXSQNCMIhXjqVLBU+9alIjH/za1iJ3jKZ6gcxf4S/aekgzv2Mkjs7UX2olEk4k1h1ZWM6LgTT+RuF2lbDRUpV0hGW1q2rPBN6BlXGxmxQhmCIwLcV70zFXmGqG9zEaG8yFCbK5LXpM1VOa3rhTIn2QHCcgPaOBbf9tzI3am4hqPUIqyqorRZ0V9MA/CjRYVr26BQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d70230a-d0c1-4412-d9d4-08db4d9063d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:35.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEFMpF6pbkTzZGl0ku2ojV7+cqXcKKt1u5qloQwjrJ2XTTtV/4Oh5Ao0CAGzhdHS+MoSBlm6c/+F/qjL1vc2FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: OjPz1oIn4gmgVkkXeLOlFTGQDdWdKwJA
X-Proofpoint-ORIG-GUID: OjPz1oIn4gmgVkkXeLOlFTGQDdWdKwJA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree iterator clean up is incompatible with the way
do_vmi_align_munmap() expects it to behave.  Update the expected
behaviour to map now since the change will work currently.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bcebfd9266324..1602c854133a4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2418,7 +2418,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #endif
 	}
 
-	next = vma_next(vmi);
+	if (vma_iter_end(vmi) > end)
+		next = vma_iter_load(vmi);
+
+	if (!next)
+		next = vma_next(vmi);
+
 	if (unlikely(uf)) {
 		/*
 		 * If userfaultfd_unmap_prep returns an error the vmas
-- 
2.39.2

