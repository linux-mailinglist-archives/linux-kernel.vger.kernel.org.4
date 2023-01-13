Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B524566A5F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjAMWbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjAMWbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:31:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24BD6C06F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:31:43 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DMV9ff008583;
        Fri, 13 Jan 2023 22:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ia/pKYvs485DK07VT5Hlv1uptsr6AIwYUeTt8NNpORU=;
 b=Jw6GqB2hgGTR6Rcc6nIA1Ojc0/hqI1N+I9O7+b5MdZ2Ef8QvGz/LbkLRA4pflql+PWAK
 fZ849rIRfV7zdTAcYql/7Y7dbsgc/3sApWAELV7dRBjKxh6qxI2FtMq24vcimr10MjQM
 fYrjxXKulIIFPk36LXmKi15Gua2kKMge2pv1kReJOicYEi4bqKx8mlh1VL01JLGrE+H4
 vh9Bs/Wb6m8jLI9vXL0BcZQmkSb/GZJw5Dek84v+eocwphfJicgzzZwobiBSl4w3l/8/
 XxdWLFmlJhIr9RWtT1txF16X1WGvOk2GjKA6LS0n46YpomXhmUa4kz8+Yz7dhE6EPoAQ 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3e0w09kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DKwdj3006706;
        Fri, 13 Jan 2023 22:31:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n3etdjkpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfOqV9YRSE+4HTuD/oYDSoVVA9mWBLvgPy5equXLURJaxp6VncCkOXrzk/HCbeHwOn39kibSG/yv/cvSBeQWakNRQC97A3O862tvLjTZ0W05SCY20b0MY/2XpB+YPx3CeFpvnkCM/OY0oFORyzI1xluDrJmJhv7EhIoKrQ1/tQ9pjZ95Qu6d2DgITZXTCNJ70p+RV2tEwM4sydFjZ5u9bEJ45ExOz6Ok/df/ulPvVSrngLc9p11qr+QInWwKbn7kQvSExkc13qbj0clr29cQBhcpuYaWmCd1OWL60Ugi6F6EUPxzaKoZQNP+kyScM1KkNy9Z+6J2IOmqUAmxkEYTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia/pKYvs485DK07VT5Hlv1uptsr6AIwYUeTt8NNpORU=;
 b=Jq7C+tDpIcCRe1tnouLR5dc9YkLLS0/BQladBDCWnTgXhIAaA9Y193N8AT6xRTapVp8eOcAvdA96MVmSATf+tIRsoXDNggNqTvM7N511SwxKejWDrygogiKM3j0wVr9J+4HrGZCAQb6e2Im9kMz9b+EakDjBNU/WekNNfpilhfvaxY47vp/fsjcbQBpVXabVaPdmpZ07yx0AQH3/BB4G4N7/qOEDYx6GDY7jRYjnrp2PTNtzuLZWrc+qrahwf8+k3WbDUpQYkvfaNriA/8fVPT9vaySYk4/77lZUnVcxdagvXsminnht9U3or9l+LMpiZsHDm/Ml6v1xw+x1mKD6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia/pKYvs485DK07VT5Hlv1uptsr6AIwYUeTt8NNpORU=;
 b=S3Koee86dj807nA2lgdskpnLZm7O27RKKF8JRlRWh5WDY4hyearAHyHy1YRLyKtzmPj3YncULqyL1GHNbLMRQMkavxhQH0oDd2VNNzKdAKtt2wNyoJyplZAdQXtbLH+p2MLJlkjx+eRVX5pmY4QRFoO0fEsdx/167HhKI1561Gk=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 22:31:05 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 13 Jan 2023
 22:31:05 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v3 2/8] mm/hugetlb: convert __update_and_free_page() to folios
