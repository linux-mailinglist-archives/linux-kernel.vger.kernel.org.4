Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814FC730C07
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbjFOALu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFOALr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:11:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F261FC3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:11:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EKIbgh015424;
        Thu, 15 Jun 2023 00:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Hxu7Kvq78QOpV0OGSDOZ0rjJ4Up+K+3YfRUCV59AvQk=;
 b=NS01AaLNxDrsWB5RZLIn29+xucGj9uuSuSG92bkLfGurrxKOA9Q8zg3wNrh7cjrwNNwc
 blw1r4atbM1QYHXUuX7NMmWK5jZPfd0q79k8BIriia1ORlEY4R0JrYT6rmXRl5F/e4re
 ND4fbcc9x1nc8fIhYXCQVhLE6lKChdv+waLDMULvxcB5nMp+eCwzieJK8NVolqW4DVBO
 9b1S499Guap2wpCbdU1BWHs1Zkygt0A8l7egM2eBYTiZz7h9R7g0sB7wPklJ4UWGSLPc
 fn47Faj3ij+wogw2aJhwr2VdZlMkKt64mcthyz+PcV3MFamaZyZudXOSQUzeQ291UNej MQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2arrq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 00:11:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35EM1SgH008284;
        Thu, 15 Jun 2023 00:11:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmchd2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 00:11:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfr8XBt/OTu8Zvm3ECtA6AsiZ8INaVa9Gm4FuwAGKZdGVlejOMeYzPnnN6tBUtujuV+iDb1DrYV2z1oHpxlXyYiY2HTGaXRkjEdK9bLhjrRf7Fqov+ONI4/g/l334rxhf5e0cdvgYI8+JR0EdtGZQfe1i1vT+XHaN1uwj+slZ3qYv8LAls+APoU/IdBzVcykevWYx3Mn5VvOuNwyXSbqZbVBTQGipPuTKaqOirgNVjdPrAPRvmqWcZrhSHIITrjDQ5SiQKvqcxvIXhga/A4uwC/CEjsTuci7oCSkPh2uYafNhv576bb4GUdb32SFV3NDJao7UVCrpYALsiCoBTqfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hxu7Kvq78QOpV0OGSDOZ0rjJ4Up+K+3YfRUCV59AvQk=;
 b=YzZKmltS+crR9C3o43yd9UOtnv6loR3CUE3G3pRiG/kpNwtuQnoYyArtjNcWMZa9LyWUtkK+U9swzCqupixWpllv9c8Ul0LtI17vk35rgxl3AccStW1Y72at/mrhcUQdAwhiCQAtxEq6hZO2j0HQsfAGix8d2/0piyWvYa3UZzaroS87pxvSb1gE6KkIhV3/Ny7HjCz/kvGk9PCy7zxerB/SRuNNRL3phg4ixMM028LD4gFnyFtR4GYfcnXCG4fR5OhMF4Fol21+tscSfgqAZeoSV5n4iHnSTd4Z0L7i8JVzctxdDRObW5KXcm7DvGH3Qo9y08P8Dhah724oHGWdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hxu7Kvq78QOpV0OGSDOZ0rjJ4Up+K+3YfRUCV59AvQk=;
 b=DOOHbH/s4+Wrrv+Lycl3EYw3MBlTkhmvCkGzqQCM+YaEnDDU/dKd/quMjxofoHh9c1vav0rCsEljHFD8v4fVTKw9BcSTNwD+HCbjmFpVDae8A7p2Y8jLyqEFbDif2LXEGPKyirkMZw2Mqx6RlNKEc16JZ63heXK8Wsrar9MhFVs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5207.namprd10.prod.outlook.com (2603:10b6:408:12c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 00:11:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 00:11:17 +0000
Date:   Wed, 14 Jun 2023 17:11:13 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 2/7] mm/hugetlb: Fix hugetlb_follow_page_mask() on
 permission checks
Message-ID: <20230615001113.GB38211@monkey>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-3-peterx@redhat.com>
 <24bc512a-b5c2-b7ea-fa83-5752cec7455b@redhat.com>
 <ZIng1SQ0xZ+eBua8@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIng1SQ0xZ+eBua8@x1n>
