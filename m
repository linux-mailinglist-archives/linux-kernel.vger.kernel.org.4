Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D074E1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGJXGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjGJXGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:06:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640D111D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 16:05:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AJNeo3016636;
        Mon, 10 Jul 2023 23:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=TX8ReSra2CTr+mmxeCiQytd1RCxHzR3pjRde6VuAu3o=;
 b=Lc3T6t/XMdkcLnXgx3FoMu8hAdJw1TnVNr1sqnnhovEiqhVLcw7RJN5GGYGXzERNW5IT
 edCe6/l5cHO5LSyRXZZgGGlAugkMK5PfuyaUKtSUJT8g/o/C6sr1hgMbeA+zTsQYC4gC
 lb29RzlAyiTn9F2fqgV8Mc8a2URaidaH8ncVhdGM17ahTPD8qU70g5AysZgbtDL+vJdI
 7esiYHNYcXC1F9B3J5/QgKggziNXiEJrwn7Q1ziLgfq6qu+yucqyfVfbpzTvt6BiNvTM
 jo8T+NXaIGwpyPo0JuFRgPZdHNESp4beHWz6XdA0BBxG4FewuEvgZ3xJyXj9Fc+M2Bte zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpydtumhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 23:05:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ALKR30022913;
        Mon, 10 Jul 2023 23:05:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx843unr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 23:05:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWjGns0CHteSjCkT7h9c7TVgz6UR9GVCHg6QAphlPSMlKjVV5J/q7NmaRmnsMg5LD9jlIhH9TRm17x71DmJ1SJseJZJH8PDDDDztbP5+9MIOI2i/QXK6kZFVD1/TSjnbQzk/J6szo7M32QDqvLyCcdlrIsGtULAK7eTO/ehBPlf3EdoTuObu9aHPgT52bHtQRp3+qrIZP6FKKV3EbixxiqIvoRKvMdFZ5MjwGjueKe/gHMl9QSIxj6ZxuHyGtRCsK2qsC8/Yqa702i9nYg1o3NFPSUjVdPpFCLjx5ubPJljR0zMAQxfGwlpBcBTIz1EHAOmNj2hRh7ihvPnWfE1m2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX8ReSra2CTr+mmxeCiQytd1RCxHzR3pjRde6VuAu3o=;
 b=hJQgDQGS/RliYLz3EQzVa3IYOiBGHltPQB5wQ5cZgyvxXEHMe0DsxSu2E0Fv7/SOiujYP7A43HeB2hKjtmuJ2A780cRyODLJR29DkRadc+UKst5ykPgGbHwIheGjQLSR/dP+DnUUmPt3VEbbbZCP4niLMX40yn6KMwAf6ukeXkYTH/UDXTTP6+X1uXumyBA9RPX+ww8CrAlM/hKuyGhh1RZoyVIY4RHvvO32bsoHiLtA3jqtfLfBuxnRPiVPeHqPIp+/n1CDkeVEBbnyd20f12gLOZmy+iDeZm3PkEFnae9uNPdjJDc+4UyWxcYmIvPf6UAeTW8e5FIfUcsrCG3kNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX8ReSra2CTr+mmxeCiQytd1RCxHzR3pjRde6VuAu3o=;
 b=RxDQHrV6CONYO90WwMMCYiFUMlToWVbAhQ+VfzvViNlwBiQ/cW8bCfoqDEF3DhyU3SuqfGjb1Mw0MbFFc+0xVra2g8fBm27GgrjS1qzp84FpzusLTSr6yMZIor7bm1yBGoRiP92Zq8sOaqXE2boJtqu1QQZW5+UsJ9mRT6lseGw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB5856.namprd10.prod.outlook.com (2603:10b6:510:131::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 23:05:23 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 23:05:23 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        david@redhat.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 1/1] mm/filemap: remove hugetlb special casing in filemap.c
