Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9B26A63E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjB1XxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1XxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:53:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD4D9EF1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:53:12 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SMttjj000437;
        Tue, 28 Feb 2023 23:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=mzgk9qOje3ARi5YSdg/YVJxtjfQ4+T+6XXgj/DL/ioI=;
 b=eu7EfXSK8Emd+BIs7ejruSKg8KzVuUI4iMNKyD3pDsR/9rPjyjnIECnuErnM/egHMlxT
 z0MNjeiUOMLDwKMiWqJQZpPibWl3Pf6wNgWOA6KT5a15yoMVRjHrT6eetPy2GWIJFrIr
 2M3+eunUe/vfJrhSpWLRsFWX4gztfifN0tdyHRyQqFvSWv+6UqcyaElG9dOXZSfD+R8Z
 baRtVuXtWEvwgNHUizMZlNkPWhBNidto7ByK8wK8CwH1Quw1UMbMG6AJmESJip2E6HNB
 Oy/K14VHsPKvLODbBwzuQZtiFeRpzsUheBFTsQPWBipth1sYJEp7+qosiX70dpKeoeXb DQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybb2fs27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 23:52:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SNe0g0000547;
        Tue, 28 Feb 2023 23:52:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s7benm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 23:52:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2Ad+5rAfqDyoXHhqjRTv6O3K/LbvjUfDKGj+b3bP2q1I/f1p8m6uAwPuTh+Pj2K0cBA0WPgcAWD+XgjMVIAOPdUIFQK/UiTB01Jt13R9rIkCgLtpkArVEU2a/aFQLXVgWFRFAIBquQ5JFI4WNikXcaqI9sCaP52COxYA6nTkvz0L0eyOGK49GiLb5/EUBCsNTfnzYsXl09nmXYKl3ybhnrSY5eBtlF3BTQIzPCPBUd94MC2yVAETkW66kn8jULtJkCVgioqdAPG/MpTffADj24waY13/0C5ohDgccUvUy+TpncHL2Kf4Hjb8xWR4osEnyB7H4KS99WZdyV04OsfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzgk9qOje3ARi5YSdg/YVJxtjfQ4+T+6XXgj/DL/ioI=;
 b=bvmfkulkWaiUJ+PxTMrLxLGVw0Y9KJ9OBklRPeIMFbx6MtnP4uadfkibDmlIxvHL4NtXy59hF2oL+iBc43nn042t4hk9qosU46MVncmIMcxFgQvWzVjJO2WwIpRLmHoajgwvuX7IrMoiHIPZR4U5gEHHQNYCdJu4lggDG5SH3suqr5A4iSpuddzO7si2cPUhGQ5bOO8cVhlwwxKWofL8B24hubq/bfrmqznJibRa/5n1OZOD7xaKc8Taj5Y1p74Py3a1aS+QjrLhp+Skwi7jzaViZHvpRqsukjqa/o/8y4FozMrnOc3TIYlQP91pnR30wi5jkKuPK4EIYQI8M+hM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzgk9qOje3ARi5YSdg/YVJxtjfQ4+T+6XXgj/DL/ioI=;
 b=iV0ftM9KU3q3O3fCxs+byLl7A+GfOM6lI6fkkaEzIuLFRlQIUfgBGmIxjSiqNaA+IUgBBtiD/FWKVjKLbi4dQzdbAgoKnqNS/egiM4zX2SsP/Ae9J2FAWI2gJF1YGr+vLjX2IPpYHYHAxG6Ul+OyEY1jqijBDq97q6ZVSq7Hm1o=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB6156.namprd10.prod.outlook.com (2603:10b6:510:1f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 23:52:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%7]) with mapi id 15.20.6156.016; Tue, 28 Feb 2023
 23:52:23 +0000
Date:   Tue, 28 Feb 2023 15:52:19 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/46] hugetlbfs: do a full walk to check if vma maps
 a page
Message-ID: <Y/6Ts386188x5Lm/@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-18-jthoughton@google.com>
 <CADrL8HVZN1CjV3=azvKaJs4h_aTjfmrKpv9O6UVyDiQDdFyEjQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HVZN1CjV3=azvKaJs4h_aTjfmrKpv9O6UVyDiQDdFyEjQ@mail.gmail.com>
