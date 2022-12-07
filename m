Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1146F6463D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiLGWEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLGWET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:04:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6525865B2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:02:43 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7LwpsJ027262;
        Wed, 7 Dec 2022 22:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=+qQj452r6rXIrtn4VlvcoIlyQB72ihTen5fn+z1csnY=;
 b=qX5lXscwvPPHVXKKUDSG6oFtkk4msXIP5Sy/AMKojfSWnla7UjnyokRczQiDKoS5SIih
 NIWbpmWpdCvLiHd1GM5FQ4qtLQTpVkDCaT1LisrJcQdy6J1sZA8ReIxX88iiLXsUibZz
 5wCIEsxUFWw+RDnbvOmUQmdOrs32qzL7EVT/s4IDXXVruuDOe5jr5P/+8XTQNGZ9ZKav
 rhzQRL6xQ/h7UGM1TQlcXHLJjiDAsDOHCZLr1vFK6tMQMmj8RnVXo2jYHEbbzy3sMVdx
 k+/9CI3NKBume7qb7K3q5PVtzPL8ErwYZTXE17ianpZyhDTbxorRphOnKAjbQ7cidrLx jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mawj6rnd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 22:01:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7LAwOc016005;
        Wed, 7 Dec 2022 22:01:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa4qtv9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 22:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Whx4p/L48quv1wdQv15JES86pJPlz/QLn0npdviz9XxpODITK6V+prJe/aN9NnZ6s4keDhdu8mzk9AaAExeDUwZOmPQN3B0M0fGjkzbJMmZqhRGLERzhlVPPU4FW5HpVrw7jRSwd0mBWg641MF7M+0I0Wx1Ucy3rtMw6MseN8HGDr7qP/U61nQtfAffUutAlPTmEOlXYyglQtmx68ggN0rFtWssFwKT3QQvghMLqO9CUwJkV8THqnMVs/FnHJJ7MSR5pkqH3Ff+9HrJUb/bSQpiXuKai9GdV4zdxRPfxsj0mx2k7v+erVx8eJvtl2KagBgaYKBoAfAsoVhnMvhs56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qQj452r6rXIrtn4VlvcoIlyQB72ihTen5fn+z1csnY=;
 b=OYP/C6EcnDQH65rC+GTpvswBqGlFz4+ti6XzHeNiM5J7UVc62PnwFdOGXxo+kB/UXKQ/yJPTdnmkGTNvcvYcQbFbxyl6UKXBjfigP2nv62sz2aHM0iwlP1o+IP4zgkluzreRD3oojqfJUJ3YwX4cqXNx864zKHqnU3bZCInQKlUuGG8fA598jaGgxWN+At13xKTF2683PxA2qN+1NbpKsPERZQIaDMAzEywYBREISmCOcJjt5pchBWjN6eYYX2kMVlay2j7uaDtjtGShcabf/d1mO4uDrjel7ukLTUsWgBwrjuEKrDrQnHtr9/1aOi37beWCXVyI2S2Y2I54nA0bYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qQj452r6rXIrtn4VlvcoIlyQB72ihTen5fn+z1csnY=;
 b=Qpq0BDi1ly9jMHGLfwbZuAkFSxVxDsyI1vlN8QQcgziRlwaSHXQl8vIVgVPvCfE1LjP2rRng1tsqsLV+f5d4C9+jajYyodoT+NuZXSJLpkUPWJqJHj3SSr5tbsGzXYhFGShAhSMiDz+aEfjfaOeznq4fJsyBPo4TTz+vdi+0YXg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4142.namprd10.prod.outlook.com (2603:10b6:208:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 22:01:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 22:01:31 +0000
Date:   Wed, 7 Dec 2022 14:01:25 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        hughd@google.com, tsahu@linux.ibm.com, jhubbard@nvidia.com,
        david@redhat.com, Wei Chen <harperchen1110@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH mm-unstable v5 10/10] mm/hugetlb: change hugetlb
 allocation functions to return a folio
