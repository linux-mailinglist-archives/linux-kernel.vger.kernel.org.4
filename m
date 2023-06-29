Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B99742D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjF2TXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjF2TWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EB73AAB;
        Thu, 29 Jun 2023 12:22:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ415D028772;
        Thu, 29 Jun 2023 19:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=5HPLDEQyUQVH4MISxpkHDadsyBn3mLXsaqlvlMMJCmo=;
 b=Lz3Yxu/z0T5iQN8Za9qCLQ+J9Va8io78qvvUvP4PajenGudaVOz5zQzq7fPy0FD6G+5N
 IPoJBimQVKRZMiSXcIIBT256+2Hfa6e6QVzhqDD7N25GksUSCGt0bvAAuaIIQm3plH9E
 zgvoTf4MBIAckmvnf6Kii2p8hPhL0EGoZPsGYobgK7dnTZPfvQqJWaqCCPq4fPeOdL/T
 RdAXyWrHUpcvcMh/kQWvB+zm22jddXfXgtHLdnB6yN6p9++778nzcjdvlfVkvHBh+e5/
 +BFaNiyV2oYcocCvkKNdjJgxFnzYqpZz4ANZjpyP6IpINTjdaz3H9pEGOH09grFvPo9l dQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdngg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TIm6nl013083;
        Thu, 29 Jun 2023 19:21:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx82gjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQENek1CcgTVJRRQKy7e2dB5eTCUpeRaETHm6BZAVNQfoW+zEZJ6errdqzYexpP2+zlI5x82eZaPMBuUnOQybwKagpn/8H/kp/e0CjnAWcn5bTxYm5Oe01J7NQX+FVa3vc7qjD2BrpcNKo80i64G1ole+A2Hul/cL3g45XJIe/RwLFABbs+9zlnr9Ze2HKr8yGuswVxR7+hQ1JXqiaFbTvr8LN4VkgvZ3+E4+4gpMBPPsTp5sYz8w+4cD8i6l98fRc0pRX9JeCX0qpUVvbeoGERFxtKxR8uIA9UrxA9+r8BTFCvRgBW9LJuUGvdqPVnVgP9/9FikeorC8BHh8NvYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HPLDEQyUQVH4MISxpkHDadsyBn3mLXsaqlvlMMJCmo=;
 b=FVrt5TP0gO12Tq0M9phF6w9w0DotniIQ8J/mDg6sg6PnQBc9ORrojxDOdHpKlY+jch8PTJ3YswFtMA4kvcWDdo8RetBwrETLHbvPiRhQdzY653XAF34gYfGS62y6KlNlqJPc0aFSLstRt5VmJwDuNkHEvWn/gcUrIey2FUpSw6tQgNVqYqg4l54t9AGEWZ1owgTKaFa/R2BKm7rDoPrj3qVj8BBi9dO/njUT9d5QoJDtKgDVfLW/noFb5kKaYD6y/WWOqNRYO7cBXnx5RsdWq7Fe5B/vk5zqToD+sFlbKzP6uDHs7vXgZkiBVvtO576QTV2cv2ctYe5UtK9h1UEMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HPLDEQyUQVH4MISxpkHDadsyBn3mLXsaqlvlMMJCmo=;
 b=UKcyKfnQTjApzbCnEw4VofenhxVf2QZlkZAQFGVLUHmPB519fvT+BrygpPawl7avhK5qNaEYr1Q48iRvsTLplQzX5HXXvBIuVBOaVECMcx45RikRAQ3dguAPthr5Pv8nboFtvy4xPykrb5PAH/7lx+PXeqz8wj2INo9fvbKaQJ4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 29 Jun
 2023 19:21:32 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 19:21:32 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v25 02/10] drivers/base: refactor memory.c to use .is_visible()
