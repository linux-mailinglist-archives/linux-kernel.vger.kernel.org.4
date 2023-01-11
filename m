Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F914666275
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjAKSGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjAKSFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:05:54 -0500
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D4115F27;
        Wed, 11 Jan 2023 10:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673460340;
        bh=AV9Go+xHCdsoX9TINfpzQ7oy2kjUbf39EKCEUBJfj0U=;
        h=From:To:Cc:Subject:Date;
        b=ejms4cozp3pmCgI/JjFqB8yuR5tuunsSe24MVSaGYgxChDOGsg8hcwF+aO2p9ThG5
         Dgj7CKlQvHg2ZND38f0K3PTvUTiTmm2lObCoiKLK8dcyBNwP9BarUFHzOf296Kk603
         dtvSfnSW+ayyIjlEAdzrZNlz6LYwB1gbFwPLIZLw=
Received: from localhost.localdomain ([111.60.247.106])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 14F2600F; Thu, 12 Jan 2023 02:05:15 +0800
X-QQ-mid: xmsmtpt1673460315tjyf90zqs
Message-ID: <tencent_0F1C483464F866AD2DFA08F0BB3B0FFFC406@qq.com>
X-QQ-XMAILINFO: Mu4fz8q1FCY3qQbmfCHUQmOmsTIPVLpe8FtYVnEgJLa9EBzoN4D4KXlmFUkAgb
         RacKQt2fXT4nL9Bh1i2fuRENxAGqjdXGhWrLkRltnQO/GgV1StiwWgAIuQVayHc2lO3/NDc9vZE1
         +NtDjhStK04Ox5f2rtNeIe0rVQhi0uaxuwJJ/xzO2i77nQ3kSTnpMwEP77BYSaHel3dd9jQAnk//
         5rcCPWCdr9jRwAGoS6EUwGDXHK23RDH/kf54iEEmCRAi6tjbiDv4pbbnC8Mj/owjYrqsoSXnzu+V
         /dYJR2MFM5SgximmqgUgbm/xHMnxnlQmWxdU80N/CPhub+6esRZVf79V+//8fnCsdQSmqUHWgowx
         7+68vRcrUDLZn5U3jnCm2CEOvk3Cm5FDh+4RC9yssA4ZdsruNHR/srn2DBWxkff+8BZDQ53+jGjv
         /1pJ3q93evXxT/q+VFRqyTyXJsS3+96QKqdicKSIGoQ5tzzbHvfAWbo0Ce4ybaSzjbEJnpzWb2RE
         6+HwqUXkilURkRTZEL48IAS/Hr5YCJzdGuEqN0cW9AV7SB6MJf2I51K3kAB4BwCr3kVlJhfNbRb5
         4jwFEdHG3+QRBrt7tEFhdJkDNBp8zDK1ukCrsllkjP9l6yLLzYrTxZ+SmPUTx6JI9shEaI5f1TRi
         9VP/SuEq1VwTNuNymB8+Wl7scsTb2XM7JfxTCrcJKukXR2L4UvheTWIh99SJptLTZKBvk1NBXrku
         gz7d5lP+BKjrsDNggkMBaKNn0dwTjgtygvP/tnRri7nEniInHnueXqpJifv9CdD7o7Dh2gvukHhx
         jkzoKvnVh8sdU9Xgdz3Pt1J8e6f/3Mpw4Hcp4f/DR/AoX47ZwiR40dwF5pGkhAWG3cMWNYBpV9b9
         K4Og9aT8R/2ZMAcKeD/1L3wck8Vo6rZYHP/+M+eQ3FxmXmzYwAkN+kqfjZE9BK3p3NZel9BpmZRY
         AWYilsKpyU8U+zUtsy6xIx+UIQxU1nxkYUNeWmta4/xeq8oc7z8Q==
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yang Xiwen <forbidden405@foxmail.com>,
        Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v3 0/3] Support for MSM8916-based UFi ufi001c and uf896
Date:   Thu, 12 Jan 2023 02:03:19 +0800
X-OQ-MSGID: <20230111180322.21874-1-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These devices are equipped with 512MB RAM, 4/8GB eMMC and MSM8916.
This series introduces support for them and adds a dtsi for the class of
MSM8916-based UFIs.

v3:
- Sort vendor-prefixes alphebatically
v2:
- Managed to get the real vendor
- Remove some reduntant descriptions
- Rename dtsi more formally

Yang Xiwen (3):
  dt-bindings: vendor-prefixes: add thwc
  dt-bindings: qcom: Document msm8916-thwc-uf896 and ufi001c
  arm64: dts: qcom: msm8916-thwc: Add initial device trees

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../boot/dts/qcom/msm8916-thwc-uf896.dts      |  41 +++
 .../boot/dts/qcom/msm8916-thwc-ufi001c.dts    |  39 +++
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi     | 246 ++++++++++++++++++
 6 files changed, 332 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi

-- 
2.39.0

