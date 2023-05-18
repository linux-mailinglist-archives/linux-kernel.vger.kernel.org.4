Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41AE70881F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjERS7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjERS7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:59:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78361726
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:58:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6JDwr018330;
        Thu, 18 May 2023 14:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9UABu5yS7r9cjV080JpQK2DakF6E8hWKSmADOcCJ2pM=;
 b=M+Z0CJUhN4t0RML6X8PUATVfzQiu8n0JzMeIns3LvAvA+xwz7LSP509VzAfxtA13tsh8
 LFR+M0rZEB2B8EZ21HcJ24u7ne2eKJ7luq9c6meSzoMvOogZ9MHrEMJ+h0NuAHXsasq3
 hV9tiJk5aeFHiS8BdY4/884oGi/zvM7qSpG6I9QnZbX+GkiIoJr+8b3lXjmQ5liyknCC
 SYDjh/DC0cebeQzE+H7A52RH8M10BaoyAkjMOFLH1U4bVruTU8knFNWImrdt6xDhLBB2
 wNsW35AtKnGlfHO/1CtlzRck5WkbLBVoDwgln3XASBtrV/rsaUxlguh9mV50bGA+M9p4 Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j2vr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDUidF040023;
        Thu, 18 May 2023 14:57:18 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106mr5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZauWPGiJfal7jN5lGYNJCdguZn50BteXifs2orPmA7SU+VVOql0ROkFivnQb9S5d6MHgC3LCniOIVHL+FKlEuw1pahYiJe7upHSFaEtuizTHrpjRtw+A5amVq6Y9rrq1zganomUhM1cKCgNHYWkM/CPAZHRv+wGdqx8pxVIMrz4krLgvNeBoVfhxpkv2uDCckJxYLkyoB2rhiCjMb49NABiTer2a5azySGyhJFs0PeAnZhDJO1VgVpogR0IsYXmjEe6Bu+AF2k5+ll0lWO9yhC/EyBa0WA7msb3iPPp7leEI4MasCtDAqHUgfP/PoL9iZhJUpK7rvNnE6ixGvOMpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UABu5yS7r9cjV080JpQK2DakF6E8hWKSmADOcCJ2pM=;
 b=bsDwOreTZppXYnG1nFDOmpO6jNTzsul7FILXlC6X9qYdWDImcZl2aeiXs8qyF/EBcIzmRdAzv2wtvxEfstTeJqaFCYFd7ljBpOFwGOhSRo3g1nrQkxRtrS0m+MffCaBY7wqSFpX2qZdrHPF11xxj+Fu1qS0c2SuPdLapIL2TT7kuPUAXD/MqxCmhmfmM2GY0DVU75IVGXlQJ/LqLKzMROELkJV9RQawXAW/AfHZODYxr3hzbHVViFbw5qEiu0CdvmM/RTzCTKnRmU+HkTBeSIjbQNmjtoPmBnVcJwGIRJSdcq6w6rn7LebVMvHCPzoNedC45jfMUKxnjpUH2N5m4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UABu5yS7r9cjV080JpQK2DakF6E8hWKSmADOcCJ2pM=;
 b=UBVKT9Yuko3L/IoUjTbnJ4v7nYtvRIVx0Jg8aKU2N3Gd4ufGVcGp/WbVwncLjeToYtq8PtldYIRVJkWFpbN1QLskEVfQVTs5on/PDApTwzGhafqe600OlsV7X3HuftT9kEmQ9Et4/BOMWH6131SX7hUwPQd2c8oE0u4GNvoEiuQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:57:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:57:16 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 35/35] mm: Avoid rewalk in mmap_region
