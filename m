Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FA0674440
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjASVXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjASVV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:21:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C1F9D287
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:42 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKxAxJ028142;
        Thu, 19 Jan 2023 21:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=eajZ6BEFzwRRcAfH/MaHIcKZWur6SUr+SVPX61qbPAo=;
 b=czV/pYIsntIESziVOKhDes2aiUKRe89urajibF9SQ6sKYiOaIirXk2b8SYd/6IZYVDGc
 lr5d1ppFAiLOwb+lFbHcJZgGvRzQ+QxaRy3mx2BZbcjVeATaKGGhTM37elTxQzyfH8bn
 a5891TMF9Bznkvw7z03iKeouKfFEb4jijRlnydBbdMJPDnCaxed6F/1DHMzsIFPm9idf
 Nojb5xV9E08Po5QmmtzJWqDQnrdn+rR92FMxDijr59/ZugU8c0ofF+xjkjpdRNO3pzOa
 AThj0QtHPFwdaoAwTJbhh8xNl3ActJI/O0KHy/KpwB3tZ/M6ImOjiH4Ruj4TjHpkaYU+ ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k013atk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JL9XI6018694;
        Thu, 19 Jan 2023 21:15:18 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quh8tmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfZVaNaN+KtCXo/0pisTKB0rYR1JxHxXx4VyvtELMfBIC+L8f/V2vmTAObOu0QGrJaiGiePvOBmlnewfUEKbXwFazZU3etxMYYeVB8VPX4rqQhLiFdBpAeImNnIvJxhDkqZqyImIFqIvugW3TynwmTqYQL4QVWJQS+Hi303GZ4pn3ZSJGKW2IPcNLKY7x8lILmT4kzeWEkTe6NABW8SCyCynEmaai5E4M6XbMMBX7Bjr/Tz5mOcZZlXqqlqIhHtGpr2AsVEfXsnWjz//uIRL2JxAaInQ75YJVKcJ5SHITzU7bh0ErDH9BQTRXvxledse02duPDEqLoL7eYU7eVNiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eajZ6BEFzwRRcAfH/MaHIcKZWur6SUr+SVPX61qbPAo=;
 b=ji3qDmxfltN0zQsTWN8EeeQYAcLW6kW2qrJTRf6zemB5ko+KCRBb9NCXbaTVLipTGIVLkD6wKLc0OtG9KaQWs0/2kRCE3co748Ws/XLievz0GJ6jqXSxrEbIGB8zxhkALSs0lWkK+uSjar4haIrrzNGRQ0mGL65vOvYQzgtKz0ecXvsSXnH7CKoWnrY3gCZUMfKu3+lyGr/9bIAvZ3wGajTRTZiZbzBIPaOdw11/SpjbzPwfIQGYCxFkZ5nW8zECzzlrOEIeB0k6mtrH9MaxLwyUmVjWS/ZPDjODjG1LTdtidtKUOSfHN/tnkQOPIbnSME8PhLoWo97KarHnjL+BJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eajZ6BEFzwRRcAfH/MaHIcKZWur6SUr+SVPX61qbPAo=;
 b=l69gYxcpPq7wflv1sLLJPLbjmxykf4drcZkzUnUVUhPvx5DlRMK/v1tl07HWh7HGlfcTQJ4FdoPOoEGD+PQlLM7Jw2hUYaeyuGfvBM46+N+Xv4nGF8no/AwupLIoVvvtxJhpalAkPXLlphBS7XHtHbvr7kww48YpG7jkEudlT2E=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 21:15:16 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 19 Jan 2023
 21:15:16 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 6/9] mm/hugetlb: convert restore_reserve_on_error to take in a folio