X-ClientProxiedBy: MW4PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:303:b4::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 4237782b-45af-4ffa-b2af-08db6d350a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NeWkekWgGPCQcULgnMRUHzVGqMhcytYlGJ0S0F+jjb3WUXTtnVt/qtiAaL0zYs+4dcJHlNZ6JddMAS2kgiqsvLTgZCT3xBV/1L1xBXtEn71kIhuEqcM1ZOT4nFseXPQGt7cgoblE5EBmEs5UlMDBZspAwMHMct3g97Pb1AFmC+N35VCLJf1uBUt62vcMoo0bdAyZ4Ca4kB6BV4X8gueIYwML6a4yDCxt93RJ7JGBsRZSw22vn9tbaWdKFivcgMIKcwvq8MKAMmijSPwOYPB0oRm2lefcfoO1MuFisMNoIDOvK/JGngMVgF4kZl0prlYsok2zomihfDDmdLteEKwZIgeaP9rRSqRwgo/ohk7l/SKf0LoWk88J5arxhPQu6lSvkiWQqNDSfsxMZucyZ3RdcPJdiPw0HcaLuEzu9A1kcZIF9LvQn2kBhR+dgau6FzZW1Rs5lJ1y6C/MX7a9OP37UcOZpyXViM/GA9f7NDJV5CByc/sXDvMwM2N0J5R6kKSlVvczESt3VoGo4wpdwK1MN9Ik0mUpxL6KJzd0SnRj0sfF/O9FuxrKVmH2C5uxP4C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(54906003)(8676002)(41300700001)(86362001)(6666004)(8936002)(33716001)(6486002)(66556008)(6916009)(66946007)(66476007)(316002)(33656002)(4326008)(478600001)(26005)(6512007)(44832011)(7416002)(9686003)(5660300002)(6506007)(83380400001)(1076003)(53546011)(186003)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?csMxFkrmrHDAmZZdSdaFB4XOqBeSceasoHBQm04t/YLzPPfwQJBWhkqQjcM9?=
 =?us-ascii?Q?N82lcryQf26PHQ8VGJpnBWCw6sA8UF4sN/083mHoTeMLdGuTUIxiJPo1Ft6V?=
 =?us-ascii?Q?toGDsRNbJlv8oy5fvzj6o8kaBH0TNRHmKDhMII/u0dpgCCamqeyAAoQz0jJ7?=
 =?us-ascii?Q?v7y0MBIm2YFoTEJQNDc67QVD1Zsu6wCvcRxADxDscsmdatUZVsiJ0ekk2TNZ?=
 =?us-ascii?Q?4J2wiqq/edTrnLH3KPLsFNfhqfbLKegztk/PMn+mSYM23/d/E4Zt3DXkqEBS?=
 =?us-ascii?Q?jJIq+x0gvUi4pvUfpCg613bsJhJnh2GJttYkEKg1eh+opFKE8QR/lA2xcAR9?=
 =?us-ascii?Q?6biQqhasvyXiyAvpJZJL8Ist7ggJ/nG9a0mwRif6BaIXfC5r2L8QGbNrXUcI?=
 =?us-ascii?Q?H52qJBIgwdDNnRTNWJrEHJ/xtuJSBG8f5eJFb+Ot4wKHQMjp4BIoDotYDlTo?=
 =?us-ascii?Q?oSss0xw4fbC+eRUu9ThJt/3a9jmPOOXyGgk032h65gP2z94Aa6SY85lLI/3A?=
 =?us-ascii?Q?xZmfjXSQ8GA3/tBZyIfQnUlmDGrtG7JAf2cgTJkPi3K4eeOh8h3qYxJI0sBh?=
 =?us-ascii?Q?iqU/tgg/mpiDNBo+i9+1tI82wkUaAJ7koh79nfamp9Aj2lSCkV7NZUs9ktmO?=
 =?us-ascii?Q?4B7hTxhNrwG/VbD8m3mUeXZ+aXSf2lcAYPk1aWDBII7kj8rdK6tEeyZn5o0y?=
 =?us-ascii?Q?WeyTs90/5mmwMfLiTyhydoqE/mhcTq7qyqbvrAMdEKF/b1Pj0rUVcM59wSAR?=
 =?us-ascii?Q?N7kSTWd254cO+QEjdz2go/mnZJEoDogqhDBhEXzoP30/meK/au8LZYBZGCdM?=
 =?us-ascii?Q?hRv+c/A1Njx+BdaFDBeUioHvD8QTDgNB8NRPm1C+/tcnsHyUinwaPajM5Y6I?=
 =?us-ascii?Q?H3XArtETJPDYiXgqkE3Fqk4twOPwhUEc6Us4NYCz7Ql4VLzExo/s+HCuGu6l?=
 =?us-ascii?Q?6L8vGplhJpe+DrE7+271GPbCS/L2wjT2RajQ/9XKitzd7Kf7RRU4Y08DzJNa?=
 =?us-ascii?Q?nr//rnkVcgpbQ2L0nSJmzZsN9YuEzYlc7vqNptosRJEiOaWrTyEwzP1ChjNT?=
 =?us-ascii?Q?ZqUsPsv6pZy8a9z85/5bE0XodH7kvbjeHRQxpP53uqfbITFmnu2LHhBIfhfQ?=
 =?us-ascii?Q?P8Uwc0Jl2Rdw9slFUFzWfntQU7Xg0NSOWD5/Q+Ft3wU5lQWaa98OPIzrIPm5?=
 =?us-ascii?Q?3nwOkWuud/6sxymdoGT9pCYwwFAe/IgT9QUFzw8wmktRn4sQrtTx8qRxpWmU?=
 =?us-ascii?Q?wKDtt8F2WevLIcgmAEajQpuRszzOXp81vTHjLBRBBFCF3Hve8a3f7KUPHueP?=
 =?us-ascii?Q?icE2diZ4MVWwg4I1vmu9OVpuEcVDP2sQnkC69GN/t0PO1T95jtKq18ntJmBe?=
 =?us-ascii?Q?RS5nZWYw8HQ0eFnCHs0tdpSGbdo4Wt2MXWmCHIepgFBNCmdae8t7x1Ms+hHm?=
 =?us-ascii?Q?iwmzWOeNnXkNLxWP2n4HsxUVhgf9O0Z8rFk2bNR0D1gDTlQqLdNatVSL3Z29?=
 =?us-ascii?Q?2doZPt8DxcL/zpXzA49ERz5lrAVEDGTBeQgVRNg86Q2D/CaMS6rnzDR45XRd?=
 =?us-ascii?Q?HoUZ4ZyApz3kPxYnoa2bqOY43C6uvwoIXCxBmkz67/enzzgXjtQl8KxsFt1T?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Hl6/ck/Bx1qi4x0GLQvsqzhO25/SwN7k6cTD/rbTnqT/R6yWWHv/2TTqz4lD?=
 =?us-ascii?Q?YVsF6qYkCkrVQ9bas0QDYrOKalsqw/l5RLRtbk5qdmFtbDcsy7dBLtFGKRdj?=
 =?us-ascii?Q?YvDlNGaz5L6lkVqZW9lHxQ/2IY2QMsE+zUriYjSe0B07KZNIzE+cZuA4dekv?=
 =?us-ascii?Q?IySgkQoC+Kjimrqz5RfjuPyjnQN5eBD10sIiVEgtJkFhI4Mm/rSsMNWKw+af?=
 =?us-ascii?Q?6Mi3fFFkhVISGqNd9PbDxK967JgOnZVvdQXTAXOOSqE9K44R+qNQyGMDpy97?=
 =?us-ascii?Q?5On6vEdKRJWb616tj+IT2sB7RFtoTc6X9vVrzObLBkvYEbBK0Ey3wjlksNQh?=
 =?us-ascii?Q?aucWT09OlVZ0TsO0Z4/evkwNwDKbw7kURl5haTn5cdknT/DyCZEReSXG4G3f?=
 =?us-ascii?Q?FN+pTpc2E3ZT7g7eiTYcGWoa/klfkuSfGhlkqZt0bXohucBW9fIFZ/tJZ905?=
 =?us-ascii?Q?Gd/n/Y/Joy+RE6cB/ub8oNnUiH40vu8+vV/bRLW3VdU1qV/eIbLcmQbYE2Cp?=
 =?us-ascii?Q?gz7i5HEeOHlse8CRxJA4dROvBd/ABsljH5Z3G0H6opZ2hUVZE5SDjkK0h0Wf?=
 =?us-ascii?Q?u5fRQo9SYINlI7dMzCOLVAs2xUOSO+jLAhtrOYDrp5Mfx2BV1aCp7ZV2cF0W?=
 =?us-ascii?Q?tlB4rDVFFWTZnwzz/fBTMZn9tHWS28KExjziQN4sg1fMMMD0inTlVQYjtWIA?=
 =?us-ascii?Q?A7LwsrXETHnNqUC6ptsgl/cCHJE2FYkU2mkSwgdwGWgZ2bKgewEm0ARXOZVs?=
 =?us-ascii?Q?jcU3maWW3RjHENT+hnaAw8UExLvg4SRqq9BLNlRsFoZFHafq1tTi1GrmyOMy?=
 =?us-ascii?Q?1rItEcT+B7XBtwUvlFg7wIab7IT9AvsAbF4fhndtgknBVNcYKlYWVON76AHb?=
 =?us-ascii?Q?tDXhO5MdE8fa+rzCuCgrnFp79ku1/59mOyycYuRB84IsIXzf3UTfN5uFGZsZ?=
 =?us-ascii?Q?fzHwCCbzw22q0uzp0hHzJuxu0IdUYjdsl50UmIcAQwKTcLxBuc6DvdABYcl4?=
 =?us-ascii?Q?c5Cjes+T5wsn9WWHibMB5fiyILjBPXmNo6LuZ2Q4SUz8SE3bSEiq6PtZLcp/?=
 =?us-ascii?Q?uR7JP6x2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4237782b-45af-4ffa-b2af-08db6d350a2a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 00:11:17.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KG8oEFcNlfsAGZfSz91oUbioGRdszN+fygWGC1xCmxRJETtbrbgATNABJcXG60uCyExh7ID66/5m89+VsIGX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140212
