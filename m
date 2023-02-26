Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A1E6A2CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 01:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjBZAHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 19:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZAHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 19:07:49 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13314233;
        Sat, 25 Feb 2023 16:07:47 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id e21so2561687oie.1;
        Sat, 25 Feb 2023 16:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB/0ZhBj49l2eO9gijViBYDSEBZCoRV6LX49yGm6hr8=;
        b=dkCfMVvfRhk+GXjQtIbXYPvpMPO/TO65FwbD1OHObEBk3dX0RhG6xWGPMNZJWNZWZs
         UgjdYEi7zEnw4GfGPdl1s+WWJapR80cgnS0RnpERHJ7Z0HKwkYpk+nPxGJ/3KqHheTrt
         6iOpDzdQ+AJM51AMy6djK8AwCbKSTN0mdG5o+NJDI9oQ6KtSmqdxsSP6s0kmr++Fs8ZH
         IhOPGARa4Ny/9fersI0T7hHvn5KMRaHBLX68jYVxeiZgyxl9BUJIh3lCoMkBDeZpi3GD
         I3p50+7bGYXWGzNUbaQcUA21HcM5kv/PtDOyXiAB5cxXCoUS3AEa3fB+HxGzQYnI59Ir
         vqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IB/0ZhBj49l2eO9gijViBYDSEBZCoRV6LX49yGm6hr8=;
        b=SGPLWvFXyG4Fq/nnf9XRZVWd3l0IECAb4HZPudTzrS0Q+4ppc2i9pTbF4UIWWpBCBQ
         IbuPZeqq+QMVALiggoHWOOVi6OT5XtXuy8kect6JKVR3K77/20JClxVhIglW7BiMkcPd
         TRVmxc0eVCuHLQeeRuJa3Ol3YnuyzO+nGIorjowIUcicO0a97NnwlA8y9/ipC9WA47wU
         bwODhhv1lJLC0XnTJpmvYJ7sU7DnlWzXLUKNhy1cv7QQLvVnp6F2sA7gcLw6F+Dhyuj2
         vuxcoLsGQriIBU9s5w9Yz263S++HBnqJShs0TYoVcu916E6NQ9w99p8vpb+Q2FWar32p
         9wiA==
X-Gm-Message-State: AO0yUKWLpKupFN8HhXIcTgit6RF1uYTRQBYq/Q678BzsSewKhla0Z31g
        QuYWDa87rIdci3tHOzeydNFKlqabEbI=
X-Google-Smtp-Source: AK7set8ymRZ9Nb6ARrHfsTEPJZoQYMNG/Xo+f+QKl3A0h+iDHMl1sOteJyU1bIQPaD9u4t7yKgBB2A==
X-Received: by 2002:aca:2411:0:b0:378:9bd:2ce0 with SMTP id n17-20020aca2411000000b0037809bd2ce0mr6121578oic.59.1677370066612;
        Sat, 25 Feb 2023 16:07:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n81-20020acabd54000000b00383e4ac8856sm979163oif.22.2023.02.25.16.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 16:07:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 25 Feb 2023 16:07:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] of: unittest: add node lifecycle tests
Message-ID: <20230226000744.GA1777251@roeck-us.net>
References: <20230213185702.395776-1-frowand.list@gmail.com>
 <20230213185702.395776-5-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213185702.395776-5-frowand.list@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:56:59PM -0600, Frank Rowand wrote:
> Add tests to exercise the actions that occur when the reference count
> of devicetree nodes decrement to zero and beyond.  Decrementing to
> zero triggers freeing memory allocated for the node.
> 
> This commit will expose a pr_err() issue in of_node_release(), resulting
> in some kernal warnings and stack traces.
> 
> When scripts/dtc/of_unittest_expect processes the console messages,
> it will also report related problems for EXPECT messages due to the
> pr_err() issue:
>    **     missing EXPECT begin      :    5
> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> ---
> 
> There are checkpatch warnings.  I have reviewed them and feel
> they can be ignored.
> 
> Stack traces from the pr_err() issue:
> 

