Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AE47406A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjF0Wuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF0Wuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:50:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928C52941
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687906249; x=1719442249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rk1Zya4YN7L4kSRUevCkoBKyaGg7P8Q144xFDaiTCVY=;
  b=eY6Z8GQ6tZ3KA7QdWO6XQmThCc8Grr3iOTOCymEuYGfpEv2UnSKyltGn
   wbz20FoGIVfor5U4e1vFKhzcAQAENw6PsATZzCXTtanwfCr+FalrHxi26
   n9uEVliBHZI29yzan/N3xVUxQaTwJGAdFHHeXQuCp/n4DalLKOVWuTkeG
   0QCDqbzrg780mkyA/fGyOjm8i3oiSx6Vh02MX3rKTmpc/KL1QpIkdcbhc
   1Bpwh4AL2h3iHcT+3hOXhVFDwumPNtIoquLt0erjfbO2WlLtFdYwKFGMS
   C1SM4ZjpTHtfBxRmQbJd9GfPlsSwGj01j7hXnhmVXtZzrdce5TFlvp9oO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="346460977"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="346460977"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 15:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="890837171"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="890837171"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.78.231]) ([10.209.78.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 15:50:48 -0700
Message-ID: <51f58d51-d5bf-79a2-a32a-e6849a118123@linux.intel.com>
Date:   Tue, 27 Jun 2023 15:50:48 -0700
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
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <CAHk-=wgMw2VE8afWp4p6RyJKCvnkhNXx4XUByUOHUWKiAo=WLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/2023 3:43 PM, Linus Torvalds wrote:
> On Tue, 27 Jun 2023 at 15:25, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I don't know what the rules are - and some of the functions you test
>> seem actively buggy (ie not handling alignment right etc).
> 
> Oh. And you *only* test the 40-byte case. That seems a bit bogus.
> 
> If I change the packet size from 40 to 1500, I get
> 
>    02: 185.1 / 186.4 cycles (8b414316) Upcoming linux kernel version
>    04: 184.9 / 186.5 cycles (8b414316) Specialized to size 40
>    06: 107.3 / 117.2 cycles (8b414316) New version
>    22: 185.6 / 186.5 cycles (8b414316) Odd-alignment handling removed
> 
> which seems unexpectedly bad for the other versions.
> 

I'm not surprised though; running 2 parallel streams (where one stream has a fixed zero as input,
so can run OOO any time) .. can really have a performance change like this

