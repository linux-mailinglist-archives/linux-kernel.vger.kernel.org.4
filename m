Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC46CAF25
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjC0Ttj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjC0Ttb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:49:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED513AAB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:49:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u1so5656223wmn.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679946558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWKsykkKVuz2dhEzgsJk6LsgHkCtoaGRFeLVtPb88b4=;
        b=M9ozzLvSFwB0rFvoXKyJaaa4QUuyFwmExeqAdbrW5d/4GD8gy7KNsAgLxRlVMLR/4C
         fqiK6c5MW0kbcD1fnK1RsfkgDLfSh8hlycjyCREBzsTg6iIYZMJJ3uCR6qS6sMDJRMjG
         eWN0qMnpKQRZoa6chaxCXdrEQ+9hXcBaLxJ3iKEm1vCHb7zelhRifQFrB2sV4R/UCe45
         YLMlO7G1eCcJMtku+l9RvLu4XwV6BC5jS1bhCoEJEYm0ew3iVo3CbyxOGorcirWX/R1e
         o101smcEVU3jamQ4pQiiJO6OWZawW4nDMF7nzCAW0bHXDlOhP/eAPmBZF602GMfwPl7I
         Wuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679946558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWKsykkKVuz2dhEzgsJk6LsgHkCtoaGRFeLVtPb88b4=;
        b=6jbgaUfJEDEPa2nJphAtbd/2R8tmRW0TdDPrGWJunhkkkP45kV403194L8PqzYI4x/
         vp77TkK0tObl+AlamP1Q9rOFBQQptynCgSG1tSIhgeo1+j4XlrSdLBvAACaOkQQlHfDQ
         nkKutZlur4WbI1dji3lJOds8ENI5iVwMkLy5BrFVDB9svyuD3SlR0GOVDTDxlshZ2QiL
         3Gv34E2Vq4qnaPGGZUejAf3XId00FQvisPYG+esolJEw2mOPtF9DczqOToEPITSjxSrd
         q7P70cnCK88JHTzXs+948ca/rkGXtC+8TRT1kngVbVLUEPxRLFGR8lLgauvsYwTWaPyT
         +lBg==
X-Gm-Message-State: AO0yUKU18UonMSZdZ2lXMewHnAsxO/AhzCEEJL4A5K+lj631KQme1m+/
        Suk1NDI6deNy+rmZMMyddJM=
X-Google-Smtp-Source: AK7set8Uxf+Nc7JF9L4fgS5+Z8Z3CoEKoIml9ofdpLE0kZzWgeKEu5QchrpmMMC+SqimZGpJBYaWNQ==
X-Received: by 2002:a1c:4c0d:0:b0:3eb:2e32:72c3 with SMTP id z13-20020a1c4c0d000000b003eb2e3272c3mr11137268wmf.22.1679946558133;
        Mon, 27 Mar 2023 12:49:18 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id c13-20020a05600c0acd00b003ee42696acesm14661366wmr.16.2023.03.27.12.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:49:17 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] staging: rtl8192u: add '*' on subsequent lines in block comment
Date:   Tue, 28 Mar 2023 00:49:08 +0500
Message-Id: <3a581aae65a152ce41fdd2db667574eba1783113.1679945728.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679945728.git.kamrankhadijadj@gmail.com>
References: <cover.1679945728.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel coding style for block comments uses a column of '*' on the
left side.
Fix block comment by adding '*' on subsequent lines as reported by
checkatch.pl script.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index e5c0bece4bb4..dd9903719c20 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -1,13 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /*++
-Copyright-c Realtek Semiconductor Corp. All rights reserved.
-
-Module Name:
-	r8192U_dm.c
-
-Abstract:
-	HW dynamic mechanism.
---*/
+ * Copyright-c Realtek Semiconductor Corp. All rights reserved.
+ *
+ * Module Name:
+ *	r8192U_dm.c
+ *
+ * Abstract:
+ *	HW dynamic mechanism.
+ *--
+ */
 #include "r8192U.h"
 #include "r8192U_dm.h"
 #include "r8192U_hw.h"
-- 
2.34.1

