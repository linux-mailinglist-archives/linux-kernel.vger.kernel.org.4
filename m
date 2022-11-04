Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4B619164
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiKDGt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiKDGtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:49:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4A72DCA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 23:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667544538; x=1699080538;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8BfVOxPqbksXWW429r5a3/bA+9u59z7eqKkCviPvp8s=;
  b=MhiAKoS/qZ1qd2lWxjvFD+5QKT/sf6XNZO66VDvejK/7848Ohw6gykE3
   42zD15zN1LN1XwkphT8k/AUOrYq5t/F4MLp5T7NzhkpxIYI67tDWoW+76
   X2L8s+wcmf+OrqInx9o6GduYHp6oQgAsc1CX6iR7D8CROlEuQigSxldB1
   BVUaKG+I4W6EG1ujI+sL9e/fbNC2IpMF+26Qbsg98zQEzA+30gK15tZhi
   vfHvP9poTYO8KTdM+xHAKNPl3dkNCyNFgH/lx8IKCCYpw2QfB7D+yLsHH
   Ei/rK5xpahcp5vwgLEj9e+q1mF4f9r+divb1JVBbPR5qeF8PgQopk98H7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="311634049"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="311634049"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 23:48:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="668258649"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="668258649"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.215.240]) ([10.254.215.240])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 23:48:56 -0700
Subject: Re: progs/test_ksyms_btf.c:37:21: error: no member named 'cpu' in
 'struct rq'
To:     Andres Freund <andres@anarazel.de>,
        kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <202210270554.FMcABmOT-lkp@intel.com>
 <20221029220425.p6lcwx65e4aqqkiw@awork3.anarazel.de>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <93b22dc2-76bd-f59b-aa86-836863b98b17@intel.com>
Date:   Fri, 4 Nov 2022 14:48:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221029220425.p6lcwx65e4aqqkiw@awork3.anarazel.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/2022 6:04 AM, Andres Freund wrote:
> Hi,
> 
> On 2022-10-27 05:02:14 +0800, kernel test robot wrote:
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   98555239e4c3aab1810d84073166eef6d54eeb3d
>> commit: 600b7b26c07a070d0153daa76b3806c1e52c9e00 tools bpftool: Fix compilation error with new binutils
>> date:   3 months ago
>> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>> reproduce:
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=600b7b26c07a070d0153daa76b3806c1e52c9e00
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 600b7b26c07a070d0153daa76b3806c1e52c9e00
>>          make O=/tmp/kselftest headers
>>          make O=/tmp/kselftest -C tools/testing/selftests
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> progs/test_ksyms_btf.c:37:21: error: no member named 'cpu' in 'struct rq'
>>                     out__rq_cpu = rq->cpu;
>>                                   ~~  ^
>>     progs/test_ksyms_btf.c:44:27: error: no member named 'cpu' in 'struct rq'
>>                     out__cpu_0_rq_cpu = rq->cpu;
>>                                         ~~  ^
>>     progs/test_ksyms_btf.c:48:25: error: no member named 'cpu' in 'struct rq'
>>             out__this_rq_cpu = rq->cpu;
>>                                ~~  ^
>>     3 errors generated.
>> --
>>>> progs/test_ksyms_btf_null_check.c:25:26: error: no member named 'cpu' in 'struct rq'
>>                     *(volatile int *)(&rq->cpu);
>>                                        ~~  ^
>>     1 error generated.
>> --
>>>> progs/test_ksyms_weak.c:41:29: error: no member named 'cpu' in 'struct rq'
>>                     out__existing_typed = rq->cpu;
>>                                           ~~  ^
>>     1 error generated.
> 
> I tried to reproduce this, without success. And it's not really clear to me
> how it could be related to the change either...

Hi Andres,

Sorry for the inconvenience, this error can be reproduced by `make
O=/tmp/kselftest -C tools/testing/selftests/bpf`, but it shouldn't be
related to your commit, the build of parent commit stopped in early
stage which caused the false positive.

Best Regards,
Rong Chen

> 
> Greetings,
> 
> Andres Freund
> 
