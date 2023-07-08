Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C7D74BBCE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 06:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjGHEgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 00:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHEgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 00:36:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D052117
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 21:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688790999; x=1720326999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3m9BxrakIBCOfBp6B8sjduPe0D8C6DQ8F4Va2zSl4bE=;
  b=K+a3Fm59e68IELaAouT9a64L+Vx/hcXJqQE9WldI7MWWBawb3I1XU/ap
   8hLoVZ1/NW+7/hGzMVC68FKu7OIGpkGdvdDWoYoSFgl9DduA/KWbPwDx0
   LGarEmZHbYd8+oOo0OWlXexgOZV78HJd9dUQfFeA6WI1qWGguTtDf1TjE
   ly780aYpD4GgkX3b3ejQNZYYt3Ta/02Th2IKIa/pIjcYZ6LkBAjwc1W82
   C0i6frz+Mx+YJLbZ6dNurRDVGC8RhGXIzOrv65Aj3nRD77H3fBnNHHehF
   skZh7iIz2vAw0EWAk5GuFEasAZRsC44yOTrtKTFDLIczBEDi+9ukMfQhc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="427720537"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="427720537"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 21:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="966829525"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="966829525"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2023 21:36:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 21:36:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 21:36:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 21:36:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDlXtaZj3T3V6wgbkWU4TF5iVvcxcK2M7QFPU/tXp1sIvZaV92mJ3aGTQxu6uesnWh6oU7izusrATv82YOjHcUfiNcc3RdCEQj+hU6xfJ7pnjcofgzk8tdemPQLM7b/GzYJNpB6q/n+/u4qACIa2vxNhdNg3h644gc2v4dYk6gxRXKVW/LT47osy/xsZRO/XQ0wt9CgyMtFixh7X558HJjSmDw/Qjxuq3RtXxlDeipZR5N6jwkwtAjFwpYkYYR90+PUVOIseajFwYdM/x7S0njFFi1T4kf200RayL5uNiatJPPDFA0iOaAhRvChKI+ts99oWU6tnpqjfBAnfc5WrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsEACmoQJ3t+5oZ2EXLEJaKpPsdQPczhE/OySm9FOrY=;
 b=Z65feIdOmg1okug55rt+TWvsmW/gOYc5yjrawu3DviV61cl+WHdadSoGagodUxsggD5pYoMfczpKpE5v79PPZTVinPGcw7zJR0yX3pp1h3ulrqQzEhojHAQAvLo3k6unDrtC4siVDiZAHDZF7nJ336abGBfYHiGXLfon1YH91GHqfZ1DUzguf+/HPVKn4OpnsmD1L8flEwZcfFc8NqcyxAMw8Ne7qzt9kqG+Wu5Z8qUasjG0B8PZkGopn1MKoPUB+ctA6IdMD6kEgYYkuO93E57b3z6ZnE5f3cZXaY92HMr/pkWTgMITWzM9FxO6xQruvqJkIa3HqVfT4Wfrt1ZUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CO1PR11MB5121.namprd11.prod.outlook.com (2603:10b6:303:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Sat, 8 Jul
 2023 04:36:30 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 04:36:30 +0000
Message-ID: <afd3a7bf-cd45-9c59-a853-d49d82ee87da@intel.com>
Date:   Sat, 8 Jul 2023 12:36:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <yuzhao@google.com>,
        <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        <akpm@linux-foundation.org>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
 <436cd29f-44a6-7636-5015-377051942137@intel.com>
 <ZKjfwYWh/n/LbTZv@casper.infradead.org>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZKjfwYWh/n/LbTZv@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CO1PR11MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cc1660-ab49-48d1-2276-08db7f6ce673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nqr9YIEZ0s+YZd2dT36FeF8QI7yItMwYvDg+imiBrASlnvEbRjlZnAoIPAxqaO2YsZTL4h9z3G+2SSX4FopydnELY9pwTpU7nBXWrVX/Fwz0lIaKwAPut4Y7CKDpH4odbfdwRaS4pEBfRwl9GP6/YK0JGXmNHzME29Ggq0m2hR949IHhD9jk+4kRhkgrqVWNeXObhnLnk9JbpDO+EqdG1pF+uZGbzcrGGg8wRFnat5ig1K6qKcpy6ITx2bdJaDlOPVNkp6Jf3t5pq9BHD/qEjAWKMu3SJDXQxqjr2Li9P6nMt/ilB9wet4GVoOGv2fyrLT0EgfvJOGEvAQhiIERmlQDZ8PglRIq1ECNHWNN51BrVkS7gavcrKizRo78nbasbRmEPo6FwlRNv0+CVrZmMpoiDO7YQbq65a44xMSMlvsBNSdznS/cJglCv7jUIzhVQtZXxttPT3CwnxvLHhjUNz1Txh5qF11Twv4CtlWQhulXkGWKphXfWU5QCGvegY+ebh+9g5wfuC7clYGJDwoYNtxKO7mDjIvQa4XIaYya4juMDEg3KNGjF0XDazLOO471lUch7ks68yQEJY8EWgi/YWUg+22N+fdPxURPsQm4mUnDb2acy5KMVUC/il+C5DwIIQBm5ZumB9qyzYQyRNPoP7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(82960400001)(36756003)(38100700002)(31696002)(86362001)(66899021)(31686004)(41300700001)(8676002)(26005)(8936002)(186003)(5660300002)(53546011)(6512007)(6506007)(2616005)(2906002)(83380400001)(6486002)(66946007)(478600001)(316002)(66476007)(4326008)(66556008)(6916009)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXVFaHNFdm5LY1dpRGZUVnNRWUdhUlBzRDBQbXFUNVhpcjluT29qbVlEcng1?=
 =?utf-8?B?UUFVbHo5TnZDeTZaWG0yUUtvYi9JOE1IUWlINGR5U3Y1N3U3ZmRVMllCMWJ5?=
 =?utf-8?B?MmRXZFpHbFNyNEZqWGU0Q1ZsT2pQbW8yTFdEb3RBVllwWTVISWVSV0t3MUo1?=
 =?utf-8?B?TVMybU1WTkFqbUJwRmY5Z0JBNkg4RE9zcml6bjVORXQ3U3FCR1VPTFZubFFL?=
 =?utf-8?B?WWVsK3A4dlByNHlaT0VwcFpjTFU5ajNkUmNTb3RMNFJCMjJzNW9NNno0R3lT?=
 =?utf-8?B?NzE5NWk5eFJoWlRhYWRrNVpOLzEybHh5Y2FFc3N0bXgrbWZTR3E3UGVFZzJZ?=
 =?utf-8?B?SHhubTZJZzBXZG1rbXVLRk9laEFybS9uT00wdlhNaXhta3FSWUwzajB5dmNS?=
 =?utf-8?B?SElEYVFGQXNJanEwelJuSnpQM2dmNnN4aGd2OHB5aXRuZlM3d2QzNG1TRUNS?=
 =?utf-8?B?Qk9YbVBDdDNNOVl0dDNyTnNsOFVHTXdVMjIxWVVpNTRWbUJYZk9QWi8zZ1du?=
 =?utf-8?B?T2k3ZWc1dkwzT0FWcHlOMmNHNTc5ZmJFbFNOdDd5czZSQUI2UE56MGdhTHlx?=
 =?utf-8?B?UGR6TmtyWFhpNnFBaHFRSmtQbnBaMkV5N0FPbW1PbzdXcWNzZWFBVWovbFll?=
 =?utf-8?B?K2t4VVUzcjgrbm84OStRYjE0WHlCTmlUSGxMYStqOGY2RXB1RndBVC9odVBi?=
 =?utf-8?B?Ti9oT1c4aExURGdtaFg4L0tiek5Ia1ZMSTMxTXlzRGxpakpQY0VPQkFoVm1r?=
 =?utf-8?B?Znl1ZzdTaTJ2NHRZTDluUXgyem0xWkpUbUlHWW52aEY3WFNaek1HY2hEL2Nk?=
 =?utf-8?B?VVdhTGI4WWY3dnAvR1ZZdlJ1UFhvNllNUForczFRS0EvOVAxQ2EwbTJoZ2pp?=
 =?utf-8?B?dkdYc2poZzV2OGcySVZuNlozQXNKQ2dlbi9HUUZvc0h2a0Q2Q01VaEFXS3N5?=
 =?utf-8?B?bnJxeVFudWNWclk2NytWa21TVnYzMURWNlNDYldvYjFycGxxaUgxY2ttTThV?=
 =?utf-8?B?aFg2TE9FOXRzaENPajhuRkRjckI5bzQwR0kxbkgzaGgvcXgyYXBidDBoUFg5?=
 =?utf-8?B?V2o3T2ZCV1pTc1d3ZVNRYWg1MlVLbnVuYVlvcWRJZVBDKytQNGxwTTd0ZXpP?=
 =?utf-8?B?YytEd1IrUzM5WVZSRk5kdnhTU3hCKzJrVVJSV3NNbTBURmlIVWVUdXp6Y3RG?=
 =?utf-8?B?Mjc0QndlOElSYlNOS3Z2VzR5TmRJSzgrTjJUbmg4cnI3RTdYR2s4Q2pRckRY?=
 =?utf-8?B?WC9KRFZrbExzZXdZVFV2RWFNMVNoZi8vVEdrejU4WXVYRXk3UFBVYUhEYWMz?=
 =?utf-8?B?Y0tNU2Zkek8zYUJWYTJyS2ptdTArRElubHgrYkRIckd4bkFIMC96VVNXK09r?=
 =?utf-8?B?Qm5rcU1wWEEza20vb1p3WlBDVnJNOWlqWEVhaDRnakd2cjZHMWUvN1kxejNo?=
 =?utf-8?B?ODV2V0JGMSszWlJaY2Ira0FqQ1BNcmNEa1ZjcDh3eVRGbVVBanhrNFZyTVgw?=
 =?utf-8?B?cWVKTkYxRXY1MWFJNzZDcVgvOWZyMTljOFY5UVpmeUZKRzJ5cUQwZUwrTThv?=
 =?utf-8?B?V2Uxd0E1RURpZHVKaHQxM1Q1eEpoMnd6cXJmcWd2cC9vdmV2ZTJ3VDJPeldH?=
 =?utf-8?B?K3pmaElpZmF5Kzlpa2h2TGNKNkVIbUhBSzJiTUV2N040UTlPRDNWdlVPa0JX?=
 =?utf-8?B?VDV3SFN1M3VqKzdVNjZLc1RveUN5MEYzeXdWYTc2OW45RlRucTYycEIwZGk2?=
 =?utf-8?B?UXRXa3J0TVN2TDRqdkRCSkFicmhVWFBkOEZRalNzajIvbXBjZE94TTh2S3No?=
 =?utf-8?B?U0MzNzVTVmhVNitwT3B6SzduR0lOcytZV01GY2RLdTBKcjc1UWxNN05pWXVC?=
 =?utf-8?B?UW1wNkxYMTB3R1VnY2hQMVFPZ05ZdXUyTll5V1F6MWRNR2w4V3d0OHpVN05B?=
 =?utf-8?B?YmtPL0pCS2Y4K3ZabG5SUXQ3T0g3SDVSTTcvTUozVE5WN3JjVE13SDhXV0xl?=
 =?utf-8?B?OXRBeG5Za3hPTlhBTHc3U2NBNytxSWJXd3lVamRid1JMWWNab005QXJ1YzE1?=
 =?utf-8?B?V1RHc2pFRmFtRHBDQ01ONzIrRXFQT0VWUnhuTTVIaG11SmxHMFUvcjF2MEJW?=
 =?utf-8?B?dGJBZEQxWjU5c2ZoUFVid1RCOU5sREtIWk9lRFNGQXR4a1JPU3pYUXQ0aVZj?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cc1660-ab49-48d1-2276-08db7f6ce673
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 04:36:30.7347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9hqpDB46fosg6BrMaGRiAP2hF8hgDmuSPk4QmnTaYUw8gtE19xOgV9vHSeUWkQtsB9fD5c2BywcxjRbUkZrFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5121
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/2023 12:02 PM, Matthew Wilcox wrote:
> On Sat, Jul 08, 2023 at 11:52:23AM +0800, Yin, Fengwei wrote:
>>> Oh, I agree, there are always going to be circumstances where we realise
>>> we've made a bad decision and can't (easily) undo it.  Unless we have a
>>> per-page pincount, and I Would Rather Not Do That.  But we should _try_
>>> to do that because it's the right model -- that's what I meant by "Tell
>>> me why I'm wrong"; what scenarios do we have where a user temporarilly
>>> mlocks (or mprotects or ...) a range of memory, but wants that memory
>>> to be aged in the LRU exactly the same way as the adjacent memory that
>>> wasn't mprotected?
>> for manpage of mlock():
>>        mlock(),  mlock2(), and mlockall() lock part or all of the calling process's virtual address space into RAM, preventing that memory
>>        from being paged to the swap area.
>>
>> So my understanding is it's OK to let the memory mlocked to be aged with
>> the adjacent memory which is not mlocked. Just make sure they are not
>> paged out to swap.
> 
> Right, it doesn't break anything; it's just a similar problem to
> internal fragmentation.  The pages of the folio which aren't mlocked
> will also be locked in RAM and never paged out.
This patchset doesn't mlock the large folio cross VMA boundary. So page
reclaim can pick the large folio and split it. Then the pages out of
VM_LOCKED VMA range will be paged out. Or did I miss something here?

> 
>> One question for implementation detail:
>>   If the large folio cross VMA boundary can not be split, how do we
>>   deal with this case? Retry in syscall till it's split successfully?
>>   Or return error (and what ERRORS should we choose) to user space?
> 
> I would be tempted to allocate memory & copy to the new mlocked VMA.
> The old folio will go on the deferred_list and be split later, or its
> valid parts will be written to swap and then it can be freed.

OK. This can be common operations for any case that splitting VMA triggers
large folio splitting but splitting fails.


Regards
Yin, Fengwei
