Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93E0692BF4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBKA0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBKA0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:26:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7707E02E;
        Fri, 10 Feb 2023 16:26:43 -0800 (PST)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 60F92660211E;
        Sat, 11 Feb 2023 00:26:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676075202;
        bh=0aZy7tt1Nff5CXL3+XhWnafCOr7nVPoVtqaoA2rqFJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXpp2P2yxyJuIu6sGlvnvAlggd7My9Y5ZPh7SAvWSd9IzGaUNzYXsF7O+TVQmGz+d
         3JZYnrNWfJPYMgJnoFACZEPSbZLrC2g/wkHkGN+nMBL/r2NpyskndGo/R6+VBb8DzC
         Fg1GawKdS7ebDfROpdMwj59M+Py76CN2GsSlJhS2L4oai7+Mh039dliPYmUs4sOQ4l
         EmFKZReejfoYyvM/iyyWBxJi33v5WiRXeYbv4oY+vJLMw+aEX9Qyr/IAhRzUINBI7w
         gYKHS4vpKf6NF6iZiJFvE7H2aJwtZyDWvqWLjeYxC/QJQXSMYmL41yCKpuPZ7FfcWT
         KucsWZz53F33Q==
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
Subject: [PATCH 2/5] dt-bindings: arm64: dts: mediatek: Add rev4 of spherion
Date:   Fri, 10 Feb 2023 19:26:23 -0500
Message-Id: <20230211002626.454844-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211002626.454844-1-nfraprado@collabora.com>
References: <20230211002626.454844-1-nfraprado@collabora.com>
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

Add binding for newer version of Google Spherion (Acer Chromebook 514):
rev4.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 11458cd16109..fd6587253191 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -144,6 +144,11 @@ properties:
           - const: google,hayato-rev1
           - const: google,hayato
           - const: mediatek,mt8192
+      - description: Google Spherion rev4 (Acer Chromebook 514)
+        items:
+          - const: google,spherion-rev4
+          - const: google,spherion
+          - const: mediatek,mt8192
       - description: Google Spherion (Acer Chromebook 514)
         items:
           - const: google,spherion-rev3
-- 
2.39.1

