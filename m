Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E2B705FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjEQGN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjEQGNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:13:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A498F107
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:13:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64ab2a37812so10711416b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684304027; x=1686896027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3lK/82RAw0QZEjsD4BXXHLsrrmmKA6HV/X8St2HKgs=;
        b=OhLxxOXpQKk2kNHQZnXE6iJxnSJQN1KFsyIKtTbPnMHsXJyiPGMlH1uTnc5lUVT9dh
         IZQ049SGiQeKWaqfjgaozVAannN4fHmEZUIXOahtXSJDy//vxfYm/N+pyOHFEKAf6KIs
         0JU4cNAOMf/b/ogtB4RHtf/RUdgf3Th5Ut3a+4iyu8SaDsrDogpVzkVqrhYPyQRLw6aQ
         N9PvAYidkRnSeaz5SFk4pfoJ9VEPBqm7/nf/8OTayEunmc3/+VOmXTIu9R/FMNd+h4bb
         P30P7bh+e39i5XPwR5ye7c3P0CawFqQal1y722v4yxpnWKf29ruTsvutrqibiNSJRSUo
         2YbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304027; x=1686896027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3lK/82RAw0QZEjsD4BXXHLsrrmmKA6HV/X8St2HKgs=;
        b=P5XVrvNbElAPZZ8pRHY6WjTYeCwmGLoCoVgUppO/PHJ/87eJIW0pLg0Abph6J759Si
         xh50M+2cyH3fb+Hvm3LuGiWehviAWG3BApRVEq2rKbTYPPubejR6Epz7chf13eSEd2lX
         W/Bm1ryapwPpZ92ljjMjJr65FYaAzPIH3JucXrK9r0UKFGu4mVzjagigRX1as43dRyig
         K56EGmLC5mkt+VVYFOzhTeIH4lGqIM/iUMig3a4J9S9pBfDlrs5cD+lBU2descchJxpL
         OKrQosSSUpRIEZuJRipTW44N9nrKAHlOee0vzR9MzX8VvRXbttXv+xF1ZB1EZw4KN/9L
         c9ug==
X-Gm-Message-State: AC+VfDwXrBhf4lgepOb1xSBH41Oc+XQvXWM+tNdohiQ4Akr9NZ8kag3/
        CYP5RxaW2eyIde/m/vS6Qu4=
X-Google-Smtp-Source: ACHHUZ7WtNgiXnk/vGT8nQQ5vMU22HsO6X9krOFcCa8CKuwtDItxe/OmOItc2vIjiEptc9Z4PpuoJg==
X-Received: by 2002:a17:902:f693:b0:1ac:788c:872a with SMTP id l19-20020a170902f69300b001ac788c872amr1582837plg.1.1684304026699;
        Tue, 16 May 2023 23:13:46 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090adb5000b0023d0c2f39f2sm690827pjx.19.2023.05.16.23.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:13:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CEE6F1061C6; Wed, 17 May 2023 13:13:41 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Pavel Machek <pavel@ucw.cz>, Kalle Valo <kvalo@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "David A . Hinds" <dahinds@users.sourceforge.net>,
        "John G . Dorsey" <john+@cs.cmu.edu>
Subject: [PATCH 1/3] pcmcia: Convert dual GPL/MPL notice to SPDX license identifier
Date:   Wed, 17 May 2023 13:13:36 +0700
Message-Id: <20230517061338.1081810-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517061338.1081810-1-bagasdotme@gmail.com>
References: <20230517061338.1081810-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26656; i=bagasdotme@gmail.com; h=from:subject; bh=Cn8UOAilwZdQvO1z/7cE78weTQTUVch9kzUAoTFKYb0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkpBRPb3CfFXbKQydurYjJPiXfS5MxJCitu+m1jzonhT +TcFR3cUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIk4nWX4p8dX9Uno57/ehPWf xTvePIivLHooxCt1I2Jin7L7h+79sYwMx1ckzsrJMhLr3tJaHM5sNet64QvVU/NNreuUDj7bUza ZFwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace license boilerplate for dual GPL 2.0/MPL 1.1 with corresponding
SPDX license identifier.

