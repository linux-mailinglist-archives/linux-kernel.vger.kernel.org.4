Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12FD61484A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiKALOn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Nov 2022 07:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiKALOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:14:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE24817E18
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:14:35 -0700 (PDT)
Received: from canpemm100007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1nNK5cZlzRnsl;
        Tue,  1 Nov 2022 19:09:37 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100007.china.huawei.com (7.192.105.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 19:14:33 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031;
 Tue, 1 Nov 2022 19:14:33 +0800
From:   zhaogongyi <zhaogongyi@huawei.com>
To:     kernel test robot <yujie.liu@intel.com>
CC:     "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [linus:master] [selftests/memory] 13023c33c9:
 kernel-selftests.memory-hotplug.mem-on-off-test.sh.fail
Thread-Topic: [linus:master] [selftests/memory] 13023c33c9:
 kernel-selftests.memory-hotplug.mem-on-off-test.sh.fail
Thread-Index: Adjt4wESSc/+YfD2QFSTt9INW1YibA==
Date:   Tue, 1 Nov 2022 11:14:33 +0000
Message-ID: <7f67ed236c3c49c1a29877a3aa221e20@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 
> Hi Gongyi,
> 
> We noticed that below commit may change the exit status of
> memory-hotplug selftest, please check if the test result is expected.
> 
> We got same test log before this commit but with a good exit, though
> there were also some "Invalid argument" and "unexpected success" log.
> Please help give some guidance if there are any problems in our test flow.
> Thanks.
> 
> 
> Greeting,
> 
> FYI, we noticed kernel-selftests.memory-hotplug.mem-on-off-test.sh.fail
> due to commit (built with gcc-11):
> 
> commit: 13023c33c962730a38d6b43995910c8805637a9a
> ("selftests/memory-hotplug: Add checking after online or offline")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-9313ba54-1_20221017
> with following parameters:
> 
> 	group: memory-hotplug
> 
> test-description: The kernel contains a set of "self tests" under the
> tools/testing/selftests/ directory. These are intended to be small unit tests
> to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
> (Skylake) with 28G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):
> 
> 
> 2022-10-28 01:04:44 make quicktest=1 run_tests -C memory-hotplug
> make: Entering directory
> '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-13023c33c962730a38
> d6b43995910c8805637a9a/tools/testing/selftests/memory-hotplug'
> TAP version 13
> 1..1
> # selftests: memory-hotplug: mem-on-off-test.sh # Test scope: 2% hotplug
> memory
> # 	 online all hot-pluggable memory in offline state:
> # 		 SKIPPED - no hot-pluggable memory in offline state
> # 	 offline 2% hot-pluggable memory in online state
> # 	 trying to offline 5 out of 224 memory block(s):
> # online->offline memory0
> # ./mem-on-off-test.sh: line 78: echo: write error: Invalid argument #
> offline_memory_expect_success 0: unexpected fail # online->offline
> memory1 # online->offline memory10 # online->offline memory100 #
> online->offline memory101 # online->offline memory102
> # 	 online all hot-pluggable memory in offline state:
> # offline->online memory1
> # offline->online memory10
> # offline->online memory100
> # offline->online memory101
> # offline->online memory102
> # 	 Test with memory notifier error injection
> # ./mem-on-off-test.sh: line 267: echo: write error: Invalid argument #

I can not reproduce the error according to the file 'reproduce'. 

Line 267 is not runnable on my system. Is there something wrong here?

The code on my system like:

266 #
267 # Offline $ratio percent of hot-pluggable memory
268 #
269 echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
270 for memory in `hotpluggable_online_memory`; do
271         if [ $((RANDOM % 100)) -lt $ratio ]; then
272                 offline_memory_expect_success $memory &>/dev/null
273         fi
274 done


> online_memory_expect_fail 142: unexpected success #
> online_memory_expect_fail 190: unexpected success
> # ./mem-on-off-test.sh: line 287: echo: write error: Invalid argument #

The problem is similar with line 267.

> offline_memory_expect_fail 107: unexpected success #

It seems the error-inject not work.

Regards,
Gongyi
