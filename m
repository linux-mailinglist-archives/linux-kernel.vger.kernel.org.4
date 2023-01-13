Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD0D66A3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjAMT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjAMT5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:57:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204A654708
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:57:37 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DJhrQJ027528;
        Fri, 13 Jan 2023 19:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=vxPmWrmpu7SeyQ+lqkf/cpEJaKN0C+rx18s9f6DMqSc=;
 b=V9IBQMDYy9uCYxrt/GcyFHGUfuDVa+kAsdOmynIU21slgW5J/dJxero4RYRI2RLP76PP
 HDdyK3f7b4Tk08xQ69dSdgxpTlFHQ34ue508fCGjj3B54Yv0yoOgkWqKTvdmm1pikLLY
 n8xJT+882S6t1WPyUiCaA5WMrDKQPOXoqtALpfD/o29GH2/wf20tMj914sBy0TqgHS5G
 ifKXIchfl0fmmR19mA6OXQjznzG0KoTGU7j3vlr0A5SUrexasDUPlfmPX8QqpcpaauUW
 KiQbMRzFYbSX9Y2Fns9xcEF0q+FiqxMZ7UhYisDBl5qB76bk8xC2TqvHfs5kpssJCRUI jA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n362w93ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 19:57:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DJSkno008391;
        Fri, 13 Jan 2023 19:57:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n3dg80wdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 19:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBNqyBAYBepUpUoQQwBN1Pjcagj7PR9CoUDQRGOJRdiKE/4s7YgS4CJ53A7j+0ve63L8v2Ky4l0MwhGrL0yNrbVRJFdmIkhZ+f/69h8RdpyGApEg7C+KhIiHKOixUVKRugZ8l5rQy+vg4NNj1mLUlq7maJVL59mzd5/Q/5bxnDGNN92lLfTD3E3jBKZ1bm2B7C5nQMB6sj16m6+KYKiUZ/wzIVvNErKFLZKZwBQNlHoPmj0lsxEOJWyTX23G1HrOzQ41eh0ki0CTWKVIRv/BgUipoWC5IXoeeQHLvtiFfgsoH+E5pNKGjYJtAYACa7uJrp+Le9YPhXr1P+5BukPzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxPmWrmpu7SeyQ+lqkf/cpEJaKN0C+rx18s9f6DMqSc=;
 b=k+D3AKbpOqZVG4RwPvacgBHsOt66wcRXVCErFxd3D+BxPSODHPJJVN6fpBzXsQldsS8XCPhMoRTt63WIqG8uANjMsf6ftztkxVOjEEjfqxaJHO7lN1vme7G8xxQ3fcR1la4PPZ1POlyWd8OAN4rPOxBCv5xsJTjh9iPlFjrOth20gh91uSL73bjwdRdlEebBvSxL53+AZd1rK9kyNdGRPZQVijO1jlBQbEAL/Z/kQPsQG+NAS1FmFN0p4iFmwq6iB/16WLX6KMb+OwFBaVlhcrNRnmjcr1Exs3J/zFhn+kUSg9PPhCUEG2NVBptwZWB3i5W5eqHhUgrhCyLn1g2VAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxPmWrmpu7SeyQ+lqkf/cpEJaKN0C+rx18s9f6DMqSc=;
 b=df52bhGpwMeIHMO+PyML7nAYBRaZS+naoPMsukjb3AhzMOZ3PHeXdYQzWhpxWfLsrn7kolnztcMGukYF76yMvXIWMf7TwUmvmOd8s3zqFaiFHm5JHT/dbSDo9ZOVJeRW3z+HBfsF0D0PW/Y4dfuQOZKJWMIANNr5lCxF4iA3DSU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB6127.namprd10.prod.outlook.com (2603:10b6:8:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 19:57:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.012; Fri, 13 Jan 2023
 19:57:19 +0000
Date:   Fri, 13 Jan 2023 11:57:16 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8G3nJ9+k2lB0kas@monkey>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109033838.2779902-1-senozhatsky@chromium.org>
X-ClientProxiedBy: MW4PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:303:8e::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b1f220-1564-44c7-8a2c-08daf5a060b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atJuIM2L3z4G+D1huYqSc45q8/9Ee01c6kZ68RPEnw9q/1sVTrxp+/EtkOqbnG5UzTBj2OZN6YV9DyBze/psKxc/Ar7NnkzGXmcVscEcRZZ4ZjQ8txRuHfXVuQB40coawK0ajzWKeUox2gtdWtUICIsy0X3+xfh9aUjG/ozlsTE1/BWFzUuvrVOORwYG3XJ9StxxwEbkOTGMUVals26D10rxLUFOZ9dv3BfnqBLTRr5wM/3jqShjAJhQdhqewZzEpPZ9MXh9LQzYunQuZvHsRt+TqK/O5Ag4/+KpSXT7wGVBBn6pdNNJBHJU807GsaaSGgfjyZvxIpmnKGkgXsr+TpHT4S5+7Gukl1+OL5EspmToNiVssqaiIJ+XIDqlc7HNUVuIQqWTUWXstgrbmJgeVomjxIAUFwynFXAEjUq9owNrrIeBH2biUQ/3UAf+snMao5SZ78IQRASxEOH8gbAaJrpSnRaljf69nZHFad/qa0qimwglC05LHySoqo3+JSU+zAE8ZXtw1Bn51/tC0KDyfeHjrKeVm7lmF0E+8ue0c4E0HjrjYr4HqHDh+erZ2sja+t4gX16OgJhM8K2CudbD80J6FggncofPzoSA7cYVKiw0bBktCjStVZgXN+b0u0bW9xjN+0M8nzparDpuXciiq/zj61pp1rzKHWhTZ9qmMGQ+1k2xXkVFAR6N5vqaOfj/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(44832011)(66946007)(86362001)(8936002)(478600001)(41300700001)(83380400001)(66556008)(9686003)(6486002)(53546011)(5660300002)(6666004)(186003)(33716001)(6506007)(6512007)(26005)(38100700002)(6916009)(66476007)(316002)(8676002)(4326008)(45080400002)(54906003)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OVu6qrsUKWYiED+r+exn49ZncUGT7qTZsoT6MH2pugEhNU1DwGVTPIJHHQLt?=
 =?us-ascii?Q?oACguSno4968ofSKgs1wHbklbE69FGk/HFl3EbSyFLXf1KnGD7YizZsfuRNX?=
 =?us-ascii?Q?SgaVjmyw3G9Hi5SwksDVPaD6Ad3xT+4W+sMzfvwlhEU37yweWqCugv8g9LGq?=
 =?us-ascii?Q?4Iv6Jw4CFv06fJ8yQon6WmXUs9eHsSc6ZqYQgoyIURHGfqgP31cVWMFGpJJL?=
 =?us-ascii?Q?7DAvEINM8CQKtK/2ZPlFxptDkHGnexuxkPe25S2BC1Z31d3rcq0bBa7U878B?=
 =?us-ascii?Q?O0DPR2Upvlua7ARS2RVQXLJTIK02nK2Ay93U1MMzoZAgXWCk+yn2lVKtBol5?=
 =?us-ascii?Q?JLP2NUhNgbEp4MKXeOQdWYk8qmFhpjIibAobwybuocoqqNiO3iD5v0ht9Qkq?=
 =?us-ascii?Q?+ICnH7VXTewNo4DhaFp8AX3PmABZH3kojOt38ZhihnG2SHeU2rXpQhFZGgDO?=
 =?us-ascii?Q?ZUp8HFxCl7lPySRs+PyqML5uynHDJZZTbcd1/ETvVFM70/7Hh8mRlLrsxg3U?=
 =?us-ascii?Q?z5DiaqMKkWCbu50/NN1O1joofp44MRjDlNSx9yruxFLBkAg9a/JpFEZTjkJN?=
 =?us-ascii?Q?8B2PhWSfNFTun1czYzuDJUEJdtgEVyzOJYHcDCXeIqwZjQZ2bjHXnWDk92+c?=
 =?us-ascii?Q?xP1/vWOn58S6gEMpETqZAcQl4FxF2sscKfUKxW/yuTrreuUhuIUM1TvjaCob?=
 =?us-ascii?Q?tWWoLXWXVdPJ8VgZzjobgIXDsIpTDodI4/lPhNZHaqgeNjNJTB2MfY8K+eQD?=
 =?us-ascii?Q?SRIU021q1y0i0tup6DCd32eceQd3CE8RJU1IL0/3JAZmoe+JUaxySDKbGTlK?=
 =?us-ascii?Q?8zg38XesKtHf/NKEtVreAaah6NI1ZQNxgxmq5ja/roF297P4iHIr9/4ly4pl?=
 =?us-ascii?Q?3p3Rb/OCSXy5GsKXnaNpQJeSqTAiXnHNkKwO1BmzIK2IkoB3BVYnRGB7u9rZ?=
 =?us-ascii?Q?S6ZV79okZtZD508T63iJ81R34Ah4zKFylh+zKxPCDFlxzGioJLdse+MR2M8t?=
 =?us-ascii?Q?sERL2dkn4dHplNhcoUKBkP+V5jD7AXtrV8PI2tPBevwfOGys+R4sCQfMY+ht?=
 =?us-ascii?Q?aiLiVhpiKYpm+niTKwr0r2ouMPtuNmuyeEWnFd9kvF0vGJyA2Gb9FyRRX7lz?=
 =?us-ascii?Q?BKjmkY1wQM/+Xnk64TkyiZvrQsAoyk96XYCt+1Dbmx7N3QvJ1zTAfala4a5K?=
 =?us-ascii?Q?zTQVSZnDetv6apyCq6O/lRc/skpKOD4HBX0lejrS9o86VWYnv859ap8+0Hhr?=
 =?us-ascii?Q?4B45L+G1p6rXRBfFu/3uUxaTgwSlA1OlIN26xapc1ADpAowjW7drxB/TrmhW?=
 =?us-ascii?Q?Lm/7WM7rmdcISHSnYHxb9R5EWaL8vgrorXKOItOjpkRzBxMm2gwfKam8tgKz?=
 =?us-ascii?Q?emiNDicTnAKWADxAUV1UUSl1O7TgaYgcNKWG0ACexsPlZpyghRQtq1tE5HIx?=
 =?us-ascii?Q?M2ZoAWf2Fx30p7BcTlYdA8qgBkBK47x0XwDNcpEn3Oe57DAYeHg8bCI6H7NG?=
 =?us-ascii?Q?wNyXIiRZiDf9Kv69GDNY4mYFbrHXRPvSHbfyN+uVJWXgMgw3fhDgNsMmCdw/?=
 =?us-ascii?Q?z/y3o1KccMI39CZCU5OxeRqitHKfMtMUUGAR+uLB4DsOM2A/xp8Ems8SAVy7?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NO97cWzTbiaL9d/QuplRTIg5m1OO13VQrbsxZFxfGPG/Eio/HuaBi3JdenNHMH0NvNBPo+C5E580t1wAxUqdQoP12VQtbkyp5Ch+1HIDBZySMx1iN5jMhUtCYF230fAWmJVoxWyl0vO23xooQHaiQyvqLTk8YvdqyrU7w1Y8yON2uV/9F3oJKDfvo5NUdtQcnc4hHy2OkqKgcSqgwIYRks4GjrYX+8hRVHEqxX63eczNKMkKcZAmWCIWmwi5kbNWftzzE2pKV0lU36AeRy22I0VsXGcTLkdk3UaAW/z8jYsPxJOxsZ9XmhhHLwI9754UKV90MGibr1FFWnkQb/dBYAoI4elIG+YEdBqrYPPYPSrp5mboN3jUxQnl5R8D8bUDPmWAecJNP9NJ6L5kiUP+H5EMMcSliCoI1VAJfDg5cB+eeNpWKJAAVImYtYAPLXK5NOEkMX1FvzkoofBsGGBl6Q864ZonZPG1/IyTohGb+vQgjqm69ICBp1njG9PAGFbekT8NV6U4mO92z5qYQXzModxF6zEFRwnqI5pvMWL7b0qbKVU4ctl1RmX7AapWY7Kl/k2d9rAbsrNHyAnq6YnYVZefp5Uw4zMH/2BODjPZL8hRDJuxS01OJlFt8TUowN9a1YPUxKw3x+1lCwdMWhP0qgqSNUAdZOdvIuzmydRIUoZTqOxrmGem2H9gPRxQQFsAw5eJPiTxOd867/uu3Ae/YuKk4OZ0/M1ChRz0lbl2IXokv5Y1Ym2L0Dwvepj3+XASum4TV6wxFevOimgsZC5FrJEryQjW3ixO8oW4hkWC7b0u0yIALzwHqM6wei4bsCa2aoF2o4Nv480AVT/GzC/AfeNbtkbLjjkEQtrOt5MbTXzZBJxnwLCgJRVm9cMnS3owrkd7SNzSIzwmN04lbZ4fPw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b1f220-1564-44c7-8a2c-08daf5a060b3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 19:57:19.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJfaL7rpBRXVsPhpvdFQmckZoCY3dW9yJJfsoAAzu2YgCF4dssZtLifkGxQzD0ksA1iA0I6cbMo9eR+XikAOPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=810 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130135
X-Proofpoint-GUID: L58GXtuZD_nUY0ZmECzuThEuCGfnjRDL
X-Proofpoint-ORIG-GUID: L58GXtuZD_nUY0ZmECzuThEuCGfnjRDL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/23 12:38, Sergey Senozhatsky wrote:
> Hi,
> 
> 	This turns hard coded limit on maximum number of physical
> pages per-zspage into a config option. It also increases the default
> limit from 4 to 8.
> 
> Sergey Senozhatsky (4):
>   zsmalloc: rework zspage chain size selection
>   zsmalloc: skip chain size calculation for pow_of_2 classes
>   zsmalloc: make zspage chain size configurable
>   zsmalloc: set default zspage chain size to 8
> 
>  Documentation/mm/zsmalloc.rst | 168 ++++++++++++++++++++++++++++++++++
>  mm/Kconfig                    |  19 ++++
>  mm/zsmalloc.c                 |  72 +++++----------
>  3 files changed, 212 insertions(+), 47 deletions(-)

Hi Sergey,

The following BUG shows up after this series in linux-next.  I can easily
recreate by doing the following:

# echo large_value > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
where 'large_value' is a so big that there could never possibly be that
many 2MB huge pages in the system.

-- 
Mike Kravetz

[   22.981684] ------------[ cut here ]------------
[   22.982990] kernel BUG at mm/zsmalloc.c:1982!
[   22.984204] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   22.985561] CPU: 0 PID: 41 Comm: kcompactd0 Not tainted 6.2.0-rc3+ #13
[   22.987430] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
[   22.989728] RIP: 0010:zs_page_migrate+0x43c/0x490
[   22.991070] Code: c7 c6 c8 f6 21 82 e8 b3 73 f6 ff 0f 0b 0f 1f 44 00 00 e9 20 fd ff ff 0f 1f 44 00 00 e9 9e fd ff ff 48 83 ef 01 e9 6b fe ff ff <0f> 0b 48 8b 43 20 49 89 45 20 e9 ff fd ff ff 48 c7 c6 60 d3 1d 82
[   22.995900] RSP: 0018:ffffc9000121fb20 EFLAGS: 00010246
[   22.997364] RAX: 0000000000000002 RBX: ffffea0005b8b380 RCX: 0000000000000000
[   22.999299] RDX: 0000000000000002 RSI: ffffffff81e28a62 RDI: 00000000ffffffff
[   23.001236] RBP: ffff88816e2cf000 R08: ffffea0005b8b340 R09: 0000000000000008
[   23.003181] R10: ffff88827fffafe0 R11: 0000000000280000 R12: ffff88816e2cf400
[   23.005038] R13: ffffea0009e7f800 R14: ffff88817d783880 R15: ffff8881036a44d8
[   23.006921] FS:  0000000000000000(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
[   23.009116] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.010732] CR2: 00007f8b14e20550 CR3: 0000000103026004 CR4: 0000000000370ef0
[   23.013978] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   23.015931] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   23.017892] Call Trace:
[   23.018664]  <TASK>
[   23.019345]  move_to_new_folio+0x14d/0x1f0
[   23.020710]  migrate_pages+0xe36/0x1240
[   23.021895]  ? __pfx_compaction_alloc+0x10/0x10
[   23.023202]  ? _raw_write_lock+0x13/0x30
[   23.024335]  ? __pfx_compaction_free+0x10/0x10
[   23.025608]  ? isolate_movable_page+0xff/0x250
[   23.026880]  compact_zone+0x9da/0xdf0
[   23.027990]  kcompactd_do_work+0x1d2/0x2c0
[   23.029180]  kcompactd+0x220/0x3e0
[   23.030166]  ? __pfx_autoremove_wake_function+0x10/0x10
[   23.031612]  ? __pfx_kcompactd+0x10/0x10
[   23.032706]  kthread+0xe6/0x110
[   23.033648]  ? __pfx_kthread+0x10/0x10
[   23.034704]  ret_from_fork+0x29/0x50
[   23.035734]  </TASK>
[   23.036443] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_seq snd_seq_device 9p netfs snd_pcm joydev 9pnet_virtio virtio_balloon snd_timer snd soundcore 9pnet virtio_blk virtio_net net_failover failover virtio_console crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
[   23.049869] ---[ end trace 0000000000000000 ]---
[   23.051154] RIP: 0010:zs_page_migrate+0x43c/0x490
[   23.052466] Code: c7 c6 c8 f6 21 82 e8 b3 73 f6 ff 0f 0b 0f 1f 44 00 00 e9 20 fd ff ff 0f 1f 44 00 00 e9 9e fd ff ff 48 83 ef 01 e9 6b fe ff ff <0f> 0b 48 8b 43 20 49 89 45 20 e9 ff fd ff ff 48 c7 c6 60 d3 1d 82
[   23.057413] RSP: 0018:ffffc9000121fb20 EFLAGS: 00010246
[   23.058892] RAX: 0000000000000002 RBX: ffffea0005b8b380 RCX: 0000000000000000
[   23.060867] RDX: 0000000000000002 RSI: ffffffff81e28a62 RDI: 00000000ffffffff
[   23.062835] RBP: ffff88816e2cf000 R08: ffffea0005b8b340 R09: 0000000000000008
[   23.064825] R10: ffff88827fffafe0 R11: 0000000000280000 R12: ffff88816e2cf400
[   23.066806] R13: ffffea0009e7f800 R14: ffff88817d783880 R15: ffff8881036a44d8
[   23.068738] FS:  0000000000000000(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
[   23.071022] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.072579] CR2: 00007f8b14e20550 CR3: 0000000103026004 CR4: 0000000000370ef0
[   23.076152] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   23.078172] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   23.080134] note: kcompactd0[41] exited with preempt_count 1

