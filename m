Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7065B4D9C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIKKri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiIKKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:47:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891FB3C8DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:47:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e20so10859093wri.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=TT6OYj05Y/OPaIfMBcxSP+HaQFVzI0H6ci3zEsCyTH0=;
        b=VPuwS/1KbQj6bIjLdGNTfU5UDPGo6ceRfJnMYfBnITrtE7a1M5nBuOJtwAgQCTcXsl
         r9XjgpLmLlzTKBAvqCKW7TFzvvHhiZ5me9UQUyucu/XHKwhFo6suLw/kk1nGeLJYyL8z
         dDGxuyXKs4Ql4YX+oMe2dm/9IesjE3yEYgISfikNOqkehWEOK+bDf1pRHDm1zi9CE/PK
         N/SYG48Xl/08fiS4TahJ94ZWogJK79rWXFRgr9mYjP/QNibBJGHi2/S2FYYeEHc8OfhU
         KQXzTaiioS6QnlPPEb7Uv+cBCv0LlCswUeWUbn/c3D41QEwEMHDaAPTtH2hYz1hkp0EB
         9UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TT6OYj05Y/OPaIfMBcxSP+HaQFVzI0H6ci3zEsCyTH0=;
        b=SaBwdu2uJoyPiHlZ8OFjBaHHiSWivuI+f/4ArM7CLEQOm6PWJHCWzIKE/ZLW+UP4Ao
         Vn4xSNgHFIAElu8Ez867QimaKZq4UcCZMkdIFFXp+kcc5LgtPYJZCpfFUCnaNiYCxWTV
         MG/uxBstSlJBVBIKEydSw19Apu6PSMbS5cOhzT5SF2P4XK2pq+dJFO9CZbRWep27fZ02
         TkIzx3roUnUcOiJYMaHSeUFYvHnyjHLkkoAtCj8G5rDqCCIABftB1TWPbBLC9ueqIBAy
         X0tdNrV/D++l9WgZNzjGghCsGqZ4TNjWk8a/WdPVnBjajDRrSVVRMH01iMnWoTlePWEg
         qStw==
X-Gm-Message-State: ACgBeo15z0jdiHDQIKBoz7lMK0kr/cnq5gBpi51SpDH5e26r8fkjGYks
        QAjZaPAkOj5QRc6Su/mGoU8=
X-Google-Smtp-Source: AA6agR6nL4INVoqEtyPqMDS+sGUJpypmgQ3Dce+GdrMZK0OzHGD8kKftBHDaZMa472Xgyc2xMcHv5A==
X-Received: by 2002:a5d:68c6:0:b0:228:74b6:2b07 with SMTP id p6-20020a5d68c6000000b0022874b62b07mr12073406wrw.60.1662893229758;
        Sun, 11 Sep 2022 03:47:09 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c020b00b003b4868eb6bbsm112872wmi.23.2022.09.11.03.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 03:47:09 -0700 (PDT)
Date:   Sun, 11 Sep 2022 12:47:07 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] staging: vt6655: Rename function MACvSetCurrRx1DescAddr
Message-ID: <0d11f588d4746988478521d323ab49e6a0b7f8b0.1662890990.git.philipp.g.hortmann@gmail.com>
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

Rename function MACvSetCurrRx1DescAddr to vt6655_mac_set_curr_rx_1_desc...
to avoid CamelCase which is not accepted by checkpatch.pl. Remove
unnecessary line break.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/card.c | 2 +-
 drivers/staging/vt6655/mac.c  | 2 +-
 drivers/staging/vt6655/mac.h  | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index dc39b3668c77..d137b4b45e3b 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -460,7 +460,7 @@ void CARDvSafeResetRx(struct vnt_private *priv)
 	/* set MAC RD pointer */
 	vt6655_mac_set_curr_rx_0_desc_addr(priv, priv->rd0_pool_dma);
 
-	MACvSetCurrRx1DescAddr(priv, priv->rd1_pool_dma);
+	vt6655_mac_set_curr_rx_1_desc_addr(priv, priv->rd1_pool_dma);
 }
 
 /*
diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index e88536705d23..d6614be79e39 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -561,7 +561,7 @@ void vt6655_mac_set_curr_rx_0_desc_addr(struct vnt_private *priv, u32 curr_desc_
  * Return Value: none
  *
  */
-void MACvSetCurrRx1DescAddr(struct vnt_private *priv, u32 curr_desc_addr)
+void vt6655_mac_set_curr_rx_1_desc_addr(struct vnt_private *priv, u32 curr_desc_addr)
 {
 	void __iomem *io_base = priv->port_offset;
 	unsigned short ww;
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index b092e59a5b98..fff9dc72e2c0 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -557,8 +557,7 @@ bool MACbSoftwareReset(struct vnt_private *priv);
 bool MACbShutdown(struct vnt_private *priv);
 void MACvInitialize(struct vnt_private *priv);
 void vt6655_mac_set_curr_rx_0_desc_addr(struct vnt_private *priv, u32 curr_desc_addr);
-void MACvSetCurrRx1DescAddr(struct vnt_private *priv,
-			    u32 curr_desc_addr);
+void vt6655_mac_set_curr_rx_1_desc_addr(struct vnt_private *priv, u32 curr_desc_addr);
 void MACvSetCurrTXDescAddr(int iTxType, struct vnt_private *priv,
 			   u32 curr_desc_addr);
 void MACvSetCurrTx0DescAddrEx(struct vnt_private *priv,
-- 
2.37.3

