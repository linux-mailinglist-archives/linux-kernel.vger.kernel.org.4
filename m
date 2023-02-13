Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9A694B22
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjBMP2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjBMP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:28:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CCB40DE;
        Mon, 13 Feb 2023 07:27:57 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 636096602142;
        Mon, 13 Feb 2023 15:27:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676302075;
        bh=5lrCTf6kSd29WBCzueCplh1nvsxxYZtH+v0sT1pv80Y=;
        h=From:To:Cc:Subject:Date:From;
        b=eWvcSBBVzsjxLYb8ItSb/FEw9EEIyGoB4mnreHIYP6E5mULPzFDgCLhFvv1X8FhRW
         gUZE2ogEeINAHFfqaeS5S+B1JTUaxwWmPO5hYmdLq8JirMIOM0suWOOgJrH2HfwWjY
         nwYYX5V9UUGU9IPAAnV5z24urOl/6lgjOQuOy0tsLiKupLIAFPOfD7AOYUFi2j5dgF
         f66eGDeqNUwfTUnTMMIwMbRaSJwLzLmIQAoMmvcIrWu3nvfumefJBccFZkMsxn55Kq
         UkRs+76uqI7UF5GFBfXbQUPywyqouXymChyVoG+sMf4pG9KeZNn1Nydu1N1wlXVjPs
         HDSSURPGXlREQ==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 1/2] dt-bindings: mmc: rockchip-dw-mshc: Add RK3588 compatible string
Date:   Mon, 13 Feb 2023 15:27:39 +0000
Message-Id: <20230213152740.359055-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.1
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

Add RK3588 compatible string for SD interface.

Co-developed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 67d7223f74da..211cd0b0bc5f 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -39,6 +39,7 @@ properties:
               - rockchip,rk3368-dw-mshc
               - rockchip,rk3399-dw-mshc
               - rockchip,rk3568-dw-mshc
+              - rockchip,rk3588-dw-mshc
               - rockchip,rv1108-dw-mshc
               - rockchip,rv1126-dw-mshc
           - const: rockchip,rk3288-dw-mshc
-- 
2.39.1

