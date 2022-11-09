Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA496622B3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKIMQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKIMPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:15:53 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E253013F9B;
        Wed,  9 Nov 2022 04:15:51 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id df087b2105b8bcc1; Wed, 9 Nov 2022 13:15:49 +0100
Received: from kreacher.localnet (unknown [213.134.163.195])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7DAA966EBA7;
        Wed,  9 Nov 2022 13:15:48 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 3/5] rtc: rtc-cmos: Eliminate forward declarations of some functions
Date:   Wed, 09 Nov 2022 13:09:32 +0100
Message-ID: <13157911.uLZWGnKmhe@kreacher>
In-Reply-To: <5640233.DvuYhMxLoT@kreacher>
References: <5640233.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.195
X-CLIENT-HOSTNAME: 213.134.163.195
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrfedvgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudeifedrudelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrdduleehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhrthgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
 rdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegrrdiiuhhmmhhosehtohifvghrthgvtghhrdhithdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] rtc: rtc-cmos: 

Reorder the ACPI-related code before cmos_do_probe() so as to eliminate
excessive forward declarations of some functions.

While at it, for consistency, add the inline modifier to the
definitions of empty stub static funtions and remove it from the
corresponding definitions of functions with non-empty bodies.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

No changes since v1.

---
 drivers/rtc/rtc-cmos.c |  304 ++++++++++++++++++++++++-------------------------
 1 file changed, 149 insertions(+), 155 deletions(-)

Index: linux-pm/drivers/rtc/rtc-cmos.c
===================================================================
--- linux-pm.orig/drivers/rtc/rtc-cmos.c
+++ linux-pm/drivers/rtc/rtc-cmos.c
@@ -744,8 +744,155 @@ static irqreturn_t cmos_interrupt(int ir
 		return IRQ_NONE;
 }
 
