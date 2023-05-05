Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784A96F8915
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjEESyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjEESyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:54:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167591891B;
        Fri,  5 May 2023 11:53:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhLE8014783;
        Fri, 5 May 2023 18:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3JFE7JTZQEZVbITtu4To1mTTVgp5EqXafMon6dsn/KI=;
 b=gT54edic2HsURDmNedENNfdQ6E/LZE0G3j/RtyUydCHsXrsENHOo45bFN/O6sulay9RO
 +BHnO+KoYxGDintluBO0KN9/Wu3AwRXB60O11SrzTdG7JBINEutTTOtenKy79yYC8tgY
 sV7ADUGZEntV8A2Lg2BRI81IvTG3cfHW//Ma5+1yLNTGibBPTiW6xzVbR7yed5d3HHni
 OdmOSv6TEx9UlSJVImeyVXHcF/sA+v3ZzfUIMX47gZF4esXyhn7cWL2AdmQK24grWHsB
 crHQ86bJ6O6CcBHC+kWpOYMAI0IRG18i2djUvCfD//v6pCMBoRx96CBIMJoTJWrc6JN7 EQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8snedhwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 18:53:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HX60k040484;
        Fri, 5 May 2023 18:53:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa9dwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 18:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf9QSQszVc9Tkuxi3JTnB5iqV5Mf88S0Cem+on4kJu9EmDNfIigzXPUkzWpkdYeOxIP5qJAnFyBvrBPASNNrYEN+T5Kq0Y+MOa9v9SK+GHwrL/LqIHMJti43nMriFVhVXWJzTf6Tt8xzO2Zn+VP5n8+8f4LiyItGKgM+LednQ8QBAneOmLtVGqGeJ6Xh6aaedYiPEAclSqNeXAtVx/an4jHPh4iNeAZ2hxU85beko6+Om88+KTS4o79d41ZpNl2/BwVaLKj+KgVjPAr0CHjgF3B+qbj7qBnKd7PHRbBJGQ1JU3somF5m8c1eyhbHhiPrhMgRZglPC78GJBMYEKXi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JFE7JTZQEZVbITtu4To1mTTVgp5EqXafMon6dsn/KI=;
 b=Xe/tKCTzoUELXT62kkQ/iutMIHczCIPLEj89xNeSMKLuRV2i5Om3FJ0E4YTcQZtKj8RZND/VJzMNeR+eFIMogn4rfI0ZYztBwGXC4sTATFP9CjxpklOuZgL0kFQDx3nh1NoHU+1gNfPsp/8unaq0SXUpvSlDGtx8VJ6PzS41+pWHJRG65LEQZpAfUr8Vq8H0Py7dsVozdGYbaWimBgbfvcTmRu1k30DGD0/uj+MADNBTfglv8nZubdmvGiFpVG9ynpDp6ZU2zAiUg3G9i/mXiqecOcv1HSQnKv/vujz/Z0yOoeK2hp5FF65BRT72N5k73nZTguslOa2CY/hbfFksBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JFE7JTZQEZVbITtu4To1mTTVgp5EqXafMon6dsn/KI=;
 b=sOABoNNR8S9ExxDAYfSIZhWP0zFjEjSi3+vsa5af7GOueC9rCua1UQOVBXveKI0uXoqeBn09kiohkIhhhnJ9vZ+2nchm8Cvj1SjtEY9wd/gslEFw8Mer4CA7Q8InEKZlFUvsqkhRjatIxv+NHSjVtcdXqcjRTdnzDXtkH4tNt6E=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BY5PR10MB4241.namprd10.prod.outlook.com (2603:10b6:a03:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 18:53:11 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 18:53:11 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        ackerleytng@google.com, vannapurve@google.com,
        erdemaktas@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH] mm/hugetlb: revert use of page_cache_next_miss()
