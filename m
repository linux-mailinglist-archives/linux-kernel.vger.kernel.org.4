Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3B6FC662
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjEIMau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjEIMar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:30:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336D340F7
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683635445; x=1715171445;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=p7bYc0V62rfjpFzqcJgOchYUFJWaxuiB7eHXrPpBDAA=;
  b=jxL8VRWTILqCtfUhLgc6OoHjSwiy7MRhi1UK/QqbvWXPTz/X5dBuauCb
   NilFPQT/fKZOVJ0u46OwRV+KlblscxE+l7KbhXn1UX1cf3CELyVwQh1wl
   KJW0VJndceOOqWqRl1q6K019sfUy7QkwtYw7Fv6/1dqcfhfXsin204oOG
   Dj9Ss/nmfeaTpt1mjHBR8ifGfyQPflVG6aH6OkyDfRK+8egS8TFXiBgj8
   JsB5bexlbuW+2gvkp8R7cLVP54WEcQTH436VpF0jQmNnn1B495eZs8/SS
   ZH+WvtsHBpfwsb4sNiomQtPumvD1QbVN5+qslS1wFOssORaZ4Ex28G3sU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="329534252"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="329534252"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 05:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="692980266"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="692980266"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 09 May 2023 05:30:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 05:30:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 9 May 2023 05:30:43 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 9 May 2023 05:30:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLT3icJa3niV/TTvYYiQfDaA5pf1BOpS8t9Dbu+t3X96u44Xu8uVVuNy9tGxSuNP1cNsAEHOX09C7Dbv2h5Yh5NPLXejNEIfPongjTszttcNoBM4gFOrkzO0Dex+abAYORpyTqam1Mf8X+WGLFxvZeKK1T+oYjBURKHoDCVBZ3lm5WS02CjXsuwAQZYCxzbm7d8dPUUrBrQ1jIQ7lYxeHAFkJDiV/5p18Jcflg7KKRa8CwI/IXjo5cSwmTVVCCZdF58RKsfldkgDJTuzG6X4DvjnfdjBc5Jt7fGwZ1j/TRBgOn7Golm+zPvBGYwlncK/pBmXSSMaKaPhRLjAPeOhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaCH2OpacfFb7GULglF7zAU1iyObP7TZ5Z1FQd6i5C4=;
 b=P55nlyfO5PBT0H1L1DB5TXJjo+ccwIV+g3+YiGQeU8gH0aptHkqfH9avdgek0vwvWHgjy3sodgSS3THsMnuILOWXuPm5284t2F0KShvAvhm0AJLaOx6RIX1zsbuySS6C+IZiy0nZvWO1vvwBRUygpFJmQmKSPv8hf/BHExKe25v8YG9AFvEmSQg9d6Sjj51xKm2QjAkigXFTNTftY/rlOgxgGByA80t/fWfO3Y64K4K3Dj3j9aimTH1uuaRrj/Qd4Yq3YIe/vEJD6/5Ga8rvmuqKaY04cPBqyGmR+Zbsu/SQNoA0N1IMojHP3tbEUu6Po+mkd1CWTXhDHYFoO7cAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ2PR11MB8585.namprd11.prod.outlook.com (2603:10b6:a03:56b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 12:30:37 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%8]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 12:30:37 +0000
Date:   Tue, 9 May 2023 20:24:47 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     kernel test robot <yujie.liu@intel.com>,
        Frank Denis <j@pureftpd.org>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        <ying.huang@intel.com>, <fengwei.yin@intel.com>
Subject: Re: [linus:master] [x86] adfcf4231b: blogbench.read_score -10.9%
 regression
