Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8D15EB186
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIZTr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiIZTrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:47:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFCEA030B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:47:16 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 3so7508331pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZlICVrogearv1SNrgNdDyrmevECXfWWv2T83Z8YgO/0=;
        b=N72HnbW5sMb92Q4N/bHZzDTNdb4ybAcE8r9IeS1ZaUm4g+VCbclqW5dTR4hrxICF+U
         XRIx7I6cBdy72OPPbY1ryHlJIyGz6jDtjoDGXSoUfO9xiC+yQvPw5QkzyfTYSil/J6BQ
         arId7t6AQzxGSEyQQhF8/jC26EXyDtkCM1DD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZlICVrogearv1SNrgNdDyrmevECXfWWv2T83Z8YgO/0=;
        b=c3zXJgfaKpvnuFmIV4svlpH4RvQA1NnnUn3gq+wjl8LC34XBINMXacDPDKb/CPocfJ
         H+gVtnYj6v68+SGFB2py/dqVNHNemWBaKF4JAhy9lgt/vbN0jHNeknnCtFNsXy7lzhkf
         2/GVeJkYAr2q6Faf++SVKWgHxu/tt3NW1Qo6c7mEF3TAKTR5PmYxZo5bB34zA6WkBu8X
         NDoTgTlLk7idofkN2vGYG3z5AeBNEb9EdGRDbfAHVjoDtOGL6BuOMmbEWl/3Q960j99x
         w7Ysy5wmPbKvF2v/x7Z4uso29v1cTYBO6s1+1G8451jDmLdeTIegzTduJ4TFInVZ+my5
         XhIA==
X-Gm-Message-State: ACrzQf2VRQY/bE06Xvh73VBIizvZC9QgQb2fvupefDmjKU3M+kQxuPfq
        c4Ktf1FxtAtYJNd254TgcEJOfg==
X-Google-Smtp-Source: AMsMyM46ZKCBt4vnZ6cvNv2xFJ4zMtqYAExJV1tiwALAiTO2eAifiY9luw1EWNA5MhmGUBA0BtqajQ==
X-Received: by 2002:a05:6a00:a05:b0:534:b1ad:cfac with SMTP id p5-20020a056a000a0500b00534b1adcfacmr25053072pfh.35.1664221635658;
        Mon, 26 Sep 2022 12:47:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b0016ed8af2ec0sm11748282plg.29.2022.09.26.12.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 12:47:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] overflow: Fix kern-doc markup for functions
Date:   Mon, 26 Sep 2022 12:47:13 -0700
Message-Id: <20220926194713.1806917-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6889; h=from:subject; bh=0PMShzQ6EtJF+kRUqPhXtNPnTNusvCqcZvTzeg25ZSg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjMgHAcuS1Ak0XX+ChZpczDofMNNUiFb6phvm+EPXJ vd1yFnWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYzIBwAAKCRCJcvTf3G3AJsVAD/ wPqoGRtTA9mVe6LhiBA9MsJ2zOFjvc9MWJ7nqqm7gsu0vHwGZ/H0xL02y31F2dxCIwmIJUw0cpmQem 8/KwdDgvz9TWCO5xX6Uqv5Su/JrMmOAStgvqA63TfF+5YqWemyjZrM5y9HnaCAXN56gWbg28hWmGxo MqvJjxkrI2Ke0uQJC7M6SxAgQVSyqzilFwzSf70B3MVz3dKwDi7pMn3rdbnEy0KMNT5mHeRpFglOxd +mekH+Ch/3aNQhFX8xI7y3a3qjp3shLEF5kEDxX+zaDT7MaJIKGyxWNxhX4yRdzroZl1w1Qxl19+lt 9WlQX1zNjmpnhGaerzVIuRRtZl3cK3aOBQUeUsExG8jBSebGbv9fvsqAPesbFShQgLApITemZCYE4S FhkMLm/4XNK97w/VMGjHAtunZraG6O2wMTRjQgUocENw4mGodTNZV8BBDlvGc0RTL7bwumsL0UbZba yhsRI/01KZiPDYOAFYnA7XmiMeVUEuNQSQYC0cYxTcyKJA9SZaOr9g+hLn+eVsbV/nbG48EBW1EW0Y JQ2guS/fEZ5lOvw1zcGDDFRyNUJVSKd2+cqBH9C3w0msq0V6mlRcj9xiMEUnaQAvkHK2HywbK3YDJh 1BCC83tR43TGWjgeuYbNXUnZFpj+Q1Wc3lRBgx37rgIFiaDHP7nKuh1qs6nA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the kern-doc markings for several of the overflow helpers and move
their location into the core kernel API documentation, where it belongs
(it's not driver-specific).

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/core-api/kernel-api.rst |  6 ++++
 Documentation/driver-api/basics.rst   |  3 --
 include/linux/overflow.h              | 43 +++++++++++++++------------
 3 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 20569f26dde1..0d0c4f87057c 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -121,6 +121,12 @@ Text Searching
 CRC and Math Functions in Linux
 ===============================
 
+Arithmetic Overflow Checking
+----------------------------
+
+.. kernel-doc:: include/linux/overflow.h
+   :internal:
+
 CRC Functions
 -------------
 
diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
index 3e2dae954898..4b4d8e28d3be 100644
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -107,9 +107,6 @@ Kernel utility functions
 .. kernel-doc:: kernel/panic.c
    :export:
 
-.. kernel-doc:: include/linux/overflow.h
-   :internal:
-
 Device Resource Management
 --------------------------
 
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 58eb34aa2af9..4b5b3ec91233 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -51,7 +51,8 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	return unlikely(overflow);
 }
 
