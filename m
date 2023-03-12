Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02F86B67C1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCLP6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCLP6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:58:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793001024F;
        Sun, 12 Mar 2023 08:58:08 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.78]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mo7if-1qLg6s1a0p-00pYmE; Sun, 12 Mar 2023 16:57:37 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] docs: hwmon: sysfs-interface: Fix stray colon
Date:   Sun, 12 Mar 2023 16:57:14 +0100
Message-Id: <20230312155714.17290-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CsoXhnzDVOZwW/awzRTbhwut01ck00jfx8PBDPdfpfa9/4oSUIq
 b3CjUuaUcxFsqM09Fqcjn/jmHU1rjdP1XffTJeoZ6ghZ/JBbz6MVRYXDCQ8wstV6pHfmES1
 3OjOkmssT6qCrMrNmLm/VijLBKYD5LkKVZtYnVfsjAvZUGpYRNj4vcodCO6X2+jEyyCI3Ux
 8Lx5eAvhqwsjm0cw8G5dw==
UI-OutboundReport: notjunk:1;M01:P0:mSaz4uIuuPE=;CYk3QMPqYNXNWafx1H7tqFcczw8
 DlY+2SfKmGmf1HJaCnzywTi07hufcopJXaXKToccmPDmY1IcncBXgiExPVSG1dBXh2Kw1Fwxe
 SzCpg7+tt2hqOxQw+CW6Z43P9QdiRQRANME44cpevaO4w9kbKmkT2oUYWVi0Kr2FUE1j4BmPk
 kjjRqhpKEfUcv3XO4SPu1O95SFpkBIUUZSpVugozxAW/wJlE9hVeWGndJ2rHN7Bkm3Uq0wmu+
 fGg+Ix73xZXdsMN4osMV59FmPXUWHjp5gZut+pt/qiiz2SrNNn6DFXG08Q4qwW+3oloFpJjuW
 TxIRsTWuXWJFldXo8v+d+PJK9l2lEJaDTeFCfoRcyc6i3PpU4hGvkbVSmT84LQYlZbdRxzuvO
 3BXRzas02csQo+o+jrTp3rgXZQHdqNovXmDTd6IeRrorQRNJMoqzeqDisaV1vpoCpQJfFMMt9
 fZAS41YNQ5p5InYDlstBQrk6ycXFeWhgxyOcT6Y44Z8k3w22KkUfCfErqvN6vJIbdv7RWPhOf
 Us147LkurqRT6TP4nAg7FRsXGr5rUhERGAvD7AeA3y0OyetiLEZiJCHQt5uTbodJjMHkASiiy
 QJhCj/Ahc8Z0v/2H7HM+QSPUATmvL8RhgogZgQrIPiJzL7+InSmoJMjwt6QSV3cf70SlHnxSC
 7r9fNIXczBfjHQrRlVb2UTKEsYlNDoPX1df7JWC3vA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 036d6a4e75c9 ("ABI: sysfs-class-hwmon: add ABI documentation
for it") moved all ABI attributes to the usual ABI documentation. But this
change left a stray colon for the fan speed control method. Fix this
to avoid a confusion of readers.

Fixes: 036d6a4e75c9 ("ABI: sysfs-class-hwmon: add ABI documentation for it")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/hwmon/sysfs-interface.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/sysfs-interface.rst b/Documentation/hwmon/sysfs-interface.rst
index 209626fb2405..f76e9f8cc1ad 100644
--- a/Documentation/hwmon/sysfs-interface.rst
+++ b/Documentation/hwmon/sysfs-interface.rst
@@ -201,7 +201,7 @@ PWM
 		Pulse width modulation fan control.
 
 `pwm[1-*]_enable`
-		Fan speed control method:
+		Fan speed control method.
 
 `pwm[1-*]_mode`
 		direct current or pulse-width modulation.
-- 
2.34.1

