Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4605A676DE1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjAVO5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjAVO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:57:39 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Jan 2023 06:57:37 PST
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14FC31BAF6;
        Sun, 22 Jan 2023 06:57:36 -0800 (PST)
Received: from shock.lan (2-248-191-197-no36.tbcn.telia.com [2.248.191.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 961631403EE;
        Sun, 22 Jan 2023 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1674399005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XZ48KyrdXx/omQ0ya+/qEXDSGlTqVrVn5v4sm9m+VDE=;
        b=YMUDAjSq9lNKIHKRCp38o4iW7ZD9oaW8d/ywbmwy0Zmb9YwZioO1yKzizsvDSqoZa97p5W
        CkVIwPVFQTp1mzIa0w37bG1no75yGPgwWNweQbK2T3J0XwmHqAOdSP8gE+o++KViCbmFkZ
        G3tIfCHz07HjR8aM1LBaPWIA5QBUNb4=
From:   Stefan Hansson <newbyte@postmarketos.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        matti.lehtimaki@gmail.com,
        Stefan Hansson <newbyte@postmarketos.org>
Subject: [PATCH 0/3] Add samsung-matisselte and common matisse dtsi
Date:   Sun, 22 Jan 2023 15:47:47 +0100
Message-Id: <20230122144749.87597-1-newbyte@postmarketos.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a common samsung-matisse dtsi and reworks
samsung-matisse-wifi to use it, and introduces samsung-matisselte. I
choose matisselte over matisse-lte as this is how most other devices
(klte, s3ve3g) do it and it is the codename that Samsung gave the
device. See individual commits for more information.

Stefan Hansson (3):
  ARM: dts: qcom: samsung-matisse-common: Add initial common device tree
  dt-bindings: arm: qcom: Add MSM8926 and Samsung Galaxy Tab 4 10.1 LTE
  ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 LTE
    (SM-T535)

 .../devicetree/bindings/arm/qcom.yaml         |   6 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 511 +-----------------
 .../qcom-msm8226-samsung-matisse-common.dtsi  | 510 +++++++++++++++++
 .../dts/qcom-msm8926-samsung-matisselte.dts   |  39 ++
 5 files changed, 568 insertions(+), 499 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8226-samsung-matisse-common.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-msm8926-samsung-matisselte.dts

-- 
2.39.0

