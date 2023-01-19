Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD9A67443C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjASVXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjASVV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:21:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45643265A6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:33 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKx1WI031429;
        Thu, 19 Jan 2023 21:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Lb3MhSGzC+YlVfqsSRiHS2gYkZi4Zy1MDQZFe/eP500=;
 b=sdZnZ7g/cNDfhg5b3TJShFcbVFe3rkd2z5odl5nqYj9h7zGkcLNjl9xQu8sbHUuoYQkk
 2QOtzb8Bgh1IPesLp2afhRKmRehcB0qd2p+OdTdJ98b+CPz70qzaX0e0fblEvYzLPqKr
 hAZfLOvxiwooGICDAyZ8+8Xxb5h/BPsdM2pcI/uThSGpCzwFdDf1aNyqOKe7wBnkF9bq
 S4/tk8kZKJWaZblwpMZTURyRgjnsyAyyIbts2HnFFGUSXtnUmMLG/k62JQ0gxtwwR8h5
 R1ZQVVkGGVdq0aJqxVJyREdrxeKbsYX63jYQ2xIv27+rtLIa07/ZNf++cp3Xs86yerrW bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdjpmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JJXNB7018679;
        Thu, 19 Jan 2023 21:15:10 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quh8tbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVOTIceGRA7eHI0BMOSLfNfG/O1cQzygDGVc7CE8ZiBWXCnPn008H6tnqXGBMrGHTnuW5uM2IK2xlMvbiLWjJar89cf4fEwnGL7K9OtmZkeYvfFKJ9P8Qd1ohyI5zTAi42Ov2meZXvnRtOiMp5NRKLz8yrPyw8Yy9+dmQFafkFJTD5V1OtMsdx1IMYuf8V8GrBNn7yvcfxw0Fu2cHupp9WObU0jOk2c2w4CoWM54VBKa7DUIVet4a7ASCvN3rhWMxIEb3DyY7PVnywmM8OCO4FWsXx6XqlNm1EockBObI6NeUc6OHsymRH6Zgz6XL6fxrwYvVWU8HIEJw++tLe8l/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb3MhSGzC+YlVfqsSRiHS2gYkZi4Zy1MDQZFe/eP500=;
 b=Oy4hE8F4ZQruaG52ErMme2InlbnbA7ryE2UUKsWQGGixqzCBMDUafVuFGSigKiBHLxTer9YovVdRDJRqwA5S330wnMdDyFszFaTPmJqpn3ygfoMK20AVbQIZ6iQ40wd2gaqlzPV8nPeqD4ECveoFHdRKWEEBcgUmVOAoAnH990wHziRsEkMRfVwbLB+Ntgzlz0xYsDGjeQn7XKVcItN8cmhXf+PS974mfd5yDrZKacK/XqPIJDu7DPaLahAPYWp2sZla9tTKH0n/mK0gwm6/6NPwWcrIGc3OXILA1iVcfdntxFOL0pp1MMfoslGIuQGXtqcKL+UVIuIEkVblvs3xtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb3MhSGzC+YlVfqsSRiHS2gYkZi4Zy1MDQZFe/eP500=;
 b=Qf9RdkBxQ0Q2WCTYRS/NM0SVdG2wUiPMs7gCrDCg0CHVnX5p1mhcY1gDZncb0vFqfzer8/XnY8j9Rj0xSETpXd0SnXaROAl/5DcY0dlFgMfVL+rOJ2CSoElB5HwAfrIkssajAkOrHT74k37w8gszGyoSPs0Tg58VFvl9zSBfJTA=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 21:15:08 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 19 Jan 2023
 21:15:08 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 4/9] mm/rmap: change hugepage_add_new_anon_rmap to take in a folio
