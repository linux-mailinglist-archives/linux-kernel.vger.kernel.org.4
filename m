Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665ED60BEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJXXmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJXXlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:41:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE764106A6E;
        Mon, 24 Oct 2022 15:00:27 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [194.36.25.51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 91BE2660239F;
        Mon, 24 Oct 2022 23:00:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666648822;
        bh=NtMGJEqZV/bhhhU6Mak10T8YkbJeZuq93Ltw2LeDx/0=;
        h=From:To:Cc:Subject:Date:From;
        b=iysEC5LQF8tCDhWXCo+bBRGap4iZPdrPXgR5kbGSjQcHMcU2DeBzM7ose8sOIEJZ5
         ozgEif9d3HN1bC7hwh+Vd797EollcuX2qxUp06A9/aOFQqrbUSdBBoJsJ3oJFXw2xs
         Rgm+wkfdbDhkvB1cgOC/76RsAhVLiOGZ0OTUCUo1bzMpTApgPdjql0jN9/055D0Df3
         T6vRdgGteqBwF5E0CRlqNJFIsziHSjo6uBf4Ak+wKPNktpdCzK6CJtCo1jnnaFn6RC
         9KK6z6RBP1o+dR5sqdMWyFee64OU8fV51bqdBceghtYxjisY8ccImdB2dVAMeXA+mG
         tdaHMk1O5naoA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Add missing dt-binding properties to rt5682(s)
Date:   Mon, 24 Oct 2022 18:00:11 -0400
Message-Id: <20221024220015.1759428-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
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


This series adds the missing sound-dai-cells to rt5682s and supplies for
both rt5682s and rt5682.

These properties are already used by sc7180-trogdor.dtsi (and derived
DTs like sc7180-trogdor-kingoftown.dtsi), so the commits in this series
are really just documenting their usage.

v1: https://lore.kernel.org/all/20221021190908.1502026-1-nfraprado@collabora.com/

Changes in v2:
- Changed sound-dai-cells to 1 on rt5682s
- Added commit fixing sound-dai-cells on rt5682
- Added mention to commit messages that properties are already being
  used by DTs

Nícolas F. R. A. Prado (4):
  ASoC: dt-bindings: realtek,rt5682s: Add #sound-dai-cells
  ASoC: dt-bindings: realtek,rt5682s: Add AVDD and MICVDD supplies
  ASoC: dt-bindings: rt5682: Set sound-dai-cells to 1
  ASoC: dt-bindings: rt5682: Add AVDD, MICVDD and VBAT supplies

 .../devicetree/bindings/sound/realtek,rt5682s.yaml        | 7 +++++++
 Documentation/devicetree/bindings/sound/rt5682.txt        | 8 +++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.38.1

