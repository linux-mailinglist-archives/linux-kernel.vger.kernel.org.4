Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424175F1B82
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJAJl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJAJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:41:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B033258149
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:41:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a26so13515246ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=O4Um8Ahpe4fGsaE3pfc2y2JDj9dfhTxsFAj901n8Dqc=;
        b=G1OfJFwuWmNwBOInZiSVDuwNpThyDHrbZPk2OhZvZliL2z5cByO0DmZreG2tvgdzGd
         Ihw/YpLkJ1qVBqQVOE0iRcMDNPPq+gJdeMedrMyBXoWDpgQL2Yyg0OMyJCSUBq05TJWr
         iywTsRQbj8Ao5Dsrfy6lbFiyacMg5fPMokfr55bOqtMnCwye8AIPRa+F2AUyuKFkciuu
         k7lgImuzSZ5huB01B1jTmGXPcbby370h2CfXyy3D8VuXKahjAahZd/w7/dAMKVFAiHmz
         gEXYBO7uZ0f+WOHZQ2gkAekbtJDhvcsuEc6Lqmy4hgHcTNhahSav/vF7zC7OWV678Zm9
         01SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=O4Um8Ahpe4fGsaE3pfc2y2JDj9dfhTxsFAj901n8Dqc=;
        b=YTW2nkRnfRpksZFHGOVfWF4R8Ntzlj3rLYrCA5esPsgLwx2AwfWbkbfIFs5VkZc6wX
         vdvQxRihwFKi85I34JgraUYllwUBdJhFbe/0J0fUXw8KUZchUljW9Cb+BgfJuv+ATz9A
         aaaAxp0ZQYudCgP0LT9x9SHuOfz0l+LytOXpMb4uAzSG7leVnHka0OVcgrddbRjuecdw
         YFKbdKjIh/trC9N50Nu7IH8pGkAINhOhGw11qg5ZubABaPyEkklLddQdSSGaycO6wY7M
         H9ygCyONTWWpHwLswKz6vIo8qDNGClQ2FD0LMe4dKFmQj3o6MrfQozgXktokJqyB4cvR
         NBqw==
X-Gm-Message-State: ACrzQf0dwqkyPFme1XX5Gz6zQNxiAgoNayyhNVkNJIlnlqsfbw5bbUkn
        T+wRkKRbtXztFhkaZPE9Gn0=
X-Google-Smtp-Source: AMsMyM4RHLCJYhDiLDCAtJw+NmB8sEODCHPwUt4syAxkCB01VCxoDS4o6OyKjeq+8wpAEq9FOPNruA==
X-Received: by 2002:a17:907:a4e:b0:77d:94d:8148 with SMTP id be14-20020a1709070a4e00b0077d094d8148mr8818059ejc.607.1664617280851;
        Sat, 01 Oct 2022 02:41:20 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id r4-20020aa7cfc4000000b0044f21c69608sm3258698edy.10.2022.10.01.02.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 02:41:20 -0700 (PDT)
Date:   Sat, 1 Oct 2022 11:41:18 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] staging: rtl8192e: Remove unchanged variable
 bDisableNormalResetCheck
Message-ID: <026313f17cf708bf8fa0661f83b2c2b515e55b12.1664616227.git.philipp.g.hortmann@gmail.com>
References: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bDisableNormalResetCheck is just once initialized with false. All
evaluations will result in !false. Remove resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 6 ++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index e77a73df9bc5..9dcae5d71fb9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -871,7 +871,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->ScanDelay = 50;
 	priv->ResetProgress = RESET_TYPE_NORESET;
 	priv->bForcedSilentReset = false;
-	priv->bDisableNormalResetCheck = false;
 	priv->force_reset = false;
 	memset(priv->rtllib->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
 
@@ -1403,13 +1402,12 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	}
 	spin_unlock_irqrestore(&priv->tx_lock, flags);
 
-	if (!priv->bDisableNormalResetCheck && ResetType == RESET_TYPE_NORMAL) {
+	if (ResetType == RESET_TYPE_NORMAL) {
 		priv->ResetProgress = RESET_TYPE_NORMAL;
 		return;
 	}
 
-	if (((priv->force_reset) || (!priv->bDisableNormalResetCheck &&
-	      ResetType == RESET_TYPE_SILENT)))
+	if ((priv->force_reset || ResetType == RESET_TYPE_SILENT))
 		_rtl92e_if_silent_reset(dev);
 	priv->force_reset = false;
 	priv->bForcedSilentReset = false;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 7d716fa12995..8a24037a93ec 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -541,7 +541,6 @@ struct r8192_priv {
 
 	enum reset_type ResetProgress;
 	bool		bForcedSilentReset;
-	bool		bDisableNormalResetCheck;
 	u16		TxCounter;
 	u16		RxCounter;
 	bool		bResetInProgress;
-- 
2.37.3

