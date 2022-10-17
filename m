Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD62600A23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiJQJOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiJQJN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:13:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6F14D4D2;
        Mon, 17 Oct 2022 02:13:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gf8so10400047pjb.5;
        Mon, 17 Oct 2022 02:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA2UmIKVuRoeoJ0BqAsA6/5RpJhUljcvAx2HKfeYlvY=;
        b=Sr4PYEf5wQLycM2jIu7gAXfNqeWkBXd3bQDKSgDYmZdhEVQ8hffMW2O/3E9d4DDSIS
         iMX+EcW/+mPQqM1dVtavf9vl3PGl8J6qCMZvdIPlOsOChUj0dvxu0VB54pkhJ7WEPWU1
         xfnMhX/zH2bU1haCFaJUxubX6NMIOfXB9EXMWkYRuhIaqyKan8QFMFPbYnEN37ll73oV
         KWYKcv3jgtBSQCisqgHkFhwVVkx0WF4odL3BBVmRk8szRD0fqCPn96Bz7MMaZONa5l2r
         P0snWRJ/vih/+ddPui3dVR7uHK/xis17kSaE8uENx5jS8XFh3qNZQ49rIeLQXYB5lOAZ
         oVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tA2UmIKVuRoeoJ0BqAsA6/5RpJhUljcvAx2HKfeYlvY=;
        b=fKFTr9866xPjb8VdM/kBQxsjqSsmB8GIlG8Vy3kD7YwZuFLChHd2c8IDPi+cQokdTd
         evjuxhWTFCoP/CXZHJHPpSA4gfiKJlU3E975YFN9ExiwopcDUY7aYZCrn7zHf3UER+8D
         v8NKmdTlDMpQtVy9Xowr6jTAz6GQ6bw0L2KHXGXtd9oR/cliEzOY2KZUGe/Tk32yqi21
         +e825dVStsc6kUPXG/J0/VIiJJ4+Qcj4VY43UScFY1HJf/G+jehWQv3f1KCn1V0geWju
         VpWvJePcOc/Ve+HzaehD/NC7OxjpDBddsW2p06Px28KNvVA+JXjGVryyYtn0VahCB6W+
         bxvw==
X-Gm-Message-State: ACrzQf2HT4HErVoYFpOzTm+IoLsR8FTKegNcz4/y04i07Cvp+nbPJpKn
        UbpRxi6asc3ak8qioLc9SUI=
X-Google-Smtp-Source: AMsMyM4scITjSJl6pnuPeInVcc11yGeCYNFu7/c6GvrHYbBuCvKiQYOowhh3BEnD5g+VIBgpi/aeKg==
X-Received: by 2002:a17:90b:17c7:b0:20b:7cb:9397 with SMTP id me7-20020a17090b17c700b0020b07cb9397mr26969871pjb.191.1665997981401;
        Mon, 17 Oct 2022 02:13:01 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:13:00 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 17/26] mmc: sdhci-uhs2: add clock operations
Date:   Mon, 17 Oct 2022 17:11:44 +0800
Message-Id: <20221017091153.454873-18-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
References: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 145508918486..3f3665d7990c 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 
 #include "sdhci.h"
@@ -403,6 +404,37 @@ int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
+static int sdhci_uhs2_disable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	return 0;
+}
+
+static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	u32 val;
+	/* 20ms */
+	int timeout_us = 20000;
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	if (read_poll_timeout_atomic(sdhci_readw, val, (val & SDHCI_CLOCK_INT_STABLE),
+				     10, timeout_us, true, host, SDHCI_CLOCK_CONTROL)) {
+		pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return 1;
+	}
+	return 0;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -564,6 +596,10 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 
 	if (!host->mmc_host_ops.uhs2_detect_init)
 		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
+	if (!host->mmc_host_ops.uhs2_disable_clk)
+		host->mmc_host_ops.uhs2_disable_clk = sdhci_uhs2_disable_clk;
+	if (!host->mmc_host_ops.uhs2_enable_clk)
+		host->mmc_host_ops.uhs2_enable_clk = sdhci_uhs2_enable_clk;
 
 	return 0;
 }
-- 
2.25.1