Date:   Fri, 13 Jan 2023 16:30:51 -0600
Message-Id: <20230113223057.173292-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
References: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:52::20) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: aa827c21-9c6c-40ec-5b8b-08daf5b5dbe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HeMp3wHJmawI74fn8kEuHRKGG0V6gmeHJAyh2k8OcWMvZTMiAfLIFSSQuCxIWGjgMy3NdYNZUXs5FVa6bEHD134apkF4UzmozF627bKTzyt7af51zszm80W7jrAWCArBQYcTuC9drL2nB/L1Nc6TjGasi7yQhh2ccf/a9EPsRYLOjlkg9Koo3ZQ28uOgHFOQJg8D7oxDsLk68MFABqsV7PHSxEd0QQoXe32f/8XbmaYBsUzZiTBy7xbO7pZXCWi9R+ws3qYZ6WY0XVotaBgBPEnc/DPv5a+TvjLfsd3myJ0N5/5bWn6lfS1ITKEjajm7+oyNmLUVBySdRXm1rr+MymenFV4GnFrmTKxEfs9idkwBY/MBgINH1ze4kpJwdMc10xtg4rjt5MzjcorXXabIybMNIP08zdr8nrSSLXuYtSpBx5PBXBHPW9k4M4BNALhCshQMpxz1hf+6ESB0khTXXJytyhKTZRCJ7zxfep2k7WugOX+RgKVZ7xMaId3CFeXnEmMEHOvPb0yDcSZzctFrDCT9PKhfk1dUYnrNvwUpPTUrFfvbiUPEZ9VQ+uh9S4cvlMSEXY++PeWfiMsMJ14I35T534t7n1SjzwWwFVJ+XGx01kH4qEoTJJ7tbjae+5D4sNQ5hCTyWBWmtJ06MJe9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(44832011)(38100700002)(86362001)(2906002)(41300700001)(8936002)(5660300002)(6666004)(107886003)(478600001)(6506007)(1076003)(2616005)(26005)(186003)(6512007)(8676002)(66556008)(316002)(4326008)(66946007)(6486002)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N58X2uiiWbldboHnvSFd8wWeL4HAHyCLj1jMcFBQYWotf/dv6B0xl0aLUv8m?=
 =?us-ascii?Q?OQaoAEQT7RV8NxAIm1a6xWPz+Lp5QmDmyBpr85ySHo8NveRQcX0Ehp+dynKh?=
 =?us-ascii?Q?dR8rG2fmimYjy2x1UDT9hA3ghCFdKGCcVBi6xOExe3r2rgHewZJxf1ZWcFCQ?=
 =?us-ascii?Q?O5Y8UdL+/bLOSsp3eaQaBY8pqHM+9DLwyL+fiB1XKjZI4DYA0XCKUHnDwcra?=
 =?us-ascii?Q?4O8bb1RA0Vf1h1i2ORBmCk/yP7OygF7PaIb/oT9V4QtgaMNbe3hJfIYQ6wg9?=
 =?us-ascii?Q?5JUPg3Ut9dVRCidMiyMWjhOGofxI0TIWX+Tr5n5w0yh9UMQ2Hj0laB982scZ?=
 =?us-ascii?Q?+MKPWb8BDhPaAKRCuFgLWDa5jd3bHQpciBEcP7PuwAzJaur2gbX9LNk5/GMW?=
 =?us-ascii?Q?opsB55l4ezd+5+OprWThmqZHnDSFP1qsgSwKGQ79O87R2yO29+aZsfzqAjml?=
 =?us-ascii?Q?rLHW1Rvok131BKopW6QS8kv6PjftKglnwO729SpQ6zLnetY25/RpXa6Gam1O?=
 =?us-ascii?Q?vM+ET0FkC8o+9f0CCQBYYSPcXqyoGIcoiyVGHULT7wrwVovoVRzrBL/iwVxI?=
 =?us-ascii?Q?yvT48FxmUjAMqKcUca3MrepiCbH0SYe0YXT449kGDEsHOIc056kEm78YTu4Z?=
 =?us-ascii?Q?MrzADkOHasHvnj0RcMp5Iw0FLeZciG4TvOaLM482oCFhD3xFm2X7Vy16GLZA?=
 =?us-ascii?Q?xcfGmtwEz4bBwmPkUlemJ4lFOJfGLZ4iKuIhKmzU+f80sIqV7pk/vufwkzA0?=
 =?us-ascii?Q?vZGkCrAF6J8qFd2w4CryeIqqNyncepk5RMtkPBcSUKPMCHswBF4r+dScI6EH?=
 =?us-ascii?Q?rCTga4BM9P9FXL8ZYvHQTPOjU3EVPmRk2xnTpouUIu4O1a/EcjWuSObrmc6g?=
 =?us-ascii?Q?L3vNyNVfpx69v1lWNqg0HBoI5uQoVhKSHUxjjsjoBFPHyOOiOSn9it/buqLw?=
 =?us-ascii?Q?FWjl3KwxCzrL4IXjhLDE91JSCIt3i/1Fznl1b5wI9uUCxN2+qJhx/MZDaTE0?=
 =?us-ascii?Q?y9GaIc466QblBhoq1gUQ0Iq8ptdpMAeZOv+RUVgS/fU20mxWmkPhO98lPOz5?=
 =?us-ascii?Q?gczxGUlbIMNcfnCEdF84iN7aogtL4Ss1YT12f2BEN5/QgWAHCY+ebtMpgfCu?=
 =?us-ascii?Q?dbhxKmNanZy7WlzEwGBsbxWUr0Fa9yEck2DSV4aUx89nZMb0gBkZWS3s6PZf?=
 =?us-ascii?Q?N/4fnm3wZ1DSEdRD11tjZKPBNH3B+7u52eARg12eFRQ4NCC6npyPhU5SjOaV?=
 =?us-ascii?Q?NFX/W0sUkYtSxSxSowvDobyLzSbCvymEQ2J2+Ies5J/TqmMYyBKKBwAZ3/fp?=
 =?us-ascii?Q?5McQi7QycSY2MwgcVg/kg2kMGWn1uk4LEVK0/plZ2CoUGrX63RW+2le0Wlcq?=
 =?us-ascii?Q?9uoPeL5dY/6Zbg7OvmQXvgwe2r4wxL2IZN+M7VTK539b2Ntu/jl4Gk1mnsb+?=
 =?us-ascii?Q?B4bcnWzB0NXnS9vABkln31hS84vPnJzOpyYhOxTflZt1wBLCYKnmuZxph2lE?=
 =?us-ascii?Q?KHLTSKP2EDdpWkjnA6YlkIwCnpuywUnFQ6RZkZDTOhjCV3HdnhDRbIguX7pl?=
 =?us-ascii?Q?l3vuvEgfYIyZC+2QOSXE+DmqXl86iQrsdmcbPNEFHELOmNCNVL+bxTI7xf/U?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sAWb/pI9X4D9/2dzwhmuS9T50WSpSpAlbmW3bMhUKEl7Kz45/1Z7crk5/hIp?=
 =?us-ascii?Q?lFzlUlwJWTkAkzcDYRozW2WhJkhIls3mUWI/5mUSMHe20lUz9Ob9AYy2XqgL?=
 =?us-ascii?Q?d+SoQQQ8R41PDdWAowPayVc2Xd2WIsJOYDvr+NAp+Qk0pnETy8dH6zF8sBro?=
 =?us-ascii?Q?0ZH8382Am4Y62TiFOYWtZ9tjlvByEiW19y8ezF2Du5BX7ZcdAW9O2sLyohSR?=
 =?us-ascii?Q?O4oSfMvuFrkPR9f+aDqNVM/tZdTeeyVLm/1Qt+M3o4DR5bz4ohSFbslzCQP0?=
 =?us-ascii?Q?9QRqWCGpdUqirXctT7ZwXLc1GFhlNopGGYIvRuPQhI6tov6DBrNU0lpg90aw?=
 =?us-ascii?Q?2R+jBuXCWtxcxlnFQnJOrwUnMMxE9gY3T5OIg7+BYTSQNj8JZx1BK5Gd1HOy?=
 =?us-ascii?Q?KxfRs1t9GQ/6xDo9kfo73tXlRgeHuhrrOJ9frpv13YssWssiKNwG1EODik7w?=
 =?us-ascii?Q?3TbVN1qKsl7xUab9XZzk0sltdN2X7p7IpAhumWnvHQg31sAYdHF4/R0hQYOA?=
 =?us-ascii?Q?KZstVUPsk52WSNZ//3vtzydemCM1+UcrC+SZj9cNOgRL3T4yEBtK361R+KV6?=
 =?us-ascii?Q?R89/WF4tSZgGKNyeApKGglBqMGjIh4aj40WuTYYlx3kvjHULDNnjJMA4rk2v?=
 =?us-ascii?Q?si+39l5vqdTK5z1BUqsBro9oQQOvZVSGaz5P1nk0Ghlncvxxt67h1E3SA5s+?=
 =?us-ascii?Q?rJzjx6do0acAgBWTPown32h/6G/uaP8yJxNIiO/wQ0lD9tXiUA7vud6J1YDb?=
 =?us-ascii?Q?czkkXrz9gsN/jBTzcaktifQdouiMXHSEjbEfA0mJANcj3VcKhpk9MfxanUbP?=
 =?us-ascii?Q?8vBi6kh4aL2YRGrSpDBmpyrehkwDme1QLno0kTYqvbsdjfN04r6dtyjQDOaV?=
 =?us-ascii?Q?E1pPfpSsUQ7k5W3OpvdZtd6z7bfKhQ44yg607zjzrUBJ6l1rSRrX9wKlLnqY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa827c21-9c6c-40ec-5b8b-08daf5b5dbe1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 22:31:05.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tmrZS6KneDh+V8DCD94HaxelKk6l01bJMEpXEm6nyhl2s+8VpvBldSV1yADOaTg6UIOpbW5bvm0Bh3/cG9EOrinodTrrnRSjFOG1xrcntU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130154
