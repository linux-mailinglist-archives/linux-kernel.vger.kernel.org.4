Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9096EAB90
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjDUN1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjDUN1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:27:31 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B944D324;
        Fri, 21 Apr 2023 06:27:22 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id B836F60506;
        Fri, 21 Apr 2023 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1682083253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2RYbc1C9+H/WQ9WMzIcpwV9sAdZeEPo9IAoHwZnSuyo=;
        b=Lfvi7Eem9Nhmj57IAOhyO1lmXsp8sH5Aec6EXGS1PJapNBZqDUQP3YvPNXrNJgNcOH07jM
        cnivTjWsKHhywBWQv24qmlZn327p1ZbRNacG1z8sDDAy1BNidID1KiqduqP8/DYeOn6BvR
        tN4PRrFIUVrpZSuW6Np7i40wHbme6a0=
Received: from frank-G5.. (fttx-pool-217.61.159.143.bambit.de [217.61.159.143])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 7541110072A;
        Fri, 21 Apr 2023 13:20:52 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
Subject: Subject: [PATCH v1 0/7] Add mt7986 thermal and pwm
Date:   Fri, 21 Apr 2023 15:20:40 +0200
Message-Id: <20230421132047.42166-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: e11c7872-5256-4a48-ae62-b36e397cf910
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This series add thermal and pwm related devicetree-nodes and necessary
dt-bindings.

I left pwm-fan for r3 for now as i cannot test this completely due to
missing 2 pin-jack and 3v3 pwm-level which my fan cannot handle (starts
spinning at ~3V).

Daniel Golle (4):
  arm64: dts: mt7986: add thermal and efuse
  arm64: dts: mt7986: add PWM
  arm64: dts: mt7986: add thermal-zones
  arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3 dts

Frank Wunderlich (3):
  dt-bindings: nvmem: mediatek: efuse: add support for mt7986
  dt-bindings: iio: adc: Add support for MT7986
  arm64: dts: mt7986: add PWM to BPI-R3

 .../iio/adc/mediatek,mt2701-auxadc.yaml       |  1 +
 .../bindings/nvmem/mediatek,efuse.yaml        |  1 +
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 44 +++++++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 89 +++++++++++++++++++
 4 files changed, 135 insertions(+)

-- 
2.34.1

