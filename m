Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9505B4D9B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiIKKr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiIKKrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:47:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A63C16C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:47:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e16so10894453wrx.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=nBdTSAzFShT30tVGtuaAt4w0WQVoDwWLtAj/D+fJEoQ=;
        b=Dp1BsHfW8cgZ2B+XxymWNyqAIO33+m3Ciz/srTGiMLnWBE2zrDnEMD71oIpt9fXmLW
         N9w/98zvBxDxAjqo90+qCw1Yalh3U1uJGITetUy3oPTK2zNcxUOrM1VeZqG3PCeFSjba
         Eohm3mwKx0NVPiLRZroHYWuTwRsMpXeb6pxVkT0usNQH/39pwOsBGRCCAeXHXCxJ24H1
         ESZUVQS7P00l6/qIH8mdc6BbHl3QtwHGN93MVrIKG2WTIsgEMegwEF946642oJ6mOOmS
         VJkDdMsi38iuMI727tBAhk6PHK6tHO1Yp2w+HSozZ28NDfVOqHInnZxzJkhtbBAdJJoJ
         O8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nBdTSAzFShT30tVGtuaAt4w0WQVoDwWLtAj/D+fJEoQ=;
        b=Vqmnh7zqg5E6j4ggm069R5d9KnQvC/oCmeG1FC2Rd2yKuU/9nQQLtQ1r8TcbhVwIGP
         G7pzNoYW47pGMKZY38PwiWtd8t5LjwREtccxC0+hYSGeNklZFngllzBSVs/JRe5QRmua
         +NhT+LAcISELGVSuiD+21AszOWCxvt6RnvJQjnBsvsGyXyXukocvD4uBTiVy7Me3TR2f
         CwkOi/f8B3BfgnI1CwHe45AmqNsId+62mCXYqp9Rga96j2SXL+6Qub1YbRVqgLQ4EDyy
         aCpOroXpKJhvYjvnlSNuGiy6D2HoU4ADb+W8CzWlRf1ZJtCLq8DT+6siWh0W+SkZh7yE
         +0Yg==
X-Gm-Message-State: ACgBeo2x1xwAgpC/PdjzYQ1DJtjz+p5L3r7bn6L9iknB1jQV594ifnOa
        Puw+TJITG7wzSzSGQLCndFM=
X-Google-Smtp-Source: AA6agR4vUjvoBaO8sfin/zparxquhaBoIOhA2IGrIbQpvw0CO05HlwQ8pkB6XNsmxmW+XIe1aKrHjA==
X-Received: by 2002:a5d:6102:0:b0:228:811f:b496 with SMTP id v2-20020a5d6102000000b00228811fb496mr12649619wrt.404.1662893219120;
        Sun, 11 Sep 2022 03:46:59 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id p8-20020a1c5448000000b003a502c23f2asm6220317wmi.16.2022.09.11.03.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 03:46:58 -0700 (PDT)
Date:   Sun, 11 Sep 2022 12:46:57 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] staging: vt6655: Rename function MACvSetCurrRx0DescAddr
Message-ID: <14f7f2b06ba9f8656d91d4cb84c363e190095049.1662890990.git.philipp.g.hortmann@gmail.com>
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

Rename function MACvSetCurrRx0DescAddr to vt6655_mac_set_curr_rx_0_desc...
to avoid CamelCase which is not accepted by checkpatch.pl. Remove
unnecessary line break.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/card.c | 2 +-
 drivers/staging/vt6655/mac.c  | 2 +-
 drivers/staging/vt6655/mac.h  | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 1b2ba6793ead..dc39b3668c77 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -458,7 +458,7 @@ void CARDvSafeResetRx(struct vnt_private *priv)
 	iowrite32(RX_PERPKT, priv->port_offset + MAC_REG_RXDMACTL0);
 	iowrite32(RX_PERPKT, priv->port_offset + MAC_REG_RXDMACTL1);
 	/* set MAC RD pointer */
-	MACvSetCurrRx0DescAddr(priv, priv->rd0_pool_dma);
+	vt6655_mac_set_curr_rx_0_desc_addr(priv, priv->rd0_pool_dma);
 
 	MACvSetCurrRx1DescAddr(priv, priv->rd1_pool_dma);
 }
diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index e1f639787316..e88536705d23 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -527,7 +527,7 @@ void MACvInitialize(struct vnt_private *priv)
  * Return Value: none
  *
  */
-void MACvSetCurrRx0DescAddr(struct vnt_private *priv, u32 curr_desc_addr)
+void vt6655_mac_set_curr_rx_0_desc_addr(struct vnt_private *priv, u32 curr_desc_addr)
 {
 	void __iomem *io_base = priv->port_offset;
 	unsigned short ww;
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index c6147a4f563e..b092e59a5b98 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -556,8 +556,7 @@ void MACvSetLongRetryLimit(struct vnt_private *priv, unsigned char byRetryLimit)
 bool MACbSoftwareReset(struct vnt_private *priv);
 bool MACbShutdown(struct vnt_private *priv);
 void MACvInitialize(struct vnt_private *priv);
-void MACvSetCurrRx0DescAddr(struct vnt_private *priv,
-			    u32 curr_desc_addr);
+void vt6655_mac_set_curr_rx_0_desc_addr(struct vnt_private *priv, u32 curr_desc_addr);
 void MACvSetCurrRx1DescAddr(struct vnt_private *priv,
 			    u32 curr_desc_addr);
 void MACvSetCurrTXDescAddr(int iTxType, struct vnt_private *priv,
-- 
2.37.3

