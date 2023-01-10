Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5817E664E03
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjAJV3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjAJV3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:29:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FCE5C1D7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:29:04 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ALGkw3030256;
        Tue, 10 Jan 2023 21:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Ue5KRszYjMTnj2K1AHindC7y6fInHEG2p6kUaNmTi8A=;
 b=iMO/PPajVxFO19BeECZndmlvYZIh0EAoodECKmu0hzspwbUcmQW0WBPLp1A3YNOVeTVT
 Bnp5CAmm6jFu4W/pnYgeF6Kkwt4tPnEL/9ctbxJaq8wkkulj956Tw/0TtsMHUwxgjTrl
 EWTMKxQCWGGP5eSINKkpKUwes74b07QTotrmVELXx8hCUONUrHpI/k7KU6CkV0SsxQye
 zCgUTZ+lp5mC0EEtOitZBpJWX7A/cjBxbgaap5bnca4uRQ8ddJlNKWC6CYjlvy8KyiRR
 +3J2tp5cz29In3YVCjNC/XysnVFcNviBp73Y0ZOZUOqvuI48aJ4WAy0mRFn/wLejJ5Dx Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n14nf9syr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AJcce7024447;
        Tue, 10 Jan 2023 21:28:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1ebume2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chM2DfBur+/QebBmLXEUfooxLCLcIuQMMGhLtl4m5kaBlcxtqvjtmoxgJfpU2hn2nsnwBEKtqeabIYBmXOdl2VCGAcf2HagvcsB6rMyXgzv5l5zRfT5yK9h8JfqMNTrT5nyDdEknZPT54FEjE7JMIY8326vsFERL492YJ2iyynjbJS/olx5eOwg2mjfk04lvmk3LGPInEn7xwR+nPRlP6SH7N5rhZ4E8LccR7M4axqEPF9rs9BUItC5hA6dIQ0Ugl5AgBFoyW8/X4qZdd2xxb7tKnOGVyDTzVg7Knjx67fU81th37jmRllhVz0v+476TLat1gT4ShDAxbwOtGHQ8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue5KRszYjMTnj2K1AHindC7y6fInHEG2p6kUaNmTi8A=;
 b=jLKNzCfihGbsy1d7IGSi/IFxG7vUsLMoC7ca8+3bbq9Cnp7fkJ8ZCpaeybs+xeGmFeLgzYOiPaOXbb+EvSYhKwyDoKyYRQCqdvUurOras3eq29KA4ZRFzXF27k2z/HA6l/ZEPEzm6uKY+1GeS4MxDvO2lfoFmsRbvlMGNJGxw7JJtq8QaDNn6pzBCvk+CVwkzoZqlRUI1pWhtEAD4v+Ita2X8UlIVoHvY+CBIOgZTjsCNilZPpYZKVvOBF7MLqREbowVAjdcHhPtFGqOKAkrmh2wyEYozcb0cKRbIkCvkllq+ZthQKdzdQb+jYP33463UmT9GiD4SmUtJFCuycZ+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue5KRszYjMTnj2K1AHindC7y6fInHEG2p6kUaNmTi8A=;
 b=RiPI0k9NV9G1CXpmf1US8IqMj6F6qK8Ya9sCjgIaP1r4wnnLNeWT01lv+90+94zE2LqB63/E+svEgJrjqekHaIILgnQnZBAOcU6Z56WvOgwktZHmpjXBAfEI7fYy//K6pRd8rsCboNfCdH4eg48dIGtXvYQU13vhk8odhZNosEg=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS7PR10MB7153.namprd10.prod.outlook.com (2603:10b6:8:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 21:28:32 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 21:28:32 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 1/8] mm/hugetlb: convert isolate_hugetlb to folios