Date:   Thu, 19 Jan 2023 13:14:41 -0800
Message-Id: <20230119211446.54165-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:180::45) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|SJ0PR10MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0c61d5-7b6a-46d8-2cc7-08dafa623ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ED63qpPHxkhHjFMyLkRWLp4mN4YP16nRYtxMQCb4kupghspkfCSz/6gH0ZOfu3I8j4+JEXFaR8xVxCoYqHBoQdE/XoMElR6OKjNhEzkxWtAtsoLBp3kCFJ3xvupUKiMEJ+bQXIe06qk4GfENng2qzSfEy877DRGzY7crgeLRkxxz8pHeEA7uutd2nYP74ejEBKF4Z0Nba6/oiamxwbR7N2QzpLsNBuvQdBTFEw+mxCzl3LbIZO0zAE2iLrMmfvm9Q74EdOz5Pz8dJyG1AxTsk9Vikc4dOomrv+QMiFabikS5NKEko8vkQCgtifMX3pTBwQU02XEOLORLqqwMA9cBXEE3KgMwkOO3aj2K2yNwLVQ827ifdsfhhAdUfLuPGr+eJGXXODbnyIXSy1cXjzPBPrZtzMBC4GmzKfzDfc1vhqo+zZEw4qrD1DpmcmPITCbIS21Qy5B4lFmacweJocWF+54GzvYsOPxi0JpNH34nzNN/v0g8gRNFWREF9CMHO8A3q0gJEf+5Vg6oEca4e/Lffmv7StyVAQQ5+dil/k5v50fcsNECkbyFokBZjHUibxT3mWmCoPmpXJHgnHwaULRPJTpgJLXCvl80Z16DNOXkxoWxdAvsR8I92/d3YhL/oBHkNYGs7AqERJlw4Bp3H2Ecsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(66946007)(38100700002)(66556008)(30864003)(66476007)(478600001)(8936002)(44832011)(2906002)(5660300002)(4326008)(8676002)(1076003)(41300700001)(2616005)(6512007)(83380400001)(186003)(107886003)(316002)(6666004)(86362001)(36756003)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/a9KMfO3772Jb1RrZm9S+SgGxyLUMJSJD8mHqSWUuvR1Jmqz8ZMmvjIo9mC3?=
 =?us-ascii?Q?dlnGSXwGyPIPgnLsj2epVxZmoorLJOz4OYc6/7RpdMtcYwcpYhN3Ib/NfYtL?=
 =?us-ascii?Q?c4VveKrg/VuIqkQDKho9H7EVeymoBPwScHcJWbXZgoYeMHx88NmMdcbJhZJi?=
 =?us-ascii?Q?mle4Zz/IlavCVHSH40Goj9JQRUWW7d5dg+rkVU6DwiRRQVDOwd3mchbQ83ir?=
 =?us-ascii?Q?S5LIcPqrWQHCFHNeFZPKEXs7ydfI6lpf3rmPwfJE2McQ+y4HNztUok6PGv45?=
 =?us-ascii?Q?1ItCMAVKRB6p40XFdxL48y5ymmBRWnkNsW0ml6bd3Xgc3Bq65kf6RAgOvtAo?=
 =?us-ascii?Q?hVQOxIlw2cP12AhxJkdKhfQknztofD3pAaX0hDlUzZYXV1ny1jgSFxT8/WSQ?=
 =?us-ascii?Q?JJei+NnrrtGRgq/xzLl7lD12v4M2uwXou4LcWXWWVBImkLdFs2yrPTv8kS9P?=
 =?us-ascii?Q?T9YAdsHsa2cyzB8ZjtlHfkVv+uQ/f3dUKkkR74lBpAgVFl0qzwfYOYGTJxzM?=
 =?us-ascii?Q?JbTL8XVSKlCzF7cHPGFjXN20lnkoySKIzYe05rtgvfnUH/xSUOEDEQHkjctq?=
 =?us-ascii?Q?6U/w6UT+WXkhYOv4/j+vzp1k1yvwGW548wFgNSHkUm54fsuB1Dg6IrQyJrkp?=
 =?us-ascii?Q?2ZHFh6CoZXn7JSacOjMDGfLWz3yWMGSfmH9fdoxthYRm3fthoyFB8j1Eepb9?=
 =?us-ascii?Q?zP5pFWTQb+NZdCjG1ac0gXVNSKDXKBVCXfFJOKhkFZ6eF4Ul0a7w6aOfooRH?=
 =?us-ascii?Q?E4px/cNNEfxTHX4FECUYtfKrkD2RO9/I3ha0AMEpmKUovdevLmNy4Uz9vjtj?=
 =?us-ascii?Q?Ev/RvnD5TdPpWm2umf/O9aT6d2R8olXH8+EOfHy0EkKBdCV1WGTtYPY1W4+x?=
 =?us-ascii?Q?DaydmM+eO4Ukf82lIiCEeRyDxn47hg6/u+fFHoPtnPuNrdRy/V5PEjPskpax?=
 =?us-ascii?Q?17W0EB51taLuXrhS3Cg3r2onlbiyBODXRlP4wRqVOqrTwtCmfoxxDfKZmcYT?=
 =?us-ascii?Q?uJAvDGj4AxQd7S3E7wGmjjdsaQbDQMsm8hOm42sRRSd07GebK+1ArUW3bIHT?=
 =?us-ascii?Q?MysAr7lTcRtd2jr1LRSjtq/IlSyn6tHWuErq0jZoPZFsZ00Ng1nGWM1luWNj?=
 =?us-ascii?Q?S90RCqS7fMO6D2jGPde2lFdZSbtsmyEjw7HwcVLR8eLf575XjNCcOMeVxkHl?=
 =?us-ascii?Q?2z3qLPJMWi9UVxIJIuWZBebkcM6zXmbTes7W6pRHhXGiwg+XP0dB0SGucE99?=
 =?us-ascii?Q?9EVQzTeNra+Dqwv1iRIw+xRPYCwCQhwpYohXWXTCMViEtaB9p2LlAP1/uJum?=
 =?us-ascii?Q?li7dR7wjnNVHa/18nemmTYS2KB+Gwrx60VkBkqNOYaKtu+/d4qcYnvx0iLgP?=
 =?us-ascii?Q?4+ZHp3jfaaJEdjtXBpXDy8kXh6u2qL0v7gD8biXBvwZf4zBlLdK+cSh2Cc66?=
 =?us-ascii?Q?R9ZZ3X84Q7EuM9UlU/j7Fr+8FY89+kyj45KF+5caRWpmewte2eMi6e3dQzto?=
 =?us-ascii?Q?wG2boGCVirqsYfsQbptOYOyjAdktQwOZnhmUYHPy+KmFRuOwybjpItL+QsJ5?=
 =?us-ascii?Q?P+6fNo+6Xzb015BXgNojaUSWGP2nUB1hG2QbCnYbArh7DV46I8+09q02SXFe?=
 =?us-ascii?Q?yeLiir5tnHT9Aoot4Ai1WqtXwcsYvcuQsowTMDOLe5kz2aOat/BmEV1l91iw?=
 =?us-ascii?Q?Mjr6Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8QG9O75WaYrYA3U/ixjjEpiKfB8PwOk9NaokaOiEge0HO6wRHKzfGMAmrUiS?=
 =?us-ascii?Q?zxHF6GylUlGtzqY3tlT3Vv76HMROQu9RK82bXy2F0r8jN/duaHOVSN3WOvfH?=
 =?us-ascii?Q?HueD3uVmak+TwQKPt8JGOFSNLPpVsGZD9Ekc6+V7H6M/ELr31gsr8BM9ZzPW?=
 =?us-ascii?Q?JdBrvzltXddez32K7mO7iPYU9xWixZBvxdQtja922xOJ9uMkG1UaxLPswwx+?=
 =?us-ascii?Q?tfcrYBZyyJ5lbpKuzbCE5i2e0GwYBAzP+3SpEDXXLKwklit3g/IY/3lFuyNL?=
 =?us-ascii?Q?vleETJWJXo/3CPoSNOd70QvXt+pvRf7HMpGCTPu0f+WMEZzbrXWNHCdGiRaG?=
 =?us-ascii?Q?fTRbhml7MeLzsJYh6sY/nDt7gMqqqjoC9n06Mmpks5x5OBUzdNMzJz1Enb73?=
 =?us-ascii?Q?5j8f3ui7mjVRchRNTrsIO92YkuYKUJ+EPHwv6oI5o+IhfwvotBqfGodMj3hL?=
 =?us-ascii?Q?rWO1l0+SEFtJPj5O83nHKGK3WxKZyY4wJytwC2W4QlbkJd8723ESeHeuiJJO?=
 =?us-ascii?Q?+ZB0UuGxjetct4suFFig9RwzKcCWGATTaNzWg/wAF4yp4EnQ1o06WpHpID01?=
 =?us-ascii?Q?K2rYsEN3zCP0+Duqt+3ntsNmtku0HDpXfFfebghWFM31rJGeZUpwJ141nPmA?=
 =?us-ascii?Q?3ZvOyicTq4HYTeL4T4Zz9Ee0O9fiB93voiAj8D0hOo+9HxUr+g5Kp+ufDX10?=
 =?us-ascii?Q?Q9En26Fv6WRfluucTJQG2B3EaTsnPwkt9EefXy5ZP+XZdhn9sR07J1pUZOu4?=
 =?us-ascii?Q?P6Kx5ueTQqMqabjUTNINErryQW2+ENG26WUWay5aY7W5KbOzqe9A8f2SRaee?=
 =?us-ascii?Q?t5k4cXCoVfUdRiG+Cr1pwBwVTOloQTTq9gohTV70GOQvTOsjyLqrTdFBKxpE?=
 =?us-ascii?Q?F+tolklr6v9VJouodfOxX3sweAO1bB6TxfHTDpVLD3VEqnmP+RhYlqWOe/6i?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0c61d5-7b6a-46d8-2cc7-08dafa623ddf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 21:15:08.0933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzc1PayUBTn8QwNINePMcMRIs+2mVuVHc+os/8zMGiWkqceDqmhU4GwiZs+BCANkMfErOjy7xtTNV+9AE0hdh85NqLVWiBIFvACLk/n93dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190178
