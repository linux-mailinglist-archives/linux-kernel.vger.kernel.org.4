Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989D661D8DA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 09:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKEItV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 04:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKEItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 04:49:19 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7056422516;
        Sat,  5 Nov 2022 01:49:17 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 797B940474;
        Sat,  5 Nov 2022 08:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1667638155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LLyTjEajQKXrzLut9HyKnIBDU1ImS4d+E858cGyWvT4=;
        b=fXzVRVhOEsem+/1MiKp6X6bosBSHDR6g4acMiVPeMafldXfTZGKdcf0Rjiso5oylBs43i8
        50wnqnAWFfYOHuyp0+eJSiJR1I2VltPFfvWPEb64Yux2Ww8j/Aq4hp3K/kQXy6jHg3X9hf
        8yrqDSUX//83jp/u0mje9/sDSI+Ufg4=
Received: from frank-G5.. (fttx-pool-217.61.159.50.bambit.de [217.61.159.50])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 6240710068B;
        Sat,  5 Nov 2022 08:49:14 +0000 (UTC)
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
Subject: [PATCH v1 0/4] update mediatek MT7986 pinctrl driver
Date:   Sat,  5 Nov 2022 09:49:01 +0100
Message-Id: <20221105084905.9596-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: bfc0057b-9111-4c39-9cec-2accbbaa280c
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

Sam Shih (4):
  dt-bindings: pinctrl: mt7986: add generic bias-pull* support
  pinctrl: mediatek: fix the pinconf register offset of some pins
  pinctrl: mediatek: extend pinctrl-moore to support new bias functions
  pinctrl: mediatek: add pull_type attribute for mediatek MT7986 SoC

 .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 50 +++++++++++-
 drivers/pinctrl/mediatek/pinctrl-moore.c      | 49 ++++++++++--
 drivers/pinctrl/mediatek/pinctrl-mt7986.c     | 80 ++++++++++++++++---
 3 files changed, 157 insertions(+), 22 deletions(-)

-- 
2.34.1

