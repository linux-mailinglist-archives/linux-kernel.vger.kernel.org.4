Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69344609649
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJWUqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJWUqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:46:05 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18906B8EA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:46:02 -0700 (PDT)
Date:   Sun, 23 Oct 2022 20:45:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666557940; x=1666817140;
        bh=+unuwbPaZn709EE+pvSpP9RlZCNHZGqPO1rQdfCVJY0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=TMLBnX+pRG0d6o+L/TgNXQchGLi+wgDl2iXEC2Z0qu2rNtOwoDdLPLoQCgNRZ0CPX
         XMb87fp9W3LyRgrN4agcJzsXhzx/OyMXm5eF8j66lis3KNi9477pCqdcD8Y0fU+vKp
         YMP5nhoyYnF0E7rwKa0CHoOapGMDZdKyQcSqzUns2tuG1u7fPn5JzcI/vhKC1fDfrj
         OhuB8WF4Pn+N0nVlPzjijuBd5rOBRUf75mVgWh/ssXrJAB6L7glDRuJR1LX7DYP2u3
         mcQMOodMSAYqjcKKdCuoP/E0mNy18rWPYumVyTyoT1CtnH3Ko3KpsAq8EiqqJ3JBBF
         ffiQPVO50o5Vg==
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
Subject: [PATCH v2 1/4] arm64: dts: qcom: msm8996: standardize blsp indexing
Message-ID: <20221023204505.115141-2-hpausten@protonmail.com>
In-Reply-To: <20221023204505.115141-1-hpausten@protonmail.com>
References: <20221023204505.115141-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use one-based indexing throughout the file for BLSP devices to avoid
confusion. Most of the node names and labels are consistent already.
This patch just fixes a few pinconf node names to match the one-based
indexing used in the label names.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
v1 -> v2: no changes

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qc=
om/msm8996.dtsi
index 5ff8de3e3de7..39afd8a99488 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1304,14 +1304,14 @@ blsp1_spi1_sleep: blsp1-spi1-sleep {
 =09=09=09=09bias-pull-down;
 =09=09=09};

-=09=09=09blsp2_uart2_2pins_default: blsp2-uart1-2pins {
+=09=09=09blsp2_uart2_2pins_default: blsp2-uart2-2pins {
 =09=09=09=09pins =3D "gpio4", "gpio5";
 =09=09=09=09function =3D "blsp_uart8";
 =09=09=09=09drive-strength =3D <16>;
 =09=09=09=09bias-disable;
 =09=09=09};

-=09=09=09blsp2_uart2_2pins_sleep: blsp2-uart1-2pins-sleep {
+=09=09=09blsp2_uart2_2pins_sleep: blsp2-uart2-2pins-sleep {
 =09=09=09=09pins =3D "gpio4", "gpio5";
 =09=09=09=09function =3D "gpio";
 =09=09=09=09drive-strength =3D <2>;
@@ -1478,28 +1478,28 @@ blsp1_uart2_sleep: blsp1-uart2-sleep {
 =09=09=09=09bias-disable;
 =09=09=09};

-=09=09=09blsp1_i2c3_default: blsp1-i2c2-default {
+=09=09=09blsp1_i2c3_default: blsp1-i2c3-default {
 =09=09=09=09pins =3D "gpio47", "gpio48";
 =09=09=09=09function =3D "blsp_i2c3";
 =09=09=09=09drive-strength =3D <16>;
 =09=09=09=09bias-disable;
 =09=09=09};

-=09=09=09blsp1_i2c3_sleep: blsp1-i2c2-sleep {
+=09=09=09blsp1_i2c3_sleep: blsp1-i2c3-sleep {
 =09=09=09=09pins =3D "gpio47", "gpio48";
 =09=09=09=09function =3D "gpio";
 =09=09=09=09drive-strength =3D <2>;
 =09=09=09=09bias-disable;
 =09=09=09};

-=09=09=09blsp2_uart3_4pins_default: blsp2-uart2-4pins {
+=09=09=09blsp2_uart3_4pins_default: blsp2-uart3-4pins {
 =09=09=09=09pins =3D "gpio49", "gpio50", "gpio51", "gpio52";
 =09=09=09=09function =3D "blsp_uart9";
 =09=09=09=09drive-strength =3D <16>;
 =09=09=09=09bias-disable;
 =09=09=09};

-=09=09=09blsp2_uart3_4pins_sleep: blsp2-uart2-4pins-sleep {
+=09=09=09blsp2_uart3_4pins_sleep: blsp2-uart3-4pins-sleep {
 =09=09=09=09pins =3D "gpio49", "gpio50", "gpio51", "gpio52";
 =09=09=09=09function =3D "blsp_uart9";
 =09=09=09=09drive-strength =3D <2>;
@@ -1535,7 +1535,7 @@ blsp2_i2c1_default: blsp2-i2c1 {
 =09=09=09=09bias-disable;
 =09=09=09};

-=09=09=09blsp2_i2c1_sleep: blsp2-i2c0-sleep {
+=09=09=09blsp2_i2c1_sleep: blsp2-i2c1-sleep {
 =09=09=09=09pins =3D "gpio55", "gpio56";
 =09=09=09=09function =3D "gpio";
 =09=09=09=09drive-strength =3D <2>;
@@ -1567,7 +1567,7 @@ cdc_reset_sleep: cdc-reset-sleep {
 =09=09=09=09output-low;
 =09=09=09};

-=09=09=09blsp2_spi6_default: blsp2-spi5-default {
+=09=09=09blsp2_spi6_default: blsp2-spi6-default {
 =09=09=09=09spi {
 =09=09=09=09=09pins =3D "gpio85", "gpio86", "gpio88";
 =09=09=09=09=09function =3D "blsp_spi12";
@@ -1584,7 +1584,7 @@ cs {
 =09=09=09=09};
 =09=09=09};

-=09=09=09blsp2_spi6_sleep: blsp2-spi5-sleep {
+=09=09=09blsp2_spi6_sleep: blsp2-spi6-sleep {
 =09=09=09=09pins =3D "gpio85", "gpio86", "gpio87", "gpio88";
 =09=09=09=09function =3D "gpio";
 =09=09=09=09drive-strength =3D <2>;
--
2.38.1


