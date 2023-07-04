Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4593B747871
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjGDSsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGDSsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:48:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B079DE64
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 11:48:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364HDxFX029016;
        Tue, 4 Jul 2023 18:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2023-03-30; bh=5AXVwZIURs1vDCC7VOeiSVo/2KLaRlaQZ8rDb2+zEeg=;
 b=UdZ7VUSzKFVy1Zcz4NzOfQFWVcEKoapMrl493MGCMs1qDNWFQp5fMciHA3vECoT/6MDg
 ZePFTGbcuJ9huoLd8ha41MwkNk8YRyEeX/erDpGpOvWw5AeBQl6JlfWAU4YCiiMKfKuz
 pMM61IGLbDY9BVnfPaC62Pqe4c3RauO1WVIzOc2WZtwlpM3C5BsdRJEQYVkOHCLuOI4T
 enALwj+RXwQgp4RPsQrIIr6gGOJwJQFfTqLDJIxYDki0T7rrod2wM+zt1d+UKMo4/yM/
 7iDmMEsnbpfq5dcS/RXUoZNknpoRcXRJMMX9pEzPoCBL1mJd9BCJ3MhPetKyB00bvGRt WA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpucy8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 18:48:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 364Iic0x009029;
        Tue, 4 Jul 2023 18:48:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakap5hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 18:48:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwOhYx9o3MheJqLaS52+d9p5DuZ4dPTYVDFj4QbyzGkCj8slQ1ISFliPuzoK1RcvDST1N50KFNsvQNKmIV2U7Be4vIcGfgd8R3zIY2TBqhU+avP2MKcjqGix15G2EIbCcFHDo6XLJiiMKS2VHK1QvM4tEZkPdcln6fpMsiXv+EDpIT6ztOAjGTPAXaRqId0XfkYudgUmp/+zQghoA12h5dQWan046PzB2/AhOiva4eVeti2IE9l+NKzqXQVesLKwIhUbRU2QHjhM5YcWCct0x6g/DsErKRCZ3sXO8Kwsz/M6H3iduL4/nTqMSgfQh0SA9y7YdzXNGCgXu5SOOYXZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AXVwZIURs1vDCC7VOeiSVo/2KLaRlaQZ8rDb2+zEeg=;
 b=bAN7m3/lIGY299qhKt5TJgCEI7D9NbzOOKT973sLLBmFQluCBvUOpzJk9+zAbq7i6WM9jb5sx9pbML/mlloyUBGam1hpWjgwKHL8J2eqzD33K1kmwiiW6bE/ln2nAEVWVfFej87HOCkJmaWZdJw+jNTI0uCrPfdZPtzJGlVzktN+vEkWegqjqaTMvo2F8KuocBcrqvXjm2a1hZ8f2gDvQObJeHbRDrI1N02La42A1GgDVnhOK0xtCLuiUpLDtyxaRvPgv0ZrFXtKtaZqYWq5NOlaJq5GqDWXGLJOtfPu+JG1PrayeNqsTAmUDtR5p91AAF10qHZ/EdpsIfaJ//BISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AXVwZIURs1vDCC7VOeiSVo/2KLaRlaQZ8rDb2+zEeg=;
 b=Sbcku1ZF5GApLVRhKgEH+M6V6+mSOA931eMqjhtUzKlH5qpsPKEjFE8V1sHS9MoNA1abi5X94FccnYlaK2/MF2hIKi4XHS3kkBa1dnefK5SehFmBvrQGD7Ac5CXpXxrnmkYrr7tm0PkuhhYGD48uAvxuiJVAWCuDEfNGvEj6mCg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 4 Jul
 2023 18:47:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 18:47:54 +0000
