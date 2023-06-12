Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DC572D0CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjFLUlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbjFLUkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37BCE53
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKO4xo029655;
        Mon, 12 Jun 2023 20:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=wU14PBuTjC9Yf1nsufmd8IeOziKTsVC4KgDaYYEL8V0=;
 b=h+aqMamu0m7qGwqXWpAUlzvT2s0oEKa3cBk2dHtqk+8w/RrWxokIbCPrN4OYNBUF8gw6
 gOUDsss/oGUMflfpnBU/x53FTDtA3xfKd+8aYAKV0imhuYpWUew92ba1HPJL+MsV+vt9
 r8MA3h+wdDlwuSYkg5H1CwSf5TyRjhbw3p5g6Co7OHWRjeMLiFNKSALyqx+vuHRNed30
 AcjCd7vRXj16MmqJxRUpX/sfsHN4V0Ln4jwwg1LXNlYEoLfOyQvvkqwAvmhvjx2V6DoN
 Lmzpb4zXWGbNMuuSXT2PY3YZL+o3FDuD0spr+y3jVzF+LuN5Yb+tsW5gqtkOd48z2ukY rA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2akv3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CIfCEY016225;
        Mon, 12 Jun 2023 20:40:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm399k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McgoDsYzjeBX++RmX15mKRQN9mQDWalP+biqNKx6ygMX7C7LgkRDFNqo7kAngDyEiGhC5lk2gswMwo/wio1cTNJQMhVg602szpKUCYn5yecsUywMeEBo+x6HFGVi3f/oGQdLaN9wYP2zZihai9e+CFLWmJObnjODQdCXQJrz9OxNcugyxGM8wkxhCDDwFkQsSh6lujH6n6ZFm/2l727O6a5MGJJLwJjQs35L97sV2SqvhMMGuRp1P2+H46j8T34TC+HR2FLv5S1iPny13fCFW212xDIgYMK1dHr3l3p/xQbcyabOVZ+/BnGGNBzA9Y3XU07ZV3E7A7VjX40FAZjwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU14PBuTjC9Yf1nsufmd8IeOziKTsVC4KgDaYYEL8V0=;
 b=YE2bUyooeQTEgEeNcpUQXQJLDE75quHeCVcGccDimhmb4KySdPi/qxQDjLhL5NAxLcJeXke94TEyxXGeTj62QaZwiEX+4+1be3xNrrrTaL54RQw24Og//Es42tdQInL8WN8QkBaq5xO3JggO3o5mNGctwWRgId3LHTbBT2poIZM+79XwuxwHUzQRkQ4LCVvRideW2BEwR81IW1RAtcsVwgWSCT9a7xy9lb5sSy2tnssrVqNWYvs+VtadrzuOZceUiHap4h9vKWYS7/Z0SqZsdtLI4tT/CE86rvTTnVBP3hdNJch/gf/anLpn5ei+rBDrpfLakl9g3Oe3hnxmvviVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU14PBuTjC9Yf1nsufmd8IeOziKTsVC4KgDaYYEL8V0=;
 b=t0iAOtB3qDvbcWDFj0yWPpyxd/QhlwRnwcufCjGQKyhyvdVv+kL2gd53SRBnCRBOId6D1ozFH7KfzRTOwr8rBxyfvGZHBIVSqXqfrA7BbEdiXC868iU/fvxwiA8VjT40q9beg7nCI5yX9C90UmNcBiJvVrHyAY1MC8r1NXJnwo4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 20:40:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:03 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 02/16] maple_tree: Add benchmarking for mas_prev()
