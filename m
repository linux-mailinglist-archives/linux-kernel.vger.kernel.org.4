Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E465F604483
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiJSMG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiJSMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:06:05 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F9DEE0B;
        Wed, 19 Oct 2022 04:42:38 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id p7so17423834vsr.7;
        Wed, 19 Oct 2022 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZHDao71BmXPVP6iHC4jGOGOK3iMkbkqoQmN3nHH8uw=;
        b=T8Rd/lfMPxUyJzY/mJcjTo0O+HwHxVXFSYxz4YHOqXPe4ngtFIVYvOiw96ap2VVk8b
         U6SHJNzww6oJ0NF5Ewxau4OXOatRvDIoJfIZsOmai4YIMnmpUKh/E6J8e2WgRP7p8exu
         VFO0NSsXBN8XVlXllpTqI6C3gJHmxyaO4fhPJYTQZGBEm0Jne6Qx5knIshKQB7IBj74i
         EJrYQGDnDuEITpuPXmeGvpMzwdSnVVxnQpGWdiD0tqTXgQi5BlwrETASfZhtIUwEHdyq
         m60Ue96mMPn8mDPOcPzCdiwrX7qx1AGdR1gCTU8GasWeIJu7e3JGpScxSxIL/ZlmrQBI
         Yo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZHDao71BmXPVP6iHC4jGOGOK3iMkbkqoQmN3nHH8uw=;
        b=M59N9dNZIEXJd59vFfuUp9EzAvOO40nHjN3Dl6jWRxDDBUvzWIOLVf60geWkBlJbGi
         RowhEnWBRImKp3lPkuyHi1Jm0FkZpsx1xrS9jPf5iFX/qQ5qGyLJMYRL0/ssNpISzjOe
         Br0CJup4fdouXTq5aHZRnVX7wDH6Baat+1Lz2EboE9l0/isxIOttFCtegWuM2+abiBi7
         jAqAGRl1rFX9RvKUo3oFpxWuA8/JljyXllOBBY0kh0b/HmcTBsHJmElMCbOL8Sq/xy6b
         lOyZEv9edNim9H6ONJDm6gtFs5Rm34oKT6pLGEonDRxEtluEsh/dR4XavgRFCkBvOdnX
         8+NQ==
X-Gm-Message-State: ACrzQf2z8W7bGAQdGZ6+r+zUAoNgCaB8Xa33YHvE2m6E8wXc0Vwij9bD
        i8zZJRsoMJg2Cq9vJtUVJH8sc9o+B8g=
X-Google-Smtp-Source: AMsMyM57MU9zVE+zShSzav/5xv+WMzFxSyUJV0YnzfrLBj5UA0XOwQKe4dIADmMol0JXR7z+NdZyUg==
X-Received: by 2002:a17:903:1205:b0:178:ac4e:70b8 with SMTP id l5-20020a170903120500b00178ac4e70b8mr7678286plh.52.1666177663663;
        Wed, 19 Oct 2022 04:07:43 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:07:43 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 15/26] mmc: sdhci-uhs2: add set_ios()
Date:   Wed, 19 Oct 2022 19:06:36 +0800
Message-Id: <20221019110647.11076-16-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
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

This is a sdhci version of mmc's set_ios operation.
It covers both UHS-I and UHS-II.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 102 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   1 +
 drivers/mmc/host/sdhci.c      |  40 ++++++++-----
 drivers/mmc/host/sdhci.h      |   2 +
 4 files changed, 130 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 2b90e5308764..b535a47dc55a 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -281,6 +281,74 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
 
