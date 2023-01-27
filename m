Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2DD67E81B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjA0OWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjA0OW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:22:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19151EBF9;
        Fri, 27 Jan 2023 06:22:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q5so5157072wrv.0;
        Fri, 27 Jan 2023 06:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsNJy+GU45M4gqqGe7j546WHUfWrvkBMHdyS3JEiglU=;
        b=crilyzytrBUZbv6+nVwitkdCjIA12LZW/POFk8tvMhZkQP94rYK2CDq72Zxj74np+E
         v7HIiMVIeTZV09kordZ+NA331vuZPgQaLxbssd6o+8k0d6HSM0Q00fz7DQpc4Zo6e4Ha
         Hl7eDhWE2ldOcYaAzvZWigII4zhfMSJTvo2IRthet0VhYjm/RHY9AXS6h12rlG6uKKij
         43tjB3WNlrQQzN6JsfxyNQLHzptn3DlHlau62mzG2kme8U70ryFfrx2qzKe8jgCT9lk7
         6462EeU5LL8mTiRVNs85BzvNTs68Nw/PuniUA7lRrgCpHXumyZDsnxy0qH97BV4nkkvP
         fHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsNJy+GU45M4gqqGe7j546WHUfWrvkBMHdyS3JEiglU=;
        b=5h70KtyQkufR93rMQ7bTI/5mjh/Wf+hwjBZbudh+iQ+Upy8xS2aq5MMRchcXZ/LAf6
         vsqe0fm6FuLktRROa8BqP6FPqFiNwIyoShEdg8McBsUN0sGXT+IH/YvVRgXahxMerpfH
         oHrxiw92I/74NGVsk2fJp6jgWM3w3brYfSEc0jf8qiaNNLCPEKLYVM29gFuD4md2FPr6
         vrdBHNszH8i3e+3Ae5g8h/iFVBQu9+vKztLHeXLbLYrYXrIGmG13p7kCT9HtyaUe6rJR
         0HJmY5X9OAppB435MuigUsNyBmcGQ8UtVc0xrV0UDTdPNv9Fj3W3GMxdFJFSnXN29VQk
         H6DA==
X-Gm-Message-State: AO0yUKU8OUrIY35ZTdJmhkqcMdiEaQSl8nbiBb/Vzx5BTqTL8aTM+0ub
        e/uR/hnarRlQppVaHDrF/Yo=
X-Google-Smtp-Source: AK7set8dCLtWin3Sq5pR4hSdcD9vBqCvZZyIgFgubS0gGdbSFOtl78QOeKviHTo1yZoG3TKibdAuww==
X-Received: by 2002:a05:6000:1204:b0:2bf:b33b:fb7d with SMTP id e4-20020a056000120400b002bfb33bfb7dmr11490015wrx.61.1674829346355;
        Fri, 27 Jan 2023 06:22:26 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c11-20020adfa30b000000b002bfb5ebf8cfsm4301039wrb.21.2023.01.27.06.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 06:22:25 -0800 (PST)
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
Subject: [PATCH v2 0/5] arm64: dts: meson: fix BPI-M5 and add BPI-M2-PRO
Date:   Fri, 27 Jan 2023 14:22:16 +0000
Message-Id: <20230127142221.3718184-1-christianshewitt@gmail.com>
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

The first patch in this series fixes an SD card (re)boot issue on the
BPI-M5. The second removes a redundant status from the sound node so
we don't carry it forward when subsequent patches convert the (fixed)
dts into a common dtsi, then add support for BPI-M2-PRO which is based
on the BPI-M5 board design.

Changes from v1:

- Added patch to remove sound node status in meson-sm1-bananapi-m5.dts 
- Added Krzysztof's ack to bindings patch
- Revised meson-sm1-bananapi-m2-pro.dts to remove sound node status
- Minor wording changes

Christian Hewitt (5):
  arm64: dts: meson: bananapi-m5: switch VDDIO_C pin to OPEN_DRAIN
  arm64: dts: meson: bananapi-m5: remove redundant status from sound
    node
  arm64: dts: meson: bananapi-m5: convert dts to dtsi
  dt-bindings: arm: amlogic: add support for BananaPi M2-Pro
  arm64: dts: meson: add support for BananaPi M2-Pro

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-sm1-bananapi-m2-pro.dts |  97 ++++
 .../dts/amlogic/meson-sm1-bananapi-m5.dts     | 428 +----------------
 .../boot/dts/amlogic/meson-sm1-bananapi.dtsi  | 435 ++++++++++++++++++
 5 files changed, 535 insertions(+), 427 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi

-- 
2.34.1

