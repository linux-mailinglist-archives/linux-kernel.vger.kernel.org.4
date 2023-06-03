Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9CD7211B3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFCSzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFCSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:55:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BACE6B;
        Sat,  3 Jun 2023 11:55:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D5CD6603050;
        Sat,  3 Jun 2023 19:55:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685818508;
        bh=8S7OKZmsezN6RAz8kQrAHp0icflqSiGjbX9ZA0jDAwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWmWePs19ts8sVUd4Z4OscrkOetjDVbAaFedKZFjEMnXmn2su4sDSPtsGHDjUAHjG
         bQwclcUFme+Pb7TeUB4X7eJJOsP1qnr46OVHC2HviY62rJRhBaHBsyS2MTdY46Ki+S
         VcF+ijqRifz0EFLjk9JsCwogHo3M4cPS8OzN+hfzBa5VG3Fbpbn7chHWaWQMqgZdkF
         8w5Zh2S3ZuxhCOBc3YfIXPeaGlTXmrQNoEzCLXlStFIWJtR/hll94cy2BkMnG4kO/S
         fiSJ+E0KuzfkCz2IXvx560GjVaggcC0i9xkgwjKzV3xbFLDd22iL1bih51DlEpOpOD
         cj807GFcEHiMA==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        gustavo.padovan@collabora.com, kernel@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 8/8] dt-bindings: iio: adc: Add rockchip,rk3588-saradc string
Date:   Sun,  4 Jun 2023 00:23:40 +0530
Message-Id: <20230603185340.13838-9-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230603185340.13838-1-shreeya.patel@collabora.com>
References: <20230603185340.13838-1-shreeya.patel@collabora.com>
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

Add rockchip,rk3588-saradc compatible string.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v3
  - No change

Changes in v2
  - Add an Acked-by tag.

 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index da50b529c157..11c27ea451c8 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -21,6 +21,7 @@ properties:
               - rockchip,rk3308-saradc
               - rockchip,rk3328-saradc
               - rockchip,rk3568-saradc
+              - rockchip,rk3588-saradc
               - rockchip,rv1108-saradc
               - rockchip,rv1126-saradc
           - const: rockchip,rk3399-saradc
-- 
2.30.2