+/**
+ * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable register
+ * @host:	SDHCI host
+ * @clear:	bit-wise clear mask
+ * @set:	bit-wise set mask
+ *
+ * Set/unset bits in UHS-II Error Interrupt Status Enable register
+ */
+void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
+{
+	u32 ier;
+
+	ier = sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN);
+	ier &= ~clear;
+	ier |= set;
+	sdhci_writel(host, ier, SDHCI_UHS2_ERR_INT_STATUS_EN);
+	sdhci_writel(host, ier, SDHCI_UHS2_ERR_INT_SIG_EN);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
+
+static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u8 cmd_res, dead_lock;
+	u16 ctrl_2;
+	unsigned long flags;
+
+	/* FIXME: why lock? */
+	spin_lock_irqsave(&host->lock, flags);
+
+	/* UHS2 Timeout Control */
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+
+	/* change to use calculate value */
+	cmd_res |= dead_lock << SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT;
+
+	sdhci_uhs2_clear_set_irqs(host,
+				  SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |
+				  SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT,
+				  0);
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+	sdhci_uhs2_clear_set_irqs(host, 0,
+				  SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |
+				  SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT);
+
+	/* UHS2 timing */
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if (ios->timing == MMC_TIMING_SD_UHS2)
+		ctrl_2 |= SDHCI_CTRL_UHS_2 | SDHCI_CTRL_UHS2_INTERFACE_EN;
+	else
+		ctrl_2 &= ~(SDHCI_CTRL_UHS_2 | SDHCI_CTRL_UHS2_INTERFACE_EN);
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
+		sdhci_enable_preset_value(host, true);
+
+	if (host->ops->set_power)
+		host->ops->set_power(host, ios->power_mode, ios->vdd);
+	else
+		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
+	udelay(100);
+
+	host->timing = ios->timing;
+	sdhci_set_clock(host, host->clock);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * MMC callbacks                                                             *
@@ -302,6 +370,39 @@ static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
 	return sdhci_start_signal_voltage_switch(mmc, ios);
 }
 
+int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (!(host->version >= SDHCI_SPEC_400) ||
+	    !(host->mmc->flags & MMC_UHS2_SUPPORT &&
+	      host->mmc->caps2 & MMC_CAP2_SD_UHS2)) {
+		sdhci_set_ios(mmc, ios);
+		return 0;
+	}
+
+	if (ios->power_mode == MMC_POWER_UNDEFINED)
+		return 1;
+
+	if (host->flags & SDHCI_DEVICE_DEAD) {
+		if (!IS_ERR(mmc->supply.vmmc) &&
+		    ios->power_mode == MMC_POWER_OFF)
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		if (!IS_ERR_OR_NULL(mmc->supply.vmmc2) &&
+		    ios->power_mode == MMC_POWER_OFF)
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
+		return 1;
+	}
+
+	/* FIXME: host->timing = ios->timing */
+
+	sdhci_set_ios_common(mmc, ios);
+
+	__sdhci_uhs2_set_ios(mmc, ios);
+
+	return 0;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -312,6 +413,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
 	host->mmc_host_ops.start_signal_voltage_switch =
 		sdhci_uhs2_start_signal_voltage_switch;
+	host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
 
 	return 0;
 }
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 5ea235b14108..23368448ccd4 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -216,5 +216,6 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 			  unsigned short vdd);
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
+void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index dfa0939a9058..de47c71995fb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -47,8 +47,6 @@
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
-
 static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
 
 void sdhci_dumpregs(struct sdhci_host *host)
@@ -1888,6 +1886,9 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	case MMC_TIMING_MMC_HS400:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
 		break;
+	case MMC_TIMING_SD_UHS2:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
+		break;
 	default:
 		pr_warn("%s: Invalid UHS-I mode selected\n",
 			mmc_hostname(host->mmc));
@@ -2305,20 +2306,9 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 }
 EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
 
-void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	u8 ctrl;
-
-	if (ios->power_mode == MMC_POWER_UNDEFINED)
-		return;
-
-	if (host->flags & SDHCI_DEVICE_DEAD) {
-		if (!IS_ERR(mmc->supply.vmmc) &&
-		    ios->power_mode == MMC_POWER_OFF)
-			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
-		return;
-	}
 
 	/*
 	 * Reset the chip on each power off.
@@ -2355,6 +2345,25 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->ops->set_power(host, ios->power_mode, ios->vdd);
 	else
 		sdhci_set_power(host, ios->power_mode, ios->vdd);
+}
+EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
+
+void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u8 ctrl;
+
+	if (ios->power_mode == MMC_POWER_UNDEFINED)
+		return;
+
+	if (host->flags & SDHCI_DEVICE_DEAD) {
+		if (!IS_ERR(mmc->supply.vmmc) &&
+		    ios->power_mode == MMC_POWER_OFF)
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		return;
+	}
+
+	sdhci_set_ios_common(mmc, ios);
 
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
@@ -2935,7 +2944,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 }
 EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 {
 	/* Host Controller v3.00 defines preset value registers */
 	if (host->version < SDHCI_SPEC_300)
@@ -2963,6 +2972,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 		host->preset_enabled = enable;
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
 
 static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 				int err)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c34ca6ffbff6..22d7f47862ae 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -871,6 +871,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
+void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
-- 
2.25.1

