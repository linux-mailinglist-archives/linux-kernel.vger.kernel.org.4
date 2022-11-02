Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708376164FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiKBOWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiKBOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:21:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CD9201B4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:21:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 4so16751084pli.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3X2UOS5GCzAk+RwX2Y3XrY61x6yZgTDSncBoSeqZLI=;
        b=tP92GVRcbpnSB3xByd6EKkdFhI2ZZxEFq+0qM0sGK5E+2xuX6AHz+yeAWxUIRaFqur
         AU3x3apJWWF5aeMB+VrgbTciJbWFSd7zo/WZRF0pEi6LgmVXPO30AYNBoO4+G1hi/ijt
         1jncQwvWehSCooj+r+y0aIOk9l0rxvB2kRewercVL8R3IktqPtZmqyZL3QkQ6rNA8aaH
         sSWEgANy+SHsjEpUjsN1OFjRilyWolHnh19b+FyPKhNuePvhf/m2OEyd8w3gyckD3uT8
         H7rF1A9ldjjt0b0xjFv51yGzcZAdkPZb6ew+0hEWjN3+HqnrTHMTyc9s0FU4QbCmrLvD
         P17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3X2UOS5GCzAk+RwX2Y3XrY61x6yZgTDSncBoSeqZLI=;
        b=niAUDq4FTIJRdsUVBPVKKUZB930LcKrsFAE8fEoLTyR2tZ3eWKiF7qjUzUGiTR9ZsL
         d6LZTMkXn0pxMheGKxagWvv0EoYKZ/DcbYYp2nhw3adHooxeJ3rMqsT/46M4bcqm5DNZ
         1ywklv8IsrFFGHR1kLpnVor2Hp9bXEybjnhXWglPc9QBAtHh8yXoaeJ06Mv8J85Qq4wQ
         2lRTFSbh+Ia3hz/lO94NPopoaea7U+3+Nd46aNclCEzC4ci6G6V7XlQRHl3bzpUH4k/k
         0UeSCGlpKkR+gaDCnmXsH1mkCKeZpRfYthrFBCrTekkl+zJmymBVkDYxqgOov5yKhBsz
         P36g==
X-Gm-Message-State: ACrzQf29xL113LWGt3bFJ/n/8KfV14EuUtdW2WZ3OeLHPzmU0T/BEZcj
        S7ri6Y8mgj/8V6SdLSFvUOseHg==
X-Google-Smtp-Source: AMsMyM5/desmGwo//lnCNuPp/LhooK+lM+AiUwQtTK6uVMwC4hR5ggGtuEkCyD1JSMcpyjgnrGVKrg==
X-Received: by 2002:a17:903:188:b0:187:dd28:5fc1 with SMTP id z8-20020a170903018800b00187dd285fc1mr2273476plg.26.1667398909278;
        Wed, 02 Nov 2022 07:21:49 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o28-20020aa7979c000000b0056b8181861esm8817773pfp.19.2022.11.02.07.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:21:48 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 2/4] PM: domains: Pass generic PM noirq hooks to genpd_finish_suspend()
Date:   Wed,  2 Nov 2022 22:21:02 +0800
Message-Id: <20221102142104.2006554-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102142104.2006554-1-shawn.guo@linaro.org>
References: <20221102142104.2006554-1-shawn.guo@linaro.org>
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
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 97deae1d4e77..f18b8b1bc17a 100644
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

