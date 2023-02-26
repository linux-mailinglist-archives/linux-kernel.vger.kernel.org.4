Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E805C6A33C4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBZTub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZTu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:50:29 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CA5C66E;
        Sun, 26 Feb 2023 11:50:26 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id r5so4711506qtp.4;
        Sun, 26 Feb 2023 11:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpicTJ2XecQ/FLAIYlC4IN5ky+P1VSOOTrB16bggomA=;
        b=fHsYQrrXP0CnbmYCtVzSnXCFay9s1s498afIdNIEde4JZaSptNP4RT3woVM37JH+8D
         lTDlnIsZGXCesmof6ni5k4A7OQ2hWCprvQcll/80odaZeqgoPRdaiz5BGdTb80sWaLhF
         jccKk6hQ6pVTBtq+uc8A9Youf2SsKf6FH2Skkg+nhNnPpth1dQy16OJFEhz7F/RV7NFt
         03dGTq4Ze5TAQQN/SoYfZ4omF6hFQAHgLBIxk5pRxS9EbABQaVYUjif4ufrWqs7Zgq/l
         C2kB2tR8YOzTP6d1I5KwBZ3bVcN8fPsk9UZl8JA1C807xNTE38Jp7kzu8j8uE5ZY/GF1
         xrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpicTJ2XecQ/FLAIYlC4IN5ky+P1VSOOTrB16bggomA=;
        b=jtGmaZhw7SMl4jnKZpnNTyGDxrn2HV7oYvWF6W0Xt6+DdQtMmCWlhoMqzDjLX9v84p
         8I3YUOMU1Lf+6pBfoS/4XqMbasiGc1+shKMzj5ZFapgbgp0+YqYjfOaxplq+yLtLtazz
         kcOWoCq7URObPB/63p/imH1P7X0Zvx//kesywNSWC7+o5nzoL5TKQ2/3FN4e3FhKLl+C
         qi/YI1CqreLVgvBRT0cw6ryKb2uJjEpyKKOfLPfdvJWwmym40zY0875cQSzRpzQHqTbG
         FQDGoFVNWg5PJATZbbflnGA0sUFJ7NwAt95gkoYdeA9Ybcm8Fa/VjbUFh1y60LKmfFIY
         +xFA==
X-Gm-Message-State: AO0yUKUqIpCNimLInwE3wUESWh8XuOv1VHw/jN1a+zlYzszvwYebPG4h
        dbDhZrKOyxqPXCie/nX+kWBS25CU+dM=
X-Google-Smtp-Source: AK7set89ddCOZ5GXGZpsQto3n8lXPGUp9ztYPYUgqpcdYvB8cL8XJfGRcFwA8QLmAEWB3iSQq2ejGQ==
X-Received: by 2002:ac8:7f89:0:b0:3bf:d0c7:12df with SMTP id z9-20020ac87f89000000b003bfd0c712dfmr5655755qtj.63.1677441025774;
        Sun, 26 Feb 2023 11:50:25 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:319d:ae28:d693:d868? ([2600:1700:2442:6db0:319d:ae28:d693:d868])
        by smtp.gmail.com with ESMTPSA id s13-20020a05622a018d00b003bfa8e1b7d1sm3402864qtw.32.2023.02.26.11.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 11:50:25 -0800 (PST)
Message-ID: <db624672-4f5f-35c7-573d-623a2685bc4c@gmail.com>
Date:   Sun, 26 Feb 2023 13:50:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/7] of: unittest: add node lifecycle tests
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213185702.395776-1-frowand.list@gmail.com>
 <20230213185702.395776-5-frowand.list@gmail.com>
 <20230226000744.GA1777251@roeck-us.net>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230226000744.GA1777251@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/23 18:07, Guenter Roeck wrote:
> On Mon, Feb 13, 2023 at 12:56:59PM -0600, Frank Rowand wrote:
>> Add tests to exercise the actions that occur when the reference count
>> of devicetree nodes decrement to zero and beyond.  Decrementing to
>> zero triggers freeing memory allocated for the node.
>>
>> This commit will expose a pr_err() issue in of_node_release(), resulting
>> in some kernal warnings and stack traces.
>>
>> When scripts/dtc/of_unittest_expect processes the console messages,
>> it will also report related problems for EXPECT messages due to the
>> pr_err() issue:
>>    **     missing EXPECT begin      :    5
>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
>> ---
>>
>> There are checkpatch warnings.  I have reviewed them and feel
>> they can be ignored.
>>
>> Stack traces from the pr_err() issue:
>>
> 
> Unfortunately my test beds trigger a warning if they encounter a backtrace
> in a log. Trying to implement workarounds would be just too time consuming,
> so I had to disable OF_UNITTEST in my boot tests as consequence of this
> patch.