X-Proofpoint-ORIG-GUID: y-v1TNK3pjDmSLTPAnL_iSYu4xlVEXCh
X-Proofpoint-GUID: y-v1TNK3pjDmSLTPAnL_iSYu4xlVEXCh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change __update_and_free_page() to __update_and_free_hugetlb_folio() by
changing its callers to pass in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 540f33d8cc51..9155bb5ee570 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1556,10 +1556,10 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 	enqueue_hugetlb_folio(h, folio);
 }
 
-static void __update_and_free_page(struct hstate *h, struct page *page)
+static void __update_and_free_hugetlb_folio(struct hstate *h,
+						struct folio *folio)
 {
 	int i;
-	struct folio *folio = page_folio(page);
 	struct page *subpage;
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
@@ -1572,7 +1572,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return;
 
-	if (hugetlb_vmemmap_restore(h, page)) {
+	if (hugetlb_vmemmap_restore(h, &folio->page)) {
 		spin_lock_irq(&hugetlb_lock);
 		/*
 		 * If we cannot allocate vmemmap pages, just refuse to free the
@@ -1608,7 +1608,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_folio(folio, huge_page_order(h));
 	} else {
-		__free_pages(page, huge_page_order(h));
+		__free_pages(&folio->page, huge_page_order(h));
 	}
 }
 
@@ -1648,7 +1648,7 @@ static void free_hpage_workfn(struct work_struct *work)
 		 */
 		h = size_to_hstate(page_size(page));
 
-		__update_and_free_page(h, page);
+		__update_and_free_hugetlb_folio(h, page_folio(page));
 
 		cond_resched();
 	}
@@ -1665,7 +1665,7 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 				 bool atomic)
 {
 	if (!folio_test_hugetlb_vmemmap_optimized(folio) || !atomic) {
-		__update_and_free_page(h, &folio->page);
+		__update_and_free_hugetlb_folio(h, folio);
 		return;
 	}
 
-- 
2.39.0

