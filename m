Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38595B4D98
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiIKKqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiIKKq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:46:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E1B2B191
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:46:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t14so10892732wrx.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=HkRQXD8heGTebUpGA++qzsjiZZghTy1mCCFzSRDXdig=;
        b=WYPJuHp1aGBbMeZbq/Lfgta/tRfmmVoikgKDHaLzGrSNx8mG4JLQlANVjyhn2Ifcii
         IOfyustG56sQ51RMk51Xe0SMz92qDkgy7NVqmrcTZuv2/W2W7XoWqc5SPt/CrWkV6lmc
         Zd0mf86u0Gq2y0ZaoBNIJsAJXUSsP3PGcvdaVJFEDwWsVkqAEn976paNHgZwCpLmZvGk
         R1yHLg2V/bDQBUv/ioiCIaNwys4i6xyAMJ3ADc01dNCf2pbr7v/F963GTZVvFQNcb7ox
         7h5Zr4C9keDvZBLmsMgevB/SVZKRTzl18IIbalaBAbYvB9RrhVM+yWHVO3zmjRwm8Ea+
         268Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=HkRQXD8heGTebUpGA++qzsjiZZghTy1mCCFzSRDXdig=;
        b=WKAdlSzhmSOE0xlTsM/GyPcyjim9FaRty1sjneTja2ctGR3HJC+760JnATsCCAiHP5
         58AwltcozxjfxfoVV71RjtogIyEvqlMsWZE81HURvFV87Muxx7bYr0+mGTth2fOT+E/k
         fhu3u/jfOAM+lHIQ6WGmtaEtKJOf0tJtJLlEtV+haYEsH7VZcqMsfb+tiDdUKHdT52mT
         C1UBBnH4it7W7vJgOxg9K9u1/rUvo5/Bzar/CFttYPDWoxMEbXKiA+SptM5O+/eluIiG
         V0S07l/+Qjj073IOlYyNvK0lwhCt+bOqrFmfJLisxXEl4yZI7o+p6zfbbS8nMCXiGRfT
         1Lcg==
X-Gm-Message-State: ACgBeo3cXh3LZoeLPfQYwfSX3DMXzm0LQEklgcVCjbkpObatZxrbA0Ti
        zCDrAtlfB1FJ3jP6z/KxTmAmEJSdewY=
X-Google-Smtp-Source: AA6agR669Jcnw8mlp+34lVaPiR8YUjeEvxn8gntiKWs+uLTYRlZppFLL0LDnT5UzroM3Lehu1xP/cQ==
X-Received: by 2002:adf:e649:0:b0:228:a8f6:42b4 with SMTP id b9-20020adfe649000000b00228a8f642b4mr12240264wrn.167.1662893185777;
        Sun, 11 Sep 2022 03:46:25 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b00229d55994e0sm4579677wrp.59.2022.09.11.03.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 03:46:25 -0700 (PDT)
Date:   Sun, 11 Sep 2022 12:46:23 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] staging: vt6655: Rename function MACbSafeTxOff
Message-ID: <50211bbdd866be93fe9ea912a433e56460bf7f28.1662890990.git.philipp.g.hortmann@gmail.com>
References: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function MACbSafeTxOff to vt6655_mac_safe_tx_off to avoid
CamelCase which is not accepted by checkpatch.pl. Remove unnecessary
declaration of function and make function static.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 8 ++++----
 drivers/staging/vt6655/mac.h | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index e0216d320235..24851fe53683 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -18,7 +18,7 @@
  *      vt6655_mac_restore_context - Restore Context of MAC Registers
  *      MACbSoftwareReset - Software Reset MAC
  *      vt6655_mac_safe_rx_off - Turn Off MAC Rx
- *      MACbSafeTxOff - Turn Off MAC Tx
+ *      vt6655_mac_safe_tx_off - Turn Off MAC Tx
  *      MACbSafeStop - Stop MAC function
  *      MACbShutdown - Shut down MAC
  *      MACvInitialize - Initialize MAC
@@ -376,7 +376,7 @@ static bool vt6655_mac_safe_rx_off(struct vnt_private *priv)
  * Return Value: true if success; otherwise false
  *
  */
-bool MACbSafeTxOff(struct vnt_private *priv)
+static bool vt6655_mac_safe_tx_off(struct vnt_private *priv)
 {
 	void __iomem *io_base = priv->port_offset;
 	unsigned short ww;
@@ -443,8 +443,8 @@ bool MACbSafeStop(struct vnt_private *priv)
 		vt6655_mac_save_soft_reset(priv);
 		return false;
 	}
-	if (!MACbSafeTxOff(priv)) {
-		pr_debug(" MACbSafeTxOff == false)\n");
+	if (!vt6655_mac_safe_tx_off(priv)) {
+		pr_debug(" vt6655_mac_safe_tx_off == false)\n");
 		vt6655_mac_save_soft_reset(priv);
 		return false;
 	}
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index e6ff860c1bfa..12b4f8937d14 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -554,7 +554,6 @@ void vt6655_mac_set_short_retry_limit(struct vnt_private *priv, unsigned char re
 void MACvSetLongRetryLimit(struct vnt_private *priv, unsigned char byRetryLimit);
 
 bool MACbSoftwareReset(struct vnt_private *priv);
-bool MACbSafeTxOff(struct vnt_private *priv);
 bool MACbSafeStop(struct vnt_private *priv);
 bool MACbShutdown(struct vnt_private *priv);
 void MACvInitialize(struct vnt_private *priv);
-- 
2.37.3

