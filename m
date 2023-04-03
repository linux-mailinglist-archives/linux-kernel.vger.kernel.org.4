Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE916D3CD2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjDCFXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjDCFXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:23:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E83FAF11
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:23:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332MU6pK007758;
        Mon, 3 Apr 2023 05:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ohlWGuVeTFKX/ILJRWBRlxXLpQTPT1nzsZWWTdMkjxA=;
 b=Umr8tG/bSTqokt31/SwS8H6nVRyzLETUEd1pJhSfI38+SSBs9QM/3Kc43v9g1rLi1HWA
 CqJzKOSRWu7GYItYVXUu/o3vk5gcQ4/CChpYx2c1imXvcio0zt1QktC+wtdNcDRuaOAs
 oQaoeRmiro54Q8g/pKp2D0FzJlb4He0KZVcQppF9yJBJ/NosTL6gg4vg7ZgvMTJ6tCXF
 Hw+OgIiYdqoMs19OzftY2jdFYSxId9VzxdQufIPDPSdTyN5OXPY4I1WHFItiKkDanh7b
 eNP2QFmnc4lE0fh12qxcxnF93537u+cb2T2NEkFVQ0hjfvyKI7IAmTDgPA29v7YLqWeo wQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb1dj5tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3332iZTo038319;
        Mon, 3 Apr 2023 05:22:35 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjptnh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTkekeb43YDGaytj8ibdOp8kbxQRmitOIpWZBjfAWkYAMpHeWKdgvyPNkf/GrJUDLUswOpW2FHWzE2Q7/RerKKsxPIqrkg+5TPC7CnkHhftMgdnCbAOcnO3RwFi3ydw5CIfap/7+1ItAVcC6bAph0XVZprTCBV0bxdfFDS9B4C7woqrB74DPbq8ISmkC+KQDiyEjMot9Ctjs4CobgYEQ2u5hsa+1H/z7CcbH5ruc7LvDU8aQRxSqc29hFxySL4o6AbolR/79vgALB9KSL/i2aMuCmfljQQUH03xKi6mqncnCJDd7cHoxh3Ktt9aS7oEOA6E1lbjFsUwFUnC0ALOBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohlWGuVeTFKX/ILJRWBRlxXLpQTPT1nzsZWWTdMkjxA=;
 b=T3+lwwtbDWIuxosZQr7mbu1drV8m+YEFobi7qFxslRFa2qOUf44H4+Vl/iTljJ0JXfVyMW5lpRDgYwLPiOjZjZAdf8ee8d2McwO+CMuTN7kg9wa2yxChqSCmgHXzvDQ3N9b7mLhPlcSct9n3zMjkHK16BWLeVZvv/4wA1jOtuAopSAln9XzGYiTJ7XLdWWNNKg4hlmI2PymAAjuuxrWkzsK3pKx5CSPofIE5w80MRZdFgV5c5bxesJIMYHhgD4/rnjR5yBInsBGMsVRNxykffG401+2Aabh1PIw1t07M2h86eT7W3mh2mKqdSdvaB0CFRayL+hRB08yL8VAxCissVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohlWGuVeTFKX/ILJRWBRlxXLpQTPT1nzsZWWTdMkjxA=;
 b=gb4IdZuB+7iEcqZpYLUj+q87gpc6O7iai0Da2r+tnrXyv7oVSoGzvjnVgQ5jKwNRxG/xVXEjazyXNqvXb11o91NvB3btsaVuLTDlU+abbadzphxZ31hERaxAaftrLrjB9wR0h6TJldYpg1+49Jqm5KuPAiNlVqoxiVTsixWkI9Y=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB7106.namprd10.prod.outlook.com (2603:10b6:510:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 05:22:32 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 05:22:32 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH 3/9] huge_page: allow arch override for clear/copy_huge_page()