Message-ID: <ZFo7j/M1suY/Ey5M@feng-clx>
References: <202305041446.71d46724-yujie.liu@intel.com>
 <CAHk-=wgYqsXvK0zA0o061NSkc=dXX4LoP_4m41TyskN9RHrojQ@mail.gmail.com>
 <CAHk-=wjMz_=WyfQMx1ebofeq+w6Cr_kRcJ1Xc=D6iKc4My16bQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjMz_=WyfQMx1ebofeq+w6Cr_kRcJ1Xc=D6iKc4My16bQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ2PR11MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bc281d-6e7c-4f18-b211-08db508930e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMIWrrjpmg8mFWlsFg081X6yqYAijMvkCHtufpygWf1HDS4ifEBWumuRUcTLc//pRI1scQBGsQeHslO+DOkJ2BbCkrlO8ukZRTV6kXC4wtVGunmzzUQxMiHQQDO5RlhLE/zJTInTUpLomKIv3fb2W2Tqhj8WYdQM6WnbyAmgZT+rDf2g+KQkC/3aHHwwVXDGWBM8J81hMXEGOfE2ELi/OZM7FzC9H7b5SwmX7/ojvYPoAjJmHST2PDT0NvH25ujoF1Eqc3wJFoJphY3LTTgjU5qVoiGwq3HUyrirz8vJch0nlbmq2GpKcdaDatVENCZCJ06ImrBC0ZOc8xJixbY43Q9r9rhQHufA33IPYbWpRCPN8G6SMEEVnmeD8j8BEZ+0rLaIbSGwDnjznw82aXNT3CdDOGSe7xZVIp2HTDIRjZvy+ASTzRJIyEaWGm0L27aKgp5BPTVeSviJjAZ50gECDAu26Y558cRHW0wyhavXH2V8KpYVfaLwvYvJvTXZVH3rNVBxRZQrxJYFezJImYaEQnF1ga6TpsjVtaVnxTeSfGUm46R+pKiuO/rmtWpDf2Qz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(66476007)(6916009)(478600001)(4326008)(316002)(6486002)(66946007)(54906003)(86362001)(66556008)(83380400001)(26005)(6512007)(6506007)(53546011)(107886003)(9686003)(6666004)(44832011)(5660300002)(2906002)(41300700001)(8676002)(33716001)(8936002)(186003)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3A2R1VsdmRoaW5PZTdyMldxZTJLVXFML1ZuejZad3JQaVh4UmhxaFRzNFgw?=
 =?utf-8?B?eGVIckJ4VkJHamprZmRpc3pHckExWkwyVm5rTGlrb1EycmV2T3kwV2pUeXg3?=
 =?utf-8?B?R0xlV0lvbWFKSmh2Z0hWZDFidGZiTFN1ckpJS0ZQOTN2OU9RTE5EcUJJYmh5?=
 =?utf-8?B?WXpRd3hNQWtsT0g5dEVhK3ZabFhpTFJCVEFQRVc1a25sY1RUemtCdmk2QWVz?=
 =?utf-8?B?Znpad0FwZ3FBTUlOcllEYXZuYyt0cVJyODRIaFkwSU9RVFcwajZjTDhBMkQy?=
 =?utf-8?B?NC9NYnhXcFhReDhETTF6K1dTNXJCZml4bUFORmhNV0pVb2d4RThYNzg4NnB1?=
 =?utf-8?B?cVdnM0pueWR6QkZTSlMyajhadnNYc1MzbTBaOHlFUFUxOWduWWtqTUVlZjhB?=
 =?utf-8?B?TlIxcDd0UHpha2lDNndaTXd3ai9NQnBoTlpOa3pVNUdhSmNBTmI1N3JtSEdX?=
 =?utf-8?B?WWtlV0FjemhNNUhGdWNMTXVRcE01Q2szZTFzSVNUWDJHYXFQWkRVQlZRNG1Z?=
 =?utf-8?B?N2x6bzVDdENiK2hzQzhhaVh2YjIvenp4RmtDZ1RLeG1xeDJTNnhCWTlUL2xT?=
 =?utf-8?B?cVExUCtXOUdPTTZieThkem9pdmtPQ1JSRndpS2srUWxSMW15STZJNVM4VkdW?=
 =?utf-8?B?emFNKzRYR2xZK3IvY05yRTRHdFRydmV1aWUwT25yS2VSVFRvU3dnQzRuNlNB?=
 =?utf-8?B?QnpwNDh1eEFqMnlwMTUrRjdlcGxuRldPbWFJcWVFcXg2aHJlMHlGZ0F3WHYy?=
 =?utf-8?B?cURsd1pNVU1JVFlISStCZ3ZJc3ozTzFycHpEVWV3VERQUHhGZ3BOT1d4d1dX?=
 =?utf-8?B?aktnT21vdmpRWTB1SlFxdDZuUGI5M0I4T0Vab3haRmNiQ2N1L1kzVmUwMVlX?=
 =?utf-8?B?Ty9lWjJVYVp5TG4yc1VoS1ZNb2FUTXYxZGdwYmphbWx0am4rM2dNRklyWjFt?=
 =?utf-8?B?YVY3OUhId01XREYxR1VkWjBEdmhBUldxNnh2OWtmR090NnR1Q2xJdk16TEZ2?=
 =?utf-8?B?ak9jbno0ditoditieE1wOWVzMFJJSVpxOVlPWkJzM0E0ODVtNy85QWhScVVy?=
 =?utf-8?B?UnZMaVJOY2ZpbmRraVI5K0tYeG9GL2hTeHBmbHQ3bWUrVmpEWFcwRjVLMmFS?=
 =?utf-8?B?TTNyaktQTUlyYUEzaGlBWHVzV3FzdGdRYkI2dnhRQ0diSkpBUlpCa0Ewcng1?=
 =?utf-8?B?R1drZzFuNDVLT29aWWM2SUF6NlpqN3BuTW44cUdUb0FSanB0MlhJelA5MStE?=
 =?utf-8?B?VGpETVdSTFk3ekVqdFQ0M0NKc3ZyekdRbXpaT2ZkN3VmOGF2Z3hYYVhYeVhC?=
 =?utf-8?B?SGh3QUk3cUhSZXVvMHJhTmwwYlZUK2dUQVZJRlh1OXR0Z3lCcnFLYmlWKzFI?=
 =?utf-8?B?MjM0YWJ5cEg3aHhCWWhIdUV5Y040M2hxRTl0VVBYNkk3RGE0WC9wMXQyVkhq?=
 =?utf-8?B?L0kxNVNmMnVrd3h0ZzVvTXdsSUl5eXNUTDBaNStZN0h2R1RVbENTZ1lHMDl1?=
 =?utf-8?B?OFhmSjc2MzNwaCswbmJPS3FscitvTkJ4ZFRaRTBTL3A1Z0I3MDFzQ2M4cnhX?=
 =?utf-8?B?SzJlZFFIZkJSOC96a1BYSmROL0RDaXc5eTBpL1g5QUhLa0xrb2RPR2xIbGRT?=
 =?utf-8?B?bGQzNHdOd29IcHlqb1JmVFpXSFkrQTVkNmtOTkYrZjFlaHFuWWtXMTRkUElk?=
 =?utf-8?B?VDV1ajE3bytzUVBVVWNWa2pxY1hQeUxqVDFkckVGZXVpeUJzZGN5cW9vZ1dL?=
 =?utf-8?B?N2c4cHpTbStqbVZVNkxQZm9zRWZhOTFFblpKQUZydEJFZnptckh3NjFEM0Ft?=
 =?utf-8?B?RE1hbnpkSS9YVkVoTEVpYjBwMVU0WGt5cXJmTENVbmJNeUFHaENQRnZJRDNI?=
 =?utf-8?B?SkhRNEx0SndCTTZtc3RWMlVaYzBTSGZLRkU1L011NGsrcS9pdGtLR2lCUmJ2?=
 =?utf-8?B?SUtCNThIdVRsY1BWRG1UREdzMXpzSEpWL3BrdGFyYWZSNVNjRTVocTJsL3ZF?=
 =?utf-8?B?ZVU5empEcjYvTndaSnJucjM3ekVNVTRsdXZ3OVlva1FJT2hrUmVrYnhDZkFX?=
 =?utf-8?B?cENjd2V1NDY0bmRldThGLzlEbjU0RjErc0dIQ242NHYvS0hOK1BGcGhoVVQz?=
 =?utf-8?Q?Ht8pDtvcM3/tfXR9hC7jioOUb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bc281d-6e7c-4f18-b211-08db508930e1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 12:30:36.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnBOKlZxXaCMZOKDFwaFcq54JPwjukev+YKAmmnqMIUMAqET7JBefe/E5Tz1Bgzh80n2M8y2u1jmriPJHENmmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8585
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, May 04, 2023 at 11:56:12AM -0700, Linus Torvalds wrote:
> On Thu, May 4, 2023 at 10:39 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And I suspect that the 'blogbench.read_score' thing probably does
> > mostly big reads, and really really liked the cacheline optimizations
> > of 'rep movs' even when it was slow in other things.
> 
> Oh, and I went to look at the blogbench code, and it's a
> *horrifically* bad benchmark for this case.
> 
> It may actually be a good benchmark for other things - the "look up
> random filenames" etc might be somewhat indicative of real performance
> on some loads.
> 
> But the read() system call part is very much *not* good.
> 
> It looks like the reason blogbench likes 'rep movs' is the traditional
> reason why memory copy benchmarks tend to like uncached copies: it
> looks like the benchmark doesn't actually even look at the data it
> reads.
> 
> It's a common pattern, but it's a bad pattern. It's not very different
> from doing CPU benchmarks using an empty loop:
> 
>      for (int i = 0; i < 1000000; i++) /*nothing*/;
> 
> and then being surprised when the compiler optimized the loop away
> because it doesn't actually *do* anything.
> 
> Of course, unlike the empty loop, the kernel will still do the reads,
> but the kernel will do the reads with the assumption that the result
> matters.
> 
> And for blogbench, that is *doubly* not the case.
> 
> Because it looks like blogbench does a loop over
> 
>         read_dummy_file(file_name);
> 
> which will open that file, and then loop over
> 
>         #define READ_CHUNK_SIZE 65536
>         ...
>             static char garbage[READ_CHUNK_SIZE];
>         ..
>         loop:
>                 if ((readen = read(fd, garbage, sizeof garbage))
> 
> and that variable is very appropriately named indeed. It is very much garbage.
> 
> So it really looks like what is going on is that you have
> 
>  (a) a threaded application (looks like N=100 for reads by default)
> 
>  (b) doing 'read()' calls into a *shared* buffer in parallel
> 
>  (c) and never using the buffer for anything else
> 
> which means that a memory copy that does non-temporal writes is going
> to look artificially really good, because nobody wants to ever see the
> end result.
> 
> Now, the "nobody wants to ever see the end result", might actually be
> at least _partially_ valid in some historical setting, if you were to
> use DMA to then push things out to a network. Back in the olden days,
> that was actually a valid reason to use non-temporal writes, because
> the DMA would have to invalidate the caches anyway.
> 
> So that part is wrong, but isn't necessarily *horrifically* wrong.
> It's just bad.
> 
> But using one shared destination buffer for N readers is *completely*
> bogus. Any cache-lines would bounce around like crazy for the
> (pointless) sharing. I'd like to call it "false sharing", but it's not
> really false: it's intentionally just using one big shared buffer as a
> sink for all these read() calls.
> 
> End result: I think the benchmark scores for reading are entirely
> pointless random numbers, and trying to optimize the kernel for this
> benchmark is exactly the wrong thing to do.
> 
> The benchmark doesn't actually do anything half-way valid.
> 
> At a *minimum* that benchmark should have different threads using
> different read() buffers.

We tried a debug patch which allocates a dedicated buffer for
each reader thread, run it on the same Cacade Lake platform, and
the regression is _gone_, after the noise of cache false sharing is
reduced.

20f3337d350c4e1b adfcf4231b8cbc2d9c1e7bfaa96 
---------------- --------------------------- 
   2119572 ±  2%      +1.7%    2155704 ±  2%  blogbench.read_score

   3700996 ±  9%      -7.4%    3427562 ± 16%  perf-stat.ps.dTLB-load-misses
 8.171e+09           +25.3%  1.024e+10        perf-stat.ps.dTLB-loads
    431224 ±  9%     -13.1%     374903 ± 12%  perf-stat.ps.dTLB-store-misses
 2.399e+09           +87.5%  4.497e+09        perf-stat.ps.dTLB-stores
   8495507 ±  7%      -8.2%    7794738        perf-stat.ps.iTLB-load-misses

      3.07            -3.1        0.00        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.00            +3.4        3.40        perf-profile.self.cycles-pp.copy_user_generic_unrolled

We also run the original blogbench binary on a IceLake platform
(which has both ERMS and FSRM), and there is almost no peformance
change for the 2 commits.

Please let us know if you need more profiling info or want to run
more tests. 

Thanks,
Feng

---
The debug patch for blobbench is:

diff --git a/src/blogbench.h b/src/blogbench.h
index bf538a8..d99d5bb 100644
--- a/src/blogbench.h
+++ b/src/blogbench.h
@@ -178,6 +178,8 @@ void *rewriter(void * const fodder);
 void *reader(void * const fodder);
 void *commenter(void * const fodder);
 
+extern pthread_key_t read_buf_key;
+
 #include "globals.h"
 
 #endif
diff --git a/src/helpers.c b/src/helpers.c
index 4c17e73..85631ec 100644
--- a/src/helpers.c
+++ b/src/helpers.c
@@ -107,15 +107,18 @@ int create_atomic_file(const char * const file_name,
 
 int read_dummy_file(const char * const file_name)
 {
-    static char garbage[READ_CHUNK_SIZE];
     ssize_t readen;
+    void * read_buf;
     int fd;
     
     if ((fd = open(file_name, O_RDONLY)) == -1) {
         return -1;
     }
+
+    read_buf = pthread_getspecific(read_buf_key);
+
     do {
-        if ((readen = read(fd, garbage, sizeof garbage))
+        if ((readen = read(fd, read_buf, READ_CHUNK_SIZE))
             < (ssize_t) 0) {
             if (errno == EINTR) {
                 continue;
diff --git a/src/process.c b/src/process.c
index a83a980..04f1411 100644
--- a/src/process.c
+++ b/src/process.c
@@ -58,9 +58,13 @@ static int wait_rewriters(void)
     return 0;    
 }
 
+pthread_key_t read_buf_key = 0;
+
 static int spawn_readers(void)
 {
     unsigned int t = nb_readers;
+
+    pthread_key_create(&read_buf_key, NULL);
     
     do {
         t--;
diff --git a/src/reader.c b/src/reader.c
index 91bab7a..2c0efdb 100644
--- a/src/reader.c
+++ b/src/reader.c
@@ -66,6 +66,11 @@ static int read_random_blog(void)
 void *reader(void * const fodder)
 {    
     (void) fodder;
+
+    void *read_buf;
+
+    read_buf = malloc(READ_CHUNK_SIZE);
+    pthread_setspecific(read_buf_key, read_buf);
     
     do {
         if (read_random_blog() != 0) {
@@ -75,6 +80,8 @@ void *reader(void * const fodder)
         usleep(USLEEP_READER);
 #endif
     } while (stop == (sig_atomic_t) 0);
+
+    free(read_buf);
     
     return NULL;
 }
  
> I suspect it might be a good idea to also touch some of the data,
> because that would be the normal situation (even with old-style
> zero-copy DMA you'd probably not do raw file data and push it out to
> the network unmodified).
> 
> Because otherwise you will always find that objectively bad memory
> copies will do better than a good memory copy that makes sense.
> 
> Anyway, that was a very long-winded way of saying that I will not use
> that benchmark as a reason to touch the kernel "copy_to_user()"
> implementation.
> 
> Of course, that's not to say that this might not be a real regression
> on real loads, but I'd want to see those other numbers.
> 
> It looks like this is an old benchmark that hasn't been touched in
> years (just going by the github activity), but I'm cc'ing the author
> anyway, and will add a pointer to this email as a github issue. Maybe
> the developer cares, maybe he doesn't, but no reason not to at least
> mention this and see if maybe the benchmark can be improved to at
> least use a thread buffers for the reads.
> 
> (The same issues are true for the writing side too, of course, but the
> writing side has less parallelism and a shared *source* is not the
> same kind of problematic from a cache pattern standpoint, so probably
> isn't going to have anything like the same effect from any memcpy
> implementation).
> 
>                   Linus
