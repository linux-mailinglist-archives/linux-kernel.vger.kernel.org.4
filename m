Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4906BBE73
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjCOVDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjCOVDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:03:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A88A3B4C;
        Wed, 15 Mar 2023 14:02:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o8so5949648lfo.0;
        Wed, 15 Mar 2023 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678914115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1/N9Cqr3ApDu4tfUrZr2c43GRU0UQ/EvExfd9NX1gg=;
        b=JzX1vlRwRB3aQPw/M3VJsZCam1nbwd2RkoVV/ooVJy36to03OiCWt+rZZ46BGXY206
         j9t2U4F9FMJnGv7n29RrmNwemHmrPdH3yPx6CxkR0NrJ0FOrjV8+gC3fWfWZEJj87qY3
         agcVe1Rfpsc/ascWIGfuq/IwN+fteEwwt+Uy7EkJNpEbKRSNF8gVy0+UGS5WcW0jog96
         fXUX2/oYtYVxaSbhjsCTDRG/9zc45lbC5HPRffd+Tv/j0mFoeaAIX664omP3b0JgPren
         2+oGOd/rZRYV1Zy/Hk/pKUmJn6blH4o4JOSkyBKc9j06u1aZPBirjwuiE2YjXTfOF3Bm
         URTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678914115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1/N9Cqr3ApDu4tfUrZr2c43GRU0UQ/EvExfd9NX1gg=;
        b=N+HkPgZCjb7hRqPtdC4qWfpcqOYQp8jhL3VGvFVgdgzfyuY+x7diSQk53URRKqCjAq
         r4tw+fyA2hIu2YMo3vk9bQJaNVG/5JPvos3tT0HK+z9+VziA+7miqOvohf1ZOL3j02oA
         kJBG6dKBtkopr9C+igxanl+h+CRKcWpqStbpMMQcsWPqPAmwcJkMLG/oYMnxnS+H3n10
         Z8Q0ovT/SghnXJTeUuYHXchn9gwb9gi+uLWaWB2AQZlTxseuG5+IgsDkyb/CBz6IQoPz
         iMiixt5RULVJXWa5XgVdPixJ43Ruf1WsS02N3YPCvuDs1LEg5HAmotORCodE8L/jaSKd
         s+HA==
X-Gm-Message-State: AO0yUKV8LkCK59YnO0+mZ+GdBp0RsW0W78JGnRQnbA12Ff6suqXSM0Mt
        MQlTJP9S2xIyVsx7vg8PFg0=
X-Google-Smtp-Source: AK7set8R+SaDA5YTU0raRklY+UuNB+SnmwaVBfVXe7NuxC9p4p0LkTQiCWGAU4y4iVskpnK+YJvuIA==
X-Received: by 2002:ac2:5fd0:0:b0:4e8:3ea0:cf37 with SMTP id q16-20020ac25fd0000000b004e83ea0cf37mr2607704lfg.34.1678914115644;
        Wed, 15 Mar 2023 14:01:55 -0700 (PDT)
Received: from localhost.localdomain ([46.211.236.75])
        by smtp.googlemail.com with ESMTPSA id p17-20020a05651238d100b0047f7722b73csm936396lft.142.2023.03.15.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:01:55 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, pauk.denis@gmail.com,
        mischief@offblast.org, de99like@mennucci.debian.net
