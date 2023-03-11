Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843BF6B56BE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCKA17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjCKA12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:27:28 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACAD144852
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:25:52 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s41so5529669oiw.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678494281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mUNQTVY5eUxEtGgiVP14QZ+ou44mulHJziOTXdxqLbU=;
        b=BC6lzsRIhhWkq+N7qS7JisZedC8v2IXl3aqCrXgYgSf6e/EGQCuo4t5Zucw8OEsh5p
         Dd0ZbGYKuQepBGuFK5QagiDU9DnjzhasUOdEEUv9o7IKPMT7foABcSNQd9Qmn/DNjUcl
         M+5IxVnrxfyQfWOiSrFv8gRMie4zEiDmKjqFs9aBbjtY0i8inJz9Nq2yslIypZHnA3/x
         8b3Bw9dqAqAujMfzB8bhQGNiPTWBnnreoCX4NIAbNZj0cVgbGuwPjNWNYmt2kM58OsMf
         nNXdadnH7T78kQ8HdKkmV/8EibKLFp4XsTdq/56edBiMBsr6/spGHEDiv/dwH604G7B2
         U9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUNQTVY5eUxEtGgiVP14QZ+ou44mulHJziOTXdxqLbU=;
        b=dtQGhhW8aIwm2b+DQMlThKGx3xc8K66BSKCB0QHZc/EhA7LmIPJyWRPE8Q0cueC0bh
         9xsb7sZOwPIulsJluXunejq6d9YCSXRMlYBXVIGhlsX+6V30iG32fCAOcPgXaCkuyAgG
         LCoKigOWVfR5Ok2VD/C/0TH+bPAChYiyJoy8YxhWiLRbNuVPmW0vIfX6QfVZCnXRbFHJ
         qW+xwf5ZLFK068/TmGG5VkJYkmIFGICarbU6PsPeG+uQesn7H0HVOCFmqu7C2+Eb01h6
         RloNxQLQFIlgfS2TNzi7Svy95OAUaFnVVfFcmQu7MLoZzTR9Hl8BBQ1rnvjBpl7fWyuJ
         GnHA==
X-Gm-Message-State: AO0yUKXkHib4p5fkLxS+EQWKn4oaF2hZt/ndsC0TZ0p6Nf7agbptrTh0
        n6RyiEU9hQJxBGEjsGQ3V0xAC85vdaRqd7/Zhds=
X-Google-Smtp-Source: AK7set86oLL3zlOw1B3P42jO7jvfaFrcPc2hOGSzF4iFhj0B7mn8fWtdx95+A2FtH5DCQQZ75eluYg==
X-Received: by 2002:a05:6808:305:b0:36e:b867:76d0 with SMTP id i5-20020a056808030500b0036eb86776d0mr13193919oie.58.1678494281072;
        Fri, 10 Mar 2023 16:24:41 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id a6-20020a056808120600b0037d93a7e8f6sm473857oil.54.2023.03.10.16.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:24:40 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] iio: dac: cio-dac: Fix typo in comment listing supported devices
Date:   Fri, 10 Mar 2023 19:24:34 -0500
Message-Id: <20230311002434.8761-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver supports the CIO-DAC08 device and not "CIO-DAC06".

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/dac/cio-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
index 791dd999cf29..bb67d3340c9f 100644
--- a/drivers/iio/dac/cio-dac.c
+++ b/drivers/iio/dac/cio-dac.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2016 William Breathitt Gray
  *
  * This driver supports the following Measurement Computing devices: CIO-DAC16,
- * CIO-DAC06, and PC104-DAC06.
+ * CIO-DAC08, and PC104-DAC06.
  */
 #include <linux/bitops.h>
 #include <linux/device.h>

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

