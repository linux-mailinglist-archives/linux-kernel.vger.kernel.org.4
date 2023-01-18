Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC63672827
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjART3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjART3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:29:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383EF54113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:29:09 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30II3qXW025989;
        Wed, 18 Jan 2023 19:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Zj+uJUrFuo2zGcXZW3N8fQzlhw8xrBEvRVnluzyH6qo=;
 b=RgojYCHWViXxDY9b8WnNqNAqwPs6vNUF+9wj2dHKQGreZskJuqCDUrI/CzUDmQhZd45I
 EWqHvRe1ZgqiqDkkljHOMPUXSii4pGSXTu2I6KkhgKCOC/eI/7bvRjaxyv79uH8hJDnB
 FOnBmF0DHCsDGVNLUoB5L3hkU7AFENV2Pxk7gOwzypUmj/tPPJ5SK0zyvWXbWrYU3igb
 jVIvp4QYuS4j2J8fq3Pmz9nmErYkWOp66LAyrk+tdSqB34wLEV2SW7GCct1xy3HZ+kmk
 kEkrWKvVXFh6lQRDHoCAF9kc0TTy5zSKN27QSiy1AZ1yUNG/cpsbOv+RgR0pjXGCANQb uA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medggh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 19:28:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IId7mp010469;
        Wed, 18 Jan 2023 19:28:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6p81a5vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 19:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls8smQ/uREhrFfMftfunM2fdsAk1VRx/mm0CjLGO6v8/egkA+3HSPu9/0ehbrURNossDYHt0y3Ru/ccnbrd1GsgvoEV5ABKFWPR+zqDW1cyano2jlP/tkI2pkKUvJ5R1zLz1q+GwqGACdmFjK3nVsDRWH2IQLoZ4EbpOoL3NcipIpY5fLvLy4wq7kmxeFpAD36o3eg/8rjVrWeU7IumF3XK3liin7giRiBAPrlPPMxr11XKzOGfUA1qHUH1lCBowppAlpuRh+dTVM7zqfc6KjaIhuWSkbonMn/xTSQPah8yYUmIZwc3ZM+D9+anMg0fNmFkr+qqWCRuZ1Ih+12mIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj+uJUrFuo2zGcXZW3N8fQzlhw8xrBEvRVnluzyH6qo=;
 b=lepsn1/zEyGZyxmIKLf/t4oSlBUF0wc9m4yjyiQqH1CV2d0AGTnet+FdMKhYqHofrUSXJgdbBPBugmFobFqRG+ccngQSPi5geo3T1wbNbCLrpQLuQhvXA2IvMXGw2zf23W42TGh8W0LnjiPW557RRJMNnsg5I2p8sXM2+8WGW3XokNTwLWiQO7x5FMamsm1LplOYxXZd6ZJ1IFo6+zf/jemqzhH73ihwU80ipoZsn9wpPG7m4KkNgDar55mySzf8UJxscCF6oGGwDWXTlOzSMNw3sjqbBQXRGIkIJlpjGcUEyrX2h6r2dgwoNOjzeF0jwM9BL8qXfa6vtaMtr3BDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj+uJUrFuo2zGcXZW3N8fQzlhw8xrBEvRVnluzyH6qo=;
 b=g8wWi4yCCF/6Fs0qNdtt43GTdG3ASABXNkVUtQo8Ln7fMAwhFDCIe4mfGhcYha8vvwrH2jC8yeV1Ovi+Usuclow0ivp/f7hcEzn/RWqzJmSs0+qR4GVyCOfBwp8SKq1y3FfmDazcNfpLSkpKwPvLUWm/IvwDQ4MazZsUKSAyk+4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA3PR10MB6950.namprd10.prod.outlook.com (2603:10b6:806:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 19:28:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%9]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 19:28:19 +0000
