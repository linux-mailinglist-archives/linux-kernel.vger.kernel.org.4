Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AD762D7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiKQK0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiKQK0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:26:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC51A17E02
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668680791; x=1700216791;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zbWJe6oEfKrd0c6UiLe9GtEd0hb06zqwb9RnuG6sdNA=;
  b=VSM0fmiG5ZDhftGFh7UtUkMNFyfpWxtYXdxTZCqClLduLfEJf8Pq0M24
   YrNNPQ+FpFrNDaMjgU9SNurhBRnVPSrvcfN/i2CpPOn8I9mH8Qy+NiNi4
   KF3gJR9WEJBalXQlJsWeB06t9cR91iP491RWQ19JLskowOWmdWAYm2iVw
   rIyONybnGOQ1mvAJQm8mrZq4V5+ALUEop7aTzLWE8DcxX0ModOEPh9yYM
   cwz6NbzkLWZIRb5uQLQjRyKOKiYn9fuulQ96FiVypRZnD6X9UIaviYwvr
   l5VivmY9RHGPERDvznDBAsRvmHhBbaMPfJwTzRfwpU+ToYiljONvnBLP6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="314631924"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="314631924"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 02:26:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="634009917"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="634009917"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.215.149]) ([10.254.215.149])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 02:26:29 -0800
Subject: Re: [tip:perf/core] BUILD SUCCESS WITH WARNING
 e8d7a90c08ce963c592fb49845f2ccc606a2ac21
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
References: <637553b5.ebdZY+lvkXPfAk1E%lkp@intel.com>
 <Y3VYQtTSJDpwKZR5@hirez.programming.kicks-ass.net>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <ef7e121e-5424-36b3-6cb2-a80cece7290c@intel.com>
Date:   Thu, 17 Nov 2022 18:26:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y3VYQtTSJDpwKZR5@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2022 5:38 AM, Peter Zijlstra wrote:
> On Thu, Nov 17, 2022 at 05:18:45AM +0800, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
>> branch HEAD: e8d7a90c08ce963c592fb49845f2ccc606a2ac21  perf: Fix possible memleak in pmu_dev_alloc()
>>
>> Warning: (recently discovered and may have been fixed)
>>
>> kernel/events/core.c:11274:4: warning: cast from 'int (*)(struct perf_cpu_pmu_context *)' to 'remote_function_f' (aka 'int (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
>>
>> Warning ids grouped by kconfigs:
>>
>> clang_recent_errors
>> |-- hexagon-randconfig-r001-20221116
>> |   `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
>> |-- hexagon-randconfig-r005-20221116
>> |   `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
>> `-- s390-randconfig-r012-20221116
>>      `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
> 
> Robot guys; why don't I have a report of this warning?
> 
> Also, this very much isn't caused by this patch, this is a pre-existing
> issue.
> 

Hi Peter,

Sorry for the misunderstanding，it's a summary report to show recent
issues, we didn't find it in your repo before merging into tip tree,
we'll take a look to improve the system.

Best Regards,
Rong Chen
