Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6046E6C78DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjCXHac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjCXHaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:30:30 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4674C7EFF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:30:26 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o2so1098130plg.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679643026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOWL7nV1WlBQFqJTXaBmWX6r0g27OV1XFhs05mfe2aI=;
        b=EABt+4tBOHM6qSQxlsLxqb+XT+Hwp/d72DA0MeJKBv+BeWvSfxLUjroAGm9hNbDTv1
         GxaE0JU5UZSis7KTZO3FdT4DLvkGbHm8fWTCi1JilTAtkHHgDZweG8IoXfGPmQqB88wZ
         JkV2r1uz95QwXrFRwgYs3n3WiuaoycjwqLpCWf0rmLnPk0MgtUR75798Hgy8QBUElqKb
         b89CmAZ1D8tBe+GDOLRXtYrjT6zra/gO6dmo4NYv1N+D6S1CoW8Mx0C8dxE0XpHWN3aR
         NvrgzuRIQOxATxA5Jp+gu/Fd+PhdkTnSmzNQ7kePZqy9u0Vq/cniTqabew25iB+vu/no
         jhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOWL7nV1WlBQFqJTXaBmWX6r0g27OV1XFhs05mfe2aI=;
        b=Lokl/XtBPQbfq6lhtEjBsbVwZA/n3VrAaoA8DaVB39TxOB/YUzXhG+04lin1hPoj3r
         WgQRof/rHZ0IGlqfYXRkDwej0diXTjgb+5nj2ytQABWxbZ+zwZPU5j0eM+YACGFBWCDC
         8D/Uw+UQzvmZelyh2NzWhPtDx4nI1ApH1KePBQtvGeGf1lZUZIXOFYO0MUCrbeB/Ods+
         k4gCnVI7HUkye7cSj7cKkBRIpXj9X3C89dgkruXPnvlBkyCJnswK4PnwWoWZDvudDDdK
         jBc+Ik3J7KKPitYR4rtFf+jk53lwLi3qPHLOF6OIWE9DYl1RCOaxNsYVSI/12ABg7uFx
         bxAw==
X-Gm-Message-State: AAQBX9ftZJRQT4kBpuUZGJoGAtlOiFrgBnV3VXxS3rLFNfsDhjvxA/h+
        QWEuGFTaaX3tT0R8p77+hoA=
X-Google-Smtp-Source: AKy350ZQYyvfIYk6qrcUqaXS46146JyxyToFgIYTy+lVEiCidRMcRlLAA2i6lOgtg9nsUhEs4z1gBw==
X-Received: by 2002:a17:903:2948:b0:19c:f232:21ca with SMTP id li8-20020a170903294800b0019cf23221camr1555972plb.3.1679643025745;
        Fri, 24 Mar 2023 00:30:25 -0700 (PDT)
Received: from ubuntu.localdomain ([59.89.175.90])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709029a0c00b0019a75ea08e5sm13511604plp.33.2023.03.24.00.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:30:25 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH v2 0/3] Staging: greybus: Use inline functions
Date:   Fri, 24 Mar 2023 00:29:49 -0700
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

