Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552BA6461B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLGT0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiLGT0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:26:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35126663F1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:26:06 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7J2ltt021877;
        Wed, 7 Dec 2022 19:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=IG3zWy1HNC9Kk3CCxfprcWl3JFca12BlODER8bp4khw=;
 b=VMNZuin0g5lcR4ymy1wQwOwFr0QPMCVnYDxeug3ZjxkBDjgSolAkPvY9QdqC/xLypJBm
 GaumZIagL/xjRK5wT5Xpi8VcpqKERRz0iQq6XzYvTep0L+1Ft8oQoRykBNsUbTPS8ScG
 WxoEdIRm+DIK9qYb9jGaHY4BGNKU40lFjUXR96kuakkxMji01uRU//KdElithIXgbKHj
 7z5C7x/uWTyHMp3vdvnZSWzqHTxpMbNDE+MVdgAZdF0TPeDrRcny0O+FymRgoeXerROP
 nlEaTMZYlVfhbsQKCVM7qBd28PaI7cbIELPOvVLZ2/4m83SXKOn5vLZZ4IEO2lkW9Aqv xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maubah7pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 19:25:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7J9ubR001914;
        Wed, 7 Dec 2022 19:25:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7ct0cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 19:25:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBLJDEyyIDa8C4LFzctcX9DMHLGG1GurWrzLYuGMbBA73cI2hKkbnJo9nGUQlOj434PGUySkt3Iyhrru0RAX44no+mfOD9hcQjLAe57ldrfxUX9DyXKrQDC4994veWthnk+4ahxaB4z5u6gRbPFAqOdWdStyG0OqtYn8XFoRiZ/aElJ9b43NxBPnELZGis1g2IPdQSSR9FJ5OUCSX6nQ1KoPq+WIMcDp5s6B6J4vBhE0Mi5qaCiKIIqgWzjk1ZE8nxwxbYhfqzOxfKd2X3YmFtjE4VHhtxlLQkLuA29yCJKTHqLBntHhjbomL01nnzOKFDHd3vvG+t//TIILyar5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/k1yZF1GxHQOvjvipkKqMm/VOBgAGXWc1t5tjwI1yU=;
 b=j9NmfKPNuKgMif5Xxs2TmArYk2dKs2mV3Y5OLOcHNGDGIfB3bxmoIilK+dj1lsiDy8Y3q923TYFudz7A88H0c1cCLqbXNJfKc//h6aE4EsJVzTx8bMGIue6eXJMxfXPVi75qlRsfIX0YWsowQq4BQJcTQdtRxZAOA7I/gNUIwgZWamsuLg0AD7/o4Jhd3BYst4FXIjdi2eR7KlJnCaUuiEtNLcioOLd0rL98l9SSFwsZyESHc0OQ4a7ibfhyJBKqoV6dZGaq/G+PcINAxLFsSfxu2anKYMhtjpfb7PHtZ9HrAoICmlJSKE8vjBlI2ZSVf1GG9UHar22dcN9gZkpuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/k1yZF1GxHQOvjvipkKqMm/VOBgAGXWc1t5tjwI1yU=;
 b=dPenMY9mED0357eOT1783GhwZxcaR0a2dC/uiN42EoQDtlE7MiC5f/6OlfmniswTOuOD5wcCFZAIu31h60bAKT6jv3/JZtgut8xlrbWp08gHnUlmCOhtaauFBcLDW41rheGXhK9mY8rWKSWTl1/sDNOEVaD322CxvEFJAl9l5zc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB6740.namprd10.prod.outlook.com (2603:10b6:610:144::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 19:25:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 19:25:43 +0000
Date:   Wed, 7 Dec 2022 11:25:40 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
Message-ID: <Y5DotA/pLbakONGl@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
 <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev>
 <Y5ALigw0kUO/B3z2@monkey>
 <4161AF1A-9508-4DF8-B756-FEB476EB32B5@linux.dev>
 <Y5DXivFOA+bO0IYQ@monkey>
 <b995eccf-5818-84ee-560e-20c00f9936b4@oracle.com>
 <d5755326-a71e-242b-5e1e-86fc897dc292@oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5755326-a71e-242b-5e1e-86fc897dc292@oracle.com>
X-ClientProxiedBy: MW2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:907:1::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a812800-956e-4c23-89d1-08dad888d51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVR4y9/m1dvuE3JRPncQBeCN101ObxvhROtticvR1MyHj5NKQW0LqCgUJVbdJc/xmHu2z4Wxjr5MhADHslKAHpAaCq7UdEKcGGHM49TmoUcGzlflnze4c5kMbirpWBGN+XimfKJZGRTYlkyuCUN2aAWW8VRiqSAwjtKsfx14Foq4bmfea4ORdB9XihfmsH4uHe9TsKX5UU2tReqVo2aQcTFRz1uHWn99NUEtRszQHvcZt4SD9I4Z+I48xhv6tj3fd1EIrNlCNq7nM8INcRN1EZRCIamMeo3CIDZlStXj6dYgqpubzt9wHnXDnZ2ZHn/J2PVcEaUJ+D8mN8J4mqJ+enWrkoGTwBuB0vRzAqoShRAXgE9l1FZ3y2w60wDd4fvsIdRAxU0IWQ+fcWSERQ8vEnahUDhKNDnUPSkL1DOo84W+n09gqH6cOPwsmxtn233OfcabuODd8ni66rmQ9BPixzqr51ZZrmIVh/w3rNgRiR4lEGNlZpknf0qeCjbh2/5f38y/CyPBvOUYGdi28mgdRBPlh3YFXffYi7YG/PsbS0n+Ksp+Y+A0LRW1KuH87YolBi1Z8Tlth0QsWL/nO9SZuWRdKfbzHYWKTR3QXBJ99ghbEKsdyEt0LkEXToaoqEovr1/d+8kvJwyGltnlJGXqZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199015)(83380400001)(7416002)(86362001)(44832011)(2906002)(5660300002)(6862004)(41300700001)(8936002)(4326008)(8676002)(33716001)(9686003)(53546011)(6512007)(26005)(6506007)(186003)(6636002)(54906003)(316002)(66946007)(66556008)(66476007)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1KD4bMdzJXRva8HCuscSHChoHFGk5zOY93ATYzWBeqT3DN15bdKGijsmNk?=
 =?iso-8859-1?Q?EFWmm5ha1d0Xgh5IK3WxL0QJrW8Xhwu1Abax23JCVqUMyW1UwkmZJGHtSY?=
 =?iso-8859-1?Q?2UDl3uPrRBs3nwr+otno55LQtA05wtIHZXTLn7pal2FTz9JWN/GYQseXRk?=
 =?iso-8859-1?Q?ymcnaWNqL3y9ueNiecsoCxrTzgHK43TG6m8jAV63iA17DrmNbop30jAUxN?=
 =?iso-8859-1?Q?gpfwHx0XkVkyn1OZMkX1d7wEAdak64VhQ+qzYf57gs0oVtrEeC2cRjH2YJ?=
 =?iso-8859-1?Q?z7CWJNubtRf+9I+fWRRSTJrqzqE4mjqrp3esoVeGpHCGnuu5QslKMCXtey?=
 =?iso-8859-1?Q?3DSkrZKWRCMUF0R66A9IuA4U3EP+t3aRhh6ngJv4FpC2f5XXi0qdrabxB6?=
 =?iso-8859-1?Q?nKg4gslZtwcgxwJE/w6Dj+MpNXqbqmgYrfODnEv+U09QuRbgyUQOvo1hUi?=
 =?iso-8859-1?Q?HkR6FaQR/xVfMEcpTH4Dna7BhDEfOZMmWVZ6ImvEi25HKj0ArhImNkXvvM?=
 =?iso-8859-1?Q?Dac4V92fOTq3xTiCR+7yzr0+VaUin0NtpbbY/r1sX5JG5G7511OxaM+nYx?=
 =?iso-8859-1?Q?tux3r8Sf0Wo5OknbZFmD90Kv/V5WNEajxHPSjvO1KWkZ09/a+FAI3SHdYO?=
 =?iso-8859-1?Q?CBdxb81VFJGMFKFlDL/8lauddb+k7KOEIGOp0MATIP+SwBJRGBqx1UfXKJ?=
 =?iso-8859-1?Q?f4tdaUHaDNKmKZ+Cs4qc0fz94aVsGao4d35cbbS3gVlBvByhi8UK7Je27p?=
 =?iso-8859-1?Q?ltUiEC476NJwFvINc2C4yERx3v2twI1y9ceCzS6T8asHEizaMwwTyUOmGD?=
 =?iso-8859-1?Q?Tqq05E4zgv2vQET3GeRWLL2oVrnY4PLL8fV0sbF+GhHZAf14Vk1y7Zzeul?=
 =?iso-8859-1?Q?pD6O1eIg+QqEJNi5XPEAXBMnigtyfc2PIwmUq9LDopOfzJOqYwLN8EXXQq?=
 =?iso-8859-1?Q?21uWwSCKtFMcjAiSsZX1vV3jfMBhIAr2v5GMhnRIeamXC13g43t+XyWMDT?=
 =?iso-8859-1?Q?TXNwsDQOkbD0lK3FlV63z5cIWmP4zioxNuq+jf6aQdXkz9oi1fojpt+3GV?=
 =?iso-8859-1?Q?4sm+WhVgZ9Mj3UK9VkvOKFH/VfVrUgCk0+cxZ8XNccwn52jtb5CX9pIO9J?=
 =?iso-8859-1?Q?8W2uvZf2V/a8VLF1ZBRh8WuZ6DCkfGUUGT/vm+xaLTHrAt7h29x6yryp4F?=
 =?iso-8859-1?Q?lQMg1oDmqrWLCBleWtF/45ZKEYdaXVTM5AKF3QDRk3VVJrfKtHUAjHF+Vf?=
 =?iso-8859-1?Q?EwgUvfsBJGA5Qu4tWuV0PYCHITt53OH6aEU05x/QakdpgbwHYmVA99jNfW?=
 =?iso-8859-1?Q?Z0Dfe9GzH/UFBpDWq2N2guVBwIdyWb7HjPR0vAnMN0yKujhbH25+JHuAIt?=
 =?iso-8859-1?Q?KHLcgXJwRXHhNyru5q87WAPPuEkuAbze1EXpo9D/POAJFvd6uHA7/z9Lk3?=
 =?iso-8859-1?Q?2vzkNW1WGpyZmHdF+Ljrs9ao3NuOXGaOp0eMICaeR0IO3zZTbxrbuWlLXQ?=
 =?iso-8859-1?Q?+y8IxH1kPDGwAvlrjqjLeJFtLY+aNHfagBiNrrGjdjym+CDF/OLtlH19v6?=
 =?iso-8859-1?Q?dnBaEa9kexb2O5SYXQTM9bP/f9mtN78wv97LYY9fFA6oyc9S1ivkB8/CO0?=
 =?iso-8859-1?Q?M2INGzSDkDSXNKQRYEaQakfA9DLjihHS3pu+kXD8N4avgAwjEbRZev7Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a812800-956e-4c23-89d1-08dad888d51c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 19:25:43.0321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZNJXtu5GGtvHiMPNKLZjDsxlMen9R031+hsONHUXWSPImao19beq83d9BgD87Jyde24Idz/6BUaYnRruX4mjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070164
