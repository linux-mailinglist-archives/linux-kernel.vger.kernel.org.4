Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7F16082D7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJVA1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJVA06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:26:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF942A936F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:26:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso1647081pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4Z56QD1CCvIrKsTPGC6Qon5YPAVLFQEgNwprnuBCtU=;
        b=IPZF1UwW5SxbJ1b7msUq7LVf59sNZJgGc1sqPbAiChtckECPQJhxvjmBVErujKIz1f
         wRwBF9xFJ23gVN/nkBD+IQkvhJ9Yi4ZBFzShxQ1LQ2y8axdBb8HPCDS6+4ocYTv7TyQ3
         iVhuXTGgkqkBh9Q1udfUuAPhGL5GzI18aqGuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4Z56QD1CCvIrKsTPGC6Qon5YPAVLFQEgNwprnuBCtU=;
        b=6gYxezXV5LM78KDK5FsC3CgkUvyKFLjcnVfbsuhrSDWZ3xVvnc5JU81cbJYTk0ZqC0
         h/55Wxe/wKIGSqzC9pYzuARmwzbYY/+NvMReRkEXA+oqgY78wvoYgDXKp1oeZ4E4atUH
         /I8bCY1oQg/w08D74v97I5upwD91K87s14J12zOwmORw6INqV+kinTVOCzEsFSAUIUGa
         eK1RQ676nmavLHdbsPm/jgRHUnBmsxav1wecZqaYG0Qal7Ehm7XXI4rRIIb4Sl64P1sa
         Gnghz2bol29Zq9IQnadonS8i1lFMSJzECowp90QZN8fZCoXgSPvs0xHP8VeDUAXqhG4I
         UgXQ==
X-Gm-Message-State: ACrzQf2PyoWcBe50eEWHLshI6IYmH+hqmR1+M0ckeS+u5+Mhb+qvAvpR
        ZgziuHNLMKB7e28IXxOOgeHRSw==
X-Google-Smtp-Source: AMsMyM5AzCeeFB+prG8aiusWOiIWgRdNjNSJMRheaGX5egNg3h+LB0g/E0afhs6BNb0SKiSZMmtoLQ==
X-Received: by 2002:a17:90b:190c:b0:211:ab56:35e6 with SMTP id mp12-20020a17090b190c00b00211ab5635e6mr13788592pjb.159.1666398417659;
        Fri, 21 Oct 2022 17:26:57 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:d6f0:dbbb:c195:162])
        by smtp.gmail.com with UTF8SMTPSA id y8-20020a170902b48800b0018099c9618esm4120291plr.231.2022.10.21.17.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 17:26:57 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tzung-Bi Shih <tzungbi@google.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] MAINTAINERS: Add drivers/firmware/google/ entry
Date:   Fri, 21 Oct 2022 17:26:47 -0700
Message-Id: <20221021172624.1.I119456791d197eb7d159f09e7479d8759008a954@changeid>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are mostly used for Chrome platforms, so group it in with the same
mailing list, repo, and (one) committer.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Per this conversation:
https://lore.kernel.org/lkml/af9c4bfd-d3fb-1c7a-fb38-0d8bbd507449@roeck-us.net/
Re: [PATCH] firmware: coreboot: Register bus in module init

I guess if this is fine with folks, Tzung-Bi might queue this up?

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9759eb08c57..ba57ef11c72f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8726,6 +8726,15 @@ S:	Supported
 F:	Documentation/networking/device_drivers/ethernet/google/gve.rst
 F:	drivers/net/ethernet/google
 
+GOOGLE FIRMWARE DRIVERS
+M:	Tzung-Bi Shih <tzungbi@google.com>
+R:	Brian Norris <briannorris@chromium.org>
+R:	Julius Werner <jwerner@chromium.org>
+L:	chrome-platform@lists.linux.dev
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
+F:	drivers/firmware/google/
+
 GPD POCKET FAN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.38.0.135.g90850a2211-goog

