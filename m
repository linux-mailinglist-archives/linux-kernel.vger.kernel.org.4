Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12FA73C70F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjFXGF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjFXGFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:05:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CD92D59
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98de322d11fso10899566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687586696; x=1690178696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BWbcO1nwvpd6S1p5aHK6YNqJsjh6u2uTKVKHyBrc6U=;
        b=gyaBU3hGEcyfDQFaVIoIY85LxuTTosEfx7uk3Z1KH5gcty1zpE+PlK0OX6wNvY5nfa
         h3rllOG9uoSGkj+5OWoYL01CCqYIJshQ+NBJgD/S6zSUsadEaq2lnwtF7Cir0LUIw4GP
         ldkRQKotJegsLHJP7UoRvpXJ0b+FV7o1VGswEURyK+jHVoXJCosavKnvdExIRm7R1Y6b
         CIXKOdUV0dOVeAdK7dd9Xd8QxPupqVUrnO62TMmON4CzYNchuUq96J4t282qDgQqqPKQ
         jNkF60rbsTy2bP1KUzb7PXNKLStMZ0r/wjk3K7r9zRPbSeeXeiDCejSek0aLhmSCo8Vm
         0Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586696; x=1690178696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BWbcO1nwvpd6S1p5aHK6YNqJsjh6u2uTKVKHyBrc6U=;
        b=Pk+UgZ7rzY8B1GXPpyXaILEYsLVsCj0eRgxGsrDm/RI1GaQcJSe2Q6c6gtmOfnePep
         inho86jeRQpJw9y6BAxy0asuPC0WaSyM/vBoW2aYu/COmRItO4d+tZCxcH5qhmfPOxla
         fA52RbqzBTWpr2ElIdlo6eArEmuhdLQIyI9QFOmJKtIxYeXTs8flbF3MRrf9RM4tNYJs
         m3x2C0E9DiKJkZI9BDKGEu1EGv/KNRKXAaEJpDpxg3WlHooq+6ObiD0b3IpLrTiJbI99
         42x8UhTFNcliXUBz3qYtJBJF7bzWn94+ZAC76hUk9yyxjUvAd4lsQ1kjH23zlQrBL55t
         FW0g==
X-Gm-Message-State: AC+VfDz6jzRpV1RqhhzMin9wyPSDx4YGSSFDOjM7qBwtHDDy3+8tjiA7
        3g2KEs1isRUNl8UnSFeVEuZhyaDrkl0=
X-Google-Smtp-Source: ACHHUZ7be3ZRgN7ScfoKn8GtZlHQKSPn4jcQARRkgRHFYt1lBd1H8O8ZdujY0N/htmY1NI/zWgY0gQ==
X-Received: by 2002:a17:906:64cc:b0:987:115d:ba05 with SMTP id p12-20020a17090664cc00b00987115dba05mr18950034ejn.3.1687586695801;
        Fri, 23 Jun 2023 23:04:55 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709065f8200b009827b97c89csm501286eju.102.2023.06.23.23.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:04:54 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:04:52 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] staging: rtl8192e: Remove variable ieee->short_slot
Message-ID: <74fe53ccfafe2e0e18319b5502ed83544cc3ffd8.1687583718.git.philipp.g.hortmann@gmail.com>
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

ieee->short_slot also named priv->rtllib->short_slot is initialized to 1
and then unchanged. All evaluations will result accordingly. Remove
resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  1 -
 drivers/staging/rtl8192e/rtllib.h            |  1 -
 drivers/staging/rtl8192e/rtllib_softmac.c    | 10 +++-------
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index a24527585166..aaff8d739efe 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -774,7 +774,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->retry_data = DEFAULT_RETRY_DATA;
 	priv->rtllib->rts = DEFAULT_RTS_THRESHOLD;
 	priv->rtllib->rate = 110;
-	priv->rtllib->short_slot = 1;
 	priv->promisc = (dev->flags & IFF_PROMISC) ? 1 : 0;
 	priv->bcck_in_ch14 = false;
 	priv->cck_present_attn = 0;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c7f800a0c48c..aa8abec390ca 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1486,7 +1486,6 @@ struct rtllib_device {
 
 	enum rtl_link_state link_state;
 
-	int short_slot;
 	int mode;       /* A, B, G */
 
 	/* used for forcing the ibss workqueue to terminate
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 23b33a239703..584371f0ce57 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -852,8 +852,7 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 		cpu_to_le16(ieee->current_network.capability &
 		WLAN_CAPABILITY_SHORT_PREAMBLE);
 
-	if (ieee->short_slot && (ieee->current_network.capability &
-	    WLAN_CAPABILITY_SHORT_SLOT_TIME))
+	if (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_SLOT_TIME)
 		beacon_buf->capability |=
 			cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME);
 
@@ -939,9 +938,7 @@ static struct sk_buff *rtllib_assoc_resp(struct rtllib_device *ieee, u8 *dest)
 	assoc->capability = cpu_to_le16(ieee->iw_mode == IW_MODE_MASTER ?
 		WLAN_CAPABILITY_ESS : WLAN_CAPABILITY_IBSS);
 
-	if (ieee->short_slot)
-		assoc->capability |=
-				 cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME);
+	assoc->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME);
 
 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
 
@@ -1190,8 +1187,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 	if (beacon->capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_PREAMBLE);
 
-	if (ieee->short_slot &&
-	   (beacon->capability & WLAN_CAPABILITY_SHORT_SLOT_TIME))
+	if (beacon->capability & WLAN_CAPABILITY_SHORT_SLOT_TIME)
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME);
 
 	hdr->listen_interval = cpu_to_le16(beacon->listen_interval);
-- 
2.41.0

