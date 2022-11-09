Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC46220E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiKIAga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIAg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:36:27 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C70A63156
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 16:36:26 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c7-20020a170903234700b0018729febd96so12244182plh.19
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 16:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CZKNxZ4ut/Q7ACsrFTYtA5PMiQEhI2gWEXdAM+wb9gg=;
        b=cYSLYVLkoMHuam5SuetiF8cgGiYoAYiOA1FDE0de+JVwbInSf58Fn7Nuqba7t29Tlm
         kAEkRJI243IEl56URLz4GqhHzc5kNIoyBU5dolJ68qRmCHxVduAFhPFH9sXXHt7fsP2m
         wmOYn67OQtdmCCrHj+8T+iKeAM2KzgvXbTWuWou/qcNVuehaO2UQIl6x966q4q7Z8zpd
         Ngq+YURUPwM23Bk/LkbCwHiBmOToe4IyoOidBtQN8lPzxQ470F5rRAwMWnq3T1F7EKp0
         isviHND/AkHcHu1qZfF96e0YUSkLT9d59G44rU/vjx0VWjDPLr9E1T9TmfaZIhC402Jc
         UqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZKNxZ4ut/Q7ACsrFTYtA5PMiQEhI2gWEXdAM+wb9gg=;
        b=uGNn3nyujfayjeFMLCifu/pETX0detScG10rm+ZbsoftSoZibEh/4VrZUEgMVWrzdP
         LPTDnlVYI8tnLCcIRmn6c7z1V7FXOJplk+Y3OWKqwSmO8UxIewaFQBJwMvYUHgikRAXE
         tT/fdAeLWpBKxTyjihbJzWuvfLVMc83CXBM2RNTEP7sLm3p0OPbDSSxpaVuXptKf2lqn
         6WEiJZ1gGn2ablnwVBhQ5EGbqvP+EQlYE75ohpttkMwZLJk0t++/w0gAYre3sbHrSklx
         p83EgbaW0P0qZH6CP9pOfLCdjwG/rkEdRvFA40f0yzF4Ga2OGy407/114OF/ji45t9Ec
         VesA==
X-Gm-Message-State: ACrzQf2ss912KG76PD+6iA3e/oKcEl2+TLlFdLeyc4OLairnG3UklzOB
        7N9mhwMEhfsBA0jBas4zF9I0Lo434BsSlQ==
X-Google-Smtp-Source: AMsMyM5l1InG0bHkfyqtHlCsU7XWX0gLXIAXXCROhFBi9h+H8VfW0HVhDGCUeTz7B6sT1CNJ/zoHWriib5mDQw==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:f3d4:b0:213:959f:5a90 with SMTP
 id ha20-20020a17090af3d400b00213959f5a90mr63952761pjb.54.1667954185985; Tue,
 08 Nov 2022 16:36:25 -0800 (PST)
Date:   Tue,  8 Nov 2022 16:36:16 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109003618.3784591-1-dlatypov@google.com>
Subject: [PATCH v2 1/3] Documentation: KUnit: make usage.rst a superset of
 tips.rst, remove duplication
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usage.rst had most of the content of the tips.rst page copied over.
But it's missing https://www.kernel.org/doc/html/v6.0/dev-tools/kunit/tips.html#customizing-error-messages
Copy it over so we can retire tips.rst w/o losing content.

And in that process, it also gained a duplicate section about how
KUNIT_ASSERT_*() exit the test case early. Remove that.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 49 ++++++++++++++++---------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 2737863ef365..b0a6c3bc0eeb 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -118,6 +118,37 @@ expectation could crash the test case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us
 to bail out of the test case if the appropriate conditions are not satisfied to
 complete the test.
 
+Customizing error messages
+--------------------------
+
+Each of the ``KUNIT_EXPECT`` and ``KUNIT_ASSERT`` macros have a ``_MSG``
+variant.  These take a format string and arguments to provide additional
+context to the automatically generated error messages.
+
+.. code-block:: c
+
+	char some_str[41];
+	generate_sha1_hex_string(some_str);
+
+	/* Before. Not easy to tell why the test failed. */
+	KUNIT_EXPECT_EQ(test, strlen(some_str), 40);
+
+	/* After. Now we see the offending string. */
+	KUNIT_EXPECT_EQ_MSG(test, strlen(some_str), 40, "some_str='%s'", some_str);
+
+Alternatively, one can take full control over the error message by using
+``KUNIT_FAIL()``, e.g.
+
+.. code-block:: c
+
+	/* Before */
+	KUNIT_EXPECT_EQ(test, some_setup_function(), 0);
+
+	/* After: full control over the failure message. */
+	if (some_setup_function())
+		KUNIT_FAIL(test, "Failed to setup thing for testing");
+
+
 Test Suites
 ~~~~~~~~~~~
 
@@ -546,24 +577,6 @@ By reusing the same ``cases`` array from above, we can write the test as a
 		{}
 	};
 
-Exiting Early on Failed Expectations
-------------------------------------
-
-We can use ``KUNIT_EXPECT_EQ`` to mark the test as failed and continue
-execution.  In some cases, it is unsafe to continue. We can use the
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
 Allocating Memory
 -----------------
 

base-commit: 6fe1ad4a156095859721fef85073df3ed43081d4
-- 
2.38.1.431.g37b22c650d-goog

