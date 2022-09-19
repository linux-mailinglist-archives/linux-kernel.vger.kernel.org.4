Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516A05BCA0F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiISKzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiISKyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:54:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7011F2AC6B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:50:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso4297125wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=zt9/L7mv46x+tMkdan6S1TWVTWPJHerYZbSiTiF39Bk=;
        b=eGlGfPlVwAfj5fVHptbsSk3lNVQfRHcbdNcnYKmguMxticjb3UzOqlD0Hs1hdq/xUt
         mJAmis2r01KXGfo3ilQL2XfqKzGxOzcZt6BTJLzSS6aw7ycwpx63Hq/J25yco8+XCoZR
         r2H6vrFqjLFbI2xsDIPj3/5F/pp2HZ5dS8PLxfCsu0CMXHcpAiczDk5Ns/R2n56cNAZe
         MzcUPPrGyPpDmKtbRK00ZL1Rdv8JT69Z7ziTEJzdnpt0s+jmNWQehcczL5y+Qe1xQaBP
         imgt5Jng/8QP1PbBXVdBiCLMEOeePcf2Rad/pu35UdwOy0yC1wSh6OIzlmU0oa6dO2kl
         LaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=zt9/L7mv46x+tMkdan6S1TWVTWPJHerYZbSiTiF39Bk=;
        b=QQp742ukz1Mzfgd6OpiJjknSfQrXl2fqJ6NtKjWfJO90iHBE2EAWeW4QWbGTkKLQza
         rZ9Rwp01JSww2aVqjnhV6XxX9eddg37Oyk2zSNm69DlhRtIWN20W4fw4ArXaNwD+dTnM
         yFU+ru57RzmQnrXzWvODB6ktav4mZ0TbedX73XTnkhuYzsQrKv9O2nYX7WxGAMCNZjFm
         r1vq67n45nQ7F0W9/XMSTNQMDk1H78CL6NIj6tTSf8xJmr3mC8V99IbRNQF26wx3astI
         Sa3YPZtcivAAbqfEE8r8eSkh3r3eOdS1apd1oLeDK6TwWhPx9611rArJkse7GAn52FAO
         0dKg==
X-Gm-Message-State: ACrzQf3b7PnZ8+nRKaU6fijrsEpH2PNzx7WOvcXpVPWSWMQwqh+FerA/
        z4lGry/Bl5nUYRLIb4l+GAo=
X-Google-Smtp-Source: AMsMyM7O37kNCtN4XEKZro5zQsRxPHEhO5SYR8+u84l1OSSgFdbTICmLLc9gdww8tJ5CmvfAVAXtsw==
X-Received: by 2002:a05:600c:4f0f:b0:3b4:c09b:37c5 with SMTP id l15-20020a05600c4f0f00b003b4c09b37c5mr8865197wmq.181.1663584617271;
        Mon, 19 Sep 2022 03:50:17 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id ay9-20020a05600c1e0900b003a5c7a942edsm13427829wmb.28.2022.09.19.03.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 03:50:16 -0700 (PDT)
Message-ID: <3b915692-c8a9-c508-5a4a-0fdb49355e99@gmail.com>
Date:   Mon, 19 Sep 2022 12:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Peter Chiu <chui-hao.chiu@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        trevor.wu@mediatek.com, Tzung-Bi Shih <tzungbi@chromium.org>,
        YC Hung <yc.hung@mediatek.com>, YT Lee <yt.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: [GIT PULL] arm64: dts: MediaTek updates for v6.1
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Olof and Arnd,

unfortunately a bit late, but hopefully still in time the updates for the DTS 64 
bit.

The most important updates are support for the MT8186, up to now only the EVB, 
but I hope we will see more board with that SoC later one. Apart from that we 
have a huge update for the MT8195 supported IP blocks, especially tied to the 
Acer Chromebook Spin 513 series.
Apart from that we have some more support for MT8192, especially for graphics 
support.

Regards,
Matthias

---

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/ 
tags/v6.0-next-dts64

for you to fetch changes up to 5ebb14aa5a193b3a6a5c359bdd4d3573cb14bdf1:

   arm64: dts: mediatek: mt6795: Add CPUX system timer node (2022-09-15 18:18:53 
+0200)

----------------------------------------------------------------
mt6795:
- add add system timer node

mt7986a:
- add wifi support

mt8183:
- add MDP3 and keypad

