Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A886E9940
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjDTQLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjDTQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:10:59 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053292729;
        Thu, 20 Apr 2023 09:10:57 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 66ED71C000B;
        Thu, 20 Apr 2023 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682007056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FwglzcQP0CkzkE+ONlTYCufahA4ItXFZzINpHTeBwiw=;
        b=CQ6nKLNhY5qKk4EBh3H8G2v0BS1b/0sdzyGTGSlWS+Xu0MZhDyWxpjp8IQ91m3+aeg+FCZ
        0Csx9E+6LCzVOy9v7NXvobvULebrNEDT/8RyNeN2GYu+yEVh1WYJsfK+t5AriMiwHWeiS2
        BV99WQWHGoDBrbzFLYoNIhRIDAaUjlOmn10fMlFDaBHdR0dRl4t8svpOZlnUvHSLFlvIsq
        sB1M8qmeH3lNylJW3cmJgSfIDbg25eI3JtvtRhEVfbhAIrJE47ScJqGlsjy5wTMIlvoTgB
        PyXPG3yVr2vXGAj+Fzg/RPjeXuHkddncZh99GTAmlZPc1UW1jLtuBfFpEn7TGQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/3] Add the Renesas X9250 potentiometers IIO support
Date:   Thu, 20 Apr 2023 18:10:49 +0200
Message-Id: <20230420161052.270366-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Renesas X9250 integrated four digitally controlled potentiometers.
On each potentiometer, the X9250T has a 100 kOhms total resistance and
the X9250U has a 50 kOhms total resistance.

Compare to the previous iteration
  https://lore.kernel.org/linux-kernel/20230420121320.252884-1-herve.codina@bootlin.com/
This v2 series uses a define for the X9250 ID value.

Best regards,
Herve Codina

Changes v1 -> v2
  - Patch 1
    No changes

  - Patch 2
    Use a define for the 0x50 value used multiple times.

  - Patch 3
    No changes

Herve Codina (3):
  dt-bindings: iio: potentiometer: Add the Renesas X9250 potentiometers
  iio: potentiometer: Add support for the Renesas X9250 potentiometers
  MAINTAINERS: add the Renesas X9250 driver entry

 .../iio/potentiometer/renesas,x9250.yaml      |  56 +++++
 MAINTAINERS                                   |   7 +
 drivers/iio/potentiometer/Kconfig             |  10 +
 drivers/iio/potentiometer/Makefile            |   1 +
 drivers/iio/potentiometer/x9250.c             | 234 ++++++++++++++++++
 5 files changed, 308 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
 create mode 100644 drivers/iio/potentiometer/x9250.c

-- 
2.39.2

