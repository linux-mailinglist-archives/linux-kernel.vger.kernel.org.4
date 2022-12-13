Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BE464AC74
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiLMA3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiLMA3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:29:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285162601
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:26:28 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwn4e029926;
        Tue, 13 Dec 2022 00:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=kF4ayXPvot1X/r1fAUpbouJOcmksairLiQa2hA/4reQ=;
 b=O5ZlMyvYoFtxffmAnOAZIZoimuBoDZ/nqA/aE802mr4mo52j/SSx8pPIcA7rhNl4BsqO
 GoUy0DGuCwsEGO4DoK+xtzuQOosjRITswfXt4gfE7DxhV6cYpBMFTAL4Jv8Veo6CdOf0
 K9eCWyPI4s7NFbU0kHUH08assv6ZSa5rly4LE9r1LZZyegGJ+3xZCYoPrwIcaD5ahRa/
 Va9k/rb4pYNRexvNecx3lP1ekja+5agk0Va73DpYJtzTF4k2FJ1UzC6xyGoAjQPJ6Ssn
 0pQ8V6HqKsQE87Mw8p+iQ8KYhuX0a8I4RCqMj3RhBJEOfUgatKNRYUm2u1Pl6DrtUCWR yA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcj0945wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 00:25:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCMQbqQ031734;
        Tue, 13 Dec 2022 00:25:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj4uqjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 00:25:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMjaStwCMwv3fwq/E351McchbeZCUTz1GzPEZpbOZcHJxEALmvhOaZlB+rHYCf3m/Lqpa/EU2CHl6hnC2mH0k3LC4vLop9rE5vXGodasDh7/DiMxxY0q0+c45atP9aG7fY78hdR08ZU+BixBraQVA759q4V67Fd+1O+Ck2QD+EDDYK5F4lhMOwrJpbzD92JR4uVZ25aLhcm7UkntQasaSDRpQTQpF0reRU2ArKh4qV9+yVkkxaPIfAXG3jGAGK4I/HN6VjHEJncrW6nghoqzyXg548T+SwRoSlL3mgkwzGdUgUZteJIoIXg1zN22fmFASFgXR9ySVPsGrRQUqlX1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kF4ayXPvot1X/r1fAUpbouJOcmksairLiQa2hA/4reQ=;
 b=gAomYfA1QSYrNM8cJIwz4p1eJ5ul2HW9ZfPfYaFwo4fwMnVCmCARip8i3wMdnDDnD9AQiljlp9vTvfEn7UIKUlfAoDh7+mZg9fUYxEevhVLM7tv509AtkPGAS4rEiXp77EZHG7/PHZHuRk7Py/d2Ngtec4IzfIdf3c1csamufUz1bUqxBeZGJjwX6nPmUKqbhQcpA1Q7ZGXQjQRjPjO5RllUF+ud0vf3zXlchx0psicI016dBYuYAvQnoBeqfL3Glm25ifZnBq8bgTS1IfKaE8KqlDCVSYw2XD5H4+7Su0YA4uJyzqDa4N7aiLSziD09Pal6L6c6Gxa2HHvFdOQemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF4ayXPvot1X/r1fAUpbouJOcmksairLiQa2hA/4reQ=;
 b=O9j41IIWKfd9Cskq8I1qLgoGSbvEPBzb6g/JWr01wHS0cNSTTzqzI/Qk7SMfMT9i3b5hZPoPhOmq1HzmHb8Ck0vMY6Lo8/q4CUtE04nQGee0CfJXZ4f3cHRRqD90Ygn9+fRu51C+319W9ifLmGZ9VGguWyOaKd/SQC6vxxA0Icc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ1PR10MB5954.namprd10.prod.outlook.com (2603:10b6:a03:48b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 00:25:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 00:25:51 +0000
Date:   Mon, 12 Dec 2022 16:25:48 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 09/47] hugetlb: make huge_pte_lockptr take an
 explicit shift argument.
