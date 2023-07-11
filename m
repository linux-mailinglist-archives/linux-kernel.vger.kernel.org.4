Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B8E74F3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjGKPhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjGKPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:37:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67621BD7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:36:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso61395385e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689089804; x=1691681804;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZhsmjYq3QjlwNHWIt4GGjxBOJJNeRrC5x7e3BBvxJY=;
        b=F96F2sEJ06nYUYyN/zyNQaw/pCUKMgCuLABXL817tYt88ibRnJPBMiY09enxC3XWrn
         I/kPoyrW30PE3dKPsAzlOyrqYHz+JyQLFs81bRb8ENp7xq6PoFEiJADIAXoeBEGy8xUy
         o3olorhn/tOdh9Ms3JmoJFZ+5u9h0dMpSnlmGvmQUkyZs7EWCl0Gjohro230l963goXx
         W/kVZwDkMoleduYSUTxenbIng1+0xGKEItEh4HSY2PjqqYVqtwfqmGNWFSuZG0+WxiOX
         slmX5CscYscYP0xaSVYLz3G9cvdF48sU3F/vW/fhbSWDfhAKSz2uGBkcTNzz6RvCUZPG
         SKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689089804; x=1691681804;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZhsmjYq3QjlwNHWIt4GGjxBOJJNeRrC5x7e3BBvxJY=;
        b=cyZUwTyC/YZVLxUWlWuuvsLJhUvzk8oeQ2QQCzhDMb7vAasDMXzjDmhzMhSsUuzEIR
         cAMhBSwLA/z4Hja9tjtQSxMzKkoHk67jh7dXKHDPNdxrMNB7/xAapHzkXZeHngN3s/3t
         uXGncqfMkfFYA+XdqiyHSs/q0JDXIgVphr+b2V/cS+I7Rr1zsjyirDQ4KS+e3lYYJd8v
         CLYv1z4vMhqe50ZomVnJcuTTf2WlE5/2NIiA4hAkDyNJGad0uQ4F1YU9UmQj4a0CKfRc
         OQ7AJ59gKSfOBdy2x3WrW7jCWAnqOnTjF49FX4jDqlgwy41Af5uJMqWR6vWwbiJXYxKL
         G0NQ==
X-Gm-Message-State: ABy/qLbVg1PoYou9v6xGpR8ZqwlCB8Vzv45p45g88q+76nSbBJuZG3oT
        4GM5vkfCC98qyO+Tr/tCERyzqg==
X-Google-Smtp-Source: APBJJlGZ9q49T7kmNKB1c37rwITt5wN6ld5+e/7kQyfM4bvBhWm7eitmkW7SIN6+Kw+F/jP/uPTfqQ==
X-Received: by 2002:a7b:c019:0:b0:3f7:f584:579b with SMTP id c25-20020a7bc019000000b003f7f584579bmr13703893wmb.9.1689089804070;
        Tue, 11 Jul 2023 08:36:44 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v6-20020a05600c444600b003fbb1ce274fsm23458249wmn.0.2023.07.11.08.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:36:43 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 0/3] Add startek-kd070fhfid015 display support
Date:   Tue, 11 Jul 2023 17:36:26 +0200
Message-Id: <20230711-startek_display-v1-0-163917bed385@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPp2rWQC/x2N0QqDMAwAf0XyvILt0Dl/ZYyR2qhhpUrixob47
 wt7vIPjdlASJoW+2kHozcpLMfCnCoYZy0SOkzGEOpzri/dON5SNno/Eumb8umvTpdA2YxsRwaq
 ISi4KlmG2rrxyNrkKjfz5b2734/gBYFObAHYAAAA=
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=zxoNkkhxg+qIZpTjwjGcbJbbjcuZjCmWKqPfmbpNbvo=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkrXcK9p5lesXkclNpI2GO8vx9IXvx9+574xhKLYKi
 wSF834OJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZK13CgAKCRArRkmdfjHURSg/EA
 Crxlkf0UGRqKF5KavZ7sr4JCyLFmB/5GQogqNk3v1vhrz35svHdt13bVypxZmp+YRh/JN4IG7dGEpE
 +kkYjBrJ35C7lyQjZDrMM2ZQWkA3bH3ugOz8r2fPGaf3AjoPZbT6D7U85m1BG9cq3LJ5tPSlMY/1PE
 E8UY1ZSiHRy8CFoFyaaFdA0+d78z7dfkDhHvsIu0O57coedYThVQxi+f39jZXse2P4xEiqj3DsWWK8
 GesIGWeCKs2agEQzNDmup33oHhkbgAxAuZMb6XwnqKUXceLytNRE7/hpaF1M0HRXuwrxCzpf6XXQLr
 Y9erzL+UMvkksoL9FZvF1ONohW0oXXH4/FMs7RvfEGB9yh17x/0EevYyOi7ZKnnGFhaAsQcxL1Gim5
 rCg9P0rCLLFrAehiP3rjACy6G4Hm7GQTkhmMW+IrDOumZ0cO39q5g8jfk9jglUQjIYX0AzUOT5rci7
 gEYLqD4oaWo+8ZRoE72G6Vf6SEnLx+JSZAkikVC13hZAXyAaBZ3VSYv6jiK4mJ2co+tfROudLoCr1J
 OIXqYsdLjNcTsEYT8MYrvGM7SjIHe54i7hLjX/f6YJaFBACtnEIRXrqGNfZjfebbB3QnC2nzq8Lz0s
 Ft4dhdH9i+G+RKLj5+2tP6AgB9zZWlD1It9wKr7or2xNvAo4RmMzrYxvSGRg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support of the Startek KD070FHFID015 panel.
It's a 7-inch TFT LCD display with a resolution of 1024 x 600 pixels.

This serie come from a bigger one [1]. Then I addressed the previous
comments for the related commits here.

Changes in v1:
- Fix typos in the driver.
- Merge 2 regulators in one bulk variable in the driver.
- Remove backlight enable/disable from the driver because it's already
  managed by the backlight core.
- Move hardcoded values from function to the generic structure in the
  driver.
- Remove unnecessary function (stk_panel_del).
- Replace some functions by macro to increase the readability.
- Link to parent serie: [1]

[1]: https://lore.kernel.org/all/20230220-display-v1-0-45cbc68e188b@baylibre.com/

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Alexandre Mergnat (2):
      dt-bindings: display: panel: add startek kd070fhfid015 support
      arm64: defconfig: enable STARTEK KD070FHFID015 panel

Guillaume La Roque (1):
      drm/panel: Support for startek-kd070fhfid015 MIPI-DSI panel

 .../display/panel/startek,kd070fhfid015.yaml       |  51 +++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 .../gpu/drm/panel/panel-startek-kd070fhfid015.c    | 434 +++++++++++++++++++++
 5 files changed, 498 insertions(+)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230711-startek_display-958d265f6baa

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

