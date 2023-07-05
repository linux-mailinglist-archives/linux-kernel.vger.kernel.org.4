Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71C37485B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjGEOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjGEOKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:10:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CCC18B;
        Wed,  5 Jul 2023 07:10:31 -0700 (PDT)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c8:b70a:ae01:7599:ed26:1798:f430])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B1F6A6606FB9;
        Wed,  5 Jul 2023 15:10:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688566229;
        bh=Bl78q3Ch1sDVxiVmKqz7qSjFhBF46KI5+lf0oBzlvdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAeFBMiKfyHbcFlsLGh09vplmumo/4HICCaTIaF5U6rNnDDZjfTtW2HxbCct4B6pD
         tdizNyJinHLTpTeq773JCG8EBtnrU88H8IfhM3h1gewH6zfzjVP/QRqdX5rfhzlQMx
         oYv8ns3b/ilTDy7yHm1LB9mFpr00zTY1aF/1fEPZCLJz4Wlp5rSK5i1l+IRVFA5/+F
         FtiDuhw7TK8CEyiyqTS+Tq69We721cVM3XvMrN0434WSD2AtewBU2DOlpFh1PWnkcL
         1AVKzXnbvNe67h3RFLTb54mIShASYfGH8SHZ6xVnB+gScT/ltS3CrV480lGxZeZagk
         pFddr6hYCGh+w==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>, Andy Yan <andyshrk@163.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@edgeble.ai>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: arm: rockchip: Add Radxa ROCK 4SE
Date:   Wed,  5 Jul 2023 15:10:10 +0100
Message-Id: <20230705141011.111568-3-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705141011.111568-1-chris.obbard@collabora.com>
References: <20230705141011.111568-1-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding entry for the Radxa ROCK 4SE.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ecdb72a519cb..3b7bf86cec02 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -694,6 +694,11 @@ properties:
           - const: radxa,rock-4c-plus
           - const: rockchip,rk3399
 
+      - description: Radxa ROCK 4SE
+        items:
+          - const: radxa,rock-4se
+          - const: rockchip,rk3399
+
       - description: Radxa ROCK Pi E
         items:
           - const: radxa,rockpi-e
-- 
2.40.1

