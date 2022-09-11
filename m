Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF7C5B4D96
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiIKKq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiIKKqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:46:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40C826128
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:46:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o25so10882920wrf.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=gp3UgaatVvujanlcL6wYXQCbjciFqKB9PuAksoUMUQ4=;
        b=qhKxEiK3HRYyBRAy3vY3BcKyHfU77EAYHoMRZG9LlIH/U9XRRKbxPeCeSplBw/Yr1R
         dkmjbztA6a4m56WoWNJsgdXplWvP4mQ7/uU5U2Go2m1muINB2bIwZxe1Q+y3ReYa6BYn
         aPnFLJ6l3BPra8/R/RCB+vE5x65JKNGLfyFH2ac75Q/M4503NVb5/ty+iK7WJQZ6quCc
         8FzUkEQIMnHpThS6Pcx6fiN188/+jiEPlaHbqdN/ifDf7kQIfS3pEnuJyX75OJXggsmL
         CJg9zVO6PXf7OxgiO3VJ7LOEI6MmBgwVqPYo1ES9oBCLhfDTdNwtX4zMyt/29CWN7Ym1
         wjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gp3UgaatVvujanlcL6wYXQCbjciFqKB9PuAksoUMUQ4=;
        b=QkkSZMTfkjvvyBTOndjxmRS/5+xoKIQNPvIBCWbtKLE2WVefFlBUI4l/a8T43N0JgY
         fH2C62eZNSeqS8fx9HA2rIKnQWbir+4W7YN/eUsrqyHmcIYCgSdpmuLhvZOQUE8yWHdc
         U8Mw5sRVOWAykXGUfjV563h57krwAFxB/ZJYtVie2QdS0a7HAuM6snTNnuSBTWQQvbQ1
         /zSQkfP5V6g3hCqZtsGml57sTcDvxqrXEn9zf/FerKFAO+gkF7v/ORFTpL++YSzoVEmO
         f1i6WXo5bmi7q13ITiCgkU9bHmDGBMg0eTmB206Pk9wzg89KNf2Fgx1bZUMptTA5GlHh
         ihqA==
X-Gm-Message-State: ACgBeo2UzrIdJ9JeuS0CBE4lOEWM0pLU/kZx8r1ywwr0LG8JClE628b7
        knMYlBo7jaH3bouqOSD1cUm8SOWzi70=
X-Google-Smtp-Source: AA6agR6S7tlDjdVGdhfl64fTLOzpj7KguvH0z1mvzqdZ0VEQpdSyaJDBt6/PTK/rdEjchIyo4jq0Mg==
X-Received: by 2002:a5d:6da7:0:b0:226:e081:941a with SMTP id u7-20020a5d6da7000000b00226e081941amr12121197wrs.642.1662893166500;
        Sun, 11 Sep 2022 03:46:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c1d0500b003b477532e66sm3478029wms.2.2022.09.11.03.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 03:46:06 -0700 (PDT)
Date:   Sun, 11 Sep 2022 12:46:04 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] staging: vt6655: Cleanup and rename function
 MACbSafeSoftwareReset
Message-ID: <540a684266610f7618b3ef6000d4699d065c8e6f.1662890990.git.philipp.g.hortmann@gmail.com>
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

Rename function MACbSafeSoftwareReset to vt6655_mac_save_soft_reset and
abyTmpRegData to tmp_reg_data to avoid CamelCase which is not accepted by
checkpatch.pl. Remove return value bRetVal as it is unused by the calling
functions. Remove unnecessary declaration of function and make function
static. Change declaration of tmp_reg_data to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 17 +++++++----------
 drivers/staging/vt6655/mac.h |  1 -
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index b1aa5fbe4430..f292a34c23dd 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -293,23 +293,20 @@ bool MACbSoftwareReset(struct vnt_private *priv)
  * Return Value: true if success; otherwise false
  *
  */
-bool MACbSafeSoftwareReset(struct vnt_private *priv)
+static void vt6655_mac_save_soft_reset(struct vnt_private *priv)
 {
-	unsigned char abyTmpRegData[MAC_MAX_CONTEXT_SIZE_PAGE0 + MAC_MAX_CONTEXT_SIZE_PAGE1];
-	bool bRetVal;
+	u8 tmp_reg_data[MAC_MAX_CONTEXT_SIZE_PAGE0 + MAC_MAX_CONTEXT_SIZE_PAGE1];
 
 	/* PATCH....
 	 * save some important register's value, then do
 	 * reset, then restore register's value
 	 */
 	/* save MAC context */
-	vt6655_mac_save_context(priv, abyTmpRegData);
+	vt6655_mac_save_context(priv, tmp_reg_data);
 	/* do reset */
-	bRetVal = MACbSoftwareReset(priv);
+	MACbSoftwareReset(priv);
 	/* restore MAC context, except CR0 */
-	vt6655_mac_restore_context(priv, abyTmpRegData);
-
-	return bRetVal;
+	vt6655_mac_restore_context(priv, tmp_reg_data);
 }
 
 /*
@@ -443,12 +440,12 @@ bool MACbSafeStop(struct vnt_private *priv)
 
 	if (!MACbSafeRxOff(priv)) {
 		pr_debug(" MACbSafeRxOff == false)\n");
-		MACbSafeSoftwareReset(priv);
+		vt6655_mac_save_soft_reset(priv);
 		return false;
 	}
 	if (!MACbSafeTxOff(priv)) {
 		pr_debug(" MACbSafeTxOff == false)\n");
-		MACbSafeSoftwareReset(priv);
+		vt6655_mac_save_soft_reset(priv);
 		return false;
 	}
 
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 25247b0bf039..5dd8644749ec 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -554,7 +554,6 @@ void vt6655_mac_set_short_retry_limit(struct vnt_private *priv, unsigned char re
 void MACvSetLongRetryLimit(struct vnt_private *priv, unsigned char byRetryLimit);
 
 bool MACbSoftwareReset(struct vnt_private *priv);
-bool MACbSafeSoftwareReset(struct vnt_private *priv);
 bool MACbSafeRxOff(struct vnt_private *priv);
 bool MACbSafeTxOff(struct vnt_private *priv);
 bool MACbSafeStop(struct vnt_private *priv);
-- 
2.37.3