Unfortunately my test beds trigger a warning if they encounter a backtrace
in a log. Trying to implement workarounds would be just too time consuming,
so I had to disable OF_UNITTEST in my boot tests as consequence of this
patch.

Guenter

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at lib/refcount.c:25 kobject_get+0xa0/0xa4
> refcount_t: addition on 0; use-after-free.
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.2.0-rc1-00005-g774057a35a67 #21
> Hardware name: Generic DT based system
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x40/0x4c
>  dump_stack_lvl from __warn+0x7c/0x15c
>  __warn from warn_slowpath_fmt+0x98/0xcc
>  warn_slowpath_fmt from kobject_get+0xa0/0xa4
>  kobject_get from of_node_get+0x14/0x1c
>  of_node_get from of_fwnode_get+0x34/0x40
>  of_fwnode_get from fwnode_full_name_string+0x34/0xa0
>  fwnode_full_name_string from device_node_string+0x4dc/0x4f4
>  device_node_string from pointer+0x364/0x598
>  pointer from vsnprintf+0x1f8/0x3d0
>  vsnprintf from vprintk_store+0x134/0x410
>  vprintk_store from vprintk_emit+0x6c/0x234
>  vprintk_emit from vprintk_default+0x20/0x28
>  vprintk_default from _printk+0x30/0x60
>  _printk from of_node_release+0xb0/0xf4
>  of_node_release from kobject_put+0xc4/0x29c
>  kobject_put from of_unittest+0x256c/0x2eb8
>  of_unittest from do_one_initcall+0x4c/0x268
>  do_one_initcall from kernel_init_freeable+0x1b4/0x214
>  kernel_init_freeable from kernel_init+0x18/0x130
>  kernel_init from ret_from_fork+0x14/0x2c
> Exception stack(0xf0821fb0 to 0xf0821ff8)
> 1fa0:                                     00000000 00000000 00000000 00000000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 fwnode_full_name_string+0x8c/0xa0
> refcount_t: underflow; use-after-free.
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.2.0-rc1-00005-g774057a35a67 #21
> Hardware name: Generic DT based system
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x40/0x4c
>  dump_stack_lvl from __warn+0x7c/0x15c
>  __warn from warn_slowpath_fmt+0x98/0xcc
>  warn_slowpath_fmt from fwnode_full_name_string+0x8c/0xa0
>  fwnode_full_name_string from device_node_string+0x4dc/0x4f4
>  device_node_string from pointer+0x364/0x598
>  pointer from vsnprintf+0x1f8/0x3d0
>  vsnprintf from vprintk_store+0x134/0x410
>  vprintk_store from vprintk_emit+0x6c/0x234
>  vprintk_emit from vprintk_default+0x20/0x28
>  vprintk_default from _printk+0x30/0x60
>  _printk from of_node_release+0xb0/0xf4
>  of_node_release from kobject_put+0xc4/0x29c
>  kobject_put from of_unittest+0x256c/0x2eb8
>  of_unittest from do_one_initcall+0x4c/0x268
>  do_one_initcall from kernel_init_freeable+0x1b4/0x214
>  kernel_init_freeable from kernel_init+0x18/0x130
>  kernel_init from ret_from_fork+0x14/0x2c
> Exception stack(0xf0821fb0 to 0xf0821ff8)
> 1fa0:                                     00000000 00000000 00000000 00000000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at lib/refcount.c:22 kobject_get+0x8c/0xa4
> refcount_t: saturated; leaking memory.
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.2.0-rc1-00005-g774057a35a67 #21
> Hardware name: Generic DT based system
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x40/0x4c
>  dump_stack_lvl from __warn+0x7c/0x15c
>  __warn from warn_slowpath_fmt+0x98/0xcc
>  warn_slowpath_fmt from kobject_get+0x8c/0xa4
>  kobject_get from of_node_get+0x14/0x1c
>  of_node_get from of_fwnode_get+0x34/0x40
>  of_fwnode_get from fwnode_full_name_string+0x34/0xa0
>  fwnode_full_name_string from device_node_string+0x4dc/0x4f4
>  device_node_string from pointer+0x364/0x598
>  pointer from vsnprintf+0x1f8/0x3d0
>  vsnprintf from vscnprintf+0x10/0x24
>  vscnprintf from printk_sprint+0x18/0x194
>  printk_sprint from vprintk_store+0x378/0x410
>  vprintk_store from vprintk_emit+0x6c/0x234
>  vprintk_emit from vprintk_default+0x20/0x28
>  vprintk_default from _printk+0x30/0x60
>  _printk from of_node_release+0xb0/0xf4
>  of_node_release from kobject_put+0xc4/0x29c
>  kobject_put from of_unittest+0x256c/0x2eb8
>  of_unittest from do_one_initcall+0x4c/0x268
>  do_one_initcall from kernel_init_freeable+0x1b4/0x214
>  kernel_init_freeable from kernel_init+0x18/0x130
>  kernel_init from ret_from_fork+0x14/0x2c
> Exception stack(0xf0821fb0 to 0xf0821ff8)
> 1fa0:                                     00000000 00000000 00000000 00000000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> ---[ end trace 0000000000000000 ]---
> 
> 
>  drivers/of/dynamic.c                          |  14 +-
>  .../of/unittest-data/testcases_common.dtsi    |   1 +
>  drivers/of/unittest-data/tests-lifecycle.dtsi |   8 +
>  drivers/of/unittest.c                         | 148 +++++++++++++++++-
>  4 files changed, 168 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/of/unittest-data/tests-lifecycle.dtsi
> 
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index cd3821a6444f..becb80f762c8 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -332,7 +332,19 @@ void of_node_release(struct kobject *kobj)
>  	/* We should never be releasing nodes that haven't been detached. */
>  	if (!of_node_check_flag(node, OF_DETACHED)) {
>  		pr_err("ERROR: Bad of_node_put() on %pOF\n", node);
> -		dump_stack();
> +
> +		/*
> +		 * of unittests will test this path.  Do not print the stack
> +		 * trace when the error is caused by unittest so that we do
> +		 * not display what a normal developer might reasonably
> +		 * consider a real bug.
> +		 */
> +		if (!IS_ENABLED(CONFIG_OF_UNITTEST) ||
> +		    strcmp(node->parent->full_name, "testcase-data")) {
> +			dump_stack();
> +			pr_err("ERROR: next of_node_put() on this node will result in a kboject warning 'refcount_t: underflow; use-after-free.'\n");
> +		}
> +
>  		return;
>  	}
>  	if (!of_node_check_flag(node, OF_DYNAMIC))
> diff --git a/drivers/of/unittest-data/testcases_common.dtsi b/drivers/of/unittest-data/testcases_common.dtsi
> index 19292bbb4cbb..e7887f2301c1 100644
> --- a/drivers/of/unittest-data/testcases_common.dtsi
> +++ b/drivers/of/unittest-data/testcases_common.dtsi
> @@ -17,3 +17,4 @@ node-remove {
>  #include "tests-address.dtsi"
>  #include "tests-platform.dtsi"
>  #include "tests-overlay.dtsi"
> +#include "tests-lifecycle.dtsi"
> diff --git a/drivers/of/unittest-data/tests-lifecycle.dtsi b/drivers/of/unittest-data/tests-lifecycle.dtsi
> new file mode 100644
> index 000000000000..28509a8783a7
> --- /dev/null
> +++ b/drivers/of/unittest-data/tests-lifecycle.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/ {
> +	testcase-data {
> +		refcount-node {
> +		};
> +	};
> +};
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index bc0f1e50a4be..db72e208819c 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -54,8 +54,9 @@ static struct unittest_results {
>   * Print the expected message only if the current loglevel will allow
>   * the actual message to print.
>   *
> - * Do not use EXPECT_BEGIN() or EXPECT_END() for messages generated by
> - * pr_debug().
> + * Do not use EXPECT_BEGIN(), EXPECT_END(), EXPECT_NOT_BEGIN(), or
> + * EXPECT_NOT_END() to report messages expected to be reported or not
> + * reported by pr_debug().
>   */
>  #define EXPECT_BEGIN(level, fmt, ...) \
>  	printk(level pr_fmt("EXPECT \\ : ") fmt, ##__VA_ARGS__)
> @@ -63,6 +64,12 @@ static struct unittest_results {
>  #define EXPECT_END(level, fmt, ...) \
>  	printk(level pr_fmt("EXPECT / : ") fmt, ##__VA_ARGS__)
>  
> +#define EXPECT_NOT_BEGIN(level, fmt, ...) \
> +	printk(level pr_fmt("EXPECT_NOT \\ : ") fmt, ##__VA_ARGS__)
> +
> +#define EXPECT_NOT_END(level, fmt, ...) \
> +	printk(level pr_fmt("EXPECT_NOT / : ") fmt, ##__VA_ARGS__)
> +
>  static void __init of_unittest_find_node_by_name(void)
>  {
>  	struct device_node *np;
> @@ -1488,6 +1495,7 @@ static int __init unittest_data_add(void)
>  		struct device_node *next = np->sibling;
>  
>  		np->parent = of_root;
> +		/* this will clear OF_DETACHED in np and children */
>  		attach_node_and_children(np);
>  		np = next;
>  	}
> @@ -2998,6 +3006,141 @@ static void __init of_unittest_overlay(void)
>  static inline void __init of_unittest_overlay(void) { }
>  #endif
>  
> +static void __init of_unittest_lifecycle(void)
> +{
> +	unsigned int refcount;
> +	int found_refcount_one = 0;
> +	int put_count = 0;
> +	struct device_node *np;
> +	struct device_node *prev_sibling, *next_sibling;
> +	const char *refcount_path = "/testcase-data/refcount-node";
> +	const char *refcount_parent_path = "/testcase-data";
> +
> +	/*
> +	 * Node lifecycle tests, non-dynamic node:
> +	 *
> +	 * - Decrementing refcount to zero via of_node_put() should cause the
> +	 *   attempt to free the node memory by of_node_release() to fail
> +	 *   because the node is not a dynamic node.
> +	 *
> +	 * - Decrementing refcount past zero should result in additional
> +	 *   errors reported.
> +	 */
> +
> +	np = of_find_node_by_path(refcount_path);
> +	unittest(np, "find refcount_path \"%s\"\n", refcount_path);
> +	if (np == NULL)
> +		goto out_skip_tests;
> +
> +	while (!found_refcount_one) {
> +
> +		if (put_count++ > 10) {
> +			unittest(0, "guardrail to avoid infinite loop\n");
> +			goto out_skip_tests;
> +		}
> +
> +		refcount = kref_read(&np->kobj.kref);
> +		if (refcount == 1)
> +			found_refcount_one = 1;
> +		else
> +			of_node_put(np);
> +	}
> +
> +	EXPECT_BEGIN(KERN_INFO, "OF: ERROR: of_node_release() detected bad of_node_put() on /testcase-data/refcount-node");
> +
> +	/*
> +	 * refcount is now one, decrementing to zero will result in a call to
> +	 * of_node_release() to free the node's memory, which should result
> +	 * in an error
> +	 */
> +	unittest(1, "/testcase-data/refcount-node is one");
> +	of_node_put(np);
> +
> +	EXPECT_END(KERN_INFO, "OF: ERROR: of_node_release() detected bad of_node_put() on /testcase-data/refcount-node");
> +
> +
> +	/*
> +	 * expect stack trace for subsequent of_node_put():
> +	 *   __refcount_sub_and_test() calls:
> +	 *   refcount_warn_saturate(r, REFCOUNT_SUB_UAF)
> +	 *
> +	 * Not capturing entire WARN_ONCE() trace with EXPECT_*(), just
> +	 * the first three lines, and the last line.
> +	 */
> +	EXPECT_BEGIN(KERN_INFO, "------------[ cut here ]------------");
> +	EXPECT_BEGIN(KERN_INFO, "WARNING: <<all>>");
> +	EXPECT_BEGIN(KERN_INFO, "refcount_t: underflow; use-after-free.");
> +	EXPECT_BEGIN(KERN_INFO, "---[ end trace <<int>> ]---");
> +
> +	/* refcount is now zero, this should fail */
> +	unittest(1, "/testcase-data/refcount-node is zero");
> +	of_node_put(np);
> +
> +	EXPECT_END(KERN_INFO, "---[ end trace <<int>> ]---");
> +	EXPECT_END(KERN_INFO, "refcount_t: underflow; use-after-free.");
> +	EXPECT_END(KERN_INFO, "WARNING: <<all>>");
> +	EXPECT_END(KERN_INFO, "------------[ cut here ]------------");
> +
> +	/*
> +	 * Q. do we expect to get yet another warning?
> +	 * A. no, the WARNING is from WARN_ONCE()
> +	 */
> +	EXPECT_NOT_BEGIN(KERN_INFO, "------------[ cut here ]------------");
> +	EXPECT_NOT_BEGIN(KERN_INFO, "WARNING: <<all>>");
> +	EXPECT_NOT_BEGIN(KERN_INFO, "refcount_t: underflow; use-after-free.");
> +	EXPECT_NOT_BEGIN(KERN_INFO, "---[ end trace <<int>> ]---");
> +
> +	unittest(1, "/testcase-data/refcount-node is zero, second time");
> +	of_node_put(np);
> +
> +	EXPECT_NOT_END(KERN_INFO, "---[ end trace <<int>> ]---");
> +	EXPECT_NOT_END(KERN_INFO, "refcount_t: underflow; use-after-free.");
> +	EXPECT_NOT_END(KERN_INFO, "WARNING: <<all>>");
> +	EXPECT_NOT_END(KERN_INFO, "------------[ cut here ]------------");
> +
> +	/*
> +	 * refcount of zero will trigger stack traces from any further
> +	 * attempt to of_node_get() node "refcount-node". One example of
> +	 * this is where of_unittest_check_node_linkage() will recursively
> +	 * scan the tree, with 'for_each_child_of_node()' doing an
> +	 * of_node_get() of the children of a node.
> +	 *
> +	 * Prevent the stack trace by removing node "refcount-node" from
> +	 * its parent's child list.
> +	 *
> +	 * WARNING:  EVIL, EVIL, EVIL:
> +	 *
> +	 *   Directly manipulate the child list of node /testcase-data to
> +	 *   remove child refcount-node.  This is ignoring all proper methods
> +	 *   of removing a child and will leak a small amount of memory.
> +	 */
> +
> +	np = of_find_node_by_path(refcount_parent_path);
> +	unittest(np, "find refcount_parent_path \"%s\"\n", refcount_parent_path);
> +	unittest(np, "ERROR: devicetree live tree left in a 'bad state' if test fail\n");
> +	if (np == NULL)
> +		return;
> +
> +	prev_sibling = np->child;
> +	next_sibling = prev_sibling->sibling;
> +	if (!strcmp(prev_sibling->full_name, "refcount-node")) {
> +		np->child = next_sibling;
> +		next_sibling = next_sibling->sibling;
> +	}
> +	while (next_sibling) {
> +		if (!strcmp(next_sibling->full_name, "refcount-node"))
> +			prev_sibling->sibling = next_sibling->sibling;
> +		prev_sibling = next_sibling;
> +		next_sibling = next_sibling->sibling;
> +	}
> +	of_node_put(np);
> +
> +	return;
> +
> +out_skip_tests:
> +	unittest(0, "One or more lifecycle tests skipped\n");
> +}
> +
>  #ifdef CONFIG_OF_OVERLAY
>  
>  /*
> @@ -3502,6 +3645,7 @@ static int __init of_unittest(void)
>  	of_unittest_match_node();
>  	of_unittest_platform_populate();
>  	of_unittest_overlay();
> +	of_unittest_lifecycle();
>  
>  	/* Double check linkage after removing testcase data */
>  	of_unittest_check_tree_linkage();
> -- 
> Frank Rowand <frowand.list@gmail.com>
> 
