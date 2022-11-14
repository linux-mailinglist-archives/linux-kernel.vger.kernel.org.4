Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501C4628B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbiKNVpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiKNVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:45:29 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B013192BA;
        Mon, 14 Nov 2022 13:45:28 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id x21so15085041ljg.10;
        Mon, 14 Nov 2022 13:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CoX/dfYn+hJHhQDyWytvdq/n3uDVXQmz8Iqx+UWmZCA=;
        b=FdyZpjENquWr3s7SjaD4oRUkLQA7i497azNAQPMHGAablSWj6vYAkoXeD0EmuIEGGF
         AcDEYaCsiFN7n/RW5Wsoj4sXFeGL1Yl92bPxuJ4NRl+qHL1ookVWAmIepxvuHxd/aU+U
         ndRQKs+jqXkie0WPKtyo9OE0N29qLjsNs33ii/U3y9qjM7Q0g4D3xc4bYlHdc+BxPN2w
         AQF5zO3lFdAJYb5gaeqE0WsOcA/CKgc28lDvrT2RSbCaLM12BfaHTE1AcJt1O8qDZcSp
         Y94pbDrqC4MyBlMUB1Vzf2ohUXZwC99WlwyFcybnVTR/0uCEJSyC7xd1i91bo51na2fJ
         sbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoX/dfYn+hJHhQDyWytvdq/n3uDVXQmz8Iqx+UWmZCA=;
        b=1pI11kB6XTGRhFuYByHUOqPkYuBRb5TfKYcyGUJ4az+0BiKyJTVCGavbvcJ+ybr0tM
         2tvxAin3YOpqNAzR13f+nnAeBJfuTCORz83k8txZKymAmyoZ7tu7eQXqHpPgkaPwPEkK
         4gPRY0ddz4ig+XhLiISTQ0fwvm9wr/fpJHTlz+uoNUFCl8JIcv/Pvtnvob837zJF8b8f
         vF5HVWi5A6rTYTDU7dVDTzdbTujMu1IVeY3LFFkKnUOJIFSRSx8eYLl51fw4jeYkFAsL
         4zzKN0Lrl7NVj4rdhREWUV9gmDNitjC4IklQNaHZRYil9aZi4S0w/GYRsdC+EEF5TmWc
         fD7A==
X-Gm-Message-State: ANoB5pn1OtYiJz6mNsQyLzf1HR8fxzs2Ic5Ruua5xwm41qrdWs8udqtN
        pQdEZV7C2Dg6o7kMw6QSm674pilMIww=
X-Google-Smtp-Source: AA0mqf7/HwxMY9FmXhOstn1//XF5AEeg6+KsWTfP0tsmePjJh9ZXNeGQxWTZadvGAXDrDVBl2+M75g==
X-Received: by 2002:a2e:9b84:0:b0:277:665c:eb4c with SMTP id z4-20020a2e9b84000000b00277665ceb4cmr4712593lji.287.1668462326764;
        Mon, 14 Nov 2022 13:45:26 -0800 (PST)
Received: from localhost.localdomain ([46.211.249.14])
        by smtp.googlemail.com with ESMTPSA id t12-20020a05651c204c00b00277041268absm2177058ljo.78.2022.11.14.13.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:45:26 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, pauk.denis@gmail.com,
        mundanedefoliation@gmail.com
Subject: [PATCH] hwmon: (nct6775) add ASUS CROSSHAIR VIII/TUF/ProArt B550M
Date:   Mon, 14 Nov 2022 23:44:56 +0200
Message-Id: <20221114214456.3891-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boards such as
* ProArt B550-CREATOR
* ProArt Z490-CREATOR 10G
* ROG CROSSHAIR VIII EXTREME
* ROG CROSSHAIR VIII HERO (WI-FI)
* TUF GAMING B550M-E
* TUF GAMING B550M-E (WI-FI)
* TUF GAMING B550M-PLUS WIFI II
have got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

This commit adds such boards to the WMI monitoring list.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Reported-by: yutesdb <mundanedefoliation@gmail.com>
Tested-by: yutesdb <mundanedefoliation@gmail.com>
---
 drivers/hwmon/nct6775-platform.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 41c97cfacfb8..50fe9533cf43 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1043,7 +1043,9 @@ static struct platform_device *pdev[2];
 
 static const char * const asus_wmi_boards[] = {
 	"PRO H410T",
+	"ProArt B550-CREATOR",
 	"ProArt X570-CREATOR WIFI",
+	"ProArt Z490-CREATOR 10G",
 	"Pro B550M-C",
 	"Pro WS X570-ACE",
 	"PRIME B360-PLUS",
@@ -1055,8 +1057,10 @@ static const char * const asus_wmi_boards[] = {
 	"PRIME X570-P",
 	"PRIME X570-PRO",
 	"ROG CROSSHAIR VIII DARK HERO",
+	"ROG CROSSHAIR VIII EXTREME",
 	"ROG CROSSHAIR VIII FORMULA",
 	"ROG CROSSHAIR VIII HERO",
+	"ROG CROSSHAIR VIII HERO (WI-FI)",
 	"ROG CROSSHAIR VIII IMPACT",
 	"ROG STRIX B550-A GAMING",
 	"ROG STRIX B550-E GAMING",
@@ -1080,8 +1084,11 @@ static const char * const asus_wmi_boards[] = {
 	"ROG STRIX Z490-G GAMING (WI-FI)",
 	"ROG STRIX Z490-H GAMING",
 	"ROG STRIX Z490-I GAMING",
+	"TUF GAMING B550M-E",
+	"TUF GAMING B550M-E (WI-FI)",
 	"TUF GAMING B550M-PLUS",
 	"TUF GAMING B550M-PLUS (WI-FI)",
+	"TUF GAMING B550M-PLUS WIFI II",
 	"TUF GAMING B550-PLUS",
 	"TUF GAMING B550-PLUS WIFI II",
 	"TUF GAMING B550-PRO",
-- 
2.36.1

