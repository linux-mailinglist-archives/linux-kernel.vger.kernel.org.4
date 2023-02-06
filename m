Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3915F68C11C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjBFPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjBFPNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:13:54 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC06EFA6;
        Mon,  6 Feb 2023 07:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675696433;
  x=1707232433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CvppahvIqjd17DLIwxDDzhXWxQnSd36CHWT9oYMGj+I=;
  b=CoZSYRLCBnJMslwCapz/W8EMHbW3kl1za41ksmAbc0XiIbKlqP/ygJ/D
   YiP71/dOLs/f8fJ5t5GBvEhinCryhWdjuhuC8uCu8oby+Xi8RF2poOI7q
   DK4nslF1V/ei19jXUPwxpmJLO3w1Ys6o9/ThdzcST083zKzYXnp7TF/aK
   p+taNfOWnmtINr2KilxvvKj9RQbVBuQ/XB1m4iddpUVgP0pwy878l09Jk
   DUMhPw+4nv63u0rZWhU72Nb06jeZmktPYGhjOBnwu0w6hQI9PSvh5Xlhu
   Fi6M+Yv6Oka35LjquvtVDdcKWsiK5nBO7LC71j5wRQX9UB7iFHJiOnv4y
   Q==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <linux-input@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <mkorpershoek@baylibre.com>,
        <jiriv@axis.com>
Subject: [PATCH v5 0/2] Input: cap11xx add support for cap1203, cap1293 and cap1298
Date:   Mon, 6 Feb 2023 16:13:29 +0100
Message-ID: <20230206151331.184634-1-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail04w.axis.com (10.20.40.10) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 1 - add compatible string for new models
PATCH 2 - add support for new models into driver

Changes in v2:
  - Fixed if statement in PATCH 2.

Changes in v3:
  - Model names sorted alphabetically in PATCH 2.

Changes in v4:
  - Model names sorted alphabetically also in PATCH 1.

Changes in v5:
  - Fix indentation in PATCH 2.

Jiri Valek - 2N (2):
  dt-bindings: input: microchip,cap11xx: add cap1203, cap1293 and
    cap1298
  Input: cap11xx - add support for cap1203, cap1293 and cap1298

 .../bindings/input/microchip,cap11xx.yaml     |  3 +++
 drivers/input/keyboard/cap11xx.c              | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.25.1