X-Proofpoint-ORIG-GUID: QQuKnIiI86Y5FVEVf4yTr8Tf79LWhpnA
X-Proofpoint-GUID: QQuKnIiI86Y5FVEVf4yTr8Tf79LWhpnA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change hugepage_add_new_anon_rmap() to take in a folio directly. While
adding a folio variable to the four call sites, convert page functions
with their folio equivalents. This removes three callers of the Huge Page
macros which take in a page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/rmap.h |  2 +-
 mm/hugetlb.c         | 90 +++++++++++++++++++++++++-------------------
 mm/rmap.c            |  6 +--
 3 files changed, 55 insertions(+), 43 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index a6bd1f0a183d..a4570da03e58 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -203,7 +203,7 @@ void page_remove_rmap(struct page *, struct vm_area_struct *,
 
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
-void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
+void hugepage_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
 static inline void __page_dup_rmap(struct page *page, bool compound)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c37a26c8392c..6f25055c3ba5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4950,7 +4950,7 @@ hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long add
 		     struct folio *new_folio)
 {
 	__folio_mark_uptodate(new_folio);
-	hugepage_add_new_anon_rmap(&new_folio->page, vma, addr);
+	hugepage_add_new_anon_rmap(new_folio, vma, addr);
 	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, &new_folio->page, 1));
 	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
 	folio_set_hugetlb_migratable(new_folio);
