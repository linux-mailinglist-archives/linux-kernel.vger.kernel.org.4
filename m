Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68BF6C7252
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjCWV2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjCWV2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:28:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903D8C15B;
        Thu, 23 Mar 2023 14:28:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so1915547wmq.2;
        Thu, 23 Mar 2023 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679606909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7olDEZj2IoK6mcnBuC6KcKeS7EuQQGPTEkBoGsEMOA=;
        b=hqPAeqIAvGtnsajTCpRYvyLpXbSqTCDRHPhITj4F2+krEOR8BCMF5+bEw6WzyepCtj
         qlKSJ5LY9LbYy3Gzriz+jfYn0ZR8wwBpCgv2S35WN+Frj+j94COfQ1QbCqME98CMHvkM
         BF2IPgHkLhwjdkJ5DAbPpccMrMlwxnHws7tXYvojI0axlLlbTUdCcA+Nol7h4RM2CxqQ
         ZfB3K9QIq9Cr8fCue6/JBXXxYPDdL8rZiaa8ahn4368VpojZShf/3CDMIR5ZUvPoUMgi
         tc18uzuE2UV5Ysj2W0hJHoQLEh+W0wApm75rmETarZUx+eSkox5Wo/DKPxf0xAN1lWmR
         CqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679606909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7olDEZj2IoK6mcnBuC6KcKeS7EuQQGPTEkBoGsEMOA=;
        b=fjDSHXo2iIXCvQINAcA07qk+8aRkNLlPmuq9KjbVnZHyB7r4GcJYW3YZT8eFm6td0i
         4I6EugqbNHmUarDZpf6aFomWyUzerPSa4k9BbELysvEIZ99iXM6gABL5ii7jsiIsdFW3
         oGkRgGVHTizJsJbJGzqN0J6Q4oE8NmNehLXJllXj8IR9peXID8E1nvTLKevc53/Wchd0
         Z7I85ZPfhz8+I0hShlgCnYYf4wH8bwrZM8paaXoPNEHAKoQKaGU6VmvoCxmZq5UCAL+p
         ig7FJMrx14OSM2aVganlr/16McewVkmx2nMWK0Nnpsh2OFaNZD9PFcBXAvC19VVbGS6i
         klWw==
X-Gm-Message-State: AO0yUKWyg1Q5lQ8P4QD9OW6qEVeQ7x+xU8WrBt9bqleHTG0BRlepLFzl
        uMZ18rThCXFkQ6FohHYDdyI=
X-Google-Smtp-Source: AK7set/ytjfxIqLhdNMpcWejEElAhLmf5GebJlQSgq1R9s52Miv4UPN1YgQsbIU5x/xC6g6kzRKMXg==
X-Received: by 2002:a7b:c4ce:0:b0:3eb:4162:7344 with SMTP id g14-20020a7bc4ce000000b003eb41627344mr807719wmk.22.1679606908952;
        Thu, 23 Mar 2023 14:28:28 -0700 (PDT)
Received: from localhost.localdomain ([46.211.10.218])
        by smtp.googlemail.com with ESMTPSA id o15-20020a1c750f000000b003ee1acdb036sm3015096wmc.17.2023.03.23.14.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:28:28 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Alejandro=20Gonz=C3=A1lez?= 
        <alejandro.gonzalez.correo@gmail.com>, bruno <bmilreu@gmail.com>,
        renedis <renedis@hotmail.com>
