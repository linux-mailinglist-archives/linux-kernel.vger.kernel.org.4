Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9891573954C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjFVCLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFVCLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:11:34 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E97AC;
        Wed, 21 Jun 2023 19:11:34 -0700 (PDT)
Date:   Thu, 22 Jun 2023 02:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687399892; x=1687659092;
        bh=S6fvHVWpgJ+++RTt92EIUdud4rBfU1qdLx0ipdC4tuM=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=ovs6Q24BdUyYfxH2Q8/cYNP2kar46JJiwhNcZSzQkEiAUyo/c6kZDSQsv0U0Y3CRk
         CDA4iHzppsH9xvvuaer0ePGi5xhCAxWQ6fdhTE7gxA0xTBkmbUcAgsnZx6Tf+InncY
         Fxz0FY5JMmHKnHazudjQJhg2nzH9JPWY7/HJ8+7U8WMTspMPPXcu2AMX0tUx96lAaB
         qeYw6kUUPx/oiMX/KDTvFuqSzmoD41+0NigZo7czmPXPq0PSUF065Fk+vVT7/r8xoD
         WRIb0mdPst1GgJquRDdIYu2DFUI6614EcFHVZuHbIM+pd3rfJDPC9JDvHJpDp0VHwG
         D5hdnaOLAcyeg==
To:     linux-kernel@vger.kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8939-sony-xperia-kanuti-tulip: Add missing 'chassis-type'
Message-ID: <20230622021105.66015-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony Xperia M4 Aqua is a handset. Add the chassis-type =3D "handset"; to it=
.

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts =
b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
index 8613cf93dac5..0633e3006f17 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -16,6 +16,7 @@
 / {
 =09model =3D "Sony Xperia M4 Aqua";
 =09compatible =3D "sony,kanuti-tulip", "qcom,msm8939";
+=09chassis-type =3D "handset";
=20
 =09qcom,board-id =3D <QCOM_BOARD_ID_MTP 0>;
 =09qcom,msm-id =3D <QCOM_ID_MSM8939 0>, <QCOM_ID_MSM8939 0x30000>;
--=20
2.39.2


