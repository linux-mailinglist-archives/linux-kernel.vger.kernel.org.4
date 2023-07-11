Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3685A74F784
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjGKRux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGKRuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:50:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9B510C7;
        Tue, 11 Jul 2023 10:50:49 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BFSJ65009120;
        Tue, 11 Jul 2023 17:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Rt/4sLdDmPq66oPK56lMe3m8JmEGzuPzXCimo3LL5wQ=;
 b=U3BvEiema5Q/CjSeSOT6gG31iqDVVbnTuGC9ZYtIoDbxd+tIl9W9adpMJn8tHZyZWg5g
 Qo29ZXf0ciCAWh6M2bYpzMLVk0aVFD7bdcbpw67nA0uIZ/TPxcNrF6Bzfr0uP963+moU
 xxlvgCj5jtWOWLuUvX4jKnFU2dhHrJdLpHMS5JGHht7MTaOFnz9SUNo35OXHoEx/avg4
 s0OS8DAxOzVAzCt81jIXsCWrcx9F1lShygsmtlhiudzpNSGm8L6wVq3PkMlCuZIFsoUA
 dFAl4O45eA50O7T4oMsBPfaKNB6k5gaPivLoyqeLjtTjITt+8/dDKweOq+j/3h+Eiden jA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrgn7u99e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 17:50:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BGUdNG008276;
        Tue, 11 Jul 2023 17:50:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8bgdmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 17:50:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXvhtdfUFlLaJwSxxr+JryYhNQSN8qY5KdfIHaNJK8gzbSEnb0kW3gJD4tGq+ef02x3vfvZxs5BN5gTugJj4QItVR1Y2bfG+H0CbrLMHUvcKUt2Daa6zthtwbOe7ANizery9mzOcSx3NaAAmZV8avSVkD7z2thec/g9a4PKRAu+/b13JdZqY5YtUFsxjmYAdHowc1TSDHn2OjOMvqYRRcaAeaYiuHdeBAbi6CGktJ+Ow3mnUs7zjLPzFGc7jC0YxhbIPUXTTqFGnqIQI8foDDND+VS23vyQ/YTVp/mHTH7NW+NjDGzcDTA3vaYUJkCNXjW0sF1SNRm3LUHrBuu4SWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rt/4sLdDmPq66oPK56lMe3m8JmEGzuPzXCimo3LL5wQ=;
 b=dsDn9Kr0pTcexTUGfBOtZn0E8WNIYeEPCP0l7wwanQQ0TjmKSFEiqIuQQJuQJz3M+ZYIkuuwNNX/kQf60chypM8c3Ptram8tvjDVDWtE9J6MDBxsbgOg8+E4UfTGs6SzxWnM+1drVgdBkfNKCx1I0CiumWz/hs7zQNqnYS43n0/7GICAKbSrn2wU61VY4BCbA3Bl3uQXWVPT3fz04A0PJk3oZujGJ/rFWnesdIIc9LyErACEOrIvs9z3zwJzd2q5+UktXZax0z8AbrrpZ8u5Sk2RRAjeNzO6ID1ubqWZ2iIwO3h2ZCv6ygC1We+TFS8bom2iDsNBzQYqR9tS5AYWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt/4sLdDmPq66oPK56lMe3m8JmEGzuPzXCimo3LL5wQ=;
 b=lNfTaOrAZawHrw3sUOhaC8jzEWkY5rLL2ZmDyoUTDSfaBpiSE98DyYo6trj6u1JGd/hS8q3HECJDIhZMqBjGOLUjIpzvxkka6BrnHzXex/Je7qtJZA/rHCFxQD0qL8ud48Ixt7mBPcvTQxdGhceRDy5xaD6+4XGL7ePqmqc0Ics=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6802.namprd10.prod.outlook.com (2603:10b6:930:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 17:50:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 17:50:37 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Ryan Roberts <ryan.roberts@arm.com>, stable@vger.kernel.org
Subject: [PATCH] mm/mlock: Fix vma iterator conversion of apply_vma_lock_flags()
Date:   Tue, 11 Jul 2023 13:50:20 -0400
Message-Id: <20230711175020.4091336-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0373.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc972fc-3971-4698-4e89-08db82375542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFLQ51ytCaQD7Vlq0vOJK9f7LPv9YwzdbLqtK4kpX87sHg7FNmv4xC/lpB+b3svtfRV8MwKmjjafmHdw69YtXI5SPJq3ZaxK80DAEFXN4IPj6WDhFgdj3flPI1y2VLRbuPnICZiiIMEduxSwTZxuUfl3F1i/S0EcrRllA5L9I7qj+rUpDLrkgGrLraWdC9fH41vqFboptEczzqx55wOcs+cdIzVowDTxZUS4+DcxQSz6c9LZdNJ6GvRfU68/mOd4wO7RRCUkDXbfqcPG18L9iVD2f1rajn+wuLlq0Jp+O8tF+uJ3fsulGVOR9J2LtdqH/4Cpx6mPyGTZKhOzgk0e7B1WMcbscJWFfsFFnAqFWS2wcWLmvtocsah10h06MOwPeRkFMid3Zz3NjlBDDje4aH0P++AmP6HzUIJhsxpv7BOWTxBtJXTCmee7o1m+bjmPQ+w1uQJOtN9hkMRp2dHTElo6OwdK0CUopFtSVbm/EHdVbrDOx39SL5D7qDeuq2KFnUX0vWJuSSBFX94ENB1qnNw0yUQeynD3kzlMXwoxS1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(86362001)(38100700002)(36756003)(54906003)(6666004)(6486002)(6506007)(26005)(186003)(1076003)(966005)(6512007)(2616005)(5660300002)(2906002)(316002)(66556008)(66946007)(8936002)(8676002)(66476007)(83380400001)(4326008)(478600001)(6916009)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TYh8kVxB4cVoTo4+5ulvQ30CL+ECy7fZ3zHAHUrsqVJtWhp8UoRTK9Gr6GbG?=
 =?us-ascii?Q?gdHyvDxlmoLa/AaYryGGasLye4TnQlRq2BJoIZdBZc0PEaXVgTbRqdO9kAyy?=
 =?us-ascii?Q?ZrMZupLafzUWqFZEgIAdE8bwooEG4vCdJxoLWIlWX6KNRf6qB160387I2svL?=
 =?us-ascii?Q?9cAqrho1DMbuhbxM8P+8b7vIQ6LkKzbywjrVmpPH6hQ19Pp6YxbkGBgDdiuM?=
 =?us-ascii?Q?aA/1buurnuZbfw+zEEfviGRtapubxzOq3FfgO7lGTvpZLEHpgbemjo8xJRRQ?=
 =?us-ascii?Q?kpsQDO0JmqLe00xUTu1VKVem9/IcX387sZCdw00Z5QntlmkiYhSrt+Kk/SzD?=
 =?us-ascii?Q?mK33ofyLxXRz7K+qIx3v8cq8ek19z5ZUNQbCN6EwjYCrIWHQfbRuwR3Dt943?=
 =?us-ascii?Q?WSG1akurmM7h/3H3AmUqaSGzkJ/LzWCYIveOh7ZQBXIGhMURJjclafVt2mO/?=
 =?us-ascii?Q?w9hCHBEgFRkqA2FTHtQM3WBiera31fI4vh4Lyhej6tau6o8vLR3ccoazLJCG?=
 =?us-ascii?Q?Y4qNnxvSk2FUyoZ7zE6s0EMfCnywss6QuvYjUJVoEiEy+iI77YUp27ZAdDDL?=
 =?us-ascii?Q?fwtwu9Jdf6gMHlnL2+4f9vYS7GN86ng9jE+Gqup6Vi17bjFJrh8skFKPeo6U?=
 =?us-ascii?Q?or/1EMhLnJ5JSm+7RU7GdSDHD9R3ffaqbgzp+u99WXRpFBHkCmQ2kH1tzoV3?=
 =?us-ascii?Q?jKJESFHmt9AKvXEW9VMGbdf2axMcnt8ODKWjsCNhF3ENgidl8sRm9Afg53yY?=
 =?us-ascii?Q?yOSCNiP7gGH0qRmXezlnvU8BPhau73M44By8oOPt3NQOnYRwJ71cA1Xbed2o?=
 =?us-ascii?Q?CmCZ/z14V3zj4gGWtdIIkGPRv/xomlJKI7meTlgChxg17aDQ6DvaZzgR0aZe?=
 =?us-ascii?Q?hFIJKWml++EP6AONL/wmTGykb0bw57j2VzoMlpZ9eTVvsaR3IRbdxz8lSRzz?=
 =?us-ascii?Q?9Ij4sKh3GqcUMQ8iNEl01buUw3LF2KZkQk7GdZRcIXqUjuv09EEmp2qxP1RD?=
 =?us-ascii?Q?SsUUjQr6jUfv2DAXXHMvLv/dw5M7ly3/w4GNcuD6WCGQyeio9bagujrs/Qxy?=
 =?us-ascii?Q?AadKyGYwXLiNcShRPEbKNdT559yA3YOKnt5GjaVKRMF1DWHhK5anBF14Or4E?=
 =?us-ascii?Q?lsxpvKVGXj4tRambAxTME8g1ilLQ0oyfCRvK5cAAieB+N6YP6MplBshI8kLX?=
 =?us-ascii?Q?cK0Skb8WUd/+1k93HcOhv9tFWl5MxY83rCKYUXk+MlcLUA4k/A1RausWGUQ8?=
 =?us-ascii?Q?jc2JuQ2nfjWvps/Qcn1KVUCQHkWxPvH+QAlCLRhridgnpE/oUrL47FuQlRDV?=
 =?us-ascii?Q?3JYe+uGb+ThcgWq8EXV51MiH6ZmyDpCoW//tt6vlqvjYnaE5vszAx3pdzUQx?=
 =?us-ascii?Q?53/vdQzHPKIHzozKXPWD50QuT2wSjO5BtoXJtfDQXbe82yrt6PErSsHFhqFA?=
 =?us-ascii?Q?jLU3UxAtP/vH2M+2fUOy8Lw60uGZstZ4lOWfP31gb572soPwbICtv46ufDuw?=
 =?us-ascii?Q?YCniB6dUKaDcgNMwoxmW7wXBd2d4tTFZO4eILlPE8zB9twS8gSx2UgFgU5sD?=
 =?us-ascii?Q?Rbfv7z4j6MKDq/FVtTfbYbGtRz9OlhbiOEJkd4cFzYv1gLMJNJgkVR2BA23s?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7CE6gVoPvMUey9cYTZ9vrzigvY34JJhnZZSND1j2cQSXaeF5XyGkB7LjMqGkWm3qgE4va22tR8FikLqQ7cef/dX1nVkMPJvNXIdWQH6J8w6Df7ewCT0kzmZDJCinfGHSBBUejXq7VN0wDhUwleT0Y490c4G87svgH/erCQTaAHmte3f1OBHpuiSaEIKtFsI1QKaM5Iow6KDy7KmwFiLv8GmsUW7EkqgJdiNjDdoqAnTE5qw+jIADOD8JhMM/7B1bw4n6zDrE6BpgwmsOysMt2zEU1XsgSiadyhXKKXh5+mwn8GG6P5VZYNzbt16P6PJjvjZ85tOKLl5sb3fR+4yVxy38xJ1COLub9+gyr19swYo5T2wXt+POoUd4atR/0u2tHtLUsjeShPxi+MgwcI/vyregGfcq2Lz5XQXP4c0hx70lRkFE4CJQUYW7yfDFjl/v0DyBPLHMXjPhMhH0YRJ+FysoGWXZjkzvA34tak6JU6QwiMUdXb8HpePda/T+JvbQmAYL+X7ZApf8SDMMfLap/QXuIcAUqV9CozHrMbA9KtjKxhXRcl6SBCBFI5X0pOHyt4RQfuvzGrqJRg8ZvXJJu65N2Ziilmi/8Dwh4k8kPAP+p8TN5xUuSv4PqZarqaKwX+4VZf3P01EwPo4f4mNsjNWZCKi5I4uJFqiRM9u87Ypupik0TWKAALmuM6D37BBz1TegTowmL4zJ7ihbPNO/w0+32/UsXSUyrZyLf8p21zGhkhZ0K8yyql1QxNHrinqVu1ZwxhBIx/BAlG3Bu4+ixkwbtlXVErEHcOtuLchBmgHzi6mQONYc61DvC6WwZ+ISAhkHFGIrGyROZBcQ+uX2kysfJoSKxKmWzreXHwNLXCg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc972fc-3971-4698-4e89-08db82375542
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:50:36.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIvOz0iDiTYoRciF5/FRUa385dlaJU9DENYI88Jf7GxKvSQ8OcW8h96DxprRHevRfQSdZRQywVAuCPVOFRnFsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6802
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_10,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=853
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110160
X-Proofpoint-ORIG-GUID: jAZFZ5JEC0lsmVL1RUgyx46UnCoKPmwH
X-Proofpoint-GUID: jAZFZ5JEC0lsmVL1RUgyx46UnCoKPmwH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

apply_vma_lock_flags() calls mlock_fixup(), which could merge the VMA
after where the vma iterator is located.  Although this is not an issue,
the next iteration of the loop will check the start of the vma to be
equal to the locally saved 'tmp' variable and cause an incorrect failure
scenario.  Fix the error by setting tmp to the end of the vma iterator
value before restarting the loop.

There is also a potential of the error code being overwritten when the
loop terminates early.  Fix the return issue by directly returning when
an error is encountered since there is nothing to undo after the loop.

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Link: https://lore.kernel.org/linux-mm/50341ca1-d582-b33a-e3d0-acb08a65166f@arm.com/
Cc: <stable@vger.kernel.org>
Fixes: 37598f5a9d8b ("mlock: convert mlock to vma iterator")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mlock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index d7db94519884..0a0c996c5c21 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -477,7 +477,6 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 {
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
-	int error;
 	VMA_ITERATOR(vmi, current->mm, start);
 
 	VM_BUG_ON(offset_in_page(start));
@@ -498,6 +497,7 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 	nstart = start;
 	tmp = vma->vm_start;
 	for_each_vma_range(vmi, vma, end) {
+		int error;
 		vm_flags_t newflags;
 
 		if (vma->vm_start != tmp)
@@ -511,14 +511,15 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 			tmp = end;
 		error = mlock_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
 		if (error)
-			break;
+			return error;
+		tmp = vma_iter_end(&vmi);
 		nstart = tmp;
 	}
 
-	if (vma_iter_end(&vmi) < end)
+	if (tmp < end)
 		return -ENOMEM;
 
-	return error;
+	return 0;
 }
 
 /*
-- 
2.39.2

