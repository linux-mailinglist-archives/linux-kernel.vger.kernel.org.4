Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2658665C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjAKNN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjAKNNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:13:41 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEAA5FC7;
        Wed, 11 Jan 2023 05:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673442820;
  x=1704978820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UPfZkIV6ylzn3F5wDsPpgzx7150wQIxYMYZpNjHxrxk=;
  b=fmeM/NXU9q0iu5s55ayAARS9bkNjz7RAV22ju50PS/xYBkiVxJJXW4gi
   OO2BY8tOpkBNJu22zbRr3lOINfEjuU15aGxkSa7uT2CKrr9jlNrDkQXmQ
   XypHpadOFzUJ3TznT7pJtHurXGzRkQAIOs2mbapss+Pba9Agx2C8EkKCs
   jrEvuX6fp5p+jhrybykytJKZNjoV2XxnjcItcKiWldj2gir40k4bMKOxX
   S9fbxjv3bfbcBfFYqeQIFRekcsOfROGvl/m06+BcC2/xnsFh0alKX5QOp
   +/p+IvkdaPTSW/KjtWQRScqiOWkER03sLyDqUbpmvN+1VIG07KFdo2Fmd
   g==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <linux-input@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <jiriv@axis.com>
Subject: [PATCH v4 0/2] Input: cap11xx add support for cap1203, cap1293 and cap1298
Date:   Wed, 11 Jan 2023 14:11:09 +0100
Message-ID: <20230111131111.475270-1-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail08w.axis.com (10.20.40.14) To se-mail01w.axis.com
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

Jiri Valek - 2N (2):
  dt-bindings: input: microchip,cap11xx: add cap1203, cap1293 and
    cap1298
  Input: cap11xx - add support for cap1203, cap1293 and cap1298

 .../bindings/input/microchip,cap11xx.yaml     |  3 +++
 drivers/input/keyboard/cap11xx.c              | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.25.1

