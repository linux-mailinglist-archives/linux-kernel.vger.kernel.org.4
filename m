Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19FE6DE8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjDLB1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDLB1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:27:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FE33594;
        Tue, 11 Apr 2023 18:27:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BLC3IG005398;
        Wed, 12 Apr 2023 01:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=jvj+OKKcBlC3v8WkZtuAqtRzeSf9TJlS1PxDPJ2zZzQ=;
 b=2FJsmkl3xaBHQPjsvJ+tr1Ifm/BU9In6t0xlRLS9C391p+GXySqWJW0S3Xz8PzQxa1JW
 mmXADJCsfNegtU9dZobNxP81nS578iOmeQp4X82/XmBcx0qbMXdpqI8WnoEWJ2zEHXEH
 H25MuGZsOIp8Yey+JoqsPIOuQwHCJIj+2EAI+K97asJAWPMk09LVN5gbh5KN9i7SIucB
 m8/fOohQUt+M7slMlFohLAQEcgvloOwNGyB6B3Wsp5D/t9+ZYjywKoEk2sFYf/WwyhKz
 cJbSsjkpVcGoFNXITlCuhSrTrmUuSIv/RqycxwdaX/PI/rv4fDgyMeX7BeZWODfgPga3 cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0e7eu6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:27:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNx5dN009948;
        Wed, 12 Apr 2023 01:27:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw87twxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:27:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkiB9stoEelbTP9XaPWsNGBoDrTb45zOem8PwVpTUiHn8ignhmLRKlEKfbgU3VQkURw4r3Jf+SmLxYf+sBCDwzxiM0BL1pVp93b63qpx8eKklRJF2U0S3TuC4XFEY0BuQnRDQV7fGtYsN+gyaeM0FNJouxhQ/RPTIbDs53KL9K/YLykUm/2xqpnZPfBlTwUrxA7+3lKva7LNeqo86CBasGgvJ2VElGqn1itxknNuz2/QinRXht5OVpvmvPr8sxlhuzPSXG4IAAn8uRhnJUKAplnypI1k5avxt8UtrTk7b5dXenHycMNeG4d/Y7B/XkxX/iIPVgWfB4RjhJi9jXwkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvj+OKKcBlC3v8WkZtuAqtRzeSf9TJlS1PxDPJ2zZzQ=;
 b=UAeJyoCZwO74RO9OTO0B2DPF8iZGQaG7rc6M93jvLgwvyF/8MfVLsUq9lX+R2g3ecgyUgnchAMDc7SLUmqsSMZsAqE3db2l/0M/qocffMJX8UFHvQ/Va4QCf+ju0DSkpZK++tggTTeUL//54DQCzv4mo3WQZVzgyrKL1/3w40wCo01L6h42k9Z3aB488xRaYPJNmv/rVmvTS3C9mKKZS37cwsbJanpuPuBOE0vEk41eA4lTEhh3kptaPJx1s/0p/Z7vMsF5LSTqsqlDtzWAzGWcaiQlmvbEwY7NnFUCjuw8Sbk5HFmJayWYODdpbHgosApdzuoNR3RoPMYn0/RKD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvj+OKKcBlC3v8WkZtuAqtRzeSf9TJlS1PxDPJ2zZzQ=;
 b=J3EOEeJ6GBxn3wbgZSHtTUck5WOBCAbjtvbsDHxdvT0qBlM0d4M7PF5vEYOKZkOMGimcU9qGLcHV/ToZYikum92p1Jy/qkE46190U6gMGnHTHq8Yjq0LcNBFYbyTHCFX9wADTCgIpyF/CqjUDdtofveVx9BVPMngLTFCLXnFEM4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN4PR10MB5560.namprd10.prod.outlook.com (2603:10b6:806:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 01:27:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 01:27:16 +0000
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Manoj N . Kumar" <manoj@linux.ibm.com>,
        "Matthew R . Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: Spelling s/semahpore/semaphore/
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0spnb4k.fsf@ca-mkp.ca.oracle.com>
References: <d7d04004b818d7ab5d62002f286b0a1b0b493193.1681208251.git.geert+renesas@glider.be>
Date:   Tue, 11 Apr 2023 21:27:13 -0400
In-Reply-To: <d7d04004b818d7ab5d62002f286b0a1b0b493193.1681208251.git.geert+renesas@glider.be>
        (Geert Uytterhoeven's message of "Tue, 11 Apr 2023 12:18:20 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN4PR10MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0965b2-2caf-48e4-4df3-08db3af50ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khWRYN9mh9sdN2EkY+/AH9w4P2c0NueqnRhOA3ziJRD9pkbnqe4BQVRIGKRKOK94ZJK9VgipGcrSHDkJTR2myYSTFVsbell3swkFsjkaAi8O+fJOjCIKCctczNFjKEn8cfLv0F/bAGrPH46Ssv8mCpq+wv25fTLGa8/5xwPLDpBwe5ZdL4e0O6H+ifaJDGJiiIEPu6AqnZYqYn8Ap4bYGk5e54HzpxSsW67vLQ072DRExsoUexi0vhmbpJUCmd9u8nUTHrLsr2zoVfAF5dM9+idPMouNVVixd4USyePHq1DycyDznBY55JhX1WIiboJJQkFuMmTqR/N24VsctXOyB/WcZR7Vc6Ln95ftLWPOUVcjYbh4OOiEjQqeDyTNMwbFky7fLjcegkJ6dDT+OJMAtRfxt+8atI1CbIvMh1J2mpe3bTOLl9IkPd3HwIdiRcWcKGsWRFeVxp2sDuGEzMgxbWNW/Ietqad5De8cZKCCsMwiu1/Xgp5AIHgB/OPjSxIMiO8D1TH8QOgGBlQXYJHLyuFH9hTpmhH1imCsdLZhbFbfd82HituZaFT7w6tsV6W+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(558084003)(54906003)(86362001)(36916002)(316002)(41300700001)(4326008)(6486002)(478600001)(66556008)(66476007)(8676002)(66946007)(5660300002)(8936002)(186003)(38100700002)(2906002)(6666004)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1iY0xLJIyAtVl0SFjABTjQgxnIdedkgT+Z4iLPn9IEleUQXIYmyko082IQKv?=
 =?us-ascii?Q?fO1WW4ir6EvL6TXRKT9AYU8lJYE/nLXJ7b2/6i0v7ztjoEc46sbrN8Aof7zD?=
 =?us-ascii?Q?wjM4iexlmmwsowxpR6mIQHCJhc/e6tIX6W3C5i9BhX9myGLsVcbRL9MgXcdG?=
 =?us-ascii?Q?tg4Xzp+aZm05gWukmivDszQRJ4v3lIlOoUoQv2tDDbnM8kBaHLONJ2SHxz71?=
 =?us-ascii?Q?VfkbMlTmrv7RerGxQcKCkDHjGyn/KagvQhApjPXHAqfhCwjhpXU7m/vwlYbg?=
 =?us-ascii?Q?0QeexYLIitFu5jcHp+yQ2EJMaay3IDJsH1oY5Bgjscy69P8X3tV1mXZlhbjK?=
 =?us-ascii?Q?SL+5oKzA/3m57Yt2NS1oEMdm3L2bAlIEocp9A5nz0taL/BF2d02VjcMqK1tg?=
 =?us-ascii?Q?tsj7SSgMXANhE3A4YF1HVMZZ2+ROnve0wHaX271EtYSXB2DFh2e3ZRRnL5iQ?=
 =?us-ascii?Q?WcWaaTnDEj6/d4SaG8xKmOLLqTZa2M4a/OqtKxIh0jGvBvuQDzWNHuIOK7i0?=
 =?us-ascii?Q?wiJ0T8umAHnB0HOg3sQ3zUrYGXB36czfjkb+SJ8MJ6udonSMOZMkSSE0YcD5?=
 =?us-ascii?Q?zkWhDVlpH8pegQ/XPqTSyZIsAuZSWDfFFuLfrBj09uxUVhCEKilnQjjvg3a5?=
 =?us-ascii?Q?qtqSR0uHJjUgkDYDC2uhOwTixqViWyWzLmucbsRJpDFtRt2xBdRnku0ggETL?=
 =?us-ascii?Q?VrTSpNjj4YV+9uuyFs4n4WX/c2Hb6MNdsaYBW6Xdvxn0VU6pVWG8QK6Hxu6G?=
 =?us-ascii?Q?td/dD7rgBhw2jcvIQMA46/CUu9P9xZZYBM8q8WxkqQl2NXQ43dK6lGX2UGdQ?=
 =?us-ascii?Q?aHq70XTJijnNg2//xBXiY09wChiFVLRbyVGDh1ms/2qFZoVttueb1nPmCxDd?=
 =?us-ascii?Q?PFEUPqIyoRkWCuFtyGBJbg3ihy6vnCjGsoI81S8yEzDqLYtkhe2uBV4XEc8R?=
 =?us-ascii?Q?lPPEVSBI0MacWkm6jA3DOOfMje2/GUNRpToeUE7jyPyOjeYdNysvaAfWe2ix?=
 =?us-ascii?Q?B9LyHyzfx8uQQeji8c5YMTWYtf5Bd/biGJ2FklB7QAxA6YAveewD7psp3QRS?=
 =?us-ascii?Q?cw1unZpfVG4Lt6qyKKSE08i/dI1D6fYvg0/94HCtlEobmXV+sOE87teR9JXZ?=
 =?us-ascii?Q?SVhDAEwo86Cvz6k97HDEh4qeYow7ViF4rbd1ZEu3d8M+0jwyD72X5TPxb79H?=
 =?us-ascii?Q?b4+flRWZMwqHCCeZWYDWxFVg+T9tFoDMQAQwA6MfR4w8BzcpB5IHRzHaZDsq?=
 =?us-ascii?Q?p/4AcJ4zj/7+AN1hYigoRMzhtGmV/4vw1HOdJcKU6LGEdvCjPsc6TSywqSkb?=
 =?us-ascii?Q?x5Cex38+bytDEeV8ccwRKHR0YGQu7ybvx55JJpEKqNYdZXk9fsOZ42VovXUR?=
 =?us-ascii?Q?Aqkm6k3w6F3krVhzRx+TLYEfdX47AzE5pQAGkkuyU/ihthQi5NMeq2TRU4OJ?=
 =?us-ascii?Q?CLtTEahfcpPJxHLaGLNb3Du07uZBAgQ0ZXlIJ+J2JrJjRjMcPGh4gPf+32SW?=
 =?us-ascii?Q?GosW0oFhFJEmfeCniJ/+VzJtgsROPidCs876pz4snMHz8crW8BHqVZ5WsOXl?=
 =?us-ascii?Q?rKH85p6NAGEOacBgeUBRs085eNAACgCVRQMQQltAsTPzthfFWfgXvmoXIVOq?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KS0Ja7zojVg17Zd7hUOnd6LTQ0+9au9Iqe7xZeqSv1FyJTSvyzmPCwv6dBa22gKD06yRgpMMz9S/+AqM1vxJgDJ/yqtbiBCeb2IVSqgcRyFDdIyXkpmctG4sRk4aDsK4++q6tHLixf3DuUde55pXm2c+8uGNjkNt1k8AWE9S4YV3a7LL0ka+ky+hllioWB7h9/5mR0iQGzz6fIQhBaxeUo8Bgm5Nb5v6XrZ5HCPbEtnCk/xw/ln8UAnNpROeAlF7UMXn+TQB2lb45czj3H48loUaIGhRwlC11VSII013qx3Fz7R/b0NAEDNfnjc6157xgUB5tfKnMOnP6SaGlQOjSnfFHrt7zmKFR5dgF/+zu6A/9/sEuWxnfO4ZceMLP8PfmB6yay4DB6ZGWvNkAfsRMxBGq5sN2mqfLIw/efgZPBgJn54+nZnEU1msXOO9PGXWDsC0fP4IY/D1j0sadjpDR1vr2u2/RMnDLinGq1HszxplQaKewxvAypryn04RAuE2YcP0HV8hFhxQaH0WYayBIZ6P/fui9rxVmfbWgNsBK5YfTH/quRBx7DODBmJQSIwhCf76hyAdfulnlvk+P22U9lBig7Q/V8L0OH9/fuDEILMC/k2S4NpHkcXwiWsdk9uR9KvIx0DkUKlMvqMXu4SbAQvXbKGv6DEhhfIcQYatTYutyhFuBMXse7ABdzwLQ6aJAcQDMMJbxmLpiFVXghtAGTgwulqmFI8/XxFCtEf8b8ftVLnb3pi9jgQEshFDZ1FONHtURuoT0diNN0LUMfJi0vvN/EQ34WDYtXxAL0ay4eFd2x58QXJuxu6tn0x6m2mFUzldUbGH5Yp6etmxtZdecw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0965b2-2caf-48e4-4df3-08db3af50ce2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 01:27:16.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaiNLAcOcI70XBcTV4ZMhezr2FJ3T9HQgoT3mVWOS/D/SUrM19rIkPKW0CrVIGxW8D9VXjzLz62SL5QJ8OtC7u4BWE/8AAvLoeNviw2LzBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=791
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120010
X-Proofpoint-ORIG-GUID: UxLW5WbDMrzwxLsPKDjgOUEMxktE4cj1
X-Proofpoint-GUID: UxLW5WbDMrzwxLsPKDjgOUEMxktE4cj1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Geert,

> Fix misspellings of "semaphore".

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
