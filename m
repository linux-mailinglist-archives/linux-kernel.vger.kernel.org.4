Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EEC64D338
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiLNXV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLNXVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:21:18 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86124AF05;
        Wed, 14 Dec 2022 15:21:15 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C192A20393;
        Thu, 15 Dec 2022 00:21:13 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] arm64: dts: qcom: msm8956-loire: SDCard
Date:   Thu, 15 Dec 2022 00:20:43 +0100
Message-Id: <20221214232049.703484-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl nodes to enable SD Cards to work on the Sony Loire platform,
and define extcon nodes in PMI8950 to feed into the ci-hdrc driver as it
cannot figure out the presence of a USB cable (nor the desired role
based on the ID pin) on its own.  While at it, extend PMI8950 with some
more channels with now-available VADC_ register constants.

Depends on:
- Fix pm8941-misc extcon interrupt dependency assumptions:
  https://lore.kernel.org/linux-arm-msm/20220926113143.40768-1-bryan.odonoghue@linaro.org/
- dt-bindings: iio: qcom-spmi-vadc: Add definitions for USB DP/DM VADCs:
  https://lore.kernel.org/linux-arm-msm/20221111120156.48040-2-angelogioacchino.delregno@collabora.com/

Marijn Suijten (6):
  arm64: dts: qcom: pmi8950: Add USB vbus and id sensing nodes
  arm64: dts: qcom: msm8956-loire: Add usb vbus and id extcons to
    ci-hdrc
  arm64: dts: qcom: pmi8950: Add missing ADC channels
  arm64: dts: qcom: msm8976: Declare and use SDC1 pins
  arm64: dts: qcom: msm8976: Declare and use SDC2 pins
  arm64: dts: qcom: msm8956-loire: Add SD Card Detect to SDC2 pin states

 .../qcom/msm8956-sony-xperia-loire-kugo.dts   |   6 ++
 .../dts/qcom/msm8956-sony-xperia-loire.dtsi   |  25 +++++
 arch/arm64/boot/dts/qcom/msm8976.dtsi         | 100 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pmi8950.dtsi         |  38 +++++++
 4 files changed, 169 insertions(+)

--
2.39.0

