Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E4373F4EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjF0GyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjF0Gxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:53:36 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B11BEB;
        Mon, 26 Jun 2023 23:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1687848810;
  x=1719384810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mOwTb3Hstep0A5XjAvtOEPKED0kB3c1FXOZYNvEJEw4=;
  b=RRU/t/d7nKEjYG90YcOvCch2QXs/LogSCrvUTlAq4OVywbD7osQ4lmle
   hTuEt5kx1gNNsH5Gfxmh79hiJErxk1KJzWjMxCPCJP+L48RBoGauFFl0V
   +JNbwTs3ELi9y0X49c9v20LI4qX64E+oSh1lrONsrZy2jsN8NVVXu1ZOb
   mF9chy2Kudb2ys5T0EoKrGh1aBNoWeW79gebV/cB0pJN6aCaW7ShYnr0z
   n/Mcr3b6UOYynSwFPf7rTMr2oOrPQ5t4F/pEVd3TNwM7uAowi8rgQmofb
   s5EULi2AYAVBcyyX8ry5Yh6QJaHXaCne7Iw/lCG35xzuk+Wj3mJlSHFPL
   Q==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v4 0/2] Input: cap11xx add advanced sensitivity settings
Date:   Tue, 27 Jun 2023 08:53:14 +0200
Message-ID: <20230627065316.1065911-1-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
  
Changes in v3:
  - Remove incorrectly used "Reviewed-by" tag in PATCH 1 and 2

Changes in v4:
  - Remove unused variable in PATCH 2

Jiri Valek - 2N (2):
  dt-bindings: input: microchip,cap11xx: add advanced sensitivity
    settings
  Input: cap11xx - add advanced sensitivity settings

 .../bindings/input/microchip,cap11xx.yaml     |  77 +++++-
 drivers/input/keyboard/cap11xx.c              | 250 ++++++++++++++----
 2 files changed, 269 insertions(+), 58 deletions(-)

-- 
2.25.1

