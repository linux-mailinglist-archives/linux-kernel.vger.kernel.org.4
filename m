Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECAF5BA0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIOSeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIOSd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:33:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492A774DDE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:33:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FHxRZp007069;
        Thu, 15 Sep 2022 18:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=RtNchCuyjDF/TyI/TR43QRH+jlOaiEF1LhcDFGm/lkA=;
 b=Wu43zlZgXo6zimWiXxgbBpHh4uzmbkT1WgKt2nljn2RTJp0jo01ExA4vTzwQXLrVkrW/
 nrU5Jvko2IcBql5CaVK5w2SR1uVQdG7Fu18u3qAHW7gCc2IZrnhrge/9FZV0ChEyKLeW
 IrM9Zdh+9hHkkLgjoxbl/lHkhZb34Sv0Y0q71W+5zUIs7aWyplIpIc/JgTPEubQT2IXz
 +8Npb3htUpX91y6T7a8YeJ3HW3Om6LQvvQtkdriVk+F2faWLkNKFbrqd3qfdV6Va02+g
 kSgIIrgkDPPy6i2E/haw4UXOG6LPEOPO/qKMOZz2uNFTQsELeWmpG4Je22I73Rf1Oin3 Xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xbr3mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 18:33:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FHxXoq004166;
        Thu, 15 Sep 2022 18:33:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8xe9jhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 18:33:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obRx7//RnRPmCUWciy0XnQLkHEThmO/+pD4nGBEdVKhusGFq+HoKI6w3tE8iud8N3F53tqdqCXl0+nCtN50K+KsiLbtzlqznThC0Q272hYZ3Zj1U01Q12nWYJr7+8orQeYytxBwc4A8YDpFJv6HXNWp3m9vibn2PwGb0H/Lg+/BybVbBXNDY4tLWJzUQDue5fxpQFIXA8z1TpsOKeJXPOlrRPc2QfYE895NeudDkx+8uXhhD7tBdfA0FIGUdk4oC3Nyq/8SCpH95tQDD/SBDGcl88ssOkBjRFZG36abR3hTSzGyPuCnkLTHCwVj23sLYiUGOBnlBCJtqzfWwrNRqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtNchCuyjDF/TyI/TR43QRH+jlOaiEF1LhcDFGm/lkA=;
 b=JfwrhJ8uiy5H6SWirmFff0/+TbFiuIq50crf2XAGZrhDWWUbyDZbNDjJ7C9hpnPurHNxLgKnbdOfrF+NA4G49eq7yUe41TLHbkLlAFPWgKgTli7tkdLDUtRu8YGkb7JQ+FCwVAWjv9UZK+aus2vOdO0cFx6wOhlRwdi8Y4UhEUWnP2WRr1jCZoVfwqGkJ4LWLQQOEwFgzyN+HdhdCXQgxSyD/w/gUOLL4/BepXGXgJA2lBlR9f8oKOFthBlPIBjyqQJL7o3HQJE6K8hrqiB2EJDCwBqmV5tTMpBaNuADsBbs1NxTr6TUUc/CKIABTzKERyXN57E1EAsTBycChX2UxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtNchCuyjDF/TyI/TR43QRH+jlOaiEF1LhcDFGm/lkA=;
 b=aNdKwuxTB+ZvfnjdMVnGw1OfB36054unF0Z7UMM8hA3JQfIuUSnUvvbjV1qZT2dCh1eW5UCVjBcFe8mowo0RV1NldtxrGhEIA//pNxTxiLOiy20FHWb1QXoS2R4iuuJFBNW2Xh3b/J2R9ESguBErfiJTp5+kWAxJBcviWGvAvRQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM8PR10MB5399.namprd10.prod.outlook.com (2603:10b6:8:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 18:33:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 18:33:12 +0000
Date:   Thu, 15 Sep 2022 11:33:10 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Muchun Song <muchun.song@linux.dev>, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: freeze allocated pages before creating hugetlb
 pages
Message-ID: <YyNv5lhdQJKNLrfr@monkey>
References: <20220808212836.111749-1-mike.kravetz@oracle.com>
 <A74A816B-2EDD-411D-86F7-E7D5B507FAEE@linux.dev>
 <YvQzeUUvBVUYh8cn@monkey>
 <0097C4FB-89B3-4CF5-9F61-D017CFE566BB@linux.dev>
 <28e70b23-daec-d94f-9baf-d99052f8f8a4@oracle.com>
 <Ywf4Kx0isZai48As@monkey>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ywf4Kx0isZai48As@monkey>
