Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFD46C8C95
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjCYIYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYIYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:24:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80C92D49
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:24:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z19so3910665plo.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679732658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Da0bkbbQlx1cEs08lUYN3fUFt8qfcR/cqaYyxH0QCRI=;
        b=S8LFugRHYwHLsqlFp4TiYTxTrzlBTJU3W9ZYzdP9TSNebZ3xugCXzOJAuEoceScAfM
         W3afFKTdAfyaaB1/BXWjHmGGPgXR/0rUoquLqS7AijFf6JfkaRz+l5tiKDKIoLH7XOP8
         xVTrwC0oV3wTBzfCU+yJc8ot5T0IkjisKaUcuMl4zw8rZ6KQn02NEt6nJfHkojIZnARb
         VIlINZ2DWrcVGbN23EK/awQb6Wb2rLmQe3xTo8ZpvLh9jhQaeGE6pDcNhqeHXQMiiMqK
         BYmltWHS7uZLZfh3FM2Pce3d84j7R+D+fnz/wMdml4nk9cLl+QqOYuFVqkCfK7BidYhu
         CYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679732658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Da0bkbbQlx1cEs08lUYN3fUFt8qfcR/cqaYyxH0QCRI=;
        b=O8vePnJqFyM80ZzHsOSHT0X96YDJvGwYX9KIQAy0GUaj1UfMqp8/sDAxvYD+RYxanD
         H7hYXcWxJuf13xLpzNZ7/+uUBv05jHTfLvf45GRjiH9tGEi0QZjSfY/yvobyymvHv4nR
         z2HwBNIYY/8aPeuxVKEUl58QK3kFWsvzLKUsqT6aCqP2WFdE+JRaI6RKicA+xFYLjpvT
         801CVkOCwdpOTraLZyh2eVes8GlCx32BBQfc/LgsuwG+w9WgxDpWDOhSxbg6BkOlcBzM
         nje+gEqrFKYJPdBqkDjejA3HThJ40eAHNZfJj1ordWLjwlIqiUL3X+Wwc6ljQ1H+w76t
         19Sw==
X-Gm-Message-State: AO0yUKXEBxyVvd1b1CdfbrVEdAIXWlnH7Nr1NWxUgey2x3RkuDFFVsKJ
        NT/mDXgtJt+FSZ9XxA56s2U=
X-Google-Smtp-Source: AK7set+llncqGBAhJvP94FYyzOGTMhdMpyTZWZW6uXjdxRoCGo9tZBxcSO6MBhAfVzbCitYTSnuZNQ==
X-Received: by 2002:a05:6a20:729d:b0:dd:e036:37e4 with SMTP id o29-20020a056a20729d00b000dde03637e4mr7209642pzk.2.1679732658165;
        Sat, 25 Mar 2023 01:24:18 -0700 (PDT)
Received: from ubuntu.localdomain ([117.245.251.101])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78105000000b005938f5b7231sm15035875pfi.201.2023.03.25.01.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:24:17 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH v3 0/3] staging: greybus: Use Inline fuctions
Date:   Sat, 25 Mar 2023 01:23:30 -0700
Message-Id: <cover.1679732179.git.sumitraartsy@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Convert macros to a static inline function, to make the relevant
types apparent in the definition and to benefit from the type
checking performed by the compiler at call sites.

Changes in v2: Change patch subjects, noted by Alison Schofield
<alison.schofield@intel.com>

Changes in v3: Change patch subjects to length 80 chars,      
noted by Alison Schofield <alison.schofield@intel.com>

Sumitra Sharma (3):
  staging: greybus: Inline gpio_chip_to_gb_gpio_controller()
  staging: greybus: Inline gb_audio_manager_module()
  staging: greybus: Inline pwm_chip_to_gb_pwm_chip()

 drivers/staging/greybus/audio_manager_module.c | 7 +++++--
 drivers/staging/greybus/gpio.c                 | 7 +++++--
 drivers/staging/greybus/pwm.c                  | 6 ++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.25.1

