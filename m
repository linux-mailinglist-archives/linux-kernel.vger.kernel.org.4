Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E156C628A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjCWJBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCWJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:01:41 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF831717B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:01:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id x37so12134714pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679562096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8RWJzOeM5GIaIf82zupXR/wrUWqvRt22D3jyGfDKRi0=;
        b=GT9VzWPWIi3fRiiTEQRqtMPzOf4UlHEtpXWnaON7ZeEB/MsGe1J2NYF8yO4jWTpa+B
         FDQV3dtv10AicBYCDB/kw4dhLuluZpSeo4pELv0kz4QwZ437E+CFPkbAktP56Z68kafx
         pl9eoxJaIMGEU+MxDRx2AeiYW560rczy2CdmHzR3iR7Udwr6HKFYfK8/2xHYyh4B6rw6
         hnQbxBujs2CSMhjGSR8KDudwUIzlEFct3Frk27NrUzCEGG6WfEI9/Jn0Z6SYnMJT5EC0
         xuUOiTtxrHodzem+fDQjMWr07zfXJvklPIPaKReyyu8FYIdkCtcTIrJm2FBO1YWJ8x/m
         IhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679562096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RWJzOeM5GIaIf82zupXR/wrUWqvRt22D3jyGfDKRi0=;
        b=PY/+WrJ6vW5rMaTozphqDucoXBrml0Im2ICnm1lLbdKWBJcHY7bk8fBxbpniYuapBI
         qld0ZVWh6LhvSlYyhkTl+iJNVfsQYpNwXUua17R6peDj/RWBebccsOFGRFw2VN9xoe+e
         ef4LusJ3l+KClMZMCWmu3971rEHNKIBRSgwA2ro85K52cS3R8JjHUWGdO940HoDOu/VV
         0bfhw/ruc/iGGR2hOPow4/eWnp6PVxiCuajf7t93ndy95TLIglMrYs9J1GjSR4YBWoHX
         sG1ukP4JiNER52213iRjpzDJ1tO/ZNubySSGIb/lmw/UIv0fd0xRGIcGVSqXogxjUVuA
         XhkA==
X-Gm-Message-State: AO0yUKUYkS5a1lG4/U8d6WFuTiRjdKJ8JB/A3T5ksoJK4uBnL4noOLqD
        +lTucgVdq1o/yzT5YszIc2lF46LLkZ1Bsg==
X-Google-Smtp-Source: AK7set9PXu7Uw9YhBNw4+ICSHXADaMDo6mZwCvehYYG3R5Lm9keHwVatsPeUKZXZPuWSWtZHu4/U5w==
X-Received: by 2002:a62:1d8f:0:b0:5dc:6dec:e992 with SMTP id d137-20020a621d8f000000b005dc6dece992mr5088682pfd.1.1679562095852;
        Thu, 23 Mar 2023 02:01:35 -0700 (PDT)
Received: from ubuntu.localdomain ([117.207.139.205])
        by smtp.gmail.com with ESMTPSA id i21-20020aa787d5000000b00625f5aaa1d9sm11346893pfo.83.2023.03.23.02.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 02:01:35 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH 0/3] Staging: greybus: Convert macro definitions to
Date:   Thu, 23 Mar 2023 02:01:04 -0700
Message-Id: <cover.1679558269.git.sumitraartsy@gmail.com>
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

Sumitra Sharma (3):
  Staging: greybus: Convert macro gpio_chip_to_gb_gpio_controller to an
    inline function
  Staging: greybus: Convert macro struct gb_audio_manager_module to an
    inline function
  Staging: greybus: Convert macro struct pwm_chip_to_gb_pwm_chip to an
    inline function

 drivers/staging/greybus/audio_manager_module.c | 7 +++++--
 drivers/staging/greybus/gpio.c                 | 7 +++++--
 drivers/staging/greybus/pwm.c                  | 6 ++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.25.1

