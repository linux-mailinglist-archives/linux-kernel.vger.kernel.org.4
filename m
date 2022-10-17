Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0554D600A10
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiJQJN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiJQJM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:12:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ED8437E4;
        Mon, 17 Oct 2022 02:12:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h2so2850199plb.2;
        Mon, 17 Oct 2022 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pndTdcmBYUOsi9vNLnQJgPVCRSImYXTUpjmesPh3caE=;
        b=LAXvw8QGYk11KMqBW7bNTaSM/zDE+VPJ6iDcnIizkW9yp4ucFxVKGPd+GoRIE2Ya+4
         YyspgneS3DTh+k8gC6IAEDo8W9g+1Mveb6h/FurqE/j4sP5lBju36AaodTaS+mW6ODEe
         B9UhvJXYw7VczXn3t/iBDcNzoOorQFLev9SGSscmDb2VaxWjlSi2gZ4+dbVl3WmkEpVc
         KUVXacPFor4BkiV1L3JN6AsiXFCz8dPmfllaW632mLEhMjxJoQLB90V6TyvN596te4OY
         mfUFitcmXMsg8TDFAlrkAYexONm63gcu1ssTt4WILvmYZHbV9/A3St8MeqXSKePcwalP
         iIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pndTdcmBYUOsi9vNLnQJgPVCRSImYXTUpjmesPh3caE=;
        b=phuIhUCg8C6xM/WcXnXd4BYU2OF7m10HiRu2LdQmdMxISqhL5m1BPCzBar0jTj+ZiF
         lRyE1yNpOeEhG1rWVd8e/e/dTFBjnbiucASkg2BaSL0GtFqOwj0ohPFUDPSRgmwRtZ7v
         xuvqWrvthXPggiWIZP6lXuJeHE2ztJ8I8cEpCsRyx40pJ009d6EfE3mN+n7mpzrUB4Zu
         Y95ax1IO0P8/7lHDpTWcxX7BSaDPIt7pT8t3Ba1uaffvbx1cIMnLHwHLscwK52gDqpG1
         xi4X61NHWcKCJhzH1uNudh2YwkE/FDDPejXBaU583e9vjdKdTH4fYLMyNzuqUeyPO1t6
         szQg==
X-Gm-Message-State: ACrzQf3JTPhfFoQNF+KYUHcvxhOqp0HWzPdgEIl9xPenuj7RW8s3y47Z
        mHyRDZwbiC/FkgwwgcD1fDc=
X-Google-Smtp-Source: AMsMyM6GMZdOV0Tja0Wwdqe6vUiPy+sZ4Rcku5AFiuFgTiRF5isWo7M6muWTjtgte98ceTLR+JkroA==
X-Received: by 2002:a17:902:b206:b0:184:6344:7aab with SMTP id t6-20020a170902b20600b0018463447aabmr11243936plr.103.1665997952001;
        Mon, 17 Oct 2022 02:12:32 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:12:31 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 07/26] mmc: sdhci: add a kernel configuration for enabling UHS-II support
Date:   Mon, 17 Oct 2022 17:11:34 +0800
Message-Id: <20221017091153.454873-8-victor.shih@genesyslogic.com.tw>
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

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
in the following commits to indicate UHS-II specific code in sdhci
controllers.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e63608834411..d89e7bf91c35 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -89,6 +89,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 
 	  This is the case for the Nintendo Wii SDHCI.
 
+config MMC_SDHCI_UHS2
+	tristate "UHS2 support on SDHCI controller"
+	depends on MMC_SDHCI
+	help
+	  This option is selected by SDHCI controller drivers that want to
+	  support UHS2-capable devices.
+
+	  If you have a controller with this feature, say Y or M here.
+
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
-- 
2.25.1