Subject: [PATCH 2/2] hwmon: (nct6775) update ASUS WMI monitoring list A520/B360/B460/B550...
Date:   Wed, 15 Mar 2023 23:01:35 +0200
Message-Id: <20230315210135.2155-2-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315210135.2155-1-pauk.denis@gmail.com>
References: <20230315210135.2155-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boards such as
* EX-B660M-V5 D4,
* PRIME A520M-A,
* PRIME A520M-A II,
* PRIME A520M-E,
* PRIME A520M-K,
* PRIME B360M-A,
* PRIME B360M-C,
* PRIME B460M-A R2.0,
* PRIME B550M-A AC,
* PRIME B550M-A WIFI II,
* PRIME B550M-K,
* PRIME B650M-A AX II,
* PRIME Z590-P WIFI,
* PRIME Z590-V,
* Pro A520M-C,
* Pro A520M-C II,
* ProArt B650-CREATOR,
* ProArt Z790-CREATOR WIFI,
* Pro B660M-C,
* Pro WS W680-ACE,
* Pro WS W680-ACE IPMI,
* ROG MAXIMUS XIII APEX,
* ROG MAXIMUS XIII EXTREME,
* ROG MAXIMUS XIII HERO,
* ROG MAXIMUS Z690 APEX,
* ROG MAXIMUS Z790 EXTREME,
* ROG STRIX B660-A GAMING WIFI,
* ROG STRIX Z590-A GAMING WIFI,
* ROG STRIX Z590-E GAMING WIFI,
* ROG STRIX Z590-F GAMING WIFI,
* ROG STRIX Z590-I GAMING WIFI,
* TUF GAMING A520M-PLUS,
* TUF GAMING A520M-PLUS II,
* TUF GAMING A520M-PLUS WIFI,
* TUF GAMING B660M-E D4,
* TUF GAMING B660-PLUS WIFI D4,
* TUF GAMING X570-PLUS_BR,
* TUF GAMING Z590-PLUS,
* Z490-GUNDAM (WI-FI),
* Z590 WIFI GUNDAM EDITION
have got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

