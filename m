Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF376D29F6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjCaV2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjCaV2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:28:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34A122EA3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:28:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn12so94887848edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680298086; x=1682890086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9uZA67W0J8w9CI902YQgQUJeWdtlUq1O49C7+5+Pz8=;
        b=U1nS8FwPD58ih3N7LbDn1tTS+raRgE8DI4T3z1JbCUvgfuCM4RlncHg2TlsQtQHCMI
         gr0qGfXdxErOiVLueD7Z1YE6Bx45IodE6fual4LiKeQp4DpkQgEr841oLAmpV9tuYC2Y
         LKfDo5F5mx/+CTj9S4WdpE1EkuF60X9ivDz2XbTvsEY6IrRXLa9ExRvlfaTPbLe8PopN
         KYsaQ5EGe8N3eJO2pR7VaS6XzOxAS6YNqKCYmtRg9dOP5NW3i28mTJB4gJiqIRD8SH4L
         fNpqrnUEVU+4f9Pm5yeqLJZaLCnhMh8YofkYZaeD1tQfLRWMM7goBLLTtPrAiT5oGiMP
         nSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680298086; x=1682890086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9uZA67W0J8w9CI902YQgQUJeWdtlUq1O49C7+5+Pz8=;
        b=Qsqk+IyfxZOaBMiVYXElLdAynkRRIrOYVQ8OhgnpgVWnarV0bSb/qTFkal8VDLPWtz
         DJNZpokWtYdNBIsu7Ghv3KEmCrxve1Zv08d+DOiFfNL3+g/KPQ7BptgB5ED1653Lw61P
         SFo8pIYSWiQ8qdpUOGco0jDONp7Vol+vJ0r25FUV3dpg3pwf0GGhDvPE75ohbXlb1d0t
         26oAF3XPL9szgasL4UsOCz10emOG0JaoA2EP855girYXoWbh9XINqJpYk3HfHSBqMKxS
         nQLbcOMT3v0ZZUCYiCYKpDg3uFOCoIn1RGzxExEKBvMkqi1nasnqhthst7tkDtcGBk47
         LREQ==
X-Gm-Message-State: AAQBX9egBksft0S93E1tiZM1bvazQCRLSZLtp2IPElSk+HNqMdGL+zsb
        NdN+WHLuBUWIW+OgpfSpbNk=
X-Google-Smtp-Source: AKy350a+9GIqV36l6mzsxYJ2WdxKzCqvhSjUnkPcecT7weya6li6mBC9FORXKpZOY/0nu4jkxr9OrQ==
X-Received: by 2002:a17:906:15c:b0:8f5:14ab:94bc with SMTP id 28-20020a170906015c00b008f514ab94bcmr24544306ejh.6.1680298086210;
        Fri, 31 Mar 2023 14:28:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id tq24-20020a170907c51800b00947abb70c93sm1092989ejc.112.2023.03.31.14.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:28:05 -0700 (PDT)
Date:   Fri, 31 Mar 2023 23:28:03 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] staging: rtl8192e: Remove enum RF_1T2R
Message-ID: <97fef03c12dbc619aab749867fa20686af2b8e3b.1680297150.git.philipp.g.hortmann@gmail.com>
References: <cover.1680297150.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680297150.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enum RF_1T2R is used to initialize a local variable that is then shifted.
The result of the shift is zero. Remove code that has always the same
result to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 3 +--
 drivers/staging/rtl8192e/rtllib.h          | 4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index b5f4d0230da7..2100d9d4e940 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -531,8 +531,7 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	priv->rtllib->bdynamic_txpower_enable = false;
 
 	powerlevelOFDM24G = priv->pwr_track >> 24;
-	RF_Type = RF_1T2R;
-	Value = (RF_Type<<8) | powerlevelOFDM24G;
+	Value = powerlevelOFDM24G;
 
 	for (j = 0; j <= 30; j++) {
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 197c0a44ebd6..7d83a4c322cf 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -433,10 +433,6 @@ enum led_ctl_mode {
 	LED_CTL_START_TO_LINK = 8,
 };
 
-enum rt_rf_type_def {
-	RF_1T2R = 0,
-};
-
 enum wireless_mode {
 	WIRELESS_MODE_UNKNOWN = 0x00,
 	WIRELESS_MODE_A = 0x01,
-- 
2.40.0

