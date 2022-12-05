Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086656430DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiLESzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiLESzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:55:08 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E7A20BD9;
        Mon,  5 Dec 2022 10:55:03 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 39d244090674e85d; Mon, 5 Dec 2022 19:55:01 +0100
Received: from kreacher.localnet (unknown [213.134.188.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 849872801E8C;
        Mon,  5 Dec 2022 19:55:00 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] PM: runtime: Adjust white space in the core code
Date:   Mon, 05 Dec 2022 19:54:59 +0100
Message-ID: <12105949.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.188.181
X-CLIENT-HOSTNAME: 213.134.188.181
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppedvudefrddufeegrddukeekrddukedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekkedrudekuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthht
 oheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some inconsistent usage of white space in the PM-runtime core code
causes that code to be somewhat harder to read that it would have
been otherwise, so adjust the white space in there to be more
consistent with the rest of the code.

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   69 +++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -243,8 +243,7 @@ void pm_runtime_set_memalloc_noio(struct
 		 * flag was set by any one of the descendants.
 		 */
 		if (!dev || (!enable &&
-			     device_for_each_child(dev, NULL,
-						   dev_memalloc_noio)))
+		    device_for_each_child(dev, NULL, dev_memalloc_noio)))
 			break;
 	}
 	mutex_unlock(&dev_hotplug_mutex);