Subject: [PATCH 3/3] hwmon: (nct6775) update ASUS WMI monitoring list B360/H410/H610/Z390...
Date:   Thu, 23 Mar 2023 23:27:51 +0200
Message-Id: <20230323212751.2474-3-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323212751.2474-1-pauk.denis@gmail.com>
References: <20230323212751.2474-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boards such as
* EX-B460M-V5,
* EX-H410M-V3,
* PRIME B360M-D,
* PRIME B360M-K,
* PRIME H410M-A,
* PRIME H410M-D,
* PRIME H410M-E,
* PRIME H410M-F,
* PRIME H410M-K,
* PRIME H410M-K R2.0,
* PRIME H510M-K R2.0,
* PRIME Z390-A,
* PRIME Z390-A/H10,
* PRIME Z390-P,
* PRIME Z390M-PLUS,
* PRIME Z490-A,
* PRIME Z490-P,
* PRIME Z490-V,
* PRIME Z490M-PLUS,
* PRO B460M-C,
* PRO H410M-C,
* ROG MAXIMUS XI APEX,
* ROG MAXIMUS XI CODE,
* ROG MAXIMUS XI EXTREME,
* ROG MAXIMUS XI FORMULA,
* ROG MAXIMUS XI GENE,
* ROG MAXIMUS XI HERO,
* ROG MAXIMUS XI HERO (WI-FI),
* ROG MAXIMUS XII APEX,
* ROG MAXIMUS XII EXTREME,
* ROG MAXIMUS XII FORMULA,
* ROG MAXIMUS XII HERO (WI-FI),
* ROG STRIX B460-F GAMING,
* ROG STRIX B460-G GAMING,
* ROG STRIX B460-H GAMING,
* ROG STRIX B460-I GAMING,
* TUF GAMING B460-PLUS,
* TUF GAMING B460-PRO (WI-FI),
* TUF GAMING B460M-PLUS,
* TUF GAMING B460M-PLUS (WI-FI),
* TUF GAMING B460M-PRO,
* TUF GAMING B550-PLUS (WI-FI),
* TUF GAMING B550M ZAKU (WI-FI),
* TUF Z390-PLUS GAMING,
* TUF Z390-PLUS GAMING (WI-FI),
* TUF Z390-PRO GAMING,
* TUF Z390M-PRO GAMING,
* TUF Z390M-PRO GAMING (WI-FI),
* WS Z390 PRO,
* B560M-P,
* EX-B560M-V5,
* EX-H510M-V3,
* EX-H610M-V3 D4,
* PRIME B560-PLUS,
* PRIME B560-PLUS AC-HES,
* PRIME B560M-A,
* PRIME B560M-A AC,
* PRIME B560M-K,
* PRIME B660-PLUS D4,
* PRIME H510M-A,
* PRIME H510M-A WIFI,
* PRIME H510M-D,
* PRIME H510M-E,
* PRIME H510M-F,
* PRIME H510M-K,
* PRIME H610I-PLUS D4,
* PRIME H610M-A D4,
* PRIME H610M-A WIFI D4,
* PRIME H610M-D D4,
* PRIME H610M-E D4,
* PRIME H610M-F D4,
* PRIME H610M-K D4,
* PRIME Z690-A,
* PRIME Z690-P,
* PRIME Z690-P D4,
* PRIME Z690-P WIFI,
* PRIME Z690-P WIFI D4,
* PRIME Z690M-PLUS D4,
* PRIME Z790-A WIFI,
* PRIME Z790-P,
* PRIME Z790-P D4,
* PRIME Z790-P WIFI,
* PRIME Z790-P WIFI D4,
* PRIME Z790M-PLUS,
* PRIME Z790M-PLUS D4,
* Pro B560M-C,
* Pro B560M-CT,
* Pro H510M-C,
* Pro H510M-CT,
* Pro H610M-C,
* Pro H610M-C D4,
* Pro H610M-CT D4,
* Pro H610T D4,
* ProArt Z690-CREATOR WIFI,
* ROG MAXIMUS Z690 HERO EVA,
* ROG MAXIMUS Z790 APEX,
* ROG MAXIMUS Z790 HERO,
* ROG STRIX B560-A GAMING WIFI,
* ROG STRIX B560-E GAMING WIFI,
* ROG STRIX B560-F GAMING WIFI,
* ROG STRIX B560-G GAMING WIFI,
* ROG STRIX B560-I GAMING WIFI,
* ROG STRIX Z690-A GAMING WIFI,
* ROG STRIX Z690-I GAMING WIFI,
* ROG STRIX Z790-A GAMING WIFI,
* ROG STRIX Z790-A GAMING WIFI D4,
* ROG STRIX Z790-E GAMING WIFI,
* ROG STRIX Z790-F GAMING WIFI,
* ROG STRIX Z790-H GAMING WIFI,
* ROG STRIX Z790-I GAMING WIFI,
* TUF GAMING B560-PLUS WIFI,
* TUF GAMING B560M-E,
* TUF GAMING B560M-PLUS,
* TUF GAMING B560M-PLUS WIFI,
* TUF GAMING Z690-PLUS,
* TUF GAMING Z690-PLUS D4,
* TUF GAMING Z690-PLUS WIFI,
* TUF GAMING Z690-PLUS WIFI D4,
* TUF GAMING Z790-PLUS D4,
* TUF GAMING Z790-PLUS WIFI,
* TUF GAMING Z790-PLUS WIFI D4,
have got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

