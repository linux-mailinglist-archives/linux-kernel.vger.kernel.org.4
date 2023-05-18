Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E2708632
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjERQrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjERQri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:47:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB5C19A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:47:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6JJW8026300;
        Thu, 18 May 2023 14:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=H6a0kxqv5ze3H6E5XtAeQKjpADPWF+IvHJic3aVsz5Q=;
 b=J3HDBfzob2tK9yqH3mws7MMU3prpSynvoXx4DJen3IvjFn7kVgO/461unJYAOELES3WP
 aY4mJOe5OYQn8stj7IAffLqzi/ZGsHA15Ynw6WrUAif9q/ev4S5OqUk1Pjfooj3Ajx3M
 SCmJ9drjBEAiPheL1tNOZiQtWA/3HbrDlZXTYa8X+Wt1HF3vwKnChEQQdbdBob89jaPT
 axtRDJY3xAEzmXNADnqNEnOykGbBjm6cG5jYpGVQlgaSWBdVmJPq8aUH0Lq88XJXhjJR
 T1OGtiUjVyWnDrs0A7GwCNurC5XQ2GL6BZHUzXT35Y59G5FHCsQI05U7IbonupTmRJVo OA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxfc2ufu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IEEv2N034079;
        Thu, 18 May 2023 14:57:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107c9p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMtr+9YqJtKd+8MoJ7JIoBsF+hjcFTUYqtTc+Nv57NhWamhOBYcfviG/Ump9v4V4N8dT7pfUKqvZIPIFUdOrCK535dDuVV4kqdv0Dla9DwULhejGADiLV7crz03yzxeC9IJden5NawDUynZ6pCMI9kbT9GyCX7tunjC7NGlCN7NQO5V61dgeqB2SVx8hIqyjgOQV3gRSeWTSdMHOYyCUu491IIaNL1mO/sqCEKvNbOTpnmMcPnLY8qG/HehI/6tMw5CNrAOfwug+E8zGvHiDuRV+mbt2mi5a1anQfMf4O87znAaSupO4ktzKyU31taRjS7Kz+6U10rV+dnpQwMuSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6a0kxqv5ze3H6E5XtAeQKjpADPWF+IvHJic3aVsz5Q=;
 b=U0+HZEa+UG5ykpZeBbcV8VzlewYJjNo6n22U7wbQmBDYKeQwIKcsqzJL/khCUVwB/R63fwkgmQt2p4hfOz4m0PBSk/tTTjXQ3PdEWMir2wimHpbwaRkBm5px+L5EgRgU94T0mGsAz3QZ1nNR+YgBkadRNcGLaaiAk4DyWlldMHUXScP9YyTJwJogvT520M6KcQ9J4CRLd7JJfsDOF5lFxiVdLshbp6FqHQqTraz6VP+loJLX3yNhA4iXtp5DsTTvTWGBt8ikj3SikwlYnc2s1udJLz8lENFAHThphI0D5NNWRqbU6G/LrIfVnGcCWg1iV0cHkkc6/dg+i4uMgmSsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6a0kxqv5ze3H6E5XtAeQKjpADPWF+IvHJic3aVsz5Q=;
 b=LyCFD16lus7PXuT+Bk1FuLyhB0gYUWjhiyLXmVCf+3CkSstl83gHp4S7+9sLS6CeIOjxDaoNs2DZ1rvXKG6/Qa5Wsr6dXpYb9FrUqWKWg2Fe4KbMLJUsDxEF86T9+myqSAHA/pye39VXHHWlx2m5gnWFhG8kv01SryIqRAso10o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:57:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:57:14 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 34/35] mm: Add vma_iter_{next,prev}_range() to vma iterator
