Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5EF6B8285
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCMUR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCMURy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:17:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4221043F;
        Mon, 13 Mar 2023 13:16:59 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 701456603082;
        Mon, 13 Mar 2023 20:16:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678738617;
        bh=475NKLqKir33iZI0kwyLeOEqNsvSrdnnNejXAnay7+s=;
        h=From:To:Cc:Subject:Date:From;
        b=PoEvgVpQH2RGL42QIc+pP6SCylC5dHBG5VKGammWmVwT7kKDEVUQ0c7zadSk3MeJF
         1gZfOtMS+4OGzascqMkMjVVdlXsV9za8S/54Lv5ZhizcOr8mjkM/D3LyKYzNV5yOEn
         nHcLqEMmd3KIwT4iMqFT3KRgTw3CTu/zKn/qpBm4O2ZuF3v+2tKzwSflrSidpj+Hz9
         mqduppReW65RkyQ46fxQvDCVDJWrwKEUITt7dqJh5ct1wk0bKTtwyQNyY6wC5Rny/x
         VAtm60bBzMiUs64oqony/6f+k3nw9TMWNPfmKEd4uBjlYMdXoHpN6VhIhrefJOI/t9
         DaU0nGz6/t8tQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/5] arm64: dts: mediatek: Add newer revisions of Google Spherion and Hayato
Date:   Mon, 13 Mar 2023 16:14:38 -0400
Message-Id: <20230313201443.2275101-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add devicetrees for the newer revisions of two machines: Google Spherion
rev4 and Google Hayato rev5-sku2. For both, the difference from the
previous revision is that they now use the rt5682s audio codec instead
of rt5682.

Changes in v2:
- Removed patch adding asurada-audio files for rt5682s
- Added patch moving nodes from existing asurada-audio files to board
  dtsi

Nícolas F. R. A. Prado (5):
  dt-bindings: arm64: dts: mediatek: Add rev5-sku2 of hayato
  dt-bindings: arm64: dts: mediatek: Add rev4 of spherion
  arm64: dts: mediatek: Remove asurada-audio dtsi files
  arm64: dts: mediatek: Add hayato-rev5-sku2
  arm64: dts: mediatek: Add spherion-rev4

 .../devicetree/bindings/arm/mediatek.yaml     | 11 +++
 arch/arm64/boot/dts/mediatek/Makefile         |  2 +
 .../mt8192-asurada-audio-rt1015p-rt5682.dtsi  | 19 -----
 .../mt8192-asurada-audio-rt1015p.dtsi         | 26 -------
 .../mediatek/mt8192-asurada-audio-rt5682.dtsi | 21 -----
 .../dts/mediatek/mt8192-asurada-hayato-r1.dts | 19 ++++-
 .../mt8192-asurada-hayato-r5-sku2.dts         | 64 +++++++++++++++
 .../mediatek/mt8192-asurada-spherion-r0.dts   | 19 ++++-
 .../mediatek/mt8192-asurada-spherion-r4.dts   | 77 +++++++++++++++++++
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 28 +++++++
 10 files changed, 218 insertions(+), 68 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682.dtsi
 delete mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p.dtsi
 delete mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r5-sku2.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r4.dts

-- 
2.39.2

