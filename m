Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1A686C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjBARHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjBARHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:07:49 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FE813D77;
        Wed,  1 Feb 2023 09:07:46 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 716F7CB5D3;
        Wed,  1 Feb 2023 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675271234; bh=66Z/Bpdu6zld3PM5oO20Gu1y5mfDkdE01d/tlgt/Ifs=;
        h=From:Subject:Date:To:Cc;
        b=hcc5QWaXwoG/7DvgzF7LNNbsP87PV1H0UXzZnenh66nrKaIkLbeVfK7hgxryjsaip
         GfGAiL/0V00uoU0+7+kqs+M7JHGLVC5A5KZ0APCuVaKvgaP1w5EOxf7qhcANCJgmz5
         I8kS0LhyynZOTG10CcB4uZLarwdm/gUAoWrsrLrQ=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/4] Improvements for OmniVision OV2685 driver
Date:   Wed, 01 Feb 2023 18:06:57 +0100
Message-Id: <20230129-ov2685-improvements-v2-0-210400f2b63e@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADGc2mMC/32OTQ6DIBSEr9Kw7jOA1kpXvUfjAvBZWQAWLPEn3
 r3oAbr8JvNlZiMRg8FIHpeNBEwmGu8y8OuF6EG6N4LpMhNOeUkZF+ATr5sbGDsGn9CimyIoWqp
 O90xzQUk2lYwIKkinh8P9aG/BRtuIewV1wYoFtLQYJD/KY8DezOeFV5t5MHHyYTkfJXak/8cTA
 wo9b5jqKlEKoZ9r6aZvMS8rafd9/wGWr+pS4wAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=66Z/Bpdu6zld3PM5oO20Gu1y5mfDkdE01d/tlgt/Ifs=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj2pw+yJf9TMjOYWheJSe51np1cXJewhoyfolq/pif
 5XU8vKaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY9qcPgAKCRBy2EO4nU3XVoxiEA
 DNI8lKcgBVIBox6DMA8LoGqoN6RJQkPFbJRIBTDQkYpkZrGuePbqRwHEBqwHaBenWa9f1cYKRXkXIO
 L4RV39OE1lg8cFOZG/wxlzxsSSv2nkuSx6qBAuclykiXbvBp0i7IrryZs3ul6Lxqs6L8O0yYlW0iPY
 0gN+SYNgQLNAKzjgRt543IFQ8S6n6E4OoUbxV00lIvJ/R81TY/bG1QNEjzV03NyOoGbo6D7oqEZ9Vx
 ZmXQWJGCLHvsnt/0d48eqPl60ls9OEc9ZSGboyP6Vna7L0W84cAbWYDM79hIUMN5AfSF1KhjvQAK5O
 K9xX5mmeKIRepsG9ooP7RaWZqI2tmFWO/rGu0Uq7SEzE2jv+BJmH/0WzHkjjfryuhGHQQc+alAbZN6
 eAMsacMY45MKdtmfjNCg5f0aa9UQ7CxCDrGobr7vNB7IE+1WMFY+Pz260wY3aPN11Ul8oYLd1sK2gH
 jr/n4nxNYpDrGnIhNUikp7rjYXjyJ4rYmJo2k8MSpvQCdGyKmtxZ0f1LByO/WKW6cmV/S3mik+9M75
 XoJwxLeXKNQ5avCAjaBxQyNL5y2gnD13OlT9GlVYUmiOFvlDhgNP1pgfQn6boapcngmjXQbGWuez1j
 hR0e5xWzS/cFPlXkSkokz5ytoHSfCL48iP999r+Q+GeDvKRWdylsfcnP4wRg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches make the sensor work in my setup, and adds a
missing error print that can happen when the dts is wrong.

The last two patches add extra API support for orientation/rotation and
get_selection that is wanted by libcamera to function correctly.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- 3/4: Reserve more space for v4l2 handler for the new controls (Jacopo)
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz

---
Luca Weiss (4):
      media: i2c: ov2685: Make reset gpio optional
      media: i2c: ov2685: Add print for power on write failed
      media: i2c: ov2685: Add controls from fwnode
      media: i2c: ov2685: Add .get_selection() support

 drivers/media/i2c/ov2685.c | 80 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)
---
base-commit: b4c97ca9bb2381580a132a6c71b0e93ac6a4524a
change-id: 20230129-ov2685-improvements-b03bdcf1c290

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