Date:   Mon, 10 Jul 2023 16:04:50 -0700
Message-ID: <20230710230450.110064-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710230450.110064-1-sidhartha.kumar@oracle.com>
References: <20230710230450.110064-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce00b54-bc9b-4429-4cd8-08db819a2423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31dnM49XK5dHP0b9dN7nqXFZXRARIHws5YHDD/Ns5GkviKHEjn0zZ6rR/mku+GNwnB4bHOn2IWX/DHVEw6aUBDjl5izUzJlKPXcPF2asMXUa7sZNtvc+k7Qjt9/bpenxDa390d8WsUvIMBVdHDSn5sFZCthZj2dlckp8A4K8d8tbg53QHt+n0wEbaEkD7SICAH3d0TfQBwxehGnCHzhp/H7bL7+S/D3rPrDL9PRkDoxWdutIj65ipQbyCg9051ZC6FA31s6GkHc+qoPuZyloXYZr5e8V/MYFAP0tJDAhpXn/Yicg3AABOBJG2LgSEXxGcpw1H+4/2nUOEEsZGLdM4K3gn9kGaOADVC83LFNbG/KV/3/2fvt4rrZo3+n0Npi1QV5z3xaKkNRPBuDp6L2pgYlmo38Uw3wZ/O9oOtD/WYLRXhGUuPKktVuKy/zhVgHMF4bKVpvUyDUDAG4mzVytPm7bdiLAqdt/UwXERHn/tP7imc1PGuA7ecuUzGZIrea8zPRGy+6s9X22hkn4kRnG5U8LgFtf4r2sa81E1HWjtvYpG7EswbqmBYc064l8/akg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(186003)(1076003)(2616005)(6512007)(6506007)(107886003)(478600001)(83380400001)(41300700001)(4326008)(30864003)(66556008)(316002)(2906002)(5660300002)(66476007)(8676002)(66946007)(44832011)(8936002)(6486002)(6666004)(36756003)(38100700002)(86362001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WERIrUQ2W15hDKHoFLCuPBkORrJkpn8Uc0daYzb/XiyVDsjFDor7E6ywnXdl?=
 =?us-ascii?Q?taQM/3omPrjI4ZlqRiT/q9g6+3KwlsgfvpPPUsZG0a/bEJaq+1NOlCxEHZr/?=
 =?us-ascii?Q?M7IAqq3G2SW8n9X4COSylQS1kgPWLhTqspcKC0fSdJb+MCfujXkv1C9OIBHL?=
 =?us-ascii?Q?tCoiNlLwhMDJEWpwxwLwOk6EMqrmJzKcGrl2SmVU7TM/AmQfBnUDJkZP8no5?=
 =?us-ascii?Q?FmVxYdCQ4BSbmgzI7LbzsjovvRW2aPnTS3CouTOVpKNvINptPnZaz1ZU4mIc?=
 =?us-ascii?Q?NsKq4TjmKqw6lXg8iS+i/k83bE9jY2TjC5SU2j8yYzupXYebv3Pc0NmRoeOO?=
 =?us-ascii?Q?BOtL1+yJ/8F+1TyJaFoqe6jYI3aAwbnBy+8ioHaXrN/kLc0i6KrB2b5PTKzX?=
 =?us-ascii?Q?H+UkGhHKR5nLYOF5B1/SHL2QLKZjlFNCXPtyJgKa29pvTGGI+f220E6UE7yG?=
 =?us-ascii?Q?CiM39O3S19mKoG3Xkov1ylmkXi/r8bxO5BRZDtBWky7tDXf8EmEg83It4ZcP?=
 =?us-ascii?Q?O893OwuKWrxar+TRVg+nskR/ozoNYBMDmrr1MZXQ9DKyAu9zMOvfxM4PrCpp?=
 =?us-ascii?Q?UcxLmo5B2k8IpxGmg7Ts9DHhHdeJ5OgFu0Xp5iWbjeocbskXzSdzw/ieKUTb?=
 =?us-ascii?Q?sEmU7LljbOWJPDsgKqrW5MRmXmGdL/33R0tw8ed1KElmGv6KmgP4EEWkdLbr?=
 =?us-ascii?Q?eCEOKZ7uqvoPSKho7GDrtidx5WxR4nY2Qx12hCUJlPLS1DenAo58Y/XKu029?=
 =?us-ascii?Q?6YlAkPnwGZb/dC9ek0JTH+VEp2zNXUdwIORzRuIcUOImb+gqoh/femnWJ8Ed?=
 =?us-ascii?Q?gnGpggg6yl1vXr/DYKjYt8KKIsduVrEs+f9zB8Z52dmiPJ6wZ3aSgWLx/1jF?=
 =?us-ascii?Q?MesiIM58qoJGXhY58lkh3pK7CyRJuzV98gptlW18beachuLFRBkBIH3lc01P?=
 =?us-ascii?Q?zAsOMumddgs5u2s2kdDT3DnJcPkol85MUfjlkVZKGTm4ga6MDsNp+q1H4zI2?=
 =?us-ascii?Q?s/7o5Y4WzEVD2fO8akDiaKSNL4zecyq7H3DmPlCUhwm/P9DHoVXhWZIjIpL3?=
 =?us-ascii?Q?yhHTXr6SN+6V5KgVo1zHGx4NrgAdEuGi9ecUCCgFuGs+odzs8RYRHd21Iplw?=
 =?us-ascii?Q?h736WKgpvbWNkF3ClngYEwy/iYNpfiBt5gp0XmKYaDR6CQHTUfP/j7BM2zzw?=
 =?us-ascii?Q?NlxzzZlivD7ksLIe+VGVfboupIffNHXRA5nmxpAUnRKTaFDMzkjDlxmnL08I?=
 =?us-ascii?Q?FQeUQx8HW5sU+XDSDp8C4S/24YRbC/+8ZuonQcGGFfGg/AFWnXEiX1xqfUj5?=
 =?us-ascii?Q?WWyH65lSpAooIkTRmrR7Eqbscn+syhq/htvJShb4hKzescamKcNz/hCcS7Q2?=
 =?us-ascii?Q?r+uaKD2ngTeo5LaQr6LtWewJPWTtNaRcPQRAyGNaofZHCDdu69En9YCE8rds?=
 =?us-ascii?Q?uAgctLI2hypthAtuUZzNvSz0EWCehW7ycO+9Og6pDEvO2vw2rpdYMWjnc+kt?=
 =?us-ascii?Q?sSDpHpuhNdkTp8/cOrzNPDUAy8Y6xTeNSDkAf1je3/fYkBsGAhXeZU1JoqNr?=
 =?us-ascii?Q?2QG/D3NSQgBgW0eoiF0QPpVdj8FMvwJHOMVkCoY7T6hccsObzrBcQDv84sGl?=
 =?us-ascii?Q?buGBF9/ZmRTQ9XEFzi9TQ5U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mWWXurAjwXwag4rqF3Gyy271e7k1FFgHlPRGpHWTRo3ZTjzgCR7fNi7K9Bd4?=
 =?us-ascii?Q?TvuauXSg0aLm5qIs1tDlb9NVqs+Z/YF1RgLh7Vm10E5aKV5Gc+TnbTuyDZH5?=
 =?us-ascii?Q?zwBx7moqgFr84vUVR+9iAEZF7KOeD1WefKkb780jt1K/AYXtGu6uMFTwGmbA?=
 =?us-ascii?Q?/gkKddSbbBRAIqbilNE9BTZnZUaL1z4c1rq0miEoS6gfE1cFVu3T1y7lS5Et?=
 =?us-ascii?Q?NVU+B2zVhLUCELyUhAG5Z1qMot/LuTTNaMIFTtGtDE2fxxzwy8Cz6nASsncb?=
 =?us-ascii?Q?YeN8+1zKglaTBp49L+swi51/VugPzn3rW54/w8TdBJiOzDwzVIEaFaZmwPHs?=
 =?us-ascii?Q?An4jTKQU37CRKv9Cx5/19CEELt2pAXEhn13W/K48ae71wEJNCg4dRSi1W+72?=
 =?us-ascii?Q?sXSLcFmhE7Z0V5a2X6rWMI4FaRLK9GvN1xULaIr0dMxr8Sm7NyfHDp51k802?=
 =?us-ascii?Q?GnB54Ph0xPgpGw0/cEJss9bhj2g8H9dpAEi9uyNCHycZx7gkUhA7KWNkA488?=
 =?us-ascii?Q?o6IvARePFObqVCFjTrMjGNy6FRWxtpZUJgLzQdXaYfzy3OZw9iTUmUIwCiws?=
 =?us-ascii?Q?hb+FnCCDJB3ef/28YVCJIlDwW8Z0cH65uzKYqhHsvs4sLNeDT2be35hhQC5I?=
 =?us-ascii?Q?08RR7Sm8CQQVhXafhb2JNYxW9k7qpNIoGffV793+H4Ic4iBd9DWSt6Nh8Oc1?=
 =?us-ascii?Q?JCDCFGUcA1nEQ9JnlBkEqi7WrZSThVIFbsJYq0uRaWz1H+vUtngxZZDGn0ah?=
 =?us-ascii?Q?0zmVCbeovgLyW40sa72Wai8IWKNY7oi8Yz8T6BzUMqo4ESiQpko5quzLTj7q?=
 =?us-ascii?Q?cUZW1ggM2kB0mLi2d1gad5n506GohqN0Zmyuz06Id+By82ZhC4NudBaTx5nC?=
 =?us-ascii?Q?xpzR4fdvFtuYUqBLlERSNcywI7HPoEzKySTYHczUftJ49Xgry0d/dEcwxYKo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce00b54-bc9b-4429-4cd8-08db819a2423
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 23:05:23.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ofbfhK2eP+gyESbyuJ8ntTmrLzrXe1y/OY/Riadb5SQpwfnBxo9gNsCFhsITgmqeaJFS+GyQ6A7+JNf0jWKyryThiHShu8clAyVs2nyU0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100209
X-Proofpoint-GUID: zqBKDcRLl2R8r5iBk810W_UBpxt21Y3J
X-Proofpoint-ORIG-GUID: zqBKDcRLl2R8r5iBk810W_UBpxt21Y3J
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove special cased hugetlb handling code within the page cache by
changing the granularity of each index to the base page size rather than
the huge page size. Adds new wrappers for hugetlb code to to interact with the
page cache which convert to a linear index.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    | 10 +++++-----
 include/linux/hugetlb.h | 12 ++++++++++++
 include/linux/pagemap.h | 26 ++------------------------
 mm/filemap.c            | 36 +++++++++++-------------------------
 mm/hugetlb.c            | 11 ++++++-----
 5 files changed, 36 insertions(+), 59 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index c2b807d37f852..d78c71dacf0d4 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -663,20 +663,20 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
 	const pgoff_t start = lstart >> huge_page_shift(h);
-	const pgoff_t end = lend >> huge_page_shift(h);
+	const pgoff_t end = lend >> PAGE_SHIFT;
 	struct folio_batch fbatch;
 	pgoff_t next, index;
 	int i, freed = 0;
 	bool truncate_op = (lend == LLONG_MAX);
 
 	folio_batch_init(&fbatch);
-	next = start;
+	next = lstart >> PAGE_SHIFT;
 	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
 			struct folio *folio = fbatch.folios[i];
 			u32 hash = 0;
 
-			index = folio->index;
+			index = folio->index >> huge_page_order(h);
 			hash = hugetlb_fault_mutex_hash(mapping, index);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -742,7 +742,7 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
 	pgoff_t idx = start >> huge_page_shift(h);
 	struct folio *folio;
 
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio))
 		return;
 