X-ClientProxiedBy: MW4PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:303:8f::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM8PR10MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec2bd54-41c3-4be8-8b6b-08da9748bf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izzqve62wnQKVRjjwsLFgWncrgmyWTC+xbcv/KRCZVBI9j/GCA7Sp17+dHft5f7og4KrsKyIv5b+nZyT++BZJz+X+eWaY/8R74vLp5mDAEpBcP10+ROnBnJ+YBhSnA3NF4Y72mp47K4ssnvWkRtmuubrNzOjzUiWcdmzTehplBXZcP8V2GzaKil6UWXVQ6mAkoDVIr68k1uj4XX46XyDqK1pyrp5nLqEqsPbwSMYyve5pg0WyMvPo7x9Dcd983TGFza0Qb8yn0MUDjYfY7k/+PuaoYw8CRpOF9J2OxEgQ8K+eXuYIXXchlaCMQEGUk171defmV5orBol8Y2pa6ULOA5gpwhk7h6VjMveesX4APAJpkI2WkIwSepglR0QQlD23iHdsm8rZGKvpDh8mbYbI5/qruTPMH2fz9xr5EYnnR6va/I5K6N/ge9DDGrANudD5DjRyA0lvan07AO6JDYBSzn9AMEOHLeVe7KPsNszimCPr1NvRgY7YK7+pYfKjQ6/tcPWkNFCqFG7PL4cKJXYtLRywf7dDp5jaZ7NvBEej/nvDnUhPZ0+QXHJPQ+kXmZmS94CWCzoGIjojwUeR3mzy80lMFjmLtNRJe+X10DWfxaBsCByhpTAfTm/RZ6Ed058Z2NOrFUFV3GqLH2qd46h1tsJmow00qOBjN2lXvNJ/aUp2mPLTcnsuZV7Aw+IBP3OPTRB58iXvLXIZD7KFypyZf+pVwKk+ZQkADdMHc4FNLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199015)(44832011)(8676002)(66556008)(66946007)(66476007)(4326008)(6862004)(2906002)(6506007)(5660300002)(6512007)(86362001)(8936002)(53546011)(33716001)(9686003)(26005)(38100700002)(186003)(41300700001)(83380400001)(966005)(478600001)(6636002)(54906003)(66899012)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azlxMHgwMVRHRk1BdWpJd2IxR1JFaE16TXgybDNNQnhDdDZla0ExM2w3cnFY?=
 =?utf-8?B?b0dXejlNOElDNmo2UGV2bW5Canpra0FoL1QwZjFYNjBxakpXOWF3VkJNQndR?=
 =?utf-8?B?TnM2U0hrdnJMWTFZV3J3RmxpZG9FSHFIcVpTT3AvQUlsR0lJVUc4OWM0T1BT?=
 =?utf-8?B?UHR3T2xnVWJlZzI3aVNNWEFZRDVUMmRmV0NqeGUreTFwaFFhMEExL0UxaUJY?=
 =?utf-8?B?dklqbU9VTEJLVFQ3Ni80bGdzbnRORC9hVmN2VWk2b1haZVZNNWVDclJldERi?=
 =?utf-8?B?Q2Y4Y1dNVG1IUVExdXVOL3liWCtKK2U2Y0JaNzBVajdQTXA2d1BTZE40cEEv?=
 =?utf-8?B?T0JyUVA1a2dGT3NkMHFqSWxaSk5Sa3ZoVm45V3ZST3B0ZHJyNmZ6a2RGWVls?=
 =?utf-8?B?SDFvcEtqcFRuQmZuSFpUVTh1S2N3ZUE0cnpsRSt0YnVqMjhQU2tyRlFYam1T?=
 =?utf-8?B?NFRpOUhHN2VpTXU2Q21nRVhUcjgwR2I4L1dpeEllTThZOHpFTktOQkpTRzFU?=
 =?utf-8?B?SzV6akJmUVpuOW15QWgwY2NlZit5OGJVclNLcHErYXdwazV6aFE0U1VzTXdV?=
 =?utf-8?B?Z29hczQ3ZDVrOHFlN1hIM2FCTEdGaXZHUHYrK0Z1QlJCWSswSGdXY2RNZXlI?=
 =?utf-8?B?TExMdVNsNEZWZStNdStUUDhMdjhscGtGSzZHVTMvZysrVjBEY21JQ0c4RFd2?=
 =?utf-8?B?K0htbFcvY29KN1VuUkkvZlBCWUVrbThKYzg5TWNwbjdaSlp3ZjdiT3RkWWgw?=
 =?utf-8?B?bnlSSFZjZ1pFM2JNSnVoUVk5RTRhL2trekZ3Yyt0anlzWWJGa2J4TXBzdFZ2?=
 =?utf-8?B?bzdCMWhaRFJYQnlCNng4VlRST2VrZWN4eEZCSWRxdFlUdE0xUUxzenprRS9G?=
 =?utf-8?B?NnVtdU5nM0pUOTltUy9JaENUSllpdWhTdUZJNFZMT3B5MVBOVzU2YTNobDRQ?=
 =?utf-8?B?QTYyaTJIdzdlMGdDcTZaNm9JNDJxYTdBbjZxcW1kOUo3U0h2YnlnMDZkTEp2?=
 =?utf-8?B?RHZkLytOa3VXTGVhWERDTU04aHBOa1NwdTVWVlM3cVpncm9XKzlHNjNVUjkz?=
 =?utf-8?B?NGZwTlNQLzdGa0JGUFZaK1hRZVBnYUhGeStEWXFHTlA1WE5TSFFqM1hYZ09T?=
 =?utf-8?B?N1M3Tk9lN3lLZUxxdkgvbjZhWHVyTUZiMjVpRHV4YlJKK2dlMjVsNFVua0Jw?=
 =?utf-8?B?WlVjM2NHcVJxWlBudkhzb21uQlVUNzlvamhIVUNJSkdkQ0d5dUZnVmcxdW93?=
 =?utf-8?B?L05qZUFCZkppOWVkanl4VWVRQWFBaXg4Q1JCZEJZWm1vUmg2VnlMaDh6MnB4?=
 =?utf-8?B?OU15SWJLbE1nU0UxY1l3elkwVys3T3VOZS82WGFJeFdIUmxtelhhK2RZMXNW?=
 =?utf-8?B?KysxYmhyRHJtK0Jhcm9yekRXZXorWlBBSjE1SGZsd1gwY3VPdktYRzB3NS9S?=
 =?utf-8?B?R3A0ckNQR2V4WHMyd0t1WXRxMHBsMXBBWnFHQURuQTZkV2w3NTVFUWV2VEk2?=
 =?utf-8?B?NTN2WExLVGVjbzZXNWgvWGdzVlFzRENpQ1pBUlhjd0VXZFhMTE51aGd1ZU5G?=
 =?utf-8?B?VEFoenhwT2NCd3lhQlBMM0prZ0kyMU1ib1g2a04vblBtaGdEWFJGaVljdUp6?=
 =?utf-8?B?cjRyaS9BTmVoQVV2RmxieENoWnAxYkJLMm85ekM1YlovaUQrcDBqTWdRWUM0?=
 =?utf-8?B?TjBtUDdxYy8zakFzUWk2QnZJVG92VDBQOGtnSEwxY2tVRWZIMGI3UTBLM3RS?=
 =?utf-8?B?K3dDUHdsbm5aeXRVN2pMK3hQR0QyMk4vVGU1RGVJNFFWVDlGRmJNR1lWZUtE?=
 =?utf-8?B?ZkFEQXJNL1NFeWlONkRIRzA5VDF1MElVbUhFbDdsYzFaQlA4RGNQbUNkai9M?=
 =?utf-8?B?ZEREVGJLOEpId2piNFNwdGxoaHFldjY2YzlEVjFGeHJCSFNRWnBnUldCaWFM?=
 =?utf-8?B?dkd0T05nanE3aitCcDc2NGJPdkpoT2wwN29TbDI1alB5MHFyMUI2YUNNQmxF?=
 =?utf-8?B?NURqbmpEYjdqQ0xwTGxndnovckRuUnhjOWRZTTFjNklLeTluTFR6b2l1K01G?=
 =?utf-8?B?NEdSMVZiNG5FV3B3NjFoY1paZFJTL0tVYjNuSndjbGJhZ2tpNy9tU2M0Q3pG?=
 =?utf-8?B?VkUyZWs5RkQ2RzU4YkFmNkR6WXFOWnQ4QzYxVFBFNVR6SXlPUWN4cUQ5VEM4?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec2bd54-41c3-4be8-8b6b-08da9748bf14
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 18:33:12.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paHXo0CHz/uHqxmeQ4f3v6BjyJIAIuxkOZMFtAemCzAptUJLogayuAIbLwR2N915Z0MNJrNHU+VlW8MJWxlGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209150112
X-Proofpoint-GUID: HQBnM1ZVvnLVaUTZBeaPIjqkyZ3ffNrm
X-Proofpoint-ORIG-GUID: HQBnM1ZVvnLVaUTZBeaPIjqkyZ3ffNrm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/22 15:31, Mike Kravetz wrote:
> On 08/25/22 15:35, Joao Martins wrote:
> > On 8/12/22 06:36, Muchun Song wrote:
> > >> On Aug 11, 2022, at 06:38, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > >> On 08/10/22 14:20, Muchun Song wrote:
> > >>>> On Aug 9, 2022, at 05:28, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> <snip>
> > >>>> There have been proposals to change at least the buddy allocator to
> > >>>> return frozen pages as described at [3].  If such a change is made, it
> > >>>> can be employed by the hugetlb code.  However, as mentioned above
> > >>>> hugetlb uses several low level allocators so each would need to be
> > >>>> modified to return frozen pages.  For now, we can manually freeze the
> > >>>> returned pages.  This is done in two places:
> > >>>> 1) alloc_buddy_huge_page, only the returned head page is ref counted.
> > >>>>  We freeze the head page, retrying once in the VERY rare case where
> > >>>>  there may be an inflated ref count.
> > >>>> 2) prep_compound_gigantic_page, for gigantic pages the current code
> > >>>>  freezes all pages except the head page.  New code will simply freeze
> > >>>>  the head page as well.
> <snip>
> > >>>> 	/*
> > >>>> 	 * By default we always try hard to allocate the page with
> > >>>> @@ -1933,7 +1934,21 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
> > >>>> 		gfp_mask |= __GFP_RETRY_MAYFAIL;
> > >>>> 	if (nid == NUMA_NO_NODE)
> > >>>> 		nid = numa_mem_id();
> > >>>> +retry:
> > >>>> 	page = __alloc_pages(gfp_mask, order, nid, nmask);
> > >>>> +
> > >>>> +	/* Freeze head page */
> > >>>> +	if (!page_ref_freeze(page, 1)) {
> > >>>
> > >>> Hi Mike,
> > >>>
> > >>> I saw Mattew has introduced a new helper alloc_frozen_pages() in thread [1] to allocate a
> > >>> frozen page. Then we do not need to handle an unexpected refcount case, which
> > >>> should be easy. Is there any consideration why we do not choose alloc_frozen_pages()?
> > >>
> > >> I asked Matthew about these efforts before creating this patch.  At the
> > >> time, there were issues with the first version of his patch series and
> > >> he wasn't sure when he would get around to looking into those issues.
> > >>
> > >> I then decided to proceed with manually freezing pages after allocation.
> > >> The thought was that alloc_frozen_pages() could be added when it became
> > >> available.  The 'downstream changes' to deal with pages that have zero
> > >> ref count should remain the same.  IMO, these downstream changes are the
> > >> more important parts of this patch.
> > >>
> > >> Shortly after sending this patch, Matthew took another look at his
> > >> series and discovered the source of issues.  He then sent this v2
> > >> series.  Matthew will correct me if this is not accurate.
> > > 
> > > Thanks Mike, it is really clear to me.
> > > 
> > >>
> > >>>
> > >>> [1] https://lore.kernel.org/linux-mm/20220809171854.3725722-15-willy@infradead.org/T/#u
> > >>>
> > >>
> > >> I am happy to wait until Matthew's series moves forward, and then use
> > >> the new interface.
> > > 
> > > I agree. Let’s wait together.
> > 
> > Maybe this is a bit of bad suggestion, but considering that the enterity of kernels
> > supporting hugetlb vmemmap optimization are using the old interface (the new one isn't yet
> > settled it seems?) would it be better to go with something this patch, and then have a
> > second patch (simpler one) that just switches to the new interface?
> > 
> 
> My thoughts.
> Right now, the earliest any of this code would be merged is in 6.1.  If
> the alloc_frozen_pages interface gors into 6.1, then it would make sense
> to just make this patch/change use it.  If not, we can manually freeze as
> done here, and switch when alloc_frozen_pages becomes available.  In either
> case, this could/should go into 6.1.
> 
> We still have a bit of time to see if alloc_frozen_pages will make 6.1.
> Ideally, we would wait and see.  Ideally, I (we) would help with Matthew's
> series.  However, I am a bit concerned that we may forget about pushing this
> forward and miss the window.  And, since Joao's optimization depends on this,
> that would miss the window as well.
> 
> Matthew, any thoughts on the likelihood of alloc_frozen_pages going into 6.1?

Unless someone objects, my plan is to send an updated verstion of this
patch (fixing __prep_compound_gigantic_page issue, thanks Miaohe!).  We
can then switch to using alloc_frozen_pages when it becomes available.

With this patch in place, Joao should be able to send an updated version of
the patch "mm/hugetlb_vmemmap: remap head page to newly allocated page".
-- 
Mike Kravetz
