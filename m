Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CC460797B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiJUOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJUOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:24:12 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35227CFFE;
        Fri, 21 Oct 2022 07:24:11 -0700 (PDT)
Date:   Fri, 21 Oct 2022 14:24:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666362249; x=1666621449;
        bh=UVyLFVsynHqqWzbr6cfqRUY/X6kUWsnU+s2ZPHcJzIE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=T/0gMzIcfI56udfn5jlFns/TrFm7tvzgzVQly7irEW3w3R/ySErxIucChDYCAy2Fz
         SEn+anUdF9QZeURWC1Q7vp10mcfoMXoT1LbZFImJ0jn78NjCUpdwsZTbYP3E0CicEW
         i/ybJ/PHpvlTFddtvkq9tZePEGrTU3enwK+8Yr7129+kk5N1J/6UaT7d7QcWjP69wq
         BaZh3UwM4XeTF8KFBrhNki5e/EQBtRTyjCRzR92TuggWnnSBhMw+8q29bmEHRkwed5
         XskzpAlubWV4JMXbhceUH5TX00B7I2UodBfKX5+Zt9oBdEXwaekO2TVrgtX4X1uT1+
         wUWB4BecPaRpA==
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
Subject: [PATCH 2/4] arm64: boot: dts: msm8996: add blsp1_i2c6 node
Message-ID: <20221021142242.129276-3-hpausten@protonmail.com>
In-Reply-To: <20221021142242.129276-1-hpausten@protonmail.com>
References: <20221021142242.129276-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the sixth I2C interface on the MSM8996 SoC.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qc=
om/msm8996.dtsi
index 80590267dfd0..70c0eae17360 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1400,6 +1400,20 @@ pwdn {
 =09=09=09=09};
 =09=09=09};

+=09=09=09blsp1_i2c6_default: blsp1_i2c6 {
+=09=09=09=09pins =3D "gpio27", "gpio28";
+=09=09=09=09function =3D "blsp_i2c6";
+=09=09=09=09drive-strength =3D <16>;
+=09=09=09=09bias-disable;
+=09=09=09};
+
+=09=09=09blsp1_i2c6_sleep: blsp1_i2c6_sleep {
+=09=09=09=09pins =3D "gpio27", "gpio28";
+=09=09=09=09function =3D "gpio";
+=09=09=09=09drive-strength =3D <2>;
+=09=09=09=09bias-pull-up;
+=09=09=09};
+
 =09=09=09pcie0_state_on: pcie0-state-on {
 =09=09=09=09perst {
 =09=09=09=09=09pins =3D "gpio35";
@@ -3127,6 +3141,23 @@ blsp1_i2c3: i2c@7577000 {
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


