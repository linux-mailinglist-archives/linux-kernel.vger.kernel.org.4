Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABD3628DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbiKNX5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiKNX5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:57:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8364C1056C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:57:32 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AELDlQo011985;
        Mon, 14 Nov 2022 23:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=y+OjshjV05r4nrc/LDP3cdXQCywZoYGW7hlpFiTNK7Y=;
 b=DwVp/wBpzchXAE542IyLf6eFfDTKA3GE1Bg88LSjX1d+9vuiJNwVmNlGpiNQ51Bb0dmp
 xSNaaAd+ObQsInIfEw0X0iWiFeyvhc1BnRofu4UuHxf2j0HBF/47pVAlLrjefPp92h91
 Vb/31Wj/oToQpPXy3Kz5eKb7UPempnyU270CfpnzzCmqzlYz2PnNPE5OF7JVKO3t6Zo+
 4Vt0lVKGReuf/cs8efeNs+AHzFTFqc+hCvYeNitbpx6tm1IOneUyET+7oFrouk6KUxLA
 15/nSb+h23wG2zOQOjKbe9rDy4Ngi3gDeRKglLS5/L8XxuHLQfrNFKGLAxsUYRtqX3S3 Ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kut2dh2sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 23:55:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AEMV02b031870;
        Mon, 14 Nov 2022 23:55:14 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xaxy6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 23:55:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGtbpB0GLV6NtJRAVkKOieeU38vKYVPrco9rvb7L5LVfyBP4clxkTzxetPF6fGTqheXVXTEPznZq1+eySO5NIGFRcQG/6fJLct3bCiLRiKzWMxs4h86pX0k5qJqL0vXs5RpfK3D4e8Dzg82WQPuk6NcSVz4cQjGVdddTWprM9Cc113IW5NSs2tOWgeigmDoGJncjfB+CcVYbENU24TF0p+Km/BuMyy63qxYbL8C6yqNqGWLftXeN3QmLdXaIydpv1lWve9WDcP8jV3KmdxDI3a44XmzC/NYJolUvyo/EJHx7ZUWQxBp8mTwilnTgk7P7jKkUISd2rbkV0RYA7iyHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+OjshjV05r4nrc/LDP3cdXQCywZoYGW7hlpFiTNK7Y=;
 b=hlWgKcrtrafvlvxMTHT0W96aDdC838qIfaut44IA2tFF5/3u0/e2ku0wArPwHnxC0R5AGu85PGABbQFSiDZuMmdzebSKF3K1INAVmErxDR/OPp2I6xrmUanCdUkZu+yP8Jk88LII7ExDXOpoqV8M5iq4wLctx9xaUQQDw/psde86zK4SxCxN59WW/QSta3CsGtKJGHeEGpWFr/Nqz5T7MOD/Mt8md+86Ts4xthQsTgVCd8rZ31++va+8ry4cKyB4XrMFFnxVa1m91tjjm7EI3EOO5wkixaqR76blm6e9wGMedP5NyE8Wvwkbh5aU/0Qn8PpN3TW/+NnAGMqPrp0ECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+OjshjV05r4nrc/LDP3cdXQCywZoYGW7hlpFiTNK7Y=;
 b=CuOGigBFk6W5KAS3hT5Cr1KCQ7aKpxAirgKUbzEGBkdBxcotjhS3lTvt1AZmRf6MvvSQk/fl6We2cLvZR6WnU4S5xn4ja+Asd/HWnfM5UluTy+LKU+SFkU7oXzGsab9IMtBiI21wPMW3VXwa0+cFb7o+Il2liCGOhmyDS0lxIhw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4178.namprd10.prod.outlook.com (2603:10b6:a03:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 23:55:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 23:55:12 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v10 0/3] fix hugetlb MADV_DONTNEED vma_lock handling
