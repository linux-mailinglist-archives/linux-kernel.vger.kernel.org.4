Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E7F68C7CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjBFUkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBFUke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:40:34 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2607D81;
        Mon,  6 Feb 2023 12:40:33 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B3B20CD0C5;
        Mon,  6 Feb 2023 20:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675716031; bh=5RRvYyn2+IbH78AOiuxm88Ly4DvIYhNYnqRBGSCNfRw=;
        h=From:Subject:Date:To:Cc;
        b=IF3Z44jnfBMetmSL0fDm5QVpJYX94wIVNbmTYWYx5n0Um7BcD6yC42ZeOEjBdKuGo
         JdSRJkdXEYGxLDe5mPrwmzO8mr0N4hpL52+D575VvGhyS4rPEHGlh7df2OANptGmGM
         IhOHmqM+bQKURJ/zqSpHnSlhY1PQWLIvs7gQQfZQ=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/5] Add support for some features on OnePlus One
Date:   Mon, 06 Feb 2023 21:40:13 +0100
Message-Id: <20230122-msm8974-bacon-features-v2-0-06bb83c20a58@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK1l4WMC/4WOOw6DMBBEr4JcZ5ExhkCq3COiMJsluMAmNhA+4
 u4xFGlTvtE8zWzMk9Pk2S3amKNJe21NAHGJGLbKvAj0MzATXKQ8EQI63xXlVUKt0BpoSA2jIw8
 5FqlQqpRYXFmQa+UJaqcMtof+Rtv91DwW8NH9UesdNXo+9x9V4Fb7wbrlvDMlR/p3eUqAg+Syb
 LI8QyHxvqZmGON5WVm17/sXb3jsYeMAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=5RRvYyn2+IbH78AOiuxm88Ly4DvIYhNYnqRBGSCNfRw=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj4WW6wDdP+/DDIoEA+MNoHXklP4dMglEcpgoOg
 za2olKKiaSJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY+FlugAKCRBy2EO4nU3X
 Vn4CEACHP57zudLBvEI0Y8z6J00xbnxu27AV5Yq1EHjjrDmcyKzy+3bsx5rd6gjVIz4X78yu+E3
 uXSNvfI9LHphOrVc2q2OLKaWlBfQ08APWrnMo4MzCNXhksu3myIFda0n8l8mFkxIfZXpa7etZa2
 CXucEw3m246mo7r6RZLcC81a4GZa/5FM5cVYOMIi2rxvrCK+vnem9Y+kCzkZE/Mo9JrRFkDMfyo
 4Ga2+0fOuyu7RfNdStGajwr4xUORE4RTg3mq3sMcq4Qx6ehY8/6ASYP7Dg0AivjHh9JsHAbzoEf
 L/eQUsjW8ntEyYM0XciRaeU2R8P+LBqwEpaeEqsRBr1/frh2Ex2lDYd6aaHH/dDIR4WXquaD+Ep
 EFNao94Of3TGDdUzgULK/8/uKopHmbbKlF7T3fpzsRElbyaAN5ifWaaJCt7eFPnWmkgW9b+HpCb
 0eRvOqS2RAud7/ybE4VB1yGaEDEfbziSxOxPcc+MugLknKh6Nv/jRlVwTHz6Wl5CBtMg5FcdEYL
 XDPGFc/AvR+DG+WRMt4BXFQvtOqRTAdEklPpjB8D0HlLi+7afKZ96ID5cFutvRyFefysEOHlZ+Y
 iQZf5EXPMXLaE9onHWZQzlMWc6ZLkfJMtv69Zcwx5VdNI1eiqNGO1x1qbBSDk9jBFFnsFVDzgu0
 BL2dSTqDwz6DvGA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the vibrator, volume keys, hall sensor, backlight and
notification LED to the device tree of the OnePlus One smartphone.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- 3/5: improve order of pinctrl* properties, remove unnecessary newline
- pick up tags
- Link to v1: https://lore.kernel.org/r/20230122-msm8974-bacon-features-v1-0-4049f565c24c@z3ntu.xyz

---
Luca Weiss (5):
      ARM: dts: qcom: pm8941: Add vibrator node
      ARM: dts: qcom: msm8974-oneplus-bacon: Add vibrator
      ARM: dts: qcom: msm8974-oneplus-bacon: Add volume keys and hall sensor
      ARM: dts: qcom: msm8974-oneplus-bacon: Add backlight
      ARM: dts: qcom: msm8974-oneplus-bacon: Add notification LED

 .../arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 96 ++++++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  6 ++
 2 files changed, 102 insertions(+)
---
base-commit: 2be7ea9924c3f827342d01ebbdf414df8ccf97d7
change-id: 20230122-msm8974-bacon-features-6c832aa94c87

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