Date:   Wed, 18 Jan 2023 11:28:15 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
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
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
Message-ID: <Y8hITxr/BBMuO6WX@monkey>
References: <Y8AnROAtMngKntnq@x1n>
 <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
 <Y8BtJzBLTpw5IR+H@x1n>
 <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
 <Y8B8mW2zSWDDwp7G@x1n>
 <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
 <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:303:b7::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA3PR10MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 93cc7a5c-6f62-4007-152e-08daf98a275a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LChaCgN88oU6F1FRkMwY9gvnc3f7i3M+ETdlMsj/Q2HyKk6Usucr1kqNgfnkagMQ7kWVt10lvvFTTeVsuY6d82bvZay1sRLJSksDUK5XgMdl11ATSoQfoNJR5Qp1JehZHoVJULmRz8u25GKlFhJcKXPHzolXeTx50bjkKsycIGyrNfw2KvBBTFRCw1D1diXihb8wHi7aUxY8YLTTtkkr/xUtfYS+9zE7SebHpTNHvdyTGjB430VjyVYxeBK3sWeOMURCmULWroejCi/5y+4daJca3fncZV5liTsLGP1ytDHPrvH4axRQMKeR3JCqOXKcSrOC1y+Uwkv3vz5t0t65CtS8w7geaQiA8lULCTRuQ1UHRSvLX7F0cZIcQmRj+NsErY+2MAT/NQsrqIHZHDZwW/3ac+cuct2thTP9XthZG5GEA4oJHxZpF7mzcvWpftnDVCfpWRLQfByNP9m0WmVlrd+4Qs30aRbngWej6PMmjfW1QJNpk/wMwuKmwqjpQVeaYYLIb4M83bBRYbsVKoBZhwkkjL7M2Vkgdv+3ywewJIs4ZVtDjN2MEAKRjfrBjlUEWTvNCpchoPY5hbaqFiSEtDy8FKHpFmew2HldYOr4Ezqe7SizZBrNtvInW8PEncvBswc65EC8n1sEnLRClq1UcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(66899015)(86362001)(2906002)(44832011)(7416002)(66946007)(66556008)(8936002)(5660300002)(38100700002)(66476007)(316002)(6666004)(54906003)(53546011)(6486002)(6506007)(478600001)(8676002)(4326008)(6916009)(41300700001)(33716001)(26005)(186003)(83380400001)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dRszhGroS1zXTH0tpM/buIPhnpFnmzBA/MQKqQnTXejli0kyDw06Api5SNId?=
 =?us-ascii?Q?516XdKohQCVwvXT+tpx0n2IgGMVNwiFYsyZ0yCdbll45hnVQ334sFqvRysy4?=
 =?us-ascii?Q?bjJhil2JowfhatQbxkkNSFWKEfyBjvSOWbqsRSMdqX+SA++y7gYrbkyD1ALa?=
 =?us-ascii?Q?1IdMoEDGWnb9bKqqMVBMqO4sJWcOwUBvnTi/Qe4T5TN9tfQ0/3I77L9IbRYL?=
 =?us-ascii?Q?3ifwmjqi2k8pB+ytPHvzJKZPuTFa6Qoc533JUi1f7v+f8POtY6UWE4DRkyyc?=
 =?us-ascii?Q?VPIKt9DqAKMxZpVhFGncwHl27atOsFy0fmH93faLjGbkihVFgAETYJy89KW1?=
 =?us-ascii?Q?c1MZiHWzzUg1HHjXL2D7XgKoJ4eIbLPpF+ljswP1WZ1i8uFEsmaeyMCeC/+h?=
 =?us-ascii?Q?WRemQSSrEFNhjG9JClkk+96E1wRtjHDMVFB3bKSITz0yWuRqSBfS0bFdronz?=
 =?us-ascii?Q?Y9PeefGKHVgsnZlaTPmnTO4OLWs52DxTpxPCAeExhR1Jbn5JHZ4UpLP19kLG?=
 =?us-ascii?Q?F7lQ1p65I67O/mdAgofQFxDXxkShakhSyPfMbBbl1Xx9kKqxTT6/gWDjgeoq?=
 =?us-ascii?Q?Td3aDNZBY/VtDoKp9YmeMLyr6yzNyOch8EZIz/uPpUQ1rKqPO5Sx3VvYwXzg?=
 =?us-ascii?Q?YwWOuUOmWkvARlEL2WUOnbFLK7ay8H8GT7ywYRIcfulzQwejOO1v2IpIyLZq?=
 =?us-ascii?Q?exzodXMX8EBuBVeZWiNi/DytW9JCLjk9tQJ1CRm53Rhcg9u2prBnOttKrm4Y?=
 =?us-ascii?Q?LWWndvOuu58S4pO/OyQ53NdGsK15J94Dh98Uwd1k/YgK3eDBS3G1BZTm0iHT?=
 =?us-ascii?Q?nhRiTtzbm8i9pF6JTadx6W682/+2ESAWZNd8CQYWIPSfAGHSUz6SLVZN4xmw?=
 =?us-ascii?Q?X9yymMGAs0pC7lq3xFvC4or7FJTqbTWl+vI9hMa2qYcG/yTsiH7bP7IyO6Dy?=
 =?us-ascii?Q?fIbMi79T8j2nbCoLwBjxNWHQlV2eHEkv/QFCQNiY4X3Kq3wGfaxEdDs6/dJY?=
 =?us-ascii?Q?6HseoCNZJv/8XKL/I7Cg0vWGwQxoUbyP1AeDX+vRgbKCmg7H3a5WxCwjADYL?=
 =?us-ascii?Q?BTXVkw1bwAN0Jm/JIe1XrxCdOWslGCZjnekLrfpQmmSQVSCU/B/7g5wycsei?=
 =?us-ascii?Q?K/OxISlngqZG/KDqpcq92IItY4BsZAaOr04EP5msri1D7ayLqsYzpWy8BapE?=
 =?us-ascii?Q?EQagpG1xBR63di6Th4CCmIKsAPBA6J3JjGckU6MDFbHQZput+m7kvUUCcuEn?=
 =?us-ascii?Q?+qKqraG5Yqh9vBh67DmkSjauVTsOtdPxmaZi68ZPXTMpSUB5drja7dDdz9cU?=
 =?us-ascii?Q?z7Y2lXViN8x5Px66TpZRv883MXaoV8PehaD6qzdYBkkyH5X//SLbcf1cGQaC?=
 =?us-ascii?Q?7PKkUUN9vwiHDnOL+pZPi60zfndtL8Y6i90YlAiGYU4iT1ijNAJ8mFIwTUI9?=
 =?us-ascii?Q?w258rDmh5hGSAdHkFzBIDERfw5op0Ds7C5Mf+u2nPVn4hOVAYts5CpUfCUiL?=
 =?us-ascii?Q?5VreXMtLfMj/bF63HhsjALpHmi2ahi1sjUX4IXzUlGf12nNmxNOARTlWStLA?=
 =?us-ascii?Q?6nt1RA9q6fDmfguyjsrJNQulxEXKkUHW9NOK/dZArlgpzXMqEB9BkmZlnHO3?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kDiRKqMTvNiccCK4hEN4o52mHQAjbfbZ/5tJVtR0tAH/OwjYSOtTjHcK+R/C?=
 =?us-ascii?Q?YprTPjWw9C6jVwPpxVUwLsXpTVJGdOEJWPfSVJ2dGYeBL7GPvOCkv1RzCKVn?=
 =?us-ascii?Q?ypufgsbcNCSkZNF5yghDlK9TBwF2QFwaKaG1QrZlS2TQKNgU1HxJqQzfuNu0?=
 =?us-ascii?Q?0XALxiQyQ0c0yIWBlMS2bM88ASI6ZOgKB44CZN++RmvQR5GMe4QkIGWrAZvQ?=
 =?us-ascii?Q?NR8ptZYBL+1lEb56SHvHQQFxYB9WG+NwgKmtti2Q0nczBZTSgukNwzHmZffJ?=
 =?us-ascii?Q?rEPE00Pg24OHthKkRwgiwrNcERejiDTV2SONMeKPIz8VnFykIYezlmGrIoIP?=
 =?us-ascii?Q?UK0nyo9ZVSvV9yHd5Is17WJSM4oNfTv2JG0RnZPZuGFE4AM/vknGXYT534d0?=
 =?us-ascii?Q?juoHDZ2GG7wDRuvQSb3dqMzsAeQlEGM4GxJxwI0jtGtEuIZ+lKW1I2zgfHXQ?=
 =?us-ascii?Q?LmMMJQI5uuOVxp5vuNlsHxUJDTBdlKY8kw0QV29EGhFKJ1UZjaxrhP55C8qb?=
 =?us-ascii?Q?zIiOp9MgQK1AXa5UyNAxsd1bjah7KfXhe4isZSZMuU2SKvCJjx2l7MShfjnh?=
 =?us-ascii?Q?XEq7auulJoZcC+7lnomare66hQ5Bos+dWVo5DqwzdhkKdOz8cNjcyPyC60WL?=
 =?us-ascii?Q?SzWffgPbLnnBfiZX7qws0H+rqvGW/YZigVoQwOJfi5gxU8vrir93Li1HiTDI?=
 =?us-ascii?Q?8nJbQB48otDbKAj86lI6VvaUmhg3zj/EXpq6YyeWfrC9LiLp0yAHBWWBv3uY?=
 =?us-ascii?Q?8BQ38zjn9nrK9xGzhcpJpguCeho1VHMLVUCtKUqioPS3e1jJVJ5PIWlQhEz2?=
 =?us-ascii?Q?R6y51hSjSMfCYdiCZbEcItndyWzczGJQ71z45FufGPN+wlhXhH4n7hZohttj?=
 =?us-ascii?Q?EcIWEk2Eblt1eqN2WQMF1rdLXP+RhOOlAFvdj4R4duI5mRt8XlYLK65tpJoW?=
 =?us-ascii?Q?VnS3MtJb8eZqgFfUTf+e7YTDUN62qKro/0cNE6DXvotqyM+IkKGmsiGv+WZB?=
 =?us-ascii?Q?PPDNHWBxJjw+7W8lFyb2MwObrFxCLB9hLaN/nOUSQHiPfAD54y+XzqYZsYGW?=
 =?us-ascii?Q?Y5q6wBMPWXrRXwUDNooS3mujdqoBssP6qgamGn2PmMRm+cK1kt2tsqr9jDsW?=
 =?us-ascii?Q?lsj6gRczOzZplwVfwE9W2GDUzCVjYM5FEQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cc7a5c-6f62-4007-152e-08daf98a275a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 19:28:19.0801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUkdyA70todgZLBVnk5E6vXE8i9Osob8MAO3oG1qAABHbyANTGrF0I/vlS42fIQhI+bnqSmve2SbFrMzrThh4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180164
