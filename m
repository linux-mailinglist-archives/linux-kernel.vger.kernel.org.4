Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B146609647
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiJWUqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJWUqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:46:04 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E426B667
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:45:53 -0700 (PDT)
Date:   Sun, 23 Oct 2022 20:45:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666557952; x=1666817152;
        bh=y2bCXpgeOzFP8XQZojpeu0g8mOyEC8O50wzfQi+iCHo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=hVQVBBHOs//SUGyRB1Lp5UFE7hdUFyjAg713P/O8hjgploXfbGy3hJfpMIE/NQdYA
         kZibEq5nGhy7fTxV7aDbY/LXXNAa03H7hXcynaGXarF5PMo2TWPzaEbofITyrCcG82
         OyCKsGIGQqsgEf5FEnuoLa2y4HHqq3zYDOvuR6qEd0bEDBqWucU3XiguzPkq6KMvIk
         x4tmYr2iIOzcSZmohPKknH2sh3E37Dg/uoslKDqAok1nANfq5jjaHdEiFnfE6bY6fL
         w4g29joWKNJs6HWOwAjBgfaGWQppCcZx8V9RO2HS2ZDUwsPIqrTGzjBl6YTmZLqHLR
         vFyYveuFNeovQ==
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
From:   Harry Austen <hpausten@protonmail.com>
Cc:     Harry Austen <hpausten@protonmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH v2 2/4] arm64: boot: dts: msm8996: add blsp1_i2c6 node
Message-ID: <20221023204505.115141-3-hpausten@protonmail.com>
In-Reply-To: <20221023204505.115141-1-hpausten@protonmail.com>
References: <20221023204505.115141-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the sixth I2C interface on the MSM8996 SoC.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
v1 -> v2: use hyphens and add "-state" pinctrl node name suffix

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qc=
om/msm8996.dtsi
index 39afd8a99488..bb49496a5413 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1418,6 +1418,20 @@ pwdn {
 =09=09=09=09};
 =09=09=09};

+=09=09=09blsp1_i2c6_default: blsp1-i2c6-state {
+=09=09=09=09pins =3D "gpio27", "gpio28";
+=09=09=09=09function =3D "blsp_i2c6";
+=09=09=09=09drive-strength =3D <16>;
+=09=09=09=09bias-disable;
+=09=09=09};
+
+=09=09=09blsp1_i2c6_sleep: blsp1-i2c6-sleep-state {
+=09=09=09=09pins =3D "gpio27", "gpio28";
+=09=09=09=09function =3D "gpio";
+=09=09=09=09drive-strength =3D <2>;
+=09=09=09=09bias-pull-up;
+=09=09=09};
+
 =09=09=09pcie0_state_on: pcie0-state-on {
 =09=09=09=09perst {
 =09=09=09=09=09pins =3D "gpio35";
@@ -3141,6 +3155,23 @@ blsp1_i2c3: i2c@7577000 {
 =09=09=09status =3D "disabled";
 =09=09};

+=09=09blsp1_i2c6: i2c@757a000 {
+=09=09=09compatible =3D "qcom,i2c-qup-v2.2.1";
+=09=09=09reg =3D <0x757a000 0x1000>;
+=09=09=09interrupts =3D <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+=09=09=09clocks =3D <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
+=09=09=09=09 <&gcc GCC_BLSP1_AHB_CLK>;
+=09=09=09clock-names =3D "core", "iface";
+=09=09=09pinctrl-names =3D "default", "sleep";
+=09=09=09pinctrl-0 =3D <&blsp1_i2c6_default>;
+=09=09=09pinctrl-1 =3D <&blsp1_i2c6_sleep>;
+=09=09=09dmas =3D <&blsp1_dma 22>, <&blsp1_dma 23>;
+=09=09=09dma-names =3D "tx", "rx";
+=09=09=09#address-cells =3D <1>;
+=09=09=09#size-cells =3D <0>;
+=09=09=09status =3D "disabled";
+=09=09};
+
 =09=09blsp2_dma: dma-controller@7584000 {
 =09=09=09compatible =3D "qcom,bam-v1.7.0";
 =09=09=09reg =3D <0x07584000 0x2b000>;
--
2.38.1