Date:   Thu, 29 Jun 2023 15:21:11 -0400
Message-Id: <20230629192119.6613-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230629192119.6613-1-eric.devolder@oracle.com>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 071495a1-1f43-4192-2631-08db78d60bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Em2g9y8Y6XyPjKVU6kGihsdXPoOGW4gjtvhv7XD2THxwlFwGf2PEEX0THkUzsongzl0+4VgFpReyHReDiQJsSU41w07rfEn4xCQfb+erePVgNWwt4EM/KdaJsMn4Vft1VEhtnbz8vOM7qNnmaf9ValnT31CtLiusqAoSkj/dv4jNsI+9bQHYEmbq1X9O9bwyvPw+efJXpK0JhSRVlSP1SGrgmsqYLjdNX5gnednVNy9dSfEjViXv5bSvhEUbuylm2USgBdcZLqKLo1mXO5Q+SPFoZuyVpf1Clj6rKdFNn7VcmVqLe8aWWhwuVcQdd0hbP5N0X2ZSasscUNi789TNmoF8FsPwBdGpxvwaq3ANrJLa9qn1Qb+toLTSK/76GkiFDQO8BgmityQTKG9sXgsUJbh1ApuBFY/cOgl9qzgCDd2PpsPfagMD05ohleo45VlUKFdxJyzSUD6nrcyyBWtltknBcWaC0/VxRvaM5b6zAck1QjWJYHhKai80pUcfyfhyz0mAmBaqXaRzN69sI5Bs8mabi6q+S1iPGfqIS+Dayqwie1JhYG+aYbHZJnbAqnquitJce9L5/bdQSXGk0Ie7DVC8gcQ7T7TXirVWhlfAOhKSBa1UNzlEUtp4k/sgfDDL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(83380400001)(316002)(6666004)(8676002)(4326008)(8936002)(6486002)(41300700001)(36756003)(86362001)(38100700002)(921005)(2616005)(7416002)(7406005)(66556008)(6512007)(5660300002)(66946007)(66476007)(478600001)(2906002)(186003)(26005)(1076003)(107886003)(30864003)(6506007)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aS9GNWfssVWzq5gLP66fydEKW2ntT26eyuA5QzsxqZ1mjjGKE/xSpHhz9fho?=
 =?us-ascii?Q?3qHyV5XjwhwkcFL0FoYvBIHiHiZIBdLZfsW3OAsYWlnjGKVRVbwBpzj+L1uB?=
 =?us-ascii?Q?NQhnbuC3fWklEwaJzklfKx6if2P3rHZmy0rf6zzOeL1oH0blbJGxg/OVYbRD?=
 =?us-ascii?Q?XstKT7+ih2tiGMk09kJqI8mrWrVlev6YsnmXpUAdn30At7BkK6ThRBavVLzt?=
 =?us-ascii?Q?7Ktx3ClcEqnLWBNqqzTW6vWANsnxDBiHsvcshx3Ypekzx28HGDblfu6aPMR+?=
 =?us-ascii?Q?ueSZJteg4Vg8aMlHjOtUec61naUv0av0FTnAw/wyLajLB8B2n6CpU4/g69xy?=
 =?us-ascii?Q?P6U2QHuDOOHYMn/kewSJXheZZuSPuLxBHUvDYkCnYwNqtHp262j2H4AyqqZ5?=
 =?us-ascii?Q?0ly/CQXep9y/FeyfAI75Wvf7SRYFvPI8pK+WEk7v8ty05LdchgUobALT30jD?=
 =?us-ascii?Q?JSunIYXpW8avooe9VKaTKX/7kMj9u4LsqCyL+QMMCILKjoHtqLgDikSiivRs?=
 =?us-ascii?Q?hvcuDjCzkrx1QvGFfcwRNbUHaHKGrpnOcYfBVbwB1QJGUlWJu29gN4OOBIAV?=
 =?us-ascii?Q?nxX7G8FjeHrZeb3UTZsLHTSFAf+2fruPMD3cVBiIzKYM+xqPd7z3WR+AKbDO?=
 =?us-ascii?Q?roSBeC+ink9dFaVkzofoQ5C9nHQ059QW2YtQL7+g7DHC37MDRqXKz9HH8Me9?=
 =?us-ascii?Q?GcXzBf4SLMgI7OAxayuiEytWc+AJ638hPashY4WopAGd3D9On/J4DMrJKfSn?=
 =?us-ascii?Q?tVyDous3W8QbH1g3PxQtzJnlEmqjFUO/PEqNdt/zqd0IACM+2CE20mRWcZE4?=
 =?us-ascii?Q?wZ5hATa1fjl58YKTgzFncyfVhrPAcT5PyWjzeorj96rlzs7Bnq+sGBJOkPTA?=
 =?us-ascii?Q?YeTIoeoEVlLT26TVRAsV8uJXPa0WCcrcaAM6S7Z6LrHqHDgb6E69nQiMR+fa?=
 =?us-ascii?Q?d1vQZcYNzMrF4tFMK7OHkDV1thbikbICjRvYWSi531pDEWgFECoMDBj70AYe?=
 =?us-ascii?Q?tqEE3H2xBmeuhzAJVgWUt6v6cjJVbNr6kWTd4Qn9qxW74pDKtRhTZYT4laia?=
 =?us-ascii?Q?nOQJDnCyCyek8KjExFMSvDvsutJEMZb9BdgZsnGwjr3b3KrQS8TJsttlsn6y?=
 =?us-ascii?Q?rI+ulpd3QJhTUTcRrTYz9xeT5bjqjqCsFP82uv7c2P/we3cqMvT/qLD0pGge?=
 =?us-ascii?Q?u9wc213z7T7y0ISt64a7uoDIc7lYx1JLPPrCk0+aWZFMh3H3EiL+pqeD8Ww/?=
 =?us-ascii?Q?diPbksVaPnkSIZ1K05sc5zxFIvJCJHARZExn0/Eyny3hDSV7vYbbVXkik8vL?=
 =?us-ascii?Q?s4wPEJB75jnKO/PxGpCLlYVfKl5ltpuXfhYUacDfp3OW8vhpa2kUDDew9Cus?=
 =?us-ascii?Q?5hMtNR/LwJDb5WvRfpDtIbeW0dFuhjwo2j6Uks5QemnUEknT5CZ1rSr5hBNL?=
 =?us-ascii?Q?sQNDVURKW9/gnHgMbIAgSbMWHBa/7v9OjdxQ8eU4BK3X9thriYikYrTIUZiY?=
 =?us-ascii?Q?UYnxIgwOHFLG+sUSc50zUOTTxyUzcTiSsaPJORn1oqwyeDiHSF2INDfahppO?=
 =?us-ascii?Q?l/6+1zgUiZ9MEEWNRmBWAnJ2gc2fu5ki4BSjeC6ckJC+AyCGj2w3lpCQj2X5?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HDV3QuEqWZF/rA15KZ/aPIHr+Scrx6B37nDUn4ricdd6RWgU3yG99HeFdgx6?=
 =?us-ascii?Q?agqKNj//5/3j4pjaU1h9ptoGhK2Zmkia2cJs63mgjLOzIfqEBx4+q9cRWiPS?=
 =?us-ascii?Q?4b+Jx55F9iUyrDJ04REnh8ff/SWmW5/cl6/VliHeUQJ9/cmPhXqK8wcCYGB5?=
 =?us-ascii?Q?AKFX5sNSi0JM2WPfXNOe7yZpq00iaZQJ0u8wuZa6oL+mzJ/9/r3FcDlrJtVV?=
 =?us-ascii?Q?KWmkNj5P9d5oP/keXlIHfZGLNlKs2OrKA4hWmhP7JBausAripue1NFqrxwn0?=
 =?us-ascii?Q?lNVgWX5oC5Ak5/e9l+GO1QOTqnmdFRDJmMtJJvdaUeZYHAcIo/2oBOzKozfK?=
 =?us-ascii?Q?vT9krMr9RJOnkioYGkldLh6FcXpNCW9mT3OpRy5dbOUBj4w0rZkPTUL44VLE?=
 =?us-ascii?Q?nu5e3Kd/jLoa+MuQ7zEz4mtr8eewz6drJMjAuZExFPPEk9yWSl0tijVuYM0A?=
 =?us-ascii?Q?3Qrk+mbeB9VbPvjAiQ+mqPKEiQVrGI/Z0r32cZfOb/ZqqLTfPqOXX7+/fJvN?=
 =?us-ascii?Q?ti7xNmUNwHoOPezaEdrAWMsR3FqHl4J83jzpdJW1qFyddlN/cVj8STgoTXpH?=
 =?us-ascii?Q?c3zx2Gbtn5qrOFhyImPP2uf0aBA1AhLRHJLllG2DpcqPKwltJ19sfRQ1z+o7?=
 =?us-ascii?Q?yW6uMZ9UzXsHoHzGqINBLPS4Eh0KC8PhjcP1JKrEdM0uoBgAGDC9Dq2vUpZ7?=
 =?us-ascii?Q?FPTHSjHyfQXsNz32uD5xixH3ZNdh6Jgho9RIjjAihQdIj2WXnMSKPycVvMth?=
 =?us-ascii?Q?nXyAd1+QZtiY0NT7RHLTfyiDt/GJl4zGCYHedcHmwlh6+BBoV+q2PTkX6/8+?=
 =?us-ascii?Q?4Slq+SS4zFQw+9MXveV4sztT+VZ4BfvMS7AG5ELNdb7w/cI4P1W0PZXFZuvB?=
 =?us-ascii?Q?uNvNRoCGDvVapj57HTiLLBolriH5ULR7nqL4308QSoq9kQ8yeQtnVy5AQ2Aq?=
 =?us-ascii?Q?gkN50pU2QXHD7l714Yt09bBnY+WXnfq/xtNt8x3mqMXHedYYFyHHSV/KVEOa?=
 =?us-ascii?Q?6iOFtYhy1ddGaz/5WmD9AcvKhEqvIjpuL3CRqMPbNRGRJY+NiDg9tTY7kplJ?=
 =?us-ascii?Q?oLWg45IPNfxrmjg4dAlhhCCQnb7itYV41KYfHu29nl74ZVAn2ejq8oAZGqJG?=
 =?us-ascii?Q?ZRFZQmXm4sMuk34yP96Zqlce8xem2IaxUVwm+smHhBlLoggVc5WCdUi25B7E?=
 =?us-ascii?Q?aJQ+dgzgHmANkIN0u9FTpy5uGM8FZC2Fryp7tHGs6NRJh9doZ0JyXoCLiTPu?=
 =?us-ascii?Q?YQYOiBnwPrceCahjvKeL3oOmSWpKskJzvR2VxGG2djYCw8L6APawX1LhyzvH?=
 =?us-ascii?Q?Dr23RBKKmEIq/lh+ZgH9aZQgfGWUyZp4ft0niwt7D+f/RGfL08Ju6Us2wIan?=
 =?us-ascii?Q?zo9lSCvubdMqMnwQEl/OVjSpGeczmnZr/MtQKuNEi0IDlbDpKrrdDe7EEgk4?=
 =?us-ascii?Q?z+CxDNKDtc0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071495a1-1f43-4192-2631-08db78d60bf0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:21:32.2992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4aO71fR7C5qMlAw18bmhEXmGd35y7/EAjMiDw0Yw/qxhBwPbDBSmtJFcZeMN54hMn4jHtEEPglSp2j9wLKemdgdSzcPlCry5uktTVRLa3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290174
