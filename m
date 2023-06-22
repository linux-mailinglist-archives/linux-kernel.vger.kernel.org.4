Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277E673A410
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjFVO70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjFVO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:38 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FAD2107;
        Thu, 22 Jun 2023 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=579f2Hm6qQ55A30fNDlpj6oIiU5T7enrkSp58+Lw7iY=; b=wVV9sqHK/vtA+V/7BCSfQ2H50H
        49B1x8Qp3SNkMoZ+Zl9POYVVnAvaXus1n+5jiATcgCAnhMpgVwzitrsM2RNcE5HhQT4eX28BAmqwn
        f6+UmZh4rEqbcgqOyWBDUAOc3z2SHL3M34jzE+gKiow9HP6b+Bt7uoQjDD9fw36f6j4g=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLlR-0002fr-Cp; Thu, 22 Jun 2023 10:58:25 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Thu, 22 Jun 2023 10:58:00 -0400
Message-Id: <20230622145800.2442116-18-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230622145800.2442116-1-hugo@hugovil.com>
References: <20230622145800.2442116-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v4 17/17] dt-bindings: rtc: pcf2127: add PCF2131
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add support for new NXP RTC PCF2131.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
index bcb230027622..2d9fe5a75b06 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
@@ -18,6 +18,7 @@ properties:
       - nxp,pca2129
       - nxp,pcf2127
       - nxp,pcf2129
+      - nxp,pcf2131
 
   reg:
     maxItems: 1
-- 
2.30.2

