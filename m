Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F616ACE51
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjCFTmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCFTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:42:44 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6010F410AB;
        Mon,  6 Mar 2023 11:42:43 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g3so43485447eda.1;
        Mon, 06 Mar 2023 11:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678131762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z+GtrP50ClS+yrVjigTcYvahRDjB91lP84G8BhbbLw=;
        b=L5yaZyqQAqAJDW+QUsHCnIdu8qj+PwacftONoG5XVTRfx/PJ7O1YgshZuPgiKFp1PY
         3qhW/g8kVkJ2FHzaZ4aUCEWjAvRguu4sIOV4CXnD0XkP7+DgPg7ItmJXusbaAPqBAJIJ
         QI0mPoG1k7MRXgUHPDh2x4J5ReqXdMyrond9BRwG1QqWjU4iRbsp21q07Z2P161tfygz
         BxtfN9ELSimOnWDRkT/UYbmWlqpn3OdxiLI0tUYBkqE40ran/DS8Hl4r6SEqzrR9R0VC
         bT32W69H7ajDn4B0+FUroE8vQAVhoQPsAJWU8l6L+5Ddt3i4czfXwNjO2mlomBFYT2c8
         WPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678131762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Z+GtrP50ClS+yrVjigTcYvahRDjB91lP84G8BhbbLw=;
        b=o5fP0L5tmJz2KaxmJv3HU50Q+qexcR7JNrWqn0AxLbLgSvCw43mlFdbl8cIhpe21/3
         Ks5fJnh1PvN0jVr0TJdwH72wTFAg0OFQZ62QkLnFOryf3oaNBW5iYHrLpo5DljOwhyKk
         E2OWzluk6CE8RI/TtQuFCItHRA2zHgBzkIX1gtBgOh/IIZk87uJkPHyue5O6NwxoGAG8
         tv7Iq0lT7xbOlBj+6qxflKVyp0h1Y9BwP7w8PdXjmUofkGcxtWACUHBqecu/Qxzkxcp2
         kU/1SKCw7c6qSVgBBR/mfFPwTzDXgFXr5sNSzq+A6SmsKEaA0BEM87QUIT3FNGekqWcs
         YaJA==
X-Gm-Message-State: AO0yUKWFebU52yebXetoQflAKoEjZvMlD08LK/NJpOEdTR4A+UiHQ/jk
        QbM1hPOJ1UI97KVoKdonCTs=
X-Google-Smtp-Source: AK7set+YhHmTNUp0BxTCGqqhHIHPg4d4XnCf5954Z5j+ADn5+NDGqhQ4XmPoGv6+bBHUthc3E7tgLg==
X-Received: by 2002:aa7:d34a:0:b0:4ab:7f0:1865 with SMTP id m10-20020aa7d34a000000b004ab07f01865mr10886471edr.5.1678131761732;
        Mon, 06 Mar 2023 11:42:41 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c405-5c00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c405:5c00::e63])
        by smtp.googlemail.com with ESMTPSA id e19-20020a170906315300b008f2b0c6052csm4951868eje.89.2023.03.06.11.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 11:42:41 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/3] meson-uart: Use "divide XTAL by 2" bit on G12A
Date:   Mon,  6 Mar 2023 20:42:20 +0100
Message-Id: <20230306194223.1869814-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.2
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

This series improves support for UART attached Bluetooth modules on
Amlogic Meson G12A and newer SoCs. These SoCs also support the "divide
XTAL by 2" bit which (greatly) reduces jitter when generating baud
rates such as 1500000 (which is used by the Bluetooth part of the
RTL8822CS SDIO WiFi and UART Bluetooth combo chip).

Without this the baud rate calculation is based on the XTAL clock
(running at 24MHz) divided by 3 (meaning: 8MHz). 8MHz cannot be divided
with integer division to a 1500000 baud rate. Using the "divide XTAL
by 2" bit however means that we can achieve 1500000 cleanly, without any
jitter.

In future we should allow dynamic switching of these UART controller
internal dividers to pick the best divider automatically for the
requested baud rate. This however still requires the new compatible
string - which is added by this series - to enable the "divide XTAL
by 2" logic on SoCs that support it (G12A and newer).

Changes since v1 at [1]:
- make meson-gx-uart a valid fallback compatible string for the newer
  meson-g12a-uart
- rebased on top of v6.3-rc1


[0] https://lore.kernel.org/linux-bluetooth/3B9D4DB2-D2CD-44FE-817A-F6EA8A0AD734@gmail.com/
[1] https://lore.kernel.org/lkml/20230222210425.626474-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (3):
  dt-bindings: serial: amlogic,meson-uart: Add compatible string for
    G12A
  tty: serial: meson: Add a new compatible string for the G12A SoC
  arm64: dts: meson-g12-common: Use the G12A UART compatible string

 .../bindings/serial/amlogic,meson-uart.yaml   | 28 +++++++++++++------
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 15 ++++++----
 drivers/tty/serial/meson_uart.c               |  8 ++++--
 3 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.39.2