X-Proofpoint-GUID: u9xq_TZmDa0hFM2955WD_UIqxuLpwMLT
X-Proofpoint-ORIG-GUID: u9xq_TZmDa0hFM2955WD_UIqxuLpwMLT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman requested that this file use the .is_visible()
method instead of #ifdefs for the attributes in memory.c.

 static struct attribute *memory_memblk_attrs[] = {
     &dev_attr_phys_index.attr,
     &dev_attr_state.attr,
     &dev_attr_phys_device.attr,
     &dev_attr_removable.attr,
 #ifdef CONFIG_MEMORY_HOTREMOVE
     &dev_attr_valid_zones.attr,
 #endif
     NULL
 };

and

 static struct attribute *memory_root_attrs[] = {
 #ifdef CONFIG_ARCH_MEMORY_PROBE
     &dev_attr_probe.attr,
 #endif

 #ifdef CONFIG_MEMORY_FAILURE
     &dev_attr_soft_offline_page.attr,
     &dev_attr_hard_offline_page.attr,
 #endif

     &dev_attr_block_size_bytes.attr,
     &dev_attr_auto_online_blocks.attr,
     NULL
 };

To that end:
 - the .is_visible() method is implemented, and IS_ENABLED(), rather
   than #ifdef, is used to determine the visibility of the attribute.
 - the DEVICE_ATTR_xx() attributes are moved outside of #ifdefs, so that
   those structs are always present for the memory_memblk_attrs[] and
   memory_root_attrs[].
 - the function body of the callback functions are now wrapped with
   IS_ENABLED(); as the callback function must exist now that the
   attribute is always compiled-in (though not necessarily visible).

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 drivers/base/memory.c | 229 ++++++++++++++++++++++++++----------------
 1 file changed, 140 insertions(+), 89 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b456ac213610..7294112fe646 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -391,62 +391,66 @@ static ssize_t phys_device_show(struct device *dev,
 			  arch_get_memory_phys_device(start_pfn));
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 static int print_allowed_zone(char *buf, int len, int nid,
 			      struct memory_group *group,
 			      unsigned long start_pfn, unsigned long nr_pages,
 			      int online_type, struct zone *default_zone)
 {
-	struct zone *zone;
+	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE)) {
+		struct zone *zone;
 
-	zone = zone_for_pfn_range(online_type, nid, group, start_pfn, nr_pages);
-	if (zone == default_zone)
-		return 0;
+		zone = zone_for_pfn_range(online_type, nid, group, start_pfn, nr_pages);
+		if (zone == default_zone)
+			return 0;
 
-	return sysfs_emit_at(buf, len, " %s", zone->name);
+		return sysfs_emit_at(buf, len, " %s", zone->name);
+	}
+	return 0;
 }
 
 static ssize_t valid_zones_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct memory_block *mem = to_memory_block(dev);