Date:   Tue, 10 Jan 2023 15:28:14 -0600
Message-Id: <20230110212821.984047-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
References: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::11) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS7PR10MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a814f3-84ea-412f-10f6-08daf3519fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5yDz8nknjeIaDQRw4n5fvsVxDpHdXxoqDwTrvyBc7qCFFoYkmXoBVjjIYnx/dCfTUaQexMh18WHh/0mf7lJjZD2NgdOTXXkME9lHJnDN7lbNrKOlgDuVc4Gy90eNWDqKA2DX01hFDPv9aSwlKcQtsHQJGbyWjdVKb0KRFseXdaktLk46SnDVB+rL+f2JqiNz0NeygOzPD3llRnmKbmIcoAHNCIZdmovOZcSbyNC9Xox7m9LJxLR/7vL8qtXpRKTNhBJpvoP5q4p+qgYK4FqatyXPjqtiBVlU9LoqE5Tnz/F60XOXSmRRaj76hX50CtA1mt3rhSr7qwFiRxXIzHXsRtbbxeAXv11LwrvW6TeZc20BrGggRly4DafCxZnwligd+4D+KouQXd3LkMt2FglYEgXBDS4gGQUtUI0fL2kkI+xbIBI2b750z7/YnonVJnbLEYNrYgIUr99bxbFch1NULb0WSTfrD+nPH2MHsrr2VQs7Jbe/JQk8/g/pbL/y5wR2FbIf+cbR9jyKOg9ndW6OCP5/b2gaTb1thD7iQa1zxxPF/bpUkzXrlT2BHt5DFayDn+QyhRptz2lPbkjTRoRFRAynJXGph++ZXWyryejVymSDytBJwepJoW4I5MP23Q0iLYMYGcoxkyoq8pVPtNhtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(2906002)(5660300002)(8936002)(44832011)(86362001)(36756003)(4326008)(41300700001)(8676002)(66946007)(66476007)(66556008)(38100700002)(316002)(6486002)(83380400001)(6506007)(2616005)(6512007)(6666004)(478600001)(107886003)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zZnn3cBj7RDKUW3rBwjrXZ+9I/KAPKVnKOdi65DF2Aa3Q/qKYc7NMr7Z/atE?=
 =?us-ascii?Q?HwTF5k50EFFs7C0Hr6aPriXqiZyCinXEptBiV7wJJAiRV+prG9b3yUdT/SWC?=
 =?us-ascii?Q?2qltoQmYo9UIuT41kv7sJYhdWMj4jBtsbJIQwyBNlolQ3bZxPsN5NbsrSbd7?=
 =?us-ascii?Q?E9PdaC6Y4zc74xGcmSwm2DTEZkPBzaBkIcEXGk8AWbIoZkeiID/wt1L4PmcQ?=
 =?us-ascii?Q?yBYZYLQ0XmNvERO1qhaSjVU2refiLPUXU+Mtp3oLyaWnwM50a9j87PaXThVH?=
 =?us-ascii?Q?JDO77G2OTPwgU2oseUFlLkH11CeM4Sp08zfrrVhNjBsI1yGsZbhaatfWhRbi?=
 =?us-ascii?Q?JKD0omgCj8PpqtQHhY+4eDxyLjjVRc9ljlC2G9az9UEX65AnV15d56CDKOid?=
 =?us-ascii?Q?MbZYSWfGFG+PQ3CtXhSqsf7jvF41+i+5HD++XMpk5xxREx3BJ46gTCbTeMVf?=
 =?us-ascii?Q?mI4lC+vHIAqB0ZLytnslxH8p6oAcAACIqp/wuVtvPKTWJs65IFpOgYp1DcdU?=
 =?us-ascii?Q?q2dnefkfc5+gu6VygZBeB50+HcBE75pe/LaeTD+PnAMYYC0IJwLHSaNCYtT2?=
 =?us-ascii?Q?//78q1JimhtYRYrUEE6OqYha1TPKx3bXqcQJ8K2/8kbdzUUKE3tF8HaVwE7J?=
 =?us-ascii?Q?lXP4fZqCGiLsjVNXgsi2qeS/6dbwuxUtFwXarJHQvdygXzRH+k6Gcidzdrqj?=
 =?us-ascii?Q?wMOhBPqX50iuP3FfHbfdNHC8yf+AClXNsrZMpQyo+X6EEevDHZUEg7t2nBsq?=
 =?us-ascii?Q?A/oeS8Jw6wGnOaq19N/6Sq8jN/cNf1dW7qt18iJbybdWeMKkRcQAoPowFfcX?=
 =?us-ascii?Q?0GH126mvLsFpsHc1hep/txMk6yWKyaPx2YW/LVRci4eyKBbms9YwSeZlbV5j?=
 =?us-ascii?Q?EE7d0fXJfCDK9DmWA7zZ4a+D+HEv7O/vTpH0wb5YbilOzziuur9FrL029gKs?=
 =?us-ascii?Q?uyCEfWu8C3Z58Wjhs2JfxjQDxeDDmeK6aCdlYVm2HP2sDnq9qStFQ387lrMF?=
 =?us-ascii?Q?jpDcQBVSIObf8QFgnU18BVEZUa8Vbj5bVp/e0OtMBnoHxeW6yA2j4H/dSvuA?=
 =?us-ascii?Q?Y2iwVZ2FXp3tVflyzWfM+ViNAcoAXoqonZ8cfQ6Fk02mIspt/t1YYe3LaLno?=
 =?us-ascii?Q?D80ozB/S3Td4tuJWhqduvR+ZsYjxzANH/jALdodQD2VCEMoENc8WC6E9UFR4?=
 =?us-ascii?Q?ZPIN0yk5/+Im23fwF+UIADVak5HLZPMCa5zVnpRRP9B5GcnNIlMYXia0Q+VR?=
 =?us-ascii?Q?GYVjykL9CXfOB+M5sDkBNJ25i1wzDF2RrWpoGB8dLxIe95vFQeEaSCIB+m41?=
 =?us-ascii?Q?ojTAOuKRkr88v2YhOa1CQXYBQXDIjJoNrz8DQO8fCn0BdM5QF95Y7KICrcsi?=
 =?us-ascii?Q?+h5GOYzST73zwBjZ3rolG6bzUypxi0QGfdfBPLSeOZKYpkVN0ixw8C+HOQv7?=
 =?us-ascii?Q?tP2Hi+rvvwr6xpViurK/X0qCuATWsm9MKoxfQ6wyacWYoKkw1l4Fs1NHiGKs?=
 =?us-ascii?Q?S/6iNIgchBGHztuqne9suPMmH76kWjGlXhhINA2Ix3I2/UTfnBHnwxDP8UWT?=
 =?us-ascii?Q?SNl5kXc7sCu/9hTLXFk2nEoJ6UcR+ksqJ9HT1s1oec3qq/VpvHm7bbOqvTHE?=
 =?us-ascii?Q?RQug7XsV5Jgpp3U3YKoS1Nk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LF2Ehjul5ZGvP8sDyNbxdelVPE4QklS6QJWZ6cZr89ZSKLoIvkI6bg9m3IHA?=
 =?us-ascii?Q?So98/LQ7BQVOXrmFQWTZRPrpJdUfQqp3N3QOr+V9yAoRYDIWJ1Vq99fWmOee?=
 =?us-ascii?Q?9RfCxLAmV6jx/KfKMKcjIkEa4wC/gw0jUaFe+s+R7e1FE/DD4ALbFyKyp4bg?=
 =?us-ascii?Q?mMk1ogognDTvK6KORZGu8L+p5Q5GskJUgoJ1sRSOWnq35j2nukOOalttJxwf?=
 =?us-ascii?Q?HKVH+iK1k1RcuYi35LCM/4CACJCKkS+IiOSnqrauOqqJzt1zhYnaPAt8FRyv?=
 =?us-ascii?Q?esqiFWOgFAUpJGJFk8TY8jXyJQa/ReqWYCexDTcYEM5JOKC2/DH8jE0KESe7?=
 =?us-ascii?Q?Qwk3Vr0HeZxBlMs8mIjFGhoPb2rZeBWdr960RvzT02SiH6m9qsI/iihxdFLJ?=
 =?us-ascii?Q?CDarDAAjt9v41G8a1J3zqOhE3bfhNcXNTFZ4ue5/5EzpWr6R7qlWIz3zFfft?=
 =?us-ascii?Q?q7xl30/J2IqkXgAsvN4y6QYDzrg4by7jp/2Y5he10w+H/ChYIY+CWOk17OCq?=
 =?us-ascii?Q?5EjXHQHmib1cRY1uIAVyJ9C9i8T0GSZ3VoF03v9HBliRT73adx/2QewPNtZ3?=
 =?us-ascii?Q?kKrV0vG9GBzMFh7Rm5WkPD0IMyr2C3HLbyBchFCshuLSn2w47kqLjSllZjS8?=
 =?us-ascii?Q?xXwU6vxI9QEmjKyLa/9i7HpYh+jhbDI3IAt/vFLwPh5CnpYAsHbfJ6rCANXw?=
 =?us-ascii?Q?mkDAdWuiYQ6Vv2HhxNvYAzvjnlX5clg8YwVJwP4IZj1UUSBv1nDnhQCxdhub?=
 =?us-ascii?Q?ZTygkpAtYcypiDeIWsZCPj7wvNFmKCkUgfT1vUwizLulNWvKNL2/JYszeGBO?=
 =?us-ascii?Q?rvoo/8A5VeR2Cx95IDlWJ06AWJ+TGSKvhMU7WMq4YdKX5l1jTVHbdDYTNgJF?=
 =?us-ascii?Q?g22FFepmQnUXeti7onKpSC62rjmzzrN1t6SNnMVTUHZ37cwtDu+EAT6lvw2B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a814f3-84ea-412f-10f6-08daf3519fa0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 21:28:32.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3NNSGOHisfW3M20/hUTBQeNx0yW83pww5Zki1QfvD7QFD9by4wZbv9mV7gL/t3iqdBktJMo/gFApJrBG7uI0Ry7sRGQfB8dtIM1pVI6z6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=825 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100142
