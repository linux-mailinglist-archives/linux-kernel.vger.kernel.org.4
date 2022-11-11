Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE244626128
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiKKS3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiKKS3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:29:30 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B95B5A7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:29:29 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-37010fefe48so50819147b3.19
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r84PG1jgHBipBYlbDtpXYn0KfCJQRPPV8o0t+BC7r80=;
        b=RTy2mC0LwDZH56aX/w5OhguMBUe0+J5NWLoqXauoT3IvbjP/GZvP1lp3Ift6APPArw
         S0endsxM2v7avWGZ+xCuwXUGDN1LUVmi91L7dhjt+htx7KxAGxyNOFM7nD2b5cV9Gjet
         buNVVDzwkcV0nD4TURr1q/Yb95l5qlwiHrXiN1Wa5ZSlFNtuhxnJZ+it6EZo//YgJeik
         FE+LS07QdGQf7NGbEIgl3UI5l28xphpdu91FyM0N5oN+V6awlfOCHo16TYQtqzA0GQ7I
         yz623pljBCpZ0pOe/hhh3r7I+V3xhKWBdS4NYzn+am8dRY/ZDPkW2jqT444VqZ7G5oFX
         0AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r84PG1jgHBipBYlbDtpXYn0KfCJQRPPV8o0t+BC7r80=;
        b=gkc61cO6U+X58y4WFaP4c7DqSELolj92HG7ZAF5bpiPMa95+9DhFo4rAUGotcx31vi
         BUdh4T0RH7QA7Yvq/UhbiKYoL49AgslYqGSccCLOHZGvkDefLhTEzNJZAoll9bP3zAak
         kjP+8GdQPakXbG3vabKDJe5zDFGSOqasSd1ouXFkbz+shFbhoV5rp6287FJJfrQeL1OF
         dignWSCE+9HSibP2uq7rpzy2TyfPlyO+MhaEA9/YgEkou02Sq2k43h1L6NefZnHnEQ10
         BgOAspNCsGoDTUCkANy46YGP+LctmN/8VzNkLBVgbb5UejbY4gsyvDBnHrqhUE4yMEMz
         vOOw==
X-Gm-Message-State: ACrzQf1f9goEJe1qkR31/libBChdcExyN1DRdA2qGz1W0fmUDQAC+AJZ
        07FQ6SoL44nWUnhW4HYkZ+30I55My37I8w==
X-Google-Smtp-Source: AMsMyM5gX6MRToLN85JAmPfGGO3zA2+D/4SmfJVxgoEu/EYsQQaI5mVzMkNQzf6jmQcMK68t0u9cNyV/pHbppg==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a81:5d7:0:b0:367:300a:b24a with SMTP id
 206-20020a8105d7000000b00367300ab24amr65639713ywf.128.1668191368372; Fri, 11
 Nov 2022 10:29:28 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:29:06 -0800
In-Reply-To: <20221111182906.1377191-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221111182906.1377191-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111182906.1377191-3-dlatypov@google.com>
Subject: [PATCH v3 3/3] Documentation: kunit: Remove redundant 'tips.rst' page
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Gow <davidgow@google.com>

The contents of 'tips.rst' was mostly included in 'usage.rst' way back in
commit 953574390634 ("Documentation: KUnit: Rework writing page to focus on writing tests"),
but the tips page remained behind as well.

The parent patches in this series fill in the gaps, so now 'tips.rst' is
redundant.
Therefore, delete 'tips.rst'.

While I regret breaking any links to 'tips' which might exist
externally, it's confusing to have two subtly different versions of the
same content around.

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>
---
v1 -> v2: rebased onto some parent patches to fix the missing sections
in usage.rst and tweaked the commit message to reflect that.
---
 Documentation/dev-tools/kunit/index.rst |   1 -
 Documentation/dev-tools/kunit/tips.rst  | 190 ------------------------
 2 files changed, 191 deletions(-)
 delete mode 100644 Documentation/dev-tools/kunit/tips.rst

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index f5d13f1d37be..d5629817cd72 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -16,7 +16,6 @@ KUnit - Linux Kernel Unit Testing
 	api/index
 	style
 	faq
-	tips
 	running_tips
 
 This section details the kernel unit testing framework.