Cc: David A. Hinds <dahinds@users.sourceforge.net>
Cc: John G. Dorsey <john+@cs.cmu.edu>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/pcmcia/cirrus.h         | 21 +--------------------
 drivers/pcmcia/i82365.c         | 22 +---------------------
 drivers/pcmcia/i82365.h         | 21 +--------------------
 drivers/pcmcia/o2micro.h        | 21 +--------------------
 drivers/pcmcia/ricoh.h          | 21 +--------------------
 drivers/pcmcia/sa1100_generic.c | 22 +---------------------
 drivers/pcmcia/sa11xx_base.c    | 22 +---------------------
 drivers/pcmcia/sa11xx_base.h    | 22 +---------------------
 drivers/pcmcia/soc_common.c     | 22 +---------------------
 drivers/pcmcia/tcic.c           | 22 +---------------------
 drivers/pcmcia/tcic.h           | 21 +--------------------
 drivers/pcmcia/ti113x.h         | 21 +--------------------
 drivers/pcmcia/topic.h          | 23 +----------------------
 drivers/pcmcia/vg468.h          | 21 +--------------------
 14 files changed, 14 insertions(+), 288 deletions(-)

diff --git a/drivers/pcmcia/cirrus.h b/drivers/pcmcia/cirrus.h
index 446a4576e73e6c..8d3a256c97a087 100644
--- a/drivers/pcmcia/cirrus.h
+++ b/drivers/pcmcia/cirrus.h
@@ -1,30 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1 */
 /*
  * cirrus.h 1.4 1999/10/25 20:03:34
  *
- * The contents of this file are subject to the Mozilla Public License
- * Version 1.1 (the "License"); you may not use this file except in
- * compliance with the License. You may obtain a copy of the License
- * at http://www.mozilla.org/MPL/
- *
- * Software distributed under the License is distributed on an "AS IS"
- * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
- * the License for the specific language governing rights and
- * limitations under the License. 
- *
  * The initial developer of the original code is David A. Hinds
  * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
  * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
  *
- * Alternatively, the contents of this file may be used under the
- * terms of the GNU General Public License version 2 (the "GPL"), in which
- * case the provisions of the GPL are applicable instead of the
- * above.  If you wish to allow the use of your version of this file
- * only under the terms of the GPL and not to allow others to use
- * your version of this file under the MPL, indicate your decision by
- * deleting the provisions above and replace them with the notice and
- * other provisions required by the GPL.  If you do not delete the
- * provisions above, a recipient may use your version of this file
- * under either the MPL or the GPL.
  */
 
 #ifndef _LINUX_CIRRUS_H
diff --git a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
index 891ccea2cccb0a..a7b50c7201215f 100644
--- a/drivers/pcmcia/i82365.c
+++ b/drivers/pcmcia/i82365.c
@@ -1,34 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1
 /*======================================================================
 
     Device driver for Intel 82365 and compatible PC Card controllers.
 
     i82365.c 1.265 1999/11/10 18:36:21
 
-    The contents of this file are subject to the Mozilla Public
-    License Version 1.1 (the "License"); you may not use this file
-    except in compliance with the License. You may obtain a copy of
-    the License at http://www.mozilla.org/MPL/
-
-    Software distributed under the License is distributed on an "AS
-    IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
-    implied. See the License for the specific language governing
-    rights and limitations under the License.
-
     The initial developer of the original code is David A. Hinds
     <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
     are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
 
-    Alternatively, the contents of this file may be used under the
-    terms of the GNU General Public License version 2 (the "GPL"), in which
-    case the provisions of the GPL are applicable instead of the
-    above.  If you wish to allow the use of your version of this file
-    only under the terms of the GPL and not to allow others to use
-    your version of this file under the MPL, indicate your decision
-    by deleting the provisions above and replace them with the notice
-    and other provisions required by the GPL.  If you do not delete
-    the provisions above, a recipient may use your version of this
-    file under either the MPL or the GPL.
-    
 ======================================================================*/
 
 #include <linux/module.h>
