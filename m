Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7C67464FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGCVkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGCVkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:40:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73C1188
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 14:40:37 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G8MeM022942;
        Mon, 3 Jul 2023 21:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=FmJWX6ok5cR9Q8LpoVmaVhutsyqzMmeKj/CRXMAW/4k=;
 b=IeQIH4Cuaawdlt0m3hLaUN2r134RrNbGWNsW4oI5fbFFkz91g76JYbd0XNa5DZAtml/9
 3Ap2+Rh3nvXn5Ku22l4ZMsbm5NSnEHkUHQTCFqJ8tdZuUbn0PX/LznfdYys6DsK0xASu
 TD8nQHc9sXTv6FwPQrJTrrsISEO8hE3xsk8hiryq6LBcorPc6bTU//60t68EYdYFVkGB
 IcGSsIi0a3RFiT+NvovkDE9nCbppT8xEg7+MuexIIpzI3fDH34wET+vdRLvGFaR+xXsu
 a82xJbqUmxV+QAHEni+pq8+hKTfzzjEgMDPiCfvOBv2zUA+5I+Jqji+gnsi9Sx1vvPY0 Wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjb2bkg76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 21:39:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363L1bVG020765;
        Mon, 3 Jul 2023 21:39:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak3kag4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 21:39:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2vIsSOeU/F3jetvQZ48Tb4wOqr8Q/wH9DTbRohnYCPm9wfyLaMtKapj8pE0oJepNq8gTfoJHlfiiZLEKBKrTu/FB56DzZ7jeu4j1epRXrOFgn6fUTN/iVFjuRptGdJIdDrFvmdx4YPtTLW5yATgsNNu7Ug78NFQXHwSglwKh5iCHAS3TwJ8bL+Ew/gjJ9vopwkqYLBue/dk7ujmjfd6U8ZnvKUbQXg591lniTKhF++z6JeZoGmlWsLXCtAt1Lvjk34Yo3GfUlmTKWU8mdAhIbbRWcuuDK9RXPCzVFDnkvjtZc/BAYu4LP2LDxYccPaoanXbPJ+QBikZywyqbIHnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmJWX6ok5cR9Q8LpoVmaVhutsyqzMmeKj/CRXMAW/4k=;
 b=V5QHgwjLK2FbX8NlWECcg9nbnRa7TLKGXig+VO11XxKMbN29hJs57/liicTlrFwcjxZcDxSklWh1L/L47u0GyTyjBVNY+1zeV9KW/EF3MDH6yY5yOJ0tBjrJK7zmdzcF6+K/zO/dPVOicHJJujgHKhtgXquqAwMdOFPVFlglftBAMRRx0jCB6WE+Pyou4FcFEIImhdweV95IH6hiCRzzgQPOzzI43togAc8mhXFbEg45MnC25YAOCkuKWNTJ6yPJ1U7FRXBDNW2OfNY+RwFXFDqAhbhtiwYUIIdruiaRQYSjORyKpX2KWRyFZJQSeMM61LhoulAaYMPsh+pKSKjhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmJWX6ok5cR9Q8LpoVmaVhutsyqzMmeKj/CRXMAW/4k=;
 b=MuOauN2nQSo8nb+/vxdf7GxYPRHEgWeFvfvEIE2Cjz7l9HFOODSmi8DNoboIdeFRx/ZKl162hVmgeCVw8M5mPQKuOFFerEzGOVFF9GOexo2c2++CetNWHOTRRlB9tm7mr9KiNAeIHjVAc6DEs9vGeETPHTFdEWn2IuCX5w0xWmA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6231.namprd10.prod.outlook.com (2603:10b6:8:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 21:39:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 21:39:50 +0000
Date:   Mon, 3 Jul 2023 14:39:46 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ian Rogers <irogers@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jiri Olsa <jolsa@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Namhyung Kim <namhyung@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ryan Roberts <ryan.roberts@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] mm/hugetlb.c: fix a bug within a BUG(): inconsistent pte
 comparison