-	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
-	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
-	struct memory_group *group = mem->group;
-	struct zone *default_zone;
-	int nid = mem->nid;
-	int len = 0;
+	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE)) {
+		struct memory_block *mem = to_memory_block(dev);
+		unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
+		unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
+		struct memory_group *group = mem->group;
+		struct zone *default_zone;
+		int nid = mem->nid;
+		int len = 0;
 
-	/*
-	 * Check the existing zone. Make sure that we do that only on the
-	 * online nodes otherwise the page_zone is not reliable
-	 */
-	if (mem->state == MEM_ONLINE) {
 		/*
-		 * If !mem->zone, the memory block spans multiple zones and
-		 * cannot get offlined.
-		 */
-		default_zone = mem->zone;
-		if (!default_zone)
-			return sysfs_emit(buf, "%s\n", "none");
-		len += sysfs_emit_at(buf, len, "%s", default_zone->name);
-		goto out;
-	}
+		* Check the existing zone. Make sure that we do that only on the
+		* online nodes otherwise the page_zone is not reliable
+		*/
+		if (mem->state == MEM_ONLINE) {
+			/*
+			 * If !mem->zone, the memory block spans multiple zones and
+			 * cannot get offlined.
+			 */
+			default_zone = mem->zone;
+			if (!default_zone)
+				return sysfs_emit(buf, "%s\n", "none");
+			len += sysfs_emit_at(buf, len, "%s", default_zone->name);
+			goto out;
+		}
 
-	default_zone = zone_for_pfn_range(MMOP_ONLINE, nid, group,
-					  start_pfn, nr_pages);
+		default_zone = zone_for_pfn_range(MMOP_ONLINE, nid, group,
+						  start_pfn, nr_pages);
 
-	len += sysfs_emit_at(buf, len, "%s", default_zone->name);
-	len += print_allowed_zone(buf, len, nid, group, start_pfn, nr_pages,
-				  MMOP_ONLINE_KERNEL, default_zone);
-	len += print_allowed_zone(buf, len, nid, group, start_pfn, nr_pages,
-				  MMOP_ONLINE_MOVABLE, default_zone);
+		len += sysfs_emit_at(buf, len, "%s", default_zone->name);
+		len += print_allowed_zone(buf, len, nid, group, start_pfn, nr_pages,
+					  MMOP_ONLINE_KERNEL, default_zone);
+		len += print_allowed_zone(buf, len, nid, group, start_pfn, nr_pages,
+					  MMOP_ONLINE_MOVABLE, default_zone);
 out:
-	len += sysfs_emit_at(buf, len, "\n");
-	return len;
+		len += sysfs_emit_at(buf, len, "\n");
+		return len;
+	}
+	return 0;
 }
 static DEVICE_ATTR_RO(valid_zones);