Message-ID: <Y5ENNfE3QsbGxZi/@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-11-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129225039.82257-11-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MN2PR10MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 58af1135-dd12-4078-69a3-08dad89e9748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTrB94WJo/J2h+sg56P/iJe61JE6IHyvICsYh/BKaG0cxniSgQQ1VCCvT0GGe9vUrIfrI3DuHtdYx+/KNCfSj5Vg/vhHt0TkfoRrivOQP1XLUD2L8XjEaC7A//rbNMoFm3UfB/m4qrzJUR6X662GEXmJmS4ypK4qAa4DeS4pyTlhOFnJ0BPhcwvDwHyEenQeJ4jBQJadZHIjmQoxowWdWcQwXLQ5dKew/+AyaZ77shSVXyFelw6gNWZDcGKPUS9gISNgD8ubDVNlG4Ut7jOuMisf8aDs4180PEXABtnITn+UPKGbuShkzdoX49ssucHmJSVFfHOXaWZ9ZgtoFRfUaVEh4HkVxvhwUauEHKr6PJJ5XP1fNafqxEAFuXgueVbWVKeaIry7S/Jo6bTAxSt02Ioqw94cicGSHg5nKr8b7rNTpSEuAZ0IG6Yq25Y5XoB16dLKTVtVCngwUrPZeXEXayF2uafCxWW6tcZfqXADwLZFPaK5CM59raPkfo4Kve50o/PVWXIHdFS1XP+bwmEQ7DPp4Wu4REkz8099K9pFKn5o8MW4GkZnDfmmqV5PNXJJ3WsM2R4mxwfYEtP1Bv0lUDrHUBOfkv6RyNaKSwQgvwFyNuZzQvPhysWMPsGuclfbbSsRsUmZmYk+rwWU+NB8ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199015)(478600001)(6506007)(6486002)(53546011)(86362001)(33716001)(38100700002)(83380400001)(9686003)(26005)(186003)(41300700001)(4744005)(7416002)(6636002)(44832011)(6666004)(8936002)(6512007)(5660300002)(66946007)(316002)(8676002)(54906003)(66476007)(6862004)(4326008)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2f8QR2MbjTdPXkTJVQG+Z+Ytc9mMtmkcdBF+JfoXKNWkzbvehOi1dbgmz1NI?=
 =?us-ascii?Q?/s7aWNaRiZuSOeWCi0sINjqOoUeqvjVYgMZ1xsZTo1v1Tf11jUPBmJ266m89?=
 =?us-ascii?Q?PUXXJrnvvVQPD6apSzaCE2rbL2G4Htx8rf/Ok8e3hlCEF1/kXiqL+NztW6Uu?=
 =?us-ascii?Q?KnK+L8YvCK5Md8tR/JPiYoHz2irf7w0u9Xu/BRPevqvNB4+hkfFjwowimPWn?=
 =?us-ascii?Q?4HAbiDqV2SI/45vYigX37F55qFgIqHT/SX3ulBpnX3cNr1+rd7moC8NkjKXa?=
 =?us-ascii?Q?30psm/upT3WfMRBjn/3po8qwf5mLDiFhnVniiLQcUKdYtRyOrPo8agekQ119?=
 =?us-ascii?Q?PnR8WI2pxTAsuG+y+QKN2Xnw1mqUhyr8blEuZanWi0mdAyoicseuP/MwgbTz?=
 =?us-ascii?Q?PKdB+91Zxm0ZoWyyFllhHOD79o++yG+hLTBX6V+xN5ceuj8ep1H4QlpG9VnS?=
 =?us-ascii?Q?SouRUOViKXGxJ7Fh6NBEGddSjygVILkytjKeBPe0upmAQIIBMRO/qiwPMU8j?=
 =?us-ascii?Q?YOj8vf4HigIgDTMBNfN0a3q6uaZcFGc15mP1U9Z8dLqMWlb9P2Xxy6Bhi7NR?=
 =?us-ascii?Q?F8Ktehg4grOnbnJP+4RO6cQhNW+BBiSBhxBLowfO8LHoe0R4OFhdyA04Xzz/?=
 =?us-ascii?Q?oMMr2kK4vJ7elB92bjSIZcsP7lslykSqlOjAw8m5c2WzPcjPmucnYAChgOty?=
 =?us-ascii?Q?L1X+WCqpb2r2/j8zmvK+FyWd9U5FaCW/kj6ygGiao8CTs7eCEfgsz5Lo9wCf?=
 =?us-ascii?Q?QfKbcLmj7Kgzf0pXyNETjaQdCbxHK8KV382+/z2hp2W/I+3xMrlp/B8zv5Ul?=
 =?us-ascii?Q?mRTU79rVpdUFLTI5gDcQYuJSK6pfON1zN1kiyCRJ+bDzMXvKBIiOzhR5TDkW?=
 =?us-ascii?Q?TwNSSX1Dye4ll1mW61j4n/mb9Lhigy9xe0V97kNZBXiZWKyv1pbTcLy9ZB0D?=
 =?us-ascii?Q?1eHIobF0eBEN9BN7SrTlG4mlgebVHHGxFgmT5I0UQhOJGMLdKd3oG0G+CsoT?=
 =?us-ascii?Q?CMmOhXKg/8m8WMT6PjjtTQvGSuzQgYM5zrl3UTVZKTiZ65q7xfsyyz4izKyc?=
 =?us-ascii?Q?MG2Hy4QqjvnK4dSjqZ4PqRzUbPQS5ZER+lfM36jDC4CxUQk1KCt1YoVgmsEn?=
 =?us-ascii?Q?s8bB5iTRi7JBdtd07M33DwCS1j+UgNicuUB5n3CCunK38q14lg+JT2QYCj4y?=
 =?us-ascii?Q?6c0qhxIPZSVWWK48VUUwXqex97Kt382k9u7Mv0yXhym+RiwpbWcPDKzi4zj5?=
 =?us-ascii?Q?nNjTQXv8F13A/341yZjfLwS6mtPrR9lqOnd3nxcydVquexsEP+ciqXTrh7K+?=
 =?us-ascii?Q?3TLrfqjrzQA1YTHRvmIUyL2lzHRv7fOgCkag37OMr7YiBrm/tyCue4K5A8FJ?=
 =?us-ascii?Q?F9cKmqHYF9G5vmKBcJWjhFB/K63mkH1LF74Ww/kHlgVhPLc+hLPECMmS/XLY?=
 =?us-ascii?Q?ZtEtjz54limT+ezVct6++CnHMCvrZmpzdv9RduohUxN5OjTy0oaXr1OWazFD?=
 =?us-ascii?Q?gvC2d6+L4oFTFh9Pp3yzQ3+yYxVXVSlYASXvrzWKsNzhi1D6HI61XeJJWiQL?=
 =?us-ascii?Q?JbBBiZ1JfJytBmRkJS8imOFIBDx9SDGirA5vaAjfjUorAOXPgyOkqIPVf2md?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58af1135-dd12-4078-69a3-08dad89e9748
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 22:01:30.9636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0/duD+Co9/KN7LeCwHKo973JhUZCoL/H91Tai1MMN3484tOZUL3K8y33qPUQwWzTjYQ0tG5EGkx5eNdxJcX+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070186
X-Proofpoint-GUID: -ZHQT0r8lb226x8_E4XUR-JNlMuY3u5U
X-Proofpoint-ORIG-GUID: -ZHQT0r8lb226x8_E4XUR-JNlMuY3u5U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:50, Sidhartha Kumar wrote:
> Many hugetlb allocation helper functions have now been converting to
> folios, update their higher level callers to be compatible with folios.
> alloc_pool_huge_page is reorganized to avoid a smatch warning reporting
> the folio variable is unintialized.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reported-by: Wei Chen <harperchen1110@gmail.com>
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  mm/hugetlb.c | 120 ++++++++++++++++++++++++---------------------------
>  1 file changed, 57 insertions(+), 63 deletions(-)

Thanks!  And, thank you to John, Wei and Rasmus for helping with
previous versions of the patch.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
