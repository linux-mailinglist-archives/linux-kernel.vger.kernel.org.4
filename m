Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B685FFE8A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 11:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJPJ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 05:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJPJ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 05:58:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BCF32D92
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 02:58:37 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q1so8079396pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 02:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIHYWY56QD8kdVR8UkvvdHp3cIEPSeTOMo7K4e0+8vI=;
        b=ZxddD8Za0wZsUUJ6Nk5mbI13E2BDhHfxNKYxve4XGPZY25S3f5dartelW6ig1AJ0TE
         urk9Jfrnxh9RzIRoYYOZ9fA6PU+cBmvY4TBahjbDqVUs9hCjgnEyQuVHAvD4dRN7zqVl
         khbXWIUjHw2GsM8BuJw1b0yQd4dsWKKVTjPhdZ6SGP9wVHwdwjiFAm9UQoff/CU0ma9D
         adwcI+adygygmXnksMbFYHxWu9jtYVhJJ9INfrsK8lWYTu3rLP17Hqzpv9WXQnsL3rZ5
         zfrhFKvaUExS+xQk8tdSPECGcIm+cRqDKTSa4bVdQcEMHZk6B5Mv04Z84z0FGILHixFf
         nB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIHYWY56QD8kdVR8UkvvdHp3cIEPSeTOMo7K4e0+8vI=;
        b=pc1KP9pUxVuFaArykismAIIwuv8z8zLCDfO9ZwtY2LMB9wqxuyIHups6WtxFu/Ah+V
         j0YDgqXczCW2pYknlUha3vSik5+S+UEN+XKLWyJZXM9YPT+bU4SbqKe5fil+vMEnESzO
         3Q8hNPNoCRAlY1Z/HW6b9/+ecSWmFxVGtzhv7EzBnsK+npwtAaRDMJAAtyfnhbcdnM9Q
         in2ITUhS0DW6XR/bTjB3RsXYBCg6YUqXKJzkgMHJtnJweiqyqgo602jLF3BBL3P5TPnd
         DyNSm5PGglN5i+eo2QuhtYOoO+ikAP4KnlJ+GMZ7DRx+rNLrd7DaZet1hOYw9VFDwjG3
         s1xQ==
X-Gm-Message-State: ACrzQf26rbfau4OkTFEfiGKSIqVkWEw3XfVxTVkU9W7ly8koTFaXb23C
        td6a2WZmxMf2ngYJTGix64OT4g==
X-Google-Smtp-Source: AMsMyM5PWhYCkM8N97Vm12Rtc/car+lxsxKzJ+85li/IR9jXxtbolLnQOKcPSUoj/WalqghFKHR9Hw==
X-Received: by 2002:a05:6a00:1341:b0:566:5e54:8110 with SMTP id k1-20020a056a00134100b005665e548110mr6842504pfu.6.1665914316527;
        Sun, 16 Oct 2022 02:58:36 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b001745662d568sm4481838plg.278.2022.10.16.02.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 02:58:35 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/3] PM: domains: Pass generic PM noirq hooks to genpd_finish_suspend()
Date:   Sun, 16 Oct 2022 17:58:13 +0800
Message-Id: <20221016095815.2550034-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221016095815.2550034-1-shawn.guo@linaro.org>
References: <20221016095815.2550034-1-shawn.guo@linaro.org>
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

While argument `poweroff` works fine for genpd_finish_suspend() to handle
distinction between suspend and poweroff, it won't scale if we want to
use it for freeze as well.  Pass generic PM noirq hooks as arguments
instead, so that the function can possibly cover freeze case too.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/base/power/domain.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 55a10e6d4e2a..01f5644938e0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1189,12 +1189,15 @@ static int genpd_prepare(struct device *dev)
  * genpd_finish_suspend - Completion of suspend or hibernation of device in an
  *   I/O pm domain.
  * @dev: Device to suspend.
- * @poweroff: Specifies if this is a poweroff_noirq or suspend_noirq callback.
+ * @suspend_noirq: Generic suspend_noirq callback.
+ * @resume_noirq: Generic resume_noirq callback.
  *
  * Stop the device and remove power from the domain if all devices in it have
  * been stopped.
  */
-static int genpd_finish_suspend(struct device *dev, bool poweroff)
+static int genpd_finish_suspend(struct device *dev,
+				int (*suspend_noirq)(struct device *dev),
+				int (*resume_noirq)(struct device *dev))
 {
 	struct generic_pm_domain *genpd;
 	int ret = 0;
@@ -1203,10 +1206,7 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (poweroff)
-		ret = pm_generic_poweroff_noirq(dev);
-	else
-		ret = pm_generic_suspend_noirq(dev);
+	ret = suspend_noirq(dev);
 	if (ret)
 		return ret;
 
@@ -1217,10 +1217,7 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 	    !pm_runtime_status_suspended(dev)) {
 		ret = genpd_stop_dev(genpd, dev);
 		if (ret) {
-			if (poweroff)
-				pm_generic_restore_noirq(dev);
-			else
-				pm_generic_resume_noirq(dev);
+			resume_noirq(dev);
 			return ret;
 		}
 	}
@@ -1244,7 +1241,9 @@ static int genpd_suspend_noirq(struct device *dev)
 {
 	dev_dbg(dev, "%s()\n", __func__);
 
-	return genpd_finish_suspend(dev, false);
+	return genpd_finish_suspend(dev,
+				    pm_generic_suspend_noirq,
+				    pm_generic_resume_noirq);
 }
 
 /**
@@ -1353,7 +1352,9 @@ static int genpd_poweroff_noirq(struct device *dev)
 {
 	dev_dbg(dev, "%s()\n", __func__);
 
-	return genpd_finish_suspend(dev, true);
+	return genpd_finish_suspend(dev,
+				    pm_generic_poweroff_noirq,
+				    pm_generic_restore_noirq);
 }
 
 /**
-- 
2.25.1