Date:   Mon, 14 Nov 2022 15:55:04 -0800
Message-Id: <20221114235507.294320-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: be1b9b54-71fc-4daa-84aa-08dac69baae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPW/MiH0oeFuzrW0v51MPKLTmND8XopbdEsRaGQHeB6HfKPu0rZzdUClnke22OfHjbIgRjD0VJ+YI022UbtbBTf33XjcnHDieoWUVPxIXQW4SUvMAx61NQotulJrJfA3wbz6Ze3VsR5LHpbiOtlKNOmx+SiFuNInTtDpqWYv+vH7jn0yKvtKi2r/11+XiQ02shhPrZe4S1xUmTOE6eNW3DgADaKR1gEhAglGFxG79JVr2Rv0QdLWcQugCTG8gWm7Ytipwm3VlZpqQhJB2x5G7G1pSkaceUd/UrmMxOVajDOCIUfPC7kfWsNYPUJrztqhTWr7NZR14+ZWKW91EF/MD/Ld8Syi4LAec0xy9+mjtHi7GgP6AYVeQIbTZpHfqSHMYlkOMyV52oJrmXEw1gtgEA6bVyj/oP3BaHD4OntENCrEAPKBe7cl4qGS/wk0OFJwHFbmoexd/rWT4SMKBP281rfxSDxnFGPlR/h/nPtvnzPJlTEE2rsXkwq4SJlFfOw44/Zlhjp6XkEl8Y23jGgMdl4YjOUYUr0SX3C617FiAcG++n9h8ktuxY71U0i6t/OGHzHHGhC/vs7ZI0U58/kn0jhvAJ3CrA8dtzqtnLxrJxjz/gMSZriYi6EBFvPEgJBy012t8VDQiVsEhKKRG5BQh8V/gHAYBk7jVKQCmyhrsE69kg2EHNPsC+3BJjEhod/YdV00bInHVjxYlw58EBSOysjAobtc8tg7zsfYXoA1BlCa+sqWC2GvAGsbqCaxPE5OHGht9w3fs3mqY8xFuQqXeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(2906002)(4326008)(66556008)(2616005)(6512007)(66476007)(8676002)(66946007)(41300700001)(86362001)(36756003)(1076003)(38100700002)(316002)(6506007)(54906003)(83380400001)(8936002)(7416002)(186003)(5660300002)(478600001)(44832011)(966005)(107886003)(26005)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QrBa9/AK26VkjhABbuX8E8ybz7iSXToXXu2EM9Wdja1HsDQJ8VDhgoYQOBrB?=
 =?us-ascii?Q?S93qfixPEX20LFKQTcRJQ9Uhw/v1Kx5G3HINOyH+vKpqp/w93iOePeALkUMK?=
 =?us-ascii?Q?UDqD6aHemkIp/nxeuGLWmk3XCOwezakVkYqHQCvePYfWAkFHiQSmqmu9p8h4?=
 =?us-ascii?Q?gk35qujG+cBxv6odv7vxO3sAZaQgmW2WQPo6mHydDGL7wQjH4jQ2XRcSgP+S?=
 =?us-ascii?Q?tXlmSrAVduO+Dus5WfAhW/pYg4k8PZmJInsZVZWSQaDEeaD6Dh9KwMF97CcJ?=
 =?us-ascii?Q?2niMaizMAfeWk9t1/bHuQt4n+aJZ/HejhuLBVOKMfccEzJfB1gJFmiKk+fIH?=
 =?us-ascii?Q?6B3Uht4jXrB07TSbrICm8pnviEYiyle2MQjBAA179qD/GRGx13fWbRmczWXn?=
 =?us-ascii?Q?VaQ29nrAlmwChuq6y7Xj9yxEkMW97JprUwJXGr/Fm6MnGUoMIIjuAg5nHmHj?=
 =?us-ascii?Q?ujOoMIGdbIr3kiUBv4MeTgg2MX1n79z8ZO8eGfoXT82VFXW3PYRAbwIIrpIk?=
 =?us-ascii?Q?la2kmJF+pDiToG6Z9u6e+nzNW/jG7ZjwnnR6f5mzNNt422acNZjadwHkunsS?=
 =?us-ascii?Q?DdrcQuwK7TdBNx4bHJ546ZDLikCLcDM4aV1+KaGPtHZCfagMJEam5SyMWltl?=
 =?us-ascii?Q?o1ET5kqjcGvzKvAWQaL/IE1/TamiwxICdY6ZhJvXXMN7DoAW5Mdsfbd/7Cb2?=
 =?us-ascii?Q?tftvtARj2XzybLQvIWpZBchlhyTc7ZQinOoS9KcyBntF6KQHLpfHlZcX5Rjh?=
 =?us-ascii?Q?UG4dbk8tf6lF1HbwPffApSx+MQL4r5UYgVpIjE1nEqQPFMeRX8h0D9wFMcnQ?=
 =?us-ascii?Q?SC/icbsgk9fm3n72OcC8FBO5liY2hv73Ax/TJj6NieWkRP5ExU/A5WpYLGrE?=
 =?us-ascii?Q?PmJ7xOY+duPlew/V6QFjWqqqCYpyDAcZKR1FfYEYkiPuw92aU298Ne81qTwB?=
 =?us-ascii?Q?Zy2l4VogMw7UP7J9QVG6i/RZNM+s9h2xM8bL/xdWjk3iP6+Ck0ZI+OuJE2Bd?=
 =?us-ascii?Q?m0Pw17/o6gIDBAiuywQDz0+brHz8tCPqHejDNHwGbtdkbw4SLDE3h0RvLkel?=
 =?us-ascii?Q?J93/AHTtpLotxoi5xb+yjWnb7U2JrpWpA84hOZOfeknbXGt8MMkXrC/jVCO3?=
 =?us-ascii?Q?oXIeiIh3kDVxpFW42RY2W6BYJbSffutjj3oOXRMVBlhqhkBCAH7DtrDHSXxG?=
 =?us-ascii?Q?HH2ILlX5T8x68yuapYlv28ASsm3RfCGAWjpM7c4VkGeyJDaIdN/nNP2B5i6N?=
 =?us-ascii?Q?1cTPwUsWky41nJQ/IPgnhUKy+6l3rcnouemp7wbdCVRMzLNLJzhqkJep2uST?=
 =?us-ascii?Q?H6v49cqbgcp79Ar8o8pUFzyVF9CMis/3IH6fXOmV/fafjdDj4lflWaKBfuwn?=
 =?us-ascii?Q?6KK3TyPdcg75XQjWTKD4mJ1LEgJGKnPG8X2gleFSaGygJDpdTA+GqQkHEecs?=
 =?us-ascii?Q?IuVZDcYCHd/oRCZNEl4lXmDwjeHFJFGPqJnhxI5kdLYdmFi1BHqjHmke0tO3?=
 =?us-ascii?Q?2jYYv3VEr/hCmCeKR9Ph02DSMB5XurhBUbSuXkeVg5Oa47I/JCaI/pvlUFX7?=
 =?us-ascii?Q?YYCKagZHEfQ4KKQrrATvi1NkQPmcKcESpkCg7NXMwkIO+GSzEq7CT5stKHd9?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rmlwmKwA8bCM8fvBVTEU17CbxdmMJmtftoLZxt4gkerFovVZ3gYO82fTJefx?=
 =?us-ascii?Q?OGdg3aPaMZuEZSrvMaggP+wakQJEsa8FUGUthUDVMNo0RHrNvu0HEUQRGZT5?=
 =?us-ascii?Q?UX4F4RkOCv1rYoDuJwAAFX/w95tOkvTFA+ckfKL6sqaCyNCsqIeCavaY0q5q?=
 =?us-ascii?Q?RfGCeOy3JQxziz+AhpJ/d7cs6wTNd+eyILW/NrZB1KhALb3kknHhhegYbtUr?=
 =?us-ascii?Q?Q3oSU0TYHEpT1NAihBlO6t9IptZbtV/0l2agkrTkpHmCAGr/wjegiUfdCggG?=
 =?us-ascii?Q?2R7WkljOzzFegEqhZIpBm4ztzBfYmi0f/O8eAlDc8LRW04OQ5onQkXH8LcwV?=
 =?us-ascii?Q?CZa3jU8yxUJEIeBBap8a1ifK6ejraRnKpfdON3l2xkaS6VW/TOk+kGZEEBz7?=
 =?us-ascii?Q?ZK3jtezeQAE/mwDNHBdRA4bNXGokkuys5cGJvBPXHwE/A/P+wzSEFcSuqKNa?=
 =?us-ascii?Q?uJYK203EirzBmh3b3OykfCy3s++FPET/kfJZkqquLZYPZTa8xmjZxcMX+ey3?=
 =?us-ascii?Q?zBTUEbInModD/DOzuGSHB9XAe3UNiuS7tZOVhoywkGkrwz3kLp1eJadFFi9F?=
 =?us-ascii?Q?DX+SOfsTyCahIqRfMNRh06M6g4zjJ+GF9HclUg4Nt5ixrNND6MbBkmaAGa5x?=
 =?us-ascii?Q?Y+57wfDzXlfVZl/FuYYLQzV8uGkSqmG+5m0j8MdUwKcJ0Yussk2Q5Bb3FJPe?=
 =?us-ascii?Q?oIXXsY6lML5H+ffrjrFrM5BrKUkYjFQG+/bVAN5rdo3SPKW1J4tiU1/PuQCy?=
 =?us-ascii?Q?RZ2/OYHUcaNyZ8fz+P9fba6yjJM4OtYjIIs+eAZZ0FpAGTRUZamBgAGiw2N8?=
 =?us-ascii?Q?jcM4QRKclSalVhS7hgncKeQtQM2ZCwGy8QpYVPFF3gIS7+mqAehRlZbfLJpG?=
 =?us-ascii?Q?Z+qGCgC5VvS3gpdDBXQV1cT6mj9UCzsRl2mxHGwE6QsmXLSKd45PDf+u0QKc?=
 =?us-ascii?Q?BBDN5O3gYfxd3HyhwwRNtRZa3sfsfxNRV1NXFSYZUf2YqXcX/qeRvz6SKk6Y?=
 =?us-ascii?Q?vbyjQLG7dfU7zl3XLgkk11Xjaap7pWryQUjpDDxQJq8TamEtlJ6RRRsows7n?=
 =?us-ascii?Q?GX0lqCLjEDMH5zYWPTj1e81iMFsruLqVs8r+3Qju4/n42hxUukw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1b9b54-71fc-4daa-84aa-08dac69baae1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 23:55:12.8150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fS9PwCoZIBBmb3Ojs0fSlNH3IXm3wN9f7r3gr6k9npoBo+PVYlWT6kmSrgwcmukbfw4mGej445USVdUIgtgTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=684 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140168