X-Proofpoint-ORIG-GUID: 0nUvyz0MlfwaLtX4PEUnXexhLEvWSstL
X-Proofpoint-GUID: 0nUvyz0MlfwaLtX4PEUnXexhLEvWSstL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert isolate_hugetlb() to take in a folio and convert its callers to
pass a folio. Use page_folio() to convert the callers to use a folio is
safe as isolate_hugetlb() operates on a head page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  4 ++--
 mm/gup.c                |  2 +-
 mm/hugetlb.c            | 16 ++++++++--------
 mm/memory-failure.c     |  2 +-
 mm/memory_hotplug.c     |  2 +-
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 551834cd5299..482929b2d044 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -169,7 +169,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
-int isolate_hugetlb(struct page *page, struct list_head *list);
+int isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
@@ -374,7 +374,7 @@ static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 	return NULL;
 }
 
-static inline int isolate_hugetlb(struct page *page, struct list_head *list)
+static inline int isolate_hugetlb(struct folio *folio, struct list_head *list)
 {
 	return -EBUSY;
 }
diff --git a/mm/gup.c b/mm/gup.c
index 5182abaaecde..bdb00b9df89e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1843,7 +1843,7 @@ static unsigned long collect_longterm_unpinnable_pages(
 			continue;
 
 		if (folio_test_hugetlb(folio)) {
-			isolate_hugetlb(&folio->page, movable_page_list);
+			isolate_hugetlb(folio, movable_page_list);
 			continue;
 		}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0c58f6519b9a..540f33d8cc51 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2781,7 +2781,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		 * Fail with -EBUSY if not possible.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		ret = isolate_hugetlb(&old_folio->page, list);
+		ret = isolate_hugetlb(old_folio, list);
 		spin_lock_irq(&hugetlb_lock);
 		goto free_new;
 	} else if (!folio_test_hugetlb_freed(old_folio)) {
@@ -2856,7 +2856,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	if (folio_ref_count(folio) && !isolate_hugetlb(&folio->page, list))
+	if (folio_ref_count(folio) && !isolate_hugetlb(folio, list))
 		ret = 0;
 	else if (!folio_ref_count(folio))
 		ret = alloc_and_dissolve_hugetlb_folio(h, folio, list);
@@ -7271,19 +7271,19 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
  * These functions are overwritable if your architecture needs its own
  * behavior.
  */
-int isolate_hugetlb(struct page *page, struct list_head *list)
+int isolate_hugetlb(struct folio *folio, struct list_head *list)
 {
 	int ret = 0;
 
 	spin_lock_irq(&hugetlb_lock);
-	if (!PageHeadHuge(page) ||
-	    !HPageMigratable(page) ||
-	    !get_page_unless_zero(page)) {
+	if (!folio_test_hugetlb(folio) ||
+	    !folio_test_hugetlb_migratable(folio) ||
+	    !folio_try_get(folio)) {
 		ret = -EBUSY;
 		goto unlock;
 	}
-	ClearHPageMigratable(page);
-	list_move_tail(&page->lru, list);
+	folio_clear_hugetlb_migratable(folio);
+	list_move_tail(&folio->lru, list);
 unlock:
 	spin_unlock_irq(&hugetlb_lock);
 	return ret;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 63d8501001c6..cf60c0fa795c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2438,7 +2438,7 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 	bool isolated = false;
 
 	if (PageHuge(page)) {
-		isolated = !isolate_hugetlb(page, pagelist);
+		isolated = !isolate_hugetlb(page_folio(page), pagelist);
 	} else {
 		bool lru = !__PageMovable(page);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fd40f7e9f176..a1e8c3e9ab08 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1641,7 +1641,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 
 		if (PageHuge(page)) {
 			pfn = page_to_pfn(head) + compound_nr(head) - 1;
-			isolate_hugetlb(head, &source);
+			isolate_hugetlb(folio, &source);
 			continue;
 		} else if (PageTransHuge(page))
 			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 61aa9aedb728..4e62b26539c9 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -601,7 +601,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 	/* With MPOL_MF_MOVE, we migrate only unshared hugepage. */
 	if (flags & (MPOL_MF_MOVE_ALL) ||
 	    (flags & MPOL_MF_MOVE && page_mapcount(page) == 1)) {
-		if (isolate_hugetlb(page, qp->pagelist) &&
+		if (isolate_hugetlb(page_folio(page), qp->pagelist) &&
 			(flags & MPOL_MF_STRICT))
 			/*
 			 * Failed to isolate page but allow migrating pages
diff --git a/mm/migrate.c b/mm/migrate.c
index 4aea647a0180..6932b3d5a9dd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1732,7 +1732,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 
 	if (PageHuge(page)) {
 		if (PageHead(page)) {
-			err = isolate_hugetlb(page, pagelist);
+			err = isolate_hugetlb(page_folio(page), pagelist);
 			if (!err)
 				err = 1;
 		}
-- 
2.39.0