Message-ID: <20230703213946.GE4378@monkey>
References: <20230630013203.1955064-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630013203.1955064-1-jhubbard@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:303:8c::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5131da-66d5-4796-f81b-08db7c0e077c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /J9frey5u5XQEO5CoiFxNbGmhx4fWc7Q/Zvp+sqfS18W1rvz4rE81vYhRBNRWT6nC6Lqy6SQGwnBW9fyly+o/JqMg09OIlRZCB+3cSo0gFYiviGA7IYRvcgDqXDxqRKTvVRwYlxX8cGqcSsfT1+UtOVTOz1wyXfxi1xV6gfh/gUY4KL3Gse5FeXcXztN1YT0LSMVmNp4FPKCxW7velFUCtTrTC2uAdIher/9+XIjgIxYKLv7oNHW8ruYQS9xsel9f4STiOsabU9y6hz6zuU5BzOsnZUskN1O/1N2Tof+Rs2SBUemCmG5mVheOcbhDAux8IHvDSpL6/EPEV9WZuC/7tgNLsGnJlEo1ZwA+kzStH1pQ8RjUmM/uto5WNMlE56gVBekW2DI89x4sKif2QaxdNDCKSngIFvUJmrJZ9qaFb8vfixUDWTjmOUM/Vj+37fdYbIz5HevtZLHpD5d1hfi6xo91zFHgK6FxBuGahL2Qe1gTsgd0DsUKrSX/F0oXkahXdpdpvGPiL8osBqGvAS6mTlxAtkujp87B1uHXaPIK6AMSe7nWDm2OQl6vXTqZNcF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(316002)(66946007)(6916009)(66556008)(66476007)(26005)(4326008)(38100700002)(9686003)(6512007)(186003)(1076003)(6506007)(53546011)(33716001)(6486002)(6666004)(478600001)(54906003)(83380400001)(7406005)(7416002)(33656002)(8936002)(2906002)(5660300002)(86362001)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NuL/7vAUh/zuyfkF3KNe8bHWF4hybzjd/hE4pHwdbNuD5gAIXqJb0z0b1X3J?=
 =?us-ascii?Q?71nTs+LHKFlQb3KgQADmILnovFzT3moYyxkYPXq0e5atDUT4vB4sWyXn31Da?=
 =?us-ascii?Q?l4CKMmsSGdx3anQHB/53d6dkoNAOtjHCpAkf0tW0YuRfwgEDvqcDGbfUL0Pt?=
 =?us-ascii?Q?c4kkLi4VEiR+kaKAA+jqi3jRJPR4v/Iy2nCQsO3+dRArg1Gt4PDEjea/v6v1?=
 =?us-ascii?Q?mYGaRCKMaS/ZyJKONnucbmHBgE8bH58i4wjZ68/jb2KcrVTHyBBK27nAXqY2?=
 =?us-ascii?Q?Ya3aZfKZaoDLJf8e54iQeUumfbBUy0XobDARd3zvZYmEN28b/ti1lGCuQl77?=
 =?us-ascii?Q?WyYRY3WpoD7nV+5paAP3/AtVjAmPZLNFmrsaM5Q/h+22jz9iUazMin+47X9B?=
 =?us-ascii?Q?Bd9XuIDcCAOeRgOWG9l8jc1+4Z+8pB+OY0rFXxjRy1mB2FOhb6W99hzfY/gO?=
 =?us-ascii?Q?kseH4ZRJCmw5JaNUdTwHCIu+dv7AYW5K3smR4DXovzQtpSZ348QFZdX6ob7L?=
 =?us-ascii?Q?/hdgA3fwwuZ8GySly4LXL9bNmvK1hbCxeXrS6JJaqtojfSjU/TNVnleINnqt?=
 =?us-ascii?Q?Fs3WXAQsQWqxHw6hYV4IXV//VIQ7QQ9qoktET/IcFDu95UdNct9VtsLwQyrv?=
 =?us-ascii?Q?flpblAiw42lu8rgO9eomCngaOmIqgTtrcVjlzTV6KjIV4JSKYbrQ/YfVaTRN?=
 =?us-ascii?Q?PYSaPotJU69/NVzEKBGsMdbvV+0W5+mvN+HtyrzBAIT+/IDP1DYJg2pdOiD2?=
 =?us-ascii?Q?bq8+Cw+x0oPkYuQqdgFHjRw//SAwYL9xTTC/eBArmN6CORyAlOBX+3M/8qLc?=
 =?us-ascii?Q?R/EZizaIIx5RtkWTvxVHvCRq09ZEe+QyAABZYPIAdEvbgFx7nKYm/J6VtbV4?=
 =?us-ascii?Q?tqvYJi0pARM2zRHS06zzwnSDtK76RmWLa4Y6CLeJGZU7YlG0SOMHVnxGjJCB?=
 =?us-ascii?Q?dRv+5mHFCRwkxYN8NNp49l7Fr3LdjFnFRcAdns9K88lpmYSwvz2ta7MiM6Ra?=
 =?us-ascii?Q?iePuFC//j3S3WxOEgGPAskjxYSHUHqazzPTd5uUMn5zKZtlCkLgfcSt1jqpT?=
 =?us-ascii?Q?lKJej96zkDaXmUUT8ZCZCfuyo3AO7VOzsiq/yNXJfJ831E+d/JmzDlYz9RHr?=
 =?us-ascii?Q?mlAwFVOtVh7ibGYnbqfq1a8b3ce88OVhYDE3vTvE6LaHr+bJx4BQejgZ1rD4?=
 =?us-ascii?Q?Ml2t08fq8vESMWpkHiSg5TGam1jKR5n+xI0WbdcHLNHbc/mCLajxMLlKx7rm?=
 =?us-ascii?Q?TnGm2io2ynkoQchCOfcdvB2U/gE9z47cMQ3pRI0H3ywWyFimGb0rhxTKxSLc?=
 =?us-ascii?Q?YEXkVOzjrHH1v7CScKwbBh0NxBWjv5MQc1N0m89IAJ8M7TZ1AsmNXI2Rx27Q?=
 =?us-ascii?Q?BYeF3zy6x+SjkSxtqgjWbPLVgYqzPhfhjjLyRIYAld15zNVfxHiwaV702inH?=
 =?us-ascii?Q?fp6SDwAtmnOsf0UIqgN2Ql3hQ4nmssf+qbgLa6LaWTwKoV2F4SAeDJLnmlh7?=
 =?us-ascii?Q?cUJWBWr+m3vlcx34cPDLhmwL2MLSEIwzUSAMwimsjWxbtYN6kwHL/6pj5PYd?=
 =?us-ascii?Q?I6khNdK3YKGnoJOLMcRND8HRjtw+aIpHl4ppdbnsLKNmspfg3bcJvRMsdp+p?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3LGe2vQ4AzA4w1wLpK8EShEZnCU2nRDl1XIfdrn6iRpNTTifRzlkvf4nHWDA?=
 =?us-ascii?Q?lFk7nsZaDjPp71A0vQrh0IlIaazJgfIB3DAKPNf1QyNQWMLabYmt96DuZa9H?=
 =?us-ascii?Q?4tnwCRXx1J2IXsQe40hBPcL05JeGwokcOSmZe5V9jmlqBs8Cwa1dLjUrwlud?=
 =?us-ascii?Q?SY21CJAOZ7YaHj9R0N41GX7x1P1quvJeFyZ7mrzQY007KGtF1srnlDp1MacO?=
 =?us-ascii?Q?cjIpzoFjhq5tmHl4iyrzvo38FDyyO3Sdhh3+tjV2KVq8Degp5RPaMqMGoueh?=
 =?us-ascii?Q?aGhNNSPjwYEgwvyivwL93r9EcOzolw1I7C6ZBHCT2A/sCQk0XAKe9whDS3Nf?=
 =?us-ascii?Q?/lQAYwL2i8OJKQ+vesOzn4aSGIDrvEpWyHuhKnvTtRC7yOMq7VLYQZV3ziQj?=
 =?us-ascii?Q?zMsIRYdg07fZEdasVO2cmnlBwkf2TioYkO2VJsMPf+hq9l82hNOdRfJdlNGt?=
 =?us-ascii?Q?Y7PyuGGrX/mUDmKmUhAiKyu5TIkQS2dnNlEnwq16KL/HsbVv3N3zORKcluVd?=
 =?us-ascii?Q?A5Fy0aB+HXPc4RgS8pPFFiiRPXBfq+tHWB+AselVB6Q7hv4o8Vy7PDDPg9j/?=
 =?us-ascii?Q?b04YvQX3Guq44Ac8EBXQNe14rUnzmoXB2AFrMV/TbOApEODDqUl6BR2bx9Hu?=
 =?us-ascii?Q?AB609+70/PXq8ggnCOYoOyZQ+hsd+pl88AuFgeB9hito6HPX2ic911wNiq46?=
 =?us-ascii?Q?lm/HyZkxjTa4nJ+SGOFLokPr3SKgh4aHE4Wf34QJ3L6vLjWeFShIjchDxNTR?=
 =?us-ascii?Q?ttikyJrztxSsmajt/FR4jCWXv6cPFGZDtg8LwM4ibk0cVjKZYH7Oec4pYsX7?=
 =?us-ascii?Q?cDg5OC08cpfqpW8pt62YybxkAPcTYW9WnefPqkASWshquKIvVGmMoCsb9wl9?=
 =?us-ascii?Q?jQuePFfm+G6Vze/cOnlRjb+AdDr+7ZL1xZYsOJo6qzyk/1losZwb4iWsce5x?=
 =?us-ascii?Q?0vZvpE/XhCDnNYCkOzCrHmGJq5f5YaPnjprLLpvvQtRg+TnPyE67tMnFMSkt?=
 =?us-ascii?Q?paLss0hehEgHUhNPozUp9MHLTmVHPAwyzbMlNw0mRCWytRrkTfeTpNdNFNAU?=
 =?us-ascii?Q?tA/3aMrtxNIjfDjSUpevaZ9V9am5PNLJ+D1Hhknafb/vC2WwiapvHFQzosJl?=
 =?us-ascii?Q?tAO3jJoFHzPWcLpZwKKheNt6zzCgEWUhrGCg2rxmyK6fK4OSRfVzNE/L5Y8L?=
 =?us-ascii?Q?3mNFA6QdIGWExsmeOQfUmsFZla+j843Rsmx/F0B8WH7ZnC4MPVau7g1HYv+c?=
 =?us-ascii?Q?XtDBOUbrLP5WSya6cmwdG4zr7K6330dXMcC2iGE7e0pXmbIhXqlgMfKSi7Z9?=
 =?us-ascii?Q?WOGKL1DBRSTJfIw3gytQ56cknM0aGSU9t45LaIEgpfjQqtIAyo4sNqe/Wk2a?=
 =?us-ascii?Q?hxrYkVqynWxYTF+F9VAY2YEFLVzL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5131da-66d5-4796-f81b-08db7c0e077c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 21:39:50.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1WLK2nApgHidRfhhav5JmclYUhtxCbV+CMVvZyUwskgcgkDAS0o/ZEbCirsktDL083XfLQvl1ewEuujm8Oq0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030198
