Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57EF6BE133
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCQG0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQG0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:26:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE1C65475;
        Thu, 16 Mar 2023 23:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679034406; x=1710570406;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bL/PYAQu02/a6klSErCbC2EVB0viYzOA5B2PQDBINuM=;
  b=ndLJM+yCK4/McL0xVQwz4mMWqWwtYccHOwa4Az0NlEkEzdh7aatta5sJ
   itOaN3d7KjJPryxIl9IuLMr83gV452jlNODnx6XOn9LvkqUHOz925PA25
   wB5sNPbF5tMpYnehRBFHwoIZq06aRIqGUg64s14R0RPxAYXWWeBHDeMZF
   uqpfDPYGLnwhnrvVGVym6m49z86ZOz1u27HpSUuOMlcuOZH6l3g1kLF6F
   KgrFFEjBDDPZyYZu4MItwCryA3HpUP4t8UCdRY3PcF+4q0FtsgQ4YQVWg
   tk3JmzMUv3PxR0QOKqKFWR4xn4j2ULFSxwW9sA3fT2h3fy1n1/PSiKm2l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339732990"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="339732990"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 23:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="710399574"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="710399574"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.44.29])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 23:26:42 -0700
Message-ID: <e7105cdd-3bc0-d4a8-52c3-36d95fcf3ad2@intel.com>
Date:   Fri, 17 Mar 2023 08:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [linus:master] [perf symbols] ce4c8e7966:
 perf-sanity-tests.Test_data_symbol.fail
Content-Language: en-US
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <202303061424.6ad43294-yujie.liu@intel.com>
 <d62c6cc7-9f43-2c23-d9e2-1ddbd0f5234c@intel.com>
 <ZBK00bqcyl2lnG8W@yujie-X299>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZBK00bqcyl2lnG8W@yujie-X299>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/23 08:18, Yujie Liu wrote:
> On Mon, Mar 06, 2023 at 03:20:09PM +0200, Adrian Hunter wrote:
>> On 6/03/23 08:30, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we sent a report when this commit was in linux-next/master:
>>>
>>> https://lore.kernel.org/all/202302092156.c0b14693-oliver.sang@intel.com/
>>>
>>> This commit has been merged to mainline and we still observe similar
>>> failures, so we report again FYI.
>>>
>>> We noticed perf-sanity-tests.Test_data_symbol.fail due to commit (built with gcc-11):
>>>
>>> commit: ce4c8e7966f317ef2af896778b5fa9105a5cd351 ("perf symbols: Get symbols for .plt.got for x86-64")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> [test failed on linux-next/master 1acf39ef8f1425cd105f630dc2c7c1d8fff27ed1]
>>>
>>> in testcase: perf-sanity-tests
>>> version: 
>>> with following parameters:
>>>
>>> 	perf_compiler: clang
>>>
>>> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>>
>>>
>>> 2023-02-08 19:29:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-ce4c8e7966f317ef2af896778b5fa91
>>> 05a5cd351/tools/perf/perf test 105
>>> 105: Test data symbol                                                : FAILED!
>>>
>>>
>>> =========================================================================================
>>> tbox_group/testcase/rootfs/kconfig/compiler/perf_compiler:
>>>   lkp-kbl-d01/perf-sanity-tests/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/clang
>>>
>>> commit: 
>>>   51a188ad8c2d8 ("perf symbols: Start adding support for .plt.got for x86")
>>>   ce4c8e7966f31 ("perf symbols: Get symbols for .plt.got for x86-64")
>>>
>>> 51a188ad8c2d89c5 ce4c8e7966f317ef2af896778b5 
>>> ---------------- --------------------------- 
>>>        fail:runs  %reproduction    fail:runs
>>>            |             |             |    
>>>            :6           50%           3:6     perf-sanity-tests.Check_branch_stack_sampling.fail
>>>            :6          100%           6:6     perf-sanity-tests.Test_data_symbol.fail
>>>            :6           33%           2:6     perf-sanity-tests.perf_record_tests.fail
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> | Reported-by: kernel test robot <yujie.liu@intel.com>
>>> | Link: https://lore.kernel.org/oe-lkp/202303061424.6ad43294-yujie.liu@intel.com
>>>
>>>
>>> To reproduce:
>>>
>>>         git clone https://github.com/intel/lkp-tests.git
>>>         cd lkp-tests
>>>         sudo bin/lkp install job.yaml           # job file is attached in this email
>>>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>>         sudo bin/lkp run generated-yaml-file
>>>
>>>         # if come across any failure that blocks the test,
>>>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>>
>> Works fine for me.  See below.
>>
>> You will have to debug your environment:
>> Add option -v to perf test (e.g. perf test -c "data symbol") and
>> add 'set -x' to tools/perf/tests/shell/test_data_symbol.sh
> 
> Thanks for the suggestion on debugging our environment.
> 
> We found that we were asked by developers to run perf test with
> sanitizer on, so we build perf with some additional flags like
> `make EXTRA_CFLAGS="-fsanitize=undefined -fsanitize=address"`, and the
> test_data_symbol failure only happens when these flags are set, but
> won't happen if do a make without those flags.
> 
> Could you please help check if above flags could impact the behavior of
> perf test? Thanks.
> 

Thanks for the information.

I sent 3 patches which should fix the test case:

https://lore.kernel.org/lkml/?q=%3C20230316194156.8320-1-adrian.hunter%40intel.com%3E


