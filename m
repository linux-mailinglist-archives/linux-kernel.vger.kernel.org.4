Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625696CEFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjC2QyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC2QyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:54:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E73135
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:54:02 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32TFgL0N031051
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:54:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=Tq0u29EsP69rsNIBxrfxtjCqZf4eV17LfB9QSRSeKnE=;
 b=OturzTUNZIrvr23K+S+BVqlt1quBOrpa2EpCdApASjrh9ndtquNMBOjcl/SlqIJ6QCqr
 XYGmmDU0RIw3mQFsDOzcrkYzGxuoWYD6cbRGtNYdzQtsJ46zK8bNtoxQZRh7AjSao8jW
 5UCdAAt47pOcSgStp/W5XGL7M+yAUP6XQyxoCm6VgvS8N305KSMnwSFq6doW6wyemlBG
 sH05Wm1KW85zKrAC0TIO5Q4l5+ZiIZf2mKTON4uY+K62417THnJzD/fZqGz3exiPzRED
 m0WeHsqVEuFxQiJ9GO5UTIsXzf1dKjtFrTTvBFOCw8O64h0HvF/aF8vrzAbs5t87cfjF KQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by m0089730.ppops.net (PPS) with ESMTPS id 3pmcamc82x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6PKQTIlqgR7kakyXegOqrJY1mquaahQDlA4bwVdReYol29qbMOtVzDscFHCLqU+unlSyxg5Bh+tzJcxA4DxBZl4hEW9cZmmm7LEXS7MOpzMEkTDgy2+Tm0tN33PajZdljSRatbO9ciPd7daQVahopM3OjvPSOmPP6NyXS7pGa0z6Q3kqIn+qt0yAqbcT5B85S5/qWgFYdG6v9mAM1wixf2TujiZkD2i0zRe4qeS2WlfOuIaccV4z45B/2Oze8t75t+gS7AwwRcAWqprRo4EVUH74UOXm8iYoMnpgWCe02G/GqKTVFtf0qOrukPGzAtg5XtdSvdNG/ksCvMcJLm7dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq0u29EsP69rsNIBxrfxtjCqZf4eV17LfB9QSRSeKnE=;
 b=eNLj/iYFBb+f64pKiK3vi5mTEQiuaECcr5ByED5k0h+DD4DM4qkIn1OOgwy/ueQLG9pr128rgfDjktC6vHO+jLd++kAXpffqcp5AhpcHlViN2olU2Bvyeh+9taq1m5Mjef8P07m6LM5/R/hqN8lK4wjz0KfZWLUW9Vh4ZbZqZQC01iIxOs0UBZQuNT4vwDfCvd1jxLY2WBvhJsJQPmKN1RIoGu8F/7Y9AOg7mfL6J9bPX3974KSlTgHULRahIi5QLw7mDIWLDYcrHSyq7HyvjHch0v24OaQ3IkYxkz2A8SI5tUTI9gYgm2tMNqgJo2Zn+a4JIoirk+Towc8QDnII8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB4520.namprd15.prod.outlook.com (2603:10b6:a03:379::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Wed, 29 Mar
 2023 16:53:58 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522%3]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 16:53:58 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Song Liu <songliubraving@meta.com>,
        Hugh Dickins <hughd@google.com>, Song Liu <song@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        David Stevens <stevensd@chromium.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] mm/khugepaged: maintain page cache uptodate flag
Thread-Topic: [PATCH v5 3/3] mm/khugepaged: maintain page cache uptodate flag
Thread-Index: AQHZXdJKRWUpBJV49U+GL8Q6io5iaa8I8egAgAA6LACAABowAIAAKsqAgAB9GYCACBRDgA==
Date:   Wed, 29 Mar 2023 16:53:58 +0000
Message-ID: <E1A7D23D-EFCB-482F-9D9D-F8D92F1630D2@fb.com>
References: <20230307052036.1520708-1-stevensd@google.com>
 <20230307052036.1520708-4-stevensd@google.com>
 <866d1a75-d462-563-dfd7-1aa2971a285b@google.com>
 <ZBzK99dSmbPB7vjA@casper.infradead.org>
 <CAPhsuW5pTh2+S7VjRbRy=WUAb7-GLQpi6HKCW0ehxs5HAup_dQ@mail.gmail.com>
 <b49b118d-893c-c749-61f6-9441539418a5@google.com>
 <ZB0ZSqw1TTp3/ec3@casper.infradead.org>
 <6F9B0A6A-B7F1-4E25-AB15-8F3782D2EF83@fb.com>
 <ZB2mH/XMj3vh1RrN@casper.infradead.org>
