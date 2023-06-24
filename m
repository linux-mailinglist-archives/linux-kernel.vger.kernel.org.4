Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9C73C70E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjFXGFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjFXGFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:05:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B6B30E6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98de322d11fso10898566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687586687; x=1690178687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JL2xUdrdhCmATetXsGKZFgi47jUsLBSoXQ95GNpVaGk=;
        b=jUnpVHYWYziKREX/8pUNaOPhrJbKE/3FgNWxsqvU80aAmKeZ5Iy3PdjTQsAD/AIPKV
         rUXSdVBDPYiuiphlnpzV0XKH8GqoxYzazLJ0HD1bwNxad1xGT99IpJzHVQvVQAnSjYhU
         glDY3VkkpKMftngSQyc70Il7EYepl7AwL0Hf5A77CFLUXyYkk45kHz63clZjM7e4kPZh
         St8/61LvxeM4bXV2rKvGXOeXw/Qo2oRSWotw+nALaV+OS1yr0QYQWAjoW6QF+fH707dG
         l/RVbDpw/DNYAkCq6JV0iiT/ymShnZKVakEfM1VBfa080SrO6VWI9Oov/EZfW4o99CNW
         vU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586687; x=1690178687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JL2xUdrdhCmATetXsGKZFgi47jUsLBSoXQ95GNpVaGk=;
        b=B/NG7ZbggNKpwq0Hy8B++zkN0yQ6Netw3Uenb0tdQAJz0lUVWVtHgnPm3mnaL3ntj7
         aZT14xGhJppmztKjj/ptXbL52stwYc7U6RAzUM0WV628YNVP34noC1MPWb/b+7/IivCe
         1ux4DY6ShW1X7/sCrdAvbhMj4m7hzeAZ/83muGKXFSUYBCukLGSq8pHGQLZtFVHl+5vZ
         Zbf1MlOqTSlUuuHY03Vm3+OUZSg8HLAfybPi6nBeMD4EB59F7XB7DntH5666jWLLTuEJ
         ymrtr5tI0BU2Y9gcf8O48iazukIuk2DBQ44z301Nx7YMuX87yVoKh0K4pNNCz+hoBjJZ
         UAXg==
X-Gm-Message-State: AC+VfDzZfTydANNxvoN3NZJQG1+NgcOH7j9wGiMNJl3Tm8MZBAuvR/5E
        g8RjXGiAxHmW6E+S+6lNEe4=
X-Google-Smtp-Source: ACHHUZ7Hy5IZ4Cn5agaSCY+j7xto3ytCgNnb98Wyez5BlPOzoT/MgNwM717Qks4R1+wYQzWf5Lk3JA==
X-Received: by 2002:a17:906:5198:b0:987:6960:36c8 with SMTP id y24-20020a170906519800b00987696036c8mr15752481ejk.7.1687586687048;
        Fri, 23 Jun 2023 23:04:47 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id xa10-20020a170907b9ca00b00988955f7b5esm501331ejc.157.2023.06.23.23.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:04:46 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:04:44 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] staging: rtl8192e: Remove variable priv->reg_chnl_plan
Message-ID: <0dd4f8eded4b172d75f0cb5d5a34ba3dc66e2e8f.1687583718.git.philipp.g.hortmann@gmail.com>
References: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable priv->reg_chnl_plan as it is only once initialized and
only once evaluated. So the result is always the same. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 5 +----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e5925899402c..5ac6af7e3a79 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -419,10 +419,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 	rtl92e_init_adaptive_rate(dev);
 
-	if (priv->reg_chnl_plan == 0xf)
-		priv->chnl_plan = priv->eeprom_chnl_plan;
-	else
-		priv->chnl_plan = priv->reg_chnl_plan;
+	priv->chnl_plan = priv->eeprom_chnl_plan;
 
 	switch (priv->eeprom_customer_id) {
 	case EEPROM_CID_NetCore:
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 23f9b729940b..a24527585166 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -763,7 +763,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rxringcount = MAX_RX_COUNT;
 	priv->irq_enabled = 0;
 	priv->chan = 1;
-	priv->reg_chnl_plan = 0xf;
 	priv->rtllib->mode = WIRELESS_MODE_AUTO;
 	priv->rtllib->iw_mode = IW_MODE_INFRA;
 	priv->rtllib->net_promiscuous_md = false;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 38b215d86eeb..fa82a0667813 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -316,7 +316,6 @@ struct r8192_priv {
 
 	bool tx_pwr_data_read_from_eeprom;
 
-	u16 reg_chnl_plan;
 	u16 chnl_plan;
 	u8 hw_rf_off_action;
 
-- 
2.41.0

