Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F61614363
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiKACsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiKACr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:47:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ACC17A8F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:47:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o7so8801519pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbrdZ3AfNBZwnOI0fG3SRJzo0Qc3Dqvr8k7roe04PJI=;
        b=HWqorN7Mn3JENdNCLQsXnKQ+LlgwfD3rhZ8l+NteXzFRkW08IFKMUxsFk45ZA5CXQN
         WpKxiy1ayugBAnoB7oC0WN9m4v3O9mkQ5V+ooBuIsjXhq9l0uJvnJNs3IKkbh2wbAC7Z
         GjcFGu7tJqVjoOTotKBJErQ4sKFIMu4jt52yxLL73oTfb8pumbi2Uh2cj0VE6EO8gpqC
         KhD7vu4KOVapF/OEyiiSdwSk02kD7Lmk9aHis/3wVND+YF2K77DFdaVjzyeMTUIOqg7T
         E53odfale8+xgW9HpsKwHwzcwsKqruUwYKIFZ88wov0TR7JaE1B1q8YTa6D4IXxStOO3
         QqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbrdZ3AfNBZwnOI0fG3SRJzo0Qc3Dqvr8k7roe04PJI=;
        b=LBBo77swdfCh/SbMAMPbtR18BExYEkaE6f0Nmw+kxGh0T0IqVGNvTPffHSU8mlmwt2
         W6CKEKFoyGFbCGKDvQbQgFRzrSCVR4RCS+fblZA+teziQfWPKh2hwd0XDSx3DTmI0sm6
         d24jZ5PuZzyJCCEpniI+1PCZgXCjAUQ35QR5d/1tHQA7au0XMLw1bfQA9TIM/WN6gi3q
         beKPzezQr5lU9R171ovh+816BGiJfYwGsNEEfMZQH4uX+loGAxpSviryl1xJlrztrpqz
         W6Q/uYe7LTRXFPvqmbja/Gn1mCndbipJEETr3ymz0wG6aMz9hhvCTeUdAmE3RM2jedta
         shNQ==
X-Gm-Message-State: ACrzQf39uxtO+IMhPTe0IrzvZPPS8PuoKD5OxqqAgEEF9+M6RGgcptC6
        WSCTK29LvjZE5pWpmM1+PviSbQ==
X-Google-Smtp-Source: AMsMyM578K2t931v1WIdEmHhbcDfsuvlv5gnCIcnBAz1zAhZVD9B5u759hMN4oDrMIEob3N7Bpfa3Q==
X-Received: by 2002:a17:902:8c8f:b0:186:b6ad:3592 with SMTP id t15-20020a1709028c8f00b00186b6ad3592mr17430451plo.119.1667270874862;
        Mon, 31 Oct 2022 19:47:54 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001714c36a6e7sm5079570plb.284.2022.10.31.19.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 19:47:54 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 2/3] PM: domains: Consolidate genpd_restore_noirq() and genpd_resume_noirq()
Date:   Tue,  1 Nov 2022 10:47:35 +0800
Message-Id: <20221101024736.1509207-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101024736.1509207-1-shawn.guo@linaro.org>
References: <20221101024736.1509207-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the logic between genpd_restore_noirq() and genpd_resume_noirq()
are same except GENPD_STATE_OFF status reset for hibernation restore.
The suspended_count decrement for restore should be the right thing to do
anyway, considering there is an increment in genpd_finish_suspend() for
hibernation.

Consolidate genpd_restore_noirq() and genpd_resume_noirq() into
genpd_finish_resume() and handle GENPD_STATE_OFF status reset for
restore case specially.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/base/power/domain.c | 70 ++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 54f6b0dd35fb..b81baeb38d81 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1247,12 +1247,14 @@ static int genpd_suspend_noirq(struct device *dev)
 }
 
 /**
- * genpd_resume_noirq - Start of resume of device in an I/O PM domain.
+ * genpd_finish_resume - Completion of resume of device in an I/O PM domain.
  * @dev: Device to resume.
+ * @resume_noirq: Generic resume_noirq callback.
  *
  * Restore power to the device's PM domain, if necessary, and start the device.
  */
-static int genpd_resume_noirq(struct device *dev)
+static int genpd_finish_resume(struct device *dev,
+			       int (*resume_noirq)(struct device *dev))
 {
 	struct generic_pm_domain *genpd;
 	int ret;
@@ -1264,9 +1266,25 @@ static int genpd_resume_noirq(struct device *dev)
 		return -EINVAL;
 
 	if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
-		return pm_generic_resume_noirq(dev);
+		return resume_noirq(dev);
 
 	genpd_lock(genpd);
+
+	/*
+	 * Special handling for hibernation restore:
+	 * At this point suspended_count == 0 means we are being run for the
+	 * first time for the given domain in the present cycle.
+	 */
+	if (resume_noirq == pm_generic_restore_noirq &&
+	    genpd->suspended_count++ == 0) {
+		/*
+		 * The boot kernel might put the domain into arbitrary state,
+		 * so make it appear as powered off to genpd_sync_power_on(),
+		 * so that it tries to power it on in case it was really off.
+		 */
+		genpd->status = GENPD_STATE_OFF;
+	}
+
 	genpd_sync_power_on(genpd, true, 0);
 	genpd->suspended_count--;
 	genpd_unlock(genpd);
@@ -1281,6 +1299,19 @@ static int genpd_resume_noirq(struct device *dev)
 	return pm_generic_resume_noirq(dev);
 }
 
+/**
+ * genpd_resume_noirq - Start of resume of device in an I/O PM domain.
+ * @dev: Device to resume.
+ *
+ * Restore power to the device's PM domain, if necessary, and start the device.
+ */
+static int genpd_resume_noirq(struct device *dev)
+{
+	dev_dbg(dev, "%s()\n", __func__);
+
+	return genpd_finish_resume(dev, pm_generic_resume_noirq);
+}
+
 /**
  * genpd_freeze_noirq - Completion of freezing a device in an I/O PM domain.
  * @dev: Device to freeze.
@@ -1366,40 +1397,9 @@ static int genpd_poweroff_noirq(struct device *dev)
  */
 static int genpd_restore_noirq(struct device *dev)
 {
-	struct generic_pm_domain *genpd;
-	int ret = 0;
-
 	dev_dbg(dev, "%s()\n", __func__);
 
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	/*
-	 * At this point suspended_count == 0 means we are being run for the
-	 * first time for the given domain in the present cycle.
-	 */
-	genpd_lock(genpd);
-	if (genpd->suspended_count++ == 0) {
-		/*
-		 * The boot kernel might put the domain into arbitrary state,
-		 * so make it appear as powered off to genpd_sync_power_on(),
-		 * so that it tries to power it on in case it was really off.
-		 */
-		genpd->status = GENPD_STATE_OFF;
-	}
-
-	genpd_sync_power_on(genpd, true, 0);
-	genpd_unlock(genpd);
-
-	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
-	    !pm_runtime_status_suspended(dev)) {
-		ret = genpd_start_dev(genpd, dev);
-		if (ret)
-			return ret;
-	}
-
-	return pm_generic_restore_noirq(dev);
+	return genpd_finish_resume(dev, pm_generic_restore_noirq);
 }
 
 /**
-- 
2.25.1

