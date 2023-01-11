Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB16651C4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjAKC3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjAKC3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:29:36 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4C164FD
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673404175; x=1704940175;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PFHTfHjeoIXPv/P0Z1wA1Qnho44eD9MSLiNH2/pY4Lk=;
  b=ZNXftcQtbj5uVlI7jD334W6+2RFWnHcnxiLM/KLBqji+HUoj7xOYIgJN
   7dcpdVwDcxnSGiIT8vLui1mxQtDTscXllhJufjhFgXHysIt15RImCfjnu
   g5A0SofHeFIXA4LXRxsiGqgFAYvyvxG0FKcxl2WWGlVLp+IJ60VH/FiyB
   mwE53Ze//CYhbYAsdVAPnp/jhLTRnl4niwcf9PIis+tIy6d4qGAcnKt6h
   jw4nTeONUo/UZANANfmS9XU+JdPy9AhDS5HVThx+y/89wMqj3jxmm8I+K
   TKZlKRgcb6MSor4EqawxY+D1HGSHBNoNdYPr9+PskQN8ErD3A1xPtrUle
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="306828239"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="306828239"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 18:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607194193"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="607194193"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2023 18:29:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 18:29:27 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 18:29:27 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 18:29:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWoxuA1I/gsc/gizKWRNS/LJfeeBPyRguXKkNmiommQgUu9Vxe3kD/EGhRIHptZSfvmHD6cYZH1t+So1J8vHHdVUbExYFFf23WADAMOmg70g3K+jBuP6p88D//6AH5pY0paAVCToDk2CrkDOHVMwiTSPLHA/6fH8dAtIWrJ0QDSlnH8t16yXDyTuskHmyTpFAZ5zaj2iTLy3fXHVG/hXOT5vLvXYYjwl0tDLQXdQAiyFGAhwwJ3BaabNQFwpSQ1IlCmEXhkNpXRzc9ct7KnVlKXIJGhRkKWn7rKIrLiGAljMa3D0VkM7i5MrNPUChbfzVW7A07ZxtTwcEJmEoN9Nkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpzCd6FgsNNwcshRKYG7VtA2FxnpBMvxFIkJQoprIek=;
 b=OzIBDJrkpB2XoYkPB072fmK5mH//U4v4NeCCyByOQnTmSISzb331pXkB0T8L84qOSiMIMe8iPddFbN0lr0wpMDRtVCn+mo/S1H8ij69xxtJkSQV/XcIlUEMnqiwABZ7T91FiK3yoL5mXOa4JIlYizprq3J0ppd5v4C6j02gu1mmVITGMJ5hXrjwbh1W04mZ04Xju9WAvy+9YtmUMpP8SjvGHXKpbaQGigrPl2f0pwsojwInpOmOxt5gPQR7uFFY0kXu65QX8LQCG7TOt8ambikTHDtGUBuzuQzvB+gbMkSdkhyN8M19Z2MlE6MqpKsZUOfyW59Ie3ciWQGkudaDDdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH3PR11MB8137.namprd11.prod.outlook.com (2603:10b6:610:15c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 02:29:24 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%3]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 02:29:24 +0000
