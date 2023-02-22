Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8A69FD70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjBVVFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjBVVFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:05:23 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7EC43904;
        Wed, 22 Feb 2023 13:04:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b12so35740875edd.4;
        Wed, 22 Feb 2023 13:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jHzJivt9HpdLxfhNJzT2EOfp00j8BcuasYYwqjK38/E=;
        b=kZTwyGEiPrvsEohuvq8Lu5GaxX8jse1emt8D2g/FYBDH1UIDsSTs323t9g12L1xCjB
         PZ8uINek2hJc+PBs5jvn3GhmdNZEJ8FpkQCxwdTVA6ny16ddgi73/FYftBpvJSlg35xr
         xfJlNpj2ZhMhUDVDiF4wdMq83VupBzVujksL/ELDgq5pQ7CCzT5NqWC7ydCQT3TuCmEL
         Ou2tKRIKMiET2bbGDKfhkMN+jzsuqELy834V0nYHbuh/Z65UBDN/TTvaohmku/wWujdQ
         BHcbXcglk57Pgx6bY6e9TdKV05ilK0jpkY6JemEFdYUtubrYtAjx/w/WFr1/KiDFKtkW
         novg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHzJivt9HpdLxfhNJzT2EOfp00j8BcuasYYwqjK38/E=;
        b=uTcL1tjCJIYp5sf5PYAYQqJYQugCYy9oPZw1+raVtBfDjvISqnCMcrPm/dHcDdeb3H
         8kwbItIw1dBC1+PgtWde3NYn0FNrnlvmgQUmZf4Pz0cTa2TZnJJrQ+6G3+WS5QFxtM+k
         1022S+iMUw2ws3Ua9IPa9HqZId1YHSlD3X1/0pJYBT88a3Pgv2TpSebuIAgTfyLT8m9K
         XT6yBhayIB3rD+NZeQ0nVEW3WAu2HbGrjV6b1eoQeXL5FxR3RxbUP/pRZw66jzXvxf6h
         FaQTIWCt8iU2lWOl9YNCxcD6DMevAbrGYgCmMkI9uuZAzlLKJTWai1+TLGisB6WvmK/c
         2O1A==
X-Gm-Message-State: AO0yUKXDoG6QTLn6RO4gAM25dE3AymoYnTrA+UBSK2FKoei5j1SfAnh/
        FcBAwezENqzD0qk0se+B22b4QtfPmbNnDg==
X-Google-Smtp-Source: AK7set8hkdfsi2LjDwLjtOhQuQIIFKuh9ziV22wwpO8xn5kqBWL0aL5POTZXLTeWhP0ZvK2q9sOm/A==
X-Received: by 2002:aa7:cf03:0:b0:4ab:4d3c:7e99 with SMTP id a3-20020aa7cf03000000b004ab4d3c7e99mr10214265edy.2.1677099879661;
        Wed, 22 Feb 2023 13:04:39 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-76c9-eb00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:76c9:eb00::e63])
        by smtp.googlemail.com with ESMTPSA id m17-20020a50c191000000b004af6a840f21sm209208edf.15.2023.02.22.13.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 13:04:39 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 RFC 0/3] meson-uart: Use "divide XTAL by 2" bit on G12A
Date:   Wed, 22 Feb 2023 22:04:22 +0100
Message-Id: <20230222210425.626474-1-martin.blumenstingl@googlemail.com>
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

Why am I sending this as RFC? The last change in this series means
that the resulting .dtbs are not compatible with old kernels anymore.
My understanding is that this is fine and only the opposite case (using
old .dtbs on new kernels) has to be supported (which is still the case
with this series). I'd like to get some confirmation for this.


[0] https://lore.kernel.org/linux-bluetooth/3B9D4DB2-D2CD-44FE-817A-F6EA8A0AD734@gmail.com/


Martin Blumenstingl (3):
  dt-bindings: serial: amlogic,meson-uart: Add compatible string for
    G12A
  tty: serial: meson: Add a new compatible string for the G12A SoC
  arm64: dts: meson-g12-common: Use the G12A UART compatible string

 .../devicetree/bindings/serial/amlogic,meson-uart.yaml |  2 ++
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi      | 10 +++++-----
 drivers/tty/serial/meson_uart.c                        |  8 ++++++--
 3 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.39.2