-static inline void rtc_wake_setup(struct device *dev);
-static void cmos_wake_setup(struct device *dev);
+#ifdef	CONFIG_ACPI
+
+#include <linux/acpi.h>
+
+static u32 rtc_handler(void *context)
+{
+	struct device *dev = context;
+	struct cmos_rtc *cmos = dev_get_drvdata(dev);
+	unsigned char rtc_control = 0;
+	unsigned char rtc_intr;
+	unsigned long flags;
+
+
+	/*
+	 * Always update rtc irq when ACPI is used as RTC Alarm.
+	 * Or else, ACPI SCI is enabled during suspend/resume only,
+	 * update rtc irq in that case.
+	 */
+	if (cmos_use_acpi_alarm())
+		cmos_interrupt(0, (void *)cmos->rtc);
+	else {
+		/* Fix me: can we use cmos_interrupt() here as well? */
+		spin_lock_irqsave(&rtc_lock, flags);
+		if (cmos_rtc.suspend_ctrl)
+			rtc_control = CMOS_READ(RTC_CONTROL);
+		if (rtc_control & RTC_AIE) {
+			cmos_rtc.suspend_ctrl &= ~RTC_AIE;
+			CMOS_WRITE(rtc_control, RTC_CONTROL);
+			rtc_intr = CMOS_READ(RTC_INTR_FLAGS);
+			rtc_update_irq(cmos->rtc, 1, rtc_intr);
+		}
+		spin_unlock_irqrestore(&rtc_lock, flags);
+	}
+
+	pm_wakeup_hard_event(dev);
+	acpi_clear_event(ACPI_EVENT_RTC);
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
+	return ACPI_INTERRUPT_HANDLED;
+}
+
+static void rtc_wake_setup(struct device *dev)
+{
+	if (acpi_disabled)
+		return;
+
+	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, dev);
+	/*
+	 * After the RTC handler is installed, the Fixed_RTC event should
+	 * be disabled. Only when the RTC alarm is set will it be enabled.
+	 */
+	acpi_clear_event(ACPI_EVENT_RTC);
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
+}
+
+static void rtc_wake_on(struct device *dev)
+{
+	acpi_clear_event(ACPI_EVENT_RTC);
+	acpi_enable_event(ACPI_EVENT_RTC, 0);
+}
+
+static void rtc_wake_off(struct device *dev)
+{
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
+}
+
+#ifdef CONFIG_X86
+/* Enable use_acpi_alarm mode for Intel platforms no earlier than 2015 */
+static void use_acpi_alarm_quirks(void)
+{
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return;
+
+	if (!is_hpet_enabled())
+		return;
+
+	if (dmi_get_bios_year() < 2015)
+		return;
+
+	use_acpi_alarm = true;
+}
+#else
+static inline void use_acpi_alarm_quirks(void) { }
+#endif
+
+static void cmos_wake_setup(struct device *dev)
+{
+	if (acpi_disabled)
+		return;
+
+	use_acpi_alarm_quirks();
+
+	cmos_rtc.wake_on = rtc_wake_on;
+	cmos_rtc.wake_off = rtc_wake_off;
+
+	/* ACPI tables bug workaround. */
+	if (acpi_gbl_FADT.month_alarm && !acpi_gbl_FADT.day_alarm) {
+		dev_dbg(dev, "bogus FADT month_alarm (%d)\n",
+			acpi_gbl_FADT.month_alarm);
+		acpi_gbl_FADT.month_alarm = 0;
+	}
+
+	cmos_rtc.day_alrm = acpi_gbl_FADT.day_alarm;
+	cmos_rtc.mon_alrm = acpi_gbl_FADT.month_alarm;
+	cmos_rtc.century = acpi_gbl_FADT.century;
+
+	if (acpi_gbl_FADT.flags & ACPI_FADT_S4_RTC_WAKE)
+		dev_info(dev, "RTC can wake from S4\n");
+
+	/* RTC always wakes from S1/S2/S3, and often S4/STD */
+	device_init_wakeup(dev, 1);
+}
+
+static void cmos_check_acpi_rtc_status(struct device *dev,
+					      unsigned char *rtc_control)
+{
+	struct cmos_rtc *cmos = dev_get_drvdata(dev);
+	acpi_event_status rtc_status;
+	acpi_status status;
+
+	if (acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)
+		return;
+
+	status = acpi_get_event_status(ACPI_EVENT_RTC, &rtc_status);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Could not get RTC status\n");
+	} else if (rtc_status & ACPI_EVENT_FLAG_SET) {
+		unsigned char mask;
+		*rtc_control &= ~RTC_AIE;
+		CMOS_WRITE(*rtc_control, RTC_CONTROL);
+		mask = CMOS_READ(RTC_INTR_FLAGS);
+		rtc_update_irq(cmos->rtc, 1, mask);
+	}
+}
+
+#else /* !CONFIG_ACPI */
+
+static inline void rtc_wake_setup(struct device *dev)
+{
+}
+
+static inline void cmos_wake_setup(struct device *dev)
+{
+}
+
+static inline void cmos_check_acpi_rtc_status(struct device *dev,
+					      unsigned char *rtc_control)
+{
+}
+#endif /* CONFIG_ACPI */
 
 #ifdef	CONFIG_PNP
 #define	INITSECTION
@@ -1140,9 +1287,6 @@ static void cmos_check_wkalrm(struct dev
 	}
 }
 