@@ -5479,6 +5479,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
 	struct page *old_page, *new_page;
+	struct folio *new_folio = NULL;
 	int outside_reserve = 0;
 	vm_fault_t ret = 0;
 	unsigned long haddr = address & huge_page_mask(h);
@@ -5590,6 +5591,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_release_old;
 	}
 
+	if (new_page)
+		new_folio = page_folio(new_page);
+
 	/*
 	 * When the original hugepage is shared one, it does not have
 	 * anon_vma prepared.
@@ -5599,9 +5603,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_release_all;
 	}
 
-	copy_user_huge_page(new_page, old_page, address, vma,
+	copy_user_huge_page(&new_folio->page, old_page, address, vma,
 			    pages_per_huge_page(h));
-	__SetPageUptodate(new_page);
+	__folio_mark_uptodate(new_folio);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, haddr,
 				haddr + huge_page_size(h));
@@ -5618,10 +5622,10 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		huge_ptep_clear_flush(vma, haddr, ptep);
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
 		page_remove_rmap(old_page, vma, true);
-		hugepage_add_new_anon_rmap(new_page, vma, haddr);
+		hugepage_add_new_anon_rmap(new_folio, vma, haddr);
 		set_huge_pte_at(mm, haddr, ptep,
-				make_huge_pte(vma, new_page, !unshare));
-		SetHPageMigratable(new_page);
+				make_huge_pte(vma, &new_folio->page, !unshare));
+		folio_set_hugetlb_migratable(new_folio);
 		/* Make the old page be freed below */
 		new_page = old_page;
 	}