Date:   Mon, 12 Jun 2023 16:39:39 -0400
Message-Id: <20230612203953.2093911-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0354.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA0PR10MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae038b1-4ff5-4c42-b3f1-08db6b853321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sp/5XFtegxzNRcoTnPwPSKoizwg1syhPPl1VA2dPtVtbgX3PqyGEs29Ksdh6f/H4OGknkr2G8Uny/c/ebymFk5te3wPWJ9uNB7FzeV4ndZXLeiWiGzRBe+54DgIfw1zwytM7uyifpMnM9qPB3xnQcheCLVUHDLZ2Mxqv0hVbyKpMm5fzBQf+lhMc3/QWwSk4DQ9nPzOIkMJHycXV4auBldCMi7Wq23JtYp8v5Rx7HYK+ehN9g5TKMDPXwUCqBL6V37aTQ15FqhWwBM01jOxhTgKrue1xM1KlPM351Rdjvh3Fj/K01LS/KkvRckhyFzHhl/+IHxxwX5rj0xxZKiXaZjptOmzy6/z1eHMI0eVC2I3zALUfeqLXgzPiTiSRM7eTeRBjc6KKJDBUkZ22eUNpPRnikj2nAcjfZrxDCtWcDQNr0EEfynLSZUHWnMQEhG+9sl+JB3ttbWp6ZOeZwLcXUVfscym7UOQigmWmEdoU/bAuyypa4xD5ZBiQ6HYvtG+jkRD6m0U4+358rBLFxy+YVFp60Fl+t/giDpPhQzl5l66Z62CttcJ7DfM8lAub/n4h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(6916009)(83380400001)(478600001)(8936002)(8676002)(316002)(66476007)(66946007)(41300700001)(86362001)(4326008)(5660300002)(38100700002)(66556008)(36756003)(6666004)(6486002)(2906002)(54906003)(6512007)(107886003)(186003)(26005)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3RCgeonaRw7dDX9wxKXkrg7iWIv1Zc3E36aAdfzFuGzUvEbXGql+DW/AD8mN?=
 =?us-ascii?Q?n57yB8S8SRWrTdjNOjPOUvle/PKRiel4g0VvD0kN5tx1nUA5FuV37RuAl9On?=
 =?us-ascii?Q?ajnz23WIzsNFCD1k61zTxbuQ/gmvqvRNRjjQqIXO68Bes9XyvGiPBknHEF1x?=
 =?us-ascii?Q?sUXbpaI1x+9LYpc+mylPZ0wFdRg5KPhpbDr2Tp3sVeQ9qTsz+J5UCAzYliF8?=
 =?us-ascii?Q?8kBTauLdiIMprSzz9SA2gU9nFtLTYbKWcPm3l68sNB8HYB9cjuD79xs8Tg/P?=
 =?us-ascii?Q?+DKiqQueSHZwKJV+ZqeFd8nDI8PW02dPhFgug7ypEjT4Zh9/VADeFpkzKkHv?=
 =?us-ascii?Q?igOcblR3o4snYbIemv0xfw7Rsgf5LtT83uYl22Gva3Hy5h5Y9h1NhpdQFlOx?=
 =?us-ascii?Q?4HRzspdq71M5NUU3z1jOsmjMxVaMQ7mWj2cDhOS7OAI3rc24kO88eHHxvHGI?=
 =?us-ascii?Q?qm8OIszV4I3VcR/1Q8qbbl9wxjQSvXQej71KuKCG9nAZXahVSfFQdPvQGIq8?=
 =?us-ascii?Q?KzYub7v1NnYq2kjWUPyt1+YeYlBOodL2oC+lMBage+Tskl86oMgZL3JAo6ZO?=
 =?us-ascii?Q?eEQwpM2t2WRQoEeRPDHGFIBVO5hY9jUOi9yXYiluglsJbiTET+NEckbK3ncp?=
 =?us-ascii?Q?nJ377TfNep1vWVtqMFLUWBKqw6DtIql8gJWuGJbJogdiqS8AD9q+EuJodnDI?=
 =?us-ascii?Q?Hn0Axz6vqrtTIw5AuCdPmoRDRqoXgDcMAuzyg02bZRnDGnQNlhFg94Cr1ukB?=
 =?us-ascii?Q?MgWXFifjNwcv1FLMqPVFums1ua58LwzITYsPSRLpzuvC15OMGpcGlq0xzgtE?=
 =?us-ascii?Q?JdhdGC5tcBbCLw8b4brp2UBkIvRyQdzZIGR+AgLgufcomvqh3MagmbNFQHSW?=
 =?us-ascii?Q?07FYP9Zf5vlmageXtl9V+HCq0CtoB7vKDg1xmatdwZanRe+xaxmTBXTMPT1d?=
 =?us-ascii?Q?mXDlYNml7ZwYGW5sn8Qra0RhLSZGnAXlVnWDuS/nvV3e617ns0zejYBQZDQ6?=
 =?us-ascii?Q?DtpwXhHSXAzppNkbIaaYhRHThy1uPkY1WjYw1HHB0ZnkzoNBEp8iFqp8cIwy?=
 =?us-ascii?Q?10mmwbe8xflW8k2N0rIaSyafJsQ7CCUtj0XBsPVT2uQs5Ks0jIH77wACz7sC?=
 =?us-ascii?Q?cf85fQ5fSpSdnUvc4RsKwMo7kkncY5dPLzFfTrXJOr81z1VdwN+moEdBt+WK?=
 =?us-ascii?Q?hsGAp6O0T45Sd8a78n4Ynly31rnVC2WBSp2uFSExrzqqi0DeV7dXs89qw0Pb?=
 =?us-ascii?Q?c6gLNL2Z1EDo/G4cogbDGpoqkEsNtl+rise+9aGszO57EpWTDGEYOlSPnA1h?=
 =?us-ascii?Q?LdWJJ8bM+QhzjG2JCOEiY/516BJr7JfuxFTICqxDkYrnLeSeHQOAdDZHYLWU?=
 =?us-ascii?Q?fnpP9kLS7T/uZPosPl83dp04rnbAJXRzUbewrL38a3IdL+yWryN+H+EZi9F5?=
 =?us-ascii?Q?+ox3PxHB2BvxZfP5eSATZ9PvZ95dIR6rQ4AHvkPIoCx7g+bcABtyzqfx7UaP?=
 =?us-ascii?Q?BDi5OXuhxEm1UwEbvHCokZpxLCiw9XysHsV6xvBKTTZ3PlmEr2QrsIwHTKes?=
 =?us-ascii?Q?wT5CDHpkKLIUlBEfxRdICBYNiMGmW5NHVfj3CQjX1cdUBZyBsY2ij3tfT6DJ?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QRLEXBfGB0vhOyawo92OI2bwTlVWwibfh1Tzyxn5yaob77UF/9eCZqNW9H64?=
 =?us-ascii?Q?mmsmPz6kaXuP0YuFmzYgqEnpTFQDO57hXT8opJYcLJU1rngemRO7wIqMri1u?=
 =?us-ascii?Q?DsXnwQpRaHInRQ++OMZv8EsQ2H5q8SrZbKn4mCmkSEXReyGDulYNMnta5USK?=
 =?us-ascii?Q?7454xVDxLBpWcGpUwEhe6HSHbZgLkGUDxgH+q+MPHfnKyCMaBuvfJD1buHL1?=
 =?us-ascii?Q?qbmwchoUjcthXrBp1sC2kiI4/q7IJb+BkQkydF/OpRqxuuVg2dLTYeulBEpA?=
 =?us-ascii?Q?02UVujjc5cCarfz4sT4LPS7vSZnMT7gcnrmkfYTpWtYQyxdI3aznZujoN/AG?=
 =?us-ascii?Q?yxdaY8s2O2DYfy/Y43szbebkx3cGVbcfgK8zznQEyMXd3BQy0exTmYIbv7Pe?=
 =?us-ascii?Q?0yTznWbmCf8eWCg4P6kFh/DaA0IzP20Dj27E9Btc/ighpNgIsDDLmqAaGpan?=
 =?us-ascii?Q?GBrqw59xcjJ31TeIQn8xjdERQi/MZFGAdGtZd6tO+0i+XgS5Gnl78qiC8SZy?=
 =?us-ascii?Q?+Sb81F7iFfHWZyx3zSkO49abKtl1Jok/b/J9OSLGLB/DiiSOYX6UvYHl+Tom?=
 =?us-ascii?Q?hMURJPrHz2h7KD1FaNNMjNua4h1izxynbuPStJtvhVHwBLiz4Jllrm6rFsry?=
 =?us-ascii?Q?10iOoR8hjq3rVBq6B+mTcECVIjxaWs6JGec6LWmtOm6YpbnXQpPwyef1rrza?=
 =?us-ascii?Q?VkclPo0s1dcVxYyvNUjVXVug8V5NZRUW3XhnpMvy7+bxT7L4/SFy+V/mSals?=
 =?us-ascii?Q?UzwTKq7s4psykA5PhLg9K6w40L1doI8TfAJc6Qo8WvMglFGJkApMsmGGnZ65?=
 =?us-ascii?Q?prq+jTuFwpC3TK+AkqZsIkFVbY9dMWv0LHpvAMk1BFg8Ve1q5appqCtttHq7?=
 =?us-ascii?Q?X7UdlKiD+xL5tCyCkHsLAV+LEEQ+o32PQyn9u3ylXmPrGwgUzfpEWwhYjium?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae038b1-4ff5-4c42-b3f1-08db6b853321
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:03.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ox+Q0+Zdm2QO/pUZgOImBn6dBfEYyBoNwYBDyGHFE1+cYjV+OhKfvUV/d/g/qD4iuaWdAVdnmmMhtp2+Ui/UUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120176
X-Proofpoint-ORIG-GUID: s6Lb2icNYkDxG4qP6CNl4pjZmHmfNJlK
X-Proofpoint-GUID: s6Lb2icNYkDxG4qP6CNl4pjZmHmfNJlK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 3dbf99c3f2b1..15d7b7bce7d6 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -45,6 +45,7 @@ atomic_t maple_tree_tests_passed;
 /* #define BENCH_MT_FOR_EACH */
 /* #define BENCH_FORK */
 /* #define BENCH_MAS_FOR_EACH */
