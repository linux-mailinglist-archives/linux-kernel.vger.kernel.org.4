Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C706DACB8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjDGMrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbjDGMrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:47:08 -0400
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de [80.67.18.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332777D9E;
        Fri,  7 Apr 2023 05:47:03 -0700 (PDT)
Received: from [92.206.161.29] (helo=note-book.lan)
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1pklTD-0002cY-Rx; Fri, 07 Apr 2023 14:45:35 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH v2 0/2] Input: atmel_mxt_ts - support capacitive keys
Date:   Fri, 07 Apr 2023 14:44:23 +0200
Message-Id: <20230407-atmel_keys-v2-0-92446a4343cb@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACcQMGQC/0WNyw7CIBBFf8WwlobSUtSV/2GMGXBaJtpHGDRq0
 3+XunF5cnPOnQVjJGRx2Mwi4pOYxiGD3m6EDzB0KOmaWWilK1UrKyH1eL/c8M3SQr33jWusdVp
 kwQGjdBEGH1alB04Y12GK2NLr93I6Z27j2MsUIsK/rbXVyqjKFOXOmFKWsqN0hInSh30o8CGW5
 QvEhNlprgAAAA==
To:     Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for touch keys found in some Atmel touch controller
configurations.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
Changes in v2:
  * Added A-b, R-b tags

---
André Apitzsch (2):
      dt-bindings: input: atmel,maxtouch: add linux,keycodes
      Input: atmel_mxt_ts - support capacitive keys

 .../devicetree/bindings/input/atmel,maxtouch.yaml  |  7 ++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 85 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)
---
base-commit: f2afccfefe7be1f7346564fe619277110d341f9b
change-id: 20230407-atmel_keys-7a49c6b677b2

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

