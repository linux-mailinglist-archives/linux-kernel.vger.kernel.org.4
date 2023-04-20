Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F296E9F57
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjDTWvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjDTWvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:51:31 -0400
Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de [80.67.18.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AB32705;
        Thu, 20 Apr 2023 15:51:30 -0700 (PDT)
Received: from [92.206.161.29] (helo=note-book.lan)
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1ppbRl-0006yb-O2; Thu, 20 Apr 2023 23:04:05 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH RESEND v2 0/2] Input: atmel_mxt_ts - support capacitive
 keys
Date:   Thu, 20 Apr 2023 23:03:49 +0200
Message-Id: <20230407-atmel_keys-v2-0-e7b016886109@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

