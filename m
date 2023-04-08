Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C416DBC1F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 18:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjDHQWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 12:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDHQWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 12:22:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332AACA15;
        Sat,  8 Apr 2023 09:22:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dm2so3445269ejc.8;
        Sat, 08 Apr 2023 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680970965; x=1683562965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AgVuZxzjQ9fJT1qGKbFhaLXLTOGYhUVcvP9PPg+lXXI=;
        b=Vnv37sC8HbDcRvtSvPJPrmV/BuwG7/X51G18bQqm0zQJY+SZMPuOYRSaE11B4Xf3dy
         ScsztWxx0tvlSiVYQwvDE2ZwsPZ/g3zo3SVgxb+os2DzvLdsrlogEwSEBTrdF9Ap5pP3
         +F6xRS0MmKeqOH/NPb4yu96C29IeQFa3mDdprMOHp+T3asC4jthhu3c+1Qgu9KdMPh0K
         Hb2YMcdCk3LqF5pRE6Ea5KfYojAHHNnbCGw1Iy2Nx0OZOL+HONokyvv/n4Sh8ANh+j8j
         znl+UKbTjGTweAkmZqsBem3OtKH2c9nSrNoJsk2NExNpMOC6qaRZHU76gA8mF2xcM75g
         i/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680970965; x=1683562965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgVuZxzjQ9fJT1qGKbFhaLXLTOGYhUVcvP9PPg+lXXI=;
        b=YiZ5eDjUdNaozoXLHzpHPjHWeEL2YOj+G0i8EuAIOV2f0TPko2l3KvD8usn1/vJVM/
         Lrkce731UrnYorhG1bxj+XQYkkiFqrrxA+JHBVxtmYQGEwQ73A2WtCC3bmm2+mKz9mEs
         UpmJShI4PLfFAFW3kDwV6VsREKkPTEa1HNxvRQ6PC+dXQQ3apFFj1IcUPH60807raJw9
         nUAtoz/2stbm9Csyj8VcxrcYD69+tIXi2ib3sHjU6AQs2ec0s/q2o5s1BdWNu5dxLBzp
         3KYWbt27O0pRDLgOadPxQfG/oe1KZzMU5Exnk4f8HFL64O6MSKXUejxyT+kWteLgcida
         yYcA==
X-Gm-Message-State: AAQBX9eBgWCjMlsZVATVZtVYlq3q/QPBHg7OhwJIniC29iTTLIZdpdPF
        so1JHyUlitwB+FscReOKHqQ=
X-Google-Smtp-Source: AKy350YimKjOpROwJM4ECX71ealaqFVG3ydRHR/gwip5OdDXFmFbOC5rpKE87ufpsMwP3rphAI/OVw==
X-Received: by 2002:a17:906:e082:b0:92a:8067:7637 with SMTP id gh2-20020a170906e08200b0092a80677637mr2752555ejb.61.1680970965383;
        Sat, 08 Apr 2023 09:22:45 -0700 (PDT)
Received: from localhost.localdomain ([46.211.233.49])
        by smtp.googlemail.com with ESMTPSA id gg20-20020a170906e29400b008f767c69421sm3273764ejb.44.2023.04.08.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 09:22:44 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, pauk.denis@gmail.com
