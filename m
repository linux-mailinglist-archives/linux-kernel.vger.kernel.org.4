Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B93626127
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiKKS3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiKKS31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:29:27 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111565CD05
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:29:27 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id c10-20020a17090aa60a00b00212e91df6acso3082412pjq.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KcgFgh+nSA6rGpYyKLAuOEZq9MjORsirblL9B+ChLi0=;
        b=GN/K8LkzrC3Xi5m04YE/88CUGXGI57CIBf0CroPXanf1c2e6S7KaF1zLqjHRHaJxTx
         GjvPAk0vMcz6bA+Z4e5AcNtwS8mrZeHu5LV1+rn9AUJ2buoMWZLYzv9ZOeqx8p90AClW
         d6tTK9BSyqanwQ7lWbOgSTQgzJu5hJc6k6RH4Umsl2iyoKEsZeEo3LWxKjJAeFlbRGdn
         t2T0hO+T2pQQWkpLB6mpYhu5eIgLgYbYKfQyVBtJ2LKCmwARyFYbzrW+mPnt/8U1HCuE
         vfvziKXdQL3Iy3zXYcXgXULs2DiskUzS69Uezt504J3TOKAHeIuvc8XiNQcxhonzGESx
         1eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcgFgh+nSA6rGpYyKLAuOEZq9MjORsirblL9B+ChLi0=;
        b=Qxx3+yQeYDDqu1JpuZIn2mF8cVFz1jcpSRcac6Uaqeb0IjgQmSxNkvjRRSV7yPEIau
         KJRwQfEmyr1SIhX91NCABkylmok0f82VUG9h6m/43CW2hXAcVNG4pMJGt6lYIi72y+FC
         i5LIKvCVjkiimOKnvJPDEkejUjn3UzfXPDPWHS1yQcXjEjvS3Dr+6lU2zWr4mYsql/HT
         4NhgaAQlSBhztYpiGzMdEz8LC+71MAo09Cx8B73sIQB8+A0mHae9wsl2VjnPCEOW1euU
         y7dKt+qw1Ii5teVWMF3Pd3EeztGl0OB6t+NSRnDOUqPNfnBMMtX2uasbcP2NOizbsJ8P
         MwFA==
X-Gm-Message-State: ANoB5plN+2C8+tomvvklw4sVl+yK3CNTA49xkGhR4EhpXWp4G+ewfyWI
        3HxVGFXqtUpZW3uaqI/qeKONHDpCvlFLeg==
X-Google-Smtp-Source: AA0mqf4NpCqVqQb5VhOoQGCCFX1K81V4IUVGkY7iGc1jDIwrgceDHzDGMr97O9zfwN+WASG6WpOvW/XDWu9a6w==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:902:9302:b0:187:3a43:3a9d with SMTP
 id bc2-20020a170902930200b001873a433a9dmr3593182plb.152.1668191366583; Fri,
 11 Nov 2022 10:29:26 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:29:05 -0800
In-Reply-To: <20221111182906.1377191-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221111182906.1377191-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111182906.1377191-2-dlatypov@google.com>
Subject: [PATCH v3 2/3] Documentation: KUnit: reword description of assertions
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing wording implies that kunit_kmalloc_array() is "the method
under test". We're actually testing the sort() function in that example.
This is because the example was changed in commit 953574390634
("Documentation: KUnit: Rework writing page to focus on writing tests"),
but the wording was not.

Also add a `note` telling people they can use the KUNIT_ASSERT_EQ()
macros from any function. Some users might be coming from a framework
like gUnit where that'll compile but silently do the wrong thing.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index b0a6c3bc0eeb..22416ebb94ab 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -112,11 +112,14 @@ terminates the test case if the condition is not satisfied. For example:
 			KUNIT_EXPECT_LE(test, a[i], a[i + 1]);
 	}
 
-In this example, the method under test should return pointer to a value. If the
-pointer returns null or an errno, we want to stop the test since the following
-expectation could crash the test case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us
-to bail out of the test case if the appropriate conditions are not satisfied to
-complete the test.
+In this example, we need to be able to allocate an array to test the ``sort()``
+function. So we use ``KUNIT_ASSERT_NOT_ERR_OR_NULL()`` to abort the test if
+there's an allocation error.
+
+.. note::
+   In other test frameworks, ``ASSERT`` macros are often implemented by calling
+   ``return`` so they only work from the test function. In KUnit, we stop the
+   current kthread on failure, so you can call them from anywhere.
 
 Customizing error messages
 --------------------------
-- 
2.38.1.431.g37b22c650d-goog