Date:   Thu, 18 May 2023 10:55:44 -0400
Message-Id: <20230518145544.1722059-36-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: cfce9cb7-3697-47a8-2504-08db57b02bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYSbvrK3Z3yK8R0dRCBEBK+zu3wYrU0rnLqQDPZtACHV883myCCKp9TawSfArSiu2s3WGR9farps58k+UlHaPbSdvi6g/RmXCK1skY10OGW759o7J5qVby7vDWu+bKLrndccwlC1KfytOqcEpf/C4oS84QJb6qpUn4OxlNQxQ8bklQS013y6H4RU55ZfEp7bkk2Xoy/FqTCy2qliUqJ1RHzMz84y9JNLRR/tAjJDjmlqGEvvLX0n6bZutPXBCuYJaUPweKchdS4LYpY8TyOIUnJnvWEMCyBMAqSpimzLg8wjwC0VN6KxDVFnwD/18vdu/3ZIjVRH+EuPRqeZBba8bTs2ks+ZupP8nbCWXhoKjSPCmgT9nt9O895XyraDn3DvyyAK2Nr5Gc36FnsMrWxyxe6BODE43dxGXsnlIrhbgbM1YM63ea7mJnRTqYArSLLzTgOrCYDcYQVVw8QAAzjhgYQc5ACpZ9CCpCu0egILBYpxD0yqmcAybaiMjufZwMdO7yTh7Qa4HysmxH9iJr4iy2/PUV1K+nsKlRb7RnzhvJfD3sL8clgpwO80qcE310hj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(41300700001)(6666004)(316002)(66556008)(66476007)(66946007)(6916009)(4326008)(6486002)(8676002)(8936002)(478600001)(5660300002)(107886003)(86362001)(26005)(6506007)(6512007)(1076003)(4744005)(186003)(2906002)(38100700002)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iTFJeA5nVfF8YWLAR3rzwmwyei50FAZOoDROR+n/IK5D6TGOl6/ZZBzRRJSH?=
 =?us-ascii?Q?jHzGfCPbo/zhoZuVRhoKUDuDEToMy4BHUa3PsAdGVt6ah08/hSe56M/VflnO?=
 =?us-ascii?Q?TZdWabVVWeYdmxOWkoCOztG1r0h2YW1iAM5IJxjdfD+KLxEmMI3GeGHC5Hgo?=
 =?us-ascii?Q?vU1nTg1qOOfWTiymkrioidmemnQJkqxZQF9JSghkThXJCYajzYD3IaC7pkcA?=
 =?us-ascii?Q?Xn43ZTGqZmvXL+rfvPFBy04SoZZ8mOw9nSWA0b6QGgRKieuvQHm+M12PU1Q7?=
 =?us-ascii?Q?X1kNCizpJM2NJ6elzuw3Y8QV05ijZ8uVFv7EjybD1mXp5Uc69dOEEsOzjRGP?=
 =?us-ascii?Q?sSUCZc6icxom5dH1ydLninUkOc7pLjYcu35WyjfhoGEjDs45VLRN07JMeNS0?=
 =?us-ascii?Q?R7tM/ILnbzL64DLVjiHwck2Kkp+N8LERKL3eViWLV8iT/vlhkOntzNgRl8Gr?=
 =?us-ascii?Q?8flzB2CG3basD6aZwUrLoUuYhWXc/u0dC7bwLqNqD9FYpa1Glqx/wzTnwgPc?=
 =?us-ascii?Q?jHQxsTQyhaQ0tAnTywQsNkDJmjbjqvQWeRDIevr/FxvVSJoxEEjvoWwsAg19?=
 =?us-ascii?Q?vbI8Ij4euFDhNGq/rk2BoRKVM1qtFm8AQfUTLqNPTBTEieXkjqCkfeeZ4OmV?=
 =?us-ascii?Q?cFBPP8xmhEJHmbLfmj3fBknVnhDdhaC9tygXcgonO7/3hn5eOHUCMN2Qp/NS?=
 =?us-ascii?Q?UTUXlF2FAXmPUkEg/0oujCNQaqkj6i/9xECa8j8kg5S8Nu8MSoKiTUEaE9cm?=
 =?us-ascii?Q?BgUfixvv3hy5nvSxXzSrvxHmpSrQTl4gFv5qSi3m80XhEXEAQ+LcldZtDmnM?=
 =?us-ascii?Q?umN6oQut2tb2yYeldEh7JvqTDdD4Vp7xZ53KJNzmfY5Ih5vDDgmE2BlTYV6T?=
 =?us-ascii?Q?FqaEBty0n4lDCgWFa3LBIF/benrsbHIuvkS8WV2bOWZ9V9N1g2PLN3EKqRrf?=
 =?us-ascii?Q?XHFfWGOJGme93RksRrh14m/hymOhcURuAHePkmfPBmC7xmFQcgtcF8nW1KGB?=
 =?us-ascii?Q?G9T+rUGjdqreMOKA2F6klrSd4GF47rPLRovoOcqlfhpLWoouAhOhB6qqyLhP?=
 =?us-ascii?Q?qkQuFlMIxHcKzjlAJP0CWqQno0cMFF8xKnLyLuHVIrFme3cWVN2gHtIrbd1k?=
 =?us-ascii?Q?lJ4pMup/9iSVvl03qJScIWjSvLulDpk0gE40MMzRJzA1dvE4E6ETpMbPyXCs?=
 =?us-ascii?Q?eHbRu8Kqlm1XQK8/ewFvkzYFsm4K8h2bsBBov0ylSEK4xv/3jlbBHI4HqO0s?=
 =?us-ascii?Q?NbtSdyLN88+mCiPpS9g4s9+hy3KwNEEjYj09IB6EaLvCrRkJjbvMVW4iaBzp?=
 =?us-ascii?Q?NdiWgSIMnSqspJHjhJGtqtjGT6bY5coCC+kNWQ+sre4t2EH2UvSQXxLd+pAO?=
 =?us-ascii?Q?xOJlqAnRc/1yRFTu7qPRGRrs5L9D4QzjOYFRsU6moOTjQpMZDLmVsoCW8pob?=
 =?us-ascii?Q?kZjT+xlHwQlf+LqMTyqfaQXUuEF2+/NZKqO0h+FIjZTq6joCcpz/rW2JeTDY?=
 =?us-ascii?Q?V0j08b0OgTiY0f2SLFBYYJyAESuCtK5pio1aV032a/KYZr5YFV0sajM6izuO?=
 =?us-ascii?Q?aPj35HqGrRl24qQ1GmF6Ieorpb3TEoWEAih8kCBq44guDSeKI5wOVuGX7M1s?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +/TDtYFCQTM2sLp7wYZVi1Js7hKRdFAmdPWf6pLQmcigrpvjSLuVe3Z98xECv1TywhLo+GHNg6hMHJOqxiGaWMM3O8KAwF/KLtGqUSAY5n3UpZj2gZdxkweiVz2CU9hgbvnwvg4LmrdgT3zB3GpohSfNevnFxMv80SR9TfUNjCsapaNKTRC6/bN7n1hT637eLSrlSTZbHjD3oncixki+9HNi2jcbPupvU7iMt11uYSDCk9bRet1/93rWfsSRZURO8G/26HnP6c4MDTV9O4Sjk9WXrK9eRqHiUSoIDGl2fjjY3D9z3iYXIhbkHzxmgBQGCgtxFk7UqVz7A0nanOATyc83qVzFqDLl+0mkA+H3U+I9mnjCovWRwrUH8hl1ZgfWrIgaLC3VJ0hMJU0D3C1M2MkXyygzXx2kZk2SYFkGbyf/mnnk+g6hdx1fu7Yo6IE6uHWThDgmdykMhQ7ifp2rpwYZ/BXf0CLs4+lH8Fm9pevKvlBOM+aKmLHY9Zg94MmEJ4GgZ6u0xm7wiq5hR9X8izHvJ0mMHl8C0RGne6x0xpPlKGCwEZ6WXB97EX57qMrtZVHOPpY8pV7sDaC3bH0La7ulNw3FYXbrDD2uipRqEycF/hpwXD2InxOsAvomMYbXB4aQX8g0j2AjpcOGlhYFUNWvFXAm4n9hJOmAyc5U47nN+/bNCvY74Jwbq6NOtFNstgirW8FhH1LJYZENU0XXpMfbx2ojjIFWtfS6wFMDHBOH1NcV2G/p7kNimdp0K+71owyesb2jLYxW8SGcDpTMoplskipLVixX9t5pulXk3VZ0pOUzSylWk8AmdfS4tIpwjMJpOboxa/TOmRUqQY6gbQv6BppXeFXJiNiQp3KjppFwXDLRIPDyyjvvyx2qvh4mWSv35XlLmaZFzfEgnPLrjA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfce9cb7-3697-47a8-2504-08db57b02bcd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:57:16.4847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LumWk34zhWU21TRFStYO3bdXdfi+nz5xcItQcnxPedXT2tZPA8rodAStO5IvjB9Z4bIj69IIJxlj7FJEjUtkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-GUID: 0Eh3hg7uWpi64GPgX6TGKt5oOf-HzJS0
X-Proofpoint-ORIG-GUID: 0Eh3hg7uWpi64GPgX6TGKt5oOf-HzJS0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the iterator has moved to the previous entry, then step forward one
range, back to the gap.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1602c854133a..71733953ff83 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2636,6 +2636,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 cannot_expand:
+	if (prev)
+		vma_iter_next_range(&vmi);
+
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
-- 
2.39.2

