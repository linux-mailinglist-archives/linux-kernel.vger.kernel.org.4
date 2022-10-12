Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73175FCBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJLUZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJLUY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:24:56 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDAA115E;
        Wed, 12 Oct 2022 13:24:50 -0700 (PDT)
Date:   Wed, 12 Oct 2022 20:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=protonmail3; t=1665606289; x=1665865489;
        bh=diUYicMMh/+7TmI9we8Hv3+n8vLxeIEDGHZbjZlmuFU=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=EooJG2TAs1OwBS87aHF96G6Jj9UQjrtUnHCRsHuRMkbTtecLRj6Vh0MpaG8IWx9kG
         F7V3haIxhcwowEVyyqMjohXK1JLNBhjbbw4Av+J/Ewh386YNQ17KEZUrGEpmpgCwpF
         bnaeQU38HatwmSOEGXHHrkwPFg2sXQPyErbKeoW9mew9YWP5IfLOzlw/G4Kk/HepUS
         hfGE/H61esF0rxLWjCoUV6bofcjwvXIXkrkR+d2cTC7QWcM9I0UwlbDmVMjWL2UYbZ
         zPRM9CjoTFuaWLHizKpNU+iFhyxdtRgwKgJRGrpiD35gsSe/VGWomz6USkCbAXd/Fj
         wvUJpYFRMXzdQ==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
From:   Job Noorman <job@noorman.info>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: sdm632: fairphone-fp3: add touchscreen
Message-ID: <20221012202341.295351-4-job@noorman.info>
Feedback-ID: 14439221:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Himax hx83112b touchscreen to the FP3 DT.

Signed-off-by: Job Noorman <job@noorman.info>
---
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64=
/boot/dts/qcom/sdm632-fairphone-fp3.dts
index 891e314bc782..2920504461d3 100644
--- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -49,6 +49,20 @@ &hsusb_phy {
 =09vdda-phy-dpdm-supply =3D <&pm8953_l13>;
 };

+&i2c_3 {
+=09status =3D "okay";
+
+=09touchscreen@48 {
+=09=09compatible =3D "himax,hx83112b";
+=09=09reg =3D <0x48>;
+=09=09interrupt-parent =3D <&tlmm>;
+=09=09interrupts =3D <65 IRQ_TYPE_LEVEL_LOW>;
+=09=09touchscreen-size-x =3D <1080>;
+=09=09touchscreen-size-y =3D <2160>;
+=09=09reset-gpios =3D <&tlmm 64 GPIO_ACTIVE_LOW>;
+=09};
+};
+
 &pm8953_resin {
 =09status =3D "okay";
 =09linux,code =3D <KEY_VOLUMEDOWN>;
--
2.38.0