mt8186:
- basic support for the Evaluation Board including, i2c, usb and uart.

mt8192:
- add nodes to support PWM, MIPI transciever, display with GCE and DSI.

mt8195:
- disable nodes not used on all boards
- Add support for CPU freq, clocks, power domain controller, spmi, scp.
- Enable audio decoder, DSP, IOMMU, mailbox.
- Add display nodes for vdosys0.
- On Cherry based chromebooks, enable the system companion processor,
   Cross EC, Google Security Chip, secondary MMC controller, trackpad and
   a few regulators.

----------------------------------------------------------------
Allen-KH Cheng (6):
       arm64: dts: Add MediaTek MT8186 dts and evaluation board and Makefile
       arm64: dts: mt8192: Add pwm node
       arm64: dts: mt8192: Add mipi_tx node
       arm64: dts: mediatek: Add mmsys #reset-cells property for mt8192
       arm64: dts: mt8192: Add display nodes
       arm64: dts: mt8192: Add dsi node

AngeloGioacchino Del Regno (8):
       arm64: dts: mediatek: cherry: Enable the System Companion Processor
       arm64: dts: mediatek: cherry: Wire up the ChromeOS Embedded Controller
       arm64: dts: mediatek: cherry: Add Google Security Chip (GSC) TPM
       arm64: dts: mediatek: cherry: Add keyboard mapping for the top row
       arm64: dts: mediatek: cherry: Enable secondary SD/MMC controller
       arm64: dts: mediatek: cherry: Enable Elantech eKTH3000 i2c trackpad
       arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus
       arm64: dts: mediatek: mt6795: Add CPUX system timer node

Fabien Parent (2):
       arm64: dts: mediatek: mt8183: add keyboard node
       arm64: dts: mediatek: mt8183-pumpkin: add keypad support

Jason-JH.Lin (2):
       arm64: dts: mt8195: Add gce node
       arm64: dts: mt8195: Add display node for vdosys0

Moudy Ho (1):
       arm64: dts: mt8183: add MediaTek MDP3 nodes

Nícolas F. R. A. Prado (1):
       arm64: dts: mediatek: Add missing xHCI clocks for mt8192 and mt8195

Peter Chiu (1):
       arm64: dts: mt7986: add built-in Wi-Fi device nodes

Tinghan Shen (9):
       arm64: dts: mediatek: Update mt81xx scpsys node to align with dt-bindings
       arm64: dts: mt8195: Disable watchdog external reset signal
       arm64: dts: mt8195: Add vdosys and vppsys clock nodes
       arm64: dts: mt8195: Add power domains controller
       arm64: dts: mt8195: Add spmi node
       arm64: dts: mt8195: Add scp node
       arm64: dts: mt8195: Add audio related nodes
       arm64: dts: mt8195: Add iommu and smi nodes
       arm64: dts: mediatek: Fix build warnings of mt8173 vcodec nodes

Trevor Wu (1):
       arm64: dts: mt8195: Specify audio reset controller

Tzung-Bi Shih (1):
       arm64: dts: mt8195: Disable I2C0 node

YC Hung (1):
       arm64: dts: mt8195: Add adsp node and adsp mailbox nodes

YT Lee (1):
       arm64: dts: mt8195: Add cpufreq node

  arch/arm64/boot/dts/mediatek/Makefile           |    1 +
  arch/arm64/boot/dts/mediatek/mt6795.dtsi        |    8 +
  arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts    |   38 +
  arch/arm64/boot/dts/mediatek/mt7986a.dtsi       |   23 +
  arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts    |   40 +
  arch/arm64/boot/dts/mediatek/mt8167.dtsi        |    3 +-
  arch/arm64/boot/dts/mediatek/mt8173.dtsi        |    7 +-
  arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts |   21 +
  arch/arm64/boot/dts/mediatek/mt8183.dtsi        |   75 +-
  arch/arm64/boot/dts/mediatek/mt8186-evb.dts     |  220 +++++
  arch/arm64/boot/dts/mediatek/mt8186.dtsi        |  819 +++++++++++++++++
  arch/arm64/boot/dts/mediatek/mt8192.dtsi        |  200 ++++-
  arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi |  256 ++++++
  arch/arm64/boot/dts/mediatek/mt8195.dtsi        | 1072 ++++++++++++++++++++++-
  14 files changed, 2765 insertions(+), 18 deletions(-)
  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi
