Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C8F680A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbjA3JzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjA3JzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:55:13 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F7593
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:54:41 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y1so10479723wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9U1ZTbzVNvGDjx9Y2rZtYKxVbVuF1IxzESylxD9SMDY=;
        b=qv+Snhp5Ck2Wb4+1zs1Qrp40mQV2PdrP7qO0XgxvbseGgqXmN3RC/AfbkIsZD6uzKa
         HYvj20Ndu2YGrlopgwrysAypkykI7JpvTP3Ir1blCkk3hbQM2drbW4mkjPQT6HVdKZ20
         4adRwjCOlss+mp3rEM3d7/nkRxTqlYYDzxCzsj4lsZzkQltxSB/kGlKh6fmmLgKYVbDa
         Xay3t7mSfffX4Y48RlvViKCW3gd9fdhagJGsMhHp9y7ryidP1Cl0NjoId12Bgw3ckjPW
         rXR76TYvauZjbM5SBOWMRcPzgHS17/LMMWeYQcZx8yqB1KkW9o1uMK6O6qvzU4DxGG7J
         5CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9U1ZTbzVNvGDjx9Y2rZtYKxVbVuF1IxzESylxD9SMDY=;
        b=c8WHT3Kc2H+Mm9g+PmjRHmA1hbaPozh+LQz69d8beG/wgyVNbLrLLYfu7qbM43q9c2
         jzJMNXnExkdSQZttva10PxLMUk/hRBdO+gDZgn+esTw3B124fw6L0on1ILd5VmhL9an6
         DkW+TYEZBzCxSylGb8HDmc2ri1+Wm0gPswm8XBJ0YnEJ08BnBMCc+9s1eRQQPrXBWtV9
         VmA93fSb/lJG0hOJSWhAK6Wr+EmMmE28X+Jkek63nccc+1L5d+My9HLLSji7U9u68pdm
         bERDhi458TPM4FyTsmg1EXR9xnt3Wkp9r1uejz0acxpDtNqO5/SWWFqnUSjH+5vV7dpj
         wE2g==
X-Gm-Message-State: AFqh2kqQmuoo5WNvv0rEJQbQbFSdzwtN1yGBxQvBGdSvJSwOluGOY52a
        lUU5YYr4ZfdIfU0BdS3CAXJ9MA==
X-Google-Smtp-Source: AMrXdXuZhbwDg4rxLxEz1h2DBFskHhu+uVPU+DfObkrGYkyh2uUDqdsIUWf+uQcinvbRrI+iBQUdEg==
X-Received: by 2002:a5d:591b:0:b0:2bf:65ac:ebcc with SMTP id v27-20020a5d591b000000b002bf65acebccmr31777747wrd.17.1675072475215;
        Mon, 30 Jan 2023 01:54:35 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d4284000000b00241fde8fe04sm11453537wrq.7.2023.01.30.01.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:54:34 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/7] soc: qcom: add UCSI function to PMIC GLINK
Date:   Mon, 30 Jan 2023 10:54:31 +0100
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANeT12MC/x2NQQrCMBAAv1L27ELaVRS/Ih6SdG0XkzRkWxFK/
 +7iceYws4NyE1a4dzs0/ojKUgz6Uwdx9mVilNEYBjeQ68nhulSJqPl2vjjcqq6NfcaaTU5Jyhs
 pkHfhGuJIBJYJXhlD8yXOFipbSiZr45d8/9/H8zh+udSJ2YcAAAA=
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC GLINK interface offers an UCSI endpoint for newer
SoCs, the UCSI exchange is necessary to configure the USB-C
port USB role and altmode on the SM8450 HDK and SM8550 MTP
boards.

This patchset focuses on USB and disables altmode support
on those 2 SoCs until DP altmode over the combo phy is
supported.

Depends on PMIC Glink patchset at [1].

[1] https://lore.kernel.org/all/20230130042003.577063-1-quic_bjorande@quicinc.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (7):
      usb: typec: ucsi: add PMIC Glink UCSI driver
      dt-bindings: soc: qcom: qcom,pmic-glink: document SM8450 compatible
      dt-bindings: soc: qcom: qcom,pmic-glink: document SM8550 compatible
      soc: qcom: pmic_glink: register ucsi aux device
      arm64: dts: qcom: sm8450-hdk: add pmic glink node
      arm64: dts: qcom: sm8550-mtp: add pmic glink node
      arm64: defconfig: add PMIC GLINK modules

 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   2 +
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |  34 ++-
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |  34 ++-
 arch/arm64/configs/defconfig                       |   4 +
 drivers/soc/qcom/pmic_glink.c                      |  67 ++++-
 drivers/usb/typec/ucsi/Kconfig                     |   7 +
 drivers/usb/typec/ucsi/Makefile                    |   1 +
 drivers/usb/typec/ucsi/ucsi_glink.c                | 321 +++++++++++++++++++++
 8 files changed, 458 insertions(+), 12 deletions(-)
---
base-commit: 56779300f3ce6229a3d02e41e4ce36047d8891ac
change-id: 20230130-topic-sm8450-upstream-pmic-glink-3b3a0b7bcd33

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

