Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF26C8CAA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjCYIfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjCYIfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:35:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C2F14983
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:35:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so2212113wmq.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UcQDl4D7QfpTg14fckybYa1gutFz2rlct5Mc7Ooqxbw=;
        b=YGvZ3CA0eLxSSJSxywKE1QEe4oOYAn4vDg+RM3MNiVaBaU84ypAF7SQVuUbLp5kwnB
         o5nbuE475eZg93Euh1SbCBAM/ftpS9twznrossXRMtTy23g6wdno8ojEmC8mVmG2aYDr
         x3D8IkQaIl/iTBmJWPXL6z75gi4jXmHO9cfyFH0sZvgF6Fcb9d/wG2yT+Hm0CSfaLKwD
         UA1a5aK19ppdgZXx552E1k8dIrrayRo4iNywoS+SH7I+FzwBFlkHe1CNjQ478K9HZI75
         160ARPVfY01NmUMPm546nGw8tYeCTnLDjPvZp3yEBr99fB4oZjkMo5ENX5cQhPqGA7aB
         K7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcQDl4D7QfpTg14fckybYa1gutFz2rlct5Mc7Ooqxbw=;
        b=4KZVAGMM2Ly1+LntZrGCVxQQ+iFX6tbgurerga+x8tq4du/paZTRANGHNy4mjylxyV
         HVs/TtEgNG7E7s3LTmDZSzhv/G1jYMC/e9sTUemswJZlyoZDLFSBBgRXbzHAAZ4zZlmr
         8RFJuLcyHba5sKKVJ87xHUa6rrCB1mxLtvsTgoI8hXvKXGxfgugGZFKJO4J/y04cB5uB
         X+nbcCnUFJkB/OoZQ890B1Y1yNMP51NRZQpcJf8dwfFj1j4PZGLEAM5JZ5h6Rg87rQ/J
         mnimB8anM76feliZEGQeUw1zNZUoKyjzDO3k0aJ57YvXvo7suAry7NgcMu1nwQaQ6x8e
         POWA==
X-Gm-Message-State: AO0yUKX+r3pPQfn3CcTT9cGSRoGAjvJSj06cp2VG9LlRxm4JJqB3Fy3R
        04kLBcek3htuelfA0MygTLVlIa8yCHY=
X-Google-Smtp-Source: AK7set+yel7kFnUKUMO0oaWKn0x9lKhDur0VbctyxcZJRj4rK0XrrY8Df9AATmRWx6qC/y7z84VdCg==
X-Received: by 2002:a05:600c:4fc1:b0:3ed:2a41:8529 with SMTP id o1-20020a05600c4fc100b003ed2a418529mr4280480wmq.2.1679733316019;
        Sat, 25 Mar 2023 01:35:16 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id o15-20020a1c750f000000b003ee1acdb036sm7223202wmc.17.2023.03.25.01.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:35:15 -0700 (PDT)
Date:   Sat, 25 Mar 2023 09:35:13 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] staging: rtl8192e: Remove priv->rf_chip in
 _rtl92e_phy_rf_read
Message-ID: <c3b2e2a41cc450c1cb9ac41b8ed19b090d9627a6.1679732276.git.philipp.g.hortmann@gmail.com>
References: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

priv->rf_chip is initialized to RF_8256 and never changed. Remove
conditions in function _rtl92e_phy_rf_read as those are dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 43 ++++++++-----------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 2dbddf4ae3d6..c4fd412cf3d6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -82,24 +82,20 @@ static u32 _rtl92e_phy_rf_read(struct net_device *dev,
 
 	Offset &= 0x3f;
 
-	if (priv->rf_chip == RF_8256) {
-		rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0xf00, 0x0);
-		if (Offset >= 31) {
-			priv->rf_reg_0value[eRFPath] |= 0x140;
-			rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
-					  bMaskDWord,
-					  (priv->rf_reg_0value[eRFPath] << 16));
-			NewOffset = Offset - 30;
-		} else if (Offset >= 16) {
-			priv->rf_reg_0value[eRFPath] |= 0x100;
-			priv->rf_reg_0value[eRFPath] &= (~0x40);
-			rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
-					  bMaskDWord,
-					  (priv->rf_reg_0value[eRFPath] << 16));
-
-			NewOffset = Offset - 15;
-		} else
-			NewOffset = Offset;
+	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0xf00, 0x0);
+	if (Offset >= 31) {
+		priv->rf_reg_0value[eRFPath] |= 0x140;
+		rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
+				  bMaskDWord,
+				  (priv->rf_reg_0value[eRFPath] << 16));
+		NewOffset = Offset - 30;
+	} else if (Offset >= 16) {
+		priv->rf_reg_0value[eRFPath] |= 0x100;
+		priv->rf_reg_0value[eRFPath] &= (~0x40);
+		rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset,
+				  bMaskDWord,
+				  (priv->rf_reg_0value[eRFPath] << 16));
+		NewOffset = Offset - 15;
 	} else {
 		NewOffset = Offset;
 	}
@@ -113,15 +109,12 @@ static u32 _rtl92e_phy_rf_read(struct net_device *dev,
 	ret = rtl92e_get_bb_reg(dev, pPhyReg->rfLSSIReadBack,
 				bLSSIReadBackData);
 
-	if (priv->rf_chip == RF_8256) {
-		priv->rf_reg_0value[eRFPath] &= 0xebf;
-
-		rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset, bMaskDWord,
-				  (priv->rf_reg_0value[eRFPath] << 16));
+	priv->rf_reg_0value[eRFPath] &= 0xebf;
 
-		rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0x300, 0x3);
-	}
+	rtl92e_set_bb_reg(dev, pPhyReg->rf3wireOffset, bMaskDWord,
+			  (priv->rf_reg_0value[eRFPath] << 16));
 
+	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0x300, 0x3);
 
 	return ret;
 
-- 
2.39.2

