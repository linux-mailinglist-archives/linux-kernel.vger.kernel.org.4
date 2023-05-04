Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9990B6F66F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjEDINS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjEDIMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:12:16 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5754C46A6
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:09:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683187784; x=1683194984; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=C+tRpfsf1TDVCYSsdj7KhPUYicNLucwZCghh4G9pejI=;
 b=TmxJHabASCQUi5F0N/EQB84zkd/h9g7sl1X9dMQjeYWr4NR+VUTbA3mD159tY/MVAGyNfhAhWe2ECuMyVublp9PtZHZSzTalmgUFvjRwvZT+bzfxj8XOTrgVK9nK9sGJvCiVq9J+G0w6MC5GAMUxNvZXZqOj9F53LMdAOstpOUKRSu7hBZwelSmRWsk/jtfnKtllzmoygcfl/ym/y3SP3Vv4ZYiormwHeusMhjZxGzJPHUSj2BrjqH5LUZO2Zuru+kg9xRTYaemOutqn+FJ/gbFJf6RBu3B6/FmOOEP+Wa/NalkixDEtP/SBkLmcxzS6fAS9pATjgQdDBntHmH78kA==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by f5ac2268c446 with SMTP id
 645365d1f77227a83038cb51 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 May 2023 07:59:13 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 06/11] Documentation/hwmon: Revise patch submission checklist
Date:   Thu,  4 May 2023 00:57:47 -0700
Message-Id: <20230504075752.1320967-7-james@equiv.tech>
In-Reply-To: <20230504075752.1320967-1-james@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop capitals from document title for consistency.
Fix minor issues (typos, grammar, etc.) and add markup.

Signed-off-by: James Seo <james@equiv.tech>
---
 Documentation/hwmon/submitting-patches.rst | 110 +++++++++++----------
 1 file changed, 58 insertions(+), 52 deletions(-)

diff --git a/Documentation/hwmon/submitting-patches.rst b/Documentation/hwmon/submitting-patches.rst
index 6482c4f137dc..3ef4b20223ea 100644
--- a/Documentation/hwmon/submitting-patches.rst
+++ b/Documentation/hwmon/submitting-patches.rst
@@ -1,13 +1,15 @@
-How to Get Your Patch Accepted Into the Hwmon Subsystem
 =======================================================
+How to get your patch accepted into the hwmon subsystem
+=======================================================
+
+.. contents::
 
 This text is a collection of suggestions for people writing patches or
-drivers for the hwmon subsystem. Following these suggestions will greatly
+drivers for the ``hwmon`` subsystem. Following these suggestions will greatly
 increase the chances of your change being accepted.
 
-
-1. General
-----------
+General
+=======
 
 * It should be unnecessary to mention, but please read and follow:
 
@@ -15,69 +17,69 @@ increase the chances of your change being accepted.
     - Documentation/process/submitting-patches.rst
     - Documentation/process/coding-style.rst
 
-* Please run your patch through 'checkpatch --strict'. There should be no
-  errors, no warnings, and few if any check messages. If there are any
-  messages, please be prepared to explain.
+* Please run your patch through ``scripts/checkpatch.pl --strict``.
+  There should be no errors, no warnings, and few if any check messages.
+  If there are any messages, please be prepared to explain.
 
 * Please use the standard multi-line comment style. Do not mix C and C++
   style comments in a single driver (with the exception of the SPDX license
   identifier).
 
-* If your patch generates checkpatch errors, warnings, or check messages,
+* If your patch generates ``checkpatch`` errors, warnings, or check messages,
   please refrain from explanations such as "I prefer that coding style".
-  Keep in mind that each unnecessary message helps hiding a real problem,
+  Keep in mind that each unnecessary message helps to hide a real problem,
   and a consistent coding style makes it easier for others to understand
   and review the code.
 
 * Please test your patch thoroughly. We are not your test group.
-  Sometimes a patch can not or not completely be tested because of missing
+  Sometimes a patch cannot or cannot completely be tested because of missing
   hardware. In such cases, you should test-build the code on at least one
-  architecture. If run-time testing was not achieved, it should be written
+  architecture. If runtime testing was not achieved, this should be written
   explicitly below the patch header.
 
 * If your patch (or the driver) is affected by configuration options such as
-  CONFIG_SMP, make sure it compiles for all configuration variants.
+  ``CONFIG_SMP``, make sure it compiles for all configuration variants.
 
 
-2. Adding functionality to existing drivers
--------------------------------------------
+Adding functionality to existing drivers
+========================================
 
-* Make sure the documentation in Documentation/hwmon/<driver_name>.rst is up to
-  date.
+* Make sure the documentation in ``Documentation/hwmon/<driver_name>.rst`` is
+  up-to-date.
 
-* Make sure the information in Kconfig is up to date.
+* Make sure the information in ``Kconfig`` is up-to-date.
 
 * If the added functionality requires some cleanup or structural changes, split
   your patch into a cleanup part and the actual addition. This makes it easier
-  to review your changes, and to bisect any resulting problems.
+  to review your changes and to bisect any resulting problems.
 
 * Never mix bug fixes, cleanup, and functional enhancements in a single patch.
 
 
-3. New drivers
---------------
+New drivers
+===========
 
-* Running your patch or driver file(s) through checkpatch does not mean its
+* Running your patch or driver file(s) through ``checkpatch`` does not mean its
   formatting is clean. If unsure about formatting in your new driver, run it
-  through Lindent. Lindent is not perfect, and you may have to do some minor
-  cleanup, but it is a good start.
+  through ``scripts/Lindent``. ``Lindent`` is not perfect, and you may have to
+  do some minor cleanup, but it is a good start.
 