@@ -887,7 +887,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		folio = filemap_get_folio(mapping, index);
+		folio = filemap_get_folio(mapping, index << huge_page_order(h));
 		if (!IS_ERR(folio)) {
 			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 623e98d62df3a..57f21279c529f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -811,6 +811,12 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
 	return huge_page_size(h) / 512;
 }
 
+static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
+				struct address_space *mapping, pgoff_t idx)
+{
+	return filemap_lock_folio(mapping, idx << huge_page_order(h));
+}
+
 #include <asm/hugetlb.h>
 
 #ifndef is_hugepage_only_range
@@ -1024,6 +1030,12 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
 	return NULL;
 }
 
+static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
+				struct address_space *mapping, pgoff_t idx)
+{
+	return NULL;
+}
+
 static inline int isolate_or_dissolve_huge_page(struct page *page,
 						struct list_head *list)
 {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 69b99b61ed72c..71d969557bd94 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -739,9 +739,6 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
  */
 static inline bool folio_contains(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return folio->index == index;
 	return index - folio_index(folio) < folio_nr_pages(folio);
 }
 
@@ -799,10 +796,9 @@ static inline struct folio *read_mapping_folio(struct address_space *mapping,
 }
 
 /*
- * Get index of the page within radix-tree (but not for hugetlb pages).
- * (TODO: remove once hugetlb pages will have ->index in PAGE_SIZE)
+ * Get the offset in PAGE_SIZE (even for hugetlb pages).
  */
-static inline pgoff_t page_to_index(struct page *page)
+static inline pgoff_t page_to_pgoff(struct page *page)
 {
 	struct page *head;
 
@@ -817,19 +813,6 @@ static inline pgoff_t page_to_index(struct page *page)
 	return head->index + page - head;
 }
 
-extern pgoff_t hugetlb_basepage_index(struct page *page);
-
-/*
- * Get the offset in PAGE_SIZE (even for hugetlb pages).
- * (TODO: hugetlb pages should have ->index in PAGE_SIZE)
- */
-static inline pgoff_t page_to_pgoff(struct page *page)
-{
-	if (unlikely(PageHuge(page)))
-		return hugetlb_basepage_index(page);
-	return page_to_index(page);
-}
-
 /*
  * Return byte-offset into filesystem object for page.
  */
@@ -866,12 +849,9 @@ static inline loff_t folio_file_pos(struct folio *folio)
 
 /*
  * Get the offset in PAGE_SIZE (even for hugetlb folios).
- * (TODO: hugetlb folios should have ->index in PAGE_SIZE)
  */
 static inline pgoff_t folio_pgoff(struct folio *folio)
 {
-	if (unlikely(folio_test_hugetlb(folio)))
-		return hugetlb_basepage_index(&folio->page);
 	return folio->index;
 }
 
@@ -882,8 +862,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 					unsigned long address)
 {
 	pgoff_t pgoff;
-	if (unlikely(is_vm_hugetlb_page(vma)))
-		return linear_hugepage_index(vma, address);
 	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
 	return pgoff;
diff --git a/mm/filemap.c b/mm/filemap.c
index 8040545954bc4..12f51e1b0f4d2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -134,11 +134,8 @@ static void page_cache_delete(struct address_space *mapping,
 
 	mapping_set_update(&xas, mapping);
 
-	/* hugetlb pages are represented by a single entry in the xarray */
-	if (!folio_test_hugetlb(folio)) {
-		xas_set_order(&xas, folio->index, folio_order(folio));
-		nr = folio_nr_pages(folio);
-	}
+	xas_set_order(&xas, folio->index, folio_order(folio));
+	nr = folio_nr_pages(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
@@ -237,7 +234,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 	if (free_folio)
 		free_folio(folio);
 
-	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+	if (folio_test_large(folio))
 		refs = folio_nr_pages(folio);
 	folio_put_refs(folio, refs);
 }
@@ -858,14 +855,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 	if (!huge) {
 		int error = mem_cgroup_charge(folio, NULL, gfp);
-		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 		if (error)
 			return error;
 		charged = true;
-		xas_set_order(&xas, index, folio_order(folio));
-		nr = folio_nr_pages(folio);
 	}
 
+	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
+	xas_set_order(&xas, index, folio_order(folio));
+	nr = folio_nr_pages(folio);
+
 	gfp &= GFP_RECLAIM_MASK;
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
@@ -2038,7 +2036,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2102,7 +2100,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2143,9 +2141,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2171,7 +2166,7 @@ EXPORT_SYMBOL(filemap_get_folios);
 static inline
 bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
 {
-	if (!folio_test_large(folio) || folio_test_hugetlb(folio))
+	if (!folio_test_large(folio))
 		return false;
 	if (index >= max)
 		return false;
@@ -2221,9 +2216,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 		if (!folio_batch_add(fbatch, folio)) {
 			nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2240,10 +2232,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 	if (nr) {
 		folio = fbatch->folios[nr - 1];
-		if (folio_test_hugetlb(folio))
-			*start = folio->index + 1;
-		else
-			*start = folio_next_index(folio);
+		*start = folio->index + folio_nr_pages(folio);
 	}
 out:
 	rcu_read_unlock();
@@ -2281,9 +2270,6 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e4a28ce0667f1..71d18bb76b4df 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -952,7 +952,7 @@ static long region_count(struct resv_map *resv, long f, long t)
 
 /*
  * Convert the address within this vma to the page offset within
- * the mapping, in pagecache page units; huge pages here.
+ * the mapping, huge page units here.
  */
 static pgoff_t vma_hugecache_offset(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
@@ -5724,7 +5724,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	pgoff_t idx = vma_hugecache_offset(h, vma, address);
+	pgoff_t idx = linear_page_index(vma, address);
 	struct folio *folio;
 
 	folio = filemap_get_folio(mapping, idx);
@@ -5741,6 +5741,7 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 	struct hstate *h = hstate_inode(inode);
 	int err;
 
+	idx <<= huge_page_order(h);
 	__folio_set_locked(folio);
 	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
 
@@ -5848,7 +5849,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio)) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		if (idx >= size)
@@ -6151,7 +6152,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_folio = filemap_lock_folio(mapping, idx);
+		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(pagecache_folio))
 			pagecache_folio = NULL;
 	}
@@ -6283,7 +6284,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 
 	if (is_continue) {
 		ret = -EFAULT;
-		folio = filemap_lock_folio(mapping, idx);
+		folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(folio))
 			goto out;
 		folio_in_pagecache = true;
-- 
2.41.0