Date:   Thu, 19 Jan 2023 13:14:43 -0800
Message-Id: <20230119211446.54165-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::26) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|SJ0PR10MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: d9709ee5-3f23-4d51-e8a9-08dafa62429c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZA2OpWItrijEzYlpfChi3S1vOcgoPhgTvux9eIk+RfqftszHHRrNKPxEWzOy0jQsggnemcVPojfA7RGF72LDnbHUILQoK4nRkE4O9z5XL12RUr0EfBAqDuLEJpVKBTZr6hwXyDt0Bg0uLxwJYe31XHD2Md7fOFsZJkeOZo8SxDX4f19antmbt476v1ii7Of8rGNsNtw5RcLErURlI1Itwln9y05LMDiuyuT7cc7zc78xzSDAbIFttv3b+CQHmrB/loc2Zb68Dx7Qzj9IaEIYsN1ywIoe7i+iRXHWEpWJMEfjc7oRVpJNhwkV3jOP+HoXD7TBGPfUnpgi7/fUXYz2x+/1LatTDohUNqmIiOfbOlXKcv4TbLe1NaNvdhhnivn2/+dfGnIxmrwN3Jv0fRsUof9+0414brFMjPy+GmYBsjn5KhAl4biX6dVJKvWSe61q0s2HmMQJFgpWiGhe1huYqCB1JmVhB7wvciqcqMqDcFBxX07oVBym0K7T4EqwoId7VXO29I2hHNUgzVHMzsBqBfN3zmSGQsiObGAM9jLvo1AftvAwv2glyk27j90KSkbxzF06EADGa06LzrnGQv24teENTpLqgtJbssD7AfkmYZsY1NYqZ98/29fXnFnK6wJwfGDa0J4Osm0YZqqNUunM3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(66946007)(38100700002)(66556008)(66476007)(478600001)(8936002)(44832011)(2906002)(5660300002)(4326008)(8676002)(1076003)(41300700001)(2616005)(6512007)(83380400001)(186003)(107886003)(316002)(6666004)(86362001)(36756003)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PLovkJ/RWZW6noKElQf83e7bqpROum//tnKMS7w0s3s4RAfyOXnspM97Fr2l?=
 =?us-ascii?Q?FCxxpmLpLfulv4XBba8nbxkECgs9zk6AjM3rjiMVpE8dJ7xy3qnrZ6mA1rdB?=
 =?us-ascii?Q?emofg4PljZF4TchtoU68J3IUQXn6qPRVvuTiVzTZDtIYeKszWiRnDt7oF2M7?=
 =?us-ascii?Q?kgW6bb9AamHxyiI/wed8ekRKJ3tqCMJHPKZMHnJqVQkD+VAYcC1UoHILZnNC?=
 =?us-ascii?Q?HxOORmZiIJUKavx0npMADpF1A+O7C+HjdLA5yJQQwxqkLZumRp5D9W2Sb7rf?=
 =?us-ascii?Q?EDaA/LPQE1KXIZzBXLYFuYwENRWKxw+L+Fp1N+UOiG4vb7SUd9uaNf2momAj?=
 =?us-ascii?Q?CvdRCS98C7uBQi4Csh0DFGadx0iQETWhdbF4o+cahOupkyRwYHyRYTFrdF1B?=
 =?us-ascii?Q?SPlCQLvOV5rr46Pi3Hi4tWevhfQCdxRKL0oDLmMPi0QrRoEF0Icdbk0O0M3q?=
 =?us-ascii?Q?yWvrYVzrLXt4GsTO3GbJhx0ItT/lVWwnYHRYmVM3JlAuky9fEsM3zh2c6Bpt?=
 =?us-ascii?Q?jri6UeLcPQPTgLGPBSj1C86ALzPh1W1kEsJASysyeDh9cn5t/8vc8HRzmhLz?=
 =?us-ascii?Q?VUiiZLluXvYY9y6lZc3lIJM1jgVFOQyu/GqYTZXsN1ZoP4a3Pfk9ZGq22m/U?=
 =?us-ascii?Q?s6CSvhmKVP7n/wPbJ2gPnFG47/SnOSV9BJv/WD4IYp/UjAtKhZj03JmJvdct?=
 =?us-ascii?Q?OEJcBOY09WlBU9URouuyeUhtk69xfIRfXaT//0fAMYEcEFIs5ATFCPvX2ipo?=
 =?us-ascii?Q?8ngBGv0cWrkl+PjBv4mB326E8gpHtkBFVwfMc4i0LgBPdjDBIbg8aJeSiwF7?=
 =?us-ascii?Q?bQbrgos6yELBCUdDr5faDlCSfgXI8mDkDEn5wqby+tkbTZ50xqjrwlPufyBc?=
 =?us-ascii?Q?T4pTZZGVVyEKWKHuVyHL+QuXB62ECdv2+caWUAbYy4z3OMNLXBzfAgzq9tpM?=
 =?us-ascii?Q?G6wDQXZ8bVKA9vxqd7NekhfRS8+Yz6dr22SeEA2n1SLiUSi5qRvzWz5THEhx?=
 =?us-ascii?Q?v/poxsxax3a9V/g89P9A4bI+Nbe2RULTCIRUkaqqzhqeknQzrmXRuUbqfmoY?=
 =?us-ascii?Q?iJ6HSwkHdBh/5sufeZbIlnLThb4iDkSn183t7fwWccOKzXF5x/0UCAKCnHCS?=
 =?us-ascii?Q?gcpX+kcjVUkkYYXbWiy6nCFv8ny0I4sqzUvMk+eLDJTKdVZCyK2cfOxZSz6A?=
 =?us-ascii?Q?zUJcu33phlBc4Nz+ty6wzINSvKK8TQamTltBVv38fwhYXPyHo2KEKvkTjmSi?=
 =?us-ascii?Q?2YLN2U+mD+2dvERddwvGHzXE/ErQOufjHe5h2zdCRyo0htfBWVYFjTm5yDb5?=
 =?us-ascii?Q?1mhzBoSmMzwjbZt/zTekNdM/39P4VXVzNFTmKoEdeVpP1338sthtg8gK7Rzx?=
 =?us-ascii?Q?c4cdUjQYYq6UV+LpGHYK4QBGCr8XyO9mm0THzDELA4CkgFcbO6pEFASWooUM?=
 =?us-ascii?Q?k0fAKBr54COda2CwBPLQYyhCp6Om8Y8z1AMIGBqPG31stUCobbnW/oOdZwFz?=
 =?us-ascii?Q?sqzAQAwkfmQIDr4HEX6iokd52ol2KICPtHVlo7twLKuQ6ELZbR9sPFkEq30W?=
 =?us-ascii?Q?rnRBt5JkOh42+T0HBDZm1zKamm8X4dd6RkwU70sPN38eIQWZhsZmZxMb78B0?=
 =?us-ascii?Q?6iWZWprPrpCEk1mFCg5p/FOA9lUNok9p4YwHlQd85Z/JSj93GMSAumoj41/A?=
 =?us-ascii?Q?o0IKlA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jH44AFwPIJLsghRoNcN7BGv4JOEJyH/uUN+1DmDO6TtcpfK8BV9nePM2tsIs?=
 =?us-ascii?Q?m0VcySWWKX9XpclaXNt22JJY61NoJeDwEP3SXRGwq5o/YQG4ktuTCJz78MAU?=
 =?us-ascii?Q?amiheuu2aJoW1J2buQHvcrBuNJJG06KsknS7T4cIVvjxZqNrSMxe0FWwLwMG?=
 =?us-ascii?Q?CLd995LsRQZJPJmpBWpvwcPhhiSPJvzuYP9NdH7iZIFVxUWufRaGVaNFaLKo?=
 =?us-ascii?Q?I85kq+S8EvxXai8xAzlPaYvQIVYXjLIfofhaBHUKyIfBGgNpkm9ky8ijALWA?=
 =?us-ascii?Q?Tw/wue1oIUTEGHA1A3782PiQczFequ0GjSaRyH0tJd7lxB9NI3d8HAROaaJ0?=
 =?us-ascii?Q?GaE2UeWqGi/GbeuGELJ+TXLMbTFMHYVjAuZZJgggVBVw1Otgn2EgpIaeZQ5I?=
 =?us-ascii?Q?0M4Mua81oNwdk0a0iuYqVPPfn4CdU5lHBawGQDK4EAYtz4V8YQioZw2IiqFk?=
 =?us-ascii?Q?yeYV9Dtn/ZbjnYnhMVYuC5B9NkL5MJx5DOxWNSpdfKh5t+9ZMqdWLcIW4En9?=
 =?us-ascii?Q?cTZBkIvGJ2Iwdt23uDeLU1IgaKDAQebSVQWo5cTasDxkkLNka+QGzowkmtHn?=
 =?us-ascii?Q?amK5Os2Xycg4ZiUcCZez1l+NTVKj35hGhVE85gTsAJijsJu3NVCsccqI3Te4?=
 =?us-ascii?Q?JjXgs7qO2A9Ju0swq5+cL82NCpVvMPI84f7byo6cJ5vFPC/AaydR4HcwvZhB?=
 =?us-ascii?Q?oUKpmGkAERy9Vs/X+97e3h/qhIBFS0pKyBu34lPT1v2Q2Zf0Bjuu3OdsT7uE?=
 =?us-ascii?Q?pKXFVR7QWRjmdPxQEt9sLU/jH0ldXYXDB7rYjW4Sf/BNimfBCuQvXsHQz3XX?=
 =?us-ascii?Q?OYe1xTb+RgWk1o2Tc51Z3L6/p2LLvGVHeEsBEWERoNeUnghcM7lOlL4SDDks?=
 =?us-ascii?Q?H5hyzwOslroOG+5I5jfTtGfXowdCi0MkgCb/LpnCvRSGBlgX1cuX1SodgWyP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9709ee5-3f23-4d51-e8a9-08dafa62429c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 21:15:16.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMncciwByK42ahoAFSX6SP36VcjXjHQ1YtN3JxDqUCMRCeZqreisKu8l5Q13iwiV9MjBjKbq4TL6kNqIg+e1gNfBVC0nce0OFxVFCWA0Ki0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190178
