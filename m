Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB5716E70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjE3UNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjE3UNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:13:35 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB1E9D;
        Tue, 30 May 2023 13:13:33 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id 50EFB62622;
        Tue, 30 May 2023 20:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1685477611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sWxb1uLSvOMQ+A7ucc82ozJghsSsGNrOYRShIiqyHuE=;
        b=QZTiWltmIj1vb+SR0MGMJsQgkkG2BnlKci1RPZHFhCMPM62XvYjyHAtzxcduI7NKXHFsdx
        +9s8NoUNnrF62WAIQQ0ciKElH+jeXpsJOZL4UZM8MppYOiPZiGRDJfXLS9PhZZh7sglSUZ
        LLpDi2VZio3iOldbNvOugWlfWESopmM=
Received: from frank-G5.. (fttx-pool-217.61.157.145.bambit.de [217.61.157.145])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 263A040ACA;
        Tue, 30 May 2023 20:13:20 +0000 (UTC)
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
Subject: [PATCH v3 0/4] Add mt7986 thermal
Date:   Tue, 30 May 2023 22:12:31 +0200
Message-Id: <20230530201235.22330-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 9f03fd52-88cf-4dc1-98dd-2f3ea44d9010
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

This series add thermal related devicetree-nodes and necessary
dt-bindings.

I left pwm-fan for r3 for now as i cannot test this completely due to
missing 2 pin-jack and 3v3 pwm-level which my fan cannot handle (starts
spinning at ~3V). Only checked voltage of pwm there.

changes in v3:
- efuse compatibles into one line

changes in v2:
- drop highest 2 trip points as they are not yet used
- leave already applied patches

Daniel Golle (3):
  arm64: dts: mt7986: add thermal and efuse
  arm64: dts: mt7986: add thermal-zones
  arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3 dts

Frank Wunderlich (1):
  dt-bindings: nvmem: mediatek: efuse: add support for mt7986

 .../bindings/nvmem/mediatek,efuse.yaml        |  1 +
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 31 ++++++++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 62 +++++++++++++++++++
 3 files changed, 94 insertions(+)

-- 
2.34.1

