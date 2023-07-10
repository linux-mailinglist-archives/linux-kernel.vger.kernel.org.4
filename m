Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8006F74DB90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGJQwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGJQwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:52:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A1213D;
        Mon, 10 Jul 2023 09:52:32 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-246.ewe-ip-backbone.de [91.248.189.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1DCF86607004;
        Mon, 10 Jul 2023 17:52:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689007950;
        bh=70i+OsHCHw8ZA82Dnx5g055yqqG/MNhkLk11vHnkswU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEcxa9PhS5m6HuCyfKMEB4sMrP0OFfZLNcG+CaFwXdTZS7E2o5crW93HRBD+2Sv1N
         5KzYKKRtlT/I6mNL8NowEyfm1iehyT9b3MV4EkwujjR1gFu4HdQ07KVV7OeNgtrhcE
         cSWp7Rkxk3YCAQYDopJbnrENJZ/LQ88fhXKoV8lLxqV8sueJhE54g55H+pzJqxGW5O
         wSXW1bJMDa9AzmfXPqWaAXer6DPV2IyGZRsoE/4Zy7kg5wRoCdSqlZ+6JhT6hSwJda
         6qDrcJ9uMM1uuHBp0rNrXp6YwhdwA/ybjKct6zZuWpRQ7intkIiT700Qbw7LnrAToS
         JzlkxjxU+fyEw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1BECC480598; Mon, 10 Jul 2023 18:52:28 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 02/13] dt-bindings: at24: add Belling BL24C16A
Date:   Mon, 10 Jul 2023 18:52:17 +0200
Message-Id: <20230710165228.105983-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710165228.105983-1-sebastian.reichel@collabora.com>
References: <20230710165228.105983-1-sebastian.reichel@collabora.com>
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

Add binding for Belling BL24C16A, which is compatible with Atmel 24C16.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/eeprom/at24.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
index 84af0d5f52aa..2ec37c11286c 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -101,6 +101,9 @@ properties:
                   pattern: spd$
       # These are special cases that don't conform to the above pattern.
       # Each requires a standard at24 model as fallback.
+      - items:
+          - const: belling,bl24c16a
+          - const: atmel,24c16
       - items:
           - enum:
               - rohm,br24g01
-- 
2.40.1

