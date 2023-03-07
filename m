Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6716AF8A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCGW2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjCGW1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:27:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C433EAF0CC;
        Tue,  7 Mar 2023 14:27:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id da10so58555317edb.3;
        Tue, 07 Mar 2023 14:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678228021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8gjcCprh0YtfA6Dnk0t8C1b7TfZOQ0dz/8SnTGInkFw=;
        b=GX5tKBTUsIR1Y3f5WlAlOygrvh+AjgsTKfFdsV7j8TjOfzu0KDs1huN4yai3/K4+xV
         lLuyCyS4mhgtbXMUf/mhycv6ttOCbPvsWfDL/+Jq39lzsmsvVJTfNSmjEhzEkBzxO1JC
         +KgOysHLqNB4zgqjqI/XypqKidEGESmCUr7CklJsULGF5bugnyfUpgLbi5KKoYalOMuo
         X9kSmaV+RWFZ4SzjBhzWpA8Om5u/CQ8T2kgwUz5nH20C1zEMMzALEq9oA4po/+CUKDrE
         S8KrBg6/NB6KsnPkxR1nmTEgoOkLzCwvW441q825numITyeG8TGOM/9qVwoBq3xa1FfP
         KdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gjcCprh0YtfA6Dnk0t8C1b7TfZOQ0dz/8SnTGInkFw=;
        b=is29HrHSmRpTyA4UUsdfFSiAa7n6YXL9RmqefNlwQMdDCEpQvWCBk9/cr8F7iWPwld
         uHYwCjDFGDu5GTTdD5KPAUM8UiwahjOZobOYvGckLa8rZuXD9W2f4MeUDpGIhGsGEuIm
         Si4Eew3HCYmgM1DVWfXc3nxT+QhM0527g+SZ0VeqxrHWGdLJguRF5R3AadsxZWlgEKa0
         rjANtvrpVd/e6DkAW0oA79PmOXFExwC3PdKt6PipgA0HZzfCttiXFzW08aVB2pdjnFlq
         2QSAIsPjg4PLcN2XXE+vrSUawRwQ2WmRpbb8dZGXesPzLSTEgdBzDdETbdtvrCA3fjK8
         fA9g==
X-Gm-Message-State: AO0yUKUl5G9ZVTFsly7r0vOexLuAEwxqtI45wIhUCMkCR6OSxUVr8Pzo
        jcPWhD86EAZ2FQszQvUCLDIa/5HT9Bg=
X-Google-Smtp-Source: AK7set+1wRh2vgznuNAkSHl6cmRUMN6CNrWvNayb33+wDRXF+1iPXKb/NZPh5Uroj+Zs8Mmntku6nQ==
X-Received: by 2002:a17:906:dac3:b0:8a9:fa2f:e440 with SMTP id xi3-20020a170906dac300b008a9fa2fe440mr21240590ejb.55.1678228021589;
        Tue, 07 Mar 2023 14:27:01 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c485-ef00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c485:ef00::e63])
        by smtp.googlemail.com with ESMTPSA id t19-20020a170906065300b008be996c1630sm6669412ejb.39.2023.03.07.14.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:27:01 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/3] meson-uart: Use "divide XTAL by 2" bit on G12A
Date:   Tue,  7 Mar 2023 23:26:48 +0100
Message-Id: <20230307222651.2106615-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

Changes since v2 at [2]:
- simplify the dt-bindings patch as suggested by Krzysztof Kozlowski
  (thank you!) which actually uncovers an unwanted change


[0] https://lore.kernel.org/linux-bluetooth/3B9D4DB2-D2CD-44FE-817A-F6EA8A0AD734@gmail.com/
[1] https://lore.kernel.org/lkml/20230222210425.626474-1-martin.blumenstingl@googlemail.com/
[2] https://lore.kernel.org/lkml/20230306194223.1869814-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (3):
  dt-bindings: serial: amlogic,meson-uart: Add compatible string for
    G12A
  tty: serial: meson: Add a new compatible string for the G12A SoC
  arm64: dts: meson-g12-common: Use the G12A UART compatible string

 .../bindings/serial/amlogic,meson-uart.yaml       |  9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 15 ++++++++++-----
 drivers/tty/serial/meson_uart.c                   |  8 ++++++--
 3 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.39.2