-/** check_add_overflow() - Calculate addition with overflow checking
+/**
+ * check_add_overflow - Calculate addition with overflow checking
  *
  * @a: first addend
  * @b: second addend
@@ -66,7 +67,8 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_add_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_add_overflow(a, b, d))
 
-/** check_sub_overflow() - Calculate subtraction with overflow checking
+/**
+ * check_sub_overflow - Calculate subtraction with overflow checking
  *
  * @a: minuend; value to subtract from
  * @b: subtrahend; value to subtract from @a
@@ -81,7 +83,8 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_sub_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_sub_overflow(a, b, d))
 
-/** check_mul_overflow() - Calculate multiplication with overflow checking
+/**
+ * check_mul_overflow - Calculate multiplication with overflow checking
  *
  * @a: first factor
  * @b: second factor
@@ -96,7 +99,8 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_mul_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
-/** check_shl_overflow() - Calculate a left-shifted value and check overflow
+/**
+ * check_shl_overflow - Calculate a left-shifted value and check overflow
  *
  * @a: Value to be shifted
  * @s: How many bits left to shift
@@ -104,15 +108,16 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  *
  * Computes *@d = (@a << @s)
  *
- * Returns true if '*d' cannot hold the result or when 'a << s' doesn't
+ * Returns true if '*@d' cannot hold the result or when '@a << @s' doesn't
  * make sense. Example conditions:
- * - 'a << s' causes bits to be lost when stored in *d.
- * - 's' is garbage (e.g. negative) or so large that the result of
- *   'a << s' is guaranteed to be 0.
- * - 'a' is negative.
- * - 'a << s' sets the sign bit, if any, in '*d'.
  *
- * '*d' will hold the results of the attempted shift, but is not
+ * - '@a << @s' causes bits to be lost when stored in *@d.
+ * - '@s' is garbage (e.g. negative) or so large that the result of
+ *   '@a << @s' is guaranteed to be 0.
+ * - '@a' is negative.
+ * - '@a << @s' sets the sign bit, if any, in '*@d'.
+ *
+ * '*@d' will hold the results of the attempted shift, but is not
  * considered "safe for use" if true is returned.
  */
 #define check_shl_overflow(a, s, d) __must_check_overflow(({		\
@@ -176,7 +181,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 			      __same_type(n, T))
 
 /**
- * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
+ * size_mul - Calculate size_t multiplication with saturation at SIZE_MAX
  *
  * @factor1: first factor
  * @factor2: second factor
@@ -196,7 +201,7 @@ static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
 }
 
 /**
- * size_add() - Calculate size_t addition with saturation at SIZE_MAX
+ * size_add - Calculate size_t addition with saturation at SIZE_MAX
  *
  * @addend1: first addend
  * @addend2: second addend
@@ -216,7 +221,7 @@ static inline size_t __must_check size_add(size_t addend1, size_t addend2)
 }
 
 /**
- * size_sub() - Calculate size_t subtraction with saturation at SIZE_MAX
+ * size_sub - Calculate size_t subtraction with saturation at SIZE_MAX
  *
  * @minuend: value to subtract from
  * @subtrahend: value to subtract from @minuend
@@ -239,7 +244,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 }
 
 /**
- * array_size() - Calculate size of 2-dimensional array.
+ * array_size - Calculate size of 2-dimensional array.
  *
  * @a: dimension one
  * @b: dimension two
@@ -252,7 +257,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 #define array_size(a, b)	size_mul(a, b)
 
 /**
- * array3_size() - Calculate size of 3-dimensional array.
+ * array3_size - Calculate size of 3-dimensional array.
  *
  * @a: dimension one
  * @b: dimension two
@@ -266,8 +271,8 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 #define array3_size(a, b, c)	size_mul(size_mul(a, b), c)
 
 /**
- * flex_array_size() - Calculate size of a flexible array member
- *                     within an enclosing structure.
+ * flex_array_size - Calculate size of a flexible array member
+ *                   within an enclosing structure.
  *
  * @p: Pointer to the structure.
  * @member: Name of the flexible array member.
@@ -284,7 +289,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
 
 /**
- * struct_size() - Calculate size of structure with trailing flexible array.
+ * struct_size - Calculate size of structure with trailing flexible array.
  *
  * @p: Pointer to the structure.
  * @member: Name of the array member.
-- 
2.34.1