@@ -5633,8 +5637,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * unshare)
 	 */
 	if (new_page != old_page)
-		restore_reserve_on_error(h, vma, haddr, new_page);
-	put_page(new_page);
+		restore_reserve_on_error(h, vma, haddr, &new_folio->page);
+	folio_put(new_folio);
 out_release_old:
 	put_page(old_page);
 
@@ -5756,6 +5760,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	int anon_rmap = 0;
 	unsigned long size;
 	struct page *page;
+	struct folio *folio = NULL;
 	pte_t new_pte;
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
@@ -5833,12 +5838,16 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				ret = 0;
 			goto out;
 		}
-		clear_huge_page(page, address, pages_per_huge_page(h));
-		__SetPageUptodate(page);
+
+		if (page)
+			folio = page_folio(page);
+
+		clear_huge_page(&folio->page, address, pages_per_huge_page(h));
+		__folio_mark_uptodate(folio);
 		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = hugetlb_add_to_page_cache(page, mapping, idx);
+			int err = hugetlb_add_to_page_cache(&folio->page, mapping, idx);
 			if (err) {
 				/*
 				 * err can't be -EEXIST which implies someone
@@ -5847,13 +5856,13 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				 * to the page cache. So it's safe to call
 				 * restore_reserve_on_error() here.
 				 */
-				restore_reserve_on_error(h, vma, haddr, page);
-				put_page(page);
+				restore_reserve_on_error(h, vma, haddr, &folio->page);
+				folio_put(folio);
 				goto out;
 			}
 			new_pagecache_page = true;
 		} else {
-			lock_page(page);
+			folio_lock(folio);
 			if (unlikely(anon_vma_prepare(vma))) {
 				ret = VM_FAULT_OOM;
 				goto backout_unlocked;
@@ -5861,12 +5870,13 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			anon_rmap = 1;
 		}
 	} else {
+		folio = page_folio(page);
 		/*
 		 * If memory error occurs between mmap() and fault, some process
 		 * don't have hwpoisoned swap entry for errored virtual address.
 		 * So we need to block hugepage fault by PG_hwpoison bit check.
 		 */
-		if (unlikely(PageHWPoison(page))) {
+		if (unlikely(folio_test_hwpoison(folio))) {
 			ret = VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
 			goto backout_unlocked;
@@ -5874,8 +5884,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 		/* Check for page in userfault range. */
 		if (userfaultfd_minor(vma)) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			/* See comment in userfaultfd_missing() block above */
 			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
 				ret = 0;
@@ -5909,10 +5919,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		goto backout;
 
 	if (anon_rmap)
-		hugepage_add_new_anon_rmap(page, vma, haddr);
+		hugepage_add_new_anon_rmap(folio, vma, haddr);
 	else
-		page_dup_file_rmap(page, true);
-	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
+		page_dup_file_rmap(&folio->page, true);
+	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
 	/*
 	 * If this pte was previously wr-protected, keep it wr-protected even
@@ -5925,7 +5935,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, address, ptep, flags, page, ptl);
+		ret = hugetlb_wp(mm, vma, address, ptep, flags, &folio->page, ptl);
 	}
 
 	spin_unlock(ptl);
@@ -5936,9 +5946,9 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * been isolated for migration.
 	 */
 	if (new_page)
-		SetHPageMigratable(page);
+		folio_set_hugetlb_migratable(folio);
 
-	unlock_page(page);
+	folio_unlock(folio);
 out:
 	hugetlb_vma_unlock_read(vma);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -5948,10 +5958,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spin_unlock(ptl);
 backout_unlocked:
 	if (new_page && !new_pagecache_page)
-		restore_reserve_on_error(h, vma, haddr, page);
+		restore_reserve_on_error(h, vma, haddr, &folio->page);
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	goto out;
 }
 
@@ -6176,6 +6186,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	spinlock_t *ptl;
 	int ret = -ENOMEM;
 	struct page *page;
+	struct folio *folio = NULL;
 	int writable;
 	bool page_in_pagecache = false;
 
@@ -6251,12 +6262,15 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		*pagep = NULL;
 	}
 
+	if (page)
+		folio = page_folio(page);
+
 	/*
-	 * The memory barrier inside __SetPageUptodate makes sure that
+	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * preceding stores to the page contents become visible before
 	 * the set_pte_at() write.
 	 */
-	__SetPageUptodate(page);
+	__folio_mark_uptodate(folio);
 
 	/* Add shared, newly allocated pages to the page cache. */
 	if (vm_shared && !is_continue) {
@@ -6271,7 +6285,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		 * hugetlb_fault_mutex_table that here must be hold by
 		 * the caller.
 		 */
-		ret = hugetlb_add_to_page_cache(page, mapping, idx);
+		ret = hugetlb_add_to_page_cache(&folio->page, mapping, idx);
 		if (ret)
 			goto out_release_nounlock;
 		page_in_pagecache = true;
@@ -6280,7 +6294,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	ptl = huge_pte_lock(h, dst_mm, dst_pte);
 
 	ret = -EIO;
-	if (PageHWPoison(page))
+	if (folio_test_hwpoison(folio))
 		goto out_release_unlock;
 
 	/*
@@ -6293,9 +6307,9 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_unlock;
 
 	if (page_in_pagecache)
-		page_dup_file_rmap(page, true);
+		page_dup_file_rmap(&folio->page, true);
 	else
-		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
+		hugepage_add_new_anon_rmap(folio, dst_vma, dst_addr);
 
 	/*
 	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
@@ -6306,7 +6320,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	else
 		writable = dst_vma->vm_flags & VM_WRITE;
 
-	_dst_pte = make_huge_pte(dst_vma, page, writable);
+	_dst_pte = make_huge_pte(dst_vma, &folio->page, writable);
 	/*
 	 * Always mark UFFDIO_COPY page dirty; note that this may not be
 	 * extremely important for hugetlbfs for now since swapping is not
@@ -6328,20 +6342,20 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	spin_unlock(ptl);
 	if (!is_continue)
-		SetHPageMigratable(page);
+		folio_set_hugetlb_migratable(folio);
 	if (vm_shared || is_continue)
-		unlock_page(page);
+		folio_unlock(folio);
 	ret = 0;
 out:
 	return ret;
 out_release_unlock:
 	spin_unlock(ptl);
 	if (vm_shared || is_continue)
-		unlock_page(page);
+		folio_unlock(folio);
 out_release_nounlock:
 	if (!page_in_pagecache)
-		restore_reserve_on_error(h, dst_vma, dst_addr, page);
-	put_page(page);
+		restore_reserve_on_error(h, dst_vma, dst_addr, &folio->page);
+	folio_put(folio);
 	goto out;
 }
 #endif /* CONFIG_USERFAULTFD */
diff --git a/mm/rmap.c b/mm/rmap.c
index 948ca17a96ad..e6d94bd19879 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2547,15 +2547,13 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 				     !!(flags & RMAP_EXCLUSIVE));
 }
 
-void hugepage_add_new_anon_rmap(struct page *page,
+void hugepage_add_new_anon_rmap(struct folio *folio,
 			struct vm_area_struct *vma, unsigned long address)
 {
-	struct folio *folio = page_folio(page);
-
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	/* increment count (starts at -1) */
 	atomic_set(&folio->_entire_mapcount, 0);
 	folio_clear_hugetlb_restore_reserve(folio);
-	__page_set_anon_rmap(folio, page, vma, address, 1);
+	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
 }
 #endif /* CONFIG_HUGETLB_PAGE */
-- 
2.39.0