X-Proofpoint-ORIG-GUID: b1ZZ0Mw5es9uMnlJbz942bNduwA3yuJ2
X-Proofpoint-GUID: b1ZZ0Mw5es9uMnlJbz942bNduwA3yuJ2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/23 11:46, Peter Xu wrote:
> On Wed, Jun 14, 2023 at 05:31:36PM +0200, David Hildenbrand wrote:
> > On 13.06.23 23:53, Peter Xu wrote:
> 
> Then I assume no fixes /backport needed at all (which is what this patch
> already does).  It's purely to be prepared only.  I'll mention that in the
> new version.

Code looks fine to me.  Feel free to add,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> > > 
> > > When at it, switching the try_grab_page() to use WARN_ON_ONCE(), to be
> > > clear that it just should never fail.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >   mm/hugetlb.c | 22 ++++++++++++++++------
> > >   1 file changed, 16 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 82dfdd96db4c..9c261921b2cf 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -6481,8 +6481,21 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> > >   	ptl = huge_pte_lock(h, mm, pte);
> > >   	entry = huge_ptep_get(pte);
> > >   	if (pte_present(entry)) {
> > > -		page = pte_page(entry) +
> > > -				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> > > +		page = pte_page(entry);
> > > +
> > > +		if (gup_must_unshare(vma, flags, page)) {
> > > +			/* Tell the caller to do Copy-On-Read */
> > > +			page = ERR_PTR(-EMLINK);
> > > +			goto out;
> > > +		}
> > > +
> > > +		if ((flags & FOLL_WRITE) && !pte_write(entry)) {
> > > +			page = NULL;
> > > +			goto out;
> > > +		}
> > > +
> > > +		page += ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> > > +
> > >   		/*
> > >   		 * Note that page may be a sub-page, and with vmemmap
> > >   		 * optimizations the page struct may be read only.
> > > @@ -6492,10 +6505,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> > >   		 * try_grab_page() should always be able to get the page here,
> > >   		 * because we hold the ptl lock and have verified pte_present().
> > >   		 */
> > > -		if (try_grab_page(page, flags)) {
> > > -			page = NULL;
> > > -			goto out;
> > > -		}
> > > +		WARN_ON_ONCE(try_grab_page(page, flags));
> > >   	}
> > >   out:
> > >   	spin_unlock(ptl);