+/* #define BENCH_MAS_PREV */
 
 #ifdef __KERNEL__
 #define mt_set_non_kernel(x)		do {} while (0)
@@ -1735,7 +1736,35 @@ static noinline void __init bench_mas_for_each(struct maple_tree *mt)
 
 }
 #endif
+#if defined(BENCH_MAS_PREV)
+static noinline void __init bench_mas_prev(struct maple_tree *mt)
+{
+	int i, count = 1000000;
+	unsigned long max = 2500;
+	void *entry;
+	MA_STATE(mas, mt, 0, 0);
+
+	for (i = 0; i < max; i += 5) {
+		int gap = 4;
+		if (i % 30 == 0)
+			gap = 3;
+		mtree_store_range(mt, i, i + gap, xa_mk_value(i), GFP_KERNEL);
+	}
 
+	rcu_read_lock();
+	for (i = 0; i < count; i++) {
+		unsigned long j = 2495;
+
+		mas_set(&mas, ULONG_MAX);
+		while ((entry = mas_prev(&mas, 0)) != NULL) {
+			MT_BUG_ON(mt, entry != xa_mk_value(j));
+			j -= 5;
+		}
+	}
+	rcu_read_unlock();
+
+}
+#endif
 /* check_forking - simulate the kernel forking sequence with the tree. */
 static noinline void __init check_forking(struct maple_tree *mt)
 {
@@ -3468,6 +3497,13 @@ static int __init maple_tree_seed(void)
 	mtree_destroy(&tree);
 	goto skip;
 #endif
+#if defined(BENCH_MAS_PREV)
+#define BENCH
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	bench_mas_prev(&tree);
+	mtree_destroy(&tree);
+	goto skip;
+#endif
 
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_iteration(&tree);
-- 
2.39.2

