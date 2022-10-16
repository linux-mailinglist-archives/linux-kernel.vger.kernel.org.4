Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DFC5FFFC6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJPOdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJPOdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:33:36 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7BF31FA7;
        Sun, 16 Oct 2022 07:33:34 -0700 (PDT)
Date:   Sun, 16 Oct 2022 14:33:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1665930811; x=1666190011;
        bh=nQcr0gyvGKgwbCZ+Rk3zEhXgbzikCjptdDy+F0zBoUA=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=MXtW+dxsE8ztPufa7ufQlRAQfdhDblVV6fSE9rgpBA1uYvmuj5pNe9JoRA3CTrd12
         pUBoq4h/HZk8eLvW3j3L4P09yXZDXFdbuRoMfY91/0BWpF4lOi1UIal0eLx5p3oGT0
         jTv86Do8o/vQNRHoakNq4TWLDfURLaoX3vLSnRkk=
To:     caleb@connolly.tech
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/7] arm64: dts: qcom: sdm845: commonize bluetooth pinconf
Message-ID: <20221016143300.1738550-1-caleb@connolly.tech>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series commonises the 4-pin pinconf used by almost all devices which h=
ave have
Bluetooth on uart6 and removes the node from individual device DTS files.

It also updates the old hsuart alias definitions to serial1. I'm happy to d=
rop this if it
may causes issues with userspace, but it seemed to make sense to throw in w=
hile we're at it.

This is a followup to Dmitry's suggestion on an earlier patch:
https://lore.kernel.org/all/CAA8EJpqz32_LxmBVbcLt0sV=3De1JzGtWEmMsKsQNoZzuG=
gLWbBQ@mail.gmail.com/

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Caleb Connolly (6):
  arm64: dts: qcom: sdm845: commonize bluetooth UART pinmux
  arm64: dts: qcom: sdm845-cheza: commonize uart6 pinconf
  arm64: dts: qcom: sdm845-db845c: commonize uart6 pinconf
  arm64: dts: qcom: sdm845-oneplus-common: commonize uart6 pinconf
  arm64: dts: qcom: sdm845-xiaomi-beryllium: commonize uart6 pinconf
  arm64: dts: qcom: sdm845-xiaomi-polaris: commonize uart6 pinconf

Dylan Van Assche (1):
  arm64: dts: qcom: sdm845-shift-axolotl: fix Bluetooth firmware loading

 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 39 ++-----------------
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    | 27 ++-----------
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 30 ++------------
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  9 +++++
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 29 ++------------
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   | 27 +------------
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 23 +++++++++++
 7 files changed, 46 insertions(+), 138 deletions(-)

--
2.38.0