In-Reply-To: <ZB2mH/XMj3vh1RrN@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ0PR15MB4520:EE_
x-ms-office365-filtering-correlation-id: 0e5abb18-e26e-4be8-4d57-08db3076308f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iyojlB3h+ZgoZqaOVjgS3pXrdZFVXcct0EASIkkwVG4lQutuD6c+CVcQrxwfj77EJDD8wEpTGQ/G5K/BkVu8D8KAirdK+O3f7j2c08x7hyoiQ2Nt5QdyAOC2vmWAqcdHkgbQU8eoHs4M6qGtSmNSh+OTl1ho2VhjdjhP061PKkeyzaye3INZcUMb//+hhxNFrbdClmXTHl4zkthfUcICiXMW7uBXKm+f93NdbXGfwT5c0oqhHrnr4Yja3/Pz0qgkwb57bdzqHhpSfPxCFFY7mV60ebZUjpah9WZjyqntD70hnEl/B+lwdnPFt+m7ejZtR3tviEn5IkNOtpgge5n9oit/zYnrOYKwrJra+6lKezmpN8qdfyRbfTuWGrCpq1GIZIGdu6YBDNNMtfxgkrLzHlqxwU6bqpk1XrWUQUgtV4frexTH3XqoYiq5veeJ+syKaXpgUGTw3/XIGfMiM/5vjTBuyUtMFAVmtGyWAjDDvLC4dHJKOcSwXuWCTaWXHgIjG9XF5lAijA8YYW6JCJm8OxRGK9Lj8NF07NIZGNeCmHc/OZm0BrQlJQgThF9WhR0uoEBIwWW7d6+twgBCdkjil6c3lKN+cGweBbYt/x8fSryzY+RWocfcPAhd8zd+A7jB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(76116006)(66946007)(66556008)(66446008)(64756008)(8676002)(6916009)(4326008)(66476007)(41300700001)(6486002)(316002)(91956017)(36756003)(33656002)(86362001)(71200400001)(6506007)(9686003)(6512007)(186003)(38100700002)(53546011)(5660300002)(8936002)(2906002)(7416002)(478600001)(54906003)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tbJvMIxnKTcD101C5PvqqQ5+KLupieXMOMxhAhsxSvkG+jC1CP2s9ZPsws7f?=
 =?us-ascii?Q?9VWqHr5TbHHlgCrLWLuf3B/G6nMTaO0m1OrsdNjdybkdn/2jwbdULCLOTYWy?=
 =?us-ascii?Q?wo7vxwM+WH7F5+QBJLTCgcoEtFRwY9I/3kiABMVANL6u8w1KYbFC9yy1jHMY?=
 =?us-ascii?Q?lNPzrGc+9hWhShjTZZMK27DYQsPXKBFroRN+KeoWwDGfoHB03sQWDPUP8cP4?=
 =?us-ascii?Q?KanHocHk9aElWHFJhbvC/itGVZZgst6znc6FtDrQB09hIvMbBvxMFj0weHaX?=
 =?us-ascii?Q?wgCLFQL4eePmmJtZAENh+RK54o20mjvleRZaRY5QW38762yWHsOA2i0ZsV96?=
 =?us-ascii?Q?A6S1DUge0DWClZRsk8qeu9pgr7G6wISMaiILUVWy4femoSdfgpvxsuUaMo4l?=
 =?us-ascii?Q?T0U07Va1syjPjelpkyGTJPJT/C2Y+rny1oAvbXIhxo4NTbwRk54M3JRnD+XZ?=
 =?us-ascii?Q?mnI9+ej1OGcusbmhdF2wKknrSSREQwHaDVQOWYW7vV7DpBhxkN1oFBwPP24q?=
 =?us-ascii?Q?hkoYGKU9cBfMrbghEmeKcy1E0uqFl4CRjmZyx+FuTwpuyiO4671psxjQq05z?=
 =?us-ascii?Q?M//f80gJExZn6rl45OM6HSB4qEzKVUAI3izdpmgbq2XeChpX74/hL1fYHujd?=
 =?us-ascii?Q?XO8ZPu2JUMgO0KH6XfcuXbscdMz6H+Z6ADWNvrmFDIhoXELT5mNlnyWcmxNk?=
 =?us-ascii?Q?d5AErkgj8guO1NNJwf0ULyGldcMguVnuqKtkvb8FZ/7ST7QTlxkIsHljtAbh?=
 =?us-ascii?Q?WUN1Lcz/VsFsMaxybaJdOV95cBDbPS6wzJcIiB89QXCGFVAVEyV0vAffxT2i?=
 =?us-ascii?Q?RR1XZ/DXkgBdVHEEGD9hvUhdkQbeWHtF+mBtOy5aS96tWHWojA/PXOgUlZTJ?=
 =?us-ascii?Q?Sw1mVaG5FB5+MMlTujCKuHIMEy4+VnmIxQJtrAtVXIbSt5nREpBhp7o6FL7S?=
 =?us-ascii?Q?li/KLRfQfdOGwIEXhLP/v2BFR/gyzIT4E706KVuJO+7V4i1EeV33t2x1+D89?=
 =?us-ascii?Q?PZw7LmxiR/hFnzV7fjnvW2vcBVsn5EpBMVbrNzut4EPhcIxeXbV3WupRHr9z?=
 =?us-ascii?Q?Ug78dX29PMkrSoAIeZjXry97XpxMLCJTMQQP2dXM96YmRallDyg9n7qfK6yq?=
 =?us-ascii?Q?JsnsLZKvuJF2gmjx/pN6nLWmH+zugfyWt6V+7RPT6n368DGxqc/SjVdE69A6?=
 =?us-ascii?Q?VwCtozu+BRKK8+KYbqsZMWIfwxKav9l1vMXSj8Y7Uv23t1twkpM5GT/vM7vf?=
 =?us-ascii?Q?0xShTE0ivgtwuqpesD0zSplA5c7o5tP8v4hJH92y8MGAEkd9uQVhT9vZU4m6?=
 =?us-ascii?Q?tVkxMiiEPPrgTy/LkwymMmrGasz0kc1PINmIkwsPYJSQrQMNPNuJpm1cdFtO?=
 =?us-ascii?Q?CHzUkxtfTezy7wuO7y8M8+kmBGByrELdQy8yrCfuM7TWWebDGsB+YrFEmjCt?=
 =?us-ascii?Q?c0tCMuqEEO7WHCaD738KiyPKUK/yEGS+Li4BhAgS/S8D3+gf7HQnsvPTyChl?=
 =?us-ascii?Q?ithJ4fMPet8KDfryXF6LKCjXvTPgvXgyRaaGgqYdGi2THRML6cjA/wFMp4A7?=
 =?us-ascii?Q?CJKNJi/jcMVOp2A2+AwL77iv9SRt57Es1nCFyqdMN/CJog3ptGGgfsEGs/6a?=
 =?us-ascii?Q?JrkObisX7RnJaOPpV2vfFlI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B2327AC1A50364E80CC0FE969880D19@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5abb18-e26e-4be8-4d57-08db3076308f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 16:53:58.1499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLNn+RPEQcI5LQUXU8zbM/OeUUrZXPUYKQHjZEThnS4CAKkm2cob40hR8Ia4WqhoETXKBIfTATmYJrWI7N/FUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4520