X-Proofpoint-ORIG-GUID: CGBANsMBnM4CSKMReYDiGK1rRJhX3eIK
X-Proofpoint-GUID: CGBANsMBnM4CSKMReYDiGK1rRJhX3eIK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/18/23 08:39, James Houghton wrote:
> > > > To deal with this, the best solution we've been able to come up with
> > > > is to check if refcount is > INT_MAX/2 (similar to try_get_page()),
> > > > and if it is, stop the operation (UFFDIO_CONTINUE or a page fault)
> > > > from proceeding. In the UFFDIO_CONTINUE case, return ENOMEM. In the
> > > > page fault cause, return VM_FAULT_SIGBUS (not VM_FAULT_OOM; we don't
> > > > want to kill a random process).
> > >
> > > You'd have to also make sure that fork() won't do the same. At least with
> > > uffd-wp, Peter also added page table copying during fork() for MAP_SHARED
> > > mappings, which would have to be handled.
> 
> Indeed, thank you! copy_hugetlb_page_range() (and therefore fork() in
> some cases) would need this check too.
> 
> >
> > If we want such a check to make a real difference, IIUC we may want to
> > consider having similar check in:
> >
> >         page_ref_add
> >         page_ref_inc
> >         page_ref_inc_return
> >         page_ref_add_unless
> >
> > But it's unfortunate that mostly all the callers to these functions
> > (especially the first two) do not have a retval yet at all.  Considering
> > the low possibility so far on having it overflow, maybe it can also be done
> > for later (and I think checking negative as try_get_page would suffice too).
> 
> I think as long as we annotate the few cases that userspace can
> exploit to overflow refcount, we should be ok. I think this was the
> same idea with try_get_page(): it is supposed to be used in places
> that userspace could reasonably exploit to overflow refcount.
> 
> >
> > >
> > > Of course, one can just disallow fork() with any HGM right from the start
> > > and keep it all simpler to not open up a can of worms there.
> > >
> > > Is it reasonable, to have more than one (or a handful) of VMAs mapping a
> > > huge page via a HGM? Restricting it to a single one, would make handling
> > > much easier.
> > >
> > > If there is ever demand for more HGM mappings, that whole problem (and
> > > complexity) could be dealt with later. ... but I assume it will already be a
> > > requirement for VMs (e.g., under QEMU) that share memory with other
> > > processes (virtiofsd and friends?)
> >
> > Yes, any form of multi-proc QEMU will need that for supporting HGM
> > postcopy.
> 
> +1. Disallowing fork() entirely is quite a restrictive limitation.
> 
> [snip]
> > > > I'm curious what others think (Mike, Matthew?). I'm guessing the
> > > > THP-like way is probably what most people would want, though it would
> > > > be a real shame to lose the vmemmap optimization.
> > >
> > > Heh, not me :) Having a single mapcount is certainly much cleaner. ... and
> > > if we're dealing with refcount overflows already, mapcount overflows are not
> > > an issue.
> > >
> > >
> > > I wonder if the following crazy idea has already been discussed: treat the
> > > whole mapping as a single large logical mapping. One reference and one
> > > mapping, no matter how the individual parts are mapped into the assigned
> > > page table sub-tree.
> > >
> > > Because for hugetlb with MAP_SHARED, we know that the complete assigned
> > > sub-tree of page tables can only map the given hugetlb page, no fragments of
> > > something else. That's very different to THP in private mappings ...
> > >
> > > So as soon as the first piece gets mapped, we increment refcount+mapcount.
> > > Other pieces in the same subtree don't do that.
> > >
> > > Once the last piece is unmapped (or simpler: once the complete subtree of
> > > page tables is gone), we decrement refcount+mapcount. Might require some
> > > brain power to do this tracking, but I wouldn't call it impossible right
> > > from the start.
> > >
> > > Would such a design violate other design aspects that are important?
> 
> This is actually how mapcount was treated in HGM RFC v1 (though not
> refcount); it is doable for both [2].

