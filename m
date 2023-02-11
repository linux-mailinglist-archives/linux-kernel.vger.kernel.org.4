Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066E8692BED
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBKA0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBKA0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:26:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3BF7CC85;
        Fri, 10 Feb 2023 16:26:39 -0800 (PST)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 02AC0660210F;
        Sat, 11 Feb 2023 00:26:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676075196;
        bh=mLxGE1hzfETEIzY5gR5Pk1qQeIPY27W1oSvX6VCd1U0=;
        h=From:To:Cc:Subject:Date:From;
        b=Ci4l9dOIm7ykglPTmFljaSkZeu+JnZ0BxSkqox3sXIpqFZv12ggpEk60TnlTANnNW
         cCcBsL56HMm5UorW/3AMUgodtjO7xRfwksjG8D3uieiMM5Q6zXDA1Ur95IqFowhSOt
         TKbTtWC7F40eBTqiKv2vfKSdlxqLenUaJUA6eJKE5jmDNQebunuyZzAzcotks+VNQj
         Xc6wZOZ2Ldtha2QmQbWu6qt8LLniQmub5I12Mx7EdJS+lEvRIYtcGkqqsx3c8bHUlo
         jvYSARqf4+XSKx1HmKXzQ9COIk3yHDK52gRBSXcb/hjpJJPSoCOeZACAFI4BQhm2DY
         XIQmURgOy6sJA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
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
Subject: [PATCH 0/5] arm64: dts: mediatek: Add newer revisions of Google Spherion and Hayato
Date:   Fri, 10 Feb 2023 19:26:21 -0500
Message-Id: <20230211002626.454844-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.39.1
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


Nícolas F. R. A. Prado (5):
  dt-bindings: arm64: dts: mediatek: Add rev5-sku2 of hayato
  dt-bindings: arm64: dts: mediatek: Add rev4 of spherion
  arm64: dts: mediatek: Add dtsi files to use rt5682s on mt8192
  arm64: dts: mediatek: Add hayato-rev5-sku2
  arm64: dts: mediatek: Add spherion-rev4

 .../devicetree/bindings/arm/mediatek.yaml     | 11 ++++
 arch/arm64/boot/dts/mediatek/Makefile         |  2 +
 .../mt8192-asurada-audio-rt1015p-rt5682s.dtsi | 18 ++++++
 .../mt8192-asurada-audio-rt5682s.dtsi         | 19 ++++++
 .../mt8192-asurada-hayato-r5-sku2.dts         | 49 +++++++++++++++
 .../mediatek/mt8192-asurada-spherion-r4.dts   | 62 +++++++++++++++++++
 6 files changed, 161 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682s.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682s.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r5-sku2.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r4.dts

-- 
2.39.1

