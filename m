Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6605667A552
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjAXWEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjAXWD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:03:59 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF7521C8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:03:43 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso25741wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2hw80KcuVAFiY4CDXg3tE7695ii5d+NENvOP8i9jB0=;
        b=naB3RXah16zS9TYfv3SuY5nU7oB2KZyejVbO9DWBDbuMl2nZHaPx25OzJhY9mvzUi1
         Yl1usIiQGf1EDfvF042o7yQ068rHWw9U07gIZfkIgAmexVHQvzygQXsLhMcRf86NOApJ
         XHPGNaihw4JbYMLuYkaiRHxC4F4kEfAk46MiiLGZ1FAJdBDnfTs0y92oJz9I1DBz5ntT
         EOl1mEZcEu4VqGid3XOgtIfnJjlfpQYTdiZQCoA9gIdIEkbEZJRb/xO5Yxwk6Xb25aTT
         6Ws9E7sR4y8TzGUGJIYyAAQ6d5BimVP6B1pPD4k0TRjP7GVkOaB9YO9a6moPYRpkE+Nh
         KGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2hw80KcuVAFiY4CDXg3tE7695ii5d+NENvOP8i9jB0=;
        b=xzg6SgGZObHFgH5HT5aBe+x2Qmwi6uQANbw+Z/u1vSF4pjXBLwreW8SynWOMk6xgg0
         /lbAoh/b+D+Cn6tY2buRKU3sKCvaLF5Dpg9zkijMaZLn/6S7DT/JDU7/KAh0BxO2o/TF
         IjkdY/ot8o5Y27EcOhsCbbpHYAbmXjo3C9VDodTAkDKudBXw/l1pc/0sL8cP5l6Nvlh8
         k5Wxlo4nECiIIymOJalamkkjeGDNJ5qd93++gbm/yIhMW+4KlG8w5joM4pjahctXPJI0
         pQ/fxpTt4Pzvsm2z18IpXEESKwdNKV73xDy0AfZ51bX99bl9J91iW52MJd2OkwDpXsN4
         UUIQ==
X-Gm-Message-State: AFqh2kobQvOmF2Z4mQzKCgc5P23+PN7UozWisDQ/8jZ987C3Au1v6tJy
        RXDVvhUIBCf1CjGwRrX83FE=
X-Google-Smtp-Source: AMrXdXsviwhZlPAxl3h3uQVg4/Jul77qoSKQNleBof+aidH7WdDd3WYw8pgsHsl8zUYXFBmbtoRWDA==
X-Received: by 2002:a05:600c:3b29:b0:3da:f7a9:50ca with SMTP id m41-20020a05600c3b2900b003daf7a950camr7698187wms.0.1674597822371;
        Tue, 24 Jan 2023 14:03:42 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c4e8900b003d990372dd5sm37792wmq.20.2023.01.24.14.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:03:41 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:03:40 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] staging: rtl8192e: Remove unused variables numpacket..
 and received_pre..
Message-ID: <c90c54f7b0e122914d5c02d6849447897a268f16.1674596722.git.philipp.g.hortmann@gmail.com>
References: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

numpacket_toself, numpacket_matchbssid and received_preamble_GI are
initialized and increased but never read. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 5 -----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e9273dfb638e..c5ebc33dc7f1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1685,10 +1685,6 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 			 ether_addr_equal(praddr, priv->rtllib->dev->dev_addr);
 	if (WLAN_FC_GET_FRAMETYPE(fc) == RTLLIB_STYPE_BEACON)
 		bPacketBeacon = true;
-	if (bpacket_match_bssid)
-		priv->stats.numpacket_matchbssid++;
-	if (bpacket_toself)
-		priv->stats.numpacket_toself++;
 	_rtl92e_process_phyinfo(priv, tmp_buf, &previous_stats, pstats);
 	_rtl92e_query_rxphystatus(priv, pstats, pdesc, pdrvinfo,
 				  &previous_stats, bpacket_match_bssid,
@@ -1804,7 +1800,6 @@ static void _rtl92e_update_received_rate_histogram_stats(
 		rateIndex = 28;
 		break;
 	}
-	priv->stats.received_preamble_GI[preamble_guardinterval][rateIndex]++;
 	priv->stats.received_rate_histogram[0][rateIndex]++;
 	priv->stats.received_rate_histogram[rcvType][rateIndex]++;
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 167c4aeea44e..70767238e721 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -184,9 +184,6 @@ enum reset_type {
 
 struct rt_stats {
 	unsigned long received_rate_histogram[4][32];
-	unsigned long received_preamble_GI[2][32];
-	unsigned long numpacket_matchbssid;
-	unsigned long numpacket_toself;
 	unsigned long num_process_phyinfo;
 	unsigned long numqry_phystatus;
 	unsigned long numqry_phystatusCCK;
-- 
2.39.1