diff --git a/drivers/pcmcia/i82365.h b/drivers/pcmcia/i82365.h
index 3f84d7a2dc84fa..5501001c7dd8ab 100644
--- a/drivers/pcmcia/i82365.h
+++ b/drivers/pcmcia/i82365.h
@@ -1,30 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1 */
 /*
  * i82365.h 1.15 1999/10/25 20:03:34
  *
- * The contents of this file are subject to the Mozilla Public License
- * Version 1.1 (the "License"); you may not use this file except in
- * compliance with the License. You may obtain a copy of the License
- * at http://www.mozilla.org/MPL/
- *
- * Software distributed under the License is distributed on an "AS IS"
- * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
- * the License for the specific language governing rights and
- * limitations under the License. 
- *
  * The initial developer of the original code is David A. Hinds
  * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
  * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
  *
- * Alternatively, the contents of this file may be used under the
- * terms of the GNU General Public License version 2 (the "GPL"), in which
- * case the provisions of the GPL are applicable instead of the
- * above.  If you wish to allow the use of your version of this file
- * only under the terms of the GPL and not to allow others to use
- * your version of this file under the MPL, indicate your decision by
- * deleting the provisions above and replace them with the notice and
- * other provisions required by the GPL.  If you do not delete the
- * provisions above, a recipient may use your version of this file
- * under either the MPL or the GPL.
  */
 
 #ifndef _LINUX_I82365_H
diff --git a/drivers/pcmcia/o2micro.h b/drivers/pcmcia/o2micro.h
index 5096e92c7a4cfb..8b828c0932950c 100644
--- a/drivers/pcmcia/o2micro.h
+++ b/drivers/pcmcia/o2micro.h
@@ -1,30 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1 */
 /*
  * o2micro.h 1.13 1999/10/25 20:03:34
  *
- * The contents of this file are subject to the Mozilla Public License
- * Version 1.1 (the "License"); you may not use this file except in
- * compliance with the License. You may obtain a copy of the License
- * at http://www.mozilla.org/MPL/
- *
- * Software distributed under the License is distributed on an "AS IS"
- * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
- * the License for the specific language governing rights and
- * limitations under the License. 
- *
  * The initial developer of the original code is David A. Hinds
  * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
  * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
  *
- * Alternatively, the contents of this file may be used under the
- * terms of the GNU General Public License version 2 (the "GPL"), in which
- * case the provisions of the GPL are applicable instead of the
- * above.  If you wish to allow the use of your version of this file
- * only under the terms of the GPL and not to allow others to use
- * your version of this file under the MPL, indicate your decision by
- * deleting the provisions above and replace them with the notice and
- * other provisions required by the GPL.  If you do not delete the
- * provisions above, a recipient may use your version of this file
- * under either the MPL or the GPL.
  */
 
 #ifndef _LINUX_O2MICRO_H
diff --git a/drivers/pcmcia/ricoh.h b/drivers/pcmcia/ricoh.h
index 8ac7b138c09486..f037169f6108f7 100644
--- a/drivers/pcmcia/ricoh.h
+++ b/drivers/pcmcia/ricoh.h
@@ -1,30 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1 */
 /*
  * ricoh.h 1.9 1999/10/25 20:03:34
  *
- * The contents of this file are subject to the Mozilla Public License
- * Version 1.1 (the "License"); you may not use this file except in
- * compliance with the License. You may obtain a copy of the License
- * at http://www.mozilla.org/MPL/
- *
- * Software distributed under the License is distributed on an "AS IS"
- * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
- * the License for the specific language governing rights and
- * limitations under the License. 
- *
  * The initial developer of the original code is David A. Hinds
  * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
  * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
  *
- * Alternatively, the contents of this file may be used under the
- * terms of the GNU General Public License version 2 (the "GPL"), in which
- * case the provisions of the GPL are applicable instead of the
- * above.  If you wish to allow the use of your version of this file
- * only under the terms of the GPL and not to allow others to use
- * your version of this file under the MPL, indicate your decision by
- * deleting the provisions above and replace them with the notice and
- * other provisions required by the GPL.  If you do not delete the
- * provisions above, a recipient may use your version of this file
- * under either the MPL or the GPL.
  */
 
 #ifndef _LINUX_RICOH_H
diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 89d4ba58c89135..9ec190ab29a89e 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -1,33 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1
 /*======================================================================
 
     Device driver for the PCMCIA control functionality of StrongARM
     SA-1100 microprocessors.
 
-    The contents of this file are subject to the Mozilla Public
-    License Version 1.1 (the "License"); you may not use this file
-    except in compliance with the License. You may obtain a copy of
-    the License at http://www.mozilla.org/MPL/
-
-    Software distributed under the License is distributed on an "AS
-    IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
-    implied. See the License for the specific language governing
-    rights and limitations under the License.
-
     The initial developer of the original code is John G. Dorsey
     <john+@cs.cmu.edu>.  Portions created by John G. Dorsey are
     Copyright (C) 1999 John G. Dorsey.  All Rights Reserved.
 
-    Alternatively, the contents of this file may be used under the
-    terms of the GNU Public License version 2 (the "GPL"), in which
-    case the provisions of the GPL are applicable instead of the
-    above.  If you wish to allow the use of your version of this file
-    only under the terms of the GPL and not to allow others to use
-    your version of this file under the MPL, indicate your decision
-    by deleting the provisions above and replace them with the notice
-    and other provisions required by the GPL.  If you do not delete
-    the provisions above, a recipient may use your version of this
-    file under either the MPL or the GPL.
-    
 ======================================================================*/
 
 #include <linux/module.h>
diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index 48140ac73ed632..3e9b3b0c9b0817 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -1,33 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1
 /*======================================================================
 
     Device driver for the PCMCIA control functionality of StrongARM
     SA-1100 microprocessors.
 
-    The contents of this file are subject to the Mozilla Public
-    License Version 1.1 (the "License"); you may not use this file
-    except in compliance with the License. You may obtain a copy of
-    the License at http://www.mozilla.org/MPL/
-
-    Software distributed under the License is distributed on an "AS
-    IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
-    implied. See the License for the specific language governing
-    rights and limitations under the License.
-
     The initial developer of the original code is John G. Dorsey
     <john+@cs.cmu.edu>.  Portions created by John G. Dorsey are
     Copyright (C) 1999 John G. Dorsey.  All Rights Reserved.
 
-    Alternatively, the contents of this file may be used under the
-    terms of the GNU Public License version 2 (the "GPL"), in which
-    case the provisions of the GPL are applicable instead of the
-    above.  If you wish to allow the use of your version of this file
-    only under the terms of the GPL and not to allow others to use
-    your version of this file under the MPL, indicate your decision
-    by deleting the provisions above and replace them with the notice
-    and other provisions required by the GPL.  If you do not delete
-    the provisions above, a recipient may use your version of this
-    file under either the MPL or the GPL.
-
 ======================================================================*/
 
 #include <linux/module.h>
diff --git a/drivers/pcmcia/sa11xx_base.h b/drivers/pcmcia/sa11xx_base.h
index 3d76d720f463de..c2dbdc5495f78e 100644
--- a/drivers/pcmcia/sa11xx_base.h
+++ b/drivers/pcmcia/sa11xx_base.h
@@ -1,33 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1 */
 /*======================================================================
 
     Device driver for the PCMCIA control functionality of StrongARM
     SA-1100 microprocessors.
 
-    The contents of this file are subject to the Mozilla Public
-    License Version 1.1 (the "License"); you may not use this file
-    except in compliance with the License. You may obtain a copy of
-    the License at http://www.mozilla.org/MPL/
-
-    Software distributed under the License is distributed on an "AS
-    IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
-    implied. See the License for the specific language governing
-    rights and limitations under the License.
-
     The initial developer of the original code is John G. Dorsey
     <john+@cs.cmu.edu>.  Portions created by John G. Dorsey are
     Copyright (C) 1999 John G. Dorsey.  All Rights Reserved.
 
-    Alternatively, the contents of this file may be used under the
-    terms of the GNU Public License version 2 (the "GPL"), in which
-    case the provisions of the GPL are applicable instead of the
-    above.  If you wish to allow the use of your version of this file
-    only under the terms of the GPL and not to allow others to use
-    your version of this file under the MPL, indicate your decision
-    by deleting the provisions above and replace them with the notice
-    and other provisions required by the GPL.  If you do not delete
-    the provisions above, a recipient may use your version of this
-    file under either the MPL or the GPL.
-
 ======================================================================*/
 
 #if !defined(_PCMCIA_SA1100_H)
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 61b0c8952bb5e0..8b035367fd4268 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -1,33 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1
 /*======================================================================
 
     Common support code for the PCMCIA control functionality of
     integrated SOCs like the SA-11x0 and PXA2xx microprocessors.
 
-    The contents of this file are subject to the Mozilla Public
-    License Version 1.1 (the "License"); you may not use this file
-    except in compliance with the License. You may obtain a copy of
-    the License at http://www.mozilla.org/MPL/
-
-    Software distributed under the License is distributed on an "AS
-    IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
-    implied. See the License for the specific language governing
-    rights and limitations under the License.
-
     The initial developer of the original code is John G. Dorsey
     <john+@cs.cmu.edu>.  Portions created by John G. Dorsey are
     Copyright (C) 1999 John G. Dorsey.  All Rights Reserved.
 
-    Alternatively, the contents of this file may be used under the
-    terms of the GNU Public License version 2 (the "GPL"), in which
-    case the provisions of the GPL are applicable instead of the
-    above.  If you wish to allow the use of your version of this file
-    only under the terms of the GPL and not to allow others to use
-    your version of this file under the MPL, indicate your decision
-    by deleting the provisions above and replace them with the notice
-    and other provisions required by the GPL.  If you do not delete
-    the provisions above, a recipient may use your version of this
-    file under either the MPL or the GPL.
-
 ======================================================================*/
 
 
