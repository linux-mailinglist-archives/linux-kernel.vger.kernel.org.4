Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7E368AFDB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 14:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjBENIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 08:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBENIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 08:08:14 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44531F5FF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 05:08:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l12so306337edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 05:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDLxI4fpTDTmEI4qnM+uL8XIXglzEjq5nSIL0bjIDLo=;
        b=ci3bWc23frclFm9mFh/FFC9McKZJpWiGMUOa1XGn9GfJUSSISMbeGeDyQYXmbOEwhH
         ed+rXxN1EyWFqhNGB2Uce+FakwGgIKEHsEW65OeuDI77gjbfI8pMPXreVu+F5+jWk/cK
         DouPMTi3TjFYXY/4ZAy+xxx565ypbvcG+MlyGl8nLj0WThcTA9ls1gZKStEHIrGVrmBq
         SjSlMxGbu0Ao0CkK8BWKnrf+McX4EyweOiWW2YF2+Lke2RptfLU72xcWVrO9pBF2cOXZ
         e4Cz1DowAM57HR2zqSPoEOzsd9VtY4k9xtYO+KY2x84AfT0+zq/BPyYD8QS3PNGwVGVV
         PQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDLxI4fpTDTmEI4qnM+uL8XIXglzEjq5nSIL0bjIDLo=;
        b=17aNXh3eph2E5VCCnJcx+X0kcxSSKNVvqFDjZu7M0h5vTh+RVEoeL0oI5XRGcQfXZz
         7AO/QywTiY2xiF1BnuHKtF8VqvGIyQt+zDrf6kx6pd7N9eTByAvl2e1/g6jBIJj85k2A
         MHBqSScn9TK8DfQWgAO2BcruRorB2nb8FJFEXfFXcl2HXWLU+k87ofOJhMjWlC1VHgJQ
         mCR3rv4lYxdXQRuj/VMzdDVXwyDpe46wCoc//QRPyQASjCZJRZINpEq7aAIQ+Cq9T8+c
         7dnbuI9AJmx3mzC9kQJAZLi35pRQn6VYWq7wcIWjg4fzVJFxdU+B+KufWmgwiC1kXlyW
         Ad/g==
X-Gm-Message-State: AO0yUKXfViJnIUQ5C6o2U3Gxg6RvpjtrMgo55cnGHEFA8AyjrjAih432
        raJZQS4Jse737xS+fUaZlFeYsu6Zv4E=
X-Google-Smtp-Source: AK7set/IJcGeqAYiBrIfoQWphmoP9Q59R+3UFGAOjal0ryJ8Jbiq5ISi436jjglfFLv6uv+3S8G9Wg==
X-Received: by 2002:a50:9304:0:b0:4a2:7489:a70a with SMTP id m4-20020a509304000000b004a27489a70amr18098803eda.22.1675602485029;
        Sun, 05 Feb 2023 05:08:05 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id b15-20020a509f0f000000b004aaa3c872d0sm1748175edf.87.2023.02.05.05.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 05:08:04 -0800 (PST)
Date:   Sun, 5 Feb 2023 14:08:02 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: vt6655: Macro with braces issue change to inline
 function
Message-ID: <Y9+qMqYD2zGWRurD@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
as '(iobase)' to avoid precedence issues"

---
Changes in v3:
	- Whitespace error from checkpatch fixed

Changes in v2:
	- Macros with one statement that is to call 'iowrite8' function changed
	to inline function as reviewed by gregkh@linuxfoundation.org.
	In relation to this, names of the callers of macro are also modified
	to call this function.

Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
---
 drivers/staging/vt6655/card.c    | 3 +--
 drivers/staging/vt6655/channel.c | 2 +-
 drivers/staging/vt6655/mac.h     | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index a6ff496b01b6..d2d122dc16d8 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -643,8 +643,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 				   &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_72);
 	/* Set to Page0 */
-        vt6655_mac_select_page0(priv->port_offset);
-
+	vt6655_mac_select_page0(priv->port_offset);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index e9a44bcebe32..60b445c38424 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -121,7 +121,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWRCCK);
 		RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
 		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWROFDM);
-	        vt6655_mac_select_page0(priv->port_offset);
+		vt6655_mac_select_page0(priv->port_offset);
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 	}
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index b9a7ca0fe604..ae3064303691 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -539,12 +539,12 @@
 
 static inline void vt6655_mac_select_page0(void __iomem *iobase)
 {
-        iowrite8(0, iobase + MAC_REG_PAGE1SEL);
+	iowrite8(0, iobase + MAC_REG_PAGE1SEL);
 }
 
 static inline void  vt6655_mac_select_page1(void __iomem *iobase)
 {
-        iowrite8(1, iobase + MAC_REG_PAGE1SEL);
+	iowrite8(1, iobase + MAC_REG_PAGE1SEL);
 }
 
 #define MAKEWORD(lb, hb) \
-- 
2.34.1


-- 
Thanks & Regards,
Guru