This commit adds such boards to the WMI monitoring list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Alejandro González <alejandro.gonzalez.correo@gmail.com>
Tested-by: bruno <bmilreu@gmail.com>
Tested-by: renedis <renedis@hotmail.com>
---
 drivers/hwmon/nct6775-platform.c | 121 +++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 9a7ad64c2cc3c..680fa0ecd6c31 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1052,6 +1052,8 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 static struct platform_device *pdev[2];
 
 static const char * const asus_wmi_boards[] = {
+	"EX-B460M-V5",
+	"EX-H410M-V3",
 	"PRIME A520M-A",
 	"PRIME A520M-A II",
 	"PRIME A520M-E",
@@ -1059,6 +1061,8 @@ static const char * const asus_wmi_boards[] = {
 	"PRIME B360-PLUS",
 	"PRIME B360M-A",
 	"PRIME B360M-C",
+	"PRIME B360M-D",
+	"PRIME B360M-K",
 	"PRIME B460-PLUS",
 	"PRIME B460M-A R2.0",
 	"PRIME B550-PLUS",
@@ -1067,9 +1071,26 @@ static const char * const asus_wmi_boards[] = {
 	"PRIME B550M-A AC",
 	"PRIME B550M-A WIFI II",
 	"PRIME B550M-K",
+	"PRIME H410M-A",
+	"PRIME H410M-D",
+	"PRIME H410M-E",
+	"PRIME H410M-F",
+	"PRIME H410M-K",
+	"PRIME H410M-K R2.0",
 	"PRIME H410M-R",
+	"PRIME H510M-K R2.0",
 	"PRIME X570-P",
 	"PRIME X570-PRO",
+	"PRIME Z390-A",
+	"PRIME Z390-A/H10",
+	"PRIME Z390-P",
+	"PRIME Z390M-PLUS",
+	"PRIME Z490-A",
+	"PRIME Z490-P",
+	"PRIME Z490-V",
+	"PRIME Z490M-PLUS",
+	"PRO B460M-C",
+	"PRO H410M-C",
 	"PRO H410T",
 	"Pro A520M-C",
 	"Pro A520M-C II",
@@ -1084,6 +1105,21 @@ static const char * const asus_wmi_boards[] = {
 	"ROG CROSSHAIR VIII HERO",
 	"ROG CROSSHAIR VIII HERO (WI-FI)",
 	"ROG CROSSHAIR VIII IMPACT",
+	"ROG MAXIMUS XI APEX",
+	"ROG MAXIMUS XI CODE",
+	"ROG MAXIMUS XI EXTREME",
+	"ROG MAXIMUS XI FORMULA",
+	"ROG MAXIMUS XI GENE",
+	"ROG MAXIMUS XI HERO",
+	"ROG MAXIMUS XI HERO (WI-FI)",
+	"ROG MAXIMUS XII APEX",
+	"ROG MAXIMUS XII EXTREME",
+	"ROG MAXIMUS XII FORMULA",
+	"ROG MAXIMUS XII HERO (WI-FI)",
+	"ROG STRIX B460-F GAMING",
+	"ROG STRIX B460-G GAMING",
+	"ROG STRIX B460-H GAMING",
+	"ROG STRIX B460-I GAMING",
 	"ROG STRIX B550-A GAMING",
 	"ROG STRIX B550-E GAMING",
 	"ROG STRIX B550-F GAMING",
@@ -1109,9 +1145,16 @@ static const char * const asus_wmi_boards[] = {
 	"TUF GAMING A520M-PLUS",
 	"TUF GAMING A520M-PLUS II",
 	"TUF GAMING A520M-PLUS WIFI",
+	"TUF GAMING B460-PLUS",
+	"TUF GAMING B460-PRO (WI-FI)",
+	"TUF GAMING B460M-PLUS",
+	"TUF GAMING B460M-PLUS (WI-FI)",
+	"TUF GAMING B460M-PRO",
 	"TUF GAMING B550-PLUS",
+	"TUF GAMING B550-PLUS (WI-FI)",
 	"TUF GAMING B550-PLUS WIFI II",
 	"TUF GAMING B550-PRO",
+	"TUF GAMING B550M ZAKU (WI-FI)",
 	"TUF GAMING B550M-E",
 	"TUF GAMING B550M-E WIFI",
 	"TUF GAMING B550M-PLUS",
@@ -1123,12 +1166,27 @@ static const char * const asus_wmi_boards[] = {
 	"TUF GAMING X570-PRO (WI-FI)",
 	"TUF GAMING Z490-PLUS",
 	"TUF GAMING Z490-PLUS (WI-FI)",
+	"TUF Z390-PLUS GAMING",
+	"TUF Z390-PLUS GAMING (WI-FI)",
+	"TUF Z390-PRO GAMING",
+	"TUF Z390M-PRO GAMING",
+	"TUF Z390M-PRO GAMING (WI-FI)",
+	"WS Z390 PRO",
 	"Z490-GUNDAM (WI-FI)",
 };
 
 static const char * const asus_msi_boards[] = {
+	"B560M-P",
+	"EX-B560M-V5",
 	"EX-B660M-V5 D4",
 	"EX-B660M-V5 PRO D4",
+	"EX-H510M-V3",
+	"EX-H610M-V3 D4",
+	"PRIME B560-PLUS",
+	"PRIME B560-PLUS AC-HES",
+	"PRIME B560M-A",
+	"PRIME B560M-A AC",
+	"PRIME B560M-K",
 	"PRIME B650-PLUS",
 	"PRIME B650M-A",
 	"PRIME B650M-A AX",
@@ -1136,8 +1194,22 @@ static const char * const asus_msi_boards[] = {
 	"PRIME B650M-A II",
 	"PRIME B650M-A WIFI",
 	"PRIME B650M-A WIFI II",
+	"PRIME B660-PLUS D4",
 	"PRIME B660M-A D4",
 	"PRIME B660M-A WIFI D4",
+	"PRIME H510M-A",
+	"PRIME H510M-A WIFI",
+	"PRIME H510M-D",
+	"PRIME H510M-E",
+	"PRIME H510M-F",
+	"PRIME H510M-K",
+	"PRIME H610I-PLUS D4",
+	"PRIME H610M-A D4",
+	"PRIME H610M-A WIFI D4",
+	"PRIME H610M-D D4",
+	"PRIME H610M-E D4",
+	"PRIME H610M-F D4",
+	"PRIME H610M-K D4",
 	"PRIME X670-P",
 	"PRIME X670-P WIFI",
 	"PRIME X670E-PRO WIFI",
@@ -1146,13 +1218,35 @@ static const char * const asus_msi_boards[] = {
 	"PRIME Z590-P WIFI",
 	"PRIME Z590-V",
 	"PRIME Z590M-PLUS",
+	"PRIME Z690-A",
+	"PRIME Z690-P",
+	"PRIME Z690-P D4",
+	"PRIME Z690-P WIFI",
+	"PRIME Z690-P WIFI D4",
+	"PRIME Z690M-PLUS D4",
+	"PRIME Z790-A WIFI",
+	"PRIME Z790-P",
+	"PRIME Z790-P D4",
+	"PRIME Z790-P WIFI",
+	"PRIME Z790-P WIFI D4",
+	"PRIME Z790M-PLUS",
+	"PRIME Z790M-PLUS D4",
+	"Pro B560M-C",
+	"Pro B560M-CT",
 	"Pro B660M-C",
 	"Pro B660M-C D4",
+	"Pro H510M-C",
+	"Pro H510M-CT",
+	"Pro H610M-C",
+	"Pro H610M-C D4",
+	"Pro H610M-CT D4",
+	"Pro H610T D4",
 	"Pro WS W680-ACE",
 	"Pro WS W680-ACE IPMI",
 	"ProArt B650-CREATOR",
 	"ProArt B660-CREATOR D4",
 	"ProArt X670E-CREATOR WIFI",
+	"ProArt Z690-CREATOR WIFI",
 	"ProArt Z790-CREATOR WIFI",
 	"ROG CROSSHAIR X670E EXTREME",
 	"ROG CROSSHAIR X670E GENE",
@@ -1164,7 +1258,15 @@ static const char * const asus_msi_boards[] = {
 	"ROG MAXIMUS Z690 APEX",
 	"ROG MAXIMUS Z690 EXTREME",
 	"ROG MAXIMUS Z690 EXTREME GLACIAL",
+	"ROG MAXIMUS Z690 HERO EVA",
+	"ROG MAXIMUS Z790 APEX",
 	"ROG MAXIMUS Z790 EXTREME",
+	"ROG MAXIMUS Z790 HERO",
+	"ROG STRIX B560-A GAMING WIFI",
+	"ROG STRIX B560-E GAMING WIFI",
+	"ROG STRIX B560-F GAMING WIFI",
+	"ROG STRIX B560-G GAMING WIFI",
+	"ROG STRIX B560-I GAMING WIFI",
 	"ROG STRIX B650-A GAMING WIFI",
 	"ROG STRIX B650E-E GAMING WIFI",
 	"ROG STRIX B650E-F GAMING WIFI",
@@ -1183,7 +1285,19 @@ static const char * const asus_msi_boards[] = {
 	"ROG STRIX Z590-E GAMING WIFI",
 	"ROG STRIX Z590-F GAMING WIFI",
 	"ROG STRIX Z590-I GAMING WIFI",
+	"ROG STRIX Z690-A GAMING WIFI",
 	"ROG STRIX Z690-A GAMING WIFI D4",
+	"ROG STRIX Z690-I GAMING WIFI",
+	"ROG STRIX Z790-A GAMING WIFI",
+	"ROG STRIX Z790-A GAMING WIFI D4",
+	"ROG STRIX Z790-E GAMING WIFI",
+	"ROG STRIX Z790-F GAMING WIFI",
+	"ROG STRIX Z790-H GAMING WIFI",
+	"ROG STRIX Z790-I GAMING WIFI",
+	"TUF GAMING B560-PLUS WIFI",
+	"TUF GAMING B560M-E",
+	"TUF GAMING B560M-PLUS",
+	"TUF GAMING B560M-PLUS WIFI",
 	"TUF GAMING B650-PLUS",
 	"TUF GAMING B650-PLUS WIFI",
 	"TUF GAMING B650M-PLUS",
@@ -1195,6 +1309,13 @@ static const char * const asus_msi_boards[] = {
 	"TUF GAMING X670E-PLUS WIFI",
 	"TUF GAMING Z590-PLUS",
 	"TUF GAMING Z590-PLUS WIFI",
+	"TUF GAMING Z690-PLUS",
+	"TUF GAMING Z690-PLUS D4",
+	"TUF GAMING Z690-PLUS WIFI",
+	"TUF GAMING Z690-PLUS WIFI D4",
+	"TUF GAMING Z790-PLUS D4",
+	"TUF GAMING Z790-PLUS WIFI",
+	"TUF GAMING Z790-PLUS WIFI D4",
 	"Z590 WIFI GUNDAM EDITION",
 };
 
-- 
2.39.2