diff --git a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
index 1a0e3f0987599d..a5fca2d14c1257 100644
--- a/drivers/pcmcia/tcic.c
+++ b/drivers/pcmcia/tcic.c
@@ -1,34 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1
 /*======================================================================
 
     Device driver for Databook TCIC-2 PCMCIA controller
 
     tcic.c 1.111 2000/02/15 04:13:12
 
-    The contents of this file are subject to the Mozilla Public
-    License Version 1.1 (the "License"); you may not use this file
-    except in compliance with the License. You may obtain a copy of
-    the License at http://www.mozilla.org/MPL/
-
-    Software distributed under the License is distributed on an "AS
-    IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
-    implied. See the License for the specific language governing
-    rights and limitations under the License.
-
     The initial developer of the original code is David A. Hinds
     <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
     are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
 
-    Alternatively, the contents of this file may be used under the
-    terms of the GNU General Public License version 2 (the "GPL"), in which
-    case the provisions of the GPL are applicable instead of the
-    above.  If you wish to allow the use of your version of this file
-    only under the terms of the GPL and not to allow others to use
-    your version of this file under the MPL, indicate your decision
-    by deleting the provisions above and replace them with the notice
-    and other provisions required by the GPL.  If you do not delete
-    the provisions above, a recipient may use your version of this
-    file under either the MPL or the GPL.
-    
 ======================================================================*/
 
 #include <linux/module.h>
diff --git a/drivers/pcmcia/tcic.h b/drivers/pcmcia/tcic.h
index 2c0b8f65ad6c6f..aff1e65fc69032 100644
--- a/drivers/pcmcia/tcic.h
+++ b/drivers/pcmcia/tcic.h
@@ -1,30 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1 */
 /*
  * tcic.h 1.13 1999/10/25 20:03:34
  *
- * The contents of this file are subject to the Mozilla Public License
- * Version 1.1 (the "License"); you may not use this file except in
- * compliance with the License. You may obtain a copy of the License
- * at http://www.mozilla.org/MPL/
- *
- * Software distributed under the License is distributed on an "AS IS"
- * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
- * the License for the specific language governing rights and
- * limitations under the License. 
- *
  * The initial developer of the original code is David A. Hinds
  * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
  * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
  *
- * Alternatively, the contents of this file may be used under the
- * terms of the GNU General Public License version 2 (the "GPL"), in which
- * case the provisions of the GPL are applicable instead of the
- * above.  If you wish to allow the use of your version of this file
- * only under the terms of the GPL and not to allow others to use
- * your version of this file under the MPL, indicate your decision by
- * deleting the provisions above and replace them with the notice and
- * other provisions required by the GPL.  If you do not delete the
- * provisions above, a recipient may use your version of this file
- * under either the MPL or the GPL.
  */
 
 #ifndef _LINUX_TCIC_H
