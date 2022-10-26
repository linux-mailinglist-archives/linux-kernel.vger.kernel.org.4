Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729AE60D87F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 02:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiJZAgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 20:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJZAgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 20:36:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54819ABD42
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 17:36:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q9-20020a17090a178900b00212fe7c6bbeso644159pja.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 17:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ailGgiiFtHdwB/nG3A6RiLx4EUpdrg50HC30U8xGLo=;
        b=U4atFBeXIc700OXYSkV+KwBvVmXl3d+nTjYQtI8gEOUrvetsC8P04b8H0OQorM6Ux0
         kX7YLqRHhSemkPbJJy5yb43nmMPLVgzMfdLYIazdQb7zhbJqp2v/xUjx0Is9qieVh1vp
         6QObeDiWZp2fM8N9aJp+esZK9bHSWbPbawhqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ailGgiiFtHdwB/nG3A6RiLx4EUpdrg50HC30U8xGLo=;
        b=oZ2l80WLJjCrEN3g7J3s/MDPkcwlu6PiSZimtx5qquBdcrYQ7WMtikppW6Y1N1J7h7
         t7nsL3fHJcJxjEaiJjCGwgMV483cOtenoRo3Rim2tAnzc8fp6OcXNNL+BmdKD3j+fdFT
         lMjJeBc/Q1uF+DzdkCiQ7wg1WqD8BwNld73qs1jBg6KJZaSRFRrox1OOJwM1D2CqUEUX
         zimAcUiMTPoj8w9YWDHKjqPS1DVBS68lBPNo774JRTKCtqE6h1N99TvLE1Qs8MD/U/zA
         Nc7Pc8p03Fje5WBMrSGzfeu1HK/WFYYo75FTyR6/KpM7BVjKqeBB3LteuRp+VPf4dpqM
         vURQ==
X-Gm-Message-State: ACrzQf3pEfIobymPdqAAetCxe7JvqcRPtG0mH9DeSaqdMLyTej2ke8Y2
        IGf3xK2aFPyZZrlQarnUWHL2Cw==
X-Google-Smtp-Source: AMsMyM6Y+OvWlp/mwC5JS0gAzw3xPKQzyO5Z2SGnJvfeHCyIr2nQ08DmZhECrHf5yBL7lUzZdHDvVQ==
X-Received: by 2002:a17:902:e5c6:b0:185:4bbd:17ce with SMTP id u6-20020a170902e5c600b001854bbd17cemr42003936plf.132.1666744603759;
        Tue, 25 Oct 2022 17:36:43 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:c1b0:de11:3d5e:16c0])
        by smtp.gmail.com with ESMTPSA id ik29-20020a170902ab1d00b001868ba9a867sm1717405plb.303.2022.10.25.17.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 17:36:43 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v7 0/2] dt-bindings: cros-ec: Update for fingerprint devices
Date:   Tue, 25 Oct 2022 17:36:39 -0700
Message-Id: <20221026003641.2688765-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces a DT binding for chromeos fingerprint
devices. The first patch tightens up the existing cros-ec binding and
the second patch introduces the fingerprint binding. As there aren't any
driver patches this can go directly through the chrome platform
tree or the dt-binding tree or the mfd tree. I sent it to the binding
maintainers in hopes it can go there directly but it doesn't really
matter.

Changes from v6 (https://lore.kernel.org/r/20220614195144.2794796-1-swboyd@chromium.org):
 * Put back into the same cros-ec binding file again
 * Gave up trying to make it use additionalProperties: false and added a
   comment instead
 * Made symmetric for the spi and rpmsg case

Changes from v5 (https://lore.kernel.org/r/20220512013921.164637-1-swboyd@chromium.org):
 * Split out to different binding file again, while using 'select'
 * Fixed examples to have required interrupts property for cros-ec-spi

Changes from v4 (https://lore.kernel.org/r/20220321191100.1993-1-swboyd@chromium.org):
 * Drop last patch that implemented driver logic
 * Drop second to last patch because it's not really needed until
   compatible is used.
 * Rolled cros-ec-spi into cros-ec-fp compatible to get all the pieces

Changes from v3 (https://lore.kernel.org/r/20220318015451.2869388-1-swboyd@chromium.org):
 * Drop spi_device_id because it isn't used
 * Dropped struct members for gpios
 * Picked up tags

Changes from v2 (https://lore.kernel.org/r/20220317005814.2496302-1-swboyd@chromium.org):
 * Dropped cros-ec spi dt properties that aren't of use right now
 * Picked up tags

Changes from v1 (https://lore.kernel.org/r/20220314232214.4183078-1-swboyd@chromium.org):
 * Properly do the boot sequence
 * Add a message that we're booting and delaying a while
 * Fix typo in commit text
 * Change binding to not spell out reset-gpios and indicate that boot0
   is about asserting boot mode
 * Split device id to different patch as it's a different topic from
   booting


Stephen Boyd (2):
  dt-bindings: cros-ec: Reorganize and enforce property availability
  dt-bindings: cros-ec: Add ChromeOS fingerprint binding

 .../bindings/chrome/google,cros-ec-typec.yaml |   1 +
 .../chrome/google,cros-kbd-led-backlight.yaml |   1 +
 .../bindings/extcon/extcon-usbc-cros-ec.yaml  |   1 +
 .../i2c/google,cros-ec-i2c-tunnel.yaml        |   1 +
 .../bindings/mfd/google,cros-ec.yaml          | 103 +++++++++++++++---
 .../bindings/pwm/google,cros-ec-pwm.yaml      |   1 +
 .../regulator/google,cros-ec-regulator.yaml   |   1 +
 .../bindings/sound/google,cros-ec-codec.yaml  |   1 +
 8 files changed, 97 insertions(+), 13 deletions(-)

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: <devicetree@vger.kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Craig Hesling <hesling@chromium.org>
Cc: Tom Hughes <tomhughes@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
https://chromeos.dev

