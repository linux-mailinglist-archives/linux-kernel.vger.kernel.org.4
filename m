Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DF97005F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbjELKri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbjELKra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:47:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C721329F;
        Fri, 12 May 2023 03:47:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so4682752b3a.0;
        Fri, 12 May 2023 03:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683888432; x=1686480432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTEC64ER82u3IhlaeRlkyP6syxElg6OBv01XXMZkg48=;
        b=fhXJHf+wTETW1VS5IEXYkCxPs6Lsaqdt8THu8UT1xhP1eXkt0Mu6Z2i7D8a42Gj5sq
         ozUsWtcX+sQI0wwOHWudOPta0lMABsYzQ+vsg82L5oRHhlL+7Bi+hwCIFEeSR/Wp5OXA
         CmKHGDDABmJiqMDz9bvF9NLg/cC4IQ4vH+xscBRQ0IJyvRZ/hK6kKUm7Ewj4gkOLdUO1
         hVTDwtCivMLvMQxi8dxynwqLWz57kfmwDA6M5ZTA3Me6TzGom/2QyhbAW9Wcr3xDigCJ
         m6bjrZt6bIEyAObzoX6eWHitG9YEcPw1XrHCr9LyUHvU63JUX4pD+8QsokDPhzdOBolo
         fX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683888432; x=1686480432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTEC64ER82u3IhlaeRlkyP6syxElg6OBv01XXMZkg48=;
        b=T/5zE6twmrEPdOeshi//tfK/svUNobyci6edRExUnykUZka7THJcGbcp/Zm6WCdVAT
         zx9DjfcELMmU8cRIT0hqUU32c9O6FNIi4sbFG3cBnaDOync8sIz+wPg52psNjXLRoFN0
         CsUzx1idlmYtupfams/bGZGMgdvpUDq3V9yYqCTjc2G8z6cg4soNAhb+vLWGNW0Cakih
         GQneScE4IyHKRNTKytptSy18hCpkfmbMIlJ5ZyLmZsHUjBualvVRtyjFDkTStyS4K60r
         XF/PVHu6A08DHS6qeLe2J2zi3u2P2SiujcbaG3q1WviYJZXwbe5JtNkBoKOovPsQV5v1
         Qt2g==
X-Gm-Message-State: AC+VfDz/U3FySwCM8Sdy97KV3GwW0Hf1C/0hKWnSzb22TOroQpwju5VF
        siDL5tU+ANfYCmg580J0sBQ=
X-Google-Smtp-Source: ACHHUZ5tx01jWVbtag8MPSN2xKcreGwRVabACsT0fbdnGoVSlTxfaeeWJ5QEjt7jQlhVQbvMqmWETA==
X-Received: by 2002:a05:6a20:8e05:b0:101:281c:494 with SMTP id y5-20020a056a208e0500b00101281c0494mr14977740pzj.27.1683888431804;
        Fri, 12 May 2023 03:47:11 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2ae-0f1d-f6c2-46f4-c62f-3944.emome-ip6.hinet.net. [2001:b400:e2ae:f1d:f6c2:46f4:c62f:3944])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78751000000b0064358d032a4sm7019268pfo.145.2023.05.12.03.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:47:11 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V1 2/3] mmc: sdhci: Export sdhci_check_ro function symbol
Date:   Fri, 12 May 2023 18:45:58 +0800
Message-Id: <20230512104559.11218-3-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512104559.11218-1-victor.shih@genesyslogic.com.tw>
References: <20230512104559.11218-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export sdhci_check_ro() function symbols which are used by other
SD Host controller drivers modules.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3241916141d7..0c9b2006e24a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2513,7 +2513,7 @@ int sdhci_get_cd_nogpio(struct mmc_host *mmc)
 }
 EXPORT_SYMBOL_GPL(sdhci_get_cd_nogpio);
 
-static int sdhci_check_ro(struct sdhci_host *host)
+int sdhci_check_ro(struct sdhci_host *host)
 {
 	unsigned long flags;
 	int is_readonly;
@@ -2536,6 +2536,7 @@ static int sdhci_check_ro(struct sdhci_host *host)
 	return host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT ?
 		!is_readonly : is_readonly;
 }
+EXPORT_SYMBOL_GPL(sdhci_check_ro);
 
 #define SAMPLE_COUNT	5
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f4f2085c274c..54e9e13108e3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -780,6 +780,7 @@ void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 int sdhci_get_cd_nogpio(struct mmc_host *mmc);
+int sdhci_check_ro(struct sdhci_host *host);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
 int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
-- 
2.25.1

