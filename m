Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A679D6770C3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjAVQtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjAVQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:49:01 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C6D7D93;
        Sun, 22 Jan 2023 08:48:57 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 5F361CD0C5;
        Sun, 22 Jan 2023 16:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674406135; bh=wXbRIRGPjPCuTthCi5DIArKqGaYCXPMlKnIiOm9PSS0=;
        h=From:Subject:Date:To:Cc;
        b=mygQKx//E6ACYL6b+F/bah2CQYZBYs8F3Umnxj9yfpw52bg9V7pCel7oYqnt+RK8f
         +REJ2iIn0YlVGPqPhclqNbmAA6eYVXO8MonlxMmvs/l4QLLXHmbaSdsXDGhEXXigxs
         auRKYM3BWomTiSLgpC/KKKPEue2hX+wqXk22zUfE=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/5] Add support for some features on OnePlus One
Date:   Sun, 22 Jan 2023 17:48:32 +0100
Message-Id: <20230122-msm8974-bacon-features-v1-0-4049f565c24c@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOBozWMC/z3Nyw6CMBCF4Vchs3YMDASKr2JcTMdBumiLrbeE8
 O4WFy7/5Hw5K2RNTjOcqhWSvlx2MZRoDhXIzOGm6K6lgWpq64YIffZmHDq0LDHgpPx4Js3Yi2mJ
 eezEDFCw5axoEweZd36X6P+0PxK+3bLPlqST+/z+z5dt+wLyaWe/jwAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=wXbRIRGPjPCuTthCi5DIArKqGaYCXPMlKnIiOm9PSS0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjzWjxteT/0N0hylfeGfPdHa/U57kRJtii0oBjkBEa
 3iQ/J4uJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY81o8QAKCRBy2EO4nU3XVj3DD/
 4mYttEGRxCUc0Yb2Y2Nkcg2uLplFwaiujbrH+RGGEFXcUmW5DqpqCGCt7wCfC2V+6nKk6AGxbMLpEo
 F1TNvxbhBfLFxIB36LLUi7CtGgDReC0dHxWhVnTl8xx5CIqa79ln22rPtamdsWrSKHAIVS+e8QJbCC
 E7lJ8Q1Hu+SJmvNgHUzBMuQBicSHTF82Gp3Hq+bQvbaA3ioJI3WJghXezzrmE7AuYTMll7mPrawDDb
 gE3JohGShKPhAOQbUCC5eVjSjCDIqdNOZAFuEum/xVE9oE4F+hAB898J9WQRoHAoNLkI0DrB97mXZ0
 UhnWsFxaDjCSczoBKdAyK1iAg76IJWev6dkVTLiozgBlX5iZGsW9ykMZt6tlsFKtZc5lpP5EHNU0T6
 EBbN97+xrDZlxCtKggTrO8qJi5pbLSsfkehoEKwHqkKCRRFdTLmEtHbs6KK0UTfKAiz0YaYKj+exVY
 qhfoqTYMMORY2Gp8BC1NLMuPgse3U+9P48WhRfCUlHTzsvRT5uaCTL4SFmBaKQPiipCbnucABxZyB7
 Zk4HN+8G4C6+Ofd0/Yhaohqgql9tjYghgrNTedi62/vP+HGvBoUmyys9KxOM4KFEM0gg3qLUOtITYH
 98SlRQFB2vtElrMZHGzHHiP3gXdl51iYzuDwdEDvNyP8ewJJvMdCYiRC9ufQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the vibrator, volume keys, hall sensor, backlight and
notification LED to the device tree of the OnePlus One smartphone.

To: ~postmarketos/upstreaming@lists.sr.ht
To: phone-devel@vger.kernel.org
To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

---
Luca Weiss (5):
      ARM: dts: qcom: pm8941: Add vibrator node
      ARM: dts: qcom: msm8974-oneplus-bacon: Add vibrator
      ARM: dts: qcom: msm8974-oneplus-bacon: Add volume keys and hall sensor
      ARM: dts: qcom: msm8974-oneplus-bacon: Add backlight
      ARM: dts: qcom: msm8974-oneplus-bacon: Add notification LED

 .../arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 97 ++++++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  6 ++
 2 files changed, 103 insertions(+)
---
base-commit: 2be7ea9924c3f827342d01ebbdf414df8ccf97d7
change-id: 20230122-msm8974-bacon-features-6c832aa94c87

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>