Thank you for letting me know about this issue.  I was a bit concerned about
causing stack traces.

I do not want to lose your testing!

I'll submit a patch to disable any test that causes a backtrace, then add a
boot command line option to enable those tests.  That was most people will
not see the backtrace, the test will be reported as skipped, and people
like me can go to the extra effort to enable the tests.

Hopefully the patch get a good reception.

-Frank

> 
> Guenter
> 
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at lib/refcount.c:25 kobject_get+0xa0/0xa4
>> refcount_t: addition on 0; use-after-free.
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.2.0-rc1-00005-g774057a35a67 #21
>> Hardware name: Generic DT based system
>>  unwind_backtrace from show_stack+0x10/0x14
>>  show_stack from dump_stack_lvl+0x40/0x4c
>>  dump_stack_lvl from __warn+0x7c/0x15c
>>  __warn from warn_slowpath_fmt+0x98/0xcc
>>  warn_slowpath_fmt from kobject_get+0xa0/0xa4
>>  kobject_get from of_node_get+0x14/0x1c
>>  of_node_get from of_fwnode_get+0x34/0x40
>>  of_fwnode_get from fwnode_full_name_string+0x34/0xa0
>>  fwnode_full_name_string from device_node_string+0x4dc/0x4f4
>>  device_node_string from pointer+0x364/0x598
>>  pointer from vsnprintf+0x1f8/0x3d0
>>  vsnprintf from vprintk_store+0x134/0x410
>>  vprintk_store from vprintk_emit+0x6c/0x234
>>  vprintk_emit from vprintk_default+0x20/0x28
>>  vprintk_default from _printk+0x30/0x60
>>  _printk from of_node_release+0xb0/0xf4
>>  of_node_release from kobject_put+0xc4/0x29c
>>  kobject_put from of_unittest+0x256c/0x2eb8
>>  of_unittest from do_one_initcall+0x4c/0x268
>>  do_one_initcall from kernel_init_freeable+0x1b4/0x214
>>  kernel_init_freeable from kernel_init+0x18/0x130
>>  kernel_init from ret_from_fork+0x14/0x2c
>> Exception stack(0xf0821fb0 to 0xf0821ff8)
>> 1fa0:                                     00000000 00000000 00000000 00000000
>> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> ---[ end trace 0000000000000000 ]---
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 fwnode_full_name_string+0x8c/0xa0
>> refcount_t: underflow; use-after-free.
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.2.0-rc1-00005-g774057a35a67 #21
>> Hardware name: Generic DT based system
>>  unwind_backtrace from show_stack+0x10/0x14
>>  show_stack from dump_stack_lvl+0x40/0x4c
>>  dump_stack_lvl from __warn+0x7c/0x15c
>>  __warn from warn_slowpath_fmt+0x98/0xcc
>>  warn_slowpath_fmt from fwnode_full_name_string+0x8c/0xa0
>>  fwnode_full_name_string from device_node_string+0x4dc/0x4f4
>>  device_node_string from pointer+0x364/0x598
>>  pointer from vsnprintf+0x1f8/0x3d0
>>  vsnprintf from vprintk_store+0x134/0x410
>>  vprintk_store from vprintk_emit+0x6c/0x234
>>  vprintk_emit from vprintk_default+0x20/0x28
>>  vprintk_default from _printk+0x30/0x60
>>  _printk from of_node_release+0xb0/0xf4
>>  of_node_release from kobject_put+0xc4/0x29c
>>  kobject_put from of_unittest+0x256c/0x2eb8
>>  of_unittest from do_one_initcall+0x4c/0x268
>>  do_one_initcall from kernel_init_freeable+0x1b4/0x214
>>  kernel_init_freeable from kernel_init+0x18/0x130
>>  kernel_init from ret_from_fork+0x14/0x2c
>> Exception stack(0xf0821fb0 to 0xf0821ff8)
>> 1fa0:                                     00000000 00000000 00000000 00000000
>> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> ---[ end trace 0000000000000000 ]---
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at lib/refcount.c:22 kobject_get+0x8c/0xa4
>> refcount_t: saturated; leaking memory.
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.2.0-rc1-00005-g774057a35a67 #21
>> Hardware name: Generic DT based system
>>  unwind_backtrace from show_stack+0x10/0x14
>>  show_stack from dump_stack_lvl+0x40/0x4c
>>  dump_stack_lvl from __warn+0x7c/0x15c
>>  __warn from warn_slowpath_fmt+0x98/0xcc
>>  warn_slowpath_fmt from kobject_get+0x8c/0xa4
>>  kobject_get from of_node_get+0x14/0x1c
>>  of_node_get from of_fwnode_get+0x34/0x40
>>  of_fwnode_get from fwnode_full_name_string+0x34/0xa0
>>  fwnode_full_name_string from device_node_string+0x4dc/0x4f4
>>  device_node_string from pointer+0x364/0x598
>>  pointer from vsnprintf+0x1f8/0x3d0
>>  vsnprintf from vscnprintf+0x10/0x24
>>  vscnprintf from printk_sprint+0x18/0x194
>>  printk_sprint from vprintk_store+0x378/0x410
>>  vprintk_store from vprintk_emit+0x6c/0x234
>>  vprintk_emit from vprintk_default+0x20/0x28
>>  vprintk_default from _printk+0x30/0x60
>>  _printk from of_node_release+0xb0/0xf4
>>  of_node_release from kobject_put+0xc4/0x29c
>>  kobject_put from of_unittest+0x256c/0x2eb8
>>  of_unittest from do_one_initcall+0x4c/0x268
>>  do_one_initcall from kernel_init_freeable+0x1b4/0x214
>>  kernel_init_freeable from kernel_init+0x18/0x130
>>  kernel_init from ret_from_fork+0x14/0x2c
>> Exception stack(0xf0821fb0 to 0xf0821ff8)
>> 1fa0:                                     00000000 00000000 00000000 00000000
>> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> ---[ end trace 0000000000000000 ]---
>>
>>
>>  drivers/of/dynamic.c                          |  14 +-
>>  .../of/unittest-data/testcases_common.dtsi    |   1 +
>>  drivers/of/unittest-data/tests-lifecycle.dtsi |   8 +
>>  drivers/of/unittest.c                         | 148 +++++++++++++++++-
>>  4 files changed, 168 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/of/unittest-data/tests-lifecycle.dtsi
>>
>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>> index cd3821a6444f..becb80f762c8 100644
>> --- a/drivers/of/dynamic.c
>> +++ b/drivers/of/dynamic.c
>> @@ -332,7 +332,19 @@ void of_node_release(struct kobject *kobj)
>>  	/* We should never be releasing nodes that haven't been detached. */
>>  	if (!of_node_check_flag(node, OF_DETACHED)) {
>>  		pr_err("ERROR: Bad of_node_put() on %pOF\n", node);
>> -		dump_stack();
>> +
>> +		/*
>> +		 * of unittests will test this path.  Do not print the stack
>> +		 * trace when the error is caused by unittest so that we do
>> +		 * not display what a normal developer might reasonably
>> +		 * consider a real bug.
>> +		 */
>> +		if (!IS_ENABLED(CONFIG_OF_UNITTEST) ||
>> +		    strcmp(node->parent->full_name, "testcase-data")) {
>> +			dump_stack();
>> +			pr_err("ERROR: next of_node_put() on this node will result in a kboject warning 'refcount_t: underflow; use-after-free.'\n");
>> +		}
>> +
>>  		return;
>>  	}
>>  	if (!of_node_check_flag(node, OF_DYNAMIC))
>> diff --git a/drivers/of/unittest-data/testcases_common.dtsi b/drivers/of/unittest-data/testcases_common.dtsi
>> index 19292bbb4cbb..e7887f2301c1 100644
>> --- a/drivers/of/unittest-data/testcases_common.dtsi
>> +++ b/drivers/of/unittest-data/testcases_common.dtsi
>> @@ -17,3 +17,4 @@ node-remove {
>>  #include "tests-address.dtsi"
>>  #include "tests-platform.dtsi"
>>  #include "tests-overlay.dtsi"
>> +#include "tests-lifecycle.dtsi"
>> diff --git a/drivers/of/unittest-data/tests-lifecycle.dtsi b/drivers/of/unittest-data/tests-lifecycle.dtsi
>> new file mode 100644
>> index 000000000000..28509a8783a7
>> --- /dev/null
>> +++ b/drivers/of/unittest-data/tests-lifecycle.dtsi
>> @@ -0,0 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/ {
>> +	testcase-data {
>> +		refcount-node {
>> +		};
>> +	};
>> +};
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index bc0f1e50a4be..db72e208819c 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -54,8 +54,9 @@ static struct unittest_results {
>>   * Print the expected message only if the current loglevel will allow
>>   * the actual message to print.
>>   *
>> - * Do not use EXPECT_BEGIN() or EXPECT_END() for messages generated by
>> - * pr_debug().
>> + * Do not use EXPECT_BEGIN(), EXPECT_END(), EXPECT_NOT_BEGIN(), or
>> + * EXPECT_NOT_END() to report messages expected to be reported or not
>> + * reported by pr_debug().
>>   */
>>  #define EXPECT_BEGIN(level, fmt, ...) \
>>  	printk(level pr_fmt("EXPECT \\ : ") fmt, ##__VA_ARGS__)
>> @@ -63,6 +64,12 @@ static struct unittest_results {
>>  #define EXPECT_END(level, fmt, ...) \
>>  	printk(level pr_fmt("EXPECT / : ") fmt, ##__VA_ARGS__)
>>  
>> +#define EXPECT_NOT_BEGIN(level, fmt, ...) \
>> +	printk(level pr_fmt("EXPECT_NOT \\ : ") fmt, ##__VA_ARGS__)
>> +
>> +#define EXPECT_NOT_END(level, fmt, ...) \
>> +	printk(level pr_fmt("EXPECT_NOT / : ") fmt, ##__VA_ARGS__)
>> +
>>  static void __init of_unittest_find_node_by_name(void)
>>  {
>>  	struct device_node *np;
>> @@ -1488,6 +1495,7 @@ static int __init unittest_data_add(void)
>>  		struct device_node *next = np->sibling;
>>  
>>  		np->parent = of_root;
>> +		/* this will clear OF_DETACHED in np and children */
>>  		attach_node_and_children(np);
>>  		np = next;
>>  	}
>> @@ -2998,6 +3006,141 @@ static void __init of_unittest_overlay(void)
>>  static inline void __init of_unittest_overlay(void) { }
>>  #endif
>>  
>> +static void __init of_unittest_lifecycle(void)
>> +{
>> +	unsigned int refcount;
>> +	int found_refcount_one = 0;
>> +	int put_count = 0;
>> +	struct device_node *np;
>> +	struct device_node *prev_sibling, *next_sibling;
>> +	const char *refcount_path = "/testcase-data/refcount-node";
>> +	const char *refcount_parent_path = "/testcase-data";
>> +
>> +	/*
>> +	 * Node lifecycle tests, non-dynamic node:
>> +	 *
>> +	 * - Decrementing refcount to zero via of_node_put() should cause the
>> +	 *   attempt to free the node memory by of_node_release() to fail
>> +	 *   because the node is not a dynamic node.
>> +	 *
>> +	 * - Decrementing refcount past zero should result in additional
>> +	 *   errors reported.
>> +	 */
>> +
>> +	np = of_find_node_by_path(refcount_path);
>> +	unittest(np, "find refcount_path \"%s\"\n", refcount_path);
>> +	if (np == NULL)
>> +		goto out_skip_tests;
>> +
>> +	while (!found_refcount_one) {
>> +
>> +		if (put_count++ > 10) {
>> +			unittest(0, "guardrail to avoid infinite loop\n");
>> +			goto out_skip_tests;
>> +		}
>> +
>> +		refcount = kref_read(&np->kobj.kref);
>> +		if (refcount == 1)
>> +			found_refcount_one = 1;
>> +		else
>> +			of_node_put(np);
>> +	}
>> +
>> +	EXPECT_BEGIN(KERN_INFO, "OF: ERROR: of_node_release() detected bad of_node_put() on /testcase-data/refcount-node");
>> +
>> +	/*
>> +	 * refcount is now one, decrementing to zero will result in a call to
>> +	 * of_node_release() to free the node's memory, which should result
>> +	 * in an error
>> +	 */
>> +	unittest(1, "/testcase-data/refcount-node is one");
>> +	of_node_put(np);
>> +
>> +	EXPECT_END(KERN_INFO, "OF: ERROR: of_node_release() detected bad of_node_put() on /testcase-data/refcount-node");
>> +
>> +
>> +	/*
>> +	 * expect stack trace for subsequent of_node_put():
>> +	 *   __refcount_sub_and_test() calls:
>> +	 *   refcount_warn_saturate(r, REFCOUNT_SUB_UAF)
>> +	 *
>> +	 * Not capturing entire WARN_ONCE() trace with EXPECT_*(), just
>> +	 * the first three lines, and the last line.
>> +	 */
>> +	EXPECT_BEGIN(KERN_INFO, "------------[ cut here ]------------");
>> +	EXPECT_BEGIN(KERN_INFO, "WARNING: <<all>>");
>> +	EXPECT_BEGIN(KERN_INFO, "refcount_t: underflow; use-after-free.");
>> +	EXPECT_BEGIN(KERN_INFO, "---[ end trace <<int>> ]---");
>> +
>> +	/* refcount is now zero, this should fail */
>> +	unittest(1, "/testcase-data/refcount-node is zero");
>> +	of_node_put(np);
>> +
>> +	EXPECT_END(KERN_INFO, "---[ end trace <<int>> ]---");
>> +	EXPECT_END(KERN_INFO, "refcount_t: underflow; use-after-free.");
>> +	EXPECT_END(KERN_INFO, "WARNING: <<all>>");
>> +	EXPECT_END(KERN_INFO, "------------[ cut here ]------------");
>> +
>> +	/*
>> +	 * Q. do we expect to get yet another warning?
>> +	 * A. no, the WARNING is from WARN_ONCE()
>> +	 */
>> +	EXPECT_NOT_BEGIN(KERN_INFO, "------------[ cut here ]------------");
>> +	EXPECT_NOT_BEGIN(KERN_INFO, "WARNING: <<all>>");
>> +	EXPECT_NOT_BEGIN(KERN_INFO, "refcount_t: underflow; use-after-free.");
>> +	EXPECT_NOT_BEGIN(KERN_INFO, "---[ end trace <<int>> ]---");
>> +
>> +	unittest(1, "/testcase-data/refcount-node is zero, second time");
>> +	of_node_put(np);
>> +
>> +	EXPECT_NOT_END(KERN_INFO, "---[ end trace <<int>> ]---");
>> +	EXPECT_NOT_END(KERN_INFO, "refcount_t: underflow; use-after-free.");
>> +	EXPECT_NOT_END(KERN_INFO, "WARNING: <<all>>");
>> +	EXPECT_NOT_END(KERN_INFO, "------------[ cut here ]------------");
>> +
>> +	/*
>> +	 * refcount of zero will trigger stack traces from any further
>> +	 * attempt to of_node_get() node "refcount-node". One example of
>> +	 * this is where of_unittest_check_node_linkage() will recursively
>> +	 * scan the tree, with 'for_each_child_of_node()' doing an
>> +	 * of_node_get() of the children of a node.
>> +	 *
>> +	 * Prevent the stack trace by removing node "refcount-node" from
>> +	 * its parent's child list.
>> +	 *
>> +	 * WARNING:  EVIL, EVIL, EVIL:
>> +	 *
>> +	 *   Directly manipulate the child list of node /testcase-data to
>> +	 *   remove child refcount-node.  This is ignoring all proper methods
>> +	 *   of removing a child and will leak a small amount of memory.
>> +	 */
>> +
>> +	np = of_find_node_by_path(refcount_parent_path);
>> +	unittest(np, "find refcount_parent_path \"%s\"\n", refcount_parent_path);
>> +	unittest(np, "ERROR: devicetree live tree left in a 'bad state' if test fail\n");
>> +	if (np == NULL)
>> +		return;
>> +
>> +	prev_sibling = np->child;
>> +	next_sibling = prev_sibling->sibling;
>> +	if (!strcmp(prev_sibling->full_name, "refcount-node")) {
>> +		np->child = next_sibling;
>> +		next_sibling = next_sibling->sibling;
>> +	}
>> +	while (next_sibling) {
>> +		if (!strcmp(next_sibling->full_name, "refcount-node"))
>> +			prev_sibling->sibling = next_sibling->sibling;
>> +		prev_sibling = next_sibling;
>> +		next_sibling = next_sibling->sibling;
>> +	}
>> +	of_node_put(np);
>> +
>> +	return;
>> +
>> +out_skip_tests:
>> +	unittest(0, "One or more lifecycle tests skipped\n");
>> +}
>> +
>>  #ifdef CONFIG_OF_OVERLAY
>>  
>>  /*
>> @@ -3502,6 +3645,7 @@ static int __init of_unittest(void)
>>  	of_unittest_match_node();
>>  	of_unittest_platform_populate();
>>  	of_unittest_overlay();
>> +	of_unittest_lifecycle();
>>  
>>  	/* Double check linkage after removing testcase data */
>>  	of_unittest_check_tree_linkage();
>> -- 
>> Frank Rowand <frowand.list@gmail.com>
>>