X-Proofpoint-ORIG-GUID: tISttJnlDPbMbafnFV7OPdhzlYzR1aFs
X-Proofpoint-GUID: tISttJnlDPbMbafnFV7OPdhzlYzR1aFs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/23 18:32, John Hubbard wrote:
> The following crash happens for me when running the -mm selftests
> (below). Specifically, it happens while running the uffd-stress
> subtests:
> 
> kernel BUG at mm/hugetlb.c:7249!
> invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 0 PID: 3238 Comm: uffd-stress Not tainted 6.4.0-hubbard-github+ #109
> Hardware name: ASUS X299-A/PRIME X299-A, BIOS 1503 08/03/2018
> RIP: 0010:huge_pte_alloc+0x12c/0x1a0
> ...
> Call Trace:
>  <TASK>
>  ? __die_body+0x63/0xb0
>  ? die+0x9f/0xc0
>  ? do_trap+0xab/0x180
>  ? huge_pte_alloc+0x12c/0x1a0
>  ? do_error_trap+0xc6/0x110
>  ? huge_pte_alloc+0x12c/0x1a0
>  ? handle_invalid_op+0x2c/0x40
>  ? huge_pte_alloc+0x12c/0x1a0
>  ? exc_invalid_op+0x33/0x50
>  ? asm_exc_invalid_op+0x16/0x20
>  ? __pfx_put_prev_task_idle+0x10/0x10
>  ? huge_pte_alloc+0x12c/0x1a0
>  hugetlb_fault+0x1a3/0x1120
>  ? finish_task_switch+0xb3/0x2a0
>  ? lock_is_held_type+0xdb/0x150
>  handle_mm_fault+0xb8a/0xd40
>  ? find_vma+0x5d/0xa0
>  do_user_addr_fault+0x257/0x5d0
>  exc_page_fault+0x7b/0x1f0
>  asm_exc_page_fault+0x22/0x30
> 
> That happens because a BUG() statement in huge_pte_alloc() attempts to
> check that a pte, if present, is a hugetlb pte, but it does so in a
> non-lockless-safe manner that leads to a false BUG() report.
> 
> We got here due to a couple of bugs, each of which by itself was not
> quite enough to cause a problem:
> 
> First of all, before commit c33c794828f2("mm: ptep_get() conversion"),
> the BUG() statement in huge_pte_alloc() was itself fragile: it relied
> upon compiler behavior to only read the pte once, despite using it twice
> in the same conditional.
> 
> Next, commit c33c794828f2 ("mm: ptep_get() conversion") broke that
> delicate situation, by causing all direct pte reads to be done via
> READ_ONCE(). And so READ_ONCE() got called twice within the same BUG()
> conditional, leading to comparing (potentially, occasionally) different
> versions of the pte, and thus to false BUG() reports.
> 
> Fix this by taking a single snapshot of the pte before using it in the
> BUG conditional.
> 
> Now, that commit is only partially to blame here but, people doing
> bisections will invariably land there, so this will help them find a fix
> for a real crash. And also, the previous behavior was unlikely to ever
> expose this bug--it was fragile, yet not actually broken.
> 
> So that's why I chose this commit for the Fixes tag, rather than the
> commit that created the original BUG() statement.
> 
> Fixes: c33c794828f2 ("mm: ptep_get() conversion")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/hugetlb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Thanks for catching this and the detailed explanation.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bce28cca73a1..73fbeb8f979f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7246,7 +7246,12 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  				pte = (pte_t *)pmd_alloc(mm, pud, addr);
>  		}
>  	}
> -	BUG_ON(pte && pte_present(ptep_get(pte)) && !pte_huge(ptep_get(pte)));
> +
> +	if (pte) {
> +		pte_t pteval = ptep_get(pte);
> +
> +		BUG_ON(pte_present(pteval) && !pte_huge(pteval));
> +	}
>  
>  	return pte;
>  }
> 
> base-commit: bf1fa6f15553df04f2bdd06190ccd5f388ab0777
> -- 
> 2.41.0
> 
