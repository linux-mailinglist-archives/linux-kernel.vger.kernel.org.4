Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A061E63DA02
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiK3PzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiK3PzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:55:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47372C672;
        Wed, 30 Nov 2022 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669823703; x=1701359703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pHHx40nNpBcEMGD23l0UjCP+x8Q8o2hccTEsLv7t7vw=;
  b=Ua8xLNJHl39fcUZ7ZMKyo1axBYNgk2LHDmnrMZ6fL5N9Vn+id7YA87q4
   AIT9f0vUMVTb8SaViL7MfZFbhfwgj5oUW6v9IN4ScV8+gkGpjOxR1FaDj
   k61/8cb80fXSUbKNiTM6uZ+giQ7uxs4JssE8Ku7rWK3jlbS1sFQyI/KyQ
   RouyU93PBnjdt4dggFm+FmtCGckF0dG9pQLA6GdgI1AKwjToT5CKdiCr2
   Rzy04TknPQ1OP+z7jcPuAc7vQrRVh1DD+WoFZy0itKD/nLAkkzhU0Liuw
   nO0Bn5n4DdICgOsECVDL10/WQRgXhFFdq0DYKqs+cDfWdy6exN3V7WcMW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="298799861"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="298799861"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 07:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="889336389"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="889336389"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 30 Nov 2022 07:54:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 06A62179; Wed, 30 Nov 2022 17:55:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 3/3] Documentation: gpio: Replace leading TABs by spaces in the code blocks
Date:   Wed, 30 Nov 2022 17:55:19 +0200
Message-Id: <20221130155519.20362-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code blocks are indented with two spaces, if the leading TAB
is occurred the syntax highlighting might be broken in some editors.
To prevent that unify all code blocks by using spaces instead of
leading TAB(s).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/gpio/driver.rst | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index 3d2f36001a7a..d69ea7547aee 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -7,7 +7,7 @@ This document serves as a guide for writers of GPIO chip drivers.
 Each GPIO controller driver needs to include the following header, which defines
 the structures used to define a GPIO driver::
 
-	#include <linux/gpio/driver.h>
+  #include <linux/gpio/driver.h>
 
 
 Internal Representation of GPIOs
@@ -144,7 +144,7 @@ is not open, it will present a high-impedance (tristate) to the external rail::
      in ----||                   |/
             ||--+         in ----|
                 |                |\
-               GND	           GND
+               GND                 GND
 
 This configuration is normally used as a way to achieve one of two things:
 
@@ -574,10 +574,10 @@ the interrupt separately and go with it:
   struct my_gpio *g;
   struct gpio_irq_chip *girq;
 
-  ret = devm_request_threaded_irq(dev, irq, NULL,
-		irq_thread_fn, IRQF_ONESHOT, "my-chip", g);
+  ret = devm_request_threaded_irq(dev, irq, NULL, irq_thread_fn,
+                                  IRQF_ONESHOT, "my-chip", g);
   if (ret < 0)
-	return ret;
+      return ret;
 
   /* Get a pointer to the gpio_irq_chip */
   girq = &g->gc.irq;
@@ -705,12 +705,12 @@ certain operations and keep track of usage inside of the gpiolib subsystem.
 Input GPIOs can be used as IRQ signals. When this happens, a driver is requested
 to mark the GPIO as being used as an IRQ::
 
-	int gpiochip_lock_as_irq(struct gpio_chip *chip, unsigned int offset)
+  int gpiochip_lock_as_irq(struct gpio_chip *chip, unsigned int offset)
 
 This will prevent the use of non-irq related GPIO APIs until the GPIO IRQ lock
 is released::
 
-	void gpiochip_unlock_as_irq(struct gpio_chip *chip, unsigned int offset)
+  void gpiochip_unlock_as_irq(struct gpio_chip *chip, unsigned int offset)
 
 When implementing an irqchip inside a GPIO driver, these two functions should
 typically be called in the .startup() and .shutdown() callbacks from the
@@ -732,12 +732,12 @@ When a GPIO is used as an IRQ signal, then gpiolib also needs to know if
 the IRQ is enabled or disabled. In order to inform gpiolib about this,
 the irqchip driver should call::
 
-	void gpiochip_disable_irq(struct gpio_chip *chip, unsigned int offset)
+  void gpiochip_disable_irq(struct gpio_chip *chip, unsigned int offset)
 
 This allows drivers to drive the GPIO as an output while the IRQ is
 disabled. When the IRQ is enabled again, a driver should call::
 
-	void gpiochip_enable_irq(struct gpio_chip *chip, unsigned int offset)
+  void gpiochip_enable_irq(struct gpio_chip *chip, unsigned int offset)
 
 When implementing an irqchip inside a GPIO driver, these two functions should
 typically be called in the .irq_disable() and .irq_enable() callbacks from the
@@ -787,12 +787,12 @@ Sometimes it is useful to allow a GPIO chip driver to request its own GPIO
 descriptors through the gpiolib API. A GPIO driver can use the following
 functions to request and free descriptors::
 
-	struct gpio_desc *gpiochip_request_own_desc(struct gpio_desc *desc,
-						    u16 hwnum,
-						    const char *label,
-						    enum gpiod_flags flags)
+  struct gpio_desc *gpiochip_request_own_desc(struct gpio_desc *desc,
+                                              u16 hwnum,
+                                              const char *label,
+                                              enum gpiod_flags flags)
 
-	void gpiochip_free_own_desc(struct gpio_desc *desc)
+  void gpiochip_free_own_desc(struct gpio_desc *desc)
 
 Descriptors requested with gpiochip_request_own_desc() must be released with
 gpiochip_free_own_desc().
-- 
2.35.1

