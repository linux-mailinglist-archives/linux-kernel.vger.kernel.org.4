Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C8761EB6A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiKGHPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiKGHPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:15:14 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EF713D14;
        Sun,  6 Nov 2022 23:15:13 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id mi9so7538428qvb.8;
        Sun, 06 Nov 2022 23:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ConCPo0JgzXnifvtHayx2cdD1tHDcQM3uZHVa6AUFo=;
        b=GjXZhSSi7DJnPZOo9Qxid2itQILmmID1uNtDj50BdEN01L7zxOkmFuyFsJ0JEQGVJ+
         knabDzCESRfscOGUdl6W1EGv5L8mgudREwnp2YAs/wqWpJHw8+VH3JWJg4NQEe639TU8
         HEsRCHx27dY32oSDO7tSWb04Vma1WNS13uShoFsGXIWdYbiD4gielxuLPoyPtgoVs3Of
         ubvwgh5ZosO1eBKMQSHpFnI3Jp6ddnqoQ0+INYbN/LOehd5yrCwFvtkE5RL2Dm+njSwB
         64BmxL/4eSt3bxGs1zW1MFwFdmlMmG98HFUYBsDUKIsBpXlbRr9TG419brH7SbofQxx4
         8JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ConCPo0JgzXnifvtHayx2cdD1tHDcQM3uZHVa6AUFo=;
        b=GnI1jTZ2yxA4QVoSdpzwMb+xIR6YMBVkRWF3gMkPLhz9KZF1PDUYGgx2B4vYE/nKVe
         /psdl2URUdzdGov9tOM/8sfM+QMFBKYRmwQTw50nxuL8APMWRa5UAsqthh5515I7J2Dc
         687V+Uvlr6/pU+FqIMeFG8vftdZnMMKWgtj5RZP8aUsapOj8y4OQYBaNTb3PrbTbHugs
         1r4rN9KcjhjwdvuZipn9ZgMzId/o4dIUACRBpFOwQnrnOoUdRP20wZaHSYLGna6KMcM+
         sXTLftA/2xF9hahDRV5IfQxVzLNN84pBAYcntr5wT4UIk9E/C106+RwHyTlm52Htp/fy
         PVLg==
X-Gm-Message-State: ACrzQf0TcVtJU6iLyA6MInflvKAQ83vpjFQfHT/TccJ9jHEALPOu8IhU
        1ybps8abI4zL6n9Wh0jcNGoBZH8P4T0=
X-Google-Smtp-Source: AMsMyM6/9iKIN29/SQteS8iyAnmP0Ri9UTD+kzyEPbhKrlCLTG0MOAkrwwnN7PuD9Jy6OjM2fgk7JA==
X-Received: by 2002:a05:6214:19cb:b0:4bb:6a28:83bc with SMTP id j11-20020a05621419cb00b004bb6a2883bcmr44021707qvc.102.1667805313040;
        Sun, 06 Nov 2022 23:15:13 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-185-122.bstnma.fios.verizon.net. [108.26.185.122])
        by smtp.gmail.com with ESMTPSA id br8-20020a05620a460800b006cf38fd659asm6318428qkb.103.2022.11.06.23.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 23:15:12 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, sboyd@kernel.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com, fugang.duan@nxp.com,
        Mr.Bossman075@gmail.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v1 0/7] Clean-up and documentation for i.MXRT1050
Date:   Mon,  7 Nov 2022 02:15:04 -0500
Message-Id: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the initial commit of i.MXRT1050
many of the DT docs were missing; this patch adds them.
The commit also adds docs for i.MXRT1170.
Clean up dtsi.
fix all the naming of pins in pinctrl,
wrong due to a miscommunication.

Jesse Taube (7):
  dt-bindings: arm: imx: Add i.MXRT compatible Documentation
  dt-bindings: pinctrl: Fix file path for pinfunc include
  dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
  dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
  dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
  pinctrl: freescale: Fix i.MXRT1050 pad names
  ARM: dts: imx: Update i.MXRT1050.dtsi compatibles

 .../devicetree/bindings/arm/fsl.yaml          |  12 +
 .../bindings/mmc/fsl-imx-esdhc.yaml           |   4 +
 .../bindings/pinctrl/fsl,imxrt1050.yaml       |   2 +-
 .../bindings/serial/fsl-lpuart.yaml           |   3 +
 .../devicetree/bindings/timer/fsl,imxgpt.yaml |   2 +
 arch/arm/boot/dts/imxrt1050.dtsi              |  11 +-
 drivers/pinctrl/freescale/pinctrl-imxrt1050.c | 546 ++++++++----------
 7 files changed, 280 insertions(+), 300 deletions(-)

-- 
2.37.2

