Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506846190A8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKDGJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDGJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:09:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD2CB4B4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667542134; x=1699078134;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+tU/lOoBWBox0mdi+ziiZ54yP1You4GLwSqhkkOENZc=;
  b=PC3CBPZt0TCeBmvFESk9p/5sckxARP5KZZcbWJ3IVlJqk8RlgL/Kd6rJ
   S616+uRN5SKJNE9ZFp+78bwxuZztu7UYdA4s4vNile/G5+8VJL0iaW2f2
   g0OelNtKBiD71nV/faC4rLfO5NB2nyEFDUIdoZ3fJ8R0366UuGm+9UYHo
   svp4diM4xdPOe1I12fuaUMFXI10k48E6rIx666qwabB37ue4yscnXnJQj
   rIQY6t6Lqis9E30Gr0rjUzAa7f42H7+575ILceGRosikgfbOR+CaYeV+G
   ftyrDybgYEtYJ45dRwrGisnSMvBl3LDCWbEEV3BMr1P1y/3d54Ks1K75v
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="297355293"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="297355293"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 23:08:53 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="724232835"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="724232835"
Received: from yuhongwe-mobl.ccr.corp.intel.com (HELO [10.254.215.240]) ([10.254.215.240])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 23:08:50 -0700
Subject: Re: [tip:perf/core 1/2] kernel/events/core.c:181:48: error:
 redefinition of 'cpu_context' as different kind of symbol
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <202210272227.jWuKg5y6-lkp@intel.com>
 <Y1q8DcG09Z0PYXEf@hirez.programming.kicks-ass.net>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <cafa4dbc-0801-9675-a508-6c6c1073cc5d@intel.com>
Date:   Fri, 4 Nov 2022 14:08:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y1q8DcG09Z0PYXEf@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/2022 1:12 AM, Peter Zijlstra wrote:
> On Thu, Oct 27, 2022 at 10:03:53PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
>> head:   dc39beffcfc19a8dd2a09c5818dcd1a4e9099033
>> commit: 983bd8543b5ab8e9a2870ae258bccd4ce7a22c7c [1/2] perf: Rewrite core context handling
>> config: mips-randconfig-r024-20221026
>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install mips cross compiling tool for clang build
>>          # apt-get install binutils-mips64el-linux-gnuabi64
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=983bd8543b5ab8e9a2870ae258bccd4ce7a22c7c
>>          git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>>          git fetch --no-tags tip perf/core
>>          git checkout 983bd8543b5ab8e9a2870ae258bccd4ce7a22c7c
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> kernel/events/core.c:181:48: error: redefinition of 'cpu_context' as different kind of symbol
>>     static DEFINE_PER_CPU(struct perf_cpu_context, cpu_context);
>>                                                    ^
>>     arch/mips/include/asm/mmu_context.h:106:19: note: previous definition is here
>>     static inline u64 cpu_context(unsigned int cpu, const struct mm_struct *mm)
> 
> *sigh*.. robot people.. this patch has sat in my queue.git for weeks now
> :/

Hi Peter,

Sorry about that, I checked the internal reports, the error was first
found on Oct 14, but it's blocked due to commit id changed in the same
branch, we'll enhance the check logic to avoid blocking such cases.

   [peterz-queue:perf/core 5/6] kernel/events/core.c:181:48: error: 
'cpu_context' redeclared as different kind of symbol


Best Regards,
Rong Chen

> 
> anyway, lemme go fix, this shouldn't be hard.
> 
