Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B38E6644CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbjAJPaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjAJP3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:29:46 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8476219;
        Tue, 10 Jan 2023 07:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673364554;
  x=1704900554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rZK4lXaEJ4x4EqUHUPXE5HpqBwAiLoEDFrRFR6F5708=;
  b=JhYxjwmH0Rr7Rogvhoo5OAAdVh+ObULieC1EXkOAtt/hklprYsE69a1j
   mIjHZi+BFIifjowKK2W5Ji3SbzFGtN1BofkQyJZszvAjgpo+Cptt4v72k
   r9I/BoKMEHgffhKs5SEKGF3wu5Iow+U9l8brRvtkT5gGLxmRhL+rcfC+q
   aH45OvGBpRw81IJnecqPm9evVJRFoSWYx7VZWJyRdqAUKqDzVBt9fFgzG
   +n4EAgPr4VFsNe//XTnVsxFnL8p3hLCHEf/SJJWFjigEa/x/6GFkEpxFd
   cmFhW4tT+N1Kqqe7kR3YqXJ1XmsXbIRdXLzCu4s8sjadPWei3v1epcCmF
   Q==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <linux-input@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <jiriv@axis.com>
Subject: [PATCH v3 0/2] Input: cap11xx add support for cap1203, cap1293 and cap1298
Date:   Tue, 10 Jan 2023 16:28:57 +0100
Message-ID: <20230110152859.295881-1-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail07w.axis.com (10.20.40.13) To se-mail01w.axis.com
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

Jiri Valek - 2N (2):
  dt-bindings: input: microchip,cap11xx: add cap1203, cap1293 and
    cap1298
  Input: cap11xx - add support for cap1203, cap1293 and cap1298

 .../bindings/input/microchip,cap11xx.yaml     |  3 +++
 drivers/input/keyboard/cap11xx.c              | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.25.1

