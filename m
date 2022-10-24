Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BE260B1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiJXQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiJXQgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:36:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EC31863D0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:23:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k8so8126048wrh.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQyeI3iWyNHZjtENn8DPYNUxwogrtaagMEXW+y/NypA=;
        b=mdfvV7EMrnMzMfiq/epK8Pii9oFAzgTAvPfpGQ0cibGpOEYZ5ROakOkngZ/DzqnpR1
         i4wUoiwGayt5INMX+SKcL5W3nifaLuJTl2+tz+JGmx1oMOZViTLmWHuiohgGa2PfLXj4
         vzQOsN+6WIH1aPsO9YqLjCNHnslwyZGVDRVkL5ekZSJNGDv6l4xelj4aiSKJZWtps05G
         JmVEDx9i8IqfiFEk1/NUEAcaZDRSif419q8EoDJfDY5sio+9SvjrClJhMJlf8fPFhOZz
         B/wo1TWrWwEMiSD4ih0sDC7Vstx4wgw+Gfb5b85aDd8cwdtrI/PiPjBRDgsCywKo0yHD
         Peyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQyeI3iWyNHZjtENn8DPYNUxwogrtaagMEXW+y/NypA=;
        b=EYQ4gLWFBsKOAzFsDFyQuvLoxRfukkByDf0bRrS+/sa6n72+LhA727UNmSOyBdLY5n
         lX0wVzwJMBbWwCMYgUxjoeF2aA3U9TayojzFtDJlyHS5+JXCOyy/u3HajhBAaMb5Hg/q
         HNGUg+e8UxDKE5zCZvoo0K5qviNLSpkKC3YEvgZJHjerxl7oS91PTOhTYly1zXgLcO3a
         JD/PQoNtgqTPoLJy1z+mVegqiBxlhR8DfgRgdVNP5m5sq8HVpQFzcAQ9DHUlqavbLY4j
         qF+b/v6Oz0eEzs96jNcEzJh+SL2mubSGb0ZotER0wml2qz6hczb5HHKE8KnMTLiu2d4e
         L2yA==
X-Gm-Message-State: ACrzQf0nIlJLcYGfD61eyWROvDBUZFbMUVTtx4OfA/paFE6v4MZYLMs/
        bhz++V1Aq4Ci2MbHUtqDzZRuUnMTZob9qg==
X-Google-Smtp-Source: AMsMyM4cYodD69HYnsNl9PmV/C27D0XivwktN7mQHyiN/OCBLBuzGLBnqTOplabDhZvWBrHfB/4HzA==
X-Received: by 2002:a5d:6f12:0:b0:236:6b05:7a78 with SMTP id ay18-20020a5d6f12000000b002366b057a78mr5565708wrb.374.1666622648215;
        Mon, 24 Oct 2022 07:44:08 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c00c800b003b4935f04a4sm163258wmm.5.2022.10.24.07.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 07:44:07 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] PM: domains: Reverse the order of performance and enabling ops
Date:   Mon, 24 Oct 2022 17:43:04 +0300
Message-Id: <20221024144304.198689-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ->set_performance_state() needs to be called before ->power_on()
when a genpd is powered on, and after ->power_off() when a genpd is
powered off. Do this in order to let the provider know to which
performance state to power on the genpd, on the power on sequence, and
also to maintain the performance for that genpd until after powering off,
on power off sequence.

There is no scenario where a consumer would need its genpd enabled and
then its performance state increased. Instead, in every scenario, the
consumer needs the genpd to be enabled from the start at a specific
performance state.

And same logic applies to the powering down. No consumer would need its
genpd performance state dropped right before powering down.

Now, there are currently two vendors which use ->set_performance_state()
in their genpd providers. One of them is Tegra, but the only genpd provider
(PMC) that makes use of ->set_performance_state() doesn't implement the
->power_on() or ->power_off(), and so it will not be affected by the ops
reversal.

The other vendor that uses it is Qualcomm, in multiple genpd providers
actually (RPM, RPMh and CPR). But all Qualcomm genpd providers that make
use of ->set_performance_state() need the order between enabling ops and
the performance setting op to be reversed. And the reason for that is that
it currently translates into two different voltages in order to power on
a genpd to a specific performance state. Basically, ->power_on() switches
to the minimum (enabling) voltage for that genpd, and then
->set_performance_state() sets it to the voltage level required by the
consumer.

By reversing the call order, we rely on the provider to know what to do
on each call, but most popular usecase is to cache the performance state
and postpone the voltage setting until the ->power_on() gets called.

As for the reason of still needing the ->power_on() and ->power_off() for a
provider which could get away with just having ->set_performance_state()
implemented, there are consumers that do not (nor should) provide an
opp-table. For those consumers, ->set_performance_state() will not be
called, and so they will enable the genpd to its minimum performance state
by a ->power_on() call. Same logic goes for the disabling.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/base/power/domain.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ead135c7044c..e66a711fec88 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -939,8 +939,8 @@ static int genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	genpd_lock(genpd);
-	gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 	genpd_power_off(genpd, true, 0);
+	gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 	genpd_unlock(genpd);
 
 	return 0;
@@ -978,9 +978,8 @@ static int genpd_runtime_resume(struct device *dev)
 		goto out;
 
 	genpd_lock(genpd);
+	genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
 	ret = genpd_power_on(genpd, 0);
-	if (!ret)
-		genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
 	genpd_unlock(genpd);
 
 	if (ret)
@@ -1018,8 +1017,8 @@ static int genpd_runtime_resume(struct device *dev)
 err_poweroff:
 	if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
 		genpd_lock(genpd);
-		gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 		genpd_power_off(genpd, true, 0);
+		gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 		genpd_unlock(genpd);
 	}
 
@@ -2749,17 +2748,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 
-	if (power_on) {
-		genpd_lock(pd);
-		ret = genpd_power_on(pd, 0);
-		genpd_unlock(pd);
-	}
-
-	if (ret) {
-		genpd_remove_device(pd, dev);
-		return -EPROBE_DEFER;
-	}
-
 	/* Set the default performance state */
 	pstate = of_get_required_opp_performance_state(dev->of_node, index);
 	if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
@@ -2771,6 +2759,18 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 			goto err;
 		dev_gpd_data(dev)->default_pstate = pstate;
 	}
+
+	if (power_on) {
+		genpd_lock(pd);
+		ret = genpd_power_on(pd, 0);
+		genpd_unlock(pd);
+	}
+
+	if (ret) {
+		genpd_remove_device(pd, dev);
+		return -EPROBE_DEFER;
+	}
+
 	return 1;
 
 err:
-- 
2.34.1

