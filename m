Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A166005DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiJQD5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiJQD5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:57:49 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFFA52DDE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:57:48 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id j188so10889612oih.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2ulezN6n3fW4gIR3MRedZj9xrarrQsVwftkxYuRwq0=;
        b=IrfIKt+5y/gs6W6ELxgNmFqmXXCX21BkPpZpsiinawkTYbBOqTr8cuBU2GqSLwKgKH
         nEl7Cd4hWozyq4p65tSBUnR29k9HD0aLGtWQatQs68vp+OS5UI2sQAvQYxyUEaRiFW7X
         YjFgUEJzhsqE3iOS7LZzHNzEmRldSQvBbtXyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2ulezN6n3fW4gIR3MRedZj9xrarrQsVwftkxYuRwq0=;
        b=oF9Ep3klIrQSQ5EuU03JZQyylN3CBB0a7mdbQMj8Dy4dCYC4HTr8japMHaLYd71vpS
         YeB1k6Y+M07yWnia11T4s1+/0bkYkT+ZKguQeuI9qNGh92q3cPvY8QCuLDi9df9/GNy2
         O5E+RuQ6Yprg3wdiqv3YiFrBGw1BerrgcuHc9/IOVx1w3VKtNiHlTaaauUTiIjws29lk
         2pSNC1THA2VF+xz6rWk3eDunNA59iQIM/US3o/su3ci3W/MgXllZm7FWIIMbLJOCV3s4
         IiY/VAjaSGz7lDmBc2ByFBbJxp/DfhYF0KL8XZLRHT3iHMAjkAYebliE/blOcpvpMIdB
         CUZQ==
X-Gm-Message-State: ACrzQf1hqK6Z/+akjMl6OdX4hn3ndkUYbkiOE+iYaDUNHNaj7d9gV/ne
        dxjOVDvXK/6zVu803eErgdNw9AojdswHDg==
X-Google-Smtp-Source: AMsMyM7vddG6dOUiDylAVSCIKgAkDA56A+COZS0XgOWAeI6xldp2N43JIycYvHh7kxOXsmMR4rHQOQ==
X-Received: by 2002:a17:90b:1a88:b0:20d:8df0:ac63 with SMTP id ng8-20020a17090b1a8800b0020d8df0ac63mr27792670pjb.206.1665979057231;
        Sun, 16 Oct 2022 20:57:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q9-20020a638c49000000b0041cd5ddde6fsm5303878pgn.76.2022.10.16.20.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 20:57:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] overflow: Fix kern-doc markup for functions
Date:   Sun, 16 Oct 2022 20:57:32 -0700
Message-Id: <20221017035732.1968394-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6343; h=from:subject; bh=7HZx7BtD5Vm36kdgMSNdrMiBfAsCzfUGxVyegNLLZ9E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTNKsNIHA2/VImzICGTlQN0giQB5nJcAk3AuFTsUZ jSgIQZKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0zSrAAKCRCJcvTf3G3AJtZIEA CGY/xs8MySMZNcXSPPFAcGiSWNGjSC4m00Deka94ljVZ0wj7SL7P55rmlOEvabeNtbEKG9cK8L8NlA tFY2D6NRbSI6q30yET9Co3+y/9GrrOUppYfW0d11iYlTjPV2Hcuf9BvDiGroirtZq5eeK267YcjRRu wF1TNFaPE2vekP/18x7yLmm3E3/+Wl+I/qDkxKluL2sOZTB1N8tqs0aJ0wbwW/uPM+NwwvfF3sSBdS 4JtCAhZXpFLHEB1Nc7O/vlqghx0ZfNDJfSNSfle42ifAlnrvBUtUB9ZfTMmvYGX68tamoxVWQJ1kTq QJBdi4jWOmyJbI92hGKMaYNs4tVYZNhcvdCVDF+3+w9FzrW+drjHAdHkzPlHTribuO7D4FyEO2pvLj 4PO3E0YNgXLk7Bq7PTB01jHakert4fcaOBhhIXYZwGtf/FVjFAoHWNdYUE3tcJXkPAOu1JeIiwutJO vSppgCtj/G+EwrKXDEWm1F4b4gpTKnQuzgietpXlhKXalf30+A820Fupum6UU1Bl62Slm+0iCZoABT kQ7KY22yuVGKNw+7ckahNs/f9sfEXyQAWpBsN4R1hP0UJonSQQa4U/4qn1HjISVC7/lpvz8mtxg+sG r5Ahm4AChbxjvlNazRn+XBh4LtXCMkG1UJRgGsabG8AT1/CMrKMghRB8rbLA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 Documentation/core-api/kernel-api.rst |  6 +++++
 Documentation/driver-api/basics.rst   |  3 ---
 include/linux/overflow.h              | 38 +++++++++++----------------
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 0793c400d4b0..06f4ab122697 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -118,6 +118,12 @@ Text Searching
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
index 19dfdd74835e..1d3be1a2204c 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -51,8 +51,8 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	return unlikely(overflow);
 }
 
-/** check_add_overflow() - Calculate addition with overflow checking
- *
+/**
+ * check_add_overflow() - Calculate addition with overflow checking
  * @a: first addend
  * @b: second addend
  * @d: pointer to store sum
@@ -66,8 +66,8 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_add_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_add_overflow(a, b, d))
 
-/** check_sub_overflow() - Calculate subtraction with overflow checking
- *
+/**
+ * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
  * @b: subtrahend; value to subtract from @a
  * @d: pointer to store difference
@@ -81,8 +81,8 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_sub_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_sub_overflow(a, b, d))
 
-/** check_mul_overflow() - Calculate multiplication with overflow checking
- *
+/**
+ * check_mul_overflow() - Calculate multiplication with overflow checking
  * @a: first factor
  * @b: second factor
  * @d: pointer to store product
@@ -96,23 +96,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_mul_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
-/** check_shl_overflow() - Calculate a left-shifted value and check overflow
- *
+/**
+ * check_shl_overflow() - Calculate a left-shifted value and check overflow
  * @a: Value to be shifted
  * @s: How many bits left to shift
  * @d: Pointer to where to store the result
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
@@ -129,7 +130,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 
 /**
  * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
- *
  * @factor1: first factor
  * @factor2: second factor
  *
@@ -149,7 +149,6 @@ static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
 
 /**
  * size_add() - Calculate size_t addition with saturation at SIZE_MAX
- *
  * @addend1: first addend
  * @addend2: second addend
  *
@@ -169,7 +168,6 @@ static inline size_t __must_check size_add(size_t addend1, size_t addend2)
 
 /**
  * size_sub() - Calculate size_t subtraction with saturation at SIZE_MAX
- *
  * @minuend: value to subtract from
  * @subtrahend: value to subtract from @minuend
  *
@@ -192,7 +190,6 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 
 /**
  * array_size() - Calculate size of 2-dimensional array.
- *
  * @a: dimension one
  * @b: dimension two
  *
@@ -205,7 +202,6 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 
 /**
  * array3_size() - Calculate size of 3-dimensional array.
- *
  * @a: dimension one
  * @b: dimension two
  * @c: dimension three
@@ -220,7 +216,6 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 /**
  * flex_array_size() - Calculate size of a flexible array member
  *                     within an enclosing structure.
- *
  * @p: Pointer to the structure.
  * @member: Name of the flexible array member.
  * @count: Number of elements in the array.
@@ -237,7 +232,6 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 
 /**
  * struct_size() - Calculate size of structure with trailing flexible array.
- *
  * @p: Pointer to the structure.
  * @member: Name of the array member.
  * @count: Number of elements in the array.
-- 
2.34.1

