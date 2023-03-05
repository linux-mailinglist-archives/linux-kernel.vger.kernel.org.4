Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E86AAFDE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCENUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCENUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:20:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F08011655;
        Sun,  5 Mar 2023 05:20:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l25so6336374wrb.3;
        Sun, 05 Mar 2023 05:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q22ZwtQznlTgrwEVXTJZ6qwfUdxTbmV0QrtKqsGsNBw=;
        b=RYQ1PbzN70fP9d3SxckyvuhAi2CMCeqcdUn5RtItTe+w9clgA6PRoSqUsYibZ4IJUO
         KHhZnV0kglgJkZ0IPOtCcopMYh1k5CO3gjdq8SK4Wjcr86jVwnePeUWAwd4rWKWH+48t
         y+ZATTgxktoZPQn8WVQCCF7nt1K+4GDJplwZiaWvu9oqSuOyqXtHmsxNOQsYDHHuwghe
         UxEBcUCCXT/K3A+AOP2qvbZLz2BLrZE43KppBnq4M0NU1kNHQHbrUWCwQOqdv0uI1eWs
         kZxRdRwPtVVopaC2gypbphRejS7HFjJZPoxLpTSH6IGyqhC9i4WKIKVfq1IudJN1HIVn
         AiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q22ZwtQznlTgrwEVXTJZ6qwfUdxTbmV0QrtKqsGsNBw=;
        b=dllNj4qMIEleq2PAUTTrgxGhTDN0wa7xU1uebs6Dm/SjH2KzWDxaj7j4zMg6TBAysE
         mX3ILhfU3NC4bIL6/bHTAdit7YWjuv1whdPRxi4qRtislf67mWD+tRi76abHhTCGoKCU
         4geAtg2PRiVpDPXPzs1QPoTSU9eCYEFEeVUKZNlHo4DMwJZnZbxotodIliYdSHf2f3Vq
         NofwcP2zqL3LfaUvVoyweJiVfO5yoj/FYSkl1K66PI1oEGZV7quFs97HerixAL8VYWsv
         xId1nc2IfV8gFkXQZQcKCElvB0y9DPkzeKIXrdeItvZGxiOoylIceTvpbh1qowY/MusH
         65bw==
X-Gm-Message-State: AO0yUKVmv6wY1AU9GuZAvRL3Vl7Utoffmm1q7w/2U5CWxQAJP4OZKsPT
        +tYVtQt/6+w3MGgzk73aOTQJ91xYHwTe+A==
X-Google-Smtp-Source: AK7set8Ye/Z1fJCh+7BzqtGuZwJtqJwh6OxsXP/yRsY60Qpkgebjr7drzUVqfdH1uhG7Iy2zrHxO1A==
X-Received: by 2002:adf:f849:0:b0:2c5:7c26:c2cc with SMTP id d9-20020adff849000000b002c57c26c2ccmr5495387wrq.29.1678022449684;
        Sun, 05 Mar 2023 05:20:49 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d6087000000b002c567b58e9asm7496851wrt.56.2023.03.05.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 05:20:49 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/2] arm64: amlogic: Add initial support for BPI-M2S variants
Date:   Sun,  5 Mar 2023 13:20:42 +0000
Message-Id: <20230305132044.1596320-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the BananaPi M2S which ships in two board variants with
the Amlogic S922X or A311D chipset. Schematics for the board are not
currently available from Sinovoip so the device-tree is largely derived
from the Khadas VIM3 (also S922X/A311D) and other recent BPI boards that
have public documentation. The device-tree also supports the RTL8822CS
WiFi/BT module. This is optional so the nodes must be enabled though an
overlay or fdtput.

Patches are based on current (v6.3) for-next branch.

Christian Hewitt (2):
  dt-bindings: arm: amlogic: add support for BananaPi M2S variants
  arm64: dts: meson: add support for BananaPi M2S variants

 .../devicetree/bindings/arm/amlogic.yaml      |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../amlogic/meson-g12b-a311d-bananapi-m2s.dts |  37 ++
 .../boot/dts/amlogic/meson-g12b-bananapi.dtsi | 521 ++++++++++++++++++
 .../amlogic/meson-g12b-s922x-bananapi-m2s.dts |  14 +
 5 files changed, 576 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d-bananapi-m2s.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-s922x-bananapi-m2s.dts

-- 
2.34.1

