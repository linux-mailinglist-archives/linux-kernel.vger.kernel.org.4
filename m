Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF696BC024
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjCOWwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCOWwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:52:32 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183B591D8;
        Wed, 15 Mar 2023 15:51:57 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h9so21087173ljq.2;
        Wed, 15 Mar 2023 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678920711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRAxQ44/xEha2xjWe0KQcS5iudbixD7wXTc+nBeJq0k=;
        b=R9FtGSo5kh/ru5IcdulU22LTXr+vuqLWwfZpHQ0wYrBGmEtQjowK1Pv2waw9jCda+t
         ea4n/W7iKN4WKkAQNYuLWPwuOG6foMzcD6YMLCKvUzMyVsa0EtkrYkPsNwmckKVeK4WJ
         dwx0UaHi4ZLfFUyLqAUpyKMt124m7FwU4LeP3gPIudZGI+7sA2jtE+zcaPRv1akEXQ3V
         gzycAaKJcUm8f2mBOSf6iacSe0oEabTPilbUlJharI9y2r34//AEK+zZ9qiuwRHcNMZH
         p0fWKtmqut4pWdLyGAL3RXMmImzTrRSOvqJmE1xgnVAZjH3Q1bKYbjTxT5EnzadSr7Z2
         +RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678920711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRAxQ44/xEha2xjWe0KQcS5iudbixD7wXTc+nBeJq0k=;
        b=MmrzbtN51W2Mdf2utHuR8OULHYINeT9qU4ZjvXpVR8QsaALOBEIqu84chkjYn+CPtg
         UYOzs0764ihzoZknBa5QZr0zkHCKTMiQhIkT/4zXA7N4uSW3LVeRs/+lCqkSi9LRnj4l
         7c+FR69vQCUmf3nSYLBCqq86D7PVsl49mFV4rigbAmZwkD5E9bpTx34tmf87EG/0R4l/
         JFTC2dXlGUN/a1fT1XdZRL9g6w3+tXmeyEaz1jh6WRZCFQ1YrNK8ZWIA2xC2DXK+l9He
         3diGyVNnN0gPpsKnly3RHpISYpUgUrkyHBvzeXml1bdEsRns9c0LFKw7G8jENIjpgRBE
         3CvA==
X-Gm-Message-State: AO0yUKWWqsVXsYw2uN1AEuXbz8PQUNAvmVkGqFssHwPxSwESYRhKmI0a
        CHd0xGv+pKFEc4PO5pm4pnI=
X-Google-Smtp-Source: AK7set8MBg80yoMbCikXcU7UUzOvdz+moNHgcLpLOrtwKUGCX+berfCaQ1F8DFajDjaTuNztX/D6qA==
X-Received: by 2002:a05:651c:19a4:b0:293:a444:f70f with SMTP id bx36-20020a05651c19a400b00293a444f70fmr1976749ljb.33.1678920711090;
        Wed, 15 Mar 2023 15:51:51 -0700 (PDT)
Received: from localhost.localdomain ([46.211.236.70])
        by smtp.googlemail.com with ESMTPSA id a1-20020a2e9801000000b00293534d9760sm1023803ljj.127.2023.03.15.15.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:51:50 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, pauk.denis@gmail.com,
        mischief@offblast.org, de99like@mennucci.debian.net
Subject: [PATCH v3] hwmon: (nct6775) update ASUS WMI monitoring list A520/B360/B460/B550...
Date:   Thu, 16 Mar 2023 00:51:28 +0200
Message-Id: <20230315225128.1236-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
Changes:
v3: cleanup list Tested-by and Signed-off-by headers
v2: remove already added "Pro A520M-C II" from patch
---

 drivers/hwmon/nct6775-platform.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 02e9241a98bf0..2db71b62e03d4 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1052,6 +1052,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 static struct platform_device *pdev[2];
 
 static const char * const asus_wmi_boards[] = {
+	"Pro A520M-C",
 	"Pro A520M-C II",
 	"PRO H410T",
 	"ProArt B550-CREATOR",
@@ -1059,11 +1060,21 @@ static const char * const asus_wmi_boards[] = {
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
@@ -1095,6 +1106,9 @@ static const char * const asus_wmi_boards[] = {
 	"ROG STRIX Z490-G GAMING (WI-FI)",
 	"ROG STRIX Z490-H GAMING",
 	"ROG STRIX Z490-I GAMING",
+	"TUF GAMING A520M-PLUS",
+	"TUF GAMING A520M-PLUS II",
+	"TUF GAMING A520M-PLUS WIFI",
 	"TUF GAMING B550M-E",
 	"TUF GAMING B550M-E WIFI",
 	"TUF GAMING B550M-PLUS",
@@ -1105,16 +1119,20 @@ static const char * const asus_wmi_boards[] = {
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
@@ -1125,20 +1143,33 @@ static const char * const asus_msi_boards[] = {
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
@@ -1147,16 +1178,24 @@ static const char * const asus_msi_boards[] = {
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

