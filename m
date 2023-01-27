Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9DD67E304
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjA0LT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjA0LSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:36 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C543EFE9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:14 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bk16so4641336wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQE11Epg7pwFwOSfMPibr6rBB+lGqfS8IaEFKxhRKRE=;
        b=fsEVZCnwmRE1p2kJ7Dxy0Zl+EUoA8psCnOlqnZRnyIIqEWPv8N4HVLfFEJXGt7mqSi
         PwXBeYUwaAMCZ5QrK7xxx53F7SWQXw05PlJgBrNKTcv5RQCqHrn2RZmowKj0vWOrvdD2
         bGiV5C9UHJu5QfGgsJgV+8nEUaSC/WRR0pfPYCL0sXl/V3oRJFtIFYGYu+gcQokXdm3z
         54d17hP1j7AJjhEJqWbY6LfzK/W61csBprcUu/wvSUDspiopjMYcKsluysPapCBhCxvf
         Kd5qE2ww9kAG+pepUde0PWKwACtinDCke/ST/42gEzFXPhpRWcWGcj4unTIai5PkF2me
         un6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQE11Epg7pwFwOSfMPibr6rBB+lGqfS8IaEFKxhRKRE=;
        b=P5MCTYKe+zQLngRaXLATj2I9rSSLNNX1Hk1eVP3yHT5G3+WU8OZ5YWzMvOeWEVQMDe
         htnd8M77E9t63s7RNGmdnN2oCN+1WQ8Fc1bt9lXB2HCabKLQ3pExXZDyw6ugXMmcTk4n
         fTT1S0f9Ji9/qNuJSuvnO+GM1aaqtg/Y5p9lQ0CPUZF9LSrbDfhKKITSpF1bmEo7p2qS
         wLuW7UEkHl0MS2ssfsmicRH9/jecb9sNXwnITCLYdp0GHhpmEB6Elzxiz75v5GQ7SQ2g
         t+5OFvcEUd/K6O2913GQBM+5iWVRJ5TASmW7pVDYw8lhW+0ygAnmQVA4ZdfI1/uNN86X
         risg==
X-Gm-Message-State: AFqh2kpMFwOpuA9gOJ0x67lElCJsgMKKRHVqChuPZL0FetQYRankH/CF
        HAgw4ZKdXYG+C6q6iLNb/RyKmWM9wAP9Ki4g
X-Google-Smtp-Source: AMrXdXsiiyEw8plRfODAQaSAsN2edE/DvCV2TfgIpm2/1vuEsyRlkTwVLxmQy/9Uc19L/UUYiHGYgQ==
X-Received: by 2002:a5d:6f03:0:b0:29a:c631:e761 with SMTP id ay3-20020a5d6f03000000b0029ac631e761mr37574019wrb.43.1674818292239;
        Fri, 27 Jan 2023 03:18:12 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:11 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 24/37] MAINTAINERS: add myself as sl28vpd nvmem layout driver
Date:   Fri, 27 Jan 2023 11:15:52 +0000
Message-Id: <20230127111605.25958-25-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Add myself as a maintainer for the new sl28vpd nvmem layout driver.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..70aa4547d784 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19178,6 +19178,12 @@ F:	drivers/irqchip/irq-sl28cpld.c
 F:	drivers/pwm/pwm-sl28cpld.c
 F:	drivers/watchdog/sl28cpld_wdt.c
 
+SL28 VPD NVMEM LAYOUT DRIVER
+M:	Michael Walle <michael@walle.cc>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
+F:	drivers/nvmem/layouts/sl28vpd.c
+
 SLAB ALLOCATOR
 M:	Christoph Lameter <cl@linux.com>
 M:	Pekka Enberg <penberg@kernel.org>
-- 
2.25.1

