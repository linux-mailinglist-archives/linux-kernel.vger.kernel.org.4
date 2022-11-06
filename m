Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2E61E27E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiKFOD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiKFODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:03:24 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946CBE37;
        Sun,  6 Nov 2022 06:03:23 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q9so8421852pfg.5;
        Sun, 06 Nov 2022 06:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+S/udKCmHjZqnoeIR1sQ8q/CXlcQvvka8Tjnn+pm0M=;
        b=JcxKKNbpHoRXw49UJtem2dR8dPnhVIlnCiAVBmD6/cZw0+v/FYlEUQ4qyJhMnJ3FL+
         ydY3WuwQ4VRtrp69Op2wdJLx3Rq7tctTZr44mJMK8k93EAcOpJWH002qiQink9IlPT31
         SP8YicXbBqwpWemhykwHTMadDtIEwf9oJBJtjbsX/Vw3oV1QwcW0SuzNU2zdJx3PyFBL
         a+pFFz1vm70mlOEvAgjJXkmeoP+qOcW90K7RiCjOzRn8OhEAwgNhFVBzX7BYH/8LL0Q0
         tFR2/rH8TrXOO4p3s5fwtU7El2M0hXrl51i+XMwRgB5ZF3vZHWofifLFwavOZSTiYd9Z
         276w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+S/udKCmHjZqnoeIR1sQ8q/CXlcQvvka8Tjnn+pm0M=;
        b=yhC6uP8CXH2aKfhZdbpBWd9Ym22HZ64s2lkD2H0LdEFcrUWnLs9QxmCfVvvCyHfg8g
         swNgp5xwIh5Lk5QxsFqr1fe+ENijaXnqr/WdFdkUzDTbNFUhmCdHSWMtAp9G7MLgp4+i
         eUWjMBjLFLp0KtHE9GBvIRY4nHpM54p1l3pGpX64LPnYbOOiaDgTVZHk4CQTmRiG46Fh
         2/waRcezLoFAF8sCh9yhSl0hVQ269ApfoW39YJj9wmTU+d+UX5k3Su2dIUCJ8hWbAkVZ
         KY7ehmqObkjRRCBnym98feHIhB3+16Sn37u93CRM5Kt5hhcrSpHKhhlcUzMAn4XhkAfb
         1jWw==
X-Gm-Message-State: ACrzQf1nWinXhzQKc9e8IAITmgb3/2Fhnospzekc/30f02aig3M/YW0A
        ghW53kLv4zZ4n8DTULojHSUijb0e9+L2pg==
X-Google-Smtp-Source: AMsMyM60npb3Ps/2+F93AMIYzlhqTklHe6wP9Bs6546mlBOpgNxzGrhrmN38P+azrsPkbs4piFCodw==
X-Received: by 2002:a05:6a00:a8c:b0:558:991a:6691 with SMTP id b12-20020a056a000a8c00b00558991a6691mr45644570pfl.53.1667743402929;
        Sun, 06 Nov 2022 06:03:22 -0800 (PST)
Received: from debian.. (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id p67-20020a625b46000000b005625d6d2999sm2635068pfb.187.2022.11.06.06.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 06:03:22 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: ad4130: format list of in_voltage-voltage_filter_mode_available modes
Date:   Sun,  6 Nov 2022 21:02:33 +0700
Message-Id: <20221106140233.74112-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3309; i=bagasdotme@gmail.com; h=from:subject; bh=ttGJr6cF+tz4BDV10+eWjaRdXdHuebhd6zQIvSyvI9s=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMnp+0qU2M3OcATMbb43beenxL0J9sUPOjrdr1yb3Ghx032x Yq1wRykLgxgHg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACYSzs/IcPR0M5vFev8jnvaucwUuC0 6y5Xznwr6m+ItOu33Am3th+xkZLsVseaS8YQNT9mLfLa1+sYohC6/OWrqzSy1ig5tn/oFtXAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx reports two warnings on sysfs documentation for AD4130 driver:

Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130:2: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130:2: WARNING: Block quote ends without a blank line; unexpected unindent.

These are due to misformatting of sinc* modes list. Format it with bullet
list. Since each entry spans multiple lines, separate each with a blank
line.

Fixes: 5bdef39c5c6e1a ("iio: adc: ad4130: add AD4130 driver")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 48 +++++++++++--------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
index d9555751d21ce2..f24ed6687e900e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
@@ -3,25 +3,35 @@ KernelVersion:  6.2
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Reading returns a list with the possible filter modes.
-		"sinc4"       - Sinc 4. Excellent noise performance. Long 1st
-				conversion time. No natural 50/60Hz rejection.
-		"sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion time.
-		"sinc3"	      - Sinc3. Moderate 1st conversion time. Good noise
-				performance.
-		"sinc3+rej60" - Sinc3 + 60Hz rejection. At a sampling frequency
-				of 50Hz, achieves simultaneous 50Hz and 60Hz
-				rejection.
-		"sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion time.
-				Best used with a sampling frequency of at least
-				216.19Hz.
-		"sinc3+pf1"   - Sinc3 + Post Filter 1.
-				53dB rejection @ 50Hz, 58dB rejection @ 60Hz.
-		"sinc3+pf2"   - Sinc3 + Post Filter 2.
-				70dB rejection @ 50Hz, 70dB rejection @ 60Hz.
-		"sinc3+pf3"   - Sinc3 + Post Filter 3.
-				99dB rejection @ 50Hz, 103dB rejection @ 60Hz.
-		"sinc3+pf4"   - Sinc3 + Post Filter 4.
-				103dB rejection @ 50Hz, 109dB rejection @ 60Hz.
+
+		  * "sinc4"       - Sinc 4. Excellent noise performance. Long
+                    1st conversion time. No natural 50/60Hz rejection.
+
+		  * "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
+		    time.
+
+		  * "sinc3"	      - Sinc3. Moderate 1st conversion time.
+		    Good noise performance.
+
+		  * "sinc3+rej60" - Sinc3 + 60Hz rejection. At a sampling
+		    frequency of 50Hz, achieves simultaneous 50Hz and 60Hz
+		    rejection.
+
+		  * "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
+		    time. Best used with a sampling frequency of at least
+		    216.19Hz.
+
+		  * "sinc3+pf1"   - Sinc3 + Post Filter 1. 53dB rejection @
+		    50Hz, 58dB rejection @ 60Hz.
+
+		  * "sinc3+pf2"   - Sinc3 + Post Filter 2. 70dB rejection @
+		    50Hz, 70dB rejection @ 60Hz.
+
+		  * "sinc3+pf3"   - Sinc3 + Post Filter 3. 99dB rejection @
+		    50Hz, 103dB rejection @ 60Hz.
+
+		  * "sinc3+pf4"   - Sinc3 + Post Filter 4. 103dB rejection @
+		    50Hz, 109dB rejection @ 60Hz.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
 KernelVersion:  6.2

base-commit: b8bee0f98634cc1ce8cc8bf0e1db025734ee0c2b
-- 
An old man doll... just what I always wanted! - Clara