X-Proofpoint-GUID: kJfzGnhRKadrrqmJpMwGFsy3uwjVq_vY
X-Proofpoint-ORIG-GUID: kJfzGnhRKadrrqmJpMwGFsy3uwjVq_vY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses the issue first reported in [1], and fully
described in patch 2.  Patches 1 and 2 address the user visible issue
and are tagged for stable backports.

While exploring solutions to this issue, related problems with mmu
notification calls were discovered.  This is addressed in patch 3.
Since there are no user visible effects, patch 3 is not tagged for
stable backports.

Previous discussions suggested further cleanup by removing the
routine zap_page_range.  This is possible because zap_page_range_single
is now exported, and all callers of zap_page_range pass ranges entirely
within a single vma.  This work will be done in a later patch so as not
to distract from this bug fix.

[1] https://lore.kernel.org/lkml/CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6JudD0g@mail.gmail.com/

v9-v10 Rearrange series and do not tag "remove duplicate mmu notifications"
       patch for stable as suggested by David.

Mike Kravetz (3):
  madvise: use zap_page_range_single for madvise dontneed
  hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing
  hugetlb: remove duplicate mmu notifications

 include/linux/mm.h | 29 +++++++++++++++++++++--------
 mm/hugetlb.c       | 45 +++++++++++++++++++++++++--------------------
 mm/madvise.c       |  6 +++---
 mm/memory.c        | 25 ++++++++++++-------------
 4 files changed, 61 insertions(+), 44 deletions(-)

-- 
2.38.1

