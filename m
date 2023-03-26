Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C426C92DC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 08:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCZGp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 02:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZGp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 02:45:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065ACA246
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 23:45:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a16so5027138pjs.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 23:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679813125;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Xa4yXSffm+6bXnmSFV6WRoBiZ42z2spUWYAuMy1+fI=;
        b=l18eSA0MKvgRUHyKdbqLoX1r7mFagcwI9bQBDON0MhvXn5UXSm+uOa8gAXeaLX3d3p
         lSse5Cod8gSnz2u3odGoITwc7z/kWkDkcwGUGduFEvEUp9X4mUZVn5t9S+CU1ZNWy2v6
         0yenqLW/f4HpEeghPCnambVaI40sF0YQMwWSp6WQgT6/UDQF5quH64H4x406vR8awMQU
         naBC+y8R4DPEC4CTSnc9RLfaj+EjOoYamtZ5a4ZbLBW0FIClhpLl3u7sD5kxZXmBWgQZ
         rYZhL7DIa4IAzg6RJACF5ObaT6z9/2154AgvYsiD4V0qhMcoNLeX5mINTRp2aPe/KQsv
         NIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679813125;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Xa4yXSffm+6bXnmSFV6WRoBiZ42z2spUWYAuMy1+fI=;
        b=ipKYgUmiJzhfzgTExNAIV34+UPjfzAOu/dbuzl/mtmV7f19+5dIsi8oMHmSgODrdS8
         BqqIMFCG0v0yIfPiPIIKZ50p/hXdmymJkPsKxH5qvpKAUIIiyMsaHr7/r/85JbmAp18n
         dT4sG95cpbGvxU15jUygYQcnSMkGImSNWK00uE8a3PzjtHJCGjxipJ/YXRTznWOo/Qfv
         9R/UMUuuApp19WjzjllU22Iuw8XMatw/W54+MMLkiD/kdy9QBs2nKTzf7KG+l6cMZEBy
         M7YkBPsEO+GQbqg2WGCb2u56UOy+IWSIk/xO0dG+BLAFsP/r+Z94h3XdzQLtHPOf/z6K
         jdHw==
X-Gm-Message-State: AAQBX9cfG6CZzHJ51IeQzIpDRw6eXQBWDjdtk3oYJJUlW4RbSzWHAldm
        Io0caVvnRB8BlPMHoMInm8Y=
X-Google-Smtp-Source: AKy350a3ZE7Sc6hR5WDQRxmgubD2rBLmS7hJtJE8YtRyOhZSlxf1M6vcSYgv9JyVenXiaj64sWXWcA==
X-Received: by 2002:a17:902:d4c7:b0:19e:6760:305b with SMTP id o7-20020a170902d4c700b0019e6760305bmr8716559plg.47.1679813125445;
        Sat, 25 Mar 2023 23:45:25 -0700 (PDT)
Received: from sumitra.com ([117.212.89.150])
        by smtp.gmail.com with ESMTPSA id bf11-20020a170902b90b00b00194caf3e975sm4068165plb.208.2023.03.25.23.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 23:45:25 -0700 (PDT)
Date:   Sat, 25 Mar 2023 23:45:19 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     outreachy@lists.linux.dev
Subject: [PATCH v4] staging: greybus: Inline pwm_chip_to_gb_pwm_chip()
Message-ID: <20230326064519.GA179449@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert 'pwm_chip_to_gb_pwm_chip' from a macro to a static
inline function, to make the relevant types apparent in the
definition and to benefit from the type checking performed by
the compiler at call sites.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---

Changes in v2: Change patch subjects, noted by Alison Schofield
<alison.schofield@intel.com>

Changes in v3: Change patch subjects to length 80 chars,      
noted by Alison Schofield <alison.schofield@intel.com>

Changes in v4: Apply change to fresh git tree, noted by 
Greg KH <gregkh@linuxfoundation.org>

 drivers/staging/greybus/pwm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 26d39e08c3b6..88da1d796f13 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -21,8 +21,11 @@ struct gb_pwm_chip {
 	struct pwm_chip		chip;
 	struct pwm_chip		*pwm;
 };
-#define pwm_chip_to_gb_pwm_chip(chip) \
-	container_of(chip, struct gb_pwm_chip, chip)
+
+static inline struct gb_pwm_chip *pwm_chip_to_gb_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct gb_pwm_chip, chip);
+}
 
 static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
 {
-- 
2.25.1

