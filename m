Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8F6D8738
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjDETry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjDETrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:47:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46851BCB;
        Wed,  5 Apr 2023 12:47:50 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 111B366031B8;
        Wed,  5 Apr 2023 20:47:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680724069;
        bh=S3QFPGksFul8EKDz4REcYGEFNQkePdH+o2Lfo0bgFJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVAqYtskWJnmjdyHOVgtNUkQps0Y9AWTS3YkRNEjAzdW0luaqGqTvNmxU2MUlpKse
         H14sRKt6TyD2Vpy50G5zW1JN3rjXP/UQ+SfpWm1H52qM53qLHqsoDwq93ydCFDHxJr
         gqTIF0ajoeslVK4gNSC/pdFG90w0QOiFWmPg7/fgjxZU/+qq1Fk8wgy10qNRkNI4xP
         ePcR4Eu/49vSNLEKxPONX+Ab6C5rio+YcQWZ2JpwiTz87RaFqt4tUDZy6WGJP2b4kQ
         VvPUYlp95YSeWqS/ojWThGkicUFScex/jdqQXXeg6x8EfN31NJTJphxfXxCPb1rcqr
         /qvT4GrDHBDvA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 1/8] regulator: dt-bindings: fcs,fan53555: Add support for RK860X
Date:   Wed,  5 Apr 2023 22:47:14 +0300
Message-Id: <20230405194721.821536-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405194721.821536-1-cristian.ciocaltea@collabora.com>
References: <20230405194721.821536-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles to support Rockchip RK860X regulators.

RK8600/RK8601 are compatible with Fairchild FAN53555 regulators, while
RK8602/RK8603 are a bit different, having a wider voltage selection
range.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml b/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
index c0dbba843f70..687eda31ad90 100644
--- a/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
+++ b/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
@@ -17,6 +17,10 @@ properties:
     enum:
       - fcs,fan53555
       - fcs,fan53526
+      - rockchip,rk8600
+      - rockchip,rk8601
+      - rockchip,rk8602
+      - rockchip,rk8603
       - silergy,syr827
       - silergy,syr828
       - tcs,tcs4525
-- 
2.40.0