Date:   Fri,  5 May 2023 11:53:01 -0700
Message-Id: <20230505185301.534259-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504233858.103068-1-mike.kravetz@oracle.com>
References: <20230504233858.103068-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BY5PR10MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d1b379-2167-4d3f-d900-08db4d99f960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXaRPR1wVnQo4551hndWj5zh/Luv1QIObHerxhYmhdXvxkJX71KztOo10ncb35AccfMukT1okNAHejXokyjYPDeZSytVZQNDN19kdw9Xt/kMbOj+aCVu1LIPFoPOGLfRgSnP250MXda1NojALKAxIJyyJiBUUDKCYZFE19xN/2NvvQRp0UnQZopGHDnvB1kkQNq7qHg5ksjMLcz18kd0gowCxnx/gpaicK9BPY2mKq2wMoP2JIpPAFEHV+U+UaBbA4+KJzSfghF3N7T6C8J9IoJCn49KHj8SeqVLLrZ1PDaFfe+qnUTfhfC1e7X+fD4dkPfQ+BEo2hqQmRggMjbvcZuidFKXu3JS4c84TGg6YbkChs1IqccMMPT7upVaVPm0cnWXy5yJE4Z+C88O6Oj8AEaF2m1ZQ+bl4FHwLf6H98qM90BzD8Tee7ZjFIQXfINB54gpS5mo1iK9+BgZWB63z/MASby0IEowFq/vO6yH/0TrfnryrPNpPNw6MsF7WIjwBCfI50/mw4D2VxOkQ5iEF9U4u2M21ClOLfPgN1RZu6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(86362001)(36756003)(6486002)(316002)(66946007)(66556008)(66476007)(966005)(478600001)(4326008)(6666004)(41300700001)(8676002)(8936002)(5660300002)(44832011)(2906002)(38100700002)(186003)(2616005)(6506007)(6512007)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gNEuzgbOS/GMQWRBSe3uMWPM6nce9Jhace4sk2E17JEbUMZ3ZFKnFxAs0yvK?=
 =?us-ascii?Q?YtGLXuGa6H2YLzE1UBU9Z0RkBXHEmsd4tLDg1bqAEiC00A4O4bL1VjKVpRnz?=
 =?us-ascii?Q?TZpOyPQAVOU5Pv5oDpoh7mgG1vJI3u0edpVJhHVYzYBVigITqqpnqpZeBgoB?=
 =?us-ascii?Q?8sIAV4BXXI1ZvXD7nXONL2ljWvL3WTovVIUoqS4gO5XrA12Qb7GyClMMI1yL?=
 =?us-ascii?Q?V/+hluWR3OWIdqQ08afNDc0ULLS9s9rGFBRHqvpdjDMMhgBPIYfhNEewqmtU?=
 =?us-ascii?Q?bzAvTtn9cP/OnQsYRPMxLu1lACOnLPkFECudj06C1NM5YJ8NRHW+V1nSBTS0?=
 =?us-ascii?Q?YInQ6ZHInhpgShIHrUOGWsgH8RDA5QhsDMlafSIv3c0h+tafoqaZu7EgEh4m?=
 =?us-ascii?Q?sK03+3612Takn8L3Rdj/AZl+bK13q6NmWCrdoZ7II3Y+bBYmnGQWVRFboUal?=
 =?us-ascii?Q?+LjReHwWfzUdBuAIHwnJthYdwTod8EBxpT+u5NLMdBRFD7+RLWT+uCXE1yp5?=
 =?us-ascii?Q?Bocq1V/aX3u2kfayBSYcF9DdDBzvJfBasiheRS+T0Gf5/hF8CdFTPKmfSXhu?=
 =?us-ascii?Q?h2yNdlBwap887GXR6Npn8Dbho5qnifz/GHu9vEZHLB55yhFM6N29W1OFjEGx?=
 =?us-ascii?Q?mxYUzh6A5TD60xy6BAgeqTDqg/Emoc0LQhwpOednQoLlb4x7CdLyhFGVrRQh?=
 =?us-ascii?Q?ASwjSJBIwqPEzNKEVYSfDyou7/shDp98CqqeKeKzTq4QqV4/lDkoaW7Mc6mI?=
 =?us-ascii?Q?c2GM+p7sTT5t2YPRBLyAJvFBFDI5PqQLA04AUEPR4BV33rqAyzPKBeQ+KVxA?=
 =?us-ascii?Q?6XxD/RwbKCz9+nmBS9CDotDPtJ/gzSGjDWsTfoG2SnVcxx3ma9liMWvUaxpz?=
 =?us-ascii?Q?qqcEC6m6tHNo31CQseuYE6b1waSTCf5zMBDDB/2+K0zP4cXsUAQ/t/bAosQy?=
 =?us-ascii?Q?YSzXOmb2ekHKiipNzUlRYHKNnxXr+TJYzhWczHP3Fem8Ss8V/+Hz9klV2OPK?=
 =?us-ascii?Q?MZ7HJYqoAFNPr2Rw1ymTa2BF0glZBBAIhQRtsKpFZZUs47arTIG7GSlqss/J?=
 =?us-ascii?Q?vL3G37eq1tIH+JQngMV8j8SVGqNL5K2dGXN1oPeZ4xwY7F/o2kIz4Xd1C3bH?=
 =?us-ascii?Q?QdzAvYWGRLnsowsZ1xG3IreJyuVLIItzN+0o0rHnNDufPHHVHXFpDdoqqEia?=
 =?us-ascii?Q?7YDG9dkYwnyKtKl9f1n1ZCbha16CVLDyrcU4D5YSL5NV1d95p/jh2pRQMUFN?=
 =?us-ascii?Q?oNx65VKRR5TzxcDY0e8Vj/igmcQL78c9ebpkSby1wHHb5bQ+92b1lnS8ilz2?=
 =?us-ascii?Q?cWcpW1GHCk45gilzHihoZgGwSPlcCg7SDsKbyXNWpAeSwBpEle+wWcZqI6/x?=
 =?us-ascii?Q?lWUv9TZvFfjSS7Jn/ibYl0szw5EZUcozNp++uyVxkvoO6PR4+70qU65XF+pg?=
 =?us-ascii?Q?X9P8/iz68/1YNfUxFYxOjhiIRJpAoKB2VcsKaqplqjMbFhdslX1xNRwwjEks?=
 =?us-ascii?Q?Gx5NBgG/P7I8yVrIM7euMZiA7fUUWHGFDg63o1AMn+PLlZDxP35JHNhqZln3?=
 =?us-ascii?Q?H6/87PNWD9DwcvKveB4jFafuhjg6defDvIH46393YJambwCsvgUPIyl3O1El?=
 =?us-ascii?Q?d2vVsqfdnX9aKkUljhrC6f0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NrYhwtlquKJN71dI1sVfchq5CKhZpZsuqCj2u2shMAxsgLq0dbxevNd4Jt2m?=
 =?us-ascii?Q?/GndiIfX6/gaAgmuLkt83RubNt+6/bWggM8st6pSW3X97U3dWanD7VP1pJwa?=
 =?us-ascii?Q?8LExKBH8rTzC8CduzcrTg9WSEIP/I+dW9NwEw9uwmcRi4Wr9Dx1jCP6syNN0?=
 =?us-ascii?Q?KHXamNEuqqb7Ioa7Pw6SpeGrcF1gT6AkF+6CRVVFUHJhY93NnHdnjJnDh6Hw?=
 =?us-ascii?Q?eDlLK2go6r4wSRMOY49gLAOspZLJSUq3pur7xkD1Q/Q9onVZY7sHDQQps5Jl?=
 =?us-ascii?Q?4Y4t5B4J1HY2xgisalJ7kv1bkmL9LTMZ8c38kYJpMS/xjtyaycu1swQ93IoA?=
 =?us-ascii?Q?4AP08ufmm0S47aIniY/LLQULQagqCFshM1+EGbFLN2tLLdpYG1V3qw/vrffD?=
 =?us-ascii?Q?DdjlL4xEBcHk1ssH68xneYwlUUJYRHCP+YOZ3dH8jin/XowOU6Ubd34dDH6R?=
 =?us-ascii?Q?T23e8LUo44p+/pyZnx5k6+qpcEj1KY5pqb04py4aOkqY+Jm2RSHIvaszi/0g?=
 =?us-ascii?Q?QxpFq95zs/MycElUatABS58nunOGD9g38XcFOn6fBbCRziFMVDxHICKHjjm4?=
 =?us-ascii?Q?NjNokt15fQ+9vBv+w9uJCHj/ne8oCqd+xkycGp+7YUM2RmDX72vpML5RZFwX?=
 =?us-ascii?Q?q70elZF77nKNmBZoMd1lphuHy9O+DoBJU9EzLbSYghxMXYIL4T6JCmdaXMv8?=
 =?us-ascii?Q?tKGJCB7WPoa+sgMKoGtutVl0zssiFkh3w+8f2qCIyUgUnCnYkUxpcrPRhg9d?=
 =?us-ascii?Q?5c8PcBn+wNAw9sqLvqIzFt7pEZ9/GBV0/YSeWuiNmpz1VheDM7G8RXmz7WZu?=
 =?us-ascii?Q?TTD2krR5dOJ+qBzG6nIm+YxFKN2lVTV2hkxdwuYbHgWDjYy6/4dg8FrIqYwl?=
 =?us-ascii?Q?68IHKoxg7rG5wK7BmnWEwfZO1KjROUbTl4U8EdGpZIXoLpAW5CEb1t+keHAH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d1b379-2167-4d3f-d900-08db4d99f960
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 18:53:11.6429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHixF7LQy4vHQXUPmUDvPGU0lo4BuFr580POU6j9ts75NpdM4GCpf4dKC/UdGfQzWXwt7zTAsC53lbeScPLQFui0a3ZB8Ay8+gCA27NwbEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_25,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=813
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050155
X-Proofpoint-GUID: QireeGlPyHFyajjyL4MsUHNy5Ly204iv
X-Proofpoint-ORIG-GUID: QireeGlPyHFyajjyL4MsUHNy5Ly204iv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Ackerley[1], the use of page_cache_next_miss() in
hugetlbfs_fallocate() introduces a bug where a second fallocate() call to
same offset fails with -EEXIST. Revert this change and go back to the
previous method of using get from the page cache and then dropping the
reference on success.

