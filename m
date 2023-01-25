Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B16467BC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjAYUJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbjAYUJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:09:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6926E5CFE5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:03 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z5so18205998wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5ygW0iNMg8HClPWoVPtKx35n6wKs6NqAz6ewUsuKhU=;
        b=U4uzPDwfHDjBX1sGGDZR/XNANZn19pibtwG3TSQnL7h8NKJjBFoNFxIopM5mF09P4B
         trCEIeBvh8aypzWPgonTJsO5i+f/xkkmUEc05qEoPxe0moqC4EtrpBO0wsgBlH+zqnBa
         UrKuJO9ZesiSt6ssBWl9gx7zdJ8FpfRYlPNiWl62SdvQPb552rdemNgl3TSdID5jGW59
         Fc7n0bmzig2tBVE4zl45CLXRfWMORBGk1QByX1mCzhJmu2+DKNpkP0yJ/sHN3VlcCdQj
         2tJXHR2PM8KmCbVwzGnMssOxseXaqNPgbsPID+skaRPC8X+IsSBXfbBGIck7VmWm5jtl
         lkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5ygW0iNMg8HClPWoVPtKx35n6wKs6NqAz6ewUsuKhU=;
        b=SvtU7RNtRZp635q2BwrshesyQhZ6LOcd6rziMmmcHVfz5oFY6ZhvYE1L+jg6YJyBcI
         dcy1SlvY5coPqv+zH4ibKTecv39OnQ63TL+YlU1mSuV6mDF0JBhL0MNH8uEJTWEMg5ci
         7yqg8YFwoWoyhg8iUPSomVgxzCissWyebGR/6dPLQZcz7F1MKfRoXUm5hdPHo20dO+kv
         W9wqFzvWDXZmTP52BUnCiVIULkg3W2PeMfo/jw8H+ww/YkqejjqniOy/eXpTfF80auVp
         ZRp8ItdZYdhfRTWRYjvgIsdRJFDrzdyQ0V/LW7bFsowKHQreMXwzgaq9qk+ZJnRbj+3P
         Bqhg==
X-Gm-Message-State: AFqh2koRxzCE/t3c27nCbYed/kVfcoFPoFCN2YNJvc5SWPlZ4Gi26Y2e
        tnmXhjy2DK7G97r++ESQiTM=
X-Google-Smtp-Source: AMrXdXsBEHflsPtdPSO01GmeB+48rssoXjzAYdMT6pVDyZekdlTG5+TNb9jTPssgYJ2aHStNGZD+4w==
X-Received: by 2002:a05:6000:69d:b0:2be:184:8af6 with SMTP id bo29-20020a056000069d00b002be01848af6mr6524730wrb.0.1674677341944;
        Wed, 25 Jan 2023 12:09:01 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id q6-20020a056000136600b00241fde8fe04sm2287868wrz.7.2023.01.25.12.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:09:01 -0800 (PST)
Date:   Wed, 25 Jan 2023 21:08:59 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] staging: rtl8192e: Remove unused variables
 num_proc.., recei.. and rxov..
Message-ID: <ff9daec237b795a01629080d0d5f7ec73b2d89da.1674675808.git.philipp.g.hortmann@gmail.com>
References: <cover.1674675808.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674675808.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

num_process_phyinfo, received_bwtype and rxoverflow are initialized and
increased but never read. Remove dead code. As a result prxsc is unused
which in result makes rxsc_sgien_exflg unused. Remove prxsc and
rxsc_sgien_exflg as well.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: Remove prxsc and rxsc_sgien_exflg
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 13 +------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   |  4 +---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  3 ---
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index f62547e54261..9d13fda33fbf 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1296,9 +1296,8 @@ static void _rtl92e_query_rxphystatus(
 {
 	struct phy_sts_ofdm_819xpci *pofdm_buf;
 	struct phy_sts_cck_819xpci *pcck_buf;
-	struct phy_ofdm_rx_status_rxsc_sgien_exintfflag *prxsc;
 	u8 *prxpkt;
-	u8 i, max_spatial_stream, tmp_rxsnr, tmp_rxevm, rxsc_sgien_exflg;
+	u8 i, max_spatial_stream, tmp_rxsnr, tmp_rxevm;
 	s8 rx_pwr[4], rx_pwr_all = 0;
 	s8 rx_snrX, rx_evmX;
 	u8 evm, pwdb_all;
@@ -1464,15 +1463,6 @@ static void _rtl92e_query_rxphystatus(
 				precord_stats->RxMIMOSignalQuality[i] = evm & 0xff;
 			}
 		}
-
-
-		rxsc_sgien_exflg = pofdm_buf->rxsc_sgien_exflg;
-		prxsc = (struct phy_ofdm_rx_status_rxsc_sgien_exintfflag *)
-			&rxsc_sgien_exflg;
-		if (pdrvinfo->BW)
-			priv->stats.received_bwtype[1+prxsc->rxsc]++;
-		else
-			priv->stats.received_bwtype[0]++;
 	}
 
 	if (is_cck_rate) {
@@ -1535,7 +1525,6 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 	if (!bcheck)
 		return;
 
-	priv->stats.num_process_phyinfo++;
 	if (!prev_st->bIsCCK && prev_st->bPacketToSelf) {
 		for (rfpath = RF90_PATH_A; rfpath < RF90_PATH_C; rfpath++) {
 			if (!rtl92e_is_legal_rf_path(priv->rtllib->dev, rfpath))
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index e0d0f4faeca7..c5fe8e0aa83f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -2183,10 +2183,8 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		tasklet_schedule(&priv->irq_rx_tasklet);
 	}
 
-	if (inta & IMR_RXFOVW) {
-		priv->stats.rxoverflow++;
+	if (inta & IMR_RXFOVW)
 		tasklet_schedule(&priv->irq_rx_tasklet);
-	}
 
 	if (inta & IMR_TXFOVW)
 		priv->stats.txoverflow++;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index e38de4d8a467..bb942283bc7a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -184,9 +184,6 @@ enum reset_type {
 
 struct rt_stats {
 	unsigned long received_rate_histogram[4][32];
-	unsigned long num_process_phyinfo;
-	unsigned long received_bwtype[5];
-	unsigned long rxoverflow;
 	unsigned long rxint;
 	unsigned long ints;
 	unsigned long shints;
-- 
2.39.1