Subject: [PATCH] hwmon: (nct6775) update ASUS WMI monitoring list A620/B760/W790
Date:   Sat,  8 Apr 2023 19:22:28 +0300
Message-Id: <20230408162228.4291-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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
* B360M-BASALT,
* B360M-D3H,
* EX-B360M-V,
* EX-B360M-V3,
* EX-B360M-V5,
* EX-B760M-V5 D4,
* PRIME A620M-A,
* PRIME B460I-PLUS,
* PRIME B460M-A,
* PRIME B460M-K,
* PRIME B550-PLUS AC-HES,
* PRIME B660M-A AC D4,
* PRIME B760M-A,
* PRIME B760M-A AX D4,
* PRIME B760M-A D4,
* PRIME B760M-AJ D4,
* PRIME B760M-A WIFI,
* PRIME B760M-A WIFI D4,
* PRIME B760M-K D4,
* PRIME B760-PLUS,
* PRIME B760-PLUS D4,
* PRIME H310I-PLUS,
* PRIME H310M-A,
* PRIME H310M-C,
* PRIME H310M-D,
* PRIME H310M-DASH,
* PRIME H310M-E,
* PRIME H310M-E/BR,
* PRIME H310M-F,
* PRIME H310M-K,
* PRIME H310-PLUS,
* PRIME H310T,
* PRIME H370-A,
* PRIME H370M-PLUS,
* PRIME H370-PLUS,
* PRIME H410I-PLUS,
* PRIME H470M-PLUS,
* PRIME H470-PLUS,
* PRIME H510M-R,
* PRIME H510T2/CSM,
* PRIME H570M-PLUS,
* PRIME H570-PLUS,
* PRIME H610M-R D4,
* PRIME H670-PLUS D4,
* PRIME H770-PLUS D4,
* PRIME Q370M-C,
* ProArt B760-CREATOR D4,
* Pro B760M-C,
* Pro B760M-CT,
* PRO Q470M-C,
* Pro Q670M-C,
* Pro WS W790-ACE,
* Pro WS W790E-SAGE SE,
* ROG MAXIMUS Z690 FORMULA,
* ROG MAXIMUS Z690 HERO,
* ROG STRIX B360-F GAMING,
* ROG STRIX B360-G GAMING,
* ROG STRIX B360-H GAMING,
* ROG STRIX B360-H GAMING/OPTANE,
* ROG STRIX B360-I GAMING,
* ROG STRIX B760-A GAMING WIFI,
* ROG STRIX B760-A GAMING WIFI D4,
* ROG STRIX B760-F GAMING WIFI,
* ROG STRIX B760-G GAMING WIFI,
* ROG STRIX B760-G GAMING WIFI D4,
* ROG STRIX B760-I GAMING WIFI,
* ROG STRIX H370-F GAMING,
* ROG STRIX H370-I GAMING,
* ROG STRIX H470-I GAMING,
* ROG STRIX Z690-E GAMING WIFI,
* ROG STRIX Z690-F GAMING WIFI,
* ROG STRIX Z690-G GAMING WIFI,
* TUF B360M-E GAMING,
* TUF B360M-PLUS GAMING,
* TUF B360M-PLUS GAMING/BR,
* TUF B360M-PLUS GAMING S,
* TUF B360-PLUS GAMING,
* TUF B360-PRO GAMING,
* TUF B360-PRO GAMING (WI-FI),
* TUF GAMING A620M-PLUS,
* TUF GAMING A620M-PLUS WIFI,
* TUF GAMING B660M-PLUS D4,
* TUF GAMING B660M-PLUS WIFI D4,
* TUF GAMING B760M-BTF WIFI D4,
* TUF GAMING B760M-E D4,
* TUF GAMING B760M-PLUS,
* TUF GAMING B760M-PLUS D4,
* TUF GAMING B760M-PLUS WIFI,
* TUF GAMING B760M-PLUS WIFI D4,
* TUF GAMING B760-PLUS WIFI,
* TUF GAMING B760-PLUS WIFI D4,
* TUF GAMING H470-PRO,
* TUF GAMING H470-PRO (WI-FI),
* TUF GAMING H570-PRO,
* TUF GAMING H570-PRO WIFI,
* TUF GAMING H670-PRO WIFI D4,
* TUF GAMING H770-PRO WIFI,
* TUF GAMING X570-PRO WIFI II,
* TUF H310M-PLUS GAMING,
* TUF H310M-PLUS GAMING/BR,
* TUF H310-PLUS GAMING,
* TUF H370-PRO GAMING,
* TUF H370-PRO GAMING (WI-FI),
have got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

This commit adds such boards to the WMI monitoring list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>

---
I have checked all boards that ASUS support site has UEFI capsule dumps[1],
such list should cover full list of boards that have nct67xx and support
WMI method for access to the sensor.

List of boards with sensor are based on images on ASUS site (e.g: AMD A620) and
DMI decode results from LinuxHW database.

I suppose that after apply commit, all next changes will be only for new
unreleased series or board name typo's fixes.

Some boards could require nct6799 patch[3], e.g: A620/X670.
Full list of cheked boards on [4].