@@ -265,15 +264,13 @@ static int rpm_check_suspend_allowed(str
 		retval = -EACCES;
 	else if (atomic_read(&dev->power.usage_count))
 		retval = -EAGAIN;
-	else if (!dev->power.ignore_children &&
-			atomic_read(&dev->power.child_count))
+	else if (!dev->power.ignore_children && atomic_read(&dev->power.child_count))
 		retval = -EBUSY;
 
 	/* Pending resume requests take precedence over suspends. */
-	else if ((dev->power.deferred_resume
-			&& dev->power.runtime_status == RPM_SUSPENDING)
-	    || (dev->power.request_pending
-			&& dev->power.request == RPM_REQ_RESUME))
+	else if ((dev->power.deferred_resume &&
+	    dev->power.runtime_status == RPM_SUSPENDING) ||
+	    (dev->power.request_pending && dev->power.request == RPM_REQ_RESUME))
 		retval = -EAGAIN;
 	else if (__dev_pm_qos_resume_latency(dev) == 0)
 		retval = -EPERM;
@@ -404,9 +401,9 @@ static int __rpm_callback(int (*cb)(stru
 		 *
 		 * Do that if resume fails too.
 		 */
-		if (use_links
-		    && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
-		    || (dev->power.runtime_status == RPM_RESUMING && retval))) {
+		if (use_links &&
+		    ((dev->power.runtime_status == RPM_SUSPENDING && !retval) ||
+		    (dev->power.runtime_status == RPM_RESUMING && retval))) {
 			idx = device_links_read_lock();
 
 			__rpm_put_suppliers(dev, false);
@@ -491,6 +488,7 @@ static int rpm_idle(struct device *dev,
 	/* Act as though RPM_NOWAIT is always set. */
 	else if (dev->power.idle_notification)
 		retval = -EINPROGRESS;
+
 	if (retval)
 		goto out;
 
@@ -574,12 +572,12 @@ static int rpm_suspend(struct device *de
 	/* Synchronous suspends are not allowed in the RPM_RESUMING state. */
 	if (dev->power.runtime_status == RPM_RESUMING && !(rpmflags & RPM_ASYNC))
 		retval = -EAGAIN;
+
 	if (retval)
 		goto out;
 
 	/* If the autosuspend_delay time hasn't expired yet, reschedule. */
-	if ((rpmflags & RPM_AUTO)
-	    && dev->power.runtime_status != RPM_SUSPENDING) {
+	if ((rpmflags & RPM_AUTO) && dev->power.runtime_status != RPM_SUSPENDING) {
 		u64 expires = pm_runtime_autosuspend_expiration(dev);
 
 		if (expires != 0) {
@@ -594,7 +592,7 @@ static int rpm_suspend(struct device *de
 			 * rest.
 			 */
 			if (!(dev->power.timer_expires &&
-					dev->power.timer_expires <= expires)) {
+			    dev->power.timer_expires <= expires)) {
 				/*
 				 * We add a slack of 25% to gather wakeups
 				 * without sacrificing the granularity.
@@ -604,9 +602,9 @@ static int rpm_suspend(struct device *de
 
 				dev->power.timer_expires = expires;
 				hrtimer_start_range_ns(&dev->power.suspend_timer,
-						ns_to_ktime(expires),
-						slack,
-						HRTIMER_MODE_ABS);
+						       ns_to_ktime(expires),
+						       slack,
+						       HRTIMER_MODE_ABS);
 			}
 			dev->power.timer_autosuspends = 1;
 			goto out;
@@ -797,8 +795,8 @@ static int rpm_resume(struct device *dev
 		goto out;
 	}
 
-	if (dev->power.runtime_status == RPM_RESUMING
-	    || dev->power.runtime_status == RPM_SUSPENDING) {
+	if (dev->power.runtime_status == RPM_RESUMING ||
+	    dev->power.runtime_status == RPM_SUSPENDING) {
 		DEFINE_WAIT(wait);
 
 		if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
@@ -825,8 +823,8 @@ static int rpm_resume(struct device *dev
 		for (;;) {
 			prepare_to_wait(&dev->power.wait_queue, &wait,
 					TASK_UNINTERRUPTIBLE);
-			if (dev->power.runtime_status != RPM_RESUMING
-			    && dev->power.runtime_status != RPM_SUSPENDING)
+			if (dev->power.runtime_status != RPM_RESUMING &&
+			    dev->power.runtime_status != RPM_SUSPENDING)
 				break;
 
 			spin_unlock_irq(&dev->power.lock);
@@ -846,9 +844,9 @@ static int rpm_resume(struct device *dev
 	 */
 	if (dev->power.no_callbacks && !parent && dev->parent) {
 		spin_lock_nested(&dev->parent->power.lock, SINGLE_DEPTH_NESTING);
-		if (dev->parent->power.disable_depth > 0
-		    || dev->parent->power.ignore_children
-		    || dev->parent->power.runtime_status == RPM_ACTIVE) {
+		if (dev->parent->power.disable_depth > 0 ||
+		    dev->parent->power.ignore_children ||
+		    dev->parent->power.runtime_status == RPM_ACTIVE) {
 			atomic_inc(&dev->parent->power.child_count);
 			spin_unlock(&dev->parent->power.lock);
 			retval = 1;
@@ -877,6 +875,7 @@ static int rpm_resume(struct device *dev
 		parent = dev->parent;
 		if (dev->power.irq_safe)
 			goto skip_parent;
+
 		spin_unlock(&dev->power.lock);
 
 		pm_runtime_get_noresume(parent);
@@ -886,8 +885,8 @@ static int rpm_resume(struct device *dev
 		 * Resume the parent if it has runtime PM enabled and not been
 		 * set to ignore its children.
 		 */
-		if (!parent->power.disable_depth
-		    && !parent->power.ignore_children) {
+		if (!parent->power.disable_depth &&
+		    !parent->power.ignore_children) {
 			rpm_resume(parent, 0);
 			if (parent->power.runtime_status != RPM_ACTIVE)
 				retval = -EBUSY;
@@ -897,6 +896,7 @@ static int rpm_resume(struct device *dev
 		spin_lock(&dev->power.lock);
 		if (retval)
 			goto out;
+
 		goto repeat;
 	}
  skip_parent:
@@ -1301,9 +1301,9 @@ int __pm_runtime_set_status(struct devic
 		 * not active, has runtime PM enabled and the
 		 * 'power.ignore_children' flag unset.
 		 */
-		if (!parent->power.disable_depth
-		    && !parent->power.ignore_children
-		    && parent->power.runtime_status != RPM_ACTIVE) {
+		if (!parent->power.disable_depth &&
+		    !parent->power.ignore_children &&
+		    parent->power.runtime_status != RPM_ACTIVE) {
 			dev_err(dev, "runtime PM trying to activate child device %s but parent (%s) is not active\n",
 				dev_name(dev),
 				dev_name(parent));
@@ -1368,9 +1368,9 @@ static void __pm_runtime_barrier(struct
 		dev->power.request_pending = false;
 	}
 
-	if (dev->power.runtime_status == RPM_SUSPENDING
-	    || dev->power.runtime_status == RPM_RESUMING
-	    || dev->power.idle_notification) {
+	if (dev->power.runtime_status == RPM_SUSPENDING ||
+	    dev->power.runtime_status == RPM_RESUMING ||
+	    dev->power.idle_notification) {
 		DEFINE_WAIT(wait);
 
 		/* Suspend, wake-up or idle notification in progress. */
@@ -1455,8 +1455,8 @@ void __pm_runtime_disable(struct device
 	 * means there probably is some I/O to process and disabling runtime PM
 	 * shouldn't prevent the device from processing the I/O.
 	 */
-	if (check_resume && dev->power.request_pending
-	    && dev->power.request == RPM_REQ_RESUME) {
+	if (check_resume && dev->power.request_pending &&
+	    dev->power.request == RPM_REQ_RESUME) {
 		/*
 		 * Prevent suspends and idle notifications from being carried
 		 * out after we have woken up the device.
@@ -1616,6 +1616,7 @@ void pm_runtime_irq_safe(struct device *
 {
 	if (dev->parent)
 		pm_runtime_get_sync(dev->parent);
+
 	spin_lock_irq(&dev->power.lock);
 	dev->power.irq_safe = 1;
 	spin_unlock_irq(&dev->power.lock);