-static void cmos_check_acpi_rtc_status(struct device *dev,
-				       unsigned char *rtc_control);
-
 static int __maybe_unused cmos_resume(struct device *dev)
 {
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
@@ -1209,156 +1353,6 @@ static SIMPLE_DEV_PM_OPS(cmos_pm_ops, cm
  * predate even PNPBIOS should set up platform_bus devices.
  */
 
-#ifdef	CONFIG_ACPI
-
-#include <linux/acpi.h>
-
-static u32 rtc_handler(void *context)
-{
-	struct device *dev = context;
-	struct cmos_rtc *cmos = dev_get_drvdata(dev);
-	unsigned char rtc_control = 0;
-	unsigned char rtc_intr;
-	unsigned long flags;
-
-
-	/*
-	 * Always update rtc irq when ACPI is used as RTC Alarm.
-	 * Or else, ACPI SCI is enabled during suspend/resume only,
-	 * update rtc irq in that case.
-	 */
-	if (cmos_use_acpi_alarm())
-		cmos_interrupt(0, (void *)cmos->rtc);
-	else {
-		/* Fix me: can we use cmos_interrupt() here as well? */
-		spin_lock_irqsave(&rtc_lock, flags);
-		if (cmos_rtc.suspend_ctrl)
-			rtc_control = CMOS_READ(RTC_CONTROL);
-		if (rtc_control & RTC_AIE) {
-			cmos_rtc.suspend_ctrl &= ~RTC_AIE;
-			CMOS_WRITE(rtc_control, RTC_CONTROL);
-			rtc_intr = CMOS_READ(RTC_INTR_FLAGS);
-			rtc_update_irq(cmos->rtc, 1, rtc_intr);
-		}
-		spin_unlock_irqrestore(&rtc_lock, flags);
-	}
-
-	pm_wakeup_hard_event(dev);
-	acpi_clear_event(ACPI_EVENT_RTC);
-	acpi_disable_event(ACPI_EVENT_RTC, 0);
-	return ACPI_INTERRUPT_HANDLED;
-}
-
-static inline void rtc_wake_setup(struct device *dev)
-{
-	if (acpi_disabled)
-		return;
-
-	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, dev);
-	/*
-	 * After the RTC handler is installed, the Fixed_RTC event should
-	 * be disabled. Only when the RTC alarm is set will it be enabled.
-	 */
-	acpi_clear_event(ACPI_EVENT_RTC);
-	acpi_disable_event(ACPI_EVENT_RTC, 0);
-}
-
-static void rtc_wake_on(struct device *dev)
-{
-	acpi_clear_event(ACPI_EVENT_RTC);
-	acpi_enable_event(ACPI_EVENT_RTC, 0);
-}
-
-static void rtc_wake_off(struct device *dev)
-{
-	acpi_disable_event(ACPI_EVENT_RTC, 0);
-}
-
-#ifdef CONFIG_X86
-/* Enable use_acpi_alarm mode for Intel platforms no earlier than 2015 */
-static void use_acpi_alarm_quirks(void)
-{
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
-		return;
-
-	if (!is_hpet_enabled())
-		return;
-
-	if (dmi_get_bios_year() < 2015)
-		return;
-
-	use_acpi_alarm = true;
-}
-#else
-static inline void use_acpi_alarm_quirks(void) { }
-#endif
-
-static void cmos_wake_setup(struct device *dev)
-{
-	if (acpi_disabled)
-		return;
-
-	use_acpi_alarm_quirks();
-
-	cmos_rtc.wake_on = rtc_wake_on;
-	cmos_rtc.wake_off = rtc_wake_off;
-
-	/* ACPI tables bug workaround. */
-	if (acpi_gbl_FADT.month_alarm && !acpi_gbl_FADT.day_alarm) {
-		dev_dbg(dev, "bogus FADT month_alarm (%d)\n",
-			acpi_gbl_FADT.month_alarm);
-		acpi_gbl_FADT.month_alarm = 0;
-	}
-
-	cmos_rtc.day_alrm = acpi_gbl_FADT.day_alarm;
-	cmos_rtc.mon_alrm = acpi_gbl_FADT.month_alarm;
-	cmos_rtc.century = acpi_gbl_FADT.century;
-
-	if (acpi_gbl_FADT.flags & ACPI_FADT_S4_RTC_WAKE)
-		dev_info(dev, "RTC can wake from S4\n");
-
-	/* RTC always wakes from S1/S2/S3, and often S4/STD */
-	device_init_wakeup(dev, 1);
-}
-
-static void cmos_check_acpi_rtc_status(struct device *dev,
-				       unsigned char *rtc_control)
-{
-	struct cmos_rtc *cmos = dev_get_drvdata(dev);
-	acpi_event_status rtc_status;
-	acpi_status status;
-
-	if (acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)
-		return;
-
-	status = acpi_get_event_status(ACPI_EVENT_RTC, &rtc_status);
-	if (ACPI_FAILURE(status)) {
-		dev_err(dev, "Could not get RTC status\n");
-	} else if (rtc_status & ACPI_EVENT_FLAG_SET) {
-		unsigned char mask;
-		*rtc_control &= ~RTC_AIE;
-		CMOS_WRITE(*rtc_control, RTC_CONTROL);
-		mask = CMOS_READ(RTC_INTR_FLAGS);
-		rtc_update_irq(cmos->rtc, 1, mask);
-	}
-}
-
-#else
-
-static void cmos_wake_setup(struct device *dev)
-{
-}
-
-static void cmos_check_acpi_rtc_status(struct device *dev,
-				       unsigned char *rtc_control)
-{
-}
-
-static void rtc_wake_setup(struct device *dev)
-{
-}
-#endif
-
 #ifdef	CONFIG_PNP
 
 #include <linux/pnp.h>