Date:   Sun,  2 Apr 2023 22:22:27 -0700
Message-Id: <20230403052233.1880567-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:303:8c::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f37a97-c6f7-4797-e175-08db34036cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g17nSWXUMfqWTm+Nexe+KttTvJn7LzjMkTOkxboC103/imibfWqRP+dRUAfy0MFiZ3jNho34I+Z5O8FmN3+0FXwMboZQuNpND9xd/2U0kbhed3oxKtcIp4ZFh52MnagA7VWrrRwHKIl/xpiEIZ12vK3J1DX0GnWPqWh6zgr2LMTQo9zWyWIAzJVhb12yWJytl4fhcgux6yreEErmcf8uvCi2b3niF+QVn7zLT4mduWYNbLPZzMThBR67aD2H1vR5GeQwB+RF9UbskebL7t1qCW9TWxSsMXqur96G7BDNzHVjpgLxJ7ql9od+TJP8M2VgHc3smjnMVdYu+3pZwb0bcnj5mYGillS9r3N6WudP+FX9Y2EapwbF1u1mTt8ntNF3wYUb+bjE3xD0wQC0jDYXYXkUO+zPcMMEHt5m6XQVhkika+qZR5KO0BxaPTmVMDL8wcHY+WPI19zyBmt4UNcxJV7J7jvCyoPwRw7m4a84JbiDFduLtwoamA3Yrmr0z9SNK3ZPKMSkmkvrWUQUks3/XvGAIqUwWZNVWPW4z4FKd5JguCbsoG/Z9py0JoQqvsuQ02F/29r558OAGgvOQzACYdo9GVkOh8bPQfIJmmjscAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(2906002)(86362001)(5660300002)(7416002)(8936002)(66476007)(66556008)(66946007)(8676002)(41300700001)(36756003)(4326008)(316002)(478600001)(103116003)(6486002)(186003)(26005)(1076003)(6506007)(6512007)(2616005)(83380400001)(6666004)(107886003)(38100700002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wlsYQxBY0Nisi8aeBxFdIVyAH4j2k7GBLV9PHGjuPzZYKNSHkfVq6//mQkp9?=
 =?us-ascii?Q?vW5PW+R1Z6w/9s93iHnlLWjJAB3bQRbws17+WSQJND4Gfp3PvWRztXQWPMq8?=
 =?us-ascii?Q?+qUW6tyAcNjZHf1OZnH1Cy3oMSRyLxI4kYk4wfCTroMT8ze/XtV9EWfq/qp/?=
 =?us-ascii?Q?IjqEA/tPRrx+x5Vym+NwWEKG3UIvy5arWju7R8QKENBb2HAVdasmSZjAfAY5?=
 =?us-ascii?Q?vp/E0iBBZb9KoCBuMfz743vKekPiT/mBe1h7zn/nVzXjty0x5wdo+QieQVpP?=
 =?us-ascii?Q?TKFXKf2ha6jcwMMIpBZ5ML8pkoU+L5vXyhRMR4Izw8oNR2hqBNuuIo+4EGal?=
 =?us-ascii?Q?OeK4SvGqIn0xFnmsj5MKXOgJBy9nQd4HR6ZIgKYrYGvsIuE6I/WE4t2ilh3J?=
 =?us-ascii?Q?MBE2L/KoeJJtJ7hHaTIvLP1olsCQR14dSkpo47CoB3PbNyU8oTL0o7h0+gsG?=
 =?us-ascii?Q?e0GageCqBcrxaUpQn867jMFxwdAhoUtXSzX6Tr/i4+SFJ/jvd9ibHI5AT6MK?=
 =?us-ascii?Q?Up9K4q215mC7kKEbjB7M+jWXfQLsRLdcL/WTj037CA3mhYBi1FqRS0+gnEhO?=
 =?us-ascii?Q?la/JL2FtudCOIxfPHEdcZp72HWiweEY3XKlO44LqSmHue/FRTjK7ZRznmCg2?=
 =?us-ascii?Q?fBxFNx5xmALmkQI/wMwO1DCYPP+BGX7BCgMegE/qKeYRPpg/dNEcLJPcfGAo?=
 =?us-ascii?Q?nbamqehrkRW59fqafecZPLGh2F8bFotgqi1Cfp1lgojvzpTkq2XhWl+b3XRo?=
 =?us-ascii?Q?Dr+sfvsmBg4d/CtABr4lweIjsTgchSxPuz0Q6+tFiBuUOSoR5CFpQoLefbmr?=
 =?us-ascii?Q?HvJEL/j2tE5goCBcxzyVl6iChc0+nBn4xW+AQFftwloS6W1RmVuVoXGjjI6C?=
 =?us-ascii?Q?m5FbxWr6l2H+Y/Kn3i6iap6XDVrz7R+eUc+18PpuAY6gFYGLs19L/bSxMxwT?=
 =?us-ascii?Q?RVe+AWAssddLrKBWtsWpnJBawijj+p0+/dS0QIRO+VtqMue2qtYZPJhs5y07?=
 =?us-ascii?Q?xGAOn0fRBvQVOi3kA8aQ5+CHNZCljyl4JZFEIsP3I6UenBNVfBzNmyIJKs7S?=
 =?us-ascii?Q?NRoCYM9ljDzSFr/zV4xAG78VJpdWgoh0uOj+KYEkaEfqMdjpRh5bDBL4Vj0J?=
 =?us-ascii?Q?y/k2K2L/kPVGmJlWfqKR38q28UgPQk2Pp7CZJ81Q4Robaxou0AzCa043/vZl?=
 =?us-ascii?Q?9CduJgc8UzQYr0ZC8wFLxyJjCUoaJVFKo/lqyswWZKCxWHSFTlbyISZD/qkZ?=
 =?us-ascii?Q?NX7v6qwn3yPqRhKSKsG8ul6gfa3YnS3ZRYokuJSmRRE3iPaiuL/W7eIVC8ST?=
 =?us-ascii?Q?W9jiEZf4ZBFBxrEIR+jckelBBTmsGwtBSnjI+feMtbOv0OBUNa4SkCROyMCP?=
 =?us-ascii?Q?+DPg8eoRIm8bIKF/dZZ8HWP4OFVjoP8DSteky1ydF32A9awPOpyzk7VbIU5G?=
 =?us-ascii?Q?RfvESJRXBYVcuy0b46mtXVPDgUJlhnwBuiyOBrYrZdqUiJUUmSHamGjlzUTf?=
 =?us-ascii?Q?VfGMFdKzzkZai6tPg0GTykwCUG+8SiA6m7cNU53mVB/FpyArWZiRNS/Fh4JZ?=
 =?us-ascii?Q?8mZAilp+HIZZwblQlgV/RKPZ6ptPlPjkDZAlB1C3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6e0FLCQ+TObGhDfhFPzRPTGMNfJoow+YEhi5Vx+XU3Ub0tJ7l5c6qDftuEAO?=
 =?us-ascii?Q?c3SaPxFK1uzl/sz8J/g5gCAKslwZZWnpTM0IbM3ivxuPrYYrz2dv6CdfVwje?=
 =?us-ascii?Q?/HI9xQayT3Nh65GVA3i/QEO111D36XV0uUAvBK2rontz27fxktQMhHloAoqw?=
 =?us-ascii?Q?4k9on4JYju5AWM/9YzTeg0q3e6FuUgqYsYXoLmKzPZU9DavapHU71P2FczNh?=
 =?us-ascii?Q?LxN9veKWYAPYETmYBvhEn6YzHGnLW/U2OKUYGQaNq7oYzNYCaf42SzCTBTXi?=
 =?us-ascii?Q?tW8eo3suuTdjqtVLHYiRLIM15JOUYQERKF/K/6WLHLCtoWp6dhkpXUlCiRkK?=
 =?us-ascii?Q?igpPdSCt63i9G0BmLBQnjJ6yVXVK6BdUIZPcmg+b38aWQ6xl/u9M8jBil622?=
 =?us-ascii?Q?+w27l9cvmszEB7hye34l0rXilTbe7ke/JvzglVPvTBiyVIna2F7zpmovGS56?=
 =?us-ascii?Q?KCsJwF6ZZvnbh2qc9VnC0YNAWeoEBlz7Md9McaMTZJOHf8V9HFNqmuQfhDai?=
 =?us-ascii?Q?U3xXwEkcymafwQbHx+coINTBWxHUZbgDmzlNsPDVQI+yp7Cg9m2Ua6NRH6Gt?=
 =?us-ascii?Q?Lsorr149K81AakdEKK6c1m2oG774e2Buasg+58kl/6+sYU2MghvWMs2cDVTd?=
 =?us-ascii?Q?6vvT3Vwqvex70e5V9NTF5XiYV7DwmAtF8EF2/3HymWef9Fyqt3BF9gfxxz8O?=
 =?us-ascii?Q?ouZwxx6fvtUdUGR8FWf7nHjZvYmDGSRMe7alpM4448LGcgbL8MVIIy0Mx7P4?=
 =?us-ascii?Q?CQngz8vGWVPYupevmV+4A24uV2xcZLdcKLOF8Fhfhbui/E09JJUZfcVdzVhd?=
 =?us-ascii?Q?tFaaATrL2qwJ/bVqwvbWh21ZvQJKkmmgg9844iwM/gnrM2qYFzIUrZkuRKsW?=
 =?us-ascii?Q?QmfpNVbcD9Vftl2mdoAjvNHJpfo3uPHC/IHtNhPsJP9kRRwiKjbLbm1c9gon?=
 =?us-ascii?Q?pEplWRSwpgx34yf/0kzR9FrfcOsrhYVIvB1AjJTOqu+QOus6gPXqXa27eY/H?=
 =?us-ascii?Q?pu0fdo/fPTtPGGyNPf9yGRW+SZdxB4Rv60p16jWjHr0BJ0L2V3UVNjN2r9Ia?=
 =?us-ascii?Q?0YNO4ynT0L/749d9GhbtxDZ4JrR0ScPUYwPgShHE2rPK3cNLJNYhl5ig4z8g?=
 =?us-ascii?Q?ZUrzvRE08ea8tq3z9csweudX6rPwbaIN7f8Z9n8Ex8mIgccvnOPIG88=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f37a97-c6f7-4797-e175-08db34036cda
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:22:32.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNJXMkL48RPF+xFdQXcLCh0so6eMyDa5HL9gezr45m7jf5XtCTvjoS1tnyCjf4dVMTs88RSIBfpiVA+VbXMR13gPNT6KLzT7YbKEoc9Y76Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_02,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030039
X-Proofpoint-GUID: ewEv5zCY3Gyz7aBBO5lxVpjQuKxkAKo8
X-Proofpoint-ORIG-GUID: ewEv5zCY3Gyz7aBBO5lxVpjQuKxkAKo8
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear/copy_huge_page() are constrained to operate on a page-at-a-time
because they also handle the CONFIG_HIGHMEM case.

Mark both __weak to allow for arch specific optimizations.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/memory.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6da97e6c7d21..9a6bce384616 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5645,8 +5645,12 @@ static void clear_gigantic_page(struct page *page,
 	}
 }
 
-void clear_huge_page(struct page *page,
-		     unsigned long addr_hint, unsigned int pages_per_huge_page)
+/*
+ * clear_huge_page(): does page-at-a-time clearing to handle the
+ * CONFIG_HIGHMEM case.
+ */
+__weak void clear_huge_page(struct page *page,
+			    unsigned long addr_hint, unsigned int pages_per_huge_page)
 {
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
@@ -5712,9 +5716,13 @@ static void copy_user_gigantic_page(struct page *dst, struct page *src,
 	}
 }
 
-void copy_user_huge_page(struct page *dst, struct page *src,
-			 unsigned long addr_hint, struct vm_area_struct *vma,
-			 unsigned int pages_per_huge_page)
+/*
+ * copy_user_huge_page(): does page-at-a-time copying to handle
+ * the CONFIG_HIGHMEM case.
+ */
+__weak void copy_user_huge_page(struct page *dst, struct page *src,
+				unsigned long addr_hint, struct vm_area_struct *vma,
+				unsigned int pages_per_huge_page)
 {
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
-- 
2.31.1