diff --git a/drivers/pcmcia/ti113x.h b/drivers/pcmcia/ti113x.h
index 5cb670e037a0c6..a65ab56551ee93 100644
--- a/drivers/pcmcia/ti113x.h
+++ b/drivers/pcmcia/ti113x.h
@@ -1,30 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1 */
 /*
  * ti113x.h 1.16 1999/10/25 20:03:34
  *
- * The contents of this file are subject to the Mozilla Public License
- * Version 1.1 (the "License"); you may not use this file except in
- * compliance with the License. You may obtain a copy of the License
- * at http://www.mozilla.org/MPL/
- *
- * Software distributed under the License is distributed on an "AS IS"
- * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
- * the License for the specific language governing rights and
- * limitations under the License. 
- *
  * The initial developer of the original code is David A. Hinds
  * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
  * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
  *
- * Alternatively, the contents of this file may be used under the
- * terms of the GNU General Public License version 2 (the "GPL"), in which
- * case the provisions of the GPL are applicable instead of the
- * above.  If you wish to allow the use of your version of this file
- * only under the terms of the GPL and not to allow others to use
- * your version of this file under the MPL, indicate your decision by
- * deleting the provisions above and replace them with the notice and
- * other provisions required by the GPL.  If you do not delete the
- * provisions above, a recipient may use your version of this file
- * under either the MPL or the GPL.
  */
 
 #ifndef _LINUX_TI113X_H
diff --git a/drivers/pcmcia/topic.h b/drivers/pcmcia/topic.h
index 582688fe750540..d1ad01abab13f4 100644
--- a/drivers/pcmcia/topic.h
+++ b/drivers/pcmcia/topic.h
@@ -1,31 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1 */
 /*
  * topic.h 1.8 1999/08/28 04:01:47
  *
- * The contents of this file are subject to the Mozilla Public License
- * Version 1.1 (the "License"); you may not use this file except in
- * compliance with the License. You may obtain a copy of the License
- * at http://www.mozilla.org/MPL/
- *
- * Software distributed under the License is distributed on an "AS IS"
- * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
- * the License for the specific language governing rights and
- * limitations under the License. 
- *
  * The initial developer of the original code is David A. Hinds
  * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
  * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
- *
- * Alternatively, the contents of this file may be used under the
- * terms of the GNU General Public License version 2 (the "GPL"), in which
- * case the provisions of the GPL are applicable instead of the
- * above.  If you wish to allow the use of your version of this file
- * only under the terms of the GPL and not to allow others to use
- * your version of this file under the MPL, indicate your decision by
- * deleting the provisions above and replace them with the notice and
- * other provisions required by the GPL.  If you do not delete the
- * provisions above, a recipient may use your version of this file
- * under either the MPL or the GPL.
- * topic.h $Release$ 1999/08/28 04:01:47
  */
 
 #ifndef _LINUX_TOPIC_H
diff --git a/drivers/pcmcia/vg468.h b/drivers/pcmcia/vg468.h
index 88c2b487f675fc..c582fc8086c26d 100644
--- a/drivers/pcmcia/vg468.h
+++ b/drivers/pcmcia/vg468.h
@@ -1,30 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MPL-1.1 */
 /*
  * vg468.h 1.11 1999/10/25 20:03:34
  *
- * The contents of this file are subject to the Mozilla Public License
- * Version 1.1 (the "License"); you may not use this file except in
- * compliance with the License. You may obtain a copy of the License
- * at http://www.mozilla.org/MPL/
- *
- * Software distributed under the License is distributed on an "AS IS"
- * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
- * the License for the specific language governing rights and
- * limitations under the License. 
- *
  * The initial developer of the original code is David A. Hinds
  * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
  * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
  *
- * Alternatively, the contents of this file may be used under the
- * terms of the GNU General Public License version 2 (the "GPL"), in which
- * case the provisions of the GPL are applicable instead of the
- * above.  If you wish to allow the use of your version of this file
- * only under the terms of the GPL and not to allow others to use
- * your version of this file under the MPL, indicate your decision by
- * deleting the provisions above and replace them with the notice and
- * other provisions required by the GPL.  If you do not delete the
- * provisions above, a recipient may use your version of this file
- * under either the MPL or the GPL.
  */
 
 #ifndef _LINUX_VG468_H
-- 
An old man doll... just what I always wanted! - Clara