-* Consider adding yourself to MAINTAINERS.
+* Consider adding yourself to ``MAINTAINERS``.
 
-* Document the driver in Documentation/hwmon/<driver_name>.rst.
+* Document the driver in ``Documentation/hwmon/<driver_name>.rst``.
 
-* Add the driver to Kconfig and Makefile in alphabetical order.
+* Add the driver to ``Kconfig`` and ``Makefile`` in alphabetical order.
 
-* Make sure that all dependencies are listed in Kconfig.
+* Make sure that all dependencies are listed in ``Kconfig``.
 
 * Please list include files in alphabetic order.
 
-* Please align continuation lines with '(' on the previous line.
+* Please align continuation lines with '``(``' on the previous line.
 
 * Avoid forward declarations if you can. Rearrange the code if necessary.
 
 * Avoid macros to generate groups of sensor attributes. It not only confuses
-  checkpatch, but also makes it more difficult to review the code.
+  ``checkpatch``, but also makes it more difficult to review the code.
 
 * Avoid calculations in macros and macro-generated functions. While such macros
   may save a line or so in the source, it obfuscates the code and makes code
@@ -88,16 +90,17 @@ increase the chances of your change being accepted.
   generate an error message just because a runtime operation failed. Report
   errors to user space instead, using an appropriate error code. Keep in mind
   that kernel error log messages not only fill up the kernel log, but also are
-  printed synchronously, most likely with interrupt disabled, often to a serial
-  console. Excessive logging can seriously affect system performance.
+  printed synchronously, most likely with interrupts disabled, and often to a
+  serial console. Excessive logging can seriously affect system performance.
 
-* Use devres functions whenever possible to allocate resources. For rationale
-  and supported functions, please see Documentation/driver-api/driver-model/devres.rst.
-  If a function is not supported by devres, consider using devm_add_action().
+* Use ``devres`` functions whenever possible to allocate resources. For
+  rationale and supported functions, please see
+  Documentation/driver-api/driver-model/devres.rst. If a function is not
+  supported by ``devres``, consider using devm_add_action().
 
 * If the driver has a detect function, make sure it is silent. Debug messages
   and messages printed after a successful detection are acceptable, but it
-  must not print messages such as "Chip XXX not found/supported".
+  must not print messages such as ``Chip XXX not found/supported``.
 
   Keep in mind that the detect function will run for all drivers supporting an
   address if a chip is detected on that address. Unnecessary messages will just
@@ -105,14 +108,14 @@ increase the chances of your change being accepted.
 
 * Provide a detect function if and only if a chip can be detected reliably.
 
-* Only the following I2C addresses shall be probed: 0x18-0x1f, 0x28-0x2f,
-  0x48-0x4f, 0x58, 0x5c, 0x73 and 0x77. Probing other addresses is strongly
-  discouraged as it is known to cause trouble with other (non-hwmon) I2C
-  chips. If your chip lives at an address which can't be probed then the
-  device will have to be instantiated explicitly (which is always better
-  anyway.)
+* Only the following I2C addresses shall be probed: ``0x18``-``0x1f``,
+  ``0x28``-``0x2f``, ``0x48``-``0x4f``, ``0x58``, ``0x5c``, ``0x73``,
+  and ``0x77``. Probing other addresses is strongly discouraged, as it is
+  known to cause trouble with other (non-``hwmon``) I2C chips. If your chip
+  lives at an address which can't be probed, then the device will have to be
+  instantiated explicitly (which is always better anyway).
 
-* Avoid writing to chip registers in the detect function. If you have to write,
+* Avoid writing to chip registers in the detect function. If you must,
   only do it after you have already gathered enough data to be certain that the
   detection is going to be successful.
 
@@ -121,25 +124,28 @@ increase the chances of your change being accepted.
 
 * Make sure there are no race conditions in the probe function. Specifically,
   completely initialize your chip and your driver first, then register with
-  the hwmon subsystem.
+  the ``hwmon`` subsystem.
 
-* Use devm_hwmon_device_register_with_info() or, if your driver needs a remove
-  function, hwmon_device_register_with_info() to register your driver with the
-  hwmon subsystem. Try using devm_add_action() instead of a remove function if
-  possible. Do not use any of the deprecated registration functions.
+* Use
+  :ref:`devm_hwmon_device_register_with_info() <devm_hwmon_device_register_with_info>`
+  or, if your driver needs a remove function,
+  :ref:`hwmon_device_register_with_info() <hwmon_device_register_with_info>` to
+  register your driver with the ``hwmon`` subsystem. Try using devm_add_action()
+  instead of a remove function if possible. Do not use any of the deprecated
+  registration functions.
 
-* Your driver should be buildable as module. If not, please be prepared to
+* Your driver should be buildable as a module. If not, please be prepared to
   explain why it has to be built into the kernel.
 
-* Do not provide support for deprecated sysfs attributes.
+* Do not provide support for deprecated ``sysfs`` attributes.
 
 * Do not create non-standard attributes unless really needed. If you have to use
   non-standard attributes, or you believe you do, discuss it on the mailing list
-  first. Either case, provide a detailed explanation why you need the
+  first. In either case, provide a detailed explanation why you need the
   non-standard attribute(s).
   Standard attributes are specified in Documentation/hwmon/sysfs-interface.rst.
 
-* When deciding which sysfs attributes to support, look at the chip's
+* When deciding which ``sysfs`` attributes to support, look at the chip's
   capabilities. While we do not expect your driver to support everything the
   chip may offer, it should at least support all limits and alarms.
 
-- 
2.34.1

