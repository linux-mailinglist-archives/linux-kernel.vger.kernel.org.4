Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831A7607EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiJUTJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiJUTJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:09:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E043295B15;
        Fri, 21 Oct 2022 12:09:15 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 03B5066025FA;
        Fri, 21 Oct 2022 20:09:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666379353;
        bh=7tSbZ3o9rnEZxiNzuX4/brBcjhft4z9R+3Odm3eod+c=;
        h=From:To:Cc:Subject:Date:From;
        b=lhhM2+K+4Va/Ait9eg4Xp6JcNcJOQtx7J0hSCLTEedwUhOxPAvPUB/lvngidszGux
         zUA9LmmgdC548TQKqg2E1tjwxDLgqQ35mWG1U4O0NsUI0NdN5mgbwng4I3q0Njd3nT
         /rHoqEibFAtJ1HVu6HCBKJVECwBwbDnbZyx/NrRXJvfCO+26LM46XtK4Hb1mirCs0r
         Z+wT8lYDalJkeccTmB5tGaXEjWVjsAWn21wbTA/qBJBAjeEl2BgIbGXs+OeeViuxtu
         GI3xwimrJgct2RkGt7Kno4A1OROtVGyw/LP4qJKBx0tBrNKi/aMMizRwuZuJShuNQ1
         z/b4Brc3UJ2Tg==
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
Subject: [PATCH 0/3] Add missing dt-binding properties to rt5682(s)
Date:   Fri, 21 Oct 2022 15:09:05 -0400
Message-Id: <20221021190908.1502026-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series adds the missing sound-dai-cells to rt5682s and supplies for
both rt5682s and rt5682.


Nícolas F. R. A. Prado (3):
  ASoC: dt-bindings: realtek,rt5682s: Add #sound-dai-cells
  ASoC: dt-bindings: realtek,rt5682s: Add AVDD and MICVDD supplies
  ASoC: dt-bindings: rt5682: Add AVDD, MICVDD and VBAT supplies

 .../devicetree/bindings/sound/realtek,rt5682s.yaml         | 7 +++++++
 Documentation/devicetree/bindings/sound/rt5682.txt         | 6 ++++++
 2 files changed, 13 insertions(+)

-- 
2.38.1