-#endif
 
 static DEVICE_ATTR_RO(phys_index);
 static DEVICE_ATTR_RW(state);
@@ -496,43 +500,43 @@ static DEVICE_ATTR_RW(auto_online_blocks);
  * as well as ppc64 will do all of their discovery in userspace
  * and will require this interface.
  */
-#ifdef CONFIG_ARCH_MEMORY_PROBE
 static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	u64 phys_addr;
-	int nid, ret;
-	unsigned long pages_per_block = PAGES_PER_SECTION * sections_per_block;
+	if (IS_ENABLED(CONFIG_ARCH_MEMORY_PROBE)) {
+		u64 phys_addr;
+		int nid, ret;
+		unsigned long pages_per_block = PAGES_PER_SECTION * sections_per_block;
 
-	ret = kstrtoull(buf, 0, &phys_addr);
-	if (ret)
-		return ret;
+		ret = kstrtoull(buf, 0, &phys_addr);
+		if (ret)
+			return ret;
 
-	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
-		return -EINVAL;
+		if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
+			return -EINVAL;
 
-	ret = lock_device_hotplug_sysfs();
-	if (ret)
-		return ret;
+		ret = lock_device_hotplug_sysfs();
+		if (ret)
+			return ret;
 
-	nid = memory_add_physaddr_to_nid(phys_addr);
-	ret = __add_memory(nid, phys_addr,
-			   MIN_MEMORY_BLOCK_SIZE * sections_per_block,
-			   MHP_NONE);
+		nid = memory_add_physaddr_to_nid(phys_addr);
+		ret = __add_memory(nid, phys_addr,
+				   MIN_MEMORY_BLOCK_SIZE * sections_per_block,
+				   MHP_NONE);
 
-	if (ret)
-		goto out;
+		if (ret)
+			goto out;
 
-	ret = count;
+		ret = count;
 out:
-	unlock_device_hotplug();
-	return ret;
+		unlock_device_hotplug();
+		return ret;
+	}
+	return 0;
 }
 
 static DEVICE_ATTR_WO(probe);
