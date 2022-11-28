Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2EC63A722
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiK1LWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiK1LV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:21:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE71E1C910;
        Mon, 28 Nov 2022 03:20:35 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 770D46600012;
        Mon, 28 Nov 2022 11:20:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669634434;
        bh=dE20A2/OTzcHoFZjonpiFTdjhVa0lqqfrLGgjF3xe2I=;
        h=From:To:Cc:Subject:Date:From;
        b=RPdzqVktr1JSiTCwjxg5t2lBvjIZVJu8cFhNojXxoE1yABV6riAbAgdmQ+XRbf/nW
         XeedMk8iCjPyspka3o+GP7OSVq26m4IOMiNAAEPYuMu+3oYD5B+Ofk2ftlQ6gRXd3D
         tZT3T9GHpRqzA7fneYJ78q6eL5uZ0htJm32mscIouWjEAFwNzsb9LBbNu44hBOkJN8
         VO/EljAOUlrbGjOLJEu/qWjNVBqS1TQmyuTicEoZ1xoRT8A2zVq3dLgpHccpWwzPjh
         5jcOWVV0+R61xODESb57J6nXijp+4DSXrJ0xdhVbY6GZjrYBOQDMWHp+g2HIufSU40
         yvyyXPiptvQNA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     krzysztof.kozlowski+dt@linaro.org
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, matthias.bgg@gmail.com, john@phrozen.org,
        sean.wang@mediatek.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 0/2] pwm-mediatek: Convert to schema and fixes
Date:   Mon, 28 Nov 2022 12:20:26 +0100
Message-Id: <20221128112028.58021-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts pwm-mediatek.txt to schema and fixes
mt7622.dtsi to declare the needed #pwm-cells on the pwm node,
required to not trigger a dtbs_check warning... and to make
that node actually usable.

AngeloGioacchino Del Regno (2):
  arm64: dts: mediatek: mt7622: Add missing pwm-cells to pwm node
  dt-bindings: pwm: mediatek: Convert pwm-mediatek to dt schema

 .../bindings/pwm/mediatek,mt2712-pwm.yaml     | 93 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-mediatek.txt  | 52 -----------
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |  1 +
 3 files changed, 94 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt

-- 
2.38.1

