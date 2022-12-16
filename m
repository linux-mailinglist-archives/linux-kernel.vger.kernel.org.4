Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5A64E528
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 01:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiLPAZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 19:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLPAZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 19:25:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B569660CD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:25:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFL3uNd026504;
        Fri, 16 Dec 2022 00:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=FGYPdhbpCy8ryxdVQbY3zr8tGqGUhssLAFRMoIfphzg=;
 b=G+VhHuU99Ve7S+a4NT/xmi/qvpWshWQtwvl9w5rexkyHZWXl/Ge2zh+/kgNpta1l4tCM
 COJmV2f9+ivzMS7Vnj/EVIi7HCCqztNkfRlbZpgV26rSmkcDf/z8tx+AAT9xyRjcPRPL
 s7gZHRjtzSEV8n+UDFyGWHvY1V8z5au6+/pRFmoQShbUpEsGkCxYzTA/mVGq7ML6qRbd
 a8Y9pA116tG7ZJf4plErv2D1LBKaH4ebFiQjc6GfbQFShnQBttB/sy/pmx4uSQGyr5ZD
 oLgxuHwb80lkKNqGsJT1/s+eZBFbY77nsMio0i/OajMBSQU31pdbMRKj3DvLKNzBeg5c Nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyerxhpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 00:25:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BFNEMbG000420;
        Fri, 16 Dec 2022 00:25:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyesj592-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 00:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpWHdkRi047RPb268Gek2owGmB93Ow7RIrtEwZdUT6WfOhrqJWY4RTw10slRmyiyWyfhFBQa/IpP+fd5wsTWw0D/OQXDlr6yGp2+3wmr+LFH6n94VTfDGAJuq7OwHMeF01C3q8xs3TUIAM+tFH0Wt7JLnhcxPaL+D0tBlunzpPbGpWKxKPHEFBOIolQcepULnCDcoCzjzOFeW5z4WdZzJhxAwskYq0JzM4QfZJkW2RZvDDocsWtB4TcsiBqojTcI9Jot8WGqGC29y+7AS+cr9kOEJ9qUtet8OPgRgazKccfIQLuhq3hoZ0VcbvR5Lu4dLEm5xYB7ASUwcffK4vDmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGYPdhbpCy8ryxdVQbY3zr8tGqGUhssLAFRMoIfphzg=;
 b=MzQ4j3ADJ/tTktaaAqB1DByht2eA9zx8tck4P6TmDFvzrGqTHirJe2xa+lG/qxJAjqwPV4+pNMjN2iwsRRUXOpihUM7uOMfsMifZ6QKMglCmk9iT1PZurWGyOZtDr+PiWHLEfa5qhFm/nHQDF58Gcgns1iOcEKaxB85npl9nKVEn2AxBmhPT0xFi0j0656WaIG6TUkRuytn98plz4CzQNh/d6gs/mqa0rT6aMBSNz4cNMz0L3ILUIG1ILe5a8IiEFAyKGKcKeBC7mpcAfF7bqHLz4ZKNal2dy2Y46xvuM0J0OsahSot95oai6IEj7Iag2Wg7LbXfP2DI5rkLTgQbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGYPdhbpCy8ryxdVQbY3zr8tGqGUhssLAFRMoIfphzg=;
 b=cuJL3w7Dd6LscEPwVlj4mcnT9+h9d2JMmidE7SJiA5qB6r33wiwrhEP00JcOPLN+WMwNFLxD+FfVrQXheUEp5ze2j3ghC4sZgWLSkAchG0ZHg0JHpwdGOg92RfRCEBFHS2SmR1TBRI25OZHj4WnhkKsVn3fzPlrINpXXPQeCytQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4295.namprd10.prod.outlook.com (2603:10b6:610:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 00:25:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 00:25:10 +0000
Date:   Thu, 15 Dec 2022 16:25:07 -0800
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
Subject: Re: [RFC PATCH v2 19/47] hugetlb: make hugetlb_follow_page_mask
 HGM-enabled
Message-ID: <Y5u646Kk1c4fatIY@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-20-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-20-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0228.namprd04.prod.outlook.com
 (2603:10b6:303:87::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a99473-c619-490c-c61c-08dadefbfdcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9lm0oSKf4K9nqcp3qoljeGDYJHJGE+LEtXtc6psD87TyIbMHZdkAR6bQicoqGQutjTQ/U6gwlZTF5SLF5eXU33tmlyEbwxXj6AJ11l0QIaD7P5M3rrQu1Fp1KfF28F4WDtOsmEdIk8kuFFAlOCbONfrbn5eQYKeEV0BszAnvqjvwKjs4Yg2XF5yX48wVML01UVPGWLg2UknAG8hRlZtatHgVoON+mqINOIs0jE/zDbt4G5GOXSGFRLGCRF7WMFAVNnDEAqB5ZNn4l9oWSYIHfO7IzmNo0ErliSenDxCUWxhm4iE7Xd1SjV297Tt3em0mtO/W8pGTfWr6BGkjAQBJ92hpwTmnSYab5zJUUWZIrssRIE7zOwqV4Fe0TpSykStQ9XDvE+RsxpkYQxAi3aN+O5pues7zdmKQ0VgZ0AtF4yp6+5zXwGAnIJhw328hve3IvDq7oyFtiBRn84E6n0s4DiZbQdwO+ynfNsWVNM8UdxkLe7O2E9DzNcPljUl9G8f5SbjJIbxsrrEIB1cFwtAhkFVNBHx9Bqwp1/wXAf7qI/MqgPftwLYRP/xnioq7/dYcdQeyM+1LHWi1SdbEfoDb0h4KRivYPSnw+GbQSxKkT0Cpk2g2RqkOpiRRFc9CNm9Pot3YhVp9MUgQdvv6155Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(558084003)(8936002)(7416002)(2906002)(8676002)(33716001)(66946007)(4326008)(66476007)(44832011)(41300700001)(83380400001)(86362001)(5660300002)(38100700002)(6486002)(478600001)(66556008)(26005)(9686003)(53546011)(6666004)(6512007)(6506007)(316002)(186003)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6uqd2xl/QA4Ua7jZtOA9bd6ZcETqqAWvXiX5H+WUTk9wz0baB3GVdoVgJXKE?=
 =?us-ascii?Q?VZA72ILAwBLXVFCF8BF8cxc09rrsQGSeqIxL1teGaUgNUgxBFGzozgtJV9qt?=
 =?us-ascii?Q?cEQfV3XbbjzXhOCuPCD3ia+CKSfkD3wIq+5NJ97d/eYKTRZKVnKkLuvMeysa?=
 =?us-ascii?Q?WY1y/Ss6xw3hNlBbZOn5x7BIoiZqkfC5a1/G4uwK0eW3/695y74plyEhuGx9?=
 =?us-ascii?Q?/cuElKEOB7vQwIFi8suXU/racW4h2xDt/LrXqvYFf0YIBr0KqnUjvxLsjuHD?=
 =?us-ascii?Q?rAlwZMsBxFbXr+qOBDA8g0QQeZ3/pS0Bc60RMmbO+HD3eM89RxFIXQOlzv65?=
 =?us-ascii?Q?acjhirUTrFG1zKYlZuiN2Jvqv64rbDFu8ovwSbysF7+hc5qPu1Dea+UnxfrP?=
 =?us-ascii?Q?+637uehRkB0rcXMtOKIEr/Uq5J2y4+hw8HWdgRE0ISkYMP2RzuFs++TDd3oN?=
 =?us-ascii?Q?CgSJOaJzjRHHA2juWpnRkasN2M/BYbedxFulEc++hZUkNkrf+R5UVxxm/RmU?=
 =?us-ascii?Q?YYs04BkSwSgxB0bYiZ0uIHbwkuILItY50Bz8Y8TXT8P/JoPzQEQbeOeqlO+P?=
 =?us-ascii?Q?0d5TZwcSTfOypprXsguyJSxmenMKtlOjJNK84eBdjPcm/wk1gZYHIDWnEYz3?=
 =?us-ascii?Q?8ZRKuzvqu578u8vdHx/AFP3dWYs9hw9M+soORrNS1ah9uusq0lwfVqgHQVWW?=
 =?us-ascii?Q?78KrSo4zaEqh469Ur/QRjEUHCgrx+agee4TWxrI9sdiLXzIdY44SL3yITeeN?=
 =?us-ascii?Q?Koe0k4lEaw7hRChOSrQjb46Nr4CnKyjGfke9cbHzk/0RJHGszWv0+eluCubq?=
 =?us-ascii?Q?SZGTVqB2TcaFEZLGugPKGzbojmXNtP/Q6OxUseEPAheDVvOtvi5Hd3FjMncN?=
 =?us-ascii?Q?LVqiwflPgPzOliSUoQJrw26Z6wTuBd4x4s4raaG+TwfzOn/6YAQa1Cn5HiCC?=
 =?us-ascii?Q?VevzKzBIbGFMvjYoIqXsr85q1Pd403jMVGmjbvOpmFfMdYRgExgNoOrwCVgo?=
 =?us-ascii?Q?9+gMN/Q246urJeE1QdyEQFlU0K4dKg611qLnbEW5I9W4mcJlsU4PpHyPbL/T?=
 =?us-ascii?Q?v9X/f1XaZqIviQBDrqKQ9lky7KgnaCKujxlyHp5WrIhd3CvhzVJVjV4GDd/p?=
 =?us-ascii?Q?R3FrCLZB+qWC2JSZcjrqkdgPOH5QNRBEa7QTEj7OAwF6GWAH/4p/iZkqLEvk?=
 =?us-ascii?Q?3Q/l8MOfhrQDTZIMmP5gt0nN4IGaINScTI2bid9bvONaYRUIujx/KKLLqukT?=
 =?us-ascii?Q?y6Kmj91ne49kygyUvyj9poPNSNLnC0GYhoNTmbwlwx1X3qDGHuXxSkS2nBG6?=
 =?us-ascii?Q?2YQ0t8VzrdxDXCWIo5SW5LcWFQZKIMgtllfjAb9JYCQHcf+MU78QkhGBHqiG?=
 =?us-ascii?Q?FPWE8Dwcimii6WhvKWRP3OIKisgIBAZKM41LvPpp2RArfPhf2vDoFy62b93I?=
 =?us-ascii?Q?RUNdmzdh6xgf+x/I9oI77E4cHKq6+Tbtk0AOyAGuT5A6JYn3YX6AxPZrMfzP?=
 =?us-ascii?Q?w+zuPJZwmis7dBbCj0+u7bWGfODBTj7YhXTCHMUJtigOKoF19w8AgKaww4aD?=
 =?us-ascii?Q?+y1oZ6EC23lljWBaPanQG+wRc7LMQfcHhaRHwVSJa8DW5uWnBo6+9TPOPa/6?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a99473-c619-490c-c61c-08dadefbfdcc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 00:25:10.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6SZ+FZtnF5iRaXQYyFrG8yjqhgRC3Pq2FP8BTpnDANxVY5ybzmct/bdrMAvgjcmI7h7eTIQK9yusIz1jK3r2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_12,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=830 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212160002
X-Proofpoint-ORIG-GUID: _CtJ7A6V5JaBEQeE73-N-jTVXFGf73fC
X-Proofpoint-GUID: _CtJ7A6V5JaBEQeE73-N-jTVXFGf73fC
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
> The change here is very simple: do a high-granularity walk.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Looks fine

-- 
Mike Kravetz