X-ClientProxiedBy: MW4P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: b603d6ce-87f9-40c1-2572-08db19e6d645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftiks/BgbRFr4lRoXZqapklm/Yoxy50LN7JHj6Pz9KZm9S1JmSIQwm+M/xFwO1U/oRxDEE26C5KwZlMcGLb+dqNNJbB/uowl2toOz4Te9Xxn54H68iz0jc34BJllvvc/w0KwelGu+dRlPjCCoobifreA1ZfBqMzIgMP/wnc8luVzOnNSucf4XHmsnIa57Dn0RB/c6z3e5e1lQZ1rxEKHOz0NgpD+py0AlCowyZcJEypG/se+kghhJsTXhskcE+JibE4Uf/BQz2BNIKNuHOr4PCoM6+ruXHdAXzvQsb1s/VWsoBfQBpolID2MtmGlChaqnZy23hiDr5K0VOCxVidinybMav+LkmCx5SzNyTpNjx1zse1gtlNVe8HyjoFlbhM/1F4AUYL5Ehq80u/XhJEc7cTBm9zskhKRGlWXmWlEtF/tf6QIjwlioiHMCXaSNPwxLo6f+9f51yd1KIePVdCYVKAmSpqWmfn+zYzna6MzQ1vjzC8Mxt29y0/rK4ExSm42RLPek2C53JwhPkiOpvYvqm/rkOjT7Wg+AfytCzFfgdaMhP6ndwmeS+k5NlvSHPCyKhk1A1bFa8ojSTrnU9w9ggxh2GMbVgYDgFIiA//m+SW721yFLJ6YLM2tKpZn9VTX7eQPBi13bYAyJn8aYHcSlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199018)(86362001)(66556008)(66476007)(66946007)(7416002)(41300700001)(8676002)(6916009)(8936002)(5660300002)(4326008)(2906002)(44832011)(38100700002)(6666004)(6486002)(54906003)(478600001)(316002)(33716001)(83380400001)(53546011)(186003)(9686003)(6512007)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XT+R8bsJx3K5R8NsVDcUw3jt4/Y7kmzMpou9n7wOzgUxfNaNMS8Y3JsZ3FcE?=
 =?us-ascii?Q?dW7c1AfJhP7bbKf52BArzDPayRWMndRHZQ6FD3nFTpqlNho1BUEN7bAG4U+C?=
 =?us-ascii?Q?nw2XmK/Lt98N9F+kz7dxLNdM3xfcP5BuT4egDNHI25y1gsmhZZCx4zOEFTYW?=
 =?us-ascii?Q?XT9528Hf5fO6ElYqbYdHACFVuF4b0I/8dwCBob60zcWmqkVGGoklfKuMV4WD?=
 =?us-ascii?Q?wlIZ3fpLtEJfLbYinnjVNYEwLWmGaJtP3njJss7S5e2dB7tD4LlzK90uwHkH?=
 =?us-ascii?Q?UYn6t9pIl2ucrdoBkLogCyBEucxmR0xI3MdWaOiCl91pb1OYiml/0GhIor67?=
 =?us-ascii?Q?xp7JXfx/TUaF2Qs13bC0IGObbRqLdfqKlVsuTgomFBNcpeo/2IEueFDgX4Lf?=
 =?us-ascii?Q?bA42HHnSu/Wktg/VjoehDmXVcEbFwAnBg31Bh6N33G06PBjNcx0P1AwM6wQo?=
 =?us-ascii?Q?YgjZKyknKITQrVunZ+sPOpPYYZ8VsTZDG2U/IslgGqhjRE8Y8GAQkHDgrd5T?=
 =?us-ascii?Q?kSf+/uRNwwwOEzOG4+IypoAb3v9yMddGw5HLlO2drKcVKnwA1ZTE47InvKHR?=
 =?us-ascii?Q?4wUOmZeEP5O/iqzDWqkzr4RqQDMnYIsmX3UozYd+csUqPT37N3Ly94DDoIAr?=
 =?us-ascii?Q?/NbK3RYTtZSkJGXD4TOXmWPujn0pDc+o2lHgG4dN09sVN5vLKpb87NA0m90t?=
 =?us-ascii?Q?i9epprogk9zEXWyh2h2lXqyFpEQK/4ieAXuQq3ZrZHK62ZFmxyBCxJ2x1V3h?=
 =?us-ascii?Q?aonnqgcRY0Mkauz8omZBwlKaQ2Yqnts8QQiQxT6zB1HkuTGcZvCuxYI5BC6d?=
 =?us-ascii?Q?xcJOCbrPJGUZOEG2fX8ahgWkN4yAWcfrLLfIXngjbY312TlsiXuV9BiG1Slm?=
 =?us-ascii?Q?6QaD1UFjo82TP+nPYgiXw759L/A1+sKbtk5a+4ZUyRQuhBkdOc71//HxJbDw?=
 =?us-ascii?Q?Bll93g4aqb+9LBHFSob0sbxAMkHISO4Rv96NsmtBb3UUTylt5wbNDjuQXqy/?=
 =?us-ascii?Q?WibiYzEhok3N82J01gK2iqv8wf/NxaE6VSN3BFbVA1nzO/R2aV1mOcTD8+e7?=
 =?us-ascii?Q?ZS1GaEFhbTSkiO+0n9xyJ67Rv9SZxPf9mtqaEXL4t78txBJGMxAOalIYJmnx?=
 =?us-ascii?Q?w1e/XGXFXtHr4WUPLev+vreffhPMX6/GIp2xt68wE4x2xftZsVYx2jdCztwR?=
 =?us-ascii?Q?BhuJkLo6Rq8seUkaw5vTC30So+iTfkk8a22lnIvAy4sArAqxQOiOHGRZSLjy?=
 =?us-ascii?Q?4SMmlu3kU6L8blBFPFH/nhC9pT6SRHzxWuZ0JUvxyk0BJtEMW4UiD7aqYy/j?=
 =?us-ascii?Q?d0HVlKNMuAv2Af5aqkSMUZ04nOKI1k9XJAdoJ0VLFqNzUpu7rESA2s0+wSRT?=
 =?us-ascii?Q?V8xn/CGuRhnLL6yOXUFnErAByp3R166/DDMRzG5k11fzrI9/LlHh5h6gcD3Z?=
 =?us-ascii?Q?F8aN8RXKcgghom71KgHEjeVFPBxJChqU1h1/+sCrNw5sqQ2uBqJJAlfu/ulf?=
 =?us-ascii?Q?jbkV7cxdHZC9jwTW8l1OdwalePXJ2logWFm+2LedLbuly6B1syZiAoC3+sB+?=
 =?us-ascii?Q?CaDrg+iLsw5oHYyZ42LrKLY95ALXK6lwWeBn6vm5lZLg7y68TAfc59fs8xT+?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lSXIXS8ixo5ty5sO+y+bhv9lIH4dvqleBOuYIQpfUw6hJRZG8tALwaO7ZXxs?=
 =?us-ascii?Q?Hixif9Aaj/cDoQbJf/R3G9qTLGtGggJ7nGFVfkYxvqU0Z9Eaq0jW+O9xItRT?=
 =?us-ascii?Q?vvmk+AM7EHjITNs7UX8Ll6wxli1F+HBPKzYqhE4akhWJrGWLySVy1M6OBNqK?=
 =?us-ascii?Q?y/CAgYmrVcrKCrFhe3YPcaUjG00vuv214fZENN5e1vepTfG3H02tenNGq0D1?=
 =?us-ascii?Q?I2I+q4CRyg9+K3RZSVqikS+tg2wfrxqj31EO7PwEou/FKhYlQHjnDaTWrfxB?=
 =?us-ascii?Q?P+SIMTMSrp8aEgkGrXuVrYJ3u3m/Hs3VScjHTkZuzhTRrmn97mftuYyeea3M?=
 =?us-ascii?Q?nZVdhp7f2S0Piguvb2ccMbUlXNXxwWCakQs3jnxpN7qpb/mCaXQj4wojSE6f?=
 =?us-ascii?Q?r4q4Jy+gggWiL7txmDSKBwOLGQDF69JkTow0CVVoUrCzeXx71oUYeg9O/BTv?=
 =?us-ascii?Q?YEwGeo3EXmTfv49DWYfq/ogYErkkyZJ2Rql/I6dXtf0AkCrfdbsHLfiVGiZA?=
 =?us-ascii?Q?F8TJpo88klIGDugOq/Mt8o0F3yDmvJDQOLDJJxtS8U/oCxEYJmfi88zajm7H?=
 =?us-ascii?Q?qxFDO3nAkl/luY7vq/TYfng3anCE/HyZSYQm+bb8v8FHY1dZaEkMW3nX8+zc?=
 =?us-ascii?Q?fD1onVb3VJgjJa7XifExsv/M54DcI0E7k1K617BkMzHFXIvJ56AiEpVp2Eyh?=
 =?us-ascii?Q?jV8JCAHco7lhQW8Ci8Y/62C+4KijiBwSLz2acMijiXTvhO83nTnOdvaZpNwz?=
 =?us-ascii?Q?BBeIIai7sxKl4uWc5gR+zOB4ZulNEfYxDUEZToz1oE2QTIFt57I+nqtZTj0I?=
 =?us-ascii?Q?ogwFI6xiCxu0hy4W3iHZaiA8ITGLDe+pyyMT1ohPg+20l5nRCQ037bX94Fr2?=
 =?us-ascii?Q?0QJbJYYEVHaIxuGCzr8vAymJeZz5X69wM3BOlETbYHk4dBBaACFKa3CKdXoV?=
 =?us-ascii?Q?5I1b6Ratxmz3jnk/Su+N1ineYzgyxht0biJ+sS7y+O7QR8uVwB/egcnIqBi7?=
 =?us-ascii?Q?+CWJbU2l0t4DdPNivlRkcO7OmZkP48QhtHevP2OuBrJB+uCWq8/FhLRajwql?=
 =?us-ascii?Q?FwRZovDkkiPqTZl6Vuux0BbhUb7RYXLyqou6SnWDSg+vaieEy+d9+4FPJT6m?=
 =?us-ascii?Q?zIsjq5fHQu4zdCj3LULqmJEyCG8LRXu5NA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b603d6ce-87f9-40c1-2572-08db19e6d645
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 23:52:23.4053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNMagMWUUtxQkZyBrFEUFe9j0xbTeySW3hTmGS0dfaDOzYyf+AwR0LUb0wF5v3sRBbMvOGHT/sf4W2gNnDen8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_18,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280189
X-Proofpoint-GUID: eQfHqx22S-0fGCLztA2Qx7cYqNrx_kWY
X-Proofpoint-ORIG-GUID: eQfHqx22S-0fGCLztA2Qx7cYqNrx_kWY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/23 07:46, James Houghton wrote:
> On Fri, Feb 17, 2023 at 4:29 PM James Houghton <jthoughton@google.com> wrote:
> >
> > Because it is safe to do so, do a full high-granularity page table walk
> > to check if the page is mapped.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> >
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index cfd09f95551b..c0ee69f0418e 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -386,17 +386,24 @@ static void hugetlb_delete_from_page_cache(struct folio *folio)
> >  static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
> >                                 unsigned long addr, struct page *page)
> >  {
> > -       pte_t *ptep, pte;
> > +       pte_t pte;
> > +       struct hugetlb_pte hpte;
> >
> > -       ptep = hugetlb_walk(vma, addr, huge_page_size(hstate_vma(vma)));
> > -       if (!ptep)
> > +       if (hugetlb_full_walk(&hpte, vma, addr))
> >                 return false;
> >
> > -       pte = huge_ptep_get(ptep);
> > +       pte = huge_ptep_get(hpte.ptep);
> >         if (huge_pte_none(pte) || !pte_present(pte))
> >                 return false;
> >
> > -       if (pte_page(pte) == page)
> > +       if (unlikely(!hugetlb_pte_present_leaf(&hpte, pte)))
> > +               /*
> > +                * We raced with someone splitting us, and the only case
> > +                * where this is impossible is when the pte was none.
> > +                */
> > +               return false;
> > +
> > +       if (compound_head(pte_page(pte)) == page)
> >                 return true;
> >
> >         return false;
> > --
> > 2.39.2.637.g21b0678d19-goog
> >
> 
> I think this patch is actually incorrect.
> 
> This function is *supposed* to check if the page is mapped at all in
> this VMA, but really we're only checking if the base address of the
> page is mapped.

The function is/was only checking if the page is mapped at the specific
address.  That is because when walking the interval tree, we know where
it would be mapped and only check there.

I suppose it would still be functionally correct if we checked for the
page being mapped anywhere in the vma.

>                 If we did the 'hugetlb_vma_maybe_maps_page' approach
> that I did previously and returned 'true' if
> !hugetlb_pte_present_leaf(), then this code would be correct again.
> 
> But what I really think this function should do is just call
> page_vma_mapped_walk(). We're sort of reimplementing it here anyway.
> Unless someone disagrees, I'll do this for v3.

Yes, I think page_vma_mapped_walk would provide the same functionality.
I did not consider this when writing hugetlb_vma_maps_page, and
hugetlb_vma_maps_page was pretty simple for the current hugetlb
possibilities.  Things get more complicated with HGM.
-- 
Mike Kravetz