diff --git a/Documentation/dev-tools/kunit/tips.rst b/Documentation/dev-tools/kunit/tips.rst
deleted file mode 100644
index 492d2ded2f5a..000000000000
--- a/Documentation/dev-tools/kunit/tips.rst
+++ /dev/null
@@ -1,190 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-============================
-Tips For Writing KUnit Tests
-============================
-
-Exiting early on failed expectations
-------------------------------------
-
-``KUNIT_EXPECT_EQ`` and friends will mark the test as failed and continue
-execution.  In some cases, it's unsafe to continue and you can use the
-``KUNIT_ASSERT`` variant to exit on failure.
-
-.. code-block:: c
-
-	void example_test_user_alloc_function(struct kunit *test)
-	{
-		void *object = alloc_some_object_for_me();
-
-		/* Make sure we got a valid pointer back. */
-		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, object);
-		do_something_with_object(object);
-	}
-
-Allocating memory
------------------
-
-Where you would use ``kzalloc``, you should prefer ``kunit_kzalloc`` instead.
-KUnit will ensure the memory is freed once the test completes.
-
-This is particularly useful since it lets you use the ``KUNIT_ASSERT_EQ``
-macros to exit early from a test without having to worry about remembering to
-call ``kfree``.
-
-Example:
-
-.. code-block:: c
-
-	void example_test_allocation(struct kunit *test)
-	{
-		char *buffer = kunit_kzalloc(test, 16, GFP_KERNEL);
-		/* Ensure allocation succeeded. */
-		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
-
-		KUNIT_ASSERT_STREQ(test, buffer, "");
-	}
-
-
-Testing static functions
-------------------------
-
-If you don't want to expose functions or variables just for testing, one option
-is to conditionally ``#include`` the test file at the end of your .c file, e.g.
-
-.. code-block:: c
-
-	/* In my_file.c */
-
-	static int do_interesting_thing();
-
-	#ifdef CONFIG_MY_KUNIT_TEST
-	#include "my_kunit_test.c"
-	#endif
-
-Injecting test-only code
-------------------------
-
-Similarly to the above, it can be useful to add test-specific logic.
-
-.. code-block:: c
-
-	/* In my_file.h */
-
-	#ifdef CONFIG_MY_KUNIT_TEST
-	/* Defined in my_kunit_test.c */
-	void test_only_hook(void);
-	#else
-	void test_only_hook(void) { }
-	#endif
-
-This test-only code can be made more useful by accessing the current kunit
-test, see below.
-
-Accessing the current test
---------------------------
-
-In some cases, you need to call test-only code from outside the test file, e.g.
-like in the example above or if you're providing a fake implementation of an
-ops struct.
-There is a ``kunit_test`` field in ``task_struct``, so you can access it via
-``current->kunit_test``.
-
-Here's a slightly in-depth example of how one could implement "mocking":
-
-.. code-block:: c
-
-	#include <linux/sched.h> /* for current */
-
-	struct test_data {
-		int foo_result;
-		int want_foo_called_with;
-	};
-
-	static int fake_foo(int arg)
-	{
-		struct kunit *test = current->kunit_test;
-		struct test_data *test_data = test->priv;
-
-		KUNIT_EXPECT_EQ(test, test_data->want_foo_called_with, arg);
-		return test_data->foo_result;
-	}
-
-	static void example_simple_test(struct kunit *test)
-	{
-		/* Assume priv is allocated in the suite's .init */
-		struct test_data *test_data = test->priv;
-
-		test_data->foo_result = 42;
-		test_data->want_foo_called_with = 1;
-
-		/* In a real test, we'd probably pass a pointer to fake_foo somewhere
-		 * like an ops struct, etc. instead of calling it directly. */
-		KUNIT_EXPECT_EQ(test, fake_foo(1), 42);
-	}
-
-
-Note: here we're able to get away with using ``test->priv``, but if you wanted
-something more flexible you could use a named ``kunit_resource``, see
-Documentation/dev-tools/kunit/api/test.rst.
-
-Failing the current test
-------------------------
-
-But sometimes, you might just want to fail the current test. In that case, we
-have ``kunit_fail_current_test(fmt, args...)`` which is defined in ``<kunit/test-bug.h>`` and
-doesn't require pulling in ``<kunit/test.h>``.
-
-E.g. say we had an option to enable some extra debug checks on some data structure:
-
-.. code-block:: c
-
-	#include <kunit/test-bug.h>
-
-	#ifdef CONFIG_EXTRA_DEBUG_CHECKS
-	static void validate_my_data(struct data *data)
-	{
-		if (is_valid(data))
-			return;
-
-		kunit_fail_current_test("data %p is invalid", data);
-
-		/* Normal, non-KUnit, error reporting code here. */
-	}
-	#else
-	static void my_debug_function(void) { }
-	#endif
-
-
-Customizing error messages
---------------------------
-
-Each of the ``KUNIT_EXPECT`` and ``KUNIT_ASSERT`` macros have a ``_MSG`` variant.
-These take a format string and arguments to provide additional context to the automatically generated error messages.
-
-.. code-block:: c
-
-	char some_str[41];
-	generate_sha1_hex_string(some_str);
-
-	/* Before. Not easy to tell why the test failed. */
-	KUNIT_EXPECT_EQ(test, strlen(some_str), 40);
-
-	/* After. Now we see the offending string. */
-	KUNIT_EXPECT_EQ_MSG(test, strlen(some_str), 40, "some_str='%s'", some_str);
-
-Alternatively, one can take full control over the error message by using ``KUNIT_FAIL()``, e.g.
-
-.. code-block:: c
-
-	/* Before */
-	KUNIT_EXPECT_EQ(test, some_setup_function(), 0);
-
-	/* After: full control over the failure message. */
-	if (some_setup_function())
-		KUNIT_FAIL(test, "Failed to setup thing for testing");
-
-Next Steps
-==========
-*   Optional: see the Documentation/dev-tools/kunit/usage.rst page for a more
-    in-depth explanation of KUnit.
-- 
2.38.1.431.g37b22c650d-goog