Date:   Wed, 11 Jan 2023 10:26:40 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <Y74eYCOBkRKlQN+H@feng-clx>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020>
 <Y7VBFLHY/PMbb4XS@hyeyoo>
 <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
 <3f7fa3b3-9623-5c4c-94b1-a41dea6eaaf2@suse.cz>
 <Y7weKyxIY+QFYq6j@xsang-OptiPlex-9020>
 <Y71t89JMgtRoNHM/@xsang-OptiPlex-9020>
 <d024b846-9282-4ecd-eafd-2e5571932a72@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d024b846-9282-4ecd-eafd-2e5571932a72@suse.cz>
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH3PR11MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdc37c0-a345-42a3-e9c1-08daf37ba787
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFEoASoFUcPIZDUNgQuSPB7oDtjCTI+QECXq8RTxQFT5QjrlbzaBtedy5jBhLbRJaNxTvhPphANfX+ue6yamAhSL6nEPTSE09svvZDWeMXRx51BgdfIWg5l1Xjm4ykGbbQj4FAbjyXUbMBx49BsOp6rvhmG01ptXprJhW82TCjOvDJu55Uq/rjwJg0G7CVq8QB45sjIqelJYzhJTAMODu1OcQ8x7EJ83m8d+1MBjhNLCcTn+WcMQtrll0g61ZKnebs8r8bpP5G8DDIXBxmruOHSU7/1J43ELiFnvApSSqwBaRFJStSJvOssbHdPg9O5LNJ6W0K+6zNywaJyF82F+ZbMCzbLqSmBZ9wog4BGuKTqikJklDWOP9bPrwBe/Y5WUSMNn6NCK1i0AyO5pctVKrPbT9tkfN5KZd8IgSPI8mfLGQBT/P3u5Yt6ITBSI/EEpwtRvdkNrUkOf3JQm5+xd1ngaahbLAsBBsZCeQ80DyCYvym3p4Ho9oyhm3kIfsJ+GsyoK42DFYoUSWOtOFZSO88otQMxpw5Ga+B4q607nyWIH9yEzSdnqDUxD+Fe7rUfbr0anMINJE3nr1PXPWi8v8Eq7S4/Jw3/KnZeNjzmVARbo+IqXxrXC8OfopE9NVUAowBu5/oIn0Xq2Pc8ugVZAzsN/0KFVHbs1jHjwvPSS9+k4F18yuyLP+ffw3WBBHsrL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(6916009)(8676002)(66946007)(66476007)(66556008)(44832011)(316002)(4326008)(54906003)(2906002)(5660300002)(8936002)(41300700001)(83380400001)(478600001)(6666004)(82960400001)(53546011)(6486002)(6506007)(38100700002)(9686003)(26005)(6512007)(86362001)(186003)(33716001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZGgG2B5DZSDkbWbV8hN1N4nLuQQw5+rDTyv+g15y5s1wvlS39exV545JwdN?=
 =?us-ascii?Q?Rjy+l0s9CxyqTb9EFytCmXS5Zhv5rm6UvfqVouzUP4NuDeLHdGSSUHUDfPq0?=
 =?us-ascii?Q?98pvyBZqgtBGq7VTNsBp6r63rgCvwl0+FmhkxLqk32eKiAMqB69qvjQ7lzY+?=
 =?us-ascii?Q?HXu8H1PiWB7sEGVTSdWDWqjEmLI42ty2/OIfRaJZo05IWez2PG1hZ0GjEB8Q?=
 =?us-ascii?Q?CpxThVFpBCWVuqzMB1Z7fzQVqOV4VSkhoJc0AZIHNobdTRFhaU8tKqpK6Xl3?=
 =?us-ascii?Q?UzZocS4XiImNFFnNVWBAHDpD54ZGjazRGgvY/QQkZoJG+mvrTiqivKoxjtbD?=
 =?us-ascii?Q?m5WssclBP48S468ONlMN5f9S8iekd0kbHKg/l702RH92KBwptl8QE4qbkcrQ?=
 =?us-ascii?Q?oMW/wVLRkWYK8+fweFJyPuvl3CV8iNbstFtGSq3ECbvXEblCDlRsPOch0drP?=
 =?us-ascii?Q?c14arHimbnAlPyJBF1dzLsMS8etUuGssqLQxHtAemJZJQHtIUtx1pOfy+K0/?=
 =?us-ascii?Q?JT2NKDESmxlVPI5ohpUpcC7ZU/xIkaIpdxge5BME6U3lsz+91Lif3mvnKj6t?=
 =?us-ascii?Q?J4df6iajUxiGbHUmUYbu5Ez0oM8kOtPa8poX3R1g7VRMWyxFOYywcJ7RYCww?=
 =?us-ascii?Q?h3dd571hDqus0Xoiw93/yOCoAshZ7d8tBQxnazTbPjslhJ58wDm/KwDL7Wj8?=
 =?us-ascii?Q?zJLCH+8lCux4g/RtaRHBcX2k6Q6v6bj3mL4TPZXKEr/f4Q5PqeCcKCuFPA+O?=
 =?us-ascii?Q?j1b4wTzu+xrNkcjJQFJvTn9jMSAedL51kJWBo3c+iVPJEpmHLeQX3GqfRAIV?=
 =?us-ascii?Q?OQHN5p42vi7BnZDKTtGBEc4QrgXBn4N+GSBED+eCVQ8QpJtgKHAMKOA+wMRi?=
 =?us-ascii?Q?biK69x6VzVmaqsjZsPk7mbUKrQKoxBGbK8Hme8IvjM/n6Sn1yzhTcjNjmTJK?=
 =?us-ascii?Q?mlUmbvNwo/9w4cyTRtybg525XpzepMDC4hVXVkNp58QRd633a1TTyALWMPGx?=
 =?us-ascii?Q?SaJA10JbNo3xszcv9PBH1vcId3TIho/BBeZn9He/vkT+tjXnmjV6Jk6zSI5V?=
 =?us-ascii?Q?YxiVvxkHn8/vty8D2ANxlz0DLbfgjTLkQLalMnJ1X2OM4p1pMR2SGUv3wZN6?=
 =?us-ascii?Q?f1TK1QGfrN17xzxXRvjNF2JGjtEayVW/7GEGZGlY8a2fQCu1UqcROeKr2+aN?=
 =?us-ascii?Q?grhGWTBuIDGcjvrITsJqKy4KwAVc+43saBnCbP4no/mAChr43E2xvN9DxBM0?=
 =?us-ascii?Q?xBC3m9e3HQy6slDjD9hm03q/axfweU45cpBCwo05J20YwXOQrxDsv4XCovQl?=
 =?us-ascii?Q?R6cGUH+9ve8OS8EkDSMbPAdsZP0cxX6Q53MVbNWWYXVPwEUK3JnpWnJ9WIsP?=
 =?us-ascii?Q?7DJE/VC+jBi5gSNfgwylFFYK8+2nClOs1rhM/kylRBgQpK32O8371OMpp6n3?=
 =?us-ascii?Q?Iwbh7rDbMF+oSj4htPh7zpT+8+vLUPZVC+heuVUH7G3OLeHYJVw1YNZKVUEV?=
 =?us-ascii?Q?HOj7zdz79DvF3ou19LffSu41d14diIO/BjnHyWHddC0qmm5EHKXS7cSI3WOV?=
 =?us-ascii?Q?AVBVESmO6hBsevxiYexsts6Ret0xlXpIeIwIlQQ7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdc37c0-a345-42a3-e9c1-08daf37ba787
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 02:29:24.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AesML0dDXsOiUnQuEJ7GpWGPt+ObhgZ18UuqdqM5st/eAHjvHJgP9sE3w+decfKHDjPN7AfZKHkp9RrTObh8uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8137
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 10:09:36PM +0800, Vlastimil Babka wrote:
> On 1/10/23 14:53, Oliver Sang wrote:
> > hi all,
> > 
> > On Mon, Jan 09, 2023 at 10:01:15PM +0800, Oliver Sang wrote:
> >> 
> >> On Fri, Jan 06, 2023 at 11:13:15AM +0100, Vlastimil Babka wrote:
> >> 
> >> > And if the rate at the parent (has it increased thanks to the
> >> > DEBUG_PAGEALLOC?) is sufficient to bisect to the truly first bad commit. Thanks!
> >> 
> >> got it. Thanks for suggestion!
> >> 
> >> since 0af8489b02 is based on v6.1-rc2, we will test (both rectorture and boot)
> >> with same config upon v6.1-rc2 to see if it's really clean there.
> >> if so we will use dmesg.invalid_opcode:#[##] to trigger new bisect.
> >> 
> >> will keep you updated. Thanks
> > 
> > by more tests, we cannot make sure the v6.1-rc2 is clean, so we also checked
> > v6.1-rc1 and v6.0. from results, we have low confidence that we can make a
> > successful bisection based on them [1][2]. could you suggest?
> 
> So am I reading it right, that the probleam appears to be introduced between
> v6.0 (0 failures) and v6.1-rc1 (>0 failures)? But agree that with such low
> incidence, it's hard to bisect.

Yes, it's hard for bisection, as it happens at a higher reproduce rate
on several commits, hope it could be bisected soon.

Before Oliver found the parent commit also trigger the problem, I did
some debug, and I think related factors could be compound_page, folio,
slub and i386(struct page size and layout), which cause some compound
page structures corrupted. 

* I tried change the slub_max_order to 0 for SLUB_TINY (much less
  compound-page operations), and no issue is found for 350 runs.

* Disable order>=1 in pcp list, the issue's reproduce rate keeps
  similar, which means the pcp operation is not related.

* Tried add some debug info in unused members of struct page of tail
  pages (not first tail page), or add one more member at the end of
  'struct page', can't reproduce it. 

From Oliver's reports, there are several kinds of errors: list
operation failure (list_head structure corruption), compound page
check failure (PageTail warning) etc, which seem to indicate the
struct pages are randomly corrupted. In dump_page(), I tired to dump
more pages befor and after 'raw' and 'head' pages

[   18.265162][  T186] page:43caddc9 refcount:1 mapcount:0 mapping:00000000 index:0xedece900 pfn:0x2dece
[   18.266205][  T186] head:5e92e8e2 order:1 compound_mapcount:0 compound_pincount:0
[   18.266928][  T186] flags: 0x10200(slab|head|zone=0)
[   18.267339][  T186] raw-2: 00010200 c0100b70 c0100b70 c01a0680 edecd000 00020001 ffffffff 00000001
[   18.268055][  T186] raw-2: 00000000 00000000
[   18.268419][  T186] raw-1: 00000000 e7652fe1 00000101 ffffffff 00000000 00000000 ffffffff 00000000
[   18.269124][  T186] raw-1: 00000000 00000000
[   18.269488][  T186] raw: 00010200 e7652fe1 c0100bf0 00000400 edece900 000a0003 ffffffff 00000001
[   18.270187][  T186] raw: edce5f81 00000000
[   18.270534][  T186] raw1: 00000000 e7653031 00000101 ffffffff 00000000 00000000 ffffffff 00000000
[   18.271257][  T186] raw1: 00000000 00000000
[   18.271617][  T186] raw2: 00010200 00000100 00000122 c01a0780 00000000 000a000a ffffffff 00000001
[   18.272330][  T186] raw2: edd5bf01 00000000
[   18.272690][  T186] raw3: 00000000 e7653081 00000101 ffffffff 00000000 00000000 ffffffff 00000000
[   18.273424][  T186] raw3: 00000000 00000000

[   18.273793][  T186] head: 00010200 c0100b70 c0100b70 c01a0680 edecd000 00020001 ffffffff 00000001
[   18.274534][  T186] head: 00000000 00000000
[   18.274909][  T186] head1: 00000000 e7652fe1 00000101 ffffffff 00000000 00000000 ffffffff 00000000
[   18.275633][  T186] head1: 00000000 00000000
[   18.275996][  T186] head2: 00010200 e7652fe1 c0100bf0 00000400 edece900 000a0003 ffffffff 00000001
[   18.276725][  T186] head2: edce5f81 00000000
[   18.277093][  T186] head3: 00000000 e7653031 00000101 ffffffff 00000000 00000000 ffffffff 00000000
[   18.277820][  T186] head3: 00000000 00000000
[   18.278182][  T186] page dumped because: VM_BUG_ON_PAGE(PageTail(page))
[   18.278747][  T186] page_owner tracks the page as allocated
[   18.279447][  T186] page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 186, tgid 186 (udevadm), ts 18262675212, free_ts 18262044539
...

The page 'head' is actually 'raw' - 2, while page 'raw' seems
corrupted as it has PG_head bit set, while PageTail() is also true. 

Another problem is 'raw-1' and 'raw' both points to 'raw-2', and
if it is an order-2 compound page, the 'raw+1' should also points
to 'raw-2' as 3 tail pages point to one head page. Or there is some
switch(corrupted) between order-1 and order-2, as Vlastimil
supsected in earlier reply?

Thanks,
Feng

> > a further information not sure if it's helpful, [1][2] are both i386 based.
> > we also tried to run boot tests on x86_64 upon commit 0af8489b02, whatever
> > with or without CONFIG_DEBUG_PAGEALLOC/CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT,
> > we never obseve similar issues (also run 999 times).
> 
> Yeah it looks very much like something that manifests only on i386 (perhaps
> only in QEMU as well?) and never x86_64.
> 
> What might be interesting then is v6.1-rc1 with further modified config to
> enabled CONFIG_SLUB_DEBUG and CONFIG_SLUB_DEBUG_ON. Maybe it will catch the
> culprit sooner. Or maybe it will obscure the bug instead, unfortunately.
> 
> Thanks for all your effort!
> 
> > [1]
> > boot results:
> > =========================================================================================
> > compiler/kconfig/rootfs/sleep/tbox_group/testcase:
> >   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/1/vm-snb/boot
> > 
> >             v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8
> > ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
> >            |             |             |             |             |             |             |             |             |
> >            :999          0%           2:999          0%           1:999          1%          11:999         21%         208:999   dmesg.invalid_opcode:#[##]
> >            :999          0%            :999          0%            :999          0%           2:999          5%          51:999   dmesg.kernel_BUG_at_include/linux/mm.h
> >            :999          0%           1:999          0%            :999          0%           4:999          4%          40:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
> >            :999          0%           1:999          0%           1:999          0%           4:999         11%         111:999   dmesg.kernel_BUG_at_lib/list_debug.c
> >            :999          0%            :999          0%            :999          0%            :999          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
> >            :999          0%            :999          0%            :999          0%           1:999          0%           3:999   dmesg.kernel_BUG_at_mm/usercopy.c
> > 
> > [2]
> > rcutorture results:
> > =========================================================================================
> > compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
> >   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/300s/vm-snb/default/rcutorture/tasks-tracing
> > 
> >             v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8
> > ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
> >            |             |             |             |             |             |             |             |             |
> >            :999          0%           3:999          0%            :999          1%           8:998         20%         200:999   dmesg.invalid_opcode:#[##]
> >            :999          0%            :999          0%            :999          0%            :998          5%          51:999   dmesg.kernel_BUG_at_include/linux/mm.h
> >            :999          0%            :999          0%            :999          0%           3:998          4%          42:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
> >            :999          0%           3:999          0%            :999          0%           4:998         10%         102:999   dmesg.kernel_BUG_at_lib/list_debug.c
> >            :999          0%            :999          0%            :999          0%            :998          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
> >            :999          0%            :999          0%            :999          0%           1:998          0%           3:999   dmesg.kernel_BUG_at_mm/usercopy.c
> > 
> >> 
> >> > 
> >> > 
> 
> 