This commit adds such boards to the WMI monitoring list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Nick Owens <mischief@offblast.org>
Tested-by: A. M. <de99like@mennucci.debian.net>
---
 drivers/hwmon/nct6775-platform.c | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 0ded82ac7fd31..2c1a47e756bf3 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1058,14 +1058,26 @@ static const char * const asus_wmi_boards[] = {
 	"ProArt Z490-CREATOR 10G",
 	"Pro B550M-C",
 	"Pro WS X570-ACE",
+	"PRIME A520M-A",
+	"PRIME A520M-A II",
+	"PRIME A520M-E",
+	"PRIME A520M-K",
 	"PRIME B360-PLUS",
+	"PRIME B360M-A",
+	"PRIME B360M-C",
 	"PRIME B460-PLUS",
+	"PRIME B460M-A R2.0",
 	"PRIME B550-PLUS",
 	"PRIME B550M-A",
 	"PRIME B550M-A (WI-FI)",
+	"PRIME B550M-A AC",
+	"PRIME B550M-A WIFI II",
+	"PRIME B550M-K",
 	"PRIME H410M-R",
 	"PRIME X570-P",
 	"PRIME X570-PRO",
+	"Pro A520M-C",
+	"Pro A520M-C II",
 	"ROG CROSSHAIR VIII DARK HERO",
 	"ROG CROSSHAIR VIII EXTREME",
 	"ROG CROSSHAIR VIII FORMULA",
@@ -1094,6 +1106,9 @@ static const char * const asus_wmi_boards[] = {
 	"ROG STRIX Z490-G GAMING (WI-FI)",
 	"ROG STRIX Z490-H GAMING",
 	"ROG STRIX Z490-I GAMING",
+	"TUF GAMING A520M-PLUS",
+	"TUF GAMING A520M-PLUS II",
+	"TUF GAMING A520M-PLUS WIFI",
 	"TUF GAMING B550M-E",
 	"TUF GAMING B550M-E WIFI",
 	"TUF GAMING B550M-PLUS",
@@ -1104,16 +1119,20 @@ static const char * const asus_wmi_boards[] = {
 	"TUF GAMING B550-PRO",
 	"TUF GAMING X570-PLUS",
 	"TUF GAMING X570-PLUS (WI-FI)",
+	"TUF GAMING X570-PLUS_BR",
 	"TUF GAMING X570-PRO (WI-FI)",
 	"TUF GAMING Z490-PLUS",
 	"TUF GAMING Z490-PLUS (WI-FI)",
+	"Z490-GUNDAM (WI-FI)",
 };
 
 static const char * const asus_msi_boards[] = {
+	"EX-B660M-V5 D4",
 	"EX-B660M-V5 PRO D4",
 	"PRIME B650-PLUS",
 	"PRIME B650M-A",
 	"PRIME B650M-A AX",
+	"PRIME B650M-A AX II",
 	"PRIME B650M-A II",
 	"PRIME B650M-A WIFI",
 	"PRIME B650M-A WIFI II",
@@ -1124,20 +1143,33 @@ static const char * const asus_msi_boards[] = {
 	"PRIME X670E-PRO WIFI",
 	"PRIME Z590-A",
 	"PRIME Z590-P",
+	"PRIME Z590-P WIFI",
+	"PRIME Z590-V",
 	"PRIME Z590M-PLUS",
+	"Pro B660M-C",
 	"Pro B660M-C-D4",
+	"Pro WS W680-ACE",
+	"Pro WS W680-ACE IPMI",
+	"ProArt B650-CREATOR",
 	"ProArt B660-CREATOR D4",
 	"ProArt X670E-CREATOR WIFI",
+	"ProArt Z790-CREATOR WIFI",
 	"ROG CROSSHAIR X670E EXTREME",
 	"ROG CROSSHAIR X670E GENE",
 	"ROG CROSSHAIR X670E HERO",
+	"ROG MAXIMUS XIII APEX",
+	"ROG MAXIMUS XIII EXTREME",
 	"ROG MAXIMUS XIII EXTREME GLACIAL",
+	"ROG MAXIMUS XIII HERO",
+	"ROG MAXIMUS Z690 APEX",
 	"ROG MAXIMUS Z690 EXTREME",
 	"ROG MAXIMUS Z690 EXTREME GLACIAL",
+	"ROG MAXIMUS Z790 EXTREME",
 	"ROG STRIX B650-A GAMING WIFI",
 	"ROG STRIX B650E-E GAMING WIFI",
 	"ROG STRIX B650E-F GAMING WIFI",
 	"ROG STRIX B650E-I GAMING WIFI",
+	"ROG STRIX B660-A GAMING WIFI",
 	"ROG STRIX B660-A GAMING WIFI D4",
 	"ROG STRIX B660-F GAMING WIFI",
 	"ROG STRIX B660-G GAMING WIFI",
@@ -1146,16 +1178,24 @@ static const char * const asus_msi_boards[] = {
 	"ROG STRIX X670E-E GAMING WIFI",
 	"ROG STRIX X670E-F GAMING WIFI",
 	"ROG STRIX X670E-I GAMING WIFI",
+	"ROG STRIX Z590-A GAMING WIFI",
 	"ROG STRIX Z590-A GAMING WIFI II",
+	"ROG STRIX Z590-E GAMING WIFI",
+	"ROG STRIX Z590-F GAMING WIFI",
+	"ROG STRIX Z590-I GAMING WIFI",
 	"ROG STRIX Z690-A GAMING WIFI D4",
 	"TUF GAMING B650-PLUS",
 	"TUF GAMING B650-PLUS WIFI",
 	"TUF GAMING B650M-PLUS",
 	"TUF GAMING B650M-PLUS WIFI",
+	"TUF GAMING B660-PLUS WIFI D4",
+	"TUF GAMING B660M-E D4",
 	"TUF GAMING B660M-PLUS WIFI",
 	"TUF GAMING X670E-PLUS",
 	"TUF GAMING X670E-PLUS WIFI",
+	"TUF GAMING Z590-PLUS",
 	"TUF GAMING Z590-PLUS WIFI",
+	"Z590 WIFI GUNDAM EDITION",
 };
 
 #if IS_ENABLED(CONFIG_ACPI)
-- 
2.39.2