X-Proofpoint-ORIG-GUID: ACB2fg4NBIZKIrCfo7T5uPBG_lBx9IiP
X-Proofpoint-GUID: ACB2fg4NBIZKIrCfo7T5uPBG_lBx9IiP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_10,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 24, 2023, at 6:31 AM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> On Fri, Mar 24, 2023 at 06:03:37AM +0000, Song Liu wrote:
>> 
>> 
>>> On Mar 23, 2023, at 8:30 PM, Matthew Wilcox <willy@infradead.org> wrote:
>> 
>> [...]
>> 
>>> 
>>> The Uptodate flag check needs to be done by the caller; the
>>> find_get_page() family return !uptodate pages.
>>> 
>>> But find_get_page() does not advertise itself as NMI-safe.  And I
>>> think it's wrong to try to make it NMI-safe.  Most of the kernel is
>>> not NMI-safe.  I think it's incumbent on the BPF people to get the
>>> information they need ahead of taking the NMI.  NMI handlers are not
>>> supposed to be doing a huge amount of work!  I don't really understand
>>> why it needs to do work in NMI context; surely it can note the location of
>>> the fault and queue work to be done later (eg on irq-enable, task-switch
>>> or return-to-user)
>> 
>> The use case here is a profiler (similar to perf-record). Parsing the 
>> build id in side the NMI makes the profiler a lot simpler. Otherwise, 
>> we will need some post processing for each sample. 
> 
> Simpler for you, maybe.  But this is an NMI!  It's not supposed to
> be doing printf-formatting or whatever, much less poking around
> in the file cache.  Like perf, it should record a sample and then
> convert that later.  Maybe it can defer to a tasklet, but i think
> scheduling work is a better option.
> 
>> OTOH, it is totally fine if build_id_parse() fails some time, say < 5%. 
>> The profiler output is still useful in such cases. 
>> 
>> I guess the next step is to replace find_get_page() with a NMI-safe
>> version?
> 
> No, absolutely not.  Stop doing so much work in an NMI.

While I understand the concern, it is not something we can easily remove, 
as there are users rely on this feature. How about we discuss this at
upcoming LSFMMBPF?

Thanks,
Song

