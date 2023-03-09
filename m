Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054A76B3222
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCIXj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjCIXjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:39:48 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084F4F602D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:39:38 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id cf14so3984878qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 15:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678405177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LfbdnVACOXWFKvpaR6ZYYYKh9TQ65GrCLW0cjjoDSa0=;
        b=WA0SmQ8OfAc6yStQQzRy5viQ3UelwGn1Y2JR6spqAbgzUhYkK4WVrLggh3T6UCL7/j
         u0UCfA0h9Ua/91H/YgVZ5L5K888s1eghGDtydQvvWRItf8c0ak0BD9431LXhMoDsCwNA
         j4zhNs1QYW94OAgREY99n7RtimhcJsRnqJ+erlv+Ui3qEbK+tvCo0UD3mWOYo6dHzxxj
         /nuBmhPmhBOYrkh4ysw6xYaeMLBOxtDesgKkFxrtk9b1WEq83jLbVgm8ohv9XDgwiYx2
         XRbejbIC820iGw/upjltd3zKHCoJdpqAxQTPoQkM4IB/UXxko2NukNfurDdZc4woTy56
         kTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678405177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfbdnVACOXWFKvpaR6ZYYYKh9TQ65GrCLW0cjjoDSa0=;
        b=zvGQ80WbfeXqOHUnFne23Z6jlZxDRgI4is9zfV4DVCLt7V5PmkEsU4pgIvXhtg/2s3
         vLagWIo8N70J5oPnPBeVAVKr6EI8iJZrgb1VL6qm6Pa2P3NF8aeJ/3D0I68OLygdgJDB
         sP3mGZkAaiyfsdyEyXAVWt4xdptWo3D+aEVbP0/L3zzLHFIBRU6eABID00lAKvYMu9rl
         rD5jNZkiUwsXh+yOb8/WA9PlNj7Va0+kPygaPcgnu9izPX5VXDzEZdLarOOCJdpB+jY1
         3Cw3CXkX9neIL7Gd65ybat61rsW5AHU8d3zSmKSTMMdsA1kGlJv3AQyTZHPYeEgndBzK
         NTcQ==
X-Gm-Message-State: AO0yUKUCdLEf2pmJ6TjFwPptSq/CI5+QroZNyaMdw3Y0w5ROhjJEPOrA
        kgFO8pdTM8x2mvDmP8I5Fiy9PQ==
X-Google-Smtp-Source: AK7set/27O+VSg6eKWmrbJko17JKICop1H/qgTd9axOzbCFp0BbNbvNJCnXLLr1NlzhxXCCittxG8g==
X-Received: by 2002:a05:622a:4d4:b0:3bf:b614:bcba with SMTP id q20-20020a05622a04d400b003bfb614bcbamr42639391qtx.42.1678405177170;
        Thu, 09 Mar 2023 15:39:37 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id g12-20020ac842cc000000b003b68d445654sm253547qtm.91.2023.03.09.15.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 15:39:36 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] gpio: pcie-idio-24: Prune superfluous license boilerplate
Date:   Thu,  9 Mar 2023 18:39:29 -0500
Message-Id: <20230309233929.3998-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
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

The SPDX License Identifier line renders the GPL boilerplate text
superfluous, so let's remove it.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-pcie-idio-24.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 8a9b98fa418f..92e693b69fc8 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -3,15 +3,6 @@
  * GPIO driver for the ACCES PCIe-IDIO-24 family
  * Copyright (C) 2018 William Breathitt Gray
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
  * This driver supports the following ACCES devices: PCIe-IDIO-24,
  * PCIe-IDI-24, PCIe-IDO-24, and PCIe-IDIO-12.
  */

base-commit: b96eb88f59c023bb27891b5ab3dbd2b1a5200d53
-- 
2.39.2