hugetlbfs_pagecache_present() was also refactored to use
page_cache_next_miss(), revert the usage there as well.

User visible impacts include hugetlb fallocate incorrectly returning
EEXIST if pages are already present in the file. In addition, hugetlb
pages will not be included in core dumps if they need to be brought in via
GUP. userfaultfd UFFDIO_COPY also uses this code and will not notice pages
already present in the cache. It may try to allocate a new page and
potentially return ENOMEM as opposed to EEXIST.

Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
Cc: <stable@vger.kernel.org> #v6.3+
Reported-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

[1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
---
This patch is meant to fix stable v6.3.1 as safe as possible by doing a
simple revert.

Patch page cache: fix page_cache_next/prev_miss off by one by Mike is a
potential fix that will allow the use of page_cache_next_miss() and is
awaiting review.

Patch Fix fallocate error in hugetlbfs when fallocating again by Ackerley
is another fix but introduces a new function and is also awaiting review.

 fs/hugetlbfs/inode.c |  8 +++-----
 mm/hugetlb.c         | 11 +++++------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9062da6da5675..6d6cd8f26d76d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -821,7 +821,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 */
 		struct folio *folio;
 		unsigned long addr;
-		bool present;
 
 		cond_resched();
 
@@ -845,10 +844,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		rcu_read_lock();
-		present = page_cache_next_miss(mapping, index, 1) != index;
-		rcu_read_unlock();
-		if (present) {
+		folio = filemap_get_folio(mapping, index);
+		if (folio) {
+			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_drop_vma_policy(&pseudo_vma);
 			continue;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 245038a9fe4ea..29ab27d2a3ef5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5666,13 +5666,12 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	pgoff_t idx = vma_hugecache_offset(h, vma, address);
-	bool present;
-
-	rcu_read_lock();
-	present = page_cache_next_miss(mapping, idx, 1) != idx;
-	rcu_read_unlock();
+	struct folio *folio;
 
-	return present;
+	folio = filemap_get_folio(mapping, idx);
+	if (folio)
+		folio_put(folio);
+	return folio != NULL;
 }
 
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
-- 
2.40.0