-#endif
 
-#ifdef CONFIG_MEMORY_FAILURE
 /*
  * Support for offlining pages of memory
  */
@@ -542,15 +546,19 @@ static ssize_t soft_offline_page_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t count)
 {
-	int ret;
-	u64 pfn;
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	if (kstrtoull(buf, 0, &pfn) < 0)
-		return -EINVAL;
-	pfn >>= PAGE_SHIFT;
-	ret = soft_offline_page(pfn, 0);
-	return ret == 0 ? count : ret;
+	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
+		int ret;
+		u64 pfn;
+
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (kstrtoull(buf, 0, &pfn) < 0)
+			return -EINVAL;
+		pfn >>= PAGE_SHIFT;
+		ret = soft_offline_page(pfn, 0);
+		return ret == 0 ? count : ret;
+	}
+	return 0;
 }
 
 /* Forcibly offline a page, including killing processes. */
@@ -558,22 +566,25 @@ static ssize_t hard_offline_page_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t count)
 {
-	int ret;
-	u64 pfn;
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	if (kstrtoull(buf, 0, &pfn) < 0)
-		return -EINVAL;
-	pfn >>= PAGE_SHIFT;
-	ret = memory_failure(pfn, MF_SW_SIMULATED);
-	if (ret == -EOPNOTSUPP)
-		ret = 0;
-	return ret ? ret : count;
+	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
+		int ret;
+		u64 pfn;
+
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (kstrtoull(buf, 0, &pfn) < 0)
+			return -EINVAL;
+		pfn >>= PAGE_SHIFT;
+		ret = memory_failure(pfn, MF_SW_SIMULATED);
+		if (ret == -EOPNOTSUPP)
+			ret = 0;
+		return ret ? ret : count;
+	}
+	return 0;
 }
 
 static DEVICE_ATTR_WO(soft_offline_page);
 static DEVICE_ATTR_WO(hard_offline_page);