X-Proofpoint-GUID: Oj6PdwfMtkh_oXFQY0eAAe7QagN6blGb
X-Proofpoint-ORIG-GUID: Oj6PdwfMtkh_oXFQY0eAAe7QagN6blGb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every caller of restore_reserve_on_error() is now passing in &folio->page,
change the function to take in a folio directly and clean up the call
sites.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    |  2 +-
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            | 21 ++++++++++-----------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e2f8951103be..880ebc58f330 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -871,7 +871,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		__folio_mark_uptodate(folio);
 		error = hugetlb_add_to_page_cache(&folio->page, mapping, index);
 		if (unlikely(error)) {
-			restore_reserve_on_error(h, &pseudo_vma, addr, &folio->page);
+			restore_reserve_on_error(h, &pseudo_vma, addr, folio);
 			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8f054d81e63b..e76be7e8df2c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -725,7 +725,7 @@ struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *v
 int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
-				unsigned long address, struct page *page);
+				unsigned long address, struct folio *folio);
 
 /* arch callback */
 int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 46467e80716f..9568d49c12d6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2802,9 +2802,9 @@ static long vma_del_reservation(struct hstate *h,
  * and the hugetlb mutex should remain held when calling this routine.
  *
  * It handles two specific cases:
- * 1) A reservation was in place and the page consumed the reservation.
- *    HPageRestoreReserve is set in the page.
- * 2) No reservation was in place for the page, so HPageRestoreReserve is
+ * 1) A reservation was in place and the folio consumed the reservation.
+ *    hugetlb_restore_reserve is set in the folio.
+ * 2) No reservation was in place for the page, so hugetlb_restore_reserve is
  *    not set.  However, alloc_hugetlb_folio always updates the reserve map.
  *
  * In case 1, free_huge_page later in the error path will increment the