X-Proofpoint-GUID: UFJa5H2K-Ax7Efz2Pz4dpvuPZnCfl97m
X-Proofpoint-ORIG-GUID: UFJa5H2K-Ax7Efz2Pz4dpvuPZnCfl97m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/22 11:05, Sidhartha Kumar wrote:
> On 12/7/22 10:49 AM, Sidhartha Kumar wrote:
> > On 12/7/22 10:12 AM, Mike Kravetz wrote:
> > > On 12/07/22 12:11, Muchun Song wrote:
> > > > > On Dec 7, 2022, at 11:42, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > > > On 12/07/22 11:34, Muchun Song wrote:
> > > > 
> > > > Agree. It has confused me a lot. I suggest changing the code to the
> > > > followings. The folio_test_large() check is still to avoid unexpected
> > > > users for OOB.
> > > > 
> > > > static inline void folio_set_compound_order(struct folio *folio,
> > > >                         unsigned int order)
> > > > {
> > > >     VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> > > >     // or
> > > >     // if (!folio_test_large(folio))
> > > >     //     return;
> > > > 
> > > >     folio->_folio_order = order;
> > > > #ifdef CONFIG_64BIT
> > > >     folio->_folio_nr_pages = order ? 1U << order : 0;
> > > > #endif
> > > > }
> > > 
> > > I think the VM_BUG_ON_FOLIO is appropriate as it would at least flag
> > > data corruption.
> > > 
> > As Mike pointed out, my intention with supporting the 0 case was to
> > cleanup the __destroy_compound_gigantic_page code by moving the ifdef
> > CONFIG_64BIT lines to folio_set_compound_order(). I'll add the
> > VM_BUG_ON_FOLIO line as well as a comment to make it clear it is not
> > normally supported.
> > 
> > > Thinking about this some more, it seems that hugetlb is the only caller
> > > that abuses folio_set_compound_order (and previously set_compound_order)
> > > by passing in a zero order.  Since it is unlikely that anyone knows of
> > > this abuse, it might be good to add a comment to the routine to note
> > > why it handles the zero case.  This might help prevent changes which
> > > would potentially break hugetlb.
> > 
> > +/*
> > + * _folio_nr_pages and _folio_order are invalid for
> > + * order-zero pages. An exception is hugetlb, which passes
> > + * in a zero order in __destroy_compound_gigantic_page().
> > + */
> >   static inline void folio_set_compound_order(struct folio *folio,
> >                  unsigned int order)
> >   {
> > +       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> > +
> >          folio->_folio_order = order;
> >   #ifdef CONFIG_64BIT
> >          folio->_folio_nr_pages = order ? 1U << order : 0;
> > 
> > Does this comment work?
> > 
> > 
> 
> I will change the comment from referencing
> __destory_compound_gigantic_page()
> to __destroy_compound_gigantic_folio, although
> __prep_compound_gigantic_folio() is another user of
> folio_set_compound_order(folio, 0). Should the sentence just be "An
> exception is hugetlb, which passes in a zero order"?

How about a comment like this?

/*
 * folio_set_compound_order is generally passed a non-zero order to
 * set up/create a large folio.  However, hugetlb code abuses this by
 * passing in zero when 'dissolving' a large folio.
 */

My only concern is that someone may modify the routine such that it no
longer works when passed zero order.  It is not likely as anyone should
notice the special case for zero, and look for callers.
-- 
Mike Kravetz