My apologies for being late to the party :)

When Peter first brought up the issue with ref/map_count overflows I was
thinking that we should use a scheme like David describes above.  As
James points out, this was the approach taken in the first RFC.

> One caveat here: if a page is unmapped in small pieces, it is
> difficult to know if the page is legitimately completely unmapped (we
> would have to check all the PTEs in the page table).

Are we allowing unmapping of small (non-huge page sized) areas with HGM?
We must be if you are concerned with it.  What API would cause this?
I just do not remember this discussion.

> would have to check all the PTEs in the page table). In RFC v1, I
> sidestepped this caveat by saying that "page_mapcount() is incremented
> if the hstate-level PTE is present". A single unmap on the whole
> hugepage will clear the hstate-level PTE, thus decrementing the
> mapcount.
> 
> On a related note, there still exists an (albeit minor) API difference
> vs. THPs: a piece of a page that is legitimately unmapped can still
> have a positive page_mapcount().
> 
> Given that this approach allows us to retain the hugetlb vmemmap
> optimization (and it wouldn't require a horrible amount of
> complexity), I prefer this approach over the THP-like approach.

Me too.

> >
> > The question is how to maintaining above information.
> >
> > It needs to be per-map (so one page mapped multiple times can be accounted
> > differently), and per-page (so one mapping/vma can contain multiple pages).
> > So far I think that's exactly the pgtable.  If we can squeeze information
> > into the pgtable it'll work out, but definitely not trivial.  Or we can
> > maintain seperate allocates for such information, but that can be extra
> > overheads too.
> 
> I don't think we necessarily need to check the page table if we allow
> for the limitations stated above.
> 

When I was thinking about this I was a bit concerned about having enough
information to know exactly when to inc or dec counts.  I was actually
worried about knowing to do the increment.  I don't recall how it was
done in the first RFC, but from a high level it would need to be done
when the first hstate level PTE is allocated/added to the page table.
Right?  My concern was with all the places where we could 'error out'
after allocating the PTE, but before initializing it.  I was just thinking
that we might need to scan the page table or keep metadata for better
or easier accounting.

I think Peter mentioned it elsewhere, we should come up with a workable
scheme for HGM ref/map counting.  This can be done somewhat independently.
-- 
Mike Kravetz
