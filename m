Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C79C646107
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLGSbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGSbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:31:01 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6575E6A759;
        Wed,  7 Dec 2022 10:31:00 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1CC5FC4A3F;
        Wed,  7 Dec 2022 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1670437858; bh=+eYqdfhUQtkHlB+nOxralti44nmznPQ11lDL/KUnEbE=;
        h=Subject:From:Date:To:Cc;
        b=QOG1fAae5D76Ctxap/tWPvZNbs06s9chtxLjrHZGf+4IBM5RQtrhpquufJQHRMrhQ
         gGGThLlU0Bk1hHDCzNdzzSw/RhltQZ5uMwbvN31Elz4Cwk3Vk12IMeawSojREu1oyT
         88BWh33Suz5N9Btd6915CGLts0w1mUKKTHni5uh0=
Subject: [PATCH v3 0/9] Add a bunch of msm8953 dts files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAM3bkGMC/w3MQQqDMBBG4avIrPuDSYi2vU2SmdaATiFjpSDevVl+i/dOMmlVjJ7DSU2OavWjHe
 E2UFmSvgWVu8mP3js/zthsuz9iwAQHld8O3rPhCODXVDi6OTIH6nlOJsgtaVn6QL/rel1/3FkTnW8A AAA=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 07 Dec 2022 19:30:37 +0100
Message-Id: <20221207-msm8953-6-1-next-dtbs-v3-v3-0-a64b3b0af0eb@z3ntu.xyz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Cc:     Gabriela David <ultracoolguy@disroot.org>,
        Eugene Lepshy <fekz115@gmail.com>,
        linux-hardening@vger.kernel.org,
        Anton Bambura <jenneron@protonmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Adam Skladowski <a39.skl@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Danila Tikhonov <JIaxyga@protonmail.com>,
        Gianluca Boiano <morf3089@gmail.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Julian Braha <julianbraha@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alejandro Tafalla <atafalla@dnyon.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3677; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=+eYqdfhUQtkHlB+nOxralti44nmznPQ11lDL/KUnEbE=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjkNvZMqTNTSfhOxClEt1bhge+JyvK92AhPpZQ4fb/
 dBRreqmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY5Db2QAKCRBy2EO4nU3XVhoVD/
 918zncaubiVzxbEsWjIWUW1DiBeNDdpPPX60rXIRVFBQszXjwyx+tuti5mJBFBDjNDxr8evm9nyfjI
 6IoGtLgA0Qw2mFEqio7Rffx1uhVIlT9oqCHsm17uRcJYE6Hmwn3urWQagq1sI1CR40IuPiKPvBKHJu
 UYDM/Akk92Jl5A5Lxp+j8pBfmBZFdKxLIMi+mz94kb4/C63DS5WK9rFwVxzNePMH1bagkwlzKcvBCn
 LgclhWq5HDYWlgnOUxHH49WqoGKP2W4Yn+wUnjO4foQwPoSlhLycKJEKZFDQIQ3vg5vWmVk/FCu6sw
 QbxJcsdPtzx/W74C3EK3fxF9/aqtXyp64b+8sGKGUR0jFe3rO7v8CHCsR1XPkgoRL3iSRQuspSV+6N
 sVMWplUx1+vQQHqSqY4jaCqtzCuNtmwqQThd+o/6Ks1cKPnnj/FTTVKA0ECHFbtBu9AH8NXVSXDZ1T
 UQO3fpCre4uNN2kINx/QG4JKj12rv4N3ggt7BFTXIeQ10nvL3ovsEaPqVuUUmbopqTPdC7w3wVn5NX
 ESraEaPe1kVISwxNEMy+dMGCPgnD/RWd+NCh/UkoCf3iI8LFP4R34H77k+cKb4DXy9mHMPaFARunSR
 rjjBVljSaWuD4HSG/IExybKwJ4e+7Y6Xo5Vigyz33P8Nl+XHxWvQ9BLT3q8A==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=no autolearn_force=no version=3.4.6
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

[0] https://github.com/msm8953-mainline/linux

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Kees Cook <keescook@chromium.org>
To: Tony Luck <tony.luck@intel.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Cc: Julian Braha <julianbraha@gmail.com>
Cc: Sireesh Kodali <sireeshkodali1@gmail.com>
Cc: Alejandro Tafalla <atafalla@dnyon.com>
Cc: Adam Skladowski <a39.skl@gmail.com>
Cc: Anton Bambura <jenneron@protonmail.com>
Cc: Danila Tikhonov <JIaxyga@protonmail.com>
Cc: Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: Eugene Lepshy <fekz115@gmail.com>
Cc: Gianluca Boiano <morf3089@gmail.com>
Cc: Gabriela David <ultracoolguy@disroot.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht
Cc: phone-devel@vger.kernel.org
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

---
Changes in v3:
- Rebase on qcom/linux.git for-next
- Fix non-alphabetical sort of sdhc_* nodes
- Add missing supplies to sdhc nodes,
    align order between all the devices,
    remove some unnecessary pinctrl override
- Pick up tags
- Link to v2: https://lore.kernel.org/linux-arm-msm/20221119203758.888207-1-luca@z3ntu.xyz/

---
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

Luca Weiss (2):
      dt-bindings: arm: qcom: document new msm8953-family devices
      arm64: dts: qcom: msm8953: Adjust reserved-memory nodes

Sireesh Kodali (1):
      arm64: dts: qcom: msm8953: Add device tree for Motorola G5 Plus

 Documentation/devicetree/bindings/arm/qcom.yaml    |  19 ++
 arch/arm64/boot/dts/qcom/Makefile                  |   7 +
 .../boot/dts/qcom/msm8953-motorola-potter.dts      | 305 +++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts  | 325 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts   | 329 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts | 325 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts  | 361 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8953.dtsi              |  24 +-
 arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts   | 252 ++++++++++++++
 arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts | 291 +++++++++++++++++
 10 files changed, 2226 insertions(+), 12 deletions(-)
---
base-commit: ca14659da4341de75506516c16f66d84bf3f2fa0
change-id: 20221207-msm8953-6-1-next-dtbs-v3-df6cd5175dd3

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>
