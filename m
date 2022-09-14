Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F20E5B8629
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiINKVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiINKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:21:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7D479ECC;
        Wed, 14 Sep 2022 03:21:14 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4ADBD6601FAD;
        Wed, 14 Sep 2022 11:21:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663150872;
        bh=QdN2B3QibIErQYqVl05FBiGUQIidoGZDB5zsfyDeIhg=;
        h=From:To:Cc:Subject:Date:From;
        b=kuK208OdpKJ/ygCdBVc8RUw7xLAg1BYoyVlcDRodErz+0HWi7i/2l+mKeQKda9jne
         3wwhPXTHqokS3xWX4655NL30hnW0ifZXEH85TTEKwFblrHpWgb2d2tXuulQYJwoglt
         Zist/UvhMfPFDOOVSF1C3BAqaE63EJ1aSbfDBopCfszheoe1tATJDUSgJAZpENvifs
         HmcH+gQ4bwSaSt1pFeUi+2EYNQR77nwX9L0l4CcgNUmLTDsJD6I03zJqucSpskx403
         U9uvGpkrmdwRa51socFiI5tNYFBk7CILz/ObpKNO2LMBD/90zH4edl7X7ptdaohYwG
         snREHz7IobqXg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     krzysztof.kozlowski+dt@linaro.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, chen.zhong@mediatek.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] MediaTek PMIC Keys - DT schema conversion
Date:   Wed, 14 Sep 2022 12:20:57 +0200
Message-Id: <20220914102059.41757-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts the old mtk-pmic-keys.txt binding to DT schema,
documents the missing support for key press/release interrupts and
adds a compatible for the newly introduced MT6331 keys.

AngeloGioacchino Del Regno (2):
  dt-bindings: input: Convert mtk-pmic-keys to DT schema
  dt-bindings: input: mediatek,pmic-keys: Add compatible for MT6331 keys

 .../bindings/input/mediatek,pmic-keys.yaml    | 118 ++++++++++++++++++
 .../bindings/input/mtk-pmic-keys.txt          |  46 -------
 2 files changed, 118 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt

-- 
2.37.2

