Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29F55B3F68
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiIITVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiIITVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:21:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D3D13FA5C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:21:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lz22so6280380ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=0D1wBgsx9F9AnTjzgr5f6n/1CVHvs76EQrMPPu7YDgE=;
        b=pM6RpUnExWtZAbqTOYYClAFB/8LMpYfWM+TnBjXKJ/e6B2cDqd9uwVzam+LsWSVsJI
         B1Oc++dG9sfd56NpN+m61dzEOqNBg1NEz2uhcD7Q9cPshJJnb0UwZ6fmLC68iSbKeWQq
         1hYLqtfAJ15QBDudWQ8V7XGXV8CYObwbZ42Ro3FmfKGNEzUynNmKXBkjfCeAkINcX2Vs
         8FfIJj9nqIkInkFEoienRlwSO+mMXs/nkWKD/hJy5iqym+y7v6d/Avx6DJBcQzmTEVn9
         Uh6QHVUlmArkuy0TQ/9adlsC4YjfgWq53SfqkKcZn1pse30PpCndYoEEBgo6kXLj8wRb
         G4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0D1wBgsx9F9AnTjzgr5f6n/1CVHvs76EQrMPPu7YDgE=;
        b=jJY74hqBIP6SkQ3Bezt42VrD6qJKehyYPe+mdg/xVxzv45h/1oY2kV2IJoAKWzAS01
         Nbjj/ZUQ1t6Nnc5UtEM1WNaMvDoWhSQyOuWY/Lb+Qwn2hUdVBfa0TLmxdTls38m7mzZR
         86YMUUMumqqIVAa7oS45SQNsS5RCTBwOiO9usgpUu44rmqt7Rh2brLOoaQpibRgc4n7s
         hw4EIWZ4RGtOdsZY0Pjrbv1kJVqK5pE5CErziJt7+0F1yCMdzb3ZZ2ZfSSuO6//lXQa8
         QZZcxS1X73z9fK8kstcVuGiB/9hBgej7VGiTUVO49eULv3+MkoDFRHoL6Ucs/Hs50MKq
         BF2w==
X-Gm-Message-State: ACgBeo1mu3rZxEpC4D4HnGMfKjmFcJdNdmC6oRBgm4gMD8V3m6a28vFI
        sVdM2WJPf5aMf5Ik03Ilp49qJ1cOAPs=
X-Google-Smtp-Source: AA6agR4t3JQdOKpFxtvHbeoFXjAZupRP7qJfv1u3v30N4LX6zUzWalLHyyPsk5gAoPATdbtHsspI/A==
X-Received: by 2002:a17:907:808:b0:730:54cc:b597 with SMTP id wv8-20020a170907080800b0073054ccb597mr10712550ejb.434.1662751282520;
        Fri, 09 Sep 2022 12:21:22 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090609ca00b00728f6d4d0d7sm664295eje.67.2022.09.09.12.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:21:22 -0700 (PDT)
Date:   Fri, 9 Sep 2022 21:21:20 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: rtl8192e: Rename bConnectBySSID
Message-ID: <2b193be93598348994b1f890b6dc5c2ffb84a9b6.1662402870.git.philipp.g.hortmann@gmail.com>
References: <cover.1662402870.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662402870.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable bConnectBySSID to connect_by_ssid to avoid CamelCase which
is not accepted by checkpatch.pl.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index e904a8704e5d..b1f5a63790c8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -138,7 +138,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = priv->rtllib;
 	bool action_allowed = false;
-	bool			bConnectBySSID = false;
+	bool connect_by_ssid = false;
 	enum rt_rf_power_state rtState;
 	u16			RFWaitCounter = 0;
 	unsigned long flag;
@@ -181,7 +181,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 
 			if (rtState == eRfOff &&
 			    change_source >= RF_CHANGE_BY_HW)
-				bConnectBySSID = true;
+				connect_by_ssid = true;
 		}
 		break;
 
@@ -217,7 +217,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 	if (action_allowed) {
 		rtl92e_set_rf_power_state(dev, state_to_set);
 		if (state_to_set == eRfOn) {
-			if (bConnectBySSID && priv->blinked_ingpio) {
+			if (connect_by_ssid && priv->blinked_ingpio) {
 				schedule_delayed_work(
 					 &ieee->associate_procedure_wq, 0);
 				priv->blinked_ingpio = false;
-- 
2.37.2

