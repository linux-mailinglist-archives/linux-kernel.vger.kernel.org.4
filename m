Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446F962C1A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiKPO5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiKPO5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:57:19 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432B428E03;
        Wed, 16 Nov 2022 06:57:18 -0800 (PST)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 7572EC4128;
        Wed, 16 Nov 2022 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1668610606; bh=KsW+8ENBtu4UJFdA+5lLI+Dz/2DZB+GaYC01A1U7Lcw=;
        h=From:To:Cc:Subject:Date;
        b=XxUwPzofsEE7PuNWDE1ZT9obfxoeFh5cK+KEr/pUwMq2MVWJ6DjnSIg1ZOZGTcnpn
         kHx7zp7fZXR1fp52oH1HOd9dqnCxDT+xh0t+kHf2/fZj6jYtJs+Dkha0D1bHDyBtk4
         po2A1SEohZck7zotkdGTXiSsqOV9XS5Wq/bz70hw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Add a bunch of msm8953 dts files
Date:   Wed, 16 Nov 2022 15:56:01 +0100
Message-Id: <20221116145616.17884-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add a bunch of msm8953-based devices that have
been created in the msm8953-mainline[0] repository, which includes
Snapdragon 450 (SDM450), Snapdragon 625 (msm8953) and Snapdragon 632
(SDM632) devices.
The dts files are trimmed down to what is currently supported upstream,
as a way to also minimizing diff for further patches.

I've tried my best in keeping all the relevant author tags based on the
git info I could find there.

*This series depends on pmi8950.dtsi patches[1]*

[0] https://github.com/msm8953-mainline/linux
[1] https://lore.kernel.org/linux-arm-msm/20221101161801.1058969-2-luca@z3ntu.xyz/

Adam Skladowski (1):
  arm64: dts: qcom: msm8953: Add device tree for Xiaomi Redmi Note 4X

Alejandro Tafalla (1):
  arm64: dts: qcom: msm8953: Add device tree for Xiaomi Mi A2 Lite

Danila Tikhonov (1):
  arm64: dts: qcom: msm8953: Add device tree for Xiaomi Mi A1

Eugene Lepshy (1):
  arm64: dts: qcom: msm8953: Add device tree for Xiaomi Redmi 5 Plus

Gabriela David (1):
  arm64: dts: qcom: sdm632: Add device tree for Motorola G7 Power

Julian Braha (1):
  arm64: dts: qcom: sdm450: Add device tree for Motorola Moto G6

Luca Weiss (1):
  dt-bindings: arm: qcom: document new msm8953-family devices

Sireesh Kodali (1):
  arm64: dts: qcom: msm8953: Add device tree for Motorola G5 Plus

 .../devicetree/bindings/arm/qcom.yaml         |  17 +
 arch/arm64/boot/dts/qcom/Makefile             |   7 +
 .../boot/dts/qcom/msm8953-motorola-potter.dts | 306 ++++++++++++++++
 .../boot/dts/qcom/msm8953-xiaomi-daisy.dts    | 316 +++++++++++++++++
 .../boot/dts/qcom/msm8953-xiaomi-mido.dts     | 331 ++++++++++++++++++
 .../boot/dts/qcom/msm8953-xiaomi-tissot.dts   | 317 +++++++++++++++++
 .../boot/dts/qcom/msm8953-xiaomi-vince.dts    | 330 +++++++++++++++++
 .../boot/dts/qcom/sdm450-motorola-ali.dts     | 256 ++++++++++++++
 .../boot/dts/qcom/sdm632-motorola-ocean.dts   | 287 +++++++++++++++
 9 files changed, 2167 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts

-- 
2.38.1

