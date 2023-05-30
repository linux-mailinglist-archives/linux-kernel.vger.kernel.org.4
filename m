Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21936716A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjE3RQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjE3RQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:16:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67533BE;
        Tue, 30 May 2023 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685466991; x=1717002991;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HRcIe0mTOGnWg8V3vHTJeh1EaCYFUQ5Z4cX/gIFHmVQ=;
  b=MeQZ4Smpek3mjxPvgUFd4NwBIQL8bAGk6qbc7XPguBsof2Smu6Sqdhzi
   HFvb+LJz9owphe3zmaB66EK0BVrUBwgf2jXTKl6EcROWCicqnKr7S+/D+
   8RfI6jA8BQuAnwEPAXuFfHlii/Lkn29Wc4IBxZhxuJTW5lVfYc1owhTer
   AlFwbVrY70aXlB/qf0o/C0C2gsxk8P0rJ3cszlpV3+ZFk6JjMzoBVndiQ
   A+xhEbgamUy+xyThhasC95dFtuvx6vBSdebGfhgRQ0ybdVKB9rfQHYMFZ
   wtLzuTpustNXaQ0TmMhZU+mpmeFdU+vsCwuxkLG7UTeyjVl7GjZrc6n6J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="354999137"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="354999137"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 10:16:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="830851633"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="830851633"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2023 10:16:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 10:16:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 10:16:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 10:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPw+sCSjcAByz3NxQOMfKn+P/i+Z9cFWluje9K5fsmHIyfF4el/ATq+iNPhQQUhZjMJFJsklcgz19LtorBza0CoBfxs2pdDe7gP0NWA0sWQZveKcV6MjfR2UlXzWlAOiZySQItd/ra5446/gDoGpg3R738RH3YtICOg0KZW1LwlSI5A2/XleI+19FJ+ldrLXBSWJRPQAOXbcQgVwlOEPO6QIiSp1xJAf/TDBOAZUEH3WI5HBQHweiJKPqkNk85SXzvv3W9aySZTz5/wR0XGD28XI3PXV4v7WakhwMEOTFZQiE94F56BaljfEznHU0Yp73d+XSbCCjVCy46sytMyCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5x/hymtmkmlnxGTbujdkyzULaHKAGKTqGVc2I1Uo/U=;
 b=UNR4nCsRxP0uCKqfKKzSN8dXJSAJTUEkCu3sNQL/1VvbNArIiMiLW2MEdGHxP07EILJLdlpNZ/YnigRZqXdFtJ01Mb900u+oz09SWAtq+yc8G52kWkc9lGPjwuqVA8JTLRkOW3QXAh3KhX6apP88LHypHx6VwMKcoOpOaZebEPvv0siktwgqThQcjM742RLnv/M876a9bJ3ZuK8o7CoRAQgonBd2W9cNOAuYhdchThwp3fykeBv3vyI6zdYuKbTWGRNoNUGOjHF7MhCHOCNWRjeCXMl7U6RjI6Pt8f+a1PqIEW10O50r6uFQCLbb58gb4e/k/cv1uJyMjAcGHC3m+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 17:16:26 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 17:16:26 +0000
Date:   Tue, 30 May 2023 10:16:22 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johan Hovold <johan@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <song@kernel.org>,
        <lucas.de.marchi@gmail.com>, <christophe.leroy@csgroup.eu>,
        <peterz@infradead.org>, <rppt@kernel.org>, <dave@stgolabs.net>,
        <willy@infradead.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <dave.hansen@linux.intel.com>, <colin.i.king@gmail.com>,
        <jim.cromie@gmail.com>, <catalin.marinas@arm.com>,
        <jbaron@akamai.com>, <rick.p.edgecombe@intel.com>,
        <yujie.liu@intel.com>, <david@redhat.com>, <tglx@linutronix.de>,
        <hch@lst.de>, <patches@lists.linux.dev>,
        <linux-modules@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <pmladek@suse.com>,
        <prarit@redhat.com>, <lennart@poettering.net>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <bav73qu5khl2dxkwpvy2hq34lyi56jn6yp7h5qlennka65kre3@zwwmrr55d2by>
References: <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
 <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
 <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHYitt7P7W+8ZlSB@bombadil.infradead.org>
