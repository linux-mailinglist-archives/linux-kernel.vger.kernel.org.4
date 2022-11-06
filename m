Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29361E0B5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKFIBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiKFIBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:01:31 -0500
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D923633D;
        Sun,  6 Nov 2022 01:01:30 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id 3E118100067;
        Sun,  6 Nov 2022 08:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1667721688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mdh0JZbus3L1IA6cFN14kANToV9RcRy1oDUVqP1gpbA=;
        b=xHtUEUBvoMD2UHy2lWvVoW/VttiFBdmv2Cs1lqwaCXq7isW5cxsTF57/T6oOL9JYEOWXt5
        hX3Fc32pOwwttmWEmRZM1Qqi/2peCIuWYxMoOraDBuI4W59oiyFOahAmbTEYlCym6Fneyi
        FnYCHT6RYRd3Ai+aIEr6zWLn2OAM+KM=
Received: from frank-G5.. (fttx-pool-80.245.79.199.bambit.de [80.245.79.199])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 701C03602A8;
        Sun,  6 Nov 2022 08:01:27 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] update mediatek MT7986 pinctrl driver
Date:   Sun,  6 Nov 2022 09:01:07 +0100
Message-Id: <20221106080114.7426-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: a546a87b-a989-4c8a-a19b-b2a470829b89
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This patch series introduces common bias-pull* pinconf support to MediaTek
MT7986 pinctrl driver and fix some register offsets in the driver.

v2:
- added patches previously postes separately which are needed to have
  dt binding checks clean
- fixed odd numbers in comments for mt7986_pull_type

Frank Wunderlich (2):
  dt-bindings: pinctrl: update pcie/pwm/spi bindings for MT7986 SoC
  dt-bindings: pinctrl: update uart/mmc bindings for MT7986 SoC

Sam Shih (4):
  dt-bindings: pinctrl: mt7986: add generic bias-pull* support
  pinctrl: mediatek: fix the pinconf register offset of some pins
  pinctrl: mediatek: extend pinctrl-moore to support new bias functions
  pinctrl: mediatek: add pull_type attribute for mediatek MT7986 SoC

 .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 108 ++++++++++++++++--
 drivers/pinctrl/mediatek/pinctrl-moore.c      |  49 ++++++--
 drivers/pinctrl/mediatek/pinctrl-mt7986.c     |  80 +++++++++++--
 3 files changed, 207 insertions(+), 30 deletions(-)

-- 
2.34.1

