Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BA46220E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiKIAgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiKIAg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:36:29 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BD863155
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 16:36:28 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pq17-20020a17090b3d9100b0020a4c65c3a9so6908329pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 16:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i16E6SEJ1XE3RexrHSv+UKrQKUgWn1ksElBhVAhWC74=;
        b=ozndvYKnYfbi79PbuCYdzeMtofBcdWRIc10S48fA0ZiNj/LbcnyA78EeEyHbGlu9n6
         7J9OUUeOSTjZdMHJ2Jj8jMxpE5/dNiSdsErzggvwEEW2nUjxnCa6+TDqTkoDJz9gOj99
         WXadIIjgvnxIVJ/DBFiBgHJkkWlKthceyqDaVjg9MiPmZqLDPR9LHxZsOGuMW6BjHu/c
         3eJf90rCsgm0AwbOvUrB59Y/Jmt+M8z3+xf8wujZCxWlDqOqjDioHBcPrSHS2jcF5xIG
         mcVvtHsOwHn5TgP74M+8eZTB81t5B4R9Xo69adh1fUPMDntg2alkPx9VTHycCQY1TfJc
         Zpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i16E6SEJ1XE3RexrHSv+UKrQKUgWn1ksElBhVAhWC74=;
        b=fKCHd+Bh95eSTID1URhvU7ZcNoo0N5RXScFOCWIdCOEFV8UeTWOl8AvLNIV+Z6zvJq
         CPu/6hqZeGUacOV7y0922BQjPC9SSINE6V5K0ee+m8rYqqKYW3lTWO9uOPKFzpp9AnFS
         dLdiIxaZAsHEmm2Q1UrqXPideJUzG8hREjRd+9B+4dztXEOKvR8ywc/7Xbc0WoVxsttZ
         cB5oCvC8HxfYNbqRVv4fdSq5mvKW5KsH7aXs4/uAJYTMOc/Q+ejxFrKTpawzNcDSmH8o
         Jtsih8ReaT3ZWA4JRhSwCrFUuO8k+Q0ewzaXeR7bmcBh9O5534BPBJd4VHXD6cqiaDXN
         Kb/A==
X-Gm-Message-State: ANoB5plqGTJPQfcn/xFZMsaC+ZXKYuQmkNNiLl5Jtr36CVvXyJn3DK+I
        IXve0HmFLTMstN0FLYdyr8aMtFcWDeaL9Q==
X-Google-Smtp-Source: AA0mqf5yfuylOiuYjTt1prubEe1a8GxqxTj996/7IMLwczKZeOoEfPOlOooJtBe4a0OmGrUTg498bwsh10ozXg==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:aa7:9ad7:0:b0:56e:d7f4:3c4a with SMTP id
 x23-20020aa79ad7000000b0056ed7f43c4amr657937pfp.76.1667954187657; Tue, 08 Nov
 2022 16:36:27 -0800 (PST)
Date:   Tue,  8 Nov 2022 16:36:17 -0800
In-Reply-To: <20221109003618.3784591-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221109003618.3784591-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109003618.3784591-2-dlatypov@google.com>
Subject: [PATCH v2 2/3] Documentation: KUnit: reword description of assertions
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

The existing wording implies that kunit_kmalloc_array() is "the method
under test". We're actually testing the sort() function in that example.
This is because the example was changed in commit 953574390634
("Documentation: KUnit: Rework writing page to focus on writing tests"),
but the wording was not.

Also add a `note` telling people they can use the KUNIT_ASSERT_EQ()
macros from any function. Some users might be coming from a framework
like gUnit where that'll compile but silently do the wrong thing.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index b0a6c3bc0eeb..8060114e3aa6 100644
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
+we there's an allocation error.
+
+.. note::
+   In other test frameworks, ``ASSERT`` macros are often implemented by calling
+   ``return`` so they only work from the test function. In KUnit, we stop the
+   current kthread on failure, so you can call them from anywhere.
 
 Customizing error messages
 --------------------------
-- 
2.38.1.431.g37b22c650d-goog

