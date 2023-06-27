Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7567406BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjF0XFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjF0XFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:05:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB445296D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687907133; x=1719443133;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FK+q1lr+AwoT9eN4z1p01SBRj2tgSZa1Ch82VpM14l0=;
  b=JRxDGQ8Xi5gpW0KQ+SAY/qOG5F69X/VJN+/LippAfN3DFa23AlEFWiqn
   /FONiifa5CYEPYSD+UX6qirfOb1Y9VsucOfUCgqyU40dAyUF/ZbwosgfM
   pLshPm07tfVR7q7OR7eMhPJl7csjfxN4OqSBd3uKwJHfHcn3bS9fWOkkr
   XR3Sb/DcS9cZ58QcCoDToXKdeauflRWecXyKR2uZJAW5Z3QFceyJRzydX
   kQPxCSAZWHpE3iXL1NA2yq0MgOjghEjKXRTPFhbZVNtImSZY/mDpxjIJd
   6MmMsVC6we0s53iOkSe7JM29ejbGlZgdMEQetWAhygHjW930nZx35rGgb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="341286883"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="341286883"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="782044687"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="782044687"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.78.231]) ([10.209.78.231])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:05:32 -0700
Message-ID: <fe807f09-9e4a-52d6-c057-b159bee55510@linux.intel.com>
Date:   Tue, 27 Jun 2023 16:05:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] x86/misc for 6.5
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
 <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
 <1982e4b4-3858-d456-6c90-92782b95726a@linux.intel.com>
 <CAHk-=wiQEj1cP7tnQ6Uw1jjFYnZmMdNgodga3b+rw98vBBvENg@mail.gmail.com>
 <CAHk-=wgMw2VE8afWp4p6RyJKCvnkhNXx4XUByUOHUWKiAo=WLQ@mail.gmail.com>
 <51f58d51-d5bf-79a2-a32a-e6849a118123@linux.intel.com>
 <CAHk-=wgtrxkRDR95y=U685LMd_ZR5TrLW0_LGoQi3v8Or11Yrw@mail.gmail.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <CAHk-=wgtrxkRDR95y=U685LMd_ZR5TrLW0_LGoQi3v8Or11Yrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/2023 4:02 PM, Linus Torvalds wrote:
> On Tue, 27 Jun 2023 at 15:51, Arjan van de Ven <arjan@linux.intel.com> wrote:
>>
>> I'm not surprised though; running 2 parallel streams (where one stream has a fixed zero as input,
>> so can run OOO any time) .. can really have a performance change like this
> 
> How much do people care?
> 
> One of the advantages of just having that single "update_csum_40b()"
> function is that it's trivial to then manually unroll.
> 
> With a 4-way unrolling, I get
> 
>    02: 184.0 / 184.5 cycles (8b414316) Upcoming linux kernel version
>    04: 184.0 / 184.2 cycles (8b414316) Specialized to size 40
>    06: 89.4 / 102.5 cycles (512daed6) New version
>    22: 184.6 / 184.4 cycles (8b414316) Odd-alignment handling removed
> 
> but doesn't most network hardware do the csum on its own anyway? How
> critical is csum_partial(), really?

the hardware does most cases..
in
https://lore.kernel.org/netdev/20211111181025.2139131-1-eric.dumazet@gmail.com/
Eric kind of implies it's for IPv6 headers in practice


