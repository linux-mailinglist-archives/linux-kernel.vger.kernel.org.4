Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8966E2CF0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDNXiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNXiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:38:52 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640265260;
        Fri, 14 Apr 2023 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1681515531;
  x=1713051531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ydv940Xa+5P2EMaQhnzv/nXM4eZImQyTFtHYz7eUDH4=;
  b=mTx01zSVwFdAnHQXpfm8aajkvtn9tRHJgz3qoOFM7AY7YM/ZPPix/l3m
   VSIO8JUZp39t82hWlfO1PerpFO+iwK+migFBr0/9VkBQDFDU/A/azUEsk
   payrfF1De6WdzzguXbs7AIoyK88DuwFADCfCSfFpA5pRCzcrywHST1J7W
   DlmkJgNDOBQAbfeH1YLdf++HdMjyZIcpmujJ4VaHWFDrd14Qxd5CgAH2O
   0IfgfayP1yXiHQYdlsU2XPme8/3/VTY5CCowKyv1MhQd99TAc7nkGqbgT
   56mcUCo9I8xj4v/C3iumzlfvo66+BZtGwZ8cjH7eAO2swUCdYcNE4xUqx
   Q==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <dmitry.torokhov@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/2] Input: cap11xx add advanced sensitivity settings
Date:   Sat, 15 Apr 2023 01:38:13 +0200
Message-ID: <20230414233815.4004526-1-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 1 - add documentation for new options
PATCH 2 - add support for advanced settings into driver

Jiri Valek - 2N (2):
  dt-bindings: input: microchip,cap11xx: add advanced sensitivity
    settings
  Input: cap11xx - add advanced sensitivity settings

 .../bindings/input/microchip,cap11xx.yaml     |  64 ++++-
 drivers/input/keyboard/cap11xx.c              | 263 +++++++++++++++---
 2 files changed, 278 insertions(+), 49 deletions(-)

-- 
2.25.1