Date:   Tue, 4 Jul 2023 14:47:52 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Sang <oliver.sang@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH] mm/mmap: Clean up validate_mm() calls
Message-ID: <20230704184752.6lwrytfirr4huu34@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Sang <oliver.sang@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjUp5+tcsHG89ieuwa0wUtSWWBWRt8xOsoZ1nskZbbk-g@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BL0PR02CA0134.namprd02.prod.outlook.com
 (2603:10b6:208:35::39) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 420633ce-4bd1-45b8-a9a1-08db7cbf2d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ExqkUKk6sseu8gJba/FtLxCnHtl+6PJ8ngic1HGY0e0sl0/qq3Lxfn/2V9WKSjeltyLGQzzhhkxvK6rqRCf5D+P2hfeqHzbj50Kq2k7GvZKN6FFVRwu59Zc+TZFwdK8UPNQfPe9hQhGcONCrUhFhpgIge7c7ZzUigdcvNj5fij9k5azcJAR9DZmHayD9uAY9oxbpqOb3HbK2Kq17jjpABGiVOk/R+KhkSDNJWYUQvPzDwMopLH+ysSFbHgCe7tlSq/xAyNzOIEg7y1H4RJwUbRMSM32MgFS9RDW/H+NDIlnd2xKcbolFt63EWWnnVN/BRLbp5cqwPjjQkKtN02yJR3z5nsWiLVXDI/4QRYnYwSh/WRHO5yil2quX/vX4KnihXXjc5WHZhO5OYdUuIvhJyx0AQZg/Epi0rsby6UcI6xmGX/EaF/ZVvW3JIXZBHyMELBlVCGpQkvWwUSQcXEd1Aj2G8dVIr6D8O7h4vN+xYlAoxtVIEQNlfm7PjB59lhY6J99bgZYGTCLoF01VpOGCfgPI8i3KlLslAxJ3PkGnf0GEnc6aQAvcumm+XVsowUk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(6916009)(4326008)(66556008)(66476007)(66946007)(38100700002)(86362001)(186003)(26005)(9686003)(6506007)(1076003)(83380400001)(33716001)(478600001)(6512007)(6486002)(54906003)(41300700001)(8676002)(8936002)(15650500001)(5660300002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BmQlJsf6egNLuXB/Mj1ar03fKzoXonqU9Qeu9ZeQEQ519uFPnaNB7RQnJn7x?=
 =?us-ascii?Q?dSxH826IGOmg2ljfdXbGfieFYVDTPJcCUK+3q0tve03ibdrH0QjibNxbI4yZ?=
 =?us-ascii?Q?MaR4IiiA+0VDUjjG286LavQmSnlp6FKPCVrevtAitMOXW1Rjr46ioyB/Kobg?=
 =?us-ascii?Q?FzdTHe9055cQsmSq6jKQJjXARdDndTgBo7T1FXeYxOEZliXEpf9qnRdjtTq9?=
 =?us-ascii?Q?ATfnXq4THLVhtFti7deul0rCEdHtqAZespqWtw0+Z/xIExXxhl+d/yoXCpPJ?=
 =?us-ascii?Q?uMZwLpl5ppzhZIWPtAc408U3hjJLf2HrWuxTey541YQRQIYd1SuP9FaiAZti?=
 =?us-ascii?Q?YtfLzxiR8O4eJ3NV+dxnHbq3JmLKreB/vHT69rLgf9ovkjkALTT0tz6JTnOr?=
 =?us-ascii?Q?3aGcKtb8TOwajSdZTMTHNvjrBAHixqe8g0xinjmOz47p5gUS8cBKg8+aUeZ+?=
 =?us-ascii?Q?w96HDp4XI0mSWCD8J1BEiVNySDDu/dB6tO+JZBep0gsADqSQ7BIbmVdHeo/b?=
 =?us-ascii?Q?6Q2guSrXjMYl4I1Jg/65ZRfxBIsiICLjVskzAgTQ481bgMrypk9PVbFRBeCl?=
 =?us-ascii?Q?6W/zQ2pbzW9iCiXifOqYHB3Y8/jjx4wH9GSA8Q25XiCqxkz9QXWGlpvC8PcM?=
 =?us-ascii?Q?jttTLI/NpSlmWzJgRCq/ESiww5BN+W+cy+5PLgF2tRv7Y8JoLxF60tWVqMjk?=
 =?us-ascii?Q?CN6G2P2CIPkp2FtWAPggUumrYT0rqkgFUAoZlMqlZJaWDVDVIPR5mh8r3Rae?=
 =?us-ascii?Q?TmaiBngavOWGCrU4vKwyNFFAp9jGkXZ9YY1RHI+0tOXrpdm+mslfUUoIGIao?=
 =?us-ascii?Q?wE0/foqeya1v2jqj2aZpXhqQDORBwBVtbYyG0cmAhnhU+Quza5v/wuPikULz?=
 =?us-ascii?Q?iHR15bg0bQml0aJsjJRy3h/opLDrGpa+OOeiUtsv0TcgJAnd5VC5RXItdRuC?=
 =?us-ascii?Q?QjPlijTlsHX908WgpM8CPXimlzXOIOUbEdhX59LBbDACByvzi9TGqdE9xEoh?=
 =?us-ascii?Q?DyFpu/fNEF1npUukJNIeTLEOrYsWCr+gDaqGRrHe4QYLRhZ4fSyh3pVSR1zm?=
 =?us-ascii?Q?78C/TVIbknrD1YbS/SSZG722Ej5cJFIpPDC9tR+OygruNZRDBaPMST59lGjL?=
 =?us-ascii?Q?mSIxY9GPd6sXdw8+GZOQkkCRl1H6IURoRM7NtWX8Vbsa0tymVQYpEN92Oj5l?=
 =?us-ascii?Q?SIW6ui07y3dKCAUUgTdUEOSdd0z0mI3TZQMrTvGkod9aavDtcDIrlMDxcW5K?=
 =?us-ascii?Q?hHA6PiBQ37zpob4OSwJed7ruMamOK+b5/UciYMS+07dfYd3Goc+nzgeVUzCo?=
 =?us-ascii?Q?cqaUJofLE9NNMRVqXuN5CGNjAAejxZatlutTTOgIlAT8YhCNONgvxEwbTZ8l?=
 =?us-ascii?Q?HhXAT23tmHnTrpRwCQUalLNF1kKZul7oaU0utDsG3oYFZqf1avvwtZUd84ql?=
 =?us-ascii?Q?0iLkJPAX5sGF5nVKw1lCwbDuwkv64HTGOT9EClgewVpBiKrYgsOsUftu9qJl?=
 =?us-ascii?Q?y7cQKm9TgZ+jPaFARoR2vkmn4MxqptzV/9IrJweYJD5ObO0FI2hsUQ9ug5hL?=
 =?us-ascii?Q?cWCv9ufF/eiYBywG+tGAY1F/Zbs3eX5KSR7kZaerOIL5+TdUh3VCh2rot4rG?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ykZb5/tYG2qYie6zOzv8bEdNwo6z11YVpmFEKrE7xZT84o9rBvo1e1fHODpEtFJ06exVcA6i8THkW36u7hgooXYqWb1wX60hDDqZUpmKdYSpVTasjXcZ7zK0aNZ4OUj8Rmho5aP4Z70Ua0Yaval+xioUJSdsRPTF3K3g1DOKKc71IxrbMpBqNYqX/nV5CL8XTmHLMiQ0mG5TU44eEM1L9N/C0s+8Niur6V/9Gf0FVEo7XpLKJFJ4pJrA+7NrFRdxy63WWUMv5zYaZUCHBgKQ+30rrqFILJmD6XJq9MkoG7bCEpJ03Ic6ksjSK6WRuYU1PpHHM8ltqxYvRgz0QFtFJUeUud7CzjIgwda8OPBmgPwL0XunaAdnes6jFr7BhrEuA8CRzTobtC+lHNRxzaMSIx39q7S9K62atN1pcT3nesgvI94uj7N1bhqRRXt5ppdgREMMjAXi7uJsiHV52tHIOAgHyixoMUx3YBiJit+QmMoUWOobjP5ue2XMve4N95Q5lUL5MOztTtYIpYYCOGcOxL6BIhz71RLvjshVKDVBdoC/YWUicjEk3LQX0jLIK7mhk3V4AoPPgefGAkkA21AJh6L6YTIzR/h3iQPqprHRn5AQMd0rP6Vd3Efz3EtfKDh97TjSMngr+y/fpfDl2nyM7vY1JwUjcU1iMO0Nx1hpJgd0cD3oGaky/uQsJoZkXCu6wqnJMQFb6IM5KmCSyydeNv5hm47Va0mqouajSkL/01Tds1gcV1bOJFy05LWjEm3XztHqMR6qh1RGW3t/nst2Nj/G11VKCYQaC38od/p8paWu/Ho/lsJG1zRCQTFwaNIAKUS0IkNVAltUQaUSxtkQo9+HcmFFwlQ1Bo17JzClZbwCGpCJ2nFubiW5/P8X2qLOjGUPJdpQ8kKXKWB7PcX/7w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420633ce-4bd1-45b8-a9a1-08db7cbf2d65
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 18:47:54.6065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yBSJVcitWrkg5QM7v5TqbrsV2B1z2XS0CixzhC/0JrevKgD/rXnyXPNv/Uv85pzHXrutldJDWzZatxNYCxtcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_12,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=650
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040163
X-Proofpoint-ORIG-GUID: _0SUtdqwHmqUeqxAuR0rwzsoSrvl5pfg
X-Proofpoint-GUID: _0SUtdqwHmqUeqxAuR0rwzsoSrvl5pfg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@linux-foundation.org> [230704 14:36]:
> On Tue, 4 Jul 2023 at 11:25, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > validate_mm() calls are too spread out and duplicated in numerous
> > locations.  Also, now that the stack write is done under the write lock,
> > it is not necessary to validate the mm prior to write operations.
> 
> So while I applied the fixes directly since I was doing all the
> write-locking stuff (and asked for the locking cleanup), I'm hoping
> these kinds of cleanups will now go back to normal and go through
> Andrew.
> 
> I do have a question related to the write locking: now that we should
> always hold the mmap lock for writing when doing any modifications,
> can the "lock_is_held()" assertions be tightened?
> 
> Right now it's "any locking", but for actual modification it should
> probably be using
> 
>      lockdep_is_held_type(mt->ma_external_lock, 1)
> 
> but there's just one 'mt_lock_is_held()' function (presumably because
> the internal lock is always just a spinlock that doesn't have the
> reader/writer distinction).

Ah, yes.  I was trying to do just that, but ran into an issue and backed
out of fully fixing this portion up until later.

The issue arises with the use of the same external lock for the munmap()
case where I'm using the second tree to track the VMAs.  Using the
spinlock causes issues with the potential sleeping within allocations.

So, I'm still working out a way to do what you (and willy) asked here.

Thanks,
Liam
