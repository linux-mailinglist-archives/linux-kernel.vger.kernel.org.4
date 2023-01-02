Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D197865B6A3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjABShQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjABShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:37:13 -0500
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF942ED;
        Mon,  2 Jan 2023 10:37:08 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 3EC124193A;
        Mon,  2 Jan 2023 19:37:07 +0100 (CET)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1672684624; x=1674499025; bh=BSfz+XNA3oYeLRZIFz2
        hXFGbvI1zFTdIifZMGr+t8+w=; b=qwxaL3r5an62S3tAUz7TItmvIisLPzhAg/W
        uj7OGiXkzS/coXAytK5ELv4+2VcND4T6VklXNlNjhcBv52NJtHOWHtBOTRc2SN36
        I8TlB7pPZMjNai4yoDjzTvB8knoXMxAmwldL+Tn/6JX6U+UFfChuX+tr7tH05NY7
        KwnzbRv5T3SEx6KI0bGLSUpFK8rXk6axJlOyl2hfiDlLLmk4EzPuy7UehPcAJ/Eu
        JUeznimiSJ1xUz4y5JP1UWN3FgV/lwz8F34Jqg7OfBC3M/k1XMrd0+Kkn4GItK6g
        w/dsth6NHiE4yqBm86GmbZ5k4Gw4Lbt6yx8r4PAHqjTRw2WhdvEStULKs41PvmjG
        WhxyvnGLGrjd0bJ/OodLsvibsOhvOihaqwA4/5OcnZGtucfdVdJCsNd2xMBXA493
        SFKktQQHw94kcQa3JsodG7FZHvZodHDrezPpRY4DerOUjT5FgDIqvqU6kzVX4GxD
        hjRJ2KgYfc2aILe94OfI2nCC0nMtKXw9lDvFYrm6zRAm1OtPPH+7peoMEDFnh0D9
        negn8NnX89t8hTu7j0gOjz1nJEDLpFQKpjyfTH4an486RT526Wu7H9QiHhzCK6sv
        bnaFthhHun0Xlugo7Gz58n7M1BFdKAFpJhOCYulSkNo+pG43dQNiioFn5K9yuuHj
        7xypDWiM=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1U7p7B3JoEV0; Mon,  2 Jan 2023 19:37:04 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 4BD0C41935;
        Mon,  2 Jan 2023 19:37:03 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id E81EE3340;
        Mon,  2 Jan 2023 19:37:02 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] doc: monospace style for inline code in botching ioctl
Date:   Mon,  2 Jan 2023 19:36:49 +0100
Message-Id: <20230102183649.9626-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Highlighting inline code improves text readability.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---

V1 -> V2 use the kernel-doc mecanism to link functions in documents

 Documentation/process/botching-up-ioctls.rst | 24 ++++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/process/botching-up-ioctls.rst b/Documentation/process/botching-up-ioctls.rst
index 9739b88463a5..088d372ecc3c 100644
--- a/Documentation/process/botching-up-ioctls.rst
+++ b/Documentation/process/botching-up-ioctls.rst
@@ -28,7 +28,7 @@ First the prerequisites. Without these you have already failed, because you
 will need to add a 32-bit compat layer:
 
  * Only use fixed sized integers. To avoid conflicts with typedefs in userspace
-   the kernel has special types like __u32, __s64. Use them.
+   the kernel has special types like ``__u32``, ``__s64``. Use them.
 
  * Align everything to the natural size and use explicit padding. 32-bit
    platforms don't necessarily align 64-bit values to 64-bit boundaries, but
@@ -41,12 +41,12 @@ will need to add a 32-bit compat layer:
    structures to the kernel, or if the kernel checks the structure size, which
    e.g. the drm core does.
 
- * Pointers are __u64, cast from/to a uintptr_t on the userspace side and
-   from/to a void __user * in the kernel. Try really hard not to delay this
-   conversion or worse, fiddle the raw __u64 through your code since that
-   diminishes the checking tools like sparse can provide. The macro
-   u64_to_user_ptr can be used in the kernel to avoid warnings about integers
-   and pointers of different sizes.
+ * Pointers are ``__u64``, cast from/to a ``uintptr_t`` on the userspace side
+   and from/to a ``void __user *`` in the kernel. Try really hard not to delay
+   this conversion or worse, fiddle the raw ``__u64`` through your code since
+   that diminishes the checking tools like sparse can provide. The macro
+   u64_to_user_ptr() can be used in the kernel to avoid warnings about
+   integers and pointers of different sizes.
 
 
 Basics
@@ -132,8 +132,8 @@ wait for outstanding ones. This is really tricky business; at the moment none of
 the ioctls supported by the drm/i915 get this fully right, which means there's
 still tons more lessons to learn here.
 
- * Use CLOCK_MONOTONIC as your reference time, always. It's what alsa, drm and
-   v4l use by default nowadays. But let userspace know which timestamps are
+ * Use ``CLOCK_MONOTONIC`` as your reference time, always. It's what alsa, drm
+   and v4l use by default nowadays. But let userspace know which timestamps are
    derived from different clock domains like your main system clock (provided
    by the kernel) or some independent hardware counter somewhere else. Clocks
    will mismatch if you look close enough, but if performance measuring tools
@@ -141,8 +141,8 @@ still tons more lessons to learn here.
    get at the raw values of some clocks (e.g. through in-command-stream
    performance counter sampling instructions) consider exposing those also.
 
- * Use __s64 seconds plus __u64 nanoseconds to specify time. It's not the most
-   convenient time specification, but it's mostly the standard.
+ * Use ``__s64`` seconds plus ``__u64`` nanoseconds to specify time. It's not
+   the most convenient time specification, but it's mostly the standard.
 
  * Check that input time values are normalized and reject them if not. Note
    that the kernel native struct ktime has a signed integer for both seconds
@@ -178,7 +178,7 @@ entails its own little set of pitfalls:
    needs to be shared across processes -  fd-passing over unix domain sockets
    also simplifies lifetime management for userspace.
 
- * Always have O_CLOEXEC support.
+ * Always have ``O_CLOEXEC`` support.
 
  * Ensure that you have sufficient insulation between different clients. By
    default pick a private per-fd namespace which forces any sharing to be done
-- 
2.30.2

