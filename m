Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6297405CA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjF0Voc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjF0Voa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:44:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA59B2706
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687902269; x=1719438269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Svsx6iLkTeK0LMangiMD1jOJsXTrHAZiBNrsTtgiQuY=;
  b=XVwPowF4ZQ2GhBFqsPaHBhHR0BWwMVf6EpQKuDId+E0BsC/gRcg4aZuI
   SiJQlBsJl9JTr82oeVWxhVkxbTNFty0FtjDm2Ob0Wr3d+QAPe3AmMq5WB
   YX3G2KBrvpfO/d+YKTsbqEl5UjJh8k9NSfQpUwlpWV4+4K+mKckJCYwsg
   2Bfz3xlc6+pTadaHiM6cOgPom/TgUC+38LkFnUW3+KofKNXtaZsCqv15s
   MOgeYopfgpe4uBrX4Nsj5ovxWEOMBJr37Hb+9YtKHpkKEcbA9rtbmefBk
   yIwZqgfmMq/CslKdMP3Uvit2unN7rXlYy4WnL6URu7FnPeYNZu/xi4IGP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361730451"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="361730451"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 14:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="861255577"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="861255577"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.78.231]) ([10.209.78.231])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 14:44:14 -0700
Message-ID: <1982e4b4-3858-d456-6c90-92782b95726a@linux.intel.com>
Date:   Tue, 27 Jun 2023 14:44:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] x86/misc for 6.5
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
 <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/2023 1:11 PM, Linus Torvalds wrote:
> On Tue, 27 Jun 2023 at 04:00, Borislav Petkov <bp@alien8.de> wrote:
>>
>> - Improve csum_partial()'s performance
> 
> Honestly, looking at that patch, my reaction is "why did it get
> unrolled in 64-byte chunks, if 40 bytes is the magic value"?
> 
> Particularly when there is then that "do a carry op each 32 bytes to
> make 32-byte chunks independent and increase ILP". So even the 64-byte
> case isn't *actuall* doing a 64-byte unrolling, it's really doing two
> 32-byte unrollings in parallel.
> 
> So you have three "magic" values, and the only one that really matters
> is likely the 40-byte one.
> 
> Yes, yes, 64 bytes is the usual cacheline size, and is "traditional"
> for unrolling. But there's nothing really magical about it here.
> 
> End result: wouldn't it have been nice to just do 40-byte chunks, and
> make the 64-byte "two overlapping 32-byte chunks" be two of the
> 40-byte chunks.
> 
> Something like the (ENTIRELY UNTESTED!) attached patch?
> 
> Again: this is *not* tested. I took a quick look at the generated
> assembly, and it looked roughly like what I expected it to look like,
> but it may be complete garbage.
> 
> I added a couple of "likely()" things just because it made the
> generated asm look more natural (ie it followed the order of the
> source code there), they are otherwise questionable annotations.
> 
> Finally: did I already mention that this is completely untested?

fwiw long flights and pools have a relation; I made a userspace testbench
for this some time ago: https://github.com/fenrus75/csum_partial
in case one would actually WANT to test ;)


