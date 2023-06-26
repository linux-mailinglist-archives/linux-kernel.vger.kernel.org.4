Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E8173DDDD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjFZLio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFZLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:38:39 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486BB10C;
        Mon, 26 Jun 2023 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1687779517;
  x=1719315517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZOwHfUAzI6+acGT57WnGZ+pcttdO2j7kyZfchscWack=;
  b=P4F+Pjb66KUlnOEoxsi7agdC5XXdNxH6owtm9qZR5DSZUzxE8IIashkK
   OqCedCzCzMVdrnEZ6NzMYM+xk0G3HG7kVfteDLD7tOZw0JhptVKy/t4s9
   gceFWSfXTvZ9T30rt69BsXAd0eyWXBhDHV+3GZeDu2qbRGh8QP1F/OztC
   y5kqur0cLArMVuggPsGuyziwAXEXsRxZQ+vcYfj5P79D2LsLa/PG0S5c1
   D75/iytg5DaMGWxydFpknWFUVqDgEBymmtURLojtJdUh+489eiLKpRcB9
   4swGTiZhC+aYMhbOLj6QVv4L1tiP1HzXPHjrcOd4zCSjVVt+4is0d1H8x
   w==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 0/2] Input: cap11xx add advanced sensitivity settings
Date:   Mon, 26 Jun 2023 13:37:38 +0200
Message-ID: <20230626113740.809871-1-jiriv@axis.com>
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

Changes in v2:
  - Removed "sensitivity-base-shift" parameter (not HW propertie) in PATCH 2.
  - Used IRQ from I2C subsystem instead of parsing it again.
  - Fixed some documentation issues in PATCH 1

Jiri Valek - 2N (2):
  dt-bindings: input: microchip,cap11xx: add advanced sensitivity
    settings
  Input: cap11xx - add advanced sensitivity settings

 .../bindings/input/microchip,cap11xx.yaml     |  77 +++++-
 drivers/input/keyboard/cap11xx.c              | 250 ++++++++++++++----
 2 files changed, 269 insertions(+), 58 deletions(-)

-- 
2.25.1

