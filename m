Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5356C78B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCXHV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCXHV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:21:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C4C0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:21:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so779695pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679642484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOWL7nV1WlBQFqJTXaBmWX6r0g27OV1XFhs05mfe2aI=;
        b=olwZ2Ki+GEmXv8N44rzlIT2zwtZrcHbqmSfDZrbXOE8skrN/XFMRPXRh9BxqAVJvq9
         1h59VhF08YneFvX2/UjLzW4bZ7/UXKkuXAelK8CWyQB03bWYJVm0indIiCeivCqWiIVE
         o+OnA12bz4QBpDXQGGUwrBH05ESQoZx/s7vzQxklJnkFiNdNGCr1h3neQDr0Wu0ETgc2
         PE72AAVHb7QW7fiOdDKL6TeyoQTUu8ItQM9D8FJWEgPRHiMsfl+BJtHzPk589PplTlCD
         F+e588GFFMmS6wLKgeMHAsaf849OTPjNgVpt/segz0OhGb4iGQ5x4kZz4M3pJDHlMQKT
         Vm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOWL7nV1WlBQFqJTXaBmWX6r0g27OV1XFhs05mfe2aI=;
        b=7LCOZy83yo07amqZ6sv5wHYL5fsczOIsV+kyC1/4yn5HC6T131zyRQKsAobOa/WBpK
         /27NA0fhK1kjwxbpcZUOpiItFLgoQNtiTCS1wQS4/moDIZc1lHhgMwLs3yIqrv6Wsb9M
         BQx5HyUDW+nsTWP/PA1Wxcgv6xZSqLT5FiKrGwEcUfnGYGm+kS+uzbnuhbFPz002+8Xz
         tV4OiVEZKptANn6mPV8VJYVQ0SOsuFmmQOFCv8bg7+EEo49RMCzHz36OVeRLy0m28AdV
         lDG9Or42MNKF2JhJo8RqMBF/lu4MvjQIlyuTrrfFxhUM4LYp8eVY4a42tw7PL7ADFR4C
         FXUQ==
X-Gm-Message-State: AAQBX9fm5LKYMK9II0kPlRNmgxDgIOyzbMVSsW07xEZuQOtaZ3gOFTEM
        HRIgiINhN/IORKZEb5nW7wc=
X-Google-Smtp-Source: AKy350a0aAAwD586M+JBEnfHYwX+wsWJNpNqvuQFJGvV3/eCeLmSCS1tVDK+PQPJ/zSPsgvlzLYLow==
X-Received: by 2002:a17:90b:1c88:b0:233:f354:e7df with SMTP id oo8-20020a17090b1c8800b00233f354e7dfmr1835231pjb.18.1679642484576;
        Fri, 24 Mar 2023 00:21:24 -0700 (PDT)
Received: from ubuntu.localdomain ([59.89.175.90])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090ab88a00b0023cfa3f7c9fsm2362372pjr.10.2023.03.24.00.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:21:24 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH v2 0/3] Staging: greybus: Use inline functions
Date:   Fri, 24 Mar 2023 00:20:30 -0700
Message-Id: <cover.1679642024.git.sumitraartsy@gmail.com>
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

CHanges in v2: Change patch subjects, noted by Alison Schofield 
<alison.schofield@intel.com>

Sumitra Sharma (3):
  Staging: greybus: Use inline function for macro
    gpio_chip_to_gb_gpio_controller
  Staging: greybus: Use inline function for gb_audio_manager_module
  Staging: greybus: Use inline function for pwm_chip_to_gb_pwm_chip

 drivers/staging/greybus/audio_manager_module.c | 7 +++++--
 drivers/staging/greybus/gpio.c                 | 7 +++++--
 drivers/staging/greybus/pwm.c                  | 6 ++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.25.1

