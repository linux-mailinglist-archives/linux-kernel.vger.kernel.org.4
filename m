Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D828468C074
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBFOtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:49:19 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3431556F;
        Mon,  6 Feb 2023 06:49:17 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 1998A60008;
        Mon,  6 Feb 2023 14:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675694956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jssNCiN7d9s4FVYSLSQNiyVO3Ef91kZOrafXDxLBvCU=;
        b=COQcQzPd++3+6kKr86fsnQKxAAOXJW0JTXfd8ACn3wA00LkZxrNz1Kn7mpHSDeIAA+FzP6
        4leRgqa2DKiybYvDlArlGTc0dc7bvn6zgIdD+n22GPxMCm0hLeLNqL9KyvhyWtL6GMeVYM
        u/p8VmGw9k650IasMSMs6PHscy2j8mkzlgdPD0d8c8OUXb1ij0r4LAvmcfvs1kVld330CJ
        nZToQi9xBPezbHbOn5iUdeIBu5Z7Z2JDERNeNMs4sL4KfjLAEPuUg2r+nUHJTP6vDszJWR
        qIvMgrFa3/WPw+6MaalIuHFzC/SHl9bcRGTDnKlP6zIbDVm5a0pwyW04X34TrA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/3] Add the Infineon PEB2466 codec support
Date:   Mon,  6 Feb 2023 15:49:01 +0100
Message-Id: <20230206144904.91078-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Infineon PEB2466 codec is a programmable DSP-based four channels
codec with filters capabilities.
It also provides signals as GPIOs.

Best regards,
Herve Codina

Herve Codina (3):
  dt-bindings: sound: Add the Infineon PEB2466 codec
  ASoC: codecs: Add support for the Infineon PEB2466 codec
  MAINTAINERS: add the Infineon PEB2466 codec entry

 .../bindings/sound/infineon,peb2466.yaml      |   91 +
 MAINTAINERS                                   |    7 +
 sound/soc/codecs/Kconfig                      |   12 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/peb2466.c                    | 2071 +++++++++++++++++
 5 files changed, 2183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
 create mode 100644 sound/soc/codecs/peb2466.c

-- 
2.39.1