[1]: https://www.asus.com/motherboards-components/motherboards/all-series
[2]: https://github.com/linuxhw/DMI/tree/master/Desktop/ASUSTek%20Computer
[3]: https://patchwork.kernel.org/project/linux-hwmon/patch/20221228135744.281752-1-linux@roeck-us.net/
[4]: https://github.com/asus-wmi-boards-sensors/asus-board-dsdt#supported-boards
---
 drivers/hwmon/nct6775-platform.c | 103 +++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 680fa0ecd6c31..5782acfb4ee1b 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1052,6 +1052,11 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 static struct platform_device *pdev[2];
 
 static const char * const asus_wmi_boards[] = {
+	"B360M-BASALT",
+	"B360M-D3H",
+	"EX-B360M-V",
+	"EX-B360M-V3",
+	"EX-B360M-V5",
 	"EX-B460M-V5",
 	"EX-H410M-V3",
 	"PRIME A520M-A",
@@ -1064,13 +1069,32 @@ static const char * const asus_wmi_boards[] = {
 	"PRIME B360M-D",
 	"PRIME B360M-K",
 	"PRIME B460-PLUS",
+	"PRIME B460I-PLUS",
+	"PRIME B460M-A",
 	"PRIME B460M-A R2.0",
+	"PRIME B460M-K",
 	"PRIME B550-PLUS",
+	"PRIME B550-PLUS AC-HES",
 	"PRIME B550M-A",
 	"PRIME B550M-A (WI-FI)",
 	"PRIME B550M-A AC",
 	"PRIME B550M-A WIFI II",
 	"PRIME B550M-K",
+	"PRIME H310-PLUS",
+	"PRIME H310I-PLUS",
+	"PRIME H310M-A",
+	"PRIME H310M-C",
+	"PRIME H310M-D",
+	"PRIME H310M-DASH",
+	"PRIME H310M-E",
+	"PRIME H310M-E/BR",
+	"PRIME H310M-F",
+	"PRIME H310M-K",
+	"PRIME H310T",
+	"PRIME H370-A",
+	"PRIME H370-PLUS",
+	"PRIME H370M-PLUS",
+	"PRIME H410I-PLUS",
 	"PRIME H410M-A",
 	"PRIME H410M-D",
 	"PRIME H410M-E",
@@ -1078,7 +1102,10 @@ static const char * const asus_wmi_boards[] = {
 	"PRIME H410M-K",
 	"PRIME H410M-K R2.0",
 	"PRIME H410M-R",
+	"PRIME H470-PLUS",
+	"PRIME H470M-PLUS",
 	"PRIME H510M-K R2.0",
+	"PRIME Q370M-C",
 	"PRIME X570-P",
 	"PRIME X570-PRO",
 	"PRIME Z390-A",
@@ -1092,6 +1119,7 @@ static const char * const asus_wmi_boards[] = {
 	"PRO B460M-C",
 	"PRO H410M-C",
 	"PRO H410T",
+	"PRO Q470M-C",
 	"Pro A520M-C",
 	"Pro A520M-C II",
 	"Pro B550M-C",
@@ -1116,6 +1144,11 @@ static const char * const asus_wmi_boards[] = {
 	"ROG MAXIMUS XII EXTREME",
 	"ROG MAXIMUS XII FORMULA",
 	"ROG MAXIMUS XII HERO (WI-FI)",
+	"ROG STRIX B360-F GAMING",
+	"ROG STRIX B360-G GAMING",
+	"ROG STRIX B360-H GAMING",
+	"ROG STRIX B360-H GAMING/OPTANE",
+	"ROG STRIX B360-I GAMING",
 	"ROG STRIX B460-F GAMING",
 	"ROG STRIX B460-G GAMING",
 	"ROG STRIX B460-H GAMING",
@@ -1127,6 +1160,9 @@ static const char * const asus_wmi_boards[] = {
 	"ROG STRIX B550-F GAMING WIFI II",
 	"ROG STRIX B550-I GAMING",
 	"ROG STRIX B550-XE GAMING WIFI",
+	"ROG STRIX H370-F GAMING",
+	"ROG STRIX H370-I GAMING",
+	"ROG STRIX H470-I GAMING",
 	"ROG STRIX X570-E GAMING",
 	"ROG STRIX X570-E GAMING WIFI II",
 	"ROG STRIX X570-F GAMING",
@@ -1142,6 +1178,13 @@ static const char * const asus_wmi_boards[] = {
 	"ROG STRIX Z490-G GAMING (WI-FI)",
 	"ROG STRIX Z490-H GAMING",
 	"ROG STRIX Z490-I GAMING",
+	"TUF B360-PLUS GAMING",
+	"TUF B360-PRO GAMING",
+	"TUF B360-PRO GAMING (WI-FI)",
+	"TUF B360M-E GAMING",
+	"TUF B360M-PLUS GAMING",
+	"TUF B360M-PLUS GAMING S",
+	"TUF B360M-PLUS GAMING/BR",
 	"TUF GAMING A520M-PLUS",
 	"TUF GAMING A520M-PLUS II",
 	"TUF GAMING A520M-PLUS WIFI",
@@ -1160,12 +1203,20 @@ static const char * const asus_wmi_boards[] = {
 	"TUF GAMING B550M-PLUS",
 	"TUF GAMING B550M-PLUS (WI-FI)",
 	"TUF GAMING B550M-PLUS WIFI II",
+	"TUF GAMING H470-PRO",
+	"TUF GAMING H470-PRO (WI-FI)",
 	"TUF GAMING X570-PLUS",
 	"TUF GAMING X570-PLUS (WI-FI)",
 	"TUF GAMING X570-PLUS_BR",
 	"TUF GAMING X570-PRO (WI-FI)",
+	"TUF GAMING X570-PRO WIFI II",
 	"TUF GAMING Z490-PLUS",
 	"TUF GAMING Z490-PLUS (WI-FI)",
+	"TUF H310-PLUS GAMING",
+	"TUF H310M-PLUS GAMING",
+	"TUF H310M-PLUS GAMING/BR",
+	"TUF H370-PRO GAMING",
+	"TUF H370-PRO GAMING (WI-FI)",
 	"TUF Z390-PLUS GAMING",
 	"TUF Z390-PLUS GAMING (WI-FI)",
 	"TUF Z390-PRO GAMING",
@@ -1180,8 +1231,10 @@ static const char * const asus_msi_boards[] = {
 	"EX-B560M-V5",
 	"EX-B660M-V5 D4",
 	"EX-B660M-V5 PRO D4",
+	"EX-B760M-V5 D4",
 	"EX-H510M-V3",
 	"EX-H610M-V3 D4",
+	"PRIME A620M-A",
 	"PRIME B560-PLUS",
 	"PRIME B560-PLUS AC-HES",
 	"PRIME B560M-A",
@@ -1195,14 +1248,28 @@ static const char * const asus_msi_boards[] = {
 	"PRIME B650M-A WIFI",
 	"PRIME B650M-A WIFI II",
 	"PRIME B660-PLUS D4",
+	"PRIME B660M-A AC D4",
 	"PRIME B660M-A D4",
 	"PRIME B660M-A WIFI D4",
+	"PRIME B760-PLUS",
+	"PRIME B760-PLUS D4",
+	"PRIME B760M-A",
+	"PRIME B760M-A AX D4",
+	"PRIME B760M-A D4",
+	"PRIME B760M-A WIFI",
+	"PRIME B760M-A WIFI D4",
+	"PRIME B760M-AJ D4",
+	"PRIME B760M-K D4",
 	"PRIME H510M-A",
 	"PRIME H510M-A WIFI",
 	"PRIME H510M-D",
 	"PRIME H510M-E",
 	"PRIME H510M-F",
 	"PRIME H510M-K",
+	"PRIME H510M-R",
+	"PRIME H510T2/CSM",
+	"PRIME H570-PLUS",
+	"PRIME H570M-PLUS",
 	"PRIME H610I-PLUS D4",
 	"PRIME H610M-A D4",
 	"PRIME H610M-A WIFI D4",
@@ -1210,6 +1277,9 @@ static const char * const asus_msi_boards[] = {
 	"PRIME H610M-E D4",
 	"PRIME H610M-F D4",
 	"PRIME H610M-K D4",
+	"PRIME H610M-R D4",
+	"PRIME H670-PLUS D4",
+	"PRIME H770-PLUS D4",
 	"PRIME X670-P",
 	"PRIME X670-P WIFI",
 	"PRIME X670E-PRO WIFI",
@@ -1235,16 +1305,22 @@ static const char * const asus_msi_boards[] = {
 	"Pro B560M-CT",
 	"Pro B660M-C",
 	"Pro B660M-C D4",
+	"Pro B760M-C",
+	"Pro B760M-CT",
 	"Pro H510M-C",
 	"Pro H510M-CT",
 	"Pro H610M-C",
 	"Pro H610M-C D4",
 	"Pro H610M-CT D4",
 	"Pro H610T D4",
+	"Pro Q670M-C",
 	"Pro WS W680-ACE",
 	"Pro WS W680-ACE IPMI",
+	"Pro WS W790-ACE",
+	"Pro WS W790E-SAGE SE",
 	"ProArt B650-CREATOR",
 	"ProArt B660-CREATOR D4",
+	"ProArt B760-CREATOR D4",
 	"ProArt X670E-CREATOR WIFI",
 	"ProArt Z690-CREATOR WIFI",
 	"ProArt Z790-CREATOR WIFI",
@@ -1258,6 +1334,8 @@ static const char * const asus_msi_boards[] = {
 	"ROG MAXIMUS Z690 APEX",
 	"ROG MAXIMUS Z690 EXTREME",
 	"ROG MAXIMUS Z690 EXTREME GLACIAL",
+	"ROG MAXIMUS Z690 FORMULA",
+	"ROG MAXIMUS Z690 HERO",
 	"ROG MAXIMUS Z690 HERO EVA",
 	"ROG MAXIMUS Z790 APEX",
 	"ROG MAXIMUS Z790 EXTREME",
@@ -1276,6 +1354,12 @@ static const char * const asus_msi_boards[] = {
 	"ROG STRIX B660-F GAMING WIFI",
 	"ROG STRIX B660-G GAMING WIFI",
 	"ROG STRIX B660-I GAMING WIFI",
+	"ROG STRIX B760-A GAMING WIFI",
+	"ROG STRIX B760-A GAMING WIFI D4",
+	"ROG STRIX B760-F GAMING WIFI",
+	"ROG STRIX B760-G GAMING WIFI",
+	"ROG STRIX B760-G GAMING WIFI D4",
+	"ROG STRIX B760-I GAMING WIFI",
 	"ROG STRIX X670E-A GAMING WIFI",
 	"ROG STRIX X670E-E GAMING WIFI",
 	"ROG STRIX X670E-F GAMING WIFI",
@@ -1287,6 +1371,9 @@ static const char * const asus_msi_boards[] = {
 	"ROG STRIX Z590-I GAMING WIFI",
 	"ROG STRIX Z690-A GAMING WIFI",
 	"ROG STRIX Z690-A GAMING WIFI D4",
+	"ROG STRIX Z690-E GAMING WIFI",
+	"ROG STRIX Z690-F GAMING WIFI",
+	"ROG STRIX Z690-G GAMING WIFI",
 	"ROG STRIX Z690-I GAMING WIFI",
 	"ROG STRIX Z790-A GAMING WIFI",
 	"ROG STRIX Z790-A GAMING WIFI D4",
@@ -1294,6 +1381,8 @@ static const char * const asus_msi_boards[] = {
 	"ROG STRIX Z790-F GAMING WIFI",
 	"ROG STRIX Z790-H GAMING WIFI",
 	"ROG STRIX Z790-I GAMING WIFI",
+	"TUF GAMING A620M-PLUS",
+	"TUF GAMING A620M-PLUS WIFI",
 	"TUF GAMING B560-PLUS WIFI",
 	"TUF GAMING B560M-E",
 	"TUF GAMING B560M-PLUS",
@@ -1304,7 +1393,21 @@ static const char * const asus_msi_boards[] = {
 	"TUF GAMING B650M-PLUS WIFI",
 	"TUF GAMING B660-PLUS WIFI D4",
 	"TUF GAMING B660M-E D4",
+	"TUF GAMING B660M-PLUS D4",
 	"TUF GAMING B660M-PLUS WIFI",
+	"TUF GAMING B660M-PLUS WIFI D4",
+	"TUF GAMING B760-PLUS WIFI",
+	"TUF GAMING B760-PLUS WIFI D4",
+	"TUF GAMING B760M-BTF WIFI D4",
+	"TUF GAMING B760M-E D4",
+	"TUF GAMING B760M-PLUS",
+	"TUF GAMING B760M-PLUS D4",
+	"TUF GAMING B760M-PLUS WIFI",
+	"TUF GAMING B760M-PLUS WIFI D4",
+	"TUF GAMING H570-PRO",
+	"TUF GAMING H570-PRO WIFI",
+	"TUF GAMING H670-PRO WIFI D4",
+	"TUF GAMING H770-PRO WIFI",
 	"TUF GAMING X670E-PLUS",
 	"TUF GAMING X670E-PLUS WIFI",
 	"TUF GAMING Z590-PLUS",
-- 
2.39.2