X-ClientProxiedBy: SJ0PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:a03:331::26) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH0PR11MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a8e03a-fd7b-4cf0-5bfd-08db61319994
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33SPbw8SLRF112v8igwEQ0QQmjBJNyt7y6y8lCn9FTpWfeNC3AeQRUGIeSlVwKJkfpuH+yus9ht0dkRx6RBPdhC5fHhcarJJj2WAlgGcdi/8fV7cWIzD45skbPwZ9j96JdCB7FCDki/jRHMztKzDBuVV6wAEAVTTRWGAz2FUrR4OFiOWWgshrekHaGgNmyEwC55UF2uJjKwzPMIBKLWGCNJMc0M6Ua1Kp/n51E5rZPVrsJKOydoxXC37UlbXgE2EbjYmxwd5p1KX6VTVT665NO7f3lSSg9VJiFDSTlen4NJZo8tQLQSZmIep8Qbzh4D0OXYhzRf6fOpWoZnK6imAF1th6NA5Rdzdc4kPhNPTe1ciGGonN7/9+hqQcfVakbCi2oxZYnS1ys0mKiBZgIvSdI44DIDiey+a6xxI0EJqDsXxCQzi3XeBQk8717GPelryw60Qbz51KZ6Dpyxp912pEMmLp/6zw5/Er0aLK5Es1a7FfhCpGVDqw2Eo1ddviw6WVAxA3UoOk591C9s/9ddVSqRAiDhxshE40xna73GoIUNaYWkFN+QnHNgfL56lHVlh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(33716001)(6512007)(9686003)(6506007)(186003)(53546011)(2906002)(83380400001)(6916009)(4326008)(6666004)(316002)(66476007)(66946007)(66556008)(41300700001)(6486002)(478600001)(54906003)(82960400001)(5660300002)(38100700002)(26005)(8936002)(86362001)(8676002)(7416002)(7406005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJDMVRjRFdCcCs5Uk90K3pRenNhZjZIM3lPYmFTR3VoOVVESGJ4OW5kc3Iw?=
 =?utf-8?B?VHJiWUxjNUttS1daazRiNTc5WDJQbGhtZmwzdmlCMExEN1VUWEpMUFNvR2dx?=
 =?utf-8?B?RHdiMlg5all4eEduOFFFQ0lxNjF5dklxUFRURGVmWm5aSUtkMUJpcWVrU0Ja?=
 =?utf-8?B?Sy9SeG9hRExOQit3d1gxQXlCSko0L1Y5ZGgrZkNuN2tXTGkxSVc5QjVnTUZp?=
 =?utf-8?B?VWFJdUd4bCtSM3dWbGpVYU16eFpZVVJLUjdQandJbFIrVnlDdVg1ZFFidmhw?=
 =?utf-8?B?OW1RSU1lRWw5QmMyMUw4anU2S1lIZzVPR2UxWGlBdTB6RVVXQm5GS3hXVm9P?=
 =?utf-8?B?U2kwdi9wcVdwdlQ0S1ROUGNOZ3dSckpGU0pxaStxNkdYcitud01Ncm13VW43?=
 =?utf-8?B?TGtPN3hhaHZXZ2RaRTVWZjc3bGVYeFhGcmwwMm5kaHFIeXB6M1VIdTNiYTNz?=
 =?utf-8?B?Tkh3a2VuSmltNzlJWUN3a1o2dkFocENkT3A4SlljRkk0elBrSkNKVTdHUmtD?=
 =?utf-8?B?S2FOWE9rU3JKNGVNOGVNczl2aUxBMzFoSVE4THlQd01GV3JXRVpmOU80dE1Y?=
 =?utf-8?B?cVZlSUE2SC84alZjMjZTamNtMUtzNFM1b1p1RXNjdms0bnhBbHJVQU1abHBU?=
 =?utf-8?B?aGhlVGJPZXl4VUNwMTh4Q3l1c3JXQXhXdHV1K25zTGR5UytheVZEV0Rockdu?=
 =?utf-8?B?L1RwYWJPZ3ZUMnIybGlrYi9NRHJUUXIzTDE5MWU4aHNsYjdYUlQ4dXFSekNs?=
 =?utf-8?B?WmUvYXBJdDg4d0ZieS9Ub2IxcHgydmJUQzFBWXBkOGkvRldkdDgwRGRTNm1L?=
 =?utf-8?B?elBsV24rKzdYRnhoYVNBdkNsclo1TTBhNWQ5RU11YzYrUjZQWkY0NlJSOWRt?=
 =?utf-8?B?ZnlnSEVYdE01cURKRndxLzhIRi9Ca0JRU3BNZkhaQWxBa3RWS252Uk9ZT3lQ?=
 =?utf-8?B?b0RydEI3UkdUTDBCUmsxOUtHbFMyNEo5MXB6d21XNFNZdTNIMkg1eEE2VGNU?=
 =?utf-8?B?U1pHUHU2MUhoQ1dIeHNsTXVNeFdvYjRmSmRKcmN1T21VNzFkTXEzUmIvbW1Y?=
 =?utf-8?B?UWNJbHJraVBLTEs4aUpGblJaRlBjZC9wOExTVXZxVnZHRUQwSGtUZktzZUNJ?=
 =?utf-8?B?bkltMXJ4VGJwNXFRd2VHbnpCUVRkaU8vWndtbHYyS0NtNFVqMWdLMTU2TjlN?=
 =?utf-8?B?MmxJWEFCckhzUC9qV2lSSU5WckhGdWFVYklMZGFibGdQd1VRRnlUOW9VK1Nw?=
 =?utf-8?B?ZXg3Z25nbHlQVklnVlhBVFUwbklCLzdVRksxRDBnMFFGa2hkbnM0VGM5WTRD?=
 =?utf-8?B?aUs3SldJdm0yWWxsYnZXcnE1TC9KTThzazZyb203RmV1NTNzbDJ3N3J3aWNn?=
 =?utf-8?B?ZURDN1I0MjJHZjNSL3kzY2JaUjZCMnUvWVBaOGM3dFQrQm1mcHEwMlJHVVZw?=
 =?utf-8?B?WHRIeGJhMG9PblRSZll0SnFEU3ZydEM2WFJsMjRuMWpZZU03aWp3NDFiN0Ux?=
 =?utf-8?B?Y0R3WndJK2tLZXd5Qk5JNkxHaHhoNHdIajYxSUh4akdoT2t5aUdXbklIdW5V?=
 =?utf-8?B?ck90dTN5MkQvY2kyOG9jdUh4U0Z5all3TEN5cDdIOXFTVjJTNkJRSGt4dGpK?=
 =?utf-8?B?NHp3U05mS1BPN0tTb2s3NDFzN2JWY1VtZ2wyN1hKWnhkd2NtbE45V2Jsd1Fm?=
 =?utf-8?B?ajJiYzdhcnlGTXJDYnBuaXNza3Q3MS91dElJSEhhQ2JTR3MvVDJpc3k4MDJv?=
 =?utf-8?B?S1k5ZzUxYm80SGE4S1NtS1NGT05NTDRFdUhGak5lMmJyRGFRSHk1WEdDdCt2?=
 =?utf-8?B?MmNQMnpLMkZHU21sZnkyWG9hNkJISFhnSW9HcXgxait6bkw5Z0pGNlN6YkMr?=
 =?utf-8?B?MEhLOG9CS1ZpM01hSGNjdjZORnFmby9IUjAxeWIxd0RENGpCNm1kSW13b2Rt?=
 =?utf-8?B?NXQwdC9uNEg4bnNKRm03alVZZ1JMMXRkSjI1U1ZnSmZEQ3ZIZlFpYXBGQm9E?=
 =?utf-8?B?UllxbGw0TjhzMm5hTFdvVzdSVEYzYURRblpLcXdLbjRENllCQlVBQ2ZNRU1u?=
 =?utf-8?B?djViMDY2R1BWb1lqcUtjUXdJZUN0UWd6UWFza0RwTGJyalR6MzBJcEIzMHlH?=
 =?utf-8?B?L1BnWVJkVnRob3lMeVRHazR2TEpITEFRTU5FV1ExLzN6bnc2T2liVGNTS1Vn?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a8e03a-fd7b-4cf0-5bfd-08db61319994
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 17:16:26.3372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRVFREznaxj1rhMkOLMRqHVNqhQjgyRZwjM53xbHivCX0+xf8nCMqm9L/OkoUTnmyRJov0OpbzDvVoGR3JSY5rKVwASA2qHzl+r07F1wytk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5332
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 09:22:14AM -0700, Luis Chamberlain wrote:
>On Mon, May 29, 2023 at 09:55:15PM -0400, Linus Torvalds wrote:
>> On Mon, May 29, 2023 at 11:18 AM Johan Hovold <johan@kernel.org> wrote:
>> >
>> > I took a closer look at some of the modules that failed to load and
>> > noticed a pattern in that they have dependencies that are needed by more
>> > than one device.
>>
>> Ok, this is a "maybe something like this" RFC series of two patches -
>> one trivial one to re-organize things a bit so that we can then do the
>> real one which uses a filter based on the inode pointer to return an
>> "idempotent return value" for module loads that share the same inode.
>>
>> It's entirely untested, and since I'm on the road I'm going to not
>> really be able to test it. It compiles for me, and the code looks
>> fairly straightforward, but it's probably buggy.
>>
>> It's very loosely based on Luis' attempt,  but it
>>  (a) is internal to module loading
>>  (b) uses a reliable cookie
>>  (c) doesn't leave the cookie around randomly for later
>>  (d) has seen absolutely no testing
>>
>> Put another way: if somebody wants to play with this, please treat it
>> as a starting point, not the final thing. You might need to debug
>> things, and fix silly mistakes.
>>
>> The idea is to just have a simple hash list of currently executing
>> module loads, protected by a trivial spinlock. Every module loader
>> adds itself to the right hash list, and if they were the *first* one
>> (ie no other pending module loads for that inode), will actually do
>> the module load.
>>
>> Everybody who *isn't* the first one will just wait for completion and
>> return the same error code that the first one returned.
>
>That's also a hell much more snazzier MODULE_DEBUG_AUTOLOAD_DUPS if we
>ever wanted to do something similar there if we wanted to also
>join request_module() calls, instead of it hiding under debug.
>
>> This is technically bogus. The first one might fail due to arguments.
>
>For boot it's fine, as I can't think of boot wanting to support trying
>to load a module with different arguments but who knows. But I can't
>see it sensible to issue concurrent multiple requests for modules
>with different arguments without waiting in userspace for the first
>to fail.
>
>Even post-boot, doing that sounds rather insane, but it would certainly
>be a compromise and should probably be clearly documented. I think just
>a comment acknolwedging that corner case seems sensible.
>
>Because we won't be able to get the arguments until we process the
>module, so it would be too late for this optimization on kread. So it is
>why I had also stuck to the original feature being in kread, as then it
>provides a uniq kread call and the caller is aware of it. But indeed I
>had not considered the effects of arguments.
>
>Lucas, any thoughts from modules kmod userspace perspective into
>supporting anyone likely issuing concurrent modules requests with
>differing arguments?

Changing module params like that without first explicitly removing the
module was never supported by kmod or module-init-tools (I'm not digging
the history before 2.6 kernel)

During boot, note there is already a shortcut
if we have the sysfs node already in the "live" state or if the module is
built-in. In that case we will return success or -EEXIST (if the
KMOD_PROBE_IGNORE_LOADED flag was passed). To be 100% equivalent when
covering the window between the first finit_module() and the sysfs node
being created, then we could add a similar flag to finit_module() and
return -EEXIST. Note however that likbmod will already clear the error
when no flag is passed, which is the normal case during boot.

The only scenario I can think of during boot in which the module params
could change would be when a buggy initrd is created, i.e.
/etc/modprobed.d/*.conf is in the rootfs but absent from initrd.

So returning the same error code seems good to me.

thanks
Lucas De Marchi

>
>> So the cookie shouldn't be just the inode, it should be the inode and
>> a hash of the arguments or something like that.
>
>Personally I think it's a fine optimization without the arguments.
>
>> But it is what it is,
>> and apart from possible show-stopper bugs this is no worse than the
>> failed "exclusive write deny" attempt. IOW - maybe worth trying?
>
>The only thing I can think of is allowing threads other than the
>first one to complete before the one that actually loaded the
>module. I thought about this race for module auto-loading, see
>the comment in kmod_dup_request_announce(), so that just
>further delays the completion to other thread with a stupid
>queue_work(). That seems more important for module auto-loading
>duplicates than for boot finit_module() duplicates. But not sure
>if odering matters in the end due to a preemtible kernel and maybe
>that concern is hysteria.
>
>> And if *that* didn't sell people on this patch series, I don't know
>> what will. I should be in marketing! Two drink minimums, here I come!
>
>Sold:
>
>on 255 vcpus 0 duplicates found with this setup:
>
>root@kmod ~ # cat /sys/kernel/debug/modules/stats
>         Mods ever loaded       66
>     Mods failed on kread       0
>Mods failed on decompress       0
>  Mods failed on becoming       0
>      Mods failed on load       0
>        Total module size       11268096
>      Total mod text size       4149248
>       Failed kread bytes       0
>  Failed decompress bytes       0
>    Failed becoming bytes       0
>        Failed kmod bytes       0
> Virtual mem wasted bytes       0
>         Average mod size       170729
>    Average mod text size       62868
>
>So:
>
>Tested-by: Luis Chamberlain <mcgrof@kernel.org>
>
>In terms of bootup timing:
>
>Before:
>Startup finished in 41.653s (kernel) + 44.305s (userspace) = 1min 25.958s
>graphical.target reached after 44.178s in userspace.
>
>After:
>Startup finished in 23.995s (kernel) + 40.350s (userspace) = 1min 4.345s
>graphical.target reached after 40.226s in userspace.
>
>So other than the brain farts above, I think this is pretty sexy.
>
>  Luis