@@ -2817,9 +2817,8 @@ static long vma_del_reservation(struct hstate *h,
  * In case 2, simply undo reserve map modifications done by alloc_hugetlb_folio.
  */
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
-			unsigned long address, struct page *page)
+			unsigned long address, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	long rc = vma_needs_reservation(h, vma, address);
 
 	if (folio_test_hugetlb_restore_reserve(folio)) {
@@ -5102,7 +5101,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
 					restore_reserve_on_error(h, dst_vma, addr,
-								&new_folio->page);
+								new_folio);
 					folio_put(new_folio);
 					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
@@ -5633,7 +5632,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * unshare)
 	 */
 	if (new_folio != page_folio(old_page))
-		restore_reserve_on_error(h, vma, haddr, &new_folio->page);
+		restore_reserve_on_error(h, vma, haddr, new_folio);
 	folio_put(new_folio);
 out_release_old:
 	put_page(old_page);
@@ -5847,7 +5846,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				 * to the page cache. So it's safe to call
 				 * restore_reserve_on_error() here.
 				 */
-				restore_reserve_on_error(h, vma, haddr, &folio->page);
+				restore_reserve_on_error(h, vma, haddr, folio);
 				folio_put(folio);
 				goto out;
 			}
@@ -5948,7 +5947,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spin_unlock(ptl);
 backout_unlocked:
 	if (new_page && !new_pagecache_page)
-		restore_reserve_on_error(h, vma, haddr, &folio->page);
+		restore_reserve_on_error(h, vma, haddr, folio);
 
 	folio_unlock(folio);
 	folio_put(folio);
@@ -6211,7 +6210,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			/* Free the allocated folio which may have
 			 * consumed a reservation.
 			 */
-			restore_reserve_on_error(h, dst_vma, dst_addr, &folio->page);
+			restore_reserve_on_error(h, dst_vma, dst_addr, folio);
 			folio_put(folio);
 
 			/* Allocate a temporary folio to hold the copied
@@ -6339,7 +6338,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		folio_unlock(folio);
 out_release_nounlock:
 	if (!page_in_pagecache)
-		restore_reserve_on_error(h, dst_vma, dst_addr, &folio->page);
+		restore_reserve_on_error(h, dst_vma, dst_addr, folio);
 	folio_put(folio);
 	goto out;
 }
-- 
2.39.0