Date:   Thu, 18 May 2023 10:55:43 -0400
Message-Id: <20230518145544.1722059-35-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0409.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe4fdd6-4a93-4f83-9ef2-08db57b02a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnwz1px650VVmUFvKr6kvKKBxeziT05w1+GzwQK9Hv1Iml/gLxqsJClfZjWSnGW+M1WmncoNgkAO+ddVHG259hh8Smf3zIlJDpkgsR3cm5rwg6q7kaX09s8GQjR4v1KnmGV1KgxAyl0zqN1XtBGRqNGp50jHMeWEtufw3NIpq6N1Dceni8X6pLpXOwXiQ6MjarFHVBOOPE5YIsh+/U7ldxdQHkeDth1G3rwo4nQoHOPs6Ga4CRMq7dqqCcZVphCY/g4978llGbaTYquBs7rF66ociJgIkkk5xXK1tAPLRUOSFEhbkCgGTc/K95kwycsJawHF2B6qkqKXPKhGmtkwt29LeGV/pT69NEvvJLaO9E88pUzl2GARuxNdrvlsAWBTFa249toeYeHK9tg9JjEtNyK2M6Qj0r9CdbtpowWnTggi52kFYI3/UQJd6WPS0NfKotyMHruVXAms4K8jhv3xDeeBoIaXiUPiJyzy0mDyWlZLKLPTMg7fW1ZbX6QUQaLof6C4bwegwbRzoYUEMAnV3Y7cxBrZKEj3F0OWyyOxqBd3C9PXzY2FJPx3mzZK5iBU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(41300700001)(6666004)(316002)(66556008)(66476007)(66946007)(6916009)(4326008)(6486002)(8676002)(8936002)(478600001)(5660300002)(107886003)(86362001)(26005)(6506007)(6512007)(1076003)(186003)(2906002)(38100700002)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p70Kk2AQHvE37DAeXDjCCXTqvIPGfvmcVv9IjqnwuPIEjzJO/tgBvHE1jk2b?=
 =?us-ascii?Q?Y1zhmqLOBDuxXirqi3JeVBe1/yow0IfFhCpxfTzNAfuItr0gA+rNOLh3p+0X?=
 =?us-ascii?Q?GnOAfqzcBz7nLKw3uQMZw3BNiHRyhwCYftOk0v64sNNKRkt7oajB3t1QE8hh?=
 =?us-ascii?Q?ZifpJYP5Xt7etlaBzpd9eshaZsBxzaUmePkP46i9Pm7a7w2GZYVZNCEohnP9?=
 =?us-ascii?Q?xqQ/+mMh+mWMSnDWAIraiyV6RahnjvmYJdDCMasrbLDVNcQLCNW7TwbxX90S?=
 =?us-ascii?Q?oglQwKCATDC02kwnj486wBR/RR0fqS3CJILbjqNwMhiBrydShen3s66wYi08?=
 =?us-ascii?Q?aR0OEmKlWhVP9JjBYDSQx5JcD0sTOmOJ/wJTWTgo2YzRmDHIX0VEbzoNhBJR?=
 =?us-ascii?Q?V/sPsep8NLpQq6TojuJFwt1kTjfnUWosOcvybMJ6bS10HqKm6z4Vh3/hVhSc?=
 =?us-ascii?Q?yBtFidQx4Aa5g/ieGA2sGQQE22b+EPHKdgzfXShk66Tfjx9khL6UrlV938/m?=
 =?us-ascii?Q?4hZFgrVjPABZEnwQ4146pLWVYhmeeFjI3JufkkI31JrBXbuvQbtyJ7UutPdF?=
 =?us-ascii?Q?qUFSGvg5JvPRPMDJxros81X9Qot+6lybdoJwE1vlnzqhLlVGM6pOEDSTFvtw?=
 =?us-ascii?Q?9320r4ncFflCKFX/gMujI0dCojW9AKku82cPdSxVHkEuZ5ExC/EdDVk69HYX?=
 =?us-ascii?Q?z4+w2oMdX6688jzR2f3XeOB5QjNQGgkchDLGWquOQonLhAQdWznXuqn1W6CQ?=
 =?us-ascii?Q?fCSJBn5CJNHhHT0hnpGIa6hbiMKuKBuDz4BP7jP+jlogz1kqduhmeqflYOv7?=
 =?us-ascii?Q?lmGrMkjhxE8U/fQBLZ5uhhp/0Asz6vESUih4jGDGsKoMqSw3KfUniJ1HFnnH?=
 =?us-ascii?Q?QnQmafG6QP44f20ei2tNgmzsmFooBZOL8hIu4BbP9qEUP4Ld4cZ7ENSw8yBd?=
 =?us-ascii?Q?kQUHgyLbrHNNLdUlGACM5VQgGcK85NKZ/YGXdAdmF2OGkdxrj3X0meozqzmO?=
 =?us-ascii?Q?KpLOHbUaDGLJ9jLGgrYHBZUP24Ir6foABtrhsKCn00iVdQizp+yz0sk5SZjc?=
 =?us-ascii?Q?W1L95fUD0Xd7TfgZ5EXpfl38f0g06duBcsWhmxQhxWFcR+ny6UBtWS1D0LB0?=
 =?us-ascii?Q?QRw4L9YbeT+mdKensGMTBezokw6mMAT31NSYz8pOPrSJzSjN/FSOR0vwNtTV?=
 =?us-ascii?Q?uewYniKt6AElBfhZHTW9SPBWQjq4fh+Vz4Y7fK9i+ToFlyXMLhwNTMrEZPkb?=
 =?us-ascii?Q?WYTGU0Gjf6h6wL7Fy9MAiqaDU5HA6mQPl/gjVcwEqMuNgcZAf596mi/YiOHA?=
 =?us-ascii?Q?utiYiGBXD+A6RWmN3WHSPsdc6dFJeIT9GXGQozfccytYcqd0PJ8bQl+UKXJc?=
 =?us-ascii?Q?UJNr9SdnNUYs1bDE5ofc1jqPp4JkYbwbvcXOJLGYJZVXaGDGKU9tyvvYMySH?=
 =?us-ascii?Q?glanekwvW801EOuDDpM4fjPDY0E9sxuYFCSt3OgHEKzurDcj2WxiBhTbTUNH?=
 =?us-ascii?Q?PBaOPlNEnjCsS06zAeEh5YGWAPwyCYwJ1dz7wmstJiq2eYAezP6iHk7qep+F?=
 =?us-ascii?Q?mqYpjzn4/s1WCmP7IzjyBgbKLpdfXgbIQOZcA14eSrmnZm0hdBIRGJWSmtKM?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d2Kv/YMUu9qXkQ1WCLDn37cJnm3R45v4LaTIWBYmOF0fW4U5RcOAzrFc14UOAzDqURWyh7RQC0mweKX8Hnmw7nOWtd3rckBAjhQMkCnezhGzIoCnZ0PsE6xULP3x43ud7hmXsrT31Y5GhpmaEy1nhNfkJ1zdjBY+PUgghLYQ4+j1Xekb3+8g3sPcz32ld7ZCR3259oxdMWWxXIwNinKya1ixsyfF37z+gjU2A+pj0WASn18+HQ2tUgVUASns+8k8IDmBok1OmuMmtMhrU/z5SDDdJeyicVMCvNWT/7tKz535JgNLQ2MDLFX61XCqNQO2pQLAFRxJF5YTWjTpEHZbB1bmAaeVAf5U529DHh3fPJGF1JtEp5FiDiHOyZBvnAfm3aPqYq8njywi/843RLBGPDqWQya7Va61JWG2Tq3nGoRqAWkaDgrCmxjNU/vgwgiv+gVoEZci8CCMJjNIRBVaQsEXL9ET11GnDS8OkZB8W52WQVEQoVfGgeLPqdt+AwUqDBG0nJ8bds/dUpRqwM/pL+M+52hvbxnmPUky4+1Qw5NpETjknNr8xmofZIHIkZpriTUo1nQEX80gVbGW1FUd2+l0gRgbgSW6tWGlcnMUvJO2WpwoH+hJ8Hq9Ke+ISFbzczVkYfbCjQRNryptALeeQ/YB9jFx+ifCuXbA4GL+rzXrDWbeO10RuaTUrzqCCGPVPhD9wxzkHW2SVTQ3vXyRIYmgDHD1nWJ8TGXMbb3U1wr3xD2OuzXF3Q3I7uyTXIBQYCh9GBACCWXXSazRbqLfeigp5QZQaSp8rvMivnfdOV8lsnnbl+gQGB+JqcGQJe6E4vqWmarl2iOZGnbnoGZ5q48cAWI+uRZpcEe+dQSvE9kJc3cYE+/2zdEMOVKE+gH5dMPVU1caYypWax4tSgCT+w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe4fdd6-4a93-4f83-9ef2-08db57b02a5b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:57:14.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hvnfBSdcjKHXweiF1zZ4CGx+p0akXt/QFuw1vSVRO1vwvZu9srsx0qj21BmSGmCPj6C5EI7AQ/haAHv9ojx5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-GUID: U9OW2C5RdSbPKMUYnNfEMCI8XI-lXY-W
X-Proofpoint-ORIG-GUID: U9OW2C5RdSbPKMUYnNfEMCI8XI-lXY-W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functionality to the VMA iterator to advance and retreat one offset
within the maple tree, regardless of the value contained.  This can lead
to less re-walking to find an area of interest, especially when there is
nothing in that offset.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1d4e7393ef..1bd731a2972b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -866,11 +866,24 @@ static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
 	return mas_find(&vmi->mas, ULONG_MAX);
 }
 
+static inline
+struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
+{
+	return mas_next_range(&vmi->mas, ULONG_MAX);
+}
+
+
 static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
 {
 	return mas_prev(&vmi->mas, 0);
 }
 
+static inline
+struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
+{
+	return mas_prev_range(&vmi->mas, 0);
+}
+
 static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
 {
 	return vmi->mas.index;
-- 
2.39.2

