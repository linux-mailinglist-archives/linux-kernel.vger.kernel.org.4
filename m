Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E477960BEC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJXXl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJXXlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:41:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E9D2F70EF;
        Mon, 24 Oct 2022 15:00:32 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [194.36.25.51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C0E496602820;
        Mon, 24 Oct 2022 23:00:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666648829;
        bh=yUOJmnlfdy5bC2kZgeZWbD0yF667HQA6aNkS15dlW6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGQxoeeulNxtBsMzpjtPmZyyGa4mApgfpXJiUxsfMh8TjJFkSpE1FpW0wUBr6Xt69
         3gZ3eY1j7ub80kQgEWBC//c94Ojomkwy0PVU7EunnRhexxGD5C68E3yef5fuLeG5+W
         srwyYfZg/MDqcf/2gs+731jRqJcm36f6Oe5mvY8Vj+4xATnTwllLTzUrmFRH1nhgZW
         /ayYlLCZnCnYFH/5rRLq/DuIf6ymFrcIX7SOLb5wcKmT7L1rsqsLZOp8GCkLqEqyNB
         pWfoMJYYX/XUuFsMt5mzA9BLAvt9JnDJkiM/AB07acH6xEKJ9fWEcKeIn+OGZ1rLwL
         14iQFRP4iIGqQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ASoC: dt-bindings: rt5682: Set sound-dai-cells to 1
Date:   Mon, 24 Oct 2022 18:00:14 -0400
Message-Id: <20221024220015.1759428-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024220015.1759428-1-nfraprado@collabora.com>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
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

Commit 0adccaf1eac9 ("ASoC: dt-bindings: rt5682: Add #sound-dai-cells")
defined the sound-dai-cells property as 0. However, rt5682 has two DAIs,
AIF1 and AIF2, and therefore should have sound-dai-cells set to 1. Fix
it.

Fixes: 0adccaf1eac9 ("ASoC: dt-bindings: rt5682: Add #sound-dai-cells")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Added this commit

 Documentation/devicetree/bindings/sound/rt5682.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
index c5f2b8febcee..6b87db68337c 100644
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ b/Documentation/devicetree/bindings/sound/rt5682.txt
@@ -46,7 +46,7 @@ Optional properties:
 
 - realtek,dmic-clk-driving-high : Set the high driving of the DMIC clock out.
 
-- #sound-dai-cells: Should be set to '<0>'.
+- #sound-dai-cells: Should be set to '<1>'.
 
 Pins on the device (for linking into audio routes) for RT5682:
 
-- 
2.38.1