-#endif
 
 /* See phys_device_show(). */
 int __weak arch_get_memory_phys_device(unsigned long start_pfn)
@@ -611,14 +622,35 @@ static struct attribute *memory_memblk_attrs[] = {
 	&dev_attr_state.attr,
 	&dev_attr_phys_device.attr,
 	&dev_attr_removable.attr,
-#ifdef CONFIG_MEMORY_HOTREMOVE
 	&dev_attr_valid_zones.attr,
-#endif
 	NULL
 };
 
+static umode_t
+memory_memblk_attr_is_visible(struct kobject *kobj,
+			       struct attribute *attr, int unused)
+{
+	umode_t mode = attr->mode;
+
+	if (attr == &dev_attr_phys_index.attr)
+		return mode;
+	if (attr == &dev_attr_state.attr)
+		return mode;
+	if (attr == &dev_attr_phys_device.attr)
+		return mode;
+	if (attr == &dev_attr_removable.attr)
+		return mode;
+	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE)) {
+		if (attr == &dev_attr_valid_zones.attr)
+			return mode;
+	}
+
+	return 0;
+}
+
 static const struct attribute_group memory_memblk_attr_group = {
 	.attrs = memory_memblk_attrs,
+	.is_visible = memory_memblk_attr_is_visible,
 };
 
 static const struct attribute_group *memory_memblk_attr_groups[] = {
@@ -878,22 +910,41 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 }
 
 static struct attribute *memory_root_attrs[] = {
-#ifdef CONFIG_ARCH_MEMORY_PROBE
 	&dev_attr_probe.attr,
-#endif
-
-#ifdef CONFIG_MEMORY_FAILURE
 	&dev_attr_soft_offline_page.attr,
 	&dev_attr_hard_offline_page.attr,
-#endif
-
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
 	NULL
 };
 
+static umode_t
+memory_root_attr_is_visible(struct kobject *kobj,
+			       struct attribute *attr, int unused)
+{
+	umode_t mode = attr->mode;
+
+	if (IS_ENABLED(CONFIG_ARCH_MEMORY_PROBE)) {
+		if (attr == &dev_attr_probe.attr)
+			return mode;
+	}
+	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
+		if (attr == &dev_attr_soft_offline_page.attr)
+			return mode;
+		if (attr == &dev_attr_hard_offline_page.attr)
+			return mode;
+	}
+	if (attr == &dev_attr_block_size_bytes.attr)
+		return mode;
+	if (attr == &dev_attr_auto_online_blocks.attr)
+		return mode;
+
+	return 0;
+}
+
 static const struct attribute_group memory_root_attr_group = {
 	.attrs = memory_root_attrs,
+	.is_visible = memory_root_attr_is_visible,
 };
 
 static const struct attribute_group *memory_root_attr_groups[] = {
-- 
2.31.1

