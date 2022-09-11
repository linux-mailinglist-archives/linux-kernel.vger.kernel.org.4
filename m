Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C4E5B4D99
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiIKKq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiIKKqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:46:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F504AE48
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:46:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c11so10851668wrp.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=0hkQhpo1A1tdXsj7hM3SgBaWaZ2bYD8tzutyzKnpV6Y=;
        b=QuTOkaDTihOMWagUS0w0B0LiJt93fzUdDTfNECCTJkZ8NI4HZgUlHrE+gAtMMCwmsY
         ziLJFr8XrHqwGm3YDsov6q4m1/vVk3lH6cJVBwrV0pjFV1DeZxRPjcmxNT++dIqJuNwg
         gS4RnuU8vrtUzmGcKCiqsmITAAK/4K/2LSj887r9uAm4i9iN154G2YRrD/wTWhrF5+q1
         XOyLhEIjWqdZ8T/3ZTyE78bBBv3kWUTuHRnGjlfFK73ehCqO4fju/jUATyX8kvea8aHx
         wSu1XFYa9VH8lBdL8nBsW82JOqdafmDb8Vdp5BDSbdBstJNjDYZqgRINkiD7C/FYE0ZM
         2qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0hkQhpo1A1tdXsj7hM3SgBaWaZ2bYD8tzutyzKnpV6Y=;
        b=r5Cf+7gKu9iIQYgGT9g3OnmpIn4mvBPYovIRFdeo2/zzYReUJCpr3Wtyi17QAhg9Ow
         Jy4Rtq9ujh14UW2MqWsBnUmQMGInmmKW8TsiTfgFv1p+TC3GSJUPbfRf9aTXHipwUX49
         SIhgKsvO0/AMU5xYGMNijdnoEDmy9pTKiROgO8JyaE+25Nv4iYRQQU0t9Q5vta3SpfPh
         0sjuS3Hea68ef5wMdO/JxnHmScmoDxDzB8zD5AmN4O/OV/jTIcz5zSu6eRSOB5nbigeN
         q25PVD/rr18nGUyaxOg52xzoMm93EN17vqSRj/+OwS99w0P0deOUuks08OLhuqnFnJyx
         C1pw==
X-Gm-Message-State: ACgBeo30lr+CSANVD8HVfdCpdk8raaK65FX/0oXNI2bze4thzqqPFHa7
        OrbbC0zxDHoazj3ouaUP2pk=
X-Google-Smtp-Source: AA6agR4BPOftbJEfLk/OZLQ9U9wjvjFHpsv5VVUyjn1M1zZ2qDnyf22vqvea0eqz9a6M+WLoZVap3A==
X-Received: by 2002:a5d:6d4f:0:b0:225:63aa:27b2 with SMTP id k15-20020a5d6d4f000000b0022563aa27b2mr12737022wri.599.1662893177794;
        Sun, 11 Sep 2022 03:46:17 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c511600b003a5b6086381sm6263484wms.48.2022.09.11.03.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 03:46:17 -0700 (PDT)
Date:   Sun, 11 Sep 2022 12:46:15 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] staging: vt6655: Rename function MACbSafeRxOff
Message-ID: <0cbcc7205e943393e2873839116d5ffcfb9d3d00.1662890990.git.philipp.g.hortmann@gmail.com>
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

Rename function MACbSafeRxOff to vt6655_mac_safe_rx_off to avoid
CamelCase which is not accepted by checkpatch.pl. Remove unnecessary
declaration of function and make function static.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 8 ++++----
 drivers/staging/vt6655/mac.h | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index f292a34c23dd..e0216d320235 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -17,7 +17,7 @@
  *      vt6655_mac_save_context - Save Context of MAC Registers
  *      vt6655_mac_restore_context - Restore Context of MAC Registers
  *      MACbSoftwareReset - Software Reset MAC
- *      MACbSafeRxOff - Turn Off MAC Rx
+ *      vt6655_mac_safe_rx_off - Turn Off MAC Rx
  *      MACbSafeTxOff - Turn Off MAC Tx
  *      MACbSafeStop - Stop MAC function
  *      MACbShutdown - Shut down MAC
@@ -322,7 +322,7 @@ static void vt6655_mac_save_soft_reset(struct vnt_private *priv)
  * Return Value: true if success; otherwise false
  *
  */
-bool MACbSafeRxOff(struct vnt_private *priv)
+static bool vt6655_mac_safe_rx_off(struct vnt_private *priv)
 {
 	void __iomem *io_base = priv->port_offset;
 	unsigned short ww;
@@ -438,8 +438,8 @@ bool MACbSafeStop(struct vnt_private *priv)
 
 	vt6655_mac_reg_bits_off(io_base, MAC_REG_TCR, TCR_AUTOBCNTX);
 
-	if (!MACbSafeRxOff(priv)) {
-		pr_debug(" MACbSafeRxOff == false)\n");
+	if (!vt6655_mac_safe_rx_off(priv)) {
+		pr_debug(" vt6655_mac_safe_rx_off == false)\n");
 		vt6655_mac_save_soft_reset(priv);
 		return false;
 	}
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 5dd8644749ec..e6ff860c1bfa 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -554,7 +554,6 @@ void vt6655_mac_set_short_retry_limit(struct vnt_private *priv, unsigned char re
 void MACvSetLongRetryLimit(struct vnt_private *priv, unsigned char byRetryLimit);
 
 bool MACbSoftwareReset(struct vnt_private *priv);
-bool MACbSafeRxOff(struct vnt_private *priv);
 bool MACbSafeTxOff(struct vnt_private *priv);
 bool MACbSafeStop(struct vnt_private *priv);
 bool MACbShutdown(struct vnt_private *priv);
-- 
2.37.3

