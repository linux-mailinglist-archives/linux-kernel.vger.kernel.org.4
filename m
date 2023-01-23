Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49971677D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjAWOH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjAWOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:07:25 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF03EFBE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:07:23 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so8641523wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fMK/+RMwR61EzRWy37zhx+HZF9yxvaCOnadqFz7PJVw=;
        b=CM0oF444X+aiG/eAAfU0knzXf6q2ftR8sHRJ8V0RejWsFpHX3FCCyzj01HX+1++CZV
         uNmAr8rUeVhaMPUXrwAOg9d+0sKIiMh16Fc3wSZrUEeORQztIpm89kg+mKWmqrAKSkE7
         0CRqR/f2W6z2MY4kxFhF1RWweemt9/0Zx7TU3ru5FL7ycTSe5WLYgpH9A2vs0+YKMiLJ
         Mb3ZRCHEf9XFbu+aQzUhrn8lUwEZFXylevywtMKfzXm7cZT6lpE0v2IqXufMVyBNa0UG
         6P3mzHiGL6qgA63HBybmQQFA1TOZlZGa6RnKf3wFscxfL1rBl1baf9Kdl5DAqyczAsKH
         /IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMK/+RMwR61EzRWy37zhx+HZF9yxvaCOnadqFz7PJVw=;
        b=TCZmKWPTGZ/VDxsolcX0CeXSEzGrifWVrJjTM96Jco33pkfI2s0mml0ltlGRTyctXH
         kNRjIXsot8TeoHfBPysZ12y/cS6cL0QcA1qHoYD4WFQQ8qZRFAKFd8O9fylP0lmfi8Lh
         GOf21kuwvSIYvTSBrvuHSCQNY7+94m/DGwJLxuYZvinYHVinF1iOCNywlIMOpg4zkA6U
         nMt7dltRlZ3dDSzkEP+0LSCV+tfo/mcOEgBLD69Bic57R0uuM5hEhwXFfG578hLDTeZw
         a0lTYWhiXROcopDqqGollbuzAlZmZgVNMZs9q3VS6YT/mXjfbRiGBRAdz17pE3FGN+zy
         h+TA==
X-Gm-Message-State: AFqh2kpN1pg2yfaBTE5R9z4YltDukvS3+UfmWCB1hf1TCkPIZGUUw9J9
        2MQjLCJsc90xgi9fE09Gobmnng==
X-Google-Smtp-Source: AMrXdXtJfkW4hbK0327mqFk53zxLlnRblI0rDrk+cXT98CF5YwUFKDniiT98vVncOHdBgU0uXWowvg==
X-Received: by 2002:a05:600c:4f45:b0:3cf:68d3:3047 with SMTP id m5-20020a05600c4f4500b003cf68d33047mr24275228wmq.41.1674482842339;
        Mon, 23 Jan 2023 06:07:22 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003c6bbe910fdsm13841655wmo.9.2023.01.23.06.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 06:07:21 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] arm64: meson-g12b: add initial support for Odroid-N2L
Date:   Mon, 23 Jan 2023 15:07:15 +0100
Message-Id: <20230122-topic-odroid-n2l-upstream-initial-v1-0-1ce5e08039d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJOUzmMC/x2NQQqDMBAAvyJ77oLZCrb9SukhJmtdSDeyiVIQ/
 97Q48xh5oDCJlzg0R1gvEuRrA3cpYOweH0zSmwM1NO1d0RY8yoBc7QsEZUSbmupxv6DolLFJ7z
 xMI+DG+8UHLTO5AvjZF7D0kq6pdTkajzL9z9+vs7zB8agXNiIAAAA
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Dongjin Kim <tobetter@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODROID-N2L is a variant SBC in small form factor and some peripherals
are removed from ODROID-N2PLUS based on S922X SoC.

- On-board ethernet is removed      
- On-board RTC is removed        
- USB 3.0 hub is removed, so one USB 2.0 and one USB 3.0 host ports
are available                                                                               
- Huge heatsink is replaced with 40x40mm heatsink, 5V active heatsink
is recommended or a tall passive sink is optional                  
- 3.5mm earjack is removed                                                                  
- IR remote receiver is removed                                                             
- MIPI DSI port is added

So achieve this the current odroid-n2 dtsi is moved as odroid.dtsi
and only the N2/N2+ changes are kept in the odroid-n2.
With this only a minimal changes are needed to support the Odroid-N2L.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      dt-bindings: arm: amlogic: document Odroid-N2L
      arm64: dts: meson-g12b: move common node into new odroid.dtsi
      arm64: dts: meson-g12b-odroid: Add initial support for Hardkernel ODROID-N2L

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dtsi     | 448 +--------------------
 .../boot/dts/amlogic/meson-g12b-odroid-n2l.dts     | 125 ++++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi | 445 ++++++++++++++++++++
 5 files changed, 581 insertions(+), 439 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230122-topic-odroid-n2l-upstream-initial-8e4f741792c1

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