Message-ID: <Y5fGjKPefweBQg+H@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-10-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-10-jthoughton@google.com>
X-ClientProxiedBy: MW4PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:303:b9::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ1PR10MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abad69b-0097-4be4-1571-08dadca096d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvTZG9y5I79iTaPqXhAWunKIjAfTtCK2U1IUM7WEnIPv2icBN7BufQhtFhOtf8dOxpxpNy2wM3UsE4H9+xNIeoutgKck+oEC06czkjDnMdqYX2asQ0y6l3In3V4DV9VYy3FbNMbWUBa+2llrCMmgTCrFxSHgH1SquVOOqKQEsL4tnykL3xWgGnWFnNDRT7hXvN+E5hEkGQPo34lY125NJ5VEezNdcWFEASpG5xCCqN/YIfIyqndSgtt63GI3repSwJKtBk/jWeQoPIrfo2b4rJmz6IpFXpN/J17UKZ+34ipQdFOGBnhvV+tC5rS+jcea1Gwx6KS4h4cGBnhszvsvPZS7Nhy/RhmjVOPzK9ofaxuNhX9HITxl0p2XmhIOkWgV1hbiwK5blignY4HK6cSiauesk79UD3YyMgonRoMxlXf72NA/eVm4pcWwLLyVFUwazvs+HfI8mGgH7Q/F5+Sl1wUnVjeK4Mim5/1rwjkLTHmxJ1ghW4WdnmUCBv3/pdliv0gTRWSI6uVpChdUoAhL2ewtl6UX8fBsNHnIB9AY/54r0/fHFxoJhErNtO37EXd5C8k49ZlsyMH9Ru88VscBhAYvUM0MYGX0hB6qVOQUcdChsre3XuD7TsxoTdOKBSZJRFOKgM4D845YhMsBaeYr05IxM1lY3nbng8ENuohJIvC4NiPDoWc53Qz2KSSb4z++gqyUmcSB03tIp4+09oX4QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199015)(86362001)(6506007)(53546011)(316002)(83380400001)(54906003)(6486002)(26005)(6666004)(9686003)(6512007)(6916009)(186003)(66946007)(478600001)(41300700001)(7416002)(8936002)(44832011)(2906002)(4744005)(5660300002)(38100700002)(66476007)(66556008)(8676002)(4326008)(66899015)(33716001)(14583001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TOo/burlk4FpscA8RiAYMXCgouRMw393c7dhtdQjvVk3K+h0IMO70QhiCiAp?=
 =?us-ascii?Q?VBo64JuXCI/dBYjuCR6SbOkn1YDFCb4fgVnFdKyZPQ/hrk/dURYY8H0Ib/Dl?=
 =?us-ascii?Q?xufUmWi4s84Nn//e7TKbE+LGEQhRx1Sdk/2LNH+mrWhZABP3xECK9+Egah2Q?=
 =?us-ascii?Q?ulBtTwk9Of0yU5iKEjTgmJZweMDj7cGlKq4bEprvSNMwNQBBO3CxeqOLxYJY?=
 =?us-ascii?Q?M11ytNM8ru+KTsAQpkasYnfWmNW8uoxPQZWrcTOv3f81FOEjrMd+IKmNvsJp?=
 =?us-ascii?Q?FPLz1x+bOu/hnJwl543gfn3tHumSh40LRYizrV9vhQcWP5N0egYAHvc7JOjZ?=
 =?us-ascii?Q?bhK09Xm+pufAPtmlA4GxAbSWJSdYGC4XgSEfwLC0puC4lBGBaLJdeOhiQRbN?=
 =?us-ascii?Q?43aPbmCyFyajSavvIA6gsQlsE0zZP96IXUZ1XAjh/eHK57nwgWZdug3sFeau?=
 =?us-ascii?Q?V0sdqEf5DSK7iPcw5AiD/lNS6gNz0f0mhqbVwUdqXKQ7Opp9g1vqP+uwPfmp?=
 =?us-ascii?Q?OmW5G7Vh8Cy25w4gbo/LUdSb0130hRlwRj0iOPmJS6MmgZbOMa1Uyd6Va+Uf?=
 =?us-ascii?Q?s21qIwOEqcDZ3LzJDNfdGe6ChT6lacMzOz29y1QS02ce833CnzE04E3KeU0I?=
 =?us-ascii?Q?64ONHt9puE1z945zMPPB0xcAQPbCV9T+5lRIzWST6Idfd0VbHLBioHr6OodV?=
 =?us-ascii?Q?VHsbQflP00cZtyK5prhdiNJhza3YLXseOmHPXBq+KR+E3qXz4q1nvngE6PHh?=
 =?us-ascii?Q?q96BbjeOk6fH4yy/xrWo5bDWOFho2aLYToGg4zv/5NcUKBxvbsOEeBKCH6nA?=
 =?us-ascii?Q?YLpefE3IpXUd+ry+YYZBeFUQPEYicyMzhyAW/pQWP/0OJgpxYcBkJz1oijAI?=
 =?us-ascii?Q?SZ0mu1Lhriwr41tZ6Zh1GMpdDmBbb39tRHZP2Ru7YzUgj6UlyHAXJIOGSuVZ?=
 =?us-ascii?Q?RHFepM3RmqyiJaLrLMxYD0m1vtcOH2c7rYO5oQ3pu+y9roL2a7iM7iYzgKLH?=
 =?us-ascii?Q?22Xb+rKxfaoa6LkylZEGVKvK16tIUXWWfOpYZptwax3LhOa3ieM2WJEA4x+c?=
 =?us-ascii?Q?jCOD+MhwlL8f3fz7t0JbtubQIqeKsrD1MNf5Tf3p74OdetQDN86CGl4nKZiu?=
 =?us-ascii?Q?mbVsFG9j+YRWfBC4V+oS4V5CTZUpIXVHkQ32nSalEky3YLRBSRP58aC/wVxh?=
 =?us-ascii?Q?PuOSTdsF5kOQS1cogmQPYMDvSN4qhoX/gKNCYUBbOFkVea0ytj8/rhYUANeV?=
 =?us-ascii?Q?HURWUdh7BIgK32a5Dr8cwJEgzFYjYnCimaYa/Te5PBguWUqnnG7s3odLSJVp?=
 =?us-ascii?Q?mFyzyVteRdXA/EN6ja7Ublr7WAOgYHCp9HOFIMAtAiiyDIiaxjfa13akofTi?=
 =?us-ascii?Q?VKIeFWl8X0kW8BRpgWu/QuWDYyu6PVR5VSzlpuL2ByHp8MC/yuzCEXm1Vx5b?=
 =?us-ascii?Q?VDkuJniDEJuwFV9JOLxDsFF1h3dCisN2y36q8E7Pg0iomKhziWk7xinD/tLk?=
 =?us-ascii?Q?prNib7987Yb8dj9xfpin4C0CzFFZOqqyysk1OhgDRfXONAand0bllAEIIroG?=
 =?us-ascii?Q?4v/4Xm7l3dldgKrBPNS57+rSdlOHA6fBlj8o1vnbIHVYtSFWG68CDaFBU4z0?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abad69b-0097-4be4-1571-08dadca096d8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 00:25:51.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4n7QUD5BjtAJF+D9PY69Rxiw0+HiRjobe9r7sDTpm8WKYw2TvX34JNb4Xmefrkxx8n91MZdChtuiMY0nME/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=749 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130002
X-Proofpoint-ORIG-GUID: AbklzqLNnw0sXN1Lp3TMQxE6uAta_zRm
X-Proofpoint-GUID: AbklzqLNnw0sXN1Lp3TMQxE6uAta_zRm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 16:36, James Houghton wrote:
> This is needed to handle PTL locking with high-granularity mapping. We
> won't always be using the PMD-level PTL even if we're using the 2M
> hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
> case, we need to lock the PTL for the 4K PTE.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  arch/powerpc/mm/pgtable.c | 3 ++-
>  include/linux/hugetlb.h   | 9 ++++-----
>  mm/hugetlb.c              | 7 ++++---
>  mm/migrate.c              | 3 ++-
>  4 files changed, 12 insertions(+), 10 deletions(-)

Straight forward substitution,

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
